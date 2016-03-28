package com.pinde.sci.biz.sys.impl;

import java.io.IOException;
import java.io.InputStream;
import java.io.PushbackInputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.poi.POIXMLDocument;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sys.IImpactorFactorBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.PubFileMapper;
import com.pinde.sci.dao.base.PubImpactorFactorMapper;
import com.pinde.sci.enums.srm.FactorTypeEnum;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubFileForm;
import com.pinde.sci.model.mo.PubImpactorFactor;
import com.pinde.sci.model.mo.PubImpactorFactorExample;
import com.pinde.sci.model.mo.PubImpactorFactorExample.Criteria;
import com.sun.xml.internal.messaging.saaj.util.ByteInputStream;
@Service
@Transactional(rollbackFor=Exception.class)
public class ImpactorFactorBizImpl implements IImpactorFactorBiz {
	
	@Resource
	private PubFileMapper pubFileMapper;
	@Resource
	private PubImpactorFactorMapper impactorFactorMapper;

	@Override
	public void importExcel(PubFileForm fileForm,PubImpactorFactor factor) throws RuntimeException{
		String fileName =  fileForm.getFile().getOriginalFilename();
		String suffix =fileName.substring(fileName.lastIndexOf(".")+1);  
		PubFile file  = new PubFile();
		file.setFileFlow(PkUtil.getUUID());
		file.setFileSuffix(suffix);
		file.setFileSize(new BigDecimal(fileForm.getFile().getSize()));
		InputStream is = null;
		try{
			is = fileForm.getFile().getInputStream();
			byte[] fileData = new byte[(int) fileForm.getFile().getSize()];  
			is.read(fileData);  
			file.setFileName(fileName);
			file.setFileContent(fileData);
		    Workbook wb =  createCommonWorkbook(new ByteInputStream(fileData,(int) fileForm.getFile().getSize() ));
		    parseExcel(wb,factor);
		}catch(Exception e){
			throw new RuntimeException(e.getMessage());
		}finally{
			try {
				if(is!=null){
					is.close();
				}
			} catch (Exception e2) {
				throw new RuntimeException(e2.getMessage());
			}
			
		}  
		GeneralMethod.setRecordInfo(file, true);
		pubFileMapper.insert(file);
	}
	
	private void parseExcel(Workbook wb,PubImpactorFactor ifactor) throws IOException,RuntimeException {
		//查询全部以验证
		List<PubImpactorFactor> factorList =  queryImpactorFactorList(new PubImpactorFactor());
		
		int sheetNum = wb.getNumberOfSheets();
		if(sheetNum>0){
			List<String> colnames = new ArrayList<String>();
			Sheet sheet;
			try{
				sheet = (HSSFSheet)wb.getSheetAt(0);
			}catch(Exception e){
				sheet = (XSSFSheet)wb.getSheetAt(0);
			}
			
			int row_num = sheet.getLastRowNum();  
             for(int i = 0; i <= row_num; i++){  
                Row r =  sheet.getRow(i);  
                int cell_num = r.getLastCellNum();  
                if(i == 0){
                	colnames.add("rank");
                	colnames.add("title");
                	colnames.add("issn");
                	colnames.add("cites");
                	colnames.add("factor");
                	colnames.add("5factor");
                	colnames.add("index");
                	colnames.add("articles");
                	colnames.add("halflife");
                	colnames.add("source");
                	colnames.add("influence");
                }else {
                	PubImpactorFactor factor = new PubImpactorFactor();
                	
					boolean flag = false;
					 for(int j = 0; j < cell_num; j++){  
						 String value = "";
						 Cell cell = r.getCell((short)j);
						 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						 if(cell.getCellType() == HSSFCell.CELL_TYPE_STRING){  
							 value = r.getCell((short) j).getStringCellValue();  
						 }else{  
							 value = _doubleTrans(r.getCell((short) j).getNumericCellValue());  
						 }
						 
						 if("rank".equals(colnames.get(j))) {
							if (value == null
									|| value.trim()
											.length() == 0) {
								flag = true;
								break;
							}
							factor.setRank(value);
						 }else if("title".equals(colnames.get(j))){
							if (value == null
									|| value.trim()
											.length() == 0) {
								flag = true;
								break;
						 }
							factor.setJournalTitle(value);
						 }else if("issn".equals(colnames.get(j))) {
							factor.setIssn(value);
						 }else if("cites".equals(colnames.get(j))){
							factor.setTotalCites(value);
						 }else if("factor".equals(colnames.get(j))) {
							factor.setImpactFactor(value);
						 }else if("5factor".equals(colnames.get(j))){
						 	factor.setFiveYearImpactorFactor(value);
						 }else if("index".equals(colnames.get(j))){
							factor.setImmediacyIndex(value);
						 }else if("articles".equals(colnames.get(j))){
							factor.setArticles(value);
						 }else if("halflife".equals(colnames.get(j))){
							factor.setCitedHalflife(value);
						 }else if("source".equals(colnames.get(j))){
							factor.setEigenfactortmSource(value);
					   	 }else if("influence".equals(colnames.get(j))){
							factor.setInfluencetmSource(value);
						 }
					  }
					 if (flag) {
						break; 
					 }
					
					//验证
					for(PubImpactorFactor  f : factorList ){
						if(f.getYear().equals(ifactor.getYear()) && f.getFactorTypeId().equals(ifactor.getFactorTypeId())){
							throw new RuntimeException("已存在相同的年份与类型！"+f.getYear() +"\t" +FactorTypeEnum.getNameById(f.getFactorTypeId()));
						}
						if(f.getYear().equals(ifactor.getYear()) && f.getFactorTypeId().equals(ifactor.getFactorTypeId()) && f.getIssn().equals(factor.getIssn())){
							throw new RuntimeException("已存在相同的ISSN号！"+f.getIssn());
						}
					}
					
					factor.setFactorFlow(PkUtil.getUUID());
					//年份
					factor.setYear(ifactor.getYear());
					//类型
					factor.setFactorTypeId(ifactor.getFactorTypeId());
					factor.setFactorTypeName(FactorTypeEnum.getNameById(ifactor.getFactorTypeId()));
					
					GeneralMethod.setRecordInfo(factor, true);
					impactorFactorMapper.insert(factor);
                }	  
            }
		}
	}

