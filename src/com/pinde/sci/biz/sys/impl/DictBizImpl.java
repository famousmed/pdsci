package com.pinde.sci.biz.sys.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sys.IDictBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SysDictMapper;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.form.sys.SubDictEditForm;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysDictExample;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysDictExample.Criteria;

@Service
@Transactional(rollbackFor=Exception.class)
public class DictBizImpl implements IDictBiz{
	
	@Resource
	private SysDictMapper sysDictMapper;

	@Override
	public void addDict(SysDict dict) {
		dict.setDictFlow(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(dict, true);
		this.sysDictMapper.insert(dict);
	}

	@Override
	public void modDict(SysDict dict) {
		GeneralMethod.setRecordInfo(dict, false);
		this.sysDictMapper.updateByPrimaryKeySelective(dict);
	}
	
	@Override
	public void modeDictAndSubDict(SysDict dict) {
		SysDict oldDict = this.readDict(dict.getDictFlow());
		String dictTypeId = oldDict.getDictTypeId();
		if(StringUtil.isNotBlank(dictTypeId)){
			String[] dictDatas = dictTypeId.split("\\.");
			String typeId = dictDatas[0];
			int level = DictTypeEnum.valueOf(typeId).getLevel();
			if(level>1){
				//查要修改节点的子节点
				SysDictExample example = new SysDictExample();
				example.createCriteria().andDictTypeIdLike(dictTypeId+"."+oldDict.getDictId()+"%").andDictFlowNotEqualTo(dict.getDictFlow());
				List<SysDict> subDicts = this.sysDictMapper.selectByExample(example);
				for(SysDict subDict:subDicts){
					String newDictTypeId = subDict.getDictTypeId().replace(oldDict.getDictId(),dict.getDictId());
					subDict.setDictTypeId(newDictTypeId);
					subDict.setDictTypeName(dict.getDictName());
					GeneralMethod.setRecordInfo(subDict, false);
					this.sysDictMapper.updateByPrimaryKeySelective(subDict);
				}
			}
		}
		GeneralMethod.setRecordInfo(dict, false);
		this.sysDictMapper.updateByPrimaryKeySelective(dict);
		
	}

	@Override
	public void delDict(String dictFlow,String recordStatus) {
		SysDict dict = new SysDict();
		dict.setDictFlow(dictFlow);
		dict.setRecordStatus(recordStatus);
		GeneralMethod.setRecordInfo(dict, false);
		this.sysDictMapper.updateByPrimaryKeySelective(dict);
		
	}
	
	@Override
	public void delDictAndSubDict(String dictFlow,String recordStatus) {
		if(GlobalConstant.FLAG_N.equals(recordStatus)){
			SysDict oldDict = this.readDict(dictFlow);
			String dictTypeId = oldDict.getDictTypeId();
			if(StringUtil.isNotBlank(dictTypeId)){
				String[] dictDatas = dictTypeId.split("\\.");
				String typeId = dictDatas[0];
				int level = DictTypeEnum.valueOf(typeId).getLevel();
				if(level>1){
					SysDict record = new SysDict();
					record.setRecordStatus(recordStatus);
					GeneralMethod.setRecordInfo(record, false);
					SysDictExample example = new SysDictExample();
					example.createCriteria().andDictTypeIdLike(dictTypeId+"."+oldDict.getDictId()+"%");
					this.sysDictMapper.updateByExampleSelective(record , example);
				}
			}
		}
		
		SysDict dict = new SysDict();
		dict.setDictFlow(dictFlow);
		dict.setRecordStatus(recordStatus);
		GeneralMethod.setRecordInfo(dict, false);
		this.sysDictMapper.updateByPrimaryKeySelective(dict);
		
	}

	@Override
	public SysDict readDict(String dictFlow) {
		return this.sysDictMapper.selectByPrimaryKey(dictFlow);
	}

	@Override
	public SysDict readDict(String dictTypeId,String dictId){
		SysDictExample example = new SysDictExample();
		Criteria criteria = example.createCriteria();
		criteria.andDictTypeIdEqualTo(dictTypeId);
		criteria.andDictIdEqualTo(dictId);
		List<SysDict> sysDictList = sysDictMapper.selectByExample(example);
		if(sysDictList.size()>0){
			return sysDictList.get(0);
		}
		return null;
	}

	@Override
	public List<SysDict> searchDictList(SysDict sysDict) {
		SysDictExample example = new SysDictExample();
		Criteria criteria = example.createCriteria();
//		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(sysDict.getDictTypeId())){
			criteria.andDictTypeIdEqualTo(sysDict.getDictTypeId());
		}
		if(StringUtil.isNotBlank(sysDict.getDictId())){
			criteria.andDictIdLike("%"+sysDict.getDictId()+"%");
		}
		if(StringUtil.isNotBlank(sysDict.getDictName())){
			criteria.andDictNameLike("%"+sysDict.getDictName()+"%");
		}
		if(StringUtil.isNotBlank(sysDict.getRecordStatus())){
			criteria.andRecordStatusEqualTo(sysDict.getRecordStatus());
		}
		//example.setOrderByClause(" RECORD_STATUS DESC,CREATE_TIME");
		example.setOrderByClause(" ORDINAL");
		return this.sysDictMapper.selectByExample(example);
	}

