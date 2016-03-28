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
 * experGroup扩展mapper
 * @author Administrator
 *
 */
public interface SrmExpertGroupExtMapper {

	List<SrmExpertProjEval> searchGroupProjByCurrExpert(Map<String, Object> paramMap);

	List<SrmExpertGroup> searchExpertGroupByCurrProj(Map<String, Object> paramMap); 
	
	/**
	 * 根据条件查询评审设置(其中关联项目表)
	 * @param srmExpertGroupProjExt
	 * @return
	 */
	List<SrmExpertGroupProjExt> selectExpertGroupProjList(SrmExpertGroupProjExt srmExpertGroupProjExt);
	
	/**
	 * 根据专家组流水号查询 关联 用户表 专家表 专家组和专家关联表
	 * @param groupFlow
	 * @return
	 */
	List<ExpertGroupUserExt> selectExpertGroupExtByGroupFlow(@Param(value="groupFlow")String groupFlow);
	
	
	
	
}
 