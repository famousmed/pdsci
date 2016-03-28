package com.pinde.sci.biz.erp;

import java.util.List;
import java.util.Map;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.erp.ErpDocShareExt;
import com.pinde.sci.model.mo.ErpDoc;
import com.pinde.sci.model.mo.ErpDocShare;

public interface IErpDocBiz {
	
	/**
	 * ����ErpDoc
	 * @param erpDoc
	 * @return
	 */
	int saveErpDoc(ErpDoc erpDoc);
	
	/**
	 * �����ĵ��ļ�
	 * @param file
	 * @param erpDoc
	 * @return
	 */
	int saveDocFile(MultipartFile file, ErpDoc erpDoc, String[] shareTypeId, String[] recordFlow, String[] recordName);
	
	/**
	 * ��ѯ
	 * @param erpDoc
	 * @return
	 */
	List<ErpDoc> searchErpDocList(Map<String, Object> paramMap);
	
	/**
	 * ��ȡһ����¼
	 * @param docFlow
	 * @return
	 */
	ErpDoc readErpDoc(String docFlow);
	
	/**
	 * ��ѯ�ĵ�����
	 * @return
	 */
	List<String> searchFileTypeList();

	/**
	 * �޸ĵ��������¼
	 * @param docShare
	 * @return
	 */
	ErpDocShare modifySingleDocShare(ErpDocShare docShare);

	/**
	 * �޸��ĵ�
	 * @param erpDoc
	 * @return
	 */
	int modifyErpDoc(ErpDoc erpDoc);

	/**
	 * ����ɾ��
	 * @param docFlowList
	 * @return
	 */
	int batchDelByDocFlowList(List<String> docFlowList);	
}
