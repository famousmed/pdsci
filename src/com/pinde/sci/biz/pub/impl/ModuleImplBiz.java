package com.pinde.sci.biz.pub.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IModuleBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.PubAttrCodeMapper;
import com.pinde.sci.dao.base.PubAttributeMapper;
import com.pinde.sci.dao.base.PubElementMapper;
import com.pinde.sci.dao.base.PubModuleMapper;
import com.pinde.sci.dao.edc.PubModuleExtMapper;
import com.pinde.sci.enums.edc.ModuleStyleEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.edc.PubModuleForm;
import com.pinde.sci.model.mo.PubAttrCode;
import com.pinde.sci.model.mo.PubAttrCodeExample;
import com.pinde.sci.model.mo.PubAttribute;
import com.pinde.sci.model.mo.PubAttributeExample;
import com.pinde.sci.model.mo.PubElement;
import com.pinde.sci.model.mo.PubElementExample;
import com.pinde.sci.model.mo.PubModule;
import com.pinde.sci.model.mo.PubModuleExample;


@Service
@Transactional(rollbackFor=Exception.class)
public class ModuleImplBiz implements IModuleBiz{

	@Resource
	private PubModuleMapper pubModuleMapper;
	@Resource
	private PubModuleExtMapper pubModuleExtMapper;
	@Resource
	private PubElementMapper pubElementMapper;
	@Resource
	private PubAttributeMapper pubAttrMapper;
	@Resource
	private PubAttrCodeMapper pubAttrCodeMapper;
	
	@Override
	public List<PubModule> searchModuleList(PubModuleExample example) {
		return pubModuleMapper.selectByExample(example);
	}

	@Override
	public PubModule readPubModule(String flow) {
		return pubModuleMapper.selectByPrimaryKey(flow);
	}

	@Override
	public PubModule readPubModuleByCode(String code) {
		PubModuleExample example = new PubModuleExample();
		 example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andModuleCodeEqualTo(code);
		List<PubModule> result =  searchModuleList(example);
		if(result!=null && result.size()>0){
			return result.get(0);
		}
		return null;
	}

	@Override
	public PubModuleForm getModuleForm(String moduleCode) {
		PubModuleForm moduleForm = new PubModuleForm();
		PubModule module = readPubModuleByCode(moduleCode);
		moduleForm.setModule(module);
		//Element
		PubElementExample example = new PubElementExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andModuleCodeEqualTo(moduleCode);
		List<PubElement> elements = pubElementMapper.selectByExample(example);
		Map<String,PubElement> elementMap = moduleForm.getElementMap();
		for(PubElement ele : elements){
			elementMap.put(ele.getElementCode(), ele);
		}
		moduleForm.setElements(elements);
		
		//Attribute
		PubAttributeExample	 attrExample = new PubAttributeExample();
		attrExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andModuleCodeEqualTo(moduleCode);
		List<PubAttribute> attrList = pubAttrMapper.selectByExample(attrExample);
		moduleForm.setAttrs(attrList);
		
		 Map<String,List<PubAttribute>> eleAttrMap = moduleForm.getEleAttrMap();
		 Map<String,PubAttribute> attrMap = moduleForm.getAttrMap();
		for(PubAttribute attr : attrList){
			List<PubAttribute> temp = eleAttrMap.get(attr.getElementCode());
			if(temp == null){
				temp = new ArrayList<PubAttribute>();
			}
			temp.add(attr);
			eleAttrMap.put(attr.getElementCode(), temp);
			attrMap.put(attr.getAttrCode(), attr);
		}
		moduleForm.setEleAttrMap(eleAttrMap);
		moduleForm.setAttrMap(attrMap);
		//AttrCode
		PubAttrCodeExample attrCodeExample = new PubAttrCodeExample();
		attrCodeExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andModuleCodeEqualTo(moduleCode);
		List<PubAttrCode> attrCodeList = pubAttrCodeMapper.selectByExample(attrCodeExample);
		moduleForm.setCodes(attrCodeList);
		 Map<String ,List<PubAttrCode>> attrCodeMap = moduleForm.getAttrCodeMap();
		 Map<String,PubAttrCode> codeMap = moduleForm.getCodeMap();
		for(PubAttrCode code : attrCodeList){
			List<PubAttrCode> temp = attrCodeMap.get(code.getAttrCode());
			if(temp == null){
				temp = new ArrayList<PubAttrCode>();
			}
			temp.add(code);
			attrCodeMap.put(code.getAttrCode(), temp);
			codeMap.put(code.getAttrCode()+"."+code.getCodeValue(), code);
		}
		return moduleForm;
	}

	@Override
	public List<PubModule> moduleSearch(String keyWord) {
		return pubModuleExtMapper.moduleSearch(keyWord) ;
	}

	@Override
	public int addPubModule(PubModule pm) {
		pm.setModuleFlow(PkUtil.getUUID());
		pm.setModuleCode(PkUtil.getUUID());
		pm.setModuleTypeName(DictTypeEnum.ModuleType.getDictNameById(pm.getModuleTypeId()));
		if (StringUtil.isNotBlank(pm.getModuleStyleId())) {
			pm.setModuleStyleName(ModuleStyleEnum.getNameById(pm.getModuleStyleId()));
		}
		GeneralMethod.setRecordInfo(pm, true);
		return this.pubModuleMapper.insert(pm);
	}

	public int updatePubModule(PubModule pm) {
		pm.setModuleTypeName(DictTypeEnum.ModuleType.getDictNameById(pm.getModuleTypeId()));
		if (StringUtil.isNotBlank(pm.getModuleStyleId())) {
			pm.setModuleStyleName(ModuleStyleEnum.getNameById(pm.getModuleStyleId()));
		}
		GeneralMethod.setRecordInfo(pm, false);
		return this.pubModuleMapper.updateByPrimaryKeySelective(pm);
	}

	@Override
	public List<PubModule> searchModuleListByDomain(String domain) {
		PubModuleExample example = new PubModuleExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andModuleTypeIdEqualTo(domain);
		example.setOrderByClause("ORDINAL");
		return searchModuleList(example);
	}
} 
 