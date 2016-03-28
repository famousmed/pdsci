package com.pinde.sci.biz.gcp;

import java.util.List;
import java.util.Map;

import org.dom4j.DocumentException;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.form.gcp.GcpCfgFileForm;
import com.pinde.sci.form.gcp.GcpEvaluationForm;
import com.pinde.sci.form.gcp.GcpFinishWorkForm;
import com.pinde.sci.form.gcp.GcpMeetingForm;
import com.pinde.sci.form.gcp.GcpProvFilingForm;
import com.pinde.sci.form.gcp.GcpSumStampForm;
import com.pinde.sci.model.mo.GcpRec;

public interface IGcpRecBiz {
	/**
	 * 新增或修改
	 * @param rec
	 * @return 受影响的行数
	 */
	int edit(GcpRec rec);
	/**
	 * 保存立项评估表
	 * @param projFlow 项目流水号
	 * @param agree 是否同意立项
	 * @param file 附件
	 * @return
	 * @throws Exception
	 */
	//int saveEval(String projFlow,String agree,String projectTime,MultipartFile file) throws Exception;
	/**
	 * 查找唯一
	 * @param projFlow 项目流水号
	 * @param recTypeId rec类型id
	 * @return
	 */
	GcpRec searchOne(String projFlow,String recTypeId);
	
	/**
	 * 查找立项评估表
	 * @param projFlow 项目流水号
	 * @return
	 * @throws Exception
	 */
	GcpEvaluationForm searchEvaluation(String projFlow)throws Exception;
	
	/**
	 * 保存文件
	 * @param projFlow
	 * @param fileForm
	 * @param files
	 * @return
	 * @throws Exception 
	 */
	int saveApplyFile(MultipartFile[] files, 
			String[] id, String[] fileFlow,String[] name, String[] version, String[] versionDate, 
			String projFlow) throws Exception;
	
	/**
	 * 查询附件信息
	 * @param projFlow
	 * @return
	 * @throws Exception 
	 */
	List<GcpCfgFileForm> searchApplyFiles(String projFlow) throws Exception;
	
	/**
	 * 删除附件
	 * @param fileFlow_id
	 * @return
	 * @throws Exception 
	 */
	int delFileByIds(String projFlow, String[] ids) throws Exception;
	/**
	 * 保存会议
	 * @param form
	 * @return
	 * @throws DocumentException
	 */
	int saveMeeting(GcpMeetingForm form) throws Exception;
	/**
	 * 获取会议信息
	 * @param projFlow
	 * @return
	 * @throws Exception
	 */
	GcpMeetingForm searchMeeting(String projFlow)throws Exception;
	/**
	 * 过滤项目的成员
	 * @param projFlow
	 * @return key:角色别名 value:所有用户的用户名（顿号隔开）
	 */
	Map<String,String> filterProjUser(String projFlow);
	/**
	 * 删除会议文件
	 * @param ids
	 * @param projFlow
	 * @throws Exception
	 */
	void delMeetingFiles(List<String> ids,String projFlow)throws Exception;
	/**
	 * 保存省级备案
	 * @param form
	 * @return
	 * @throws Exception
	 */
	int saveProvFiling(GcpProvFilingForm form) throws Exception;
	/**
	 * 获取省级备案
	 * @param projFlow
	 * @return
	 * @throws Exception
	 */
	GcpProvFilingForm searchProvFiling(String projFlow) throws Exception;
	/**
	 * 获取总结盖章
	 * @param projFlow
	 * @return
	 * @throws Exception
	 */
	GcpSumStampForm searchSumStamp(String projFlow) throws Exception;
	/**
	 * 保存总结盖章
	 * @param form
	 * @return
	 * @throws Exception
	 */
	int saveSumStamp(GcpSumStampForm form) throws Exception;
	/**
	 * 获取研究结束工作
	 * @param projFlow
	 * @return
	 * @throws Exception
	 */
	GcpFinishWorkForm searchFinishWork(String projFlow) throws Exception;
	/**
	 * 保存研究结束工作
	 * @param form
	 * @return
	 * @throws Exception
	 */
	int saveFinishWork(GcpFinishWorkForm form) throws Exception;
	
	/**
	 * 根据projFlowList查询
	 * @param projFlowList
	 * @return
	 */
	List<GcpRec> searchGcpRecListWithBLOBs(List<String> projFlowList);
	/**
	 * 查询启动会议日期
	 * @param gcpRecList
	 * @return
	 * @throws Exception 
	 */
	Map<String, String> searchStartMeetingDate(List<GcpRec> gcpRecList) throws Exception;
	int saveEval(String projFlow, Map<String, Object> paramMap);
}
