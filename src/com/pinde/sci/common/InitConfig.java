package com.pinde.sci.common;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.config.*;
import com.pinde.core.jspform.PageGroup;
import com.pinde.core.jspform.PageGroupParse;
import com.pinde.core.license.PdLicense;
import com.pinde.core.util.*;
import com.pinde.sci.biz.irb.IIrbInfoBiz;
import com.pinde.sci.biz.sys.*;
import com.pinde.sci.common.util.RegionUtil;
import com.pinde.sci.enums.gcp.GcpRecTypeEnum;
import com.pinde.sci.enums.irb.IrbRecTypeEnum;
import com.pinde.sci.enums.res.ResRecTypeEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.irb.CodeValues;
import com.pinde.sci.model.irb.IrbFormRequestUtil;
import com.pinde.sci.model.irb.IrbSingleForm;
import com.pinde.sci.model.mo.*;

import org.apache.commons.io.FileUtils;
import org.dom4j.Attribute;
import org.dom4j.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

/**
 * ϵͳ��ʼ������
 * 
 * @author shijian
 * @create 2014.04.2
 */
public class InitConfig implements ServletContextListener {

	private final static Logger logger = LoggerFactory.getLogger(InitConfig.class);
	
	public static boolean licenseed = false;	

	public void contextDestroyed(ServletContextEvent event) {
	}

	/** ��ʼ����� */
	public void contextInitialized(ServletContextEvent event) {
		logger.debug("ϵͳ��ʼ��...");		
		ServletContext context = event.getServletContext();
		//�����ֵ�
		_loadDict(context);
		//����ϵͳ����
		_loadEnum(context);
		//���ؽ�ɫ
		_loadRole(context);
		//���ػ���
		_loadOrg(context);
		//���ز���
		_loadDept(context);	
		//���ؿ�������
		_loadSrmCfg(context);	
		//������������
		_loadIrbCfg(context);
		//����GCP����
		_loadGcpCfg(context);
		//����ϵͳ����
		_loadSysCfg(context);
		//��������ίԱ��
		_loadIrb(context);
		//����סԺҽʦ����
		_loadResCfg(context);
		//У��License
		_checkLicense(context);
		//���ع���վ
		_loadWorkStation(context);
		//����ʡ�й�ϵ
		_getCityMap();
	}

	public static void refresh(ServletContext context){
		logger.debug("��ʼˢ���ڴ�...");
		//���ع���վ
		_loadWorkStation(context);
		//�����ֵ�
		_loadDict(context);
		//����ϵͳ����
		_loadEnum(context);
		//���ؽ�ɫ
		_loadRole(context);
		//���ػ����Ͳ���
		//���ػ���
		_loadOrg(context);
		//���ز���
		_loadDept(context);
		//���ؿ�������
		_loadSrmCfg(context);	
		//���ؿ�������
		_loadIrbCfg(context);
		//����ϵͳ����
		_loadSysCfg(context);
		//��������ίԱ��
		_loadIrb(context);
		//����סԺҽʦ����
		_loadResCfg(context);
		//У��License
		_checkLicense(context);
		//���ع���վ
		_loadWorkStation(context);
		//����ʡ�й�ϵ
		_getCityMap();
	}
	

	private static void _checkLicense(ServletContext context){		
		logger.debug("��ʼLicense��֤...");
        String licenseStringEncoded = getSysCfg("license.key");
        licenseed = PdLicense.checkLicense(licenseStringEncoded);
        logger.debug("�����ݿ����license.key�ļ�,���ؽ����"+licenseed);
        if(licenseed==false){
            logger.debug("��classpath����license.key�ļ�");
            try {
                File licenseFile = SpringUtil.getResource("classpath:license.key").getFile();
                licenseStringEncoded = FileUtils.readFileToString(licenseFile);
                licenseed = PdLicense.checkLicense(licenseStringEncoded);
                logger.debug("��classpath����license.key�ļ�,���ؽ����"+licenseed);
            } catch (IOException e) {
                logger.debug("��classpath����license.key�ļ�ʧ��",e);
            }
        }

		context.setAttribute("licenseed", licenseed);
		context.setAttribute("machineId", PdLicense.getMachineId());
		context.setAttribute("licenseedWorkStation", PdLicense.getLicensedWorkStation());
		context.setAttribute("issueDate", PdLicense.getIssueDate());
		context.setAttribute("validDate", PdLicense.getValidDate());
		logger.debug("License��֤�����" + licenseed);
		if (licenseed == false) {
			logger.debug("ϵͳLicenseУ��ʧ�ܣ���������ϵͳ...");
//			throw new RuntimeException("ϵͳLicenseУ��ʧ�ܣ���������ϵͳ...");
		}
	}
	

	
	private static Map<String,WorkStation> workStationMap;
	
	public static String getWorkStationName(String workStationId){
		if(workStationMap!=null){
			WorkStation workStation = workStationMap.get(workStationId);
			if(workStation!=null){
				return workStation.getWorkStationName();
			}
		}
		return null;		
	}
	
