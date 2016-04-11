package com.pinde.sci.biz.sch.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.iterators.PermutationIterator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StatisticsUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sch.ISchArrangeBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.ResDoctorMapper;
import com.pinde.sci.dao.base.SchArrangeDoctorDeptMapper;
import com.pinde.sci.dao.base.SchArrangeDoctorMapper;
import com.pinde.sci.dao.base.SchArrangeMapper;
import com.pinde.sci.dao.base.SchArrangeResultMapper;
import com.pinde.sci.dao.base.SchDoctorDeptMapper;
import com.pinde.sci.dao.base.SchRotationDeptMapper;
import com.pinde.sci.dao.base.SchRotationGroupMapper;
import com.pinde.sci.dao.sch.SchDoctorDeptExtMapper;
import com.pinde.sci.enums.sch.SchArrangeStatusEnum;
import com.pinde.sci.enums.sch.SchArrangeTypeEnum;
import com.pinde.sci.enums.sch.SchStageEnum;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorExample;
import com.pinde.sci.model.mo.SchArrange;
import com.pinde.sci.model.mo.SchArrangeDoctor;
import com.pinde.sci.model.mo.SchArrangeDoctorDept;
import com.pinde.sci.model.mo.SchArrangeDoctorDeptExample;
import com.pinde.sci.model.mo.SchArrangeExample;
import com.pinde.sci.model.mo.SchArrangeResult;
import com.pinde.sci.model.mo.SchArrangeResultExample;
import com.pinde.sci.model.mo.SchDoctorDept;
import com.pinde.sci.model.mo.SchDoctorDeptExample;
import com.pinde.sci.model.mo.SchRotationDept;
import com.pinde.sci.model.mo.SchRotationDeptExample;
import com.pinde.sci.model.mo.SchRotationGroup;
import com.pinde.sci.model.mo.SchRotationGroupExample;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor=Exception.class)
public class SchArrangeBizImpl implements ISchArrangeBiz {
	@Autowired
	private SchArrangeMapper arrangeMapper;
	@Autowired
	private ResDoctorMapper doctorMapper;
	@Autowired
	private SchArrangeDoctorMapper arrangeDoctorMapper;
	@Autowired
	private SchDoctorDeptMapper doctorDeptMapper;
	@Autowired
	private SchArrangeDoctorDeptMapper arrangeDoctorDeptMapper;
	@Autowired
	private SchRotationDeptMapper rotationDeptMapper;
	@Autowired
	private SchArrangeResultMapper schArrangeResultMapper;
	@Autowired
	private SchRotationGroupMapper rotationGroupMapper;

	@Override
	public List<SchArrange> searchSchArrange(String orgFLow) {
		SchArrangeExample example = new SchArrangeExample();
		example.createCriteria()
		.andOrgFlowEqualTo(orgFLow)
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("OPER_TIME DESC");
		return arrangeMapper.selectByExample(example);
	}

	@Override
	public void rostering(String beginDate) {
		final SysUser currUser = GlobalContext.getCurrentUser();
		//待排班医师-选科结束未排班
		final List<ResDoctor> doctorList = searchCouldSchDoctor(currUser.getOrgFlow());
		//排班记录
		final SchArrange arrange = new SchArrange();
		arrange.setArrangeFlow(PkUtil.getUUID());
		arrange.setBeginDate(beginDate);
		arrange.setDoctorNum(doctorList.size());
		arrange.setOperTime(DateUtil.getCurrDateTime());
		arrange.setOperUserFlow(GlobalContext.getCurrentUser().getUserFlow());
		arrange.setOperUserName(GlobalContext.getCurrentUser().getUserName());
		arrange.setArrangeTypeId(SchArrangeTypeEnum.Auto.getId());
		arrange.setArrangeTypeName(SchArrangeTypeEnum.Auto.getName());
		arrange.setArrangeStatusId(SchArrangeStatusEnum.Process.getId());
		arrange.setArrangeStatusName(SchArrangeStatusEnum.Process.getName());
		arrange.setOrgFlow(currUser.getOrgFlow());
		arrange.setOrgName(currUser.getOrgName());
		GeneralMethod.setRecordInfo(arrange, true);
		arrangeMapper.insert(arrange);
		//记录人员及人员排班的信息
		_arrangeDoctorAndDept(arrange, doctorList,currUser);
		new Thread(new Runnable() {
			
			@Override
			public void run() {
				//智能排班
				_processDoctor(arrange, doctorList,currUser);				
			}
		}).start();
	}
	
