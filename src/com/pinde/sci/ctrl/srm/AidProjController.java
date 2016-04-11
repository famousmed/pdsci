package com.pinde.sci.ctrl.srm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.pinde.core.jspform.Page;
import com.pinde.core.jspform.PageGroup;
import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.srm.IAidProjBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.impl.OrgBizImpl;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.common.util.JspFormUtil;
import com.pinde.sci.enums.pub.ProjCategroyEnum;
import com.pinde.sci.enums.srm.AidAssessStatusEnum;
import com.pinde.sci.enums.srm.AidProjCategoryEnum;
import com.pinde.sci.enums.srm.AidProjStatusEnum;
import com.pinde.sci.enums.srm.ProjRecTypeEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.AidProj;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjRec;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.pub.AidProjExt;
import com.pinde.sci.model.pub.ProjAidForm;
import com.pinde.sci.model.pub.ProjAidFundExt;

@Controller
@RequestMapping("/srm/aid/proj")
public class AidProjController extends GeneralController{

	@Autowired
	private IAidProjBiz aidProjBiz;
	@Autowired
	private IFileBiz fileBiz;
	@Autowired
	private OrgBizImpl orgBiz;
	@Autowired
	private IPubProjBiz projBiz;	
	
	/**
	 * ��Ŀ��Ϣ�����б�
	 * @param proj
	 * @param currentPage
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list")
	public String list(AidProj aidProj,Integer currentPage ,HttpServletRequest request, Model model){
		SysUser currUser = GlobalContext.getCurrentUser();
		PageHelper.startPage(currentPage, getPageSize(request));
		aidProj.setApplyUserFlow(currUser.getUserFlow());
		List<AidProj> aidProjList = this.aidProjBiz.searchAidProj(aidProj);
		model.addAttribute("aidProjList",aidProjList);
		if(ProjCategroyEnum.Xk.getId().equals(aidProj.getProjCategoryId())){//ѧ�Ʊ���
			return "srm/aid/proj/aidProjList_xk";
		}else{
			return "srm/aid/proj/aidProjList";
		}
	}
	

	
//	/**
//	 * ��ת����Ŀ������Ϣ�����
//	 * @return
//	 * @throws DocumentException 
//	 */
//	@RequestMapping(value="/edit")
//	public String edit(String look , String projFlow ,Model model) throws DocumentException{
//		SysUser currUser = GlobalContext.getCurrentUser();
//		model.addAttribute("currUser", currUser);
//		AidProj aidProj=null;
//		if(StringUtil.isNotBlank(projFlow)){
//			aidProj=aidProjBiz.readAidProj(projFlow);
//			model.addAttribute("aidProj", aidProj);
//		}
//		if(aidProj!=null && aidProj.getProjInfo()!=null){
//		    //������Ϣ��չ��Map
//			HashMap<String,String> aidProjExtMap=new HashMap<String, String>();
//			//�ʽ����List
//			List<ProjAidFundExt> fundList=new ArrayList<ProjAidFundExt>();
//			//�ʽ�������
//			ProjAidFundExt fundExt = null;
//			//�ļ���ˮ��List
//			List<String> fileFlowList=new ArrayList<String>();
//			//�ļ���ˮ���ַ���
//			String fileFlow=null;
//			//�ļ�List
//			List<PubFile> fileList=null;
//			Document document = DocumentHelper.parseText(aidProj.getProjInfo());
//			Element root=document.getRootElement();
//			for(Iterator it=root.elementIterator();it.hasNext();){
//				Element element=(Element) it.next();
//				aidProjExtMap.put(element.getName(),element.attributeValue("value"));
//				if(element.getName().equals("fund")){
//					fundExt=new ProjAidFundExt();
//					fundExt.setFundYear(element.attributeValue("fundYear"));
//					fundExt.setFundCountryCount(element.attributeValue("fundCountryCount"));
//					fundExt.setFundProvinceCount(element.attributeValue("fundProvinceCount"));
//					fundExt.setFundCityCount(element.attributeValue("fundCityCount"));
//					fundExt.setFundAreaCount(element.attributeValue("fundAreaCount"));
//					fundList.add(fundExt);
//				}
//				if(element.getName().equals("file")){
//					fileFlow=new String(element.attributeValue("fileFlow"));
//					fileFlowList.add(fileFlow);
//				}
//				if(!fileFlowList.isEmpty()){
//					fileList=fileBiz.searchFile(fileFlowList);
//				}
//			}
//			model.addAttribute("aidProjExtMap", aidProjExtMap);
//			model.addAttribute("fundList",fundList);
//			model.addAttribute("fileList", fileList);
//		}
//		if(null!=look && look.equals("look")){
//			return "srm/aid/proj/view/projInfoAidView";
//		}
//		return "srm/aid/proj/projInfoAid";
//	}
//	
	@RequestMapping(value="/save")
	public String save(Model model,HttpServletRequest request,ProjAidForm projAidForm){
		 AidProj aidProj=projAidForm.getAidProj();
	   //��ȡ�ļ���Ϣ
		MultipartHttpServletRequest mh = (MultipartHttpServletRequest)request;
		List<MultipartFile> fileList = mh.getFiles("file");
		//��ҳ���ȡ�ʽ������Ϣ
		
		String [] fundYearArray=request.getParameterValues("fundYear");
		String [] fundCountryCountArray=request.getParameterValues("fundCountryCount");
		String [] fundProvinceCountArray=request.getParameterValues("fundProvinceCount");
		String [] fundCityCountArray=request.getParameterValues("fundCityCount");
		String [] fundAreaCountArray=request.getParameterValues("fundAreaCount");
		List<ProjAidFundExt> fundList=new ArrayList<ProjAidFundExt>();
		ProjAidFundExt fundExt = null;
		if(null!=fundYearArray && fundYearArray.length>0){
	
			for(int i=0;i<fundYearArray.length;i++){
				fundExt =new ProjAidFundExt();
				fundExt.setFundYear(fundYearArray[i]);
				if(null!=fundCountryCountArray && fundCountryCountArray.length>0){
				fundExt.setFundCountryCount(fundCountryCountArray[i]);
				}
				if(null!=fundProvinceCountArray && fundProvinceCountArray.length>0){
				fundExt.setFundProvinceCount(fundProvinceCountArray[i]);
				}
				fundExt.setFundCityCount(fundCityCountArray[i]);
				fundExt.setFundAreaCount(fundAreaCountArray[i]);
				fundList.add(fundExt);
			}
		}
	    
		//������Ŀ������Ϣ
		aidProj.setProjCategoryId(aidProj.getProjDeclarer());
		aidProj.setProjCategoryName(AidProjCategoryEnum.getNameById(aidProj.getProjDeclarer()));
		//������Ŀ���
		if(aidProj.getProjCategoryId().equals(AidProjCategoryEnum.Country.getId())){
			aidProj.setProjTypeName(DictTypeEnum.AidCountryProjType.getDictNameById(aidProj.getProjTypeId()));
		}else if(aidProj.getProjCategoryId().equals(AidProjCategoryEnum.Province.getId())){
			aidProj.setProjTypeName(DictTypeEnum.AidProvinceProjType.getDictNameById(aidProj.getProjTypeId()));
		}else if(aidProj.getProjCategoryId().equals(AidProjCategoryEnum.City.getId())){
			aidProj.setProjTypeName(DictTypeEnum.AidCityProjType.getDictNameById(aidProj.getProjTypeId()));
		}
		//������Ŀ��������ˮ��
		SysUser currUser = GlobalContext.getCurrentUser();
		aidProj.setApplyUserFlow(currUser.getUserFlow());
		AidProjExt aidProjExt=projAidForm.getAidProjExt();
		
		String [] fileFlowArray=request.getParameterValues("fileFlow");
		List<String> fileFlowList=new ArrayList<String>();
		if(null != fileFlowArray && fileFlowArray.length>0){
			for(String s:fileFlowArray){
				fileFlowList.add(s);
			}
		}
		aidProjBiz.save(aidProj, fileList, aidProjExt, fundList,fileFlowList);
	    return "redirect:list?isCountry="+aidProj.getProjCategoryId();
	}

