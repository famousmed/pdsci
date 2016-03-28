package com.pinde.sci.ctrl.app;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Node;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pinde.core.util.CodeUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IInputBiz;
import com.pinde.sci.biz.edc.IVisitBiz;
import com.pinde.sci.biz.edc.impl.VisitBizImpl;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.common.util.WeixinQiYeUtil;
import com.pinde.sci.enums.edc.AppResultTypeEnum;
import com.pinde.sci.model.edc.EdcDesignForm;
import com.pinde.sci.model.mo.EdcVisit;
import com.pinde.sci.model.mo.PubPatientVisit;
import com.pinde.sci.model.mo.PubPatientVisitExample;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/app/edc")
public class EdcController extends GeneralController{    
	@Autowired
	private IVisitBiz visitBiz;
	@Autowired
	private IInputBiz inputBiz; 
	private static Logger logger = LoggerFactory.getLogger(EdcController.class);
	private static String appUser = "www.nj-pdxx.com";
	
	@ExceptionHandler(Throwable.class)
    public String exception(Throwable e, HttpServletRequest request,Model model) {
		logger.error(this.getClass().getCanonicalName()+" some error happened",e);
		model.addAttribute("resultName", "后台出错了");
		return "app/crs/500";
    }

	@RequestMapping(value={""},method={RequestMethod.GET})
	public String index(){
		return "app/edc/index";
	}

	@RequestMapping(value={"/"},method={RequestMethod.GET})
	public String index2(){
		return "app/edc/index";
	}

	@RequestMapping(value={"/login"},method={RequestMethod.GET})
	public String login(){
		return "app/edc/login";
	}
	
	@RequestMapping(value={"/loginByWeixin"},method={RequestMethod.GET})
	public String loginByWeixin(String code,HttpServletRequest request,HttpServletResponse response,Model model){
		String userFlow = WeixinQiYeUtil.getUserFlowByCode(InitConfig.getSysCfg("sys_weixin_qiye_corp_id"), InitConfig.getSysCfg("sys_weixin_qiye_secret"), InitConfig.getSysCfg("sys_weixin_qiye_app_id"), code);
		if(StringUtil.isBlank(userFlow)){
			return "app/crs/login";
		}else{
			model.addAttribute("userFlow", userFlow);
			return "redirect:/app/edc/projList";
		}
	}
	
	@RequestMapping(value={"/doLogin"},method={RequestMethod.GET})
	public String login(String userPhone,String userPasswd,HttpServletRequest request,HttpServletResponse response,Model model){
		String resp = _reqFunction("login", "<request><userPhone>"+StringUtil.defaultString(userPhone)+"</userPhone><userPasswd>"+StringUtil.defaultString(userPasswd)+"</userPasswd></request>");
		if(!AppResultTypeEnum.Success.getId().equals(_getResponseString(resp, "resultId"))){
			model.addAttribute("resultName", _getResponseString(resp, "resultName"));
			return "app/edc/500";			
		}
		String userFlow = StringUtil.defaultString(_getResponseString(resp, "data/userInfo/userFlow"));
		String userName = StringUtil.defaultString(_getResponseString(resp, "data/userInfo/userName"));
		model.addAttribute("userFlow", userFlow);
//		model.addAttribute("userName", userName);
		return "redirect:/app/edc/projList";
	}
	
	@RequestMapping(value={"/projList"},method={RequestMethod.GET})
	public String projList(String userFlow,HttpServletRequest request,HttpServletResponse response,Model model){
		String resp = _reqFunction("projList", "<request><userFlow>"+StringUtil.defaultString(userFlow)+"</userFlow></request>");
		if(!AppResultTypeEnum.Success.getId().equals(_getResponseString(resp, "resultId"))){
			model.addAttribute("resultName", _getResponseString(resp, "resultName"));
			return "app/edc/500";			
		}
		List<Map<String,String>> projList = new ArrayList<Map<String,String>>();
		List<Node> projNodeList = _getResponseNodeList(resp, "data/proj");
		for(Node porj : projNodeList){
			String projFlow = _getNodeText(porj, "projFlow");
			String projName = _getNodeText(porj, "projName");
			Map<String,String> projMap = new HashMap<String, String>();
			projMap.put("projFlow", projFlow);
			projMap.put("projName", projName);
			projList.add(projMap);
		}
		model.addAttribute("projList", projList);
		model.addAttribute("userFlow", userFlow);
		return "app/edc/projList";
	}
	
