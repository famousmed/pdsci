package com.pinde.sci.biz.edc.impl;


import java.io.IOException;
import java.io.InputStream;
import java.io.PushbackInputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.POIXMLDocument;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.core.util.VelocityUtil;
import com.pinde.sci.biz.edc.IEdcRandomBiz;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.edc.IVisitBiz;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.EdcIeMapper;
import com.pinde.sci.dao.base.EdcProjOrgMapper;
import com.pinde.sci.dao.base.EdcProjParamMapper;
import com.pinde.sci.dao.base.EdcRandomRecMapper;
import com.pinde.sci.dao.base.GcpDrugStoreRecMapper;
import com.pinde.sci.dao.base.PubFileMapper;
import com.pinde.sci.dao.base.PubPatientIeMapper;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.dao.edc.EdcRandomRecExtMapper;
import com.pinde.sci.dao.edc.GcpDrugStoreRecExtMapper;
import com.pinde.sci.enums.edc.EdcIETypeEnum;
import com.pinde.sci.enums.edc.EdcRandomAssignLabelEnum;
import com.pinde.sci.enums.edc.EdcRandomAssignStatusEnum;
import com.pinde.sci.enums.edc.EdcRandomAssignTypeEnum;
import com.pinde.sci.enums.edc.EdcRandomTypeEnum;
import com.pinde.sci.enums.edc.PatientTypeEnum;
import com.pinde.sci.enums.gcp.GcpDrugStoreStatusEnum;
import com.pinde.sci.enums.pub.PatientStageEnum;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.pub.WeixinStatusEnum;
import com.pinde.sci.model.edc.RandomDrugGroupForm;
import com.pinde.sci.model.edc.RandomFactor;
import com.pinde.sci.model.edc.RandomInfo;
import com.pinde.sci.model.edc.RandomMinMaxAssignForm;
import com.pinde.sci.model.mo.EdcIe;
import com.pinde.sci.model.mo.EdcProjOrg;
import com.pinde.sci.model.mo.EdcProjOrgExample;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.EdcRandomRec;
import com.pinde.sci.model.mo.EdcRandomRecExample;
import com.pinde.sci.model.mo.EdcRandomRecExample.Criteria;
import com.pinde.sci.model.mo.GcpDrugStoreRec;
import com.pinde.sci.model.mo.GcpDrugStoreRecExample;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubFileForm;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientExample;
import com.pinde.sci.model.mo.PubPatientIe;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjOrg;
import com.pinde.sci.model.mo.SysUser;
import com.sun.xml.internal.messaging.saaj.util.ByteInputStream;
@Service
@Transactional(rollbackFor=Exception.class)
public class EdcRandomBizImpl implements IEdcRandomBiz {
	
	@Resource
	private EdcProjParamMapper projParamMapper;
	@Resource
	private PubFileMapper pubFileMapper;
	@Resource
	private EdcRandomRecMapper randomRecMapper;
	@Resource
	private GcpDrugStoreRecMapper drugStoreRecMapper;
	@Resource
	private GcpDrugStoreRecExtMapper drugStoreRecExtMapper;
	@Resource
	private EdcRandomRecExtMapper randomRecExtMapper;
	@Resource
	private IProjOrgBiz projOrgBiz;
	@Resource
	private IPubPatientBiz patientBiz;
	@Resource
	private EdcProjOrgMapper edcProjOrgMapper;
	@Resource
	private PubProjMapper projMapper;
	@Resource
	private IMsgBiz msgBiz;
	@Resource
	private PubPatientIeMapper patientIeMapper;
	@Resource
	private EdcIeMapper edcIeMapper;
	@Resource
	private IVisitBiz visitBiz;
	

	@Override
	public EdcProjParam readProjParam(String projFlow) {
		return projParamMapper.selectByPrimaryKey(projFlow);
	}

