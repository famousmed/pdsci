package com.pinde.sci.ctrl.erp;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.erp.IErpDocBiz;
import com.pinde.sci.biz.erp.IErpDocLogBiz;
import com.pinde.sci.biz.erp.IErpDocShareBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IDictBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.sys.ReqTypeEnum;
import com.pinde.sci.model.erp.ErpDocShareExt;
import com.pinde.sci.model.mo.ErpDoc;
import com.pinde.sci.model.mo.ErpDocLog;
import com.pinde.sci.model.mo.ErpDocShare;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("erp/doc")
public class DocumentController extends GeneralController{ 
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IErpDocBiz erpDocBiz;
	@Autowired
	private IDictBiz dictBiz;
	@Autowired
	private IErpDocShareBiz erpDocShareBiz;
	@Autowired
	private IErpDocLogBiz erpDocLogBiz;
	
	@RequestMapping(value = "/list/{docCategory}",method={RequestMethod.POST,RequestMethod.GET})
	public String list(@PathVariable String docCategory, ErpDoc erpDoc, String afterDate, String userName, String sortType, Integer currentPage,HttpServletRequest request, Model model){
		setSessionAttribute("docCategory", docCategory);
		//文档类型
		List<String> fileTypeList = erpDocBiz.searchFileTypeList();
		model.addAttribute("fileTypeList", fileTypeList);
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(StringUtil.isNotBlank(erpDoc.getCreateTime())){
			StringBuffer beforeDateSB = new StringBuffer(DateUtil.getDate(erpDoc.getCreateTime()));
			beforeDateSB.append("000000");
			erpDoc.setCreateTime(beforeDateSB.toString());
		}
		if(StringUtil.isNotBlank(afterDate)){
			StringBuffer afterDateSB = new StringBuffer(DateUtil.getDate(afterDate));
			afterDateSB.append("235959");
			afterDate = afterDateSB.toString();
		}
		if(StringUtil.isBlank(sortType)){
			sortType = "CREATE_TIME DESC";
		}
		paramMap.put("sortType", sortType);
		paramMap.put("erpDoc", erpDoc);
		paramMap.put("userName", userName);
		paramMap.put("afterDate", afterDate);
		SysUser currUser = GlobalContext.getCurrentUser();
		if("created".equals(docCategory)){
			erpDoc.setCreateUserFlow(currUser.getUserFlow());
		}else if("shared".equals(docCategory)){//共享给我的文档
			paramMap.put("userFlow", currUser.getUserFlow());
			paramMap.put("deptFlow", currUser.getDeptFlow());
			//PageHelper.startPage(currentPage, getPageSize(request));
			//List<ErpDocShareExt> erpDocShareExtList = erpDocShareBiz.searchErpDocShareExtList(paramMap);
			//model.addAttribute("erpDocShareExtList", erpDocShareExtList);
			//return "erp/doc/list";
		}else if("public".equals(docCategory)){
			erpDoc.setIsPublic(GlobalConstant.RECORD_STATUS_Y);
		}else if("all".equals(docCategory)){
			paramMap.put("userFlow", currUser.getUserFlow());
			paramMap.put("deptFlow", currUser.getDeptFlow());
			erpDoc.setCreateUserFlow(currUser.getUserFlow());
			erpDoc.setIsPublic(GlobalConstant.RECORD_STATUS_Y);
			paramMap.put("all",GlobalConstant.RECORD_STATUS_Y);
		}
		PageHelper.startPage(currentPage, getPageSize(request));
		List<ErpDoc> erpDocList = erpDocBiz.searchErpDocList(paramMap);
		model.addAttribute("erpDocList", erpDocList);
		return "erp/doc/list";
	}
	
	/**
	 * 上传文档
	 */
	@RequestMapping(value="/addDoc")
	public String addDoc(){
		return "erp/doc/add";
	}
	
