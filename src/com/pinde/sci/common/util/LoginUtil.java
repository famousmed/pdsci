package com.pinde.sci.common.util;

import java.util.ArrayList;
import java.util.List;

import com.pinde.sci.biz.edc.IProjUserBiz;
import com.pinde.sci.biz.irb.IIrbInfoUserBiz;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.model.mo.IrbInfoUser;
import com.pinde.sci.model.mo.PubProjUser;
import com.pinde.sci.model.mo.SysUserRole;

public class LoginUtil {
	
	public static void loadSysRole(String userFlow,IUserRoleBiz userRoleBiz,IRoleBiz roleBiz){

		//加载所拥有的权限
		List<String> currUserMenuIdList = new ArrayList<String>();
		List<String> currUserMenuSetIdList = new ArrayList<String>();
		List<String> currUserModuleIdList = new ArrayList<String>();
		List<String> currUserWorkStationIdList = new ArrayList<String>();
		List<SysUserRole> sysUserRoleList = userRoleBiz.getByUserFlow(userFlow);
		List<String> currRoleList = new ArrayList<String>();
		for(SysUserRole userRole : sysUserRoleList){
			currRoleList.add(userRole.getRoleFlow());
			List<String> menuIds = roleBiz.getPopedom(userRole.getRoleFlow());
			currUserMenuIdList.addAll(menuIds);	
			
			for(String menuId : currUserMenuIdList){
				String setId = InitConfig.getMenuSetIdByMenuId(menuId);
				if(!currUserMenuSetIdList.contains(setId)&&setId!=null){
					currUserMenuSetIdList.add(setId);
				}	
				String moduleId = InitConfig.getModuleIdByMenuId(menuId);
				if(!currUserModuleIdList.contains(moduleId)&&moduleId!=null){
					currUserModuleIdList.add(moduleId);							
				}
				String wsid = InitConfig.getWorkStationIdByMenuId(menuId);
				if(!currUserWorkStationIdList.contains(wsid)&&wsid!=null){
					currUserWorkStationIdList.add(wsid);							
				}
			}			
		}
		
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_ROLE_LIST, currRoleList);
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_MENU_ID_LIST, currUserMenuIdList);
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_MENU_SET_ID_LIST, currUserMenuSetIdList);
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_MODULE_ID_LIST, currUserModuleIdList);
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_WORKSTATION_ID_LIST, currUserWorkStationIdList);
		
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_ROLE_LIST_BACKUP, currRoleList);
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_MENU_ID_LIST_BACKUP, currUserMenuIdList);
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_MENU_SET_ID_LIST_BACKUP, currUserMenuSetIdList);
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_MODULE_ID_LIST_BACKUP, currUserModuleIdList);
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_WORKSTATION_ID_LIST_BACKUP, currUserWorkStationIdList);	
	}
	
	@SuppressWarnings("unchecked")
	public static void loadEDCProjRole(String userFlow,String projFlow,IProjUserBiz projUserBiz,IRoleBiz roleBiz){
		
		//加载该项目拥有的权限
		List<String> projUserMenuIdList = new ArrayList<String>();
		List<String> projUserMenuSetIdList = new ArrayList<String>();
		List<String> projUserModuleIdList = new ArrayList<String>();
		List<String> projUserWorkStationIdList = new ArrayList<String>();
		List<String> projRoleList = new ArrayList<String>();		

		//系统级别权限
		List<String> currUserMenuIdList = (List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_MENU_ID_LIST_BACKUP);
		List<String> currUserMenuSetIdList = (List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_MENU_SET_ID_LIST_BACKUP);
		List<String> currUserModuleIdList = (List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_MODULE_ID_LIST_BACKUP);
		List<String> currUserWorkStationIdList = (List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_WORKSTATION_ID_LIST_BACKUP);
		List<String> currRoleList =  (List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_ROLE_LIST_BACKUP);
				
		PubProjUser search = new PubProjUser();
		search.setUserFlow(userFlow);
		search.setProjFlow(projFlow);
		List<PubProjUser> projUserRoleList = projUserBiz.search(search);
		for(PubProjUser userRole : projUserRoleList){
			if(!projRoleList.contains(userRole.getRoleFlow())&&userRole.getRoleFlow()!=null){
				projRoleList.add(userRole.getRoleFlow());
				List<String> menuIds = roleBiz.getPopedom(userRole.getRoleFlow());
				projUserMenuIdList.addAll(menuIds);	
				
				for(String menuId : projUserMenuIdList){
					String setId = InitConfig.getMenuSetIdByMenuId(menuId);
					if(!projUserMenuSetIdList.contains(setId)&&setId!=null){
						projUserMenuSetIdList.add(setId);
					}	
					String moduleId = InitConfig.getModuleIdByMenuId(menuId);
					if(!projUserModuleIdList.contains(moduleId)&&moduleId!=null){
						projUserModuleIdList.add(moduleId);							
					}
					String wsid = InitConfig.getWorkStationIdByMenuId(menuId);
					if(!projUserWorkStationIdList.contains(wsid)&&wsid!=null){
						projUserWorkStationIdList.add(wsid);							
					}
				}
			}
		}
		
		//新的权限容器
		List<String> currUserMenuIdListNew = new ArrayList<String>();
		List<String> currUserMenuSetIdListNew = new ArrayList<String>();
		List<String> currUserModuleIdListNew = new ArrayList<String>();
		List<String> currUserWorkStationIdListNew = new ArrayList<String>();
		List<String> currRoleListNew = new ArrayList<String>();
		
		
		currUserMenuIdListNew.addAll(currUserMenuIdList);
		currUserMenuSetIdListNew.addAll(currUserMenuSetIdList);
		currUserModuleIdListNew.addAll(currUserModuleIdList);
		currUserWorkStationIdListNew.addAll(currUserWorkStationIdList);
		currRoleListNew.addAll(currRoleList);
		
		for(String menuId :projUserMenuIdList){
			if(!currUserMenuIdListNew.contains(menuId)&&menuId!=null){
				currUserMenuIdListNew.add(menuId);					
			}		
		}
		for(String menuSetId :projUserMenuSetIdList){
			if(!currUserMenuSetIdListNew.contains(menuSetId)&&menuSetId!=null){
				currUserMenuSetIdListNew.add(menuSetId);					
			}		
		}
		for(String moduleId :projUserModuleIdList){
			if(!currUserModuleIdListNew.contains(moduleId)&&moduleId!=null){
				currUserModuleIdListNew.add(moduleId);					
			}		
		}
		for(String wsId :projUserWorkStationIdList){
			if(!currUserWorkStationIdListNew.contains(wsId)&&wsId!=null){
				currUserWorkStationIdListNew.add(wsId);					
			}		
		}
		for(String roleFlow :projRoleList){
			if(!currRoleListNew.contains(roleFlow)&&roleFlow!=null){
				currRoleListNew.add(roleFlow);					
			}		
		}
				
		
		//参考登录动作
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_ROLE_LIST, currRoleListNew);
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_MENU_ID_LIST, currUserMenuIdListNew);
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_MENU_SET_ID_LIST, currUserMenuSetIdListNew);
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_MODULE_ID_LIST, currUserModuleIdListNew);
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_WORKSTATION_ID_LIST, currUserWorkStationIdListNew);
	}
	
	@SuppressWarnings("unchecked")
	public static void loadIrbRole(String userFlow,IIrbInfoUserBiz irbInfoUserBiz,IRoleBiz roleBiz){
		
		//加载该项目拥有的权限
		List<String> irbUserMenuIdList = new ArrayList<String>();
		List<String> irbUserMenuSetIdList = new ArrayList<String>();
		List<String> irbUserModuleIdList = new ArrayList<String>();
		List<String> irbUserWorkStationIdList = new ArrayList<String>();
		List<String> irbRoleList = new ArrayList<String>();		

		//系统级别权限
		List<String> currUserMenuIdList = (List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_MENU_ID_LIST_BACKUP);
		List<String> currUserMenuSetIdList = (List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_MENU_SET_ID_LIST_BACKUP);
		List<String> currUserModuleIdList = (List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_MODULE_ID_LIST_BACKUP);
		List<String> currUserWorkStationIdList = (List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_WORKSTATION_ID_LIST_BACKUP);
		List<String> currRoleList =  (List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_ROLE_LIST_BACKUP);
				
		IrbInfoUser irbUser = new IrbInfoUser();
		irbUser.setUserFlow(userFlow);
		irbUser.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<IrbInfoUser> irbUserRoleList = irbInfoUserBiz.queryUserList(irbUser); 
		
		for(IrbInfoUser userRole : irbUserRoleList){
			if(!irbRoleList.contains(userRole.getRoleFlow())&&userRole.getRoleFlow()!=null){
				irbRoleList.add(userRole.getRoleFlow());
				List<String> menuIds = roleBiz.getPopedom(userRole.getRoleFlow());
				irbUserMenuIdList.addAll(menuIds);	
				
				for(String menuId : irbUserMenuIdList){
					String setId = InitConfig.getMenuSetIdByMenuId(menuId);
					if(!irbUserMenuSetIdList.contains(setId)&&setId!=null){
						irbUserMenuSetIdList.add(setId);
					}	
					String moduleId = InitConfig.getModuleIdByMenuId(menuId);
					if(!irbUserModuleIdList.contains(moduleId)&&moduleId!=null){
						irbUserModuleIdList.add(moduleId);							
					}
					String wsid = InitConfig.getWorkStationIdByMenuId(menuId);
					if(!irbUserWorkStationIdList.contains(wsid)&&wsid!=null){
						irbUserWorkStationIdList.add(wsid);							
					}
				}
			}
		}
		for(String menuId :irbUserMenuIdList){
			if(!currUserMenuIdList.contains(menuId)&&menuId!=null){
				currUserMenuIdList.add(menuId);					
			}		
		}
		for(String menuSetId :irbUserMenuSetIdList){
			if(!currUserMenuSetIdList.contains(menuSetId)&&menuSetId!=null){
				currUserMenuSetIdList.add(menuSetId);					
			}		
		}
		for(String moduleId :irbUserModuleIdList){
			if(!currUserModuleIdList.contains(moduleId)&&moduleId!=null){
				currUserModuleIdList.add(moduleId);					
			}		
		}
		for(String wsId :irbUserWorkStationIdList){
			if(!currUserWorkStationIdList.contains(wsId)&&wsId!=null){
				currUserWorkStationIdList.add(wsId);					
			}		
		}
		for(String roleFlow :irbRoleList){
			if(!currRoleList.contains(roleFlow)&&roleFlow!=null){
				currRoleList.add(roleFlow);					
			}		
		}
		
		//参考登录动作
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_ROLE_LIST, currRoleList);
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_MENU_ID_LIST, currUserMenuIdList);
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_MENU_SET_ID_LIST, currUserMenuSetIdList);
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_MODULE_ID_LIST, currUserModuleIdList);
		GlobalContext.setSessionAttribute(GlobalConstant.CURRENT_WORKSTATION_ID_LIST, currUserWorkStationIdList);
	}

}
