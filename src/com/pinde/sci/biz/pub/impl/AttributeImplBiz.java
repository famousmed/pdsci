package com.pinde.sci.biz.pub.impl;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IAttrCodeBiz;
import com.pinde.sci.biz.pub.IAttributeBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.PubAttributeMapper;
import com.pinde.sci.enums.edc.AttrDataTypeEnum;
import com.pinde.sci.enums.edc.AttrInputTypeEnum;
import com.pinde.sci.model.mo.PubAttrCode;
import com.pinde.sci.model.mo.PubAttribute;
import com.pinde.sci.model.mo.PubAttributeExample;


@Service
@Transactional(rollbackFor=Exception.class)
public class AttributeImplBiz implements IAttributeBiz{

	@Resource
	private PubAttributeMapper pubAttributeMapper;
	
	@Autowired
	private IAttrCodeBiz pubAttrCodeBiz; 

	@Override
	public List<PubAttribute> searchAttributeList(PubAttributeExample example) {
		return pubAttributeMapper.selectByExample(example);
	}
 

	@Override
	public List<PubAttribute> searchAttributeList(String moduleCode,
			String elementCode) {
		PubAttributeExample example = new PubAttributeExample();
		example.createCriteria().andModuleCodeEqualTo(moduleCode).andElementCodeEqualTo(elementCode).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		return searchAttributeList(example);
	}

	@Override
	public PubAttribute readPubAttribute(String flow) {
		return pubAttributeMapper.selectByPrimaryKey(flow);
	}


	@Override
	public void addAttr(PubAttribute attr) {
		attr.setAttrFlow(PkUtil.getUUID());
		attr.setAttrCode(PkUtil.getUUID());
		attr.setDataTypeName(AttrDataTypeEnum.getNameById(attr.getDataTypeId()));
		attr.setInputTypeName(AttrInputTypeEnum.getNameById(attr.getInputTypeId()));
		GeneralMethod.setRecordInfo(attr, true);
		pubAttributeMapper.insert(attr);
	}

	@Override
	public void addAttrList(List<PubAttribute> attrList) {
		if (attrList != null && attrList.size() > 0) {
			for (PubAttribute attr : attrList) {
				pubAttributeMapper.insert(attr);
			}
		}
	}

	@Override
	public PubAttribute readPubAttributeByCode(String attrCode) {
		PubAttributeExample example = new PubAttributeExample();
		example.createCriteria().andAttrCodeEqualTo(attrCode).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		
		List<PubAttribute> result = searchAttributeList(example);
		if(result!=null && result.size()>0){
			return result.get(0);
		}
		return null;
	}


	@Override
	public void modify(PubAttribute attr) {
		
		if(StringUtil.isNotBlank(attr.getDataTypeId())){
			attr.setDataTypeName(AttrDataTypeEnum.getNameById(attr.getDataTypeId()));
		}
		if(StringUtil.isNotBlank(attr.getInputTypeId())){
			attr.setInputTypeName(AttrInputTypeEnum.getNameById(attr.getInputTypeId()));
		}
		GeneralMethod.setRecordInfo(attr, false);
		pubAttributeMapper.updateByPrimaryKeySelective(attr);
	}


	@Override
	public void deleteAttr(PubAttribute attr) {
		attr.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		pubAttributeMapper.updateByPrimaryKeySelective(attr);
	}


	@Override
	public void saveAttributeOrder(String[] attrFlow) {
		for(int i=0;i<attrFlow.length;i++){
			PubAttribute update = new PubAttribute();
			update.setAttrFlow(attrFlow[i]);
			update.setOrdinal((i+1));
			pubAttributeMapper.updateByPrimaryKeySelective(update);			
		}		
		
	}


	@Override
	public void copyAttribute(PubAttribute attr) {
		String attrCode = attr.getAttrCode();
		String attrName = attr.getAttrName();
		String attrVarName = attr.getAttrVarName();
		Integer ordinal = attr.getOrdinal();
		String copyAttrCode = PkUtil.getUUID();
		String copyAttrName = attrName + "copy";
		String copyAttrVarName = attrVarName + "copy";
		
		//复制属性
		PubAttribute copeAttr = attr;
		copeAttr.setAttrFlow(PkUtil.getUUID());
		copeAttr.setAttrCode(copyAttrCode);
		copeAttr.setAttrName(copyAttrName);
		copeAttr.setAttrVarName(copyAttrVarName);
		Integer copyOrdinal = ordinal==null?ordinal:ordinal+1;
		copeAttr.setOrdinal(copyOrdinal);
		GeneralMethod.setRecordInfo(copeAttr, true);
		pubAttributeMapper.insert(copeAttr);
		
		List<PubAttrCode> attrCodeList = pubAttrCodeBiz.searchAttrCodeListByAttrCode(attrCode);
		List<PubAttrCode> copyAttrCodeList = new ArrayList<PubAttrCode>();	//复制代码集合
		if (attrCodeList != null && attrCodeList.size() > 0) {
			for(PubAttrCode code : attrCodeList){
				PubAttrCode copyPubAttrCode = new PubAttrCode();
				copyPubAttrCode = code;
				copyPubAttrCode.setCodeFlow(PkUtil.getUUID());
				copyPubAttrCode.setAttrCode(copyAttrCode);
				GeneralMethod.setRecordInfo(copyPubAttrCode, true);
				copyAttrCodeList.add(copyPubAttrCode);
			}
		}
		
		pubAttrCodeBiz.addAttrCodeList(copyAttrCodeList);
		
	}
} 
 