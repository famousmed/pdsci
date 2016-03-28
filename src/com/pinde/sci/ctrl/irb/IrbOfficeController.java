package com.pinde.sci.ctrl.irb;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.irb.IIrbRegulationBiz;
import com.pinde.sci.biz.irb.IIrbStampBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.pub.IPubTrainBiz;
import com.pinde.sci.biz.pub.IPubTrainUserBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.irb.IrbRegulationTypeEnum;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.model.mo.IrbRegulation;
import com.pinde.sci.model.mo.IrbStamp;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubTrain;
import com.pinde.sci.model.mo.PubTrainUser;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/irb/office")
public class IrbOfficeController extends GeneralController{    
	
	private static Integer DEFAULT_PAGE_SIZE = 15;//默认分页数大小
	
	private static Logger logger = LoggerFactory.getLogger(IrbOfficeController.class);
	@Autowired
	private IPubTrainBiz trainBiz;
	@Autowired
	private IPubTrainUserBiz trainUserBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IFileBiz fileBiz;
	@Autowired
	private IPubProjBiz projBiz;
	@Autowired
	private IIrbStampBiz stampBiz;
	@Autowired
	private IIrbRegulationBiz regulationBiz;
	
	/**
	 * 加载盖章登记列表、查询
	 */
	@RequestMapping(value={"/seal"},method={RequestMethod.GET,RequestMethod.POST})
	public String seal(IrbStamp stamp,String stampEndDate,Integer currentPage,HttpServletRequest request, Model model){
		PageHelper.startPage(currentPage, getPageSize(request));
		List<IrbStamp> stampList = stampBiz.queryStampList(stamp,stampEndDate);
		Map<String,PubProj> projMap = new HashMap<String, PubProj>();
		if(null !=stampList && !stampList.isEmpty()){
			for(IrbStamp s : stampList){
				if(StringUtil.isNotEmpty(s.getProjFlow())){
					PubProj  proj = projBiz.readProject(s.getProjFlow());
					if(null != proj){
						projMap.put(s.getStampFlow(), proj);
					}
				}
			}
		}
		model.addAttribute("stampList", stampList);
		model.addAttribute("projMap", projMap);
		return "irb/office/seal/list";
	}
	/**
	 * 盖章登记新增、编辑跳转
	 */
	@RequestMapping(value={"/editSeal"},method={RequestMethod.GET})
	public String editSeal(String stampFlow,Model model){
		if(StringUtil.isNotBlank(stampFlow)){
			IrbStamp stamp = stampBiz.getStampByFlow(stampFlow);
			model.addAttribute("stamp", stamp);
		}else{
			SysUser currUser = GlobalContext.getCurrentUser();
			model.addAttribute("currUser", currUser);
		}
		return "irb/office/seal/edit";
	}
	
