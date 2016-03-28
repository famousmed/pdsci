package com.pinde.sci.biz.job;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.dao.base.PubProjRecMapper;
import com.pinde.sci.dao.pub.PubProjExtMapper;
import com.pinde.sci.enums.pub.ProjCategroyEnum;
import com.pinde.sci.enums.srm.ProjCompleteStatusEnum;
import com.pinde.sci.enums.srm.ProjRecTypeEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjExample;
import com.pinde.sci.model.mo.PubProjRec;
import com.pinde.sci.model.mo.PubProjRecExample;
import com.pinde.sci.model.mo.SysUser;

@Component
public class ProjAdviceJob {

	@Autowired
	private PubProjMapper projMapper;
	@Autowired
	private PubProjRecMapper projRecMapper;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IMsgBiz msgBiz;
	@Value("#{configProperties['thread.switch']}") 
	private String threadSwitch;
	@Autowired
	private PubProjExtMapper projExtMapper;
	
	@Scheduled(cron="0/60 36 10 ? * SAT")
	public void completeProjAdivceForApplyUser(){
		if(!GlobalConstant.FLAG_Y.equals(threadSwitch)){
			return;
		}	
		int completeAdviceNumberOfDaysInt = Integer.parseInt("30");
		List<PubProj> projs = findProjForProjEndTimeBeforeDays(completeAdviceNumberOfDaysInt);
		for(PubProj proj:projs){
			String applyUserFlow = proj.getApplyUserFlow();
			SysUser user = userBiz.readSysUser(applyUserFlow);
			msgBiz.addSmsMsg(user.getUserPhone(), "请及时填写并提交"+proj.getProjName()+"项目的结题报告!");
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
	
	@Scheduled(cron="0 40 15 * * ?")
	public void projRecSubmitAdvice(){
		if(!GlobalConstant.FLAG_Y.equals(threadSwitch)){
			return;
		}
		ProjRecTypeEnum[] recTypes = ProjRecTypeEnum.values();
		for(ProjRecTypeEnum recType:recTypes){
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("recTypeId", recType.getId());
			paramMap.put("status", "Submit");
			List<Map<String , String>> results = this.projExtMapper.selectOrgHavingProjCount(paramMap);
			if(results!=null && !results.isEmpty()){
				for(Map<String , String> item:results){
					String orgFlow = (String)item.get("ORGFLOW");
					Object num = item.get("NUM");
					if(!"0".equals(num)){
						String msg = "您有"+num+"条"+recType.getName()+"待审核,请及时登录科教管理平台审核";
						List<SysUser> userManagers = this.userBiz.findUserByOrgFlowAndRoleFlow(orgFlow, InitConfig.getSysCfg("srm_local_manager_role"));
						 if(userManagers!=null && !userManagers.isEmpty()){
							 for(SysUser u:userManagers){
								 msgBiz.addSmsMsg(u.getUserPhone() , msg);
							 }
						 }
						
					}
				}
			}
		}
	}
	
	
	
	
	
	@Scheduled(cron="0 40 15 * * ?")
	public void projRecFirstAuditAdvice(){
		if(!GlobalConstant.FLAG_Y.equals(threadSwitch)){
			return;
		}
		ProjRecTypeEnum[] recTypes = ProjRecTypeEnum.values();
		for(ProjRecTypeEnum recType:recTypes){
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("recTypeId", recType.getId());
			paramMap.put("status", "FirstAudit");
			List<Map<String , String>> results = this.projExtMapper.selectOrgHavingProjCount(paramMap);
			if(results!=null && !results.isEmpty()){
				for(Map<String , String> item:results){
					String orgFlow = (String)item.get("ORGFLOW");
					orgFlow = this.orgBiz.readSysOrg(orgFlow).getChargeOrgFlow();
					Object num = item.get("NUM");
					if(!"0".equals(num)){
						String msg = "您有"+num+"条"+recType.getName()+"待审核,请及时登录科教管理平台审核";
						List<SysUser> userManagers = this.userBiz.findUserByOrgFlowAndRoleFlow(orgFlow, InitConfig.getSysCfg("srm_local_manager_role"));
						 if(userManagers!=null && !userManagers.isEmpty()){
							 for(SysUser u:userManagers){
								 msgBiz.addSmsMsg(u.getUserPhone() , msg);
							 }
						 }
						
					}
				}
			}
		}
	}
	
	@Scheduled(cron="0 40 15 * * ?")
	public void projRecThirdBackAdvice(){
		if(!GlobalConstant.FLAG_Y.equals(threadSwitch)){
			return;
		}
		ProjRecTypeEnum[] recTypes = ProjRecTypeEnum.values();
		String globalOorgFlow = InitConfig.getSysCfg("global_org_flow");
		String needAdviceOrgFlow = "";
		for(ProjRecTypeEnum recType:recTypes){
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("recTypeId", recType.getId());
			paramMap.put("status", "ThirdBack");
			List<Map<String , String>> results = this.projExtMapper.selectOrgHavingProjCount(paramMap);
			if(results!=null && !results.isEmpty()){
				for(Map<String , String> item:results){
					String orgFlow = (String)item.get("ORGFLOW");
					String chargeOrgFlow = this.orgBiz.readSysOrg(orgFlow).getChargeOrgFlow();
					if(globalOorgFlow.equals(chargeOrgFlow)){
						//直属医院 通知医院管理员
						needAdviceOrgFlow = orgFlow;
					}else{
						needAdviceOrgFlow = chargeOrgFlow;
					}
					Object num = item.get("NUM");
					if(!"0".equals(num)){
						String msg = "您有"+num+"条"+recType.getName()+"被退回,请及时登录科教管理平台查看详情，并及时退回下级部门管理员";
						List<SysUser> userManagers = this.userBiz.findUserByOrgFlowAndRoleFlow(needAdviceOrgFlow, InitConfig.getSysCfg("srm_local_manager_role"));
						 if(userManagers!=null && !userManagers.isEmpty()){
							 for(SysUser u:userManagers){
								 msgBiz.addSmsMsg(u.getUserPhone() , msg);
							 }
						 }
						
					}
				}
			}
		}
	}
	
	
	@Scheduled(cron="0 40 15 * * ?")
	public void projRecSecondBackAdvice(){
		if(!GlobalConstant.FLAG_Y.equals(threadSwitch)){
			return;
		}
		ProjRecTypeEnum[] recTypes = ProjRecTypeEnum.values();
		for(ProjRecTypeEnum recType:recTypes){
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("recTypeId", recType.getId());
			paramMap.put("status", "SecondBack");
			List<Map<String , String>> results = this.projExtMapper.selectOrgHavingProjCount(paramMap);
			if(results!=null && !results.isEmpty()){
				for(Map<String , String> item:results){
					String orgFlow = (String)item.get("ORGFLOW");
					orgFlow = this.orgBiz.readSysOrg(orgFlow).getChargeOrgFlow();
					Object num = item.get("NUM");
					if(!"0".equals(num)){
						String msg = "您有"+num+"条"+recType.getName()+"被退回,请及时登录科教管理平台查看详情，并及时退回给下级部门管理员";
						List<SysUser> userManagers = this.userBiz.findUserByOrgFlowAndRoleFlow(orgFlow, InitConfig.getSysCfg("srm_local_manager_role"));
						 if(userManagers!=null && !userManagers.isEmpty()){
							 for(SysUser u:userManagers){
								 msgBiz.addSmsMsg(u.getUserPhone() , msg);
							 }
						 }
						
					}
				}
			}
		}
	}

}