	public static WorkStation getWorkStation(String workStationId){
		if(workStationMap!=null){
			return workStationMap.get(workStationId);
		}
		return null;		
	}
	
	private static Map<String,WorkStation> menuWorkStationMap;
	
	public static String getWorkStationIdByMenuId(String menuId){
		if(menuWorkStationMap!=null){
			WorkStation workStation = menuWorkStationMap.get(menuId);
			if(workStation!=null){
				return workStation.getWorkStationId();
			}
		}
		return null;		
	}
	
	private static Map<String,Module> menuModuleMap;	
	public static String getModuleIdByMenuId(String menuId){
		if(menuModuleMap!=null){
			Module module = menuModuleMap.get(menuId);
			if(module!=null){
				return module.getModuleId();
			}
		}
		return null;		
	}
	
	private static Map<String,MenuSet> menuSetMap;
	public static String getMenuSetIdByMenuId(String menuId){
		if(menuSetMap!=null){
			MenuSet menuSet = menuSetMap.get(menuId);
			if(menuSet!=null){
				return menuSet.getSetId();
			}
		}
		return null;		
	}
	
	private static void _loadWorkStation(ServletContext context) {
		logger.debug("��ʼ���ع���վ�����ļ�...");
		try {
			WorkStationParse parse = new WorkStationParse(SpringUtil.getResource("classpath:workStation.xml").getFile());
			//ֻ������Ȩ�Ĺ���վ
			List<WorkStation> workStationList = parse.parse();
			List<String> licensedWorkStation =  PdLicense.getLicensedWorkStation(); 
			List<WorkStation> workStationLicenseList = new ArrayList<WorkStation>();
			for(WorkStation workStation : workStationList){
				if(licensedWorkStation.contains(workStation.getWorkStationId())){
					workStationLicenseList.add(workStation);					
				}
			}			

			Map<String,WorkStation> menuWorkStationMap = new HashMap<String, WorkStation>();
			Map<String,Module> menuModuleMap = new HashMap<String, Module>();
			Map<String,MenuSet> menuSetMap = new HashMap<String, MenuSet>();
			Map<String,WorkStation> workStationMap = new HashMap<String, WorkStation>();
//			int imodule = 1;

//			IDictBiz dictBiz = (IDictBiz) SpringUtil.getBean(IDictBiz.class);
			for(WorkStation workStation : workStationLicenseList){
				workStationMap.put(workStation.getWorkStationId(), workStation);				
				List<Module> moduleList = workStation.getModuleList();
				for(Module module : moduleList){
					//�����ݿ⣬��ģ������û�б����¶���
//					SysDict moduleDict = dictBiz.readDict(DictTypeEnum.SysModule.getId(), module.getModuleId());
//					if(moduleDict==null){
//						SysDict dict = new SysDict();
//						dict.setDictTypeId(DictTypeEnum.SysModule.getId());
//						dict.setDictTypeName(DictTypeEnum.SysModule.getName());
//						dict.setDictId(module.getModuleId());
//						dict.setDictName(module.getModuleName());
//						dict.setOrdinal(imodule++);
//						dict.setDictDesc(module.getModuleName());
//						dictBiz.addDict(dict);
//					}else{
//						if(GlobalConstant.RECORD_STATUS_Y.equals(moduleDict.getRecordStatus())){
////							module.setModuleName(moduleDict.getDictName());
//						}
//					}					
					
					int imenuset = 1;
					
					List<MenuSet> menuSetList = module.getMenuSetList();
					for(MenuSet menuSet : menuSetList){
						//�����ݿ⣬��һ���˵���û�б����¶���
//						SysDict menuSetDict = dictBiz.readDict(DictTypeEnum.SysModule.getId()+"."+module.getModuleId(), menuSet.getSetId());
//						if(menuSetDict==null){
//							SysDict dict = new SysDict();
//							dict.setDictTypeId(DictTypeEnum.SysModule.getId()+"."+module.getModuleId());
//							dict.setDictTypeName(menuSet.getSetName());
//							dict.setDictId(menuSet.getSetId());
//							dict.setDictName(menuSet.getSetName());
//							dict.setOrdinal(Integer.parseInt(imodule+""+(imenuset++)));
//							dict.setDictDesc(menuSet.getSetName());
//							dictBiz.addDict(dict);
//						}else{
//							if(GlobalConstant.RECORD_STATUS_Y.equals(menuSetDict.getRecordStatus())){
////								menuSet.setSetName(menuSetDict.getDictName());
//							}
//						}	
						
						int imenu = 1;
						
						List<Menu> menuList = menuSet.getMenuList();
						for(Menu menu : menuList){
							//�����ݿ⣬�������˵�����û�б����¶���
//							SysDict menuDict = dictBiz.readDict(DictTypeEnum.SysModule.getId()+"."+module.getModuleId()+"."+menuSet.getSetId(), menu.getMenuId());
//							if(menuDict==null){
//								SysDict dict = new SysDict();
//								dict.setDictTypeId(DictTypeEnum.SysModule.getId()+"."+module.getModuleId()+"."+menuSet.getSetId());
//								dict.setDictTypeName(menu.getMenuName());
//								dict.setDictId(menu.getMenuId());
//								dict.setDictName(menu.getMenuName());
//								dict.setOrdinal(Integer.parseInt(imodule+""+imenuset+""+(imenu++)));
//								dict.setDictDesc(menu.getMenuName());
//								dictBiz.addDict(dict);
//							}else{
//								if(GlobalConstant.RECORD_STATUS_Y.equals(menuDict.getRecordStatus())){
////									menu.setMenuName(menuDict.getDictName());
//								}
//							}	
							
							menuModuleMap.put(menu.getMenuId(), module);
							menuSetMap.put(menu.getMenuId(), menuSet);
							menuWorkStationMap.put(menu.getMenuId(), workStation);
						}
					}
				}
			}
			context.setAttribute("workStationList", workStationLicenseList);
//			GlobalContext.workStationList = workStationLicenseList;
			context.setAttribute("workStationMap", workStationMap);
			context.setAttribute("allWorkStation", workStationList);
			InitConfig.workStationMap = workStationMap;
			InitConfig.menuWorkStationMap = menuWorkStationMap;
			InitConfig.menuModuleMap = menuModuleMap;
			InitConfig.menuSetMap = menuSetMap;
		} catch (Exception e) {
			logger.error("ϵͳ����վ����ʧ�ܣ���������ϵͳ...",e);
			throw new RuntimeException("ϵͳ����վ����ʧ�ܣ���������ϵͳ...");	
		} 
	}
	
