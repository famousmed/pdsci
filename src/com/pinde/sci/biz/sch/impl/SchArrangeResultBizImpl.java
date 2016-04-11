package com.pinde.sci.biz.sch.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.sch.ISchArrangeBiz;
import com.pinde.sci.biz.sch.ISchArrangeDoctorBiz;
import com.pinde.sci.biz.sch.ISchArrangeDoctorDeptBiz;
import com.pinde.sci.biz.sch.ISchArrangeResultBiz;
import com.pinde.sci.biz.sch.ISchDeptBiz;
import com.pinde.sci.biz.sch.ISchDoctorDeptBiz;
import com.pinde.sci.biz.sch.ISchRotationDeptBiz;
import com.pinde.sci.biz.sch.ISchRotationGroupBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.SchArrangeResultMapper;
import com.pinde.sci.dao.sch.SchArrangeResultExtMapper;
import com.pinde.sci.enums.res.RecDocCategoryEnum;
import com.pinde.sci.enums.sch.SchArrangeStatusEnum;
import com.pinde.sci.enums.sch.SchArrangeTypeEnum;
import com.pinde.sci.enums.sch.SchStageEnum;
import com.pinde.sci.form.sch.SchArrangeResultForm;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SchArrange;
import com.pinde.sci.model.mo.SchArrangeDoctor;
import com.pinde.sci.model.mo.SchArrangeDoctorDept;
import com.pinde.sci.model.mo.SchArrangeResult;
import com.pinde.sci.model.mo.SchArrangeResultExample;
import com.pinde.sci.model.mo.SchArrangeResultExample.Criteria;
import com.pinde.sci.model.mo.SchDept;
import com.pinde.sci.model.mo.SchDoctorDept;
import com.pinde.sci.model.mo.SchRotationDept;
import com.pinde.sci.model.mo.SchRotationGroup;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor=Exception.class)
public class SchArrangeResultBizImpl implements ISchArrangeResultBiz {
	@Autowired
	private SchArrangeResultMapper arrangeResultMapper;
	@Resource
	private ISchArrangeBiz arrangeBiz;
	@Resource
	private ISchArrangeDoctorBiz arrdocBiz;
	@Resource
	private ISchArrangeDoctorDeptBiz arrDocDeptBiz;
	@Resource
	private SchArrangeResultExtMapper resultMapper;
	@Resource
	private ISchRotationDeptBiz rotationDeptBiz;
	@Resource
	private ISchDoctorDeptBiz doctroDeptBiz;
	@Resource
	private SchArrangeResultExtMapper resultExtMapper; 
	@Resource
	private ISchDeptBiz schDeptBiz;
	@Resource
	private IResDoctorBiz doctorBiz;
	@Resource
	private ISchRotationGroupBiz groupBiz;
	
	@Override
	public List<SchArrangeResult> searchSchArrangeResult() {
		SchArrangeResultExample example = new SchArrangeResultExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return arrangeResultMapper.selectByExample(example);
	}
	
	@Override
	public List<SchArrangeResult> searchSchArrangeResultByDoctor(String doctorFlow){
		SchArrangeResultExample example = new SchArrangeResultExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andDoctorFlowEqualTo(doctorFlow);
		example.setOrderByClause("SCH_DEPT_ORDER,SCH_START_DATE");
		return arrangeResultMapper.selectByExample(example);
	}
	
	@Override
	public SchArrangeResult readSchArrangeResult(String resultFlow) {
		return arrangeResultMapper.selectByPrimaryKey(resultFlow);
	}