	/**
	 * 选择盖章项目列表
	 * @param currentPage
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/showProj"},method={RequestMethod.GET,RequestMethod.POST})
	public String showProj(Integer currentPage,PubProj proj,HttpServletRequest request, Model model){
		
		PageHelper.startPage(currentPage, getPageSize(request));
		
		List<PubProj> projList = projBiz.queryProjList(proj);
		model.addAttribute("projList", projList);
		return "irb/office/seal/projList";
	}
	
	/**
	 * 保存盖章登记
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/saveStamp"},method={RequestMethod.POST})
	@ResponseBody
	public String saveStamp(IrbStamp stamp, Model model){
		if(null != stamp){
			int reslut = stampBiz.saveStamp(stamp);
			if(reslut == GlobalConstant.ONE_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 删除盖章登记
	 * @param stamp
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/delSeal"},method={RequestMethod.GET})
	@ResponseBody
	public String delSeal(String stampFlow, Model model){
		if(StringUtil.isNotBlank(stampFlow)){
			IrbStamp stamp = stampBiz.getStampByFlow(stampFlow);
			stamp.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			int reslut = stampBiz.saveStamp(stamp);
			if(reslut == GlobalConstant.ONE_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	/**
	 * 加载培训列表、查询
	 * @param train
	 * @param endTrainDate
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/train"},method={RequestMethod.GET,RequestMethod.POST})
	public String train(PubTrain train,String endTrainDate,String currentPage, Model model){
		List<PubTrain> trainList = trainBiz.queryTrainList(train, endTrainDate, null);
		model.addAttribute("trainCategoryId", train.getTrainCategoryId());
		model.addAttribute("trainList", trainList);
		return "irb/office/train/list";
	}
	
	/**
	 * 查看培训证书
	 * @param trainFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/certificate"},method={RequestMethod.GET})
	public String certificate(String trainFlow,Model model){
		Map<String, PubFile> fileMap = new HashMap<String, PubFile>();
		if(StringUtil.isNotBlank(trainFlow)){
			PubTrainUser temp = new PubTrainUser();
			temp.setTrainFlow(trainFlow);
			List<PubTrainUser> userList =trainUserBiz.queryTrainUserList(temp);
			if(null != userList && userList.size() > 0){
				for(PubTrainUser user : userList){
					if(StringUtil.isNotBlank(user.getFileFlow())){
						PubFile file = fileBiz.readFile(user.getFileFlow());
						fileMap.put(user.getRecordFlow(), file);
					}
				}
			}
			model.addAttribute("userList", userList);
			model.addAttribute("fileMap", fileMap);
		}
		return "irb/office/train/certificate";
	}
	
	/**
	 * 保存培训证书
	 * @param request
	 * @param recordFlows
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/saveCertificate"},method={RequestMethod.POST})
	@ResponseBody
	public String saveCertificate(MultipartRequest request, String[] recordFlows,String[] fileNo, String trainCategoryId,Model model){
		List<MultipartFile> filesList = request.getFiles("files");
		if(filesList != null && filesList.size() > 0){
			 trainUserBiz.saveFiles(filesList, recordFlows,fileNo);
			 return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 新增或编辑培训信息
	 * @param trainCategoryId
	 * @param trainFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/editTrain"},method={RequestMethod.GET,RequestMethod.POST})
	public String editTrain(String trainCategoryId,String trainFlow,Model model){
		if(StringUtil.isNotBlank(trainFlow)){
			PubTrain train = trainBiz.getTrainByFlow(trainFlow);
			model.addAttribute("train", train);
			
			PubTrainUser temp = new PubTrainUser();
			temp.setTrainFlow(trainFlow);
			List<PubTrainUser> trainUserList = trainUserBiz.queryTrainUserList(temp);
			model.addAttribute("trainUserList", trainUserList);
			
			Map<String, SysUser> trainUserMap = new LinkedHashMap<String, SysUser>();
			SysUser sysUser = null;
			for (PubTrainUser trainUser : trainUserList) {
				sysUser = userBiz.readSysUser(trainUser.getUserFlow());
				trainUserMap.put(trainUser.getUserFlow(), sysUser);
			}
			model.addAttribute("trainUserMap", trainUserMap);
		}
		model.addAttribute("trainCategoryId", trainCategoryId);
		return "irb/office/train/edit";
	}
	
	@RequestMapping(value={"/userMain"},method={RequestMethod.GET,RequestMethod.POST})
	public String  userMain(SysUser search,Model model){
		List<SysDept> deptList = trainUserBiz.queryIrbDept();
		model.addAttribute("deptList", deptList);
		
		search.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		search.setStatusId(UserStatusEnum.Activated.getId());
		List<SysUser> sysUserList = userBiz.searchUser(search);
		model.addAttribute("sysUserList", sysUserList);
		
		Map<String,SysUser> sysUserMap = new HashMap<String, SysUser>();
		if (sysUserList != null && sysUserList.size() > 0) {
			for(SysUser sysuser : sysUserList){
				sysUserMap.put(sysuser.getUserFlow(), sysuser);
			}
		}
		model.addAttribute("sysUserMap", sysUserMap);
		
		model.addAttribute("userName", search.getUserName());
		model.addAttribute("deptFlow", search.getDeptFlow());
		
		return "irb/office/train/userMain";
	}
	
	/**
	 * 保存培训人员
	 * @param userFlows
	 * @param train
	 * @return
	 */
	@RequestMapping(value={"/saveTrainUser"})
	@ResponseBody
	public String saveTrainUser(String[] userFlows, PubTrain train){
		int result = this.trainUserBiz.saveTrainUser(userFlows, train);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value={"/delTrainUser"})
	@ResponseBody
	public String delTrainUser(String recordFlow){
		PubTrainUser user = new PubTrainUser();
		user.setRecordFlow(recordFlow);
		user.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		this.trainUserBiz.editUser(user);
		
		return GlobalConstant.DELETE_SUCCESSED;
	}
	
