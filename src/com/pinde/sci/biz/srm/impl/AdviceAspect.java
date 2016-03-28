package com.pinde.sci.biz.srm.impl;

import java.util.List;

import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.srm.IProjApplyBiz;
import com.pinde.sci.biz.srm.IProjProcessBiz;
import com.pinde.sci.biz.srm.IProjRecBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.srm.ProjApproveStatusEnum;
import com.pinde.sci.enums.srm.ProjRecTypeEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.enums.srm.RegPageEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjProcess;
import com.pinde.sci.model.mo.PubProjRec;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.UserRegForm;

@Service
@Aspect
public class AdviceAspect {
	
	@Autowired
	private IMsgBiz msgBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IPubProjBiz projBiz;
	@Autowired
	private IProjRecBiz projRecBiz;
	@Autowired
	private IProjProcessBiz processBiz;
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private IOrgBiz orgBiz;
	
	/**
	 * 人员注册审核信息通知
	 * @param user
	 */
	@After("target(com.pinde.sci.biz.sys.IUserBiz) && execution(public * activateUser(..)) && args(user,..)")
	public void addRegistAuditMsg(SysUser user){
		user = userBiz.readSysUser(user.getUserFlow());
        msgBiz.addSmsMsg(user.getUserPhone(), "您在苏州卫生局科教平台的注册信息审核已通过，可登录进行操作");
	}
	
	/**
	 * 申报书审核信息通知
	 */
	@After("target(com.pinde.sci.biz.srm.IProjApplyBiz) && execution(public * applyAudit(..)) && args(projFlow , projListScope , agreeFlag , auditContent,..)")
	public void addApplyAuditMsg(String projFlow , String projListScope,String  agreeFlag , String auditContent){
		addProjMsg(projFlow , projListScope , agreeFlag , "申报书");
	}
	
	/**
	 * 立项审核通知
	 */
	@After("target(com.pinde.sci.biz.srm.IProjApproveBiz) && execution(public * setUp(..)) && args(proj,remark,sug,..)")
	public void addApproveAuditMsg(PubProj proj , String remark , String sug){
		//您XXXXX项目已立项，立项编号XXXXX，请登录系统查看详情
		String projFlow = proj.getProjFlow();
		PubProjProcess projProcess = new PubProjProcess();
		projProcess.setProjFlow(projFlow);
		List<PubProjProcess> processes = this.processBiz.searchApproveProcess(projProcess);
		for(PubProjProcess ps : processes){
			if(ProjStageEnum.Approve.getId().equals(ps.getProjStageId()) && 
					ProjApproveStatusEnum.Approve.getId().equals(ps.getProjStatusId())){
				proj = projBiz.readProjectNoBlogs(proj.getProjFlow());
				String projName = proj.getProjName();
				String applyUserFlow = proj.getApplyUserFlow();
				SysUser user = userBiz.readSysUser(applyUserFlow);
				msgBiz.addSmsMsg(user.getUserPhone(), "您"+projName+"项目已经被立项,立项编号"+proj.getProjNo()+",请登录系统查看详情!");
				break;
			}
		}
	}
	
	/**
	 * 合同审核通知
	 */
	@After("target(com.pinde.sci.biz.srm.IProjContractBiz) && execution(public * contractAudit(..)) && args(projFlow,projListScope,agreeFlag,auditContent,..)")
	public void addContractAuditMsg(String projFlow , String projListScope , String agreeFlag , String auditContent){
		addProjMsg(projFlow , projListScope , agreeFlag , "合同");
	}
	
	/**
	 * 进展阶段报告审核通知
	 */
	@After("target(com.pinde.sci.biz.srm.IProjScheduleBiz) && execution(public * scheduleAudit(..)) && args(recFlow,projListScope,agreeFlag,auditContent,..)")
	public void addScheduleAuditMsg(String recFlow , String projListScope,
			String agreeFlag, String auditContent){
		PubProjRec rec = this.projRecBiz.readProjRec(recFlow);
		addProjMsg(rec.getProjFlow() , projListScope , agreeFlag , rec.getRecTypeName());
	}
	
