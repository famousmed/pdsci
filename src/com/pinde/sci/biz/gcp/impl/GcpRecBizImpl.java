package com.pinde.sci.biz.gcp.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.gcp.IGcpRecBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.pub.IPubProjUserBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.GcpRecMapper;
import com.pinde.sci.dao.base.PubFileMapper;
import com.pinde.sci.dao.base.PubProjProcessMapper;
import com.pinde.sci.enums.gcp.GcpProjStageEnum;
import com.pinde.sci.enums.gcp.GcpRecTypeEnum;
import com.pinde.sci.form.gcp.GcpCfgFileForm;
import com.pinde.sci.form.gcp.GcpEvaluationForm;
import com.pinde.sci.form.gcp.GcpFinishWorkForm;
import com.pinde.sci.form.gcp.GcpMeetingFileForm;
import com.pinde.sci.form.gcp.GcpMeetingForm;
import com.pinde.sci.form.gcp.GcpProvFilingForm;
import com.pinde.sci.form.gcp.GcpSumStampForm;
import com.pinde.sci.model.mo.GcpRec;
import com.pinde.sci.model.mo.GcpRecExample;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjProcess;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.pub.PubProjUserExt;

@Service
@Transactional(rollbackFor=Exception.class)
public class GcpRecBizImpl implements IGcpRecBiz {
	@Autowired
	private GcpRecMapper gcpRecMapper;
	@Autowired
	private IFileBiz fileBiz;
	@Autowired
	private IPubProjBiz pubProjBiz;
    @Autowired
    private PubFileMapper pubFileMapper;
    @Autowired
    private IPubProjUserBiz pubProjUserBiz;
    @Autowired
    private IRoleBiz roleBiz;
    @Resource
	private PubProjProcessMapper projProcessMapper;

