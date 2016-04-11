package com.pinde.sci.biz.srm.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IPubCountBiz;
import com.pinde.sci.biz.sys.impl.OrgBizImpl;
import com.pinde.sci.biz.sys.impl.UserBizImpl;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.AidTalentsMapper;
import com.pinde.sci.dao.base.SrmProjFundDetailMapper;
import com.pinde.sci.dao.base.SrmProjFundInfoMapper;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.dao.pub.PubProjExtMapper;
import com.pinde.sci.dao.srm.SrmAchCountExtMapper;
import com.pinde.sci.dao.sys.SysOrgExtMapper;
import com.pinde.sci.enums.srm.AchStatusEnum;
import com.pinde.sci.enums.srm.ProjApplyStatusEnum;
import com.pinde.sci.enums.srm.ProjApproveStatusEnum;
import com.pinde.sci.enums.srm.ProjCompleteStatusEnum;
import com.pinde.sci.enums.srm.ProjEvaluationStatusEnum;
import com.pinde.sci.enums.srm.ProjFundTypeEnum;
import com.pinde.sci.enums.srm.ProjRecTypeEnum;
import com.pinde.sci.enums.srm.ProjScheduleStatusEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.model.mo.AidTalents;
import com.pinde.sci.model.mo.AidTalentsExample;
import com.pinde.sci.model.mo.AidTalentsExample.Criteria;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmProjFundDetailExample;
import com.pinde.sci.model.mo.SrmProjFundInfoExample;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserExample;
import com.pinde.sci.model.pub.PubProjCountExt;
import com.pinde.sci.model.srm.SrmAchCountExt;

@Service
@Transactional(rollbackFor=Exception.class)
public class PubCountBizImpl implements IPubCountBiz{
    
	@Autowired
	private SysOrgExtMapper sysOrgExtMapper;
	@Autowired
	private PubProjExtMapper projExtMapper;
	@Autowired
	private SrmAchCountExtMapper srmAchCountExtMapper;
	@Autowired
	private OrgBizImpl orgBiz;
	@Autowired
	private AidTalentsBizImpl aidTalentsBizImpl;
	@Autowired
	private AidTalentsMapper aidTalentsMapper;
	@Autowired
	private UserBizImpl userBiz;
	@Autowired
	private SysUserMapper userMapper;
	
	@Autowired
	private SrmProjFundInfoMapper projFundInfoMapper;
	
