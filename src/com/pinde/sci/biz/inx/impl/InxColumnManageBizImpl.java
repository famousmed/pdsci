package com.pinde.sci.biz.inx.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.inx.IinxColumnManageBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.InxColumnMapper;
import com.pinde.sci.dao.inx.InxColumnExtMapper;
import com.pinde.sci.form.inx.InxColumnForm;
import com.pinde.sci.model.inx.InxColumnExt;
import com.pinde.sci.model.mo.InxColumn;
import com.pinde.sci.model.mo.InxColumnExample;
import com.pinde.sci.model.mo.InxColumnExample.Criteria;

@Service
@Transactional(rollbackFor=Exception.class)
public class InxColumnManageBizImpl implements IinxColumnManageBiz {
	@Resource
	private InxColumnMapper inxColumnMapper;
	@Resource
	private InxColumnExtMapper inxColumnExtMapper;

	@Override
	public List<InxColumn> getAll(String recordStatus) {
		InxColumnExample example = new InxColumnExample();
		example.createCriteria().andRecordStatusEqualTo(recordStatus);
		example.setOrderByClause(" ordinal asc , create_time asc");
		return this.inxColumnMapper.selectByExample(example);
	}

	@Override
	public String save(InxColumn column) {
		column.setColumnFlow(PkUtil.getUUID());
		if("0".equals(column.getParentColumnId())){
			column.setParentColumnId(null);
		}
		column.setColumnId(this.getNextColumnId(column.getParentColumnId()));
		GeneralMethod.setRecordInfo(column, true);
		int saveResult =  this.inxColumnMapper.insertSelective(column);
		String returnInfo = "0";
		if(saveResult==1){
			returnInfo = column.getColumnId();
		}
		return returnInfo;
	}

	@Override
	public String getNextColumnId(String parentColumnId) {
		InxColumnExample example = new InxColumnExample();
		Criteria criteria = example.createCriteria();
		if(StringUtil.isNotEmpty(parentColumnId)){
			criteria.andParentColumnIdEqualTo(parentColumnId);
		}else{
			criteria.andParentColumnIdIsNull();
		}
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("column_id desc ");
		List<InxColumn> list = this.inxColumnMapper.selectByExample(example);
		if(list!=null&&list.size()>0){//已有子栏目
			String bigestColumnId = list.get(0).getColumnId();
			int length = bigestColumnId.length();
			String leftPart = bigestColumnId.substring(0, length-2);
			String rightPart = bigestColumnId.substring(length-2);
			int idValue = new Integer(rightPart).intValue();
			idValue++;
			if(idValue<10){
				rightPart = "0"+idValue;
			}else{
				rightPart = String.valueOf(idValue);
			}
			return leftPart + rightPart;
		}else{//没有子栏目
			if(StringUtil.isNotBlank(parentColumnId)){
				return parentColumnId + "01";
			}
			return "LM01";
		}
	}

	@Override
	public String getAllparentColumn(String columnId) {
		InxColumn col = getById(columnId);
		StringBuilder sb = new StringBuilder();
		while(StringUtil.isNotBlank(col.getParentColumnId())) {
			InxColumn parCol = getById(col.getParentColumnId());
			sb.insert(0, parCol.getColumnName()).insert(0, "-");
			columnId = parCol.getColumnId();
			col = getById(columnId);
		}
		sb.insert(0, "顶级栏目");
		return sb.toString();
	}

	@Override
	public InxColumn getById(String columnId) {
		if(StringUtil.isNotBlank(columnId)){
			InxColumnExample example = new InxColumnExample();
			example.createCriteria().andColumnIdEqualTo(columnId);
			List<InxColumn> list = this.inxColumnMapper.selectByExample(example);
			if(list!=null && list.size()>0){
				return list.get(0);
			}
		}
		return null ;
	}

	@Override
	public int update(InxColumn column) {
		if("0".equals(column.getParentColumnId())){
			column.setParentColumnId(null);
		}
		return this.inxColumnMapper.updateByPrimaryKeySelective(column);
	}

	@Override
	public InxColumn getByFlow(String flow) {
		return this.inxColumnMapper.selectByPrimaryKey(flow);
	}

	@Override
	public InxColumnExt getExtByFlow(String flow) {
		InxColumnForm form = new InxColumnForm();
		form.setColumnFlow(flow);
		return this.inxColumnExtMapper.selectOneByForm(form);
	}

	@Override
	public List<InxColumn> queryChildColumn(String columnId) {
		InxColumnExample example = new InxColumnExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andParentColumnIdEqualTo(columnId);
		return inxColumnMapper.selectByExample(example);
	}

	@Override
	public int updateRecordStatus(List<String> ids, String recordStatus) {
		if(StringUtil.isNotBlank(recordStatus)&&ids!=null&&!ids.isEmpty()){
			InxColumnExample example = new InxColumnExample();
			example.createCriteria().andColumnIdIn(ids);
			InxColumn col = new InxColumn();
			col.setRecordStatus(recordStatus);
			return this.inxColumnMapper.updateByExampleSelective(col, example);
		}
		return 0;
	}

	@Override
	public List<InxColumn> searchInxColumnList(Map<String, Object> paramMap) {
		return inxColumnExtMapper.searchInxColumnList(paramMap);
	}
	

}
