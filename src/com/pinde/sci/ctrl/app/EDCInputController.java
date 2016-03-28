package com.pinde.sci.ctrl.app;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pinde.core.util.CodeUtil;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PyUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcRandomBiz;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.edc.IVisitBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.biz.security.PasswordHelper;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.edc.PubProjEdcMapper;
import com.pinde.sci.enums.edc.AppReqTypeEnum;
import com.pinde.sci.enums.edc.AppResultTypeEnum;
import com.pinde.sci.enums.edc.EdcIETypeEnum;
import com.pinde.sci.enums.edc.EdcRandomAssignLabelEnum;
import com.pinde.sci.enums.edc.EdcRandomAssignTypeEnum;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.model.edc.RandomFactor;
import com.pinde.sci.model.edc.RandomInfo;
import com.pinde.sci.model.mo.EdcIe;
import com.pinde.sci.model.mo.EdcProjOrg;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.EdcRandomRec;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjOrg;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/edc/app/input")
public class EDCInputController extends GeneralController{   
	
	private static Logger logger = LoggerFactory.getLogger(EDCInputController.class);
	private static String INPUT_ROLE_FLOW = "42f5703ba7cf4471951315d342cbd067";
	private static String appUser1 = "www.wcare.cn";
	private static String appUser2 = "www.nj-pdxx.com";
	
	@Autowired
	private IUserBiz userBiz; 
	@Autowired
	private PubProjEdcMapper pubProjEdcMapper; 
	@Autowired
	private IEdcRandomBiz randomBiz; 
	@Autowired
	private IPubPatientBiz patientBiz; 
	@Autowired
	private IProjOrgBiz projOrgBiz;
	@Autowired
	private IVisitBiz visitBiz; 

	
	//已查看模块分类型显示
	@RequestMapping(value={"/reqFunction"},method={RequestMethod.POST})
	public String reqFunction(String reqCode,String reqParam,String sign,HttpServletRequest request,HttpServletResponse response,Model model){
		String appUser = "";
		String sha1 = CodeUtil.sha1(reqCode+reqParam+appUser1);
		if(StringUtil.defaultString(sign).equals(sha1)){
			appUser = appUser1;
		}
		sha1 = CodeUtil.sha1(reqCode+reqParam+appUser2);
		if(StringUtil.defaultString(sign).equals(sha1)){
			appUser = appUser2;
		}
		
		response.setContentType("application/xml");  
		logger.info(reqCode);
		logger.info(reqParam);

		model.addAttribute("reqCode", reqCode);
		//校验用户
		if(StringUtil.isBlank(appUser)){
			logger.info("appUser is not vailded");
			return "edc/app/403";
		}
		
		//解析reqParam
		if(StringUtil.isBlank(reqParam)&&StringUtil.isNotEquals(reqCode, AppReqTypeEnum.update.getId())){ 
			logger.info("reqParam is null return 404");
			return "edc/app/404";
		}
		if(AppReqTypeEnum.login.getId().equals(reqCode)){
			return _login(reqParam,model);
		}else if(AppReqTypeEnum.projList.getId().equals(reqCode)){
			return _projList(reqParam,model);
		}else if(AppReqTypeEnum.patientList.getId().equals(reqCode)){
			return _patientList(reqParam,model);
		}else if(AppReqTypeEnum.patientDetail.getId().equals(reqCode)){
			return _patientDetail(reqParam,model);
		}else if(AppReqTypeEnum.update.getId().equals(reqCode)){
			return _update(reqParam,model);
		}
		return "edc/app/404";
	}
	
	@RequestMapping(value={"/test"},method={RequestMethod.GET})
	public String test(){
		return "edc/app/test";
	}
	

