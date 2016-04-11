package com.pinde.sci.biz.edc.impl;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.BeanUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcNormalValueBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.EdcNormalValueMapper;
import com.pinde.sci.dao.base.EdcProjOrgMapper;
import com.pinde.sci.dao.base.EdcProjParamMapper;
import com.pinde.sci.dao.base.PubFileMapper;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.model.mo.EdcNormalValue;
import com.pinde.sci.model.mo.EdcNormalValueExample;
import com.pinde.sci.model.mo.EdcProjOrg;
import com.pinde.sci.model.mo.EdcProjOrgExample;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubFileForm;


@Service
@Transactional(rollbackFor=Exception.class)
public class EdcNormalValuelBizImpl implements IEdcNormalValueBiz{
	@Resource
	private EdcNormalValueMapper normalValueMapper;
	@Resource
	private EdcProjOrgMapper edcProjOrgMapper;
	@Resource
	private PubFileMapper pubFileMapper;
	@Resource
	private EdcProjParamMapper projParamMapper;
	
	@Override
	public Map<String, List<EdcNormalValue>> getNormalValueMap(String projFlow,String orgFlow) {
		List<EdcNormalValue> list =  searchNormalValue(projFlow,orgFlow);
		Map<String,List<EdcNormalValue>> map = new HashMap<String, List<EdcNormalValue>>();
		for(EdcNormalValue nv : list){
			List<EdcNormalValue> temp  = map.get(nv.getElementCode());
			if(temp == null){
				temp = new ArrayList<EdcNormalValue>();
			}
			temp.add(nv);
			map.put(nv.getElementCode(), temp);
		}
		return map;
	}
	
	@Override
	public List<EdcNormalValue> searchNormalValue(String projFlow,String orgFlow) {
		EdcNormalValueExample example = new EdcNormalValueExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return normalValueMapper.selectByExample(example);
	}

	@Override
	public String addNormalValue(EdcNormalValue normalValue) {
		normalValue.setRecordFlow(PkUtil.getUUID());
		if(StringUtil.isNotBlank(normalValue.getSexId())){
			normalValue.setSexName(UserSexEnum.getNameById(normalValue.getSexId())); 
		}
		GeneralMethod.setRecordInfo(normalValue, true);
		 normalValueMapper.insert(normalValue);
		 return normalValue.getRecordFlow();
	}

	@Override
	public void modifyNormalValue(EdcNormalValue normalValue) {
		GeneralMethod.setRecordInfo(normalValue, false);
		normalValueMapper.updateByPrimaryKeySelective(normalValue);
	}

	@Override
	public EdcNormalValue readNormalValue(String recordFlow) {
		return normalValueMapper.selectByPrimaryKey(recordFlow);
	}

