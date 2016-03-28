package com.pinde.sci.biz.pub.impl;


import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.PubFileMapper;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubFileExample;
import com.pinde.sci.model.mo.PubFileExample.Criteria;
import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor=Exception.class)
public class FileBizImpl implements IFileBiz {

	@Resource
	private PubFileMapper pubFileMapper;
   
	@Override
	public PubFile readFile(String fileFlow) {
		return pubFileMapper.selectByPrimaryKey(fileFlow);
	}

	@Override
	public String addFile(MultipartFile mulFile , String userFlow) {
		String originalFileName =  mulFile.getOriginalFilename();
		String suffix =originalFileName.substring(originalFileName.lastIndexOf(".")+1);  
		PubFile file  = new PubFile();
		file.setFileFlow(PkUtil.getUUID());
		file.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		file.setCreateTime(DateUtil.getCurrDateTime());
		file.setCreateUserFlow(userFlow); 
		file.setFileSuffix(suffix);
		if (mulFile != null) {
			file.setFileSize(new BigDecimal(mulFile.getSize()));
		}
		try {
			InputStream is = mulFile.getInputStream();
			  byte[] fileData = new byte[(int) mulFile.getSize()];  
			    is.read(fileData);  
			    file.setFileName(originalFileName);
			    file.setFileContent(fileData);
		} catch (IOException e) {
			throw new RuntimeException("文件上传异常");
		}  
		pubFileMapper.insert(file);
		return file.getFileFlow();
	}

//	@Override
//	public List<PubFile> searchFile(PubFile file) {
//		PubFileExample docExample  = new PubFileExample();
//		Criteria crieria =  docExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
//		if(StringUtil.isNotBlank(file.getFileName())){
//			crieria.andFileNameLike("%"+file.getFileName()+"%");
//		}
////		if(StringUtil.isNotBlank(file.getProjFlow())){
////			crieria.andProjFlowEqualTo(file.getProjFlow());
////		}
////		if(StringUtil.isNotBlank(file.getRecFlow())){
////			crieria.andRecFlowEqualTo(file.getRecFlow());
////		}
//		docExample.setOrderByClause("create_time desc");
//		return pubFileMapper.selectByExample(docExample);
//		
//	}

	@Override
	public List<PubFile> searchFile(List<String> fileFlows) {
		PubFileExample docExample  = new PubFileExample();
		Criteria crieria =  docExample.createCriteria();
		crieria.andFileFlowIn(fileFlows).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		docExample.setOrderByClause("CREATE_TIME DESC");
		return this.pubFileMapper.selectByExample(docExample);
		
	}

	
	@Override
	public void down(PubFile file, final HttpServletResponse response) throws Exception{
		if(file !=null){
		    byte[] data =  file.getFileContent();
		    int dataLength = 0;
		    if (data != null) {
		    	dataLength = data.length;
		    }
		    String fileName = file.getFileName();
		    fileName = URLEncoder.encode(fileName, "UTF-8");
		    if(StringUtil.isNotBlank(file.getFileSuffix())){
		    	fileName+= "."+file.getFileSuffix();
		    }
		    response.reset();  
		    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");  
		    response.addHeader("Content-Length", "" + dataLength);  
		    response.setContentType("application/octet-stream;charset=UTF-8");  
		    OutputStream outputStream = new BufferedOutputStream(response.getOutputStream()); 
		    if (data != null) {
		    	outputStream.write(data); 
		    }
		    outputStream.flush();  
		    outputStream.close();  
		}else {
			 OutputStream outputStream = new BufferedOutputStream(response.getOutputStream()); 
			 outputStream.write("未发现文件".getBytes()); 
			 outputStream.flush();  
			 outputStream.close();  
		}
	}
	
	@Override
	public void down(SrmAchFile file, HttpServletResponse response)
			throws Exception {
		byte[] data =  file.getFileContent();
	    String fileName = file.getFileName();
	    fileName = URLEncoder.encode(fileName, "UTF-8");
	    if(StringUtil.isNotBlank(file.getFileSuffix())){
	    	fileName+= "."+file.getFileSuffix();
	    }
	    response.reset();  
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");  
	    response.addHeader("Content-Length", "" + data.length);  
	    response.setContentType("application/octet-stream;charset=UTF-8");  
	    OutputStream outputStream = new BufferedOutputStream(response.getOutputStream());  
	    outputStream.write(data);  
	    outputStream.flush();  
	    outputStream.close(); 
		
	}
		
	@Override
	public void addFile(PubFile file) {
		if (file.getFileContent() != null) {
			file.setFileSize(new BigDecimal(file.getFileContent().length));
		}
		this.pubFileMapper.insert(file);
	}

	@Override
	public int editFile(PubFile file) {
		if(file!=null){
			if (file.getFileContent() != null) {
				file.setFileSize(new BigDecimal(file.getFileContent().length));
			}
			if(StringUtil.isNotBlank(file.getFileFlow())){//修改
				GeneralMethod.setRecordInfo(file, false);
				return this.pubFileMapper.updateByPrimaryKeySelective(file);
			}else{//新增
				file.setFileFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(file, true);
				return this.pubFileMapper.insertSelective(file);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int saveFile(PubFile file) {
		if (file.getFileContent() != null) {
			file.setFileSize(new BigDecimal(file.getFileContent().length));
		}
		GeneralMethod.setRecordInfo(file, true);
		return this.pubFileMapper.insertSelective(file);
	}

	/**
	　* 把一个文件转化为字节
	　* @param file
	　* @return byte[]
	　* @throws Exception
	　*/
	public static byte[] getByte(File file) throws Exception{
		if (file == null) {
            return null;
        }
        try {
        	int length = (int) file.length();
			if(length>Integer.MAX_VALUE) {	//当文件的长度超过了int的最大值
				System.out.println("this file is max ");
			}
            FileInputStream stream = new FileInputStream(file);
            ByteArrayOutputStream out = new ByteArrayOutputStream(length);
			byte[] b = new byte[length];
            int n;
            while ((n = stream.read(b)) != -1)
                out.write(b, 0, n);
            stream.close();
            out.close();
            return out.toByteArray();
        } catch (IOException e) {
        }
        return null;
	}


	@Override
	public void downFile(File file, final HttpServletResponse response) throws Exception{
	    byte[] data =  getByte(file);;
	    int dataLength = 0;
	    if (data != null) {
	    	dataLength = data.length;
	    }
	    String fileName = file.getName();
	    fileName = URLEncoder.encode(fileName, "UTF-8");
	    response.reset();  
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");  
	    response.addHeader("Content-Length", "" + dataLength);  
	    response.setContentType("application/octet-stream;charset=UTF-8");  
	    OutputStream outputStream = new BufferedOutputStream(response.getOutputStream()); 
	    if (data != null) {
	    	outputStream.write(data); 
	    }
	    outputStream.flush();  
	    outputStream.close();  
	}

	@Override
	public int editFileList(List<PubFile> files) {
		if (files != null && files.size() > 0) {
			for (PubFile file:files) {
				if (file.getFileContent() != null) {
					file.setFileSize(new BigDecimal(file.getFileContent().length));
				}
				if(StringUtil.isNotBlank(file.getFileFlow())){//修改
					GeneralMethod.setRecordInfo(file, false);
					return this.pubFileMapper.updateByPrimaryKeySelective(file);
				}else{//新增
					file.setFileFlow(PkUtil.getUUID());
					GeneralMethod.setRecordInfo(file, true);
					return this.pubFileMapper.insertSelective(file);
				}
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
}