	private String _login(String reqParam,Model model){
		Map<String,String> responseMap = new HashMap<String, String>();
		String resultId = "";
		String resultName = "";
		String userPhone = "";
		String userPasswd  = "";
		try {
			userPhone = _getReqParamString(reqParam,"userPhone");
			userPasswd = _getReqParamString(reqParam,"userPasswd");
		}  catch (DocumentException e) {
			logger.info("parsing reqParam error");
			return "edc/app/500";
		}
		 if(StringUtil.isBlank(userPhone)){
			 resultId = AppResultTypeEnum.PhoneEmpty.getId();
			 resultName = AppResultTypeEnum.PhoneEmpty.getName();
		 }
		 if(StringUtil.isBlank(userPasswd)){
			 resultId = AppResultTypeEnum.PasswordEmpty.getId();
			 resultName = AppResultTypeEnum.PhoneEmpty.getName();
		 }
		 if(StringUtil.isNotBlank(userPhone)  && StringUtil.isNotBlank(userPasswd)){
			 SysUser user = userBiz.findByUserPhone(userPhone);
			//判断密码
			 if(user != null){
				String passwd = StringUtil.defaultString(user.getUserPasswd());
				if(!passwd.equalsIgnoreCase(PasswordHelper.encryptPassword(user.getUserFlow(), userPasswd))){
					resultId = AppResultTypeEnum.LoginError.getId();
					resultName =  AppResultTypeEnum.LoginError.getName();
				} else if (!_activated(user)){	//判断是否是激活状态
					resultId = AppResultTypeEnum.UserUnActivated.getId();
					resultName = AppResultTypeEnum.UserUnActivated.getName();
				} else {
					List<PubProj> projList = pubProjEdcMapper.selectUserProjListForInput(user.getUserFlow(), INPUT_ROLE_FLOW);
					if(projList!=null && projList.size()>0){
						resultId = AppResultTypeEnum.Success.getId();
						resultName = AppResultTypeEnum.Success.getName();
						model.addAttribute("user", user);
						
					}else {
						resultId = AppResultTypeEnum.UserFlowNull.getId();
						resultName = AppResultTypeEnum.UserFlowNull.getName();
					}
				}	
			 }else {
				 resultId = AppResultTypeEnum.LoginError.getId();
				 resultName =  AppResultTypeEnum.LoginError.getName();
			 }
		 }
			 
		responseMap.put("resultId", resultId);
		responseMap.put("resultName",resultName);
		model.addAttribute("responseMap", responseMap);
		
		return "edc/app/login";
	}
	 

	private String _projList(String reqParam, Model model) {
		try {
			Map<String,String> responseMap = new HashMap<String, String>();
			
			String userFlow = _getReqParamString(reqParam,"userFlow");
			List<PubProj> projList =  pubProjEdcMapper.selectUserProjListForInput(userFlow, INPUT_ROLE_FLOW);
			model.addAttribute("projList", projList);
			
			responseMap.put("resultId", AppResultTypeEnum.Success.getId());
			responseMap.put("resultName",AppResultTypeEnum.Success.getName());
			model.addAttribute("responseMap", responseMap);
		} catch (DocumentException e) {
			logger.info("parsing reqParam error");
			return "edc/app/500";
		}

		return "edc/app/projList";
	}
	
	

	private String _getReqParamString(String reqParam,String paramName) throws DocumentException{
		 Document dom =  DocumentHelper.parseText(reqParam);
		 Node node = dom.getRootElement().selectSingleNode(paramName);
		 if(node != null  ){
			 return node.getText();
		 }
		 return "";
	}
	private List<Node> _getReqParamList(String reqParam,String path) throws DocumentException{
		 Document dom =  DocumentHelper.parseText(reqParam);
		 List<Node> nodes = dom.getRootElement().selectNodes(path);
		 return nodes;
	}
	

	


