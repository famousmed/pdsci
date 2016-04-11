package com.pinde.sci.biz.sch.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.sch.ISchArrangeResultBiz;
import com.pinde.sci.biz.sch.ISchDeptBiz;
import com.pinde.sci.biz.sch.ISchDeptRelBiz;
import com.pinde.sci.biz.sch.ISchDoctorDeptBiz;
import com.pinde.sci.biz.sch.ISchRotationBiz;
import com.pinde.sci.biz.sch.ISchRotationDeptBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.SchRotationDeptMapper;
import com.pinde.sci.dao.base.SchRotationDeptReqMapper;
import com.pinde.sci.dao.base.SchRotationGroupMapper;
import com.pinde.sci.dao.sch.SchRotationDeptExtMapper;
import com.pinde.sci.dao.sch.SchRotationDeptReqExtMapper;
import com.pinde.sci.enums.res.RegistryTypeEnum;
import com.pinde.sci.enums.sch.SchSelTypeEnum;
import com.pinde.sci.enums.sch.SchStageEnum;
import com.pinde.sci.form.sch.SchRotationDeptForm;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SchArrangeResult;
import com.pinde.sci.model.mo.SchDept;
import com.pinde.sci.model.mo.SchDeptRel;
import com.pinde.sci.model.mo.SchDoctorDept;
import com.pinde.sci.model.mo.SchRotation;
import com.pinde.sci.model.mo.SchRotationDept;
import com.pinde.sci.model.mo.SchRotationDeptExample;
import com.pinde.sci.model.mo.SchRotationDeptExample.Criteria;
import com.pinde.sci.model.mo.SchRotationDeptReq;
import com.pinde.sci.model.mo.SchRotationDeptReqExample;
import com.pinde.sci.model.mo.SchRotationGroup;
import com.pinde.sci.model.mo.SchRotationGroupExample;
import com.pinde.sci.model.mo.SysOrg;

@Service
@Transactional(rollbackFor=Exception.class)
public class SchRotationDeptBizImpl implements ISchRotationDeptBiz {
	@Autowired
	private SchRotationDeptMapper rotationDeptMapper;
	@Autowired
	private SchRotationGroupBizImpl rotationGroupBiz;
	@Autowired
	private SchRotationGroupMapper rotationGroupMapper;
	@Resource
	private ISchDeptBiz schDeptBiz;
	@Autowired
	private SchRotationDeptReqMapper deptReqMapper;
	@Autowired
	private SchRotationDeptReqExtMapper deptReqExtMapper;
	@Autowired
	private ISchDoctorDeptBiz doctorDeptBiz;
	@Autowired
	private IResDoctorBiz doctorBiz;
	@Resource
	private ISchArrangeResultBiz schArrangeResultBiz;
	@Resource
	private ISchRotationBiz rotationBiz;
	@Resource
	private ISchDeptRelBiz deptRelBiz;
	@Resource
	private SchRotationDeptExtMapper rotationDeptExtMapper;
	@Resource
	private IOrgBiz orgBiz;
	

	@Override
	public List<SchRotationDept> searchSchRotationDept() {
		SchRotationDeptExample example = new SchRotationDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		return rotationDeptMapper.selectByExample(example);
	}

	@Override
	public List<SchRotationDept> searchSchRotationDept(String rotationFlow) {
		SchRotationDeptExample example = new SchRotationDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRotationFlowEqualTo(rotationFlow)
		.andOrgFlowIsNull();
		example.setOrderByClause("ORDINAL");
		return rotationDeptMapper.selectByExample(example);
	}
	
	@Override
	public List<SchRotationDept> searchOrgSchRotationDept(String rotationFlow,String orgFlow) {
		SchRotationDeptExample example = new SchRotationDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRotationFlowEqualTo(rotationFlow)
		.andOrgFlowEqualTo(orgFlow);
		example.setOrderByClause("ORDINAL");
		return rotationDeptMapper.selectByExample(example);
	}
	
	@Override
	public List<SchRotationDept> searchSchRotationDeptGroup(String rotationFlow) {
		SchRotationDeptExample example = new SchRotationDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andIsRequiredEqualTo(GlobalConstant.FLAG_N)
		.andRotationFlowEqualTo(rotationFlow).andOrgFlowIsNull();
		example.setOrderByClause("ORDINAL");
		return rotationDeptMapper.selectByExample(example);
	}
	
	@Override
	public List<SchRotationDept> searchOrgSchRotationDeptGroup(String rotationFlow,String orgFlow) {
		SchRotationDeptExample example = new SchRotationDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andIsRequiredEqualTo(GlobalConstant.FLAG_N)
		.andRotationFlowEqualTo(rotationFlow).andOrgFlowEqualTo(orgFlow);
		example.setOrderByClause("ORDINAL");
		return rotationDeptMapper.selectByExample(example);
	}
	
	@Override
	public List<SchRotationDept> searchRotationDeptByFlows(List<String> recordFlows) {
		SchRotationDeptExample example = new SchRotationDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andRecordFlowIn(recordFlows);
		return rotationDeptMapper.selectByExample(example);
	}
	
	@Override
	public List<SchRotationDept> searchSchRotationDeptMust(String rotationFlow) {
		SchRotationDeptExample example = new SchRotationDeptExample();
		Criteria criteria = example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andIsRequiredEqualTo(GlobalConstant.FLAG_Y)
			.andRotationFlowEqualTo(rotationFlow).andOrgFlowIsNull();
		example.setOrderByClause("ORDINAL");
		return rotationDeptMapper.selectByExample(example);
	}
	
