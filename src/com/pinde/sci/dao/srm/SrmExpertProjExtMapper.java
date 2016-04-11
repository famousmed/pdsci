package com.pinde.sci.dao.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmExpertProj;
import com.pinde.sci.model.srm.SrmExpertProjExt;
import com.pinde.sci.model.srm.SysUserExt;

public interface SrmExpertProjExtMapper {

	/**
	 * �����������ñ� ��ѯĳ��ר���������Ŀ
	 * @param srmExpertProjExt
	 * @return
	 */
	List<SrmExpertProjExt> selectExpertProj(SrmExpertProjExt srmExpertProjExt);
	
	/**
	 * ��������ר�Һ�������Ŀ������ ��ѯר����Ϣ
	 * @param expertProj
	 * @return
	 */
	List<SysUserExt> selectJoinEvalSetExpertList(SrmExpertProj expertProj);
	
	/**
	 * ��ѯר���������Ŀ �����û����ר�ұ�
	 * @param expertProj
	 * @return
	 */
	List<SrmExpertProjExt> selectExpertProjAndUserExt(SrmExpertProj expertProj);
}