	private static Map<String,Map<String,String>> sysDictNameMap;
	private static void _loadDict(ServletContext context) {
		Map<String,List<SysDict>>  sysListDictMap = new HashMap<String, List<SysDict>>();
		Map<String,String>  sysDictIdMap = new HashMap<String,String>();
		Map<String,Map<String,String>> sysDictNameMap=new HashMap<String, Map<String,String>>();
		@SuppressWarnings("unchecked")
		List<DictTypeEnum> dictTypeEnumList = (List<DictTypeEnum>) EnumUtil.toList(DictTypeEnum.class);
		for(DictTypeEnum dictTypeEnum : dictTypeEnumList){		
			String dictTypeId = dictTypeEnum.getId();
			Map<String,String> dictNameMap=new HashMap<String, String>();
			sysDictNameMap.put(dictTypeId, dictNameMap);
			IDictBiz dictBiz = (IDictBiz) SpringUtil.getBean(IDictBiz.class);
			
			SysDict sysDict = new SysDict();
			sysDict.setDictTypeId(dictTypeId);
			sysDict.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			
			List<SysDict> sysDictList = dictBiz.searchDictList(sysDict);
			for(SysDict dict : sysDictList){
				String typeId = dict.getDictTypeId()+"."+dict.getDictId();
				sysDictIdMap.put(typeId, dict.getDictName());
				dictNameMap.put(dict.getDictName(), dict.getDictId());
				if(dictTypeEnum.getLevel()>1){
					sysDict.setDictTypeId(typeId);
					List<SysDict> sysDictSecondList = dictBiz.searchDictList(sysDict);
					
					if(sysDictSecondList!=null && sysDictSecondList.size()>0){
						for(SysDict sDict : sysDictSecondList){
							String tTypeId = typeId+"."+sDict.getDictId();
							String tTypeName = dict.getDictName()+"."+sDict.getDictName();
							
							sysDictIdMap.put(tTypeId,tTypeName);
							
							if(dictTypeEnum.getLevel()>2){
								sysDict.setDictTypeId(tTypeId);
								List<SysDict> sysDictThirdList = dictBiz.searchDictList(sysDict);
								
								if(sysDictThirdList!=null && sysDictThirdList.size()>0){
									for(SysDict tDict : sysDictThirdList){
										sysDictIdMap.put(tTypeId+"."+tDict.getDictId(),tTypeName+"."+tDict.getDictName());
									}
								}
								
								sysListDictMap.put(tTypeId, sysDictThirdList);
								context.setAttribute("dictTypeEnum"+tTypeId+"List", sysDictThirdList);
							}
							
						}
					}
					
					sysListDictMap.put(typeId, sysDictSecondList);
					context.setAttribute("dictTypeEnum"+typeId+"List", sysDictSecondList);
				}
			}

			sysListDictMap.put(dictTypeId, sysDictList);
			context.setAttribute("dictTypeEnum"+dictTypeEnum.name()+"List", sysDictList);
		}
//		GlobalContext.sysDictListMap = sysListDictMap;
		InitConfig.sysDictNameMap=sysDictNameMap;
		DictTypeEnum.sysDictIdMap = sysDictIdMap;
		DictTypeEnum.sysListDictMap = sysListDictMap;
	}
	
	public static Map<String,String> getDictNameMap(String dictTypeId){
	    if(sysDictNameMap!=null){
	    	return sysDictNameMap.get(dictTypeId);
	    }
		return null;
	}
	
