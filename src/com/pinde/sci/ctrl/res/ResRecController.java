package com.pinde.sci.ctrl.res;

import java.io.File;
import java.math.BigDecimal;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.util.HSSFColor.GOLD;
import org.docx4j.openpackaging.io.SaveToZipFile;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.Docx4jUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.res.IResAssessCfgBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.res.IResDoctorProcessBiz;
import com.pinde.sci.biz.res.IResRecBiz;
import com.pinde.sci.biz.sch.ISchArrangeResultBiz;
import com.pinde.sci.biz.sch.ISchDeptBiz;
import com.pinde.sci.biz.sch.ISchRotationBiz;
import com.pinde.sci.biz.sch.ISchRotationDeptBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.res.RecStatusEnum;
import com.pinde.sci.enums.res.RegistryTypeEnum;
import com.pinde.sci.enums.res.ResAssessTypeEnum;
import com.pinde.sci.enums.res.ResRecTypeEnum;
import com.pinde.sci.form.res.ResAssessCfgItemForm;
import com.pinde.sci.form.res.ResAssessCfgTitleForm;
import com.pinde.sci.model.irb.IrbSingleForm;
import com.pinde.sci.model.mo.FstuProj;
import com.pinde.sci.model.mo.ResAppeal;
import com.pinde.sci.model.mo.ResAssessCfg;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.ResRec;
import com.pinde.sci.model.mo.SchArrangeResult;
import com.pinde.sci.model.mo.SchDept;
import com.pinde.sci.model.mo.SchRotationDept;
import com.pinde.sci.model.mo.SchRotationDeptReq;
import com.pinde.sci.model.mo.SysUser;
@Controller
@RequestMapping("/res/rec")
public class ResRecController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(ResRecController.class);
	
	@Autowired
	private IResRecBiz resRecBiz;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private ISchDeptBiz schDeptBiz;
	@Resource
	private ISchRotationDeptBiz schRotationDeptBiz;
	@Resource
	private ISchRotationBiz schRotationBiz;
	@Resource
	private IResAssessCfgBiz assessCfgBiz;
	@Resource
	private IResDoctorBiz resDoctorBiz;
	@Resource
	private ISchArrangeResultBiz schArrangeResultBiz;
	@Resource
	private IResDoctorProcessBiz resDoctorProcessBiz;
	@Resource
	private IResDoctorBiz doctorBiz;
	@Resource
	private IUserBiz userBiz;
	
	/**
	 * 获取登记表表单
	 * @param orgFlow
	 * @param schDeptFlow
	 * @param resTypeId
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/showRegistryForm",method={RequestMethod.GET,RequestMethod.POST})
	public String showRegistryForm(String recFlow, String recTypeId,String rotationFlow,String schDeptFlow,String userFlow,String roleFlag,String resultFlow, Model model){
		
		userFlow = StringUtil.defaultIfEmpty(userFlow, GlobalContext.getCurrentUser().getUserFlow());
		
		if(StringUtil.isNotBlank(schDeptFlow)){
			SchDept schDept = schDeptBiz.readSchDept(schDeptFlow);
			model.addAttribute("schDept",schDept);
		}
		
		SchArrangeResult result = null;
		if(StringUtil.isNotBlank(resultFlow)){
			result=schArrangeResultBiz.readSchArrangeResult(resultFlow);
			model.addAttribute("sresult",result);
			model.addAttribute("result", result);
			
			ResDoctorSchProcess process = resDoctorProcessBiz.searchByResultFlow(resultFlow);
			model.addAttribute("currRegProcess", process);
		}
		
		ResRec rec = null;

		if(StringUtil.isNotBlank(recFlow)){
			rec = this.resRecBiz.readResRec(recFlow);
			recTypeId = rec.getRecTypeId();
		}
		
		boolean isAfter = ResRecTypeEnum.AfterSummary.getId().equals(recTypeId) || ResRecTypeEnum.AfterEvaluation.getId().equals(recTypeId);
		
		if(isAfter && StringUtil.isBlank(recFlow)){
			List<ResRec> recList = resRecBiz.searchByRec(recTypeId,schDeptFlow,userFlow);
			if(recList!=null && recList.size()>0){
				recFlow = recList.get(0).getRecFlow();
				rec = resRecBiz.readResRec(recFlow);
			}
			
			if(ResRecTypeEnum.AfterSummary.getId().equals(recTypeId)){
				List<ResRec> evaluationList = resRecBiz.searchByRec(ResRecTypeEnum.AfterEvaluation.getId(),schDeptFlow,userFlow);
				if(evaluationList!=null && evaluationList.size()>0){
					model.addAttribute("evaluation",evaluationList.get(0));
				}
			}
			if(StringUtil.isNotBlank(userFlow)){
				ResDoctor doctor  = doctorBiz.readDoctor(userFlow);
				model.addAttribute("doctor", doctor);
			}
		}
		if(rec!=null){
			model.addAttribute("rec",rec);
			
			if(!StringUtil.isNotBlank(rotationFlow)){
				ResDoctor doctor = resDoctorBiz.readDoctor(rec.getOperUserFlow());
				rotationFlow = doctor.getRotationFlow();
			}
			
			if(ResRecTypeEnum.AfterEvaluation.getId().equals(recTypeId)){
				Map<String,Integer> recFinishMap = new HashMap<String, Integer>();
				List<String> recTypeIds = new ArrayList<String>();
				recTypeIds.add(ResRecTypeEnum.CaseRegistry.getId());
				recTypeIds.add(ResRecTypeEnum.DiseaseRegistry.getId());
				recTypeIds.add(ResRecTypeEnum.OperationRegistry.getId());
				recTypeIds.add(ResRecTypeEnum.SkillRegistry.getId());
				List<ResRec> recList = resRecBiz.searchFinishRec(recTypeIds,rec.getOperUserFlow());
				if(recList!=null && recList.size()>0){
					for(ResRec recTemp : recList){
						String recTypeIdTemp = recTemp.getRecTypeId();
						if(recFinishMap.get(recTypeIdTemp)==null){
							recFinishMap.put(recTypeIdTemp,1);
						}else{
							recFinishMap.put(recTypeIdTemp,recFinishMap.get(recTypeIdTemp)+1);
						}
					}
				}
				
				List<SchRotationDeptReq> deptReqList = schRotationDeptBiz.searchDeptReq(rotationFlow,schDeptFlow);
				if(deptReqList!=null && deptReqList.size()>0){
					for(SchRotationDeptReq deptReq : deptReqList){
						if(recFinishMap.get(deptReq.getRecTypeId()+"req")==null){
							recFinishMap.put(deptReq.getRecTypeId()+"req",(deptReq.getReqNum().intValue()));
						}else{
							recFinishMap.put(deptReq.getRecTypeId()+"req",recFinishMap.get(deptReq.getRecTypeId()+"req")+(deptReq.getReqNum().intValue()));
						}
					}
				}
				model.addAttribute("recFinishMap",recFinishMap);
			}
		}
		
		if(!isAfter && result!=null){
			List<SchRotationDeptReq> deptReqList = schRotationDeptBiz.searchStandardReqByResult(result,recTypeId);
			model.addAttribute("deptReqList",deptReqList);
		}
		
		String currVer = rec==null?null:rec.getRecVersion();
		
		Map<String,String> formDataMap = null;
		if(rec!=null){
			String recContent = rec.getRecContent();
			if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(roleFlag)){
				//recContent = cutHeadScore(recContent);
			}
			formDataMap = resRecBiz.parseRecContent(recContent);
			model.addAttribute("formDataMap", formDataMap);	
			userFlow = rec.getOperUserFlow();
		}
		
		model.addAttribute("formFileName", recTypeId);
		
		rotationFlow = "";
		if(StringUtil.isNotBlank(userFlow)){
			ResDoctor doctor = doctorBiz.readDoctor(userFlow);
			if(doctor!=null){
				rotationFlow = doctor.getRotationFlow();
			}
		}
		
		//查询当前用户计划内轮转科室
		List<SchDept> deptList = schDeptBiz.searchrotationDept(userFlow);
		model.addAttribute("deptList",deptList);
		
		SysUser user=new SysUser();
		user.setUserFlow(userFlow);
		ResDoctorSchProcess process = resDoctorProcessBiz.searchCurrDept(user);
		model.addAttribute("process",process);
		
		//查询用户信息
//		SysUser cuurSysUser=GlobalContext.getCurrentUser();
//		String flow=cuurSysUser.getUserFlow();
//		SysUser sysUser=userBiz.findByFlow(flow);
//		model.addAttribute("sysUser", sysUser);
		return resRecBiz.getFormPath(recTypeId,currVer,rotationFlow);
	}
	
	@RequestMapping(value="/printRegistryCheck")
	public void printRegistryCheck(String recFlow, HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(StringUtil.isNotBlank(recFlow)){
			ResRec rec  = resRecBiz.readResRec(recFlow);
			Map<String,String> formDataMap = null;
			if(rec!=null){
				String recContent = rec.getRecContent();
				formDataMap = resRecBiz.parseRecContent(recContent);
				for(Entry<String, String> entry : formDataMap.entrySet()){
					//System.err.println("key:" + entry.getKey() + "--value:" + entry.getValue());
					String key = entry.getKey();
					String value = entry.getValue();
					resultMap.put(key, value);
					String rowNo = new String();
					String cellNo = new String();
					boolean addFlag = false;
					if("teamwork".equals(key)){//团队协作、奉献精神
						rowNo="1";
						addFlag = true;
					}else if("quantity".equals(key)){//完成工作数量
						rowNo="2";
						addFlag = true;
					}else if("quality".equals(key)){//完成工作质量
						rowNo="3";
						addFlag = true;
					}else if("complyWith".equals(key)){//遵守劳动纪律、规章制度
						rowNo="4";
						addFlag = true;
					}else if("Level".equals(key)){//考核等级
						rowNo="5";
						addFlag = true;
					}
					if(addFlag){
						if("优秀".equals(value)){
							cellNo = "1";
						}else if("良好".equals(value)){
							cellNo = "2";
						}else if("达标".equals(value) || "合格".equals(value)){
							cellNo = "3";
						}else if("尚可".equals(value) || "基本合格".equals(value)){
							cellNo = "4";
						}else if("欠缺".equals(value) || "不合格".equals(value)){
							cellNo = "5";
						}
						resultMap.put("row" + rowNo + "cell" + cellNo, value);
					}
				}
				String year = formDataMap.get("year");
				WordprocessingMLPackage temeplete = new WordprocessingMLPackage();
				String path = "/jsp/res/edu/student/print/annualRegistryCheckTemeplete.docx";//模板
				ServletContext context =  request.getServletContext();
				String watermark = GeneralMethod.getWatermark(GlobalConstant.FLAG_N);
				temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), resultMap,watermark,true);
				if(temeplete!=null){
					String name = "年度考核登记表（"+ year +"年度）.docx"; 
					response.setHeader("Content-disposition","attachment; filename="+new String(name.getBytes("gbk"),"ISO8859-1" ) +""); 
					response.setContentType ("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
					ServletOutputStream out = response.getOutputStream ();
					(new SaveToZipFile (temeplete)).save (out);
					out.flush ();
				}
			}
		}
	}
	
	//带教老师评分去除科主任评分以正确展示
	private String cutHeadScore(String content){
		if(StringUtil.isNotBlank(content)){
			try {
				Document doc = DocumentHelper.parseText(content);
				Element root = doc.getRootElement();
				Element headNode = root.element(GlobalConstant.RES_ROLE_SCOPE_HEAD+ResRecTypeEnum.AfterEvaluation.getId());
				if(headNode!=null){
					headNode.detach();
				}
				content = doc.asXML();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return content;
	}
	
	@RequestMapping(value="/saveRegistryForm",method={RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public String saveRegistryForm(String formFileName,String recFlow,String schDeptFlow,String operUserFlow,String roleFlag,HttpServletRequest req){
		
		operUserFlow = StringUtil.defaultIfEmpty(operUserFlow,GlobalContext.getCurrentUser().getUserFlow());
		String rotationFlow = "";
		String orgFlow = "";
		ResDoctor doctor = doctorBiz.readDoctor(operUserFlow);
		if(doctor!=null){
			rotationFlow = doctor.getRotationFlow();
			orgFlow = doctor.getOrgFlow();
		}
		int result = this.resRecBiz.saveRegistryForm(formFileName,recFlow,schDeptFlow,rotationFlow,req,orgFlow);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value="/appraiseList",method={RequestMethod.GET,RequestMethod.POST})
	public String appraiseList(String recFlow,Model model){
		if(StringUtil.isNotBlank(recFlow)){
			ResRec rec = resRecBiz.readResRec(recFlow);
			if(rec!=null){
				Map<String,List<Map<String,String>>> appraiseMap = resRecBiz.parseRecContentAppraise(rec.getRecContent());
				model.addAttribute("appraiseMap",appraiseMap);
			}
		}
		return "res/doctor/appraiseList";
	}
	
	@RequestMapping(value="/opreResRec",method={RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public String delResRec(ResRec rec){
		String deleteS = GlobalConstant.DELETE_SUCCESSED;
		String deleteF = GlobalConstant.DELETE_FAIL;
		if(rec!=null){
			if(StringUtil.isNotBlank(rec.getStatusId())){
				rec.setStatusName(RecStatusEnum.getNameById(rec.getStatusId()));
				rec.setAuditStatusId(RecStatusEnum.TeacherAuditY.getId());
				rec.setAuditStatusName(RecStatusEnum.TeacherAuditY.getName());
				rec.setHeadAuditStatusId(RecStatusEnum.HeadAuditY.getId());
				rec.setHeadAuditStatusName(RecStatusEnum.HeadAuditY.getName());
				deleteS = GlobalConstant.OPRE_SUCCESSED;
				deleteF = GlobalConstant.OPRE_FAIL;
			}
			if(resRecBiz.edit(rec)!=GlobalConstant.ZERO_LINE){
				return deleteS;
			}
		}
		return deleteF;
	}
	
	@RequestMapping(value="/requireData",method={RequestMethod.GET,RequestMethod.POST})
	public String requireData(String resTypeId,String schDeptFlow,Model model){
		if(StringUtil.isNotBlank(schDeptFlow)){
			SchDept schDept = schDeptBiz.readSchDept(schDeptFlow);
			model.addAttribute("schDept",schDept);
		}
		return "res/doctor/registry/data";
	}
	
	
	/**
	 * 登记数据列表
	 * @param schDeptFlow
	 * @param rotationFlow
	 * @param recTypeId
	 * @param resultFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/requireDataList",method={RequestMethod.GET,RequestMethod.POST})
	public String requireDataList(String schDeptFlow,String rotationFlow,String recTypeId,String resultFlow,Model model){
		Map<String,Integer> recCountMap = new HashMap<String, Integer>();
		
		String userFlow = GlobalContext.getCurrentUser().getUserFlow();
		
		if(StringUtil.isNotBlank(recTypeId) && StringUtil.isNotBlank(schDeptFlow)){//&& StringUtil.isNotBlank(rotationFlow)
			List<ResRec> recList = resRecBiz.searchByRecWithBLOBs(recTypeId,schDeptFlow,userFlow);
			if(recList!=null && recList.size()>0){
				model.addAttribute("recList",recList);
				
				//Map<String,Map<String,String>> recMap = new HashMap<String, Map<String,String>>();
				Map<String,List<Map<String,String>>> viewListMap = new HashMap<String, List<Map<String,String>>>();
				Map<String,List<ResRec>> recListMap = new HashMap<String,List<ResRec>>();
				for(ResRec recTemp : recList){
					//Map<String,String> formDataMap = resRecBiz.parseRecContent(recTemp.getRecContent());
					//recMap.put(recTemp.getRecFlow(),formDataMap);
					/////////////////////////////////////////////////
					List<Map<String,String>> viewInfoList = resRecBiz.parseViewValue(recTemp.getRecContent());
					viewListMap.put(recTemp.getRecFlow(),viewInfoList);
					
//					String itemName = StringUtil.defaultIfEmpty(recTemp.getItemName(),"other");
					String itemId = recTemp.getItemId();
					
					if(recListMap.get(itemId)==null){
						List<ResRec> recTempList = new ArrayList<ResRec>();
						recTempList.add(recTemp);
						recListMap.put(itemId,recTempList);
					}else{
						recListMap.get(itemId).add(recTemp);
					}
					
					if(RecStatusEnum.TeacherAuditY.getId().equals(recTemp.getAuditStatusId())){
						if(recCountMap.get("auditCount")==null){
							recCountMap.put("auditCount",1);
						}else{
							recCountMap.put("auditCount",recCountMap.get("auditCount")+1);
						}
						
						if(recCountMap.get(itemId+"auditCount")==null){
							recCountMap.put(itemId+"auditCount",1);
						}else{
							recCountMap.put(itemId+"auditCount",recCountMap.get(itemId+"auditCount")+1);
						}
					}
					
					if(recCountMap.get("finishCount")==null){
						recCountMap.put("finishCount",1);
					}else{
						recCountMap.put("finishCount",recCountMap.get("finishCount")+1);
					}
					
					if(recCountMap.get(itemId+"finishCount")==null){
						recCountMap.put(itemId+"finishCount",1);
					}else{
						recCountMap.put(itemId+"finishCount",recCountMap.get(itemId+"finishCount")+1);
					}
					
					if(recCountMap.get(recTemp.getRecTypeId()+"finish")==null){
						recCountMap.put(recTemp.getRecTypeId()+"finish",1);
					}else{
						recCountMap.put(recTemp.getRecTypeId()+"finish",recCountMap.get(recTemp.getRecTypeId()+"finish")+1);
					}
				}
				
				//model.addAttribute("recMap",recMap);
				model.addAttribute("viewListMap",viewListMap);
				model.addAttribute("recListMap",recListMap);
			}
			
			List<ResAppeal> appealList = resRecBiz.searchAppeal(recTypeId,schDeptFlow,userFlow);
			if(appealList!=null && appealList.size()>0){
				Map<String,ResAppeal> appealMap = new HashMap<String,ResAppeal>();
				for(ResAppeal appeal : appealList){
					appealMap.put(appeal.getItemId(),appeal);
					
//					if(recCountMap.get("appealCount")==null){
//						recCountMap.put("appealCount",appeal.getAppealNum().intValue());
//					}else{
//						recCountMap.put("appealCount",recCountMap.get("appealCount")+appeal.getAppealNum().intValue());
//					}
//					
//					if(recCountMap.get(appeal.getItemName()+"appealCount")==null){
//						recCountMap.put(appeal.getItemName()+"appealCount",appeal.getAppealNum().intValue());
//					}else{
//						recCountMap.put(appeal.getItemName()+"appealCount",recCountMap.get(appeal.getItemName()+"appealCount")+appeal.getAppealNum().intValue());
//					}
				}
				model.addAttribute("appealMap",appealMap);
			}
		}
		
		//计算要求数
		if(StringUtil.isNotBlank(resultFlow)){
			SchArrangeResult result = schArrangeResultBiz.readSchArrangeResult(resultFlow);
			
			List<SchRotationDeptReq> deptReqList = schRotationDeptBiz.searchStandardReqByResult(result,recTypeId);
			if(deptReqList!=null && deptReqList.size()>0){
				model.addAttribute("deptReqList",deptReqList);
				
				Map<String,SchRotationDeptReq> deptReqMap = new HashMap<String, SchRotationDeptReq>();
				for(SchRotationDeptReq deptReqTemp : deptReqList){
					deptReqMap.put(deptReqTemp.getReqFlow(),deptReqTemp);
					if(recCountMap.get(deptReqTemp.getRecTypeId()+"reqNum")==null){
						recCountMap.put(deptReqTemp.getRecTypeId()+"reqNum",deptReqTemp.getReqNum().intValue());
					}else{
						recCountMap.put(deptReqTemp.getRecTypeId()+"reqNum",recCountMap.get(deptReqTemp.getRecTypeId()+"reqNum")+deptReqTemp.getReqNum().intValue());
					}
				}
				
				model.addAttribute("deptReqMap",deptReqMap);
			}
			
			List<SchArrangeResult> results = new ArrayList<SchArrangeResult>();
			results.add(result);
			Map<String,String> recFinishMap = resRecBiz.getFinishPer(results);
			model.addAttribute("recFinishMap",recFinishMap);
		}
		
		model.addAttribute("recCountMap",recCountMap);
		
		return "res/doctor/registryView";
	}
	
	/**
	 * 培训视图 TODO
	 * */
	@RequestMapping(value="/processView",method={RequestMethod.GET})
	public String processView(String resultFlow,String processFlow,Model model){
		SchArrangeResult result = schArrangeResultBiz.readSchArrangeResult(resultFlow);
		if(result!=null){
			model.addAttribute("result",result);
			List<SchArrangeResult> results = new ArrayList<SchArrangeResult>();
			results.add(result);
			Map<String,String> recFinishMap = resRecBiz.getFinishPer(results);
			model.addAttribute("recFinishMap",recFinishMap);
			
			//要求数
			List<SchRotationDeptReq> deptReqList = schRotationDeptBiz.searchStandardReqByResult(result);
			if(deptReqList!=null && deptReqList.size()>0){
				Map<String,BigDecimal> reqNumMap = new HashMap<String,BigDecimal>();
				for(SchRotationDeptReq req : deptReqList){
					String key = req.getRecTypeId();
					if(reqNumMap.get(key)==null){
						reqNumMap.put(key,req.getReqNum());
					}else{
						reqNumMap.put(key,reqNumMap.get(key).add(req.getReqNum()));
					}
				}
				model.addAttribute("reqNumMap",reqNumMap);
			}
		}
		
		ResDoctorSchProcess process = resDoctorProcessBiz.read(processFlow);
		if(process!=null){
			model.addAttribute("process",process);
			
			String schDeptFlow = process.getSchDeptFlow();
			
			//申述数
			List<Map<String,Object>> appealCountList = resRecBiz.searchAppealCount(schDeptFlow,GlobalContext.getCurrentUser().getUserFlow());
			if(appealCountList!=null && appealCountList.size()>0){
				Map<Object,Object> appealCount = new HashMap<Object, Object>();
				for(Map<String,Object> map : appealCountList){
					appealCount.put(map.get("appealKey"),map.get("appealSum"));
				}
				model.addAttribute("appealCount",appealCount);
			}
		}
		
		return "res/doctor/processView";
	}
	
	@RequestMapping(value="/grade",method={RequestMethod.GET})
	public String grade(String recFlow,String recTypeId,Model model) throws Exception{
		SysUser currUser = GlobalContext.getCurrentUser();
		if(StringUtil.isNotBlank(recTypeId) && currUser!=null){
			String cfgCodeId = null;
			if(ResRecTypeEnum.TeacherGrade.getId().equals(recTypeId)){
				cfgCodeId = ResAssessTypeEnum.TeacherAssess.getId();
			}else if(ResRecTypeEnum.DeptGrade.getId().equals(recTypeId)){
				cfgCodeId = ResAssessTypeEnum.DeptAssess.getId();
			}
			
			ResRec rec = resRecBiz.readResRec(recFlow);
			if(rec!=null){
				model.addAttribute("rec",rec);
				Map<String,Object> gradeMap = resRecBiz.parseGradeXml(rec.getRecContent());
				model.addAttribute("gradeMap",gradeMap);
			}
			
			ResAssessCfg search = new ResAssessCfg();
			search.setCfgCodeId(cfgCodeId);
			search.setOrgFlow(currUser.getOrgFlow());
			List<ResAssessCfg> assessCfgList = assessCfgBiz.searchAssessCfgList(search);
			if(assessCfgList != null && !assessCfgList.isEmpty()){
				ResAssessCfg assessCfg = assessCfgList.get(0);
				Document dom = DocumentHelper.parseText(assessCfg.getCfgBigValue());
				String titleXpath = "//title";
				List<Element> titleElementList = dom.selectNodes(titleXpath);
				if(titleElementList != null && !titleElementList.isEmpty()){
					List<ResAssessCfgTitleForm> titleFormList = new ArrayList<ResAssessCfgTitleForm>();
					for(Element te :titleElementList){
						ResAssessCfgTitleForm titleForm = new ResAssessCfgTitleForm();
						titleForm.setId(te.attributeValue("id"));
						titleForm.setName(te.attributeValue("name"));
						List<Element> itemElementList = te.elements("item");
						List<ResAssessCfgItemForm> itemFormList = null;
						if(itemElementList != null && !itemElementList.isEmpty()){
							itemFormList = new ArrayList<ResAssessCfgItemForm>();
							for(Element ie : itemElementList){
								ResAssessCfgItemForm itemForm = new ResAssessCfgItemForm();
								itemForm.setId(ie.attributeValue("id"));
								itemForm.setName(ie.element("name") == null ? "" : ie.element("name").getTextTrim());
								itemForm.setScore(ie.element("score") == null ? "" : ie.element("score").getTextTrim());
								itemFormList.add(itemForm);
							}
						}
						titleForm.setItemList(itemFormList);
						titleFormList.add(titleForm);
					}
					model.addAttribute("titleFormList", titleFormList);
				}
			}
		}
		return "res/doctor/score/grade";
	}
	
	@RequestMapping(value="/saveGrade",method={RequestMethod.POST})
	@ResponseBody
	public String saveGrade(ResRec rec,HttpServletRequest request){
		String recContent = createGradeXml(request.getParameterMap());
		if(rec!=null){
			if(!StringUtil.isNotBlank(rec.getRecFlow())){
				SysUser user = GlobalContext.getCurrentUser();
				rec.setOperUserFlow(user.getUserFlow());
				rec.setOperUserName(user.getUserName());
				rec.setOperTime(DateUtil.getCurrDateTime());
				if(StringUtil.isNotBlank(rec.getSchDeptFlow())){
					SchDept schDept = schDeptBiz.readSchDept(rec.getSchDeptFlow());
					if(schDept!=null){
						rec.setSchDeptName(schDept.getSchDeptName());
						rec.setSchDeptFlow(schDept.getSchDeptFlow());
						rec.setOrgFlow(schDept.getOrgFlow());
						rec.setOrgName(schDept.getOrgName());
						rec.setDeptFlow(schDept.getDeptFlow());
						rec.setDeptName(schDept.getDeptName());
					}
				}
				
				if(StringUtil.isNotBlank(rec.getRecTypeId())){
					rec.setRecTypeId(rec.getRecTypeId());
					rec.setRecTypeName(ResRecTypeEnum.getNameById(rec.getRecTypeId()));
				}
			}
			
			rec.setRecContent(recContent);
		}
		if(resRecBiz.edit(rec)!=GlobalConstant.ZERO_LINE){
			return rec.getRecFlow();
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	private String createGradeXml(Map<String,String[]> gradeInfo){
		Document document = DocumentHelper.createDocument();
		Element rootEle = document.addElement("gradeInfo");
		if(gradeInfo!=null){
			String[] assessIds = gradeInfo.get("assessId");
			String[] scores = gradeInfo.get("score");
			String[] lostReasons = gradeInfo.get("lostReason");
			if(assessIds!=null && assessIds.length>0){
				for(int i = 0 ; i<assessIds.length ; i++){
					String assessId = assessIds[i];
					String score = scores[i];
					String lostReason = lostReasons[i];
					
					Element item = rootEle.addElement("grade");
					item.addAttribute("assessId",assessId);
					
					Element scoreElement = item.addElement("score");
					scoreElement.setText(score);
					
					Element lostReasonElement = item.addElement("lostReason");
					lostReasonElement.setText(lostReason);
				}
			}
			
			String[] totalScore = gradeInfo.get("totalScore");
			if(totalScore!=null && totalScore.length>0 && StringUtil.isNotBlank(totalScore[0])){
				Element item = rootEle.addElement("totalScore");
				item.setText(totalScore[0]);
			}
		}
		return document.asXML();
	}
	
	@RequestMapping(value="/sopView",method={RequestMethod.GET})
	public String sopView(String resultFlow,Model model){
		if(StringUtil.isNotBlank(resultFlow)){
			SchRotationDept rotationDept = schRotationDeptBiz.readStandardRotationDept(resultFlow);
			model.addAttribute("rotationDept",rotationDept);
		}
		return "res/doctor/sop";
	}
	//TODO 申述
	@RequestMapping(value="/editAppeal",method={RequestMethod.GET})
	public String editAppeal(String recTypeId,String appealFlow,String schDeptFlow,String doctorFlow,String resultFlow,String reqFlow,Model model){
		if(StringUtil.isNotBlank(resultFlow)){
			SchArrangeResult result = schArrangeResultBiz.readSchArrangeResult(resultFlow);
			List<SchRotationDeptReq> deptReqList = schRotationDeptBiz.searchStandardReqByResult(result,recTypeId);
			if(deptReqList!=null && deptReqList.size()>0){
				Map<String,Integer> reqCountMap = new HashMap<String, Integer>();
				for(SchRotationDeptReq deptReq : deptReqList){
					reqCountMap.put(deptReq.getReqFlow(),deptReq.getReqNum().intValue());
				}
				
				List<String> recTypeIds = new ArrayList<String>();
				for(RegistryTypeEnum regType : RegistryTypeEnum.values()){
					if(GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("res_registry_type_"+regType.getId()))){
						if(GlobalConstant.FLAG_Y.equals(regType.getHaveAppeal())){
							recTypeIds.add(regType.getId());
						}
					}
				}
				List<ResRec> recList = resRecBiz.searchByRec(recTypeIds,schDeptFlow,GlobalContext.getCurrentUser().getUserFlow());
				if(recList!=null && recList.size()>0){
					for(ResRec rec : recList){
						String key = rec.getRecTypeId()+rec.getItemId();
						//if(RecStatusEnum.TeacherAuditY.getId().equals(rec.getAuditStatusId())){
							if(reqCountMap.get(key)==null){
								reqCountMap.put(key,1);
							}else{
								reqCountMap.put(key,reqCountMap.get(key)+1);
							}
						//}
					}
				}
				
				model.addAttribute("reqCountMap",reqCountMap);
				model.addAttribute("deptReqList",deptReqList);
			}
			
			List<ResAppeal> appealList = resRecBiz.searchAppeal(recTypeId,schDeptFlow,GlobalContext.getCurrentUser().getUserFlow());
			if(appealList!=null && appealList.size()>0){
				Map<String,ResAppeal> appealMap = new HashMap<String, ResAppeal>();
				for(ResAppeal appeal : appealList){
					appealMap.put(appeal.getItemId(),appeal);
				}
				model.addAttribute("appealMap",appealMap);
			}
		}
		
		if(StringUtil.isNotBlank(reqFlow)){
			SchRotationDeptReq req = schRotationDeptBiz.readDeptReq(reqFlow);
			model.addAttribute("req",req);
		}
		
		if(StringUtil.isNotBlank(appealFlow)){
			ResAppeal appeal = resRecBiz.readAppeal(appealFlow);
			model.addAttribute("appeal",appeal);
		}
		
		return "res/doctor/appeal/editAppeal";
	}
	
	@RequestMapping(value="/saveAppeal",method={RequestMethod.POST})
	@ResponseBody
	public String saveAppeal(ResAppeal appeal){
		if(appeal!=null){
			if(StringUtil.isNotBlank(appeal.getRecTypeId())){
				appeal.setRecTypeName(RegistryTypeEnum.getNameById(appeal.getRecTypeId()));
			}
			
			if(StringUtil.isNotBlank(appeal.getStatusId())){
				appeal.setStatusName(RecStatusEnum.getNameById(appeal.getStatusId()));
			}
			
			if(!StringUtil.isNotBlank(appeal.getAppealFlow())){
				appeal.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
				appeal.setOrgName(GlobalContext.getCurrentUser().getOrgName());
				appeal.setStatusId(RecStatusEnum.Edit.getId());
				appeal.setStatusName(RecStatusEnum.Edit.getName());
				
				if(StringUtil.isNotBlank(appeal.getSchDeptFlow())){
					SchDept schDept = schDeptBiz.readSchDept(appeal.getSchDeptFlow());
					if(schDept!=null){
						appeal.setDeptFlow(schDept.getDeptFlow());
						appeal.setDeptName(schDept.getDeptName());
						
						appeal.setSchDeptFlow(schDept.getSchDeptFlow());
						appeal.setSchDeptName(schDept.getSchDeptName());
					}
				}
			}
			
			appeal.setAuditStatusId("");
			appeal.setAuditStatusName("");
			
			if(resRecBiz.editAppeal(appeal)!=GlobalConstant.ZERO_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value="/operAppeal",method={RequestMethod.POST})
	@ResponseBody
	public String operAppeal(ResAppeal appeal){
		String deleteS = GlobalConstant.OPRE_SUCCESSED;
		String deleteF = GlobalConstant.OPRE_FAIL;
		if(appeal!=null){
//			if(StringUtil.isNotBlank(appeal.getStatusId())){
//				appeal.setStatusName(RecStatusEnum.getNameById(appeal.getStatusId()));
//			}
			
			if(StringUtil.isNotBlank(appeal.getAuditStatusId())){
				appeal.setAuditStatusName(RecStatusEnum.getNameById(appeal.getAuditStatusId()));
				appeal.setAuditTime(DateUtil.getCurrDateTime());
				appeal.setAuditUserFlow(GlobalContext.getCurrentUser().getUserFlow());
				appeal.setAuditUserName(GlobalContext.getCurrentUser().getUserName());
//				if(RecStatusEnum.TeacherAuditN.getId().equals(appeal.getAuditStatusId())){
//					appeal.setStatusId(RecStatusEnum.Edit.getId());
//					appeal.setStatusName(RecStatusEnum.getNameById(appeal.getStatusId()));
//				}
			}
			
//			if(StringUtil.isNotBlank(appeal.getHeadAuditStatusId())){
//				appeal.setHeadAuditStatusName(RecStatusEnum.getNameById(appeal.getHeadAuditStatusId()));
//				appeal.setHeadAuditTime(DateUtil.getCurrDateTime());
//				appeal.setHeadAuditUserFlow(GlobalContext.getCurrentUser().getUserFlow());
//				appeal.setHeadAuditUserName(GlobalContext.getCurrentUser().getUserName());
//				if(RecStatusEnum.HeadAuditN.getId().equals(appeal.getAuditStatusId())){
//					appeal.setStatusId(RecStatusEnum.Edit.getId());
//					appeal.setStatusName(RecStatusEnum.getNameById(appeal.getStatusId()));
//				}
//			}
			
			if(StringUtil.isNotBlank(appeal.getRecordStatus())){
				deleteS = GlobalConstant.DELETE_SUCCESSED;
				deleteF = GlobalConstant.DELETE_FAIL;
			}
			
			if(resRecBiz.editAppeal(appeal)!=GlobalConstant.ZERO_LINE){
				return deleteS;
			}
		}
		return deleteF;
	}
	
	@RequestMapping(value="/appealList",method={RequestMethod.GET,RequestMethod.POST})
	public String appealList(ResAppeal appeal,String startTime,String endTime,Model model){
		if(appeal == null){
			appeal = new ResAppeal();
		}
		appeal.setOperUserFlow(GlobalContext.getCurrentUser().getUserFlow());
		List<ResAppeal> appealList = resRecBiz.searchAppeal(appeal,startTime,endTime);
		model.addAttribute("appealList",appealList);
		
		return "res/doctor/appeal/appealList";
	}
	
	//TODO 评分列表
	@RequestMapping(value="/score/dept",method={RequestMethod.GET,RequestMethod.POST})
	public String dept(Model model){
		_setModelAttribute(ResRecTypeEnum.DeptGrade.getId(),model);
		return "res/doctor/score/dept";
	}
	
	@RequestMapping(value="/score/teacher",method={RequestMethod.GET,RequestMethod.POST})
	public String teacher(Model model){
		_setModelAttribute(ResRecTypeEnum.TeacherGrade.getId(),model);
		return "res/doctor/score/teacher";
	}
	
	private void _setModelAttribute(String recTypeId,Model model){
		List<String> doctorFlows  = new ArrayList<String>();
		doctorFlows.add(GlobalContext.getCurrentUser().getUserFlow());
		List<SchArrangeResult> arrResultList =  schArrangeResultBiz.searchArrangeResultByDoctorFlows(doctorFlows);
		if(arrResultList!=null&&!arrResultList.isEmpty()){
			List<String> schResultFlows = new ArrayList<String>();
			List<String> schDeptFLows = new ArrayList<String>();
			for (SchArrangeResult result : arrResultList) {
				schResultFlows.add(result.getResultFlow());
				schDeptFLows.add(result.getSchDeptFlow());
			}

			model.addAttribute("arrResultList", arrResultList);
			
			List<ResDoctorSchProcess> processList = resDoctorProcessBiz.searchByResultFlows(schResultFlows);
			if(processList!=null && processList.size()>0){
				Map<String,ResDoctorSchProcess> processMap = new HashMap<String, ResDoctorSchProcess>();
				for(ResDoctorSchProcess process : processList){
					processMap.put(process.getSchResultFlow(),process);
				}
				model.addAttribute("processMap", processMap);
			}
			
			List<ResRec> recList = resRecBiz.searchByRec(recTypeId,schDeptFLows,GlobalContext.getCurrentUser().getUserFlow());
			if(recList!=null && recList.size()>0){
				Map<String,ResRec> recMap = new HashMap<String, ResRec>();
				Map<String,Map<String,Object>> recContentMap = new HashMap<String, Map<String,Object>>();
				
				for(ResRec rec : recList){
					recMap.put(rec.getSchDeptFlow(),rec);
					
					Map<String,Object> contentMap = resRecBiz.parseGradeXml(rec.getRecContent());
					recContentMap.put(rec.getRecFlow(),contentMap);
				}
				
				model.addAttribute("recMap",recMap);
				model.addAttribute("recContentMap",recContentMap);
			}
		}
	}
	
	/**
	 * 入科视图
	 * */
	@RequestMapping(value="/inDeptView",method={RequestMethod.GET})
	public String inDeptView(String processFlow,Model model){
		ResDoctorSchProcess process = resDoctorProcessBiz.read(processFlow);
		if(process!=null){
			model.addAttribute("process",process);
			
			List<ResRec> recList = resRecBiz.searchByRec(ResRecTypeEnum.PreTrainForm.getId(),process.getSchDeptFlow(),process.getUserFlow());
			if(recList!=null && recList.size()>0){
				model.addAttribute("preTrainFormRec",recList.get(0));
			}
		}
		
		return "res/edu/student/inDeptView";
	}
	
	/**
	 * 出科视图
	 * */
	@RequestMapping(value="/outDeptView",method={RequestMethod.GET})
	public String outDeptView(String processFlow,Model model){
		ResDoctorSchProcess process = resDoctorProcessBiz.read(processFlow);
		model.addAttribute("process",process);
		
		if (process != null) {
			String schDeptFlow = process.getSchDeptFlow();
			//带教老师,科室考评
			List<String> recTypeIds = new ArrayList<String>();
			recTypeIds.add(ResRecTypeEnum.DeptGrade.getId());
			recTypeIds.add(ResRecTypeEnum.TeacherGrade.getId());
			recTypeIds.add(ResRecTypeEnum.AfterEvaluation.getId());
			recTypeIds.add(ResRecTypeEnum.AfterSummary.getId());
			
			List<ResRec> deptGradeList = resRecBiz.searchByRecWithBLOBs(recTypeIds,schDeptFlow,GlobalContext.getCurrentUser().getUserFlow());
			
			if(deptGradeList!=null && deptGradeList.size()>0){
				for(ResRec rec : deptGradeList){
					String recTypeId = rec.getRecTypeId();
					if(ResRecTypeEnum.DeptGrade.getId().equals(recTypeId)){
						Map<String,Object> gradeMap = resRecBiz.parseGradeXml(rec.getRecContent());
						model.addAttribute("deptGrade",rec);
						model.addAttribute("deptGradeMap", gradeMap);
					}else if(ResRecTypeEnum.TeacherGrade.getId().equals(recTypeId)){
						Map<String,Object> gradeMap = resRecBiz.parseGradeXml(rec.getRecContent());
						model.addAttribute("teacherGrade",rec);
						model.addAttribute("teacherGradeMap", gradeMap);
					}else if(ResRecTypeEnum.AfterEvaluation.getId().equals(recTypeId)){
						model.addAttribute("evaluation",rec);
					}else if(ResRecTypeEnum.AfterSummary.getId().equals(recTypeId)){
						Map<String,Object> afterDataMap = resRecBiz.parseContent(rec.getRecContent());
						model.addAttribute("afterDataMap",afterDataMap);
						model.addAttribute("after",rec);
					}
				}
			}
		}
		
		return "res/edu/student/outDeptView";
	}
	///////////////////////////////////////
	@RequestMapping(value="/showRecForm",method={RequestMethod.GET,RequestMethod.POST})
	public String showRecForm(String recTypeId,String operUserFlow, Model model){
		
		ResRec rec = resRecBiz.searchRecWithBLOBs(recTypeId,operUserFlow);
		model.addAttribute("rec",rec);
		String currVer = rec==null?null:rec.getRecVersion();
		Map<String,Object> formDataMap = null;
		if(rec!=null){
			String recContent = rec.getRecContent();
			formDataMap = resRecBiz.parseContent(recContent);
			model.addAttribute("formDataMap", formDataMap);	
		}
		model.addAttribute("formFileName", recTypeId);
		String rotationFlow = "";
		if(StringUtil.isNotBlank(operUserFlow)){
			ResDoctor doctor = doctorBiz.readDoctor(operUserFlow);
			if(doctor!=null){
				rotationFlow = doctor.getRotationFlow();
			}
		}
		
		return resRecBiz.getFormPath(recTypeId,currVer,rotationFlow);
	}
	/**
	 * 删除Resrec
	 * @param proj
	 * @return
	 */
	@RequestMapping("/delResrec")
	@ResponseBody
	public String delResrec(ResRec rec){
		int result=resRecBiz.editRec(rec);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.DELETE_SUCCESSED;
		}
		return GlobalConstant.DELETE_FAIL;
	}
	@RequestMapping(value="/viewForm",method={RequestMethod.GET,RequestMethod.POST})
	public String viewForm(String recTypeId,String formId, Model model){
		if(StringUtil.isNotBlank(formId) && StringUtil.isNotBlank(recTypeId)){
			String currVer = InitConfig.resFormRequestUtil.getVersionMap().get(formId+"_"+recTypeId);
			if(StringUtil.isBlank(currVer)){
				currVer = InitConfig.resFormRequestUtil.getVersionMap().get(GlobalConstant.RES_FORM_PRODUCT+"_"+recTypeId);
			}
			if(StringUtil.isBlank(currVer)){
				currVer = GlobalConstant.RES_FORM_PRODUCT_VER;
			}
			Map<String,IrbSingleForm> singleFormMap = InitConfig.resFormRequestUtil.getFormMap().get(recTypeId);
			
			IrbSingleForm singleForm = singleFormMap.get(formId+"_"+currVer);
			
			if(singleForm == null){
				singleForm = singleFormMap.get(GlobalConstant.RES_FORM_PRODUCT+"_"+currVer);
			}
			
			if(singleForm == null){
				throw new RuntimeException("未发现表单 模版类型:"+formId+",表单类型:"+ResRecTypeEnum.getNameById(recTypeId)+",版本号:"+currVer);
			}
			
			String jspPath = singleForm.getJspPath();
			
			if(StringUtil.isNotBlank(jspPath)){
				jspPath = MessageFormat.format(jspPath,singleForm.getProductType(),singleForm.getVersion());
			}
			
			return jspPath;
		}
		return "error/404";
	}
	
	@RequestMapping(value="/savePreTrainForm",method={RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public String savePreTrainForm(String recFlow,String resultFlow,String roleFlag,HttpServletRequest req){
		int result = resRecBiz.editPreTrainForm(recFlow,resultFlow,roleFlag,req);
		if(result!=GlobalConstant.ZERO_LINE){
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
	@RequestMapping(value="/saveAnnualTrainForm",method={RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public String saveAnnualTrainForm(String recFlow,String roleFlag,HttpServletRequest req){
		int result = resRecBiz.editAnnualTrainForm(recFlow,roleFlag,req);
		if(result!=GlobalConstant.ZERO_LINE){
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}

	
	/**
	 * 学员操作出科
	 * @param userFlow
	 * @param schDeptFlow
	 * @param processFlow
	 * @return
	 */
	@RequestMapping(value="/docOperAfter",method={RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public String docOperAfter(String userFlow,String schDeptFlow,String processFlow){
		if(StringUtil.isNotBlank(userFlow) && StringUtil.isNotBlank(schDeptFlow)){
			List<ResRec> preTrainList = resRecBiz.searchByRec(ResRecTypeEnum.PreTrainForm.getId(),schDeptFlow,userFlow);
			if(preTrainList!=null && preTrainList.size()>0){
				ResRec preTrain = preTrainList.get(0);
				if(preTrain!=null && RecStatusEnum.TeacherAuditY.getId().equals(preTrain.getAuditStatusId())){
					List<ResRec> teacherGradeList = resRecBiz.searchByRec(ResRecTypeEnum.TeacherGrade.getId(),schDeptFlow,userFlow);
					if(teacherGradeList!=null && teacherGradeList.size()>0){
						if(StringUtil.isNotBlank(processFlow)){
							ResDoctorSchProcess process = new ResDoctorSchProcess();
							process.setProcessFlow(processFlow);
							process.setSchFlag(GlobalConstant.FLAG_Y);
							process.setIsCurrentFlag(GlobalConstant.FLAG_N);
							int result = resDoctorProcessBiz.edit(process);
							if(result!=GlobalConstant.ZERO_LINE){
								return GlobalConstant.OPRE_SUCCESSED_FLAG;
							}
						}
					}
				}
			}
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
	/**
	 * 培训登记
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/speRegistry/{roleFlag}")
	public String speRegistry(@PathVariable String roleFlag,String doctorFlow,Model model){
		model.addAttribute("roleFlag",roleFlag);
		
		doctorFlow = StringUtil.defaultIfEmpty(doctorFlow,GlobalContext.getCurrentUser().getUserFlow());
		
		ResDoctor doctor = doctorBiz.readDoctor(doctorFlow);
		model.addAttribute("doctor",doctor);
		return "res/doctor/speRegistry";
	}
}

