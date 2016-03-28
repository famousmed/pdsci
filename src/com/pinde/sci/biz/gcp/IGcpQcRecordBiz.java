package com.pinde.sci.biz.gcp;

import java.util.List;

import com.pinde.sci.model.mo.GcpQcRecord;
import com.pinde.sci.model.mo.GcpQcRecordRec;
import com.pinde.sci.model.mo.GcpQcRemind;


public interface IGcpQcRecordBiz {
	List<GcpQcRecord> searchQcRecord();
	
	List<GcpQcRecord> searchQcRecord(String orgFlow,String projFlow);
	
	GcpQcRecord readQcRecord(String qcFlow);
	
	GcpQcRecordRec readQcRecordRec(String qcFlow,
			String recTypeId);

	int saveQcRecordRec(GcpQcRecordRec qcRecordRec);

	List<GcpQcRecordRec> searchQcRecordRecByQcFlow(String projFlow,
			String qcFlow);

	List<GcpQcRecord> searchQcRecordByqcRecord(GcpQcRecord qcRecord);

	int saveQcRemind(GcpQcRemind qcRemind);

	GcpQcRemind readQcRemind(String recordFlow);

	int editQcRecord(GcpQcRecord qcRecord, String remindRecordFlow);

	List<GcpQcRemind> searchQcRemind(String orgFlow);

	List<GcpQcRemind> searchQcRemind(String orgFlow, String projFlow,
			String qcTypeId);

	List<GcpQcRemind> searchQcRemindByQcRemind(GcpQcRemind qcRemind);

	GcpQcRemind readQcRemind(GcpQcRemind qcRemind);

	String editQcRecordRetuenFlow(GcpQcRecord qcRecord, String remindRecordFlow);
}