	private static void _loadEnum(ServletContext context){
		Set<Class<?>> set = ClassUtil.getClasses("com.pinde.sci.enums");
		for(Class<?> cls : set){		
			@SuppressWarnings({ "unchecked", "rawtypes" })
			List<GeneralEnum> enumList = (List<GeneralEnum>) EnumUtil.toList((Class<? extends GeneralEnum>) cls);
			context.setAttribute(StringUtil.uncapitalize(cls.getSimpleName())+"List", enumList);
			for(@SuppressWarnings("rawtypes") GeneralEnum genum : enumList){	
				context.setAttribute(StringUtil.uncapitalize(cls.getSimpleName()) +genum.name(), genum);			
			}			
		}	
	}
	private static Map<String,SysRole> sysRoleMap ; 
	private static Map<String,List<SysRole>> sysRoleWsMap ;
	
	public static SysRole getSysRole(String orgFlow){
		if(sysRoleMap!=null){
			SysRole sysRole = sysRoleMap.get(orgFlow);
//			if(sysRole!=null){
//				return sysRole.getRoleName();
//			}
			return sysRole;
		}
		return null;		
	} 
	
	public static void _loadRole(ServletContext context) {
		Map<String,SysRole> sysRoleMap = new HashMap<String, SysRole>();
		Map<String,List<SysRole>> sysRoleWsMap = new HashMap<String,List<SysRole>>();
		IRoleBiz roleBiz = (IRoleBiz) SpringUtil.getBean(IRoleBiz.class);		
		List<SysRole> sysRoleList = roleBiz.search(new SysRole());
		for(SysRole sysRole : sysRoleList){
			sysRoleMap.put(sysRole.getRoleFlow(), sysRole);			
			List<SysRole> roleList = sysRoleWsMap.get(sysRole.getWsId());
			if(roleList == null){
				roleList = new ArrayList<SysRole>();
			}
			roleList.add(sysRole);
			sysRoleWsMap.put(sysRole.getWsId(), roleList);
		}	
		InitConfig.sysRoleMap = sysRoleMap;
		InitConfig.sysRoleWsMap = sysRoleWsMap;
		context.setAttribute("sysRoleMap",sysRoleMap);		
		context.setAttribute("sysRoleWsMap",sysRoleWsMap);
	}
	
	private static Map<String,SysOrg> sysOrgMap ;
	private static Map<String,SysOrg> sysOrgNameMap ;
	private static List<SysOrg> sysOrgList ;
	public static String getOrgNameByFlow(String orgFlow){
		if(sysOrgMap!=null){
			SysOrg sysOrg = sysOrgMap.get(orgFlow);
			if(sysOrg!=null){
				return sysOrg.getOrgName();
			}
		}
		return null;		
	} 

	public static void _loadOrg(ServletContext context) {
		Map<String,SysOrg> sysOrgMap = new HashMap<String, SysOrg>();
		Map<String,SysOrg> sysOrgNameMap = new HashMap<String, SysOrg>();
		IOrgBiz orgBiz = (IOrgBiz) SpringUtil.getBean(IOrgBiz.class);	
		SysOrg search = new SysOrg();
		search.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysOrg> sysOrgList = orgBiz.searchOrg(search);
		for(SysOrg sysOrg : sysOrgList){
			sysOrgMap.put(sysOrg.getOrgFlow(), sysOrg);
			sysOrgNameMap.put(sysOrg.getOrgName(), sysOrg);
		}
		context.setAttribute("sysOrgList",sysOrgList);	
		context.setAttribute("sysOrgMap",sysOrgMap);		
		InitConfig.sysOrgMap = sysOrgMap;
		InitConfig.sysOrgNameMap = sysOrgNameMap;
		InitConfig.sysOrgList = sysOrgList;
	}
	
	public static SysOrg getSysOrgByName(String orgName){
		 return InitConfig.sysOrgNameMap.get(orgName);
	}
	
	private static Map<String,SysDept> sysDeptMap ;
	public static String getDeptNameByFlow(String deptFlow){
		if(sysDeptMap!=null){
			SysDept sysDept = sysDeptMap.get(deptFlow);
			if(sysDept!=null){
				return sysDept.getDeptName();
			}
		}
		return null;		
	} 

	public static void _loadDept(ServletContext context) {
		Map<String,SysDept> sysDeptMap = new HashMap<String, SysDept>();
		IDeptBiz deptBiz = (IDeptBiz) SpringUtil.getBean(IDeptBiz.class);
		SysDept search = new SysDept();
		search.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysDept> sysDeptList = deptBiz.searchDept(search);
		for(SysDept sysDept : sysDeptList){
			sysDeptMap.put(sysDept.getDeptFlow(), sysDept);
		}		
		InitConfig.sysDeptMap = sysDeptMap;
	}
	
