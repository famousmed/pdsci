package com.pinde.sci.ctrl.njmuedu;


import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.njmuedu.INjmuEduCourseBiz;
import com.pinde.sci.biz.njmuedu.INjmuEduCourseChapterBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.enums.sys.OrgTypeEnum;
import com.pinde.sci.form.edu.EduFileForm;
import com.pinde.sci.form.njmuedu.ChapterForm;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseChapter;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserRole;

@Controller
@RequestMapping("njmuedu/manage/course")
public class NjmuEduCourseManageController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(NjmuEduCourseManageController.class);
	@Autowired
	private INjmuEduCourseBiz courseBiz;
	@Autowired
	private INjmuEduCourseChapterBiz chapterBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IOrgBiz orgBiz;
	
	
	/**
	 * 编辑课程
	 * @return
	 */
	@RequestMapping("/editCourse")
	public String editCourse(String courseFlow, Model model){
		if(StringUtil.isNotBlank(courseFlow)){
			EduCourse course = courseBiz.readCourse(courseFlow);
			model.addAttribute("course", course);
		}
		return "njmuedu/manage/course/edit";
	}
	
	/**
	 * 保存课程信息
	 * @param course
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/saveCourse")
	@ResponseBody
	public String saveCourse(EduCourse course, MultipartFile file) throws Exception{
		if(file.getSize() > 0){
			String checkResult = checkFile(file);
			if(checkResult != GlobalConstant.FLAG_Y){
				return checkResult;
			}
		}
		int result = courseBiz.editCourse(course,file);
		if(result != GlobalConstant.ZERO_LINE){
			return course.getCourseFlow();
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 查看章节
	 * @param courseFlow
	 * @return
	 */
	@RequestMapping("/chapterList")
	public String lookChapter(String courseFlow, Model model){
		EduCourse course = courseBiz.readCourse(courseFlow);
		model.addAttribute("course", course);
		return "njmuedu/manage/chapter/tree";
	}
	
	/**
	 * 编辑章节
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/editChapter")
	public String editChapter(String chapterFlow,String level,Model model){
	    EduCourseChapter chapter = chapterBiz.seachOne(chapterFlow);
	    model.addAttribute("chapter", chapter);
	    SysUser currUser=GlobalContext.getCurrentUser();
	    List<SysUser> userList=searchTeacher(currUser.getOrgFlow());
	    model.addAttribute("userList", userList);
	    if(Integer.parseInt(level)==2){
	    	return "njmuedu/manage/chapter/editChapterL2";
	    }else{
	    	return "njmuedu/manage/chapter/editChapterL1";
	    }
		
	}
	
	/**
	 * 添加章节
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/addChapter")
	public String addChapter(String chapterFlow,String level,Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
	    List<SysUser> userList=searchTeacher(currUser.getOrgFlow());
	    model.addAttribute("userList", userList);
	    if(Integer.parseInt(level)>=1){
	    	model.addAttribute("parentChapterFlow", chapterFlow);
	    	return "njmuedu/manage/chapter/editChapterL2";
	    }else{
	    	return "njmuedu/manage/chapter/editChapterL1";
	    }
		
	}
	
	/**
	 * 保存章节信息
	 * @param subject
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/saveChapter")
	@ResponseBody
	public String saveChapter(EduCourseChapter chapter){
		String result=this.chapterBiz.saveChapterReturnFlow(chapter);
		return result;
	}
	
	/**
	 * 获取课程全部章节
	 * @return 指定格式的json
	 */
	@RequestMapping(value="/getAllDataJson")
	@ResponseBody
	public String getAllDataJson(String courseFlow){
		if(StringUtil.isNotBlank(courseFlow)){
			List<EduCourseChapter> chapterList = chapterBiz.getAllChapter(courseFlow);
			StringBuilder sb = new StringBuilder();
			sb.append("[");
			sb.append("{\"id\":\"0\", \"pId\":\"-1\", \"name\":\"课程章节\",\"open\":true,\"t\":\"\"},");
			for (EduCourseChapter chapter : chapterList) {
				sb.append("{");
				sb.append("\"id\":").append("\""+chapter.getChapterFlow()+"\"").append(",");
				sb.append("\"pId\":").append("\""+StringUtil.replaceNull(chapter.getParentChapterFlow(),"0")+"\"").append(",");
				sb.append("\"name\":").append("\"").append(chapter.getChapterName()).append("\",");
				sb.append("\"t\":").append("\"\"");
				sb.append("},");
			}
			sb.deleteCharAt(sb.length()-1);
			sb.append("]");
			return sb.toString();
		}
		return null;
	}
	/**
	 * 保存视频
	 * @param video
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping(value="/saveCourseVideo")
	@ResponseBody
	public EduFileForm saveCourseVideo(MultipartFile file) throws Exception{
		EduFileForm fileForm=null;
		if(GlobalConstant.FILE_SIZE_PASS_SCOPE.equals(checkFileSize(file,"video"))){
			fileForm=new EduFileForm();
			fileForm.setFileSize(file.getSize());
			return fileForm;
		}
		String fileName=file.getOriginalFilename();
		fileForm=this.courseBiz.saveFile(file, "njmueduCourseVideo");
		if(fileForm!=null){
			fileForm.setFileName(fileName);
		}
		return fileForm;
	}
	/**
	 * 保存图片
	 * @param file
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping(value="/saveCourseImg")
	@ResponseBody
	public EduFileForm saveCourseImg(MultipartFile file) throws  Exception{
		if(GlobalConstant.FILE_SIZE_PASS_SCOPE.equals(checkFileSize(file,"img"))){
			return null;
		}
		String fileName=file.getOriginalFilename();
		EduFileForm fileForm=this.courseBiz.saveFile(file, "njmueduCourseImg");
		if(fileForm!=null){
			fileForm.setFileName(fileName);
		}
		return fileForm;
	}
	
	/**
	 * 检查文件大小
	 * @return
	 */
	public String checkFileSize(MultipartFile file,String type){
		int fileScope=0;
		if(type=="video"){
			fileScope=Integer.parseInt((String) InitConfig.getSysCfg("njmuedu_chapter_file_size"));
		}
		if(type=="img"){
			fileScope=Integer.parseInt((String) InitConfig.getSysCfg("njmuedu_course_img_size"));
		}
		long fileScopeb=fileScope*1024*1024;
		if(file.getSize()>fileScopeb){
			return GlobalConstant.FILE_SIZE_PASS_SCOPE;
		}
		return "";
	}
	

	/**
	 * 加载课程列表
	 * @param course
	 * @param model
	 * @return
	 */
	@RequestMapping("/courseList")
	public String courseList(EduCourse course, Integer currentPage,HttpServletRequest request, Model model){
		PageHelper.startPage(currentPage, getPageSize(request));
		List<EduCourse> courseList = courseBiz.searchCourseList(course);
		model.addAttribute("courseList", courseList);
		return "njmuedu/manage/course/list";
	}
	
	/**
	 * 删除课程
	 * @param courseFlow
	 * @return
	 */
	@RequestMapping("/delCourse")
	@ResponseBody
	public String delCourse(String courseFlow){
		if(StringUtil.isNotBlank(courseFlow)){
			int result = courseBiz.delCourse(courseFlow);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	/**
	 * 删除课程图片
	 * @param courseFlow
	 * @return
	 */
	@RequestMapping("/deleteCourseImg")
	@ResponseBody
	public String deleteCourseImg(String courseFlow){
		if(StringUtil.isNotBlank(courseFlow)){
			int result = courseBiz.deleteCourseImg(courseFlow);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	
	
	/**
	 * 查询教师
	 * @param orgFlow
	 * @return
	 */
	@RequestMapping("/searchTeacher")
	@ResponseBody
	public List<SysUser> searchTeacher(String orgFlow){
		if(StringUtil.isNotBlank(orgFlow)){
			Map<String,Object> paramMap=new HashMap<String, Object>();
			String roleFlow=InitConfig.getSysCfg("njmuedu_teacher_role_flow");
			paramMap.put("roleFlow", roleFlow);
			paramMap.put("orgFlow", orgFlow);
			List<SysUser> teacherList = userBiz.searchUserListByOrgFlow(paramMap);
			return teacherList;
		}
		return null;
	}
	
	
	/**
	 * 批量删除(含下级)
	 * @param listString
	 * @return
	 */
	@RequestMapping(value="/deleteJson",method=RequestMethod.POST)
	@ResponseBody
	public String deleteJson(String listString){
		List<String> chapterFlowList = null;
		if(StringUtil.isNotBlank(listString)){
			String[] arr = listString.split(",");
			chapterFlowList =  Arrays.asList(arr);
		}
		if(chapterFlowList !=null && !chapterFlowList.isEmpty()){
			//删除上传图片的路径中的图片
			int result = chapterBiz.updateByChapterFlowList(chapterFlowList);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}

	/**
	 * 检查文件大小及类型
	 * @param file
	 * @return
	 */
	private String checkFile(MultipartFile file) {
		List<String> mimeList = new ArrayList<String>();
		if(StringUtil.isNotBlank(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_mime")))){
			mimeList = Arrays.asList(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_mime")).split(","));
		}
		List<String> suffixList = new ArrayList<String>();
		if(StringUtil.isNotBlank(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_suffix")))){
			suffixList = Arrays.asList(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_suffix")).split(","));
		}
		
		String fileType = file.getContentType();//MIME类型;
		String fileName = file.getOriginalFilename();//文件名
		String suffix = fileName.substring(fileName.lastIndexOf("."));//后缀名
		if(!(mimeList.contains(fileType) &&  suffixList.contains(suffix))){
			return GlobalConstant.UPLOAD_IMG_TYPE_ERROR;
		}
		long limitSize = Long.parseLong(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_limit_size")));//图片大小限制
		if(file.getSize() > limitSize*1024*1024){
			return GlobalConstant.UPLOAD_IMG_SIZE_ERROR +limitSize +"M" ;
		}
		return GlobalConstant.FLAG_Y;//可执行保存
	}
	
	
	/**
	 * 跳转到视频预览页面
	 * @param chapterFlow
	 * @return
	 */
	@RequestMapping(value="/previewCourseVideo")
	public String saveCourse(String chapterFlow,Model model){
		EduCourseChapter chapter=this.chapterBiz.seachOne(chapterFlow);
		model.addAttribute("chapter", chapter);
		return "njmuedu/manage/chapter/courseVideo";
	}
	
	/**
	 * 获取视频时间
	 * @param chapterFile
	 * @return
	 * @throws EncoderException 
	 * @throws InputFormatException 
	 */
//	@RequestMapping(value="/fileTime",method=RequestMethod.POST)
//	@ResponseBody
//	public String fileTime(String chapterFile) throws InputFormatException, EncoderException{
//		     File source = new File(InitConfig.getSysCfg("upload_stream_dir")+chapterFile);
//			 if(source.isFile()){
//		      Encoder encoder = new Encoder();
//		  	  String mins="";
//		      String secs="";
//		      String time="";
//		          MultimediaInfo m = encoder.getInfo(source);
//		          BigDecimal ls = BigDecimal.valueOf(m.getDuration()).divide(new BigDecimal(1000));
//		          BigDecimal min=ls.divide(new BigDecimal(60),0,BigDecimal.ROUND_DOWN);
//		        
//		          BigDecimal sec=ls.remainder(new BigDecimal(60)).setScale(0,BigDecimal.ROUND_HALF_DOWN);
//		          mins= min.toString();
//		          secs= sec.toString();
//		          if ( min.toString().length()==1) {
//		        	 mins="0"+mins;
//		          }if (sec.toString().length()==1) {
//		        	  secs="0"+secs;
//				 }
//		         time=mins+":"+secs;
//		         return time;
//			 }else
//				return GlobalConstant.PLEASE_INPUT_TRUE_FILEURL;
//	        }
}
