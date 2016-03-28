package com.pinde.sci.biz.srm.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pinde.core.jspform.ItemGroup;
import com.pinde.core.jspform.Page;
import com.pinde.core.jspform.PageGroup;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IProjPageBiz;
import com.pinde.sci.biz.srm.IProjRecBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.common.util.JspFormUtil;
import com.pinde.sci.dao.base.PubFileMapper;
import com.pinde.sci.enums.srm.ProjRecTypeEnum;
import com.pinde.sci.model.mo.PubProjRec;

@Service
public class ProjPageBizImpl  implements IProjPageBiz{

	@Autowired
	private IProjRecBiz projRecBiz;
	@Resource
	private PubFileMapper pubFileMapper;
	
	@Override
	public Page getPage(String isAid) {
		/*PageGroup pageGroup = null;
		Page page=null;
		if(StringUtil.isNotBlank(isAid) && isAid.equals(GlobalConstant.FLAG_Y)){
			pageGroup=InitConfig.projInfoAidPageMap.get("0");
		}
		if(null!=pageGroup){
			page=pageGroup.getPageMap().get("step1");
			return page;
		}*/
		return null;
	}	
	
	@Override
	public PageGroup getPageGroup(String recTypeId , String projTypeId){
		PageGroup pageGroup = null;
		String pageGroupName = InitConfig.configMap.get(recTypeId).get(projTypeId);
		if(ProjRecTypeEnum.Info.getId().equals(recTypeId)){
			pageGroup = InitConfig.projInfoPageMap.get(pageGroupName);
		}else if(ProjRecTypeEnum.Apply.getId().equals(recTypeId)){
			pageGroup = InitConfig.projApplyPageMap.get(pageGroupName);
		}else if(ProjRecTypeEnum.Contract.getId().equals(recTypeId)){
			pageGroup = InitConfig.projContractPageMap.get(pageGroupName);
		}else if(ProjRecTypeEnum.DelayReport.getId().equals(recTypeId)){
			pageGroup = InitConfig.projDelayPageMap.get(pageGroupName);
		}else if(ProjRecTypeEnum.ScheduleReport.getId().equals(recTypeId)){
			pageGroup = InitConfig.projSchdulePageMap.get(pageGroupName);
		}else if(ProjRecTypeEnum.ChangeReport.getId().equals(recTypeId)){
			pageGroup = InitConfig.projChangePageMap.get(pageGroupName);
		}else if(ProjRecTypeEnum.CompleteReport.getId().equals(recTypeId)){
			pageGroup = InitConfig.projCompletePageMap.get(pageGroupName);
		}else if(ProjRecTypeEnum.TerminateReport.getId().equals(recTypeId)){
			pageGroup = InitConfig.projTerminatePageMap.get(pageGroupName);
		}	
		return pageGroup;	 
	}
	
	@Override
	public Page getPage(String recTypeId , String projTypeId , String pageName){
		PageGroup pageGroup = getPageGroup(recTypeId , projTypeId);
		Page page = pageGroup.getPageMap().get(pageName);
		return page;
	}

	@Override
	public Map<String, Object> getItemGroupDataMap(String projRecFlow, Page page,String itemGroupFlow) {
		Map<String , Object> resultMap = new HashMap<String , Object>();
		if(StringUtil.isNotBlank(projRecFlow)){
			PubProjRec projRec = this.projRecBiz.readProjRec(projRecFlow);
			if(StringUtil.isNotBlank(itemGroupFlow)){
				resultMap = JspFormUtil.parseXmlItemGroupStr(projRec.getRecContent(), page, itemGroupFlow);
			}
		}
		return resultMap;
	}

	@Override
	public void modProjRecContentItem(String projRecFlow, Page page,Map<String, String[]> dataMap) {
		//将要操作的步骤数据读取出来
		PubProjRec projRec = this.projRecBiz.readProjRec(projRecFlow);
		String recContent = projRec.getRecContent();
		//修改item
		recContent = JspFormUtil.updateXmlStr(recContent, page, dataMap);
		projRec.setRecContent(recContent);
		this.projRecBiz.modProjRecWithXml(projRec);		
	}
	
	@Override
	public void modProjRecContentItemGroup(String projRecFlow, Page page,
			Map<String, String[]> dataMap, String itemGroupFlow,
			String itemGroupName, String flag) {
		//将要操作的步骤数据读取出来
		PubProjRec projRec = this.projRecBiz.readProjRec(projRecFlow);
		String recContent = projRec.getRecContent();
		if(GlobalConstant.FLAG_Y.equals(flag)){
			if(StringUtil.isBlank(itemGroupFlow)){
				itemGroupFlow = PkUtil.getUUID();
			}
			recContent = JspFormUtil.updateXmlItemGroupStr(recContent, page, itemGroupName, itemGroupFlow, dataMap);
		}else if(GlobalConstant.FLAG_N.equals(flag)){
			recContent = JspFormUtil.delXmlItemGroupStr(recContent, page, itemGroupName, itemGroupFlow);
		}
		projRec.setRecContent(recContent);
		this.projRecBiz.modProjRecWithXml(projRec);
	}
	
	@Override
	public void delFileItemGroup(String projRecFlow, Page page, Object object,
			String itemGroupFlow, String itemGroupName, String delFileFlag) {
		//将要操作的步骤数据读取出来
		PubProjRec projRec = this.projRecBiz.readProjRec(projRecFlow);
		String recContent = projRec.getRecContent();
		if(GlobalConstant.FLAG_Y.equals(delFileFlag)){
			recContent = JspFormUtil.delXmlFileItemGroupStr(recContent, page, itemGroupName, itemGroupFlow);
			projRec.setRecContent(recContent);
			this.projRecBiz.modProjRecWithXml(projRec);
		}
	}


	@Override
	public String getJspPath(Page page, String itemGroupName) {
		if(StringUtil.isNotBlank(itemGroupName)){
			List<ItemGroup> itemGroupList = page.getItemGroupList();
			String jsp = "";
			for(ItemGroup ig:itemGroupList){
				if(ig.getName().equals(itemGroupName)){
					jsp = ig.getJsp();
					break;
				}
			}
			return jsp;
		}else{
			return page.getJsp();
		}
	}

}
