package com.pinde.sci.dao.sch;



import java.util.List;

import org.apache.ibatis.annotations.Param;

/**
 * proj��չmapper
 * @author Administrator
 *
 */
public interface SchRotationDeptExtMapper {
	/**
	 * ����δ�����Ŀ�������
	 * @param orgFlow
	 * @param rotationFlow
	 * @return
	 */
	int getUnrelCount(@Param(value="orgFlow")String orgFlow,@Param(value="rotationFlow")String rotationFlow);
	
	/**
	 * �Ѿ�ͬ���÷����Ļ���
	 * @param rotationFlow
	 * @return
	 */
	List<String> isUpdateOrg(@Param(value="rotationFlow")String rotationFlow);
} 