	@Override
	public void addRandomFile(EdcProjParam projParam,PubFileForm fileForm,String projFlow) {
		String fileName =  fileForm.getFile().getOriginalFilename();
		String suffix =fileName.substring(fileName.lastIndexOf(".")+1);  
		PubFile file  = new PubFile();
		file.setFileFlow(PkUtil.getUUID());
		file.setFileSuffix(suffix);
		file.setFileSize(new BigDecimal(fileForm.getFile().getSize()));
		try {
			InputStream is = fileForm.getFile().getInputStream();
			  byte[] fileData = new byte[(int) fileForm.getFile().getSize()];  
			    is.read(fileData);  
			    file.setFileName(fileName);
			    file.setFileContent(fileData);
				try {
					 Workbook wb =  createCommonWorkbook(new ByteInputStream(fileData,(int) fileForm.getFile().getSize() ));
					 parseRandomExcel(projFlow,wb);
				} catch (Exception e) {
					e.printStackTrace();
				}
			    is.close();
		} catch (IOException e) {
			e.printStackTrace();
		}  
		GeneralMethod.setRecordInfo(file, true);
		pubFileMapper.insert(file);
		if (projParam == null) {
			projParam = new EdcProjParam();
			projParam.setProjFlow(projFlow);
			projParam.setRandomFileFlow(file.getFileFlow());
			GeneralMethod.setRecordInfo(projParam, true);
			projParamMapper.insert(projParam);
		} else {
			projParam.setRandomFileFlow(file.getFileFlow());
			GeneralMethod.setRecordInfo(projParam, false);
			projParamMapper.updateByPrimaryKeySelective(projParam);
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
	private void parseRandomExcel(String projFlow,Workbook wb) throws IOException {
		Map<String,String> orgCenterMap = new HashMap<String, String>();
		List<PubProjOrg> projOrgList = projOrgBiz.searchProjOrg(projFlow);
		for(PubProjOrg projOrg : projOrgList){
			orgCenterMap.put(String.valueOf(projOrg.getCenterNo()), projOrg.getOrgFlow());
		}
        // first sheet
		int sheetNum = wb.getNumberOfSheets();
		if(sheetNum>0){
			List<String> colnames = new ArrayList<String>();
			Sheet sheet;
			try {
				sheet = (HSSFSheet) wb.getSheetAt(0);
			} catch (Exception e) {
				sheet = (XSSFSheet)wb.getSheetAt(0);
			}
			 int row_num = sheet.getLastRowNum();  
             for (int i = 0; i <= row_num; i++) {  
                Row r =  sheet.getRow(i);  
                int cell_num = r.getLastCellNum();  
                if (i == 0) {
                	for (int j = 0; j < cell_num; j++) {  
                		 String value = "";
						 if(r.getCell((short)j).getCellType() == 1){  
							 value = r.getCell((short) j).getStringCellValue();  
						 }else{  
							 value = _doubleTrans(r.getCell((short) j).getNumericCellValue());  
						 }  
						colnames.add(value);
					}
                }else {
                	EdcRandomRec randomRec = new EdcRandomRec();
                	randomRec.setRecordFlow(PkUtil.getUUID());
					boolean flag = false;
					 for (int j = 0; j < cell_num; j++) {  
						 String value = "";
						 if(r.getCell((short)j).getCellType() == 1){  
							 value = r.getCell((short) j).getStringCellValue();  
						 }else{  
							 value = _doubleTrans(r.getCell((short) j).getNumericCellValue());  
						 }  
						if ("cn".equals(colnames.get(j))) {
							if (value == null
									|| value.trim()
											.length() == 0) {
								flag = true;
								break;
							}
//							randomRec.setCenterNo(value);
							randomRec.setOrgFlow(orgCenterMap.get(value));
						} else if ("obsid".equals(colnames.get(j))) {
							if (value == null
									|| value.trim()
											.length() == 0) {
								flag = true;
								break;
							}
							randomRec.setOrdinal(Integer.parseInt(value));
						} else if ("pack".equals(colnames.get(j))) {
							randomRec.setDrugPack(value);
						} else if ("block".equals(colnames.get(j))) {
							randomRec.setBlockNum(value);
						} else if ("group".equals(colnames.get(j))) {
							randomRec.setDrugGroup(value);
						} else if ("factor".equals(colnames.get(j))) {
							randomRec.setDrugFactorId(value); 
						}
					}
					if (flag) {
						break;
					}
					randomRec.setProjFlow(projFlow);
					randomRec.setAssignStatusId(EdcRandomAssignStatusEnum.UnAssign.getId());
					randomRec.setAssignStatusName(EdcRandomAssignStatusEnum.UnAssign.getName());
					randomRec.setAssignEmail(GlobalConstant.FLAG_N);
					randomRec.setPromptEmail(GlobalConstant.FLAG_N);
					GeneralMethod.setRecordInfo(randomRec, true);
					randomRecMapper.insert(randomRec);
                }	  
            }
		}
		if(sheetNum>1){
			List<String> colnames = new ArrayList<String>();
			Sheet sheet;
			try {
				sheet = (HSSFSheet) wb.getSheetAt(1);
			} catch (Exception e) {
				sheet = (XSSFSheet)wb.getSheetAt(1);
			}
			 int row_num = sheet.getLastRowNum();  
             for (int i = 0; i <= row_num; i++) {  
                Row r =  sheet.getRow(i);  
                int cell_num = r.getLastCellNum();  
                if (i == 0) {
                	for (int j = 0; j < cell_num; j++) {  
                		 String value = "";
						 if(r.getCell((short)j).getCellType() == 1){  
							 value = r.getCell((short) j).getStringCellValue();  
						 }else{  
							 value = _doubleTrans(r.getCell((short) j).getNumericCellValue());  
						 }  
						colnames.add(value);
					}
                }else {
                	GcpDrugStoreRec drugStoreRec = new GcpDrugStoreRec();
                	drugStoreRec.setRecordFlow(PkUtil.getUUID());
					boolean flag = false;
					 for (int j = 0; j < cell_num; j++) {  
						 String value = "";
						 if(r.getCell((short)j).getCellType() == 1){  
							 value = r.getCell((short) j).getStringCellValue();  
						 }else{  
							 value = _doubleTrans(r.getCell((short) j).getNumericCellValue());  
						 }  
						if ("cn".equals(colnames.get(j))) {
							if (value == null
									|| value.trim()
											.length() == 0) {
								flag = true;
								break;
							}
//							drugStoreRec.setCenterNo(value);
							drugStoreRec.setOrgFlow(orgCenterMap.get(value));
						} else if ("obsid".equals(colnames.get(j))) {
							if (value == null
									|| value.trim()
											.length() == 0) {
								flag = true;
								break;
							}
							drugStoreRec.setOrdinal(Integer.parseInt(value));
						} else if ("pack".equals(colnames.get(j))) {
							drugStoreRec.setDrugPack(value);
						} else if ("group".equals(colnames.get(j))) {
							drugStoreRec.setDrugGroup(value);
						} else if ("factor".equals(colnames.get(j))) {
							drugStoreRec.setDrugFactorId(value);
						}
					}
					if (flag) {
						break;
					}
					drugStoreRec.setProjFlow(projFlow);
					drugStoreRec.setDrugStatusId(GcpDrugStoreStatusEnum.UnSend.getId());
					drugStoreRec.setDrugStatusName(GcpDrugStoreStatusEnum.UnSend.getName());
					drugStoreRec.setAssignEmail(GlobalConstant.FLAG_N);
					GeneralMethod.setRecordInfo(drugStoreRec, true);
					drugStoreRecMapper.insert(drugStoreRec);
                }	  
            }
		}
	}

	@Override
	public Map<String, EdcRandomRec> getPatientRandomMap(String projFlow,String orgFlow) {
		 List<EdcRandomRec> recList = searchPatientRandom(projFlow,orgFlow);
		 Map<String,EdcRandomRec> map = new HashMap<String, EdcRandomRec>();
		 for(EdcRandomRec rec : recList){
			 map.put(rec.getPatientFlow(), rec);
		 }
		 return map;
	}
	
	@Override
	public List<EdcRandomRec> searchPatientRandom(String projFlow,String orgFlow) {
		 EdcRandomRecExample example = new EdcRandomRecExample();
		 example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		 .andAssignStatusIdEqualTo(EdcRandomAssignStatusEnum.Assigned.getId());
		 example.setOrderByClause("ASSIGN_TIME");
		 return randomRecMapper.selectByExample(example);
	}

	@Override
	public synchronized String  assign(Map<String,String> ieValueMap,EdcProjParam projParam,String assignLabel,PubPatient currPatient,
			String layerFactors,String assignTypeId,SysUser assignUser) {
		String randomType = projParam.getRandomTypeId();
		String patientFlow = currPatient.getPatientFlow();
		
		String res = "";
		if(EdcRandomTypeEnum.Dynamic.getId().equals(randomType)){ //动态随机
			if(EdcRandomAssignLabelEnum.First.getId().equals(assignLabel)){
				res = _dynamicAssign(currPatient,layerFactors,projParam,assignTypeId, assignUser);
			}else if(EdcRandomAssignLabelEnum.Follow.getId().equals(assignLabel)){
				res = _dynamicAssignFollow(currPatient,layerFactors,projParam,assignTypeId,assignUser);
			}
		}else if(EdcRandomTypeEnum.BlockCompetition.getId().equals(randomType)){
			if(EdcRandomAssignLabelEnum.First.getId().equals(assignLabel)){
				res = _competitionAssign(currPatient,layerFactors,projParam,assignTypeId,assignUser);
			}else if(EdcRandomAssignLabelEnum.Follow.getId().equals(assignLabel)){
				//随访待添加
			} 
		}
		
		if (StringUtil.isNotBlank(res) && res.indexOf(GlobalConstant.RANDOM_SUCCESSED) >-1) {
			if (EdcRandomAssignLabelEnum.First.getId().equals(assignLabel)) {//入组申请
				//保存纳入排除值
				if (ieValueMap != null) {	
					savePatientIe(patientFlow, ieValueMap);
				}
				//保存访视窗
				patientBiz.createPatientWindow(patientFlow);
			}
		}
		
		return res;
	}

	private String _competitionAssign(PubPatient patient,
			String layerFactors, EdcProjParam projParam, String assignTypeId,SysUser assignUser) {
		boolean isBlind = GeneralMethod.isBlind(projParam);
		EdcRandomRecExample example1 = new EdcRandomRecExample();
		Criteria criteria =  example1.createCriteria().andProjFlowEqualTo(patient.getProjFlow()).andOrgFlowEqualTo(patient.getOrgFlow()) 
		.andAssignStatusIdEqualTo(EdcRandomAssignStatusEnum.UnAssign.getId())
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(layerFactors)){ 
			criteria.andDrugFactorIdEqualTo(layerFactors); 
		}
		example1.setOrderByClause("ORDINAL");
		List<EdcRandomRec> recList = randomRecMapper.selectByExample(example1);
		EdcRandomRec randomRec = null;
		if(recList!=null && recList.size()>0){
			//本中心存在可用随机号
			randomRec = recList.get(0);
		}else {
			//查找新的区组
			EdcRandomRecExample example2 = new EdcRandomRecExample();
			Criteria criteria2 =  example2.createCriteria().andProjFlowEqualTo(patient.getProjFlow()).andOrgFlowIsNull() 
			.andAssignStatusIdEqualTo(EdcRandomAssignStatusEnum.UnAssign.getId())
			.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			if(StringUtil.isNotBlank(layerFactors)){ 
				criteria2.andDrugFactorIdEqualTo(layerFactors); 
			}
			example2.setOrderByClause("ORDINAL");
			List<EdcRandomRec> recList2 = randomRecMapper.selectByExample(example2);
			randomRec = recList2.get(0);
		}
		
		
		if(randomRec!= null){
			RandomInfo info = new RandomInfo();
			
			int patientCount = patientBiz.getPatientMaxCount(patient.getProjFlow());
			String randomCode = String.valueOf(patientCount+1);
			String factorName = _getDrugFactorName(layerFactors,GeneralMethod.getRandomFactor(projParam.getRandomFactor()));
			
			randomRec.setDrugFactorName(factorName); //回写 方便显示
			randomRec.setPatientFlow(patient.getPatientFlow());
			randomRec.setPatientCode(patient.getPatientCode());
			//标记机构
			randomRec.setOrgFlow(patient.getOrgFlow());  
			randomRec.setRandomCode(randomCode);
			randomRec.setAssignStatusId(EdcRandomAssignStatusEnum.Assigned.getId());
			randomRec.setAssignStatusName(EdcRandomAssignStatusEnum.Assigned.getName());
			randomRec.setAssignUserFlow(assignUser.getUserFlow());
			randomRec.setAssignUserName(assignUser.getUserName());
			randomRec.setAssignLabelId(EdcRandomAssignLabelEnum.First.getId());
			randomRec.setAssignLabelName(EdcRandomAssignLabelEnum.First.getName());
			randomRec.setAssignTypeId(assignTypeId);
			randomRec.setAssignTypeName(EdcRandomAssignTypeEnum.getNameById(assignTypeId));
			randomRec.setAssignTime(DateUtil.getCurrDateTime());
			randomRec.setAssignEmail(GlobalConstant.FLAG_N);
		
			
			
			//盲法继续找药，非盲法结束
			if(isBlind){
				String group = randomRec.getDrugGroup();
				GcpDrugStoreRecExample drugStoreRecExample = new GcpDrugStoreRecExample();
				com.pinde.sci.model.mo.GcpDrugStoreRecExample.Criteria drugCriteria =  drugStoreRecExample.createCriteria()
				.andProjFlowEqualTo(patient.getProjFlow())
				.andOrgFlowEqualTo(patient.getOrgFlow()).andDrugGroupEqualTo(group).andDrugStatusIdEqualTo(GcpDrugStoreStatusEnum.UnSend.getId())
				.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
				if(StringUtil.isNotEmpty(layerFactors)){ 
					drugCriteria.andDrugFactorIdEqualTo(layerFactors);
				}
				drugStoreRecExample.setOrderByClause("ORDINAL");
				
				List<GcpDrugStoreRec> drugRecList = drugStoreRecMapper.selectByExample(drugStoreRecExample);
				if(drugRecList!=null&&drugRecList.size()>0){
					GcpDrugStoreRec drugStore =  drugRecList.get(0);
					
					//回写drugPack  待确认字段
					randomRec.setDrugPack(drugStore.getDrugPack());
					
					drugStore.setDrugStatusId(GcpDrugStoreStatusEnum.Send.getId());
					drugStore.setDrugStatusName(GcpDrugStoreStatusEnum.Send.getName());
					drugStore.setDrugFactorName(factorName);				//回写 方便显示
					drugStore.setAssignUserFlow(assignUser.getUserFlow());
					drugStore.setAssignUserName(assignUser.getUserName());
					drugStore.setAssignTime(DateUtil.getCurrDateTime());
					drugStore.setAssignLabelId(EdcRandomAssignLabelEnum.First.getId());
					drugStore.setAssignLabelName(EdcRandomAssignLabelEnum.First.getName());
					drugStore.setAssignTypeId(assignTypeId);
					drugStore.setAssignTypeName(EdcRandomAssignTypeEnum.getNameById(assignTypeId)); 
					drugStore.setPatientFlow(patient.getPatientFlow());
					drugStore.setPatientCode(patient.getPatientCode());
					drugStore.setAssignEmail(GlobalConstant.FLAG_Y);
					drugStoreRecMapper.updateByPrimaryKey(drugStore);
					
				}else {
					return GlobalConstant.RANDOM_FAIL_DRUG;
				}
			}
			GeneralMethod.setRecordInfo(randomRec, false);
			randomRecMapper.updateByPrimaryKeySelective(randomRec);
			//将该区组置为本中心
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("projFlow", patient.getProjFlow());
			map.put("blockNum", randomRec.getBlockNum());
			map.put("orgFlow", patient.getOrgFlow());
			randomRecExtMapper.updateBlock(map);
			
			patient.setPatientStageId(PatientStageEnum.In.getId());
			patient.setPatientStageName(PatientStageEnum.In.getName());
			patient.setInDate(DateUtil.getCurrDateTime());
			patient.setInDoctorFlow(assignUser.getUserFlow());
			patient.setInDoctorName(assignUser.getUserName());
			patientBiz.modifyPatient(patient);
			
			info.setPatient(patient);
			info.setRandomRec(randomRec);
			
			
			//添加短信邮件
			_addAssignMsg(info,isBlind,assignUser);
			if(isBlind){
				return GlobalConstant.RANDOM_SUCCESSED +",药物编码："+info.getRandomRec().getDrugPack();
			}else {
				return GlobalConstant.RANDOM_SUCCESSED +",药物组别："+info.getRandomRec().getDrugGroup();
			}
		}else {
			return GlobalConstant.RANDOM_FAIL_RREC;
		}
	}

	//动态随机_入组
	private String _dynamicAssign(PubPatient patient, String layerFactors,EdcProjParam projParam ,String assignTypeId,SysUser assignUser) {
		boolean isBlind = GeneralMethod.isBlind(projParam);
		EdcRandomRecExample example = new EdcRandomRecExample();
		Criteria criteria =  example.createCriteria().andProjFlowEqualTo(patient.getProjFlow())
		.andOrgFlowEqualTo(patient.getOrgFlow()).andAssignStatusIdEqualTo(EdcRandomAssignStatusEnum.UnAssign.getId())
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(layerFactors)){ 
			criteria.andDrugFactorIdEqualTo(layerFactors); 
		}
		example.setOrderByClause("ORDINAL");
		List<EdcRandomRec> recList = randomRecMapper.selectByExample(example);
		
		if(recList!=null && recList.size()>0){
			EdcRandomRec randomRec = recList.get(0);
			RandomInfo info = new RandomInfo();
			
			int patientCount = patientBiz.getPatientMaxCount(patient.getProjFlow());
			String randomCode = String.valueOf(patientCount+1);
			String factorName = _getDrugFactorName(layerFactors,GeneralMethod.getRandomFactor(projParam.getRandomFactor()));
			
			randomRec.setDrugFactorName(factorName); //回写 方便显示
			randomRec.setPatientFlow(patient.getPatientFlow());
			randomRec.setPatientCode(patient.getPatientCode());
			randomRec.setRandomCode(randomCode);
			randomRec.setAssignStatusId(EdcRandomAssignStatusEnum.Assigned.getId());
			randomRec.setAssignStatusName(EdcRandomAssignStatusEnum.Assigned.getName());
			randomRec.setAssignUserFlow(assignUser.getUserFlow());
			randomRec.setAssignUserName(assignUser.getUserName());
			randomRec.setAssignLabelId(EdcRandomAssignLabelEnum.First.getId());
			randomRec.setAssignLabelName(EdcRandomAssignLabelEnum.First.getName());
			randomRec.setAssignTypeId(assignTypeId);
			randomRec.setAssignTypeName(EdcRandomAssignTypeEnum.getNameById(assignTypeId));
			randomRec.setAssignTime(DateUtil.getCurrDateTime());
			randomRec.setAssignEmail(GlobalConstant.FLAG_N);
		
			
			
			//盲法继续找药，非盲法结束
			if(isBlind){
				String group = randomRec.getDrugGroup();
				GcpDrugStoreRecExample drugStoreRecExample = new GcpDrugStoreRecExample();
				com.pinde.sci.model.mo.GcpDrugStoreRecExample.Criteria drugCriteria =  drugStoreRecExample.createCriteria()
				.andProjFlowEqualTo(patient.getProjFlow())
				.andOrgFlowEqualTo(patient.getOrgFlow()).andDrugGroupEqualTo(group).andDrugStatusIdEqualTo(GcpDrugStoreStatusEnum.UnSend.getId())
				.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
				if(StringUtil.isNotEmpty(layerFactors)){ 
					drugCriteria.andDrugFactorIdEqualTo(layerFactors);
				}
				drugStoreRecExample.setOrderByClause("ORDINAL");
				
				List<GcpDrugStoreRec> drugRecList = drugStoreRecMapper.selectByExample(drugStoreRecExample);
				if(drugRecList!=null&&drugRecList.size()>0){
					GcpDrugStoreRec drugStore =  drugRecList.get(0);
					
					//回写drugPack  待确认字段
					randomRec.setDrugPack(drugStore.getDrugPack());
					
					drugStore.setDrugStatusId(GcpDrugStoreStatusEnum.Send.getId());
					drugStore.setDrugStatusName(GcpDrugStoreStatusEnum.Send.getName());
					drugStore.setDrugFactorName(factorName);				//回写 方便显示
					drugStore.setAssignUserFlow(assignUser.getUserFlow());
					drugStore.setAssignUserName(assignUser.getUserName());
					drugStore.setAssignTime(DateUtil.getCurrDateTime());
					drugStore.setAssignLabelId(EdcRandomAssignLabelEnum.First.getId());
					drugStore.setAssignLabelName(EdcRandomAssignLabelEnum.First.getName());
					drugStore.setAssignTypeId(assignTypeId);
					drugStore.setAssignTypeName(EdcRandomAssignTypeEnum.getNameById(assignTypeId)); 
					drugStore.setPatientFlow(patient.getPatientFlow());
					drugStore.setPatientCode(patient.getPatientCode());
					drugStore.setAssignEmail(GlobalConstant.FLAG_Y);
					drugStoreRecMapper.updateByPrimaryKey(drugStore);
					
				}else {
					return GlobalConstant.RANDOM_FAIL_DRUG;
				}
			}
			//添加短信邮件
			GeneralMethod.setRecordInfo(randomRec, false);
			randomRecMapper.updateByPrimaryKeySelective(randomRec);
			
			patient.setPatientStageId(PatientStageEnum.In.getId());
			patient.setPatientStageName(PatientStageEnum.In.getName());
			patient.setInDate(DateUtil.getCurrDateTime());
			patient.setInDoctorFlow(assignUser.getUserFlow());
			patient.setInDoctorName(assignUser.getUserName());
			patientBiz.modifyPatient(patient);
			
			info.setPatient(patient);
			info.setRandomRec(randomRec);
			_addAssignMsg(info,isBlind,assignUser);
			if(isBlind){
				return GlobalConstant.RANDOM_SUCCESSED +",药物编码："+info.getRandomRec().getDrugPack();
			}else {
				return GlobalConstant.RANDOM_SUCCESSED +",药物组别："+info.getRandomRec().getDrugGroup();
			}
		}else {
			return GlobalConstant.RANDOM_FAIL_RREC;
		}
	}
	private void _addAssignMsg(RandomInfo info,Boolean isBlind,  SysUser user) {
		
		EdcRandomRec rec = info.getRandomRec();
		
		String projFlow = rec.getProjFlow();
		PubProj proj = projMapper.selectByPrimaryKey(projFlow);
		
		String title = InitConfig.getSysCfg("edc_random_assign_email_title");
		String content = InitConfig.getSysCfg("edc_random_assign_email_content");
		
		Map<String,String> dataMap = new HashMap<String, String>();
		dataMap.put("projName", proj.getProjName());
		dataMap.put("projShortName", proj.getProjShortName());
		dataMap.put("randomCode", rec.getRandomCode());
		dataMap.put("patientCode", rec.getPatientCode());
		dataMap.put("assignUserName",rec.getAssignUserName());
		dataMap.put("assignLabelName",rec.getAssignLabelName());
		
		if(isBlind){
			dataMap.put("drugPack", "药物编码："+rec.getDrugPack());
			dataMap.put("drugGroup", " ");
		}else {
			dataMap.put("drugPack", " ");
			dataMap.put("drugGroup", "药物组别："+rec.getDrugGroup());
		}
		dataMap.put("patientBirthday", info.getPatient().getPatientBirthday());
		dataMap.put("assignTime",DateUtil.transDate(rec.getAssignTime(),"yyyy-MM-dd HH:mm:ss"));
		
		try {
			title = VelocityUtil.evaluate(title,dataMap);
			content = VelocityUtil.evaluate(content,dataMap);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		if(StringUtil.isNotBlank(user.getUserEmail())){ 
			msgBiz.addEmailMsg(user.getUserEmail(), title, content);
		}
		if(StringUtil.isNotBlank(user.getUserPhone())){ 
			msgBiz.addSmsMsg(user.getUserPhone(), content);
		}
		if(StringUtil.isEquals(InitConfig.getSysCfg("sys_weixin_qiye_flag"), GlobalConstant.FLAG_Y)&&UserStatusEnum.Activated.getId().equals(user.getStatusId())&&WeixinStatusEnum.Status1.getId().equals(user.getWeiXinStatusId())){
			msgBiz.addWeixinMsg(user.getUserFlow(), title, content);
		}
	}

	//动态随机_随访
	private String _dynamicAssignFollow(PubPatient patient,
			String layerFactors,EdcProjParam projParam ,String assignTypeId,SysUser assignUser) {
		String projFlow = patient.getProjFlow();
		boolean isBlind = GeneralMethod.isBlind(projParam);
		//随访不再申请randomRec记录，，直接申请药物，同时回写本次申请相关数据，方便短信邮件提醒
		
		RandomInfo randomInfo = getRandomInfo(patient.getPatientFlow());
		EdcRandomRec randomRec = randomInfo.getRandomRec();
		if(randomRec!=null){
			
			String group = randomRec.getDrugGroup();
			
			GcpDrugStoreRecExample drugStoreRecExample = new GcpDrugStoreRecExample();
			com.pinde.sci.model.mo.GcpDrugStoreRecExample.Criteria drugCriteria = drugStoreRecExample.createCriteria().andProjFlowEqualTo(projFlow)
			.andOrgFlowEqualTo(patient.getOrgFlow())
			.andDrugGroupEqualTo(group)
			.andDrugStatusIdEqualTo(GcpDrugStoreStatusEnum.UnSend.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			if(StringUtil.isNotBlank(layerFactors)){ 
				drugCriteria.andDrugFactorIdEqualTo(layerFactors);
			}
			drugStoreRecExample.setOrderByClause("ORDINAL");
			
			List<GcpDrugStoreRec> drugRecList = drugStoreRecMapper.selectByExample(drugStoreRecExample);
			if(drugRecList!=null&&drugRecList.size()>0){
				GcpDrugStoreRec drugStore =  drugRecList.get(0);
				
				String factorName =  _getDrugFactorName(layerFactors,GeneralMethod.getRandomFactor(projParam.getRandomFactor()));
				
				//更新为最后一次申请记录
				randomRec.setAssignUserFlow(GlobalContext.getCurrentUser().getUserFlow());
				randomRec.setAssignUserName(GlobalContext.getCurrentUser().getUserName());
				randomRec.setAssignLabelId(EdcRandomAssignLabelEnum.Follow.getId());
				randomRec.setAssignLabelName(EdcRandomAssignLabelEnum.Follow.getName());
				randomRec.setAssignTypeId(assignTypeId);
				randomRec.setAssignTypeName(EdcRandomAssignTypeEnum.getNameById(assignTypeId)); 
				randomRec.setAssignTime(DateUtil.getCurrDateTime());
				randomRec.setAssignEmail(GlobalConstant.FLAG_N);
//				//回写drugPack  待确认字段
				randomRec.setDrugPack(drugStore.getDrugPack());
				randomRec.setDrugFactorId(layerFactors);
				randomRec.setDrugFactorName(factorName); //回写 方便显示
				
				GeneralMethod.setRecordInfo(randomRec, false);
				randomRecMapper.updateByPrimaryKeySelective(randomRec);
				
				
				drugStore.setDrugStatusId(GcpDrugStoreStatusEnum.Send.getId());
				drugStore.setDrugStatusName(GcpDrugStoreStatusEnum.Send.getName());
				drugStore.setDrugFactorName(factorName);				//回写 方便显示
				drugStore.setAssignUserFlow(assignUser.getUserFlow());
				drugStore.setAssignUserName(assignUser.getUserName());
				drugStore.setAssignTime(DateUtil.getCurrDateTime());
				drugStore.setAssignLabelId(EdcRandomAssignLabelEnum.Follow.getId());
				drugStore.setAssignLabelName(EdcRandomAssignLabelEnum.Follow.getName());
				drugStore.setAssignTypeId(assignTypeId);
				drugStore.setAssignTypeName(EdcRandomAssignTypeEnum.getNameById(assignTypeId));
				drugStore.setPatientFlow(patient.getPatientFlow());
				drugStore.setPatientCode(patient.getPatientCode());
				drugStore.setAssignEmail(GlobalConstant.FLAG_Y);
				drugStoreRecMapper.updateByPrimaryKey(drugStore);
				
				//添加短信邮件
				RandomInfo info = new RandomInfo();
				info.setPatient(patient);
				info.setRandomRec(randomRec);
				_addAssignMsg(info,isBlind,GlobalContext.getCurrentUser());
				
				return GlobalConstant.RANDOM_SUCCESSED +",药物编码："+ drugStore.getDrugPack();
			}else {
				return GlobalConstant.RANDOM_FAIL_DRUG;
			}
		}
		else {
			return GlobalConstant.RANDOM_FAIL_RREC;
		}
	}
	
	private String _getDrugFactorName(String layerFactors,List<RandomFactor> factors) {
		String factorName = "";
        if(layerFactors != null && layerFactors.length() > 0)
        {
            for(int j = 0; j < layerFactors.length(); j++)
            {
                String temp = layerFactors.substring(j, j + 1);
                for(RandomFactor factor : factors){
                	if(factor.getIndex().equals(String.valueOf(j+1))){
                		if(StringUtil.isNotBlank(factorName)){
                			factorName += ";";
                		}
                		factorName += factor.getItemMap().get(temp);
                	}
                }
            }
        }
        return factorName;
	}
	
	@Override
	public void modify(EdcProjParam param) {
		GeneralMethod.setRecordInfo(param, false);
		projParamMapper.updateByPrimaryKeySelective(param);
	}

	@Override
	public void addProjParam(EdcProjParam param) {
		GeneralMethod.setRecordInfo(param, true);
		projParamMapper.insert(param);
	}

	@Override
	public List<EdcRandomRec> searchPatientRandomRec(String patientFlow) {
		EdcRandomRecExample example = new EdcRandomRecExample();
		example.createCriteria().andPatientFlowEqualTo(patientFlow).andAssignStatusIdEqualTo(EdcRandomAssignStatusEnum.Assigned.getId())
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);	
		example.setOrderByClause("assign_Time");
		return randomRecMapper.selectByExample(example);
	}
	@Override
	public List<EdcRandomRec> searchRandomRec(EdcRandomRecExample example) { 
		return randomRecMapper.selectByExample(example);
	}

	@Override
	public RandomInfo getRandomInfo(String patientFlow) {
		RandomInfo randomInfo = new RandomInfo();
		randomInfo.setPatient(patientBiz.readPatient(patientFlow));
		
		 List<EdcRandomRec> randomRecList = searchPatientRandomRec(patientFlow);
		 if(randomRecList!=null && randomRecList.size()>0){
			 randomInfo.setRandomRec(randomRecList.get(randomRecList.size()-1));
			 
			 GcpDrugStoreRecExample example = new GcpDrugStoreRecExample();
			 example.createCriteria().andPatientFlowEqualTo(patientFlow)
			 .andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			 example.setOrderByClause("assign_time");
			 List<GcpDrugStoreRec> drugRecList = drugStoreRecMapper.selectByExample(example);
			 randomInfo.setDrugRecList(drugRecList);
		 }
		return randomInfo;
	}

	@Override
	public Map<String, String> getOrgAssignDateMap(String projFlow) {
		List<RandomMinMaxAssignForm> orgAssignForm = drugStoreRecExtMapper.selectAssignDate(projFlow);
		Map<String,String> assignDateMap = new HashMap<String, String>();
		for(RandomMinMaxAssignForm form: orgAssignForm){
			assignDateMap.put(form.getOrgFlow()+"_Min", form.getMinAssignDate());
			assignDateMap.put(form.getOrgFlow()+"_Max", form.getMaxAssignDate());
			assignDateMap.put(form.getOrgFlow()+"_Count", form.getAssignCount());
		}
		return assignDateMap;
	}
	
	@Override
	public Map<String,Object> getOrgAssignMap(String projFlow,String orgFlow) {
		Map<String,Object> assignMap = new HashMap<String, Object>();
		Map<String,Integer> assignNumMap = new HashMap<String, Integer>();
		Map<String,Integer> assignOrgNumMap = new HashMap<String, Integer>();
		PubPatientExample example = new PubPatientExample();
		if (StringUtil.isNotBlank(orgFlow)) {
			example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
			.andPatientStageIdNotEqualTo(PatientStageEnum.Filter.getId());
		} else {
			example.createCriteria().andProjFlowEqualTo(projFlow).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
			.andPatientStageIdNotEqualTo(PatientStageEnum.Filter.getId());
		}
		example.setOrderByClause("IN_DATE");
		List<PubPatient> patientList = patientBiz.searchPatient(example);
		List<String> inDateList  = new ArrayList<String>();
		if (patientList != null && patientList.size() > 0) {
			for(PubPatient patient : patientList){
				String orgflow = patient.getOrgFlow();
				String inDate = DateUtil.transDate(patient.getInDate());
				if (!inDateList.contains(inDate)) {
					inDateList.add(inDate);
				}
				//assignNumMap
				int assignNum = 0;
				if (assignNumMap.get(orgflow) != null) {
					assignNum = assignNumMap.get(orgflow);
				}
				assignNum++;
				assignNumMap.put(orgflow, assignNum);
				//assignOrgNumMap
				int assignOrgNum = 0;
				if (assignOrgNumMap.get(orgflow+"_"+inDate) != null) {
					assignOrgNum = assignOrgNumMap.get(orgflow+"_"+inDate);
				}
				assignOrgNum++;
				assignOrgNumMap.put(orgflow+"_"+inDate, assignOrgNum);
			}
		}
		assignNumMap.put("inNum", patientList==null?0:patientList.size());
		assignNumMap.put("total", countPatient(projFlow,orgFlow));
		
		assignMap.put("inDateList", inDateList);
		assignMap.put("assignNum", assignNumMap);
		assignMap.put("assignOrgNum", assignOrgNumMap);
		return assignMap;
	}
	
	@Override
	public EdcRandomRec readEdcRandomRec(String recFlow) { 
		return randomRecMapper.selectByPrimaryKey(recFlow);
	}

	@Override
	public List<EdcRandomRec> searchRandomRecList(EdcRandomRecExample example) {
		return randomRecMapper.selectByExample(example);
	}

	@Override
	public int modifyEdcRandomRec(EdcRandomRec randomRec) {
		GeneralMethod.setRecordInfo(randomRec, false);
		int result = randomRecMapper.updateByPrimaryKeySelective(randomRec);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.ONE_LINE; 
		}
		return GlobalConstant.ZERO_LINE; 
	}

