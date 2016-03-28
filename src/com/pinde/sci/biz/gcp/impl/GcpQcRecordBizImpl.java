package com.pinde.sci.biz.gcp.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.gcp.IGcpQcRecordBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.GcpQcRecordMapper;
import com.pinde.sci.dao.base.GcpQcRecordRecMapper;
import com.pinde.sci.dao.base.GcpQcRemindMapper;
import com.pinde.sci.model.mo.GcpQcRecord;
import com.pinde.sci.model.mo.GcpQcRecordExample;
import com.pinde.sci.model.mo.GcpQcRecordExample.Criteria;
import com.pinde.sci.model.mo.GcpQcRecordRec;
import com.pinde.sci.model.mo.GcpQcRecordRecExample;
import com.pinde.sci.model.mo.GcpQcRemind;
import com.pinde.sci.model.mo.GcpQcRemindExample;

@Service
@Transactional(rollbackFor = Exception.class)
public class GcpQcRecordBizImpl implements IGcpQcRecordBiz{
	@Autowired
	private GcpQcRecordMapper qcRecordMapper;
	@Autowired
	private GcpQcRecordRecMapper qcRecordRecMapper;
	@Autowired
	private GcpQcRemindMapper qcRemindMapper;
	@Override
	public List<GcpQcRecord> searchQcRecord() {
		GcpQcRecordExample example = new GcpQcRecordExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("QC_START_DATE DESC,CREATE_TIME DESC");
		return qcRecordMapper.selectByExample(example);
	}

	@Override
	public List<GcpQcRecord> searchQcRecord(String orgFlow, String projFlow) {
		GcpQcRecordExample example = new GcpQcRecordExample();
		Criteria criteria = example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgFlowEqualTo(orgFlow);
		if(StringUtil.isNotBlank(projFlow)){
			criteria.andProjFlowEqualTo(projFlow);
		}
		example.setOrderByClause("QC_START_DATE DESC,CREATE_TIME DESC");
		return qcRecordMapper.selectByExample(example);
	}

	
	@Override
	public GcpQcRecord readQcRecord(String qcFlow) {
		return qcRecordMapper.selectByPrimaryKey(qcFlow);
	}

