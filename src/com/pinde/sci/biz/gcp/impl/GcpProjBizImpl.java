package com.pinde.sci.biz.gcp.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.gcp.IGcpFinBiz;
import com.pinde.sci.biz.gcp.IGcpProjBiz;
import com.pinde.sci.biz.gcp.IGcpRecBiz;
import com.pinde.sci.biz.irb.IIrbApplyBiz;
import com.pinde.sci.biz.irb.IIrbUserBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.GcpRecMapper;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.dao.base.PubProjOrgMapper;
import com.pinde.sci.dao.base.PubProjProcessMapper;
import com.pinde.sci.dao.base.PubProjUserMapper;
import com.pinde.sci.dao.pub.PubProjExtMapper;
import com.pinde.sci.dao.pub.PubTrainUserExtMapper;
import com.pinde.sci.enums.edc.PatientTypeEnum;
import com.pinde.sci.enums.gcp.GcpFundTypeEnum;
import com.pinde.sci.enums.gcp.GcpProjStageEnum;
import com.pinde.sci.enums.gcp.GcpProjStatusEnum;
import com.pinde.sci.enums.gcp.GcpRecTypeEnum;
import com.pinde.sci.enums.irb.IrbAuthTypeEnum;
import com.pinde.sci.enums.irb.IrbDecisionEnum;
import com.pinde.sci.enums.irb.IrbStageEnum;
import com.pinde.sci.enums.irb.IrbTypeEnum;
import com.pinde.sci.enums.pub.PatientStageEnum;
import com.pinde.sci.enums.pub.ProjCategroyEnum;
import com.pinde.sci.enums.pub.ProjOrgTypeEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.form.gcp.GCPMonitorForm;
import com.pinde.sci.form.gcp.GcpCfgFileForm;
import com.pinde.sci.form.gcp.GcpIrbForm;
import com.pinde.sci.model.irb.ProjInfoForm;
import com.pinde.sci.model.irb.ProjOrgForm;
import com.pinde.sci.model.mo.GcpContract;
import com.pinde.sci.model.mo.GcpFund;
import com.pinde.sci.model.mo.GcpRec;
import com.pinde.sci.model.mo.IrbApply;
import com.pinde.sci.model.mo.IrbUser;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjExample;
import com.pinde.sci.model.mo.PubProjExample.Criteria;
import com.pinde.sci.model.mo.PubProjOrg;
import com.pinde.sci.model.mo.PubProjProcess;
import com.pinde.sci.model.mo.PubProjProcessExample;
import com.pinde.sci.model.mo.PubProjUser;
import com.pinde.sci.model.mo.PubProjUserExample;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.pub.PubTrainUserExt;

@Service
@Transactional(rollbackFor=Exception.class)
public class GcpProjBizImpl implements IGcpProjBiz {
	@Autowired
	private IIrbApplyBiz irbApplyBiz;
	@Autowired
	private IIrbUserBiz irbUserBiz;
	@Autowired
	private IPubPatientBiz patientBiz;
	@Resource
	private PubProjProcessMapper projProcessMapper;
	@Resource
	private PubProjMapper projMapper;
	@Resource
	private PubProjOrgMapper projOrgMapper;
	@Resource
	private PubProjUserMapper projUserMapper;
	@Autowired
	private PubTrainUserExtMapper pubTrainUserExtMapper;
	@Autowired
	private IGcpFinBiz gcpFinBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IGcpRecBiz gcpRecBiz;
	@Autowired
	private GcpRecMapper gcpRecMapper;
	@Resource
	private PubProjExtMapper pubProjExtMapper;
	
	@Override
	public PubProj readProject(String projFlow) {
		return projMapper.selectByPrimaryKey(projFlow);
	}
	