	@RequestMapping(value="/delete")
	@ResponseBody
	public String delete(String projFlow){
		AidProj aidProj=new AidProj();
		aidProj.setProjFlow(projFlow);
        aidProjBiz.deleteAidProj(aidProj);
		return GlobalConstant.DELETE_SUCCESSED;
	}
	
	/**
	 * ������Ŀ���
	 * @param projListScope
	 * @param aidProj
	 * @param isCountry
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/auditAidProjList/{projListScope}")
	public String auditAidProjList(@PathVariable String projListScope, AidProj aidProj, String isCountry, Model model){
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		model.addAttribute("isCountry", isCountry);
		return "srm/aid/proj/auditAidProjList";
	}
	
	/**
	 * ѧ�Ʊ������
	 * @param projListScope
	 * @param aidProj
	 * @param org
	 * @param currentPage
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/auditAidProjListOfXk/{projListScope}")
	public String auditAidProjListOfXk(@PathVariable String projListScope, AidProj aidProj,  SysOrg org,  Integer currentPage, HttpServletRequest request, Model model){
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		auditProjList(projListScope, aidProj, org, currentPage, request, model);
		return "srm/aid/proj/auditAidProjList_xk";
	}
	
	/**
	 * ���ر�����Ŀ�б�
	 * @param aidProj
	 * @param isCountry
	 * @param org
	 * @param currentPage
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/loadAidProjList/{projListScope}")
	public String loadAidProjList(@PathVariable String projListScope, AidProj aidProj, String isCountry, SysOrg org,  Integer currentPage, HttpServletRequest request, Model model){
		//������Ŀ����
		if(AidProjCategoryEnum.Country.getId().equals(isCountry)){
			aidProj.setProjCategoryId(AidProjCategoryEnum.Country.getId());
		}else if(AidProjCategoryEnum.Province.getId().equals(isCountry)){
			aidProj.setProjCategoryId(AidProjCategoryEnum.Province.getId());
		}
		auditProjList(projListScope, aidProj, org, currentPage, request, model);
		return "srm/aid/proj/loadAidProjList";
	}

	private void auditProjList(String projListScope, AidProj aidProj, SysOrg org, Integer currentPage, HttpServletRequest request, Model model) {
		//��ѯ��ǰ��������������
		SysUser currUser = GlobalContext.getCurrentUser();
		List<SysOrg> childrenOrgList=orgBiz.searchChildrenOrgByOrgFlowNotIncludeSelf(currUser.getOrgFlow());
		model.addAttribute("childrenOrgList", childrenOrgList);
		//��ѯ��ǰ������������������������
		List<SysOrg> allOrgList=orgBiz.searchChildrenOrgByOrgFlow(currUser.getOrgFlow());
		List<SysOrg> orgList=null; 
		//�����ѯ�����ге���λ��Ϊ�գ���ѯ�óе���λ�µ���Ŀ
		SysOrg newSysOrg=new SysOrg();
		newSysOrg.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(org.getOrgFlow())){
			aidProj.setApplyOrgFlow(org.getOrgFlow());
			//����ͬ����λ
			//���ݸõ�λ����ˮ�Ų�ѯ�õ�λ��Ϣ
			SysOrg sysOrg=orgBiz.readSysOrg(org.getOrgFlow());
			newSysOrg.setChargeOrgFlow(sysOrg.getChargeOrgFlow());
			//���ݸõ�λ�����ܲ�����ˮ�ţ���ѯͬ����λ
			orgList=orgBiz.searchOrg(newSysOrg);
			model.addAttribute("orgList", orgList);

		}
		//������ܲ���������Ϊ�գ���ѯ�����ܲ�����һ�����е�λ
		else if(StringUtil.isNotBlank(org.getChargeOrgFlow())){
		    newSysOrg.setChargeOrgFlow(org.getChargeOrgFlow());
			orgList=orgBiz.searchOrg(newSysOrg);
			model.addAttribute("orgList", orgList);
			allOrgList=orgBiz.searchChildrenOrgByOrgFlowNotIncludeSelf(org.getChargeOrgFlow());
		}
		PageHelper.startPage(currentPage, getPageSize(request));
		if(projListScope.equals(GlobalConstant.USER_LIST_CHARGE)){//���ܲ���
			//aidProj.setStatusId(AidProjStatusEnum.Pass.getId());
			aidProj.setChargeOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		}else if(projListScope.equals(GlobalConstant.USER_LIST_GLOBAL)){//������
			//aidProj.setStatusId(AidProjStatusEnum.Pass.getId());
		}
		List<AidProj> aidProjList=aidProjBiz.searchAidProjByChargeOrg(aidProj,allOrgList);
		model.addAttribute("aidProjList", aidProjList);
	}
	
	@RequestMapping("/add")
	public String add(String typeId , Model model){
		String pageGroupName = InitConfig.configMap.get("Aid").get(typeId);
		PageGroup pageGroup = InitConfig.projAidPageMap.get(pageGroupName);
		Page page = pageGroup.getPageMap().get(pageGroup.getFirstPage());
		return page.getJsp();
	}
	
	@RequestMapping("/edit")
	public String edit(@RequestParam(required=true)String typeId , @RequestParam(required=true)String projFlow , Model model){
		AidProj aidProj = this.aidProjBiz.readAidProj(projFlow);
		model.addAttribute("aidProj" , aidProj);
		String pageGroupName = InitConfig.configMap.get("Aid").get(typeId);
		PageGroup pageGroup = InitConfig.projAidPageMap.get(pageGroupName);
		Page page = pageGroup.getPageMap().get(pageGroup.getFirstPage());
		Map<String , Object> resultMap = new HashMap<String , Object>();
		resultMap = JspFormUtil.parseXmlStr(aidProj.getProjInfo() , page);
		model.addAttribute("resultMap", resultMap);
		//��ȡ�����б�
		List<String> fileFlows = this.projBiz.getFileFlows(resultMap);
		model.addAttribute("fileFlows" , fileFlows);
		Map<String , PubFile> pageFileMap = this.projBiz.getFile(resultMap);
		if(pageFileMap!=null){
			model.addAttribute("pageFileMap" , pageFileMap);
		}
		return page.getJsp();
	}
	
	@RequestMapping("/view")
	public String view(@RequestParam(required=true)String typeId , @RequestParam(required=true)String projFlow , Model model){
		AidProj aidProj = this.aidProjBiz.readAidProj(projFlow);
		model.addAttribute("aidProj" , aidProj);
		String pageGroupName = InitConfig.configMap.get("Aid").get(typeId);
		PageGroup pageGroup = InitConfig.projAidPageMap.get(pageGroupName);
		Page page = pageGroup.getPageMap().get(pageGroup.getFirstPage());
		Map<String , Object> resultMap = new HashMap<String , Object>();
		resultMap = JspFormUtil.parseXmlStr(aidProj.getProjInfo() , page);
		model.addAttribute("resultMap", resultMap);
		//��ȡ�����б�
		List<String> fileFlows = this.projBiz.getFileFlows(resultMap);
		model.addAttribute("fileFlows" , fileFlows);
		Map<String , PubFile> pageFileMap = this.projBiz.getFile(resultMap);
		if(pageFileMap!=null){
			model.addAttribute("pageFileMap" , pageFileMap);
		}
		return pageGroup.getView();
	}
	
	private Page _getPage(String pageName , String typeId){
		String pageGroupName = InitConfig.configMap.get("Aid").get(typeId);
		PageGroup pageGroup = InitConfig.projAidPageMap.get(pageGroupName);
		Page page = pageGroup.getPageMap().get(pageName);
		return page;
	}
	
	/**
	 * ������Ŀ��¼
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/saveStepForKy"},method={RequestMethod.POST,RequestMethod.GET})
	public String saveStepForKy(HttpServletRequest request){
		//String typeId = InitConfig.getSysCfg("srm_aidproj_ky");
		String categoryId = ProjCategroyEnum.Ky.getId();
		return saveStep(request , categoryId);
	}
	
	/**
	 * �˲���Ŀ��¼
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/saveStepForRc"},method={RequestMethod.POST,RequestMethod.GET})
	public String saveStepForRc(HttpServletRequest request){
		//String typeId = InitConfig.getSysCfg("srm_aidproj_rc");
		String categoryId = ProjCategroyEnum.Rc.getId();
		return saveStep(request , categoryId);
	}
	
	/**
	 * ѧ����Ŀ��¼
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/saveStepForXk"},method={RequestMethod.POST,RequestMethod.GET})
	public String saveStepForXk(HttpServletRequest request){
		//String typeId = InitConfig.getSysCfg("srm_aidproj_xk");
		String categoryId = ProjCategroyEnum.Xk.getId();
		return saveStep(request , categoryId);
	}
	
	
	public String saveStep(HttpServletRequest request , String categoryId){ 
		Map<String , String[]> dataMap = JspFormUtil.getParameterMap(request);
		String projSubCategoryId =  dataMap.get("projSubCategoryId")[0];
		String pageName = "";
		String nextPageName = "";
		if(dataMap.get("pageName")!=null){
			pageName = dataMap.get("pageName")[0];
		}
		if(dataMap.get("nextPageName")!=null){
			nextPageName = dataMap.get("nextPageName")[0];
		}
		Page page =_getPage(pageName , projSubCategoryId);	
		//nextPage��֧�ֲ�ͬҳ�����һ��
		//Page nextPage = _getPage(nextPageName , typeId);
		AidProj aidProj = this.aidProjBiz.createAidProj(dataMap , categoryId , projSubCategoryId);
		String xmlStr = JspFormUtil.updateXmlStr("",page, dataMap);
		aidProj.setProjInfo(xmlStr);
		SysOrg sysOrg = orgBiz.readSysOrg(GlobalContext.getCurrentUser().getOrgFlow());
		if(sysOrg != null){
			aidProj.setChargeOrgFlow(sysOrg.getChargeOrgFlow()!=null?sysOrg.getChargeOrgFlow():"");
			aidProj.setChargeOrgName(sysOrg.getChargeOrgName()!=null?sysOrg.getChargeOrgName():"");
		}
		aidProj.setStatusId(AidProjStatusEnum.NonSubmit.getId());
		aidProj.setStatusName(AidProjStatusEnum.NonSubmit.getName());
		this.aidProjBiz.saveAidProj(aidProj);
		//Ŀǰֻ��Ե�ҳ��
		if("finish".equals(nextPageName)){
			return "redirect:/srm/aid/proj/list?projCategoryId=" + aidProj.getProjCategoryId();
		}
		return "";
	}
	
	/**
	 * ���
	 * @param projFlow
	 * @return
	 */
	@RequestMapping("/auditAidProj")
	@ResponseBody
	public String auditAidProj(String projFlow){
		if(StringUtil.isNotBlank(projFlow)){
			AidProj aidProj = new AidProj();
			aidProj.setProjFlow(projFlow);
			aidProj.setStatusId(AidProjStatusEnum.Pass.getId());
			aidProj.setStatusName(AidProjStatusEnum.Pass.getName());
			aidProjBiz.saveAidProj(aidProj);
			return GlobalConstant.PREPARE_APPROVAL_SUCCESSED;
		}
		return GlobalConstant.PREPARE_APPROVAL_FAIL;
	}
	
	/**
	 * ��ת����ӱ�����Ŀ
	 * @param projFlow
	 * @return
	 */
	@RequestMapping("/addAidProj")
	public String addAidProj(String projFlow){
		return "srm/aid/proj/aidProjTypeList";
	}
}