	@Override
	public EdcProjOrg readEdcProjParam(String projFlow, String orgFlow) {
		EdcProjOrgExample example = new EdcProjOrgExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcProjOrg> list = edcProjOrgMapper.selectByExample(example);
		if(list!=null && list.size()>0){
			return list.get(0);
		}
		return null;
	}

	@Override
	public void addEdcProjOrg(EdcProjOrg epo) {
		GeneralMethod.setRecordInfo(epo, true);
		edcProjOrgMapper.insert(epo);
	}

	@Override
	public void modifyEdcProjOrg(EdcProjOrg epo) {
		GeneralMethod.setRecordInfo(epo, false);
		edcProjOrgMapper.updateByPrimaryKeySelective(epo);
	}

	@Override
	public Map<String, EdcProjOrg> getEdcPropOrgMap(String projFlow) {
		EdcProjOrgExample example = new EdcProjOrgExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcProjOrg> list = edcProjOrgMapper.selectByExample(example);
		Map<String,EdcProjOrg> map = new HashMap<String, EdcProjOrg>();
		for(EdcProjOrg epo : list){
			map.put(epo.getOrgFlow(), epo);
		}
		return map;
	}

	@Override
	public Integer countAssign(String projFlow) {
		PubPatientExample example = new PubPatientExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andPatientStageIdNotEqualTo(PatientStageEnum.Filter.getId());
		int patienCount = patientBiz.count(example);
		return patienCount;
	}
	