	/**
	 * 删除培训信息
	 * @param trainFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/delTrain"})
	@ResponseBody
	public String delTrain(String trainFlow,Model model){
		if(StringUtil.isNotBlank(trainFlow)){
			PubTrain train = trainBiz.getTrainByFlow(trainFlow);
			if(null != train){
				PubTrainUser temp = new PubTrainUser();
				temp.setTrainFlow(trainFlow);
				List<PubTrainUser> userlist = trainUserBiz.queryTrainUserList(temp);
				for(PubTrainUser user : userlist){
					if(StringUtil.isNotBlank(user.getFileFlow())){
						PubFile file = new PubFile();
						file.setFileFlow(user.getFileFlow());
						file.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
						fileBiz.editFile(file);
					}
					user.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
					trainUserBiz.editUser(user);
				}
				int result = trainBiz.deleteTrain(train);
				if(result == GlobalConstant.ONE_LINE){
					return GlobalConstant.DELETE_SUCCESSED;
				}
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	@RequestMapping(value={"/searchTrain"},method={RequestMethod.POST,RequestMethod.GET})
	public String searchTrain(PubTrain train, String endTrainDate, String userName,Integer currentPage,HttpServletRequest request, Model model){
		List<PubTrainUser> trainUserListByName = new ArrayList<PubTrainUser>();
		List<String> trainFlows = new ArrayList<String>();
		
		//培训类别
		List<String> typeIdList = new ArrayList<String>();
		if(StringUtil.isNotBlank(train.getTrainTypeId())){
			String[] typeIds = train.getTrainTypeId().split(",");
			typeIdList = Arrays.asList(typeIds);
			model.addAttribute("typeIdList", typeIdList);
		}
		if(typeIdList.size() > 1){
			train.setTrainTypeId(null);
		}
			
		//培训类型
		List<String> categoryIdList = new ArrayList<String>();
		if(StringUtil.isNotBlank(train.getTrainCategoryId())){
			String[] categoryIds = train.getTrainCategoryId().split(",");
			categoryIdList = Arrays.asList(categoryIds);
			model.addAttribute("categoryIdList" , categoryIdList);
			
		}
		if(categoryIdList.size() > 1){
			train.setTrainCategoryId(null);
		}
		
		boolean flag = true;
		
		if(StringUtil.isNotBlank(userName)){
			PubTrainUser temp = new PubTrainUser();
			temp.setUserName(userName);
			trainUserListByName = trainUserBiz.queryTrainUserList(temp);
			for(PubTrainUser user : trainUserListByName){
				String trainFlow = user.getTrainFlow();
				trainFlows.add(trainFlow);
			}
			if(null == trainFlows || trainFlows.isEmpty()){
				flag = false;
			}
		}
		
		if(!flag){
			return "irb/office/train/searchList";
		}
		PageHelper.startPage(currentPage, getPageSize(request));
		
		List<PubTrain> trainList = trainBiz.queryTrainList(train, endTrainDate, trainFlows);

		Map<String,List<PubTrainUser>> trainUserMap = new LinkedHashMap<String, List<PubTrainUser>>();
		if(null != trainList && !trainList.isEmpty()){
			List<PubTrainUser> trainUserList = new ArrayList<PubTrainUser>();
			for(PubTrain tr : trainList){
				if(StringUtil.isNotBlank(tr.getTrainFlow())){
					PubTrainUser temp = new PubTrainUser();
					temp.setTrainFlow(tr.getTrainFlow());
					trainUserList = trainUserBiz.queryTrainUserList(temp);
					trainUserMap.put(tr.getTrainFlow(), trainUserList);
				}
			}
		}
		model.addAttribute("trainList", trainList);
		model.addAttribute("trainUserMap", trainUserMap);
		return "irb/office/train/searchList";
	}
	
	
	@RequestMapping(value={"/regulation"},method={RequestMethod.GET})
	public String sop(String arrange,IrbRegulation regulation, Model model){
		Map<String,List<IrbRegulation>> regulationMap = new LinkedHashMap<String, List<IrbRegulation>>();
		List<IrbRegulation> regulationList = new ArrayList<IrbRegulation>();
		
		IrbRegulationTypeEnum[] enums = IrbRegulationTypeEnum.values();
		for(IrbRegulationTypeEnum e :enums){
			if(e.getArrange().equals(arrange)){
				regulation.setRegTypeId(e.getId());
				regulationList = regulationBiz.queryRegulationList(regulation);
				regulationMap.put(e.getId(), regulationList);
			}
		}
		model.addAttribute("regulationMap", regulationMap);
		return "irb/office/sop/list";
	}
	
	
	@RequestMapping(value={"/saveRegulation"},method={RequestMethod.POST})
	@ResponseBody
	public String saveRegulation(MultipartFile uploadFile,IrbRegulation regulation, Model model){
		if(null != uploadFile && null != regulation){
			String fileName = uploadFile.getOriginalFilename();
			String suffix = fileName.substring(fileName.lastIndexOf(".")+1);
			
			InputStream inS = null;
			try {
				inS = uploadFile.getInputStream();
				byte[] bytes = new byte[(int)uploadFile.getSize()];
				inS.read(bytes);
				
				PubFile file = new PubFile();
				file.setFileSuffix(suffix);
				file.setFileName(fileName);
				file.setFileContent(bytes);
				
				if(StringUtil.isNotBlank(regulation.getFileFlow())){
					PubFile existFile = fileBiz.readFile(regulation.getFileFlow());
					if(null != existFile){
						if(StringUtil.isBlank(file.getFileName())){//修改没有选择文件
							file = existFile;
						}else{
							file.setFileFlow(regulation.getFileFlow());
							file.setCreateTime(existFile.getCreateTime());
							file.setCreateUserFlow(existFile.getCreateUserFlow());
							file.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
						}
					}
				}
				
				int result = regulationBiz.editRegulation(file, regulation);
				if(result == GlobalConstant.ONE_LINE){
					return GlobalConstant.SAVE_SUCCESSED;
				}
			} catch (IOException e) {
				e.printStackTrace();
				return e.getMessage();
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}

	
	@RequestMapping(value={"/editRegulation"},method={RequestMethod.GET})
	public String editRegulation(IrbRegulation regulation, Model model){
		if(StringUtil.isNotBlank(regulation.getRegFlow())){
			regulation = regulationBiz.getRegulationByFlow(regulation.getRegFlow());
			if(null != regulation && StringUtil.isNotBlank(regulation.getFileFlow())){
				PubFile file = fileBiz.readFile(regulation.getFileFlow());
				model.addAttribute("file", file);
			}
		}
		model.addAttribute("regulation", regulation);
		return "irb/office/sop/edit";
	}
	
	@RequestMapping(value={"/delRegulation"},method={RequestMethod.GET})
	@ResponseBody
	public String delRegulation(String regFlow,Model model){
		if(StringUtil.isNotBlank(regFlow)){
			IrbRegulation regulation = regulationBiz.getRegulationByFlow(regFlow);
			if(null != regulation){
				regulation.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				if(StringUtil.isNotBlank(regulation.getFileFlow())){
					PubFile file =  fileBiz.readFile(regulation.getFileFlow());
					if(null != file){
						file.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
						int result =  regulationBiz.editRegulation(file, regulation);
						if(result == GlobalConstant.ONE_LINE){
							return GlobalConstant.DELETE_SUCCESSED;
						}
					}
				}
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	@RequestMapping(value={"/fund"},method={RequestMethod.GET})
	public String fund(String type ,Model model){
		if("in".equals(type)){
			return "irb/office/fund/inlist";
		}else {
			return "irb/office/fund/outlist";
		}
	}
	@RequestMapping(value={"/editFund"},method={RequestMethod.GET})
	public String editFund(String type ,Model model){
		return "irb/office/fund/edit";
	}
}

