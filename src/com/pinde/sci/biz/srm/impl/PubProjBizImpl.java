package com.pinde.sci.biz.srm.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.jspform.ItemGroupData;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.dao.pub.PubProjExtMapper;
import com.pinde.sci.enums.edc.PatientTypeEnum;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientExample;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjExample;
import com.pinde.sci.model.srm.PubProjExt;
import com.pinde.sci.model.srm.ReportForm;

@Service
@Transactional(rollbackFor=Exception.class)
public class PubProjBizImpl implements IPubProjBiz{

	@Resource
	private PubProjExtMapper pubProjExtMapper;
	@Resource
	private PubProjMapper projMapper;
	@Autowired
	private IFileBiz fileBiz;
	@Autowired
	private IPubPatientBiz patientBiz;


	
	@Override
	public void modProject(PubProj proj) {
		GeneralMethod.setRecordInfo(proj, false);
		this.projMapper.updateByPrimaryKeySelective(proj);
		
	}

	@Override
	public PubProj readProject(String projFlow) {
		return projMapper.selectByPrimaryKey(projFlow);
	}
	
	@Override
	public PubProj readProjectNoBlogs(String projFlow) {
		PubProj proj = null;
		PubProjExample example = new PubProjExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow);
		List<PubProj> list = projMapper.selectByExample(example);
		if (list != null) {
			proj = list.get(0);
		}
		return proj;
	}

	@Override
	public List<PubProj> searchPubProjList(PubProj proj) {
		return this.pubProjExtMapper.selectCommonProjList(proj);
	}
	
	public List<PubProj> searchPubProjListForFundPlan(Map<Object , Object> paramMap){
		return this.pubProjExtMapper.selectProjListForFundPlan(paramMap);
	}

	@Override
	public List<PubProj> queryProjList(PubProj proj) {
		PubProjExample example = new PubProjExample();
		com.pinde.sci.model.mo.PubProjExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(proj.getProjName())){
			criteria.andProjNameLike("%"+ proj.getProjName() +"%");
		}
		if(StringUtil.isNotBlank(proj.getProjShortName())){
			criteria.andProjShortNameLike("%"+ proj.getProjShortName() +"%");
		}
		if(StringUtil.isNotBlank(proj.getProjNo())){
			criteria.andProjNoLike("%"+ proj.getProjNo() +"%");
		}
		if(StringUtil.isNotBlank(proj.getApplyUserFlow())){
			criteria.andApplyUserFlowEqualTo(proj.getApplyUserFlow());
		}
		if(StringUtil.isNotBlank(proj.getApplyUserName())){
			criteria.andApplyUserNameLike("%" + proj.getApplyUserName() + "%");
		}
		if(StringUtil.isNotBlank(proj.getApplyDeptName())){
			criteria.andApplyDeptNameLike("%" + proj.getApplyDeptName()+ "%");
		}
		
		if(StringUtil.isNotBlank(proj.getProjStageId())){//阶段
			List<String> projStageIdList = new ArrayList<String>();
			String[] projStageIds  = proj.getProjStageId().split(",");
			projStageIdList = Arrays.asList(projStageIds);
			criteria.andProjStageIdIn(projStageIdList);
		}
		if(StringUtil.isNotBlank(proj.getProjCategoryId())){//类别 
			List<String> projCategoryIdList = new ArrayList<String>();
			String[] projCategoryIds  = proj.getProjCategoryId().split(",");
			projCategoryIdList = Arrays.asList(projCategoryIds);
			criteria.andProjCategoryIdIn(projCategoryIdList);
		}
		if(StringUtil.isNotBlank(proj.getProjSubTypeId())){//期类别
			criteria.andProjSubTypeIdEqualTo(proj.getProjSubTypeId());
		}
		if(StringUtil.isNotBlank(proj.getApplyOrgFlow())){//机构
			criteria.andApplyOrgFlowEqualTo(proj.getApplyOrgFlow());
		}
		if(StringUtil.isNotBlank(proj.getApplyDeptFlow())){//承担科室
			criteria.andApplyDeptFlowEqualTo(proj.getApplyDeptFlow());
		}
		if(StringUtil.isNotBlank(proj.getProjStatusId())){//状态
			criteria.andProjStatusIdEqualTo(proj.getProjStatusId());
		}
		if(StringUtil.isNotBlank(proj.getProjTypeId())){
			criteria.andProjTypeIdEqualTo(proj.getProjTypeId());
		}
		example.setOrderByClause("CREATE_TIME DESC, PROJ_START_TIME DESC, PROJ_END_TIME");
		return projMapper.selectByExample(example);
	}
	
	@Override
	public List<PubProj> searchProjByProjFlows(List<String> projFlows) {
		return this.pubProjExtMapper.searchProjByProjFlows(projFlows);
	}

	@Override
	public List<String> getFileFlows(Map<String, Object> resultMap) {
		List<String> fileFlows = new ArrayList<String>();
		Object isFileObj = resultMap.get(GlobalConstant.IS_FILE);
		if(isFileObj instanceof String){
			if(StringUtil.isNotBlank(isFileObj.toString())){
			fileFlows.add(isFileObj.toString());
			}
		}else if(isFileObj instanceof List){
			for(String str:(List<String>)isFileObj){
				if(StringUtil.isNotBlank(str)){
					fileFlows.add(str);
				}
			}
		}
		
		for(Entry<String, Object> entry:resultMap.entrySet()){
			Object obj = entry.getValue();
			if(obj instanceof List){
				List<?> list = (List<?>)obj; 
				if(list==null ||list.isEmpty()){
					continue;
				}
				for(Object itemObj:list){
					if(itemObj instanceof ItemGroupData){
						ItemGroupData itemGroupData = (ItemGroupData)itemObj;
						Map<String , Object> objMap = itemGroupData.getObjMap();
						if(objMap!=null){
							Object fileObj = (Object)objMap.get(GlobalConstant.IS_FILE);
							if(fileObj instanceof String){
							  if(StringUtil.isNotBlank(fileObj.toString())){
								fileFlows.add(fileObj.toString());
							  }
							}else if(fileObj instanceof List){
								for(String str:(List<String>)fileObj){
									if(StringUtil.isNotBlank(str)){
										fileFlows.add(str);
									}
									}
								
							}
						}
						
					}
				}
				
			}
		}
		return fileFlows;
	}
	
	public Map<String , PubFile> getFile(Map<String , Object> resultMap){
		Map<String , PubFile> pageFileMap = null;
		 List<String> fileFlows = this.getFileFlows(resultMap);
		if(fileFlows!=null &&  !fileFlows.isEmpty()){
			pageFileMap = new HashMap<String, PubFile>();
			List<PubFile> fileList = this.fileBiz.searchFile(fileFlows);
			for(PubFile file:fileList){
				pageFileMap.put(file.getFileFlow(), file);
			}
	  }	
		return pageFileMap;
	}

	@Override
	public List<PubProj> searchProjListWithBlob(PubProj proj) {
		PubProjExample example = new PubProjExample();
		com.pinde.sci.model.mo.PubProjExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(proj.getApplyUserFlow())){
			criteria.andApplyUserFlowEqualTo(proj.getApplyUserFlow());
		}
		if(StringUtil.isNotBlank(proj.getApplyOrgFlow())){
			criteria.andApplyOrgFlowEqualTo(proj.getApplyOrgFlow());
		}
		if(StringUtil.isNotBlank(proj.getProjStatusId())){
			criteria.andProjStatusIdEqualTo(proj.getProjStatusId());
		}
		if(StringUtil.isNotBlank(proj.getProjStageId())){
			criteria.andProjStageIdEqualTo(proj.getProjStageId());
		}
		if(StringUtil.isNotBlank(proj.getProjNo())){
			criteria.andProjNoLike("%"+proj.getProjNo()+"%");
		}
		if(StringUtil.isNotBlank(proj.getProjName())){
			criteria.andProjNameLike("%"+proj.getProjName()+"%");
		}
		if(StringUtil.isNotBlank(proj.getProjCategoryId())){
			criteria.andProjCategoryIdEqualTo(proj.getProjCategoryId());
		}
		example.setOrderByClause("CREATE_TIME DESC, PROJ_START_TIME DESC, PROJ_END_TIME");
		return projMapper.selectByExampleWithBLOBs(example);
	}

	@Override
	public List<PubProj> queryProjList(PubProjExt projExt) {
		if(projExt!=null&&StringUtil.isNotBlank(projExt.getKeyword())){
			projExt.setKeyword("%"+projExt.getKeyword()+"%");
		}
		return  pubProjExtMapper.selectList(projExt);
	}

	@Override
	public List<ReportForm> findReportForm(PubProj proj) {
      String[] factors = new String[]{"applyCount" , "evalCount" , "approveCount" , "notApproveCount"};
      List<ReportForm> resultReportForm = new ArrayList<ReportForm>();
      Map<String , ReportForm> tempMap = new HashMap<String, ReportForm>();
      for(String factor:factors){
    	  List<ReportForm> reportForms = findReportForm(proj ,factor);
    	  for(ReportForm form:reportForms){
    		  String orgFlow = form.getOrgFlow();
    		  if(tempMap.containsKey(orgFlow)){
                  ReportForm existsForm = tempMap.get(orgFlow);
                  if(factor.equals(factors[0])){
                	  existsForm.setApplyCount(form.getProjCount());
                  }else if(factor.equals(factors[1])){
                	  existsForm.setEvalCount(form.getProjCount());
                  }else if(factor.equals(factors[2])){
                	  existsForm.setApproveCount(form.getProjCount());
                  }else if(factor.equals(factors[3])){
                	  existsForm.setNotApproveCount(form.getProjCount());
                  }
    		  }else{
    			  ReportForm newForm = new ReportForm();
    			  newForm.setOrgFlow(form.getOrgFlow());
    			  newForm.setOrgName(form.getOrgName());
    			  if(factor.equals(factors[0])){
    				  newForm.setApplyCount(form.getProjCount());
                  }else if(factor.equals(factors[1])){
                	  newForm.setEvalCount(form.getProjCount());
                  }else if(factor.equals(factors[2])){
                	  newForm.setApproveCount(form.getProjCount());
                  }else if(factor.equals(factors[3])){
                	  newForm.setNotApproveCount(form.getProjCount());
                  }
    			  tempMap.put(orgFlow, newForm);
    		  }
    	  }
      }
        resultReportForm.addAll(tempMap.values());
        //计算立项比例
//        for(ReportForm report:resultReportForm){
//        	if(report.getEvalCount()!=null && report.getEvalCount()!=0){
//        		BigDecimal tmpApproveCount = new BigDecimal(report.getApproveCount());
//        		BigDecimal tmpEvalCount = new BigDecimal(report.getEvalCount());
//        		BigDecimal tempScale = tmpApproveCount.divide(tmpEvalCount, 2,BigDecimal.ROUND_HALF_UP);
//        		report.setApproveScale(tempScale.floatValue());
//        	}
//        	
//        }
		return resultReportForm;
	}
	
	private List<ReportForm> findReportForm(PubProj proj , String factor){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("factor", factor);
		paramMap.put("proj", proj);
		return this.pubProjExtMapper.selectReportFormData(paramMap);
	}

	@Override
	public List<PubPatient> searchPubProjListByPatientCode(String projFlow,
			String patientCode,Map<String,PubProj> projMap) {
		PubPatientExample example = new PubPatientExample();
		example.createCriteria().andPatientCodeEqualTo(patientCode).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId());
		example.setOrderByClause("in_date desc");
		List<PubPatient> patientList = patientBiz.searchPatient(example);
		for(PubPatient patient : patientList){
			projMap.put(patient.getProjFlow(), projMapper.selectByPrimaryKey(patient.getProjFlow()));
		}
		return patientList;
	} 
}
