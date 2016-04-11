package com.pinde.sci.biz.gcp;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.mo.PubDiary;
import com.pinde.sci.model.mo.PubRegulation;
import com.pinde.sci.model.mo.PubWorkpaper;

public interface IWorkFileBiz {
	/**
	 * ���湤����־
	 * @param diary
	 * @return
	 */
	int saveDiary(PubDiary diary);
	
	/**
	 * ��ѯȫ��������־
	 * @return
	 */
	List<PubDiary> searchDiaryList();
	
	/**
	 * ��ȡһ��������־
	 * @param diaryFlow
	 * @return
	 */
	PubDiary readDiary(String diaryFlow);
	
	//**********�����ļ�***********
	
	/**
	 * ��ѯ�����ļ�
	 * @param regulation
	 * @return
	 */
	List<PubRegulation> searchRegulaionFileList(PubRegulation regulation);
	
	/**
	 * ���淨���ļ�
	 * @param file
	 * @param regulation
	 * @return
	 */
	int saveRegulationFile(MultipartFile multipartFile, PubRegulation regulation);
	
	/**
	 * ɾ�������ļ�
	 * @param regulationFlow
	 * @param fileFlow
	 * @return
	 */
	int delRegulationFile(String regulationFlow, String fileFlow);
	
	/**
	 * ����������
	 * @param regulationFlow
	 * @return
	 */
	int saveOrder(String[] regulationFlow);
	
	//*************�����ļ�************
	/**
	 * ���湤���ļ�
	 * @param workpaper
	 * @return
	 */
	int saveWorkpaper(PubWorkpaper workpaper);
	
	/**
	 * ��ѯ�����ļ�
	 * @param workpaper
	 * @return
	 */
	List<PubWorkpaper> searchWorkpaperList(PubWorkpaper workpaper);
	
	/**
	 * ��ȡһ�������ļ�
	 * @param recordFlow
	 * @return
	 */
	PubWorkpaper readWorkpaper(String recordFlow);
}
