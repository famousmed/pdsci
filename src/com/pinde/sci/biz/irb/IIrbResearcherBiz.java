package com.pinde.sci.biz.irb;

import java.util.List;

import com.pinde.sci.form.irb.IrbApplyFileForm;
import com.pinde.sci.form.sys.SysUserForm;
import com.pinde.sci.model.irb.ProjInfoForm;
import com.pinde.sci.model.mo.IrbApply;
import com.pinde.sci.model.mo.IrbProcess;
import com.pinde.sci.model.mo.IrbRec;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysUser;

public interface IIrbResearcherBiz {
	
	public ProjInfoForm readProjInfoForm(String projFlow);

	public List<SysDept> searchSysDept(String orgFlow);

	public List<SysUser> searchSysUserByDept(String deptFlow);

	public void addProj(PubProj proj);

	public void modifyProj(PubProj proj);

	public PubProj readPubProj(String projFlow);

	public void addIrbApply(IrbApply apply);
	public List<IrbApply> searchIrbApplyList(String projFlow);
	//public void handProcess(IrbApply irb);
	public void modifyIrbApply(IrbApply irb); 
	/**
	 * 保存送审文件
	 * @param pubFile
	 * @param irbRec
	 * @param form
	 * @return
	 */
	public int saveApplyFile(PubFile pubFile,IrbRec irbRec,IrbApplyFileForm form) throws Exception;
	/**
	 * 删除文件节点
	 * @param irbFlow
	 * @param fileId
	 */
	public void delApplyFile(String irbFlow,String fileId) throws Exception;

	public List<IrbApply> searchIrbApplyList(String projFlow, String id);
	/**
	 * 查询可选择为研究人员的用户
	 * @param form
	 * @return
	 */
	public List<SysUser> queryResUser(SysUserForm form);

	public IrbApply readIrbApply(String irbFlow);

	public List<IrbProcess> searchProcess(String irbFlow);

	public List<PubProj> searchProjList(PubProj proj);
    public void saveProcess(IrbApply irb,IrbProcess process);

	void modifyIrbProcess(IrbProcess process);
}
