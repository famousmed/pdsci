package com.pinde.sci.ctrl.gcp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pinde.sci.biz.gcp.IGcpFinBiz;
import com.pinde.sci.biz.gcp.IGcpProjBiz;
import com.pinde.sci.biz.gcp.IGcpQcRecordBiz;
import com.pinde.sci.biz.gcp.IGcpRecBiz;
import com.pinde.sci.biz.pub.IPubPatientAeBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.gcp.GcpProjStatusEnum;
import com.pinde.sci.enums.gcp.GcpQcTypeEnum;
import com.pinde.sci.enums.pub.ProjCategroyEnum;
import com.pinde.sci.model.irb.ProjInfoForm;
import com.pinde.sci.model.mo.GcpContract;
import com.pinde.sci.model.mo.GcpQcRecord;
import com.pinde.sci.model.mo.GcpRec;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientAe;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysUser;
@Controller
@RequestMapping("/gcp")
public class GcpController extends  GeneralController{
	private static Logger logger = LoggerFactory.getLogger(GcpController.class);
	private static final String GCP_CURR_PROJ = "gcpCurrProj";
	//private static Integer DEFAULT_START_PAGE_INDEX = 1;//默认起始分页索引
	//private static Integer DEFAULT_PAGE_SIZE = 15;//默认分页数大小
	
	@Autowired
	private IPubProjBiz projBiz;
	@Autowired
	private IPubPatientAeBiz patientAeBiz;
	@Autowired
	private IGcpRecBiz gcpRecBiz;
	@Autowired
	private IGcpFinBiz gcpFinBiz;
	@Autowired
	private IPubPatientBiz patientBiz;
	@Autowired
	private IGcpProjBiz gcpProjBiz;
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IGcpQcRecordBiz qcRecordBiz;
	