	@Override
	public List<SchRotationDept> searchSchRotationDeptMustWithBLOBs(String rotationFlow) {
		SchRotationDeptExample example = new SchRotationDeptExample();
		Criteria criteria = example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andIsRequiredEqualTo(GlobalConstant.FLAG_Y)
		.andRotationFlowEqualTo(rotationFlow).andOrgFlowIsNull();
		example.setOrderByClause("ORDINAL");
		return rotationDeptMapper.selectByExampleWithBLOBs(example);
	}
	
	@Override
	public List<SchRotationDept> searchOrgSchRotationDeptMust(String rotationFlow,String orgFlow) {
		SchRotationDeptExample example = new SchRotationDeptExample();
		Criteria criteria = example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andIsRequiredEqualTo(GlobalConstant.FLAG_Y)
		.andRotationFlowEqualTo(rotationFlow).andOrgFlowEqualTo(orgFlow);
		example.setOrderByClause("ORDINAL");
		return rotationDeptMapper.selectByExample(example);
	}
	
	@Override
	public List<SchRotationDept> searchRotationDeptByRecordFlows(List<String> recordFlows) {
		SchRotationDeptExample example = new SchRotationDeptExample();
		Criteria criteria = example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecordFlowIn(recordFlows);
		example.setOrderByClause("ORDINAL");
		return rotationDeptMapper.selectByExample(example);
	}
	
	@Override
	public SchRotationDept readSchRotationDept(String recordFlow) {
		return rotationDeptMapper.selectByPrimaryKey(recordFlow);
	}
	
	@Override
	public List<SchRotationDept> searchDeptByStandard(String rotationFlow,String groupFlow,String standardDeptId,String orgFlow){
		SchRotationDeptExample example = new SchRotationDeptExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
				.andStandardDeptIdEqualTo(standardDeptId)
				.andOrgFlowEqualTo(orgFlow);
		if(StringUtil.isNotBlank(rotationFlow)){
			criteria.andRotationFlowEqualTo(rotationFlow);
		}
		if(StringUtil.isNotBlank(groupFlow)){
			criteria.andGroupFlowEqualTo(groupFlow);
		}else{
			criteria.andIsRequiredEqualTo(GlobalConstant.FLAG_Y);
		}
		return rotationDeptMapper.selectByExample(example);
	}
	
	@Override
	public SchRotationDept readSchRotationDept(String schDeptFlow,String rotationFlow){
		SchRotationDept rotationDept = null;
		SchRotationDeptExample example = new SchRotationDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andSchDeptFlowEqualTo(schDeptFlow).andRotationFlowEqualTo(rotationFlow);
		List<SchRotationDept> rotationDeptList = rotationDeptMapper.selectByExampleWithBLOBs(example);
		if(rotationDeptList!=null && rotationDeptList.size()>0){
			rotationDept = rotationDeptList.get(0);
		}
		return rotationDept;
	}

