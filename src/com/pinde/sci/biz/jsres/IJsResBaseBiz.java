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
	 * ����
	 * @param resBase
	 * @return
	 */
	int saveResBase(ResBase resBase);

	/**
	 * ���������Ϣ
	 * @throws IOException 
	 * @throws JAXBException 
	 */
	int saveBaseInfo(String flag, BaseInfoForm baseInfoForm, String index)throws Exception;
	/**
	 * ����רҵ��Ϣ
	 */
	public int saveTrainSpe(List<ResOrgSpe> saveList,String oldCategory,String baseFlow);
	/**
	 * ���һ���
	 */
	public ResBase readBase(String baseFlow);
	/**
	 * ������չ�Ļ�����Ϣ
	 * @param paramMap
	 * @return
	 */
	public List<ResBaseExt> searchResBaseExtList(Map<String, Object> paramMap);
	/**
	 * ���һ���List
	 * @param resBase
	 * @return
	 */
	public List<ResBase> searchResBaseList(ResBase resBase);
}
