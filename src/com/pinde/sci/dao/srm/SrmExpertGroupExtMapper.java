package com.pinde.sci.dao.srm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmExpertGroup;
import com.pinde.sci.model.mo.SrmExpertProjEval;
import com.pinde.sci.model.srm.ExpertGroupUserExt;
import com.pinde.sci.model.srm.SrmExpertGroupProjExt;
/**
 * experGroup��չmapper
 * @author Administrator
 *
 */
public interface SrmExpertGroupExtMapper {

	List<SrmExpertProjEval> searchGroupProjByCurrExpert(Map<String, Object> paramMap);

	List<SrmExpertGroup> searchExpertGroupByCurrProj(Map<String, Object> paramMap); 
	
	/**
	 * ����������ѯ��������(���й�����Ŀ��)
	 * @param srmExpertGroupProjExt
	 * @return
	 */
	List<SrmExpertGroupProjExt> selectExpertGroupProjList(SrmExpertGroupProjExt srmExpertGroupProjExt);
	
	/**
	 * ����ר������ˮ�Ų�ѯ ���� �û��� ר�ұ� ר�����ר�ҹ�����
	 * @param groupFlow
	 * @return
	 */
	List<ExpertGroupUserExt> selectExpertGroupExtByGroupFlow(@Param(value="groupFlow")String groupFlow);
	
	
	
	
}
 