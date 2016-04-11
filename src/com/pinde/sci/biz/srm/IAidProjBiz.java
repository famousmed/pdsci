package com.pinde.sci.biz.srm;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.mo.AidProj;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.pub.AidProjExt;
import com.pinde.sci.model.pub.ProjAidFundExt;

public interface IAidProjBiz {

	/**
	 * 插入一条项目补填记录
	 * @param aidProj
	 */
	public void save(AidProj aidProj,List<MultipartFile> fileList,AidProjExt aidProjExt,List<ProjAidFundExt> fundList,List<String> fileFlows);
	
	/**
	 * 根据流水号查询一条项目信息补填记录
	 * @param projFlow
	 * @return 
	 */
    public AidProj readAidProj(String projFlow);
    
    /**
     * 修改一条项目补填记录
     * @param aidProj
     */
//    public void updateAidProj(AidProj aidProj);
    
    /**
     * 删除一条项目补填记录
     * @param projFlow
     */
    public void deleteAidProj(AidProj aidProj);
    
    /**
     * 根据条件查询补填项目列表
     * @param aidProj
     * @return 
     */
    public List<AidProj> searchAidProj(AidProj aidProj);
    
    public List<AidProj> searchAidProjByChargeOrg(AidProj aidProj,List<SysOrg> allOrgList);
    
    /**
     * 根据数据集合和typeId创建AidProj对象
     * @param dataMap
     * @param typeId
     * @return
     */
    public AidProj createAidProj(Map<String , String[]> dataMap , String projCategoryId , String projSubCategoryId);
    
    public void saveAidProj(AidProj aidProj);
}
