package com.pinde.sci.biz.njmuedu.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.njmuedu.INjmuEduCourseChapterBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.EduCourseChapterMapper;
import com.pinde.sci.dao.njmuedu.NjmuEduCourseChapterExtMapper;
import com.pinde.sci.enums.edu.EduCourseTypeEnum;
import com.pinde.sci.form.njmuedu.ChapterForm;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseChapter;
import com.pinde.sci.model.mo.EduCourseChapterExample;
import com.pinde.sci.model.mo.EduCourseChapterExample.Criteria;
import com.pinde.sci.model.njmuedu.EduCourseChapterExt;
import com.pinde.sci.model.njmuedu.EduUserExt;
@Service
@Transactional(rollbackFor = Exception.class)
public class NjmuEduCourseChapterBizImpl implements INjmuEduCourseChapterBiz {
	@Autowired
	private EduCourseChapterMapper eduCourseChapterMapper;
	@Autowired
	private NjmuEduCourseChapterExtMapper eduCourseChapterExtMapper;
	
	@Override
	public EduCourseChapter seachOne(String chapterFlow) {
		return this.eduCourseChapterMapper.selectByPrimaryKey(chapterFlow);
	}
	@Override
	public List<EduCourseChapter> getAllChapter(String courseFlow) {
		EduCourseChapterExample example = new EduCourseChapterExample();
		example.createCriteria().andCourseFlowEqualTo(courseFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("to_number(CHAPTER_NO) asc,CREATE_TIME asc");
		return eduCourseChapterMapper.selectByExample(example);
	}
	
	
	@Override
	public int saveChapterInfo(EduCourseChapter chapter, MultipartFile file) throws Exception {
		if(file.getSize() > 0){
			//´´½¨Ä¿Â¼
			String dateString = DateUtil.getCurrDate2();
			String newDir = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir"))+File.separator+"eduImages"+File.separator + dateString ;
			File fileDir = new File(newDir);
			if(!fileDir.exists()){
				fileDir.mkdirs();
			}
			//ÎÄ¼þÃû
			String originalFilename = file.getOriginalFilename();
			originalFilename = PkUtil.getUUID() + originalFilename.substring(originalFilename.lastIndexOf("."));
			File newFile = new File(fileDir, originalFilename); 
			file.transferTo(newFile);
			
			//É¾³ýÔ­Í¼Æ¬
			String oldChapterImg = chapter.getChapterImg();
			if(StringUtil.isNotBlank(oldChapterImg)){
				try {
					oldChapterImg = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir"))+ File.separator + oldChapterImg;
					File imgFile = new File(oldChapterImg);
					if(imgFile.exists()){
						imgFile.delete();
					}
				} catch (Exception e) {
					e.printStackTrace();
					throw new RuntimeException("É¾³ýÍ¼Æ¬Ê§°Ü£¡");
				}
			}
			
			String chapterImg = "eduImages/" + dateString+"/"+originalFilename;
			chapter.setChapterImg(chapterImg);//Í¼Æ¬Â·¾¶
		}
		if(chapter.getChapterOrder() == null){
			short maxChapterOrder = eduCourseChapterExtMapper.selectMAXChapterOrder();
			chapter.setChapterOrder((short) (maxChapterOrder+1));
		}
		return saveChapter(chapter);
	}
	
	
	@Override
	public int saveChapter(EduCourseChapter chapter) {
		chapter.setChapterFile(chapter.getChapterFile().trim());
		if(StringUtil.isNotBlank(chapter.getChapterFlow())){
			GeneralMethod.setRecordInfo(chapter, false);
			return eduCourseChapterMapper.updateByPrimaryKeySelective(chapter);
		}else{
			chapter.setChapterFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(chapter, true);
			return eduCourseChapterMapper.insert(chapter);
		}
	}
	

	@Override
	public int countNoParentChapterByCourseFlow(EduCourse eduCourse) {
		EduCourseChapterExample example=new EduCourseChapterExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andParentChapterFlowIsNull();
		if(StringUtil.isNotBlank(eduCourse.getCourseFlow())){
	    	criteria.andCourseFlowEqualTo(eduCourse.getCourseFlow());
	    }
		return eduCourseChapterMapper.countByExample(example);
	}
	@Override
	public int countParentChapterByCourseFlow(EduCourse eduCourse) {
		EduCourseChapterExample example=new EduCourseChapterExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andParentChapterFlowIsNotNull();
		if(StringUtil.isNotBlank(eduCourse.getCourseFlow())){
		  criteria.andCourseFlowEqualTo(eduCourse.getCourseFlow());
	    }
		return eduCourseChapterMapper.countByExample(example);
	}
	@Override
	public EduCourseChapterExt seachOneWithExt(String chapterFlow) {
		return this.eduCourseChapterExtMapper.selectOneWithExt(chapterFlow);
	}
	
	
	@Override
	public int deleteChapterImg(String chapterFlow) {
		if(StringUtil.isNotBlank(chapterFlow)){
			EduCourseChapter chapter = seachOne(chapterFlow);
			if(chapter != null){ //ÐÞ¸Ä¿Î³ÌÉ¾³ý
				String img = chapter.getChapterImg();
				if(StringUtil.isNotBlank(img)){
					try {
						img = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir"))+ File.separator + img;
						File file = new File(img);
						if(file.exists()){
							boolean delRestlt = file.delete();
							if(delRestlt){//É¾³ý³É¹¦
								chapter.setChapterImg(null);
								return eduCourseChapterMapper.updateByPrimaryKey(chapter);
							}
						}
					} catch (Exception e) {
						e.printStackTrace();
						throw new RuntimeException("É¾³ýÍ¼Æ¬Ê§°Ü£¡");
					}
				}
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int updateByChapterFlowList(List<String> chapterFlowList) {
		ChapterForm form = new ChapterForm();
		form.setChapterFlowList(chapterFlowList);
		return eduCourseChapterExtMapper.updateByChapterFlowList(form);
	}
	
	
	@Override
	public List<EduCourseChapter> searchCourseChapterList(EduCourseChapter chapter, String order,String isParent) {
		EduCourseChapterExample example = new EduCourseChapterExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(chapter.getCourseFlow())){
			criteria.andCourseFlowEqualTo(chapter.getCourseFlow());
		}
		if(StringUtil.isNotBlank(isParent)){
			criteria.andParentChapterFlowIsNotNull();
		}
		if(StringUtil.isNotBlank(order)){
			example.setOrderByClause(order);
		}
		return eduCourseChapterMapper.selectByExample(example);
	}
	@Override
	public List<EduCourseChapter> searchChapterListByChapterFlowList(List<String> chapterFlowList) {
		if(chapterFlowList != null && !chapterFlowList.isEmpty()){
			EduCourseChapterExample example = new EduCourseChapterExample();
			example.createCriteria().andChapterFlowIn(chapterFlowList).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			example.setOrderByClause("CREATE_TIME DESC");
			return eduCourseChapterMapper.selectByExample(example);
		}
		return null;
	}
	@Override
	public Map<String,Map<String,List<EduCourseChapterExt>>> searchTeachersChapterList(
			List<EduUserExt> eduUserExtList) {
		Map<String,Map<String,List<EduCourseChapterExt>>> teacherChapterMap=new HashMap<String, Map<String,List<EduCourseChapterExt>>>();
		Map<String,List<EduCourseChapterExt>> optionalChapterMap=new HashMap<String, List<EduCourseChapterExt>>();
		Map<String,List<EduCourseChapterExt>> publicChapterMap=new HashMap<String, List<EduCourseChapterExt>>();
		Map<String,List<EduCourseChapterExt>> requiredChapterMap=new HashMap<String, List<EduCourseChapterExt>>();
		teacherChapterMap.put(EduCourseTypeEnum.Optional.getId(), optionalChapterMap);
		teacherChapterMap.put(EduCourseTypeEnum.Public.getId(), publicChapterMap);
		teacherChapterMap.put(EduCourseTypeEnum.Required.getId(), requiredChapterMap);
		if(eduUserExtList !=null && !eduUserExtList.isEmpty()){	
			for(EduUserExt eduUserExt:eduUserExtList){
				List<EduCourseChapterExt> eduCourseChapterExtOptionalList=new ArrayList<EduCourseChapterExt>();
				List<EduCourseChapterExt> eduCourseChapterExtPublicList=new ArrayList<EduCourseChapterExt>();
				List<EduCourseChapterExt> eduCourseChapterExtRequiredList=new ArrayList<EduCourseChapterExt>();
			    List<EduCourseChapter> chapterList=searchChapterListByTeacherId(eduUserExt.getUserFlow());
			    optionalChapterMap.put(eduUserExt.getUserFlow(), eduCourseChapterExtOptionalList);
			    publicChapterMap.put(eduUserExt.getUserFlow(), eduCourseChapterExtPublicList);
			    requiredChapterMap.put(eduUserExt.getUserFlow(), eduCourseChapterExtRequiredList);
			    if(chapterList!=null && !chapterList.isEmpty()){	
			    	for(EduCourseChapter chapter:chapterList){
			    		EduCourseChapterExt eduChapterExt=this.eduCourseChapterExtMapper.selectOneWithExt(chapter.getChapterFlow());
			    		for(EduCourseTypeEnum type:EduCourseTypeEnum.values()){
			    			if(eduChapterExt.getCourse().getCourseTypeId().equals(type.getId())){
			    				teacherChapterMap.get(type.getId()).get(eduUserExt.getUserFlow()).add(eduChapterExt);
			    			}
			    		}
			    		
			    	}
			    }
			}
		}
		return teacherChapterMap;
	}
	@Override
	public List<EduCourseChapter> searchChapterListByTeacherId(String teacherId) {
		EduCourseChapterExample example=new EduCourseChapterExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(teacherId)){
		   criteria.andTeacherIdEqualTo(teacherId);
		}
		example.setOrderByClause("chapter_order asc,course_flow asc");
		return eduCourseChapterMapper.selectByExample(example);
	}
    
	@Override
	public String saveChapterReturnFlow(EduCourseChapter chapter) {
		if(StringUtil.isNotBlank(chapter.getChapterFlow())){
			GeneralMethod.setRecordInfo(chapter, false);
			return eduCourseChapterMapper.updateByPrimaryKeySelective(chapter)+":"+chapter.getChapterFlow();
		}else{
			chapter.setChapterFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(chapter, true);
			return eduCourseChapterMapper.insert(chapter)+":"+chapter.getChapterFlow();
		}
	}
}
