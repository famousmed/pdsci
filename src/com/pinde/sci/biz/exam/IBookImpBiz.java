package com.pinde.sci.biz.exam;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.exam.ExamBookImpExt;
import com.pinde.sci.model.exam.ExamBookRegistInfo;
import com.pinde.sci.model.exam.ExamQuestionExt;
import com.pinde.sci.model.exam.QuestionFileVerifyInfo;
import com.pinde.sci.model.mo.ExamBookComposInfo;
import com.pinde.sci.model.mo.ExamBookImp;
import com.pinde.sci.model.mo.ExamBookImpDetail;
import com.pinde.sci.model.mo.ExamBookRecognizeInfo;
import com.pinde.sci.model.mo.ExamBookReloadRec;
import com.pinde.sci.model.mo.ExamBookScanInfo;

public interface IBookImpBiz {
	
	public List<ExamBookImp> search(ExamBookImp imp);
	
	public List<ExamBookImpDetail> searchDetail(String bookImpFlow);
	
	public List<ExamBookImpDetail> searchDetail(ExamBookImpDetail bookImpDetail);
	
	public List<ExamBookReloadRec> searchBookReloadRecsByBookFlow(String bookFlow);
	
	/**
	 * ��ѯ�������ݣ������ļ�
	 * @param bookImpFlow
	 * @return
	 */
	public List<ExamBookImpDetail> searchDetailWithFileContent(String bookImpFlow);
	
	public void addImp(ExamBookImp imp,List<ExamBookImpDetail> impDetailList);
	
	public void modifyImp(ExamBookImp imp,List<ExamBookImpDetail> impDetailList);
	
	/**
	 * �����ϴ������ļ�
	 * @param imp
	 * @param impDetailList
	 */
	public void reuploadQuestion(String impDetailFlow , MultipartFile questionFile);

	public void submit(String bookImpFlow);
	
	/**
	 * ����������ѯ������Ϣ
	 * @param bookImpFlow
	 * @return
	 */
	public ExamBookImp findBookImpByImpFlow(String bookImpFlow);
	
	/**
	 * ����������ѯ�������ϸ��Ϣ
	 * @param bookImpDetailFlow
	 * @return
	 */
	public ExamBookImpDetail findBookImpDetailByDetailFlow(String bookImpDetailFlow);
	
	/**
	 * ��ȡ�ϴ��ļ�������
	 * @param detailFlow
	 * @return
	 */
	public String findQuestionContentByimpDetailFlow(String detailFlow);
	
	/**
	 * ������Ŀ���͵��ļ������ļ�����Ϣ���õ�Ҫ�����detail��
	 * @param detail
	 * @param questionTypeFile
	 */
	public void parseQuestionFile(ExamBookImpDetail detail , MultipartFile questionTypeFile);
	
	/**
	 * �����ϴ�����Ŀ�ļ�
	 * @param questionTypeFile
	 * @return Map<�ڼ��� ,Map<�к�,����>> ���� Map<�к�,����>��LinkedHashMap ����˳���
	 */
	public Map<Integer , Map<Integer , String>> parseQuestionFile(MultipartFile questionTypeFile);
	
	/**
	 * ������Ŀ�������ļ�У��
	 * @param questionTypeId
	 * @param questionTypeFile
	 * @return ��Ŀ�ļ�У����Ϣ
	 */
	public QuestionFileVerifyInfo verifyQuestionFile(String questionTypeId , MultipartFile questionTypeFile);
	
	/**
	 * ��ѯ�Ѿ��������Ϣ
	 * @param impExt
	 * @return
	 */
	public List<ExamBookImpExt> search(ExamBookImpExt impExt);
	
	/**
	 * �Ե������Ϣ�����²������ò�������У������
	 * @param bookImp
	 */
	public void operate(ExamBookImp bookImp);
	
	/**
	 * ����������ѯ������Ϣ(���������Ϣ)
	 * @param bookImpFlow
	 * @return
	 */
	public ExamBookImpExt findExamBookImpByExamBookImpFlow(String bookImpFlow);
	
	/**
	 * ��ȡ��Ŀ�ĵǼ���Ϣ
	 * @param bookFlow
	 * @return
	 */
	public ExamBookRegistInfo getBookRegistInfo(String bookFlow);
	
	/**
	 * �Ǽ���Ŀɨ����Ϣ
	 * @param bookScanInfo
	 */
	public void registBookScanInfo(ExamBookScanInfo bookScanInfo);
	
	/**
	 * �Ǽ�ʶ����Ϣ
	 * @param recognizeInfo
	 */
	public void registRecognizeInfo(ExamBookRecognizeInfo recognizeInfo);
	
	/**
	 * �Ǽ��Ű���Ϣ
	 * @param bookComposInfo
	 */
	public void registComposInfo(ExamBookComposInfo bookComposInfo);

	List<ExamQuestionExt> createQuestionsfortest(
			ExamBookImpDetail bookImpDetail, ExamBookImp bookImp);

	/**
	 * ���ݵ������Ϣ��������
	 * @param bookImpDetail
	 * @param bookImp
	 * @return
	 */
	List<ExamQuestionExt> createQuestions(ExamBookImpDetail bookImpDetail,
			ExamBookImp bookImp);
	
	/**
	 * ɾ�������ļ�
	 * @param impDetailFlow
	 */
	public void delImpDetailByImpDetailFlow(String impDetailFlow);
	
}