	@Autowired
	private SrmProjFundDetailMapper projFundDetailMapper;
	
	
	/**
	 * ������
	 */
	@Override
	public List<Map<String, Integer>> selectCountProjGlobal(SysOrg org) {
		SysUser currentUser = GlobalContext.getCurrentUser();
		String currentOrgFlow = currentUser.getOrgFlow();
		List<Map<String, Integer>> resultMapList=new LinkedList<Map<String,Integer>>();
		Map<String,Integer> resultMap_ky=new HashMap<String,Integer>();
		Map<String,Integer> resultMap_xk=new HashMap<String,Integer>();
		Map<String,Integer> resultMap_rc=new HashMap<String,Integer>();
		Integer count=null;
		Map<String,Object> paramMap=new HashMap<String, Object>();
		List<String> statusList=new ArrayList<String>(); 
	    //���걨��˵���Ŀ����
		//����
		resultMap_ky=countApplyProj(resultMap_ky, count, paramMap, 
				                    GlobalConstant.RECORD_STATUS_Y, currentOrgFlow, 
				                    "ky",GlobalConstant.USER_LIST_GLOBAL,
				                    ProjApplyStatusEnum.SecondAudit.getId(),
				                    ProjApplyStatusEnum.FirstAudit.getId(),
				                    "",InitConfig.getSysCfg("global_org_flow"));
		//�ص�ѧ��
		resultMap_xk=countApplyProj(resultMap_xk, count, paramMap, 
                                    GlobalConstant.RECORD_STATUS_Y, currentOrgFlow, 
                                    "xk",GlobalConstant.USER_LIST_GLOBAL,
                                    ProjApplyStatusEnum.SecondAudit.getId(),
                                    ProjApplyStatusEnum.FirstAudit.getId(),
                                    "",InitConfig.getSysCfg("global_org_flow"));	
	    //�ص��˲�
		resultMap_rc=countApplyProj(resultMap_rc, count, paramMap, 
                                    GlobalConstant.RECORD_STATUS_Y, currentOrgFlow, 
                                    "rc",GlobalConstant.USER_LIST_GLOBAL,
                                    ProjApplyStatusEnum.SecondAudit.getId(),
                                    ProjApplyStatusEnum.FirstAudit.getId(),
                                    "",InitConfig.getSysCfg("global_org_flow"));		
			
			
			//�����������
			statusList.removeAll(statusList);
			paramMap.clear();
			statusList.add(ProjApproveStatusEnum.Approving.getId());
			//����
			resultMap_ky=countApproveEvaProj(resultMap_ky, count, paramMap, statusList, org, "ky");
			//�ص�ѧ��
			resultMap_xk=countApproveEvaProj(resultMap_xk, count, paramMap, statusList, org, "xk");
			//�ص��˲�
			resultMap_rc=countApproveEvaProj(resultMap_rc, count, paramMap, statusList, org, "rc");
			
			//������������
			//����
			resultMap_ky=countApproveProj(resultMap_ky, count, paramMap, statusList, org, "ky");
			//�ص�ѧ��
			resultMap_xk=countApproveProj(resultMap_xk, count, paramMap, statusList, org, "xk");
			//�ص��˲�
			resultMap_rc=countApproveProj(resultMap_rc, count, paramMap, statusList, org, "rc");
			
			//���²����ѵ�
//			statusList.removeAll(statusList);
//			paramMap.clear();
//			statusList.add(ProjApproveStatusEnum.NotApprove.getId());
//			stageList.add(ProjStageEnum.Apply.getId());
//			stageList.add(ProjStageEnum.Archive.getId());
//			paramMap.put("chargeOrgFlow", org.getChargeOrgFlow());
//			paramMap.put("projStatusId", statusList);
//			paramMap.put("projStageId", ProjStageEnum.Approve.getId());
//			paramMap.put("projStageList", stageList);
//			count=projExtMapper.selectCountProjFundDown(paramMap);
//			if(count != 0){
//				resultMap.put("down", count);
//			}
			
			//����ͬ��˵�
			paramMap.clear();
			resultMap_ky=countContractProj(resultMap_ky, count, paramMap, 
                    GlobalConstant.RECORD_STATUS_Y, currentOrgFlow, 
                    "ky",GlobalConstant.USER_LIST_GLOBAL,
                    ProjApplyStatusEnum.SecondAudit.getId(),
                    ProjApplyStatusEnum.FirstAudit.getId(),
                    "",InitConfig.getSysCfg("global_org_flow"));
           //�ص�ѧ��
            resultMap_xk=countContractProj(resultMap_xk, count, paramMap, 
                    GlobalConstant.RECORD_STATUS_Y, currentOrgFlow, 
                    "xk",GlobalConstant.USER_LIST_GLOBAL,
                    ProjApplyStatusEnum.SecondAudit.getId(),
                    ProjApplyStatusEnum.FirstAudit.getId(),
                    "",InitConfig.getSysCfg("global_org_flow"));	
           //�ص��˲�
            resultMap_rc=countContractProj(resultMap_rc, count, paramMap, 
                    GlobalConstant.RECORD_STATUS_Y, currentOrgFlow, 
                    "rc",GlobalConstant.USER_LIST_GLOBAL,
                    ProjApplyStatusEnum.SecondAudit.getId(),
                    ProjApplyStatusEnum.FirstAudit.getId(),
                    "",InitConfig.getSysCfg("global_org_flow"));
			
			
			//����չ������˵�
			statusList.removeAll(statusList);
			paramMap.clear();
			statusList.add(ProjScheduleStatusEnum.Submit.getId());    
			statusList.add(ProjScheduleStatusEnum.FirstAudit.getId());
			statusList.add(ProjScheduleStatusEnum.SecondAudit.getId());
			//����
		    resultMap_ky=countScheduleProj(resultMap_ky, count, paramMap, statusList, org, "ky");
			//�ص�ѧ��
			resultMap_xk=countScheduleProj(resultMap_xk, count, paramMap, statusList, org, "xk");
			//�ص��˲�
			resultMap_rc=countScheduleProj(resultMap_rc, count, paramMap, statusList, org, "rc");
			
			//�������˵���Ŀ
			statusList.removeAll(statusList);
			paramMap.clear();
			statusList.add(ProjScheduleStatusEnum.Submit.getId());    
			statusList.add(ProjScheduleStatusEnum.FirstAudit.getId());
			statusList.add(ProjScheduleStatusEnum.SecondAudit.getId());
			//����
		    resultMap_ky=countChangeProj(resultMap_ky, count, paramMap, statusList, org, "ky");
			//�ص�ѧ��
			resultMap_xk=countChangeProj(resultMap_xk, count, paramMap, statusList, org, "xk");
			//�ص��˲�
			resultMap_rc=countChangeProj(resultMap_rc, count, paramMap, statusList, org, "rc");
			
			//����ֹ��˵���Ŀ
			statusList.removeAll(statusList);
			paramMap.clear();
			statusList.add(ProjCompleteStatusEnum.Submit.getId());    
			statusList.add(ProjCompleteStatusEnum.FirstAudit.getId());
			statusList.add(ProjCompleteStatusEnum.SecondAudit.getId());
			//����
		    resultMap_ky=countTerminateProj(resultMap_ky, count, paramMap, statusList, org, "ky");
			//�ص�ѧ��
			resultMap_xk=countTerminateProj(resultMap_xk, count, paramMap, statusList, org, "xk");
			//�ص��˲�
			resultMap_rc=countTerminateProj(resultMap_rc, count, paramMap, statusList, org, "rc");
			
			//��������˵���Ŀ
			statusList.removeAll(statusList);
			paramMap.clear();
			statusList.add(ProjScheduleStatusEnum.Submit.getId());    
			statusList.add(ProjScheduleStatusEnum.FirstAudit.getId());
			statusList.add(ProjScheduleStatusEnum.SecondAudit.getId());
			//����
		    resultMap_ky=countCompleteProj(resultMap_ky, count, paramMap, statusList, org, "ky");
			//�ص�ѧ��
			resultMap_xk=countCompleteProj(resultMap_xk, count, paramMap, statusList, org, "xk");
			//�ص��˲�
			resultMap_rc=countCompleteProj(resultMap_rc, count, paramMap, statusList, org, "rc");
			
			//����������
			statusList.removeAll(statusList);
			paramMap.clear();
			statusList.add(ProjCompleteStatusEnum.ThirdAudit.getId());
			//����
			resultMap_ky=countCompleteEvaProj(resultMap_ky, count, paramMap, statusList, org, "ky");
			//�ص�ѧ��
			resultMap_xk=countCompleteEvaProj(resultMap_xk, count, paramMap, statusList, org, "xk");
			//�ص��˲�
			resultMap_rc=countCompleteEvaProj(resultMap_rc, count, paramMap, statusList, org, "rc");
			
			//���鵵
			statusList.removeAll(statusList);
			paramMap.clear();
			statusList.add(ProjScheduleStatusEnum.ThirdAudit.getId());
			//����
			resultMap_ky=countArchiveProj(resultMap_ky, count, paramMap, statusList, org, "ky");
			//�ص�ѧ��
			resultMap_xk=countArchiveProj(resultMap_xk, count, paramMap, statusList, org, "xk");
			//�ص��˲�
			resultMap_rc=countArchiveProj(resultMap_rc, count, paramMap, statusList, org, "rc");
			
			resultMapList.add(resultMap_ky);
			resultMapList.add(resultMap_xk);
			resultMapList.add(resultMap_rc);
		    return resultMapList;
	}
	