	//public static ProjPage projApplyPage;
	public static Map<String , Map<String , String>> configMap;
	public static Map<String , PageGroup> projInfoPageMap;//��Ŀ����
	public static Map<String , PageGroup> projApplyPageMap;//�걨��
	public static Map<String , PageGroup> projSetUpPageMap;//�걨��
	public static Map<String , PageGroup> projContractPageMap;//��ͬ
	public static Map<String , PageGroup> projSchdulePageMap;//����
	public static Map<String , PageGroup> projCompletePageMap;//��Ŀ����
	public static Map<String , PageGroup> projDelayPageMap;//��������
	public static Map<String , PageGroup> projChangePageMap;//�������
	public static Map<String , PageGroup> projTerminatePageMap;//��ֹ����
	public static Map<String , PageGroup> projAidPageMap;//��Ŀ��Ϣ����
	
//	public static PageGroup projInfoPage;//��Ŀ������Ϣ
	
	private static void _loadSrmCfg(ServletContext context) {
		logger.debug("��ʼ���ؿ��������ļ�...");
		try {
			ProjPageCfgParse configMapParse = new ProjPageCfgParse(SpringUtil.getResource("classpath:ProjPageCfg.xml").getFile());
			InitConfig.configMap = configMapParse.parseProductConfig();
			
			PageGroupParse projInfoParse = new PageGroupParse(SpringUtil.getResource("classpath:"+GlobalConstant.SRM_FORM_CONFIG_PATH+"/ProjInfoPage.xml").getFile());
			InitConfig.projInfoPageMap = projInfoParse.parse();
			
			PageGroupParse projApplyParse = new PageGroupParse(SpringUtil.getResource("classpath:"+GlobalConstant.SRM_FORM_CONFIG_PATH+"/ProjApplyPage.xml").getFile());
			InitConfig.projApplyPageMap = projApplyParse.parse();
			
			PageGroupParse projSetUpParse = new PageGroupParse(SpringUtil.getResource("classpath:"+GlobalConstant.SRM_FORM_CONFIG_PATH+"/ProjSetUpPage.xml").getFile());
			InitConfig.projSetUpPageMap = projSetUpParse.parse();
			
			PageGroupParse projContracParse = new PageGroupParse(SpringUtil.getResource("classpath:"+GlobalConstant.SRM_FORM_CONFIG_PATH+"/ProjContractPage.xml").getFile());
			InitConfig.projContractPageMap = projContracParse.parse();
			
			PageGroupParse projSchduleParse = new PageGroupParse(SpringUtil.getResource("classpath:"+GlobalConstant.SRM_FORM_CONFIG_PATH+"/ProjSchedulePage.xml").getFile());
			InitConfig.projSchdulePageMap = projSchduleParse.parse();
			
			PageGroupParse projCompleteParse = new PageGroupParse(SpringUtil.getResource("classpath:"+GlobalConstant.SRM_FORM_CONFIG_PATH+"/ProjCompletePage.xml").getFile());
			InitConfig.projCompletePageMap =projCompleteParse.parse();
			
			PageGroupParse projDelayParse = new PageGroupParse(SpringUtil.getResource("classpath:"+GlobalConstant.SRM_FORM_CONFIG_PATH+"/ProjDelayPage.xml").getFile());
			InitConfig.projDelayPageMap =projDelayParse.parse();
			
			PageGroupParse projChangeParse = new PageGroupParse(SpringUtil.getResource("classpath:"+GlobalConstant.SRM_FORM_CONFIG_PATH+"/ProjChangePage.xml").getFile());
			InitConfig.projChangePageMap =projChangeParse.parse();
			
			PageGroupParse projTerminateParse = new PageGroupParse(SpringUtil.getResource("classpath:"+GlobalConstant.SRM_FORM_CONFIG_PATH+"/ProjTerminatePage.xml").getFile());
		    InitConfig.projTerminatePageMap=projTerminateParse.parse();
		    
		    PageGroupParse projInfoAidParse = new PageGroupParse(SpringUtil.getResource("classpath:"+GlobalConstant.SRM_FORM_CONFIG_PATH+"/ProjAidPage.xml").getFile());
		    InitConfig.projAidPageMap = projInfoAidParse.parse();
		} catch (Exception e) {
			logger.error("�������ü���ʧ�ܣ���������ϵͳ...",e);
			throw new RuntimeException("�������ü���ʧ�ܣ���������ϵͳ...");	
		} 
	}
	
