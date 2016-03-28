package com.pinde.sci.ctrl.jsres;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.jsres.IJsResDoctorBiz;
import com.pinde.sci.biz.jsres.IJsResDoctorRecruitBiz;
import com.pinde.sci.biz.jsres.impl.JsResDoctorRecruitBizImpl;
import com.pinde.sci.biz.pub.IPubUserResumeBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.jsres.JsResDoctorAuditStatusEnum;
import com.pinde.sci.model.jsres.JsResDoctorRecruitExt;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/jsres/doctorRecruit")
public class JsResDoctorRecruitController extends GeneralController {
	@Autowired
	private IJsResDoctorBiz jsResDoctorBiz;
	@Autowired
	private JsResDoctorRecruitBizImpl jsResDoctorRecruitBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IResDoctorBiz resDoctorBiz;
	@Autowired
	private IPubUserResumeBiz userResumeBiz;
	@Autowired
	private IJsResDoctorRecruitBiz doctorRecruitBiz;

	/**
	 * 跳到父页面，用子页面处理
	 */
	@RequestMapping(value="/doctorRecruitList")
	public String doctorRecruitList(){
		return  "jsres/hospital/doctor/doctorTrendMain";
	}
	/**
	 * 当前机构下所有医师
	 */
	@RequestMapping(value="/doctorTrendList")
	public String doctorRecruit(Model model,Integer currentPage, HttpServletRequest request,ResDoctorRecruit resDoctorRecruit,SysUser user){
		SysUser sysuser=GlobalContext.getCurrentUser();
		resDoctorRecruit.setOrgFlow(sysuser.getOrgFlow());
		resDoctorRecruit.setAuditStatusId(JsResDoctorAuditStatusEnum.LocalPassed.getId());
		PageHelper.startPage(currentPage, getPageSize(request));
		List<JsResDoctorRecruitExt> RecruitList=jsResDoctorRecruitBiz.resDoctorRecruitExtList(resDoctorRecruit,user);
		model.addAttribute("recruitList",RecruitList);
		return  "jsres/hospital/doctor/doctorTrendList";
	}
	/**
	 * 根据当前doctorFlow和recruitFlow分别获取一条对应记录
	 */
	@RequestMapping(value="/updateDoctorRecruit")
	public String updateDoctorRecruit(Model model,String doctorFlow,String recruitFlow){
		if (StringUtil.isNotBlank(doctorFlow)) {
			SysUser user= userBiz.readSysUser(doctorFlow);
			model.addAttribute("user",user);
		}
		ResDoctorRecruit doctorRecruit=doctorRecruitBiz.readResDoctorRecruit(recruitFlow);
		model.addAttribute("doctorRecruit",doctorRecruit);
		return  "jsres/hospital/doctor/editDoctorTrend";
	}
	/**
	 * 修改ResDoctorRecru的值
	 */
	@RequestMapping(value="/modifyDoctorRecruit")
	@ResponseBody
	public String modifyDoctorRecruit(ResDoctorRecruitWithBLOBs recruitWithBLOBs){
		int num=doctorRecruitBiz.saveDoctorRecruit(recruitWithBLOBs);
		if (GlobalConstant.ZERO_LINE != num) {
			return GlobalConstant.UPDATE_SUCCESSED;
		}else{
			return GlobalConstant.UPDATE_FAIL;
		}
		
	}
	
	
}