	/**
	 * 加载不良事件一览
	 * @param projFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/aeList")
	public String aeList(Model model){
		PubPatientAe patientAe = new PubPatientAe();
		patientAe.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		List<PubPatientAe> patientAeList = patientAeBiz.searchPatientAeList(patientAe);
		if(patientAeList != null && !patientAeList.isEmpty()){
			List<String> projFlowList = new ArrayList<String>();//AE表不重复的projFlow
			Map<String,List<PubPatientAe>> projAeMap = new HashMap<String, List<PubPatientAe>>();
			Map<String,String> patientFlowMap = new HashMap<String, String>();
			for(PubPatientAe ae :patientAeList){
				String projFlow = ae.getProjFlow();
				if (!projFlowList.contains(projFlow)){//过滤projFlow
					projFlowList.add(projFlow);
				}
				
				String patientFlow = ae.getPatientFlow();
				if (!patientFlowMap.containsKey(patientFlow)){//过滤patientFlow
					//根据projFlow组织Map
					List<PubPatientAe> temp = projAeMap.get(projFlow);
					if(temp == null){
						temp = new ArrayList<PubPatientAe>();
					}
					temp.add(ae);
					projAeMap.put(projFlow, temp);
					
					patientFlowMap.put(patientFlow, patientFlow);
				}
			}
			List<PubProj> projList = projBiz.searchProjByProjFlows(projFlowList);
			model.addAttribute("projList", projList);
			model.addAttribute("projAeMap", projAeMap);
		}
		return "gcp/search/aeList";
	}
	
	/**
	 * 加载项目进度一览
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/projProgressList")
	public String projProgressList(PubProj proj, String searchFlag, Model model) throws Exception{
		if(!GlobalConstant.FLAG_Y.equals(searchFlag)){
			return "gcp/search/projProgressList";
		}
		proj.setApplyOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		proj.setProjStatusId(GcpProjStatusEnum.Passed.getId());
		List<PubProj> projList = projBiz.queryProjList(proj);
		
		List<String> projFlowList = new ArrayList<String>();
		if(projList != null && !projList.isEmpty()){
			for(PubProj p : projList){
				projFlowList.add(p.getProjFlow());
			}
			
			//启动会议日期
			List<GcpRec> gcpRecList = gcpRecBiz.searchGcpRecListWithBLOBs(projFlowList);
			if(gcpRecList != null && !gcpRecList.isEmpty()){
				Map<String, String> startMeetingDateMap = gcpRecBiz.searchStartMeetingDate(gcpRecList);
				model.addAttribute("startMeetingDateMap", startMeetingDateMap);
			}
			
			//合同总例数
			List<GcpContract> contractList = gcpFinBiz.searchContractList(projFlowList);
			if(contractList != null && !contractList.isEmpty()){
				Map<String, Integer> contractCaseNumMap = new HashMap<String, Integer>();
				for(GcpContract con : contractList){
					String projFlow = con.getProjFlow();
					int caseNumber = 0;
					if (con.getCaseNumber() != null) {
						caseNumber = con.getCaseNumber();
					}
					Integer temp = contractCaseNumMap.get(projFlow);
					if(temp == null){
						temp = caseNumber;
					}else{
						temp = temp + caseNumber;
					}
					contractCaseNumMap.put(projFlow, temp);
				}
				model.addAttribute("contractCaseNumMap", contractCaseNumMap);
			}
			
			//入组/完成	脱落/终止
			List<PubPatient> patietnList = patientBiz.searchPatientStageList(projFlowList);
			if(patietnList != null && !patietnList.isEmpty()){
				Map<String, Map<String, Integer>> stageMap = new HashMap<String, Map<String, Integer>>();
				for(PubPatient pat : patietnList){
					String projFlow = pat.getProjFlow();
					String stageId = pat.getPatientStageId();
					Map<String, Integer> tempMap = stageMap.get(projFlow);
					if(tempMap == null){
						tempMap = new HashMap<String, Integer>();
					}
					
					Integer temp = tempMap.get(stageId);
					if(temp == null){
						temp = 1;
					}else{
						temp += 1;
					}
					tempMap.put(stageId, temp);
					stageMap.put(projFlow, tempMap);					
				}
				model.addAttribute("stageMap", stageMap);
			}
			
			//SAE例数
			List<PubPatientAe> patientAeList = patientAeBiz.searchSaeList(projFlowList);
			if(patientAeList != null && !patientAeList.isEmpty()){
				Map<String, Integer> saeMap = new HashMap<String, Integer>();
				for(PubPatientAe ae :patientAeList){
					String projFlow = ae.getProjFlow();
					Integer temp = saeMap.get(projFlow);
					if(temp == null){
						temp = 1;
					}else{
						temp += 1;
					}
					saeMap.put(projFlow, temp);
				}
				model.addAttribute("saeMap", saeMap);
			}
		}
		model.addAttribute("projList", projList);
		return "gcp/search/projProgressList";
	}
	/**
	 * 专业组一览表
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/deptProjView"},method={RequestMethod.GET})
	public String deptProjView(Model model){
		SysUser currUser = GlobalContext.getCurrentUser();
		PubProj proj=new PubProj();
		proj.setApplyOrgFlow(currUser.getOrgFlow());
		proj.setProjStatusId(GcpProjStatusEnum.Passed.getId());
		//存放每个专业组每种类型的项目数量的map
	    Map<String, Map<String,String>> deptProjMap=new HashMap<String, Map<String,String>>();
		//查询当前机构的专业组
		SysDept dept=new SysDept();
		dept.setOrgFlow(currUser.getOrgFlow());
		List<SysDept> deptList=deptBiz.searchDept(dept);
		model.addAttribute("deptList", deptList);
		//如果该机构专业组不为空，则查询每个专业组每种项目类别的项目数量
		if(null!=deptList && !deptList.isEmpty()){
			List<String> projCateList=new ArrayList<String>();
			projCateList.add(ProjCategroyEnum.Ky.getId());
			projCateList.add(ProjCategroyEnum.Qx.getId());
			projCateList.add(ProjCategroyEnum.Yw.getId());
			for(SysDept sysDept:deptList){
				proj.setApplyDeptFlow(sysDept.getDeptFlow());
				Map<String,String> projCateMap=new HashMap<String, String>();
				for(String projCate:projCateList){
					proj.setProjCategoryId(projCate);
					Integer count=gcpProjBiz.count(proj);
					projCateMap.put(projCate, String.valueOf(count));
				}
				deptProjMap.put(sysDept.getDeptFlow(), projCateMap);
			}
		}
		model.addAttribute("deptProjMap", deptProjMap);
		return "gcp/search/deptProjList";
	}
	
	/**
	 * 药监检查一览表
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/qcList"},method={RequestMethod.GET})
	public String qcList(String startDate,String endDate,String currentPage,Model model){
		GcpQcRecord qcRecord = new GcpQcRecord();
		qcRecord.setQcTypeId(GcpQcTypeEnum.Inspection.getId());
		qcRecord.setQcStartDate(startDate);
		qcRecord.setQcEndDate(endDate);
		List<GcpQcRecord> qcRecordList = qcRecordBiz.searchQcRecordByqcRecord(qcRecord);
		if(qcRecordList!=null && qcRecordList.size()>0){
			List<String> projFlows = new ArrayList<String>();
			for(GcpQcRecord qcRecordTemp : qcRecordList){
				if(!projFlows.contains(qcRecordTemp.getProjFlow())){
					projFlows.add(qcRecordTemp.getProjFlow());
				}
			}
			List<ProjInfoForm> projFormList = gcpProjBiz.searchProjFormList(projFlows);
			if(projFormList!=null && projFormList.size()>0){
				Map<String,ProjInfoForm> projFormMap = new HashMap<String,ProjInfoForm>();
				for(ProjInfoForm projForm : projFormList){
					PubProj proj = projForm.getProj();
					if(proj!=null){
						projFormMap.put(proj.getProjFlow(),projForm);
					}
				}
				model.addAttribute("projFormMap", projFormMap);
			}
			model.addAttribute("qcRecordList", qcRecordList);
		}
		return "gcp/search/qcList";
	}
}
