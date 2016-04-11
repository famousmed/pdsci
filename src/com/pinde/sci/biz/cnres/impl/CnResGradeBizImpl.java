package com.pinde.sci.biz.cnres.impl;

import java.io.IOException;
import java.io.InputStream;
import java.io.PushbackInputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.poi.POIXMLDocument;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.formula.functions.Value;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.cnres.ICnResExamBiz;
import com.pinde.sci.biz.cnres.ICnResGradeBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.ResDoctorRecruitMapper;
import com.pinde.sci.dao.base.ResExamDoctorMapper;
import com.pinde.sci.dao.base.ResGradeBorderlineMapper;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.dao.res.ResDoctorExtMapper;
import com.pinde.sci.enums.res.RecruitTypeEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResDoctorRecruitExample;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.ResExamDoctor;
import com.pinde.sci.model.mo.ResExamDoctorExample;
import com.pinde.sci.model.mo.ResGradeBorderline;
import com.pinde.sci.model.mo.ResGradeBorderlineExample;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserExample;
import com.pinde.sci.model.res.GradeBorderlineStatistics;
import com.pinde.sci.model.res.GradeStep;
import com.pinde.sci.model.res.GradeStepStatistics;
import com.sun.xml.internal.messaging.saaj.util.ByteInputStream;

@Service
@Transactional(rollbackFor=Exception.class)
public class CnResGradeBizImpl implements ICnResGradeBiz{

	@Autowired
	private ResGradeBorderlineMapper gradeBorderlineMapper;
	@Autowired
	private ResDoctorRecruitMapper doctorRecruitMapper;
	@Autowired
	private ResDoctorExtMapper doctorExtMapper;
	@Autowired
	private ResExamDoctorMapper examDoctorMapper;
	@Autowired
	private SysUserMapper userMapper;
	@Autowired
	private ICnResExamBiz examManageBiz;
	
	

	@Override
	public ResDoctorRecruit findResDoctorRecruitByDoctorFlow(String doctorFlow) {
		return this.doctorRecruitMapper.selectByPrimaryKey(doctorFlow);
	}

	@Override
	public void inputDoctorGrade(String examFlow , String doctorFlow, String examResult) {
		ResExamDoctor record = new ResExamDoctor();
		record.setExamResult(new BigDecimal(examResult));
		ResExamDoctorExample example = new ResExamDoctorExample();
		example.createCriteria()
		.andExamFlowEqualTo(examFlow)
		.andDoctorFlowEqualTo(doctorFlow)
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		GeneralMethod.setRecordInfo(record, false);
		this.examDoctorMapper.updateByExampleSelective(record , example);
	}

	@Override
	public void submitRecruit(ResDoctorRecruitWithBLOBs doctorRecruit) {
		doctorRecruit.setRecruitFlow(PkUtil.getUUID());
		doctorRecruit.setRecruitDate(DateUtil.getCurrDate());
		doctorRecruit.setRetestFlag(GlobalConstant.FLAG_N);
		doctorRecruit.setAdmitFlag(GlobalConstant.FLAG_N);
		doctorRecruit.setRecruitTypeId(RecruitTypeEnum.Fill.getId());
		doctorRecruit.setRecruitTypeName(RecruitTypeEnum.Fill.getName());
		String year = InitConfig.getSysCfg("res_reg_year");
		if(StringUtil.isBlank(year)){
			throw new RuntimeException("后台系统没有设置报名年份");
		}
		doctorRecruit.setRecruitYear(year);
		GeneralMethod.setRecordInfo(doctorRecruit, true);
		this.doctorRecruitMapper.insertSelective(doctorRecruit);
	}

	@Override
	public void importExcel(String examFlow , MultipartFile file) throws InvalidFormatException, IOException {
		InputStream is = file.getInputStream();
		byte[] fileData = new byte[(int)file.getSize()];  
		is.read(fileData); 
		Workbook wb =  createCommonWorkbook(new ByteInputStream(fileData, (int)file.getSize() ));
	    parseExcel(examFlow,wb);
	}