	public static IrbFormRequestUtil formRequestUtil ;
	@SuppressWarnings("unchecked")
	private static void _loadIrbCfg(ServletContext context) {
		logger.debug("��ʼ�������������ļ�...");
		formRequestUtil = new IrbFormRequestUtil();
		try {
			 
			for(GeneralEnum<String> temp : EnumUtil.toList(IrbRecTypeEnum.class)){
					IrbRecTypeEnum irbRecTypeEnum = (IrbRecTypeEnum)temp;
					if(GlobalConstant.FLAG_N.equals(irbRecTypeEnum.getIsForm())){
						continue;
					}
					String formFileName = irbRecTypeEnum.getId();
					XmlParse irbFormXp = new XmlParse(SpringUtil.getResource("classpath:"+GlobalConstant.IRB_FORM_CONFIG_PATH+"/"+formFileName+".xml").getFile());
					
					List<Element> productTypeElements = irbFormXp.getRootElement().elements();
					String jspPath = "";
					String viewPath = "";
					for(Element productEle : productTypeElements){
						if(productEle.getName().equals("jsp")){ 
							jspPath = productEle.attributeValue("path");
							viewPath = productEle.attributeValue("view");
							formRequestUtil.getVersionMap().put(formFileName, productEle.attributeValue("ver"));
						}
						List<IrbSingleForm> formList =  formRequestUtil.getFormTypeMap().get(formFileName);
						if(formList == null){
							formList = new ArrayList<IrbSingleForm>();
						}
						List<Element> pageElements = productEle.elements();
						for(Element pageEle :pageElements){
							IrbSingleForm singleForm = new IrbSingleForm();
							singleForm.setProductType(productEle.getName());
							singleForm.setCategory(pageEle.attributeValue("categroy"));
							singleForm.setVersion(pageEle.attributeValue("ver"));
//							if(StringUtil.isNotBlank(jspPath)){
//								singleForm.setJspPath(MessageFormat.format(jspPath,singleForm.getProductType(),singleForm.getCategory(),singleForm.getVersion()));
//							}
							singleForm.setJspPath(jspPath);
//							if(StringUtil.isNotBlank(viewPath)){
//								singleForm.setViewPath(MessageFormat.format(jspPath,singleForm.getProductType(),singleForm.getCategory(),singleForm.getVersion()));
//							}
							singleForm.setViewPath(viewPath);
							List<Element> itemElements = pageEle.elements();
							singleForm.setItemList(itemElements);
							/*����code�ڵ�*/
							Map<String,Map<String,CodeValues>> itemCodeMap = new HashMap<String,Map<String,CodeValues>>();
							for (Element el : itemElements) {
								List<Element> codeElements = el.elements("code");
								if(codeElements!=null&&!codeElements.isEmpty()){
									Map<String,CodeValues> codeMap = new LinkedHashMap<String,CodeValues>();
									CodeValues values = null;
									for (Element cel : codeElements) {
										values = new CodeValues();
										values.setText(cel.getTextTrim());
										Attribute newLineAttr = cel.attribute("newLine");
										if(newLineAttr!=null){
											values.setNewLine(newLineAttr.getValue());
										}
										Attribute remarkAttr = cel.attribute("remark");
										if(remarkAttr!=null){
											values.setRemark(remarkAttr.getValue());
										}
										codeMap.put(cel.attributeValue("value"), values);
									}
									itemCodeMap.put(el.attributeValue("name"), codeMap);
								}
							}
							singleForm.setItemCodeMap(itemCodeMap);
							
							formList.add(singleForm);
							//product_yw_1.0
							Map<String,IrbSingleForm> singleFormMap = formRequestUtil.getFormMap().get(formFileName);
							if(singleFormMap == null){
								singleFormMap = new HashMap<String, IrbSingleForm>();
							}
							singleFormMap.put(singleForm.getProductType()+"_"+singleForm.getCategory()+"_"+singleForm.getVersion(), singleForm);
							formRequestUtil.getFormMap().put(formFileName, singleFormMap);
						}
						formRequestUtil.getFormTypeMap().put(formFileName, formList);
					}
			}
		} catch (Exception e) {
			logger.error("�������ü���ʧ�ܣ���������ϵͳ...",e);
			throw new RuntimeException("�������ü���ʧ�ܣ���������ϵͳ...");	
		} 
	}
	