	public static Workbook createCommonWorkbook(InputStream inp) throws IOException, InvalidFormatException { 
		// 首先判断流是否支持mark和reset方法，最后两个if分支中的方法才能支持 
		if (!inp.markSupported()) { 
			// 还原流信息 
			inp = new PushbackInputStream(inp); 
		} 
		// EXCEL2003使用的是微软的文件系统 
		if (POIFSFileSystem.hasPOIFSHeader(inp)) { 
			return new HSSFWorkbook(inp); 
		} 
		// EXCEL2007使用的是OOM文件格式 
		if (POIXMLDocument.hasOOXMLHeader(inp)) { 
			// 可以直接传流参数，但是推荐使用OPCPackage容器打开 
			return new XSSFWorkbook(OPCPackage.open(inp)); 
		} 
		throw new IOException("不能解析的excel版本"); 
	} 
	
	public static String _doubleTrans(double d)
    {
        if((double)Math.round(d) - d == 0.0D)
            return String.valueOf((long)d);
        else
            return String.valueOf(d);
    }
	
	@Override
	public List<PubImpactorFactor> queryImpactorFactorList(PubImpactorFactor factor) {
		PubImpactorFactorExample example = new PubImpactorFactorExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		
		if(StringUtil.isNotBlank(factor.getIssn())){
			criteria.andIssnLike("%"+ factor.getIssn() +"%");
		}
		if(StringUtil.isNotBlank(factor.getJournalTitle())){
			criteria.andJournalTitleLike("%"+ factor.getJournalTitle()+"%");
		}
		if(StringUtil.isNotBlank(factor.getYear())){
			criteria.andYearEqualTo(factor.getYear());
		}
		example.setOrderByClause("YEAR DESC");
		List<PubImpactorFactor> impactorFactorList = impactorFactorMapper.selectByExample(example);
		return impactorFactorList;
	}

	@Override
	public List<PubImpactorFactor> getImpactorFactorByISSN(String issn) {
		PubImpactorFactorExample example = new PubImpactorFactorExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(issn)){
			criteria.andIssnEqualTo(issn);
			example.setOrderByClause("YEAR DESC");
			List<PubImpactorFactor> factorList = impactorFactorMapper.selectByExample(example);
			if(factorList.size() > 0 ){
				return factorList;
			}
		}
		return null;
	}

}
