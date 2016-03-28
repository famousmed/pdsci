package com.pinde.sci.biz.pub;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.SrmAchFile;

public interface IFileBiz {
	
	public PubFile readFile(String fileFlow);

//	public int save(PubFileForm fileForm);

//	public List<PubFile> searchFile(PubFile file);
//	
	public List<PubFile> searchFile(List<String> fileFlows);

	public void down(PubFile doc,final HttpServletResponse response) throws Exception;
	
	public void down(SrmAchFile doc,final HttpServletResponse response) throws Exception;

	public void addFile(PubFile file);
	
	
	/**
	 * 用于项目基本信息的文件上传
	 * @param projFlow
	 * @param files
	 */
//	public List<String> addFiles(MultipartFile[] files); 
	
	/**
	 * 新增文件 
	 * @param file userFlow
	 * @return  文件流水号
	 */
	public String addFile(MultipartFile file , String userFlow);
	/**
	 * 新增或修改
	 * @param file
	 * @return
	 */
	public int editFile(PubFile file);

	void downFile(File file, HttpServletResponse response) throws Exception;

	int editFileList(List<PubFile> files);

	int saveFile(PubFile file);
 
} 
 