	@Override
	public int saveIrb(GcpIrbForm form) {
		if(form!=null){
			IrbApply irb = new IrbApply();
			String projFlow = form.getProjFlow();
			irb.setProjFlow(projFlow);
			String irbTypeId = form.getIrbTypeId();
			irb.setIrbTypeId(irbTypeId);
			irb.setIrbTypeName(IrbTypeEnum.getNameById(irbTypeId));
			irb.setIrbNo(form.getIrbNo());
			irb.setIrbDecisionId(form.getIrbDecisionId());
			irb.setIrbDecisionName(IrbDecisionEnum.getNameById(form.getIrbDecisionId()));
			irb.setIrbReviewDate(form.getIrbReviewDate());
			irb.setTrackDate(form.getTrackDate());
			irb.setIrbStageId(IrbStageEnum.Filing.getId());
			irb.setIrbStageName(IrbStageEnum.Filing.getName());
			irb.setIrbApplyDate(DateUtil.getCurrDate());
			irbApplyBiz.edit(irb);
			/*主审委员*/
			IrbUser irbUser = new IrbUser();
			irbUser.setProjFlow(projFlow);
			irbUser.setIrbFlow(irb.getIrbFlow());
			if(IrbTypeEnum.Init.getId().equals(irbTypeId)){//初审
				/*方案*/
				irbUser.setUserFlow("-1");//无userFlow，但数据库必填,又不能被当做同一个人过滤
				irbUser.setAuthId(IrbAuthTypeEnum.CommitteePRO.getId());
				irbUser.setAuthName(IrbAuthTypeEnum.CommitteePRO.getName());
				irbUser.setUserName(form.getCommitteePRO());
				irbUserBiz.edit(irbUser);
				/*知情同意书*/
				irbUser.setUserFlow("-2");
				irbUser.setRecordFlow(null);
				irbUser.setAuthId(IrbAuthTypeEnum.CommitteeICF.getId());
				irbUser.setAuthName(IrbAuthTypeEnum.CommitteeICF.getName());
				irbUser.setUserName(form.getCommitteeICF());
				irbUserBiz.edit(irbUser);
			}else{
				irbUser.setUserFlow("-3");
				irbUser.setAuthId(IrbAuthTypeEnum.Committee.getId());
				irbUser.setAuthName(IrbAuthTypeEnum.Committee.getName());
				irbUser.setUserName(form.getCommittee());
				irbUserBiz.edit(irbUser);
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public Map<String, Object> searchPatientCount(String projFlow,String orgFlow) {
		Map<String, Object> countMap = null;
		if(StringUtil.isNotBlank(projFlow)){
			PubPatient patient = new PubPatient();
			patient.setProjFlow(projFlow);
			patient.setPatientTypeId(PatientTypeEnum.Real.getId());
			
			int inCount = 0;
			if(StringUtil.isNotBlank(orgFlow)){
				patient.setOrgFlow(orgFlow);
				Map<String,String> inDateMap = patientBiz.getOrgInDateMap(projFlow);
				if(inDateMap != null && inDateMap.get(orgFlow+"_Count") != null){
					inCount = Integer.parseInt(inDateMap.get(orgFlow+"_Count"));
				}
			}else{
				patient.setPatientStageId(PatientStageEnum.In.getId());//入组数
				inCount = this.patientBiz.count(patient);
			}
			
			patient.setPatientStageId(PatientStageEnum.Finish.getId());//完成数
			int finishCount = this.patientBiz.count(patient);
			patient.setPatientStageId(PatientStageEnum.Off.getId());//脱落数
			int offCount = this.patientBiz.count(patient);
			
			countMap = new HashMap<String, Object>();
			countMap.put(PatientStageEnum.In.getId(), inCount);
			countMap.put(PatientStageEnum.Finish.getId(), finishCount);
			countMap.put(PatientStageEnum.Off.getId(), offCount);
			
			GcpContract contract = new GcpContract();
			contract.setProjFlow(projFlow);
			List<GcpContract> contractList = gcpFinBiz.searchContList(contract,null);
			if(contractList != null && contractList.size()>0){
				int sum = 0;
				for(GcpContract contractTemp : contractList){
					if(contractTemp.getCaseNumber() != null){
						sum+=contractTemp.getCaseNumber();
					}
				}
				countMap.put(projFlow, sum);
			}
		}
		/*项目总经费*/
		GcpFund gcpFund = new GcpFund();
		gcpFund.setOrgFlow(orgFlow);
		gcpFund.setProjFlow(projFlow);
		gcpFund.setFundTypeId(GcpFundTypeEnum.In.getId());
		BigDecimal in = this.gcpFinBiz.searchSumFund(gcpFund);//总到账
		if(in==null){
			in = new BigDecimal(0);
		}
		/*gcpFund.setFundTypeId(GcpFundTypeEnum.Out.getId());
		BigDecimal out = this.gcpFinBiz.searchSumFund(gcpFund);//总支出
		if(out==null){
			out = new BigDecimal(0);
		}*/
		countMap.put("fund",in);
		
		return countMap;
	}

	@Override
	public int changeProj(PubProjProcess process) {
		if(process!=null){
			PubProj proj = readProject(process.getProjFlow());
			if(proj!=null){
				String projStageId = process.getProjStageId();
				if(StringUtil.isNotBlank(projStageId)){
					proj.setProjStageId(projStageId);
					proj.setProjStageName(ProjStageEnum.getNameById(projStageId));
				}
				String projStatusId = process.getProjStatusId();
				if(StringUtil.isNotBlank(projStatusId)){
					proj.setProjStatusId(projStatusId);
					proj.setProjStatusName(GcpProjStatusEnum.getNameById(projStatusId));
				}
				modifyProj(proj);
				process.setProcessFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(process, true);
				process.setProjStageId(proj.getProjStageId());
				process.setProjStageName(proj.getProjStageName());
				process.setProjStatusId(proj.getProjStatusId());
				process.setProjStatusName(proj.getProjStatusName());
				SysUser currUser = GlobalContext.getCurrentUser();
				process.setOperUserFlow(currUser.getUserFlow());
				process.setOperUserName(currUser.getUserName());
				process.setOperOrgFlow(currUser.getOrgFlow());
				process.setOperOrgName(currUser.getOrgName());
				process.setOperTime(DateUtil.getCurrDateTime());
				
				//
				this.projProcessMapper.insertSelective(process);
				
				//
				try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				
				if(GcpProjStatusEnum.Passed.getId().equals(proj.getProjStatusId())){ 
					//项目文件同时审核通过
					PubProjProcess fileProcess = new PubProjProcess();
					fileProcess.setProcessFlow(PkUtil.getUUID());
					fileProcess.setProjFlow(process.getProjFlow());
					fileProcess.setProjStageId(proj.getProjStageId());
					fileProcess.setProjStageName(proj.getProjStageName());
					fileProcess.setProjStatusId(proj.getProjStatusId());
					fileProcess.setProjStatusName(proj.getProjStatusName());
					fileProcess.setOperUserFlow(currUser.getUserFlow());
					fileProcess.setOperUserName(currUser.getUserName());
					fileProcess.setOperOrgFlow(currUser.getOrgFlow());
					fileProcess.setOperOrgName(currUser.getOrgName());
					fileProcess.setOperTime(DateUtil.getCurrDateTime());
					
					fileProcess.setRecTypeName("项目文件");
					fileProcess.setProcessRemark(GcpProjStatusEnum.Passed.getName());
					fileProcess.setRecTypeId("Process");
					GeneralMethod.setRecordInfo(fileProcess, true);
					this.projProcessMapper.insertSelective(fileProcess);
				}
				
				
				return GlobalConstant.ONE_LINE;
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public List<PubProj> searchProjList(PubProj proj) {
		PubProjExample example = new PubProjExample();
		com.pinde.sci.model.mo.PubProjExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(proj.getApplyUserFlow())){
			criteria.andApplyUserFlowEqualTo(proj.getApplyUserFlow());
		}
		if(StringUtil.isNotBlank(proj.getApplyOrgFlow())){
			criteria.andApplyOrgFlowEqualTo(proj.getApplyOrgFlow());
		}
		if(StringUtil.isNotBlank(proj.getProjDeclarerFlow())){
			criteria.andProjDeclarerFlowEqualTo(proj.getProjDeclarerFlow());
		}
		if(StringUtil.isNotBlank(proj.getProjStatusId())){
			criteria.andProjStatusIdEqualTo(proj.getProjStatusId());
		}
		if(StringUtil.isNotBlank(proj.getProjNo())){
			criteria.andProjNoLike("%"+proj.getProjNo()+"%");
		}
		if(StringUtil.isNotBlank(proj.getProjName())){
			criteria.andProjNameLike("%"+proj.getProjName()+"%");
		}
		if(StringUtil.isNotBlank(proj.getProjStageId())){
			if (proj.getProjStageId().indexOf(",") >-1) {
				List<String> projStageIdList = new ArrayList<String>();
				String[] projStageIds  = proj.getProjStageId().split(",");
				projStageIdList = Arrays.asList(projStageIds);
				criteria.andProjStageIdIn(projStageIdList);
			} else {
				criteria.andProjStageIdEqualTo(proj.getProjStageId());
			}
		}
		if(StringUtil.isNotBlank(proj.getProjCategoryId())){
			if (proj.getProjCategoryId().indexOf(",") >-1) {
				List<String> projCategoryIdList = new ArrayList<String>();
				String[] projCategoryIds  = proj.getProjCategoryId().split(",");
				projCategoryIdList = Arrays.asList(projCategoryIds);
				criteria.andProjCategoryIdIn(projCategoryIdList);
			} else {
				criteria.andProjCategoryIdEqualTo(proj.getProjCategoryId());
			}
		}
		if(StringUtil.isNotBlank(proj.getProjSubTypeId())){//期类别
			criteria.andProjSubTypeIdEqualTo(proj.getProjSubTypeId());
		}
		if(StringUtil.isNotBlank(proj.getApplyDeptFlow())){//承担科室
			criteria.andApplyDeptFlowEqualTo(proj.getApplyDeptFlow());
		}
		if(StringUtil.isNotBlank(proj.getProjTypeId())){
			criteria.andProjTypeIdEqualTo(proj.getProjTypeId());
		}
		example.setOrderByClause("CREATE_TIME DESC, PROJ_START_TIME DESC, PROJ_END_TIME");
		return projMapper.selectByExample(example);
	}
	
	@Override
	public List<ProjInfoForm> searchProjFormList(List<String> projFlows){
		List<ProjInfoForm> projFormList = null;
		PubProjExample example = new PubProjExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowIn(projFlows);
		List<PubProj> projList = projMapper.selectByExampleWithBLOBs(example);
		if(projList!=null && projList.size()>0){
			projFormList = new ArrayList<ProjInfoForm>();
			for(PubProj proj : projList){
				ProjInfoForm projForm = new ProjInfoForm();
				String projInfo = proj.getProjInfo();
				proj.setProjInfo(null);
				projForm.setProj(proj);
				if(StringUtil.isNotBlank(projInfo)){
					try{
						Document doc = DocumentHelper.parseText(projInfo);
						Element e = (Element) doc.selectSingleNode("projInfo/generalInfo");
						if(e != null){
							Element registCategoryElement  = e.element("registCategory");
							Element isLeaderElement  = e.element("isLeader");
							Element interMulCenterElement  = e.element("interMulCenter");
							
							projForm.setRegistCategory(registCategoryElement == null ? "" : registCategoryElement.getTextTrim());
							projForm.setIsLeader(isLeaderElement == null ? "" : isLeaderElement.getTextTrim());
							projForm.setInterMulCenter(interMulCenterElement == null ? "" : interMulCenterElement.getTextTrim());
						}
					}catch(Exception ex){
						ex.printStackTrace();
					}
				}
				projFormList.add(projForm);
			}
		}
		return projFormList;
	}
	
	@Override
	public List<ProjInfoForm> searchProjFormList(PubProj proj) throws Exception {
		List<ProjInfoForm> projFormList = null;
		List<PubProj> projList = searchProjList(proj);
		if(projList!=null&&!projList.isEmpty()){
			projFormList = new ArrayList<ProjInfoForm>();
			for (PubProj pubProj : projList) {
				String pFlow = pubProj.getProjFlow();
				ProjInfoForm projInfoForm = this.searchGeneralInfo(pFlow);
				if(projInfoForm!=null){
					projFormList.add(projInfoForm);
				}
			}
		}
		return projFormList;
	}
	
	@Override
	public ProjInfoForm searchGeneralInfo(String projFlow) throws Exception {
		ProjInfoForm projInfoForm = null;
		if(StringUtil.isNotBlank(projFlow)){
			PubProj proj = readProject(projFlow);
			if(proj != null){
				projInfoForm = new ProjInfoForm();
				projInfoForm.setProj(proj);
				String projInfo = proj.getProjInfo();
				if (StringUtil.isNotBlank(projInfo)) {
					Document doc = DocumentHelper.parseText(projInfo);
					Element e = (Element) doc.selectSingleNode("projInfo/generalInfo");
					if(e != null){
						Element registCategoryElement  = e.element("registCategory");
						Element isLeaderElement  = e.element("isLeader");
						Element interMulCenterElement  = e.element("interMulCenter");
						
						projInfoForm.setRegistCategory(registCategoryElement == null ? "" : registCategoryElement.getTextTrim());
						projInfoForm.setIsLeader(isLeaderElement == null ? "" : isLeaderElement.getTextTrim());
						projInfoForm.setInterMulCenter(interMulCenterElement == null ? "" : interMulCenterElement.getTextTrim());
					}
				}
			}
		}
		return projInfoForm;
	}
	
	@Override
	public String addProjInfo(PubProj proj, ProjInfoForm projInfoForm) {
		String projInfo = proj.getProjInfo();
		if(StringUtil.isBlank(projInfo)){ 
			projInfo = "<projInfo/>";
		} 
		Document doc = null;
		try {
			String registCategory = StringUtil.defaultIfEmpty(projInfoForm.getRegistCategory(),""); 
			String isLeader = StringUtil.defaultIfEmpty(projInfoForm.getIsLeader(),""); 
			String interMulCenter = StringUtil.defaultIfEmpty(projInfoForm.getInterMulCenter(),""); 
			
			doc = DocumentHelper.parseText(projInfo);
			Element root = doc.getRootElement();
			Element generalInfoElement = root.element("generalInfo");
			if(generalInfoElement==null){//新增
				generalInfoElement = root.addElement("generalInfo");
			}
			//注册分类
			Element registCategoryElement = generalInfoElement.element("registCategory");
			if (registCategoryElement == null) {
				registCategoryElement = generalInfoElement.addElement("registCategory");
			}
			registCategoryElement.setText(registCategory);
			//组长/参与
			Element isLeaderElement = generalInfoElement.element("isLeader");
			if (isLeaderElement == null) {
				isLeaderElement = generalInfoElement.addElement("isLeader");
			}
			isLeaderElement.setText(isLeader);
			//国际多中心
			Element interMulCenterElement = generalInfoElement.element("interMulCenter");
			if (interMulCenterElement == null) {
				interMulCenterElement = generalInfoElement.addElement("interMulCenter");
			}
			interMulCenterElement.setText(interMulCenter);
			
			return doc.asXML();
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		return projInfo;
	}
	
	@Override
	public int modifyProj(PubProj proj) {
		if(proj != null && StringUtil.isNotBlank(proj.getProjFlow())){
			GeneralMethod.setRecordInfo(proj, false);
			return projMapper.updateByPrimaryKeySelective(proj);
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int addSponsor(PubProj proj, ProjInfoForm projInfoForm) {
		try {
			Document doc = DocumentHelper.parseText(proj.getProjInfo());
			Element root = doc.getRootElement();
			//****************申办者****************
			Element declarerElement = root.element("declarer");
			if(declarerElement==null){//新增
				declarerElement = root.addElement("declarer");
			}
			//申办者地址
			Element declarerAddressElement = declarerElement.element("declarerAddress");
			if (declarerAddressElement == null) {
				declarerAddressElement = declarerElement.addElement("declarerAddress");
			}
			declarerAddressElement.setText(projInfoForm.getDeclarerAddress());
			
			//申办者邮编
			Element declarerZipElement = declarerElement.element("declarerZip");
			if (declarerZipElement == null) {
				declarerZipElement = declarerElement.addElement("declarerZip");
			}
			declarerZipElement.setText(projInfoForm.getDeclarerZip());
			//申办者联系人
			Element dLinkManElement = declarerElement.element("dLinkMan");
			if (dLinkManElement == null) {
				dLinkManElement = declarerElement.addElement("dLinkMan");
			}
			dLinkManElement.setText(projInfoForm.getdLinkMan());
			//申办者联系人手机
			Element dLinkManPhoneElement = declarerElement.element("dLinkManPhone");
			if (dLinkManPhoneElement == null) {
				dLinkManPhoneElement = declarerElement.addElement("dLinkManPhone");
			}
			dLinkManPhoneElement.setText(projInfoForm.getdLinkManPhone());
			//申办者联系人邮箱
			Element dLinkManEmailElement = declarerElement.element("dLinkManEmail");
			if (dLinkManEmailElement == null) {
				dLinkManEmailElement = declarerElement.addElement("dLinkManEmail");
			}
			dLinkManEmailElement.setText(projInfoForm.getdLinkManEmail());
			
			//****************CRO****************
			Element CROElement = root.element("CRO");
			if(CROElement==null){//新增
				CROElement = root.addElement("CRO");
			}
			//CRO名称
			Element CRONameElement = CROElement.element("CROName");
			if (CRONameElement == null) {
				CRONameElement = CROElement.addElement("CROName");
			}
			CRONameElement.setText(projInfoForm.getCROName());
			//CRO法人代表
			Element CROLegalRepresentElement = CROElement.element("CROLegalRepresent");
			if (CROLegalRepresentElement == null) {
				CROLegalRepresentElement = CROElement.addElement("CROLegalRepresent");
			}
			CROLegalRepresentElement.setText(projInfoForm.getCROLegalRepresent());
			//CRO地址
			Element CROAddressElement = CROElement.element("CROAddress");
			if (CROAddressElement == null) {
				CROAddressElement = CROElement.addElement("CROAddress");
			}
			CROAddressElement.setText(projInfoForm.getCROAddress());
			//CRO邮编
			Element CROZipElement = CROElement.element("CROZip");
			if (CROZipElement == null) {
				CROZipElement = CROElement.addElement("CROZip");
			}
			CROZipElement.setText(projInfoForm.getCROZip());
			//CRO联系人
			Element CROLinkManElement = CROElement.element("CROLinkMan");
			if (CROLinkManElement == null) {
				CROLinkManElement = CROElement.addElement("CROLinkMan");
			}
			CROLinkManElement.setText(projInfoForm.getCROLinkMan());
			//CRO联系人手机
			Element CROLinkManPhoneElement = CROElement.element("CROLinkManPhone");
			if (CROLinkManPhoneElement == null) {
				CROLinkManPhoneElement = CROElement.addElement("CROLinkManPhone");
			}
			CROLinkManPhoneElement.setText(projInfoForm.getCROLinkManPhone());
			//CRO联系人邮箱
			Element CROLinkManEmailElement = CROElement.element("CROLinkManEmail");
			if (CROLinkManEmailElement == null) {
				CROLinkManEmailElement = CROElement.addElement("CROLinkManEmail");
			}
			CROLinkManEmailElement.setText(projInfoForm.getCROLinkManEmail());
			
			String projInfo = doc.asXML();
			proj.setProjInfo(projInfo);
			
			return modifyProj(proj);
			
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		return GlobalConstant.ZERO_LINE;
	}

	
	
	@Override
	public ProjInfoForm searchDeclarerAndCRO(String projFlow) throws Exception {
		ProjInfoForm projInfoForm = null;
		if(StringUtil.isNotBlank(projFlow)){
			PubProj proj = readProject(projFlow);
			if(proj != null && StringUtil.isNotBlank(proj.getProjInfo())){
				projInfoForm = new ProjInfoForm();
				projInfoForm.setProj(proj);
				Document doc = DocumentHelper.parseText(proj.getProjInfo());
				Element de = (Element) doc.selectSingleNode("projInfo/declarer");
				if(de != null){
					Element declarerAddressElement  = de.element("declarerAddress");
					Element declarerZipElement  = de.element("declarerZip");
					Element dLinkManElement  = de.element("dLinkMan");
					Element dLinkManPhoneElement  = de.element("dLinkManPhone");
					Element dLinkManEmailElement  = de.element("dLinkManEmail");
					
					projInfoForm.setDeclarerAddress(declarerAddressElement == null ? "" : declarerAddressElement.getTextTrim());
					projInfoForm.setDeclarerZip(declarerZipElement == null ? "" : declarerZipElement.getTextTrim());
					projInfoForm.setdLinkMan(dLinkManElement == null ? "" : dLinkManElement.getTextTrim());
					projInfoForm.setdLinkManPhone(dLinkManPhoneElement == null ? "" : dLinkManPhoneElement.getTextTrim());
					projInfoForm.setdLinkManEmail(dLinkManEmailElement == null ? "" : dLinkManEmailElement.getTextTrim());
				}
				Element ce = (Element) doc.selectSingleNode("projInfo/CRO");
				if(ce != null){
					Element CRONameElement  = ce.element("CROName");
					Element CROLegalRepresentElement  = ce.element("CROLegalRepresent");
					Element CROAddressElement  = ce.element("CROAddress");
					Element CROZipElement  = ce.element("CROZip");
					Element CROLinkManElement  = ce.element("CROLinkMan");
					Element CROLinkManPhoneElement  = ce.element("CROLinkManPhone");
					Element CROLinkManEmailElement  = ce.element("CROLinkManEmail");
					 
					projInfoForm.setCROName(CRONameElement == null ? "" : CRONameElement.getTextTrim());
					projInfoForm.setCROLegalRepresent(CROLegalRepresentElement == null ? "" :CROLegalRepresentElement.getTextTrim());
					projInfoForm.setCROAddress(CROAddressElement == null ? "" : CROAddressElement.getTextTrim());
					projInfoForm.setCROZip(CROZipElement == null ? "" : CROZipElement.getTextTrim());
					projInfoForm.setCROLinkMan(CROLinkManElement == null ? "" : CROLinkManElement.getTextTrim());
					projInfoForm.setCROLinkManPhone(CROLinkManPhoneElement == null ? "" : CROLinkManPhoneElement.getTextTrim());
					projInfoForm.setCROLinkManEmail(CROLinkManEmailElement == null ? "" : CROLinkManEmailElement.getTextTrim());
				}
			}
		}
		return projInfoForm;
	}

	@Override
	public int addResearchOrg(ProjOrgForm projOrgForm, String projFlow) {
		if(projOrgForm != null){
			 List<PubProjOrg> pbuProjOrgList = projOrgForm.getProjOrgList();
			 for(PubProjOrg org : pbuProjOrgList){
				 if (StringUtil.isNotBlank(org.getOrgTypeId())) {
					 org.setOrgTypeName(ProjOrgTypeEnum.getNameById(org.getOrgTypeId()));
				 }
				 if(StringUtil.isNotBlank(org.getRecordFlow())){//修改
					 GeneralMethod.setRecordInfo(org, false);
					 projOrgMapper.updateByPrimaryKeySelective(org);
				 }else{//新增
					 org.setRecordFlow(PkUtil.getUUID());
					 org.setProjFlow(projFlow);
					 GeneralMethod.setRecordInfo(org, true);
					 projOrgMapper.insert(org);
				 }
			 }
		}
		
		if(StringUtil.isNotBlank(projFlow)){
			PubProj proj = readProject(projFlow);
			if(proj != null && StringUtil.isNotBlank(proj.getProjInfo())){
				try {
					Document doc = DocumentHelper.parseText(proj.getProjInfo());
					Element root = doc.getRootElement();
					//****************临床试验负责单位****************
					Element projOrgElement = root.element("projOrg");
					if(projOrgElement==null){//新增
						projOrgElement = root.addElement("projOrg");
					}
					Element leaderOrgElement = projOrgElement.element("leaderOrg");
					if (leaderOrgElement == null) {
						leaderOrgElement = projOrgElement.addElement("leaderOrg");
					}
					leaderOrgElement.setText(projOrgForm.getLeaderOrg());
					//联系人
					Element leaderOrgLinkManElement = projOrgElement.element("leaderOrgLinkMan");
					if (leaderOrgLinkManElement == null) {
						leaderOrgLinkManElement = projOrgElement.addElement("leaderOrgLinkMan");
					}
					leaderOrgLinkManElement.setText(projOrgForm.getLeaderOrgLinkMan());
					//联系电话
					Element leaderOrgLinkManPhoneElement = projOrgElement.element("leaderOrgLinkManPhone");
					if (leaderOrgLinkManPhoneElement == null) {
						leaderOrgLinkManPhoneElement = projOrgElement.addElement("leaderOrgLinkManPhone");
					}
					leaderOrgLinkManPhoneElement.setText(projOrgForm.getLeaderOrgLinkManPhone());
					String projInfo = doc.asXML();
					proj.setProjInfo(projInfo);
					
					return modifyProj(proj);
					
				} catch (DocumentException e) {
					e.printStackTrace();
				}
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public ProjOrgForm searchLeader(String projFlow) throws Exception {
		ProjOrgForm projOrgForm = null;
		if(StringUtil.isNotBlank(projFlow)){
			PubProj proj = readProject(projFlow);
			if(proj != null && StringUtil.isNotBlank(proj.getProjInfo())){
				projOrgForm = new ProjOrgForm();
				Document doc = DocumentHelper.parseText(proj.getProjInfo());
				Element oe = (Element) doc.selectSingleNode("/projInfo/projOrg");
				if(oe != null){
					Element leaderOrgElement  = oe.element("leaderOrg");
					Element leaderOrgLinkManElement  = oe.element("leaderOrgLinkMan");
					Element leaderOrgLinkManPhoneElement  = oe.element("leaderOrgLinkManPhone");
					
					projOrgForm.setLeaderOrg(leaderOrgElement == null ? "" : leaderOrgElement.getTextTrim());
					projOrgForm.setLeaderOrgLinkMan(leaderOrgLinkManElement == null ? "" : leaderOrgLinkManElement.getTextTrim());
					projOrgForm.setLeaderOrgLinkManPhone(leaderOrgLinkManPhoneElement == null ? "" : leaderOrgLinkManPhoneElement.getTextTrim());
				}
			}
		}
		return projOrgForm;
	}

	@Override
	public int saveProjAndProjUser(PubProj proj, PubProjUser projUser) {
		if(proj != null){
			if(StringUtil.isBlank(proj.getProjFlow())){//新增
				String projFlow = PkUtil.getUUID();
				proj.setProjFlow(projFlow);
				GeneralMethod.setRecordInfo(proj, true);
				projMapper.insert(proj);
				
				if (projUser != null) {
					projUser.setProjFlow(projFlow);
					projUser.setRecordFlow(PkUtil.getUUID());
					GeneralMethod.setRecordInfo(projUser, true);
					projUserMapper.insert(projUser);
				}
			}else{//修改
				GeneralMethod.setRecordInfo(proj, false);
				projMapper.updateByPrimaryKeySelective(proj);
				
				if (projUser != null) {
					projUser.setProjFlow(proj.getProjFlow());
					GeneralMethod.setRecordInfo(projUser, false);
					projUserMapper.updateByPrimaryKeySelective(projUser);
				}
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int saveMonitor(List<GCPMonitorForm> monitorFormList, String projFlow) throws Exception {
		if(monitorFormList != null && !monitorFormList.isEmpty() && StringUtil.isNotBlank(projFlow) ){
			PubProj proj = readProject(projFlow);
			if(proj != null){
				Document dom = DocumentHelper.parseText(proj.getProjInfo());
				Element root = dom.getRootElement();
				
				Element monitorsElement = root.element("monitors");
				if(monitorsElement == null){
					monitorsElement = root.addElement("monitors");
				}
				for(GCPMonitorForm monitorForm : monitorFormList){
					String id = StringUtil.defaultIfEmpty(monitorForm.getId(),"");
					String name = StringUtil.defaultIfEmpty(monitorForm.getName(),"");
					String identityCardNo = StringUtil.defaultIfEmpty(monitorForm.getIdentityCardNo(),"");
					String phone = StringUtil.defaultIfEmpty(monitorForm.getPhone(),"");
					String email = StringUtil.defaultIfEmpty(monitorForm.getEmail(),"");
					String isGCPTrain = StringUtil.defaultIfEmpty(monitorForm.getIsGCPTrain(),"");
					
					if(StringUtil.isNotBlank(id)){//修改monitor节点
						String monitorXpath = "//monitor[@id='"+id+"']";
						Element monitorElement = (Element) dom.selectSingleNode(monitorXpath);
						if(monitorElement != null){
							Element nameElement = monitorElement.element("name");
							nameElement.setText(name);
							Element identityCardNoElement = monitorElement.element("identityCardNo");
							identityCardNoElement.setText(identityCardNo);
							Element phoneElement = monitorElement.element("phone");
							phoneElement.setText(phone);
							Element emailElement = monitorElement.element("email");
							emailElement.setText(email);
							Element isGCPTrainElement = monitorElement.element("isGCPTrain");
							isGCPTrainElement.setText(isGCPTrain);
						}
					}else{//新增monitor节点
						Element monitorElement = monitorsElement.addElement("monitor");
						monitorElement.addAttribute("id", PkUtil.getUUID());
						Element nameElement = monitorElement.addElement("name");
						nameElement.setText(name);
						Element identityCardNoElement = monitorElement.addElement("identityCardNo");
						identityCardNoElement.setText(identityCardNo);
						Element phoneElement = monitorElement.addElement("phone");
						phoneElement.setText(phone);
						Element emailElement = monitorElement.addElement("email");
						emailElement.setText(email);
						Element isGCPTrainElement = monitorElement.addElement("isGCPTrain");
						isGCPTrainElement.setText(isGCPTrain);
					}
				}
				String projInfo = dom.asXML();
				proj.setProjInfo(projInfo);
				return modifyProj(proj);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GCPMonitorForm> searchMonitor(String projFlow) throws Exception {
		List<GCPMonitorForm> monitorFormList = null;
		if(StringUtil.isNotBlank(projFlow)){
			PubProj proj = readProject(projFlow);
			if(proj != null && StringUtil.isNotBlank(proj.getProjInfo())){
				monitorFormList = new ArrayList<GCPMonitorForm>();
				Document dom = DocumentHelper.parseText(proj.getProjInfo());
				List<Element> monitorElements = dom.selectNodes("//monitor");
				if(monitorElements != null && !monitorElements.isEmpty()){
					for (Element me : monitorElements) {
						GCPMonitorForm monitorForm = new GCPMonitorForm();
						monitorForm.setId(me.attributeValue("id"));
						monitorForm.setName(me.element("name") == null ? "" : me.element("name").getTextTrim());
						monitorForm.setIdentityCardNo(me.element("identityCardNo") == null ? "" : me.element("identityCardNo").getTextTrim());
						monitorForm.setPhone(me.element("phone") == null ? "" : me.element("phone").getTextTrim());
						monitorForm.setEmail(me.element("email") == null ? "" : me.element("email").getTextTrim());
						monitorForm.setIsGCPTrain(me.element("isGCPTrain") == null ? "" : me.element("isGCPTrain").getTextTrim());
						monitorFormList.add(monitorForm);
					}
				}
			}
		}
		return monitorFormList;
	}

	@Override
	public int delMonitorByIds(String[] ids, String projFlow) throws Exception {
		if(ids.length > 0 && StringUtil.isNotBlank(projFlow)){
			PubProj proj = readProject(projFlow);
			if(proj != null){
				Document dom = DocumentHelper.parseText(proj.getProjInfo());
				for(String id : ids){
					String monitorXpath = "//monitor[@id='"+id+"']";
					Element monitorElement = (Element) dom.selectSingleNode(monitorXpath);
					monitorElement.getParent().remove(monitorElement);
				}
				String projInfo = dom.asXML();
				proj.setProjInfo(projInfo);
				return modifyProj(proj);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<PubProjProcess> optionList(String projFlow) {
		List<PubProjProcess> processList = null;
		if(StringUtil.isNotBlank(projFlow)){
			PubProjProcessExample example = new PubProjProcessExample();
			example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
			                        .andProjFlowEqualTo(projFlow).andRecTypeIdEqualTo("Audit");
			example.setOrderByClause("oper_time desc");
			processList = this.projProcessMapper.selectByExample(example);
		}
		return processList;
	}

	@Override
	public Map<String, String> searchGcpTrainDate(List<SysUser> userList) {
		Map<String, String> trainDateMap = null;
		if(userList!=null&&!userList.isEmpty()){
			List<String> userFlows = new ArrayList<String>();
			for (SysUser user : userList) {
				userFlows.add(user.getUserFlow());
			}
			List<PubTrainUserExt> trainList = this.pubTrainUserExtMapper.selectGcpList(userFlows);
			if(trainList!=null&&!trainList.isEmpty()){
				trainDateMap = new LinkedHashMap<String, String>();
				for (PubTrainUserExt user : trainList) {
					trainDateMap.put(user.getUserFlow(), user.getTrainDate());
				}
			}
		}
		return trainDateMap;
	}

	@Override
	public int count(PubProj proj) {
		PubProjExample example = new PubProjExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(proj!=null){
			if(StringUtil.isNotBlank(proj.getApplyOrgFlow())){
				criteria.andApplyOrgFlowEqualTo(proj.getApplyOrgFlow());
			}
			if(StringUtil.isNotBlank(proj.getProjCategoryId())){
				criteria.andProjCategoryIdEqualTo(proj.getProjCategoryId());
			}
			if(StringUtil.isNotBlank(proj.getProjStageId())){
				criteria.andProjStageIdEqualTo(proj.getProjStageId());
			}
			if(StringUtil.isNotBlank(proj.getProjStatusId())){
				criteria.andProjStatusIdEqualTo(proj.getProjStatusId());
			}
			if(StringUtil.isNotBlank(proj.getApplyDeptFlow())){
				criteria.andApplyDeptFlowEqualTo(proj.getApplyDeptFlow());
			}
		}
		return this.projMapper.countByExample(example);
	}

	@Override
	public Map<String, Integer> countOrgProj(String orgFlow) {
		Map<String, Integer> countMap = null;
		if(StringUtil.isNotBlank(orgFlow)){
			countMap = new HashMap<String, Integer>();
			PubProj proj = new PubProj();
			proj.setProjStatusId(GcpProjStatusEnum.Passed.getId());
			proj.setApplyOrgFlow(orgFlow);
			/*科研*/
			proj.setProjCategoryId(ProjCategroyEnum.Ky.getId());
			int ky = this.count(proj);
			countMap.put(ProjCategroyEnum.Ky.getId(), ky);
			/*药物*/
			proj.setProjCategoryId(ProjCategroyEnum.Yw.getId());
			int yw = this.count(proj);
			countMap.put(ProjCategroyEnum.Yw.getId(), yw);
			/*器械*/
			proj.setProjCategoryId(ProjCategroyEnum.Qx.getId());
			int qx = this.count(proj);
			countMap.put(ProjCategroyEnum.Qx.getId(), qx);
		}
		return countMap;
	}

	@Override
	public Map<String, Object> countOrgData(String orgFlow) {
		Map<String, Object> countMap = null;
		if(StringUtil.isNotBlank(orgFlow)){
			countMap = new HashMap<String, Object>();
			/*待伦理审查(初审)*/
			PubProj proj = new PubProj();
			proj.setApplyOrgFlow(orgFlow);
			/*int projTotal = this.count(proj);//总项目数
			int irbTotal = this.irbApplyBiz.queryIrbApplyCount(orgFlow);
			countMap.put("irb", projTotal-irbTotal);*/
			/*准备、实施、结束阶段*/
			proj.setProjStatusId(GcpProjStatusEnum.Passed.getId());
			for (GcpProjStageEnum sEnum : GcpProjStageEnum.values()) {
				proj.setProjStageId(sEnum.getId());
				int sCount = this.count(proj);
				countMap.put(sEnum.getId(), sCount);
			}
			/**/
			/*完成入组数*/
			/*PubPatient patient = new PubPatient();
			patient.setOrgFlow(orgFlow);
			patient.setInDate(GlobalConstant.FLAG_Y);
			patient.setPatientTypeId(PatientTypeEnum.Real.getId());
			int inDateCount = this.patientBiz.countPatient(patient);
			countMap.put("inDate", inDateCount);*/
			/*机构余额*/
			GcpFund gcpFund = new GcpFund();
			gcpFund.setOrgFlow(orgFlow);
			gcpFund.setFundTypeId(GcpFundTypeEnum.In.getId());
			BigDecimal in = this.gcpFinBiz.searchSumFund(gcpFund);//总到账
			if(in==null){
				in = new BigDecimal(0);
			}
			gcpFund.setFundTypeId(GcpFundTypeEnum.Out.getId());
			BigDecimal out = this.gcpFinBiz.searchSumFund(gcpFund);//总支出
			if(out==null){
				out = new BigDecimal(0);
			}
			countMap.put("fund", in.subtract(out));
		}
		return countMap;
	}

	@Override
	public int saveResearcher(String userFlow, String projFlow, String deptFlow) {
		PubProj proj = readProject(projFlow);
		if(proj!=null){
			String oldUserFlow = proj.getApplyUserFlow();
			SysUser user = this.userBiz.readSysUser(userFlow);
			if(user!=null){
				proj.setApplyUserFlow(userFlow);
				proj.setApplyUserName(user.getUserName());
			}
			SysDept dept = this.deptBiz.readSysDept(deptFlow);
			if(dept!=null){
				proj.setApplyDeptFlow(deptFlow);
				proj.setApplyDeptName(dept.getDeptName());
			}
			this.projMapper.updateByPrimaryKeySelective(proj);
			if(StringUtil.isNotBlank(oldUserFlow)&&!oldUserFlow.equals(userFlow)){//删除之前保存的
				PubProjUserExample example = new PubProjUserExample();
				example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andUserFlowEqualTo(oldUserFlow)
				                        .andProjFlowEqualTo(projFlow).andRoleFlowEqualTo(InitConfig.getSysCfg(GlobalConstant.RESEARCHER_ROLE_FLOW));
				List<PubProjUser> projUserList = this.projUserMapper.selectByExample(example);
				if(projUserList != null && !projUserList.isEmpty()){
					PubProjUser oldProjUser = projUserList.get(0);
					oldProjUser.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
					this.projUserMapper.updateByPrimaryKeySelective(oldProjUser);
				}
			}
			PubProjUserExample example = new PubProjUserExample();
			example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andUserFlowEqualTo(userFlow)
			                        .andProjFlowEqualTo(projFlow).andRoleFlowEqualTo(InitConfig.getSysCfg(GlobalConstant.RESEARCHER_ROLE_FLOW));
			List<PubProjUser> projUserList = this.projUserMapper.selectByExample(example);
			if(projUserList == null || projUserList.isEmpty()){//项目成员中没有保存为主要研究者
				PubProjUser projUser = new PubProjUser();
				projUser.setRecordFlow(PkUtil.getUUID());
				projUser.setProjFlow(projFlow);
				projUser.setUserFlow(userFlow);
				if(user!=null){
					projUser.setOrgFlow(user.getOrgFlow());
				}
				projUser.setRoleFlow(InitConfig.getSysCfg(GlobalConstant.RESEARCHER_ROLE_FLOW));
				projUser.setAuthUserFlow(GlobalContext.getCurrentUser().getUserFlow());
				projUser.setAuthTime(DateUtil.getCurrDateTime());
				GeneralMethod.setRecordInfo(projUser, true);
				this.projUserMapper.insertSelective(projUser);
				}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}

	@SuppressWarnings("unchecked")
	@Override
	public int saveArchiveToRec(List<GcpCfgFileForm> fileFormList,GcpRec gcpRec) throws DocumentException {
		Document dom = null;
		Element archiveElement = null;
		
			if(StringUtil.isBlank(gcpRec.getRecContent())){
				dom = DocumentHelper.createDocument();
				archiveElement = dom.addElement("archive");
				for(GcpProjStageEnum enums : GcpProjStageEnum.values()){
					Element stageElement = archiveElement.addElement("stage");
					stageElement.addAttribute("id", enums.getId());
					for(GcpCfgFileForm fileForm:fileFormList){
						   if(fileForm.getStage().equals(enums.getId())){
							   Element fileElement=stageElement.addElement("file");
							   fileElement.addAttribute("id", fileForm.getId());
							   fileElement.addElement("fileName").setText(fileForm.getFileName());
						   }
						}
				}
				gcpRec.setRecContent(dom.asXML());
			    gcpRec.setRecFlow(PkUtil.getUUID());
			    GeneralMethod.setRecordInfo(gcpRec, true);
			    return gcpRecMapper.insertSelective(gcpRec);
			}else{
			dom=DocumentHelper.parseText(gcpRec.getRecContent());
			List<Element> stageNodeList=dom.selectNodes("/archive//stage");
			for(Element stageElement:stageNodeList){
				for(GcpCfgFileForm fileForm:fileFormList){
					if(fileForm.getStage().equals(stageElement.attributeValue("id"))){
						Element fileElement=stageElement.addElement("file");
						 fileElement.addAttribute("id", fileForm.getId());
						 fileElement.addElement("fileName").setText(fileForm.getFileName());
					}
					
				}
			}
			gcpRec.setRecContent(dom.asXML());
			GeneralMethod.setRecordInfo(gcpRec, false);
			return gcpRecMapper.updateByPrimaryKeyWithBLOBs(gcpRec);
		}
		 
	}
	
	@Override
	public List<PubProj> queryTerminateProjList() {
		Map<String,String> terminateId = new HashMap<String, String>();
		terminateId.put("projStatusId", GcpProjStatusEnum.NoPassed.getId());
		terminateId.put("projStageId", GcpProjStageEnum.Terminate.getId());
		return pubProjExtMapper.selectTerminateProj(terminateId);
	} 
	
	@Override
	public Map<String,ProjInfoForm> projInfoFormMap(List<PubProj> projList) throws Exception {
		ProjInfoForm projInfoForm = null;
		Map<String,ProjInfoForm> projInfoFormMap = new HashMap<String,ProjInfoForm>();
		if (projList != null && projList.size() > 0) {
			for (PubProj temp:projList) {
				String projFlow = temp.getProjFlow();
				PubProj proj = readProject(projFlow);
				if(proj != null){
					projInfoForm = new ProjInfoForm();
					String projInfo = proj.getProjInfo();
					if (StringUtil.isNotBlank(projInfo)) {
						Document doc = DocumentHelper.parseText(projInfo);
						Element e = (Element) doc.selectSingleNode("projInfo/generalInfo");
						if(e != null){
							Element registCategoryElement  = e.element("registCategory");
							Element isLeaderElement  = e.element("isLeader");
							Element interMulCenterElement  = e.element("interMulCenter");
							
							projInfoForm.setRegistCategory(registCategoryElement == null ? "" : registCategoryElement.getTextTrim());
							projInfoForm.setIsLeader(isLeaderElement == null ? "" : isLeaderElement.getTextTrim());
							projInfoForm.setInterMulCenter(interMulCenterElement == null ? "" : interMulCenterElement.getTextTrim());
						}
					}
				}
				projInfoFormMap.put(projFlow, projInfoForm);
			}
		}
		return projInfoFormMap;
	}

	@Override
	public List<PubProjProcess> searchProjProcess(String projFlow) {
		List<PubProjProcess> processList = null;
		if(StringUtil.isNotBlank(projFlow)){
			PubProjProcessExample example = new PubProjProcessExample();
			example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
			                        .andProjFlowEqualTo(projFlow);
			example.setOrderByClause("oper_time");
			processList = this.projProcessMapper.selectByExample(example);
		}
		return processList;
	}


	@Override
	public void saveProcess(PubProjProcess process) {
		projProcessMapper.insertSelective(process);
	}

	@Override
	public List<PubProjProcess> searchProjProcessExample(PubProjProcessExample example) {
		return projProcessMapper.selectByExample(example);
	}

}
