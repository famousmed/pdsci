package com.pinde.sci.biz.jsres.impl;


import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.xml.bind.JAXBException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.JaxbUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.jsres.IJsResBaseBiz;
import com.pinde.sci.biz.jsres.IResOrgSpeBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.ResBaseMapper;
import com.pinde.sci.dao.base.ResOrgSpeMapper;
import com.pinde.sci.dao.jsres.ResBaseExtMapper;
import com.pinde.sci.enums.jsres.BaseStatusEnum;
import com.pinde.sci.form.jsres.BaseExtInfoForm;
import com.pinde.sci.form.jsres.BaseInfoForm;
import com.pinde.sci.model.jsres.ResBaseExt;
import com.pinde.sci.model.mo.ResBase;
import com.pinde.sci.model.mo.ResBaseExample;
import com.pinde.sci.model.mo.ResBaseExample.Criteria;
import com.pinde.sci.model.mo.ResOrgSpe;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
@Service
@Transactional(rollbackFor=Exception.class)
public class JsResBaseBizImpl implements IJsResBaseBiz{

	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private ResBaseMapper resBaseMapper;
	@Autowired
	private ResOrgSpeMapper resOrgSpeMapper;
	@Autowired
	private ResBaseExtMapper resBaseExtMapper;
	@Autowired
	private IResOrgSpeBiz resOrgSpeBiz;
	/**
	 * 保存基地的基本信息
	 * @throws IOException 
	 * @throws JAXBException 
	 */
	@Override
	public int saveBaseInfo(String flag, BaseInfoForm baseInfoForm, String index) throws Exception {
		SysOrg sysOrg = baseInfoForm.getSysOrg();
		if(sysOrg!=null){
			orgBiz.update(sysOrg);
		}
		ResBase resBase=readBase(sysOrg.getOrgFlow());
		String xml= null;
		BaseExtInfoForm baseExtInfo = null ;
		if(resBase != null){
			xml=resBase.getBaseInfo();
			baseExtInfo =JaxbUtil.converyToJavaBean(xml, BaseExtInfoForm.class);
		}else{
			resBase=baseInfoForm.getResBase();
			baseExtInfo=new BaseExtInfoForm();
		}
		if(GlobalConstant.TEACH_CONDITION.equals(flag)){
			baseExtInfo.setEducationInfo(baseInfoForm.getEducationInfo());
		}else  if (GlobalConstant.ORG_MANAGE.equals(flag)){
			baseExtInfo.setOrganizationManage(baseInfoForm.getOrganizationManage());
		}else if(GlobalConstant.SUPPORT_CONDITION.equals(flag)){
			baseExtInfo.setSupportCondition(baseInfoForm.getSupportCondition());
		}else if(GlobalConstant.BASIC_INFO.equals(flag)){
			baseExtInfo.setBasicInfo(baseInfoForm.getBasicInfo());
		}
		xml=JaxbUtil.convertToXml(baseExtInfo);
		resBase.setBaseInfo(xml);
		resBase.setBaseStatusId(BaseStatusEnum.NotSubmit.getId());
		resBase.setBaseStatusName(BaseStatusEnum.NotSubmit.getName());
		return saveResBase(resBase);
  	}
	
	@Override
	public ResBase readBase(String baseFlow) {
		ResBase resBase = null;
		if(StringUtil.isNotBlank(baseFlow)){
			resBase = resBaseMapper.selectByPrimaryKey(baseFlow);
		}
		return  resBase ;
	}
	
