package com.pinde.sci.ctrl.jsres;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.JaxbUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.jsres.IJsResBaseBiz;
import com.pinde.sci.biz.jsres.IResOrgSpeBiz;
import com.pinde.sci.biz.res.IResJointOrgBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.jsres.BaseStatusEnum;
import com.pinde.sci.form.jsres.BaseExtInfoForm;
import com.pinde.sci.form.jsres.BaseInfoForm;
import com.pinde.sci.form.jsres.SpeForm;
import com.pinde.sci.model.jsres.ResBaseExt;
import com.pinde.sci.model.mo.ResBase;
import com.pinde.sci.model.mo.ResJointOrg;
import com.pinde.sci.model.mo.ResOrgSpe;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;

/**
 * @author Neal
 *
 */
@Controller
@RequestMapping("/jsres/base")
public class JsResBaseManagerController extends GeneralController {
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IJsResBaseBiz baseBiz;
	@Autowired
	private IResJointOrgBiz resJointOrgBiz;
	@Autowired
	private IResOrgSpeBiz resOrgSpeBiz;

	@RequestMapping("/baseAudit")
	@ResponseBody
	public String baseAudit(String baseFlow,String status){
		ResBase resBase=new ResBase();
		resBase.setOrgFlow(baseFlow);
		if (GlobalConstant.FLAG_Y.equals(status)) {
			resBase.setBaseStatusId(BaseStatusEnum.ChargePassed.getId());
			resBase.setBaseStatusName(BaseStatusEnum.ChargePassed.getName());
		}
		if (GlobalConstant.FLAG_N.equals(status)) {
			resBase.setBaseStatusId(BaseStatusEnum.NotPassed.getId());
			resBase.setBaseStatusName(BaseStatusEnum.NotPassed.getName());
		}
		int result=baseBiz.saveResBase(resBase);
		if (GlobalConstant.ZERO_LINE!=result) {
			return GlobalConstant.OPRE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}

	/**
	 * 查找协同基地（未用）
	 * @param model
	 * @return
	 */
	@RequestMapping("/findCoopBase")
	public String findCoopBase(Model model){
		SysUser user=GlobalContext.getCurrentUser();
		List<ResJointOrg> jointOrgs = resJointOrgBiz.searchResJointByOrgFlow(user.getOrgFlow());
		model.addAttribute("jointOrgs", jointOrgs);
		return  "jsres/hospital/hos/editCoopBase";
	}

	/**
	 * 市厅查找基地信息
	 */
	@RequestMapping("/findBaseInfo")
	public String findBaseInfo(Integer currentPage,ResBase base, SysOrg org,  HttpServletRequest request, Model model,String auditFlag){
		if (GlobalConstant.FLAG_Y.equals(auditFlag)) {
			base.setBaseStatusId(BaseStatusEnum.Auditing.getId());	
		}
		Map<String, Object> paramMap = new HashMap<String, Object> ();
		paramMap.put("org",org);
		paramMap.put("base",base);
		PageHelper.startPage(currentPage, getPageSize(request));
		List<ResBaseExt> resBaseExtList = baseBiz.searchResBaseExtList(paramMap);
		model.addAttribute("resBaseExtList", resBaseExtList);
		if (GlobalConstant.FLAG_Y.equals(auditFlag)) {
			return "jsres/city/hospital/auditHospitals";
		}
		return "jsres/city/hospital/hospitalList";
	}
	/**
	 * 查找专业基地
	 * @param model
	 * @return
	 */
	@RequestMapping("/findTrainSpe")
	public ModelAndView findTrainSpe(Model model,String trainCategoryType,String orgFlow,String editFlag){
		ModelAndView mav=new ModelAndView();
		ResOrgSpe search = new ResOrgSpe();
		search.setOrgFlow(orgFlow);
		search.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<ResOrgSpe> resSpesList =resOrgSpeBiz.searchResOrgSpeList(search, trainCategoryType);
		if(resSpesList!=null && resSpesList.size()>0){
			Map<String,ResOrgSpe> rbsMap = new HashMap<String,ResOrgSpe>();
			for(ResOrgSpe rbs : resSpesList){
				String key = rbs.getSpeTypeId() + rbs.getSpeId();
				rbsMap.put(key, rbs);
			}
			mav.addObject("rbsMap", rbsMap);
		}
		ResBase resBase =baseBiz.readBase(orgFlow);
		model.addAttribute("resBase", resBase);
		if (GlobalConstant.FLAG_Y.equals(editFlag)||(StringUtil.isBlank(resBase.getBaseStatusId())&&getSessionAttribute(GlobalConstant.USER_LIST_SCOPE).equals(GlobalConstant.USER_LIST_LOCAL))) {
			mav.setViewName("jsres/hospital/hos/editSpe");
		}else{
			model.addAttribute("baseInfoName", trainCategoryType);
			mav.setViewName("jsres/city/hospital/speView");
		}
		return mav;
	}

	/**
	 * 查找信息
	 * @param model
	 * @param baseFlow
	 * @param source
	 * @param Flag
	 * @return
	 */
	@RequestMapping("/findAllBaseInfo")
	public ModelAndView findAllBaseInfo(String baseFlow,String baseInfoName,String editFlag){
		ModelAndView mav = new ModelAndView();
		mav.addObject("sysOrg", orgBiz.readSysOrg(baseFlow));
		ResBase resBase = baseBiz.readBase(baseFlow);
		mav.addObject("resBase", resBase);
		if (resBase!=null) {
			String Xml=resBase.getBaseInfo();
			if(StringUtil.isNotBlank(Xml)){	
				BaseExtInfoForm baseExtInfoForm=JaxbUtil.converyToJavaBean(Xml, BaseExtInfoForm.class);
				if (GlobalConstant.BASIC_INFO.equals(baseInfoName)) {
					mav.addObject("basicInfo", baseExtInfoForm.getBasicInfo());
				}else if (GlobalConstant.ORG_MANAGE.equals(baseInfoName)) {
					mav.addObject("organizationManage", baseExtInfoForm.getOrganizationManage());
				}else if (GlobalConstant.TEACH_CONDITION.equals(baseInfoName)) {
					mav.addObject("educationInfo", baseExtInfoForm.getEducationInfo());
				}else if (GlobalConstant.SUPPORT_CONDITION.equals(baseInfoName)) {
					mav.addObject("supportCondition", baseExtInfoForm.getSupportCondition());
				}
			}
			if(StringUtil.isBlank(resBase.getBaseStatusId())||GlobalConstant.FLAG_Y.equals(editFlag)) {
				mav.setViewName("jsres/hospital/hos/edit"+baseInfoName);
			}else{
				mav.addObject("baseInfoName", baseInfoName);
				mav.setViewName("jsres/city/hospital/"+baseInfoName.substring(0,1).toLowerCase()+baseInfoName.substring(1, baseInfoName.length()));
			}
		}else{//无记录
			mav.setViewName("jsres/hospital/hos/edit"+baseInfoName);
		}
		return mav;
	}

	/**
	 * 保存基本信息
	 * @param form
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/saveBase")
	@ResponseBody
	public String saveBase(String flag, BaseInfoForm form, String index) throws Exception{
		int  result =  baseBiz.saveBaseInfo(flag, form, index);
		if(GlobalConstant.ZERO_LINE !=  result){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}

	/**
	 * 保存专业基地信息
	 * @param form
	 * @return
	 */
	@RequestMapping("/saveTrainSpe")
	@ResponseBody
	public String saveTrainSpe(@RequestBody SpeForm form,String trainCategoryType,String baseFlow){
		List<ResOrgSpe> resBaseSpeList = form.getSpeList();
		int result= baseBiz.saveTrainSpe(resBaseSpeList,trainCategoryType,baseFlow);
		if (GlobalConstant.ZERO_LINE != result) {
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}

	/**
	 * 提交操作
	 * @param baseFlow
	 * @return
	 */
	@RequestMapping("/submitBaseInfo")
	@ResponseBody
	public String submitBaseInfo(String baseFlow){
		ResBase resBase=new ResBase();
		resBase.setOrgFlow(baseFlow);
		resBase.setBaseStatusId(BaseStatusEnum.Auditing.getId());
		resBase.setBaseStatusName(BaseStatusEnum.Auditing.getName());
		int result=baseBiz.saveResBase(resBase);
		if (GlobalConstant.ZERO_LINE!=result) {
			return GlobalConstant.OPRE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
	/**
	 * 跳转界面
	 * @return
	 */
	@RequestMapping("/hospitalMain")
	public String hospitalMain(){
		return "jsres/city/hospital/hospitalMain";
	}

	@RequestMapping("/main")
	public String main(Model model,String baseFlow){
		ResBase resBase=baseBiz.readBase(baseFlow);
		model.addAttribute("resBase",resBase);
		return "jsres/hospital/hos/main";
	}
	/**
	 * 跳转页面用于选审核专业
	 * @return
	 */
	@RequestMapping("/spePage")
	public String spePage(){
		return "jsres/city/hospital/trainSpeMainView";
	}
	@RequestMapping("/trainSpeMain")
	public String trainSpeMain(){
		return "jsres/hospital/hos/trainSpeMain";
	}


}
