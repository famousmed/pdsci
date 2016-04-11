package com.pinde.sci.ctrl.xjgl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseBiz;
import com.pinde.sci.biz.sys.IDictBiz;
import com.pinde.sci.biz.xjgl.IXjCourseMajorBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.ctrl.edu.EduCourseManageController;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.enums.xjgl.XjglCourseTypeEnum;
import com.pinde.sci.form.edu.MajorCourseForm;
import com.pinde.sci.model.edu.EduCourseMajorExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseMajor;
import com.pinde.sci.model.mo.SysDict;



@Controller
@RequestMapping("/xjgl/majorCourse")
public class XjglCourseMajorController extends GeneralController{

	private static Logger logger = LoggerFactory.getLogger(XjglCourseMajorController.class);
	@Autowired
	private IXjCourseMajorBiz courseMajorBiz;
	@Autowired
	private IEduCourseBiz courseBiz;
	@Autowired
	private IDictBiz dictBiz;
	/**
	 * 查询出专业及其对应课程
	 * @param model
	 * @return
	 */
    @RequestMapping("/list")
	public String courseMajorList(EduCourseMajor courseMajor,EduCourse course,Integer currentPage,HttpServletRequest request,Model model){
    	String year=courseMajor.getPlanYear();
    	if(StringUtil.isBlank(courseMajor.getPlanYear())){
    		year=InitConfig.getSysCfg("xjgl_curr_year");
        	if(StringUtil.isBlank(year)){
        		year=DateUtil.getCurrDateTime("yyyy");
        	}
    		courseMajor.setPlanYear(year);
    	}
    	model.addAttribute("year", year);
    	PageHelper.startPage(currentPage, getPageSize(request));
    	List<MajorCourseForm> formList= this.courseMajorBiz.searchIncludeCourseMajor(courseMajor,course);
    	model.addAttribute("formList", formList);
    	List<String> yearList=this.courseMajorBiz.searchRecommendYear(year,null);
    	List<String> delYearList=this.courseMajorBiz.searchRecommendYear(null,GlobalConstant.FLAG_N);
    	model.addAttribute("delYearList", delYearList);
    	model.addAttribute("yearList", yearList);
		return "xjgl/plat/professMaintain";
	}
    
    @RequestMapping("/edit")
   	public String edit(String majorId,Model model){
   		return "xjgl/plat/professInfo";
   	}
    
    @RequestMapping("/delCourseMajor")
    @ResponseBody
   	public String delCourseMajor(EduCourseMajor courseMajor,Model model){
    	List<EduCourseMajor> courseMajorList=this.courseMajorBiz.searchCourseMajorListNoStatus(courseMajor);
    	if(courseMajorList!=null && !courseMajorList.isEmpty()){
    		courseMajor=courseMajorList.get(0);
    		int result=courseMajorBiz.delete(courseMajor);
    		if(result==GlobalConstant.ONE_LINE){
    			return GlobalConstant.DELETE_SUCCESSED;
    		}
    	}
   		return GlobalConstant.DELETE_FAIL;
   	}
    
    @RequestMapping("/loadCourseMajorTb")
   	public String loadCourseMajorTb(String majorId,String year,Model model){
    	if(StringUtil.isNotBlank(majorId)){
    		String majorName=DictTypeEnum.Major.getDictNameById(majorId);
        	model.addAttribute("majorName", majorName);
        	Map<String,Object> courseMap=searchCourseByMajor(majorId,year);
        	model.addAttribute("courseMap", courseMap);
    	}
   		return "xjgl/plat/professInfoTb";
   	}
    
    @RequestMapping("/saveRecommendData")
    @ResponseBody
   	public String recommendData(EduCourseMajor courseMajor,String targetYear,Model model){
    	int result=this.courseMajorBiz.saveRecommendData(courseMajor,targetYear);
    	if(result==GlobalConstant.ONE_LINE){
    		return GlobalConstant.OPERATE_SUCCESSED;
    	}
   		return GlobalConstant.OPRE_FAIL;
   	}
    
    @RequestMapping("/delRecommendData")
    @ResponseBody
   	public String delRecommendData(EduCourseMajor courseMajor,Model model){
    	int result=this.courseMajorBiz.delRecommendData(courseMajor);
    	if(result==GlobalConstant.ONE_LINE){
    		return GlobalConstant.OPERATE_SUCCESSED;
    	}
   		return GlobalConstant.OPRE_FAIL;
   	}
    
