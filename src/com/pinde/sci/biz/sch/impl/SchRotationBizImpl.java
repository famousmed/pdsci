package com.pinde.sci.biz.sch.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sch.ISchDeptBiz;
import com.pinde.sci.biz.sch.ISchDeptRelBiz;
import com.pinde.sci.biz.sch.ISchRotationBiz;
import com.pinde.sci.biz.sch.ISchRotationDeptBiz;
import com.pinde.sci.biz.sch.ISchRotationGroupBiz;
import com.pinde.sci.biz.sys.ICfgBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SchRotationGroupMapper;
import com.pinde.sci.dao.base.SchRotationMapper;
import com.pinde.sci.dao.sch.SchRotationExtMapper;
import com.pinde.sci.enums.sch.SchSelTypeEnum;
import com.pinde.sci.enums.sch.SchStageEnum;
import com.pinde.sci.model.mo.SchDept;
import com.pinde.sci.model.mo.SchDeptRel;
import com.pinde.sci.model.mo.SchRotation;
import com.pinde.sci.model.mo.SchRotationDept;
import com.pinde.sci.model.mo.SchRotationDeptReq;
import com.pinde.sci.model.mo.SchRotationExample;
import com.pinde.sci.model.mo.SchRotationExample.Criteria;
import com.pinde.sci.model.mo.SchRotationGroup;
import com.pinde.sci.model.mo.SysCfg;
import com.pinde.sci.model.mo.SysOrg;

@Service
@Transactional(rollbackFor=Exception.class)
public class SchRotationBizImpl implements ISchRotationBiz {
	@Autowired
	private SchRotationMapper rotationMapper;
	@Autowired
	private SchRotationExtMapper rotationExtMapper;
	@Autowired
	private ISchRotationGroupBiz groupBiz;
	@Autowired
	private ISchRotationDeptBiz rotationDeptBiz;
	@Autowired
	private ISchDeptRelBiz deptRelBiz;
	@Autowired
	private SchRotationGroupMapper rotationGroupMapper;
	@Autowired
	private ISchRotationGroupBiz rotationGroupBiz;
	@Autowired
	private ISchDeptBiz deptBiz;
	@Autowired
	private ICfgBiz cfgBiz;
	@Autowired
	private IOrgBiz orgBiz;
	
	
	@Override
	public List<SchRotation> searchSchRotation() {
		SchRotationExample example = new SchRotationExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		return rotationMapper.selectByExample(example);
	}
	
	@Override
	public List<SchRotation> searchSchRotationByIsPublish() {
		SchRotationExample example = new SchRotationExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andPublishFlagEqualTo(GlobalConstant.FLAG_Y);
		example.setOrderByClause("ORDINAL");
		return rotationMapper.selectByExample(example);
	}
	
	
	
//	@Override
//	public List<SchRotation> searchRotation(String orgFlow) {
//		SchRotationExample example = new SchRotationExample();
//		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgFlowEqualTo(orgFlow).andRotationTypeIdEqualTo(SchRotationTypeEnum.Local.getId());
//		example.setOrderByClause("ORDINAL");
//		return rotationMapper.selectByExample(example);
//	}
	
//	@Override
//	public SchRotation readRotationByStandardAndOrg(String orgFlow,String rotationFlow) {
//		SchRotation rotation = null;
//		SchRotationExample example = new SchRotationExample();
//		example.createCriteria()
//		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
//		.andOrgFlowEqualTo(orgFlow)
//		.andRotationTypeIdEqualTo(SchRotationTypeEnum.Local.getId())
//		.andRotationFlowEqualTo(rotationFlow);
//		List<SchRotation> rotationList = rotationMapper.selectByExample(example);
//		if(rotationList!=null && rotationList.size()>0){
//			rotation = rotationList.get(0);
//		}
//		return rotation;
//	}
	
//	@Override
//	public List<SchRotation> searchSchRotationIsPublish(String publishFlag) {
//		SchRotationExample example = new SchRotationExample();
//		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRotationTypeIdEqualTo(SchRotationTypeEnum.Standard.getId());
//		if(StringUtil.isNotBlank(publishFlag)){
//			criteria.andPublishFlagEqualTo(publishFlag);
//		}
//		example.setOrderByClause("ORDINAL");
//		return rotationMapper.selectByExample(example);
//	}
	