	/**
	 * 保存文档及分享个人、部门
	 * @param file
	 * @param erpDoc
	 * @return
	 */
	@RequestMapping(value="/saveDocFile")
	@ResponseBody
	public String saveDocFile(MultipartFile file, String[] shareTypeId, String[] shareRecordFlow, String[] shareRecordName, ErpDoc erpDoc){
		String checkResult = checkFile(file);
		if(checkResult != GlobalConstant.FLAG_Y){
			return checkResult;
		}
		int result = erpDocBiz.saveDocFile(file, erpDoc, shareTypeId, shareRecordFlow, shareRecordName);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 检查上传文件大小
	 * @param file
	 * @return
	 */
	private String checkFile(MultipartFile file) {
		String limitSize = InitConfig.getSysCfg("erp_doc_limit_size");
		limitSize = StringUtil.defaultIfEmpty(limitSize, "100");
		if(file.getSize() > Long.parseLong(limitSize)*1024*1024){
			return GlobalConstant.UPLOAD_IMG_SIZE_ERROR + limitSize +"M";
		}
		return GlobalConstant.FLAG_Y;//可执行保存
	}
	
	/**
	 * 修改单个分享记录
	 * @param docShare
	 * @return
	 */
	@RequestMapping(value="/modifySingleDocShare")
	@ResponseBody
	public String modifySingleDocShare(ErpDocShare docShare){
		if(StringUtil.isNotBlank(docShare.getDocFlow())){
			ErpDocShare result = erpDocBiz.modifySingleDocShare(docShare);
			return result.getRecordStatus();
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 *选择共享
	 */
	@RequestMapping(value={"/userMain"},method={RequestMethod.GET,RequestMethod.POST})
	public String  userMain(){
		return "erp/doc/userMain";
	}
	
	/**
	 * 选择共享人
	 * @param search
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/searchShareUsers"},method={RequestMethod.GET,RequestMethod.POST})
	public String searchShareUsers(SysUser sysUser, String docFlow, String shareTypeId, Model model){
		SysDept dept=new SysDept();
		dept.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		dept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysDept> deptList=this.deptBiz.searchDept(dept);
		model.addAttribute("deptList", deptList);
		
		sysUser.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		sysUser.setStatusId(UserStatusEnum.Activated.getId());
		List<SysUser> sysUserList = userBiz.searchUser(sysUser);
		model.addAttribute("sysUserList", sysUserList);
		if(StringUtil.isNotBlank(docFlow)){
			searchUserAndDept(docFlow, shareTypeId, model);
		}
		return "erp/doc/shareUsers";
	}
	
	/**
	 * 选择共享部门
	 * @param dept
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/searchShareDepts"},method={RequestMethod.GET,RequestMethod.POST})
	public String searchShareDepts(SysDept sysDept, String docFlow, String shareTypeId, Model model){
		sysDept.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		sysDept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysDept> deptList = deptBiz.searchDept(sysDept);
		model.addAttribute("deptList", deptList);
		if(StringUtil.isNotBlank(docFlow)){
			searchUserAndDept(docFlow, shareTypeId, model);
		}
		return "erp/doc/shareDepts";
	}
	
	/**
	 * 已共享文档的部门、个人
	 * @param docFlow
	 * @param shareTypeId
	 * @param model
	 */
	private void searchUserAndDept(String docFlow, String shareTypeId, Model model) {
		ErpDocShare docShare = new ErpDocShare();
		docShare.setDocFlow(docFlow);
		docShare.setShareTypeId(shareTypeId);
		docShare.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<ErpDocShare> docShareList = erpDocShareBiz.searchErpDocShareList(docShare);
		if(docShareList != null && !docShareList.isEmpty()){
			Map<String, ErpDocShare> docShareMap = new HashMap<String, ErpDocShare>();
			for(ErpDocShare share : docShareList){
				if (share.getCreateUserFlow().equals(GlobalContext.getCurrentUser().getUserFlow())){
					docShareMap.put(share.getShareRecordFlow()+"_my", share);
				}else{
					docShareMap.put(share.getShareRecordFlow()+"_other", share);
				}
			}
			model.addAttribute("docShareList", docShareList);
			model.addAttribute("docShareMap", docShareMap);
		}
	}
	
	/**
	 * 查看、编辑文档
	 * @param docFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/editDoc")
	public String editDoc(String docFlow, Model model){
		if(StringUtil.isNotBlank(docFlow)){
			ErpDoc erpDoc = erpDocBiz.readErpDoc(docFlow);
			model.addAttribute("erpDoc", erpDoc);
			ErpDocShare docShare = new ErpDocShare();
			docShare.setDocFlow(docFlow);
			docShare.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<ErpDocShare> docShareList = erpDocShareBiz.searchErpDocShareList(docShare);
			model.addAttribute("docShareList", docShareList);
		}
		return "erp/doc/edit";
	}
	
	/**
	 * 修改文档
	 * @param erpDoc
	 * @return
	 */
	@RequestMapping(value="/modifyErpDoc")
	@ResponseBody
	public String modifyErpDoc(ErpDoc erpDoc){
		if(StringUtil.isNotBlank(erpDoc.getDocFlow())){
			int result = erpDocBiz.modifyErpDoc(erpDoc);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	/**
	 * 批量共享
	 * @param docFlow
	 * @param shareTypeId
	 * @param shareRecordFlow
	 * @param shareRecordName
	 * @param recordStatus
	 * @return
	 */
	@RequestMapping(value="/batchShare")
	@ResponseBody
	public String batchShare(String[] docFlow, String shareTypeId, String shareRecordFlow, String shareRecordName, String recordStatus){
		String result = erpDocShareBiz.batchShare(docFlow, shareTypeId, shareRecordFlow, shareRecordName, recordStatus);
		if(result != null){
			return result;
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	/**
	 * 删除Doc
	 * @param erpDoc
	 * @return
	 */
	@RequestMapping(value="/delDoc")
	@ResponseBody
	public String delDoc(String docFlow){
		if(StringUtil.isNotBlank(docFlow)){
			ErpDoc erpDoc = new ErpDoc();
			erpDoc.setDocFlow(docFlow);
			erpDoc.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			int result = erpDocBiz.saveErpDoc(erpDoc);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	/**
	 * 批量删除
	 * @param docFlow
	 * @return
	 */
	@RequestMapping(value="/batchDelDoc")
	@ResponseBody
	public String batchDelDoc(String[] docFlow){
		if(docFlow.length > 0){
			List<String> docFlowList = Arrays.asList(docFlow);
			int result = erpDocBiz.batchDelByDocFlowList(docFlowList);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	
	/**
	 * 删除Doc
	 * @param erpDoc
	 * @return
	 */
	@RequestMapping(value="/delDocShare")
	@ResponseBody
	public String delDocShare(String docFlow){
		if(StringUtil.isNotBlank(docFlow)){
			ErpDocShare erpDocShare = new ErpDocShare();
			erpDocShare.setDocFlow(docFlow);
			erpDocShare.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			int result = erpDocShareBiz.saveErpDocShare(erpDocShare);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}

	
	//*********************** ErpDocLog *************************
	
	/**
	 * 文档查阅日志记录
	 * @param docFlow
	 * @param docName
	 * @return
	 */
	@RequestMapping(value="/docLog",method={RequestMethod.POST})
	@ResponseBody
	public String docLog(String docFlow, String docName){
		if(StringUtil.isNotBlank(docFlow)){
			ErpDocLog docLog = new ErpDocLog();
			docLog.setDocFlow(docFlow);
			docLog.setReqTypeId(ReqTypeEnum.GET.getId());
			docLog.setReqTypeName(ReqTypeEnum.getNameById(ReqTypeEnum.GET.getId()));
			String operName = "查阅";
			docLog.setOperName(operName);
			docLog.setLogDesc(operName+"了文档");
			int result = erpDocLogBiz.docLog(docLog);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	/**
	 * 反馈及评论
	 */
	@RequestMapping(value="/comments")
	public String comments(){
		return "erp/doc/comments";
	}
	
	/**
	 * 查阅情况/操作日志
	 * @param docLog
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/searchDocLogs")
	public String searchDocLogs(ErpDocLog docLog, Model model){
		if(StringUtil.isNotBlank(docLog.getDocFlow())){
			List<ErpDocLog> docLogList = erpDocLogBiz.searchErpDocLogList(docLog);
			model.addAttribute("docLogList", docLogList);
		}
		if(ReqTypeEnum.GET.getId().equals(docLog.getReqTypeId())){
			return "erp/doc/readCase";//查阅情况
		}else{
			return "erp/doc/logs";//操作日志
		}
	}
	
	@RequestMapping(value="/loadLabelList")
	@ResponseBody
	public List<SysDict> loadLabelList(){
		return this.dictBiz.searchDictListByDictTypeId("Label");
	}
	
}

