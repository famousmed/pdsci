package com.pinde.sci.ctrl.srm;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
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
import com.pinde.sci.biz.srm.IPatentAuthorBiz;
import com.pinde.sci.biz.srm.IPatentBiz;
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
import com.pinde.sci.model.mo.SrmAchPatent;
import com.pinde.sci.model.mo.SrmAchPatentAuthor;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.SrmAchPatentAuthorList;

//���������
@Controller
//��Ŀ·��
@RequestMapping("/srm/ach/patent")
public class AchPatentController  extends GeneralController{

	//�Զ�װ��
    @Autowired
    private IPatentBiz patentBiz;
    @Autowired
    private IPatentAuthorBiz patentAuthorBiz;
    @Autowired
 	private ISrmAchFileBiz srmAchFileBiz;
 	@Autowired
 	private ISrmAchProcessBiz srmAchProcessBiz;
 	@Autowired
	private IOrgBiz orgBiz;
 	
	 /**
	  * ִ�б�����޸Ĳ���ҵ��
	  * @param srmAchPatent ר��ʵ�����
	  * @return
	  * @throws IOException 
	  */
    @RequestMapping(value="/save" ,method=RequestMethod.POST)
    @ResponseBody
    public String save(String jsondata , @RequestParam(value="file" , required=false) MultipartFile file ,HttpServletRequest request) throws IOException{
    	 SrmAchPatentAuthorList aList=JSON.parseObject(jsondata,SrmAchPatentAuthorList.class);  
    	 SrmAchPatent patent=aList.getPatent();
    	 List<SrmAchPatentAuthor> authorList=aList.getAchPatentList();
    	 //ö�٣�����ר�����IDö�ٻ��name    
    	 patent.setCooperTypeName(DictTypeEnum.PatentCooperType.getDictNameById(patent.getCooperTypeId()));
    	 patent.setOrgBelongName(DictTypeEnum.OrgBelong.getDictNameById( patent.getOrgBelongId()));
    	 patent.setRangeName(DictTypeEnum.PatentRange.getDictNameById(patent.getRangeId()));
    	 patent.setStatusName(DictTypeEnum.PatentStatus.getDictNameById(patent.getStatusId()));
    	 patent.setTypeName(DictTypeEnum.PatentType.getDictNameById(patent.getTypeId()));
    	 
    	 patent.setOperStatusId(AchStatusEnum.Apply.getId());
         patent.setOperStatusName(AchStatusEnum.Apply.getName());
         //��ȡ���뵥λ��Ϣ
         SysUser currUser = GlobalContext.getCurrentUser();
         patent.setApplyOrgFlow(currUser.getOrgFlow());
         patent.setApplyOrgName(currUser.getOrgName());
         patent.setApplyUserFlow(currUser.getUserFlow());
         patent.setApplyUserName(currUser.getUserName());
    	
		//ö�٣�����ר���������IDö�ٻ��name
		for(int i = 0; i < authorList.size(); i++){
     		//authorList.get(i).setTypeName(DictTypeEnum.AuthorType.getDictNameById(authorList.get(i).getTypeId()));
  			authorList.get(i).setSexName(UserSexEnum.getNameById(authorList.get(i).getSexId()));
  			authorList.get(i).setTitleName(DictTypeEnum.UserTitle.getDictNameById(authorList.get(i).getTitleId()));
  			authorList.get(i).setDegreeName(DictTypeEnum.UserDegree.getDictNameById(authorList.get(i).getDegreeId()));
  			authorList.get(i).setEducationName(DictTypeEnum.UserEducation.getDictNameById(authorList.get(i).getEducationId()));
	  	}
    	 
		//��װ�ɹ����̶���
		SrmAchProcess srmAchProcess=new SrmAchProcess();
		srmAchProcess.setTypeId(AchTypeEnum.Patent.getId());
		srmAchProcess.setTypeName(AchTypeEnum.Patent.getName());
		srmAchProcess.setOperateUserFlow(currUser.getUserFlow());
		srmAchProcess.setOperateUserName(currUser.getUserName());
		srmAchProcess.setOperStatusId(AchStatusEnum.Apply.getId());
		srmAchProcess.setOperStatusName(AchStatusEnum.Apply.getName());
	       
       	SrmAchFile srmAchFile = null;
		if(file != null && StringUtil.isNotBlank(file.getOriginalFilename())){
			//��װ��������
			srmAchFile =new SrmAchFile();
			byte[] b = new byte[(int) file.getSize()]; 
			file.getInputStream().read(b);
			srmAchFile.setFileFlow(aList.getSrmAchFile().getFileFlow());
			srmAchFile.setFileContent(b);
			srmAchFile.setFileName(file.getOriginalFilename());
			srmAchFile.setTypeId(AchTypeEnum.Patent.getId());
			srmAchFile.setTypeName(AchTypeEnum.Patent.getName());
			String[] nameArray=file.getOriginalFilename().split("\\.");
			srmAchFile.setFileSuffix(nameArray[nameArray.length-1]);
			srmAchFile.setFileType(nameArray[nameArray.length-1]);
		}
		patentBiz.save(patent, authorList,srmAchFile,srmAchProcess);
		return GlobalConstant.SAVE_SUCCESSED;    	  
     }
     
     
     /**
      * ִ�в�ѯ����ҵ��
      * @param srmAchPatent ר��ʵ�����
      * @param model
      * @return
      */
     @RequestMapping(value="/list",method={RequestMethod.GET,RequestMethod.POST})
     public String list(Integer currentPage, SrmAchPatent srmAchPatent,SrmAchPatentAuthor author,HttpServletRequest request, Model model){
    	 SysUser currUser = GlobalContext.getCurrentUser();
    	 srmAchPatent.setApplyUserFlow(currUser.getUserFlow());
    	 
		 PageHelper.startPage(currentPage, getPageSize(request));
		 List<SrmAchPatent> patentList = patentBiz.search(srmAchPatent, null);
		 
		 Map<String,List<SrmAchPatentAuthor>> allAuthorMap = new LinkedHashMap<String,List<SrmAchPatentAuthor>>();
		 
		 List<SrmAchPatentAuthor> patentAuthorList = patentAuthorBiz.searchAuthorList(new SrmAchPatentAuthor());
		 if(patentList != null && !patentList.isEmpty()){
			 for(SrmAchPatentAuthor a : patentAuthorList){
				 List<SrmAchPatentAuthor> list = allAuthorMap.get(a.getPatentFlow());
				 if(list == null){
					 list = new ArrayList<SrmAchPatentAuthor>();
				 }
				 list.add(a);
				 allAuthorMap.put(a.getPatentFlow(), list);
			 }
		 }	 
		 model.addAttribute("allAuthorMap", allAuthorMap);
    	 model.addAttribute("patentList",patentList);
    	 return "srm/ach/patent/list";
     }
     
     
     /**
      * ר������б�
      * @param thesis
      * @param model
      * @return
      */
     @RequestMapping(value="/auditList/{scope}",method={RequestMethod.POST,RequestMethod.GET})
     public String auditList(@PathVariable String scope, String currentPage, SrmAchPatent patent, SrmAchPatentAuthor author, SysOrg org,Model model,HttpServletRequest request){
    	 List<SrmAchPatent> searchList=null;
    	 List<SrmAchPatent> patentList=null;
    	 //��ѯ��ǰ�����������м����ӻ�����������
    	 SysUser currUser = GlobalContext.getCurrentUser();
    	 List<SysOrg> currOrgChildList=orgBiz.searchChildrenOrgByOrgFlow(currUser.getOrgFlow());
    	 //����orgFlow��chargeOrgFlow��ѯ�����ӻ����б���ӻ������ӻ������б��Map
    	 Map<String,List<SysOrg>> resultMap=orgBiz.searchChargeAndApply(org,scope);
    	 //��ȡ��ǰ��������һ���Ļ���
    	 List<SysOrg> firstGradeOrgList=(List<SysOrg>) resultMap.get("firstGradeOrgList");
    	 model.addAttribute("firstGradeOrgList", firstGradeOrgList);
		 //��ǰ��¼����������
    	 if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL.equals(scope)){
    		 //���ò�ѯ�������Ƽ������ͨ���ĳɹ�
     		 patent.setOperStatusId(AchStatusEnum.FirstAudit.getId()); 
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
		   		    searchList = patentBiz.search(patent, selfOrgList);
	   		    }else{
		   		    searchList = patentBiz.search(patent, secondGradeOrgList);
	   		    }
 			}
 			
    	 }else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE.equals(scope)){
    		 patent.setOperStatusId(AchStatusEnum.FirstAudit.getId()); 
    	 }else{
    		 if(StringUtil.isBlank(patent.getOperStatusId())){
    			 patent.setOperStatusId(AchStatusEnum.Submit.getId());
     		 }
    		 if(GlobalConstant.FLAG_Y.equals(patent.getOperStatusId())){
    			patent.setOperStatusId(AchStatusEnum.Submit.getId()+","+AchStatusEnum.FirstAudit.getId());
    		 }
    	 }
    	//�����ѯ����orgFlow��Ϊ�գ����ѯ��org�����гɹ�
    	 if(StringUtil.isNotBlank(org.getOrgFlow())){
    		 patent.setApplyOrgFlow(org.getOrgFlow());
	   		 searchList = patentBiz.search(patent, null);
	     }
    	 //�����ѯ����orgFlow��chargeOrgFlow��Ϊ�գ���ô��ѯ��ǰ��¼�������гɹ�
    	 if(StringUtil.isBlank(org.getOrgFlow()) && StringUtil.isBlank(org.getChargeOrgFlow())){
	   		 searchList = patentBiz.search(patent, currOrgChildList);
    	 }
    	 
    	//��֯�������ߵ�Map
    	Map<String, List<SrmAchPatentAuthor>> allAuthorMap = new HashMap<String, List<SrmAchPatentAuthor>>();
  		List<SrmAchPatentAuthor> patentAuthorList = patentAuthorBiz.searchAuthorList(new SrmAchPatentAuthor());
  		if(patentAuthorList != null && !patentAuthorList.isEmpty()){
  			for(SrmAchPatentAuthor a : patentAuthorList){
  				List<SrmAchPatentAuthor> authorList = allAuthorMap.get(a.getPatentFlow());
  				if(authorList == null){
  					authorList = new ArrayList<SrmAchPatentAuthor>();
  				}
  				authorList.add(a);
  				allAuthorMap.put(a.getPatentFlow(), authorList);
  			}
  		}
  		
  		//����ר����ˮ��
  		if(StringUtil.isNotBlank(author.getAuthorName())){ 
  			patentList = new ArrayList<SrmAchPatent>();
 			for(SrmAchPatent b : searchList){
 				boolean addFlag = false;
 				List<SrmAchPatentAuthor> authorByNameList = allAuthorMap.get(b.getPatentFlow());
 				if(authorByNameList != null){
     				for(SrmAchPatentAuthor na : authorByNameList){
     					if(na.getAuthorName().equals(author.getAuthorName())){
     						addFlag = true;
     						break;
     					}
     				}
 				}
 				if(addFlag){
 					patentList.add(b);
 				}
 			}
  		}else {
  			patentList = searchList;
  		}
   		 model.addAttribute("patentList", patentList);
		 model.addAttribute("allAuthorMap", allAuthorMap);
		 return "srm/ach/patent/auditList"+scope;
 	}
     
     
     
     /**
      * ����ר����ˮ�Ų�ѯ��ר������ϸ��Ϣ
      * @param srmAchPatent  ר��ʵ�����
      * @param model
      * @return
      */
     @RequestMapping(value="/edit",method=RequestMethod.GET)
     public String edit(String patentFlow, Model model){
    	  if(StringUtil.isNotBlank(patentFlow)){
    		  SrmAchPatent patent=patentBiz.readPatent(patentFlow);
    		  model.addAttribute("patent", patent);
    		  //����
    		  SrmAchPatentAuthor tempAuthor = new SrmAchPatentAuthor();
    		  tempAuthor.setPatentFlow(patentFlow);
	    	  List<SrmAchPatentAuthor> authorList=patentAuthorBiz.searchAuthorList(tempAuthor);
	    	  model.addAttribute("authorList", authorList);
	    	  //����
	    	  List<SrmAchFile> fileList = srmAchFileBiz.searchSrmAchFile(patentFlow);  
	    	  if(fileList != null && !fileList.isEmpty()){
	    		  SrmAchFile file = fileList.get(0);
	    		  model.addAttribute("file", file);
	    	  }
    	  }
    	  return "srm/ach/patent/edit";
     }
     
     /**
      * ����ר����ˮ��ɾ��ר��
      * @param srmAchPatent  ר��ʵ�����
      * @return
      */
     @RequestMapping(value="/delete",method=RequestMethod.GET)
     @ResponseBody
     public  String delete(String patentFlow){
    	 if(StringUtil.isNotBlank(patentFlow)){
    		 SrmAchPatent patent = new SrmAchPatent();
    		 patent.setPatentFlow(patentFlow);
    		 patent.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
    		 //����
    		 SrmAchPatentAuthor tempAuthor = new SrmAchPatentAuthor();
    		 tempAuthor.setPatentFlow(patentFlow);
			 List<SrmAchPatentAuthor> authorList = patentAuthorBiz.searchAuthorList(tempAuthor);
			 for(SrmAchPatentAuthor author : authorList){
				 author.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			 }
			 //����
			 List<SrmAchFile> fileList = srmAchFileBiz.searchSrmAchFile(patentFlow); 
			 SrmAchFile file = null;
	    	 if(fileList != null && !fileList.isEmpty()){
	    		 file = fileList.get(0);
	    		 file.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
	    	 }
			 int result = patentBiz.edit(patent, authorList, file);
		
			 if(result == GlobalConstant.ONE_LINE){
				 return GlobalConstant.DELETE_SUCCESSED;
			 }
		 }
		 return GlobalConstant.DELETE_FAIL;
     }
	 
   
	
	@RequestMapping(value = "/deleteAuthor",method={RequestMethod.GET})
	@ResponseBody
	public String deleteAuthor(String authorFlow){
		if(StringUtil.isNotBlank(authorFlow)){
			SrmAchPatentAuthor author = new SrmAchPatentAuthor();
			author.setAuthorFlow(authorFlow);
			author.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			patentAuthorBiz.editAuthor(author);
			return GlobalConstant.DELETE_SUCCESSED;
		}
		return GlobalConstant.DELETE_FAIL;
	}
    
    
    @RequestMapping("/audit")
 	public String audit(@RequestParam(value="patentFlow", required=true)String patentFlow,Model model){
    	//���ݳɹ���ˮ�Ų�ѯ�����Ϣ�����ڼ������ҳ�� 
		 SrmAchFile file = null;
		 List<SrmAchFile> fileList=null;
		if(StringUtil.isNotBlank(patentFlow)){
			//��ѯ�ɹ�����
			SrmAchPatent patent=patentBiz.readPatent(patentFlow);
			model.addAttribute("patent", patent);
			//��ѯ�ɹ�����
			SrmAchPatentAuthor author = new SrmAchPatentAuthor();
	    	author.setPatentFlow(patentFlow);
		    List<SrmAchPatentAuthor> authorList=patentAuthorBiz.searchAuthorList(author);
			model.addAttribute("authorList", authorList);
			//��ѯ�ɹ�����
		    fileList=srmAchFileBiz.searchSrmAchFile(patentFlow);  
		  if(fileList!=null && !fileList.isEmpty()){
		    file=fileList.get(0);
		    model.addAttribute("file", file);
		   }
		}
 		return "srm/ach/patent/audit";
 	}
     
    
    @RequestMapping(value="/saveAudit",method={RequestMethod.POST})
 	@ResponseBody
 	public String saveAudit(@RequestParam(value="agreeFlag" , required=true)String agreeFlag,String auditContent,
 			                @RequestParam(value="patentFlow" , required=true)String patentFlow,Model model){
 		SrmAchPatent patent=patentBiz.readPatent(patentFlow);
 		SrmAchProcess process=srmAchProcessBiz.searchAchProcess(patentFlow, AchStatusEnum.Apply.getId()).get(0);

 		if(agreeFlag.equals(GlobalConstant.FLAG_Y)){
 			 patent.setOperStatusId(AchStatusEnum.FirstAudit.getId());
 			 patent.setOperStatusName(AchStatusEnum.FirstAudit.getName());
 			 process.setOperStatusId(AchStatusEnum.FirstAudit.getId());
 			 process.setOperStatusName(AchStatusEnum.FirstAudit.getName());
 		}else{
 			 patent.setOperStatusId(AchStatusEnum.RollBack.getId());
 			 patent.setOperStatusName(AchStatusEnum.RollBack.getName());
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
		 patentBiz.updatePatentStatus(patent, process);
		 return GlobalConstant.OPERATE_SUCCESSED;
 	}
    
    
    
 	@RequestMapping(value="/submitAudit",method={RequestMethod.GET})
 	@ResponseBody
 	public String submitAudit(@RequestParam(value="patentFlow" , required=true)String patentFlow,Model model){
		SrmAchPatent patent=patentBiz.readPatent(patentFlow);
		patent.setOperStatusId(AchStatusEnum.Submit.getId());
		patent.setOperStatusName(AchStatusEnum.Submit.getName());
 		 
		 SrmAchProcess process=srmAchProcessBiz.searchAchProcess(patentFlow, AchStatusEnum.Apply.getId()).get(0);
		 process.setProcessFlow(PkUtil.getUUID());
		 process.setOperStatusId(AchStatusEnum.Submit.getId());
		 process.setOperStatusName(AchStatusEnum.Submit.getName());
		 GeneralMethod.setRecordInfo(process, true);
		 process.setOperateTime(process.getCreateTime());
		 SysUser currUser = GlobalContext.getCurrentUser();
		 process.setOperateUserFlow(currUser.getUserFlow());
		 process.setOperateUserName(currUser.getUserName());
		 patentBiz.updatePatentStatus(patent, process);
		 return GlobalConstant.OPRE_SUCCESSED_FLAG;
 	}
}