	@Override
	public int saveSchRotationDept(SchRotationDept rotationDept) {
		if(rotationDept != null){
			if(StringUtil.isNotBlank(rotationDept.getRecordFlow())){
				GeneralMethod.setRecordInfo(rotationDept, false);
				return rotationDeptMapper.updateByPrimaryKeySelective(rotationDept);
			}else{
				rotationDept.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(rotationDept, true);
				return rotationDeptMapper.insertSelective(rotationDept);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int saveRotationDeptOrd(String[] recordFlows){
		if(recordFlows != null && recordFlows.length>0){
			int i = 0 ;
			SchRotationDept rotationDept = new SchRotationDept();
			for(String recordFlow : recordFlows){
				if(StringUtil.isNotBlank(recordFlow)){
					rotationDept.setRecordFlow(recordFlow);
					rotationDept.setOrdinal(i++);
					saveSchRotationDept(rotationDept);
				}
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int saveSchRotationDeptForm(SchRotationDeptForm rotationDeptForm,String rotationFlow){
		//如果方案已发布则重置所用培训机构关联信息
		//delRelRotationDept(rotationFlow);
		
		return saveSchRotationDeptForm(rotationDeptForm);
	}
	
	private void delRelRotationDept(String rotationFlow){
		if(StringUtil.isNotBlank(rotationFlow)){
			SchRotation rotation = rotationBiz.readSchRotation(rotationFlow);
			if(GlobalConstant.FLAG_Y.equals(rotation.getPublishFlag())){
				SchRotationDept rotationDept = new SchRotationDept();
				rotationDept.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				SchRotationDeptExample example = new SchRotationDeptExample();
				example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
				.andOrgFlowIsNotNull().andRotationFlowEqualTo(rotationFlow);
				rotationDeptMapper.updateByExampleSelective(rotationDept,example);
				
				SchRotationGroup group = new SchRotationGroup();
				group.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				SchRotationGroupExample gExample = new SchRotationGroupExample();
				gExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
				.andOrgFlowIsNotNull().andRotationFlowEqualTo(rotationFlow);
				rotationGroupMapper.updateByExampleSelective(group,gExample);
			}
		}
	}
	
	@Override
	public int saveSchRotationDeptForm(SchRotationDeptForm rotationDeptForm){
		//String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		//String orgName = GlobalContext.getCurrentUser().getOrgName();
		List<SchRotationDept> rotationDeptList = rotationDeptForm.getRotationDeptList();
		List<String> recordFlows = new ArrayList<String>();
		for(SchRotationDept rotationDept : rotationDeptList){
			if(StringUtil.isNotBlank(rotationDept.getRecordFlow())){
				recordFlows.add(rotationDept.getRecordFlow());
			}
		}
		
		SchRotationGroup rotationGroup = rotationDeptForm.getRotationGroup();
		if(StringUtil.isNotBlank(rotationGroup.getSchStageId())){
			rotationGroup.setSchStageName(SchStageEnum.getNameById(rotationGroup.getSchStageId()));
		}
		
		String rotationFlow = rotationGroup.getRotationFlow();
		
		List<String> isUpdateOrgFlows = rotationDeptExtMapper.isUpdateOrg(rotationFlow);
		
		List<SchRotationDept> rotationDeptDbList = null;
		int result = GlobalConstant.ZERO_LINE;
		if(StringUtil.isNotBlank(rotationGroup.getGroupFlow())){
			result = rotationGroupBiz.update(rotationGroup);
			
			SchRotationGroup tempGroup = new SchRotationGroup();
			tempGroup.setGroupName(rotationGroup.getGroupName());
			tempGroup.setSchMonth(rotationGroup.getSchMonth());
			tempGroup.setIsRequired(rotationGroup.getIsRequired());
			tempGroup.setSchStageId(rotationGroup.getSchStageId());
			tempGroup.setSchStageName(rotationGroup.getSchStageName());
			tempGroup.setOrdinal(rotationGroup.getOrdinal());
			if(SchSelTypeEnum.Free.getId().equals(rotationGroup.getSelTypeId())){
				tempGroup.setDeptNum(rotationGroup.getDeptNum());
			}
			SchRotationGroupExample groupExample = new SchRotationGroupExample();
			groupExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
			.andStandardGroupFlowEqualTo(rotationGroup.getGroupFlow());
			rotationGroupMapper.updateByExampleSelective(tempGroup,groupExample);
		}else{
			//rotationGroup.setGroupFlow(PkUtil.getUUID());
			//rotationGroup.setOrgFlow(orgFlow);
			//rotationGroup.setOrgName(orgName);
			result = rotationGroupBiz.save(rotationGroup);
			
			if(isUpdateOrgFlows!=null && isUpdateOrgFlows.size()>0){
				SchRotationGroup group = new SchRotationGroup();
				for(String orgFlow : isUpdateOrgFlows){
					SysOrg org = orgBiz.readSysOrg(orgFlow);
					
					group.setRotationFlow(rotationFlow);
					group.setGroupName(rotationGroup.getGroupName());
					group.setDeptNum(rotationGroup.getDeptNum());
					group.setSchMonth(rotationGroup.getSchMonth());
					group.setGroupNote(rotationGroup.getGroupNote());
					group.setSelTypeId(rotationGroup.getSelTypeId());
					group.setSelTypeName(rotationGroup.getSelTypeName());
					group.setMaxDeptNum(rotationGroup.getMaxDeptNum());
					group.setOrdinal(rotationGroup.getOrdinal());
					group.setIsRequired(rotationGroup.getIsRequired());
					group.setSchStageId(rotationGroup.getSchStageId());
					group.setSchStageName(rotationGroup.getSchStageName());
					group.setStandardGroupFlow(rotationGroup.getGroupFlow());
					group.setOrgFlow(orgFlow);
					group.setOrgName(org.getOrgName());
					rotationGroupBiz.save(group);
				}
			}
		}
		if(result == GlobalConstant.ZERO_LINE){
			return  GlobalConstant.ZERO_LINE;
		}
		rotationDeptDbList = rotationGroupBiz.readSchRotationDept(rotationGroup.getGroupFlow());
		
		 
		if(rotationDeptDbList != null && rotationDeptDbList.size()>0){
			for(SchRotationDept rotationDeptDb : rotationDeptDbList){
				if(!recordFlows.contains(rotationDeptDb.getRecordFlow())){
					rotationDeptDb.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
					saveSchRotationDept(rotationDeptDb);
					delOrgGroupOrRotationDept(rotationDeptDb.getRecordFlow(),null);
				}
			}
		}
		
		for(SchRotationDept rotationDept : rotationDeptList){
			//rotationDept.setOrgFlow(orgFlow);
			//rotationDept.setOrgName(orgName);
			rotationDept.setGroupFlow(rotationGroup.getGroupFlow());
			rotationDept.setRecordStatus(rotationGroup.getRecordStatus());
			if(StringUtil.isNotBlank(rotationDept.getSchDeptFlow())){
				SchDept schDept = schDeptBiz.readSchDept(rotationDept.getSchDeptFlow());
				if(schDept != null){
					rotationDept.setDeptFlow(schDept.getDeptFlow());
					rotationDept.setDeptName(schDept.getDeptName());
				}else{
					return GlobalConstant.ZERO_LINE; 
				}
			}
			
			rotationDept.setSchMonth(StringUtil.defaultIfEmpty(rotationDept.getSchMonth(),"0"));
			
			boolean isBlank = !StringUtil.isNotBlank(rotationDept.getRecordFlow());
			
			saveSchRotationDept(rotationDept);
			
			if(isBlank){
				if(isUpdateOrgFlows!=null && isUpdateOrgFlows.size()>0){
					for(String orgFlow : isUpdateOrgFlows){
						SysOrg org = orgBiz.readSysOrg(orgFlow);
						List<SchDeptRel> deptRelList = deptRelBiz.searchRelByStandard(orgFlow,rotationDept.getStandardDeptId());
						SchRotationGroup group = rotationGroupBiz.readGroupByStandard(orgFlow,rotationDept.getGroupFlow());
						
						SchRotationDept rotationDeptOrg = new SchRotationDept();
						rotationDeptOrg.setOrgFlow(org.getOrgFlow());
						rotationDeptOrg.setOrgName(org.getOrgName());
						rotationDeptOrg.setSchMonth(rotationDept.getSchMonth());
						rotationDeptOrg.setIsRequired(rotationDept.getIsRequired());
						rotationDeptOrg.setDeptNote(rotationDept.getDeptNote());
						rotationDeptOrg.setOrdinal(rotationDept.getOrdinal());
						rotationDeptOrg.setStandardDeptId(rotationDept.getStandardDeptId());
						rotationDeptOrg.setStandardDeptName(rotationDept.getStandardDeptName());
						rotationDeptOrg.setGroupFlow(group.getGroupFlow());
						rotationDeptOrg.setRotationFlow(rotationFlow);
						
						if(deptRelList!=null && deptRelList.size()>0){
							if(group!=null && GlobalConstant.FLAG_N.equals(group.getIsRequired())){
								if(SchSelTypeEnum.Free.getId().equals(group.getSelTypeId())){
									Integer standardMax = rotationGroup.getMaxDeptNum();
									standardMax+=(deptRelList.size()-1);
									group.setMaxDeptNum(standardMax);
								}else{
									Integer standardMax = rotationGroup.getDeptNum();
									standardMax+=(deptRelList.size()-1);
									group.setDeptNum(standardMax);
								}
								rotationGroupBiz.update(group);
							}
							
							boolean first = true;
							for(SchDeptRel deptRel : deptRelList){
								rotationDeptOrg.setRecordFlow(null);
								rotationDeptOrg.setSchDeptFlow(deptRel.getSchDeptFlow());
								rotationDeptOrg.setSchDeptName(deptRel.getSchDeptName());
								SchDept dept = schDeptBiz.readSchDept(deptRel.getSchDeptFlow());
								if(dept!=null){
									rotationDeptOrg.setDeptFlow(dept.getDeptFlow());
									rotationDeptOrg.setDeptName(dept.getDeptName());
								}
								
								if(!first){
									rotationDeptOrg.setSchMonth("0");
								}
								
								saveSchRotationDept(rotationDeptOrg);
								
								first = false;
							}
						}else{
							rotationDeptOrg.setRecordFlow(null);
							saveSchRotationDept(rotationDeptOrg);
						}
					}
				}
			}
		}
		return GlobalConstant.ONE_LINE;
	}
	
	@Override
	public int delSchRotationDeptForm(SchRotationDeptForm rotationDeptForm){
		SchRotationGroup group = rotationDeptForm.getRotationGroup();
		rotationGroupBiz.update(group);
		
		List<SchRotationDept> rotationDeptList = rotationDeptForm.getRotationDeptList();
		if(rotationDeptList!=null && rotationDeptList.size()>0){
			for(SchRotationDept rotationDept : rotationDeptList){
				saveSchRotationDept(rotationDept);
			}
		}
		List<String> recordFlows = new ArrayList<String>();
		for(SchRotationDept rotationDept : rotationDeptList){
			if(StringUtil.isNotBlank(rotationDept.getRecordFlow())){
				rotationDept.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				recordFlows.add(rotationDept.getRecordFlow());
			}
		}
		return GlobalConstant.ONE_LINE;
	}
	
	@Override
	public int saveSelDepts(List<String> recordFlows,Map<String,String> schMonthMap,ResDoctor doctor){
		if(recordFlows!=null && recordFlows.size()>0){
			List<SchRotationDept> rotationDeptList = searchRotationDeptByFlows(recordFlows);
			if(rotationDeptList!=null && rotationDeptList.size()>0){
				
				SchDoctorDept doctorDept = new SchDoctorDept();
				doctorDept.setDoctorFlow(doctor.getDoctorFlow());
				doctorDept.setDoctorName(doctor.getDoctorName());
				doctorDept.setOrgFlow(doctor.getOrgFlow());
				doctorDept.setOrgName(doctor.getOrgName());
				doctorDept.setRotationFlow(doctor.getRotationFlow());
				doctorDept.setRotationName(doctor.getRotationName());
				doctorDept.setSessionNumber(doctor.getSessionNumber());
				
				for(SchRotationDept rotationDept : rotationDeptList){
					doctorDept.setRecordFlow(null);
					doctorDept.setGroupFlow(rotationDept.getGroupFlow());
					doctorDept.setSchMonth(schMonthMap.get(rotationDept.getRecordFlow()));
					doctorDept.setSchDeptFlow(rotationDept.getSchDeptFlow());
					doctorDept.setSchDeptName(rotationDept.getSchDeptName());
					doctorDept.setDeptFlow(rotationDept.getDeptFlow());
					doctorDept.setDeptName(rotationDept.getDeptName());
					doctorDept.setStandardDeptId(rotationDept.getStandardDeptId());
					doctorDept.setStandardDeptName(rotationDept.getStandardDeptName());
					doctorDept.setIsRequired(rotationDept.getIsRequired());
					doctorDept.setOrdinal(rotationDept.getOrdinal());
					doctorDeptBiz.editDoctorDept(doctorDept);
				}
				
				doctor.setSelDeptFlag(GlobalConstant.FLAG_Y);
				doctorBiz.editDoctor(doctor);
				return GlobalConstant.ONE_LINE;
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int saveSelDeptsAndResult(List<String> recordFlows,Map<String,String> schMonthMap,ResDoctor doctor){
		saveSelDepts(recordFlows,schMonthMap,doctor);
		return schArrangeResultBiz.saveResultByDoctor(doctor);
	}
	
	@Override
	public List<SchRotationDept> searchDeptByRotations(List<String> rotationFlows){
		SchRotationDeptExample example = new SchRotationDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andRotationFlowIn(rotationFlows)
		.andOrgFlowIsNull();
		example.setOrderByClause("ORDINAL");
		return rotationDeptMapper.selectByExample(example);
	}
	
	@Override
	public List<SchRotationDept> searchSelDeptByRotations(List<String> rotationFlows){
		SchRotationDeptExample example = new SchRotationDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRotationFlowIn(rotationFlows)
		.andIsRequiredEqualTo(GlobalConstant.FLAG_N).andOrgFlowIsNull();
		return rotationDeptMapper.selectByExample(example);
	}
	
	@Override
	public List<SchRotationDept> searchOrgSelDeptByRotations(List<String> rotationFlows,String orgFlow){
		SchRotationDeptExample example = new SchRotationDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRotationFlowIn(rotationFlows)
		.andIsRequiredEqualTo(GlobalConstant.FLAG_N).andOrgFlowEqualTo(orgFlow);
		return rotationDeptMapper.selectByExample(example);
	}
	
	@Override
	public int saveRotationDeptList(List<SchRotationDept> rotationDeptList,SchRotationGroup group){
		for(SchRotationDept rotationDept : rotationDeptList){
			saveSchRotationDept(rotationDept);
		}
		if(group!=null){
			rotationGroupBiz.saveSchRotationGroup(group);
		}
		return GlobalConstant.ONE_LINE;
	}
	
	@Override
	public SchRotationDept readStandardRotationDeptByLocal(String rotationFlow,String groupFlow,String standardDeptId){
		SchRotationDeptExample example = new SchRotationDeptExample();
		com.pinde.sci.model.mo.SchRotationDeptExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
				.andOrgFlowIsNull();
		if(StringUtil.isNotBlank(groupFlow)){
			SchRotationGroup group = rotationGroupBiz.readSchRotationGroup(groupFlow);
			if(group!=null){
				groupFlow = group.getStandardGroupFlow();
			}
			criteria.andGroupFlowEqualTo(groupFlow).andStandardDeptIdEqualTo(standardDeptId);
		}else{
			criteria.andIsRequiredEqualTo(GlobalConstant.FLAG_Y).andRotationFlowEqualTo(rotationFlow).andStandardDeptIdEqualTo(standardDeptId);
		}
		List<SchRotationDept> rotationDeptList = rotationDeptMapper.selectByExample(example);
		SchRotationDept rotationDept = null;
		if(rotationDeptList!=null && rotationDeptList.size()>0){
			rotationDept = rotationDeptList.get(0);
		}
		return rotationDept;
	}
	
	@Override
	public List<SchRotationDept> searchRotationDeptByGroupFlow(String groupFlow){
		SchRotationDeptExample example = new SchRotationDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andGroupFlowEqualTo(groupFlow);
		return rotationDeptMapper.selectByExample(example);
	}
	
	@Override
	public List<SchRotationDept> searchRotationDeptByGroupFlowWithBLOBs(String groupFlow){
		SchRotationDeptExample example = new SchRotationDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andGroupFlowEqualTo(groupFlow);
		return rotationDeptMapper.selectByExampleWithBLOBs(example);
	}
	
	/**
	 * 更新指定区域规则
	 */
	@Override
	public int updateAreaRule(String rotationFlow,String standardDeptId,String groupFlow,SysOrg org){
		String oldRotationFlow = rotationFlow;
		String oldGroupFlow = groupFlow;
		//删除原区域数据
		SchRotationDept rotationDept = new SchRotationDept();
		rotationDept.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		SchRotationDeptExample example = new SchRotationDeptExample();
		com.pinde.sci.model.mo.SchRotationDeptExample.Criteria criteria = example.createCriteria()
				.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
				.andOrgFlowEqualTo(org.getOrgFlow());
		if(StringUtil.isNotBlank(groupFlow)){
			criteria.andGroupFlowEqualTo(groupFlow).andStandardDeptIdEqualTo(standardDeptId);
		}else{
			criteria.andIsRequiredEqualTo(GlobalConstant.FLAG_Y).andRotationFlowEqualTo(rotationFlow).andStandardDeptIdEqualTo(standardDeptId);
		}
		int oldDeptNum = rotationDeptMapper.updateByExampleSelective(rotationDept,example);
		
		//找到原区域标准数据
		example.clear();
		criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
				.andOrgFlowIsNull();
		SchRotationGroup group = null;
		if(StringUtil.isNotBlank(groupFlow)){
			group = rotationGroupBiz.readSchRotationGroup(groupFlow);
			if(group!=null){
				groupFlow = group.getStandardGroupFlow();
			}
			criteria.andGroupFlowEqualTo(groupFlow).andStandardDeptIdEqualTo(standardDeptId);
		}else{
			criteria.andIsRequiredEqualTo(GlobalConstant.FLAG_Y).andRotationFlowEqualTo(rotationFlow).andStandardDeptIdEqualTo(standardDeptId);
		}
		List<SchRotationDept> standardRotationDept = rotationDeptMapper.selectByExample(example);
		if(standardRotationDept!=null && standardRotationDept.size()>0){
			rotationDept = standardRotationDept.get(0);
			if(rotationDept!=null && org!=null){
				List<SchDeptRel> deptRelList = deptRelBiz.searchRelByStandard(org.getOrgFlow(),standardDeptId);
				if(deptRelList!=null && deptRelList.size()>0){
					if(group!=null && GlobalConstant.FLAG_N.equals(group.getIsRequired())){
						int newDeptNum = deptRelList.size();
						if(SchSelTypeEnum.Free.getId().equals(group.getSelTypeId())){
							int currNum = group.getMaxDeptNum();
							group.setMaxDeptNum(currNum+(newDeptNum-oldDeptNum));
						}else{
							int currNum = group.getDeptNum();
							group.setDeptNum(currNum+(newDeptNum-oldDeptNum));
						}
						rotationGroupBiz.update(group);
					}
					
					rotationDept.setOrgFlow(org.getOrgFlow());
					rotationDept.setOrgName(org.getOrgName());
					rotationDept.setGroupFlow(oldGroupFlow);
					rotationDept.setRotationFlow(oldRotationFlow);
					
					boolean first = true;
					for(SchDeptRel deptRel : deptRelList){
						rotationDept.setRecordFlow(null);
						rotationDept.setSchDeptFlow(deptRel.getSchDeptFlow());
						rotationDept.setSchDeptName(deptRel.getSchDeptName());
						SchDept dept = schDeptBiz.readSchDept(deptRel.getSchDeptFlow());
						if(dept!=null){
							rotationDept.setDeptFlow(dept.getDeptFlow());
							rotationDept.setDeptName(dept.getDeptName());
						}
						
						if(!first){
							rotationDept.setSchMonth("0");
						}
						
						saveSchRotationDept(rotationDept);
						
						first = false;
					}
				}
			}
		}
		
		return GlobalConstant.ONE_LINE;
	}
	/*******************************************************要求*****************************************************/
	
	@Override
	public List<SchRotationDeptReq> searchDeptReq(String rotationFlow,String schDeptFlow,String recTypeId){
		if(StringUtil.isNotBlank(rotationFlow) && StringUtil.isNotBlank(schDeptFlow) && StringUtil.isNotBlank(recTypeId)){
			SchRotationDeptReqExample example = new SchRotationDeptReqExample();
			example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRotationFlowEqualTo(rotationFlow)
			.andRecTypeIdEqualTo(recTypeId)
			.andStandardDeptIdEqualTo(schDeptFlow);
			return deptReqMapper.selectByExample(example);
		}
		return null;
	}
	
	@Override
	public List<SchRotationDeptReq> searchDeptReqByRel(String relRecordFlow,String recTypeId){
		SchRotationDeptReqExample example = new SchRotationDeptReqExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andRecTypeIdEqualTo(recTypeId)
		.andRelRecordFlowEqualTo(relRecordFlow);
		example.setOrderByClause("CREATE_TIME DESC");
		return deptReqMapper.selectByExample(example);
	}
	
	@Override
	public int defaultOtherItem(String relRecordFlow,String recTypeId){
		if(StringUtil.isNotBlank(relRecordFlow) && StringUtil.isNotBlank(recTypeId)){
			RegistryTypeEnum regType = null;
			for(RegistryTypeEnum rte : RegistryTypeEnum.values()){
				if(rte.getId().equals(recTypeId)){
					regType = rte;
					break;
				}
			}
			if(regType!=null && regType.getHaveItem().equals(GlobalConstant.FLAG_Y)){
				List<SchRotationDeptReq> reqList = searchDeptReqByRel(relRecordFlow,recTypeId,GlobalConstant.RES_REQ_OTHER_ITEM_ID);
				if(reqList==null || reqList.size()<=0){
					SchRotationDept rotationDept = readSchRotationDept(relRecordFlow);
					if(rotationDept!=null){
						SchRotationDeptReq req = new SchRotationDeptReq();
						req.setRotationFlow(rotationDept.getRotationFlow());
						req.setStandardDeptId(rotationDept.getStandardDeptId());
						req.setStandardDeptName(rotationDept.getStandardDeptName());
						req.setRelRecordFlow(relRecordFlow);
						req.setRecTypeId(regType.getId());
						req.setRecTypeName(regType.getName());
						req.setItemId(GlobalConstant.RES_REQ_OTHER_ITEM_ID);
						req.setItemName(GlobalConstant.RES_REQ_OTHER_ITEM_NAME);
						req.setOrgFlow(rotationDept.getOrgFlow());
						req.setOrgName(rotationDept.getOrgName());
						req.setReqNum(BigDecimal.ZERO);
						return editDeptReq(req);
					}
				}
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public List<SchRotationDeptReq> searchDeptReqByRel(String relRecordFlow){
		SchRotationDeptReqExample example = new SchRotationDeptReqExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andRelRecordFlowEqualTo(relRecordFlow);
		return deptReqMapper.selectByExample(example);
	}
	
	@Override
	public List<SchRotationDeptReq> searchDeptReqByRel(String relRecordFlow,String recTypeId,String itemId){
		SchRotationDeptReqExample example = new SchRotationDeptReqExample();
		com.pinde.sci.model.mo.SchRotationDeptReqExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andRelRecordFlowEqualTo(relRecordFlow);
		if(StringUtil.isNotBlank(recTypeId)){
			criteria.andRecTypeIdEqualTo(recTypeId);
		}
		if(StringUtil.isNotBlank(itemId)){
			criteria.andItemIdEqualTo(itemId);
		}
		example.setOrderByClause("CREATE_TIME DESC");
		return deptReqMapper.selectByExample(example);
	}
	
	@Override
	public List<SchRotationDeptReq> searchDeptReq(String rotationFlow,String schDeptFlow){
		if(StringUtil.isNotBlank(rotationFlow) && StringUtil.isNotBlank(schDeptFlow)){
			SchRotationDeptReqExample example = new SchRotationDeptReqExample();
			example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRotationFlowEqualTo(rotationFlow)
			.andStandardDeptIdEqualTo(schDeptFlow);
			return deptReqMapper.selectByExample(example);
		}
		return null;
	}
	
	@Override
	public List<SchRotationDeptReq> searchDeptReqByItemId(String rotationFlow,String schDeptFlow,String itemId){
		SchRotationDeptReqExample example = new SchRotationDeptReqExample();
		com.pinde.sci.model.mo.SchRotationDeptReqExample.Criteria criteria = example.createCriteria()
				.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRotationFlowEqualTo(rotationFlow)
				.andStandardDeptIdEqualTo(schDeptFlow);
		if(StringUtil.isNotBlank(itemId)){
			criteria.andItemIdEqualTo(itemId);
		}
		example.setOrderByClause("CREATE_TIME DESC");
		return deptReqMapper.selectByExample(example);
	}
	
	@Override
	public SchRotationDeptReq readDeptReq(String reqFlow){
		return deptReqMapper.selectByPrimaryKey(reqFlow);
	}
	
	@Override
	public int editDeptReq(SchRotationDeptReq deptReq){
		if(deptReq!=null){
			if(StringUtil.isNotBlank(deptReq.getReqFlow())){
				GeneralMethod.setRecordInfo(deptReq, false);
				return deptReqMapper.updateByPrimaryKeySelective(deptReq);
			}else{
				deptReq.setReqFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(deptReq, true);
				return deptReqMapper.insertSelective(deptReq);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public List<SchRotationDeptReq> searchReqByRotationAndSchDept(List<String> rotationFlows,List<String> schDeptFlows,String recTypeId,String itemName){
		return deptReqExtMapper.searchReqByRotationAndSchDept(rotationFlows, schDeptFlows, recTypeId, itemName);
	}
	
	@Override
	public List<Map<String,Object>> countReqWithSchDept(List<String> rotationFlows,List<String> standardDeptIds){
		return deptReqExtMapper.countReqWithSchDept(rotationFlows,standardDeptIds);
	}
	
	@Override
	public List<SchRotationDeptReq> searchStandardReqByMust(String rotationFlow,String standardDeptId){
		SchRotationDeptExample rotationDeptExample = new SchRotationDeptExample();
		rotationDeptExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andIsRequiredEqualTo(GlobalConstant.FLAG_Y)
		.andRotationFlowEqualTo(rotationFlow)
		.andStandardDeptIdEqualTo(standardDeptId)
		.andOrgFlowIsNull();
		List<SchRotationDept> rotationDeptList = rotationDeptMapper.selectByExample(rotationDeptExample);
		
		List<SchRotationDeptReq> reqList = null;
		if(rotationDeptList!=null && rotationDeptList.size()>0){
			String relRecordFlow = rotationDeptList.get(0).getRecordFlow();
			reqList = searchDeptReqByRel(relRecordFlow);
		}
		return reqList;
	}
	
	@Override
	public List<SchRotationDeptReq> searchStandardReqByGroup(String standardGroupFlow,String standardDeptId){
		SchRotationDeptExample rotationDeptExample = new SchRotationDeptExample();
		rotationDeptExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andGroupFlowEqualTo(standardGroupFlow)
		.andStandardDeptIdEqualTo(standardDeptId)
		.andOrgFlowIsNull();
		List<SchRotationDept> rotationDeptList = rotationDeptMapper.selectByExample(rotationDeptExample);
		
		List<SchRotationDeptReq> reqList = null;
		if(rotationDeptList!=null && rotationDeptList.size()>0){
			String relRecordFlow = rotationDeptList.get(0).getRecordFlow();
			reqList = searchDeptReqByRel(relRecordFlow);
		}
		return reqList;
	}
	
	@Override
	public List<SchRotationDeptReq> searchStandardReqByStandard(
			String standardGroupFlow,
			String standardDeptId,
			String recTypeId,
			String itemId
			){
		List<SchRotationDeptReq> reqList = null;
		if(StringUtil.isNotBlank(standardDeptId)){
			SchRotationDeptExample rotationDeptExample = new SchRotationDeptExample();
			Criteria criteria = rotationDeptExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
					.andStandardDeptIdEqualTo(standardDeptId).andOrgFlowIsNull().andGroupFlowEqualTo(standardGroupFlow);
			List<SchRotationDept> rotationDeptList = rotationDeptMapper.selectByExample(rotationDeptExample);
			
			if(rotationDeptList!=null && rotationDeptList.size()>0){
				String relRecordFlow = rotationDeptList.get(0).getRecordFlow();
				reqList = searchDeptReqByRel(relRecordFlow,recTypeId,itemId);
			}
		}
		
		return reqList;
	}
	
	
	
	@Override
	public List<SchRotationDeptReq> searchStandardReqByResult(SchArrangeResult result){
		List<SchRotationDeptReq> reqList = null;
		if(result!=null){
			SchRotationGroup group = rotationGroupBiz.readSchRotationGroup(result.getGroupFlow());
			if(group!=null){
				reqList = searchStandardReqByGroup(group.getStandardGroupFlow(),result.getStandardDeptId());
			}
		}
		return reqList;
	}
	
	@Override
	public List<SchRotationDeptReq> searchStandardReqByResult(SchArrangeResult result,String recTypeId){
		List<SchRotationDeptReq> reqList = null;
		if(result!=null){
			String standardGroupFlow = null;
			if(StringUtil.isNotBlank(result.getGroupFlow())){
				SchRotationGroup group = rotationGroupBiz.readSchRotationGroup(result.getGroupFlow());
				standardGroupFlow = group.getStandardGroupFlow();
			}
			reqList = searchStandardReqByStandard(standardGroupFlow,result.getStandardDeptId(),recTypeId,null);
		}
		return reqList;
	}
	
	@Override
	public List<SchRotationDeptReq> searchStandardReqByRelFlows(List<String> relRecordFlows){
		SchRotationDeptReqExample example = new SchRotationDeptReqExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
				.andRelRecordFlowIn(relRecordFlows);
		return deptReqMapper.selectByExample(example);
	}
	/**=====================================================================================================*/
	
	@Override
	public int delGroupOrRotationDept(String recordFlow,String groupFlow,String rotationFlow){
		//delRelRotationDept(rotationFlow);
		delOrgGroupOrRotationDept(recordFlow,groupFlow);
		int result = 0;
		if(StringUtil.isNotBlank(recordFlow)){
			SchRotationDept rotationDept = new SchRotationDept();
			rotationDept.setRecordFlow(recordFlow);
			rotationDept.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			result = saveSchRotationDept(rotationDept);
		}else if(StringUtil.isNotBlank(groupFlow)){
			SchRotationGroup rotationGroup = new SchRotationGroup();
			rotationGroup.setGroupFlow(groupFlow);
			rotationGroup.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			rotationGroupBiz.saveSchRotationGroup(rotationGroup);
			
			SchRotationDept rotationDept = new SchRotationDept();
			rotationDept.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			SchRotationDeptExample example = new SchRotationDeptExample();
			example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andGroupFlowEqualTo(groupFlow);
			result = rotationDeptMapper.updateByExampleSelective(rotationDept,example);
		}
		return result;
	}
	
	private int delOrgGroupOrRotationDept(String recordFlow,String groupFlow){
		int result = 0;
		
		SchRotationDeptExample deptExample = new SchRotationDeptExample();
		SchRotationGroupExample groupExample = new SchRotationGroupExample();
		
		if(StringUtil.isNotBlank(recordFlow)){
			SchRotationDept standardDept = readSchRotationDept(recordFlow);
			String standardGroupFlow = standardDept.getGroupFlow();
			groupExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
			.andStandardGroupFlowEqualTo(standardGroupFlow);
			List<SchRotationGroup> localGroupList = rotationGroupMapper.selectByExample(groupExample);
			if(localGroupList!=null && localGroupList.size()>0){
				List<String> groupFlows = new ArrayList<String>();
				for(SchRotationGroup srg : localGroupList){
					groupFlows.add(srg.getGroupFlow());
				}
				
				SchRotationDept rotationDept = new SchRotationDept();
				rotationDept.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				deptExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
				.andGroupFlowIn(groupFlows).andStandardDeptIdEqualTo(standardDept.getStandardDeptId())
				.andOrgFlowIsNotNull();
				result = rotationDeptMapper.updateByExampleSelective(rotationDept,deptExample);
			}
		}else if(StringUtil.isNotBlank(groupFlow)){
			SchRotationGroup group = new SchRotationGroup();
			group.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			
			groupExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
			.andStandardGroupFlowEqualTo(groupFlow);
			List<SchRotationGroup> localGroupList = rotationGroupMapper.selectByExample(groupExample);
			if(localGroupList!=null && localGroupList.size()>0){
				rotationGroupMapper.updateByExampleSelective(group,groupExample);
				
				List<String> groupFlows = new ArrayList<String>();
				for(SchRotationGroup srg : localGroupList){
					groupFlows.add(srg.getGroupFlow());
				}
				
				SchRotationDept rotationDept = new SchRotationDept();
				rotationDept.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				deptExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
				.andGroupFlowIn(groupFlows).andOrgFlowIsNotNull();
				result = rotationDeptMapper.updateByExampleSelective(rotationDept,deptExample);
			}
		}
		return result;
	}
	
	@Override
	public SchRotationDept readStandardRotationDept(String resultFlow){
		SchRotationDept rotationDept = null;
		if(StringUtil.isNotBlank(resultFlow)){
			SchArrangeResult result = schArrangeResultBiz.readSchArrangeResult(resultFlow);
			if(result!=null){
				String rotationFlow = result.getRotationFlow();
				String standardDeptId = result.getStandardDeptId();
				SchRotationGroup group = rotationGroupBiz.readSchRotationGroup(result.getGroupFlow());
				if(group!=null){
					if(StringUtil.isNotBlank(rotationFlow) && StringUtil.isNotBlank(standardDeptId)){
						SchRotationDeptExample example = new SchRotationDeptExample();
						Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.FLAG_Y)
								.andRotationFlowEqualTo(rotationFlow)
								.andStandardDeptIdEqualTo(standardDeptId)
								.andOrgFlowIsNull()
								.andGroupFlowEqualTo(group.getStandardGroupFlow());
						List<SchRotationDept> rotationDeptList = rotationDeptMapper.selectByExampleWithBLOBs(example);
						if(rotationDeptList!=null && rotationDeptList.size()>0){
							rotationDept = rotationDeptList.get(0);
						}
					}
				}
			}
		}
		return rotationDept;
	}
	
	@Override
	public int getUnrelCount(String orgFlow,String rotationFlow){
		return rotationDeptExtMapper.getUnrelCount(orgFlow,rotationFlow);
	}
	
}
