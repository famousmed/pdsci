package com.pinde.sci.biz.irb;

import java.util.List;

import com.pinde.sci.form.irb.IrbApplyForm;
import com.pinde.sci.form.irb.IrbArchiveForm;
import com.pinde.sci.form.irb.IrbDecisionDetailForm;
import com.pinde.sci.form.irb.IrbNoticeForm;
import com.pinde.sci.form.irb.IrbQuickOpinionForm;
import com.pinde.sci.form.irb.IrbReceiptNoticeForm;
import com.pinde.sci.model.irb.IrbForm;
import com.pinde.sci.model.mo.IrbApply;
import com.pinde.sci.model.mo.IrbProcess;
import com.pinde.sci.model.mo.IrbRec;
import com.pinde.sci.model.mo.PubFile;


public interface IIrbSecretaryBiz {
	
	IrbForm readIrbForm(String irbFlow);
	
	/**
	 * 确认已上传文件
	 * @param fileIds 文件id数组
	 * @param irbFlow
	 * @return
	 * @throws Exception
	 */
	int fileConfirm(String[] fileIds,String irbFlow) throws Exception;

	/**
	 * 保存补充修改通知
	 * @param form 补充修改通知封装
	 * @param irbRec 
	 * @return
	 * @throws Exception
	 */
	int saveApplyAndModifyFile(IrbNoticeForm form,IrbRec irbRec)throws Exception;
	/**
	 * 保存受理通知
	 * @param form
	 * @return
	 */
	int saveRecNotice(IrbReceiptNoticeForm form);
	/**
	 * 查找最新的一条受理/处理记录
	 * @param irbFlow
	 * @return
	 */
	IrbProcess queryLatestHandlePro(String irbFlow);
	/**
	 * 保存快审主审综合意见
	 * @param form
	 * @return
	 * @throws Exception
	 */
	int saveQuickOpinion(IrbQuickOpinionForm form) throws Exception;
	
	/**
	 * 查找irbApply
	 * @param form
	 * @return
	 */
	List<IrbForm> searchIrbListByForm(IrbApplyForm form);
	/**
	 * 读取快审主审综合意见
	 * @param irbFlow
	 * @return
	 * @throws Exception
	 */
	IrbQuickOpinionForm readQuickOpinion(String irbFlow) throws Exception;
	/**
	 * 保存传达决定内容
	 * @param irbFlow
	 * @param form
	 * @return
	 */
	int saveDecDetail(String irbFlow, IrbDecisionDetailForm form) throws Exception;
	/**
	 * 读取传达决定内容
	 * @param irbFlow
	 * @param irbRecTypeId
	 * @return
	 * @throws Exception
	 */
	IrbDecisionDetailForm readDecDetail(String irbFlow,String irbRecTypeId) throws Exception;
	/**
	 * 判断apply的传达文件是批件还是意件
	 * @param curApply
	 * @return
	 */
	String checkFileType(IrbApply curApply);
	
	/**
	 * 判断是否已发过批件
	 * @param curApply
	 * @return
	 */
	boolean isHaveApprove(IrbApply curApply);
	/**
	 * 新增存档文件
	 * @param form
	 * @param pubFile
	 * @return
	 * @throws Exception
	 */
	int addApplyFile(IrbArchiveForm form,PubFile pubFile)throws Exception;

	int saveReviewFile(IrbDecisionDetailForm decisionForm) throws Exception;
	
}