	private void _arrangeDoctorAndDept(SchArrange arrange,List<ResDoctor> doctorList,SysUser currUser){
		SchRotationGroupExample exampleSRG = new SchRotationGroupExample();
		exampleSRG.createCriteria().andOrgFlowEqualTo(currUser.getOrgFlow());//.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<SchRotationGroup> schRotationGroupList = rotationGroupMapper.selectByExample(exampleSRG);
		Map<String,SchRotationGroup>schRotationGroupMap = new HashMap<String,SchRotationGroup>();
		for(SchRotationGroup schRotationGroup : schRotationGroupList){
			schRotationGroupMap.put(schRotationGroup.getGroupFlow(), schRotationGroup);
		}
		//记录医师留痕
		for(ResDoctor doctor : doctorList){
			SchArrangeDoctor arrangeDoctor = new SchArrangeDoctor();
			arrangeDoctor.setArrDocFlow(PkUtil.getUUID());
			arrangeDoctor.setArrangeFlow(arrange.getArrangeFlow());
			arrangeDoctor.setDoctorFlow(doctor.getDoctorFlow());
			arrangeDoctor.setDoctorName(doctor.getDoctorName());
			arrangeDoctor.setRotationFlow(doctor.getRotationFlow());
			arrangeDoctor.setRotationName(doctor.getRotationName());
			GeneralMethod.setRecordInfo(arrangeDoctor, true);
			arrangeDoctor.setOrgFlow(currUser.getOrgFlow());
			arrangeDoctor.setOrgName(currUser.getOrgName());
			arrangeDoctorMapper.insert(arrangeDoctor);
			
			List<SchArrangeDoctorDept> arrangeDoctorDeptList =  new ArrayList<SchArrangeDoctorDept>();
			
			//记录必轮科室留痕
			String rotationFlow = doctor.getRotationFlow();
			
			List<SchRotationDept> rotationDeptList =  searchRotationDept(rotationFlow,currUser.getOrgFlow());
			for(SchRotationDept rotationDept :rotationDeptList){
				SchArrangeDoctorDept arrangeDocDept = new SchArrangeDoctorDept();
				arrangeDocDept.setArrDocDeptFlow(PkUtil.getUUID());
				arrangeDocDept.setArrangeFlow(arrange.getArrangeFlow());
				arrangeDocDept.setDoctorFlow(doctor.getDoctorFlow());
				arrangeDocDept.setDoctorName(doctor.getDoctorName());
				arrangeDocDept.setDeptFlow(rotationDept.getDeptFlow()); 
				arrangeDocDept.setDeptName(rotationDept.getDeptName());
				
				SchRotationGroup schRotationGroup = schRotationGroupMap.get(rotationDept.getGroupFlow());
				arrangeDocDept.setGroupFlow(rotationDept.getGroupFlow());
				arrangeDocDept.setGroupName(schRotationGroup.getGroupName());
				arrangeDocDept.setSchStageId(schRotationGroup.getSchStageId());
				arrangeDocDept.setSchStageName(schRotationGroup.getSchStageName());
				
				arrangeDocDept.setSchDeptFlow(rotationDept.getSchDeptFlow());
				arrangeDocDept.setSchDeptName(rotationDept.getSchDeptName());
				arrangeDocDept.setSchMonth(rotationDept.getSchMonth());
				arrangeDocDept.setOrgFlow(currUser.getOrgFlow());
				arrangeDocDept.setOrgName(currUser.getOrgName());
				arrangeDocDept.setIsRequired(rotationDept.getIsRequired());
				arrangeDocDept.setStandardGroupFlow(schRotationGroup.getStandardGroupFlow());
				arrangeDocDept.setStandardDeptId(rotationDept.getStandardDeptId());
				arrangeDocDept.setStandardDeptName(rotationDept.getStandardDeptName());
				GeneralMethod.setRecordInfo(arrangeDocDept, true);
				arrangeDoctorDeptMapper.insert(arrangeDocDept);
				arrangeDoctorDeptList.add(arrangeDocDept);
			}
			
			//记录医师选科留痕
			//医师已选科记录
			SchDoctorDeptExample example = new SchDoctorDeptExample();
			example.createCriteria()
			.andDoctorFlowEqualTo(doctor.getDoctorFlow())
			.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			
			List<SchDoctorDept> doctorDeptList = doctorDeptMapper.selectByExample(example);
			if(doctorDeptList!=null){
				for(SchDoctorDept schDoctorDept : doctorDeptList){
					SchArrangeDoctorDept arrangeDocDept = new SchArrangeDoctorDept();
					arrangeDocDept.setArrDocDeptFlow(PkUtil.getUUID());
					arrangeDocDept.setArrangeFlow(arrange.getArrangeFlow());
					arrangeDocDept.setDoctorFlow(doctor.getDoctorFlow());
					arrangeDocDept.setDoctorName(doctor.getDoctorName());
					arrangeDocDept.setDeptFlow(schDoctorDept.getDeptFlow()); 
					arrangeDocDept.setDeptName(schDoctorDept.getDeptName());
					
					SchRotationGroup schRotationGroup = schRotationGroupMap.get(schDoctorDept.getGroupFlow());
					arrangeDocDept.setGroupFlow(schDoctorDept.getGroupFlow());
					arrangeDocDept.setGroupName(schRotationGroup.getGroupName());
					arrangeDocDept.setSchStageId(schRotationGroup.getSchStageId());
					arrangeDocDept.setSchStageName(schRotationGroup.getSchStageName());
					
					arrangeDocDept.setSchDeptFlow(schDoctorDept.getSchDeptFlow());
					arrangeDocDept.setSchDeptName(schDoctorDept.getSchDeptName());
					arrangeDocDept.setSchMonth(schDoctorDept.getSchMonth());
					arrangeDocDept.setOrgFlow(currUser.getOrgFlow());
					arrangeDocDept.setOrgName(currUser.getOrgName());

					arrangeDocDept.setIsRequired(schDoctorDept.getIsRequired());
					arrangeDocDept.setStandardGroupFlow(schRotationGroup.getStandardGroupFlow());
					arrangeDocDept.setStandardDeptId(schDoctorDept.getStandardDeptId());
					arrangeDocDept.setStandardDeptName(schDoctorDept.getStandardDeptName());
					
					GeneralMethod.setRecordInfo(arrangeDocDept, true);
					arrangeDoctorDeptMapper.insert(arrangeDocDept);
					arrangeDoctorDeptList.add(arrangeDocDept);
				}
			}
		}
	}
	
