package com.pinde.sci.biz.pub.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.sci.biz.pub.IAttrCodeBiz;
import com.pinde.sci.biz.pub.IAttributeBiz;
import com.pinde.sci.biz.pub.IElementBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.ctrl.pub.ModuleController;
import com.pinde.sci.dao.base.PubAttributeMapper;
import com.pinde.sci.dao.base.PubElementMapper;
import com.pinde.sci.enums.edc.AttrDataTypeEnum;
import com.pinde.sci.enums.edc.AttrInputTypeEnum;
import com.pinde.sci.model.mo.PubAttrCode;
import com.pinde.sci.model.mo.PubAttribute;
import com.pinde.sci.model.mo.PubElement;
import com.pinde.sci.model.mo.PubElementExample;


@Service
@Transactional(rollbackFor=Exception.class)
public class ElementImplBiz implements IElementBiz{

	@Resource
	private PubElementMapper pubElementMapper;
	@Resource
	private PubAttributeMapper pubAttributeMapper;
	@Autowired
	private IAttributeBiz pubAttributeBiz; 
	@Autowired
	private IAttrCodeBiz pubAttrCodeBiz; 
	
	private static Logger logger = LoggerFactory.getLogger(ModuleController.class);

	@Override
	public List<PubElement> searchElementList(PubElementExample example) {
		return pubElementMapper.selectByExample(example);
	}
 
	@Override
	public List<PubElement> searchElementList(String moduleCode) {
		PubElementExample example  = new PubElementExample();
		example.createCriteria().andModuleCodeEqualTo(moduleCode).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		return searchElementList(example);
	}

	@Override
	public PubElement readPubElement(String elementFlow) {
		return pubElementMapper.selectByPrimaryKey(elementFlow);
	}

	@Override
	public PubElement readPubElementByCode(String elementCode) {
		PubElementExample example  = new PubElementExample();
		example.createCriteria().andElementCodeEqualTo(elementCode).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<PubElement> result =  searchElementList(example);
		if(result !=null && result.size()>0){
			return result.get(0);
		}
		return null;
	}

