package com.pinde.sci.biz.edc.impl;




import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.sci.biz.edc.IInspectBiz;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.EdcDcfMapper;
import com.pinde.sci.dao.base.EdcQueryMapper;
import com.pinde.sci.dao.base.EdcVisitDataEventMapper;
import com.pinde.sci.dao.edc.EdcPatientVisitExtMapper;
import com.pinde.sci.dao.edc.EdcQueryExtMapper;
import com.pinde.sci.enums.edc.EdcQueryStatusEnum;
import com.pinde.sci.enums.edc.EdcSdvStatusEnum;
import com.pinde.sci.model.mo.EdcDcf;
import com.pinde.sci.model.mo.EdcDcfExample;
import com.pinde.sci.model.mo.EdcQuery;
import com.pinde.sci.model.mo.EdcQueryExample;
import com.pinde.sci.model.mo.EdcVisitDataEvent;
import com.pinde.sci.model.mo.EdcVisitDataEventExample;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubProjOrg;


@Service
@Transactional(rollbackFor=Exception.class)
public class InspectBizImpl implements IInspectBiz{
	@Resource
	private EdcQueryMapper queryMapper;
	@Resource
	private EdcVisitDataEventMapper dataEventMapper;
	@Resource
	private EdcQueryExtMapper queryExtMapper;
	@Resource
	private EdcDcfMapper dcfMapper;
	@Resource
	private EdcPatientVisitExtMapper edcPatientVisitExtMapper;
	@Autowired
	private IProjOrgBiz projOrgBiz;
	
	
	@Override
	public void addEdcQuery(EdcQuery query, EdcVisitDataEvent dataEvent) {
		addEdcQuery(query);
		
		addVisitDataEvent(dataEvent);
	}

	private void addEdcQuery(EdcQuery query) {
		GeneralMethod.setRecordInfo(query, true);
		queryMapper.insert(query);
	}

	@Override
	public List<EdcQuery> searchEdcQuery(EdcQueryExample example) {
		return queryMapper.selectByExample(example);
	}
	
	private List<EdcQuery> searchEdcQuerySended(String projFlow) {
		EdcQueryExample example = new EdcQueryExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andQueryStatusIdEqualTo(EdcQueryStatusEnum.Sended.getId());
		return queryMapper.selectByExample(example);
	}
	
	@Override
	public Map<String,Integer> searchEdcQuery(String projFlow){
		List<EdcQuery> querySendedList = searchEdcQuerySended(projFlow);
		Map<String,Integer> queryMap = new HashMap<String,Integer>();
		for(EdcQuery query : querySendedList){
			String orgFlow = query.getOrgFlow();
			String sendWayId = query.getSendWayId();
			String solvedId = query.getSolveStatusId();
			String queryStatusId = query.getQueryStatusId();
			//根据发送方式
			if(queryMap.get(sendWayId) == null){
				queryMap.put(sendWayId, 1);
			}else{
				queryMap.put(sendWayId,queryMap.get(sendWayId)+1);
			}
			//根据发送方式，解决状态
			if(queryMap.get(sendWayId+solvedId) == null){
				queryMap.put(sendWayId+solvedId, 1);
			}else{
				queryMap.put(sendWayId+solvedId,queryMap.get(sendWayId+solvedId)+1);
			}
			//根据发送方式，疑问状态
			if(queryMap.get(sendWayId+queryStatusId) == null){
				queryMap.put(sendWayId+queryStatusId, 1);
			}else{
				queryMap.put(sendWayId+queryStatusId,queryMap.get(sendWayId+queryStatusId)+1);
			}
			//根据机构，发送方式
			if(queryMap.get(orgFlow+sendWayId) == null){
				queryMap.put(orgFlow+sendWayId,1);
			}else{
				queryMap.put(orgFlow+sendWayId,queryMap.get(orgFlow+sendWayId)+1);
			}
			//根据机构，发送方式，解决状态
			if(queryMap.get(orgFlow+sendWayId+solvedId) == null){
				queryMap.put(orgFlow+sendWayId+solvedId,1);
			}else{
				queryMap.put(orgFlow+sendWayId+solvedId,queryMap.get(orgFlow+sendWayId+solvedId)+1);
			}
			//根据机构，发送方式，疑问状态
			if(queryMap.get(orgFlow+sendWayId+queryStatusId) == null){
				queryMap.put(orgFlow+sendWayId+queryStatusId,1);
			}else{
				queryMap.put(orgFlow+sendWayId+queryStatusId,queryMap.get(orgFlow+sendWayId+queryStatusId)+1);
			}
		}
		return queryMap;
	}