	@Override
	public Integer countPatient(String projFlow,String orgFlow) {
		PubPatientExample example = new PubPatientExample();
		if (StringUtil.isNotBlank(orgFlow)) {
			example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		} else {
			example.createCriteria().andProjFlowEqualTo(projFlow).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		}
		int patienCount = patientBiz.count(example);
		return patienCount;
	}

	@Override
	public List<GcpDrugStoreRec> searchDrugAssignRec(String projFlow,String orgFlow) {
		GcpDrugStoreRecExample example = new GcpDrugStoreRecExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andPatientFlowIsNotNull()
		.andOrgFlowEqualTo(orgFlow); 
		example.setOrderByClause("ASSIGN_TIME");
		return drugStoreRecMapper.selectByExample(example);
	}

	@Override
	public GcpDrugStoreRec readGcpDrugStoreRec(String recFlow) { 
		return drugStoreRecMapper.selectByPrimaryKey(recFlow);
	}
	
	@Override
	public GcpDrugStoreRec seachGcpDrugStoreRec(String patientFlow,String drugPack) { 
		GcpDrugStoreRecExample drugStoreRecExample = new GcpDrugStoreRecExample();
		drugStoreRecExample.createCriteria().andPatientFlowEqualTo(patientFlow)
		.andDrugPackEqualTo(drugPack).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		drugStoreRecExample.setOrderByClause("ORDINAL");
		
		List<GcpDrugStoreRec> drugRecList = drugStoreRecMapper.selectByExample(drugStoreRecExample);
		GcpDrugStoreRec drugStore = null;
		if(drugRecList!=null && drugRecList.size()>0){
			drugStore = drugRecList.get(0);
		}
		return drugStore;
	}
	
