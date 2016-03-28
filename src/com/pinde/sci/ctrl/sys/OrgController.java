package com.pinde.sci.ctrl.sys;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.srm.IApplyLimitBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.res.OrgLevelEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.enums.sys.OrgTypeEnum;
import com.pinde.sci.form.srm.SrmApplyLimitForm;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SrmApplyLimit;
import com.pinde.sci.model.mo.SysOrg;

@Controller
@RequestMapping("/sys/org")
public class OrgController extends GeneralController {
	
	private static Logger logger=LoggerFactory.getLogger(OrgController.class);
	@Autowired
	private IOrgBiz sysOrgBiz;	
	@Autowired
	private IApplyLimitBiz applyLimitBiz;
	@Autowired
	private IResDoctorBiz doctorBiz;
	
	@RequestMapping(value="/list",method={RequestMethod.POST,RequestMethod.GET})
	public String list(SysOrg org, Integer currentPage,HttpServletRequest request, Model model){
		PageHelper.startPage(currentPage, getPageSize(request));
//		org.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
//		if(this.getSessionAttribute("currWsId").toString().equals(GlobalConstant.EDC_WS_ID) && StringUtil.isBlank(org.getOrgProvId())){
//			org.setOrgProvId(InitConfig.getSysCfg("srm_default_orgProvId"));
//		}
		List<SysOrg> sysList=sysOrgBiz.searchOrg(org);
		model.addAttribute("sysList",sysList);
		return "sys/org/list";
	}
	
	@RequestMapping(value = "/edit",method={RequestMethod.GET})
	public String edit(String orgFlow,Model model){
		if(StringUtil.isNotBlank(orgFlow)){
			SysOrg sysOrg=sysOrgBiz.readSysOrg(orgFlow);
			model.addAttribute("sysOrg", sysOrg);
			Map<String,Object> orgInfoData =_parseXmlOrg(sysOrg.getOrgInfo());//通过Map<String,Object>,OrgXmlUtil.parseXmlOrg解析
			model.addAttribute("orgInfoData",orgInfoData);//放到model里面去
			List<SysOrg> childOrgList = this.sysOrgBiz.searchChildrenOrgByOrgFlow(orgFlow);
			List<String> childOrgFlowList = new ArrayList<String>();
			for(SysOrg org:childOrgList){
				childOrgFlowList.add(org.getOrgFlow());
			}
			model.addAttribute("childOrgFlowList" , childOrgFlowList);
		}
		return "sys/org/edit";
	} 
	
	@RequestMapping(value = "/info",method={RequestMethod.GET})
	public String info(Model model){
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		if(StringUtil.isNotBlank(orgFlow)){
			SysOrg sysOrg=sysOrgBiz.readSysOrg(orgFlow);
			model.addAttribute("sysOrg", sysOrg);
			Map<String,Object> orgInfoData =_parseXmlOrg(sysOrg.getOrgInfo());//通过Map<String,Object>,OrgXmlUtil.parseXmlOrg解析
			model.addAttribute("orgInfoData",orgInfoData);//放到model里面去			
		}
		return "sys/org/info";
	} 
	
	@RequestMapping(value={"/save"},method=RequestMethod.POST)
	@ResponseBody
	public String save(SysOrg org,HttpServletRequest request) throws Exception{
		String xml = "";
		if(StringUtil.isNotBlank(org.getOrgFlow())){
			SysOrg oldOrg = this.sysOrgBiz.readSysOrg(org.getOrgFlow());
			xml = oldOrg.getOrgInfo();
			
			if(!org.getOrgName().equals(oldOrg.getOrgName()) && StringUtil.isNotBlank(org.getOrgName())){
				ResDoctor doctor = new ResDoctor();
				doctor.setOrgFlow(org.getOrgFlow());
				doctor.setOrgName(org.getOrgName());
				doctorBiz.updateRedundancyData(doctor);
			}
		}
		Map<String , String[]> datasMap = request.getParameterMap();//传orgXmlUtilMap<String , String[]>参数
		xml = _createXmlOrg(datasMap , "orgInfo." , xml);//获取xml中的参数
//		org.setOrgProvName(DictTypeEnum.OrgProv.getDictNameById(org.getOrgProvId()));
		if (StringUtil.isNotBlank(org.getOrgTypeId())) {
			org.setOrgTypeName(OrgTypeEnum.getNameById(org.getOrgTypeId()));
		}
		org.setOrgInfo(xml);//放进OrgInfo大字段
		if(StringUtil.isNotBlank(org.getChargeOrgFlow())){
			org.setChargeOrgName(InitConfig.getOrgNameByFlow(org.getChargeOrgFlow()));			
		}else{
			org.setChargeOrgFlow("");
			org.setChargeOrgName("");
		}
		if(StringUtil.isNotBlank(org.getOrgLevelId())){
			org.setOrgLevelName(OrgLevelEnum.getNameById(org.getOrgLevelId()));
		}else{
			org.setOrgLevelName("");
		}
		sysOrgBiz.saveOrg(org);
		
		InitConfig._loadOrg(request.getServletContext());
		return GlobalConstant.SAVE_SUCCESSED;		
	}
	