	/**
	 * ���ܲ���
	 */
	@Override
	public List<Map<String, Integer>> selectCountProjCharge(SysOrg org) {
		SysUser currentUser = GlobalContext.getCurrentUser();
		String currentOrgFlow = currentUser.getOrgFlow();
		List<Map<String, Integer>> resultMapList=new LinkedList<Map<String,Integer>>();
		Map<String,Integer> resultMap_ky=new HashMap<String,Integer>();
		Map<String,Integer> resultMap_xk=new HashMap<String,Integer>();
		Map<String,Integer> resultMap_rc=new HashMap<String,Integer>();
		Integer count=null;
		Map<String,Object> paramMap=new HashMap<String, Object>();
		List<String> statusList=new ArrayList<String>(); 
		//���걨��˵���Ŀ����
		//����
		resultMap_ky=countApplyProj(resultMap_ky, count, paramMap, 
                                    GlobalConstant.RECORD_STATUS_Y, currentOrgFlow, 
                                    "ky",GlobalConstant.USER_LIST_CHARGE,
                                    ProjApplyStatusEnum.FirstAudit.getId(),
                                    ProjApplyStatusEnum.ThirdBack.getId(),
                                    "",currentOrgFlow);
		//�ص�ѧ��
		resultMap_xk=countApplyProj(resultMap_xk, count, paramMap, 
                                    GlobalConstant.RECORD_STATUS_Y, currentOrgFlow, 
                                    "xk",GlobalConstant.USER_LIST_CHARGE,
                                    ProjApplyStatusEnum.FirstAudit.getId(),
                                    ProjApplyStatusEnum.ThirdBack.getId(),
                                    "",currentOrgFlow);	
		//�ص��˲�
		resultMap_rc=countApplyProj(resultMap_rc, count, paramMap, 
                                    GlobalConstant.RECORD_STATUS_Y, currentOrgFlow, 
                                    "rc",GlobalConstant.USER_LIST_CHARGE,
                                    ProjApplyStatusEnum.FirstAudit.getId(),
                                    ProjApplyStatusEnum.ThirdBack.getId(),
                                    "",currentOrgFlow);		
		
		//����ͬ��˵�
		paramMap.clear();
		        //����
				resultMap_ky=countContractProj(resultMap_ky, count, paramMap, 
		                                    GlobalConstant.RECORD_STATUS_Y, currentOrgFlow, 
		                                    "ky",GlobalConstant.USER_LIST_CHARGE,
		                                    ProjApplyStatusEnum.FirstAudit.getId(),
		                                    ProjApplyStatusEnum.ThirdBack.getId(),
		                                    "",currentOrgFlow);
				//�ص�ѧ��
				resultMap_xk=countContractProj(resultMap_xk, count, paramMap, 
		                                    GlobalConstant.RECORD_STATUS_Y, currentOrgFlow, 
		                                    "xk",GlobalConstant.USER_LIST_CHARGE,
		                                    ProjApplyStatusEnum.FirstAudit.getId(),
		                                    ProjApplyStatusEnum.ThirdBack.getId(),
		                                    "",currentOrgFlow);	
				//�ص��˲�
				resultMap_rc=countContractProj(resultMap_rc, count, paramMap, 
		                                    GlobalConstant.RECORD_STATUS_Y, currentOrgFlow, 
		                                    "rc",GlobalConstant.USER_LIST_CHARGE,
		                                    ProjApplyStatusEnum.FirstAudit.getId(),
		                                    ProjApplyStatusEnum.ThirdBack.getId(),
		                                    "",currentOrgFlow);
		
		//����չ������˵�
		statusList.removeAll(statusList);
		paramMap.clear(); 
		statusList.add(ProjScheduleStatusEnum.FirstAudit.getId());
		//����
	    resultMap_ky=countScheduleProj(resultMap_ky, count, paramMap, statusList, org, "ky");
		//�ص�ѧ��
		resultMap_xk=countScheduleProj(resultMap_xk, count, paramMap, statusList, org, "xk");
		//�ص��˲�
		resultMap_rc=countScheduleProj(resultMap_rc, count, paramMap, statusList, org, "rc");
		
		//�������˵���Ŀ
		statusList.removeAll(statusList);
		paramMap.clear(); 
		statusList.add(ProjScheduleStatusEnum.FirstAudit.getId());
		//����
	    resultMap_ky=countChangeProj(resultMap_ky, count, paramMap, statusList, org, "ky");
		//�ص�ѧ��
		resultMap_xk=countChangeProj(resultMap_xk, count, paramMap, statusList, org, "xk");
		//�ص��˲�
		resultMap_rc=countChangeProj(resultMap_rc, count, paramMap, statusList, org, "rc");
		
		//����ֹ��˵���Ŀ
		statusList.removeAll(statusList);
		paramMap.clear();
		statusList.add(ProjCompleteStatusEnum.FirstAudit.getId());
		//����
	    resultMap_ky=countTerminateProj(resultMap_ky, count, paramMap, statusList, org, "ky");
		//�ص�ѧ��
		resultMap_xk=countTerminateProj(resultMap_xk, count, paramMap, statusList, org, "xk");
		//�ص��˲�
		resultMap_rc=countTerminateProj(resultMap_rc, count, paramMap, statusList, org, "rc");
		
		//��������˵���Ŀ
		statusList.removeAll(statusList);
		paramMap.clear();
		statusList.add(ProjCompleteStatusEnum.FirstAudit.getId());
		//����
	    resultMap_ky=countCompleteProj(resultMap_ky, count, paramMap, statusList, org, "ky");
		//�ص�ѧ��
		resultMap_xk=countCompleteProj(resultMap_xk, count, paramMap, statusList, org, "xk");
		//�ص��˲�
		resultMap_rc=countCompleteProj(resultMap_rc, count, paramMap, statusList, org, "rc");
		
		resultMapList.add(resultMap_ky);
		resultMapList.add(resultMap_xk);
		resultMapList.add(resultMap_rc);
		return resultMapList;
	}
	