	@Override
	public String editQcRecordRetuenFlow(GcpQcRecord qcRecord,String remindRecordFlow){
		if(qcRecord!=null){
			if(StringUtil.isNotBlank(qcRecord.getQcFlow())){
				editQcRecord(qcRecord,remindRecordFlow);
				return GlobalConstant.SAVE_SUCCESSED;
			}else{
				qcRecord.setQcFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(qcRecord, true);
				qcRecordMapper.insertSelective(qcRecord);
				editQcRecord(qcRecord,remindRecordFlow);
				return qcRecord.getQcFlow();
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@Override
	public int editQcRecord(GcpQcRecord qcRecord,String remindRecordFlow) {
		if(qcRecord!=null){
			if(StringUtil.isNotBlank(qcRecord.getQcFlow())){
				GeneralMethod.setRecordInfo(qcRecord, false);
				qcRecordMapper.updateByPrimaryKeySelective(qcRecord);
			}else{
				qcRecord.setQcFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(qcRecord, true);
				qcRecordMapper.insertSelective(qcRecord);
			}
			
			GcpQcRemind qcRemind = new GcpQcRemind();
			if(StringUtil.isBlank(remindRecordFlow)){
				GcpQcRecord qcRecordTemp = readQcRecord(qcRecord.getQcFlow());
				if(qcRecordTemp!=null){
					qcRemind.setOrgFlow(qcRecordTemp.getOrgFlow());
					qcRemind.setProjFlow(qcRecordTemp.getProjFlow());
					qcRemind.setQcTypeId(qcRecordTemp.getQcTypeId());
					qcRemind.setQcCategoryId(qcRecordTemp.getQcCategoryId());
					qcRemind = readQcRemind(qcRemind);
					if(qcRemind!=null){
						remindRecordFlow = qcRemind.getRecordFlow();
					}
				}
			}
			if(StringUtil.isNotBlank(remindRecordFlow)){
				qcRemind.setRecordFlow(remindRecordFlow);
				qcRemind.setRemindStatus(GlobalConstant.FLAG_Y);
				return saveQcRemind(qcRemind);
			}else{
				return GlobalConstant.ONE_LINE;
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public GcpQcRecordRec readQcRecordRec(String qcFlow,String recTypeId){
		GcpQcRecordRecExample example = new GcpQcRecordRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andQcFlowEqualTo(qcFlow).andRecTypeIdEqualTo(recTypeId);
		List<GcpQcRecordRec> qcRecordRecList = qcRecordRecMapper.selectByExampleWithBLOBs(example);
		GcpQcRecordRec qcRecordRec = null;
		if(qcRecordRecList!=null && qcRecordRecList.size()>0){
			qcRecordRec = qcRecordRecList.get(0);
		}
		return qcRecordRec;
	}
	
	@Override
	public List<GcpQcRecordRec> searchQcRecordRecByQcFlow(String projFlow,String qcFlow){
		GcpQcRecordRecExample example = new GcpQcRecordRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow)
		.andQcFlowEqualTo(qcFlow);
		return qcRecordRecMapper.selectByExampleWithBLOBs(example);
	}
	
	@Override
	public int saveQcRecordRec(GcpQcRecordRec qcRecordRec){
		if(qcRecordRec != null){
			if(StringUtil.isNotBlank(qcRecordRec.getRecFlow())){
				GeneralMethod.setRecordInfo(qcRecordRec, false);
				return qcRecordRecMapper.updateByPrimaryKeySelective(qcRecordRec);
			}else{
				qcRecordRec.setRecFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(qcRecordRec, true);
				return qcRecordRecMapper.insertSelective(qcRecordRec);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public List<GcpQcRecord> searchQcRecordByqcRecord(GcpQcRecord qcRecord){
		GcpQcRecordExample example = new GcpQcRecordExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(qcRecord != null){
			if(StringUtil.isNotBlank(qcRecord.getQcStartDate())){
				criteria.andQcStartDateGreaterThanOrEqualTo(qcRecord.getQcStartDate());
			}
			if(StringUtil.isNotBlank(qcRecord.getQcEndDate())){
				criteria.andQcStartDateLessThanOrEqualTo(qcRecord.getQcEndDate());
			}
			if(StringUtil.isNotBlank(qcRecord.getQcTypeId())){
				criteria.andQcTypeIdEqualTo(qcRecord.getQcTypeId());
			}
		}
		example.setOrderByClause("QC_START_DATE DESC,CREATE_TIME DESC");
		return qcRecordMapper.selectByExample(example);
	}
	
	@Override
	public int saveQcRemind(GcpQcRemind qcRemind){
		if(qcRemind != null){
			if(StringUtil.isNotBlank(qcRemind.getRecordFlow())){
				GeneralMethod.setRecordInfo(qcRemind, false);
				return qcRemindMapper.updateByPrimaryKeySelective(qcRemind);
			}else{
				qcRemind.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(qcRemind, true);
				return qcRemindMapper.insertSelective(qcRemind);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public List<GcpQcRemind> searchQcRemindByQcRemind(GcpQcRemind qcRemind){
		GcpQcRemindExample example = new GcpQcRemindExample();
		com.pinde.sci.model.mo.GcpQcRemindExample.Criteria criteria = example.createCriteria()
				.andRemindStatusEqualTo(GlobalConstant.FLAG_N).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(qcRemind!=null){
			if(StringUtil.isNotBlank(qcRemind.getQcTypeId())){
				criteria.andQcTypeIdEqualTo(qcRemind.getQcTypeId());
			}
			if(StringUtil.isNotBlank(qcRemind.getOrgFlow())){
				criteria.andOrgFlowEqualTo(qcRemind.getOrgFlow());
			}
			if(StringUtil.isNotBlank(qcRemind.getQcCategoryId())){
				criteria.andQcCategoryIdEqualTo(qcRemind.getQcCategoryId());
			}
			if(StringUtil.isNotBlank(qcRemind.getProjFlow())){
				String[] projFlows = qcRemind.getProjFlow().split(",");
				if(projFlows!=null && projFlows.length>0){
					List<String> projFlowList = new ArrayList<String>();
					for(String flow : projFlows){
						projFlowList.add(flow);
					}
					criteria.andProjFlowIn(projFlowList);
				}
			}
		}
		example.setOrderByClause("CREATE_TIME DESC");
		return qcRemindMapper.selectByExample(example);
	}
	
	@Override
	public List<GcpQcRemind> searchQcRemind(String orgFlow){
		GcpQcRemindExample example = new GcpQcRemindExample();
		com.pinde.sci.model.mo.GcpQcRemindExample.Criteria criteria = example.createCriteria()
				.andRemindStatusEqualTo(GlobalConstant.FLAG_N).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(orgFlow)){
			criteria.andOrgFlowEqualTo(orgFlow);
		}
		example.setOrderByClause("CREATE_TIME DESC");
		return qcRemindMapper.selectByExample(example);
	}
	
	@Override
	public List<GcpQcRemind> searchQcRemind(String orgFlow,String projFlow,String qcTypeId){
		GcpQcRemindExample example = new GcpQcRemindExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andRemindStatusEqualTo(GlobalConstant.FLAG_N)
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andQcTypeIdEqualTo(qcTypeId).andOrgFlowEqualTo(orgFlow);
		example.setOrderByClause("CREATE_TIME DESC");
		return qcRemindMapper.selectByExample(example);
	}
	
	@Override
	public GcpQcRemind readQcRemind(String recordFlow){
		return qcRemindMapper.selectByPrimaryKey(recordFlow);
	}
	
	@Override
	public GcpQcRemind readQcRemind(GcpQcRemind qcRemind){
		List<GcpQcRemind> qcRemindList = searchQcRemindByQcRemind(qcRemind);
		qcRemind = null;
		if(qcRemindList!=null && qcRemindList.size()>0){
			qcRemind = qcRemindList.get(0);
		}
		return qcRemind;
	}
}