	public static Workbook createCommonWorkbook(InputStream inS) throws IOException, InvalidFormatException { 
		// 首先判断流是否支持mark和reset方法，最后两个if分支中的方法才能支持 
		if (!inS.markSupported()) { 
			// 还原流信息 
			inS = new PushbackInputStream(inS); 
		} 
		// EXCEL2003使用的是微软的文件系统 
		if (POIFSFileSystem.hasPOIFSHeader(inS)) { 
			return new HSSFWorkbook(inS); 
		} 
		// EXCEL2007使用的是OOM文件格式 
		if (POIXMLDocument.hasOOXMLHeader(inS)) { 
			// 可以直接传流参数，但是推荐使用OPCPackage容器打开 
			return new XSSFWorkbook(OPCPackage.open(inS)); 
		} 
		throw new IOException("不能解析的excel版本"); 
	} 
	
	private void parseExcel(String examFlow,Workbook wb)  {
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
                System.err.println(i);
                int cell_num = r.getLastCellNum();  
                if(i == 0){
                	for (int j = 0; j < cell_num; j++) {  
               		 String value = "";
						 if(r.getCell((short)j).getCellType() == 1){  
							 value = r.getCell((short) j).getStringCellValue();  
						 }else{  
							 value = _doubleTrans(r.getCell((short) j).getNumericCellValue());  
						 }  
						 System.err.println(value+"==="); 
						colnames.add(value);
					}
                }else {
                	ResExamDoctor examDoctor = new ResExamDoctor();
                	String name="";
					String ticketNum = "";
					boolean flag = false;
					for(int j = 0; j < cell_num; j++){  
						String value = "";
						 if(r.getCell((short)j).getCellType() == 1){  
							 value = r.getCell((short) j).getStringCellValue();  
						 }else{  
							 value = _doubleTrans(r.getCell((short) j).getNumericCellValue());  
						 }  
						 System.err.println(value+"==="); 
					
						if("姓名".equals(colnames.get(j))) {
							if (value == null
									|| value.trim()
											.length() == 0) {
								flag = true;
								break;
							}
							name = value;
						}else if("准考证号".equals(colnames.get(j))){
							if (value == null
									|| value.trim()
											.length() == 0) {
								flag = true;
								break;
							}
							ticketNum = value;
						}else if("成绩".equals(colnames.get(j))){
							examDoctor.setExamResult(new BigDecimal(value));
						}
				    	GeneralMethod.setRecordInfo(examDoctor, false);
				    	
				    	if (flag) {
							break; 
						}
					}
		    		ResExamDoctorExample examDoctorExample = new ResExamDoctorExample();
		    		examDoctorExample.createCriteria()
		    		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		    		.andExamFlowEqualTo(examFlow)
		    		.andDoctorNameEqualTo(name)
		    		.andTicketNumEqualTo(ticketNum);
					this.examDoctorMapper.updateByExampleSelective(examDoctor, examDoctorExample);
                }	  
            }
		}
	}
	
	public static String _doubleTrans(double d){
        if((double)Math.round(d) - d == 0.0D)
            return String.valueOf((long)d);
        else
            return String.valueOf(d);
    }

	private ResDoctorRecruitExample createResDoctorRecruitExample(ResDoctorRecruit docRecruit){
		ResDoctorRecruitExample example = new ResDoctorRecruitExample();
		if(docRecruit!=null){
			com.pinde.sci.model.mo.ResDoctorRecruitExample.Criteria criteria = example.createCriteria();
			if(StringUtil.isNotBlank(docRecruit.getDoctorFlow())){
				criteria.andDoctorFlowEqualTo(docRecruit.getDoctorFlow());
			}
			if(StringUtil.isNotBlank(docRecruit.getRecordStatus())){
				criteria.andRecordStatusEqualTo(docRecruit.getRecordStatus());
			}
			if(StringUtil.isNotBlank(docRecruit.getRecruitYear())){
				criteria.andRecruitYearEqualTo(docRecruit.getRecruitYear());
			}
		}
		return example;
	}

	@Override
	public ResDoctorRecruit findResDoctorRecruit(String year, String doctorFlow) {
		List<ResDoctorRecruit> recruits = findResDoctorRecruits(year , doctorFlow);
		if(recruits.size()>0){
			return recruits.get(0);
		}
		return null;
	}

	@Override
	public List<ResDoctorRecruit> findResDoctorRecruits(String year,
			String doctorFlow) {
		ResDoctorRecruit docRecruit = new ResDoctorRecruit();
		docRecruit.setRecruitYear(year);
		docRecruit.setDoctorFlow(doctorFlow);
		docRecruit.setRecordStatus(GlobalConstant.FLAG_Y);
		ResDoctorRecruitExample example = createResDoctorRecruitExample(docRecruit);
		example.setOrderByClause("CREATE_TIME DESC");
		List<ResDoctorRecruit> recruits = this.doctorRecruitMapper.selectByExample(example);
		return recruits;
		
	}

	@Override
	public List<ResGradeBorderline> findGradeBorderlineByExamFlow(
			String examFlow) {
		ResGradeBorderlineExample example = new ResGradeBorderlineExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andExamFlowEqualTo(examFlow);
		return gradeBorderlineMapper.selectByExample(example);
	}
	
	
	public ResGradeBorderline findResGradeBorderlineByExamFlowAndSpeId(String examFlow , String speId){
		ResGradeBorderlineExample example = new ResGradeBorderlineExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andExamFlowEqualTo(examFlow)
		.andSpeIdEqualTo(speId);
		List<ResGradeBorderline> borderlines = gradeBorderlineMapper.selectByExample(example);
		if(borderlines.size()==1){
			return borderlines.get(0);
		}
		return null;
	}
	
	@Override
	public Integer getMoreThanGradeDoctorCountInExamForSpe(String examFlow,
			String speId, String moreThanGrade) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("examFlow", examFlow);
		paramMap.put("speId", speId);
		paramMap.put("moreThanGrade", moreThanGrade);
		return this.doctorExtMapper.searchJoinExamDoctorCountByParamMap(paramMap);
	}

	@Override
	public Map<String, GradeBorderlineStatistics> getGradeBorderlineStatistics(
			String examFlow) {
		Map<String , GradeBorderlineStatistics> resultMap = null;
		List<ResGradeBorderline> gradeBorderlines = findGradeBorderlineByExamFlow(examFlow);
		List<SysDict> spes = DictTypeEnum.sysListDictMap.get(DictTypeEnum.GraduateMajor.getId());
		if(spes!=null && !spes.isEmpty()){
			resultMap = new HashMap<String, GradeBorderlineStatistics>();
			for(SysDict dict : spes){
				String speId = dict.getDictId();
				GradeBorderlineStatistics gradeBorderlineStatistics = new GradeBorderlineStatistics();
				//设置总人数
			    Integer doctorCountInExamForSpe = this.examManageBiz.getDoctorCountInExamForSpe(examFlow, speId);
			    gradeBorderlineStatistics.setSum(doctorCountInExamForSpe);
				for(ResGradeBorderline gradeBorderline : gradeBorderlines){
					if(speId.equals(gradeBorderline.getSpeId())){
					    //设置分数线信息
						gradeBorderlineStatistics.setGradeBorderline(gradeBorderline);
						String gradeline = gradeBorderline.getGradeBorderline();
						if(StringUtil.isNotBlank(gradeline)){
							//设置过线人数
							Integer passDoctorCount = getMoreThanGradeDoctorCountInExamForSpe(examFlow , speId , gradeline);
							gradeBorderlineStatistics.setPassCount(passDoctorCount);
						}
						
					}
				}
				resultMap.put(speId, gradeBorderlineStatistics);
			}
		}
		return resultMap;
	}

	@Override
	public void addGradeBorderLine(ResGradeBorderline borderline) {
		if(StringUtil.isBlank(borderline.getBorderlineFlow())){
			borderline.setBorderlineFlow(PkUtil.getUUID());
			if(StringUtil.isBlank(borderline.getGradeStep())){
				borderline.setGradeStep(ICnResGradeBiz.defaultGradeStep.toString());//分数间隔默认为5
			}
			GeneralMethod.setRecordInfo(borderline, true);
			this.gradeBorderlineMapper.insertSelective(borderline);
		}else{
			this.gradeBorderlineMapper.updateByPrimaryKeySelective(borderline);
		}
	}

	@Override
	public List<GradeStep> crateGradeSteps(Integer max, Integer min,
			Integer step) {
		
		if((max-min)<0){
			throw new RuntimeException("异常");
		}
		List<GradeStep> gradeSteps = new ArrayList<GradeStep>();
		if(step==null || step==0){
			step = ICnResGradeBiz.defaultGradeStep;//默认步长
		}
		int segment = (max-min)/step;
		if(((max-min)%step)>0){
			segment = segment + 1;
		}
		int tmp = min;
		for(int i = 0 ; i<segment;i++){
			int start = tmp;
			int end = tmp+step;
			GradeStep gradeStep = new GradeStep();
			gradeStep.setStartGrade(start);
			gradeStep.setEndGrade(end);
			gradeSteps.add(gradeStep);
			tmp = end+1;
			if(end>=max){
				end = max;
				gradeStep.setEndGrade(end);
				break;
			}
			
		}
		return gradeSteps;
	}
	
	@Override
	public Map<String , GradeStepStatistics> getGradeSteps(String examFlow){
		Map<String , GradeStepStatistics> resultMap = new HashMap<String, GradeStepStatistics>();
		List<ResGradeBorderline> gradeBorderlines = findGradeBorderlineByExamFlow(examFlow);
		List<SysDict> spes = DictTypeEnum.sysListDictMap.get(DictTypeEnum.GraduateMajor.getId());
		if(spes!=null && !spes.isEmpty()){
			for(SysDict dict : spes){
				String speId = dict.getDictId();
				GradeStepStatistics gradeStepStatistics = new GradeStepStatistics();
				Integer step = null;
				for(ResGradeBorderline gradeborderline : gradeBorderlines){
					if(speId.equals(gradeborderline.getSpeId())){
						step = Integer.parseInt(gradeborderline.getGradeStep());
						gradeStepStatistics.setGradeBorderline(gradeborderline);
					}
				}
				List<GradeStep> gradeSteps = getGradeStep(examFlow , speId , step);
				if(gradeSteps!=null){
					gradeStepStatistics.setGradeSteps(gradeSteps);
					resultMap.put(speId, gradeStepStatistics);
				}
				
			}
		}
		return resultMap;
	}

	@Override
	public List<GradeStep> getGradeStep(String examFlow, String speId,
			Integer step) {
		Map<String, Object> gradeParamMap = new HashMap<String, Object>();
		gradeParamMap.put("examFlow", examFlow);
		gradeParamMap.put("speId", speId);
		gradeParamMap.put("max", GlobalConstant.FLAG_Y);
		Integer maxGrade = this.doctorExtMapper.searchMaxOrMinGradeInExam(gradeParamMap);
		if(maxGrade==0){
			return null;
		}
		gradeParamMap.put("max", GlobalConstant.FLAG_N);
		gradeParamMap.put("min", GlobalConstant.FLAG_Y);
		Integer minGrade = this.doctorExtMapper.searchMaxOrMinGradeInExam(gradeParamMap);
		List<GradeStep> gradeSteps = crateGradeSteps(maxGrade, minGrade, step);
		for(GradeStep gradeStep : gradeSteps){
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("examFlow", examFlow);
			paramMap.put("speId", speId);
			paramMap.put("startGrade", gradeStep.getStartGrade());
			paramMap.put("endGrade", gradeStep.getEndGrade());
			Integer docCount = this.doctorExtMapper.searchJoinExamDoctorCountByParamMap(paramMap);
			gradeStep.setCount(docCount);
		}
		return gradeSteps;
	}

	@Override
	public BigDecimal findGradeBorderlineByExamFlowAndSpe(String examFlow,
			String speId) {
		ResGradeBorderlineExample example = new ResGradeBorderlineExample();
		example.createCriteria()
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andPublishFlagEqualTo(GlobalConstant.FLAG_Y)
		.andExamFlowEqualTo(examFlow)
		.andSpeIdEqualTo(speId);
		List<ResGradeBorderline> gradeLines = this.gradeBorderlineMapper.selectByExample(example);
		if(gradeLines.size()==1){
			ResGradeBorderline gradeBorderline = gradeLines.get(0);
			if(StringUtil.isNotBlank(gradeBorderline.getGradeBorderline())){
				return new BigDecimal(gradeBorderline.getGradeBorderline());
			}
		}
		return null;
	}
	

	public void modGradeBorderlineStep(ResGradeBorderline borderline){
		if(borderline!=null && StringUtil.isNotBlank(borderline.getGradeStep())){
			ResGradeBorderline record = new ResGradeBorderline();
			record.setGradeStep(borderline.getGradeStep());
			ResGradeBorderlineExample example = new ResGradeBorderlineExample();
			example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
			.andExamFlowEqualTo(borderline.getExamFlow())
			.andSpeIdEqualTo(borderline.getSpeId());
			this.gradeBorderlineMapper.updateByExampleSelective(record, example);
		}
		
	}

}