	private String _patientList(String reqParam, Model model) {
		Map<String,String> responseMap = new HashMap<String, String>();
		String resultId = "";
		String resultName = "";
		String projFlow  = "";
		String userFlow = "";
		
		try {
			 projFlow = _getReqParamString(reqParam,"projFlow");
			 userFlow =  _getReqParamString(reqParam,"userFlow");
		} catch (DocumentException e) {
			e.printStackTrace();
			logger.info("parsing reqParam error");
			return "edc/app/500";
		}
		System.err.println("==========="+userFlow); 
		if(StringUtil.isBlank(userFlow)){
			resultId = AppResultTypeEnum.UserFlowNull.getId();
			resultName = AppResultTypeEnum.UserFlowNull.getName();
		}else {
			SysUser user = userBiz.readSysUser(userFlow);
			if(!_auth(user, projFlow)){
				resultId = AppResultTypeEnum.UserFlowNull.getId();
				resultName = AppResultTypeEnum.UserFlowNull.getName();
			}else {
				String orgFlow = user.getOrgFlow();
				List<PubPatient> patientList = patientBiz.searchAssignPatientByProjFlow(projFlow,orgFlow);
				if(patientList.size()>0){
					Map<String,EdcRandomRec> recMap = randomBiz.getPatientRandomMap(projFlow, orgFlow); 
					
					EdcProjParam projParam = randomBiz.readProjParam(projFlow); 
					if(GeneralMethod.isBlind(projParam)){
						for(Map.Entry<String, EdcRandomRec> entity: recMap.entrySet()){
							entity.getValue().setDrugGroup("***");
						}
					}
					Map<String,String> drugMap = randomBiz.getRandomInfo(projFlow,orgFlow);
					
					model.addAttribute("patientList", patientList);
					model.addAttribute("recMap", recMap);
					model.addAttribute("drugMap", drugMap);
				}
				resultId = AppResultTypeEnum.Success.getId();
				resultName = AppResultTypeEnum.Success.getName();
			}
		}
		responseMap.put("resultId", resultId);
		responseMap.put("resultName",resultName);
		model.addAttribute("responseMap", responseMap);
		return "edc/app/patientList";
	}
	private String _patientDetail(String reqParam, Model model) {
		Map<String,String> responseMap = new HashMap<String, String>();
		String resultId = "";
		String resultName = "";
		String projFlow  = "";
		String patientFlow = "";
		String userFlow  = "";
		
		try {
			 projFlow = _getReqParamString(reqParam,"projFlow");
			 userFlow =  _getReqParamString(reqParam,"userFlow");
			 patientFlow = _getReqParamString(reqParam,"patientFlow");
		} catch (DocumentException e) {
			logger.info("parsing reqParam error");
			return "edc/app/500";
		}
		
		if(StringUtil.isBlank(userFlow)){
			resultId = AppResultTypeEnum.UserFlowNull.getId();
			resultName = AppResultTypeEnum.UserFlowNull.getName();
		}else {
			SysUser user = userBiz.readSysUser(userFlow);
			if(!_auth(user, projFlow)){
				resultId = AppResultTypeEnum.UserFlowNull.getId();
				resultName = AppResultTypeEnum.UserFlowNull.getName();
			}else {
				List<PubProjOrg> projOrgList = projOrgBiz.searchProjOrg(projFlow);
				for(PubProjOrg projOrg : projOrgList){
					if(projOrg.getOrgFlow().equals(user.getOrgFlow())){
						model.addAttribute("centerNo", projOrg.getCenterNo());
					    break;
					}
				}
				PubPatient patient = patientBiz.readPatient(patientFlow);
				if(patient != null){
					RandomInfo randomInfo = randomBiz.getRandomInfo(patientFlow);
					EdcProjParam projParam = randomBiz.readProjParam(projFlow); 
					if(GeneralMethod.isBlind(projParam)){
						randomInfo.getRandomRec().setDrugGroup("***");
					}
					model.addAttribute("randomInfo", randomInfo);
					resultId = AppResultTypeEnum.Success.getId();
					resultName = AppResultTypeEnum.Success.getName();
				}else {
					resultId = AppResultTypeEnum.PatientNotFound.getId();
					resultName = AppResultTypeEnum.PatientNotFound.getName();
				}
			}
		}
		responseMap.put("resultId", resultId);
		responseMap.put("resultName",resultName);
		model.addAttribute("responseMap", responseMap);
		
		return "edc/app/patientDetail";
	}
	
	private boolean _activated(SysUser user){
		if(user == null){
			return false ;
		}else {
			if(UserStatusEnum.Activated.getId().equals(user.getStatusId())){
				return true ;
			}
		}
		return false;
	}
	
	private boolean _auth(SysUser user,String projFlow){
		if(user == null){
			return false ;
		}else {
			if(StringUtil.isNotBlank(projFlow)){
				List<PubProj>   projList = pubProjEdcMapper.selectUserProjListForInput(user.getUserFlow(), INPUT_ROLE_FLOW);
				 for(PubProj proj : projList){
					 if(projFlow.equals(proj.getProjFlow())){
						 return true;
					 }
				 }
			}
		}
		return false;
	}
	
	private String _update(String reqParam, Model model) {
		String appType = "";
		try {
			appType = _getReqParamString(reqParam,"appType");
		} catch (DocumentException e) {
			logger.info("parsing reqParam error");
			return "edc/app/500";
		}
		Map<String,String> responseMap = new HashMap<String, String>();
		String resultId =  AppResultTypeEnum.Success.getId();
		String resultName =  AppResultTypeEnum.Success.getName();
		responseMap.put("resultId", resultId);
		responseMap.put("resultName",resultName);
		responseMap.put("appType", appType);
		model.addAttribute("responseMap", responseMap);
		return "edc/app/update";
	}
}