	private double [][] _arrageDept(SchArrange arrange,ResDoctor doctor,
			List<SchArrangeDoctorDept> arrangeDoctorDeptList,List<String> allSchDeptList,
			List<String> allSchDateList,
			SysUser currUser){
		String resRotationUnit = StringUtil.defaultIfEmpty(InitConfig.getSysCfg("res_rotation_unit"),"Month");
		String firthStartYear = DateUtil.transDateTime(arrange.getBeginDate(), DateUtil.defDtPtn04, "yyyy");
		
		SchArrangeResultExample example = new SchArrangeResultExample();
		com.pinde.sci.model.mo.SchArrangeResultExample.Criteria criteria = example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andOrgFlowEqualTo(currUser.getOrgFlow());
		criteria.andSchYearGreaterThanOrEqualTo(firthStartYear);
		List<SchArrangeResult> schArrangeResultList = schArrangeResultMapper.selectByExample(example);

		Map<String,Integer> schDeptCountMap = new HashMap<String,Integer>();
		for(SchArrangeResult schArrangeResult : schArrangeResultList){
			String schDeptFlow = schArrangeResult.getSchDeptFlow();
			String schStartDate = schArrangeResult.getSchStartDate();
			String schEndDate = schArrangeResult.getSchEndDate();
			String processDate = schStartDate;
			do{
				String interval = schDeptFlow+"_"+processDate;
				Integer deptCount  = schDeptCountMap.get(interval);
				if(deptCount==null){
					deptCount = new Integer(0);
				}
				deptCount = deptCount+1;
				schDeptCountMap.put(interval,deptCount);
				int signDays = (int) DateUtil.signDaysBetweenTowDate(schEndDate,processDate);
				if(signDays<=0){
					break;
				}
				processDate = DateUtil.addDate(processDate, 1);	
			}while(true);
		}
		
		float doctorTotalSchMonth  = 0;
		for(SchArrangeDoctorDept arrangeDocDept : arrangeDoctorDeptList){
			float tmp = Float.parseFloat(arrangeDocDept.getSchMonth());
			doctorTotalSchMonth += tmp;
			if(!allSchDeptList.contains(arrangeDocDept.getSchDeptFlow())){
				allSchDeptList.add(arrangeDocDept.getSchDeptFlow());
			}
		}
		
		String startDate = arrange.getBeginDate();
		String endDate = arrange.getBeginDate();
		
		if("Month".equals(resRotationUnit)){
			endDate = DateUtil.addMonthForArrange(arrange.getBeginDate(), doctorTotalSchMonth+"");
		}
		if("Week".equals(resRotationUnit)){
			endDate = DateUtil.addDate(arrange.getBeginDate(), (int)doctorTotalSchMonth*7-1);
		}
		int totalDays = (int) DateUtil.signDaysBetweenTowDate(endDate,startDate)+1;
		
		double [][] old = new double[allSchDeptList.size()][totalDays];
		
		{
			String processDate = startDate;
			do{
				allSchDateList.add(processDate);
				int signDays = (int) DateUtil.signDaysBetweenTowDate(endDate,processDate);
				if(signDays<=0){
					break;
				}
				processDate = DateUtil.addDate(processDate, 1);	
			}while(true);
		}
		
		int i=0;
		
		for(String schDeptFlow : allSchDeptList){
			int j = 0;

			String processDate = startDate;
			do{
				String interval = schDeptFlow+"_"+processDate;
				Integer deptCount  = schDeptCountMap.get(interval);
				if(deptCount==null){
					deptCount = new Integer(0);
				}
				old[i][j++] = deptCount.doubleValue();
				int signDays = (int) DateUtil.signDaysBetweenTowDate(endDate,processDate);
				if(signDays<=0){
					break;
				}
				processDate = DateUtil.addDate(processDate, 1);	
			}while(true);
			i++;
		}
		_printArray(old);
		return old;
	}
	
