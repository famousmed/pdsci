package com.pinde.sci.dao.srm;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.model.mo.SrmExpert;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.ExpertInfo;
import com.pinde.sci.model.srm.SysUserExt;

/**
 * expert��չmapper
 * @author shij
 *
 */
public interface ExpertExtMapper {

	/**
	 * ���ݲ���ĳר�����ר��
	 * @param proj
	 * @return
	 */
	public List<SrmExpert> searchSysUserNotInByGroupFlow(String groupFlow);
	
	public List<SrmExpert> searchExpertInfo(HashMap<String, Object> map);
	/**
	 * ��ѯר���б���ĳ�����������������ר�� ������������ˮ��Ϊnull �� ""ʱ ����ѯ������ר��
	 * @param evalSetFlow
	 * @return
	 */
	public List<SysUserExt> selectExpertNotInEvalSettingByEvalSetFlow(@Param(value="evalSetFlow")String evalSetFlow);
}