	public static IrbFormRequestUtil gcpFormRequestUtil ;
	@SuppressWarnings("unchecked")
	private static void _loadGcpCfg(ServletContext context) {
		logger.debug("��ʼ����GCP�����ļ�...");
		gcpFormRequestUtil = new IrbFormRequestUtil();
		try {
			 
			for(GeneralEnum<String> temp : EnumUtil.toList(GcpRecTypeEnum.class)){
					GcpRecTypeEnum gcpRecTypeEnum = (GcpRecTypeEnum)temp;
					if(GlobalConstant.FLAG_N.equals(gcpRecTypeEnum.getIsForm())){
						continue;
					}
					String formFileName = gcpRecTypeEnum.getId();
					XmlParse irbFormXp = new XmlParse(SpringUtil.getResource("classpath:"+GlobalConstant.QC_FORM_CONFIG_PATH+"/"+formFileName+".xml").getFile());
					
					List<Element> productTypeElements = irbFormXp.getRootElement().elements();
					String jspPath = "";
					String viewPath = "";
					for(Element productEle : productTypeElements){
						if(productEle.getName().equals("jsp")){ 
							jspPath = productEle.attributeValue("path");
							viewPath = productEle.attributeValue("view");
							gcpFormRequestUtil.getVersionMap().put(formFileName, productEle.attributeValue("ver"));
						}
						List<IrbSingleForm> formList =  gcpFormRequestUtil.getFormTypeMap().get(formFileName);
						if(formList == null){
							formList = new ArrayList<IrbSingleForm>();
						}
						List<Element> pageElements = productEle.elements();
						for(Element pageEle :pageElements){
							IrbSingleForm singleForm = new IrbSingleForm();
							singleForm.setProductType(productEle.getName());
							singleForm.setVersion(pageEle.attributeValue("ver"));
							singleForm.setJspPath(jspPath);
							singleForm.setViewPath(viewPath);
							List<Element> itemElements = pageEle.elements();
							singleForm.setItemList(itemElements);
							/*����code�ڵ�*/
							Map<String,Map<String,CodeValues>> itemCodeMap = new HashMap<String,Map<String,CodeValues>>();
							for (Element el : itemElements) {
								List<Element> codeElements = el.elements("code");
								if(codeElements!=null&&!codeElements.isEmpty()){
									Map<String,CodeValues> codeMap = new LinkedHashMap<String,CodeValues>();
									CodeValues values = null;
									for (Element cel : codeElements) {
										values = new CodeValues();
										values.setText(cel.getTextTrim());
										Attribute newLineAttr = cel.attribute("newLine");
										if(newLineAttr!=null){
											values.setNewLine(newLineAttr.getValue());
										}
										Attribute remarkAttr = cel.attribute("remark");
										if(remarkAttr!=null){
											values.setRemark(remarkAttr.getValue());
										}
										codeMap.put(cel.attributeValue("value"), values);
									}
									itemCodeMap.put(el.attributeValue("name"), codeMap);
								}
							}
							singleForm.setItemCodeMap(itemCodeMap);
							
							formList.add(singleForm);
							//product_1.0
							Map<String,IrbSingleForm> singleFormMap = gcpFormRequestUtil.getFormMap().get(formFileName);
							if(singleFormMap == null){
								singleFormMap = new HashMap<String, IrbSingleForm>();
							}
							singleFormMap.put(singleForm.getProductType()+"_"+singleForm.getVersion(), singleForm);
							gcpFormRequestUtil.getFormMap().put(formFileName, singleFormMap);
						}
						gcpFormRequestUtil.getFormTypeMap().put(formFileName, formList);
					}
			}
		} catch (Exception e) {
			logger.error("GCP���ü���ʧ�ܣ���������ϵͳ...",e);
			throw new RuntimeException("GCP���ü���ʧ�ܣ���������ϵͳ...");	
		} 
	}
	
	private static Map<String,String> sysCfgMap = new HashMap<String, String>();
	private static Map<String,String> sysCfgDescMap;
	private static void _loadSysCfg(ServletContext context) {
		sysCfgMap = new HashMap<String, String>();
		sysCfgDescMap = new HashMap<String, String>();
		ICfgBiz cfgBiz = (ICfgBiz) SpringUtil.getBean(ICfgBiz.class);
		List<SysCfg> sysCfgList = cfgBiz.search(new SysCfg());
		for(SysCfg sysCfg : sysCfgList){
			if(StringUtil.isNotBlank(sysCfg.getCfgDesc())){
				sysCfgDescMap.put(sysCfg.getCfgCode(), sysCfg.getCfgDesc());
			}
			sysCfgMap.put(sysCfg.getCfgCode(), sysCfg.getCfgValue());
			if(StringUtil.isNotBlank(sysCfg.getCfgBigValue())){
				sysCfgMap.put(sysCfg.getCfgCode(), sysCfg.getCfgBigValue());				
			}
		}
		context.setAttribute("sysCfgMap",sysCfgMap);
		context.setAttribute("sysCfgDescMap", sysCfgDescMap);
	}
	
	public static String getSysCfg(String key){
		return StringUtil.defaultString(sysCfgMap.get(key));
	}
	
	public static String getSysCfgDesc(String key){
		return StringUtil.defaultString(sysCfgDescMap.get(key));
	}