	/**
	 * ҽԺ
	 */
	@Override
	public List<Map<String, Integer>> selectCountProjLocal(SysOrg org) {
		SysUser currentUser = GlobalContext.getCurrentUser();
		String currentOrgFlow = currentUser.getOrgFlow();
		List<Map<String, Integer>> resultMapList=new LinkedList<Map<String,Integer>>();
		Map<String,Integer> resultMap_ky=new HashMap<String,Integer>();
		Map<String,Integer> resultMap_xk=new HashMap<String,Integer>();
		Map<String,Integer> resultMap_rc=new HashMap<String,Integer>();
		Integer count=null;
		Map<String,Object> paramMap=new HashMap<String, Object>();
		List<String> statusList=new ArrayList<String>(); 
		//���걨��˵���Ŀ����
		//����
		resultMap_ky=countApplyProj(resultMap_ky, count, paramMap, 
                                    GlobalConstant.RECORD_STATUS_Y, currentOrgFlow, 
                                    "ky",GlobalConstant.USER_LIST_LOCAL,
                                    ProjApplyStatusEnum.Submit.getId(),
                                    ProjApplyStatusEnum.SecondBack.getId(),
                                    ProjApplyStatusEnum.ThirdBack.getId(),InitConfig.getSysCfg("global_org_flow"));
		//�ص�ѧ��
		resultMap_xk=countApplyProj(resultMap_xk, count, paramMap, 
                                    GlobalConstant.RECORD_STATUS_Y, currentOrgFlow, 
                                    "xk",GlobalConstant.USER_LIST_LOCAL,
                                    ProjApplyStatusEnum.Submit.getId(),
                                    ProjApplyStatusEnum.SecondBack.getId(),
                                    ProjApplyStatusEnum.ThirdBack.getId(),InitConfig.getSysCfg("global_org_flow"));	
		//�ص��˲�
		resultMap_rc=countApplyProj(resultMap_rc, count, paramMap, 
                                    GlobalConstant.RECORD_STATUS_Y, currentOrgFlow, 
                                    "rc",GlobalConstant.USER_LIST_LOCAL,
                                    ProjApplyStatusEnum.Submit.getId(),
                                    ProjApplyStatusEnum.SecondBack.getId(),
                                    ProjApplyStatusEnum.ThirdBack.getId(),InitConfig.getSysCfg("global_org_flow"));		
		
		
		//�����������
		statusList.removeAll(statusList);
		paramMap.clear();
		statusList.add(ProjApproveStatusEnum.Approving.getId());
		//����
		resultMap_ky=countApproveEvaProj(resultMap_ky, count, paramMap, statusList, org, "ky");
		//�ص�ѧ��
		resultMap_xk=countApproveEvaProj(resultMap_xk, count, paramMap, statusList, org, "xk");
		//�ص��˲�
		resultMap_rc=countApproveEvaProj(resultMap_rc, count, paramMap, statusList, org, "rc");
		
		//������������
		//����
		resultMap_ky=countApproveProj(resultMap_ky, count, paramMap, statusList, org, "ky");
		//�ص�ѧ��
		resultMap_xk=countApproveProj(resultMap_xk, count, paramMap, statusList, org, "xk");
		//�ص��˲�
		resultMap_rc=countApproveProj(resultMap_rc, count, paramMap, statusList, org, "rc");
		
		//����ͬ��˵�
		paramMap.clear();
		//����
				resultMap_ky=countContractProj(resultMap_ky, count, paramMap, 
		                                    GlobalConstant.RECORD_STATUS_Y, currentOrgFlow, 
		                                    "ky",GlobalConstant.USER_LIST_LOCAL,
		                                    ProjApplyStatusEnum.Submit.getId(),
		                                    ProjApplyStatusEnum.SecondBack.getId(),
		                                    ProjApplyStatusEnum.ThirdBack.getId(),InitConfig.getSysCfg("global_org_flow"));
				//�ص�ѧ��
				resultMap_xk=countContractProj(resultMap_xk, count, paramMap, 
		                                    GlobalConstant.RECORD_STATUS_Y, currentOrgFlow, 
		                                    "xk",GlobalConstant.USER_LIST_LOCAL,
		                                    ProjApplyStatusEnum.Submit.getId(),
		                                    ProjApplyStatusEnum.SecondBack.getId(),
		                                    ProjApplyStatusEnum.ThirdBack.getId(),InitConfig.getSysCfg("global_org_flow"));	
				//�ص��˲�
				resultMap_rc=countContractProj(resultMap_rc, count, paramMap, 
		                                    GlobalConstant.RECORD_STATUS_Y, currentOrgFlow, 
		                                    "rc",GlobalConstant.USER_LIST_LOCAL,
		                                    ProjApplyStatusEnum.Submit.getId(),
		                                    ProjApplyStatusEnum.SecondBack.getId(),
		                                    ProjApplyStatusEnum.ThirdBack.getId(),InitConfig.getSysCfg("global_org_flow"));		
		
		//����չ������˵�
		statusList.removeAll(statusList);
		paramMap.clear();
		statusList.add(ProjScheduleStatusEnum.Submit.getId());
		//����
	    resultMap_ky=countScheduleProj(resultMap_ky, count, paramMap, statusList, org, "ky");
		//�ص�ѧ��
		resultMap_xk=countScheduleProj(resultMap_xk, count, paramMap, statusList, org, "xk");
		//�ص��˲�
		resultMap_rc=countScheduleProj(resultMap_rc, count, paramMap, statusList, org, "rc");
	
		//�������˵���Ŀ
		statusList.removeAll(statusList);
		paramMap.clear();
		statusList.add(ProjScheduleStatusEnum.Submit.getId());  
		//����
	    resultMap_ky=countChangeProj(resultMap_ky, count, paramMap, statusList, org, "ky");
		//�ص�ѧ��
		resultMap_xk=countChangeProj(resultMap_xk, count, paramMap, statusList, org, "xk");
		//�ص��˲�
		resultMap_rc=countChangeProj(resultMap_rc, count, paramMap, statusList, org, "rc");
		
		//����ֹ��˵���Ŀ
		statusList.removeAll(statusList);
		paramMap.clear();
		statusList.add(ProjCompleteStatusEnum.Submit.getId()); 
		//����
	    resultMap_ky=countTerminateProj(resultMap_ky, count, paramMap, statusList, org, "ky");
		//�ص�ѧ��
		resultMap_xk=countTerminateProj(resultMap_xk, count, paramMap, statusList, org, "xk");
		//�ص��˲�
		resultMap_rc=countTerminateProj(resultMap_rc, count, paramMap, statusList, org, "rc");
		
		//��������˵���Ŀ
		statusList.removeAll(statusList);
		paramMap.clear();
		statusList.add(ProjCompleteStatusEnum.Submit.getId()); 
		//����
	    resultMap_ky=countCompleteProj(resultMap_ky, count, paramMap, statusList, org, "ky");
		//�ص�ѧ��
		resultMap_xk=countCompleteProj(resultMap_xk, count, paramMap, statusList, org, "xk");
		//�ص��˲�
		resultMap_rc=countCompleteProj(resultMap_rc, count, paramMap, statusList, org, "rc");
		
		//����������
		statusList.removeAll(statusList);
		paramMap.clear();
		statusList.add(ProjCompleteStatusEnum.FirstAudit.getId());
		//����
		resultMap_ky=countCompleteEvaProj(resultMap_ky, count, paramMap, statusList, org, "ky");
		//�ص�ѧ��
		resultMap_xk=countCompleteEvaProj(resultMap_xk, count, paramMap, statusList, org, "xk");
		//�ص��˲�
		resultMap_rc=countCompleteEvaProj(resultMap_rc, count, paramMap, statusList, org, "rc");
		
		//���鵵
		statusList.removeAll(statusList);
		paramMap.clear();
		statusList.add(ProjCompleteStatusEnum.FirstAudit.getId());
		//����
		resultMap_ky=countArchiveProj(resultMap_ky, count, paramMap, statusList, org, "ky");
		//�ص�ѧ��
		resultMap_xk=countArchiveProj(resultMap_xk, count, paramMap, statusList, org, "xk");
		//�ص��˲�
		resultMap_rc=countArchiveProj(resultMap_rc, count, paramMap, statusList, org, "rc");
		
		
		resultMapList.add(resultMap_ky);
		resultMapList.add(resultMap_xk);
		resultMapList.add(resultMap_rc);
		return resultMapList;
	}
    