	@Override
	public void addElement(PubElement element,boolean addValFlag,
			boolean addUnitFlag, boolean addAbnormalFlag, String moduleTypeId) {
		element.setElementFlow(PkUtil.getUUID());
		element.setElementCode(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(element, true);
		pubElementMapper.insert(element);
		
		if(addValFlag){
			//默认添加录入值属性
			PubAttribute attribute = new PubAttribute();
			attribute.setAttrFlow(PkUtil.getUUID());
			attribute.setAttrCode(PkUtil.getUUID());
			attribute.setModuleCode(element.getModuleCode());
			attribute.setElementCode(element.getElementCode());
			attribute.setElementName(element.getElementName());
			attribute.setAttrName(GlobalConstant.DEFAULT_ATTR_VALUE_NAME);
			attribute.setAttrVarName(GlobalConstant.DEFAULT_ATTR_VALUE_VAR_NAME);
			attribute.setDataTypeId(AttrDataTypeEnum.String.getId());
			attribute.setDataTypeName(AttrDataTypeEnum.String.getName());
			attribute.setDataLength(GlobalConstant.DEFAULT_ATTR_DATA_LENGTH);
			if (moduleTypeId.equals(GlobalConstant.MODULD_TYPE_LB)) {	//实验室检查模块  录入值属性名默认显示
				attribute.setIsViewName(GlobalConstant.FLAG_Y);
			} else {
				attribute.setIsViewName(GlobalConstant.FLAG_N);
			}
			attribute.setOrdinal(GlobalConstant.DEFAULT_ATTR_ORDINAL);
			attribute.setInputTypeId(AttrInputTypeEnum.Text.getId());
			attribute.setInputTypeName(AttrInputTypeEnum.Text.getName());
			GeneralMethod.setRecordInfo(attribute, true);
			pubAttributeMapper.insert(attribute);
		}
		if(addUnitFlag){
			//默认添加单位属性
			PubAttribute attribute = new PubAttribute();
			attribute.setAttrFlow(PkUtil.getUUID());
			attribute.setAttrCode(PkUtil.getUUID());
			attribute.setModuleCode(element.getModuleCode());
			attribute.setElementCode(element.getElementCode());
			attribute.setElementName(element.getElementName());
			attribute.setAttrName(GlobalConstant.DEFAULT_ATTR_UNIT_NAME);
			attribute.setAttrVarName(GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME);
			attribute.setDataTypeId(AttrDataTypeEnum.String.getId());
			attribute.setDataTypeName(AttrDataTypeEnum.String.getName());
			attribute.setDataLength(GlobalConstant.DEFAULT_ATTR_DATA_LENGTH);
			attribute.setIsViewName(GlobalConstant.FLAG_Y);
			attribute.setOrdinal(GlobalConstant.DEFAULT_ATTR_ORDINAL);
			attribute.setInputTypeId(AttrInputTypeEnum.Text.getId());
			attribute.setInputTypeName(AttrInputTypeEnum.Text.getName());
			GeneralMethod.setRecordInfo(attribute, true);
			pubAttributeMapper.insert(attribute);
		}
		if(addAbnormalFlag){
			//默认添加是否异常属性
			PubAttribute attribute = new PubAttribute();
			attribute.setAttrFlow(PkUtil.getUUID());
			attribute.setAttrCode(PkUtil.getUUID());
			attribute.setModuleCode(element.getModuleCode());
			attribute.setElementCode(element.getElementCode());
			attribute.setElementName(element.getElementName());
			attribute.setAttrName(GlobalConstant.DEFAULT_ATTR_ABNORMAL_NAME);
			attribute.setAttrVarName(GlobalConstant.DEFAULT_ATTR_ABNORMAL_VAR_NAME);
			attribute.setDataTypeId(AttrDataTypeEnum.String.getId());
			attribute.setDataTypeName(AttrDataTypeEnum.String.getName());
			attribute.setDataLength(GlobalConstant.DEFAULT_ATTR_DATA_LENGTH);
			attribute.setIsViewName(GlobalConstant.FLAG_Y);
			attribute.setOrdinal(GlobalConstant.DEFAULT_ATTR_ORDINAL);
			attribute.setInputTypeId(AttrInputTypeEnum.Text.getId());
			attribute.setInputTypeName(AttrInputTypeEnum.Text.getName());
			GeneralMethod.setRecordInfo(attribute, true);
			pubAttributeMapper.insert(attribute);
		}
	}

	@Override
	public void updatePubElementByFlow(PubElement element) {
		GeneralMethod.setRecordInfo(element, false);
		pubElementMapper.updateByPrimaryKeySelective(element);
	}
	
	@Override
	public void updatePubElementByCode(PubElement element) {
		GeneralMethod.setRecordInfo(element, false);
//		pubElementMapper.updateByPrimaryKeySelective(element);
		PubElementExample example = new PubElementExample();
		example.createCriteria().andElementCodeEqualTo(element.getElementCode()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		pubElementMapper.updateByExampleSelective(element, example);
	}

	@Override
	public void saveElementOrder(String[] elementFlow) {
		for(int i=0;i<elementFlow.length;i++){
			PubElement update = new PubElement();
			update.setElementFlow(elementFlow[i]);
			update.setOrdinal((i+1));
			pubElementMapper.updateByPrimaryKeySelective(update);			
		}		
	}
	
	@Override
	public void copyElement(PubElement element) {
		String moduleCode = element.getModuleCode();
		String elementCode = element.getElementCode();
		String elementName = element.getElementName();
		String elementVarName = element.getElementVarName();
		Integer ordinal = element.getOrdinal();
		String copyElementCode = PkUtil.getUUID();
		String copyElementName = elementName + "copy";
		String copyElementVarName = elementVarName + "copy";
		
		//复制元素
		PubElement copeElement = element;
		copeElement.setElementFlow(PkUtil.getUUID());
		copeElement.setElementCode(copyElementCode);
		copeElement.setElementName(copyElementName);
		copeElement.setElementVarName(copyElementVarName);
		Integer copyOrdinal = ordinal==null?ordinal:ordinal+1;
		copeElement.setOrdinal(copyOrdinal);
		GeneralMethod.setRecordInfo(copeElement, true);
		pubElementMapper.insert(copeElement);
		
		List<PubAttrCode> attrCodeList = pubAttrCodeBiz.searchAttrCodeList(moduleCode,elementCode);
		Map<String,List<PubAttrCode>> attrCodeMap = new HashMap<String, List<PubAttrCode>>();
		if (attrCodeList != null && attrCodeList.size() > 0) {
			for(PubAttrCode code : attrCodeList){
				List<PubAttrCode> temp = attrCodeMap.get(code.getAttrCode());
				if(temp == null){
					temp = new ArrayList<PubAttrCode>()	;
				}
				temp.add(code);
				attrCodeMap.put(code.getAttrCode(), temp);
			}
		}
		
		List<PubAttribute> copyAttrList = new ArrayList<PubAttribute>();	//复制属性集合
		List<PubAttrCode> copyAttrCodeList = new ArrayList<PubAttrCode>();	//复制代码集合
		
		//复制属性
		List<PubAttribute> attrList = pubAttributeBiz.searchAttributeList(moduleCode, elementCode);
		if (attrList != null && attrList.size() > 0) {
			for (PubAttribute attr : attrList) {
				List<PubAttrCode> temp = attrCodeMap.get(attr.getAttrCode());
				String copyAttrCode = PkUtil.getUUID();
				PubAttribute copyAttr = new PubAttribute();
				copyAttr = attr;
				copyAttr.setAttrFlow(PkUtil.getUUID());
				copyAttr.setAttrCode(copyAttrCode);
				copyAttr.setElementCode(copyElementCode);
				copyAttr.setElementName(copyElementName);
				GeneralMethod.setRecordInfo(copyAttr, true);
				copyAttrList.add(copyAttr);
				
				//复制代码
				if (temp != null && temp.size() > 0) {
					for (PubAttrCode attrCode : temp) {
						PubAttrCode copyPubAttrCode = new PubAttrCode();
						copyPubAttrCode = attrCode;
						copyPubAttrCode.setCodeFlow(PkUtil.getUUID());
						copyPubAttrCode.setAttrCode(copyAttrCode);
						copyPubAttrCode.setElementCode(copyElementCode);
						GeneralMethod.setRecordInfo(copyPubAttrCode, true);
						copyAttrCodeList.add(copyPubAttrCode);
					}
				}
				
			}
		}
		
		pubAttributeBiz.addAttrList(copyAttrList);
		pubAttrCodeBiz.addAttrCodeList(copyAttrCodeList);
		
	}
	
} 
 