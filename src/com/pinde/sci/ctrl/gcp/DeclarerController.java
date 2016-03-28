package com.pinde.sci.ctrl.gcp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.gcp.IGcpProjBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.sys.OrgTypeEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("gcp/declarer")
public class DeclarerController extends GeneralController{
	private static Logger logger = LoggerFactory.getLogger(DeclarerController.class);
	
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IGcpProjBiz pubProjBiz;
	@Autowired
	private IGcpProjBiz gcpProjBiz;
	@Autowired
	private IOrgBiz sysOrgBiz;	
	
	/**
	 * 加载申办者列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list",method={RequestMethod.POST,RequestMethod.GET})
	public String list(String orgName,String orgProvId,String orgCityId,String orgAreaId,Model model){
		SysOrg org = new SysOrg();
		org.setOrgName(orgName);
		org.setOrgProvId(orgProvId);
		org.setOrgCityId(orgCityId);
		org.setOrgAreaId(orgAreaId);
		org.setOrgTypeId(OrgTypeEnum.Declare.getId());
		List<SysOrg> orgList = orgBiz.searchOrgWithBLOBs(org);
		model.addAttribute("orgList",orgList);
		
		if(orgList != null && orgList.size()>0){
			Map<String,Map<String,String>> orgInfoFormMap = new HashMap<String,Map<String,String>>();
			List<String> orgFlows = new ArrayList<String>();
			for(SysOrg orgTemp : orgList){
				String orgInfo = orgTemp.getOrgInfo();
				Map<String,String> orgInfoMap = getOrgInfo(orgInfo);
				orgInfoFormMap.put(orgTemp.getOrgFlow(),orgInfoMap);
				orgFlows.add(orgTemp.getOrgFlow());
			}
			model.addAttribute("orgInfoFormMap",orgInfoFormMap);
			
			List<SysUser> userList = userBiz.searchSysUserByOrgFlows(orgFlows);
			if(userList != null && userList.size()>0){
				Map<String,SysUser> userMap = new HashMap<String, SysUser>();
				for(SysUser user : userList){
					userMap.put(user.getOrgFlow(),user);
				}
				model.addAttribute("userMap",userMap);
			}
		}
		return "gcp/declarer/list";
	}
	
	/**
	 * 申办方机构编辑
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/editOrg",method={RequestMethod.GET})
	public String editOrg(String orgFlow,Model model){
		if(StringUtil.isNotBlank(orgFlow)){
			SysOrg org = orgBiz.readSysOrg(orgFlow);
			model.addAttribute("org",org);
			
			if(org != null){
				String orgInfo = org.getOrgInfo();
				Map<String,String> orgInfoMap = getOrgInfo(orgInfo);
				model.addAttribute("orgInfoMap",orgInfoMap);
				
				SysUser user = userBiz.searcherUserByOrgFlow(orgFlow);
				model.addAttribute("user",user);
			}
		}
		return "gcp/declarer/editOrg";
	}
	
	@RequestMapping(value="/saveOrg",method={RequestMethod.POST})
	@ResponseBody
	public String saveOrg(SysOrg org,HttpServletRequest request,SysUser user){
		if(org != null && user != null){
			//包装机构
			org.setOrgTypeId(OrgTypeEnum.Declare.getId());
			org.setOrgTypeName(OrgTypeEnum.Declare.getName());
			String orgInfo = "<orgInfo/>";
			Map<String,String[]> tabMap = request.getParameterMap();
			String headName = (tabMap.get("orgInfo.name"))[0];
			String headPhone = (tabMap.get("orgInfo.phone"))[0];
			try{
				if(StringUtil.isNotBlank(org.getOrgFlow())){
					SysOrg tempOrg = orgBiz.readSysOrg(org.getOrgFlow());
					if(tempOrg != null && StringUtil.isNotBlank(tempOrg.getOrgInfo())){
						orgInfo = tempOrg.getOrgInfo();
					}
				}
				Document dom = DocumentHelper.parseText(orgInfo);
				Element root = dom.getRootElement();
				String xpath = "/orgInfo/info";
				Element headInfoElement = (Element)dom.selectSingleNode(xpath);
				Element headNameElement = null;
				Element headPhoneElement = null;
				Element nameValue = null;
				Element phoneValue = null;
				if(null != headInfoElement){
					headInfoElement = root.element("info");
					headNameElement = (Element)headInfoElement.selectSingleNode("item[@name='orgInfo.name']");
					if(headNameElement != null){
						headNameElement.detach();
					}
					headPhoneElement = (Element)headInfoElement.selectSingleNode("item[@name='orgInfo.phone']");
					if(headPhoneElement != null){
						headPhoneElement.detach();
					}
				}else{
					headInfoElement = root.addElement("info");
				}
				headNameElement = headInfoElement.addElement("item");
				headNameElement.addAttribute("name","orgInfo.name");
				headPhoneElement = headInfoElement.addElement("item");
				headPhoneElement.addAttribute("name","orgInfo.phone");
				nameValue = headNameElement.addElement("value");
				phoneValue = headPhoneElement.addElement("value");
				nameValue.setText(StringUtil.isNotBlank(headName)?headName:"");
				phoneValue.setText(StringUtil.isNotBlank(headPhone)?headPhone:"");
				orgInfo = dom.asXML();
				org.setOrgPhone(headPhone);
			}catch(Exception e){
				e.printStackTrace();
			}
			org.setOrgInfo(orgInfo);
			
			if(StringUtil.isBlank(user.getUserFlow())){
				SysUser old = userBiz.findByUserCode(user.getUserCode());
				if(old!=null){
					return GlobalConstant.USER_CODE_REPETE;
				}
			}
			
			if(orgBiz.saveDeclarerOrg(org,user) != GlobalConstant.ZERO_LINE){
				SysUser currUser = GlobalContext.getCurrentUser();
				if(currUser.getUserFlow().equals(user.getUserFlow())){
					currUser = userBiz.readSysUser(user.getUserFlow());
					setSessionAttribute(GlobalConstant.CURRENT_USER, currUser);
					setSessionAttribute(GlobalConstant.CURRENT_USER_NAME, user.getUserName());	
				}
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * orgInfo内元素
	 * */
	private Map<String,String> getOrgInfo(String orgInfo){
		Map<String,String> orgInfoMap = null;
		if(StringUtil.isNotBlank(orgInfo)){
			try{
				Document dom = DocumentHelper.parseText(orgInfo);
				String xpath = "/orgInfo/info";
				Element headInfoElement = (Element)dom.selectSingleNode(xpath);
				Element headNameElement = null;
				Element headPhoneElement = null;
				if(headInfoElement != null){
					orgInfoMap = new HashMap<String, String>();
					Element value = null;
					headNameElement = (Element)headInfoElement.selectSingleNode("item[@name='orgInfo.name']");
					headPhoneElement = (Element)headInfoElement.selectSingleNode("item[@name='orgInfo.phone']");
					if(headNameElement != null){
						value = (Element)headNameElement.selectSingleNode("value");
						orgInfoMap.put("orgInfo.name",value.getText());
					}
					if(headPhoneElement != null){
						value = (Element)headPhoneElement.selectSingleNode("value");
						orgInfoMap.put("orgInfo.phone",value.getText());
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return orgInfoMap;
	}
	/**
	 * 申办方项目列表
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/projList")
	public String projList(Model model) throws Exception{
		SysUser currUser = GlobalContext.getCurrentUser();
		PubProj proj = new PubProj();
		proj.setProjDeclarerFlow(currUser.getOrgFlow());
		List<PubProj> projList =  pubProjBiz.searchProjList(proj);
		model.addAttribute("projList", projList);
		return "gcp/declarer/projList";
	}
	
	/**
	 * 申办方机构维护
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/orgInfo")
	public String orgInfo(Model model){
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		if(StringUtil.isNotBlank(orgFlow)){
			SysOrg sysOrg=sysOrgBiz.readSysOrg(orgFlow);
			model.addAttribute("sysOrg", sysOrg);
			Map<String,Object> orgInfoData =_parseXmlOrg(sysOrg.getOrgInfo());
			model.addAttribute("orgInfoData",orgInfoData);			
		}
		return "gcp/declarer/orgInfo";
	}
	
	@RequestMapping(value={"/save"},method=RequestMethod.POST)
	@ResponseBody
	public String save(SysOrg org,HttpServletRequest request) throws Exception{
		String xml = "";
		if(StringUtil.isNotBlank(org.getOrgFlow())){
			SysOrg oldOrg = this.sysOrgBiz.readSysOrg(org.getOrgFlow());
			xml = oldOrg.getOrgInfo();
		}
		Map<String , String[]> datasMap = request.getParameterMap();
		xml = _createXmlOrg(datasMap , "orgInfo." , xml);
		if (StringUtil.isNotBlank(org.getOrgTypeId())) {
			org.setOrgTypeName(OrgTypeEnum.getNameById(org.getOrgTypeId()));
		}
		org.setOrgInfo(xml);
		if(StringUtil.isNotBlank(org.getChargeOrgFlow())){
			org.setChargeOrgName(InitConfig.getOrgNameByFlow(org.getChargeOrgFlow()));			
		}else{
			org.setChargeOrgFlow("");
			org.setChargeOrgName("");
		}
		sysOrgBiz.saveOrg(org);
		
		InitConfig._loadOrg(request.getServletContext());
		return GlobalConstant.SAVE_SUCCESSED;		
	}
	
	/**
	 * 
	 * @param datasMap 参数的MAP集合
	 * @param namePattern xml字段的前缀
	 * @return
	 */
	private String _createXmlOrg(Map<String , String[]> datasMap , String namePattern , String xml) throws Exception{
		Document document = null;
		if(StringUtil.isBlank(xml)){
			document = DocumentHelper.createDocument();
			Element rootElement=document.addElement("orgInfo");
			Element infoEle = rootElement.addElement("info");
			Set<Entry<String , String[]>> entrys = datasMap.entrySet();
			Iterator<Entry<String , String[]>> iterator = entrys.iterator();
			while(iterator.hasNext()){
				Entry<String , String[]> entry = iterator.next();
				String key = entry.getKey();
				if(!key.startsWith(namePattern)){
					continue;
				}
				String[] values = entry.getValue();
				Element itemEle = infoEle.addElement("item");
				itemEle.addAttribute("name", key);
				if(values!=null && values.length>0){
					for(String val:values){
						Element valEle = itemEle.addElement("value");
						valEle.setText(val);
					}
				}
			}
			
		}else{
			document = DocumentHelper.parseText(xml);
			Element rootEle = document.getRootElement();
			Element infoEle = (Element)rootEle.selectSingleNode("info");
			if(infoEle!=null){
				infoEle.detach();
			}
			
			infoEle = rootEle.addElement("info");
			Set<Entry<String , String[]>> entrys = datasMap.entrySet();
			Iterator<Entry<String , String[]>> iterator = entrys.iterator();
			while(iterator.hasNext()){
				Entry<String , String[]> entry = iterator.next();
				String key = entry.getKey();
				if(!key.startsWith(namePattern)){
					continue;
				}
				String[] values = entry.getValue();
				Element itemEle = infoEle.addElement("item");
				itemEle.addAttribute("name", key);
				if(values!=null && values.length>0){
					for(String val:values){
						Element valEle = itemEle.addElement("value");
						valEle.setText(val);
					}
				}
			}
		}
		return document.asXML();
		
	}
	
	/**
	 * 
	 * @param xml
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private Map<String, Object> _parseXmlOrg(String xml){
		Map<String , Object> map = new HashMap<String , Object>();
		if(StringUtil.isBlank(xml)){
			return map;
		}
		Document doc=null;
		try {
			doc=DocumentHelper.parseText(xml);
			Element rootEle = doc.getRootElement();
			Element infoEle = (Element)rootEle.selectSingleNode("info");
			if(infoEle==null){
				return map;
			}
			@SuppressWarnings("rawtypes")
			Iterator iterator = infoEle.elementIterator();
			while(iterator.hasNext()){
				Element itemEle = (Element)iterator.next();
				String name = itemEle.attributeValue("name");
				List<Element> valEleList = itemEle.elements();
				if(valEleList!=null && valEleList.size()==1){
					Element valEle = (Element)valEleList.get(0);
					map.put(name, valEle.getText());
				}else if(valEleList!=null && valEleList.size()>1){
					List<String> vals = new ArrayList<String>(); 
					for(Object obj : valEleList){
						Element valEle = (Element)obj;
						String val = valEle.getText();
						vals.add(val);
					}
					map.put(name, vals);
				}
			}
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		return map;
	}
}
