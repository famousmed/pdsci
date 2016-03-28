package com.pinde.sci.biz.srm.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.srm.IAidProjBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.AidProjMapper;
import com.pinde.sci.enums.pub.ProjCategroyEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.AidProj;
import com.pinde.sci.model.mo.AidProjExample;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.AidProjExample.Criteria;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.pub.AidProjExt;
import com.pinde.sci.model.pub.ProjAidFundExt;


@Service
@Transactional(rollbackFor=Exception.class)
public class AidProjBizImpl implements IAidProjBiz{

	@Resource
	private AidProjMapper aidProjMapper;
	@Autowired
	private IFileBiz fileBiz;
//	@Autowired
//	private OrgBizImpl orgBiz;
	
	@Override
	public void save(AidProj aidProj
			,List<MultipartFile> fileList
			,AidProjExt aidProjExt
			,List<ProjAidFundExt> fundList
			,List<String> fileFlows){
		 SysUser currUser= GlobalContext.getCurrentUser();
		 List<String> fileFlowList=new ArrayList<String>();
		  for(MultipartFile file:fileList){
			  String fileFlow=fileBiz.addFile(file,currUser.getUserFlow());
			  fileFlowList.add(fileFlow);
		  }
		//dom4j组织xml数据
			String leadOrgName=aidProjExt.getLeadOrgName();
			String projIntr=aidProjExt.getProjIntr();
			String projRemark=aidProjExt.getProjRemark();
			String projRemark2=aidProjExt.getProjRemark2();
			String projRemark3=aidProjExt.getProjRemark3();
			Document document=DocumentHelper.createDocument();
			//根节点
			Element jspForm=document.addElement("jspForm");
			//二级节点
			Element leadOrgNameElement=jspForm.addElement("leadOrgName");
			//二级节点
			Element projIntrElement=jspForm.addElement("projIntr");
			//二级节点
			Element projRemarkElement=jspForm.addElement("projRemark");
			//二级节点
			Element projRemark2Element=jspForm.addElement("projRemark2");
			//二级节点
			Element projRemark3Element=jspForm.addElement("projRemark3");
			leadOrgNameElement.addAttribute("value", leadOrgName);
			projIntrElement.addAttribute("value", projIntr);
			projRemarkElement.addAttribute("value", projRemark);
			projRemark2Element.addAttribute("value", projRemark2);
			projRemark3Element.addAttribute("value", projRemark3);
			if(null!=fundList && !fundList.isEmpty()){
				for(ProjAidFundExt fundExt:fundList){
					//二级节点--资金分配
					Element fundElement=jspForm.addElement("fund");
					fundElement.addAttribute("fundYear", fundExt.getFundYear());
					fundElement.addAttribute("fundCountryCount", fundExt.getFundCountryCount());
					fundElement.addAttribute("fundProvinceCount", fundExt.getFundProvinceCount());
					fundElement.addAttribute("fundCityCount", fundExt.getFundCityCount());
					fundElement.addAttribute("fundAreaCount", fundExt.getFundAreaCount());
				}
			}
			if(null!=fileFlows && !fileFlows.isEmpty()){
				for(String s:fileFlows){
					 //二级节点--文件流水号
		    		Element fileElement=jspForm.addElement("file");
		    		fileElement.addAttribute("fileFlow", s);
				}
			}
		    if(null != fileFlowList && !fileFlowList.isEmpty()){
		    	for(String s:fileFlowList){
		    	   //二级节点--文件流水号
		    		Element fileElement=jspForm.addElement("file");
		    		fileElement.addAttribute("fileFlow", s);
		    	}
		    } 
		      aidProj.setProjInfo(document.asXML()); 
			if(StringUtil.isNotBlank(aidProj.getProjFlow())){
				GeneralMethod.setRecordInfo(aidProj, false);
				aidProjMapper.updateByPrimaryKeySelective(aidProj);
			}else{
				aidProj.setProjFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(aidProj, true);
				aidProjMapper.insert(aidProj);
			}
		    
		
	}

	@Override
	public AidProj readAidProj(String projFlow) {
		return aidProjMapper.selectByPrimaryKey(projFlow);
	}

//	@Override
//	public void updateAidProj(AidProj aidProj) {
//		GeneralMethod.setRecordInfo(aidProj, false);
//		aidProjMapper.updateByPrimaryKeySelective(aidProj);
//		
//	}

	@Override
	public void deleteAidProj(AidProj aidProj) {
		GeneralMethod.setRecordInfo(aidProj, false);
	     aidProj.setRecordStatus(GlobalConstant.FLAG_N);
	     aidProjMapper.updateByPrimaryKeySelective(aidProj);
	
	}

	@Override
	public List<AidProj> searchAidProj(AidProj aidProj) {
		AidProjExample example=new AidProjExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
		if(StringUtil.isNotBlank(aidProj.getProjYear())){
			criteria.andProjYearEqualTo(aidProj.getProjYear());
		}
		if(StringUtil.isNotBlank(aidProj.getProjNo())){
			criteria.andProjNoLike("%"+aidProj.getProjNo()+"%");
		}
		if(StringUtil.isNotBlank(aidProj.getProjName())){
			criteria.andProjNameLike("%"+aidProj.getProjName()+"%");
		}
		if(StringUtil.isNotBlank(aidProj.getProjCategoryId())){
			criteria.andProjCategoryIdEqualTo(aidProj.getProjCategoryId());
		}
		if(StringUtil.isNotBlank(aidProj.getApplyUserFlow())){
			criteria.andApplyUserFlowEqualTo(aidProj.getApplyUserFlow());
		}
		if(StringUtil.isNotBlank(aidProj.getProjSubCategoryId())){
			criteria.andProjCategoryIdEqualTo(aidProj.getProjSubCategoryId());
		}
		example.setOrderByClause("CREATE_TIME DESC");
		return aidProjMapper.selectByExample(example);
	}