	@Override
	public int saveSchArrangeResults(List<SchArrangeResult> resultList) {
		if(resultList!=null && resultList.size()>0){
			for(SchArrangeResult result : resultList){
				saveSchArrangeResult(result);
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int saveSchArrangeResult(SchArrangeResult result) {
		if(result != null){
			if(StringUtil.isNotBlank(result.getResultFlow())){
				return update(result);
			}else{
				result.setResultFlow(PkUtil.getUUID());
				return save(result);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int save(SchArrangeResult result){
		GeneralMethod.setRecordInfo(result, true);
		return arrangeResultMapper.insertSelective(result);
	}
	
	@Override
	public int update(SchArrangeResult result){
		GeneralMethod.setRecordInfo(result, false);
		return arrangeResultMapper.updateByPrimaryKeySelective(result);
	}
	
	@Override
	public int saveSchArrangeResultForm(SchArrangeResultForm resultForm){
		if(resultForm != null){
			SchArrange arrange = new SchArrange();
			SysUser user = GlobalContext.getCurrentUser();
			arrange.setArrangeFlow(PkUtil.getUUID());
			arrange.setOperTime(DateUtil.getCurrDateTime());
			arrange.setOperUserFlow(user.getUserFlow());
			arrange.setOperUserName(user.getUserName());
			arrange.setOrgFlow(user.getOrgFlow());
			arrange.setOrgName(user.getOrgName());
			arrange.setArrangeTypeId(SchArrangeTypeEnum.Hand.getId());
			arrange.setArrangeTypeName(SchArrangeTypeEnum.Hand.getName());
			arrange.setArrangeStatusId(SchArrangeStatusEnum.Confirm.getId());
			arrange.setArrangeStatusName(SchArrangeStatusEnum.Confirm.getName());
			arrangeBiz.saveArrange(arrange);
			
			SchArrangeDoctor arrDoc = resultForm.getArrDoc();
			arrDoc.setArrangeFlow(arrange.getArrangeFlow());
			arrDoc.setOrgFlow(user.getOrgFlow());
			arrDoc.setOrgName(user.getOrgName());
			arrdocBiz.saveSchArrangeDoctor(arrDoc);
			
			List<SchArrangeDoctorDept> arrDocDeptList = resultForm.getArrDocDeptList();
			if(arrDocDeptList != null && arrDocDeptList.size()>0){
				for(SchArrangeDoctorDept arrDocDept : arrDocDeptList){
					arrDocDept.setArrangeFlow(arrange.getArrangeFlow());
					arrDocDept.setOrgFlow(user.getOrgFlow());
					arrDocDept.setOrgName(user.getOrgName());
					arrDocDeptBiz.saveSchArrangeDoctorDept(arrDocDept);
				}
			}
			
			delArrangeResult(arrDoc.getDoctorFlow());
			
			List<SchArrangeResult> arrResultList = resultForm.getResultList();
			if(arrResultList != null && arrResultList.size()>0){
				for(SchArrangeResult arrResult : arrResultList){
					arrResult.setArrangeFlow(arrange.getArrangeFlow());
					arrResult.setOrgFlow(user.getOrgFlow());
					arrResult.setOrgName(user.getOrgName());
					saveSchArrangeResult(arrResult);
				}
			}
			
			return GlobalConstant.ONE_LINE;		
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int delArrangeResult(String doctorFlow){
		SchArrangeResultExample example = new SchArrangeResultExample();
		example.createCriteria().andDoctorFlowEqualTo(doctorFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		SchArrangeResult resultTemp = new SchArrangeResult();
		resultTemp.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		return arrangeResultMapper.updateByExampleSelective(resultTemp, example);
	}
	
	@Override
	public List<SchArrangeResult> searchArrangeResultByDateAndOrg(String schStartDate,String schEndDate,String orgFlow){
		SchArrangeResultExample example = new SchArrangeResultExample();
		Criteria criteria = example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgFlowEqualTo(orgFlow);
		if(StringUtil.isNotBlank(schStartDate)){
			criteria.andSchEndDateGreaterThanOrEqualTo(schStartDate);
		}
		if(StringUtil.isNotBlank(schEndDate)){
			criteria.andSchEndDateLessThanOrEqualTo(schEndDate);
		}
		return arrangeResultMapper.selectByExample(example);
	}
	
	@Override
	public List<SchArrangeResult> searchArrangeResultByDate(String schStartDate,String schEndDate){
		SchArrangeResultExample example = new SchArrangeResultExample();
		Criteria criteria = example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(schStartDate)){
			criteria.andSchEndDateGreaterThanOrEqualTo(schStartDate);
		}
		if(StringUtil.isNotBlank(schEndDate)){
			criteria.andSchEndDateLessThanOrEqualTo(schEndDate);
		}
		return arrangeResultMapper.selectByExample(example);
	}
	
	@Override
	public List<SchArrangeResult> searchArrangeResultByDate(String schStartDate,String schEndDate,String doctorName){
		SchArrangeResultExample example = new SchArrangeResultExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andSchEndDateBetween(schStartDate,schEndDate).andDoctorNameEqualTo(doctorName);
		example.setOrderByClause("SCH_END_DATE");
		return arrangeResultMapper.selectByExample(example);
	}
	
	@Override
	public List<SchArrangeResult> searchArrangeResultByDoctorFlows(List<String> doctorFlows){
		List<SchArrangeResult> resultList = null;
		if(doctorFlows!=null&&!doctorFlows.isEmpty()){
			SchArrangeResultExample example = new SchArrangeResultExample();
			example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andDoctorFlowIn(doctorFlows);
			example.setOrderByClause("SCH_END_DATE");
			resultList = arrangeResultMapper.selectByExample(example);
		}
		return resultList; 
	}
	
	@Override
	public List<SchArrangeResult> searchArrangeResultByResultFlow(List<String> resultFlows){
		List<SchArrangeResult> resultList = null;
		if(resultFlows!=null&&!resultFlows.isEmpty()){
			SchArrangeResultExample example = new SchArrangeResultExample();
			example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andResultFlowIn(resultFlows);
			example.setOrderByClause("SCH_END_DATE");
			resultList = arrangeResultMapper.selectByExample(example);
		}
		return resultList; 
	}
	
	@Override
	public List<Map<String,Object>> countResultByUser(List<String> userFlows){
		return resultMapper.countResultByUser(userFlows);
	}
	
	@Override
	public int saveResultByDoctor(ResDoctor doctor){
		if(doctor!=null){
			String doctorFlow = doctor.getDoctorFlow();
			String rotationFlow = doctor.getRotationFlow();
			Integer sessionNumber = Integer.parseInt(doctor.getSessionNumber());
			
			List<SchRotationGroup> groupList = groupBiz.searchOrgGroupOrAll(rotationFlow,doctor.getOrgFlow(),null);
			Map<String,SchRotationGroup> groupMap = new HashMap<String, SchRotationGroup>();
			for(SchRotationGroup group : groupList){
				groupMap.put(group.getGroupFlow(),group);
			}
			
			//留痕数据
			SchArrange arrange = new SchArrange();
			arrange.setArrangeFlow(PkUtil.getUUID());
			arrange.setOperTime(DateUtil.getCurrDateTime());
			arrange.setOperUserFlow(doctorFlow);
			arrange.setOperUserName(doctor.getDoctorName());
			arrange.setOrgFlow(doctor.getOrgFlow());
			arrange.setOrgName(doctor.getOrgName());
			arrange.setArrangeTypeId(SchArrangeTypeEnum.Hand.getId());
			arrange.setArrangeTypeName(SchArrangeTypeEnum.Hand.getName());
			arrange.setArrangeStatusId(SchArrangeStatusEnum.Confirm.getId());
			arrange.setArrangeStatusName(SchArrangeStatusEnum.Confirm.getName());
			arrangeBiz.saveArrange(arrange);
			
			SchArrangeDoctor arrDoc = new SchArrangeDoctor();
			arrDoc.setArrangeFlow(arrange.getArrangeFlow());
			arrDoc.setDoctorFlow(doctorFlow);
			arrDoc.setDoctorName(doctor.getDoctorName());
			arrDoc.setRotationFlow(rotationFlow);
			arrDoc.setRotationName(doctor.getRotationName());
			arrDoc.setOrgFlow(doctor.getOrgFlow());
			arrDoc.setOrgName(doctor.getOrgName());
			arrdocBiz.saveSchArrangeDoctor(arrDoc);
			
			SchArrangeDoctorDept arrDocDept = new SchArrangeDoctorDept();
			arrDocDept.setArrangeFlow(arrange.getArrangeFlow());
			arrDocDept.setDoctorFlow(doctorFlow);
			arrDocDept.setDoctorName(doctor.getDoctorName());
			arrDocDept.setOrgFlow(doctor.getOrgFlow());
			arrDocDept.setOrgName(doctor.getOrgName());
			//=============================================
			
			SchArrangeResult result = new SchArrangeResult();
			result.setDoctorFlow(doctorFlow);
			result.setDoctorName(doctor.getDoctorName());
			result.setSessionNumber(doctor.getSessionNumber());
			result.setRotationFlow(doctor.getRotationFlow());
			result.setRotationName(doctor.getRotationName());
			result.setOrgFlow(doctor.getOrgFlow());
			result.setOrgName(doctor.getOrgName());
			
			List<SchRotationDept> mustRotationDeptList = rotationDeptBiz.searchOrgSchRotationDeptMust(rotationFlow,doctor.getOrgFlow());
			if(mustRotationDeptList!=null && mustRotationDeptList.size()>0){
				for(SchRotationDept rotationDept : mustRotationDeptList){
					result.setDeptFlow(rotationDept.getDeptFlow());
					result.setDeptName(rotationDept.getDeptName());
					result.setSchDeptFlow(rotationDept.getSchDeptFlow());
					result.setSchDeptName(rotationDept.getSchDeptName());
					result.setIsRequired(rotationDept.getIsRequired());
					result.setGroupFlow(rotationDept.getGroupFlow());
					result.setStandardDeptId(rotationDept.getStandardDeptId());
					result.setStandardDeptName(rotationDept.getStandardDeptName());
					String standardGroupFlow = null;
					SchRotationGroup group = groupMap.get(rotationDept.getGroupFlow());
					if(group!=null){
						standardGroupFlow = group.getStandardGroupFlow();
					}
					result.setStandardGroupFlow(standardGroupFlow);
					
					String schMonth = rotationDept.getSchMonth();
					
					Integer saveCount = 0;
					if(StringUtil.isNotBlank(schMonth) && !"0".equals(schMonth)){
						result.setResultFlow(null);
						result.setArrangeFlow(arrange.getArrangeFlow());
						result.setSchYear(sessionNumber.toString());
						result.setSchMonth(schMonth);
						if(rotationDept.getOrdinal()!=null){
							result.setSchDeptOrder(BigDecimal.valueOf(rotationDept.getOrdinal()));
						}
						saveCount+=saveSchArrangeResult(result);
					}
					
					if(saveCount<=0){
						result.setResultFlow(null);
						result.setArrangeFlow(arrange.getArrangeFlow());
						result.setSchMonth("0");
						if(rotationDept.getOrdinal()!=null){
							result.setSchDeptOrder(BigDecimal.valueOf(rotationDept.getOrdinal()));
						}
						saveSchArrangeResult(result);
					}
					
					//留痕数据
					arrDocDept.setArrDocDeptFlow(null);
					arrDocDept.setDeptFlow(rotationDept.getDeptFlow());
					arrDocDept.setDeptName(rotationDept.getDeptName());
					arrDocDept.setSchDeptFlow(rotationDept.getSchDeptFlow());
					arrDocDept.setSchDeptName(rotationDept.getSchDeptName());
					arrDocDept.setGroupFlow(rotationDept.getGroupFlow());
					arrDocDept.setGroupName(group.getGroupName());
					arrDocDept.setSchMonth(schMonth);
					arrDocDeptBiz.saveSchArrangeDoctorDept(arrDocDept);
					//==================================================
				}
			}
			
			List<SchDoctorDept> doctorDeptList =  doctroDeptBiz.searchSchDoctorDept(doctorFlow);
			if(doctorDeptList!=null && doctorDeptList.size()>0){
				for(SchDoctorDept doctorDept : doctorDeptList){
					result.setDeptFlow(doctorDept.getDeptFlow());
					result.setDeptName(doctorDept.getDeptName());
					result.setSchDeptFlow(doctorDept.getSchDeptFlow());
					result.setSchDeptName(doctorDept.getSchDeptName());
					result.setIsRequired(GlobalConstant.FLAG_N);
					result.setGroupFlow(doctorDept.getGroupFlow());
					result.setStandardDeptId(doctorDept.getStandardDeptId());
					result.setStandardDeptName(doctorDept.getStandardDeptName());
					String standardGroupFlow = null;
					SchRotationGroup group = groupMap.get(doctorDept.getGroupFlow());
					if(group!=null){
						standardGroupFlow = group.getStandardGroupFlow();
					}
					result.setStandardGroupFlow(standardGroupFlow);
					
					String schMonth = doctorDept.getSchMonth();
					
					Integer saveCount = 0;
					if(StringUtil.isNotBlank(schMonth) && !"0".equals(schMonth)){
						result.setResultFlow(null);
						result.setArrangeFlow(arrange.getArrangeFlow());
						result.setSchYear(sessionNumber.toString());
						result.setSchMonth(schMonth);
						if(doctorDept.getOrdinal()!=null){
							result.setSchDeptOrder(BigDecimal.valueOf(doctorDept.getOrdinal()));
						}
						saveCount+=saveSchArrangeResult(result);
					}
					
					if(saveCount<=0){
						result.setResultFlow(null);
						result.setArrangeFlow(arrange.getArrangeFlow());
						result.setSchMonth("0");
						if(doctorDept.getOrdinal()!=null){
							result.setSchDeptOrder(BigDecimal.valueOf(doctorDept.getOrdinal()));
						}
						saveSchArrangeResult(result);
					}
					
					//留痕数据
					arrDocDept.setArrDocDeptFlow(null);
					arrDocDept.setDeptFlow(doctorDept.getDeptFlow());
					arrDocDept.setDeptName(doctorDept.getDeptName());
					arrDocDept.setSchDeptFlow(doctorDept.getSchDeptFlow());
					arrDocDept.setSchDeptName(doctorDept.getSchDeptName());
					arrDocDept.setGroupFlow(doctorDept.getGroupFlow());
					arrDocDept.setGroupName(group.getGroupName());
					arrDocDept.setSchMonth(schMonth);
					arrDocDeptBiz.saveSchArrangeDoctorDept(arrDocDept);
					//====================
				}
			}
			
			//sortResult(doctorFlow);
			sortResultByStage(doctorFlow,doctor.getOrgFlow(),rotationFlow);
		}
		return GlobalConstant.ONE_LINE;
	}
	
	private void sortResultByStage(String userFlow,String orgFlow,String rotationFlow){
		if(StringUtil.isNotBlank(userFlow) && StringUtil.isNotBlank(rotationFlow) && StringUtil.isNotBlank(orgFlow)){
			Map<String,List<SchArrangeResult>> resultMap = null;
			List<SchArrangeResult> resultList = searchSchArrangeResultByDoctor(userFlow);
			if(resultList!=null && resultList.size()>0){
				resultMap = new HashMap<String, List<SchArrangeResult>>();
				for(SchArrangeResult sar : resultList){
					String key = sar.getGroupFlow();
					if(resultMap.get(key)==null){
						List<SchArrangeResult> sarTempList = new ArrayList<SchArrangeResult>();
						sarTempList.add(sar);
						resultMap.put(key,sarTempList);
					}else{
						resultMap.get(key).add(sar);
					}
				}
				
				Map<String,List<SchRotationGroup>> groupMap = null;
				List<SchRotationGroup> groupList = groupBiz.searchOrgGroupOrAll(rotationFlow,orgFlow,null);
				if(groupList!=null && groupList.size()>0){
					groupMap = new HashMap<String, List<SchRotationGroup>>();
					for(SchRotationGroup srg : groupList){
						String key = srg.getSchStageId();
						if(groupMap.get(key)==null){
							List<SchRotationGroup> srgTempList = new ArrayList<SchRotationGroup>();
							srgTempList.add(srg);
							groupMap.put(key,srgTempList);
						}else{
							groupMap.get(key).add(srg);
						}
					}
				}
				if(resultMap!=null && groupMap!=null){
					int ord = 0 ;
					for(SchStageEnum stage : SchStageEnum.values()){
						String stageId = stage.getId();
						
						List<SchRotationGroup> srgTempList = groupMap.get(stageId);
						if(srgTempList!=null && srgTempList.size()>0){
							for(SchRotationGroup srg : srgTempList){
								String groupFlow = srg.getGroupFlow();
								
								List<SchArrangeResult> sarTempList = resultMap.get(groupFlow);
								if(sarTempList!=null && sarTempList.size()>0){
									for(SchArrangeResult sar : sarTempList){
										sar.setSchDeptOrder(BigDecimal.valueOf(ord++));
										saveSchArrangeResult(sar);
									}
								}
							}
						}
					}
				}
			}
		}
	}
	
	/**
	 * 为医师的排班按照标准科室为组的形式排序
	 * @param userFlow
	 */
	private int sortResult(String userFlow){
		return resultExtMapper.sortResult(userFlow);
	}
	
	@Override
	public Map<String,String> countDateArea(ResDoctor doctor){
		return resultExtMapper.countDateArea(doctor);
	}
	
	@Override
	public List<Map<String,Object>> countMonthNum(String month,ResDoctor doctor){
		return resultExtMapper.countMonthNum(month,doctor);
	}
	
	@Override
	public List<SchArrangeResult> searchInMonthResult(String schDeptFlow,String month,ResDoctor doctor){
		return resultExtMapper.searchInMonthResult(schDeptFlow,month,doctor);
	}
	
	@Override
	public List<SchArrangeResult> willInDoctor(String orgFlow,String userFlow){
		return resultExtMapper.willInDoctor(orgFlow,userFlow);
	}
	
	@Override
	public int countRotationUse(String rotationFlow){
		return resultExtMapper.countRotationUse(rotationFlow);
	}
	
	@Override
	public int createFreeRosteringResult(ResDoctor doctor){
		if(doctor!=null){
			String orgFlow = doctor.getOrgFlow();
			List<SchDept> schDeptList = schDeptBiz.searchSchDeptList(orgFlow);
			if(schDeptList!=null && schDeptList.size()>0){
				SysUser operUser = GlobalContext.getCurrentUser();
				
				SchArrange arrange = new SchArrange();
				arrange.setArrangeFlow(PkUtil.getUUID());
				arrange.setDoctorNum(1);
				arrange.setOperTime(DateUtil.getCurrDateTime());
				arrange.setOperUserFlow(operUser.getUserFlow());
				arrange.setOperUserName(operUser.getUserName());
				arrange.setArrangeTypeId(SchArrangeTypeEnum.Hand.getId());
				arrange.setArrangeTypeName(SchArrangeTypeEnum.Hand.getName());
				arrange.setArrangeStatusId(SchArrangeStatusEnum.Finish.getId());
				arrange.setArrangeStatusName(SchArrangeStatusEnum.Finish.getName());
				arrange.setOrgFlow(doctor.getOrgFlow());
				arrange.setOrgName(doctor.getOrgName());
				arrangeBiz.saveArrange(arrange);
				
				SchArrangeResult result = new SchArrangeResult();
				result.setArrangeFlow(arrange.getArrangeFlow());
				result.setDoctorFlow(doctor.getDoctorFlow());
				result.setDoctorName(doctor.getDoctorName());
				result.setSessionNumber(doctor.getSessionNumber());
				result.setSchYear("1");
				result.setOrgFlow(doctor.getOrgFlow());
				result.setOrgName(doctor.getOrgName());
				result.setIsRequired(GlobalConstant.FLAG_Y);
				for(SchDept schDept : schDeptList){
					result.setResultFlow(null);
					result.setDeptFlow(schDept.getDeptFlow());
					result.setDeptName(schDept.getDeptName());
					result.setSchDeptFlow(schDept.getSchDeptFlow());
					result.setSchDeptName(schDept.getSchDeptName());
					saveSchArrangeResult(result);
				}
				
				doctor.setSelDeptFlag(GlobalConstant.FLAG_Y);
				doctorBiz.editDoctor(doctor);
				
				return GlobalConstant.ONE_LINE;
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public List<SchArrangeResult> cutAfterResult(List<String> doctorFlows){
		return resultExtMapper.cutAfterResult(doctorFlows);
	}
	
	@Override
	public int editFreeRostering(String doctorFlow,String[] addSchDeptFlows,String[] delResultFlows){
		if(StringUtil.isNotBlank(doctorFlow)){
			ResDoctor doctor = doctorBiz.readDoctor(doctorFlow);
			SysUser operUser = GlobalContext.getCurrentUser();
			
			//重置状态
			doctor.setSchFlag(GlobalConstant.FLAG_N);
			doctor.setSchStatusId("");
			doctor.setSchStatusName("");
			doctorBiz.editDoctor(doctor);
			
			SchArrange arrange = new SchArrange();
			arrange.setArrangeFlow(PkUtil.getUUID());
			arrange.setDoctorNum(1);
			arrange.setOperTime(DateUtil.getCurrDateTime());
			arrange.setOperUserFlow(operUser.getUserFlow());
			arrange.setOperUserName(operUser.getUserName());
			arrange.setArrangeTypeId(SchArrangeTypeEnum.Hand.getId());
			arrange.setArrangeTypeName(SchArrangeTypeEnum.Hand.getName());
			arrange.setArrangeStatusId(SchArrangeStatusEnum.Finish.getId());
			arrange.setArrangeStatusName(SchArrangeStatusEnum.Finish.getName());
			arrange.setOrgFlow(doctor.getOrgFlow());
			arrange.setOrgName(doctor.getOrgName());
			arrangeBiz.saveArrange(arrange);
			
			if(doctor!=null){
				if(addSchDeptFlows!=null && addSchDeptFlows.length>0){
					List<String> schDeptFlows = new ArrayList<String>();
					for(String flow : addSchDeptFlows){
						schDeptFlows.add(flow);
					}
					List<SchDept> schDeptList = schDeptBiz.searchDeptByFlows(schDeptFlows);
					if(schDeptList!=null && schDeptList.size()>0){
						SchArrangeResult result = new SchArrangeResult();
						result.setArrangeFlow(arrange.getArrangeFlow());
						result.setDoctorFlow(doctor.getDoctorFlow());
						result.setDoctorName(doctor.getDoctorName());
						result.setSessionNumber(doctor.getSessionNumber());
						result.setSchYear(doctor.getSessionNumber());
						for(SchDept schDept : schDeptList){
							result.setResultFlow(null);
							result.setSchDeptFlow(schDept.getSchDeptFlow());
							result.setSchDeptName(schDept.getSchDeptName());
							result.setDeptFlow(schDept.getDeptFlow());
							result.setDeptName(schDept.getDeptName());
							saveSchArrangeResult(result);
						}
					}
				}
				
				if(delResultFlows!=null && delResultFlows.length>0){
					SchArrangeResult result = new SchArrangeResult();
					result.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
					for(String flow : delResultFlows){
						result.setResultFlow(flow);
						saveSchArrangeResult(result);
					}
				}
			}
		}
		
		return GlobalConstant.ONE_LINE;
	}
	
	@Override
	public int saveGroupResult(List<SchArrangeResult> resultList,String groupId,SysUser operUser){
		if(groupId!=null && operUser!=null && resultList!=null && resultList.size()>0){
			//获取组员
			ResDoctor searchDoctor = new ResDoctor();
			searchDoctor.setGroupId(groupId);
			searchDoctor.setOrgFlow(operUser.getOrgFlow());
			searchDoctor.setDoctorCategoryId(RecDocCategoryEnum.Intern.getId());
			List<ResDoctor> doctorList = doctorBiz.searchByDoc(searchDoctor);
			if(doctorList!=null && doctorList.size()>0){
				//留痕数据
				SchArrange arrange = new SchArrange();
				arrange.setArrangeFlow(PkUtil.getUUID());
				arrange.setDoctorNum(doctorList.size());
				arrange.setOperTime(DateUtil.getCurrDateTime());
				arrange.setOperUserFlow(operUser.getUserFlow());
				arrange.setOperUserName(operUser.getUserName());
				arrange.setArrangeTypeId(SchArrangeTypeEnum.Hand.getId());
				arrange.setArrangeTypeName(SchArrangeTypeEnum.Hand.getName());
				arrange.setArrangeStatusId(SchArrangeStatusEnum.Finish.getId());
				arrange.setArrangeStatusName(SchArrangeStatusEnum.Finish.getName());
				arrange.setOrgFlow(operUser.getOrgFlow());
				arrange.setOrgName(operUser.getOrgName());
				arrangeBiz.saveArrange(arrange);
				
				//获取规则详情
				List<String> recordFlows = new ArrayList<String>();
				for(SchArrangeResult result : resultList){
					recordFlows.add(result.getResultFlow());
				}
				List<SchRotationDept> rotationDeptList = rotationDeptBiz.searchRotationDeptByFlows(recordFlows);
				if(rotationDeptList!=null && rotationDeptList.size()>0){
					Map<String,SchRotationDept> rotationDeptMap = new HashMap<String, SchRotationDept>();
					List<SchDoctorDept> doctorDeptList = new ArrayList<SchDoctorDept>();
					for(SchRotationDept rotationDept : rotationDeptList){
						rotationDeptMap.put(rotationDept.getRecordFlow(),rotationDept);
						
						//记录选科科室
						if(!GlobalConstant.FLAG_Y.equals(rotationDept.getIsRequired())){
							SchDoctorDept doctorDept = new SchDoctorDept();
							doctorDept.setGroupFlow(rotationDept.getGroupFlow());
							doctorDept.setSchMonth(rotationDept.getSchMonth());
							doctorDept.setSchDeptFlow(rotationDept.getSchDeptFlow());
							doctorDept.setSchDeptName(rotationDept.getSchDeptName());
							doctorDept.setDeptFlow(rotationDept.getDeptFlow());
							doctorDept.setDeptName(rotationDept.getDeptName());
							doctorDept.setOrgFlow(rotationDept.getOrgFlow());
							doctorDept.setOrgName(rotationDept.getOrgName());
							doctorDept.setStandardDeptId(rotationDept.getStandardDeptId());
							doctorDept.setStandardDeptName(rotationDept.getStandardDeptName());
							doctorDept.setIsRequired(rotationDept.getIsRequired());
							
							doctorDeptList.add(doctorDept);
						}
					}
					
					//为每个组员保存计划
					for(ResDoctor doctor : doctorList){
						int order = 0;
						
						//为医师创建选科数据
						for(SchDoctorDept doctorDept : doctorDeptList){
							doctorDept.setDoctorFlow(doctor.getDoctorFlow());
							doctorDept.setDoctorName(doctor.getDoctorName());
							doctorDept.setRotationFlow(doctor.getRotationFlow());
							doctorDept.setRotationName(doctor.getRotationName());
							doctorDept.setSessionNumber(doctor.getSessionNumber());
							
							doctroDeptBiz.save(doctorDept);
						}
						
						for(SchArrangeResult resultTemp : resultList){
							//为医师创建排班数据
							SchRotationDept rotationDept = rotationDeptMap.get(resultTemp.getResultFlow());
							SchArrangeResult result = new SchArrangeResult();
							result.setArrangeFlow(arrange.getArrangeFlow());
							result.setDoctorFlow(doctor.getDoctorFlow());
							result.setDoctorName(doctor.getDoctorName());
							result.setSessionNumber(doctor.getSessionNumber());
							result.setRotationFlow(doctor.getRotationFlow());
							result.setRotationName(doctor.getRotationName());
							result.setSchDeptOrder(BigDecimal.valueOf(order++));
							result.setDeptFlow(rotationDept.getDeptFlow());
							result.setDeptName(rotationDept.getDeptName());
							result.setSchDeptFlow(rotationDept.getSchDeptFlow());
							result.setSchDeptName(rotationDept.getSchDeptName());
							result.setOrgFlow(doctor.getOrgFlow());
							result.setOrgName(doctor.getOrgName());
							result.setIsRequired(rotationDept.getIsRequired());
							result.setStandardDeptId(rotationDept.getStandardDeptId());
							result.setStandardDeptName(rotationDept.getStandardDeptName());
							result.setGroupFlow(rotationDept.getGroupFlow());
							result.setSchYear(resultTemp.getSchYear());
							result.setSchMonth(resultTemp.getSchMonth());
							result.setSchStartDate(resultTemp.getSchStartDate());
							result.setSchEndDate(resultTemp.getSchEndDate());
							saveSchArrangeResult(result);
							
							//更新医师选科排班状态
							doctor.setSchFlag(GlobalConstant.FLAG_Y);
							doctor.setSelDeptFlag(GlobalConstant.FLAG_Y);
							doctorBiz.editDoctor(doctor);
						}
					}
					
					return GlobalConstant.ONE_LINE;
				}
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
}
