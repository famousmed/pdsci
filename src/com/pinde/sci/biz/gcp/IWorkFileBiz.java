package com.pinde.sci.biz.gcp;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.mo.PubDiary;
import com.pinde.sci.model.mo.PubRegulation;
import com.pinde.sci.model.mo.PubWorkpaper;

public interface IWorkFileBiz {
	/**
	 * 保存工作日志
	 * @param diary
	 * @return
	 */
	int saveDiary(PubDiary diary);
	
	/**
	 * 查询全部工作日志
	 * @return
	 */
	List<PubDiary> searchDiaryList();
	
	/**
	 * 读取一条工作日志
	 * @param diaryFlow
	 * @return
	 */
	PubDiary readDiary(String diaryFlow);
	
	//**********法规文件***********
	
	/**
	 * 查询法规文件
	 * @param regulation
	 * @return
	 */
	List<PubRegulation> searchRegulaionFileList(PubRegulation regulation);
	
	/**
	 * 保存法规文件
	 * @param file
	 * @param regulation
	 * @return
	 */
	int saveRegulationFile(MultipartFile multipartFile, PubRegulation regulation);
	
	/**
	 * 删除法规文件
	 * @param regulationFlow
	 * @param fileFlow
	 * @return
	 */
	int delRegulationFile(String regulationFlow, String fileFlow);
	
	/**
	 * 保存排序码
	 * @param regulationFlow
	 * @return
	 */
	int saveOrder(String[] regulationFlow);
	
	//*************工作文件************
	/**
	 * 保存工作文件
	 * @param workpaper
	 * @return
	 */
	int saveWorkpaper(PubWorkpaper workpaper);
	
	/**
	 * 查询工作文件
	 * @param workpaper
	 * @return
	 */
	List<PubWorkpaper> searchWorkpaperList(PubWorkpaper workpaper);
	
	/**
	 * 读取一条工作文件
	 * @param recordFlow
	 * @return
	 */
	PubWorkpaper readWorkpaper(String recordFlow);
}