	@RequestMapping(value="/delete",method=RequestMethod.GET)
	@ResponseBody
	public String delete(SysOrg org,HttpServletRequest request){
//		org.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		sysOrgBiz.saveOrg(org);
		InitConfig._loadOrg(request.getServletContext());
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	

	@RequestMapping("/loadApplyOrg")
	@ResponseBody
	public Object loadApplyOrg(@RequestParam(value="orgFlow" , required=true)String orgFlow){
		SysOrg sysOrg = new SysOrg();
		sysOrg.setChargeOrgFlow(orgFlow);
		sysOrg.setRecordStatus(GlobalConstant.FLAG_Y);
		List<SysOrg> orgList = this.sysOrgBiz.searchOrg(sysOrg);
		//List<SysOrg> chargeOrgList = this.sysOrgBiz.searchChargeOrg();
		//List<SysOrg> resultOrgList = new ArrayList<SysOrg>();
		
		return orgList;
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
			Element rootElement=document.addElement("orgInfo");//根节点
			Element infoEle = rootElement.addElement("info");//信息节点
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
				infoEle.detach();//如果info节点存在就删除掉
			}
			//重新创建info节点
			infoEle = rootEle.addElement("info");//信息节点
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
			Element rootEle = doc.getRootElement();//根节点
			Element infoEle = (Element)rootEle.selectSingleNode("info");//查找info节点
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
	
	
	/**
	 * 机构限制
	 * @param orgFlow
	 * @param model
	 * @return
	 */
	@RequestMapping("/editOrgApplyLimit")
	public String editOrgApplyLimit(String orgFlow, Model model){
		if(StringUtil.isNotBlank(orgFlow)){
			SysOrg sysOrg = sysOrgBiz.readSysOrg(orgFlow);
			model.addAttribute("sysOrg", sysOrg);
			SrmApplyLimit applyLimit = new SrmApplyLimit();
			applyLimit.setOrgFlow(orgFlow);
			List<SrmApplyLimit> applyLimitList = applyLimitBiz.searchApplyLimitList(applyLimit);
			if(applyLimitList != null && !applyLimitList.isEmpty()){
				Map<String, SrmApplyLimit> applyLimitMap = new HashMap<String, SrmApplyLimit>();
				for(SrmApplyLimit al :applyLimitList){
					SrmApplyLimit temp = applyLimitMap.get(al.getProjTypeId());
					if(temp == null){
						temp = al;
					}
					applyLimitMap.put(al.getProjTypeId(), temp);
				}
				model.addAttribute("applyLimitMap", applyLimitMap);
			}
		}
		return "sys/org/editOrgApplyLimit";
	}
	
	/**
	 * 保存机构限制
	 * @param customerUser
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/saveOrgApplyLimitList")
	@ResponseBody
	public String saveOrgApplyLimitList(@RequestBody SrmApplyLimitForm form){
		List<SrmApplyLimit> applyLimitList = form.getApplyLimitList();
		int result = applyLimitBiz.saveApplyLimitList(applyLimitList);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping("/viewallorgapplylimitinfo")
	public String viewAllOrgApplyLimitInfo(Model model){
		SrmApplyLimit applyLimit = new SrmApplyLimit();
		List<SrmApplyLimit> applyLimitInfos = this.applyLimitBiz.searchApplyLimitList(applyLimit);
		Map<String , Map<String , String>> applyLimitInfoMap = new HashMap<String, Map<String,String>>();
		Map<String , String> orgs = new HashMap<String, String>();
		Map<String , String> limitNumMap = null;
		for(SrmApplyLimit sal:applyLimitInfos){
			String orgFlow = sal.getOrgFlow();
			orgs.put(orgFlow, sal.getOrgName());
			Short limitNum = sal.getLimitNum();
			String limitNumStr = "";
			if(limitNum!=null){
				limitNumStr = String.valueOf(limitNum);
			}
			if(applyLimitInfoMap.containsKey(orgFlow)){
				limitNumMap = applyLimitInfoMap.get(orgFlow);
				limitNumMap.put(sal.getProjTypeId(), limitNumStr);
			}else{
				limitNumMap = new HashMap<String, String>();
				limitNumMap.put(sal.getProjTypeId(), limitNumStr);
				applyLimitInfoMap.put(orgFlow, limitNumMap);
			}
		}
		model.addAttribute("orgs", orgs);
		model.addAttribute("applyLimitInfoMap" , applyLimitInfoMap);
		return "sys/org/allorgapplylimitinfo";
	}
}