	@Override
	public void copyRecord(EdcNormalValue normalValue) {
		EdcNormalValue copyRecord = new EdcNormalValue();
		try {
			BeanUtil.copyProperties(copyRecord, normalValue);
			copyRecord.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(copyRecord, true);
			normalValueMapper.insert(copyRecord);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void delRecord(EdcNormalValue normalValue) {
		GeneralMethod.setRecordInfo(normalValue, false);
		normalValue.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		normalValueMapper.updateByPrimaryKeySelective(normalValue);
	}

	@Override
	public void lockNormalValue(String projFlow, String orgFlow) {
		EdcProjOrg projOrg =searchEdcProjOrg(projFlow,orgFlow);
		if(projOrg!=null){
			projOrg.setNormalValueLock(GlobalConstant.LOCK_STATUS_Y);
			GeneralMethod.setRecordInfo(projOrg, false);
			edcProjOrgMapper.updateByPrimaryKeySelective(projOrg);
		}else {
			projOrg =  addEdcProjOrg(projFlow,orgFlow);
			projOrg.setNormalValueLock(GlobalConstant.LOCK_STATUS_Y);
			GeneralMethod.setRecordInfo(projOrg, true);
			edcProjOrgMapper.insert(projOrg);
		}
	}
	@Override
	public EdcProjOrg searchEdcProjOrg(String projFlow, String orgFlow) {
		EdcProjOrgExample example = new EdcProjOrgExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcProjOrg> list =  edcProjOrgMapper.selectByExample(example);
		if(list.size()>0){
			return list.get(0);
		}
		return null;
	}

	@Override
	public void addNormalValueFile(String projFlow,String orgFlow,PubFileForm fileForm) {
		String fileName =  fileForm.getFile().getOriginalFilename();
		String suffix =fileName.substring(fileName.lastIndexOf(".")+1);  
		PubFile file  = new PubFile();
		file.setFileFlow(PkUtil.getUUID());
		file.setFileSuffix(suffix);
		file.setFileType(suffix);
		file.setFileSize(new BigDecimal(fileForm.getFile().getSize()));
		try {
			InputStream is = fileForm.getFile().getInputStream();
			  byte[] fileData = new byte[(int) fileForm.getFile().getSize()];  
			    is.read(fileData);  
			    file.setFileName(fileName);
			    file.setFileContent(fileData);
			    is.close();
		} catch (IOException e) {
			e.printStackTrace();
		}  
		GeneralMethod.setRecordInfo(file, true);
		pubFileMapper.insert(file);
		
		EdcProjOrg projOrg = searchEdcProjOrg(projFlow, orgFlow);
		if(projOrg == null){
			projOrg = addEdcProjOrg(projFlow,orgFlow);
			projOrg.setNormalValueFileFlow(file.getFileFlow());
			projOrg.setNormalValueFileName(fileName);
			GeneralMethod.setRecordInfo(projOrg, true);
			edcProjOrgMapper.insert(projOrg);
		}else {
			projOrg.setNormalValueFileFlow(file.getFileFlow());
			projOrg.setNormalValueFileName(fileName);
			GeneralMethod.setRecordInfo(projOrg, false);
			edcProjOrgMapper.updateByPrimaryKeySelective(projOrg);
		}
	}

	private EdcProjOrg addEdcProjOrg(String projFlow, String orgFlow) {
		EdcProjOrg projOrg =  new EdcProjOrg();
		projOrg.setRecordFlow(PkUtil.getUUID());
		projOrg.setProjFlow(projFlow);
		projOrg.setOrgFlow(orgFlow);
		return projOrg;
	}

	@Override
	public void unLockNormalValue(EdcProjOrg projOrg) {
		projOrg.setNormalValueLock(GlobalConstant.LOCK_STATUS_N);
		GeneralMethod.setRecordInfo(projOrg, false);
		edcProjOrgMapper.updateByPrimaryKeySelective(projOrg);
	}

	@Override
	public List<EdcNormalValue> searchEdcNormalValue(EdcNormalValueExample example) {
		return normalValueMapper.selectByExample(example);
	}

	@Override
	public EdcProjParam readProjParam(String projFlow) {
		return projParamMapper.selectByPrimaryKey(projFlow); 
	}

	@Override
	public void updateNormalValueFile(String projFlow, String orgFlow, PubFileForm fileForm) {
		String fileName =  fileForm.getFile().getOriginalFilename();
		String suffix = fileName.substring(fileName.lastIndexOf(".")+1); 
		String fileFlow = PkUtil.getUUID();
		PubFile file  = new PubFile();
		file.setFileFlow(fileFlow);
		file.setFileSuffix(suffix);
		file.setFileType(suffix);
		file.setFileSize(new BigDecimal(fileForm.getFile().getSize()));
		try {
			InputStream is = fileForm.getFile().getInputStream();
			  byte[] fileData = new byte[(int) fileForm.getFile().getSize()];  
			    is.read(fileData);  
			    file.setFileName(fileName);
			    file.setFileContent(fileData);
			    is.close();
		} catch (IOException e) {
			e.printStackTrace();
		}  
		GeneralMethod.setRecordInfo(file, true);
		pubFileMapper.insert(file);
		
		EdcProjOrg projOrg = searchEdcProjOrg(projFlow, orgFlow);
		String oldFileFlow = "";
		if(projOrg == null){
			projOrg = addEdcProjOrg(projFlow,orgFlow);
			projOrg.setNormalValueFileFlow(file.getFileFlow());
			projOrg.setNormalValueFileName(fileName);
			GeneralMethod.setRecordInfo(projOrg, true);
			edcProjOrgMapper.insert(projOrg);
		} else {
			oldFileFlow = projOrg.getNormalValueFileFlow();
			projOrg.setNormalValueFileFlow(file.getFileFlow());
			projOrg.setNormalValueFileName(fileName);
			GeneralMethod.setRecordInfo(projOrg, false);
			edcProjOrgMapper.updateByPrimaryKeySelective(projOrg);
		}
		//删除原正常值盖章文件（只修改recordStatus为"N"）
		PubFile oldFile  = pubFileMapper.selectByPrimaryKey(oldFileFlow);
		if (oldFile != null) {
			oldFile.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			pubFileMapper.updateByPrimaryKey(oldFile);
		}
	}
	
}  
 