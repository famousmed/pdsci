 package com.pinde.sci.ctrl.srm;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pinde.sci.biz.srm.IAidProjBiz;
import com.pinde.sci.biz.srm.IPubCountBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.srm.AchTypeEnum;
import com.pinde.sci.enums.srm.AidProjCategoryEnum;
import com.pinde.sci.enums.srm.AidTalentsStatusEnum;
import com.pinde.sci.model.mo.AidProj;
import com.pinde.sci.model.mo.AidTalents;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.pub.PubProjCountExt;
import com.pinde.sci.model.srm.SrmAchCountExt;

@Controller
@RequestMapping("/srm/view")
public class PubCountController extends GeneralController{

	@Autowired
	private IPubCountBiz pubCountBizImpl;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IAidProjBiz aidProjBiz;
	
	
	@RequestMapping(value="/list/{projListScope}")
	private String view(@PathVariable String projListScope, Model model){
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		List<Map<String, Integer>> resultMapList=null;
		Map<String,Integer> resultMap=new HashMap<String, Integer>();
		Map<String,Integer> resultMap_ky=null;
		Map<String,Integer> resultMap_xk=null;
		Map<String,Integer> resultMap_rc=null;
		Map<String,Integer> srmAchMap=null;
		SysOrg org = new SysOrg();
		SysUser currUser = GlobalContext.getCurrentUser();
		org.setChargeOrgFlow(currUser.getOrgFlow());
		//��ѯ��ǰ�����¼����ӻ������й��Ҽ���Ŀ
		int aidProjProvinceCount=countAidProj(AidProjCategoryEnum.Province.getId());
		model.addAttribute("aidProjProvinceCount", aidProjProvinceCount);
		//��ѯ��ǰ�����¼����ӻ�������ʡ����Ŀ
		int aidProjCountryCount=countAidProj(AidProjCategoryEnum.Country.getId());
		model.addAttribute("aidProjCountryCount", aidProjCountryCount);
		//��ѯ��ǰ�����¼����ӻ���������������Ŀ
		int aidProjCityCount=countAidProj(AidProjCategoryEnum.City.getId());
		model.addAttribute("aidProjCityCount", aidProjCityCount);
		//��ѯ��ǰ��¼�����ڻ�������һ���������Լ������л���
		List<SysOrg> orgList=orgBiz.searchChildrenOrgByOrgFlowNotIncludeSelf(currUser.getOrgFlow());
		
		//��ǰ��¼����������
		if(projListScope.equals(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL)){
			//���������ͳ��
			resultMapList=pubCountBizImpl.selectCountProjGlobal(org);
			resultMap_ky=resultMapList.get(0);
			resultMap_xk=resultMapList.get(1);
			resultMap_rc=resultMapList.get(2);
			//��ѯ��ǰ�����´���˵��ص��˲�����
			int aidTalentsCount=countAidTalents(AidTalentsStatusEnum.LocalPassed.getId());
				//ҽԺ���������˺�ͨ�������������㣬�����Map
				if(aidTalentsCount>0){
					resultMap.put("aidTalentsCount", aidTalentsCount);
				}
            //���÷�����ѯ��ǰ����������˵���Ա����
			Map<String, Integer> regedUserMap = regedUserCount();
			resultMap.putAll(regedUserMap);
			if(null!=resultMap && !resultMap.isEmpty()){
				model.addAttribute("resultMap", resultMap);
			}
			
		    //ͳ�Ƶ�ǰ�����������������
			LinkedHashMap<String,String> projCountInfoMap=countApproveInfo();
			 
			//ͳ�Ƶ�ǰ��������Ͻ�����е�����Ŀ����
			LinkedHashMap<String, String> orgCountInfoMap=countOrgProj();
			
			//ͳ�Ƶ�ǰ���������е��ĳɹ����ͼ�����
			LinkedHashMap<String, String> srmAchCountMap=countSrmAch();
			model.addAttribute("resultMap_ky", resultMap_ky);
			model.addAttribute("resultMap_xk", resultMap_xk);
			model.addAttribute("resultMap_rc", resultMap_rc);
			model.addAttribute("srmAchCountMap", srmAchCountMap);
			model.addAttribute("orgCountInfoMap", orgCountInfoMap);
			model.addAttribute("projCountInfoMap", projCountInfoMap);
			return "srm/view/global";
		}
		//��ǰ��¼�������ܲ���
		//���������ͳ��
		else if(projListScope.equals(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE)){
			
			resultMapList=pubCountBizImpl.selectCountProjCharge(org);
			resultMap_ky=resultMapList.get(0);
			resultMap_xk=resultMapList.get(1);
			resultMap_rc=resultMapList.get(2);
			
            if(null!=resultMap && !resultMap.isEmpty()){
            	model.addAttribute("resultMap", resultMap);
			}
            
          //���÷�����ѯ��ǰ����������˵���Ա����
			Map<String, Integer> regedUserMap = regedUserCount();
			resultMap.putAll(regedUserMap);
			if(null!=resultMap && !resultMap.isEmpty()){
				model.addAttribute("resultMap", resultMap);
			}
            
            //ͳ�Ƶ�ǰ�����������������
			LinkedHashMap<String,String> projCountInfoMap=countApproveInfo();
			
			//ͳ�Ƶ�ǰ���ܲ�����Ͻ�����е�����Ŀ����
			LinkedHashMap<String, String> orgCountInfoMap=countOrgProj();
			//ͳ�Ƶ�ǰ���ܲ������е��ĳɹ����ͼ�����
			LinkedHashMap<String, String> srmAchCountMap=countSrmAch();
			model.addAttribute("resultMap_ky", resultMap_ky);
			model.addAttribute("resultMap_xk", resultMap_xk);
			model.addAttribute("resultMap_rc", resultMap_rc);
			model.addAttribute("srmAchCountMap", srmAchCountMap);
			model.addAttribute("orgCountInfoMap", orgCountInfoMap);
			model.addAttribute("projCountInfoMap", projCountInfoMap);
			return "srm/view/charge";
		}
		//��ǰ��¼����ҽԺ
		//���������ͳ��
		else{
			resultMapList=pubCountBizImpl.selectCountProjLocal(org);
			resultMap_ky=resultMapList.get(0);
			resultMap_xk=resultMapList.get(1);
			resultMap_rc=resultMapList.get(2);
			
			//�����Ժ��� ��Ҫ����Ԥ����˺ͱ������
			if("local".equals(InitConfig.getSysCfg("srm_for_use"))){
				//��ѯԤ�����
				Integer dealBudgetAuditCount = this.pubCountBizImpl.findDealBudgetAuditProjCount();
				if(dealBudgetAuditCount>0){
					resultMap_ky.put("dealBudgetAuditCount", dealBudgetAuditCount);	
				}
				//��ѯ������˵�����
				Integer dealPaymentAuditCount = this.pubCountBizImpl.findDealPaymentAuditCount();
				if(dealPaymentAuditCount>0){
					resultMap_ky.put("dealPaymentAuditCount" , dealPaymentAuditCount);	
				}
				
			}
			
			//��ѯ��ǰ�����´���˵�ר���ʽ�����
			int aidTalentsCount=countAidTalents(AidTalentsStatusEnum.Passing.getId());
				//ҽԺ���������˺�ͨ�������������㣬�����Map
				if(aidTalentsCount>0){
					resultMap_rc.put("aidTalentsCount", aidTalentsCount);
				}
			
			 //���÷�����ѯ��ǰ����������˵���Ա����
			Map<String, Integer> regedUserMap = regedUserCount();
			resultMap.putAll(regedUserMap);
			
            if(null!=resultMap && !resultMap.isEmpty()){
            	model.addAttribute("resultMap", resultMap);
			}
			srmAchMap=pubCountBizImpl.selectCountSrmAchLocal(org);
			if(null!=srmAchMap && !srmAchMap.isEmpty()){
            	model.addAttribute("srmAchMap", srmAchMap);
			}
			//�����ɹ�����ö�٣�����һ��СдID��ͷ��Map
			Map<String,String> lowerAchTypeMap=new HashMap<String, String>();
			for(AchTypeEnum str:AchTypeEnum.values()){
				lowerAchTypeMap.put(str.getId(),str.getId().toLowerCase());	
			}
			model.addAttribute("lowerAchTypeMap", lowerAchTypeMap);
			//ͳ�Ƶ�ǰ�����������������
			LinkedHashMap<String,String> projCountInfoMap=countApproveInfo();
			
			//ͳ�Ƶ�ǰҽԺ���е��ĳɹ����ͼ�����
			LinkedHashMap<String, String> srmAchCountMap=countSrmAch();
			model.addAttribute("resultMap_ky", resultMap_ky);
			model.addAttribute("resultMap_xk", resultMap_xk);
			model.addAttribute("resultMap_rc", resultMap_rc);
			model.addAttribute("srmAchCountMap", srmAchCountMap);
			model.addAttribute("projCountInfoMap", projCountInfoMap);
			return "srm/view/local";
		}
		
	
	}
	/**
	 * ͳ�Ƶ�ǰ�����������Ա
	 * @return
	 */
	 private Map<String,Integer> regedUserCount(){
		 Map<String,Integer> regedUserMap=new HashMap<String, Integer>();
		 SysUser sysUser=new SysUser();
		 sysUser.setStatusId(UserStatusEnum.Reged.getId());
		 List<SysUser> userList=pubCountBizImpl.selectRegedUser(sysUser);
		 int regedUserCount=0;
		 if(null!=userList && !userList.isEmpty()){
			 for(SysUser user:userList){
				 regedUserCount++;
			 }
		 }
		 if(regedUserCount>0){
			 regedUserMap.put("regedUserCount", regedUserCount);
		 }
		 return regedUserMap;
	 }
	 /**
	  * ͳ����Ŀ������Ϣ
	  * @param projCategoryId
	  * @return
	  */
	 private int countAidProj(String projCategoryId){
		 SysUser currUser = GlobalContext.getCurrentUser();
		//��ѯ��ǰ������������������������
			List<SysOrg> allOrgList=orgBiz.searchChildrenOrgByOrgFlow(currUser.getOrgFlow());
			AidProj aidProj=new AidProj();
			//��ѯ��ǰ���������ӻ���������ʡ����Ŀ
			aidProj.setProjCategoryId(projCategoryId);
			List<AidProj> aidProjList=aidProjBiz.searchAidProjByChargeOrg(aidProj,allOrgList);
			int aidProjCount=0;
			if(null!=aidProjList && !aidProjList.isEmpty()){
				for(AidProj proj:aidProjList){
					aidProjCount++;
				 }
			}
			return aidProjCount;
	 }
	 /**
	  * ͳ��ר���ʽ��˲�
	  * @return
	  */
	 private int countAidTalents(String statusId){
		 int aidTalentsCount=0;
		 AidTalents aidTalents=new AidTalents();
			aidTalents.setStatusId(statusId);
			List<AidTalents> aidTalentsList=pubCountBizImpl.selectAidTalentsByOrg(aidTalents);
			if(null!=aidTalentsList && !aidTalentsList.isEmpty()){
				for(AidTalents aidTalentss:aidTalentsList){
					aidTalentsCount++;
				}
			}
			return aidTalentsCount;
	 }
	 /**
	  * ͳ���������������
	  * @return
	  */
	 private LinkedHashMap<String,String> countApproveInfo(){
		 LinkedHashMap<String,String> projCountInfoMap=new LinkedHashMap<String, String>();
			int countExpert=pubCountBizImpl.selectProjInExpertAll();
			projCountInfoMap.put("������Ŀ������", String.valueOf(countExpert));
			//ͳ�Ƶ�ǰҽԺ����ͨ���������Ŀ����
			int countApprove=pubCountBizImpl.selectProjApproveAll();
			projCountInfoMap.put("������Ŀ����", String.valueOf(countApprove));
			//ͳ�Ƶ�ǰҽԺ�������ͨ������Ŀ����
			int countNotApprove=pubCountBizImpl.selectProjNotApproveAll();
			projCountInfoMap.put("δ������Ŀ����", String.valueOf(countNotApprove));
			//ͳ�Ƶ�ǰҽԺ��������Ŀ�������
			BigDecimal bigCountApprove=new BigDecimal(countApprove);
			BigDecimal bigCountApply=new BigDecimal(pubCountBizImpl.selectProjApply());
			if(bigCountApply.intValue()!=0){
			  BigDecimal countAppPp=bigCountApprove.divide(bigCountApply,2,RoundingMode.HALF_UP);
			  projCountInfoMap.put("�������", String.valueOf(countAppPp.doubleValue()*100));
			}else{
				 projCountInfoMap.put("�������","0");	
			}
			//ͳ�Ƶ�ǰҽԺ������Ŀ������
			int countComplete=pubCountBizImpl.selectProjComplete();
			projCountInfoMap.put("������Ŀ����", String.valueOf(countComplete));
			return projCountInfoMap;
	 }
	 /**
	  * ͳ�Ƶ�ǰ������Ͻ�ɹ�����
	  * @return
	  */
	 private LinkedHashMap<String,String> countSrmAch(){
		 List<SrmAchCountExt> srmAchCountList=pubCountBizImpl.selectSrmAchByOrg();
			LinkedHashMap<String, String> srmAchCountMap=new LinkedHashMap<String, String>();
			for(AchTypeEnum str:AchTypeEnum.values()){
			  for(SrmAchCountExt sc:srmAchCountList){
				if(str.getName().equals(sc.getAchTypeName()) && GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("srm_useAchType_"+str.getId()))){
					 srmAchCountMap.put(sc.getAchTypeName(), sc.getSrmAchCount());
				}
			  }
			}
			for(AchTypeEnum str:AchTypeEnum.values()){
				if(!srmAchCountMap.containsKey(str.getName()) && GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("srm_useAchType_"+str.getId()))){
					srmAchCountMap.put(str.getName(), "0");
				}
			}
		   return srmAchCountMap;
	 }
	 private LinkedHashMap<String,String> countOrgProj(){
		    SysUser currUser = GlobalContext.getCurrentUser();
		    //��ѯ��ǰ��¼�����ڻ�������һ���������Լ������л���
			List<SysOrg> orgList=orgBiz.searchChildrenOrgByOrgFlowNotIncludeSelf(currUser.getOrgFlow());
		    List<PubProjCountExt> projCountInfoList=pubCountBizImpl.selectProjGroupByOrg();
			LinkedHashMap<String, String> orgCountInfoMap=new LinkedHashMap<String, String>();
			for(PubProjCountExt ppce:projCountInfoList){
				orgCountInfoMap.put(ppce.getOrgName(),ppce.getProjCount());
			}
			for(SysOrg so:orgList){
				if(!orgCountInfoMap.containsKey(so.getOrgName())){
					orgCountInfoMap.put(so.getOrgName(), "0");
				}
			}
			return orgCountInfoMap;
	 }
}
