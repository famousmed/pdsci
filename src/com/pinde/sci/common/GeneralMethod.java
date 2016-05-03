package com.pinde.sci.common;

import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.enums.edc.AttrDataTypeEnum;
import com.pinde.sci.enums.edc.EdcBlindTypeEnum;
import com.pinde.sci.enums.edc.EdcInputStatusEnum;
import com.pinde.sci.enums.edc.ProjInputTypeEnum;
import com.pinde.sci.enums.erp.WorkOrderStatusEnum;
import com.pinde.sci.enums.irb.IrbStageEnum;
import com.pinde.sci.enums.irb.IrbTypeEnum;
import com.pinde.sci.enums.pub.ProjOrgTypeEnum;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.enums.res.RegistryTypeEnum;
import com.pinde.sci.enums.srm.ProjApplyStatusEnum;
import com.pinde.sci.enums.srm.ProjApproveStatusEnum;
import com.pinde.sci.enums.srm.ProjArchiveStatusEnum;
import com.pinde.sci.enums.srm.ProjContractStatusEnum;
import com.pinde.sci.enums.srm.ProjEvaluationStatusEnum;
import com.pinde.sci.enums.srm.ProjScheduleStatusEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.enums.sys.ReqTypeEnum;
import com.pinde.sci.model.edc.EdcDesignForm;
import com.pinde.sci.model.edc.RandomFactor;
import com.pinde.sci.model.mo.EdcAttrCode;
import com.pinde.sci.model.mo.EdcAttribute;
import com.pinde.sci.model.mo.EdcNormalValue;
import com.pinde.sci.model.mo.EdcPatientVisit;
import com.pinde.sci.model.mo.EdcPatientVisitData;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.EdcVisitAttrCode;
import com.pinde.sci.model.mo.PubProjOrg;
import com.pinde.sci.model.mo.PubProjProcess;
import com.pinde.sci.model.mo.SysLog;
import com.pinde.sci.model.mo.SysUser;
public class GeneralMethod {
	private static Logger logger = LoggerFactory.getLogger(GeneralMethod.class);
	
