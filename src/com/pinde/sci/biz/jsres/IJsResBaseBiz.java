package com.pinde.sci.biz.jsres;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.xml.bind.JAXBException;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.sci.form.jsres.BaseInfoForm;
import com.pinde.sci.model.jsres.ResBaseExt;
import com.pinde.sci.model.mo.ResBase;
import com.pinde.sci.model.mo.ResOrgSpe;
@Service
@Transactional(rollbackFor=Exception.class)
public interface IJsResBaseBiz {

	/**
	 * 保存
	 * @param resBase
	 * @return
	 */
	int saveResBase(ResBase resBase);

	/**
	 * 保存基地信息
	 * @throws IOException 
	 * @throws JAXBException 
	 */
	int saveBaseInfo(String flag, BaseInfoForm baseInfoForm, String index)throws Exception;
	/**
	 * 保存专业信息
	 */
	public int saveTrainSpe(List<ResOrgSpe> saveList,String oldCategory,String baseFlow);
	/**
	 * 查找基地
	 */
	public ResBase readBase(String baseFlow);
	/**
	 * 查找扩展的基地信息
	 * @param paramMap
	 * @return
	 */
	public List<ResBaseExt> searchResBaseExtList(Map<String, Object> paramMap);
	/**
	 * 查找基地List
	 * @param resBase
	 * @return
	 */
	public List<ResBase> searchResBaseList(ResBase resBase);
}
