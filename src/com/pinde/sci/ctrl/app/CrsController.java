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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pinde.core.util.CodeUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.common.util.WeixinQiYeUtil;
import com.pinde.sci.enums.edc.AppResultTypeEnum;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/app/crs")
public class CrsController{    
	
	private static Logger logger = LoggerFactory.getLogger(CrsController.class);
	private static String appUser = "www.nj-pdxx.com";
	
	@Value("#{configProperties['pdapp.edc.app.url']}") 
	private String edcAppUrl;
	
	@ExceptionHandler(Throwable.class)
    public String exception(Throwable e, HttpServletRequest request,Model model) {
		logger.error(this.getClass().getCanonicalName()+" some error happened",e);
		model.addAttribute("resultName", "后台出错了");
		return "app/crs/500";
    }

	@RequestMapping(value={""},method={RequestMethod.GET})
	public String index(){
		return "app/crs/index";
	}

	@RequestMapping(value={"/"},method={RequestMethod.GET})
	public String index2(){
		return "app/crs/index";
	}

	@RequestMapping(value={"/login"},method={RequestMethod.GET})
	public String login(){
		return "app/crs/login";
	}
	
	@RequestMapping(value={"/loginByWeixin"},method={RequestMethod.GET})
	public String loginByWeixin(String code,HttpServletRequest request,HttpServletResponse response,Model model){
		String userFlow = WeixinQiYeUtil.getUserFlowByCode(InitConfig.getSysCfg("sys_weixin_qiye_corp_id"), InitConfig.getSysCfg("sys_weixin_qiye_secret"), InitConfig.getSysCfg("sys_weixin_qiye_app_id"), code);
		if(StringUtil.isBlank(userFlow)){
			return "app/crs/login";
		}else{
			model.addAttribute("userFlow", userFlow);
			return "redirect:/app/crs/projList";
		}
	}
	
	@RequestMapping(value={"/doLogin"},method={RequestMethod.GET})
	public String login(String userPhone,String userPasswd,HttpServletRequest request,HttpServletResponse response,Model model){
		String resp = _reqFunction("login", "<request><userPhone>"+StringUtil.defaultString(userPhone)+"</userPhone><userPasswd>"+StringUtil.defaultString(userPasswd)+"</userPasswd></request>");
		if(!AppResultTypeEnum.Success.getId().equals(_getResponseString(resp, "resultId"))){
			model.addAttribute("resultName", _getResponseString(resp, "resultName"));
			return "app/crs/500";			
		}
		String userFlow = StringUtil.defaultString(_getResponseString(resp, "data/userInfo/userFlow"));
		String userName = StringUtil.defaultString(_getResponseString(resp, "data/userInfo/userName"));
		model.addAttribute("userFlow", userFlow);
//		model.addAttribute("userName", userName);
		return "redirect:/app/crs/projList";
	}
	
