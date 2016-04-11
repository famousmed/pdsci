package com.pinde.sci.dao.inx;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.form.inx.InxInfoForm;
import com.pinde.sci.model.inx.InxInfoExt;
import com.pinde.sci.model.mo.InxInfo;


public interface InxInfoExtMapper {
	public List<InxInfo> selectByForm(InxInfoForm form);
	public List<InxInfoExt> selectExtByForm(InxInfoForm form);
	public List<InxInfo> selectByFormWithBlobs(InxInfoForm form);
	public List<InxInfoExt> selectExtByFormWithBlobs(InxInfoForm form);
	public long selectCountByForm(InxInfoForm form);
	public InxInfoExt selectExtByFlow(String infoFlow);
	public int updateInfoState(InxInfoForm form);
	
	/**
	 * ĳ����֮���֪ͨ
	 * ���org��Ϊ�������ǰ������org_flowΪ�յ�����,����ֻ��ѯorg_flowΪ�յ�����
	 * @param orgFlow
	 * @return
	 */
	public List<InxInfo> searchInfoByOrgBeforeDate(@Param(value="orgFlow")String orgFlow,@Param(value="date")String date);
}