	private void _processDoctor(SchArrange arrange,List<ResDoctor> doctorList,SysUser currUser){
		for(int d=0;d<doctorList.size();d++){
			ResDoctor doctor = doctorList.get(d);
			
			//删除已经存在的排班
			SchArrangeResultExample example2 = new SchArrangeResultExample();
			example2.createCriteria().andDoctorFlowEqualTo(doctor.getDoctorFlow());//.andArrangeFlowNotEqualTo(arrangeFlow);
			
			SchArrangeResult resultUpdate = new SchArrangeResult();
			resultUpdate.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			schArrangeResultMapper.updateByExampleSelective(resultUpdate, example2);
			
			SchArrangeDoctorDeptExample exampleSdd = new SchArrangeDoctorDeptExample();
			exampleSdd.createCriteria().andDoctorFlowEqualTo(doctor.getDoctorFlow())
			.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			
			List<SchArrangeDoctorDept> arrangeDoctorDeptList = arrangeDoctorDeptMapper.selectByExample(exampleSdd);
			List<String> allSchDeptList = new LinkedList<String>();
			List<String> allSchDateList = new LinkedList<String>();
			double [][] old = _arrageDept(arrange, doctor,arrangeDoctorDeptList,allSchDeptList,allSchDateList, currUser);
			if(d==0){
				SchArrange update = new SchArrange();
				update.setArrangeFlow(arrange.getArrangeFlow());
				update.setBeginIndex(StatisticsUtil.arrange(old)+"");
				arrangeMapper.updateByPrimaryKeySelective(update);
			}
			//获得医生所有的科室（必选+可选）
			List<SchArrangeDoctorDept> arrDocDeptList1 = new ArrayList<SchArrangeDoctorDept>();
			List<SchArrangeDoctorDept> arrDocDeptList2 = new ArrayList<SchArrangeDoctorDept>();
			List<SchArrangeDoctorDept> arrDocDeptList3 = new ArrayList<SchArrangeDoctorDept>();
			for(SchArrangeDoctorDept arraryDoctorDept : arrangeDoctorDeptList){
				//第一阶段
				if(StringUtil.isBlank(arraryDoctorDept.getSchStageId())){
					if(StringUtil.isNotBlank(arraryDoctorDept.getSchMonth())){
						arrDocDeptList1.add(arraryDoctorDept);
					}
				}
				if(SchStageEnum.FirstStage.getId().equals(arraryDoctorDept.getSchStageId())){
					if(StringUtil.isNotBlank(arraryDoctorDept.getSchMonth())){
						arrDocDeptList1.add(arraryDoctorDept);
					}
				}
				//第二阶段
				if(SchStageEnum.SecondStage.getId().equals(arraryDoctorDept.getSchStageId())){
					if(StringUtil.isNotBlank(arraryDoctorDept.getSchMonth())){
						arrDocDeptList2.add(arraryDoctorDept);
					}
				}
				//第三阶段
				if(SchStageEnum.ThirdStage.getId().equals(arraryDoctorDept.getSchStageId())){
					if(StringUtil.isNotBlank(arraryDoctorDept.getSchMonth())){
						arrDocDeptList3.add(arraryDoctorDept);
					}
				}
			}
			
			List<List<SchArrangeDoctorDept>> allArrDocDeptListList  =new ArrayList<List<SchArrangeDoctorDept>>();
			allArrDocDeptListList.addAll(splitArrDept(arrDocDeptList1));
			allArrDocDeptListList.addAll(splitArrDept(arrDocDeptList2));
			allArrDocDeptListList.addAll(splitArrDept(arrDocDeptList3));

			String schStartDate = arrange.getBeginDate();
			int startInterval = 0;
			for(Iterator<List<SchArrangeDoctorDept>> it = allArrDocDeptListList.iterator();it.hasNext();){
				List<SchArrangeDoctorDept> arrDocDeptList = it.next();
				String schEndDate = _processDoctorDept(arrange, doctor,schStartDate,startInterval,arrDocDeptList,allSchDeptList,allSchDateList,currUser,old);
				schStartDate = DateUtil.addDate(schEndDate,1);
				startInterval +=arrDocDeptList.size();
			}
			if(d==doctorList.size()-1){
				SchArrange update = new SchArrange();
				update.setArrangeFlow(arrange.getArrangeFlow());
				update.setEndIndex(StatisticsUtil.arrange(old)+"");
				arrangeMapper.updateByPrimaryKeySelective(update);
			}
			ResDoctor update = new ResDoctor();
			update.setDoctorFlow(doctor.getDoctorFlow());
			update.setSchFlag(GlobalConstant.RECORD_STATUS_Y);
			doctorMapper.updateByPrimaryKeySelective(update);
		}
		SchArrange update = new SchArrange();
		update.setArrangeFlow(arrange.getArrangeFlow());
//		update.setEndIndex(StatisticsUtil.arrange(old)+"");
		update.setArrangeStatusId(SchArrangeStatusEnum.Finish.getId());
		update.setArrangeStatusName(SchArrangeStatusEnum.Finish.getName());
		arrangeMapper.updateByPrimaryKeySelective(update);
	}
	
