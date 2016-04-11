package com.pinde.sci.biz.pub.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IAttrCodeBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.PubAttrCodeMapper;
import com.pinde.sci.model.mo.PubAttrCode;
import com.pinde.sci.model.mo.PubAttrCodeExample;
import com.pinde.sci.model.mo.PubAttribute;


@Service
@Transactional(rollbackFor=Exception.class)
public class AttrCodeImplBiz implements IAttrCodeBiz{

	@Resource
	private PubAttrCodeMapper pubAttrCodeMapper;
	


	@Override
	public List<PubAttrCode> searchAttrCodeList(PubAttrCodeExample example) {
		return pubAttrCodeMapper.selectByExample(example) ;
	}

	@Override
	public List<PubAttrCode> searchAttrCodeList(String moduleCode,String elementCode) {
		PubAttrCodeExample example = new PubAttrCodeExample();
		example.createCriteria().andModuleCodeEqualTo(moduleCode).andElementCodeEqualTo(elementCode).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		return searchAttrCodeList(example);
	}

	@Override
	public void addAttrCode(PubAttribute attr,List<PubAttrCode> attrCodeList) {
		if(attrCodeList!=null){
			for(PubAttrCode code:attrCodeList){
				if(StringUtil.isBlank(code.getCodeFlow())){ 
					code.setCodeFlow(PkUtil.getUUID());
					code.setModuleCode(attr.getModuleCode());
					code.setElementCode(attr.getElementCode());
					code.setAttrCode(attr.getAttrCode());
					GeneralMethod.setRecordInfo(code, true);
					pubAttrCodeMapper.insert(code);
				}else {
					pubAttrCodeMapper.updateByPrimaryKeySelective(code);
				}
			}
		}
	}
	
	@Override
	public void addAttrCodeList(List<PubAttrCode> attrCodeList) {
		if(attrCodeList != null && attrCodeList.size() > 0){
			for(PubAttrCode code:attrCodeList){
				pubAttrCodeMapper.insert(code);
			}
		}
	}

	@Override
	public List<PubAttrCode> searchAttrCodeListByAttrCode(String attrCode) {
		PubAttrCodeExample example = new PubAttrCodeExample();
		example.createCriteria().andAttrCodeEqualTo(attrCode).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		return searchAttrCodeList(example);
	}

	@Override
	public void deleteAttrCode(String codeFlow) {
		PubAttrCode code = pubAttrCodeMapper.selectByPrimaryKey(codeFlow);
		code.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		pubAttrCodeMapper.updateByPrimaryKeySelective(code);
	}

	@Override
	public void deleteAttrCode(List<PubAttrCode> codeList) {
		if(codeList!=null){
			for(PubAttrCode record:codeList ){
				deleteAttrCode(record.getCodeFlow());
			}
		}
	}

	@Override
	public void add(PubAttrCode attrCode) {
		pubAttrCodeMapper.insert(attrCode);
	}

	@Override
	public void modify(PubAttrCode attrCode) {
		pubAttrCodeMapper.updateByPrimaryKeySelective(attrCode);
	}
} 
 