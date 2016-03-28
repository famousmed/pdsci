package com.pinde.sci.model.srm;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.pinde.sci.model.mo.PubProj;

public class ListToExcel extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> objMap,
			HSSFWorkbook hssfWorkbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		HSSFSheet sheet = hssfWorkbook.createSheet("list");
		getCell(sheet, 0, 0).setCellValue("年份");
		getCell(sheet, 0, 1).setCellValue("项目类别");
		getCell(sheet, 0, 2).setCellValue("项目名称");
		getCell(sheet, 0, 3).setCellValue("起止时间");
		getCell(sheet, 0, 4).setCellValue("项目负责人");
		getCell(sheet, 0, 5).setCellValue("当前阶段");
		getCell(sheet, 0, 6).setCellValue("当前状态");
		getCell(sheet, 0, 7).setCellValue("申报单位");
		List<PubProj> projList=(List<PubProj>) objMap.get("projList");
		HSSFRow sheetRow=null;
		int rowNum=1;
		for(PubProj proj:projList){
			sheetRow=sheet.createRow(rowNum);
			getCell(sheet, rowNum, 0).setCellValue(proj.getProjYear());
			getCell(sheet, rowNum, 1).setCellValue(proj.getProjCategoryName());
			getCell(sheet, rowNum, 2).setCellValue(proj.getProjName());
			getCell(sheet, rowNum, 3).setCellValue(proj.getProjStartTime()+"~"+proj.getProjEndTime());
			getCell(sheet, rowNum, 4).setCellValue(proj.getApplyUserName());
			getCell(sheet, rowNum, 5).setCellValue(proj.getProjStageName());
			getCell(sheet, rowNum, 6).setCellValue(proj.getProjStatusName());
			getCell(sheet, rowNum, 7).setCellValue(proj.getApplyOrgName());
			rowNum++;
		}
		
		String filename = ".xlsx";
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-disposition", "attachment;filename="
				+ filename);
		ServletOutputStream ouputStream = response.getOutputStream();
		hssfWorkbook.write(ouputStream);
		ouputStream.flush();
		ouputStream.close();

	}

}
