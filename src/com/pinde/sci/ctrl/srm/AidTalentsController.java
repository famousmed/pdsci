package com.pinde.sci.ctrl.srm;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.docx4j.openpackaging.io.SaveToZipFile;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.Docx4jUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IAidTalentsBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.srm.AidAssessStatusEnum;
import com.pinde.sci.enums.srm.AidTalentsStatusEnum;
import com.pinde.sci.model.mo.AidTalents;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.AidTalentsExt;

@Controller
@RequestMapping("/srm/aid/talents")
public class AidTalentsController extends GeneralController {
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IAidTalentsBiz aidTalentsBiz;
	/**
	 * 申请汇总列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list/{role}")
	public String list(Integer currentPage,AidTalents aid,@PathVariable String role,String view,HttpServletRequest request, Model model){
		
		if(aid==null){
			aid = new AidTalents();
		}
		List<String> orgFlowList = null;
		if(GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL.equals(role)){//负责人
			aid.setUserFlow(GlobalContext.getCurrentUser().getUserFlow());
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL.equals(role)) {//科技处
			aid.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE.equals(role)){//主管部门
			List<SysOrg> orgList = this.orgBiz.searchChildrenOrgByOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
			if(orgList!=null&&!orgList.isEmpty()){
				orgFlowList = new ArrayList<String>();
				for (SysOrg org : orgList) {
					orgFlowList.add(org.getOrgFlow());
				}
			}
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL.equals(role)){//卫生局
			aid.setStatusId(AidTalentsStatusEnum.LocalPassed.getId());
		}
		
		aid.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		String result = "srm/aid/talents/list";//专项资金管理 或 专项资金申请
		if(GlobalConstant.FLAG_Y.equals(view)){//view 用来标记 返回的页面
			result = "srm/aid/talents/allList";//专项资金汇总
			aid.setStatusId(AidTalentsStatusEnum.GlobalPassed.getId());
		}
		PageHelper.startPage(currentPage, getPageSize(request));
		List<AidTalents> aidList = this.aidTalentsBiz.queryList(aid,orgFlowList);
		model.addAttribute("aidList", aidList);
		model.addAttribute("role", role);
		return result;
	}
	/**
	 * 新增/编辑申请表
	 * @param talentsFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/edit")
	public String edit(String talentsFlow,String chooseUserFlow,String orgFlow,String role, Model model)throws Exception{
		if(StringUtil.isNotBlank(talentsFlow)){
			AidTalentsExt aidExt = this.aidTalentsBiz.query(talentsFlow);
			if(aidExt!=null){
				orgFlow = aidExt.getOrgFlow();
				model.addAttribute("aidExt", aidExt);
			}
		}
		if(StringUtil.isNotBlank(chooseUserFlow)){//选择的用户
			SysUser chooseUser = this.userBiz.readSysUser(chooseUserFlow);
			if(chooseUser!=null){
				orgFlow = chooseUser.getOrgFlow();
				model.addAttribute("chooseUser", chooseUser);
			}
		}
		if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL.equals(role)){//科技处
			orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		}
		List<SysDept> deptList = queryDeptList(orgFlow);//部门
		model.addAttribute("deptList", deptList);
		return "srm/aid/talents/edit";
	}
	
	/**
	 * 选择用户
	 * @return
	 */
	@RequestMapping(value="/chooseUser")
	public String chooseUser(Integer currentPage,SysUser sysUser,String role,HttpServletRequest request,Model model){
		String orgFlow = null;
		/*用户列表*/
		if(sysUser==null){
			sysUser = new SysUser();
		}else{
			orgFlow = sysUser.getOrgFlow();
		}
		if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL.equals(role)){//科技处
			orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
			sysUser.setOrgFlow(orgFlow);
		}
		sysUser.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		sysUser.setStatusId(UserStatusEnum.Activated.getId());
		if(currentPage==null){
			currentPage = 1;
		}
		PageHelper.startPage(currentPage, getPageSize(request));
		List<SysUser> userList = this.userBiz.searchUser(sysUser);
		
