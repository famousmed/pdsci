package com.pinde.sci.ctrl.srm;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.alibaba.fastjson.JSON;
import com.pinde.core.page.PageHelper;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IReseachrepAuthorBiz;
import com.pinde.sci.biz.srm.IReseachrepBiz;
import com.pinde.sci.biz.srm.ISrmAchFileBiz;
import com.pinde.sci.biz.srm.ISrmAchProcessBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.enums.srm.AchStatusEnum;
import com.pinde.sci.enums.srm.AchTypeEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SrmAchReseachrep;
import com.pinde.sci.model.mo.SrmAchReseachrepAuthor;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.SrmAchReseachrepAuthorList;

@Controller
@RequestMapping("/srm/ach/reseachrep")
public class AchReseachrepController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(AchReseachrepController.class);
	
	@Autowired
	private IReseachrepBiz reseachrepBiz;
	@Autowired
    private IReseachrepAuthorBiz authorBiz;
	@Autowired
	private ISrmAchFileBiz srmAchFileBiz;
	@Autowired
	private ISrmAchProcessBiz srmAchProcessBiz;
	@Autowired
	private IOrgBiz orgBiz;
	
	/**
	 * ��ȡ�б�
	 * @param reseachrep
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list")
	public String list(SrmAchReseachrep reseachrep, Integer currentPage,HttpServletRequest request, Model model){
		
		SysUser currUser = GlobalContext.getCurrentUser();
		reseachrep.setApplyUserFlow(currUser.getUserFlow());
		
		PageHelper.startPage(currentPage, getPageSize(request));
   		
   		List<SrmAchReseachrep> reseachrepList= this.reseachrepBiz.search(reseachrep,null);
   		//�������
   		Map<String,List<SrmAchReseachrepAuthor>> allAuthorMap = new LinkedHashMap<String,List<SrmAchReseachrepAuthor>>();
   		List<SrmAchReseachrepAuthor> allreseachrepAuthorList = authorBiz.searchAuthorList(new SrmAchReseachrepAuthor());
   		for(SrmAchReseachrepAuthor a : allreseachrepAuthorList){
   			List<SrmAchReseachrepAuthor> list = allAuthorMap.get(a.getReseachrepFlow());
   			if(list == null){
   				list = new ArrayList<SrmAchReseachrepAuthor>();
   			}
   			list.add(a);
   			allAuthorMap.put(a.getReseachrepFlow(), list);
   		}
		 model.addAttribute("reseachrepList", reseachrepList);
		 model.addAttribute("allAuthorMap", allAuthorMap);
		return "srm/ach/reseachrep/list";
	}
	
	
	/**
	 * �༭
	 * @param reseachrepFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/edit")
	public String edit(String reseachrepFlow, Model model){
		 if(StringUtil.isNotBlank(reseachrepFlow)){
			 //
		     SrmAchReseachrep reseachrep=this.reseachrepBiz.readReseachrep(reseachrepFlow);
		     model.addAttribute("reseachrep",reseachrep);
		     
		     //������ˮ�Ų�ѯ����
	    	 SrmAchReseachrepAuthor author = new SrmAchReseachrepAuthor();
	    	 author.setReseachrepFlow(reseachrepFlow);
		     List<SrmAchReseachrepAuthor> reseachrepAuthorList = this.authorBiz.searchAuthorList(author);
			 model.addAttribute("reseachrepAuthorList", reseachrepAuthorList);
			 
			 //�鸽��
			 List<SrmAchFile> fileList  = srmAchFileBiz.searchSrmAchFile(reseachrepFlow);  
		     if(fileList != null && !fileList.isEmpty()){
		    	 SrmAchFile file=fileList.get(0);
			     model.addAttribute("file", file);
		     }
	     }
		 return "srm/ach/reseachrep/edit";
	}
	
	/**
	 * �����о�����
	 * @param jsondata
	 * @param file
	 * @param request
	 * @return
	 */
	@RequestMapping(value={"/save"},method=RequestMethod.POST)
	@ResponseBody
    public  String save(String jsondata ,@RequestParam(value="file" , required=false)MultipartFile file,HttpServletRequest request)
    {      		
		 SrmAchReseachrepAuthorList aList = JSON.parseObject(jsondata, SrmAchReseachrepAuthorList.class);
		 
		 SysUser currUser = GlobalContext.getCurrentUser();
		
		 List<SrmAchReseachrepAuthor> authorList=aList.getAuthorList();
		 SrmAchReseachrep reseachrep = aList.getReseachrep();
	      //ö�٣������о��������IDö�ٻ��name
		 reseachrep.setBelongOrgName(DictTypeEnum.OrgBelong.getDictNameById(reseachrep.getBelongOrgId()));
		 reseachrep.setSubjectTypeName(DictTypeEnum.SubjectType.getDictNameById(reseachrep.getSubjectTypeId()));
		 reseachrep.setAcceptObjectName(DictTypeEnum.AcceptOrg.getDictNameById(reseachrep.getAcceptObjectId()));
		 reseachrep.setProjSourceName(DictTypeEnum.ProjSource.getDictNameById(reseachrep.getProjSourceId()));
		 reseachrep.setApplyOrgFlow(currUser.getOrgFlow());
		 reseachrep.setApplyOrgName(currUser.getOrgName());
		 reseachrep.setOperStatusId(AchStatusEnum.Apply.getId());
		 reseachrep.setOperStatusName(AchStatusEnum.Apply.getName());
		 //��������Ϣ
		 reseachrep.setApplyUserFlow(currUser.getUserFlow());
		 reseachrep.setApplyUserName(currUser.getUserName());
		   //ö�٣������о������������IDö�ٻ��name
         for(int i=0;i<authorList.size();i++){
    	    // authorList.get(i).setTypeName(DictTypeEnum.AuthorType.getDictNameById(authorList.get(i).getTypeId()));
    	    authorList.get(i).setSexName(UserSexEnum.getNameById(authorList.get(i).getSexId()));
    	    authorList.get(i).setTitleName(DictTypeEnum.UserTitle.getDictNameById(authorList.get(i).getTitleId()));
    	    authorList.get(i).setDegreeName(DictTypeEnum.UserDegree.getDictNameById(authorList.get(i).getDegreeId()));
    	    authorList.get(i).setEducationName(DictTypeEnum.UserEducation.getDictNameById(authorList.get(i).getEducationId()));
         }
	       //��װ��������
	     SrmAchFile srmAchFile=new SrmAchFile();
	     if(file != null && StringUtil.isNotBlank(file.getOriginalFilename())){
	    	 
			 byte[] b = new byte[(int) file.getSize()]; 
			 try{
				 file.getInputStream().read(b);
			 }
			 catch (Exception e){
				 e.printStackTrace();
			 }
			 srmAchFile.setFileFlow(aList.getSrmAchFile().getFileFlow());
			 srmAchFile.setFileContent(b);
			 srmAchFile.setFileName(file.getOriginalFilename());
			 srmAchFile.setTypeId(AchTypeEnum.Reseachrep.getId());
			 srmAchFile.setTypeName(AchTypeEnum.Reseachrep.getName());
			 String[] nameArray=file.getOriginalFilename().split("\\.");
			 srmAchFile.setFileSuffix(nameArray[nameArray.length-1]);
			 srmAchFile.setFileType(nameArray[nameArray.length-1]);
 		}
        //��װ�ɹ����̶���
        SrmAchProcess srmAchProcess=new SrmAchProcess();
        srmAchProcess.setTypeId(AchTypeEnum.Reseachrep.getId());
        srmAchProcess.setTypeName(AchTypeEnum.Reseachrep.getName());
      
        srmAchProcess.setOperateUserFlow(currUser.getUserFlow());
        srmAchProcess.setOperateUserName(currUser.getUserName());
        srmAchProcess.setOperStatusId(AchStatusEnum.Apply.getId());
        srmAchProcess.setOperStatusName(AchStatusEnum.Apply.getName());
        reseachrepBiz.save(reseachrep, authorList, srmAchFile, srmAchProcess);
        return GlobalConstant.SAVE_SUCCESSED;
    }
	
	
	/**
	 * ɾ������
	 * @param reseachrep
	 * @return
	 */
	@RequestMapping(value = "/delete",method={RequestMethod.GET})
	@ResponseBody
	public  String delete(String reseachrepFlow){
		if(StringUtil.isNotBlank(reseachrepFlow)){
			SrmAchReseachrep reseachrep = new SrmAchReseachrep();
			reseachrep.setReseachrepFlow(reseachrepFlow);
			reseachrep.setRecordStatus(GlobalConstant.RECORD_STATUS_N); 
			//����
			SrmAchReseachrepAuthor author = new SrmAchReseachrepAuthor();
			author.setReseachrepFlow(reseachrepFlow);
			List<SrmAchReseachrepAuthor> authorList = authorBiz.searchAuthorList(author);
			for(SrmAchReseachrepAuthor a : authorList){
				a.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			}
			//����
			SrmAchFile file = null;
			List<SrmAchFile> fileList = srmAchFileBiz.searchSrmAchFile(reseachrepFlow); 
			if(fileList != null && !fileList.isEmpty()){
				 file = fileList.get(0);
				 file.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			}
			int result = reseachrepBiz.edit(reseachrep, authorList, file);
			if(result == GlobalConstant.ONE_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		 }
		 return GlobalConstant.DELETE_FAIL;
	}
	
	/**
	 * ����
	 * @param reseachrepFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/submitAudit")
	@ResponseBody
	public String submitAudit(@RequestParam(value="reseachrepFlow" , required=true)String reseachrepFlow,Model model){
		 SrmAchReseachrep reseachrep = this.reseachrepBiz.readReseachrep(reseachrepFlow);
		 reseachrep.setOperStatusId(AchStatusEnum.Submit.getId());
		 reseachrep.setOperStatusName(AchStatusEnum.Submit.getName());
		 
		 SrmAchProcess process=srmAchProcessBiz.searchAchProcess(reseachrepFlow, AchStatusEnum.Apply.getId()).get(0);
		 
		 process.setProcessFlow(PkUtil.getUUID());
		 process.setOperStatusId(AchStatusEnum.Submit.getId());
		 process.setOperStatusName(AchStatusEnum.Submit.getName());
		 GeneralMethod.setRecordInfo(process, true);
		 process.setOperateTime(process.getCreateTime());
		 SysUser currUser = GlobalContext.getCurrentUser();
	     process.setOperateUserFlow(currUser.getUserFlow());
	     process.setOperateUserName(currUser.getUserName());
	     
	     this.reseachrepBiz.updateReseachrepStatus(reseachrep, process);
	     return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	
	/**
	 * ����б�
	 * @param reseachrep
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/auditList/{scope}")
	public String auditList(@PathVariable String scope,String auditStatus, SrmAchReseachrep reseachrep, SrmAchReseachrepAuthor author, String currentPage,SysOrg org,Model model){
		 SysUser currUser = GlobalContext.getCurrentUser();
		 List<SrmAchReseachrep> searchList=null;
    	 List<SrmAchReseachrep> reseachrepList=null;
    	 //��ѯ��ǰ�����������м����ӻ�����������
    	 List<SysOrg> currOrgChildList=orgBiz.searchChildrenOrgByOrgFlow(currUser.getOrgFlow());
    	 //����orgFlow��chargeOrgFlow��ѯ�����ӻ����б���ӻ������ӻ������б��Map
    	 Map<String,List<SysOrg>> resultMap=orgBiz.searchChargeAndApply(org,scope);
    	 //��ȡ��ǰ��������һ���Ļ���
    	 List<SysOrg> firstGradeOrgList=(List<SysOrg>) resultMap.get("firstGradeOrgList");
    	 model.addAttribute("firstGradeOrgList", firstGradeOrgList);
		 //List<String> reseachrepFlowList = authorBiz.getReseachrepFlowByAuthor(author);
	   	 if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL .equals(scope)){
	   	//���ò�ѯ�������Ƽ������ͨ���ĳɹ�
	     		reseachrep.setOperStatusId(AchStatusEnum.FirstAudit.getId()); 
	    		 //�����ǰ��¼���������֣���ȡ�õ�λѡ������һ�������������ӻ���
	    		 List<SysOrg> secondGradeOrgList=(List<SysOrg>) resultMap.get("secondGradeOrgList");
	    		 if(null!=secondGradeOrgList && !secondGradeOrgList.isEmpty()){
	    			 model.addAttribute("secondGradeOrgList",secondGradeOrgList);
	    		 }
	    		 //�����ѯ����orgFlowΪ����chargeOrgFlow��Ϊ�գ����ѯ�����ܲ����������ӻ��������гɹ�
	 			if(StringUtil.isBlank(org.getOrgFlow()) && StringUtil.isNotBlank(org.getChargeOrgFlow())){
	 				if(null == secondGradeOrgList || secondGradeOrgList.isEmpty()){
		   		    	SysOrg sysOrg=orgBiz.readSysOrg(org.getChargeOrgFlow());
		   		    	List<SysOrg> selfOrgList=new ArrayList<SysOrg>();
		   		    	selfOrgList.add(sysOrg);
			   		    searchList = reseachrepBiz.search(reseachrep,selfOrgList);
		   		    }else{
			   		    searchList = reseachrepBiz.search(reseachrep,secondGradeOrgList);
		   		    }
	 			}	
	   	 }else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE.equals(scope)){
	   		reseachrep.setOperStatusId(AchStatusEnum.FirstAudit.getId());
	   	 }else{
	   		if(StringUtil.isBlank(reseachrep.getOperStatusId())){
	   			reseachrep.setOperStatusId(AchStatusEnum.Submit.getId());
	    	}
	   		if(GlobalConstant.FLAG_Y.equals(reseachrep.getOperStatusId())){
	   			reseachrep.setOperStatusId(AchStatusEnum.Submit.getId()+","+AchStatusEnum.FirstAudit.getId());
	   		}
	   	 }
	   //�����ѯ����orgFlow��Ϊ�գ����ѯ��org�����гɹ�
    	 if(StringUtil.isNotBlank(org.getOrgFlow())){
    		 reseachrep.setApplyOrgFlow(org.getOrgFlow());
	   		 searchList = reseachrepBiz.search(reseachrep, null);
	     }
    	 //�����ѯ����orgFlow��chargeOrgFlow��Ϊ�գ���ô��ѯ��ǰ��¼�������гɹ�
    	 if(StringUtil.isBlank(org.getOrgFlow()) && StringUtil.isBlank(org.getChargeOrgFlow())){
	   		 searchList = reseachrepBiz.search(reseachrep, currOrgChildList);
    	 }
    	 
    	 
    	 Map<String, List<SrmAchReseachrepAuthor>> allAuthorMap = new HashMap<String, List<SrmAchReseachrepAuthor>>();
    	 List<SrmAchReseachrepAuthor> reseachrepAuthorList = authorBiz.searchAuthorList(new SrmAchReseachrepAuthor());
    	 if(reseachrepAuthorList != null && !reseachrepAuthorList.isEmpty()){
    		 for(SrmAchReseachrepAuthor a : reseachrepAuthorList){
    			 List<SrmAchReseachrepAuthor> authorList = allAuthorMap.get(a.getReseachrepFlow());
    			 if(authorList == null){
    				 authorList = new ArrayList<SrmAchReseachrepAuthor>();
    			 }
    			 authorList.add(a);
    			 allAuthorMap.put(a.getReseachrepFlow(), authorList);
    		 }
    	 }			
	    		
		//����
		if(StringUtil.isNotBlank(author.getAuthorName())){ 
			reseachrepList = new ArrayList<SrmAchReseachrep>();
			for(SrmAchReseachrep b : searchList){
				boolean addFlag = false;
				List<SrmAchReseachrepAuthor> authorByNameList = allAuthorMap.get(b.getReseachrepFlow());
				if(authorByNameList != null){
    				for(SrmAchReseachrepAuthor na : authorByNameList){
    					if(na.getAuthorName().equals(author.getAuthorName())){
    						addFlag = true;
    						break;
    					}
    				}
				}
				if(addFlag){
					reseachrepList.add(b);
				}
			}
		}else {
			reseachrepList = searchList;
		}
		model.addAttribute("allAuthorMap", allAuthorMap);
   		model.addAttribute("reseachreps", reseachrepList);
   		return "srm/ach/reseachrep/auditList"+scope;
	}
	/**
	 * ɾ������
	 * @param author
	 * @return
	 */
	@RequestMapping(value = "/deleteAuthor")
	@ResponseBody
	public String deleteAuthor(String authorFlow){
		SrmAchReseachrepAuthor author = new SrmAchReseachrepAuthor();
		author.setAuthorFlow(authorFlow);
		author.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		authorBiz.editReseachrepAuthor(author);
		return GlobalConstant.DELETE_SUCCESSED;
	}
	
	/**
	 * ���
	 * @param reseachrepFlow
	 * @param model
	 * @return
	 */
	@RequestMapping("/audit")
	public String audit(@RequestParam(value="reseachrepFlow" , required=true)String reseachrepFlow,Model model){
		//���ݳɹ���ˮ�Ų�ѯ�����Ϣ�����ڼ������ҳ�� 
		 SrmAchFile file = null;
		 List<SrmAchFile> fileList=null;
		if(StringUtil.isNotBlank(reseachrepFlow)){
			//��ѯ�ɹ�����
			SrmAchReseachrep reseachrep=reseachrepBiz.readReseachrep(reseachrepFlow);
			model.addAttribute("reseachrep", reseachrep);
			//��ѯ�ɹ�����
			SrmAchReseachrepAuthor author = new SrmAchReseachrepAuthor();
	    	author.setReseachrepFlow(reseachrepFlow);
		    List<SrmAchReseachrepAuthor> reseachrepAuthorList = authorBiz.searchAuthorList(author);
			model.addAttribute("reseachrepAuthorList", reseachrepAuthorList);
			//��ѯ�ɹ�����
		    fileList=srmAchFileBiz.searchSrmAchFile(reseachrepFlow);  
		  if(fileList!=null && !fileList.isEmpty()){
		    file=fileList.get(0);
		    model.addAttribute("file", file);
		   }
		}
		return "srm/ach/reseachrep/audit";
	}
	
	@RequestMapping(value="/saveAudit")
	@ResponseBody
	public String saveAudit(@RequestParam(value="agreeFlag" , required=true)String agreeFlag,String auditContent,
			                @RequestParam(value="reseachrepFlow" , required=true)String reseachrepFlow,Model model){
		SrmAchProcess process=srmAchProcessBiz.searchAchProcess(reseachrepFlow, AchStatusEnum.Apply.getId()).get(0);
		SrmAchReseachrep reseachrep = this.reseachrepBiz.readReseachrep(reseachrepFlow);
		if(agreeFlag.equals(GlobalConstant.FLAG_Y)){
			 reseachrep.setOperStatusId(AchStatusEnum.FirstAudit.getId());
			 reseachrep.setOperStatusName(AchStatusEnum.FirstAudit.getName());
			 process.setOperStatusId(AchStatusEnum.FirstAudit.getId());
			 process.setOperStatusName(AchStatusEnum.FirstAudit.getName());
		}
		else{
			 reseachrep.setOperStatusId(AchStatusEnum.RollBack.getId());
			 reseachrep.setOperStatusName(AchStatusEnum.RollBack.getName());
			 process.setOperStatusId(AchStatusEnum.RollBack.getId());
			 process.setOperStatusName(AchStatusEnum.RollBack.getName());
		}
		process.setProcessFlow(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(process, true);
		process.setOperateTime(process.getCreateTime());
		SysUser currUser = GlobalContext.getCurrentUser();
		process.setOperateUserFlow(currUser.getUserFlow());
		process.setOperateUserName(currUser.getUserName());
		process.setContent(auditContent);
		this.reseachrepBiz.updateReseachrepStatus(reseachrep, process);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
}
