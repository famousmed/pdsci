package com.pinde.sci.biz.sch.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sch.ISchDeptBiz;
import com.pinde.sci.biz.sch.ISchDeptExternalRelBiz;
import com.pinde.sci.biz.sch.ISchDeptRelBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SchDeptMapper;
import com.pinde.sci.dao.sch.SchDeptExtMapper;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SchDept;
import com.pinde.sci.model.mo.SchDeptExample;
import com.pinde.sci.model.mo.SchDeptExternalRel;
import com.pinde.sci.model.mo.SchDeptRel;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysOrg;

@Service
@Transactional(rollbackFor=Exception.class)
public class SchDeptBizImpl implements ISchDeptBiz {
	@Autowired
	private SchDeptMapper schDeptMapper;
	@Resource
	private IDeptBiz deptBiz;
	@Resource
	private ISchDeptRelBiz deptRelBiz;
	@Resource
	private IOrgBiz orgBiz;
	@Resource
	private ISchDeptExternalRelBiz deptExtBiz;
	@Resource
	private SchDeptExtMapper deptExtMapper;

	@Override
	public List<SchDept> searchSchDept(String deptFlow) {
		SchDeptExample example = new SchDeptExample();
		example.createCriteria().andDeptFlowEqualTo(deptFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		return schDeptMapper.selectByExample(example);
	}
	
	@Override
	public List<SchDept> searchrotationDept(String userFlow) {
		return deptExtMapper.searchrotationDept(userFlow);
	}
	
	@Override
	public List<SchDept> userSchDept(String userFlow) {
		return deptExtMapper.userSchDept(userFlow);
	}
	
	@Override
	public List<SchDept> countDeptArea(ResDoctor doctor) {
		return deptExtMapper.countDeptArea(doctor);
	}

	@Override
	public int saveSchDept(SchDept dept) {
		if(dept != null){
			if(StringUtil.isNotBlank(dept.getSchDeptFlow())){
				GeneralMethod.setRecordInfo(dept, false);
				return schDeptMapper.updateByPrimaryKeySelective(dept);
			}else{
				dept.setSchDeptFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(dept, true);
				return schDeptMapper.insertSelective(dept);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int delSchDept(SchDept dept){
		if(dept!=null){
			deptRelBiz.depSchDeptRel(dept.getSchDeptFlow());
		}
		return saveSchDept(dept);
	}
	
	@Override
	public int saveSchDeptAndRed(SchDept dept,String[] standardDeptIds){
		if(dept.getDeptNum()==null){
			dept.setDeptNum(0);
		}
		saveSchDept(dept);
		//删除之前关联的数据
		if(dept!=null){
			deptRelBiz.depSchDeptRel(dept.getSchDeptFlow());
		}
		if(standardDeptIds!=null && standardDeptIds.length>0 && dept!=null){
			SchDeptRel deptRel = new SchDeptRel();
			deptRel.setSchDeptFlow(dept.getSchDeptFlow());
			deptRel.setSchDeptName(dept.getSchDeptName());
			deptRel.setDeptFlow(dept.getDeptFlow());
			deptRel.setDeptName(dept.getDeptName());
			deptRel.setOrgFlow(dept.getOrgFlow());
			deptRel.setOrgName(dept.getOrgName());
			for(String standardDeptId : standardDeptIds){
				deptRel.setRecordFlow(null);
				deptRel.setStandardDeptId(standardDeptId);
				deptRel.setStandardDeptName(DictTypeEnum.StandardDept.getDictNameById(standardDeptId));
				deptRelBiz.editDeptRel(deptRel);
			}
		}
		return GlobalConstant.ONE_LINE;
	}
	
	@Override
	public int saveSchDeptAndRedAndExtRel(SchDept dept,String[] standardDeptIds,SchDeptExternalRel deptExtRel){
		SysOrg org = orgBiz.readSysOrg(dept.getExternalOrgFlow());
		if(org!=null){
			dept.setExternalOrgName(org.getOrgName());
		}
		saveSchDeptAndRed(dept,standardDeptIds);
		
		deptExtRel.setSchDeptFlow(dept.getSchDeptFlow());
		deptExtRel.setSchDeptName(dept.getSchDeptName());
		deptExtRel.setDeptFlow(dept.getDeptFlow());
		deptExtRel.setDeptName(dept.getDeptName());
		deptExtRel.setOrgFlow(dept.getOrgFlow());
		deptExtRel.setOrgName(dept.getOrgName());
		
		deptExtRel.setRelOrgFlow(dept.getExternalOrgFlow());
		deptExtRel.setRelOrgName(dept.getExternalOrgName());
		
		SchDept schDept = readSchDept(deptExtRel.getRelSchDeptFlow());
		if(schDept!=null){
			deptExtRel.setRelDeptFlow(schDept.getDeptFlow());
			deptExtRel.setRelDeptName(schDept.getDeptName());
			deptExtRel.setRelSchDeptFlow(schDept.getSchDeptFlow());
			deptExtRel.setRelSchDeptName(schDept.getSchDeptName());
		}
		deptExtBiz.delSchDeptRel(dept.getSchDeptFlow());
		deptExtRel.setRecordFlow(null);
		deptExtBiz.editSchDeptExtRel(deptExtRel);
		return GlobalConstant.ONE_LINE;
	}

	@Override
	public SchDept readSchDept(String schDeptFlow) {
		return schDeptMapper.selectByPrimaryKey(schDeptFlow);
	}

	@Override
	public Map<String, List<SchDept>> searchSchDeptMap(String orgFlow) {
		SchDeptExample example = new SchDeptExample();
		example.createCriteria().andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		List<SchDept> schDeptTempList = schDeptMapper.selectByExample(example);
		
		Map<String, List<SchDept>> schDeptMap = new HashMap<String, List<SchDept>>();
		for(SchDept dept : schDeptTempList){
			String sysDeptFlow = dept.getDeptFlow();
			if(schDeptMap.get(sysDeptFlow) == null){
				List<SchDept> schDeptList = new ArrayList<SchDept>();
				schDeptList.add(dept);
				schDeptMap.put(sysDeptFlow, schDeptList);
			}else{
				schDeptMap.get(sysDeptFlow).add(dept);
			}
		}
		return schDeptMap;
	}
	
	@Override
	public List<SchDept> searchSchDeptList(String orgFlow) {
		SchDeptExample example = new SchDeptExample();
		example.createCriteria().andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL ");
		return schDeptMapper.selectByExample(example);
	}
	
	@Override
	public List<SchDept> searchSchExternalDeptListByDept(String deptFlow) {
		SchDeptExample example = new SchDeptExample();
		example.createCriteria().andDeptFlowEqualTo(deptFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andExternalEqualTo(GlobalConstant.FLAG_Y);
		example.setOrderByClause("ORDINAL ");
		return schDeptMapper.selectByExample(example);
	}
	
	@Override
	public int mapDeptRel(String orgFlow,List<String> deptFlows){
		if(StringUtil.isNotBlank(orgFlow) && deptFlows!=null && deptFlows.size()>0){
			SysOrg org = orgBiz.readSysOrg(orgFlow);
//			List<SysDept> deptList = deptBiz.searchDeptByOrg(orgFlow);
			List<SysDept> deptList = deptBiz.searchDeptByFlows(deptFlows);
			if(deptList!=null && deptList.size()>0){
				SchDept dept = new SchDept();
				dept.setIsExternal(GlobalConstant.FLAG_N);
				dept.setExternal(GlobalConstant.FLAG_N);
				dept.setOrgFlow(org.getOrgFlow());
				dept.setOrgName(org.getOrgName());
				for(SysDept sDept : deptList){
					dept.setSchDeptFlow(null);
					dept.setSchDeptName(sDept.getDeptName());
					dept.setDeptFlow(sDept.getDeptFlow());
					dept.setDeptName(sDept.getDeptName());
					saveSchDept(dept);
				}
				return GlobalConstant.ONE_LINE;
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public List<SchDept> searchDeptByFlows(List<String> schDeptLists){
		SchDeptExample example = new SchDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andSchDeptFlowIn(schDeptLists);
		example.setOrderByClause("ORDINAL ");
		return schDeptMapper.selectByExample(example);
	}
	
	@Override
	public List<SchDept> searchDeptByDeotFlows(List<String> deptLists){
		SchDeptExample example = new SchDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andDeptFlowIn(deptLists);
		example.setOrderByClause("ORDINAL ");
		return schDeptMapper.selectByExample(example);
	}
	
	@Override
	public List<SchDept> searchTeachDept(String teacherUserFlow){
		return deptExtMapper.searchTeachDept(teacherUserFlow);
	}
}
