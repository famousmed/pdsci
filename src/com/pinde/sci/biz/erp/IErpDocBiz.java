package com.pinde.sci.biz.erp;

import java.util.List;
import java.util.Map;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.erp.ErpDocShareExt;
import com.pinde.sci.model.mo.ErpDoc;
import com.pinde.sci.model.mo.ErpDocShare;

public interface IErpDocBiz {
	
	/**
	 * 保存ErpDoc
	 * @param erpDoc
	 * @return
	 */
	int saveErpDoc(ErpDoc erpDoc);
	
	/**
	 * 保存文档文件
	 * @param file
	 * @param erpDoc
	 * @return
	 */
	int saveDocFile(MultipartFile file, ErpDoc erpDoc, String[] shareTypeId, String[] recordFlow, String[] recordName);
	
	/**
	 * 查询
	 * @param erpDoc
	 * @return
	 */
	List<ErpDoc> searchErpDocList(Map<String, Object> paramMap);
	
	/**
	 * 获取一条记录
	 * @param docFlow
	 * @return
	 */
	ErpDoc readErpDoc(String docFlow);
	
	/**
	 * 查询文档类型
	 * @return
	 */
	List<String> searchFileTypeList();

	/**
	 * 修改单个分享记录
	 * @param docShare
	 * @return
	 */
	ErpDocShare modifySingleDocShare(ErpDocShare docShare);

	/**
	 * 修改文档
	 * @param erpDoc
	 * @return
	 */
	int modifyErpDoc(ErpDoc erpDoc);

	/**
	 * 批量删除
	 * @param docFlowList
	 * @return
	 */
	int batchDelByDocFlowList(List<String> docFlowList);	
}
