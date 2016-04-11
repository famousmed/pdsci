package com.pinde.sci.ctrl.jsres;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pinde.core.page.PageHelper;
import com.pinde.sci.biz.jsres.IJsResDoctorBiz;
import com.pinde.sci.biz.jsres.impl.JsResDoctorRecruitBizImpl;
import com.pinde.sci.biz.pub.IPubUserResumeBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.SysLogMapper;
import com.pinde.sci.enums.jsres.JsResDoctorAuditStatusEnum;
import com.pinde.sci.model.jsres.JsResDoctorRecruitExt;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.SysLog;
import com.pinde.sci.model.mo.SysLogExample;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/jsres/manage")
public class JsResManageController extends GeneralController {
	@Autowired
	private SysLogMapper logMapper;
	@Autowired
	private IJsResDoctorBiz jsResDoctorBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IResDoctorBiz resDoctorBiz;
	@Autowired
	private IPubUserResumeBiz userResumeBiz;
	@Autowired
	private JsResDoctorRecruitBizImpl jsResDoctorRecruitBiz;
	
	/**
	 * 管理员主界面
	 */
	@RequestMapping(value="/{role}")
	public String index(@PathVariable String role,Model model,Integer currentPage){
		setSessionAttribute(GlobalConstant.USER_LIST_SCOPE, role);
		if (GlobalConstant.SYSTEM_ROLE.equals(role)) { //主管部门
			return "jsres/system/index";
		} else if (GlobalConstant.USER_LIST_GLOBAL.equals(role)) { //省级管理员
			return "jsres/global/index";
		}else if (GlobalConstant.USER_LIST_PROVINCE.equals(role)) { //审核部门
			return "jsres/province/index";
		}else if (GlobalConstant.USER_LIST_CHARGE.equals(role)) { //市局
			return "jsres/city/index";
		} else if (GlobalConstant.USER_LIST_LOCAL.equals(role)) { //培训基地
			return "jsres/hospital/index";
		}
		return "/inx/jsres/login";
	}
	
	@RequestMapping(value="/accounts")
	public String accounts(Model model) throws Exception{
		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
		SysLogExample example = new SysLogExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andUserFlowEqualTo(user.getUserFlow());
		example.setOrderByClause("create_time desc");
		List<SysLog> logs = logMapper.selectByExample(example);
		if(logs!=null && logs.size()>0){
			model.addAttribute("log", logs.get(0));
		}
		return "jsres/accounts";
	}
	
	@RequestMapping(value={"/modPasswd"})
	public String modPasswd(Model model){	
		return "jsres/system/modPasswd";
	}
	
	/**
	 * 跳到父页面，用子页面处理
	 * 
	 */
	@RequestMapping(value={"/{role}/doctor/auditDoctors"})
	public String auditDoctors(@PathVariable String role){
		return "/jsres/"+ role+"/doctor/auditDoctors";
	}
	/**
	 * 医师信息审核列表
	 * @param doctor
	 * @param sysUser
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/doctorTrendList")
	public String doctorRecruit(Model model,Integer currentPage, HttpServletRequest request,ResDoctorRecruit resDoctorRecruit,SysUser user){
		SysUser sysuser=GlobalContext.getCurrentUser();
		resDoctorRecruit.setOrgFlow(sysuser.getOrgFlow());
		resDoctorRecruit.setAuditStatusId(JsResDoctorAuditStatusEnum.Auditing.getId());
		PageHelper.startPage(currentPage, getPageSize(request));
		List<JsResDoctorRecruitExt> RecruitList=jsResDoctorRecruitBiz.resDoctorRecruitExtList(resDoctorRecruit,user);
		model.addAttribute("recruitList",RecruitList);
		return  "jsres/province/doctor/auditDoctorsZi";
	}
	
	/**
	 * 审核信息页面
	 * @param doctor
	 * @param sysUser
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/{role}/doctor/doctorMain"})
	public String doctorMain(@PathVariable String role,Model model,String doctorFlow){
		ResDoctorRecruit recruit = new ResDoctorRecruit();
		recruit.setAuditStatusId(JsResDoctorAuditStatusEnum.Auditing.getId());
		recruit.setDoctorFlow(doctorFlow);
		List<ResDoctorRecruit> recruitList = jsResDoctorRecruitBiz.searchResDoctorRecruitList(recruit);
		model.addAttribute("recruitList", recruitList);
		return "/jsres/"+ role +"/doctor/doctorMain";
	}
	
}
