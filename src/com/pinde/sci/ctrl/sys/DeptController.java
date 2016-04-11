package com.pinde.sci.ctrl.sys;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysOrg;


@Controller
@RequestMapping("/sys/dept")
public class DeptController extends GeneralController{
	
	private static Logger logger=LoggerFactory.getLogger(DeptController.class);
	
	@Resource
	private IDeptBiz deptBiz;
	
	@Autowired
	private IOrgBiz orgBiz;	
	
	@RequestMapping(value={"/edit"},method=RequestMethod.GET)
	public ModelAndView edit(@RequestParam(value="deptFlow",required=false)String deptFlow){
		ModelAndView mav=new ModelAndView("sys/dept/edit");
		if(StringUtil.isNotBlank(deptFlow)){
			SysDept sysDept=deptBiz.readSysDept(deptFlow);
			mav.addObject("sysDept",sysDept);
		}
		SysOrg sysOrg=new SysOrg();
		sysOrg.setRecordStatus(GlobalConstant.FLAG_Y);
		List<SysOrg> orgList=orgBiz.searchOrg(sysOrg);
		mav.addObject("orgList",orgList);
		return mav;
	}
	
	@RequestMapping(value = "/list/{deptListScope}",method={RequestMethod.POST,RequestMethod.GET})
	public String list(@PathVariable String deptListScope,SysDept dept,Model model,HttpServletRequest request){
		setSessionAttribute(GlobalConstant.DEPT_LIST_SCOPE, deptListScope);
		if(GlobalConstant.DEPT_LIST_LOCAL.equals(deptListScope)){
			dept.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
			if(StringUtil.isNotBlank(dept.getOrgFlow())){
				List<SysDept> deptList=deptBiz.searchDept(dept);
				model.addAttribute("deptList",deptList);				
			}			
		}
		if(GlobalConstant.DEPT_LIST_GLOBAL.equals(deptListScope)){
			if(StringUtil.isNotBlank(dept.getOrgFlow())){
				List<SysDept> deptList=deptBiz.searchDept(dept);
				model.addAttribute("deptList",deptList);			
			}			
		}
		return "sys/dept/list";
	}
	
	@RequestMapping(value={"/save"},method=RequestMethod.POST)
	public @ResponseBody  String save(SysDept dept,HttpServletRequest request){
		deptBiz.saveDept(dept);
		InitConfig._loadDept(request.getServletContext());
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value="/delete",method=RequestMethod.GET)
	public @ResponseBody String delete(SysDept dept){
//		dept.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		deptBiz.saveDept(dept);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	@RequestMapping(value="/saveOrder",method=RequestMethod.POST)
	@ResponseBody
	public String saveOrder(String [] deptFlow,Model model,HttpServletRequest request) throws Exception{
		deptBiz.saveOrder(deptFlow);
		InitConfig._loadDept(request.getServletContext());
		return GlobalConstant.SAVE_SUCCESSED;
		
	}
}