		List<SysDept> deptList = queryDeptList(orgFlow);//部门
		model.addAttribute("deptList", deptList);
		model.addAttribute("userList", userList);
		return "srm/aid/talents/chooseUser";
	}
	
	private List<SysDept> queryDeptList(String orgFlow) {
		List<SysDept> list = null;
		if(StringUtil.isNotBlank(orgFlow)){
			SysDept sysDept = new SysDept();
			sysDept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			sysDept.setOrgFlow(orgFlow);
			list = this.deptBiz.searchDept(sysDept);
		}
		return list;
	}
	/**
	 * 保存
	 * @param aidTalents
	 * @param form
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public String save(AidTalentsExt aidExt )throws Exception{
		if(aidExt!=null){
			String assessStatusId = aidExt.getAssessStatusId();
			if(StringUtil.isNotBlank(assessStatusId)){
				aidExt.setAssessStatusName(AidAssessStatusEnum.getNameById(assessStatusId));
			}
			int result = this.aidTalentsBiz.edit(aidExt);
			if(result == GlobalConstant.ONE_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	/**
	 * ajax获取部门
	 * @param orgFlow
	 * @return
	 */
	@RequestMapping(value="/queryDeptListJson")
	@ResponseBody
	public List<SysDept> queryDeptListJson(String orgFlow){
		return queryDeptList(orgFlow);
	}
	/**
	 * 评价/查看全部/审核界面
	 * @param talentsFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/assess")
	public String assess(String talentsFlow,String viewAll, Model model)throws Exception{
		if(StringUtil.isNotBlank(talentsFlow)){
			AidTalentsExt aidExt = this.aidTalentsBiz.query(talentsFlow);
			model.addAttribute("aidExt", aidExt);
		}
		if(GlobalConstant.FLAG_Y.equals(viewAll)){//查看全部
			return "srm/aid/talents/viewAll";
		}else if(GlobalConstant.FLAG_N.equals(viewAll)) {
			return "srm/aid/talents/check";
		}
		return "srm/aid/talents/assess";
	}
	
	/**
	 * 删除
	 * @param talentsFlow
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/del")
	@ResponseBody
	public String del(String talentsFlow){
		if(StringUtil.isNotBlank(talentsFlow)){
			AidTalents aid = new AidTalents();
			aid.setTalentsFlow(talentsFlow);
			aid.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			int result = this.aidTalentsBiz.edit(aid);
			if(result==GlobalConstant.ONE_LINE){
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	/**
	 * 送审
	 * @param talentsFlow
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sendCheck")
	@ResponseBody
	public String sendCheck(String talentsFlow){
		if(StringUtil.isNotBlank(talentsFlow)){
			AidTalents aid = new AidTalents();
			aid.setTalentsFlow(talentsFlow);
			aid.setStatusId(AidTalentsStatusEnum.Passing.getId());
			aid.setStatusName(AidTalentsStatusEnum.Passing.getName());
			int result = this.aidTalentsBiz.edit(aid);
			if(result==GlobalConstant.ONE_LINE){
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	
	/**
	 * 对单条记录操作
	 * @param talentsFlow
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/operate")
	@ResponseBody
	public String operate(String talentsFlow,String oper) throws Exception{
		if(StringUtil.isNotBlank(talentsFlow)){
			AidTalents aid = new AidTalents();
			aid.setTalentsFlow(talentsFlow);
			if("del".equals(oper)){//删除
				aid.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			}else if("sendCheck".equals(oper)){//送审
				aid.setStatusId(AidTalentsStatusEnum.Passing.getId());
				aid.setStatusName(AidTalentsStatusEnum.Passing.getName());
			}
			int result = this.aidTalentsBiz.edit(aid);
			if(result==GlobalConstant.ONE_LINE){
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}
	/**
	 * 审核
	 * @param talentsFlow
	 * @param statusId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/check")
	@ResponseBody
	public String check(AidTalentsExt aidExt) throws Exception{
		if(aidExt!=null){
				aidExt.setStatusName(AidTalentsStatusEnum.getNameById(aidExt.getStatusId()));
				int result = this.aidTalentsBiz.edit(aidExt);
				if(result==GlobalConstant.ONE_LINE){
					return GlobalConstant.OPRE_SUCCESSED;
				}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	/**
	 * 打印申请表、评价表
	 * @param talentsFlow
	 * @param type
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/print")
	public void print(String talentsFlow,String type,String watermarkFlag,HttpServletRequest request,HttpServletResponse response)throws Exception{
		String templ = null;
		String fileName = null;
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(GlobalConstant.AID_DOC_TYPE_TALENTS.equals(type)){//申请表
			templ = "aidTalentsPrintTemeplete.docx";
			fileName = "医学重点人才培养专项资金申请表";
		}else if(GlobalConstant.AID_DOC_TYPE_ASSESS.equals(type)){//评价表
			templ = "aidAssessPrintTemeplete.docx";
			fileName = "医学重点人才培养绩效评价表";
		}
		if(StringUtil.isNotBlank(templ)&&StringUtil.isNotBlank(talentsFlow)){
			AidTalentsExt aidExt = this.aidTalentsBiz.query(talentsFlow);
			paramMap.put("orgName", StringUtil.defaultIfEmpty(aidExt.getOrgName(),""));
			paramMap.put("applyDate", StringUtil.defaultIfEmpty(aidExt.getApplyDate(),""));
			paramMap.put("assessDate", StringUtil.defaultIfEmpty(aidExt.getAssessDate(),""));
			paramMap.put("userName", StringUtil.defaultIfEmpty(aidExt.getUserName(),""));
			paramMap.put("mainCompose", StringUtil.defaultIfEmpty(aidExt.getMainCompose(),""));
			paramMap.put("deptName", StringUtil.defaultIfEmpty(aidExt.getDeptName(), ""));
			paramMap.put("postName", StringUtil.defaultIfEmpty(aidExt.getPostName(), ""));
			paramMap.put("titleName", StringUtil.defaultIfEmpty(aidExt.getTitleName(), ""));
			paramMap.put("sexName", StringUtil.defaultIfEmpty(aidExt.getSexName(), ""));
			paramMap.put("userBirthday", StringUtil.defaultIfEmpty(aidExt.getUserBirthday(), ""));
			paramMap.put("studyCountry", StringUtil.defaultIfEmpty(aidExt.getStudyCountry(), ""));
			paramMap.put("startDate", StringUtil.defaultIfEmpty(aidExt.getStartDate(), ""));
			paramMap.put("endDate", StringUtil.defaultIfEmpty(aidExt.getEndDate(), ""));
			paramMap.put("studyName", StringUtil.defaultIfEmpty(aidExt.getStudyName(), ""));
			paramMap.put("content", StringUtil.defaultIfEmpty(aidExt.getContent(), ""));
			paramMap.put("applyFee", StringUtil.defaultIfEmpty(aidExt.getApplyFee(), ""));
			paramMap.put("sqPrincipal", StringUtil.defaultIfEmpty(aidExt.getSqPrincipal(), ""));
			paramMap.put("newBusiness", StringUtil.defaultIfEmpty(aidExt.getNewBusiness(), ""));
			paramMap.put("thesis", StringUtil.defaultIfEmpty(aidExt.getThesis(), ""));
			paramMap.put("project", StringUtil.defaultIfEmpty(aidExt.getProject(), ""));
			paramMap.put("other", StringUtil.defaultIfEmpty(aidExt.getOther(), ""));
			String path = "/jsp/srm/aid/talents/"+templ;
			ServletContext context =  request.getServletContext();
			String watermark = GeneralMethod.getWatermark(watermarkFlag);
			WordprocessingMLPackage temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), paramMap,watermark , false);
			if(temeplete!=null){
				response.setContentType ("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
				String name = fileName+".docx";
				response.setHeader("Content-disposition","attachment; filename="+new String(name.getBytes("gbk"),"ISO8859-1" ) +""); 
				
				ServletOutputStream out = response.getOutputStream ();
				(new SaveToZipFile (temeplete)).save (out);
				out.flush ();
			}
			
		}
	}
}