    @RequestMapping("/save")
    @ResponseBody
   	public String saveCourseMajor(EduCourseMajor courseMajor){
    	List<EduCourseMajor> courseMajorList=this.courseMajorBiz.searchCourseMajorListNoStatus(courseMajor);
    	if(courseMajorList!=null && !courseMajorList.isEmpty()){
    		courseMajor.setRecordFlow(courseMajorList.get(0).getRecordFlow());
    		if(GlobalConstant.RECORD_STATUS_N.equals(courseMajorList.get(0).getRecordStatus())){
    			courseMajor.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
    		}
    	}
    	if(StringUtil.isNotBlank(courseMajor.getMajorId())){
    		String majorName=DictTypeEnum.Major.getDictNameById(courseMajor.getMajorId());
    		courseMajor.setMajorName(majorName);
    	}
    	if(StringUtil.isNotBlank(courseMajor.getCourseFlow())){
    		EduCourse course=this.courseBiz.readCourse(courseMajor.getCourseFlow());
    		if(course!=null){
    			courseMajor.setCourseName(course.getCourseName());
    		}
    	}
    	if(StringUtil.isNotBlank(courseMajor.getCourseTypeId())){
    		String courseTypeName=XjglCourseTypeEnum.getNameById(courseMajor.getCourseTypeId());
    		courseMajor.setCourseTypeName(courseTypeName);
    	}else{
    		courseMajor.setCourseTypeId("");
    		courseMajor.setCourseTypeName("");
    	}
    	courseMajor.setRecommendFlag(GlobalConstant.FLAG_N);
    	int result=this.courseMajorBiz.save(courseMajor);
    	if(result==GlobalConstant.ONE_LINE){
    		return GlobalConstant.SAVE_SUCCESSED;
    	}
   		return GlobalConstant.SAVE_FAIL;
   	}
    
    
    
//---------------------------------------基础数据-----------------------------------------    
    @RequestMapping("/searchCourseJson")
    @ResponseBody
    public List<EduCourse> searchCourseJson(String majorId,String year){
    	List<EduCourse> courseList=this.courseMajorBiz.searchCourseNotIncludeMajor(majorId, year);
   		return courseList;
   	}
    
    @RequestMapping("/searchMajorJson")
    @ResponseBody
    public List<SysDict> searchMajorJson(){
    	Map<String,List<SysDict>>  sysListDictMap = DictTypeEnum.sysListDictMap;
    	List<SysDict> dictList=sysListDictMap.get("Major");
   		return dictList;
   	}
    
    @RequestMapping("/searchCourseByMajor")
    @ResponseBody
    public Map<String,Object> searchCourseByMajor(String majorId,String year){
    	Map<String,Object> map=new HashMap<String, Object>();
    	EduCourseMajor courseMajor=new EduCourseMajor();
    	courseMajor.setMajorId(majorId);
    	courseMajor.setPlanYear(year);
    	List<EduCourseMajorExt> courseMajorExtList=this.courseMajorBiz.searchCourseByMajor(majorId, year);
    	List<EduCourse> degreeList=new ArrayList<EduCourse>();
    	List<EduCourse> optionalList=new ArrayList<EduCourse>();
    	List<EduCourse> publicList=new ArrayList<EduCourse>();
    	List<EduCourse> notIncludeList=new ArrayList<EduCourse>();
    	if(courseMajorExtList!=null && !courseMajorExtList.isEmpty()){
    	   for(EduCourseMajorExt courseMajorExt:courseMajorExtList){
    		   if(XjglCourseTypeEnum.Degree.getId().equals(courseMajorExt.getCourseTypeId())){
    			   degreeList.add(courseMajorExt.getCourse());
    		   }
    		   else if(XjglCourseTypeEnum.Optional.getId().equals(courseMajorExt.getCourseTypeId())){
    			   optionalList.add(courseMajorExt.getCourse());
    		   }
    		   else if(XjglCourseTypeEnum.Public.getId().equals(courseMajorExt.getCourseTypeId())){
    			   publicList.add(courseMajorExt.getCourse());
    		   }else if(StringUtil.isBlank(courseMajorExt.getCourseTypeId())){
    			   notIncludeList.add(courseMajorExt.getCourse());
    		   }
    	   }
    	}
    	map.put("degreeList", degreeList);
    	map.put("optionalList", optionalList);
    	map.put("publicList", publicList);
    	map.put("notIncludeList", notIncludeList);
   		return map;
   	}
    
}