	@Override
	public Map<String, Integer> selectCountSrmAchLocal(SysOrg org) {
		Map<String,Integer> srmAchMap=new HashMap<String,Integer>();
		Integer count=null;
		Map<String,Object> paramMap=new HashMap<String, Object>();
		List<String> statusList=new ArrayList<String>(); 
		//���������
		srmAchMap=countSrmMap(statusList, srmAchMap, paramMap, "SRM_ACH_THESIS", "Thesis", count, org);
	    //����˵�ר��
		srmAchMap=countSrmMap(statusList, srmAchMap, paramMap, "SRM_ACH_PATENT", "Patent", count, org);		
	    //����˵ļ���
		srmAchMap=countSrmMap(statusList, srmAchMap, paramMap, "SRM_ACH_APPRAISAL", "Appraisal", count, org);		
 		//����˵�����
		srmAchMap=countSrmMap(statusList, srmAchMap, paramMap, "SRM_ACH_BOOK", "Book", count, org);		
		//����˵�����Ȩ
		srmAchMap=countSrmMap(statusList, srmAchMap, paramMap, "SRM_ACH_COPYRIGHT", "Copyright", count, org);		
		//����˵��о�����
		srmAchMap=countSrmMap(statusList, srmAchMap, paramMap, "SRM_ACH_RESEACHREP", "Reseachrep", count, org);		
        //����˵ĿƼ�����
		srmAchMap=countSrmMap(statusList, srmAchMap, paramMap, "SRM_ACH_SAT", "Sat", count, org);		
		return srmAchMap;
	}
	/**
	 * ��֯���걨��˲�ѯ����
	 * @param resultMap
	 * @param count
	 * @param paramMap
	 * @param recordStatus
	 * @param orgFlow
	 * @param projCategoryId
	 * @param scope
	 * @param status1
	 * @param status2
	 * @param status3
	 * @param chargeOrgFlow
	 * @return
	 */
    public Map<String,Integer> countApplyProj(Map<String,Integer> resultMap,
    		                                  Integer count,Map<String,Object> paramMap,
    		                                  String recordStatus, String orgFlow,
    		                                  String projCategoryId,String scope,
    		                                  String status1,String status2,
    		                                  String status3,String chargeOrgFlow){
    	PubProj proj=new PubProj();
    	proj.setRecordStatus(recordStatus);
    	proj.setProjCategoryId(projCategoryId);
    	proj.setProjStageId(ProjStageEnum.Apply.getId());
    	paramMap.put("orgFlow", orgFlow);
    	paramMap.put("chargeOrgFlow", chargeOrgFlow);
		paramMap.put("proj", proj);
		paramMap.put("scope", scope);
		paramMap.put("status1", status1);
		paramMap.put("status2", status2);
		paramMap.put("status3", status3);
		count=projExtMapper.selectApplyAduitProjList(paramMap).size();
		if(count != 0){
			resultMap.put("apply", count);
		}
    	return resultMap;
    }
    /**
     * ��֯���������ѯ����
     * @param resultMap
     * @param count
     * @param paramMap
     * @param statusList
     * @param org
     * @param projCategoryId
     * @return
     */
    public Map<String,Integer> countApproveEvaProj(Map<String,Integer> resultMap,
            Integer count,Map<String,Object> paramMap,
            List<String> statusList,SysOrg org,
            String projCategoryId){
    	   
    	paramMap.put("chargeOrgFlow", org.getChargeOrgFlow());
    	paramMap.put("projCategoryId", projCategoryId);
		paramMap.put("projStatusId", statusList);
		paramMap.put("projStageId", ProjStageEnum.Approve.getId());
		paramMap.put("processApproveStageId", ProjStageEnum.Approve.getId());
		paramMap.put("processApproveStatusId", ProjEvaluationStatusEnum.Evaluation.getId());
		count=projExtMapper.selectCountProj(paramMap);
		if(count != 0){
			resultMap.put("approveEva", count);
		}
           return resultMap;
        }
    