	@Override
	public int  saveTrainSpe(List<ResOrgSpe> saveList,String trainCategoryType,String baseFlow) {
		ResOrgSpe exitSpe=new ResOrgSpe();
		exitSpe.setOrgFlow(baseFlow);
		List<ResOrgSpe>exitSpeList = resOrgSpeBiz.searchResOrgSpeList(exitSpe, trainCategoryType);
		Map<String, ResOrgSpe> oldMap = new HashMap<String, ResOrgSpe>();
		List<ResOrgSpe> oldStatusYList = new ArrayList<ResOrgSpe>();
		List<ResOrgSpe> oldStatusNList = new ArrayList<ResOrgSpe>();
		if(exitSpeList != null && !exitSpeList.isEmpty()){
				for(ResOrgSpe  s: exitSpeList){
					if(GlobalConstant.RECORD_STATUS_Y.equals(s.getRecordStatus())){
						oldMap.put(s.getOrgSpeFlow(), s );
						oldStatusYList.add(s);
					}else{
						oldStatusNList.add(s);
					}
				}
		}
		if(saveList != null && !saveList.isEmpty()){
			for(ResOrgSpe s: saveList){
				boolean addFlag = true;
				if(oldStatusYList!= null && !oldStatusYList.isEmpty()){
					for(ResOrgSpe oldResOrgSpe: oldStatusYList){
						if(s.getSpeTypeId().equals(oldResOrgSpe.getSpeTypeId()) &&  s.getSpeId().equals(oldResOrgSpe.getSpeId()) && baseFlow.equals(oldResOrgSpe.getOrgFlow()) ){
							addFlag = false;
							if(oldMap.size()>0){
								oldMap.remove(oldResOrgSpe.getOrgSpeFlow());
							}
							break;
						}
					}
				}
				if(addFlag){
					ResOrgSpe ResOrgSpe = new ResOrgSpe();
					ResOrgSpe.setSpeId( s.getSpeId());
					ResOrgSpe.setSpeName( s.getSpeName());
					ResOrgSpe.setSpeTypeId(s.getSpeTypeId());
					ResOrgSpe.setSpeTypeName(s.getSpeTypeName());
					ResOrgSpe.setOrgFlow(baseFlow);
					if(oldStatusNList != null && !oldStatusNList.isEmpty()){
						for(ResOrgSpe N :oldStatusNList){
							if(s.getSpeTypeId().equals(N.getSpeTypeId()) &&  s.getSpeId().equals(N.getSpeId()) && baseFlow.equals(N.getOrgFlow()) ){
								addFlag = false;
								N.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
								resOrgSpeBiz.saveResOrgSpe(N);
								break;
							}
						}
						if(addFlag){//新增
							resOrgSpeBiz.saveResOrgSpe(ResOrgSpe);
						}
					}else{//新增
						resOrgSpeBiz.saveResOrgSpe(ResOrgSpe);
					}
				}
			}
		}
		//删除原先的
		if(oldMap.size()>0){
			for(Entry<String, ResOrgSpe> entry : oldMap.entrySet()){
				ResOrgSpe delBaseSpe = entry.getValue();
				delBaseSpe.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				resOrgSpeBiz.saveResOrgSpe(delBaseSpe);
			}
		}
		ResBase resBase=readBase(baseFlow);
		if (resBase!=null) {
			resBase.setBaseStatusId(BaseStatusEnum.NotSubmit.getId());
			resBase.setBaseStatusName(BaseStatusEnum.NotSubmit.getName());
			saveResBase(resBase);
		}
		return GlobalConstant.ONE_LINE;
	}
	@Override
	public List<ResBaseExt> searchResBaseExtList(Map<String, Object> paramMap) {
		return resBaseExtMapper.searchResBaseExtList(paramMap);
	}
	
	@Override
	public int saveResBase(ResBase resBase) {
		if(StringUtil.isNotBlank(resBase.getOrgFlow())){
			GeneralMethod.setRecordInfo(resBase, false);
			return resBaseMapper.updateByPrimaryKeySelective(resBase);
		}else{
			SysUser sysUser =GlobalContext.getCurrentUser();
			resBase.setOrgFlow(sysUser.getOrgFlow());
			GeneralMethod.setRecordInfo(resBase, true);
			return resBaseMapper.insert(resBase);
		}
	}

	@Override
	public List<ResBase> searchResBaseList(ResBase resBase) {
		ResBaseExample example=new ResBaseExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
		if (StringUtil.isNotBlank(resBase.getOrgFlow())) {
			criteria.andOrgFlowEqualTo(resBase.getOrgFlow());
		}
		if (StringUtil.isNotBlank(resBase.getBaseStatusId())) {
			criteria.andBaseStatusIdEqualTo(resBase.getBaseStatusId());
		}
		if (StringUtil.isNotBlank(resBase.getBaseStatusName())) {
			criteria.andBaseStatusNameEqualTo(resBase.getBaseStatusName());
		}
		return resBaseMapper.selectByExample(example);
	}
}