	@Override
	public List<SchRotation> searchSchRotationForPlatform(String doctorCateGoryId) {
		SchRotationExample example = new SchRotationExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andPublishFlagEqualTo(GlobalConstant.FLAG_Y);
		if(StringUtil.isNotBlank(doctorCateGoryId)){
			criteria.andDoctorCategoryIdEqualTo(doctorCateGoryId);
		}
		example.setOrderByClause("ORDINAL");
		return rotationMapper.selectByExample(example);
	}
	
//	@Override
//	public List<SchRotation> searchRotationByRole(String roleFlag,SchRotation rotation){
//		return rotationExtMapper.searchRotationByRole(roleFlag,rotation);
//	}

	@Override
	public List<SchRotation> searchOrgStandardRotation(SchRotation rotation){
		SchRotationExample example = new SchRotationExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		
		if(StringUtil.isNotBlank(rotation.getDoctorCategoryId())){
			criteria.andDoctorCategoryIdEqualTo(rotation.getDoctorCategoryId());
		}
		if(StringUtil.isNotBlank(rotation.getSpeId())){
			criteria.andSpeIdEqualTo(rotation.getSpeId());
		}
		if(StringUtil.isNotBlank(rotation.getPublishFlag())){
			criteria.andPublishFlagEqualTo(rotation.getPublishFlag());
		}
		example.setOrderByClause("ORDINAL");
		return rotationMapper.selectByExample(example);
	}
	
	@Override
	public List<SchRotation> searchSchRotation(String speId) {
		SchRotationExample example = new SchRotationExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andSpeIdEqualTo(speId);
		example.setOrderByClause("ORDINAL");
		return rotationMapper.selectByExample(example);
	}

	@Override
	public SchRotation readSchRotation(String rotationFlow) {
		return rotationMapper.selectByPrimaryKey(rotationFlow);
	}

