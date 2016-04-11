package com.pinde.sci.biz.sczyres.impl;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.res.IResRegBiz;
import com.pinde.sci.biz.sczyres.DoctorRecruitBiz;
import com.pinde.sci.biz.sczyres.DoctorSingupBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.PubUserResumeMapper;
import com.pinde.sci.dao.base.ResDoctorMapper;
import com.pinde.sci.dao.base.ResDoctorRecruitMapper;
import com.pinde.sci.enums.res.RecruitTypeEnum;
import com.pinde.sci.enums.res.RegStatusEnum;
import com.pinde.sci.enums.sczyres.SpeCatEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.form.sczyres.ExtInfoForm;
import com.pinde.sci.form.sczyres.SingUpForm;
import com.pinde.sci.form.sczyres.WorkResumeForm;
import com.pinde.sci.model.mo.PubUserResume;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.ResReg;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
@Service
@Transactional(rollbackFor=Exception.class)
public class DoctorSingupBizImpl implements DoctorSingupBiz{

	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private ResDoctorMapper doctorMapper;
	@Autowired
	private ResDoctorRecruitMapper doctorRecruitMapper;
	@Autowired
	private IResRegBiz resResBiz;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private DoctorRecruitBiz recruitBiz;
	@Resource
	private PubUserResumeMapper resumpMapper;
	
	private static final String EXT_INFO_ROOT = "extInfo";
	private static final String EXT_INFO_ELE = "extInfoForm";
	private static final String WORK_RESUME_LIST_ELE = "workResumeList";
	private static final String WORK_RESUME_ELE = "workResumeForm";
	
	@Override
	public void submitSingup(SingUpForm form) {
		SysUser user = form.getUser();
		String userFlow = user.getUserFlow();
		//修改user信息
		this.userBiz.updateUser(form.getUser());
		String regYear = InitConfig.getSysCfg("res_reg_year");
		ResDoctor doctor = form.getDoctor();
		doctor.setDoctorFlow(userFlow);
		doctor.setDoctorName(user.getUserName());
		//设置报名年份
		doctor.setSessionNumber(regYear);
		
        //在InitConfig.getSysCfg("res_reg_year")报名年份下是否存在res_reg的记录
        ResReg reg = this.resResBiz.searchResReg(userFlow, regYear);
        if(reg==null){
        	reg = new ResReg();
        	reg.setUserFlow(userFlow);
        	reg.setUserName(user.getUserName());
        	reg.setRegYear(regYear);
        	reg.setStatusId(RegStatusEnum.UnSubmit.getId());
        	reg.setStatusName(RegStatusEnum.UnSubmit.getName());
        	this.resResBiz.editResReg(reg);
        }
		//是否存在doctor信息
		ResDoctor existDoctor = this.doctorMapper.selectByPrimaryKey(userFlow);
		if(existDoctor==null){
			//学员状态为未提交
	        doctor.setDoctorStatusId(RegStatusEnum.UnSubmit.getId());
	        doctor.setDoctorStatusName(RegStatusEnum.UnSubmit.getName());
			GeneralMethod.setRecordInfo(doctor, true);
			doctor.setSelDeptFlag(GlobalConstant.FLAG_N);
			doctor.setSchFlag(GlobalConstant.FLAG_N);
			this.doctorMapper.insertSelective(doctor);
		}else{
			GeneralMethod.setRecordInfo(doctor, false);
			this.doctorMapper.updateByPrimaryKeySelective(doctor);
		}
		
		//保存额外信息
		PubUserResume resume = resumpMapper.selectByPrimaryKey(userFlow);
		String content = getXmlFromExtInfo(form.getExtInfo());
		if(resume==null){
			resume = new PubUserResume();
			resume.setUserFlow(userFlow);
			resume.setUserName(user.getUserName());
			resume.setUserResume(content);
			GeneralMethod.setRecordInfo(resume, true);
			this.resumpMapper.insertSelective(resume);
		}else{
			resume.setUserResume(content);
			GeneralMethod.setRecordInfo(resume,false);
			this.resumpMapper.updateByPrimaryKeySelective(resume);
		}
	}

	@Override
	public void submitRecruit(ResDoctorRecruitWithBLOBs recruit) {
		recruit.setRecruitTypeId(RecruitTypeEnum.Fill.getId());
		recruit.setRecruitTypeName(RecruitTypeEnum.Fill.getName());
		saveRecruit(recruit);
		//将学员状态更改为待审核
		ResDoctor doctor = new ResDoctor();
		doctor.setDoctorFlow(recruit.getDoctorFlow());
		doctor.setDoctorStatusId(RegStatusEnum.Passing.getId());
		doctor.setDoctorStatusName(RegStatusEnum.Passing.getName());
		doctor.setOrgFlow(recruit.getOrgFlow());
		doctor.setOrgName(recruit.getOrgName());
		this.doctorMapper.updateByPrimaryKeySelective(doctor);
		
		ResReg reg = this.resResBiz.searchResReg(recruit.getDoctorFlow(), recruit.getRecruitYear());
		reg.setStatusId(RegStatusEnum.Passing.getId());
		reg.setStatusName(RegStatusEnum.Passing.getName());
		this.resResBiz.editResReg(reg);
		
	}
	
