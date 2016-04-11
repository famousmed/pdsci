package com.pinde.sci.ctrl.edu;

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
import com.pinde.sci.biz.edu.IEduCourseBiz;
import com.pinde.sci.biz.edu.IEduCourseChapterBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.sys.OrgTypeEnum;
import com.pinde.sci.form.edu.ChapterForm;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseChapter;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserRole;

@Controller
@RequestMapping("edu/manage/course")
public class EduCourseManageController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(EduCourseManageController.class);
	@Autowired
	private IEduCourseBiz courseBiz;
	@Autowired
	private IEduCourseChapterBiz chapterBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IOrgBiz orgBiz;
	
	/**
	 * �༭�γ�
	 * @return
	 */
	@RequestMapping("/editCourse")
	public String editCourse(String courseFlow, Model model){
		if(StringUtil.isNotBlank(courseFlow)){
			EduCourse course = courseBiz.readCourse(courseFlow);
			model.addAttribute("course", course);
		}
		return "edu/manage/course/edit";
	}
	
	/**
	 * ����γ���Ϣ
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
			//return GlobalConstant.SAVE_SUCCESSED;
			return course.getCourseFlow();
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	
	/**
	 * ����ļ���С������
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
		String fileType = file.getContentType();//MIME����;
		String fileName = file.getOriginalFilename();//�ļ���
		String suffix = fileName.substring(fileName.lastIndexOf("."));//��׺��
		if(!(mimeList.contains(fileType) &&  suffixList.contains(suffix))){
			return GlobalConstant.UPLOAD_IMG_TYPE_ERROR;
		}
		long limitSize = Long.parseLong(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_limit_size")));//ͼƬ��С����
		if(file.getSize() > limitSize*1024*1024){
			return GlobalConstant.UPLOAD_IMG_SIZE_ERROR +limitSize +"M" ;
		}
		return GlobalConstant.FLAG_Y;//��ִ�б���
	}

	/**
	 * ���ؿγ��б�
	 * @param course
	 * @param model
	 * @return
	 */
	@RequestMapping("/courseList")
	public String courseList(EduCourse course, Integer currentPage,HttpServletRequest request, Model model){
		PageHelper.startPage(currentPage, getPageSize(request));
		List<EduCourse> courseList = courseBiz.searchCourseList(course);
		model.addAttribute("courseList", courseList);
		return "edu/manage/course/list";
	}
	
	/**
	 * ɾ���γ�
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
	 * ɾ���γ�ͼƬ
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
	 * �鿴�½�
	 * @param courseFlow
	 * @return
	 */
	@RequestMapping("/lookChapter")
	public String lookChapter(String courseFlow, Model model){
		EduCourse course = courseBiz.readCourse(courseFlow);
		model.addAttribute("course", course);
		//��ѯѧУ
		SysOrg sysOrg = new SysOrg();
		sysOrg.setOrgTypeId(OrgTypeEnum.University.getId());
		sysOrg.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysOrg> orgList = orgBiz.searchOrg(sysOrg);
		model.addAttribute("orgList", orgList);
		return "edu/manage/course/tree";
	}
	
	/**
	 * ��ѯ��ʦ
	 * @param orgFlow
	 * @return
	 */
	@RequestMapping("/searchTeacher")
	@ResponseBody
	public List<SysUser> searchTeacher(String orgFlow, Model model){
		if(StringUtil.isNotBlank(orgFlow)){
			Map<String,Object> paramMap=new HashMap<String, Object>();
			String roleFlow=InitConfig.getSysCfg("teacher_role_flow");
			paramMap.put("roleFlow", roleFlow);
			paramMap.put("orgFlow", orgFlow);
			List<SysUser> teacherList = userBiz.searchUserListByOrgFlow(paramMap);
			return teacherList;
		}
		return null;
	}
	
	
	/**
	 * ��ȡ�γ�ȫ���½�
	 * @return ָ����ʽ��json
	 */
	@RequestMapping(value="/getAllDataJson")
	@ResponseBody
	public String getAllDataJson(String courseFlow){
		if(StringUtil.isNotBlank(courseFlow)){
			List<EduCourseChapter> chapterList = chapterBiz.getAllChapter(courseFlow);
			StringBuilder sb = new StringBuilder();
			sb.append("[");
			sb.append("{\"id\":\"0\", \"pId\":\"-1\", \"name\":\"�γ��½�\",\"open\":true,\"t\":\"\"},");
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
	 * �༭�ڵ��¼�
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/getByIdJson",method=RequestMethod.POST)
	@ResponseBody
	public ChapterForm getByIdJson(String id){
		if(StringUtil.isNotBlank(id)){
			EduCourseChapter chapter = chapterBiz.seachOne(id);
			ChapterForm  form = new ChapterForm();
			form.setChapter(chapter);
			String teacherId = chapter.getTeacherId();
			if(StringUtil.isNotBlank(teacherId)){
				SysUser sysUser = userBiz.readSysUser(teacherId);
				String orgFlow = sysUser.getOrgFlow();
				if(StringUtil.isNotBlank(orgFlow)){
					form.setOrgFlow(orgFlow);
					//��ȡ��ʦ��ɫ��ˮ��
					String roleFlow=InitConfig.getSysCfg("teacher_role_flow");
					SysUserRole userRole = new SysUserRole();
					userRole.setRoleFlow(roleFlow);
					userRole.setOrgFlow(orgFlow);
					List<SysUserRole> userRoleList  =  userRoleBiz.searchUserRole(userRole);
					List<String> userFlowList = new ArrayList<String>();
					if(userRoleList != null && !userRoleList.isEmpty()){
						for(SysUserRole ur : userRoleList){
							userFlowList.add(ur.getUserFlow());
						}
						List<SysUser> teacherList = userBiz.searchSysUserByuserFlows(userFlowList);
						form.setUserList(teacherList);
					}
				}
			}
			return form;
		}
		return null;
	}
	
	/**
	 * �����½���Ϣ
	 * @param subject
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/saveChapter",method=RequestMethod.POST)
	@ResponseBody
	public String saveChapter(EduCourseChapter chapter, MultipartFile file) throws Exception{
		if(file.getSize() > 0){
			String checkResult = checkFile(file);
			if(checkResult != GlobalConstant.FLAG_Y){
				return checkResult;
			}
		}
		
		int result = chapterBiz.saveChapterInfo(chapter,file);
		if(result != GlobalConstant.ZERO_LINE){
			//return GlobalConstant.SAVE_SUCCESSED;
			return chapter.getChapterImg();
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	
	/**
	 * ɾ���½�ͼƬ
	 * @param courseFlow
	 * @return
	 */
	@RequestMapping("/deleteChapterImg")
	@ResponseBody
	public String deleteChapterImg(String chapterFlow){
		if(StringUtil.isNotBlank(chapterFlow)){
			int result = chapterBiz.deleteChapterImg(chapterFlow);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	/**
	 * ����ɾ��(���¼�)
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
			//TODO ɾ���ϴ�ͼƬ��·���е�ͼƬ
			
			int result = chapterBiz.updateByChapterFlowList(chapterFlowList);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		
		return GlobalConstant.DELETE_FAIL;
	}
}