	@RequestMapping(value={"/projList"},method={RequestMethod.GET})
	public String projList(String userFlow,HttpServletRequest request,HttpServletResponse response,Model model){
		String resp = _reqFunction("projList", "<request><userFlow>"+StringUtil.defaultString(userFlow)+"</userFlow></request>");
		if(!AppResultTypeEnum.Success.getId().equals(_getResponseString(resp, "resultId"))){
			model.addAttribute("resultName", _getResponseString(resp, "resultName"));
			return "app/crs/500";			
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
		return "app/crs/projList";
	}
	
	@RequestMapping(value={"/patientList"},method={RequestMethod.GET})
	public String patientList(String userFlow,String projFlow,HttpServletRequest request,HttpServletResponse response,Model model){
		String resp = _reqFunction("applyParam", "<request><userFlow>"+StringUtil.defaultString(userFlow)+"</userFlow><projFlow>"+StringUtil.defaultString(projFlow)+"</projFlow></request>");
		if(!AppResultTypeEnum.Success.getId().equals(_getResponseString(resp, "resultId"))){
			model.addAttribute("resultName", _getResponseString(resp, "resultName"));
			return "app/crs/500";			
		}
		String applyForFollow = StringUtil.defaultString(_getResponseString(resp, "data/params/applyForFollow"));
		model.addAttribute("applyForFollow",applyForFollow);
		
		resp = _reqFunction("patientList", "<request><userFlow>"+StringUtil.defaultString(userFlow)+"</userFlow><projFlow>"+StringUtil.defaultString(projFlow)+"</projFlow></request>");
		if(!AppResultTypeEnum.Success.getId().equals(_getResponseString(resp, "resultId"))){
			model.addAttribute("resultName", _getResponseString(resp, "resultName"));
			return "app/crs/500";			
		}
		
		model.addAttribute("projName", _getProjName(userFlow, projFlow));
		
		List<Map<String,String>> patientInfoList = new ArrayList<Map<String,String>>();
		List<Node> patientInfoNodeList = _getResponseNodeList(resp, "data/patientInfo");
		for(Node patientInfo : patientInfoNodeList){
			String patientFlow = _getNodeText(patientInfo, "patientFlow");
			String order = _getNodeText(patientInfo, "order");
			String namePy = _getNodeText(patientInfo, "namePy");
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
		return "app/crs/patientList";
	}
	
	@RequestMapping(value={"/apply"},method={RequestMethod.GET})
	public String apply(String userFlow,String projFlow,HttpServletRequest request,HttpServletResponse response,Model model){
		String resp = _reqFunction("applyParam", "<request><userFlow>"+StringUtil.defaultString(userFlow)+"</userFlow><projFlow>"+StringUtil.defaultString(projFlow)+"</projFlow></request>");
		if(!AppResultTypeEnum.Success.getId().equals(_getResponseString(resp, "resultId"))){
			model.addAttribute("resultName", _getResponseString(resp, "resultName"));
			return "app/crs/500";			
		}
		
		model.addAttribute("projName", _getProjName(userFlow, projFlow));
		
		String patientInfoName = StringUtil.defaultString(_getResponseString(resp, "data/patientInfo/@name"));
		String factorName = StringUtil.defaultString(_getResponseString(resp, "data/factor/@name"));
		String includeName = StringUtil.defaultString(_getResponseString(resp, "data/include/@name"));
		String excludeName = StringUtil.defaultString(_getResponseString(resp, "data/exclude/@name"));
		model.addAttribute("patientInfoName",patientInfoName);
		model.addAttribute("factorName",factorName);
		model.addAttribute("includeName",includeName);
		model.addAttribute("excludeName",excludeName);
		
		List<Node> patientInfoItemNodeList = _getResponseNodeList(resp, "data/patientInfo/item");
		List<Map<String,Object>> patientInfoItemList = _getItemList(patientInfoItemNodeList);
		model.addAttribute("patientInfoItemList",patientInfoItemList);
		
		List<Node> factorItemNodeList = _getResponseNodeList(resp, "data/factor/item");
		List<Map<String,Object>> factorItemList = _getItemList(factorItemNodeList);
		model.addAttribute("factorItemList",factorItemList);
		
		List<Node> includeItemNodeList = _getResponseNodeList(resp, "data/include/item");
		List<Map<String,Object>> includeItemList = _getItemList(includeItemNodeList);
		model.addAttribute("includeItemList",includeItemList);
		
		List<Node> excludeItemNodeList = _getResponseNodeList(resp, "data/exclude/item");
		List<Map<String,Object>> excludeItemList = _getItemList(excludeItemNodeList);
		model.addAttribute("excludeItemList",excludeItemList);
		
		return "app/crs/apply";
	}
	
	@RequestMapping(value={"/doApply"},method={RequestMethod.POST})
	public String doApply(String userFlow,String projFlow,String[] patientInfoitem,String[] factoritem,String[] includeitem,String[] excludeitem, HttpServletRequest request,HttpServletResponse response,Model model){
		String req = "<request><userFlow>"+StringUtil.defaultString(userFlow)+"</userFlow><projFlow>"+StringUtil.defaultString(projFlow)+"</projFlow>";
		if(patientInfoitem!=null&&patientInfoitem.length>0){
			String pReq = "<patientInfo>";
			for(String id : patientInfoitem){
				pReq = pReq+"<item id=\""+id+"\">"+StringUtil.defaultString(request.getParameter(id))+"</item>";
			}
			pReq = pReq+"</patientInfo>";
			req = req+pReq;
		}
		if(factoritem!=null&&factoritem.length>0){
			String pReq = "<factor>";
			for(String id : factoritem){
				pReq = pReq+"<item id=\""+id+"\">"+StringUtil.defaultString(request.getParameter(id))+"</item>";
			}
			pReq = pReq+"</factor>";
			req = req+pReq;
		}
		if(includeitem!=null&&includeitem.length>0){
			String pReq = "<include>";
			for(String id : includeitem){
				pReq = pReq+"<item id=\""+id+"\">"+StringUtil.defaultString(request.getParameter(id))+"</item>";
			}
			pReq = pReq+"</include>";
			req = req+pReq;
		}
		if(excludeitem!=null&&excludeitem.length>0){
			String pReq = "<exclude>";
			for(String id : excludeitem){
				pReq = pReq+"<item id=\""+id+"\">"+StringUtil.defaultString(request.getParameter(id))+"</item>";
			}
			pReq = pReq+"</exclude>";
			req = req+pReq;
		}
		req = req+"</request>";
		String resp = _reqFunction("apply", req);		
		if(!AppResultTypeEnum.Success.getId().equals(_getResponseString(resp, "resultId"))){
			model.addAttribute("resultName", _getResponseString(resp, "resultName"));
			return "app/crs/500";			
		}
		model.addAttribute("projName", _getProjName(userFlow, projFlow));
		model.addAttribute("applyResult", _getResponseString(resp, "data/applyResult"));
		
		return "/app/crs/applyResult";
	}
	
	@RequestMapping(value={"/patient"},method={RequestMethod.GET})
	public String patient(String userFlow,String projFlow,String patientFlow, HttpServletRequest request,HttpServletResponse response,Model model){
		String resp = _reqFunction("applyParam", "<request><userFlow>"+StringUtil.defaultString(userFlow)+"</userFlow><projFlow>"+StringUtil.defaultString(projFlow)+"</projFlow></request>");
		if(!AppResultTypeEnum.Success.getId().equals(_getResponseString(resp, "resultId"))){
			model.addAttribute("resultName", _getResponseString(resp, "resultName"));
			return "app/crs/500";			
		}
		String applyForFollow = StringUtil.defaultString(_getResponseString(resp, "data/params/applyForFollow"));
		model.addAttribute("applyForFollow",applyForFollow);

		model.addAttribute("projName", _getProjName(userFlow, projFlow));
		
		model.addAttribute("patientInfo", _getPatientInfo(userFlow, projFlow, patientFlow));
		
		return "/app/crs/patient";
	}
	
	@RequestMapping(value={"/patientDetail"},method={RequestMethod.GET})
	public String patientDetail(String userFlow,String projFlow,String patientFlow, HttpServletRequest request,HttpServletResponse response,Model model){
		String resp = _reqFunction("applyParam", "<request><userFlow>"+StringUtil.defaultString(userFlow)+"</userFlow><projFlow>"+StringUtil.defaultString(projFlow)+"</projFlow></request>");
		if(!AppResultTypeEnum.Success.getId().equals(_getResponseString(resp, "resultId"))){
			model.addAttribute("resultName", _getResponseString(resp, "resultName"));
			return "app/crs/500";			
		}
		String applyForFollow = StringUtil.defaultString(_getResponseString(resp, "data/params/applyForFollow"));
		model.addAttribute("applyForFollow",applyForFollow);
		resp = _reqFunction("patientDetail", "<request><userFlow>"+StringUtil.defaultString(userFlow)+"</userFlow><projFlow>"+StringUtil.defaultString(projFlow)+"</projFlow><patientFlow>"+StringUtil.defaultString(patientFlow)+"</patientFlow></request>");
		if(!AppResultTypeEnum.Success.getId().equals(_getResponseString(resp, "resultId"))){
			model.addAttribute("resultName", _getResponseString(resp, "resultName"));
			return "app/crs/500";			
		}
		model.addAttribute("projName", _getProjName(userFlow, projFlow));
		
		model.addAttribute("patientInfo", _getPatientInfo(userFlow, projFlow, patientFlow));
		
		List<Map<String,String>> applyRecordList = new ArrayList<Map<String,String>>();
		List<Node> applyRecordNodeList = _getResponseNodeList(resp, "data/applyRecord");
		for(Node applyRecord : applyRecordNodeList){
			String pack = _getNodeText(applyRecord, "pack");
			String assignTime = _getNodeText(applyRecord, "assignTime");
			String assigner = _getNodeText(applyRecord, "assigner");
			Map<String,String> applyRecordMap = new HashMap<String, String>();
			applyRecordMap.put("pack", pack);
			applyRecordMap.put("assignTime", assignTime);
			applyRecordMap.put("assigner", assigner);
			applyRecordList.add(applyRecordMap);
		}
		model.addAttribute("applyRecordList", applyRecordList);
		return "/app/crs/patientDetail";
	}
	
	@RequestMapping(value={"/visit"},method={RequestMethod.GET})
	public String visit(String userFlow,String projFlow,String patientFlow,HttpServletRequest request,HttpServletResponse response,Model model){
		String resp = _reqFunction("applyParam", "<request><userFlow>"+StringUtil.defaultString(userFlow)+"</userFlow><projFlow>"+StringUtil.defaultString(projFlow)+"</projFlow></request>");
		if(!AppResultTypeEnum.Success.getId().equals(_getResponseString(resp, "resultId"))){
			model.addAttribute("resultName", _getResponseString(resp, "resultName"));
			return "app/crs/500";			
		}
//		String patientInfoName = StringUtil.defaultString(_getResponseString(resp, "data/patientInfo/@name"));
		String factorName = StringUtil.defaultString(_getResponseString(resp, "data/factor/@name"));
//		String includeName = StringUtil.defaultString(_getResponseString(resp, "data/include/@name"));
//		String excludeName = StringUtil.defaultString(_getResponseString(resp, "data/exclude/@name"));
//		model.addAttribute("patientInfoName",patientInfoName);
		model.addAttribute("factorName",factorName);
//		model.addAttribute("includeName",includeName);
//		model.addAttribute("excludeName",excludeName);
		
//		List<Node> patientInfoItemNodeList = _getResponseNodeList(resp, "data/patientInfo/item");
//		List<Map<String,Object>> patientInfoItemList = _getItemList(patientInfoItemNodeList);
//		model.addAttribute("patientInfoItemList",patientInfoItemList);
		
		List<Node> factorItemNodeList = _getResponseNodeList(resp, "data/factor/item");
		List<Map<String,Object>> factorItemList = _getItemList(factorItemNodeList);
		model.addAttribute("factorItemList",factorItemList);
		
//		List<Node> includeItemNodeList = _getResponseNodeList(resp, "data/include/item");
//		List<Map<String,Object>> includeItemList = _getItemList(includeItemNodeList);
//		model.addAttribute("includeItemList",includeItemList);
//		
//		List<Node> excludeItemNodeList = _getResponseNodeList(resp, "data/exclude/item");
//		List<Map<String,Object>> excludeItemList = _getItemList(excludeItemNodeList);
//		model.addAttribute("excludeItemList",excludeItemList);
		
		model.addAttribute("projName", _getProjName(userFlow, projFlow));
		
		model.addAttribute("patientInfo", _getPatientInfo(userFlow, projFlow, patientFlow));
		
		return "app/crs/visit";
	}
	@RequestMapping(value={"/doVisit"},method={RequestMethod.POST})
	public String doVisit(String userFlow,String projFlow,String patientFlow,String[] factoritem,HttpServletRequest request,HttpServletResponse response,Model model){
		String req = "<request><userFlow>"+StringUtil.defaultString(userFlow)+"</userFlow><projFlow>"+StringUtil.defaultString(projFlow)+"</projFlow><patientFlow>"+StringUtil.defaultString(patientFlow)+"</patientFlow>";
//		if(patientInfoitem!=null&&patientInfoitem.length>0){
//			String pReq = "<patientInfo>";
//			for(String id : patientInfoitem){
//				pReq = pReq+"<item id=\""+id+"\">"+StringUtil.defaultString(request.getParameter(id))+"</item>";
//			}
//			pReq = pReq+"</patientInfo>";
//			req = req+pReq;
//		}
		if(factoritem!=null&&factoritem.length>0){
			String pReq = "<factor>";
			for(String id : factoritem){
				pReq = pReq+"<item id=\""+id+"\">"+StringUtil.defaultString(request.getParameter(id))+"</item>";
			}
			pReq = pReq+"</factor>";
			req = req+pReq;
		}
//		if(includeitem!=null&&includeitem.length>0){
//			String pReq = "<include>";
//			for(String id : includeitem){
//				pReq = pReq+"<item id=\""+id+"\">"+StringUtil.defaultString(request.getParameter(id))+"</item>";
//			}
//			pReq = pReq+"</include>";
//			req = req+pReq;
//		}
//		if(excludeitem!=null&&excludeitem.length>0){
//			String pReq = "<exclude>";
//			for(String id : excludeitem){
//				pReq = pReq+"<item id=\""+id+"\">"+StringUtil.defaultString(request.getParameter(id))+"</item>";
//			}
//			pReq = pReq+"</exclude>";
//			req = req+pReq;
//		}
		req = req+"</request>";
		String resp = _reqFunction("visit", req);		
		if(!AppResultTypeEnum.Success.getId().equals(_getResponseString(resp, "resultId"))){
			model.addAttribute("resultName", _getResponseString(resp, "resultName"));
			return "app/crs/500";			
		}
		model.addAttribute("projName", _getProjName(userFlow, projFlow));
		model.addAttribute("patientInfo", _getPatientInfo(userFlow, projFlow, patientFlow));
		model.addAttribute("applyResult", _getResponseString(resp, "data/applyResult"));
		
		return "/app/crs/visitResult";
	}
	
	private List<Map<String,Object>> _getItemList(List<Node> itemNodeList){
		List<Map<String,Object>> itemList = new ArrayList<Map<String,Object>>();
		for(Node itemNode : itemNodeList){
			String id = _getNodeText(itemNode, "@id");
			String name = _getNodeText(itemNode, "@name");
			String order = _getNodeText(itemNode, "@order");
			String type = _getNodeText(itemNode, "@type");
			String placeholder = _getNodeText(itemNode, "@placeholder");
			String maxValue = _getNodeText(itemNode, "@maxValue");
			String minValue = _getNodeText(itemNode, "@minValue");
			String passedValue = _getNodeText(itemNode, "@passedValue");
			String text = itemNode.getText();
			Map<String,Object> itemMap = new HashMap<String, Object>();
			itemMap.put("id", id);
			itemMap.put("name", name);
			itemMap.put("order", order);
			itemMap.put("type", type);
			itemMap.put("placeholder", placeholder);
			itemMap.put("text", text);
			itemMap.put("maxValue", maxValue);
			itemMap.put("minValue", minValue);
			itemMap.put("passedValue", passedValue);
			
			List<Map<String,String>> optionList = new ArrayList<Map<String,String>>();
			List<Node> optionNodeList = itemNode.selectNodes("option");
			for(Node optionNode : optionNodeList){
				String optionId = _getNodeText(optionNode, "@id");
				String optionText = optionNode.getText();
				Map<String,String> optionMap = new HashMap<String, String>();
				optionMap.put("id", optionId);
				optionMap.put("text", optionText);
				optionList.add(optionMap);
			}
			itemMap.put("optionList", optionList);
			itemList.add(itemMap);
		}
		return itemList;
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
		PostMethod request = new PostMethod(edcAppUrl); 
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