	public static void setRecordInfo(Object obj,boolean isAdd) {
		SysUser currUser = GlobalContext.getCurrentUser();
		Class<?> clazz = obj.getClass();
		try {
			if(isAdd){
				Method setRecordStatusMethod = clazz.getMethod("setRecordStatus",String.class);
				setRecordStatusMethod.invoke(obj,GlobalConstant.RECORD_STATUS_Y);
				Method setCreateTime = clazz.getMethod("setCreateTime",String.class);
				setCreateTime.invoke(obj,DateUtil.getCurrDateTime());
				Method setCreateUserFlow = clazz.getMethod("setCreateUserFlow",String.class);
				if(currUser!=null){
					setCreateUserFlow.invoke(obj,currUser.getUserFlow());					
				}
			}
			Method setModifyTime = clazz.getMethod("setModifyTime",String.class);
			setModifyTime.invoke(obj,DateUtil.getCurrDateTime());
			Method setModifyUserFlow = clazz.getMethod("setModifyUserFlow",String.class);
			if(currUser!=null){
				setModifyUserFlow.invoke(obj,currUser.getUserFlow());				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 我的项目列表上显示的图标 需要对应6个点 分别为1-6
	 * 1 表示勾
	   2 表示编辑
	   3 表示空白
	   4 表示叉号
	 * @param projProcessList
	 * @return
	 */
	public static Map<String , String> showIcn(List<PubProjProcess> projProcessList){
		Map<String , String> icnMap = new HashMap<String , String>();
		PubProjProcess upApplyProcess = null;//申报阶段最新的一次记录
		PubProjProcess upApproveProcess = null;//立项阶段最新的一次记录
		PubProjProcess contractProcess = null;//实施阶段最新的一次记录
		PubProjProcess upSchduleProcess = null;//实施阶段最新的一次记录
		PubProjProcess upCompleteProcess = null;//验收阶段最新的一次记录
		PubProjProcess upArchiveProcess = null;//归档阶段最新的一次记录
		/*--第一个点--*/
		for(PubProjProcess ppp:projProcessList){
			if(ProjStageEnum.Apply.getId().equals(ppp.getProjStageId())){
				upApplyProcess =  ppp;
				break;
			}
		}
		if(upApplyProcess!=null){
			if(StringUtil.isEquals(InitConfig.getSysCfg("srm_for_use") , "global")){
				//区域版本
				String statusId = upApplyProcess.getProjStatusId();
				if(ProjApplyStatusEnum.ThirdAudit.getId().equals(statusId)){
					icnMap.put("1", "1");//对应的第一个点
				}else{
					icnMap.put("1", "2");
				}
			}else{
				//医院版
				String statusId = upApplyProcess.getProjStatusId();
				if(ProjApplyStatusEnum.FirstAudit.getId().equals(statusId)){
					icnMap.put("1", "1");//对应的第一个点
				}else{
					icnMap.put("1", "2");
				}
			}
		}
		/*--第二个点--*/
		//项目是否在评审的标记
		boolean evalFlag = false;
		for(PubProjProcess ppp:projProcessList){
			if(ProjStageEnum.Approve.getId().equals(ppp.getProjStageId()) && 
					ProjEvaluationStatusEnum.Evaluation.getId().equals(ppp.getProjStatusId())){
				evalFlag = true;
				break;
			}
		}
		if(!evalFlag){
			icnMap.put("2", "3");//对应第二个点
		}
		
		for(PubProjProcess ppp:projProcessList){
			if(ProjStageEnum.Approve.getId().equals(ppp.getProjStageId())){
				upApproveProcess =  ppp;
				break;
			}
		}
		if(upApproveProcess!=null){
			if(evalFlag){
				if(!ProjEvaluationStatusEnum.Evaluation.getId().equals(upApproveProcess.getProjStatusId())){
					icnMap.put("2", "1");
				}else{
					icnMap.put("2", "2");
				}
			}
			/*--第三个点--*/
				
			for(PubProjProcess ppp:projProcessList){
				if(ProjStageEnum.Approve.getId().equals(ppp.getProjStageId()) && ProjApproveStatusEnum.Approve.getId().equals(ppp.getProjStatusId())){
					icnMap.put("3", "1");
					break;
				}
			}
			
			for(PubProjProcess ppp:projProcessList){
				if(ProjStageEnum.Approve.getId().equals(ppp.getProjStageId()) && ProjApproveStatusEnum.NotApprove.getId().equals(ppp.getProjStatusId())){
					icnMap.put("3", "4");
					break;
				}
			}
				
				
		}else{
			icnMap.put("3", "3");
			icnMap.put("4", "3");
			icnMap.put("5", "3");
			icnMap.put("6", "3");
			return icnMap;
		}
		
		/*--第四个点--*/
		for(PubProjProcess ppp:projProcessList){
			if(ProjStageEnum.Contract.getId().equals(ppp.getProjStageId())){
				contractProcess =  ppp;
				break;
			}
		}
		if(contractProcess!=null){
			//如果最近的一次是实施阶段合同
			if(StringUtil.isEquals(InitConfig.getSysCfg("srm_for_use") , "global")){
				//区域版本
				String statusId = contractProcess.getProjStatusId();
				if(ProjContractStatusEnum.ThirdAudit.getId().equals(statusId)){
					icnMap.put("4", "1");//对应的第四个点
				}else{
					icnMap.put("4", "2");
				}
			}else{
				//医院版
				String statusId = contractProcess.getProjStatusId();
				if(ProjContractStatusEnum.FirstAudit.getId().equals(statusId)){
					icnMap.put("4", "1");//对应的第四个点
				}else{
					icnMap.put("4", "2");
				}
			}
		}else{
			icnMap.put("4", "3");
			icnMap.put("5", "3");
			icnMap.put("6", "3");
			//解决 直接跳过实施阶段 申请验收 没图标的情况
			//return icnMap;
		}
		
		
		
		/*--第五个点--*/
		for(PubProjProcess ppp:projProcessList){
			if(ProjStageEnum.Schedule.getId().equals(ppp.getProjStageId())){
				upSchduleProcess =  ppp;
				break;
			}
		}
		if(upSchduleProcess!=null){
//			if(ProjRecTypeEnum.Contract.getId().equals(upSchduleProcess.getRecTypeId())){
//				//如果最近的一次是实施阶段合同
//				if(StringUtil.isEquals(InitConfig.getSysCfg("srm_for_use") , "global")){
//					//区域版本
//					String statusId = upSchduleProcess.getProjStatusId();
//					if(ProjScheduleStatusEnum.ThirdAudit.getId().equals(statusId)){
//						icnMap.put("4", "1");//对应的第四个点
//					}else{
//						icnMap.put("4", "2");
//					}
//				}else{
//					//医院版
//					String statusId = upSchduleProcess.getProjStatusId();
//					if(ProjScheduleStatusEnum.FirstAudit.getId().equals(statusId)){
//						icnMap.put("4", "1");//对应的第四个点
//					}else{
//						icnMap.put("4", "2");
//					}
//				}
//			}else{
//				//如果不是
//				boolean contractFlag = false;
//				for(PubProjProcess ppp:projProcessList){
//					if(ProjRecTypeEnum.Contract.getId().equals(ppp.getRecTypeId())){
//						contractFlag = true;
//						break;
//					}
//				}
//				if(contractFlag){
//					icnMap.put("4" , "1");
//				}else{
//					icnMap.put("4" , "3");
//				}
				if(StringUtil.isEquals(InitConfig.getSysCfg("srm_for_use") , "global")){
					//区域版本
					String statusId = upSchduleProcess.getProjStatusId();
					if(ProjScheduleStatusEnum.ThirdAudit.getId().equals(statusId)){
						icnMap.put("5", "1");//对应的第五个点
					}else{
						icnMap.put("5", "2");
					}
				}else{
					//医院版
					String statusId = upSchduleProcess.getProjStatusId();
					if(ProjScheduleStatusEnum.FirstAudit.getId().equals(statusId)){
						icnMap.put("5", "1");//对应的第五个点
					}else{
						icnMap.put("5", "2");
					}
				}
				
			//}
		}else{
			//icnMap.put("4", "3");
			icnMap.put("5", "3");
			icnMap.put("6", "3");
			//解决 直接跳过实施阶段 申请验收 没图标的情况
			//return icnMap;
		}
		
		/*--第6点--*/
		for(PubProjProcess ppp:projProcessList){
			if(ProjStageEnum.Archive.getId().equals(ppp.getProjStageId())){
				upArchiveProcess =  ppp;
				break;
			}
		}
		if(upArchiveProcess!=null){
			if(ProjArchiveStatusEnum.Archive.getId().equals(upArchiveProcess.getProjStatusId())){
				icnMap.put("6", "1");
			}else{
				icnMap.put("6" , "2");
			}
		}else{
			//判断是否到了验收阶段
			for(PubProjProcess ppp:projProcessList){
				if(ProjStageEnum.Complete.getId().equals(ppp.getProjStageId())){
					upCompleteProcess =  ppp;
					break;
				}
			}
			if(upCompleteProcess!=null){
				icnMap.put("6", "2");
			}else{
				icnMap.put("6", "3");
			}
		}
		return icnMap;
	}
	public static String getInputStatusPic(String inputType , EdcPatientVisit visit){
		if(visit == null){
			return "";
		}
		String skinPath = InitConfig.getSysCfg("sys_skin");
		if(ProjInputTypeEnum.Single.getId().equals(inputType)){
			if(EdcInputStatusEnum.Save.getId().equals(visit.getInputOperStatusId())){
				return "/css/skin/"+skinPath+"/images/shu.gif";
			}else if(EdcInputStatusEnum.Checked.getId().equals(visit.getInputOperStatusId())){
				return "/css/skin/"+skinPath+"/images/gou2.gif";
			}
		}else {
			if(EdcInputStatusEnum.Checked.getId().equals(visit.getInputOperStatusId())){
				return "/css/skin/"+skinPath+"/images/gou2.gif";
			}
		}
		return ""; 
	}
	public static boolean isSingleInput(EdcProjParam projParam){
		if(ProjInputTypeEnum.Single.getId().equals(projParam.getInputTypeId())){		//单份录入
			return true;
		}else if(ProjInputTypeEnum.Double.getId().equals(projParam.getInputTypeId())){	 //双份录入
			return  false;
		}
		return false;
	}
	public static String getVisitData(String attrCode, Map<String,EdcPatientVisitData> valueMap,String userFlow,EdcPatientVisit visit){
		if(valueMap == null  || !valueMap.containsKey(attrCode)|| visit ==null){
			return "";
		}
		if(EdcInputStatusEnum.Checked.getId().equals(visit.getInputOperStatusId())){
			return valueMap.get(attrCode).getAttrValue();
		}
		if(userFlow.equals(visit.getInputOper1Flow())){		
			return valueMap.get(attrCode).getAttrValue1();
		}else if(userFlow.equals(visit.getInputOper2Flow())){	 //双份录入
			return valueMap.get(attrCode).getAttrValue2();
		}
		return "";
	}
	//无核对
	public static String getVisitDataNoCheck(String attrCode, Map<String,EdcPatientVisitData> valueMap,String userFlow,EdcPatientVisit visit){
		if(valueMap == null  || !valueMap.containsKey(attrCode)|| visit ==null){
			return "";
		}
		if(EdcInputStatusEnum.Submit.getId().equals(visit.getInputOperStatusId())){
			return valueMap.get(attrCode).getAttrValue();
		}
		if(userFlow.equals(visit.getInputOper1Flow())){		
			return valueMap.get(attrCode).getAttrValue1();
		}else if(userFlow.equals(visit.getInputOper2Flow())){	 //双份录入
			return valueMap.get(attrCode).getAttrValue2();
		}
		return "";
	}
	public static boolean isRandom(EdcProjParam projParam){
		if(projParam == null){
			return false;
		}
		if(GlobalConstant.FLAG_Y.equals(projParam.getIsRandom())){		//单份录入
			return true;
		}else{	
			return  false;
		}
	}

	public static boolean isBlind(EdcProjParam projParam) {
		if(projParam == null){
			return false;
		}
		if (projParam.getBlindTypeId() == null) {
			return false;
		}
		if(projParam.getBlindTypeId().equals(EdcBlindTypeEnum.Blind.getId())){		
			return true;
		}else{	
			return  false;
		}
	}
	public static String getSinglePic(String status){ 
		String skinPath = InitConfig.getSysCfg("sys_skin");
		if(EdcInputStatusEnum.Save.getId().equals(status)){
			return "/css/skin/"+skinPath+"/images/shu.gif";
		}else if(EdcInputStatusEnum.Submit.getId().equals(status)){
			return "/css/skin/"+skinPath+"/images/gou.gif";
		}
		return "";
	}
	public static String getAttrValue(EdcDesignForm designParam,String attrCode,String attrValue) {
		if(designParam==null||!designParam.getAttrCodeValueMap().containsKey(attrCode) || StringUtil.isBlank(attrValue)){   
			return attrValue;
		}else {
			String result = "";
			for(String code : StringUtil.split(attrValue, ",")){
				String value = designParam.getAttrCodeValueMap().get(attrCode).get(code); 
				if(StringUtil.isNotBlank(result)){
					result+=",";
				}
				result += StringUtil.defaultIfEmpty(value, "");
			}
			if(StringUtil.isBlank(result)){
				return attrValue;
			}
			return result ;
		}
	}
	
	public static String getIrbTypeNameById(String irbTypeId) {
		return IrbTypeEnum.getNameById(irbTypeId);
	}
	
	public static List<PubProjOrg> filterProjOrg(List<PubProjOrg> projOrgList) {
		List<PubProjOrg> result = new ArrayList<PubProjOrg>();
		if(projOrgList != null && projOrgList.size()>0){
			for(PubProjOrg projOrg : projOrgList){
				if(ProjOrgTypeEnum.Leader.getId().equals(projOrg.getOrgTypeId())
							||ProjOrgTypeEnum.Parti.getId().equals(projOrg.getOrgTypeId())){
					result.add(projOrg);
				}
			}
		}
		return result;
	}
	
	public static String getWatermark(String watermarkFlag){
		String watermark = "";
		if(GlobalConstant.FLAG_Y.equals(watermarkFlag)){
			watermark =StringUtil.defaultIfEmpty(InitConfig.getSysCfg("srm_watermark_y"),"正式稿").trim();
		}else{
			watermark =StringUtil.defaultIfEmpty(InitConfig.getSysCfg("srm_watermark_n"),"").trim();
		}
		return watermark;
	}

	public static String getDateSeason(String month) {
		Integer monthInt = Integer.parseInt(month);
		switch (monthInt) {
		case 1: 
			return "1";
		case 2: 
			return "1";
		case 3: 
			return "1";
		case 4: 
			return "2";
		case 5: 
			return "2";
		case 6: 
			return "2";
		case 7: 
			return "3";
		case 8: 
			return "3";
		case 9: 
			return "3";
		case 10: 
			return "4";
		case 11: 
			return "4";
		case 12: 
			return "4";
		default:
			break;
		}
		return "";
	}
	public static List<RandomFactor> getRandomFactor(String factorParam) {
		List<RandomFactor> factors= new ArrayList<RandomFactor>();
		if(StringUtil.isNotBlank(factorParam)){ 
			try {
				Document document = DocumentHelper.parseText(factorParam);
				Element rootElement = document.getRootElement();
				List<Element> layerElements = rootElement.selectNodes("layer");
				for(Element layerEle :layerElements){
					RandomFactor factor = new RandomFactor();
					factor.setIndex(layerEle.attributeValue("index"));
					factor.setWeight(layerEle.attributeValue("weight"));
					Map<String,String> itemMap = new TreeMap<String, String>();
					List<Element> itemElements = layerEle.selectNodes("./item");
					for(Element itemEle :itemElements){
						itemMap.put(itemEle.attributeValue("code"), itemEle.getText());
					}
					factor.setItemMap(itemMap);
					factors.add(factor);
				}
			} catch (DocumentException e) {
				e.printStackTrace();
			}
		}
		return factors;
	}

	public static String getProcessClass(String currIrbStageId,String irbStageId){ 
		if(IrbStageEnum.Apply.getId().equals(irbStageId)){
			return "2";
		} else if (IrbStageEnum.Handle.getId().equals(irbStageId)) {
			if (IrbStageEnum.Apply.getId().equals(currIrbStageId)) {
				return "1";
			} else {
				return "2";
			}
		} else if (IrbStageEnum.Review.getId().equals(irbStageId)) {
			if (IrbStageEnum.Apply.getId().equals(currIrbStageId) || IrbStageEnum.Handle.getId().equals(currIrbStageId)) {
				return "1";
			} else {
				return "2";
			}
		} else if (IrbStageEnum.Decision.getId().equals(irbStageId)) {
			if (IrbStageEnum.Apply.getId().equals(currIrbStageId) || IrbStageEnum.Handle.getId().equals(currIrbStageId) 
					|| IrbStageEnum.Review.getId().equals(currIrbStageId)) {
				return "1";
			} else {
				return "2";
			}
		} else if (IrbStageEnum.Archive.getId().equals(irbStageId)) {
			if (IrbStageEnum.Archive.getId().equals(currIrbStageId) || IrbStageEnum.Filing.getId().equals(currIrbStageId)) {
				return "2";
			} else {
				return "1";
			}
		} else if (IrbStageEnum.Filing.getId().equals(irbStageId)) {
			if (IrbStageEnum.Filing.getId().equals(currIrbStageId)) {
				return "2";
			} else {
				return "1";
			}
		}
		return "";
	}
	
	public static boolean getVisibleByWorkStatusId(String workStatusId, String currWorkStatusId){
		if(WorkOrderStatusEnum.Closed.getId().equals(currWorkStatusId)){
			return true;
		}
		if(WorkOrderStatusEnum.Implemented.getId().equals(workStatusId)){
			if (WorkOrderStatusEnum.Implemented.getId().equals(currWorkStatusId) || WorkOrderStatusEnum.CompletePassed.getId().equals(currWorkStatusId) || WorkOrderStatusEnum.CompleteUnPassed.getId().equals(currWorkStatusId) || WorkOrderStatusEnum.Passed.getId().equals(currWorkStatusId)) {
				return true;
			} else {
				return false; 
			}
		}else if(WorkOrderStatusEnum.CompletePassed.getId().equals(workStatusId)){
			if (WorkOrderStatusEnum.CompletePassed.getId().equals(currWorkStatusId) || WorkOrderStatusEnum.Passed.getId().equals(currWorkStatusId)) {
				return true;
			} else {
				return false; 
			}
		}else if(WorkOrderStatusEnum.CompleteUnPassed.getId().equals(workStatusId)){
			if (WorkOrderStatusEnum.CompleteUnPassed.getId().equals(currWorkStatusId) || WorkOrderStatusEnum.Passed.getId().equals(currWorkStatusId)) {
				return true;
			} else {
				return false; 
			}
		}else if(WorkOrderStatusEnum.Passed.getId().equals(workStatusId)){
			if (WorkOrderStatusEnum.Passed.getId().equals(currWorkStatusId)) {
				return true;
			} else {
				return false; 
			}
		}
		return false; 
	}
	
	public static boolean canShowByVersion(String version){
		boolean result = false;
		if(StringUtil.isBlank(version)){
			result = true;
		}
		if("global".equals(version)){
			if("global".equals(InitConfig.getSysCfg("srm_for_use"))){
				result = true;
			}else{
				result = false;
			}
		}
		if("charge".equals(version)){
			if("global".equals(InitConfig.getSysCfg("srm_for_use"))&&"Y".equals(InitConfig.getSysCfg("srm_for_charge_use"))){
				result = true;
			}else{
				result = false;
			}
		}
		if("local".equals(version)){
			if("local".equals(InitConfig.getSysCfg("srm_for_use"))){
				result = true;
			}else{
				result = false;
			}
		}
		return result;
	}
	
	public static boolean canShowByVersionForRes(String version){
		boolean result = StringUtil.isBlank(version);
		if(!result){
			result = version.equals(InitConfig.getSysCfg("res_for_use"));
		}
		return result;
	}
	
	public static Integer getIrbStageOrdinal(String stageId){
		if(IrbStageEnum.Handle.getId().equals(stageId)){
			return 0;
		}else if(IrbStageEnum.Review.getId().equals(stageId)){
			return 1;
		}else if(IrbStageEnum.Decision.getId().equals(stageId)){
			return 2;
		}else if(IrbStageEnum.Archive.getId().equals(stageId)){
			return 3;
		}else if(IrbStageEnum.Filing.getId().equals(stageId)){
			return 4;
		}
		return -1;
	}
	
	public static String toHTML(String value){
		//String result="";
		//String javaString = StringEscapeUtils.escapeJava(value);
		//System.out.println(javaString+"============");
		//result = javaString.replace("\\n", "<br/>");
		if(StringUtil.isNotBlank(value)){
			value = value.replaceAll("\\n", "<br/>");	
		}else{
			value="";
		}
		
		return value;
	}
	
	public static String getCondition(String attrCode,String commAttrCode,String commNormalValueKey,String sexId){
		String condition = "";
		if (StringUtil.isNotBlank(attrCode)) {
			EdcDesignForm designForm = (EdcDesignForm) GlobalContext.getSession().getAttribute(GlobalConstant.PROJ_DESC_FORM);
			EdcAttribute attr = designForm.getAttrMap().get(attrCode);
			if (attr != null) {
				String dataType = attr.getDataTypeId();
				if (AttrDataTypeEnum.Integer.getId().equals(dataType)) {
					condition += "custom[integer],";
				}
				if (AttrDataTypeEnum.Float.getId().equals(dataType)) {
					condition += "custom[number],";
				}
				if (StringUtil.isNotBlank(attr.getDataLength())) {
					condition += "maxSize["+attr.getDataLength()+"],";
				}
				List<EdcVisitAttrCode> attrCodeList = designForm.getVisitAttrCodeMap().get(commAttrCode+"_"+attrCode);
				if (!GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME.equals(attr.getAttrVarName()) && 
						attrCodeList != null && attrCodeList.size() > 0) {
					condition += "funcCall[checkCode],";
				}
				if (GlobalConstant.DEFAULT_ATTR_VALUE_VAR_NAME.equals(attr.getAttrVarName())) {
					Map<String,EdcNormalValue> normalValueMap = designForm.getNormalValueMap().get(commNormalValueKey);
					if (normalValueMap != null) {
						String min = "";
						String max = "";
						EdcNormalValue normalValue = normalValueMap.get(UserSexEnum.Unknown.getId());
						if (normalValue == null) {
							normalValue = normalValueMap.get(sexId);
						}
						if (normalValue != null) {
							min = normalValue.getLowerValue();
							max = normalValue.getUpperValue();
							condition += "min["+min+"], max["+max+"]";
						}
					}
				}
			}
		}
		return condition;
	}
	
	public static String getCodeTitle(String attrCode,String commAttrCode){
		StringBuilder codeTitle = new StringBuilder();
		if (StringUtil.isNotBlank(attrCode)) {
			EdcDesignForm designForm = (EdcDesignForm) GlobalContext.getSession().getAttribute(GlobalConstant.PROJ_DESC_FORM);
			EdcAttribute attr = designForm.getAttrMap().get(attrCode);
			if (attr != null) {
				if (!GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME.equals(attr.getAttrVarName())) {
					List<EdcVisitAttrCode> attrCodeList = designForm.getVisitAttrCodeMap().get(commAttrCode+"_"+attrCode);
					if (attrCodeList != null && attrCodeList.size() > 0) {
						for (EdcVisitAttrCode code:attrCodeList) {
							EdcAttrCode edcAttrCode = designForm.getCodeMap().get(code.getCodeFlow());
							if (edcAttrCode != null) {
								codeTitle.append(edcAttrCode.getCodeValue()+"&#12288;"+edcAttrCode.getCodeName()+"</br>");
							}
						}
						if(codeTitle.length() > 0) {
							codeTitle.deleteCharAt(codeTitle.length()-1);	//去掉选项最后的</br>
						}
					}
				}
			}
		}
		return codeTitle.toString();
	}
	
	public static String getCodeValues(String attrCode,String commAttrCode){
		StringBuilder codeValues = new StringBuilder();
		if (StringUtil.isNotBlank(attrCode)) {
			EdcDesignForm designForm = (EdcDesignForm) GlobalContext.getSession().getAttribute(GlobalConstant.PROJ_DESC_FORM);
			EdcAttribute attr = designForm.getAttrMap().get(attrCode);
			if (attr != null) {
				if (!GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME.equals(attr.getAttrVarName())) {
					List<EdcVisitAttrCode> attrCodeList = designForm.getVisitAttrCodeMap().get(commAttrCode+"_"+attrCode);
					if (attrCodeList != null && attrCodeList.size() > 0) {
						for (EdcVisitAttrCode code:attrCodeList) {
							EdcAttrCode edcAttrCode = designForm.getCodeMap().get(code.getCodeFlow());
							if (edcAttrCode != null) {
								codeValues.append(edcAttrCode.getCodeValue() + ",");
							}
						}
						if(codeValues.length() > 0) {
							codeValues.deleteCharAt(codeValues.length()-1);	//去掉选项最后的逗号
						}
					}
				}
			}
		}
		return codeValues.toString();
	}
	
	
	public static String getPercent(Integer x, Integer total){ 
		   String result="";//接受百分比的值  
		   if(x==null){
			   x = 0;
		   }
		   double xtmp = x*1.0;  
		   if(total!=null && total!=0){
			   double tempresult=xtmp/total; 
			   DecimalFormat df1 = new DecimalFormat("0.00%");    //##.00%   百分比格式，后面不足2位的用0补齐  
			   result= df1.format(tempresult); 
		   }else{
			   result = "0";
		   }
		     
		   return result;  
		}
	public static String getPercentByString(String a, String b){ 
		int x=0;
		int total=0;
		if(StringUtil.isNotBlank(a)){
			x=Integer.parseInt(a);
		}
		if(StringUtil.isNotBlank(b)){
			total=Integer.parseInt(b);
		}
		   String result="";//接受百分比的值  
		   double xtmp = x*1.0;  
		   if(total!=0){
			   double tempresult=xtmp/total; 
			   DecimalFormat df1 = new DecimalFormat("0.00%");    //##.00%   百分比格式，后面不足2位的用0补齐  
			   result= df1.format(tempresult); 
		   }else{
			   result = "0";
		   }
		     
		   return result;  
		}  
	
	public static String getPercentByDouble(Double x, Double total){ 
		   String result="";//接受百分比的值  
		   if(x==null){
			   x = new Double("0");
		   }
		   if(total!=null && total!=0){
			   double tempresult=x/total; 
			   DecimalFormat df1 = new DecimalFormat("0.00%");    //##.00%   百分比格式，后面不足2位的用0补齐  
			   result= df1.format(tempresult); 
		   }else{
			   result = "0";
		   }
		     
		   return result;  
		}

	public static void addSysLog(SysLog log) {
		SysUser user = GlobalContext.getCurrentUser();
		log.setLogFlow(PkUtil.getUUID());
		log.setUserFlow(user.getUserFlow());
		log.setUserCode(user.getUserCode());
		log.setUserName(user.getUserName());
		log.setOrgFlow(user.getOrgFlow());
		log.setOrgName(user.getOrgName());
		log.setDeptFlow(user.getDeptFlow());
		log.setDeptName(user.getDeptName());
		if(StringUtil.isBlank(log.getReqTypeId())){
			log.setReqTypeId(ReqTypeEnum.GET.getId());
		}
		log.setReqTypeName(ReqTypeEnum.getNameById(log.getReqTypeId())); 
		log.setLogTime(DateUtil.getCurrDateTime());
		if(StringUtil.isBlank(log.getWsId())){
			log.setWsId(GlobalContext.getCurrentWsId());
		}
		log.setWsName(InitConfig.getWorkStationName(log.getWsId()));
		setRecordInfo(log, true);
	}
	
	public static String tranNum(String value,String digit){
		BigDecimal divider=new BigDecimal(1);
		BigDecimal ten=new BigDecimal(10);
		BigDecimal dividered=new BigDecimal(value);
		if(Integer.parseInt(digit)>=1){
			for(int i=1;i<=Integer.parseInt(digit);i++){
				divider=divider.multiply(ten);
			}
			return dividered.divide(divider,2,BigDecimal.ROUND_HALF_UP).toString();
		}
		return "";
	}
	
	public static RegistryTypeEnum getRegistryTypeEnumById(String id){
		for(RegistryTypeEnum registryType : RegistryTypeEnum.values()){
			if(registryType.getId().equals(id)){
				return registryType;
			}
		}
		return null;
	}
}
