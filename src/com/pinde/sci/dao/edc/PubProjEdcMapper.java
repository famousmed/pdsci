package com.pinde.sci.dao.edc;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.model.mo.PubProj;

/**
 * proj¿©’πmapper
 * @author Administrator
 *
 */
public interface PubProjEdcMapper {
	
	public List<PubProj> selectUserProjList(Map<String,String> paramMap);
	
	public List<PubProj> selectUserProjListForAssign(@Param(value="userFlow")String userFlow, @Param(value="roleFlow")String roleFlow);
	
	public List<PubProj> selectUserProjListForInput(@Param(value="userFlow")String userFlow, @Param(value="roleFlow")String roleFlow);

	public List<PubProj> selectUserProjListForMobile(
			Map<String, String> paramMap); 

} 