	@RequestMapping(value={"/patientList"},method={RequestMethod.GET})
	public String patientList(String userFlow,String projFlow,HttpServletRequest request,HttpServletResponse response,Model model){
		String resp = _reqFunction("patientList", "<request><userFlow>"+StringUtil.defaultString(userFlow)+"</userFlow><projFlow>"+StringUtil.defaultString(projFlow)+"</projFlow></request>");
		if(!AppResultTypeEnum.Success.getId().equals(_getResponseString(resp, "resultId"))){
			model.addAttribute("resultName", _getResponseString(resp, "resultName"));
			return "app/edc/500";			
		}
		
		model.addAttribute("projName", _getProjName(userFlow, projFlow));
		
		List<Map<String,String>> patientInfoList = new ArrayList<Map<String,String>>();
		List<Node> patientInfoNodeList = _getResponseNodeList(resp, "data/patientInfo");
		for(Node patientInfo : patientInfoNodeList){
			String patientFlow = _getNodeText(patientInfo, "patientFlow");
			String order = _getNodeText(patientInfo, "order");
			String name = _getNodeText(patientInfo, "name");
			String birthday = _getNodeText(patientInfo, "birthday");
			String sex = _getNodeText(patientInfo, "sex");
			String pack = _getNodeText(patientInfo, "pack");
			String group = _getNodeText(patientInfo, "group");
			String assignTime = _getNodeText(patientInfo, "assignTime");
			String assigner = _getNodeText(patientInfo, "assigner");
			Map<String,String> patientInfoMap = new HashMap<String, String>();
			patientInfoMap.put("patientFlow", patientFlow);
			patientInfoMap.put("order", order);
			patientInfoMap.put("name", name);
			patientInfoMap.put("order", order);
			patientInfoMap.put("birthday", birthday);
			patientInfoMap.put("sex", sex);
			patientInfoMap.put("pack", pack);
			patientInfoMap.put("group", group);
			patientInfoMap.put("assignTime", assignTime);
			patientInfoMap.put("assigner", assigner);
			patientInfoList.add(patientInfoMap);
		}
		model.addAttribute("patientInfoList", patientInfoList);
		return "app/edc/patientList";
	}
	@RequestMapping(value={"/visitList"},method={RequestMethod.GET})
	public String visit(String userFlow,String projFlow,String patientFlow,HttpServletRequest request,HttpServletResponse response,Model model){
		
		model.addAttribute("projName", _getProjName(userFlow, projFlow));
		model.addAttribute("patientInfo", _getPatientInfo(userFlow, projFlow, patientFlow));
		
		List<EdcVisit> visitList = visitBiz.searchVisitList(projFlow);
		model.addAttribute("visitList",visitList);
		
		model.addAttribute("userFlow",userFlow);
		
		PubPatientVisitExample example = new PubPatientVisitExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andPatientFlowEqualTo(patientFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<PubPatientVisit> patientVisitList = inputBiz.searchPatientVisit(example);
		Map<String,String> patientVisitMap = new HashMap<String, String>();
		for(PubPatientVisit pv :patientVisitList ){
			patientVisitMap.put(pv.getVisitFlow(),pv.getVisitDate());
		}
		model.addAttribute("patientVisitMap", patientVisitMap);
		return "app/edc/visitList";
	}
	@RequestMapping(value={"/input"},method={RequestMethod.GET})
	public String doVisit(String userFlow,String visitFlow,String patientFlow,String projFlow,HttpServletRequest request,HttpServletResponse response,Model model){
//		if(getSessionAttribute(GlobalConstant.PROJ_DESC_FORM)==null){
//			logger.info("==============init proj desc ========");
//			EdcDesignForm designForm = edcModuleBiz.getCrfDescForm(projFlow);
//			setSessionAttribute(GlobalConstant.PROJ_DESC_FORM, designForm);
//		}
		//EdcDesignForm form = inputBiz.
		//model.addAttribute("patientInfo", _getPatientInfo(userFlow, projFlow, patientFlow));
		
		return "/app/edc/input";
	}
	
	
	private String _getProjName(String userFlow,String projFlow){
		String projName = "";
		String resp = _reqFunction("projList", "<request><userFlow>"+StringUtil.defaultString(userFlow)+"</userFlow></request>");
		if(!AppResultTypeEnum.Success.getId().equals(_getResponseString(resp, "resultId"))){
			return projName;			
		}
		List<Node> projNodeList = _getResponseNodeList(resp, "data/proj");
		for(Node porj : projNodeList){
			String projFlowNode = _getNodeText(porj, "projFlow");
			String projNameNode = _getNodeText(porj, "projName");
			if(StringUtil.defaultString(projFlow).equals(projFlowNode)){
				projName = projNameNode;
				break;
			}
		}
		return projName;
	}
	
	private Map<String,String> _getPatientInfo(String userFlow,String projFlow,String patientFlowForFind){
		String resp = _reqFunction("patientList", "<request><userFlow>"+StringUtil.defaultString(userFlow)+"</userFlow><projFlow>"+StringUtil.defaultString(projFlow)+"</projFlow></request>");
		if(!AppResultTypeEnum.Success.getId().equals(_getResponseString(resp, "resultId"))){
			return null;
		}
		List<Node> patientInfoNodeList = _getResponseNodeList(resp, "data/patientInfo");
		for(Node patientInfo : patientInfoNodeList){
			String patientFlow = _getNodeText(patientInfo, "patientFlow");
			String order = _getNodeText(patientInfo, "order");
			String namePy = _getNodeText(patientInfo, "namePy");
			String name = _getNodeText(patientInfo, "name");
			String birthday = _getNodeText(patientInfo, "birthday");
			String sex = _getNodeText(patientInfo, "sex");
			String pack = _getNodeText(patientInfo, "pack");
			String group = _getNodeText(patientInfo, "group");
			String assignTime = _getNodeText(patientInfo, "assignTime");
			String assigner = _getNodeText(patientInfo, "assigner");
			Map<String,String> patientInfoMap = new HashMap<String, String>();
			patientInfoMap.put("patientFlow", patientFlow);
			patientInfoMap.put("order", order);
			patientInfoMap.put("namePy", namePy);
			patientInfoMap.put("name", name);
			patientInfoMap.put("order", order);
			patientInfoMap.put("birthday", birthday);
			patientInfoMap.put("sex", sex);
			patientInfoMap.put("pack", pack);
			patientInfoMap.put("group", group);
			patientInfoMap.put("assignTime", assignTime);
			patientInfoMap.put("assigner", assigner);
			if(StringUtil.defaultString(patientFlowForFind).equals(patientFlow)){
				return patientInfoMap;
			}
		}
		return null;
	}
	
	private String _reqFunction(String reqCode,String reqParam){
		HttpClient httpClient = new HttpClient();
		PostMethod request = new PostMethod("http://localhost:8080/pdsci/edc/app/input/reqFunction"); 
		request.addParameter("reqCode", reqCode);
		request.addParameter("reqParam", reqParam);
		String sha1 = CodeUtil.sha1(reqCode+reqParam+appUser);
		System.err.println("reqCode+reqParam+appUser="+reqCode+reqParam+appUser);
		System.err.println("sha1="+sha1);
		request.addParameter("sign", sha1); 
		HttpMethodParams param = request.getParams();
		param.setContentCharset("UTF-8");  
		
		StringBuffer buf = new StringBuffer();
		BufferedReader in = null;
		try {
			httpClient.executeMethod(request);  
			InputStream stream = request.getResponseBodyAsStream();  
			in = new BufferedReader(new InputStreamReader(stream, "UTF-8")); 
			String line;  
			while (null != (line = in.readLine())) {  
				buf.append(line).append("\n");  
			}  
			request.releaseConnection();
		} catch (Exception e) {
			e.printStackTrace();
			if (in != null) {  
				try {  
					in.close();  
				} catch (Exception e1) {  
//					e1.printStackTrace();  
				}  
			}  
		}   

		String result = buf.toString();  
		return result;  

	}
	
	private String _getResponseString(String resp,String path) {
		 Document dom;
		try {
			dom = DocumentHelper.parseText(resp);
			 Node node = dom.getRootElement().selectSingleNode(path);
			 if(node != null  ){
				 return node.getText();
			 }
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 return "";
	}
	
	private String _getNodeText(Node node,String path) {
		try {
			 Node find = node.selectSingleNode(path);
			 if(find != null  ){
				 return find.getText();
			 }
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 return "";
	}
	
	private List<Node> _getResponseNodeList(String resp,String path) {
		 Document dom;
		try {
			dom = DocumentHelper.parseText(resp);
			 List<Node> nodes = dom.getRootElement().selectNodes(path);
			 return nodes;
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
}