	@Override
	public List<AidProj> searchAidProjByChargeOrg(AidProj aidProj,List<SysOrg> allOrgList) {
		AidProjExample example=new AidProjExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
		if(StringUtil.isNotBlank(aidProj.getProjYear())){
			criteria.andProjYearEqualTo(aidProj.getProjYear());
		}
		if(StringUtil.isNotBlank(aidProj.getProjNo())){
			criteria.andProjNoLike("%"+aidProj.getProjNo()+"%");
		}
		if(StringUtil.isNotBlank(aidProj.getProjName())){
			criteria.andProjNameLike("%"+aidProj.getProjName()+"%");
		}
		if(StringUtil.isNotBlank(aidProj.getProjCategoryId())){
			criteria.andProjCategoryIdEqualTo(aidProj.getProjCategoryId());
		}
		if(StringUtil.isNotBlank(aidProj.getApplyUserFlow())){
			criteria.andApplyUserFlowEqualTo(aidProj.getApplyUserFlow());
		}
		if(StringUtil.isNotBlank(aidProj.getApplyOrgFlow())){
			criteria.andApplyOrgFlowEqualTo(aidProj.getApplyOrgFlow());
		}
		if(StringUtil.isNotBlank(aidProj.getProjSubCategoryId())){
			criteria.andProjSubCategoryIdEqualTo(aidProj.getProjSubCategoryId());
		}
		if(StringUtil.isNotBlank(aidProj.getStatusId())){
			criteria.andStatusIdEqualTo(aidProj.getStatusId());
		}
		if(StringUtil.isNotBlank(aidProj.getChargeOrgFlow())){
			criteria.andChargeOrgFlowEqualTo(aidProj.getChargeOrgFlow());
		}
		if(null!=allOrgList && !allOrgList.isEmpty()){
			List<String> orgFlowList=new ArrayList<String>();
			for(SysOrg org:allOrgList){
				orgFlowList.add(org.getOrgFlow());
			}
			criteria.andApplyOrgFlowIn(orgFlowList);
		}
		example.setOrderByClause("CREATE_TIME DESC");
		return aidProjMapper.selectByExample(example);
	}

	@Override
	public AidProj createAidProj(Map<String, String[]> dataMap, String projCategoryId , String projSubCategoryId) {
		AidProj aidProj = new AidProj();
		if(dataMap.get("projFlow")!=null){
			aidProj.setProjFlow(dataMap.get("projFlow")[0]);
		}
		if(dataMap.get("projYear")!=null){
			aidProj.setProjYear(dataMap.get("projYear")[0]);
		}
		if(dataMap.get("projName")!=null){
			aidProj.setProjName(dataMap.get("projName")[0]);
		}
		if(dataMap.get("projStartTime")!=null){
			aidProj.setProjStartTime(dataMap.get("projStartTime")[0]);
		}
		if(dataMap.get("projEndTime")!=null){
			aidProj.setProjEndTime(dataMap.get("projEndTime")[0]);
		}
		if(dataMap.get("projNo")!=null){
			aidProj.setProjNo(dataMap.get("projNo")[0]);
		}
		if(dataMap.get("projTypeId")!=null){
			aidProj.setProjTypeId(dataMap.get("projTypeId")[0]);
		}
		if(dataMap.get("projTypeName")!=null){
			aidProj.setProjTypeName(dataMap.get("projTypeName")[0]);
		}
		if(dataMap.get("projDeclarer")!=null){
			aidProj.setProjDeclarer(dataMap.get("projDeclarer")[0]);
		}
		SysUser currUser = GlobalContext.getCurrentUser();
		aidProj.setApplyUserFlow(currUser.getUserFlow());
		aidProj.setApplyOrgFlow(currUser.getOrgFlow());
		aidProj.setApplyUserName(currUser.getUserName());
		aidProj.setApplyOrgName(currUser.getOrgName());
		
		
		aidProj.setProjCategoryId(projCategoryId);
		aidProj.setProjCategoryName(ProjCategroyEnum.getNameById(projCategoryId));
		
		aidProj.setProjSubCategoryId(projSubCategoryId);
		List<SysDict> dicts = DictTypeEnum.sysListDictMap.get(DictTypeEnum.AidProjType.getId());
		for(SysDict dict:dicts){
			if(dict.getDictId().equals(projSubCategoryId)){
				aidProj.setProjSubCategoryName(dict.getDictName());
			}
		}
		
		return aidProj;
	}

	@Override
	public void saveAidProj(AidProj aidProj) {
		if(StringUtil.isBlank(aidProj.getProjFlow())){
			aidProj.setProjFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(aidProj, true);
			this.aidProjMapper.insertSelective(aidProj);	
		}else{
			GeneralMethod.setRecordInfo(aidProj, false);
			aidProjMapper.updateByPrimaryKeySelective(aidProj);
		}
		
		
	}
  
}