	@Override
	public List<EdcVisitDataEvent> searchEdcDataVisitEvent(
			EdcVisitDataEventExample data) {
		return dataEventMapper.selectByExample(data); 
	}

	@Override
	public EdcQuery readEdcQuery(String queryFlow) {
		return queryMapper.selectByPrimaryKey(queryFlow); 
	}

	@Override
	public void modifyQuery(EdcQuery query) {
		GeneralMethod.setRecordInfo(query, false);
		queryMapper.updateByPrimaryKeySelective(query);
	}

	@Override
	public List<EdcQuery> searchUnSolveSdvQuery(String dataRecordFlow) {
		return queryExtMapper.searchUnSolveSdvQuery(dataRecordFlow);
	}
	@Override
	public void addVisitDataEvent(EdcVisitDataEvent dataEvent) {
		GeneralMethod.setRecordInfo(dataEvent, true);
		dataEventMapper.insert(dataEvent);
	}

	@Override
	public void modifyDataEvent(EdcVisitDataEvent dataEvent) {
		GeneralMethod.setRecordInfo(dataEvent, false);
		dataEventMapper.updateByPrimaryKeySelective(dataEvent);
	}

	@Override
	public void addEdcQuery(EdcQuery query,
			List<EdcVisitDataEvent> dataEventList) {
		addEdcQuery(query);
		for(EdcVisitDataEvent event: dataEventList){
			addVisitDataEvent(event);
		}
	}

	@Override
	public void addDcf(EdcDcf dcf) {
		GeneralMethod.setRecordInfo(dcf, true);
		dcfMapper.insert(dcf);
	}

	@Override
	public Integer readDcfSeq(String projFlow, String orgFlow) {
		EdcDcfExample example = new EdcDcfExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return dcfMapper.countByExample(example); 
	}

	@Override
	public Integer searchQuerySeq(PubPatient patient) {
		EdcQueryExample example = new EdcQueryExample();
		example.createCriteria().andProjFlowEqualTo(patient.getProjFlow()).andOrgFlowEqualTo(patient.getOrgFlow()).andPatientFlowEqualTo(patient.getPatientFlow())
		.andQueryStatusIdEqualTo(EdcQueryStatusEnum.Sended.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return queryMapper.countByExample(example);
	}

	@Override
	public List<EdcDcf> searchEdcDcf(EdcDcfExample example) {
		return dcfMapper.selectByExample(example);
	} 
	
	@Override
	public EdcDcf readEdcDcf(String dcfFlow) {
		return dcfMapper.selectByPrimaryKey(dcfFlow); 
	}
	
	@Override
	public Map<String,String> searchSdvStatus(String projFlow){
		Map<String,String> sdvStatusMap = new HashMap<String,String>();
		//按机构
		List<PubProjOrg> projOrgList = projOrgBiz.searchProjOrg(projFlow);
		if (projOrgList != null && projOrgList.size() > 0) {
			for (PubProjOrg temp:projOrgList) {
				String orgFlow = temp.getOrgFlow();
				String notSdvCount = edcPatientVisitExtMapper.searchSdvStatus(projFlow,orgFlow,EdcSdvStatusEnum.NotSdv.getId());
				String sdvingCount = edcPatientVisitExtMapper.searchSdvStatus(projFlow,orgFlow,EdcSdvStatusEnum.Sdving.getId());
				String sdvedCount = edcPatientVisitExtMapper.searchSdvStatus(projFlow,orgFlow,EdcSdvStatusEnum.Sdved.getId());
				sdvStatusMap.put(orgFlow+EdcSdvStatusEnum.NotSdv.getId(), notSdvCount);
				sdvStatusMap.put(orgFlow+EdcSdvStatusEnum.Sdving.getId(), sdvingCount);
				sdvStatusMap.put(orgFlow+EdcSdvStatusEnum.Sdved.getId(), sdvedCount);
			}
		}
		//全部
		String notSdvCount = edcPatientVisitExtMapper.searchSdvStatus(projFlow,"",EdcSdvStatusEnum.NotSdv.getId());
		String sdvingCount = edcPatientVisitExtMapper.searchSdvStatus(projFlow,"",EdcSdvStatusEnum.Sdving.getId());
		String sdvedCount = edcPatientVisitExtMapper.searchSdvStatus(projFlow,"",EdcSdvStatusEnum.Sdved.getId());
		sdvStatusMap.put(EdcSdvStatusEnum.NotSdv.getId(), notSdvCount);
		sdvStatusMap.put(EdcSdvStatusEnum.Sdving.getId(), sdvingCount);
		sdvStatusMap.put(EdcSdvStatusEnum.Sdved.getId(), sdvedCount);
		return sdvStatusMap;
	}
	
}  
 