	/**
	 * 获取额外信息xml
	 * @param extInfo
	 * @return
	 */
	private String getXmlFromExtInfo(ExtInfoForm extInfo){
		String xmlBody = null;
		if(extInfo!=null){
			Document doc = DocumentHelper.createDocument();
			Element root = doc.addElement(EXT_INFO_ROOT);
			Element extInfoForm = root.addElement(EXT_INFO_ELE);
			Map<String,String> filedMap = getClassFieldMap(extInfo);
			if(filedMap!=null && filedMap.size()>0){
				for(String key : filedMap.keySet()){
					Element item = extInfoForm.addElement(key);
					item.setText(filedMap.get(key));
				}
			}
			
			List<WorkResumeForm> workResumeList = extInfo.getWorkResumeList();
			if(workResumeList!=null && workResumeList.size()>0){
				Element workResumeListEle = root.addElement(WORK_RESUME_LIST_ELE);
				for(WorkResumeForm resume : workResumeList){
					Element resumeEle = workResumeListEle.addElement(WORK_RESUME_ELE);
					Map<String,String> resumeFiledMap = getClassFieldMap(resume);
					if(resumeFiledMap!=null && resumeFiledMap.size()>0){
						for(String key : resumeFiledMap.keySet()){
							Element item = resumeEle.addElement(key);
							item.setText(resumeFiledMap.get(key));
						}
					}
				}
			}
			
			xmlBody=doc.asXML();
		}
		return xmlBody;
	}
	
	/**
	 * 获取属性名和值
	 * @param extInfo
	 * @return
	 */
	private Map<String,String> getClassFieldMap(Object obj){
		Map<String,String> filedMap = null;
		if(obj!=null){
			try{
				filedMap = new HashMap<String, String>();
				String stringClassName = String.class.getSimpleName();
				Class<?> objClass = obj.getClass();
				Field[] fileds = objClass.getDeclaredFields();
				for(Field f : fileds){
					String typeName = f.getType().getSimpleName();
					if(stringClassName.equals(typeName)){
						String attrName = f.getName();
						String firstLetter = attrName.substring(0,1).toUpperCase();
						String methedName = "get"+firstLetter+attrName.substring(1);
						Method getMethod = objClass.getMethod(methedName);
						String value = (String)getMethod.invoke(obj);
						filedMap.put(attrName,StringUtil.defaultString(value));
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return filedMap;
	}
	
	
	/**
	 * 解析额外信息xml
	 */
	@Override
	public ExtInfoForm parseExtInfoXml(String extInfoXml){
		ExtInfoForm extInfo = null;
		if(StringUtil.isNotBlank(extInfoXml)){
			try{
				extInfo = new ExtInfoForm();
				Document doc = DocumentHelper.parseText(extInfoXml);
				Element root = doc.getRootElement();
				Element extInfoFormEle = root.element(EXT_INFO_ELE);
				if(extInfoFormEle!=null){
					List<Element> extInfoAttrEles = extInfoFormEle.elements();
					if(extInfoAttrEles!=null && extInfoAttrEles.size()>0){
						for(Element attr : extInfoAttrEles){
							String attrName = attr.getName();
							String attrValue = attr.getText();
							setValue(extInfo,attrName,attrValue);
						}
					}
				}
				
				Element workResumeListEle = root.element(WORK_RESUME_LIST_ELE);
				if(workResumeListEle!=null){
					List<Element> workResumeEles = workResumeListEle.elements();
					if(workResumeEles!=null && workResumeEles.size()>0){
						List<WorkResumeForm> resumeList = new ArrayList<WorkResumeForm>();
						for(Element resumeEle : workResumeEles){
							WorkResumeForm resume = new WorkResumeForm();
							List<Element> resumeAttrEles = resumeEle.elements();
							if(resumeAttrEles!=null && resumeAttrEles.size()>0){
								for(Element attr : resumeAttrEles){
									String attrName = attr.getName();
									String attrValue = attr.getText();
									setValue(resume,attrName,attrValue);
								}
							}
							resumeList.add(resume);
						}
						extInfo.setWorkResumeList(resumeList);
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return extInfo;
	}
	
	/**
	 * 为对象自动复制
	 */
	private void setValue(Object obj,String attrName,String attrValue){
		try{
			Class<?> objClass = obj.getClass();
			String firstLetter = attrName.substring(0,1).toUpperCase();
			String methedName = "set"+firstLetter+attrName.substring(1);
			Method setMethod = objClass.getMethod(methedName,new Class[] {String.class});
			setMethod.invoke(obj,new Object[] {attrValue});
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public List<SysDict> findSpe(String catSpeId) {
		List<SysDict> spes = new ArrayList<SysDict>();
		if(SpeCatEnum.Zy.getId().equals(catSpeId)){
			spes = DictTypeEnum.sysListDictMap.get(DictTypeEnum.ZySpe.getId());
		}
		if(SpeCatEnum.Zyqk.getId().equals(catSpeId)){
			spes = DictTypeEnum.sysListDictMap.get(DictTypeEnum.ZyqkSpe.getId());
		}
		return spes;
	}

	@Override
	public void saveRecruit(ResDoctorRecruitWithBLOBs recruit) {
		String regYear = InitConfig.getSysCfg("res_reg_year");
		String recruitFlow = recruit.getRecruitFlow();
		String orgFlow = recruit.getOrgFlow();
		SysOrg org = this.orgBiz.readSysOrg(orgFlow);
		recruit.setRecruitDate(DateUtil.getCurrDate());
		recruit.setOrgName(org.getOrgName());
		recruit.setRecruitYear(regYear);
		//是否存在该记录
		//不存在就新增 存在就修改
		if(StringUtil.isBlank(recruitFlow)){
			recruit.setRecruitFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(recruit, true);
			this.doctorRecruitMapper.insertSelective(recruit);
		}else{
			GeneralMethod.setRecordInfo(recruit, false);
			this.doctorRecruitMapper.updateByPrimaryKeySelective(recruit);
		}
	}

	@Override
	public void modDoctorByDoctorFlow(ResDoctor doctor) {
		if(doctor!=null){
			this.doctorMapper.updateByPrimaryKeySelective(doctor);
		}
		
	}
}
