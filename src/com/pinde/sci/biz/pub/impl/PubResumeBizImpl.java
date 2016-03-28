package com.pinde.sci.biz.pub.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduResumeBiz;
import com.pinde.sci.biz.pub.IAcademicResumeBiz;
import com.pinde.sci.biz.pub.IPubUserResumeBiz;
import com.pinde.sci.biz.pub.IWorkResumeBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.PubUserResumeMapper;
import com.pinde.sci.form.pub.AcademicResumeForm;
import com.pinde.sci.form.pub.EduResumeForm;
import com.pinde.sci.form.pub.WorkResumeForm;
import com.pinde.sci.model.mo.PubUserResume;
import com.pinde.sci.model.mo.SysUser;
/**
 * 
 * @author tiger
 *
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class PubResumeBizImpl implements IPubUserResumeBiz, IEduResumeBiz, IWorkResumeBiz, IAcademicResumeBiz {
	@Resource
	private PubUserResumeMapper userResumpMapper;
	/**
	 * �����������
	 */
	@Override
	public int saveEduResume(SysUser user, EduResumeForm form) throws Exception {
		if(null != user && null != form){
			Document dom ;
			Element root ;
			Element eduElement;
			
			String startDate = form.getStartDate();
			String endDate = form.getEndDate();
			String college = form.getCollege();
			String major = form.getMajor();
			String education = form.getEducation();
			String degree = form.getDegree();
			
			//��ȡ������Ϣ
			PubUserResume resume = readPubUserResume(user.getUserFlow());
			
			if(null != resume && null != resume.getUserResume()){//���ڸ��˼���--���޸�
				dom = DocumentHelper.parseText(resume.getUserResume());
				root = dom.getRootElement();
				
				//���޽���������¼�����򴴽�һ��education�ڵ�
				String xpath = "/rusume/education";
				eduElement = (Element)dom.selectSingleNode(xpath);
				if(null != eduElement){
					eduElement = root.element("education");
					
				}else{
					eduElement = root.addElement("education");
				}
			}else{//�������˼���
				resume = new PubUserResume();

				dom = DocumentHelper.createDocument();
				root = dom.addElement("rusume");
				eduElement = root.addElement("education");
			}
			
			String xpath = "/rusume/education/record[@recordId = '"+form.getRecordId()+"']";;
			Element recordElement = (Element)dom.selectSingleNode(xpath);
			//���� record id���� �ж��������޸� ���˼����еĽ�������
			
			if(null != recordElement){
				recordElement.addAttribute("recordId",form.getRecordId());
				recordElement.element("startDate").setText(StringUtil.defaultIfEmpty(startDate, ""));
				recordElement.element("endDate").setText(StringUtil.defaultIfEmpty(endDate, ""));
				recordElement.element("college").setText(StringUtil.defaultIfEmpty(college, ""));
				recordElement.element("major").setText(StringUtil.defaultIfEmpty(major, ""));
				recordElement.element("education").setText(StringUtil.defaultIfEmpty(education, ""));
				recordElement.element("degree").setText(StringUtil.defaultIfEmpty(degree, ""));
			}else{
				String recordId = PkUtil.getUUID();
				recordElement = eduElement.addElement("record").addAttribute("recordId", recordId);
				recordElement.addElement("startDate").setText(StringUtil.defaultIfEmpty(startDate, ""));
				recordElement.addElement("endDate").setText(StringUtil.defaultIfEmpty(endDate, ""));
				recordElement.addElement("college").setText(StringUtil.defaultIfEmpty(college, ""));
				recordElement.addElement("major").setText(StringUtil.defaultIfEmpty(major, ""));
				recordElement.addElement("education").setText(StringUtil.defaultIfEmpty(education, ""));
				recordElement.addElement("degree").setText(StringUtil.defaultIfEmpty(degree, ""));
			}
			//CLOB
			resume.setUserResume(dom.asXML());
			int result =  savePubUserResume(user, resume);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.ONE_LINE; 
			}
			
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	/**
	 * ��ȡ��������
	 */
	@Override
	public PubUserResume readPubUserResume(String userFlow) {
		if(StringUtil.isNotBlank(userFlow)){
			PubUserResume resume = userResumpMapper.selectByPrimaryKey(userFlow);
			return resume;
		}
		return null;
	}
	
	/**
	 * ���ؽ����б�
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<EduResumeForm> queryEduResumeList(PubUserResume resume) throws Exception {
		List<EduResumeForm> eduFormList = null;
		if(null != resume && StringUtil.isNotBlank(resume.getUserResume())){
			Document dom = DocumentHelper.parseText(resume.getUserResume());
			String xpath = "/rusume/education/record";
			List<Element> recordElements = dom.selectNodes(xpath);
			if(null != recordElements && !recordElements.isEmpty()){
				eduFormList = new ArrayList<EduResumeForm>();
				EduResumeForm form = null;
				for(Element e : recordElements){
					form = new EduResumeForm();
					form.setRecordId(e.attributeValue("recordId"));//id
					form.setStartDate(e.element("startDate").getTextTrim());
					form.setEndDate(e.element("endDate").getTextTrim());
					form.setCollege(e.element("college").getTextTrim());
					form.setMajor(e.element("major").getTextTrim());
					form.setEducation(e.element("education").getTextTrim());
					form.setDegree(e.element("degree").getTextTrim());
					eduFormList.add(form);
				}
			}
		}
		return eduFormList;
	}
	
	/**
	 * ��ȡһ����������
	 */
	@Override
	public EduResumeForm getEduResumeByRecordId(String userFlow, String recordId) throws Exception {
		EduResumeForm eduForm = null;
		if(StringUtil.isNotBlank(userFlow) && StringUtil.isNotBlank(recordId)){
			PubUserResume resume = readPubUserResume(userFlow);
			if(null != resume && StringUtil.isNotBlank(resume.getUserResume())){
				Document dom = DocumentHelper.parseText(resume.getUserResume());
				String xpath = "/rusume/education/record[@recordId = '"+recordId+"']";
				Element e = (Element) dom.selectSingleNode(xpath);
				if(null != e){
					eduForm = new EduResumeForm();
					eduForm.setRecordId(e.attributeValue("recordId"));
					eduForm.setStartDate(e.element("startDate").getTextTrim());
					eduForm.setEndDate(e.element("endDate").getTextTrim());
					eduForm.setCollege(e.element("college").getTextTrim());
					eduForm.setMajor(e.element("major").getTextTrim());
					eduForm.setEducation(e.element("education").getTextTrim());
					eduForm.setDegree(e.element("degree").getTextTrim());
				}
			}
		}
		return eduForm;
		
	}
	
	
	/**
	 * ɾ��һ����������
	 */
	@Override
	public int delEduResumeByRecordId(String userFlow, String recordId) throws Exception {
		if(StringUtil.isNotBlank(userFlow) && StringUtil.isNotBlank(recordId)){
			PubUserResume resume = readPubUserResume(userFlow);
			if(null != resume && StringUtil.isNotBlank(resume.getUserResume())){
				Document dom = DocumentHelper.parseText(resume.getUserResume());
				String xpath = "/rusume/education/record[@recordId = '"+recordId+"']";
				
				//List list = dom.selectNodes(xpath);// 
				
				Element e = (Element) dom.selectSingleNode(xpath);//��xpath���Ҷ���
				if(null != e){
					/*List list = dom.selectNodes(xpath);// ��xpath���Ҷ���
					
					//��������������������Ҫɾ���Ľڵ�,�������൱��ָ�룬ָ���������еĽڵ�
					Iterator iter = list.iterator();
					while (iter.hasNext()) {
						Element nextE = (Element) iter.next();
						e.remove(nextE);
					}*/
					Element parentE =  e.getParent();
					parentE.remove(e);
				}
				resume.setUserResume(dom.asXML());
				int result =  savePubUserResume(null, resume);
				if(result != GlobalConstant.ZERO_LINE){
					return GlobalConstant.ONE_LINE; 
				}
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	
	
	
	

	//-------------------��������------------------------------
	/**
	 * ���ع��������б�
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<WorkResumeForm> queryWorkList(PubUserResume resume) throws Exception {
		List<WorkResumeForm> workFormList = null;
		if(null != resume && StringUtil.isNotBlank(resume.getUserResume())){
			Document dom = DocumentHelper.parseText(resume.getUserResume());
			String xpath = "/rusume/work/record";
			List<Element> recordElements = dom.selectNodes(xpath);
			if(null != recordElements && !recordElements.isEmpty()){
				workFormList = new ArrayList<WorkResumeForm>();
				WorkResumeForm form = null;
				for(Element e : recordElements){
					form = new WorkResumeForm();
					form.setRecordId(e.attributeValue("recordId"));//id
					form.setStartDate(e.element("startDate").getTextTrim());
					form.setEndDate(e.element("endDate").getTextTrim());
					form.setOrgName(e.element("orgName").getTextTrim());
					form.setDepartment(e.element("department").getTextTrim());
					form.setTitle(e.element("title").getTextTrim());
					workFormList.add(form);
				}
			}
		}
		return workFormList;
	}


	@Override
	public WorkResumeForm getWorkResumeByRecordId(String userFlow, String recordId) throws Exception {
		WorkResumeForm workForm = null;
		if(StringUtil.isNotBlank(userFlow) && StringUtil.isNotBlank(recordId)){
			PubUserResume resume = readPubUserResume(userFlow);
			if(null != resume && StringUtil.isNotBlank(resume.getUserResume())){
				Document dom = DocumentHelper.parseText(resume.getUserResume());
				String xpath = "/rusume/work/record[@recordId = '"+recordId+"']";
				Element e = (Element) dom.selectSingleNode(xpath);
				if(null != e){
					workForm = new WorkResumeForm();
					workForm.setRecordId(e.attributeValue("recordId"));
					workForm.setStartDate(e.element("startDate").getTextTrim());
					workForm.setEndDate(e.element("endDate").getTextTrim());
					workForm.setOrgName(e.element("orgName").getTextTrim());
					workForm.setDepartment(e.element("department").getTextTrim());
					workForm.setTitle(e.element("title").getTextTrim());
				}
			}
		}
		return workForm;
	}


	@Override
	public int saveWorkResume(SysUser user, WorkResumeForm form) throws Exception {
		if(null != user && null != form){
			Document dom ;
			Element root ;
			Element workElement;
			
			String startDate = form.getStartDate();
			String endDate = form.getEndDate();
			String orgName = form.getOrgName();
			String department = form.getDepartment();
			String title = form.getTitle();
			
			PubUserResume resume = readPubUserResume(user.getUserFlow());
			
			if(null != resume && null != resume.getUserResume()){//���ڸ��˼���--���޸�
				dom = DocumentHelper.parseText(resume.getUserResume());
				root = dom.getRootElement();
				//���޹���������¼�����򴴽�һ��work�ڵ�
				String xpath = "/rusume/work";
				workElement = (Element)dom.selectSingleNode(xpath);
				if(null != workElement){
					workElement = root.element("work");
					
				}else{
					workElement = root.addElement("work");
				}
				
			}else{//�������˼���
				resume = new PubUserResume();
				
				dom = DocumentHelper.createDocument();
				root = dom.addElement("rusume");
				workElement = root.addElement("work");
			}
			
			String xpath = "/rusume/work/record[@recordId = '"+form.getRecordId()+"']";;
			Element recordElement = (Element)dom.selectSingleNode(xpath);
			//���� record id���� �ж��������޸� ���˼����еĹ�������
			
			if(null != recordElement){
				recordElement.addAttribute("recordId",form.getRecordId());
				recordElement.element("startDate").setText(StringUtil.defaultIfEmpty(startDate, ""));
				recordElement.element("endDate").setText(StringUtil.defaultIfEmpty(endDate, ""));
				recordElement.element("orgName").setText(StringUtil.defaultIfEmpty(orgName, ""));
				recordElement.element("department").setText(StringUtil.defaultIfEmpty(department, ""));
				recordElement.element("title").setText(StringUtil.defaultIfEmpty(title, ""));
			}else{
				String recordId = PkUtil.getUUID();
				recordElement = workElement.addElement("record").addAttribute("recordId", recordId);
				recordElement.addElement("startDate").setText(StringUtil.defaultIfEmpty(startDate, ""));
				recordElement.addElement("endDate").setText(StringUtil.defaultIfEmpty(endDate, ""));
				recordElement.addElement("orgName").setText(StringUtil.defaultIfEmpty(orgName, ""));
				recordElement.addElement("department").setText(StringUtil.defaultIfEmpty(department, ""));
				recordElement.addElement("title").setText(StringUtil.defaultIfEmpty(title, ""));
			}
			//CLOB
			resume.setUserResume(dom.asXML());
			
			
			int result =  savePubUserResume(user, resume);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.ONE_LINE; 
			}
			
		}
		return GlobalConstant.ZERO_LINE;
	}


	@Override
	public int delWorkResumeByRecordId(String userFlow, String recordId) throws Exception {
		if(StringUtil.isNotBlank(userFlow) && StringUtil.isNotBlank(recordId)){
			PubUserResume resume = readPubUserResume(userFlow);
			if(null != resume && StringUtil.isNotBlank(resume.getUserResume())){
				Document dom = DocumentHelper.parseText(resume.getUserResume());
				String xpath = "/rusume/work/record[@recordId = '"+recordId+"']";
				
				Element e = (Element) dom.selectSingleNode(xpath);//��xpath���Ҷ���
				if(null != e){
					Element parentE =  e.getParent();
					parentE.remove(e);
				}
				resume.setUserResume(dom.asXML());
				int result =  savePubUserResume(null, resume);
				if(result != GlobalConstant.ZERO_LINE){
					return GlobalConstant.ONE_LINE; 
				}
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	
	
	//----------------------------------ѧ����ְ---------------------------
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<AcademicResumeForm> queryAcademicList(PubUserResume resume) throws Exception {
		List<AcademicResumeForm> academicFormList = null;
		if(null != resume && StringUtil.isNotBlank(resume.getUserResume())){
			Document dom = DocumentHelper.parseText(resume.getUserResume());
			String xpath = "/rusume/academic/record";
			List<Element> recordElements = dom.selectNodes(xpath);
			if(null != recordElements && !recordElements.isEmpty()){
				academicFormList = new ArrayList<AcademicResumeForm>();
				AcademicResumeForm form = null;
				for(Element e : recordElements){
					form = new AcademicResumeForm();
					form.setRecordId(e.attributeValue("recordId"));//id
					form.setStartDate(e.element("startDate").getTextTrim());
					form.setAcademicName(e.element("academicName").getTextTrim());
					form.setTitle(e.element("title").getTextTrim());
					academicFormList.add(form);
				}
			}
		}
		return academicFormList;
	}


	@Override
	public AcademicResumeForm getAcademicResumeByRecordId(String userFlow, String recordId) throws Exception {
		AcademicResumeForm academicForm = null;
		if(StringUtil.isNotBlank(userFlow) && StringUtil.isNotBlank(recordId)){
			PubUserResume resume = readPubUserResume(userFlow);
			if(null != resume && StringUtil.isNotBlank(resume.getUserResume())){
				Document dom = DocumentHelper.parseText(resume.getUserResume());
				String xpath = "/rusume/academic/record[@recordId = '"+recordId+"']";
				Element e = (Element) dom.selectSingleNode(xpath);
				if(null != e){
					academicForm = new AcademicResumeForm();
					academicForm.setRecordId(e.attributeValue("recordId"));
					academicForm.setStartDate(e.element("startDate").getTextTrim());
					academicForm.setAcademicName(e.element("academicName").getTextTrim());
					academicForm.setTitle(e.element("title").getTextTrim());
				}
			}
		}
		return academicForm;
	}


	@Override
	public int saveAcademicResume(SysUser user, AcademicResumeForm form) throws Exception {
		if(null != user && null != form){
			Document dom ;
			Element root ;
			Element academicElement;
			
			String startDate = form.getStartDate();
			String academicName = form.getAcademicName();
			String title = form.getTitle();
			
			PubUserResume resume = readPubUserResume(user.getUserFlow());
			
			if(null != resume && null != resume.getUserResume()){//���ڸ��˼���--���޸�
				dom = DocumentHelper.parseText(resume.getUserResume());
				root = dom.getRootElement();
				//���޹���������¼�����򴴽�һ��academic�ڵ�
				String xpath = "/rusume/academic";
				academicElement = (Element)dom.selectSingleNode(xpath);
				if(null != academicElement){
					academicElement = root.element("academic");
					
				}else{
					academicElement = root.addElement("academic");
				}
				
			}else{//�������˼���
				resume = new PubUserResume();
				
				dom = DocumentHelper.createDocument();
				root = dom.addElement("rusume");
				academicElement = root.addElement("academic");
			}
			
			String xpath = "/rusume/academic/record[@recordId = '"+form.getRecordId()+"']";;
			Element recordElement = (Element)dom.selectSingleNode(xpath);
			//���� record id���� �ж��������޸� ���˼����е�ѧ����ְ����
			
			if(null != recordElement){
				recordElement.addAttribute("recordId",form.getRecordId());
				recordElement.element("startDate").setText(StringUtil.defaultIfEmpty(startDate, ""));
				recordElement.element("academicName").setText(StringUtil.defaultIfEmpty(academicName, ""));
				recordElement.element("title").setText(StringUtil.defaultIfEmpty(title, ""));
			}else{
				String recordId = PkUtil.getUUID();
				recordElement = academicElement.addElement("record").addAttribute("recordId", recordId);
				recordElement.addElement("startDate").setText(StringUtil.defaultIfEmpty(startDate, ""));
				recordElement.addElement("academicName").setText(StringUtil.defaultIfEmpty(academicName, ""));
				recordElement.addElement("title").setText(StringUtil.defaultIfEmpty(title, ""));
			}
			//CLOB
			resume.setUserResume(dom.asXML());
			
			int result =  savePubUserResume(user, resume);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.ONE_LINE; 
			}
			
		}
		return GlobalConstant.ZERO_LINE;
	}


	@Override
	public int delAcademicResumeByRecordId(String userFlow, String recordId) throws Exception {
		if(StringUtil.isNotBlank(userFlow) && StringUtil.isNotBlank(recordId)){
			PubUserResume resume = readPubUserResume(userFlow);
			if(null != resume && StringUtil.isNotBlank(resume.getUserResume())){
				Document dom = DocumentHelper.parseText(resume.getUserResume());
				String xpath = "/rusume/academic/record[@recordId = '"+recordId+"']";
				Element e = (Element) dom.selectSingleNode(xpath);//��xpath���Ҷ���
				if(null != e){
					Element parentE =  e.getParent();
					parentE.remove(e);
				}
				resume.setUserResume(dom.asXML());
				int result =  savePubUserResume(null, resume);
				if(result != GlobalConstant.ZERO_LINE){
					return GlobalConstant.ONE_LINE; 
				}
			}
		}
		return GlobalConstant.ZERO_LINE;
	}


	@Override
	public int savePubUserResume(SysUser user, PubUserResume resume) {
		//�����û�����ˮ���ж��������޸�����
		if(StringUtil.isNotBlank(resume.getUserFlow())){//�޸�
			GeneralMethod.setRecordInfo(resume, false);
			return userResumpMapper.updateByPrimaryKeyWithBLOBs(resume);
		}else{//����
			if(null != user){
				resume.setUserFlow(user.getUserFlow());
				resume.setUserName(user.getUserName());
				GeneralMethod.setRecordInfo(resume, true);
				return userResumpMapper.insert(resume);
			}else{
				return GlobalConstant.ZERO_LINE;
			}
		}
	}
}