	public static void main(String[] args) {
		System.err.println(StringUtil.uncapitalize("AvbD"));
	}
	public static Map<String,IrbInfo> irbInfoMap ;
	private static void _loadIrb(ServletContext context) {
		Map<String,IrbInfo> irbInfoMap = new HashMap<String, IrbInfo>();
		IIrbInfoBiz irbBiz = (IIrbInfoBiz) SpringUtil.getBean(IIrbInfoBiz.class);	
		IrbInfo search = new IrbInfo();
		search.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<IrbInfo> irbInfoList = irbBiz.queryInfo(search);
		for(IrbInfo info : irbInfoList){
			irbInfoMap.put(info.getRecordFlow(), info);
		}
		context.setAttribute("irbInfoMap",irbInfoMap);	
		context.setAttribute("irbInfoList",irbInfoList);	
		InitConfig.irbInfoMap =  irbInfoMap;
	}
	public static IrbFormRequestUtil resFormRequestUtil ;
	@SuppressWarnings("unchecked")
	private static void _loadResCfg(ServletContext context) {
		logger.debug("��ʼ����סԺҽʦ���ֵ�...");
		loadResFormDict(context);
		logger.debug("��ʼ����סԺҽʦ�����ļ�...");
		resFormRequestUtil = new IrbFormRequestUtil();
		try {
			for(GeneralEnum<String> temp : EnumUtil.toList(ResRecTypeEnum.class)){
					ResRecTypeEnum resRecTypeEnum = (ResRecTypeEnum)temp;
					if(GlobalConstant.FLAG_N.equals(resRecTypeEnum.getIsForm())){
						continue;
					}
					String formFileName = resRecTypeEnum.getId();
					XmlParse irbFormXp = new XmlParse(SpringUtil.getResource("classpath:"+GlobalConstant.RES_FORM_CONFIG_PATH+"/"+formFileName+".xml").getFile());
					
					List<Element> productTypeElements = irbFormXp.getRootElement().elements();
					String jspPath = "";
					for(Element productEle : productTypeElements){
						String productType = productEle.getName();
						if(productType.equals("jsp")){ 
							jspPath = productEle.attributeValue("path");
							continue;
						}
						List<IrbSingleForm> formList =  resFormRequestUtil.getFormTypeMap().get(formFileName);
						if(formList == null){
							formList = new ArrayList<IrbSingleForm>();
						}
						List<Element> pageElements = productEle.elements();
						resFormRequestUtil.getVersionMap().put(productType+"_"+formFileName, productEle.attributeValue("ver"));
						for(Element pageEle : pageElements){
							IrbSingleForm singleForm = new IrbSingleForm();
							singleForm.setProductType(productType);
							singleForm.setVersion(pageEle.attributeValue("ver"));
							singleForm.setJspPath(jspPath);
							List<Element> itemElements = pageEle.elements();
							singleForm.setItemList(itemElements);
							formList.add(singleForm);
							Map<String,IrbSingleForm> singleFormMap = resFormRequestUtil.getFormMap().get(formFileName);
							if(singleFormMap == null){
								singleFormMap = new HashMap<String, IrbSingleForm>();
							}
							singleFormMap.put(singleForm.getProductType()+"_"+singleForm.getVersion(), singleForm);
							resFormRequestUtil.getFormMap().put(formFileName, singleFormMap);
						}
						resFormRequestUtil.getFormTypeMap().put(formFileName, formList);
					}
			}
		} catch (Exception e) {
			logger.error("סԺҽʦ���ü���ʧ�ܣ���������ϵͳ...",e);
			throw new RuntimeException("סԺҽʦ���ü���ʧ�ܣ���������ϵͳ...");	
		} 
	}
	
	private static void loadResFormDict(ServletContext context){
		try{
			XmlParse irbFormXp = new XmlParse(SpringUtil.getResource("classpath:"+GlobalConstant.RES_FORM_CONFIG_PATH+"/formDict.xml").getFile());
			List<Element> formDictElements = irbFormXp.getRootElement().elements();
			List<Map<String,String>> resFormDictList = new ArrayList<Map<String,String>>();
			for(Element dict : formDictElements){
				Map<String,String> dictForm  = new HashMap<String, String>();
				String dictId = dict.getName();
				String dictDesc = dict.attributeValue("desc"); 
				dictForm.put("dictId",dictId);
				dictForm.put("dictDesc",dictDesc);
				resFormDictList.add(dictForm);
			}
			context.setAttribute("resFormDictList",resFormDictList);
		}catch(Exception e){
			logger.error("סԺҽʦ��Ŀ¼����ʧ�ܣ���������ϵͳ...",e);
			throw new RuntimeException("סԺҽʦ��Ŀ¼����ʧ�ܣ���������ϵͳ...");	
		}
	}
	private static 	Map<String, List<String>> cityMap;
	public static  List<String> getCityMap(String provId){
		if(InitConfig.cityMap!=null){
			return InitConfig.cityMap.get(provId);
		}
		return null;
	}
	/**
	 * ͨ��ʡ��ID�����һ���е�List
	 * @param provId
	 * @return
	 */
	public static void _getCityMap() {
		List<String> cityIdList =null;
		Map<String, List<String>> cityMap=new HashMap<String, List<String>>();
		try {
			ApplicationContext contextsci = new ClassPathXmlApplicationContext("spring-context.xml");
			//File f = new File("D:\\provCityAreaJson.min.json");
			
			InputStreamReader read =  new InputStreamReader(RegionUtil.class.getResourceAsStream("/provCityAreaJson.min.json"),"UTF-8");
					//new InputStreamReader(new FileInputStream(f),"UTF-8");
			BufferedReader br=new BufferedReader(read);
			String line="";
			StringBuffer  buffer = new StringBuffer();
			while((line=br.readLine())!=null){
			buffer.append(line);
			}
			String fileContent = buffer.toString();
			
			JSONArray provArray = JSON.parseArray(fileContent);
			for(Object provObj : provArray.toArray()){
				JSONObject prov = (JSONObject)provObj;
				String v = prov.getString("v");
				if(!cityMap.containsKey(v)){
					cityIdList=new ArrayList<String>();
				}else{
					cityIdList=cityMap.get(v);
				}
				String n = prov.getString("n");
				JSONArray cityArray = prov.getJSONArray("s");
				for(Object cityObj : cityArray.toArray()){
					JSONObject city = (JSONObject)cityObj;
					String vc = city.getString("v");
					cityIdList.add(vc);
				}
				cityMap.put(v, cityIdList);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		InitConfig.cityMap=cityMap;
	}
}