	@Override
	public int saveSchRotation(SchRotation rotation) {
		if(rotation != null){
			if(StringUtil.isNotBlank(rotation.getRotationFlow())){
				GeneralMethod.setRecordInfo(rotation, false);
				return rotationMapper.updateByPrimaryKeySelective(rotation);
			}else{
				rotation.setRotationFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(rotation, true);
				return rotationMapper.insertSelective(rotation);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<SchRotation> searchRotationByrotationFlows(List<String> rotationFlows){
		SchRotationExample example = new SchRotationExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRotationFlowIn(rotationFlows);
		example.setOrderByClause("ORDINAL");
		return rotationMapper.selectByExample(example);
	}
	
//	@Override
//	public List<SchRotation> searchNotExistRotation(String orgFlow){
//		return rotationExtMapper.searchNotExistRotation(orgFlow);
//	}
	
	@Override
	public int saveLocalRotation(List<SchRotation> rotationList,String orgFlow){
		String orgName = null;
		Map<String,List<SchDeptRel>> deptRelListMap = new HashMap<String, List<SchDeptRel>>();
		if(StringUtil.isNotBlank(orgFlow)){
			List<SchDeptRel> deptRelList = deptRelBiz.searchRelByOrg(orgFlow);
			//解析标准科室轮转科室关系
			if(deptRelList!=null && deptRelList.size()>0){
				for(SchDeptRel deptRel : deptRelList){
					String key = deptRel.getStandardDeptId();
					if(deptRelListMap.get(key)==null){
						List<SchDeptRel> deptRelTempRelList = new ArrayList<SchDeptRel>();
						deptRelTempRelList.add(deptRel);
						deptRelListMap.put(key,deptRelTempRelList);
					}else{
						deptRelListMap.get(key).add(deptRel);
					}
				}
			}
			
			SysOrg org = orgBiz.readSysOrg(orgFlow);
			if(org!=null){
				orgName = org.getOrgName();
			}
		}
		
		//保存本地方案
		if(rotationList!=null && rotationList.size()>0){
			List<String> stabdardRotationFlows = new ArrayList<String>();
			for(SchRotation rotation : rotationList){
				stabdardRotationFlows.add(rotation.getRotationFlow());
			}
			//通过标准方案获取标准规则
			List<SchRotationGroup> groupList = groupBiz.searchGroupByRotations(stabdardRotationFlows);
			List<SchRotationDept> rotationDeptList = rotationDeptBiz.searchDeptByRotations(stabdardRotationFlows);
			
			//解析标准轮转规则
			Map<String,List<SchRotationDept>> rotationDeptListMap = null;
			if(rotationDeptList!=null && rotationDeptList.size()>0){
				rotationDeptListMap = new HashMap<String, List<SchRotationDept>>();
				for(SchRotationDept rotationDept : rotationDeptList){
//					if(GlobalConstant.FLAG_Y.equals(rotationDept.getIsRequired())){
//						String key = rotationDept.getRotationFlow();
//						if(rotationDeptListMap.get(key)==null){
//							List<SchRotationDept> rotationDeptTempList = new ArrayList<SchRotationDept>();
//							rotationDeptTempList.add(rotationDept);
//							rotationDeptListMap.put(key,rotationDeptTempList);
//						}else{
//							rotationDeptListMap.get(key).add(rotationDept);
//						}
//					}else{
						String key = rotationDept.getGroupFlow();
						if(rotationDeptListMap.get(key)==null){
							List<SchRotationDept> rotationDeptTempList = new ArrayList<SchRotationDept>();
							rotationDeptTempList.add(rotationDept);
							rotationDeptListMap.put(key,rotationDeptTempList);
						}else{
							rotationDeptListMap.get(key).add(rotationDept);
						}
//					}
				}
			}
			//解析标准轮转规则分组
			Map<String,List<SchRotationGroup>> groupListMap = null;
			if(groupList!=null && groupList.size()>0){
				groupListMap = new HashMap<String, List<SchRotationGroup>>();
				for(SchRotationGroup group : groupList){
					String key = group.getRotationFlow();
					if(groupListMap.get(key)==null){
						List<SchRotationGroup> groupTempList = new ArrayList<SchRotationGroup>();
						groupTempList.add(group);
						groupListMap.put(key,groupTempList);
					}else{
						groupListMap.get(key).add(group);
					}
				}
			}
			
			//解析保存本地规则
			for(SchRotation rotation : rotationList){
				String rotationFlow = rotation.getRotationFlow();
				//获取本方案必轮科室列表
//				List<SchRotationDept> mustRotationDeptList = null;
//				if(rotationDeptListMap!=null){
//					mustRotationDeptList = rotationDeptListMap.get(rotationFlow);
//				}
//				if(mustRotationDeptList!=null && mustRotationDeptList.size()>0){
//					for(SchRotationDept rotationDept : mustRotationDeptList){
//						rotationDept.setRotationFlow(rotationFlow);
//						rotationDept.setOrgFlow(orgFlow);
//						rotationDept.setOrgName(orgName);
//						parseStandardDept(deptRelListMap,rotationDept,rotation);
//					}
//				}
				//获取本方案组合列表
				if(groupListMap!=null){
					List<SchRotationGroup> standardGroupList = groupListMap.get(rotationFlow);
					if(standardGroupList!=null && standardGroupList.size()>0){
						for(SchRotationGroup group : standardGroupList){
							Integer deptNum = group.getDeptNum();
							Integer maxDeptNum = group.getMaxDeptNum();
							//获取组合内科室
							List<SchRotationDept> groupRotationDeptList = null;
							if(rotationDeptListMap!=null){
								groupRotationDeptList = rotationDeptListMap.get(group.getGroupFlow());
							}
							group.setStandardGroupFlow(group.getGroupFlow());
							group.setGroupFlow(PkUtil.getUUID());
							if(groupRotationDeptList!=null && groupRotationDeptList.size()>0){
								for(SchRotationDept rotationDept : groupRotationDeptList){
									rotationDept.setRotationFlow(rotationFlow);
									rotationDept.setGroupFlow(group.getGroupFlow());
									rotationDept.setOrgFlow(orgFlow);
									rotationDept.setOrgName(orgName);
									
									int upCount = parseStandardDept(deptRelListMap,rotationDept,rotation);
									if(GlobalConstant.FLAG_N.equals(group.getIsRequired())){
										if(SchSelTypeEnum.Free.getId().equals(group.getSelTypeId())){
											maxDeptNum+=upCount;
										}else{
											deptNum+=upCount;
										}
									}
								}
							}
							
							group.setRotationFlow(rotationFlow);
							if(SchSelTypeEnum.Free.getId().equals(group.getSelTypeId())){
								group.setMaxDeptNum(maxDeptNum);
							}else{
								group.setDeptNum(deptNum);
							}
							group.setOrgFlow(orgFlow);
							group.setOrgName(orgName);
							GeneralMethod.setRecordInfo(group,true);
							rotationGroupMapper.insertSelective(group);
						}
					}
				}
				
				//获取本方案组合
				List<SchRotationGroup> confirmGroupList = rotationGroupBiz.searchOrgGroupOrAll(rotationFlow,orgFlow,null);
				//获取本方案规则
				List<SchRotationDept> confirmDeptList = rotationDeptBiz.searchOrgSchRotationDept(rotationFlow,orgFlow);
				Map<String,List<SchRotationDept>> confirmDeptMap = new HashMap<String,List<SchRotationDept>>();
				for(SchRotationDept srd : confirmDeptList){
					String key = srd.getGroupFlow();
					if(confirmDeptMap.get(key)==null){
						List<SchRotationDept> srds = new ArrayList<SchRotationDept>();
						srds.add(srd);
						confirmDeptMap.put(key,srds);
					}else{
						confirmDeptMap.get(key).add(srd);
					}
				}
				//产生本地顺序
				int ord = 0;
				if(GlobalConstant.FLAG_Y.equals(rotation.getIsStage())){
					Map<String,List<SchRotationGroup>> confirmGroupMap = new HashMap<String,List<SchRotationGroup>>();
					for(SchRotationGroup srg : confirmGroupList){
						String key = srg.getSchStageId();
						if(confirmGroupMap.get(key)==null){
							List<SchRotationGroup> srgs = new ArrayList<SchRotationGroup>();
							srgs.add(srg);
							confirmGroupMap.put(key,srgs);
						}else{
							confirmGroupMap.get(key).add(srg);
						}
					}
					
					for(SchStageEnum stage : SchStageEnum.values()){
						String groupKey = stage.getId();
						List<SchRotationGroup> sortGroupList = confirmGroupMap.get(groupKey);
						for(SchRotationGroup srg : sortGroupList){
							String deptKey = srg.getGroupFlow();
							List<SchRotationDept> sortDeptList = confirmDeptMap.get(deptKey);
							for(SchRotationDept srd : sortDeptList){
								srd.setOrdinal(ord++);
								rotationDeptBiz.saveSchRotationDept(srd);
							}
						}
					}
				}else{
					for(SchRotationGroup srg : confirmGroupList){
						String deptKey = srg.getGroupFlow();
						List<SchRotationDept> sortDeptList = confirmDeptMap.get(deptKey);
						for(SchRotationDept srd : sortDeptList){
							srd.setOrdinal(ord++);
							rotationDeptBiz.saveSchRotationDept(srd);
						}
					}
				}
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	private int parseStandardDept(Map<String,List<SchDeptRel>> deptRelListMap,SchRotationDept rotationDept,SchRotation rotation){
		int overFlowNum = 0;
		if(rotationDept!=null){
			List<SchDeptRel> deptRelList = deptRelListMap.get(rotationDept.getStandardDeptId());
			if(deptRelList!=null && deptRelList.size()>0){
				boolean first = true;
				for(SchDeptRel deptRel : deptRelList){
					SchDept dept = deptBiz.readSchDept(deptRel.getSchDeptFlow());
					
					rotationDept.setRecordFlow(null);
					if(dept!=null){
						rotationDept.setSchDeptFlow(dept.getSchDeptFlow());
						rotationDept.setSchDeptName(dept.getSchDeptName());
						rotationDept.setDeptFlow(dept.getDeptFlow());
						rotationDept.setDeptName(dept.getDeptName());
					}
					
					if(!first){
						rotationDept.setSchMonth("0");
					}
					rotationDeptBiz.saveSchRotationDept(rotationDept);
					first = false;
				}
				overFlowNum = deptRelList.size()-1;
			}else{
				rotationDept.setRecordFlow(null);
				rotationDeptBiz.saveSchRotationDept(rotationDept);
			}
		}
		return overFlowNum;
	}
	
	@Override
	public int editRotations(List<SchRotation> rotationList){
		if(rotationList!=null && rotationList.size()>0){
			for(SchRotation rotation : rotationList){
				saveSchRotation(rotation);
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<SchRotation> searchNotExistRotation(String orgFlow) {
		return rotationExtMapper.searchNotExistRotation(orgFlow);
	}
	
	@Override
	public int rotationClone(String rotationFlow,String rotationYear){
		if(StringUtil.isNotBlank(rotationFlow)){
			SchRotation rotation = readSchRotation(rotationFlow);
			
			if(rotation!=null){
				//保存新方案
				rotation.setRotationFlow(null);
				rotation.setPublishFlag(GlobalConstant.FLAG_N);
				//rotation.setRotationYear(rotationYear);
				rotation.setRotationName("复制-"+rotation.getRotationName());
				saveSchRotation(rotation);
				
				//保存方案的表单配置
				SysCfg cfg = cfgBiz.read("res_form_category_"+rotationFlow);
				if(cfg!=null){
					cfg.setCfgCode("res_form_category_"+rotation.getRotationFlow());
					cfgBiz.add(cfg);
				}
				
				//查询老方案必轮科室
//				List<SchRotationDept> oldRotationDeptList = rotationDeptBiz.searchSchRotationDeptMustWithBLOBs(rotationFlow);
//				if(oldRotationDeptList!=null && oldRotationDeptList.size()>0){
//					for(SchRotationDept rotationDept : oldRotationDeptList){
//						String relFlow = rotationDept.getRecordFlow();
//						
//						rotationDept.setRecordFlow(null);
//						rotationDept.setRotationFlow(rotation.getRotationFlow());
//						rotationDeptBiz.saveSchRotationDept(rotationDept);
//						
//						//保存关联的要求
//						saveReqByRel(relFlow,rotationDept.getRecordFlow(),rotation);
//					}
//				}
				
				//查询老方案科室组
				List<SchRotationGroup> oldGroupList = groupBiz.searchSchRotationGroup(rotationFlow);
				if(oldGroupList!=null && oldGroupList.size()>0){
					for(SchRotationGroup group : oldGroupList){
						String oldGroupFlow = group.getGroupFlow();
						
						group.setGroupFlow(null);
						group.setRotationFlow(rotation.getRotationFlow());
						groupBiz.saveSchRotationGroup(group);
						
						List<SchRotationDept> oldGroupDeptList = rotationDeptBiz.searchRotationDeptByGroupFlowWithBLOBs(oldGroupFlow);
						if(oldGroupDeptList!=null && oldGroupDeptList.size()>0){
							for(SchRotationDept rotationDept : oldGroupDeptList){
								String relFlow = rotationDept.getRecordFlow();
								
								rotationDept.setRecordFlow(null);
								rotationDept.setRotationFlow(rotation.getRotationFlow());
								rotationDept.setGroupFlow(group.getGroupFlow());
								rotationDeptBiz.saveSchRotationDept(rotationDept);
								//保存关联的要求
								saveReqByRel(relFlow,rotationDept.getRecordFlow(),rotation);
							}
						}
					}
				}
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	private void saveReqByRel(String oldRelFlow,String newRelFlow,SchRotation rotation){
		String rotationFlow = rotation.getRotationFlow();
		if(StringUtil.isNotBlank(oldRelFlow)){
			List<SchRotationDeptReq> reqList = rotationDeptBiz.searchDeptReqByRel(oldRelFlow);
			if(reqList!=null && reqList.size()>0){
				for(SchRotationDeptReq req : reqList){
					req.setReqFlow(null);
					req.setRelRecordFlow(newRelFlow);
					req.setRotationFlow(rotationFlow);
					rotationDeptBiz.editDeptReq(req);
				}
			}
		}
	}
}