	@Override
	public int edit(GcpRec rec) {
		if(rec!=null){
			rec.setOperTime(DateUtil.getCurrDateTime());
	        SysUser currUser = GlobalContext.getCurrentUser();
	        rec.setOperUserFlow(currUser.getUserFlow());
	        rec.setOperUserName(currUser.getUserName());
	        
			if(StringUtil.isNotBlank(rec.getRecFlow())){//修改
				GeneralMethod.setRecordInfo(rec, false);
				return this.gcpRecMapper.updateByPrimaryKeySelective(rec);
			}else{//新增
				rec.setRecFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(rec, true);
				return this.gcpRecMapper.insertSelective(rec);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int saveEval(String projFlow,Map<String,Object> paramMap) {
		PubProj proj = this.pubProjBiz.readProject(projFlow);
		if(proj!=null){
			//
			if(paramMap.get("agree")!=null){
				PubProjProcess process = new PubProjProcess();
				process.setProcessFlow(PkUtil.getUUID());
				process.setProjFlow(projFlow);
				process.setProjStageId(GcpProjStageEnum.Apply.getId());
				process.setProjStageName(GcpProjStageEnum.Apply.getName());
				process.setProjStatusId((String)paramMap.get("agree"));
				process.setRecTypeName("立项评估");
				process.setRecTypeId("Process");
				process.setProjStatusName((String)paramMap.get("agree"));
				process.setProcessRemark((String)paramMap.get("agree"));
				SysUser currUser = GlobalContext.getCurrentUser();
				process.setOperUserFlow(currUser.getUserFlow());
				process.setOperUserName(currUser.getUserName());
				process.setOperOrgFlow(currUser.getOrgFlow());
				process.setOperOrgName(currUser.getOrgName());
				process.setOperTime(DateUtil.getCurrDateTime());
				GeneralMethod.setRecordInfo(process, true);
				projProcessMapper.insertSelective(process);
			}
			
			GcpRec rec = this.searchOne(projFlow, GcpRecTypeEnum.EvaluationSheet.getId());
			if(rec==null){//首次添加
				rec = new GcpRec();
				rec.setProjFlow(projFlow);
				rec.setRecTypeId(GcpRecTypeEnum.EvaluationSheet.getId());
				rec.setRecTypeName(GcpRecTypeEnum.EvaluationSheet.getName());
				rec.setGcpStageId(proj.getProjStageId());
				rec.setGcpStageName(proj.getProjStageName());
				Document dom = DocumentHelper.createDocument();
				Element root = dom.addElement("evaluation");
				
				Iterator<String> it = paramMap.keySet().iterator();
				while(it.hasNext()){
					String key = it.next();
					root.addElement(key).setText((String)paramMap.get(key));
				} 
				if(paramMap.get("agree")==null){
					root.addElement("deptSign").setText(GlobalContext.getCurrentUser().getUserName());
					root.addElement("deptSignDate").setText(DateUtil.getCurrDate());
				}else {
					root.addElement("officeSignSign").setText(GlobalContext.getCurrentUser().getUserName());
					root.addElement("officeSignSignDate").setText(DateUtil.getCurrDate());
				}
//				root.addElement("agree").setText(agree);
//				root.addElement("projectTime").setText(projectTime);
				rec.setRecContent(dom.asXML());
				return this.edit(rec);
			}else {
				Document dom;
				try {
					dom = DocumentHelper.parseText(rec.getRecContent());
					Element root = dom.getRootElement();
					Iterator<String> it = paramMap.keySet().iterator();
					while(it.hasNext()){
						String key = it.next();
						Element ele = root.element(key);
						if(ele!=null){
							ele.setText((String)paramMap.get(key));
						}else {
							root.addElement(key).setText((String)paramMap.get(key));
						}
					} 
					if(paramMap.get("agree")==null){
						root.addElement("deptSign").setText(GlobalContext.getCurrentUser().getUserName());
						root.addElement("deptSignDate").setText(DateUtil.getCurrDate());
					}else {
						root.addElement("officeSign").setText(GlobalContext.getCurrentUser().getUserName());
						root.addElement("officeSignDate").setText(DateUtil.getCurrDate());
					}
					rec.setRecContent(dom.asXML());
					return this.edit(rec);
				} catch (DocumentException e) {
					e.printStackTrace();
				}
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public GcpRec searchOne(String projFlow, String recTypeId) {
		GcpRec rec = null;
		if(StringUtil.isNotBlank(projFlow)&&StringUtil.isNotBlank(recTypeId)){
			GcpRecExample example = new GcpRecExample();
			example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
			                        .andProjFlowEqualTo(projFlow).andRecTypeIdEqualTo(recTypeId);
			List<GcpRec> recList = this.gcpRecMapper.selectByExampleWithBLOBs(example);
			if(recList!=null&&!recList.isEmpty()){
				rec = recList.get(0);
			}
		}
		return rec;
	}

	@Override
	public GcpEvaluationForm searchEvaluation(String projFlow) throws Exception {
		GcpEvaluationForm form = null;
		if(StringUtil.isNotBlank(projFlow)){
			GcpRec rec = this.searchOne(projFlow, GcpRecTypeEnum.EvaluationSheet.getId());
			if(rec!=null&&StringUtil.isNotBlank(rec.getRecContent())){
				Document dom = DocumentHelper.parseText(rec.getRecContent());
				if(dom!=null){
					Element root = dom.getRootElement();
					Element nameElement = root.element("fileName");
					String fileName = nameElement==null?"":nameElement.getTextTrim();
					Element flowElement = root.element("fileFlow");
					String fileFlow = flowElement==null?"":flowElement.getTextTrim();
					Element agreeElement = root.element("agree");
					String agree = agreeElement==null?"":agreeElement.getTextTrim();
					Element projectTimeElement = root.element("projectTime");
					String projectTime = projectTimeElement==null?"":projectTimeElement.getTextTrim();
					form = new GcpEvaluationForm();
					form.setAgree(agree);
					form.setProjectTime(projectTime);
					form.setFileName(fileName);
					form.setFileFlow(fileFlow);
					
					
					//
					Map<String,String> dataMap = new HashMap<String, String>();
					List<Element> elements = root.elements();
					for(Element element : elements){
						dataMap.put(element.getName(), element.getText());
					}
					form.setDataMap(dataMap);
					
					
					/*
					//nydefy
					Element signElement = root.element("sign");
					String sign = signElement==null?"":signElement.getTextTrim();
					form.setSign(sign);
					
					Element officeAudit1Element = root.element("officeAudit1");
					String officeAudit1 = officeAudit1Element==null?"":officeAudit1Element.getTextTrim();
					form.setOfficeAudit1(officeAudit1);
					
					Element officeAudit2Element = root.element("officeAudit2");
					String officeAudit2 = officeAudit2Element==null?"":officeAudit2Element.getTextTrim();
					form.setOfficeAudit1(officeAudit2);
					
					Element officeAudit3Element = root.element("officeAudit3");
					String officeAudit3 = officeAudit3Element==null?"":officeAudit3Element.getTextTrim();
					form.setOfficeAudit1(officeAudit3);
					
					//dept
					Element officeAudit3Element = root.element("officeAudit3");
					String officeAudit3 = officeAudit3Element==null?"":officeAudit3Element.getTextTrim();
					form.setOfficeAudit1(officeAudit3);
					
					Element officeAudit3Element = root.element("officeAudit3");
					String officeAudit3 = officeAudit3Element==null?"":officeAudit3Element.getTextTrim();
					form.setOfficeAudit1(officeAudit3);
					*/
				}
			}
		}
		return form;
	}

	@Override
    public int saveApplyFile(MultipartFile[] files,
            String[] ids, String[] fileFlows, String[] fileNames, String[] versions, String[] versionDates,
            String projFlow) throws Exception {
		PubProj proj = pubProjBiz.readProject(projFlow);
        if(proj != null){
        	//1、操作文件 --》获取文件的流水号
        	String[] editFileFlows = editFiles(files, fileFlows);
        	//2、封装GcpCfgFileForm
        	List<GcpCfgFileForm> fileFormList = new ArrayList<GcpCfgFileForm>();
        	for(int i = 0; i < ids.length; i++){
        		GcpCfgFileForm fileForm = new GcpCfgFileForm();
        		if(i<ids.length){
        			fileForm.setId(ids[i]);
        		}
        		if(i<editFileFlows.length){
        			fileForm.setFileFlow(editFileFlows[i]);
        		}
        		if(i<fileNames.length){
        			fileForm.setFileName(fileNames[i]);
        		}
        		if(i<versions.length){
        			fileForm.setVersion(versions[i]);
        		}
        		if(i<versionDates.length){
        			fileForm.setVersionDate(versionDates[i]);
        		}
        		fileFormList.add(fileForm);
        	}
        	//3、操作记录
        	return editGcpRecFileXML(proj, fileFormList);
        }
		return GlobalConstant.ZERO_LINE;
    }

	/**
     * 保存附件
     * @param filesList
     * @param fileFlows
     * @return
     */
    private String[] editFiles(MultipartFile[] files, String[] fileFlows) {
        if(files.length > 0){  
            for(int i = 0;i < files.length; i++){
                //保存文件  
            	MultipartFile multipartFile = files[i];
                if(!multipartFile.isEmpty()){
                    PubFile file = new PubFile();
                    String originalFileName = multipartFile.getOriginalFilename();
                    String suffix =originalFileName.substring(originalFileName.lastIndexOf(".")+1); 
                    //默认的文件名
                    file.setFileName(originalFileName);
                    //文件后缀名
                    file.setFileSuffix(suffix);
                    file.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
                    try {
                        file.setFileContent(multipartFile.getBytes());
                        fileBiz.editFile(file);
                        fileFlows[i]= file.getFileFlow();
                    } catch (Exception e) {
                        throw new RuntimeException("文件上传异常");
                    } 
                }
            } 
        }
        return fileFlows; 
    }

    /**
     * 保存GCP_REC
     * @param projFlow
     * @param fileFormList
     * @return
     * @throws Exception
     */
    private int editGcpRecFileXML(PubProj proj, List<GcpCfgFileForm> fileFormList) throws Exception {
        Document dom = null;
        Element root = null;
        String projFlow = proj.getProjFlow();
        GcpRec gcpRec = searchOne(projFlow, GcpRecTypeEnum.ApplyFile.getId());
        if(gcpRec == null){
            //第一次新增XML
            dom = DocumentHelper.createDocument();
            root = dom.addElement("applyFile");
            for(GcpCfgFileForm form : fileFormList){
            	if(StringUtil.isNotBlank(form.getFileFlow())){
            		Element fileElement = root.addElement("file").addAttribute("id", form.getId());
            		fileElement.addElement("fileFlow").setText(form.getFileFlow());
            		fileElement.addElement("fileName").setText(form.getFileName());
            		String version = form.getVersion();
            		if(StringUtil.isNotBlank(version)){
            			fileElement.addElement("version").setText(version);
            		}else{
            			fileElement.addElement("version");
            		}
            		String versionDate = form.getVersionDate();
            		if(StringUtil.isNotBlank(versionDate)){
            			fileElement.addElement("versionDate").setText(form.getVersionDate());
            		}else{
            			fileElement.addElement("versionDate");
            		}
            	}
            }
            
            gcpRec = new GcpRec();
            gcpRec.setProjFlow(projFlow);
            gcpRec.setGcpStageId(proj.getProjStageId());
            gcpRec.setGcpStageName(proj.getProjStageName());
            gcpRec.setRecTypeId(GcpRecTypeEnum.ApplyFile.getId());
            gcpRec.setRecTypeName(GcpRecTypeEnum.ApplyFile.getName());
            
            gcpRec.setRecContent(dom.asXML());
            return edit(gcpRec);
        }
        //非第一次新增、修改XML
        String cfgBigValue = gcpRec.getRecContent();
        dom = DocumentHelper.parseText(cfgBigValue);
        
        for(GcpCfgFileForm form : fileFormList){
            String id = form.getId();
            String fileFlow = form.getFileFlow();
            String fileName = form.getFileName();
            String version = form.getVersion();
            String versionDate = form.getVersionDate();
            
            String fileXpath = "//file[@id='"+id+"']";
            Element fileElement = (Element) dom.selectSingleNode(fileXpath);
            if(fileElement != null){//修改file节点
                Node fileFlowNode = fileElement.element("fileFlow");
                fileFlowNode.setText(StringUtil.defaultString(fileFlow));
                Node fileNameNode = fileElement.element("fileName");
                fileNameNode.setText(StringUtil.defaultString(fileName));
                Node versionNode = fileElement.element("version");
                if(versionNode == null){
                	versionNode = fileElement.addElement("version");
                }
                versionNode.setText(version);
                Node versionDateNode = fileElement.element("versionDate");
                if(versionDateNode == null){
                	versionDateNode = fileElement.addElement("versionDate");
                }
                versionDateNode.setText(versionDate);
            }else{//新增file节点
                if(StringUtil.isNotBlank(fileFlow)){
                	root = dom.getRootElement();
                	fileElement = root.addElement("file").addAttribute("id", id);
                	fileElement.addElement("fileFlow").setText(StringUtil.defaultString(fileFlow));
                	fileElement.addElement("fileName").setText(StringUtil.defaultString(fileName));
                	if(StringUtil.isNotBlank(version)){
                		fileElement.addElement("version").setText(StringUtil.defaultString(version));
                	}
                	if(StringUtil.isNotBlank(versionDate)){
                		fileElement.addElement("versionDate").setText(StringUtil.defaultString(versionDate));
                	}
                }
            }
        }
        gcpRec.setRecContent(dom.asXML());
        return edit(gcpRec);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<GcpCfgFileForm> searchApplyFiles(String projFlow) throws Exception {
        if(StringUtil.isNotBlank(projFlow)){
            List<GcpCfgFileForm> fileFormList = new ArrayList<GcpCfgFileForm>();
            GcpRec gcpRec = searchOne(projFlow, GcpRecTypeEnum.ApplyFile.getId());
            if(gcpRec != null){
                Document dom = DocumentHelper.parseText(gcpRec.getRecContent());
                String fileXpath = "//file";
                List<Element> fileElements = dom.selectNodes(fileXpath);//阶段
                if(fileElements != null && !fileElements.isEmpty()){
                    for (Element fe : fileElements) {
                        GcpCfgFileForm file = new GcpCfgFileForm();
                        file.setId(fe.attributeValue("id"));
                        file.setFileFlow(fe.element("fileFlow") == null ? "" : fe.element("fileFlow").getTextTrim());
                        file.setFileName(fe.element("fileName") == null ? "" : fe.element("fileName").getTextTrim());
                        file.setVersion(fe.element("version") == null ? "" : fe.element("version").getTextTrim());
                        file.setVersionDate(fe.element("versionDate") == null ? "" : fe.element("versionDate").getTextTrim());
                        file.setTemple(fe.element("temple") == null ? "" : fe.element("temple").getTextTrim());
                        fileFormList.add(file);
                    }
                }
            }
            return fileFormList;
        }
        return null;
    }

	@Override
	public int delFileByIds(String projFlow, String[] ids) throws Exception {
		if(StringUtil.isNotBlank(projFlow) && ids.length >0){
			GcpRec gcpRec = searchOne(projFlow, GcpRecTypeEnum.ApplyFile.getId());
			if(gcpRec != null){
				Document dom = DocumentHelper.parseText(gcpRec.getRecContent());
            	for(String id : ids){
            		//file节点
            		String fileXpath = "//file[@id='"+id+"']";
            		Element fileElement = (Element) dom.selectSingleNode(fileXpath);
            		if(fileElement != null){
            			Element fileFlowElement =  fileElement.element("fileFlow");
            			if(fileFlowElement != null){
            				String fileFlow = fileElement.element("fileFlow").getTextTrim();
            				//删除PubFile 
            				PubFile pubFile = new PubFile();
            				pubFile.setFileFlow(fileFlow);
            				pubFile.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
            				fileBiz.editFile(pubFile);
            				
            				//删除file节点
            				fileElement.getParent().remove(fileElement);
            				
            			}
            		}
                }
            	gcpRec.setRecContent(dom.asXML());
            	return edit(gcpRec);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int saveMeeting(GcpMeetingForm form) throws Exception {
		if(form != null){
			String projFlow = form.getProjFlow();
			PubProj proj = this.pubProjBiz.readProject(projFlow);
			if(proj!=null){
				//修改项目阶段
				String projStageId = form.getProjStageId();
				if (StringUtil.isNotBlank(projStageId) && !projStageId.equals(proj.getProjStageId())) {
					proj.setProjStageId(projStageId);
					proj.setProjStageName(GcpProjStageEnum.getNameById(projStageId));
					this.pubProjBiz.modProject(proj);
				}
				GcpRec rec = this.searchOne(projFlow, GcpRecTypeEnum.StartNotice.getId());
				if(rec==null){
					rec = new GcpRec();
					rec.setProjFlow(projFlow);
					rec.setGcpStageId(proj.getProjStageId());
					rec.setGcpStageName(proj.getProjStageName());
					rec.setRecTypeId(GcpRecTypeEnum.StartNotice.getId());
					rec.setRecTypeName(GcpRecTypeEnum.StartNotice.getName());
					Document dom = DocumentHelper.createDocument();
					dom.addElement("startNotice");
					rec.setRecContent(dom.asXML());
				}
				Document dom = DocumentHelper.parseText(rec.getRecContent());
				if(dom!=null){
					Element root = dom.getRootElement();
					String saveType = form.getSaveType();
					if("meeting".equals(saveType)){//会议信息
						Element meetingEl = root.element("meeting");
						if(meetingEl==null){
							meetingEl = root.addElement("meeting");
						}
						Element dateEl  = meetingEl.element("date");
						if(dateEl==null){
							dateEl = meetingEl.addElement("date");
						}
						dateEl.setText(StringUtil.defaultIfEmpty(form.getDate(), ""));
						Element addressEl  = meetingEl.element("address");
						if(addressEl==null){
							addressEl = meetingEl.addElement("address");
						}
						addressEl.setText(StringUtil.defaultIfEmpty(form.getAddress(), ""));
						Element compereEl  = meetingEl.element("compere");
						if(compereEl==null){
							compereEl = meetingEl.addElement("compere");
						}
						compereEl.setText(StringUtil.defaultIfEmpty(form.getCompere(), ""));
						Element userEl  = meetingEl.element("user");
						if(userEl==null){
							userEl = meetingEl.addElement("user");
						}
						userEl.setText(StringUtil.defaultIfEmpty(form.getUser(), ""));
						Element introEl  = meetingEl.element("intro");
						if(introEl==null){
							introEl = meetingEl.addElement("intro");
						}
						introEl.setText(StringUtil.defaultIfEmpty(form.getIntro(), ""));
					}else if("notice".equals(saveType)){//启动通知
						Element noticeEl = root.element("notice");
						if(noticeEl==null){
							noticeEl = root.addElement("notice");
						}
						Element periodEl  = noticeEl.element("period");
						if(periodEl==null){
							periodEl = noticeEl.addElement("period");
						}
						periodEl.setText(StringUtil.defaultIfEmpty(form.getPeriod(), ""));
						Element scopeEl  = noticeEl.element("scope");
						if(scopeEl==null){
							scopeEl = noticeEl.addElement("scope");
						}
						scopeEl.setText(StringUtil.defaultIfEmpty(form.getScope(), ""));
						Element rcEl  = noticeEl.element("researchCount");
						if(rcEl==null){
							rcEl = noticeEl.addElement("researchCount");
						}
						rcEl.setText(StringUtil.defaultIfEmpty(form.getResearchCount(), ""));
						Element nDateEl  = noticeEl.element("noticeDate");
						if(nDateEl==null){
							nDateEl = noticeEl.addElement("noticeDate");
						}
						nDateEl.setText(StringUtil.defaultIfEmpty(form.getNoticeDate(), ""));
						Element goSignEl  = noticeEl.element("goSign");
						if(goSignEl==null){
							goSignEl = noticeEl.addElement("goSign");
						}
						goSignEl.setText(StringUtil.defaultIfEmpty(form.getGoSign(), ""));
					}else if("file".equals(saveType)){//会议文件
						Element filesEl = root.element("files");
						if(filesEl==null){
							filesEl = root.addElement("files");
						}
						List<GcpMeetingFileForm> files = form.getFiles();
						if(files!=null&&!files.isEmpty()){
							for (GcpMeetingFileForm mForm : files) {
								MultipartFile file = mForm.getFile();
								String fileName = mForm.getFileName();
								String id = mForm.getId();
								PubFile pubFile = new PubFile();
								pubFile.setFileFlow(mForm.getFileFlow());
								if(file!=null&&file.getSize()>0){
									pubFile.setFileName(fileName);
									if(file.getSize()>0){
										String originalFilename = file.getOriginalFilename();
										String suffix = originalFilename.substring(originalFilename.lastIndexOf(".")+1);
										pubFile.setFileContent(file.getBytes());
										pubFile.setFileSuffix(suffix);
									}
									this.fileBiz.editFile(pubFile);
								}
								if(StringUtil.isNotBlank(id)){//修改
									Element fileEl = (Element) dom.selectSingleNode("//file[@id='"+id+"']");
									fileEl.element("fileFlow").setText(pubFile.getFileFlow());
									fileEl.element("fileName").setText(fileName);
								}else{//新增
									Element fileEl = filesEl.addElement("file").addAttribute("id", PkUtil.getUUID());
									fileEl.addElement("fileFlow").setText(pubFile.getFileFlow());
									fileEl.addElement("fileName").setText(fileName);
								}
								
							}
						}
					}
					rec.setRecContent(dom.asXML());
				}
				return this.edit(rec);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@SuppressWarnings("unchecked")
	@Override
	public GcpMeetingForm searchMeeting(String projFlow) throws Exception {
		GcpMeetingForm form = null;
		if(StringUtil.isNotBlank(projFlow)){
			GcpRec rec = this.searchOne(projFlow, GcpRecTypeEnum.StartNotice.getId());
			if(rec!=null&&StringUtil.isNotBlank(rec.getRecContent())){
				Document dom = DocumentHelper.parseText(rec.getRecContent());
				if(dom!=null){
					form = new GcpMeetingForm();
					Element meetingEl = (Element) dom.selectSingleNode("//meeting");
					if(meetingEl!=null){
						Element dateEl = meetingEl.element("date");
						form.setDate(dateEl==null?"":dateEl.getTextTrim());
						Element addressEl = meetingEl.element("address");
						form.setAddress(addressEl==null?"":addressEl.getTextTrim());
						Element compereEl = meetingEl.element("compere");
						form.setCompere(compereEl==null?"":compereEl.getTextTrim());
						Element userEl = meetingEl.element("user");
						form.setUser(userEl==null?"":userEl.getTextTrim());
						Element introEl = meetingEl.element("intro");
						form.setIntro(introEl==null?"":introEl.getTextTrim());
					}
					Element noticeEl = (Element) dom.selectSingleNode("//notice");
					if(noticeEl!=null){
						Element periodEl = noticeEl.element("period");
						form.setPeriod(periodEl==null?"":periodEl.getTextTrim());
						Element scopeEl = noticeEl.element("scope");
						form.setScope(scopeEl==null?"":scopeEl.getTextTrim());
						Element rcEl = noticeEl.element("researchCount");
						form.setResearchCount(rcEl==null?"":rcEl.getTextTrim());
						Element nDateEl = noticeEl.element("noticeDate");
						form.setNoticeDate(nDateEl==null?"":nDateEl.getTextTrim());
						Element goSignEl = noticeEl.element("goSign");
						form.setGoSign(goSignEl==null?"":goSignEl.getTextTrim());
					}
					List<Element> fileEls = dom.selectNodes("//file");
					if(fileEls!=null&&!fileEls.isEmpty()){
						List<GcpMeetingFileForm> files = new ArrayList<GcpMeetingFileForm>();
						GcpMeetingFileForm fileForm = null;
						for (Element fe : fileEls) {
							fileForm = new GcpMeetingFileForm();
							fileForm.setId(fe.attributeValue("id"));
							fileForm.setFileFlow(fe.elementTextTrim("fileFlow"));
							fileForm.setFileName(fe.elementTextTrim("fileName"));
							files.add(fileForm);
						}
						form.setFiles(files);
					}
				}
			}
		}
		return form;
	}

	@Override
	public Map<String, String> filterProjUser(String projFlow) {
		Map<String, String> userMap = null;
		if(StringUtil.isNotBlank(projFlow)){
			PubProjUserExt userExt = new PubProjUserExt();
			userExt.setProjFlow(projFlow);
			userExt.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<PubProjUserExt> userList = this.pubProjUserBiz.queryExtList(userExt);
			SysRole role = new SysRole();
			role.setWsId(GlobalConstant.GCP_WS_ID);
			role.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<SysRole> roleList = this.roleBiz.search(role);
			if(userList!=null&&roleList!=null){
				userMap = new HashMap<String, String>();
				for (SysRole sysRole : roleList) {
					String roleName = sysRole.getRoleName();
					for (PubProjUserExt user : userList) {
						if(user.getRoleFlow().equals(sysRole.getRoleFlow())){
							StringBuilder sb = new StringBuilder(StringUtil.defaultIfEmpty(userMap.get(roleName),""));
							sb = sb.append(user.getUser().getUserName()).append("、");
							String value = sb.toString();
							userMap.put(roleName, value);
						}
					}
					String tempValue = userMap.get(roleName);
					if(StringUtil.isNotBlank(tempValue)){
						userMap.put(roleName, tempValue.substring(0, tempValue.length()-1));
					}
				}
			}
		}
		return userMap;
	}

	@Override
	public void delMeetingFiles(List<String> ids, String projFlow)
			throws Exception {
		if(StringUtil.isNotBlank(projFlow)&&ids!=null&&!ids.isEmpty()){
			GcpRec rec = this.searchOne(projFlow, GcpRecTypeEnum.StartNotice.getId());
			if(rec!=null&&StringUtil.isNotBlank(rec.getRecContent())){
				Document dom = DocumentHelper.parseText(rec.getRecContent());
				if(dom!=null){
					for (String id : ids) {
						Element idEl = (Element) dom.selectSingleNode("//file[@id='"+id+"']");
						if(idEl!=null){
							idEl.getParent().remove(idEl);
						}
					}
					rec.setRecContent(dom.asXML());
					this.edit(rec);
				}
			}
		}
	}

	@Override
	public int saveProvFiling(GcpProvFilingForm form) throws Exception {
		if(form!=null){
			String projFlow = form.getProjFlow();
			PubProj proj = this.pubProjBiz.readProject(projFlow);
			if(proj!=null){
				GcpRec rec = this.searchOne(projFlow, GcpRecTypeEnum.ProvinceFiling.getId());
				if(rec==null){//第一次添加
					rec = new GcpRec();
					rec.setProjFlow(projFlow);
					rec.setGcpStageId(proj.getProjStageId());
					rec.setGcpStageName(proj.getProjStageName());
					rec.setRecTypeId(GcpRecTypeEnum.ProvinceFiling.getId());
					rec.setRecTypeName(GcpRecTypeEnum.ProvinceFiling.getName());
					Document dom = DocumentHelper.createDocument();
					Element root = dom.addElement("provinceFiling");
					root.addElement("opinion").setText(StringUtil.defaultIfEmpty(form.getOpinion(), ""));
					root.addElement("date").setText(StringUtil.defaultIfEmpty(form.getDate(), ""));
					rec.setRecContent(dom.asXML());
					return this.edit(rec);
				}
				/*修改*/
				Document dom = DocumentHelper.parseText(rec.getRecContent());
				if(dom!=null){
					Element root = dom.getRootElement();
					root.element("opinion").setText(StringUtil.defaultIfEmpty(form.getOpinion(), ""));
					root.element("date").setText(StringUtil.defaultIfEmpty(form.getDate(), ""));
					rec.setRecContent(dom.asXML());
					return this.edit(rec);
				}
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public GcpProvFilingForm searchProvFiling(String projFlow) throws Exception {
		GcpProvFilingForm pfForm = null;
		if(StringUtil.isNotBlank(projFlow)){
			GcpRec rec = this.searchOne(projFlow, GcpRecTypeEnum.ProvinceFiling.getId());
			if(rec!=null){
				Document dom = DocumentHelper.parseText(rec.getRecContent());
				if(dom!=null){
					pfForm = new GcpProvFilingForm();
					Element root = dom.getRootElement();
					pfForm.setOpinion(root.elementText("opinion"));
					pfForm.setDate(root.elementText("date"));
				}
			}
		}
		return pfForm;
	}

	@Override
	public GcpSumStampForm searchSumStamp(String projFlow) throws Exception {
		GcpSumStampForm ssForm = null;
		if(StringUtil.isNotBlank(projFlow)){
			GcpRec rec = this.searchOne(projFlow, GcpRecTypeEnum.SummaryStamp.getId());
			if(rec!=null){
				Document dom = DocumentHelper.parseText(rec.getRecContent());
				if(dom!=null){
					ssForm = new GcpSumStampForm();
					Element root = dom.getRootElement();
					ssForm.setAdminSign(root.elementText("adminSign"));
					ssForm.setDate(root.elementText("date"));
					ssForm.setDirSign(root.elementText("dirSign"));
					ssForm.setOrgConfirm(root.elementText("orgConfirm"));
					ssForm.setResConfirm(root.elementText("resConfirm"));
					ssForm.setResSign(root.elementText("resSign"));
				}
			}
		}
		return ssForm;
	}

	@Override
	public int saveSumStamp(GcpSumStampForm form) throws Exception {
		if(form!=null){
			String projFlow = form.getProjFlow();
			PubProj proj = this.pubProjBiz.readProject(projFlow);
			if(proj!=null){
				GcpRec rec = this.searchOne(projFlow, GcpRecTypeEnum.SummaryStamp.getId());
				if(rec==null){//第一次添加
					rec = new GcpRec();
					rec.setProjFlow(projFlow);
					rec.setGcpStageId(proj.getProjStageId());
					rec.setGcpStageName(proj.getProjStageName());
					rec.setRecTypeId(GcpRecTypeEnum.SummaryStamp.getId());
					rec.setRecTypeName(GcpRecTypeEnum.SummaryStamp.getName());
					Document dom = DocumentHelper.createDocument();
					Element root = dom.addElement("summaryStamp");
					root.addElement("resConfirm").setText(StringUtil.defaultIfEmpty(form.getResConfirm(), ""));
					root.addElement("resSign").setText(StringUtil.defaultIfEmpty(form.getResSign(), ""));
					root.addElement("orgConfirm").setText(StringUtil.defaultIfEmpty(form.getOrgConfirm(), ""));
					root.addElement("adminSign").setText(StringUtil.defaultIfEmpty(form.getAdminSign(), ""));
					root.addElement("dirSign").setText(StringUtil.defaultIfEmpty(form.getDirSign(), ""));
					root.addElement("date").setText(StringUtil.defaultIfEmpty(form.getDate(), ""));
					rec.setRecContent(dom.asXML());
					return this.edit(rec);
				}
				/*修改*/
				Document dom = DocumentHelper.parseText(rec.getRecContent());
				if(dom!=null){
					Element root = dom.getRootElement();
					root.element("resConfirm").setText(StringUtil.defaultIfEmpty(form.getResConfirm(), ""));
					root.element("resSign").setText(StringUtil.defaultIfEmpty(form.getResSign(), ""));
					root.element("orgConfirm").setText(StringUtil.defaultIfEmpty(form.getOrgConfirm(), ""));
					root.element("adminSign").setText(StringUtil.defaultIfEmpty(form.getAdminSign(), ""));
					root.element("dirSign").setText(StringUtil.defaultIfEmpty(form.getDirSign(), ""));
					root.element("date").setText(StringUtil.defaultIfEmpty(form.getDate(), ""));
					rec.setRecContent(dom.asXML());
					return this.edit(rec);
				}
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public GcpFinishWorkForm searchFinishWork(String projFlow) throws Exception {
		GcpFinishWorkForm fwForm = null; 
		if(StringUtil.isNotBlank(projFlow)){
			GcpRec rec = this.searchOne(projFlow, GcpRecTypeEnum.FinishWork.getId());
			if(rec!=null){
				Document dom = DocumentHelper.parseText(rec.getRecContent());
				if(dom!=null){
					fwForm = new GcpFinishWorkForm();
					Element root = dom.getRootElement();
					fwForm.setAnswerDate(root.elementText("answerDate"));
					fwForm.setAppNumber(root.elementText("appNumber"));
					fwForm.setCleanDate(root.elementText("cleanDate"));
					fwForm.setCopiesDate(root.elementText("copiesDate"));
					fwForm.setDbLockDate(root.elementText("dbLockDate"));
					fwForm.setProjLockDate(root.elementText("projLockDate"));
					fwForm.setRegNumber(root.elementText("regNumber"));
					fwForm.setReplyDate(root.elementText("replyDate"));
				}
			}
		}
		return fwForm;
	}

	@Override
	public int saveFinishWork(GcpFinishWorkForm form) throws Exception {
		if(form!=null){
			String projFlow = form.getProjFlow();
			PubProj proj = this.pubProjBiz.readProject(projFlow);
			if(proj!=null){
				//修改项目阶段
				String projStageId = form.getProjStageId();
				if (StringUtil.isNotBlank(projStageId) && !projStageId.equals(proj.getProjStageId())) {
					proj.setProjStageId(projStageId);
					proj.setProjStageName(GcpProjStageEnum.getNameById(projStageId));
					this.pubProjBiz.modProject(proj);
				}
				GcpRec rec = this.searchOne(projFlow, GcpRecTypeEnum.FinishWork.getId());
				if(rec==null){//第一次添加
					rec = new GcpRec();
					rec.setProjFlow(projFlow);
					rec.setGcpStageId(proj.getProjStageId());
					rec.setGcpStageName(proj.getProjStageName());
					rec.setRecTypeId(GcpRecTypeEnum.FinishWork.getId());
					rec.setRecTypeName(GcpRecTypeEnum.FinishWork.getName());
					Document dom = DocumentHelper.createDocument();
					Element root = dom.addElement("finishWork");
					root.addElement("dbLockDate").setText(StringUtil.defaultIfEmpty(form.getDbLockDate(), ""));
					root.addElement("cleanDate").setText(StringUtil.defaultIfEmpty(form.getCleanDate(), ""));
					root.addElement("projLockDate").setText(StringUtil.defaultIfEmpty(form.getProjLockDate(), ""));
					root.addElement("replyDate").setText(StringUtil.defaultIfEmpty(form.getReplyDate(), ""));
					root.addElement("answerDate").setText(StringUtil.defaultIfEmpty(form.getAnswerDate(), ""));
					root.addElement("regNumber").setText(StringUtil.defaultIfEmpty(form.getRegNumber(), ""));
					root.addElement("appNumber").setText(StringUtil.defaultIfEmpty(form.getAppNumber(), ""));
					root.addElement("copiesDate").setText(StringUtil.defaultIfEmpty(form.getCopiesDate(), ""));
					rec.setRecContent(dom.asXML());
					return this.edit(rec);
				}
				/*修改*/
				Document dom = DocumentHelper.parseText(rec.getRecContent());
				if(dom!=null){
					Element root = dom.getRootElement();
					root.element("dbLockDate").setText(StringUtil.defaultIfEmpty(form.getDbLockDate(), ""));
					root.element("cleanDate").setText(StringUtil.defaultIfEmpty(form.getCleanDate(), ""));
					root.element("projLockDate").setText(StringUtil.defaultIfEmpty(form.getProjLockDate(), ""));
					root.element("replyDate").setText(StringUtil.defaultIfEmpty(form.getReplyDate(), ""));
					root.element("answerDate").setText(StringUtil.defaultIfEmpty(form.getAnswerDate(), ""));
					root.element("regNumber").setText(StringUtil.defaultIfEmpty(form.getRegNumber(), ""));
					root.element("appNumber").setText(StringUtil.defaultIfEmpty(form.getAppNumber(), ""));
					root.element("copiesDate").setText(StringUtil.defaultIfEmpty(form.getCopiesDate(), ""));
					rec.setRecContent(dom.asXML());
					return this.edit(rec);
				}
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<GcpRec> searchGcpRecListWithBLOBs(List<String> projFlowList) {
		if(projFlowList != null && !projFlowList.isEmpty()){
			GcpRecExample example = new GcpRecExample();
			example.createCriteria().andProjFlowIn(projFlowList).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			return gcpRecMapper.selectByExampleWithBLOBs(example);
		} 
		return null;
	}

	@Override
	public Map<String, String> searchStartMeetingDate(List<GcpRec> gcpRecList) throws Exception {
		if(gcpRecList != null && !gcpRecList.isEmpty()){
			Map<String,String> startMeetingDateMap = new HashMap<String, String>();
			for(GcpRec rec : gcpRecList){
				String recContent = rec.getRecContent();
				if(StringUtil.isNotBlank(recContent)){
					Document dom = DocumentHelper.parseText(recContent);
					if(dom != null){
						Element dateElement = (Element) dom.selectSingleNode("//date");
						if(dateElement != null){
							String date = dateElement.getTextTrim();
							startMeetingDateMap.put(rec.getProjFlow(), date);
						}
					}
				}
			}
			return startMeetingDateMap;
		}
		return null;
	}


}