	public int MaxSchDeptNums = 8;
	
	public List<List<SchArrangeDoctorDept>> splitArrDept(List<SchArrangeDoctorDept> arrDocDeptList){
		ArrayList<List<SchArrangeDoctorDept>> result=new ArrayList<List<SchArrangeDoctorDept>>();
		List<SchArrangeDoctorDept> temp = new ArrayList<SchArrangeDoctorDept>();
		while(arrDocDeptList.size()>0){
			int r=(int)(Math.random()*arrDocDeptList.size());
			temp.add(arrDocDeptList.remove(r));
			if(temp.size()==MaxSchDeptNums){
				result.add(temp);
				temp = new ArrayList<SchArrangeDoctorDept>();
			}
		}
		if(temp.size()>0){
			result.add(temp);
		}
		return result;
	}

	private String _processDoctorDept(SchArrange arrange,ResDoctor doctor,String schStartDate,int startInterval,
			List<SchArrangeDoctorDept> arrDocDeptList,List<String> allSchDeptList,List<String> allSchDateList,
			SysUser currUser,double [][] old){
		String resRotationUnit = StringUtil.defaultIfEmpty(InitConfig.getSysCfg("res_rotation_unit"),"Month");
		//医生最大的排班数量
		List<String> arrDocDeptFlowList = new LinkedList<String>();
		Map<String,SchArrangeDoctorDept> arrangeDoctorDeptMap = new HashMap<String, SchArrangeDoctorDept>();
		for(SchArrangeDoctorDept arrangeDoctorDept : arrDocDeptList){
			arrDocDeptFlowList.add(arrangeDoctorDept.getArrDocDeptFlow());
			arrangeDoctorDeptMap.put(arrangeDoctorDept.getArrDocDeptFlow(), arrangeDoctorDept);
		}

		double doctorIndex = Double.MAX_VALUE;
		List<String> bestArrDocDeptFlowArray = null;
		int order = 0;
		Iterator<List<String>> it = new PermutationIterator<String>(arrDocDeptFlowList);
		while (it.hasNext()) {
			List<String> arrDocDeptFlowArray = it.next();
			
			double[][] newArray = _copyArray(old);
			
			String startDate = schStartDate;
			String endDate  =schStartDate;
			for(int i=0;i<arrDocDeptFlowArray.size();i++){
				String arrDocDeptFlow = arrDocDeptFlowArray.get(i);

				String schDeptFlow = arrangeDoctorDeptMap.get(arrDocDeptFlow).getSchDeptFlow();
				float schMonth = Float.parseFloat(StringUtil.defaultIfEmpty(arrangeDoctorDeptMap.get(arrDocDeptFlow).getSchMonth(), "0.0"));
				int oriDeptIndex = allSchDeptList.indexOf(schDeptFlow);
				if("Month".equals(resRotationUnit)){
					endDate = DateUtil.addMonthForArrange(startDate, schMonth+"");
				}
				if("Week".equals(resRotationUnit)){
					endDate = DateUtil.addDate(startDate, (int)schMonth*7-1);
				}
				String processDate = startDate;
				do{
					int oriDateIndex = allSchDateList.indexOf(processDate);
					newArray[oriDeptIndex][oriDateIndex] += 1;
					int signDays = (int) DateUtil.signDaysBetweenTowDate(endDate,processDate);
					if(signDays<=0){
						break;
					}
					processDate = DateUtil.addDate(processDate, 1);	
				}while(true);
				startDate = DateUtil.addDate(processDate, 1);
			}
//			_printArray(newArray);
			double index = StatisticsUtil.arrange(newArray);
			if(index<doctorIndex){
				bestArrDocDeptFlowArray = arrDocDeptFlowArray;
				doctorIndex = index;
			}
			double oldIndex = StatisticsUtil.arrange(old);
			if(oldIndex==0d){
				break;
			}
			order++;
		}
		
		String schYear = DateUtil.transDateTime(schStartDate, DateUtil.defDtPtn04, "yyyy");
		//最佳方案
		//记录最佳方案后的old值
		String startDate = schStartDate;
		String endDate  =schStartDate;
		for(int i=0;i<bestArrDocDeptFlowArray.size();i++){
			String arrDocDeptFlow = bestArrDocDeptFlowArray.get(i);
			SchArrangeDoctorDept arrangeDoctorDept = arrangeDoctorDeptMap.get(arrDocDeptFlow);
			
			String schDeptFlow = arrangeDoctorDept.getSchDeptFlow();
			float schMonth = Float.parseFloat(arrangeDoctorDept.getSchMonth());
			int oriDeptIndex = allSchDeptList.indexOf(schDeptFlow);
			
			if("Month".equals(resRotationUnit)){
				endDate = DateUtil.addMonthForArrange(startDate, schMonth+"");
			}
			if("Week".equals(resRotationUnit)){
				endDate = DateUtil.addDate(startDate, (int)schMonth*7-1);
			}
			String processDate = startDate;
			do{
				int oriDateIndex = allSchDateList.indexOf(processDate);
				old[oriDeptIndex][oriDateIndex] += 1;
				int signDays = (int) DateUtil.signDaysBetweenTowDate(endDate,processDate);
				if(signDays<=0){
					break;
				}
				processDate = DateUtil.addDate(processDate, 1);	
			}while(true);
			
			//记录排班结构
			SchArrangeResult sar = new SchArrangeResult();
			sar.setResultFlow(PkUtil.getUUID());
			sar.setArrangeFlow(arrange.getArrangeFlow());
			sar.setDoctorFlow(doctor.getDoctorFlow());
			sar.setDoctorName(doctor.getDoctorName());
			sar.setSessionNumber(doctor.getSessionNumber());
			sar.setRotationFlow(doctor.getRotationFlow());
			sar.setRotationName(doctor.getRotationName());
			sar.setSchYear(schYear);
			sar.setSchDeptOrder(new BigDecimal((startInterval+i+1)));
			sar.setSchStartDate(startDate);
			sar.setSchEndDate(endDate);
			sar.setDeptFlow(arrangeDoctorDept.getDeptFlow());
			sar.setDeptName(arrangeDoctorDept.getDeptName());
			sar.setSchDeptFlow(arrangeDoctorDept.getSchDeptFlow());
			sar.setSchDeptName(arrangeDoctorDept.getSchDeptName());
			sar.setIsRequired(arrangeDoctorDept.getIsRequired());
			sar.setGroupFlow(arrangeDoctorDept.getGroupFlow());
			sar.setStandardGroupFlow(arrangeDoctorDept.getStandardGroupFlow());
			sar.setStandardDeptId(arrangeDoctorDept.getStandardDeptId());
			sar.setStandardDeptName(arrangeDoctorDept.getStandardDeptName());
			
			GeneralMethod.setRecordInfo(sar, true);
			
			sar.setOrgFlow(arrangeDoctorDept.getOrgFlow());
			sar.setOrgName(arrangeDoctorDept.getOrgName());
			
			sar.setSchMonth(schMonth+"");
			schArrangeResultMapper.insert(sar);
			
			startDate = DateUtil.addDate(processDate, 1);
		}
//		_printArray(old);
		return endDate;
	}
	
