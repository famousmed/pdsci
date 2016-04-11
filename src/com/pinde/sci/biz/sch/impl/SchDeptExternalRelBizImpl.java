package com.pinde.sci.biz.sch.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sch.ISchDeptExternalRelBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SchDeptExternalRelMapper;
import com.pinde.sci.model.mo.SchDeptExternalRel;
import com.pinde.sci.model.mo.SchDeptExternalRelExample;

@Service
@Transactional(rollbackFor=Exception.class)
public class SchDeptExternalRelBizImpl implements ISchDeptExternalRelBiz {
	@Autowired
	private SchDeptExternalRelMapper deptExtRelMapper;

	@Override
	public int editSchDeptExtRel(SchDeptExternalRel schDeptExtRel) {
		if(schDeptExtRel !=null){
			if(StringUtil.isNotBlank(schDeptExtRel.getRecordFlow())){
				GeneralMethod.setRecordInfo(schDeptExtRel, false);
				return deptExtRelMapper.updateByPrimaryKeySelective(schDeptExtRel);
			}else{
				schDeptExtRel.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(schDeptExtRel, true);
				return deptExtRelMapper.insertSelective(schDeptExtRel);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public SchDeptExternalRel readSchDeptExtRel(String recordFlow) {
		return deptExtRelMapper.selectByPrimaryKey(recordFlow);
	}

	@Override
	public SchDeptExternalRel readSchDeptExtRelBySchDept(String schDeptFlow) {
		SchDeptExternalRelExample example = new SchDeptExternalRelExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andSchDeptFlowEqualTo(schDeptFlow);
		SchDeptExternalRel schDeptExtRel = null;
		List<SchDeptExternalRel> deptExtRelList = deptExtRelMapper.selectByExample(example);
		if(deptExtRelList!=null && deptExtRelList.size()>0){
			schDeptExtRel = deptExtRelList.get(0);
		}
		return schDeptExtRel;
	}

	@Override
	public List<SchDeptExternalRel> searchSchDeptExtRel() {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List<SchDeptExternalRel> searchSchDeptExtRel(String orgFlow) {
		SchDeptExternalRelExample example = new SchDeptExternalRelExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgFlowEqualTo(orgFlow);
		return deptExtRelMapper.selectByExample(example);
	}
	
	@Override
	public int delSchDeptRel(String schDeptFlow){
		SchDeptExternalRel deptExtRel = new SchDeptExternalRel();
		deptExtRel.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		SchDeptExternalRelExample example = new SchDeptExternalRelExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andSchDeptFlowEqualTo(schDeptFlow);
		return deptExtRelMapper.updateByExampleSelective(deptExtRel,example);
	}
	
}