    /**
     * ��֯���������ѯ����
     * @param resultMap
     * @param count
     * @param paramMap
     * @param statusList
     * @param org
     * @param projCategoryId
     * @return
     */
    public Map<String,Integer> countCompleteEvaProj(Map<String,Integer> resultMap,
            Integer count,Map<String,Object> paramMap,
            List<String> statusList,SysOrg org,
            String projCategoryId){
    	   
    	paramMap.put("recFlag", "true");
		paramMap.put("recTypeId", ProjRecTypeEnum.CompleteReport.getId());
		paramMap.put("projCategoryId", projCategoryId);
		paramMap.put("projStatusId", statusList);
		paramMap.put("projStageId", ProjStageEnum.Complete.getId());
		paramMap.put("processCompleteStageId", ProjStageEnum.Complete.getId());
		paramMap.put("processCompleteStatusId", ProjEvaluationStatusEnum.Evaluation.getId());
		paramMap.put("chargeOrgFlow", org.getChargeOrgFlow());
		count=projExtMapper.selectCountProj(paramMap);
		if(count != 0){
			resultMap.put("completeEva", count);
		}
           return resultMap;
        }
    
    
    /**
     * ��֯������������ѯ����
     * @param resultMap
     * @param count
     * @param paramMap
     * @param statusList
     * @param org
     * @param projCategoryId
     * @return
     */
    public Map<String,Integer> countApproveProj(Map<String,Integer> resultMap,
                                     Integer count,Map<String,Object> paramMap,
                                     List<String> statusList,SysOrg org,
                                     String projCategoryId){
    	statusList.removeAll(statusList);
		paramMap.clear();
		statusList.add(ProjApproveStatusEnum.Approving.getId());
    	paramMap.put("chargeOrgFlow", org.getChargeOrgFlow());
		paramMap.put("projStatusId", statusList);
		paramMap.put("projStageId", ProjStageEnum.Approve.getId());
		paramMap.put("projCategoryId", projCategoryId);
		count=projExtMapper.selectCountProj(paramMap);
		if(count != 0){
			resultMap.put("approve", count);
		}
    	return resultMap;
    }
    /**
     * ��֯��ͬ��˲�ѯ����
     * @param resultMap
     * @param count
     * @param paramMap
     * @param recordStatus
     * @param orgFlow
     * @param projCategoryId
     * @param scope
     * @param status1
     * @param status2
     * @param status3
     * @param chargeOrgFlow
     * @return
     */
    public Map<String,Integer> countContractProj(Map<String,Integer> resultMap,
            Integer count,Map<String,Object> paramMap,
            String recordStatus, String orgFlow,
            String projCategoryId,String scope,
            String status1,String status2,
            String status3,String chargeOrgFlow){
      PubProj proj=new PubProj();
      proj.setRecordStatus(recordStatus);
      proj.setProjCategoryId(projCategoryId);
      proj.setProjStageId(ProjStageEnum.Contract.getId());
      paramMap.put("orgFlow", orgFlow);
      paramMap.put("chargeOrgFlow", chargeOrgFlow);
      paramMap.put("proj", proj);
      paramMap.put("scope", scope);
      paramMap.put("status1", status1);
      paramMap.put("status2", status2);
      paramMap.put("status3", status3);
      count=projExtMapper.selectContractAduitProjList(paramMap).size();
      if(count != 0){
        resultMap.put("contract", count);
      }
      return resultMap;
}
    /**
     * ��֯��������ѯ����
     * @param resultMap
     * @param count
     * @param paramMap
     * @param statusList
     * @param org
     * @param projCategoryId
     * @return
     */
    public Map<String,Integer> countChangeProj(Map<String,Integer> resultMap,
            Integer count,Map<String,Object> paramMap,
            List<String> statusList,SysOrg org,
            String projCategoryId){

    	paramMap.put("recFlag", "true");
		paramMap.put("projStatusId", statusList);
		paramMap.put("projStageId", ProjStageEnum.Schedule.getId());
		paramMap.put("recTypeId", ProjRecTypeEnum.ChangeReport.getId());
		paramMap.put("chargeOrgFlow", org.getChargeOrgFlow());
		paramMap.put("projCategoryId", projCategoryId);
		count=projExtMapper.selectCountProj(paramMap);
		if(count != 0){
			resultMap.put("changeReport", count);
		}
		return resultMap;
    }
    
    /**
     * ��֯��չ�����ѯ����
     * @param resultMap
     * @param count
     * @param paramMap
     * @param statusList
     * @param org
     * @param projCategoryId
     * @return
     */
    public Map<String,Integer> countScheduleProj(Map<String,Integer> resultMap,
            Integer count,Map<String,Object> paramMap,
            List<String> statusList,SysOrg org,
            String projCategoryId){

    	paramMap.put("recFlag", "true");
		paramMap.put("projStatusId", statusList);
		paramMap.put("projStageId", ProjStageEnum.Schedule.getId());
		paramMap.put("recTypeId", ProjRecTypeEnum.ScheduleReport.getId());
		paramMap.put("chargeOrgFlow", org.getChargeOrgFlow());
		paramMap.put("projCategoryId", projCategoryId);
		count=projExtMapper.selectCountProj(paramMap);
		if(count != 0){
			resultMap.put("scheduleReport", count);
		}
		return resultMap;
    }
    
    /**
     * ��֯���ձ����ѯ����
     * @param resultMap
     * @param count
     * @param paramMap
     * @param statusList
     * @param org
     * @param projCategoryId
     * @return
     */
    public Map<String,Integer> countCompleteProj(Map<String,Integer> resultMap,
            Integer count,Map<String,Object> paramMap,
            List<String> statusList,SysOrg org,
            String projCategoryId){
       
    	paramMap.put("recFlag", "true");
		paramMap.put("projStatusId", statusList);
		paramMap.put("projStageId", ProjStageEnum.Complete.getId());
		paramMap.put("recTypeId", ProjRecTypeEnum.CompleteReport.getId());
		paramMap.put("chargeOrgFlow", org.getChargeOrgFlow());
		paramMap.put("projCategoryId", projCategoryId);
		count=projExtMapper.selectCountProj(paramMap);
		if(count != 0){
			resultMap.put("completeReport", count);
		}
		return resultMap;
    }
    
    /**
     * ��֯��ֹ�����ѯ����
     * @param resultMap
     * @param count
     * @param paramMap
     * @param statusList
     * @param org
     * @param projCategoryId
     * @return
     */
    public Map<String,Integer> countTerminateProj(Map<String,Integer> resultMap,
            Integer count,Map<String,Object> paramMap,
            List<String> statusList,SysOrg org,
            String projCategoryId){

    	paramMap.put("recFlag", "true");
		paramMap.put("projStatusId", statusList);
		paramMap.put("projStageId", ProjStageEnum.Complete.getId());
		paramMap.put("recTypeId", ProjRecTypeEnum.TerminateReport.getId());
		paramMap.put("chargeOrgFlow", org.getChargeOrgFlow());
		paramMap.put("projCategoryId", projCategoryId);
		count=projExtMapper.selectCountProj(paramMap);
		if(count != 0){
			resultMap.put("terminateReport", count);
		}
		return resultMap;
    }
    