	private double[][] _copyArray(double[][] strArray){
		double[][] copyArray=new double[strArray.length][];
		for(int i=0;i<strArray.length;i++){
			copyArray[i]=new double[strArray[i].length];
			System.arraycopy(strArray[i], 0, copyArray[i], 0, strArray[i].length);
		}
		return copyArray;
	}
	
	private void _printArray(double[][] intArray){
//		for(double ttt [] : intArray){
//			for(double t : ttt){
//				System.err.print(t+" ");
//			}
//			System.err.println("");
//		}
		System.err.println(StatisticsUtil.arrange(intArray));
	}

	private List<SchRotationDept> searchRotationDept(String rotationFlow,String orgFlow) {
		SchRotationDeptExample example = new SchRotationDeptExample();
		example.createCriteria().andOrgFlowEqualTo(orgFlow).andRotationFlowEqualTo(rotationFlow).andIsRequiredEqualTo(GlobalConstant.FLAG_Y).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return rotationDeptMapper.selectByExample(example);
	}

	@Override
	public List<ResDoctor> searchUnSchDoctor(String orgFlow) {
		ResDoctorExample example = new ResDoctorExample();
		com.pinde.sci.model.mo.ResDoctorExample.Criteria creater = example.createCriteria();
		creater.andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andSchFlagEqualTo(GlobalConstant.FLAG_N);
		return doctorMapper.selectByExample(example); 
	}
	@Override
	public List<ResDoctor> searchCouldSchDoctor(String orgFlow) {
		ResDoctorExample example = new ResDoctorExample();
		example.createCriteria().andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andSchFlagEqualTo(GlobalConstant.FLAG_N).andSelDeptFlagEqualTo(GlobalConstant.FLAG_Y);
		return doctorMapper.selectByExample(example);
	}

	@Override
	public SchArrange readArrange(String arrangeFlow) {
		return arrangeMapper.selectByPrimaryKey(arrangeFlow);
	}
	
	@Override
	public void modifyArrange(SchArrange arrange) {
		arrangeMapper.updateByPrimaryKeySelective(arrange);
	} 
	
	@Override
	public int saveArrange(SchArrange arrange){
		GeneralMethod.setRecordInfo(arrange, true);
		return arrangeMapper.insertSelective(arrange);
	};
}