	@Override
	public List<SysDict> searchDictListAllByDictTypeId(String dictTypeId , boolean isShowAll) {
		
		SysDictExample example = new SysDictExample();
		Criteria criteria  = example.createCriteria();
		criteria.andDictTypeIdEqualTo(dictTypeId);
		if(!isShowAll){
			criteria.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
		}
		example.setOrderByClause(" ORDINAL");
		return this.sysDictMapper.selectByExample(example);
		
	}

	@Override
	public List<SysDict> searchDictListByDictTypeId(String dictTypeId) {
		SysDictExample example = new SysDictExample();
		example.createCriteria().andDictTypeIdEqualTo(dictTypeId).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		return this.sysDictMapper.selectByExample(example);
		
	}

	@Override
	public List<SysDict> searchDictListByDictTypeIdNotIncludeSelf(SysDict dict) {
		SysDictExample example = new SysDictExample();
		Criteria criteria = example.createCriteria();
		if(StringUtil.isNotBlank(dict.getDictTypeId())){
			criteria.andDictTypeIdEqualTo(dict.getDictTypeId());
		}
		if(StringUtil.isNotBlank(dict.getDictFlow())){
			criteria.andDictFlowNotEqualTo(dict.getDictFlow());
		}
		return this.sysDictMapper.selectByExample(example);
	}

	@Override
	public void saveOrder(String[] dictFlows) {
		if(dictFlows==null) return;
		int i=1;
		for(String flow : dictFlows){
			SysDict dict = new SysDict();
			dict.setDictFlow(flow);
			dict.setOrdinal((i++));
			this.sysDictMapper.updateByPrimaryKeySelective(dict);		
		}	
		
	}

	@Override
	public void saveSubDict(SubDictEditForm subDictForm) {
		String dictTypeId = "";
		String topDictFlow = subDictForm.getTopDictFlow();
		List<SysDict> subDicts = subDictForm.getSubDicts();
		SysDict topDict = this.readDict(topDictFlow);
		dictTypeId = topDict.getDictTypeId()+"."+topDict.getDictId();
		SysDict dict = subDictForm.getDict();
		dict.setDictTypeName(topDict.getDictName());
		dict.setDictTypeId(dictTypeId);
		if(StringUtil.isBlank(dict.getDictFlow())){
			//新增字典时判断该类型字典代码是否存在
			SysDict sysDict = this.readDict(dictTypeId, dict.getDictId());
			if(null!=sysDict){
				 throw new RuntimeException("字典代码为："+dict.getDictId()+"的字典已经存在，请换一个！");
			}
			this.addDict(dict);	
			if(subDicts!=null && !subDicts.isEmpty()){
				dictTypeId = dict.getDictTypeId()+"."+dict.getDictId();
				for(SysDict subdict:subDicts){
					subdict.setDictTypeName(dict.getDictName());
					subdict.setDictTypeId(dictTypeId);
					if(StringUtil.isBlank(subdict.getDictFlow())){
						SysDict exitSysDict = this.readDict(dictTypeId, dict.getDictId());
						if(null!=exitSysDict){
							 throw new RuntimeException("字典代码为："+dict.getDictId()+"的字典已经存在，请换一个！");
						}
						this.addDict(subdict);
					}else{
						List<SysDict> dictList = this.searchDictListByDictTypeIdNotIncludeSelf(subdict);
						for(SysDict exitDict:dictList){
							 if(subdict.getDictId().equals(exitDict.getDictId())){
								 throw new RuntimeException("字典代码为："+subdict.getDictId()+"的字典已经存在，请换一个！");
							 }
						}
						this.modDict(dict);
					}
					
				}
			}
		}else{
			//修改字典时，字典代码可以与自身相同，可以是新ID，但不能与其他字典相同			
			List<SysDict> exitDictList = this.searchDictListByDictTypeIdNotIncludeSelf(dict);
			for(SysDict sysDict:exitDictList){
				 if(dict.getDictId().equals(sysDict.getDictId())){
					 throw new RuntimeException("字典代码为："+dict.getDictId()+"的字典已经存在，请换一个！");
				 }
			}
			this.modDict(dict);
			if(subDicts!=null && !subDicts.isEmpty()){
				dictTypeId = dict.getDictTypeId()+"."+dict.getDictId();
				for(SysDict subdict:subDicts){
					subdict.setDictTypeName(dict.getDictName());
					subdict.setDictTypeId(dictTypeId);
					if(StringUtil.isBlank(subdict.getDictFlow())){
						SysDict exitSysDict = this.readDict(dictTypeId, dict.getDictId());
						if(null!=exitSysDict){
							 throw new RuntimeException("字典代码为："+dict.getDictId()+"的字典已经存在，请换一个！");
						}
						this.addDict(subdict);
					}else{
						List<SysDict> dictList = this.searchDictListByDictTypeIdNotIncludeSelf(subdict);
						for(SysDict exitDict:dictList){
							 if(subdict.getDictId().equals(exitDict.getDictId())){
								 throw new RuntimeException("字典代码为："+subdict.getDictId()+"的字典已经存在，请换一个！");
							 }
						}
						this.modDict(dict);
					}
					
				}
			}
		}	
		
	}

	

}
