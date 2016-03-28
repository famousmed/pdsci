package com.pinde.sci.ctrl.resedu;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.test.ITestResultBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.model.mo.FstuCredit;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.TestResult;

@Controller
@RequestMapping("/resedu/edu")
public class ResEduTestController extends GeneralController{
	
	@Resource
	private IUserBiz userBiz;
	@Resource
	private ITestResultBiz testResultBiz ;
	
	/**
	 * ²éÔƒ
	 * @param model
	 * @param user
	 * @param currentPage
	 * @param request
	 * @return
	 */
	@RequestMapping("/resultList")
	public String resultList(Model model,SysUser user,Integer currentPage,HttpServletRequest request){
		if(currentPage==null){
			currentPage=1;
		}
		PageHelper.startPage(currentPage,getPageSize(request));
		SysUser currsysUser = GlobalContext.getCurrentUser();
		String userOrgFlow= currsysUser.getOrgFlow();
		user.setOrgFlow(userOrgFlow);
		List<SysUser> userList=userBiz.searchUser(user);
		 model.addAttribute("userList", userList);
		return "/res/edu/teacher/resultList";
	}
	/**
	 * ¾ŽÝ‹
	 * @param userFlow
	 * @param model
	 * @return
	 */
	@RequestMapping("/editTestResult")
	public String editTestResult(String userFlow,Model model){
		if(StringUtil.isNotBlank(userFlow)){
			SysUser user=userBiz.readSysUser(userFlow);
			model.addAttribute("user", user);
			List<TestResult> result=testResultBiz.searchResultByUserFlow(userFlow);
			model.addAttribute("result", result);
		}
		return "/res/edu/teacher/editTestResult";
	}
	/**
	 * ±£´æTestResult
	 * @param testResults
	 * @return
	 */
	@RequestMapping("/saveTestResult")
	@ResponseBody
	public String saveTestResult(@RequestBody List<TestResult> testResults){
		int result=testResultBiz.saveTestResultList(testResults);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	/**
	 * „h³ýTestResult
	 * @param testResult
	 * @return
	 */
	@RequestMapping("/delTestResult")
	@ResponseBody
	public String delTestResult(TestResult testResult){
		int result=testResultBiz.edit(testResult);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.DELETE_SUCCESSED;
		}
		return GlobalConstant.DELETE_FAIL;
	}
}
