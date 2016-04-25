package com.pinde.sci.biz.pub.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IPubPatientWindowBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.PubPatientWindowMapper;
import com.pinde.sci.model.mo.PubPatientWindow;
import com.pinde.sci.model.mo.PubPatientWindowExample;
import com.pinde.sci.model.mo.PubPatientWindowExample.Criteria;


@Service
@Transactional(rollbackFor=Exception.class)
public class PubPatientWindowBizImpl implements IPubPatientWindowBiz{

	@Resource
	private PubPatientWindowMapper windowMapper;

	@Override
	public List<PubPatientWindow> searchPatientWindowList(PubPatientWindow window) {
		PubPatientWindowExample example = new PubPatientWindowExample(); 
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(window.getProjFlow())){
			criteria.andProjFlowEqualTo(window.getProjFlow());
		}
		if(StringUtil.isNotBlank(window.getOrgFlow())){
			criteria.andOrgFlowEqualTo(window.getOrgFlow());
		}
		if(StringUtil.isNotBlank(window.getPatientFlow())){
			criteria.andPatientFlowEqualTo(window.getPatientFlow());
		}
		if(StringUtil.isNotBlank(window.getVisitFlow())){
			criteria.andVisitFlowEqualTo(window.getVisitFlow());
		}
		return windowMapper.selectByExample(example);
	}
	
	@Override
	public List<PubPatientWindow> searchPatientWindowByPatientFlows(String projFlow,List<String> patientFlows) {
		PubPatientWindowExample example = new PubPatientWindowExample(); 
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow)
		.andPatientFlowIn(patientFlows);
		example.setOrderByClause("VISIT_DATE DESC NULLS LAST");
		return windowMapper.selectByExample(example);
	}
	
	@Override
	public PubPatientWindow searchPatientWindow(String patientFlow,String visitFlow) {
		PubPatientWindow window = null;
		PubPatientWindowExample example = new PubPatientWindowExample(); 
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(patientFlow)){
			criteria.andPatientFlowEqualTo(patientFlow);
		}
		if(StringUtil.isNotBlank(visitFlow)){
			criteria.andVisitFlowEqualTo(visitFlow);
		}
		List<PubPatientWindow> list = windowMapper.selectByExample(example);
		if (list != null && list.size() >0) {
			window = list.get(0);
		}
		return window;
	}
	
	@Override
	public int savePatientWindow(PubPatientWindow patientWindow) {
		if(StringUtil.isNotBlank(patientWindow.getRecordFlow())){
			GeneralMethod.setRecordInfo(patientWindow, false);
			return windowMapper.updateByPrimaryKeySelective(patientWindow);
		}else{
			patientWindow.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(patientWindow, true);
			return windowMapper.insert(patientWindow);
		}
	}
	
	@Override
	public int savePatientWindow(String projFlow,String patientFlow,String visitFlow){
		if(StringUtil.isNotBlank(projFlow) && StringUtil.isNotBlank(projFlow) && StringUtil.isNotBlank(visitFlow)){
			PubPatientWindow window = new PubPatientWindow();
			window.setProjFlow(projFlow);
			window.setPatientFlow(patientFlow);
			window.setVisitFlow(visitFlow);
			List<PubPatientWindow> windowList = searchPatientWindowList(window);
			if(windowList!=null && windowList.size()>0){
				for(PubPatientWindow windowTemp : windowList){
					windowTemp.setIsNotice(GlobalConstant.FLAG_Y);
					savePatientWindow(windowTemp);
				}
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public PubPatientWindow readPatientWindow(String recordFlow){
		return windowMapper.selectByPrimaryKey(recordFlow);
	}
	
	@Override
	public PubPatientWindow readPatientWindow(String patientFlow,String visitFlow){
		PubPatientWindow window = new PubPatientWindow();
		window.setPatientFlow(patientFlow);
		window.setVisitFlow(visitFlow);
		List<PubPatientWindow> windowList = searchPatientWindowList(window);
		if(windowList!=null && windowList.size()>0){
			window = windowList.get(0);
		}else{
			window = null;
		}
		return window;
	}

	@Override
	public List<PubPatientWindow> searchRemaind(String projFlow, String orgFlow) {
		PubPatientWindowExample example = new PubPatientWindowExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow)
		.andWindowVisitRightGreaterThan(DateUtil.getCurrDate()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("window_visit_right");
		return windowMapper.selectByExample(example);
	}

	@Override
	public List<PubPatientWindow> searchPatientWindowByPatientFlows(
			String projFlow, String patientFlow) {
		PubPatientWindowExample example = new PubPatientWindowExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andPatientFlowEqualTo(patientFlow).andWindowVisitLeftIsNotNull()
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("VISIT_DATE");
		return windowMapper.selectByExample(example);
	}

}  
 