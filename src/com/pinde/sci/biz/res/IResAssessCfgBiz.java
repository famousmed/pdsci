package com.pinde.sci.biz.res;

import java.util.List;
import com.pinde.sci.form.res.ResAssessCfgForm;
import com.pinde.sci.form.res.ResAssessCfgItemForm;
import com.pinde.sci.form.res.ResAssessCfgTitleForm;
import com.pinde.sci.model.mo.ResAssessCfg;

public interface IResAssessCfgBiz {
	
	/**
	 * ����
	 * @param assessCfg
	 * @return
	 */
	int saveAssessCfg(ResAssessCfg assessCfg);
	
	/**
	 * ��ȡһ����¼
	 * @param cfgFlow
	 * @return
	 */
	ResAssessCfg readResAssessCfg(String cfgFlow);
	
	/**
	 * ��ѯ
	 * @param assessCfg
	 * @return
	 */
	List<ResAssessCfg> searchAssessCfgList(ResAssessCfg assessCfg);
	
	/**
	 * �༭����ָ�����
	 * @param cfgForm
	 * @param titleForm
	 * @return
	 * @throws Exception 
	 */
	int editAssessCfgTitle(ResAssessCfg assessCfg, ResAssessCfgTitleForm titleForm) throws Exception;
	
	/**
	 * ɾ������ָ�����
	 * @param cfgFlow
	 * @param id
	 * @return
	 * @throws Exception 
	 */
	int deleteTitle(String cfgFlow, String id) throws Exception;
	
	
	
	/**
	 * ���濼��ָ���б�
	 * @param form
	 * @return
	 * @throws Exception 
	 */
	int saveAssessItemList(ResAssessCfgForm form) throws Exception;
	
	/**
	 * �޸Ŀ���ָ��
	 * @param cfgFlow 
	 * @param itemForm
	 * @return
	 * @throws Exception 
	 */
	int modifyItem(String cfgFlow, ResAssessCfgItemForm itemForm) throws Exception;
	
	/**
	 * ɾ������ָ��
	 * @param cfgFlow
	 * @param id
	 * @return
	 * @throws Exception 
	 */
	int deleteItem(String cfgFlow, String id) throws Exception;

}
