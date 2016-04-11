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
	 * ����һ����Ŀ�����¼
	 * @param aidProj
	 */
	public void save(AidProj aidProj,List<MultipartFile> fileList,AidProjExt aidProjExt,List<ProjAidFundExt> fundList,List<String> fileFlows);
	
	/**
	 * ������ˮ�Ų�ѯһ����Ŀ��Ϣ�����¼
	 * @param projFlow
	 * @return 
	 */
    public AidProj readAidProj(String projFlow);
    
    /**
     * �޸�һ����Ŀ�����¼
     * @param aidProj
     */
//    public void updateAidProj(AidProj aidProj);
    
    /**
     * ɾ��һ����Ŀ�����¼
     * @param projFlow
     */
    public void deleteAidProj(AidProj aidProj);
    
    /**
     * ����������ѯ������Ŀ�б�
     * @param aidProj
     * @return 
     */
    public List<AidProj> searchAidProj(AidProj aidProj);
    
    public List<AidProj> searchAidProjByChargeOrg(AidProj aidProj,List<SysOrg> allOrgList);
    
    /**
     * �������ݼ��Ϻ�typeId����AidProj����
     * @param dataMap
     * @param typeId
     * @return
     */
    public AidProj createAidProj(Map<String , String[]> dataMap , String projCategoryId , String projSubCategoryId);
    
    public void saveAidProj(AidProj aidProj);
}