	@Override
	public void modifyGcpDrugStoreRec(GcpDrugStoreRec rec) {
		GeneralMethod.setRecordInfo(rec, false);
		drugStoreRecMapper.updateByPrimaryKey(rec);
	}

	@Override
	public void modifyEdcRandomRecForCancle(EdcRandomRec randomRec) {
		GeneralMethod.setRecordInfo(randomRec, false);
		randomRecMapper.updateByPrimaryKey(randomRec);
	}
	
	@Override
	public Map<String, String> getRandomInfo(String projFlow,
			String orgFlow) {
		Map<String, String>  map = new HashMap<String, String>();
		GcpDrugStoreRecExample example = new GcpDrugStoreRecExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andDrugStatusIdEqualTo(GcpDrugStoreStatusEnum.Send.getId());
		example.setOrderByClause("ORDINAL");
		List<GcpDrugStoreRec> drugList = drugStoreRecMapper.selectByExample(example);
		for(GcpDrugStoreRec drug : drugList){
			String pack = map.get(drug.getPatientFlow());
			if(pack == null){
				pack = "";
			}
			if(StringUtil.isNotBlank(pack)){
				pack+=",";
			}
			pack+=drug.getDrugPack();
			map.put(drug.getPatientFlow(), pack);
		}
		return map;
	}
	