    /**
     * ��֯�鵵��ѯ����
     * @param resultMap
     * @param count
     * @param paramMap
     * @param statusList
     * @param org
     * @param projCategoryId
     * @return
     */
    public Map<String,Integer> countArchiveProj(Map<String,Integer> resultMap,
            Integer count,Map<String,Object> paramMap,
            List<String> statusList,SysOrg org,
            String projCategoryId){

    	paramMap.put("projStatusId", statusList);
		paramMap.put("projStageId", ProjStageEnum.Complete.getId());
		paramMap.put("chargeOrgFlow", org.getChargeOrgFlow());
		paramMap.put("projCategoryId", projCategoryId);
		count=projExtMapper.selectCountProj(paramMap);
		if(count != 0){
			resultMap.put("archive", count);
		}
		return resultMap;
    }
	/**
	 * ��֯���гɹ���ѯ����
	 * @param statusList
	 * @param srmAchMap
	 * @param paramMap
	 * @param tableName
	 * @param type
	 * @param count
	 * @param org
	 * @return
	 */
	public Map<String,Integer> countSrmMap(List<String> statusList,
			                               Map<String,Integer> srmAchMap,
			                               Map<String,Object> paramMap,
			                               String tableName,String type,
			                               Integer count,SysOrg org){
		statusList.removeAll(statusList);
		paramMap.clear();
		statusList.add(AchStatusEnum.Submit.getId());
		paramMap.put("operStatusId", statusList);
		paramMap.put("applyOrgFlow", org.getChargeOrgFlow());
		paramMap.put("tableName", tableName);
		count=projExtMapper.selectCountSrmAch(paramMap);
		if(count !=0){
			srmAchMap.put(type, count);
		}
		return srmAchMap;
	}
	
	
   //ͳ�Ʋμ��������Ŀ������
	@Override
	public int selectProjInExpertAll() {
		SysUser currUser = GlobalContext.getCurrentUser();
		List<PubProjCountExt> projCountExtList=projExtMapper.selectProjCountInExpert(currUser.getOrgFlow());
		if(null!=projCountExtList && !projCountExtList.isEmpty()){
			int count = 0;
		    for(PubProjCountExt projCountExt:projCountExtList){
			count=count+Integer.parseInt(projCountExt.getProjCount());
		    }
		    return count;
		}else{
			return GlobalConstant.ZERO_LINE;
		}
		
	}
   //ͳ��ͨ���������Ŀ����
	@Override
	public int selectProjApproveAll() {
		SysUser currUser = GlobalContext.getCurrentUser();
		String scope=(String) GlobalContext.getSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE);
		HashMap<String,String> map=new HashMap<String, String>();
		map.put("orgFlow", currUser.getOrgFlow());
		map.put("projStageId", ProjStageEnum.Approve.getId());
		map.put("projStatusId", ProjApproveStatusEnum.Approve.getId());
		map.put("projCategoryId","ky");
		map.put("scope", scope);
		map.put("processFlag", GlobalConstant.FLAG_Y);
		List<PubProjCountExt> projCountExtList=projExtMapper.selectRoundStageStatus(map);
		if(null!=projCountExtList && !projCountExtList.isEmpty()){
			int count = 0;
		    for(PubProjCountExt projCountExt:projCountExtList){
			count=count+Integer.parseInt(projCountExt.getProjCount());
		    }
		    return count;
		}else{
			return GlobalConstant.ZERO_LINE;
		}
	}
   //ͳ�����ͨ������Ŀ����
	@Override
	public int selectProjNotApproveAll() {
		SysUser currUser = GlobalContext.getCurrentUser();
		String scope=(String) GlobalContext.getSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE);
		HashMap<String,String> map=new HashMap<String, String>();
		map.put("orgFlow", currUser.getOrgFlow());
		map.put("projStageId", ProjStageEnum.Approve.getId());
		map.put("projStatusId", ProjApproveStatusEnum.NotApprove.getId());
		map.put("projCategoryId","ky");
		map.put("scope", scope);
		map.put("processFlag", GlobalConstant.FLAG_Y);
		List<PubProjCountExt> projCountExtList=projExtMapper.selectRoundStageStatus(map);
		if(null!=projCountExtList && !projCountExtList.isEmpty()){
			int count = 0;
		    for(PubProjCountExt projCountExt:projCountExtList){
			count=count+Integer.parseInt(projCountExt.getProjCount());
		    }
		    return count;
		}else{
			return GlobalConstant.ZERO_LINE;
		}
		
	}
    //ͳ���걨���ͨ������Ŀ����
	@Override
	public int selectProjApply() {
		SysUser currUser = GlobalContext.getCurrentUser();
	    String scope=(String) GlobalContext.getSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE);
	    HashMap<String,String> map=new HashMap<String, String>();
	    map.put("scope", scope);
	    map.put("orgFlow", currUser.getOrgFlow());
	    map.put("projStageId", ProjStageEnum.Apply.getId());
		map.put("projStatusId", ProjApplyStatusEnum.ThirdAudit.getId());
		map.put("projCategoryId","ky");
		map.put("processFlag", GlobalConstant.FLAG_Y);
		List<PubProjCountExt> projCountExtList=projExtMapper.selectRoundStageStatus(map);
		if(null!=projCountExtList && !projCountExtList.isEmpty()){
			int count = 0;
		    for(PubProjCountExt projCountExt:projCountExtList){
			count=count+Integer.parseInt(projCountExt.getProjCount());
		    }
		    return count;
		}else{
			return GlobalConstant.ZERO_LINE;
		}	
		
	}

	@Override
	public int selectProjComplete() {
    	SysUser currUser = GlobalContext.getCurrentUser();
	    String scope=(String) GlobalContext.getSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE);
	    HashMap<String,String> map=new HashMap<String, String>();
	    map.put("scope", scope);
	    map.put("orgFlow", currUser.getOrgFlow());
	    map.put("projStageId", ProjStageEnum.Complete.getId());
		map.put("projStatusId", ProjApplyStatusEnum.ThirdAudit.getId());
		map.put("processFlag", GlobalConstant.FLAG_Y);
		map.put("projCategoryId","ky");
		List<PubProjCountExt> projCountExtList=projExtMapper.selectRoundStageStatus(map);
		if(null!=projCountExtList && !projCountExtList.isEmpty()){
			int count = 0;
		    for(PubProjCountExt projCountExt:projCountExtList){
			count=count+Integer.parseInt(projCountExt.getProjCount());
		    } 
		    return count;
		}else{
			return GlobalConstant.ZERO_LINE;
		}	
	}

	@Override
	public List<PubProjCountExt> selectProjGroupByOrg() {
		SysUser currUser = GlobalContext.getCurrentUser();
	    String scope=(String) GlobalContext.getSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE);
	    HashMap<String,String> map=new HashMap<String, String>();
	    map.put("scope", scope);
	    map.put("orgFlow", currUser.getOrgFlow());
	    map.put("projStageId", ProjStageEnum.Approve.getId());
		map.put("projStatusId", ProjApproveStatusEnum.Approve.getId());
		map.put("processFlag", GlobalConstant.FLAG_Y);
		map.put("projCategoryId","ky");
		List<PubProjCountExt> projCountExtList=projExtMapper.selectRoundStageStatus(map);
		List<PubProjCountExt> projDirectCountExtList=projExtMapper.selectProjDirect(map);
		projCountExtList.addAll(projDirectCountExtList);
		return projCountExtList;
		
		
	}

	@Override
	public List<SrmAchCountExt> selectSrmAchByOrg() {
		List<SrmAchCountExt> srmAchCountList=new ArrayList<SrmAchCountExt>();
		//����
		List<SrmAchCountExt> thesisCountList=selectSrmAchByTypeId("srm_ach_thesis", "thesis",false);
		//ר��
		List<SrmAchCountExt> patentCountList=selectSrmAchByTypeId("srm_ach_patent", "patent",false);
		//����
		List<SrmAchCountExt> appraisalCountList=selectSrmAchByTypeId("srm_ach_appraisal", "appraisal",false);
		//����
		List<SrmAchCountExt> bookCountList=selectSrmAchByTypeId("srm_ach_book", "book",false);
		//����Ȩ
		List<SrmAchCountExt> copyrightCountList=selectSrmAchByTypeId("srm_ach_copyright", "copyright",false);
		//�о�����
		List<SrmAchCountExt> reseachrepCountList=selectSrmAchByTypeId("srm_ach_reseachrep", "reseachrep",false);
		//�Ƽ�
		List<SrmAchCountExt> satCountList=selectSrmAchByTypeId("srm_ach_sat", "sat", false);
	    
		if(null!=thesisCountList && !thesisCountList.isEmpty()){
	    	srmAchCountList.addAll(thesisCountList);
	    }
	    if(null!=patentCountList && !patentCountList.isEmpty()){
	    	srmAchCountList.addAll(patentCountList);
	    }
	    if(null!=appraisalCountList && !appraisalCountList.isEmpty()){
	    	srmAchCountList.addAll(appraisalCountList);
	    }
	    if(null!=bookCountList && !bookCountList.isEmpty()){
	    	srmAchCountList.addAll(bookCountList);
	    }
	    if(null!=copyrightCountList && !copyrightCountList.isEmpty()){
	    	srmAchCountList.addAll(copyrightCountList);
	    }
	    if(null!=reseachrepCountList && !reseachrepCountList.isEmpty()){
	    	srmAchCountList.addAll(reseachrepCountList);
	    }
	    if(null!=satCountList && !satCountList.isEmpty()){
	    	srmAchCountList.addAll(satCountList);
	    }
		return srmAchCountList;
	}

	@Override
	public List<SrmAchCountExt> selectSrmAchByTypeId(String table,
			String tableName,Boolean sumFlag) {
		SysUser currUser = GlobalContext.getCurrentUser();
	    String scope=(String) GlobalContext.getSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE);
		HashMap<String,String> map=new HashMap<String, String>();
		map.put("scope", scope);
		map.put("orgFlow", currUser.getOrgFlow());
		map.put("table", table);
		map.put("tableName", tableName);
		if(sumFlag){
	    map.put("sumFlag", "sumFlag");
		}
		return  srmAchCountExtMapper.selectSrmAch(map);
		
	}

	@Override
	public List<AidTalents> selectAidTalentsByOrg(AidTalents aidTalents) {
		SysUser currUser = GlobalContext.getCurrentUser();
		List<SysOrg> orgList=orgBiz.searchChildrenOrgByOrgFlow(currUser.getOrgFlow());
		AidTalentsExample example=new AidTalentsExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(aidTalents.getStatusId())){
			criteria.andStatusIdEqualTo(aidTalents.getStatusId());
		}
		List<AidTalents> talentsList=aidTalentsMapper.selectByExample(example);
		if(null!=orgList && !orgList.isEmpty()){
			List<String> orgFlowList=new ArrayList<String>();
			List<AidTalents> needRemoveList=new ArrayList<AidTalents>();
			for(SysOrg org:orgList){
				orgFlowList.add(org.getOrgFlow());
			}
			for(AidTalents talents:talentsList){
				if(!orgFlowList.contains(talents.getOrgFlow())){
					needRemoveList.add(talents);
				}
			}
		  talentsList.removeAll(needRemoveList);
		}
		
		return talentsList;
	}

	@Override
	public List<SysUser> selectRegedUser(SysUser sysUser) {
		SysUser currUser = GlobalContext.getCurrentUser();
		List<SysOrg> orgList=orgBiz.searchChildrenOrgByOrgFlow(currUser.getOrgFlow());
		SysUserExample example=new SysUserExample();
		com.pinde.sci.model.mo.SysUserExample.Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(sysUser.getStatusId())){
			criteria.andStatusIdEqualTo(sysUser.getStatusId());
		}
		List<SysUser> userList=userMapper.selectByExample(example);
		if(null!=orgList && !orgList.isEmpty()){
			List<String> orgFlowList=new ArrayList<String>();
			List<SysUser> needRemoveList=new ArrayList<SysUser>();
			for(SysOrg org:orgList){
				orgFlowList.add(org.getOrgFlow());
			}
			for(SysUser user:userList){
				if(!orgFlowList.contains(user.getOrgFlow())){
					needRemoveList.add(user);
				}
			}
			userList.removeAll(needRemoveList);
		}
		return userList;
	}

	@Override
	public Integer findDealBudgetAuditProjCount() {
		SrmProjFundInfoExample example = new SrmProjFundInfoExample();
		example.createCriteria()
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andBudgetStatusIdEqualTo(AchStatusEnum.Submit.getId());
		return projFundInfoMapper.countByExample(example);
	}

	@Override
	public Integer findDealPaymentAuditCount() {
		SrmProjFundDetailExample example = new SrmProjFundDetailExample();
		example.createCriteria()
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andFundTypeIdEqualTo(ProjFundTypeEnum.Reimburse.getId())
		.andOperStatusIdEqualTo(AchStatusEnum.Submit.getId());
		return projFundDetailMapper.countByExample(example);
	}
	   
	   
}
