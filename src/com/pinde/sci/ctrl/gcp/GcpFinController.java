package com.pinde.sci.ctrl.gcp;

import java.io.IOException;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.gcp.IGcpFinBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.srm.IProjProcessBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.PubProjProcessMapper;
import com.pinde.sci.enums.gcp.GcpContractTypeEnum;
import com.pinde.sci.enums.gcp.GcpFundTypeEnum;
import com.pinde.sci.enums.gcp.GcpProjStageEnum;
import com.pinde.sci.enums.gcp.GcpProjStatusEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.gcp.GcpContractExt;
import com.pinde.sci.model.mo.GcpContract;
import com.pinde.sci.model.mo.GcpFund;
import com.pinde.sci.model.mo.GcpFundExample;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjProcess;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysUser;
@Controller
@RequestMapping("/gcp/fin")
public class GcpFinController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(GcpFinController.class);
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IPubProjBiz pubProjBiz;
	@Autowired
	private IGcpFinBiz gcpFinBiz;
	@Autowired
	private IFileBiz fileBiz;
	@Autowired
	private PubProjProcessMapper projProcessMapper;
	
	/**
	 * 科室列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/deptList")
	public String deptList(String type,String deptFlow,Model model){
		SysDept dept = new SysDept();
		dept.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		dept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		if (StringUtil.isNotBlank(deptFlow)) {
			dept.setDeptFlow(deptFlow);
		}
		List<SysDept> deptList = this.deptBiz.searchDept(dept);
		model.addAttribute("deptList", deptList);
		return "gcp/fin/"+type+"/deptList";
	}
	/**
	 * 合同列表
	 * @param projFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/contList")
	public String contList(GcpContract contract, Model model){
		PubProj proj=new PubProj();
		List<GcpContractExt> contList = this.gcpFinBiz.searchContractList(proj,contract);
		model.addAttribute("contList", contList);
		return "gcp/fin/contract/list";
	}
	/**
	 * 合同列表
	 * @param projFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/contractList")
	public String contractList(GcpContract contract,PubProj proj, Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
		proj.setApplyOrgFlow(currUser.getOrgFlow());
		proj.setProjStatusId(GcpProjStatusEnum.Passed.getId());
		List<GcpContractExt> contractList = this.gcpFinBiz.searchContractList(proj,contract);
		model.addAttribute("contractList", contractList);
		//查询当前机构所有科室
		SysDept dept = new SysDept();
		dept.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		dept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysDept> deptList = this.deptBiz.searchDept(dept);
		model.addAttribute("deptList", deptList);
				
		return "gcp/fin/contract/amountList";
	}
	/**
	 * 机构主界面合同列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/orgContList")
	public String orgContList(Model model){
		GcpContract contract = new GcpContract();
		contract.setOrgFlow(InitConfig.getSysCfg("gcp_default_org"));
		PageHelper.startPage(1, Integer.valueOf(InitConfig.getSysCfg("gcp_org_info_count")));
		List<GcpContract> contList = this.gcpFinBiz.searchContList(contract,"create_time desc");
		model.addAttribute("contList", contList);
		return "gcp/proj/main/contList";
	}
	/**
	 * 机构主界面经费列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/orgFundList")
	public String orgFundList(Model model){
		GcpFund fund = new GcpFund();
		fund.setOrgFlow(InitConfig.getSysCfg("gcp_default_org"));
		PageHelper.startPage(1, Integer.valueOf(InitConfig.getSysCfg("gcp_org_info_count")));
		List<GcpFund> fundList = this.gcpFinBiz.searchFundList(fund);
		Map<String,PubProj> projMap = null;
		if(fundList!=null&&!fundList.isEmpty()){
			projMap =new HashMap<String, PubProj>();
			for (GcpFund gcpFund : fundList) {
				PubProj proj = this.pubProjBiz.readProject(gcpFund.getProjFlow());
				projMap.put(gcpFund.getFundFlow(), proj);
			}
		}
		model.addAttribute("fundList", fundList);
		model.addAttribute("projMap", projMap);
		return "gcp/proj/main/fundList";
	}
	/**
	 * 科室的项目列表
	 * @param proj
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/projList")
	public String projList(PubProj proj,String contractNo, Model model){
		proj.setApplyOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		proj.setProjStatusId(GcpProjStatusEnum.Passed.getId());
		List<PubProj> projList = this.pubProjBiz.queryProjList(proj);
		if(StringUtil.isNotBlank(contractNo)){
			GcpContract cont = this.gcpFinBiz.searchContByNo(contractNo);
			if(cont!=null){
				projList = new ArrayList<PubProj>();
				String projFlow = cont.getProjFlow();
				PubProj finProj = this.pubProjBiz.readProject(projFlow);
				projList.add(finProj);
				model.addAttribute("projFlow", projFlow);
			}
		}
		
		SysDept dept = new SysDept();
		dept.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		dept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysDept> deptList = this.deptBiz.searchDept(dept);
		model.addAttribute("deptList", deptList);
		
		Map<String,Map<String,Object>> countMap = this.gcpFinBiz.countContract(projList,contractNo);
		model.addAttribute("projList", projList);
		model.addAttribute("countMap", countMap);
		return "gcp/fin/contract/projList";
	}
	/**
	 * 显示合同编辑页面
	 * @param contractFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/editContract")
	public String editContract(String contractFlow,Model model){
		if(StringUtil.isNotBlank(contractFlow)){
			GcpContract cont = this.gcpFinBiz.searchContByFlow(contractFlow);
			if(cont!=null){
				PubFile file = this.fileBiz.readFile(cont.getContractFile());
				model.addAttribute("cont", cont);
				model.addAttribute("file", file);
			}
		}
		return "gcp/fin/contract/edit";
	}
	/**
	 * 保存合同
	 * @param cont
	 * @param file
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value="/saveContract")
	@ResponseBody
	public String saveContract(GcpContract cont,@RequestParam(value="file",required=false) MultipartFile file) throws IOException{
		PubProj proj = this.pubProjBiz.readProject(cont.getProjFlow());
		if(proj!=null){
			cont.setContractTypeName(GcpContractTypeEnum.getNameById(cont.getContractTypeId()));
			cont.setProjName(proj.getProjName());
			cont.setProjShortName(proj.getProjShortName());
			cont.setProjSubTypeId(proj.getProjSubTypeId());
			cont.setProjSubTypeName(proj.getProjSubTypeName());
			cont.setProjDeclarer(proj.getProjDeclarer());
			cont.setProjShortDeclarer(proj.getProjShortDeclarer());
			cont.setOrgFlow(StringUtil.defaultString(proj.getApplyOrgFlow()));
			
			//
			if(StringUtil.isBlank(cont.getContractFlow())){
				PubProjProcess process = new PubProjProcess();
				process.setProcessFlow(PkUtil.getUUID());
				process.setProjFlow(proj.getProjFlow());
				process.setProjStageId(GcpProjStageEnum.Apply.getId());
				process.setProjStageName(GcpProjStageEnum.Apply.getName());
				process.setProjStatusId("Y");
				process.setRecTypeName("合同");
				process.setRecTypeId("Process");
				process.setProcessRemark("已签订");
				
				SysUser currUser = GlobalContext.getCurrentUser();
				process.setOperUserFlow(currUser.getUserFlow());
				process.setOperUserName(currUser.getUserName());
				process.setOperOrgFlow(currUser.getOrgFlow());
				process.setOperOrgName(currUser.getOrgName());
				process.setOperTime(DateUtil.getCurrDateTime());
				GeneralMethod.setRecordInfo(process, true);
				projProcessMapper.insertSelective(process);
			}
			
			int result = this.gcpFinBiz.editContract(cont, file);
			if(result==GlobalConstant.ONE_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	/**
	 * 删除合同附件
	 * @param contractFlow
	 * @return
	 */
	@RequestMapping(value="/delContFile")
	@ResponseBody
	public String delContFile(String contractFlow){
		if(StringUtil.isNotBlank(contractFlow)){
			int result = this.gcpFinBiz.delContractFile(contractFlow);
			if(result== GlobalConstant.ONE_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	/**
	 * 删除合同
	 * @param contractFlow
	 * @return
	 */
	@RequestMapping(value="/delContract")
	@ResponseBody
	public String delContract(String contractFlow){
		if(StringUtil.isNotBlank(contractFlow)){
			int result = this.gcpFinBiz.delContract(contractFlow);
			if(result== GlobalConstant.ONE_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	/**
	 * 经费记录项目列表
	 * @param proj
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/projFundList")
	public String projFundList(PubProj proj,String deptFlag,Model model){
		proj.setApplyOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		proj.setProjStatusId(GcpProjStatusEnum.Passed.getId());
		List<PubProj> projList = this.pubProjBiz.queryProjList(proj);
		Map<String,Map<String,Object>> countMap = this.gcpFinBiz.countFund(projList);
		model.addAttribute("projList", projList);
		model.addAttribute("countMap", countMap);
		Map<String,List<GcpFund>> fundMap=this.gcpFinBiz.fundMap(projList);
		model.addAttribute("fundMap", fundMap);
		List<GcpContract> contractList = gcpFinBiz.searchContractList();
		Map<String,Float> contractFundMap = new HashMap<String, Float>(); 
		if(contractList != null && contractList.size() >0){
			for(GcpContract c : contractList){
				String projFlow = c.getProjFlow();
				Float unIn = new Float(0);
				if (contractFundMap.get(projFlow) != null) {
					unIn = contractFundMap.get(projFlow);
				}
				if(c.getContractFund()!=null){
					unIn += c.getContractFund().floatValue();
					contractFundMap.put(projFlow, unIn);
				}
			}
		}
		model.addAttribute("contractFundMap", contractFundMap);
		
		//查询当前机构所有科室
		SysDept dept = new SysDept();
		dept.setOrgFlow(InitConfig.getSysCfg("gcp_default_org"));
		dept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysDept> deptList = this.deptBiz.searchDept(dept);
		model.addAttribute("deptList", deptList);
		if(StringUtil.isNotBlank(deptFlag)){
		   return "gcp/fin/fund/deptProjList";
		}
		//合同编号
		if(contractList != null && !contractList.isEmpty()){
			Map<String,String> projContractNoMap = new HashMap<String, String>(); 
			for(GcpContract c : contractList){
				String projFlow = c.getProjFlow();
				String contractNo = c.getContractNo();
				String temp = projContractNoMap.get(projFlow);
				if(temp == null){
					temp = contractNo;
				}else{
					temp = temp +"，"+ contractNo;
				}
				projContractNoMap.put(projFlow, temp);
			}
			model.addAttribute("projContractNoMap", projContractNoMap);
		}
		return "gcp/fin/fund/list";
	}
	
	
	/**
	 * 编辑经费信息
	 * @param contractFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/editFund")
	public String editFund(String fundFlow,Model model){
		GcpFund fund=null;
		if(StringUtil.isNotBlank(fundFlow)){
			fund=gcpFinBiz.readFund(fundFlow);
			model.addAttribute("fund", fund);
		}
		return "gcp/fin/fund/edit";
	}
	/**
	 * 保存经费记录
	 * @param gcpFund
	 * @return
	 */
	@RequestMapping(value="/saveFund")
	@ResponseBody
	public String saveFund(GcpFund gcpFund,Model model){
		PubProj proj = this.pubProjBiz.readProject(gcpFund.getProjFlow());
		if(proj!=null){
			gcpFund.setOrgFlow(StringUtil.defaultString(proj.getApplyOrgFlow()));
			if (StringUtil.isNotBlank(gcpFund.getFundUsesId())) {
				gcpFund.setFundUsesName(DictTypeEnum.GcpFundUses.getDictNameById(gcpFund.getFundUsesId()));
			}
			gcpFund.setFundTypeName(GcpFundTypeEnum.getNameById(gcpFund.getFundTypeId()));
			int result = this.gcpFinBiz.saveFund(gcpFund);
			
			
			//process
			//
			PubProjProcess process = new PubProjProcess();
			process.setProcessFlow(PkUtil.getUUID());
			process.setProjFlow(proj.getProjFlow());
			process.setProjStageId(GcpProjStageEnum.Apply.getId());
			process.setProjStageName(GcpProjStageEnum.Apply.getName());
			process.setProjStatusId(gcpFund.getFundTypeId());
			process.setRecTypeName("款项");
			process.setRecTypeId("Process");
			process.setProcessRemark(gcpFund.getFundTypeName() +"["+gcpFund.getFundAmount()+"]");
			
			SysUser currUser = GlobalContext.getCurrentUser();
			process.setOperUserFlow(currUser.getUserFlow());
			process.setOperUserName(currUser.getUserName());
			process.setOperOrgFlow(currUser.getOrgFlow());
			process.setOperOrgName(currUser.getOrgName());
			process.setOperTime(DateUtil.getCurrDateTime());
			GeneralMethod.setRecordInfo(process, true);
			projProcessMapper.insertSelective(process);
			
			
			if(result==GlobalConstant.ONE_LINE){
				model.addAttribute("projFlow", gcpFund.getProjFlow());
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	/**
	 * 删除经费记录
	 * @param fundFlow
	 * @return
	 */
	@RequestMapping(value="/delFund")
	@ResponseBody
	public String delFund(String fundFlow){
		if(StringUtil.isNotBlank(fundFlow)){
			int result = this.gcpFinBiz.delFund(fundFlow);
			if(result== GlobalConstant.ONE_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	@RequestMapping(value="/seachDeptListJson")
	@ResponseBody
	public List<SysDept> seachDeptListJson(){
		SysDept dept = new SysDept();
		dept.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		dept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		return this.deptBiz.searchDept(dept);
	}
	
	@RequestMapping(value="/loadFund")
	public String loadFund(String projFlow,Model model){
		GcpFund fund = new GcpFund(); 
		fund.setProjFlow(projFlow);
		List<GcpFund> fundList = gcpFinBiz.searchFundList(fund);
		model.addAttribute("fundList", fundList);
		return "gcp/proj/main/fundList";
	}
	
}