	@Override
	public int savePatientIe(String patientFlow,Map<String,String> ieValueMap){
		PubPatient patient = patientBiz.readPatient(patientFlow);
		String projFlow = patient.getProjFlow();
		
		PubPatientIe patientIe = patientIeMapper.selectByPrimaryKey(patientFlow);
		if (patientIe == null) {
			patientIe = new PubPatientIe();
			patientIe.setProjFlow(projFlow);
		}
		String ieInfo = patientIe.getIeInfo();
		if (StringUtil.isBlank(ieInfo)) {
			ieInfo = "<ieInfo/>";
		}
		try {
			Document dom = DocumentHelper.parseText(ieInfo);
			Element root = dom.getRootElement();
			
			//纳入标准
			Element includeElement = (Element)root.selectSingleNode("include");
			if (includeElement == null) {
				includeElement = root.addElement("include");
			}
			List<EdcIe> inList = visitBiz.searchIeList(projFlow,EdcIETypeEnum.Include.getId());
			if (inList != null && inList.size() > 0) {
				for (int i=0;i<inList.size();i++) {
					EdcIe ie = inList.get(i);
					String ieFlow = ie.getIeFlow();
					String varName = ie.getIeVarName();
					Element itemElement = (Element)includeElement.selectSingleNode("item[@ieFlow='"+ ieFlow +"']");
					if (itemElement == null) {
						itemElement = includeElement.addElement("item");
						itemElement.addAttribute("ieFlow", ieFlow);
						itemElement.addAttribute("varName", varName);
					}
					itemElement.setText(StringUtil.defaultString(ieValueMap == null?"":ieValueMap.get(varName)));
				}
			}
			//排除标准
			Element excludeElement = (Element)root.selectSingleNode("exclude");
			if (excludeElement == null) {
				excludeElement = root.addElement("exclude");
			}
			List<EdcIe> exList = visitBiz.searchIeList(projFlow,EdcIETypeEnum.Exclude.getId());
			if (exList != null && exList.size() > 0) {
				for (int i=0;i<exList.size();i++) {
					EdcIe ie = exList.get(i);
					String ieFlow = ie.getIeFlow();
					String varName = ie.getIeVarName();
					Element itemElement = (Element)excludeElement.selectSingleNode("item[@ieFlow='"+ ieFlow +"']");
					if (itemElement == null) {
						itemElement = excludeElement.addElement("item");
						itemElement.addAttribute("ieFlow", ieFlow);
						itemElement.addAttribute("varName", varName);
					}
					itemElement.setText(StringUtil.defaultString(ieValueMap == null?"":ieValueMap.get(varName)));
				}
			}
			
			patientIe.setIeInfo(dom.asXML());
			int result =  editPatientIe(patientFlow,patientIe);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.ONE_LINE; 
			}
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		return GlobalConstant.ZERO_LINE; 
	}
	