	/**
	 * 验收审核通知
	 */
	@After("target(com.pinde.sci.biz.srm.IProjCompleteBiz) && execution(public * completeAudit(..)) && args(projFlow,recTypeId,projListScope,agreeFlag,auditContent,..)")
	public void addCompleteAuditMsg(String projFlow, String recTypeId, String projListScope, String agreeFlag,
			String auditContent){
		addProjMsg(projFlow , projListScope , agreeFlag , ProjRecTypeEnum.getNameById(recTypeId));
	}
	
	private void addProjMsg(String projFlow , String projListScope,String  agreeFlag , String type){
		PubProj proj = projBiz.readProjectNoBlogs(projFlow);
		String projName = proj.getProjName();
		String applyUserFlow = proj.getApplyUserFlow();
		SysUser user = userBiz.readSysUser(applyUserFlow);
		if(GlobalConstant.FLAG_Y.equals(agreeFlag)){
			agreeFlag = "审核通过";
		}
		if(GlobalConstant.FLAG_N.equals(agreeFlag)){
			agreeFlag = "退回";
		}
		if(GlobalConstant.USER_LIST_LOCAL.equals(projListScope)){
			projListScope = "医院科教处";
		}
		if(GlobalConstant.USER_LIST_CHARGE.equals(projListScope)){
			projListScope = "区管理部门";
		}
		if(GlobalConstant.USER_LIST_GLOBAL.equals(projListScope)){
			projListScope = "苏州卫生局";
		}
		msgBiz.addSmsMsg(user.getUserPhone(), "您"+projName+"项目的"+type+"已经被"+projListScope+agreeFlag);
	}
	
	/**
	 * 人员注册信息通知
	 * public void regUser(UserRegForm form , SysRole role);
	 */
	@After("target(com.pinde.sci.biz.sys.IUserRegBiz) && execution(public * regUser(..)) && args(form,role,..)")
	public void userRegAdviceMsg(UserRegForm form , SysRole role){
		String regPageId = role.getRegPageId();
		SysUser user = form.getUser();
		String needAdviceRole = "";
		String needAdviceOrg = "";
		 if(RegPageEnum.ExpertRegPage.getId().equals(regPageId) || RegPageEnum.ProjRegPage.getId().equals(regPageId)){
			 //专家注册通知 需要通知该注册所在机构的管理员
			 //项目负责人注册通知 需要通知该注册所在机构的管理员
			 needAdviceRole = InitConfig.getSysCfg("srm_local_manager_role");
			 needAdviceOrg = user.getOrgFlow();
		 }else if(RegPageEnum.orgRegPage.getId().equals(regPageId)){
			 //机构负责人注册通知 需要通知上一级的管理员
			 SysOrg org = this.orgBiz.readSysOrg(user.getOrgFlow());
			 needAdviceOrg = org.getChargeOrgFlow();
			 if(InitConfig.getSysCfg("global_org_flow").equals(needAdviceOrg)){
				 //表示向顶级单位通知
				 needAdviceRole = InitConfig.getSysCfg("srm_global_manager_role");
			 }else{
				 //表示向上一级单位通知
				 needAdviceRole = InitConfig.getSysCfg("srm_charge_manager_role");
			 }
		 }
		 List<SysUser> userManagers = this.userBiz.findUserByOrgFlowAndRoleFlow(needAdviceOrg, needAdviceRole);
		 if(userManagers!=null && !userManagers.isEmpty()){
			 for(SysUser u:userManagers){
				 msgBiz.addSmsMsg(u.getUserPhone() , "您有一条人员注册信息待审核，请及时登录苏州卫生局科教平台进行操作");
			 }
		 }
		
	}
	
}
