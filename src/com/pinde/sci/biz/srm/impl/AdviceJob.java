package com.pinde.sci.biz.srm.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.context.ApplicationContext;

import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.pub.impl.MsgBizImpl;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.impl.UserBizImpl;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.dao.base.PubProjRecMapper;
import com.pinde.sci.enums.pub.ProjCategroyEnum;
import com.pinde.sci.enums.srm.ProjCompleteStatusEnum;
import com.pinde.sci.enums.srm.ProjRecTypeEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjExample;
import com.pinde.sci.model.mo.PubProjRec;
import com.pinde.sci.model.mo.PubProjRecExample;
import com.pinde.sci.model.mo.SysUser;

public class AdviceJob implements Job{

	private PubProjMapper projMapper;
	private PubProjRecMapper projRecMapper;
	private IUserBiz userBiz;
	private IMsgBiz msgBiz;
	
	
	@Override
	public void execute(JobExecutionContext jctx) throws JobExecutionException {
		Map triggerDataMap = jctx.getTrigger().getJobDataMap();
		Map jobDetailDataMap = jctx.getJobDetail().getJobDataMap();
		ApplicationContext applicationContext = (ApplicationContext)jobDetailDataMap.get("applicationContext");
		projMapper = applicationContext.getBean(PubProjMapper.class);
		projRecMapper = applicationContext.getBean(PubProjRecMapper.class);
		userBiz = applicationContext.getBean(UserBizImpl.class);
		msgBiz = applicationContext.getBean(MsgBizImpl.class);
		String completeAdviceNumberOfDays = (String)triggerDataMap.get("completeAdviceNumberOfDays");
		int completeAdviceNumberOfDaysInt = Integer.parseInt(completeAdviceNumberOfDays);
		List<PubProj> projs = findProjForProjEndTimeBeforeDays(completeAdviceNumberOfDaysInt);
		for(PubProj proj:projs){
			String applyUserFlow = proj.getApplyUserFlow();
			SysUser user = userBiz.readSysUser(applyUserFlow);
			msgBiz.addSmsMsg(user.getUserPhone(), "请及时填写并提交"+proj.getProjName()+"项目的结题报告!");
			System.out.println("TIP-------------------------------");
		}
		
		
	}
	
	/**
	 * 查询项目结束时间小于等于当前时间在所给天数之前的所有项目，没有提交过实施阶段报告的(包过 验收报告和中止报告)
	 * 项目结束时间<=(当前时间-所给天数)
	 * @param numOfDays
	 * @return
	 */
	public List<PubProj> findProjForProjEndTimeBeforeDays(Integer numOfDays){
		List<PubProj> resultProjs = new ArrayList<PubProj>();
		SimpleDateFormat dft = new SimpleDateFormat("yyyy-MM-dd");
		Date nowDate = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(nowDate);
		cal.set(Calendar.DATE, cal.get(Calendar.DATE)+numOfDays);
		String resultDate = dft.format(cal.getTime());
		PubProjExample example = new PubProjExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andProjCategoryIdEqualTo(ProjCategroyEnum.Ky.getId())
		.andProjEndTimeLessThanOrEqualTo(resultDate)
		.andProjStageIdNotEqualTo(ProjStageEnum.Archive.getId());
		System.out.println(this.projMapper+"--------");
		List<PubProj> projs = this.projMapper.selectByExample(example);
		List<String> recTypeIds = new ArrayList<String>();
		recTypeIds.add(ProjRecTypeEnum.CompleteReport.getId());
		recTypeIds.add(ProjRecTypeEnum.TerminateReport.getId());
		for(PubProj proj : projs){
			PubProjRecExample projRecExample = new PubProjRecExample();
			projRecExample.createCriteria()
			.andProjFlowEqualTo(proj.getProjFlow())
			.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
			.andRecTypeIdIn(recTypeIds)
			.andProjStageIdEqualTo(ProjStageEnum.Complete.getId());
			List<PubProjRec> projRecs = this.projRecMapper.selectByExample(projRecExample);
			if(projRecs==null || projRecs.isEmpty()){
				resultProjs.add(proj);
			}else{
				for(PubProjRec projRec : projRecs){
					if(ProjCompleteStatusEnum.Apply.getId().equals(projRec.getProjStatusId())){
						resultProjs.add(proj);
					}
					
				}
			}
			
		}
		
		return resultProjs;
	}

}