	private int editPatientIe(String patientFlow,PubPatientIe patientIe) {
		if(patientIe != null){
			if(StringUtil.isNotBlank(patientIe.getPatientFlow())){//修改
				GeneralMethod.setRecordInfo(patientIe, false);
				return patientIeMapper.updateByPrimaryKeyWithBLOBs(patientIe);
			}else{//新增
				patientIe.setPatientFlow(patientFlow);
				GeneralMethod.setRecordInfo(patientIe, true);
				return patientIeMapper.insert(patientIe);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public PubPatientIe readPubPatientIe(String patientFlow) { 
		return patientIeMapper.selectByPrimaryKey(patientFlow);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Map<String,String> getPatientIeMap(String patientFlow){
		Map<String,String> patientIeMap = new HashMap<String,String>();
		PubPatientIe patientIe = patientIeMapper.selectByPrimaryKey(patientFlow);
		if (patientIe != null) {
			String ieInfo = patientIe.getIeInfo();
			if (StringUtil.isBlank(ieInfo)) {
				ieInfo = "<ieInfo/>";
			}
			try {
				Document dom = DocumentHelper.parseText(ieInfo);
				Element root = dom.getRootElement();
				
				//纳入标准
				List<Element> includeItems = (List<Element>)root.selectNodes("include/item");
				if (includeItems != null && includeItems.size() > 0) {
					for (Element item: includeItems) {
						patientIeMap.put(item.attributeValue("ieFlow"), StringUtil.defaultString(item.getText()));
					}
				}
				//排除标准
				List<Element> excludeItems = (List<Element>)root.selectNodes("exclude/item");
				if (excludeItems != null && excludeItems.size() > 0) {
					for (Element item: excludeItems) {
						patientIeMap.put(item.attributeValue("ieFlow"), StringUtil.defaultString(item.getText()));
					}
				}
			} catch (DocumentException e) {
				e.printStackTrace();
			}
		}
		return patientIeMap; 
	}
	
	@Override
	public Map<String, List<PubPatient>> getOrgCount(String projFlow,String patientStageId) {
		Map<String,List<PubPatient>> orgCountMap = new HashMap<String, List<PubPatient>>();
		PubPatientExample example = new PubPatientExample();
		example.createCriteria().andProjFlowEqualTo(projFlow)
		.andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andPatientStageIdEqualTo(patientStageId);
		example.setOrderByClause("patient_code");
		List<PubPatient> patientList = patientBiz.searchPatient(example);
		for(PubPatient patient : patientList){
			List<PubPatient> temp  = orgCountMap.get(patient.getOrgFlow());
			if(temp == null){
				temp =  new ArrayList<PubPatient>();
			}
			temp.add(patient);
			orgCountMap.put(patient.getOrgFlow(), temp);
		}
		return orgCountMap;
	}
	
	@Override
	public List<RandomDrugGroupForm> searchDurgGroups(String projFlow) {
		 return randomRecExtMapper.searchDurgGroups(projFlow);
	}
	
	@Override
	public String searchPatientDrugGroup(String patientFlow) {
		String drugGroup = "";
		EdcRandomRecExample example = new EdcRandomRecExample();
		example.createCriteria().andPatientFlowEqualTo(patientFlow).andAssignStatusIdEqualTo(EdcRandomAssignStatusEnum.Assigned.getId())
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);	
		example.setOrderByClause("assign_Time");
		List<EdcRandomRec> list = randomRecMapper.selectByExample(example);
		if(list!=null && list.size()>0){
			EdcRandomRec randomRec = list.get(list.size()-1);
			drugGroup = randomRec.getDrugGroup();
		}
		return drugGroup;
	}
	
	@Override
	public List<EdcRandomRec> searchRandomRec(List<String> patientFlows){
		EdcRandomRecExample example = new EdcRandomRecExample();
		example.createCriteria().andPatientFlowIn(patientFlows).andAssignStatusIdEqualTo(EdcRandomAssignStatusEnum.Assigned.getId())
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);	
		example.setOrderByClause("assign_Time");
		return randomRecMapper.selectByExample(example);
	}

	@Override
	public void resetBlock(EdcRandomRec rec) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("projFlow", rec.getProjFlow());
		map.put("blockNum", rec.getBlockNum());
		randomRecExtMapper.resetBlock(map);
	}

	@Override
	public List<GcpDrugStoreRec> searchDrugStoreList(String projFlow,
			String orgFlow) {
		
		GcpDrugStoreRecExample example = new GcpDrugStoreRecExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		
		return drugStoreRecMapper.selectByExample(example);
	}

	@Override
	public Integer countAssignDrug(String projFlow, String orgFlow) {
		GcpDrugStoreRecExample example = new GcpDrugStoreRecExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andDrugStatusIdEqualTo(GcpDrugStoreStatusEnum.Send.getId());
		return drugStoreRecMapper.countByExample(example); 
	}

	@Override
	public Integer countUnAssignDrug(String projFlow, String orgFlow) {
		List<String> inlist = new ArrayList<String>();
		inlist.add(GcpDrugStoreStatusEnum.Storaged.getId());
		inlist.add(GcpDrugStoreStatusEnum.UnSend.getId());
		GcpDrugStoreRecExample example = new GcpDrugStoreRecExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andDrugStatusIdIn(inlist);
		return drugStoreRecMapper.countByExample(example); 
	}

	@Override
	public Integer searchMaxVisit(String projFlow) {
		return randomRecExtMapper.searchMaxVisit(projFlow);
	}

	@Override
	public Integer searchMaxVisitFollow(String projFlow, int i) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("projFlow", projFlow);
		map.put("followNum", i);
		return randomRecExtMapper.searchMaxVisitFollow(map);
	}
}
