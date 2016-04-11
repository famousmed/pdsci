package com.pinde.sci.ctrl.sample;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.PushbackInputStream;
import java.io.StringReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.POIXMLDocument;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.jspform.Item;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.SpringUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.edc.IProjUserBiz;
import com.pinde.sci.biz.irb.IIrbApplyBiz;
import com.pinde.sci.biz.irb.IIrbCommitteeBiz;
import com.pinde.sci.biz.irb.IIrbRecBiz;
import com.pinde.sci.biz.irb.impl.IrbSecretaryBizImpl;
import com.pinde.sci.biz.pub.impl.PubResumeBizImpl;
import com.pinde.sci.biz.sample.ISampleBiz;
import com.pinde.sci.biz.security.PasswordHelper;
import com.pinde.sci.biz.srm.IThesisBiz;
import com.pinde.sci.biz.srm.impl.ThesisBizImpl;
import com.pinde.sci.biz.sys.IDictBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.common.util.JspFormUtil;
import com.pinde.sci.dao.base.IrbApplyMapper;
import com.pinde.sci.dao.base.IrbMeetingMapper;
import com.pinde.sci.dao.base.IrbMeetingUserMapper;
import com.pinde.sci.dao.base.IrbRecMapper;
import com.pinde.sci.dao.base.IrbUserMapper;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.dao.base.SrmAchBookAuthorMapper;
import com.pinde.sci.dao.base.SrmAchBookMapper;
import com.pinde.sci.dao.base.SrmAchPatentAuthorMapper;
import com.pinde.sci.dao.base.SrmAchPatentMapper;
import com.pinde.sci.dao.base.SrmAchSatAuthorMapper;
import com.pinde.sci.dao.base.SrmAchSatMapper;
import com.pinde.sci.dao.base.SrmAchThesisAuthorMapper;
import com.pinde.sci.dao.base.SrmAchThesisMapper;
import com.pinde.sci.dao.base.SysDeptMapper;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.dao.pub.PubProjExtMapper;
import com.pinde.sci.enums.edc.EdcRandomAssignStatusEnum;
import com.pinde.sci.enums.gcp.GcpDrugStoreStatusEnum;
import com.pinde.sci.enums.gcp.GcpProjSubTypeEnum;
import com.pinde.sci.enums.irb.IrbAuthTypeEnum;
import com.pinde.sci.enums.irb.IrbDecisionEnum;
import com.pinde.sci.enums.irb.IrbRecTypeEnum;
import com.pinde.sci.enums.irb.IrbReviewTypeEnum;
import com.pinde.sci.enums.irb.IrbStageEnum;
import com.pinde.sci.enums.irb.IrbTypeEnum;
import com.pinde.sci.enums.pub.ProjCategroyEnum;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.enums.srm.AchStatusEnum;
import com.pinde.sci.form.irb.IrbApplyFileForm;
import com.pinde.sci.form.irb.IrbArchiveForm;
import com.pinde.sci.form.irb.IrbDecisionDetailForm;
import com.pinde.sci.form.irb.IrbMinutesForm;
import com.pinde.sci.form.irb.IrbVoteForm;
import com.pinde.sci.form.pub.AcademicResumeForm;
import com.pinde.sci.form.pub.EduResumeForm;
import com.pinde.sci.form.pub.WorkResumeForm;
import com.pinde.sci.model.irb.IrbSingleForm;
import com.pinde.sci.model.irb.ProjInfoForm;
import com.pinde.sci.model.mo.EdcRandomRec;
import com.pinde.sci.model.mo.GcpDrugStoreRec;
import com.pinde.sci.model.mo.IrbApply;
import com.pinde.sci.model.mo.IrbApplyExample;
import com.pinde.sci.model.mo.IrbInfo;
import com.pinde.sci.model.mo.IrbMeeting;
import com.pinde.sci.model.mo.IrbMeetingExample;
import com.pinde.sci.model.mo.IrbMeetingUser;
import com.pinde.sci.model.mo.IrbProcess;
import com.pinde.sci.model.mo.IrbRec;
import com.pinde.sci.model.mo.IrbUser;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubFileForm;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjExample;
import com.pinde.sci.model.mo.PubProjOrg;
import com.pinde.sci.model.mo.PubProjUser;
import com.pinde.sci.model.mo.SrmAchBook;
import com.pinde.sci.model.mo.SrmAchBookAuthor;
import com.pinde.sci.model.mo.SrmAchPatent;
import com.pinde.sci.model.mo.SrmAchPatentAuthor;
import com.pinde.sci.model.mo.SrmAchSat;
import com.pinde.sci.model.mo.SrmAchSatAuthor;
import com.pinde.sci.model.mo.SrmAchThesis;
import com.pinde.sci.model.mo.SrmAchThesisAuthor;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysDeptExample;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserExample;
import com.sun.xml.internal.messaging.saaj.util.ByteInputStream;

@Controller  
@RequestMapping("/makeup")
public class MakeupController extends GeneralController{

	private static final Logger log = LoggerFactory.getLogger(MakeupController.class); 
	
	@Autowired
	private ISampleBiz jobBiz; 
	@Autowired
	private PubProjMapper projMapper; 
	@Autowired
	private SysDeptMapper deptMapper;
	@Autowired
	private SysUserMapper userMapper;
	@Autowired
	private IProjUserBiz pjUserBiz;
	@Autowired
	private IProjOrgBiz projOrgBiz;
	@Autowired
	private IrbMeetingMapper meetingMapper;
	@Autowired
	private IrbMeetingUserMapper meetingUserMapper;
	@Autowired
	private IrbUserMapper irbUserMapper;
	@Autowired
	private IrbApplyMapper irbMapper;
	@Autowired
	private IIrbRecBiz irbRecBiz;
	@Autowired
	private IrbRecMapper recMapper;
	@Autowired
	private IIrbApplyBiz irbApplyBiz;
	@Autowired
	private IIrbCommitteeBiz committeeBiz;
	@Autowired
	private IrbSecretaryBizImpl secretaryBiz;
	@Autowired
	private SrmAchThesisMapper thesisMapper;
	@Autowired
	private SrmAchThesisAuthorMapper thesisAuthorMapper;
	@Autowired
	private SrmAchBookMapper bookMapper;
	@Autowired
	private SrmAchBookAuthorMapper bookAuthorMapper;
	@Autowired
	private SrmAchPatentMapper patentMapper;
	@Autowired
	private SrmAchPatentAuthorMapper patentAuthorMapper;
	@Autowired
	private SrmAchSatMapper satMapper;
	@Autowired
	private SrmAchSatAuthorMapper satAuthorMapper;
	
	@RequestMapping("/upload")
	public  String  makeup(PubFileForm fileForm) {
		String fileName =  fileForm.getFile().getOriginalFilename();
		String suffix =fileName.substring(fileName.lastIndexOf(".")+1);  
		PubFile file  = new PubFile();
		file.setFileFlow(PkUtil.getUUID());
		file.setFileSuffix(suffix);
		try {
			InputStream is = fileForm.getFile().getInputStream();
			  byte[] fileData = new byte[(int) fileForm.getFile().getSize()];  
			    is.read(fileData);  
			    file.setFileName(fileName);
			    file.setFileContent(fileData);
				try {
					 Workbook wb =  createCommonWorkbook(new ByteInputStream(fileData,(int) fileForm.getFile().getSize() ));
					 parseExcel(wb);
				} catch (Exception e) {
					e.printStackTrace();
				}
			    is.close();
		} catch (IOException e) {
			e.printStackTrace();
		}  
		return "sample/makeup";
	}
	public static Workbook createCommonWorkbook(InputStream inp) throws IOException, InvalidFormatException { 
		// 首先判断流是否支持mark和reset方法，最后两个if分支中的方法才能支持 
		if (!inp.markSupported()) { 
			// 还原流信息 
			inp = new PushbackInputStream(inp); 
		} 
		// EXCEL2003使用的是微软的文件系统 
		if (POIFSFileSystem.hasPOIFSHeader(inp)) { 
			return new HSSFWorkbook(inp); 
		} 
		// EXCEL2007使用的是OOM文件格式 
		if (POIXMLDocument.hasOOXMLHeader(inp)) { 
			// 可以直接传流参数，但是推荐使用OPCPackage容器打开 
			return new XSSFWorkbook(OPCPackage.open(inp)); 
		} 
		throw new IOException("不能解析的excel版本"); 
	} 
	
	private void parseExcel(Workbook wb) throws IOException, DocumentException {
        // first sheet
		int sheetNum = wb.getNumberOfSheets();
		if(sheetNum>0){
			List<String> colnames = new ArrayList<String>();
			Sheet sheet;
			try {
				sheet = (HSSFSheet) wb.getSheetAt(0);
			} catch (Exception e) {
				sheet = (XSSFSheet)wb.getSheetAt(0);
			}
			 int row_num = sheet.getLastRowNum();  
             for (int i = 0; i <= row_num; i++) {  
                Row r =  sheet.getRow(i);  
                int cell_num = r.getLastCellNum();  
                if (i == 0) {
                	for (int j = 0; j < cell_num; j++) {  
                		 String value = "";
						 if(r.getCell((short)j).getCellType() == 1){  
							 value = r.getCell((short) j).getStringCellValue();  
						 } 
						colnames.add(value);
					}
                }else {
                	PubProj proj = new PubProj();
                	ProjInfoForm form = new ProjInfoForm();
                	proj.setProjFlow(PkUtil.getUUID());
					boolean flag = false;
					 for (int j = 0; j < cell_num; j++) {  
						 String value = "";
						 if(r.getCell((short)j).getCellType() == 1){  
							 value = r.getCell((short) j).getStringCellValue();  
						 }else{  
							 value = _doubleTrans(r.getCell((short) j).getNumericCellValue());  
						 } 
						if ("项目全称".equals(colnames.get(j))) {
							if (value == null
									|| value.trim()
											.length() == 0) {
								flag = true;
								break;
							}
							proj.setProjName(value);
						} else if ("项目简称".equals(colnames.get(j))) {
							if (value == null
									|| value.trim()
											.length() == 0) {
								flag = true;
								break;
							}
							proj.setProjShortName(value);
						} else if ("期类别".equals(colnames.get(j))) {
							conversionProjSubType(proj,value); 
							conversionProjCategory(proj);
						} else if ("项目类别".equals(colnames.get(j))) {
							conversionProjType(proj,value);
						} else if ("注册分类".equals(colnames.get(j))) {
							form.setRegistCategory(value);
						} else if ("CFDA".equals(colnames.get(j))) {
							proj.setCfdaNo(value);
						} else if ("组长参加".equals(colnames.get(j))) {
							form.setIsLeader(conversionIsLearder(value));
						} else if ("项目来源全称".equals(colnames.get(j))) {
							proj.setProjDeclarer(value);
						} else if ("项目来源简称".equals(colnames.get(j))) {
							proj.setProjShortDeclarer(value);
						} else if ("联系人".equals(colnames.get(j))) {
							form.setdLinkMan(value);
						} else if ("联系人手机".equals(colnames.get(j))) {
							form.setdLinkManPhone(value);
						} else if ("联系人邮件".equals(colnames.get(j))) {
							form.setdLinkManEmail(value);
						} else if ("CRO".equals(colnames.get(j))) {
							form.setCROName(value);
						}else if ("CRO联系人".equals(colnames.get(j))) {
							form.setCROLinkMan(value);
						}else if ("CRO手机".equals(colnames.get(j))) {
							form.setCROLinkManPhone(value);
						}else if ("CRO邮件".equals(colnames.get(j))) {
							form.setCROLinkManEmail(value);
						}else if ("承担科室".equals(colnames.get(j))) {
							proj.setApplyDeptFlow(_getDeptFlowByName(value));
							proj.setApplyDeptName(value);
						}else if ("科主任".equals(colnames.get(j))) {
							form.setDirector(value);
						}else if ("主要研究者".equals(colnames.get(j))) {
							SysUser user = _getSysUserByName(value);
							if(user != null){
								proj.setApplyUserFlow(_getSysUserByName(value).getUserFlow());
								proj.setApplyUserName(value);
								proj.setApplyOrgFlow(user.getOrgFlow());
								proj.setApplyOrgName(user.getOrgName());
								
								//新增主要研究者
								String roleFlow = InitConfig.getSysCfg("researcher_role_flow");
								String userName = user.getUserName();
								//保存至pub_proj_user表
								PubProjUser projUser = new PubProjUser();
								projUser.setRecordFlow(PkUtil.getUUID());
								projUser.setProjFlow(proj.getProjFlow());
								projUser.setOrgFlow(user.getOrgFlow());
								projUser.setRoleFlow(roleFlow);
								projUser.setUserFlow(user.getUserFlow());
								projUser.setAuthUserFlow(GlobalContext.getCurrentUser().getUserFlow());
								projUser.setAuthTime(DateUtil.getCurrDateTime());
								GeneralMethod.setRecordInfo(proj, true);
								pjUserBiz.add(projUser);
							}else {
								proj.setApplyUserName(value);
							}
						}else if ("临床研究单位".equals(colnames.get(j))) {
							if(StringUtil.isNotBlank(value)){
								String[] orgs = StringUtil.split(value, ",");
								for(String projOrg: orgs){
									String[] orgStr = StringUtil.split(projOrg, "_");
									if(orgStr != null &&orgStr.length==2){
										String orgName = orgStr[0];
										String orgRole = orgStr[1];
										PubProjOrg pjorg = new PubProjOrg();
										pjorg.setProjFlow(proj.getProjFlow());
										pjorg.setOrgName(orgName);
										if("1".equals(orgRole)){
											pjorg.setOrgTypeId("1");
										}else if("2".equals(orgRole)){
											pjorg.setOrgTypeId("2");
										}
										projOrgBiz.addProjOrg(pjorg);
									}
								}
							}
						}else if ("组长主要研究者".equals(colnames.get(j))) {
							form.setLeaderOrgLinkMan(value);
						}else if ("组长联系电话".equals(colnames.get(j))) {
							form.setLeaderOrgLinkManPhone(value);
						}else if ("组长邮件".equals(colnames.get(j))) {
							form.setLeaderOrgLinkManEmail(value);
						}else if ("组长伦理联系人".equals(colnames.get(j))) {
							form.setLeaderOrgIrbLinkMan(value);
						}else if ("组长伦理联系电话".equals(colnames.get(j))) {
							form.setLeaderOrgIrbLinkManPhone(value);
						}else if ("组长伦理邮件".equals(colnames.get(j))) {
							form.setLeaderOrgIrbLinkManEmail(value);
						}
					}
					if (flag) {
						break;
					}
					String content = _addProjInfo(proj.getProjInfo(), form);
					proj.setProjInfo(content);
					GeneralMethod.setRecordInfo(proj, true);
					projMapper.insert(proj);
                }	  
            }
		}
		if(sheetNum>1){
			List<String> colnames = new ArrayList<String>();
			Sheet sheet;
			try {
				sheet = (HSSFSheet) wb.getSheetAt(1);
			} catch (Exception e) {
				sheet = (XSSFSheet)wb.getSheetAt(1);
			}
			 int row_num = sheet.getLastRowNum();  
             for (int i = 0; i <= row_num; i++) {  
                Row r =  sheet.getRow(i);  
                int cell_num = r.getLastCellNum();  
                if (i == 0) {
                	for (int j = 0; j < cell_num; j++) {  
                		 String value = "";
						 if(r.getCell((short)j).getCellType() == 1){  
							 value = r.getCell((short) j).getStringCellValue();  
						 }
						colnames.add(value);
					}
                }else {
                	IrbApply irb = new IrbApply();
                	irb.setIrbFlow(PkUtil.getUUID());
					boolean flag = false;
					 for (int j = 0; j < cell_num; j++) {  
						 String value = "";
						 if(r.getCell((short)j).getCellType() == 1){  
							 value = r.getCell((short) j).getStringCellValue();  
						 }else{  
							 value = _doubleTrans(r.getCell((short) j).getNumericCellValue());  
						 } 
						if ("项目名称".equals(colnames.get(j))) {
							PubProj proj = _getProjByName(value);
							log.info("=====zj======"+value+"======="+proj);
							if(proj==null || StringUtil.isBlank(proj.getProjFlow())){ 
								break;
							}
							irb.setProjFlow(proj.getProjFlow());
							irb.setProjName(proj.getProjName());
							irb.setProjShortName(proj.getProjShortName());
							irb.setProjDeclarer(proj.getProjDeclarer());
							irb.setProjShortDeclarer(proj.getProjShortDeclarer());
							irb.setProjSubTypeId(proj.getProjSubTypeId());
							irb.setProjSubTypeName(proj.getProjSubTypeName());
						} else if ("审查类别".equals(colnames.get(j))) {
							irb.setIrbTypeId(_getIrbTypeByName(value));
							irb.setIrbTypeName(IrbTypeEnum.getNameById(irb.getIrbTypeId()));
						} else if ("状态".equals(colnames.get(j))) {
							if("撤销".equals(value)){
								break;
							}
							irb.setIrbStageId(_getIrbStageByName(value));
							irb.setIrbStageName(IrbStageEnum.getNameById(irb.getIrbStageId()));
						} else if ("送审日期".equals(colnames.get(j))) {
							irb.setIrbApplyDate(DateUtil.transDate(value, "yyyy-MM-dd"));
						} else if ("受理日期".equals(colnames.get(j))) {
							irb.setIrbAcceptedDate(DateUtil.transDate(value, "yyyy-MM-dd"));
						}else if ("受理号".equals(colnames.get(j))) {
							irb.setIrbNo(value);
						}else if ("审查方式".equals(colnames.get(j))) {
							if(StringUtil.isNotBlank(value)){
								irb.setReviewWayId(_getReviewWayByName(value));
								irb.setReviewWayName(IrbReviewTypeEnum.getNameById(irb.getReviewWayId()));
							}
						}else if ("伦理委员会".equals(colnames.get(j))) {
							irb.setIrbInfoFlow(value);
						}else if ("主审委员".equals(colnames.get(j))) {
							//
							if(StringUtil.isNotBlank(value)){
								String[] wys = StringUtil.split(value, ",");
								if(wys!=null && wys.length>0){
									for(String wy : wys ){
										if( StringUtil.split(wy, "_").length<2){
											continue;
										}
										String name = StringUtil.split(wy, "_")[0];
										String roleName = StringUtil.split(wy, "_")[1];
										SysUser user = _getSysUserByName(name);
										if(user==null){
											continue;
										}
										IrbUser irbuser = new IrbUser();
										irbuser.setRecordFlow(PkUtil.getUUID());
										irbuser.setProjFlow(irb.getProjFlow());
										irbuser.setIrbFlow(irb.getIrbFlow());
										irbuser.setUserFlow(user.getUserFlow());
										irbuser.setUserName(user.getUserName());
										irbuser.setAuthId(_getAuthId(roleName));
										irbuser.setAuthName(IrbAuthTypeEnum.getNameById(irbuser.getAuthId()));
										GeneralMethod.setRecordInfo(irbuser, true);
										irbUserMapper.insert(irbuser);
									}
								}
							}
						}else if ("送审文件".equals(colnames.get(j))) {
							if(StringUtil.isNotBlank(value)){
								String[] files = StringUtil.split(value, ",");
								Document dom = null;
								Element root = null;
								String content = null;
								
								if(StringUtil.isNotBlank(content)){
									dom = DocumentHelper.parseText(content);
									root = dom.getRootElement();
								}else{
									dom = DocumentHelper.createDocument();
									root = dom.addElement("applyFile");
								}
								IrbRec irbRec = new IrbRec();		//同步更新IRB_REC表的ApplyFile送审文件清单数据
								irbRec.setProjFlow(irb.getProjFlow());
								irbRec.setIrbFlow(irb.getIrbFlow());
								irbRec.setIrbStageId(irb.getIrbStageId());
								irbRec.setIrbStageName(irb.getIrbStageName());
								irbRec.setRecTypeId(IrbRecTypeEnum.ApplyFile.getId());
								irbRec.setRecTypeName(IrbRecTypeEnum.ApplyFile.getName());
								
								if(files!=null && files.length>0){
									for(String fileStr : files){
										if(StringUtil.split(fileStr, "☆").length<5){
											continue;
										}
											String fileName = StringUtil.split(fileStr, "☆")[0];
											String fileUrl = StringUtil.split(fileStr, "☆")[1];
											String version = StringUtil.split(fileStr, "☆")[2];
											String date = StringUtil.split(fileStr, "☆")[3];
											String confirm = StringUtil.split(fileStr, "☆")[4];
										
										Element fileElement = root.addElement("file");
										fileElement.addAttribute("id", PkUtil.getUUID());
										if(StringUtil.isNotBlank(fileUrl)){ 
											fileElement.addElement("fileFlow").setText(fileUrl);
										}
										fileElement.addElement("fileName").setText(fileName);
										if(StringUtil.isNotBlank(version)){
											fileElement.addElement("version").setText(version);
										}
										if(StringUtil.isNotBlank(date)){
											fileElement.addElement("versionDate").setText(date);
										}
										if(StringUtil.isNotBlank(confirm) && "1".equals(confirm)){
											fileElement.addAttribute("confirm", "true");
										}
										irbRec.setRecContent(dom.asXML());
										this.irbRecBiz.edit(irbRec);
									}
								}
							}
						}else if ("会议日期".equals(colnames.get(j))) {
							irb.setMeetingDate(value);
							irb.setMeetingFlow(_getMeetingByDate(value));
						}else if ("审查结果".equals(colnames.get(j))) {
							irb.setIrbDecisionId(_getDecisionIdByName(value));
							irb.setIrbDecisionName(value);
						}else if ("决定日期".equals(colnames.get(j))) {
							irb.setIrbDecisionDate(DateUtil.transDate(value, "yyyy-MM-dd"));
						}else if ("批件日期".equals(colnames.get(j))) {
							irb.setApproveDate(DateUtil.transDate(value, "yyyy-MM-dd"));
						}else if ("跟踪审查频率".equals(colnames.get(j))) {
							irb.setTrackFrequency(value);
						}else if ("跟踪审查日期".equals(colnames.get(j))) {
							irb.setTrackDate(DateUtil.transDate(value, "yyyy-MM-dd"));
						}

					}
					if (flag) {
						break;
					}
					GeneralMethod.setRecordInfo(irb, true);
					irbMapper.insert(irb);
                }	  
            }
		}
	}
	 private String _getAuthId(String value) {
		 if("主审委员1".equals(value)){
			 return IrbAuthTypeEnum.CommitteePRO.getId();
		 }else if("主审委员2".equals(value)){
			 return IrbAuthTypeEnum.CommitteeICF.getId();
		 }else if("主审委员".equals(value)){
			 return IrbAuthTypeEnum.Committee.getId();
		 }else if("独立顾问".equals(value)){
			 return IrbAuthTypeEnum.Consultant.getId();
		 }
		return null;

	}
	private String _getDecisionIdByName(String value) {
		 if("同意".equals(value)){
			 return IrbDecisionEnum.Agree.getId();
		 }else if("作必要的修正后同意".equals(value)){
			 return IrbDecisionEnum.AmendmentAgree.getId();
		 }else if("作必要的修正后重审".equals(value)){
			 return IrbDecisionEnum.AmendmentRetrial.getId();
		 }else if("同意结题".equals(value)){
			 return IrbDecisionEnum.AgreeFinish.getId();
		 }
		 return null;
	}
	private String _getDecisionIdById(String value) {
		 if("1".equals(value)){
			 return IrbDecisionEnum.Agree.getId();
		 }else if("2".equals(value)){
			 return IrbDecisionEnum.AmendmentAgree.getId();
		 }else if("3".equals(value)){
			 return IrbDecisionEnum.AmendmentRetrial.getId();
		 }else if("4".equals(value)){
			 return IrbDecisionEnum.Terminate.getId();
		 }
		 return null;
	}
	private String _getMeetingByDate(String value) {
		IrbMeetingExample example = new IrbMeetingExample();
		example.createCriteria().andMeetingDateEqualTo(value);
		List<IrbMeeting> meetingList = meetingMapper.selectByExample(example);
		if(meetingList!=null && meetingList.size()>0){
			return meetingList.get(0).getMeetingFlow();
		}
		return null;
	}
	private String _getReviewWayByName(String value) {
		 if("会议审查".equals(value)){
			 return IrbReviewTypeEnum.Meeting.getId();
		 }else if("快速审查".equals(value)||"处理".equals(value)){
			 return IrbReviewTypeEnum.Fast.getId();
		 }
		return null;
	}
	private String _getIrbStageByName(String value) {
		 if("申请/报告".equals(value)){
			 return IrbStageEnum.Apply.getId();
		 }else if("受理".equals(value)||"处理".equals(value)){
			 return IrbStageEnum.Handle.getId();
		 }else if("审查".equals(value)){
			 return IrbStageEnum.Review.getId();
		 }else if("传达决定".equals(value)){
			 return IrbStageEnum.Decision.getId();
		 }else if("文件存档".equals(value)){
			 return IrbStageEnum.Archive.getId();
		 }
		return null;
	}
	private String _getIrbTypeByName(String value) {
		 if("初始审查申请".equals(value)){
			 return IrbTypeEnum.Init.getId();
		 }else if("复审申请".equals(value)){
			 return IrbTypeEnum.Retrial.getId();
		 }else if("修正案审查申请".equals(value)){
			 return IrbTypeEnum.Revise.getId();
		 }else if("研究进展报告".equals(value)){
			 return IrbTypeEnum.Schedule.getId();
		 }else if("暂停/终止研究报告".equals(value)){
			 return IrbTypeEnum.Terminate.getId();
		 }else if("严重不良事件报告".equals(value)){
			 return IrbTypeEnum.Sae.getId();
		 }else if("违背方案报告".equals(value)){
			 return IrbTypeEnum.Violate.getId();
		 }else if("结题报告".equals(value)){
			 return IrbTypeEnum.Finish.getId();
		 }
		return null;
	}
	private PubProj _getProjByName(String value) {
		 PubProjExample example = new PubProjExample();
		 example.createCriteria().andProjShortNameEqualTo(value);
		 List<PubProj> projList = projMapper.selectByExample(example);
		 if(projList != null && projList.size()>0){
			 return projList.get(0);
		 }
		return null;
	}
	public static String _doubleTrans(double d)
	    {
	        if((double)Math.round(d) - d == 0.0D)
	            return String.valueOf((long)d);
	        else
	            return String.valueOf(d);
	    }
	public SysUser _getSysUserByName(String value) {
		SysUserExample example = new SysUserExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andUserNameEqualTo(value);
		List<SysUser> list = userMapper.selectByExample(example);
		if(list!=null && list.size()>0){
			return list.get(0);
		}
		return null;
	}
	private String _getDeptFlowByName(String value) {
		SysDeptExample example = new SysDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andDeptNameEqualTo(value);
		List<SysDept> list = deptMapper.selectByExample(example);
		if(list!=null && list.size()>0){
			return list.get(0).getDeptFlow();
		}
		return "";
	}
	private void conversionProjType(PubProj proj, String value) {
		if("中药".equals(value)){ 
			proj.setProjTypeId("1");
		}else if("天然药物".equals(value)){
			proj.setProjTypeId("2");
		}else if("化学药物".equals(value)){
			proj.setProjTypeId("3");
		}else if("预防用生物制品".equals(value)){
			proj.setProjTypeId("4");
		}else if("治疗用生物制品".equals(value)){
			proj.setProjTypeId("5");
		}else if("放射性药物".equals(value)){
			proj.setProjTypeId("6");
		}else if("进口药物".equals(value)){
			proj.setProjTypeId("7");
		}else if("医疗器械".equals(value)){
			proj.setProjTypeId("8");
		}else if("其他".equals(value)){
			proj.setProjTypeId("9");
		}
		proj.setProjTypeName(value);
	}
	private void conversionProjSubType(PubProj proj,String value) {
		if("临床科研".equals(value)){
			proj.setProjSubTypeId(GcpProjSubTypeEnum.Ky.getId());
			proj.setProjSubTypeName(GcpProjSubTypeEnum.Ky.getName());
		}else if("医疗器械".equals(value)){
			proj.setProjSubTypeId(GcpProjSubTypeEnum.Qx.getId());
			proj.setProjSubTypeName(GcpProjSubTypeEnum.Qx.getName());
		}else if("其他".equals(value)||"补充临床试验".equals(value)){ 
			proj.setProjSubTypeId(GcpProjSubTypeEnum.Qt.getId());
			proj.setProjSubTypeName(GcpProjSubTypeEnum.Qt.getName());
		}else if("生物等效".equals(value)){
			proj.setProjSubTypeId(GcpProjSubTypeEnum.Ⅰ.getId());
			proj.setProjSubTypeName(GcpProjSubTypeEnum.Ⅰ.getName());
		}else if("Ⅱ期".equals(value)||"Ⅱb期".equals(value)){
			proj.setProjSubTypeId(GcpProjSubTypeEnum.Ⅱ.getId());
			proj.setProjSubTypeName(GcpProjSubTypeEnum.Ⅱ.getName());
		}else if("Ⅲ期".equals(value)){
			proj.setProjSubTypeId(GcpProjSubTypeEnum.Ⅲ.getId());
			proj.setProjSubTypeName(GcpProjSubTypeEnum.Ⅲ.getName());
		}else if("Ⅳ期".equals(value)){
			proj.setProjSubTypeId(GcpProjSubTypeEnum.Ⅳ.getId());
			proj.setProjSubTypeName(GcpProjSubTypeEnum.Ⅳ.getName());
		}
	}
	private void conversionProjCategory(PubProj proj) {
		if(GcpProjSubTypeEnum.Ky.getId().equals(proj.getProjSubTypeId())){ 
			proj.setProjCategoryId(ProjCategroyEnum.Ky.getId());
			proj.setProjCategoryName(ProjCategroyEnum.Ky.getName());
		}else if("医疗器械".equals(proj.getProjSubTypeId())){
			proj.setProjCategoryId(ProjCategroyEnum.Qx.getId());
			proj.setProjCategoryName(ProjCategroyEnum.Qx.getName());
		}else {
			proj.setProjCategoryId(ProjCategroyEnum.Yw.getId());
			proj.setProjCategoryName(ProjCategroyEnum.Yw.getName());
		}
	}
	private String conversionIsLearder(String value) {
		if("组长".equals(value)){ 
			return "1";
		}else if("参加".equals(value)){
			return "2";
		} 
		return "2";
	}
	private String _addProjInfo(String content,ProjInfoForm projInfo) {
		if(StringUtil.isBlank(content)){ 
			content = "<projInfo/>";
		} 
		Document doc = null;
		try {
			doc = DocumentHelper.parseText(content);
			//****************一般信息****************
			Node generalInfoNode = doc.selectSingleNode("projInfo/generalInfo");
			Element generalInfoElement = null;
			if(generalInfoNode == null ){
				generalInfoElement = doc.getRootElement().addElement("generalInfo");
			}
			//注册分类
			Node registCategoryNode = generalInfoElement.selectSingleNode("registCategory");
			if (registCategoryNode == null) {
				registCategoryNode = generalInfoElement.addElement("registCategory");
			}
			registCategoryNode.setText(projInfo.getRegistCategory());
			
			//组长/参与
			Node isLeaderNode = generalInfoElement.selectSingleNode("isLeader");
			if (isLeaderNode == null) {
				isLeaderNode = generalInfoElement.addElement("isLeader");
			}
			isLeaderNode.setText(projInfo.getIsLeader());
			//国际多中心
			Node interMulCenterNode = generalInfoElement.selectSingleNode("interMulCenter");
			if (interMulCenterNode == null) {
				interMulCenterNode = generalInfoElement.addElement("interMulCenter");
			}
			interMulCenterNode.setText(StringUtil.defaultIfEmpty(projInfo.getInterMulCenter(),""));
			
			//****************申办者****************
			Node declarerNode = doc.selectSingleNode("projInfo/declarer");
			Element declarerElement = null;
			if(declarerNode == null ){
				declarerElement = doc.getRootElement().addElement("declarer");
			}
			//申办者地址
			Node declarerAddressNode = declarerElement.selectSingleNode("declarerAddress");
			if (declarerAddressNode == null) {
				declarerAddressNode = declarerElement.addElement("declarerAddress");
			}
			declarerAddressNode.setText(StringUtil.defaultIfEmpty(projInfo.getDeclarerAddress(),""));
			//申办者邮编
			Node declarerZipNode = declarerElement.selectSingleNode("declarerZip");
			if (declarerZipNode == null) {
				declarerZipNode = declarerElement.addElement("declarerZip");
			}
			declarerZipNode.setText(StringUtil.defaultIfEmpty(projInfo.getDeclarerZip(),""));
			//申办者联系人
			Node dLinkManNode = declarerElement.selectSingleNode("dLinkMan");
			if (dLinkManNode == null) {
				dLinkManNode = declarerElement.addElement("dLinkMan");
			}
			dLinkManNode.setText(StringUtil.defaultIfEmpty(projInfo.getdLinkMan(),""));
			//申办者联系人手机
			Node dLinkManPhoneNode = declarerElement.selectSingleNode("dLinkManPhone");
			if (dLinkManPhoneNode == null) {
				dLinkManPhoneNode = declarerElement.addElement("dLinkManPhone");
			}
			dLinkManPhoneNode.setText(StringUtil.defaultIfEmpty(projInfo.getdLinkManPhone(),""));
			//申办者联系人邮箱
			Node dLinkManEmailNode = declarerElement.selectSingleNode("dLinkManEmail");
			if (dLinkManEmailNode == null) {
				dLinkManEmailNode = declarerElement.addElement("dLinkManEmail");
			}
			dLinkManEmailNode.setText(StringUtil.defaultIfEmpty(projInfo.getdLinkManEmail(),""));
			
			//****************CRO****************
			Node CRONode = doc.selectSingleNode("projInfo/CRO");
			Element CROElement = null;
			if(CRONode == null ){
				CROElement = doc.getRootElement().addElement("CRO");
			}
			//CRO名称
			Node CRONameNode = CROElement.selectSingleNode("CROName");
			if (CRONameNode == null) {
				CRONameNode = CROElement.addElement("CROName");
			}
			CRONameNode.setText(StringUtil.defaultIfEmpty(projInfo.getCROName(),""));
			//法人
			Node CROLegalRepresentNode = CROElement.selectSingleNode("CROLegalRepresent");
			if (CROLegalRepresentNode == null) {
				CROLegalRepresentNode = CROElement.addElement("CROLegalRepresent");
			}
			CROLegalRepresentNode.setText(StringUtil.defaultIfEmpty(projInfo.getCROLegalRepresent(),""));
			//CRO地址
			Node CROAddressNode = CROElement.selectSingleNode("CROAddress");
			if (CROAddressNode == null) {
				CROAddressNode = CROElement.addElement("CROAddress");
			}
			CROAddressNode.setText(StringUtil.defaultIfEmpty(projInfo.getCROAddress(),""));
			//CRO邮编
			Node CROZipNode = CROElement.selectSingleNode("CROZip");
			if (CROZipNode == null) {
				CROZipNode = CROElement.addElement("CROZip");
			}
			CROZipNode.setText(StringUtil.defaultIfEmpty(projInfo.getCROZip(),""));
			//CRO联系人
			Node CROLinkManNode = CROElement.selectSingleNode("CROLinkMan");
			if (CROLinkManNode == null) {
				CROLinkManNode = CROElement.addElement("CROLinkMan");
			}
			CROLinkManNode.setText(StringUtil.defaultIfEmpty(projInfo.getCROLinkMan(),""));
			//CRO联系人手机
			Node CROLinkManPhoneNode = CROElement.selectSingleNode("CROLinkManPhone");
			if (CROLinkManPhoneNode == null) {
				CROLinkManPhoneNode = CROElement.addElement("CROLinkManPhone");
			}
			CROLinkManPhoneNode.setText(StringUtil.defaultIfEmpty(projInfo.getCROLinkManPhone(),""));
			//CRO联系人邮箱
			Node CROLinkManEmailNode = CROElement.selectSingleNode("CROLinkManEmail");
			if (CROLinkManEmailNode == null) {
				CROLinkManEmailNode = CROElement.addElement("CROLinkManEmail");
			}
			CROLinkManEmailNode.setText(StringUtil.defaultIfEmpty(projInfo.getCROLinkManEmail(),""));
			
			//****************研究者信息****************
			Node researcherNode = doc.selectSingleNode("projInfo/researcher");
			Element researcherElement = null;
			if(researcherNode == null ){
				researcherElement = doc.getRootElement().addElement("researcher");
			}
			//科主任
			Node directorNode = researcherElement.selectSingleNode("director");
			if (directorNode == null) {
				directorNode = researcherElement.addElement("director");
			}
			directorNode.setText(StringUtil.defaultIfEmpty(projInfo.getDirector(),""));
			
			//****************临床研究机构****************
			Node projOrgNode = doc.selectSingleNode("projInfo/projOrg");
			Element projOrgElement = null;
			if(projOrgNode == null ){
				projOrgElement = doc.getRootElement().addElement("projOrg");
			}
			//临床试验负责单位
//			Node leaderOrgNode = projOrgElement.selectSingleNode("leaderOrg");
//			if (leaderOrgNode == null) {
//				leaderOrgNode = projOrgElement.addElement("leaderOrg");
//			}
//			leaderOrgNode.setText(projInfo.getLeaderOrg());
			//临床试验负责单位联系人
			Node leaderOrgLinkManNode = projOrgElement.selectSingleNode("leaderOrgLinkMan");
			if (leaderOrgLinkManNode == null) {
				leaderOrgLinkManNode = projOrgElement.addElement("leaderOrgLinkMan");
			}
			leaderOrgLinkManNode.setText(StringUtil.defaultIfEmpty(projInfo.getLeaderOrgLinkMan(),""));
			//临床试验负责单位联系人手机
			Node leaderOrgLinkManPhoneNode = projOrgElement.selectSingleNode("leaderOrgLinkManPhone");
			if (leaderOrgLinkManPhoneNode == null) {
				leaderOrgLinkManPhoneNode = projOrgElement.addElement("leaderOrgLinkManPhone");
			}
			leaderOrgLinkManPhoneNode.setText(StringUtil.defaultIfEmpty(projInfo.getLeaderOrgLinkManPhone(),""));
			//临床试验负责单位联系人邮件
			Node leaderOrgLinkManEmailNode = projOrgElement.selectSingleNode("leaderOrgLinkManEmail");
			if (leaderOrgLinkManEmailNode == null) {
				leaderOrgLinkManEmailNode = projOrgElement.addElement("leaderOrgLinkManEmail");
			}
			leaderOrgLinkManEmailNode.setText(StringUtil.defaultIfEmpty(projInfo.getLeaderOrgLinkManEmail(),""));
			
			//临床试验负责单位联系人
			Node leaderOrgIrbLinkManNode = projOrgElement.selectSingleNode("leaderOrgIrbLinkMan");
			if (leaderOrgIrbLinkManNode == null) {
				leaderOrgIrbLinkManNode = projOrgElement.addElement("leaderOrgIrbLinkMan");
			}
			leaderOrgIrbLinkManNode.setText(StringUtil.defaultIfEmpty(projInfo.getLeaderOrgIrbLinkMan(),""));
			
			//临床试验负责单位联系人手机
			Node leaderOrgIrbLinkManPhoneNode = projOrgElement.selectSingleNode("leaderOrgIrbLinkManPhone");
			if (leaderOrgIrbLinkManPhoneNode == null) {
				leaderOrgIrbLinkManPhoneNode = projOrgElement.addElement("leaderOrgIrbLinkManPhone");
			}
			leaderOrgIrbLinkManPhoneNode.setText(StringUtil.defaultIfEmpty(projInfo.getLeaderOrgIrbLinkManPhone(),""));
			
			//临床试验负责单位联系人邮件
			Node leaderOrgIrbLinkManEmailNode = projOrgElement.selectSingleNode("leaderOrgIrbLinkManEmail");
			if (leaderOrgIrbLinkManEmailNode == null) {
				leaderOrgIrbLinkManEmailNode = projOrgElement.addElement("leaderOrgIrbLinkManEmail");
			}
			leaderOrgIrbLinkManEmailNode.setText(StringUtil.defaultIfEmpty(projInfo.getLeaderOrgIrbLinkManEmail(),""));
			
			return doc.asXML();
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		return content;
	}
	@RequestMapping("/uploadUser")
	public  String  uploadUser(PubFileForm fileForm) {
		String fileName =  fileForm.getFile().getOriginalFilename();
		String suffix =fileName.substring(fileName.lastIndexOf(".")+1);  
		PubFile file  = new PubFile();
		file.setFileFlow(PkUtil.getUUID());
		file.setFileSuffix(suffix);
		try {
			InputStream is = fileForm.getFile().getInputStream();
			  byte[] fileData = new byte[(int) fileForm.getFile().getSize()];  
			    is.read(fileData);  
			    file.setFileName(fileName);
			    file.setFileContent(fileData);
				try {
					 Workbook wb =  createCommonWorkbook(new ByteInputStream(fileData,(int) fileForm.getFile().getSize() ));
					 parseUserExcel(wb);
				} catch (Exception e) {
					e.printStackTrace();
				}
			    is.close();
		} catch (IOException e) {
			e.printStackTrace();
		}  
		return "sample/user";
	}
	private void parseUserExcel(Workbook wb) {
		int sheetNum = wb.getNumberOfSheets();
		if(sheetNum>0){
			List<String> colnames = new ArrayList<String>();
			Sheet sheet;
			try {
				sheet = (HSSFSheet) wb.getSheetAt(0);
			} catch (Exception e) {
				sheet = (XSSFSheet)wb.getSheetAt(0);
			}
			 int row_num = sheet.getLastRowNum();  
             for (int i = 0; i <= row_num; i++) {  
                Row r =  sheet.getRow(i);  
                int cell_num = r.getLastCellNum();  
                if (i == 0) {
                	for (int j = 0; j < cell_num; j++) {  
                		 String value = "";
						 if(r.getCell((short)j).getCellType() == 1){  
							 value = r.getCell((short) j).getStringCellValue();  
						 } 
						colnames.add(value);
					}
                }else {
                	SysUser user = new SysUser();
                	user.setUserFlow(PkUtil.getUUID());
					boolean flag = false;
					 for (int j = 0; j < cell_num; j++) {  
						 String value = "";
						 if(r.getCell((short)j).getCellType() == 1){  
							 value = r.getCell((short) j).getStringCellValue();  
						 }else{  
							 value = _doubleTrans(r.getCell((short) j).getNumericCellValue());  
						 } 
						if ("登录名".equals(colnames.get(j))) {
							if (value == null
									|| value.trim()
											.length() == 0) {
								flag = true;
								break;
							}
							user.setUserCode(value);
						} else if ("密码".equals(colnames.get(j))) {
							if (value == null
									|| value.trim()
											.length() == 0) {
								flag = true;
								break;
							}
							user.setUserPasswd(PasswordHelper.encryptPassword(user.getUserFlow(), value));
						} else if ("科室".equals(colnames.get(j))) {
							user.setDeptFlow(_getDeptFlowByName(value)); 
							user.setDeptName(value);
						} else if ("姓名".equals(colnames.get(j))) {
							user.setUserName(value);
						} else if ("性别".equals(colnames.get(j))) {
							if("男".equals(value)){
								user.setSexId(UserSexEnum.Man.getId());
							}else if("女".equals(value)){
								user.setSexId(UserSexEnum.Woman.getId());
							}
							user.setSexName(value);
						} else if ("身份证".equals(colnames.get(j))) {
							user.setIdNo(value);
						} else if ("出生年月".equals(colnames.get(j))) {
							user.setUserBirthday(value);
						} else if ("学历".equals(colnames.get(j))) {
							user.setEducationName(value);
						} else if ("学位".equals(colnames.get(j))) {
							user.setDegreeName(value);
						} else if ("职称".equals(colnames.get(j))) {
							user.setTitleName(value);
						} else if ("职务".equals(colnames.get(j))) {
							user.setPostName(value);
						} else if ("手机".equals(colnames.get(j))) {
							user.setUserPhone(value);
						} 
					}
					if (flag) {
						break;
					}
					user.setStatusId("Activated");
					user.setStatusDesc("已激活");
					user.setOrgFlow("24708495ccdc4c3da3affdd1ebce474b");
					user.setOrgName("河南中医学院第一附属医院");
					GeneralMethod.setRecordInfo(user, true);
					userMapper.insert(user);
                }	  
            }
		}
	}
	@RequestMapping("/synResume")
	@ResponseBody
	public  Integer synResume() throws Exception{
			Connection conn = null;
		  Class.forName("oracle.jdbc.driver.OracleDriver");//加入oracle的驱动，“”里面是驱动的路径
		   
		  String url = "jdbc:oracle:thin:@192.168.1.11:1521:demo";// 数据库连接，oracle代表链接的是oracle数据库；thin:@MyDbComputerNameOrIP代表的是数据库所在的IP地址（可以保留thin:）；1521代表链接数据库的端口号；ORCL代表的是数据库名称

		  String UserName = "irb";// 数据库用户登陆名 ( 也有说是 schema 名字的 )

		  String Password = "irb123456";// 密码

		  conn = DriverManager.getConnection(url, UserName, Password);
		   int sum = 0;
		  Statement statement = conn.createStatement();
		  ResultSet rs =  statement.executeQuery("select * from sys_user where INSTI_NUMBER='HeN'");
		  while(rs.next()){
			  String userName = rs.getString("user_name");
			  String content = "";
			  try{
					BufferedReader reader = new BufferedReader(rs.getCharacterStream("USER_INFO"));//项目其它信息xml结构 
					String temp = null;
					StringBuffer sb = new StringBuffer(100);
					int count = 0;
					while((temp=reader.readLine())!=null){
						if(count>0){
							sb.append("\n");
						}
						sb.append(temp);
						count++;
					}
					content = sb.toString();
					reader.close();
				}
				catch(Exception e){
					e.printStackTrace();
				}
			  SysUser user = _getSysUserByName(userName);
			  
			  if(user != null){
				  
				  Document dom = DocumentHelper.parseText(content);
					String xpath = "/sysuser/eduexpers/eduexper";
					List<Element> temps = dom.selectNodes(xpath);
				  
				  for(Element eduEle : temps){
					  EduResumeForm resume = new EduResumeForm();
					  resume.setStartDate(eduEle.elementText("begdate"));
					  resume.setEndDate(eduEle.elementText("enddate"));
					  resume.setCollege(eduEle.elementText("eduname")); 
					  resume.setEducation(eduEle.elementText("education"));
					  resume.setDegree(eduEle.elementText("degree"));
					  resume.setMajor(eduEle.elementText("edudept"));
//					  resumeBiz.saveEduResume(user,resume);
				  }
				   xpath = "/sysuser/workexpers/workexper";
				  temps = dom.selectNodes(xpath);
				  
				  for(Element eduEle : temps){
					  WorkResumeForm resume = new WorkResumeForm();
					  resume.setStartDate(eduEle.elementText("begdate"));
					  resume.setEndDate(eduEle.elementText("enddate"));
					  resume.setOrgName(eduEle.elementText("workname"));
					  resume.setTitle(eduEle.elementText("workpost"));
					  resume.setDepartment(eduEle.elementText("workdept"));
//					  resumeBiz.saveWorkResume(user,resume);
				  }
				  xpath = "/sysuser/acads/acad";
				  temps = dom.selectNodes(xpath);
				  
				  for(Element eduEle : temps){
					  AcademicResumeForm resume = new AcademicResumeForm();
					  resume.setStartDate(eduEle.elementText("begdate"));
					  resume.setAcademicName(eduEle.elementText("acadname"));
					  resume.setTitle(eduEle.elementText("acadpost"));
//					  resumeBiz.saveAcademicResume(user,resume);
				  }
				  sum++;
			  }
		  }
		  statement.close();
		  conn.close();
		  
		  return sum;
	}
	@RequestMapping("/synArchiveFile")
	@ResponseBody
	public  Integer synArchiveFile() throws Exception{
			Connection conn = null;
		  Class.forName("oracle.jdbc.driver.OracleDriver");//加入oracle的驱动，“”里面是驱动的路径
		   
		  String url = "jdbc:oracle:thin:@192.168.1.11:1521:demo";// 数据库连接，oracle代表链接的是oracle数据库；thin:@MyDbComputerNameOrIP代表的是数据库所在的IP地址（可以保留thin:）；1521代表链接数据库的端口号；ORCL代表的是数据库名称

		  String UserName = "irb";// 数据库用户登陆名 ( 也有说是 schema 名字的 )

		  String Password = "irb123456";// 密码

		  conn = DriverManager.getConnection(url, UserName, Password);
		   int sum = 0;
		  Statement statement = conn.createStatement();
		  ResultSet rs =  statement.executeQuery("select * from project_irb where INSTI_NUMBER='HeN'");
		  while(rs.next()){
			  String irbNo = rs.getString("SQSL_NUM");
			  String content = "";
			  try{
					BufferedReader reader = new BufferedReader(rs.getCharacterStream("IRT_OTHER_INFO"));//项目其它信息xml结构 
					String temp = null;
					StringBuffer sb = new StringBuffer(100);
					int count = 0;
					while((temp=reader.readLine())!=null){
						if(count>0){
							sb.append("\n");
						}
						sb.append(temp);
						count++;
					}
					content = sb.toString();
					reader.close();
				}
				catch(Exception e){
					e.printStackTrace();
				}
			  if(StringUtil.isNotBlank(irbNo)){
				 IrbApplyExample example = new IrbApplyExample();
				 example.createCriteria().andIrbNoEqualTo(irbNo);
				 List<IrbApply> irbList = irbMapper.selectByExample(example);
				  if(irbList != null && irbList.size()>0){
					  IrbApply irb = irbList.get(0);
					  Document dom = DocumentHelper.parseText(content);
						String xpath = "/irb/archivefiles/archivefile";
						List<Element> temps = dom.selectNodes(xpath);
					  
						
						List<IrbArchiveForm> list = new ArrayList<IrbArchiveForm>();
					  for(Element ele : temps){
						  String fileName = ele.elementText("filename");
						  String archivedate = ele.elementText("archivedate");
						  String fileurl = ele.elementText("fileurl");
						  IrbArchiveForm form = new IrbArchiveForm();
						  form.setIrbFlow(irb.getIrbFlow());
						  form.setDate(DateUtil.transDate(archivedate,"yyyy-MM-dd"));
						  form.setName(fileName);
						  form.setFileFlow(fileurl);
						  form.setUrl("/sci/pub/file/down?fileFlow="+fileurl);
						  list.add(form);
					  }
					  saveArchiveFile(list);
					  sum++;
				  }
			  }
		  }
		  statement.close();
		  conn.close();
		  
		  return sum;
	}
	public void saveArchiveFile(List<IrbArchiveForm> list) throws Exception {
		for (IrbArchiveForm form : list) {
			this.irbRecBiz.saveArchiveFile(form);
		}
	}
	@RequestMapping("/synIrbMeetingUser")
	@ResponseBody
	public  Integer synIrbMeetingUser() throws Exception{
			Connection conn = null;
		  Class.forName("oracle.jdbc.driver.OracleDriver");//加入oracle的驱动，“”里面是驱动的路径
		   
		  String url = "jdbc:oracle:thin:@192.168.1.11:1521:demo";// 数据库连接，oracle代表链接的是oracle数据库；thin:@MyDbComputerNameOrIP代表的是数据库所在的IP地址（可以保留thin:）；1521代表链接数据库的端口号；ORCL代表的是数据库名称

		  String UserName = "irb";// 数据库用户登陆名 ( 也有说是 schema 名字的 )

		  String Password = "irb123456";// 密码

		  conn = DriverManager.getConnection(url, UserName, Password);
		   int sum = 0;
		  Statement statement = conn.createStatement();
		  Statement statement1 = conn.createStatement();
		  ResultSet rs =  statement.executeQuery("select * from meeting_user where INSTI_NUMBER='HeN'");
		  ResultSet rs1 =  null;
		  while(rs.next()){
			  String meetingFlow = rs.getString("meeting_flow");
			  String userName = rs.getString("user_name");
			  String isAttend = rs.getString("is_attend");
			  String roleName = rs.getString("irb_dept");
			  rs1 = statement1.executeQuery("select * from meeting_info where meeting_flow='"+meetingFlow+"'");
			  if(rs1.next()){
				  if("1".equals(isAttend)){
					  String meetingDate = rs1.getString("meeting_date");
					  
					  String sciMeetingFlow = _getMeetingByDate(meetingDate);
					  String userFlow = _getSysUserByName(userName).getUserFlow();
					  
					  IrbMeetingUser mu = new IrbMeetingUser();
					  mu.setRecordFlow(PkUtil.getUUID());
					  mu.setMeetingFlow(sciMeetingFlow);
					  mu.setUserFlow(userFlow);
					  mu.setUserName(userName);
					  mu.setAttendStatus(isAttend);
					  _conversionRole(mu,roleName);
					  GeneralMethod.setRecordInfo(mu, true);
					  meetingUserMapper.insert(mu);
				  }
			  }
			  
			  sum++;
		  }
		  statement.close();
		  conn.close();
		  
		  return sum;
	}
	private void _conversionRole(IrbMeetingUser mu, String roleName) {
		if("委员".equals(roleName)){
			mu.setRoleName("委员");
			mu.setRoleFlow("eac38a56dae54fc5b2a06f7a92334f12");
		}else if("主任委员".equals(roleName)){
			mu.setRoleName("主席");
			mu.setRoleFlow("7da541be011b436297f6df6a7104a6d2");
		}else if("工作人员".equals(roleName)){
			mu.setRoleName("工作人员");
			mu.setRoleFlow("e60d843719f04da09e20119ace736748");
		}else if("委员秘书".equals(roleName)){
			mu.setRoleName("委员");
			mu.setRoleFlow("eac38a56dae54fc5b2a06f7a92334f12");
		}else if(StringUtil.isBlank(roleName)){
			mu.setRoleName("独立顾问");
			mu.setRoleFlow("8d76efda2783479b800b5e5ac16acb4c");
		}
	}
	@RequestMapping("/synMinute")
	@ResponseBody
	public  Integer synMinute() throws Exception{
			Connection conn = null;
		  Class.forName("oracle.jdbc.driver.OracleDriver");//加入oracle的驱动，“”里面是驱动的路径
		   
		  String url = "jdbc:oracle:thin:@192.168.1.11:1521:demo";// 数据库连接，oracle代表链接的是oracle数据库；thin:@MyDbComputerNameOrIP代表的是数据库所在的IP地址（可以保留thin:）；1521代表链接数据库的端口号；ORCL代表的是数据库名称

		  String UserName = "irb";// 数据库用户登陆名 ( 也有说是 schema 名字的 )

		  String Password = "irb123456";// 密码

		  conn = DriverManager.getConnection(url, UserName, Password);
		   int sum = 0;
		  Statement statement = conn.createStatement();
		  ResultSet rs =  statement.executeQuery("select * from project_irb where INSTI_NUMBER='HeN'");
		  while(rs.next()){
			  String irbNo = rs.getString("SQSL_NUM");
			  String content = "";
			  try{
					BufferedReader reader = new BufferedReader(rs.getCharacterStream("IRT_OTHER_INFO"));//项目其它信息xml结构 
					String temp = null;
					StringBuffer sb = new StringBuffer(100);
					int count = 0;
					while((temp=reader.readLine())!=null){
						if(count>0){
							sb.append("\n");
						}
						sb.append(temp);
						count++;
					}
					content = sb.toString();
					reader.close();
				}
				catch(Exception e){
					e.printStackTrace();
				}
			  if(StringUtil.isNotBlank(irbNo)){
				 IrbApplyExample example = new IrbApplyExample();
				 example.createCriteria().andIrbNoEqualTo(irbNo);
				 List<IrbApply> irbList = irbMapper.selectByExample(example);
				  if(irbList != null && irbList.size()>0){
					  IrbApply irb = irbList.get(0);
					    Document dom = DocumentHelper.parseText(content); 
					    String xpath = "/irb/meeting/record";
						List<Element> temps = dom.selectNodes(xpath);
					    if(temps!=null && temps.size()>0){
					    	Element temp = temps.get(0);
							IrbMinutesForm form = new IrbMinutesForm();
							form.setTitle(temp.elementText("sqrbg"));
							form.setQuestion(temp.elementText("qanda"));
							form.setDiscussion(temp.elementText("zsyj"));
							saveMinutes(irb.getIrbFlow(),form,temp.elementText("recorddate"),temp.elementText("recorder"));
						  sum++;
					    }
				  }
			  }
		  }
		  statement.close();
		  conn.close();
		  
		  return sum;
	}
	public int saveMinutes(String irbFlow, IrbMinutesForm form,String date,String user) throws Exception {
		if(StringUtil.isNotBlank(irbFlow) && form!=null){
			IrbRec irbRec = new IrbRec(); 
			irbRec.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			irbRec.setIrbFlow(irbFlow);
			irbRec.setRecTypeId(IrbRecTypeEnum.Minutes.getId());
			IrbRec findIrbRec = this.irbRecBiz.readIrbRec(irbRec);
			if(findIrbRec==null){
				irbRec.setRecTypeName(IrbRecTypeEnum.Minutes.getName());
				IrbApply irbApply = this.irbApplyBiz.queryByFlow(irbFlow);
				irbRec.setProjFlow(irbApply.getProjFlow());
				irbRec.setIrbStageId(irbApply.getIrbStageId());
				irbRec.setIrbStageName(irbApply.getIrbStageName());
				findIrbRec = irbRec;
			}
			Document dom = DocumentHelper.createDocument();
			Element root = dom.addElement("minutes"); 
			/*会议报告的会议记录*/
			String reportMinutes = form.getReportMinutes();
			String question = form.getQuestion();
			String discussion = form.getDiscussion();
			String title = form.getTitle();
			if(StringUtil.isNotBlank(reportMinutes)){
				root.addElement("reportMinutes").setText(reportMinutes);
			}
			if(StringUtil.isNotBlank(title)){
				root.addElement("title").setText(title);
			}
			if(StringUtil.isNotBlank(question)){
				root.addElement("question").setText(question);
			}
			if(StringUtil.isNotBlank(discussion)){
				root.addElement("discussion").setText(discussion);
			}
			String recContent = dom.asXML();
			findIrbRec.setRecContent(recContent);
			findIrbRec.setCreateTime(date);
			findIrbRec.setCreateUserFlow("307e0ca21ac145b7b6ff833c4dec25d2");
			findIrbRec.setModifyTime(date);
			findIrbRec.setModifyUserFlow("307e0ca21ac145b7b6ff833c4dec25d2");
			findIrbRec.setRecFlow(PkUtil.getUUID());
			recMapper.insert(findIrbRec);
		}
		return GlobalConstant.ZERO_LINE;
	}
	@RequestMapping("/synDecisionFile")
	@ResponseBody
	public  Integer synDecisionFile() throws Exception{
			Connection conn = null;
		  Class.forName("oracle.jdbc.driver.OracleDriver");//加入oracle的驱动，“”里面是驱动的路径
		   
		  String url = "jdbc:oracle:thin:@192.168.1.11:1521:demo";// 数据库连接，oracle代表链接的是oracle数据库；thin:@MyDbComputerNameOrIP代表的是数据库所在的IP地址（可以保留thin:）；1521代表链接数据库的端口号；ORCL代表的是数据库名称

		  String UserName = "irb";// 数据库用户登陆名 ( 也有说是 schema 名字的 )

		  String Password = "irb123456";// 密码

		  conn = DriverManager.getConnection(url, UserName, Password);
		   int sum = 0;
		  Statement statement = conn.createStatement();
		  ResultSet rs =  statement.executeQuery("select * from project_irb where INSTI_NUMBER='HeN'");
		  while(rs.next()){
			  String irbNo = rs.getString("SQSL_NUM");
			  String content = "";
			  try{
					BufferedReader reader = new BufferedReader(rs.getCharacterStream("IRT_OTHER_INFO"));//项目其它信息xml结构 
					String temp = null;
					StringBuffer sb = new StringBuffer(100);
					int count = 0;
					while((temp=reader.readLine())!=null){
						if(count>0){
							sb.append("\n");
						}
						sb.append(temp);
						count++;
					}
					content = sb.toString();
					reader.close();
				}
				catch(Exception e){
					e.printStackTrace();
				}
			  if(StringUtil.isNotBlank(irbNo)){
				 IrbApplyExample example = new IrbApplyExample();
				 example.createCriteria().andIrbNoEqualTo(irbNo);
				 List<IrbApply> irbList = irbMapper.selectByExample(example);
				 
				  if(irbList != null && irbList.size()>0){
					  IrbApply irb = irbList.get(0);
					  IrbInfo irbInfo = InitConfig.irbInfoMap.get(irb.getIrbInfoFlow());
					    Document dom = DocumentHelper.parseText(content); 
					    String xpath = "/irb/votes/vote";
					    String decisionName = "";
					    if(dom.selectSingleNode("/irb/meeting/irbdecision/decision") ==null){
					    	decisionName = irb.getIrbDecisionName();
					    }else {
					    	decisionName = dom.selectSingleNode("/irb/meeting/irbdecision/decision").getText();
					    }
					   
					    	
					   
						List<Element> temps = dom.selectNodes(xpath);
						if(temps!=null && temps.size()>0){
							IrbVoteForm form = new IrbVoteForm();
					    	form.setDecisionId(_getDecisionIdByName(decisionName));
					    	form.setDecisionName(decisionName);
					    	form.setMeetingFlow(irb.getMeetingFlow());
					    	form.setIrbFlow(irb.getIrbFlow());
					    	List<IrbVoteForm> voteList= new ArrayList<IrbVoteForm>();
						    for(Element temp : temps){
						    	if(StringUtil.isBlank(temp.elementText("userName"))){
						    		continue;
						    	}
						    	IrbVoteForm voteForm = new IrbVoteForm();
						    	voteForm.setIrbFlow(irb.getIrbFlow());
						    	voteForm.setDate(irb.getMeetingDate());
						    	voteForm.setDecisionId(_getDecisionIdByName(temp.elementText("voteResult"))); 
						    	voteForm.setDecisionName(temp.elementText("voteResult"));
						    	voteForm.setOpinion(temp.elementText("opinion"));
						    	voteForm.setUserName(temp.elementText("userName"));
						    	voteForm.setUserFlow(_getSysUserByName(temp.elementText("userName")).getUserFlow());
						    	if( dom.selectSingleNode("/irb/meeting/record/quituser")!=null 
						    			&&StringUtil.isNotBlank(dom.selectSingleNode("/irb/meeting/record/quituser").getText()) && dom.selectSingleNode("/irb/meeting/record/quituser").getText().indexOf(temp.elementText("userName"))>-1){
						    		voteForm.setConflict("Y");
						    	}
						    	voteList.add(voteForm);
						    }
						    form.setVoteList(voteList);
						    committeeBiz.saveVoteDecision(form);
						}
						 Node approvalnotice = dom.selectSingleNode("/irb/approvalnotice");
						 if(approvalnotice!=null){
							 IrbDecisionDetailForm form = new IrbDecisionDetailForm();
							 form.setOpinion(approvalnotice.selectSingleNode("content").getText());
							 form.setTrackFrequency(approvalnotice.selectSingleNode("frequency").getText());
							 form.setTrackDate(approvalnotice.selectSingleNode("trackdate").getText());
							 form.setChairman(approvalnotice.selectSingleNode("chairman").getText());
							 form.setApproveValidity(approvalnotice.selectSingleNode("validateTime").getText());
							 form.setContact(irbInfo.getContactUser()+" "+"  "+irbInfo.getContactPhone()+" "+irbInfo.getContactMobile());
							 form.setIrbInfo(irbInfo.getIrbName());
							 form.setIrbDecisionDate(approvalnotice.selectSingleNode("approvalnoticedate").getText());
							 form.setIrbRecTypeId(IrbRecTypeEnum.ApproveFile.getId());
							 secretaryBiz.saveDecDetail(irb.getIrbFlow(), form);
						 }
						 Node notification = dom.selectSingleNode("/irb/notification");
						 if(notification!=null){
							 IrbDecisionDetailForm form = new IrbDecisionDetailForm();
							 form.setOpinion(notification.selectSingleNode("content").getText());
							 if(notification.selectSingleNode("validateTime")!=null){
								 form.setApproveValidity(notification.selectSingleNode("validateTime").getText());
							 }
							 if(notification.selectSingleNode("frequency")!=null){
								 form.setTrackFrequency(notification.selectSingleNode("frequency").getText());
							 }
							 if(notification.selectSingleNode("trackdate")!=null){
								 form.setTrackDate(notification.selectSingleNode("trackdate").getText());
							 }
							 form.setChairman(notification.selectSingleNode("chairman").getText());
							 form.setContact(irbInfo.getContactUser()+" "+"  "+irbInfo.getContactPhone()+" "+irbInfo.getContactMobile());
							 form.setIrbInfo(irbInfo.getIrbName());
							 form.setIrbDecisionDate(notification.selectSingleNode("notificationdate").getText());
							 form.setIrbRecTypeId(IrbRecTypeEnum.OpinionFile.getId());
							 secretaryBiz.saveDecDetail(irb.getIrbFlow(), form);
						 }
				  }
			  }
		  }
		  statement.close();
		  conn.close();
		  
		  return sum;
	}
	public int saveVoteDecision(IrbVoteForm form) throws Exception {
		if(form!=null){
			IrbVoteForm mForm = new IrbVoteForm();
			mForm.setmDecisionId(form.getmDecisionId());
			mForm.setMeetingFlow(form.getMeetingFlow());
			String irbFlow = form.getIrbFlow();
			committeeBiz.saveVote(mForm, irbFlow,null);//保存最终决定
			List<IrbVoteForm> voteList = form.getVoteList();
			String currDate = DateUtil.getCurrDate();
			if(voteList!=null&&!voteList.isEmpty()){//批量保存投票
				String userFlows[] = new String[voteList.size()];
				for (int i=0;i<voteList.size();i++) {
					IrbVoteForm irbVoteForm = voteList.get(i);
					String userFlow = irbVoteForm.getUserFlow();
					IrbVoteForm sForm = new IrbVoteForm();
					sForm.setUserFlow(userFlow);
					sForm.setUserName(irbVoteForm.getUserName());
					String decisionId = irbVoteForm.getDecisionId();
					String conflict = irbVoteForm.getConflict();
					if(GlobalConstant.FLAG_Y.equals(conflict)){
						sForm.setConflict(GlobalConstant.FLAG_Y);
						sForm.setDecisionId("");
						userFlows[i] = userFlow;
					}else{
						sForm.setDecisionId(decisionId);
						sForm.setConflict("");
					}
					sForm.setDate(currDate);
					committeeBiz.saveVote(sForm, irbFlow, null);
				}
				committeeBiz.saveConflict(irbFlow,userFlows);//批量保存利益冲突退出
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	@RequestMapping("/synSchedule")
	@ResponseBody
	public  Integer synSchedule() throws Exception{
			Connection conn = null;
		  Class.forName("oracle.jdbc.driver.OracleDriver");//加入oracle的驱动，“”里面是驱动的路径
		   
		  String url = "jdbc:oracle:thin:@192.168.1.11:1521:demo";// 数据库连接，oracle代表链接的是oracle数据库；thin:@MyDbComputerNameOrIP代表的是数据库所在的IP地址（可以保留thin:）；1521代表链接数据库的端口号；ORCL代表的是数据库名称

		  String UserName = "irb";// 数据库用户登陆名 ( 也有说是 schema 名字的 )

		  String Password = "irb123456";// 密码

		  conn = DriverManager.getConnection(url, UserName, Password);
		   int sum = 0;
		  Statement statement = conn.createStatement();
		  ResultSet rs =  statement.executeQuery("select * from project_irb where INSTI_NUMBER='HeN' and IRB_TYPE='研究进展报告'");
		  while(rs.next()){
			  String irbNo = rs.getString("SQSL_NUM");
			  String content = "";
			  try{
					BufferedReader reader = new BufferedReader(rs.getCharacterStream("IRT_OTHER_INFO"));//项目其它信息xml结构 
					String temp = null;
					StringBuffer sb = new StringBuffer(100);
					int count = 0;
					while((temp=reader.readLine())!=null){
						if(count>0){
							sb.append("\n");
						}
						sb.append(temp);
						count++;
					}
					content = sb.toString();
					reader.close();
				}
				catch(Exception e){
					e.printStackTrace();
				}
			  if(StringUtil.isNotBlank(irbNo)){
				 IrbApplyExample example = new IrbApplyExample();
				 example.createCriteria().andIrbNoEqualTo(irbNo);
				 List<IrbApply> irbList = irbMapper.selectByExample(example);
				  if(irbList != null && irbList.size()>0){
					  IrbApply apply = irbList.get(0);
					  String irbFlow = apply.getIrbFlow();
						IrbRec rec = new IrbRec();;
						String formFileName = "ScheduleApplication";
						Map<String,String> dataMap = new HashMap<String, String>();
						
						
						Document dom = DocumentHelper.parseText(content); 
						dataMap.put("patientCount", dom.selectSingleNode("/irb/applyorreport/testerInfo/caseNum").getText());
						dataMap.put("inPatientNum", dom.selectSingleNode("/irb/applyorreport/testerInfo/inGroupNum").getText());
						dataMap.put("finishPatientNum", dom.selectSingleNode("/irb/applyorreport/testerInfo/overCaseNum").getText());
						dataMap.put("termiPatientNum", dom.selectSingleNode("/irb/applyorreport/testerInfo/exitNum").getText());
						dataMap.put("saeNum", dom.selectSingleNode("/irb/applyorreport/testerInfo/saeNum").getText());
						dataMap.put("saeReportNum", dom.selectSingleNode("/irb/applyorreport/testerInfo/reportedSaeNum").getText());
						
						String researchProgress1 = dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_015832']/code[text()!='']").getText();
						dataMap.put("researchProgress1", conversionProgress1(researchProgress1));
						
						if( dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_020106']/code[text()!='']")!=null){
							String researchProgress2 = dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_020106']/code[text()!='']").getText();
							dataMap.put("researchProgress2", conversionProgress2(researchProgress2));
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_020106']/code[text()!='']/explain")!=null){
								String researchProgress2Explain = dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_020106']/code[text()!='']/explain").getText();
								dataMap.put("factSheets", researchProgress2Explain);
							}
						}
						
						
						String researchProgress3 = dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_020134']/code[text()!='']").getText();
						dataMap.put("researchProgress3", conversionProgress2(researchProgress3));
						
						String researchProgress4 = dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_020209']/code[text()!='']").getText();
						dataMap.put("researchProgress4", conversionProgress2(researchProgress4));
						
						String researchProgress5 = dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_020224']/code[text()!='']").getText();
						dataMap.put("researchProgress5", conversionProgress2(researchProgress5));
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_020224']/code[text()!='']/explain")!=null){
							String researchProgress5Explain = dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_020224']/code[text()!='']/explain").getText();
							dataMap.put("newInfo", researchProgress5Explain);
						}
						
						
						String researchProgress6 = dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_020239']/code[text()!='']").getText();
						dataMap.put("researchProgress6", conversionProgress2(researchProgress6));
						
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_020239']/code[text()!='']/explain")!=null){
							String quesDesc = dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_020239']/code[text()!='']/explain").getText();
							dataMap.put("quesDesc", quesDesc);
						}
						
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_081438']/code[text()!='']")!=null){
						String researchProgress7 = dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_081438']/code[text()!='']").getText();
						dataMap.put("researchProgress7", conversionProgress7(researchProgress7));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='2_092046']/code[text()!='']")!=null){
							String isExtendDocValid = dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='2_092046']/code[text()!='']").getText();
							dataMap.put("isExtendDocValid", conversionProgress2(isExtendDocValid));
						}
						
						
						dataMap.put("applyManName", dom.selectSingleNode("/irb/applyorreport/applyer").getText());
						dataMap.put("applyDate", dom.selectSingleNode("/irb/applyorreport/applydate").getText());
						
						
						Map<String,IrbSingleForm> singleFormMap = InitConfig.formRequestUtil.getFormMap().get(formFileName);
						IrbSingleForm singleForm = 	singleFormMap.get("product_yw_1.0");
						String recContent = _getRecContent(formFileName, singleForm.getItemList(), dataMap); 
						rec.setProjFlow(apply.getProjFlow());
						rec.setIrbFlow(irbFlow);
						String irbStageId = apply.getIrbStageId();
						rec.setIrbStageId(irbStageId);
						String irbStageName = apply.getIrbStageName();
						rec.setIrbStageName(irbStageName);
						rec.setRecTypeId(formFileName);
						String nameById = IrbRecTypeEnum.getNameById(formFileName);
						rec.setRecTypeName(nameById);
						rec.setRecVersion("1.0");
						rec.setRecContent(recContent);
						irbRecBiz.edit(rec);
						sum++;
				  }
			  }
		  }
		  statement.close();
		  conn.close();
		  
		  return sum;
	}
	
	private String conversionProgress7(String researchProgress7) {
		if("不适用".equals(researchProgress7)){
			return "1";
		}else if("是".equals(researchProgress7)){
			return "2";
		}else if("否".equals(researchProgress7)){
			return "3";
		}
		return "";
	}
	private String conversionProgress1(String researchProgress1) {
		if("研究尚未启动".equals(researchProgress1)){
			return "0";
		}else if("正在招募受试者（尚未入组）".equals(researchProgress1)){
			return "1";
		}else if("正在实施研究".equals(researchProgress1)){
			return "2";
		}else if("受试者的试验干预已经完成".equals(researchProgress1)){
			return "3";
		}else if("后期数据处理阶段".equals(researchProgress1)){
			return "4";
		}
		return "";
	}
	private String conversionProgress2(String researchProgress2) {
		if("否".equals(researchProgress2)){
			return "0";
		}else if("是".equals(researchProgress2)){
			return "1";
		}
		return "";
	}
	
	private String _getRecContent(String formName,List<Element> list,Map<String,String> dataMap) { 
		Element rootEle = DocumentHelper.createElement(formName);
		if(list !=null && list.size()>0){
			for(Element itemEle : list){
				String multiple = itemEle.attributeValue("multiple");
				if(GlobalConstant.FLAG_N.equals(multiple) || StringUtil.isBlank(multiple)){
					String value =  dataMap.get(itemEle.attributeValue("name"));
					Element element = DocumentHelper.createElement(itemEle.attributeValue("name")); 
					if (StringUtil.isNotBlank(value)) {
						element.setText(value);
					}
					rootEle.add(element);
				}else {
					String data = dataMap.get(itemEle.attributeValue("name"));
					String[] values = StringUtil.split(data, ",");
					Element element = DocumentHelper.createElement(itemEle.attributeValue("name")); 
					if(values!=null && values.length>0){
						for(String value : values){
							Element valueEle = DocumentHelper.createElement("value"); 
							if (StringUtil.isNotBlank(value)) {
								valueEle.setText(value);
							}
							element.add(valueEle);
						}
					}
					rootEle.add(element);
				}
			}
		}
		return rootEle.asXML();
	}
	@RequestMapping("/synScheduleWork")
	@ResponseBody
	public  Integer synScheduleWork() throws Exception{
			Connection conn = null;
		  Class.forName("oracle.jdbc.driver.OracleDriver");//加入oracle的驱动，“”里面是驱动的路径
		   
		  String url = "jdbc:oracle:thin:@192.168.1.11:1521:demo";// 数据库连接，oracle代表链接的是oracle数据库；thin:@MyDbComputerNameOrIP代表的是数据库所在的IP地址（可以保留thin:）；1521代表链接数据库的端口号；ORCL代表的是数据库名称

		  String UserName = "irb";// 数据库用户登陆名 ( 也有说是 schema 名字的 )

		  String Password = "irb123456";// 密码

		  conn = DriverManager.getConnection(url, UserName, Password);
		   int sum = 0;
		  Statement statement = conn.createStatement();
		  ResultSet rs =  statement.executeQuery("select * from project_irb where INSTI_NUMBER='HeN' and IRB_TYPE='研究进展报告'");
		  while(rs.next()){
			  String irbNo = rs.getString("SQSL_NUM");
			  String content = "";
			  try{
					BufferedReader reader = new BufferedReader(rs.getCharacterStream("IRT_OTHER_INFO"));//项目其它信息xml结构 
					String temp = null;
					StringBuffer sb = new StringBuffer(100);
					int count = 0;
					while((temp=reader.readLine())!=null){
						if(count>0){
							sb.append("\n");
						}
						sb.append(temp);
						count++;
					}
					content = sb.toString();
					reader.close();
				}
				catch(Exception e){
					e.printStackTrace();
				}
			  if(StringUtil.isNotBlank(irbNo)){
				 IrbApplyExample example = new IrbApplyExample();
				 example.createCriteria().andIrbNoEqualTo(irbNo);
				 List<IrbApply> irbList = irbMapper.selectByExample(example);
				  if(irbList != null && irbList.size()>0){
					  IrbApply apply = irbList.get(0);
					  String irbFlow = apply.getIrbFlow();
						IrbRec rec = new IrbRec();;
						String formFileName = "ScheduleWorksheet";
						Map<String,String> dataMap = new HashMap<String, String>();
						Document dom = DocumentHelper.parseText(content); 
						
						List<Element> workSheet = dom.selectNodes("/irb/reviewworksheet");
						for(Element ele : workSheet){ 
							if(ele.selectSingleNode("templet/title/item1[@id='1_035322']/code[text()!='']")!=null){
							dataMap.put("reviewElement1", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_035322']/code[text()!='']").getText()));
							}
							if(ele.selectSingleNode("templet/title/item1[@id='1_035337']/code[text()!='']")!=null){
							dataMap.put("reviewElement2", conversionProgress7(ele.selectSingleNode("templet/title/item1[@id='1_035337']/code[text()!='']").getText()));
							} 
							if(ele.selectSingleNode("templet/title/item1[@id='1_035348']/code[text()!='']")!=null){
							dataMap.put("reviewElement3", conversionProgress7(ele.selectSingleNode("templet/title/item1[@id='1_035348']/code[text()!='']").getText()));
							}
							if(ele.selectSingleNode("templet/title/item1[@id='1_035403']/code[text()!='']")!=null){
							dataMap.put("reviewElement4",  conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_035403']/code[text()!='']").getText()));
							}
							if(ele.selectSingleNode("templet/title/item1[@id='1_035415']/code[text()!='']")!=null){
							dataMap.put("reviewElement5",  conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_035415']/code[text()!='']").getText()));
							}
							if(ele.selectSingleNode("templet/title/item1[@id='1_035426']/code[text()!='']")!=null){
							dataMap.put("reviewElement6",  conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_035426']/code[text()!='']").getText()));
							}
							dataMap.put("suggest", ele.selectSingleNode("advice").getText());
							dataMap.put("decision", _getDecisionIdById(ele.selectSingleNode("decision").getText()));
							dataMap.put("preCommitteeName", ele.selectSingleNode("sign").getText());
							dataMap.put("signDate", ele.selectSingleNode("date").getText());
							
							
							Map<String,IrbSingleForm> singleFormMap = InitConfig.formRequestUtil.getFormMap().get(formFileName);
							IrbSingleForm singleForm = 	singleFormMap.get("product_yw_1.0");
							String recContent = _getRecContent(formFileName, singleForm.getItemList(), dataMap); 
							rec.setProjFlow(apply.getProjFlow());
							rec.setIrbFlow(irbFlow);
							String irbStageId = apply.getIrbStageId();
							rec.setIrbStageId(irbStageId);
							String irbStageName = apply.getIrbStageName();
							rec.setIrbStageName(irbStageName);
							rec.setRecTypeId(formFileName);
							String nameById = IrbRecTypeEnum.getNameById(formFileName);
							rec.setRecTypeName(nameById);
							rec.setRecVersion("1.0");
							rec.setRecContent(recContent);
							if(_getSysUserByName(ele.selectSingleNode("sign").getText()) !=null){
								rec.setOperUserFlow(_getSysUserByName(ele.selectSingleNode("sign").getText()).getUserFlow());
							
							}irbRecBiz.edit(rec);
						}
						sum++;
				  }
			  }
		  }
		  statement.close();
		  conn.close();
		  
		  return sum;
	}
	@RequestMapping("/synRetrialRevise")
	@ResponseBody
	public  Integer synRetrialRevise() throws Exception{
			Connection conn = null;
		  Class.forName("oracle.jdbc.driver.OracleDriver");//加入oracle的驱动，“”里面是驱动的路径
		   
		  String url = "jdbc:oracle:thin:@192.168.1.11:1521:demo";// 数据库连接，oracle代表链接的是oracle数据库；thin:@MyDbComputerNameOrIP代表的是数据库所在的IP地址（可以保留thin:）；1521代表链接数据库的端口号；ORCL代表的是数据库名称

		  String UserName = "irb";// 数据库用户登陆名 ( 也有说是 schema 名字的 )

		  String Password = "irb123456";// 密码

		  conn = DriverManager.getConnection(url, UserName, Password);
		   int sum = 0;
		  Statement statement = conn.createStatement();
		  ResultSet rs =  statement.executeQuery("select * from project_irb where INSTI_NUMBER='HeN' and IRB_TYPE!='研究进展报告'");
		  while(rs.next()){
			  String irbNo = rs.getString("SQSL_NUM");
			  String content = "";
			  try{
					BufferedReader reader = new BufferedReader(rs.getCharacterStream("IRT_OTHER_INFO"));//项目其它信息xml结构 
					String temp = null;
					StringBuffer sb = new StringBuffer(100);
					int count = 0;
					while((temp=reader.readLine())!=null){
						if(count>0){
							sb.append("\n");
						}
						sb.append(temp);
						count++;
					}
					content = sb.toString();
					reader.close();
				}
				catch(Exception e){
					e.printStackTrace();
				}
			  if(StringUtil.isNotBlank(irbNo)){
				 IrbApplyExample example = new IrbApplyExample();
				 example.createCriteria().andIrbNoEqualTo(irbNo);
				 List<IrbApply> irbList = irbMapper.selectByExample(example);
				  if(irbList != null && irbList.size()>0){
					  IrbApply apply = irbList.get(0);
					  String irbFlow = apply.getIrbFlow();
						if(apply.getIrbTypeId().equals(IrbTypeEnum.Init.getId())){
							//申请表
							
							//审查表
						}else if(apply.getIrbTypeId().equals(IrbTypeEnum.Retrial.getId())){
							//申请表
						
							String formFileName = "RetrialApplication";
							Map<String,String> dataMap = new HashMap<String, String>();
							
							Document dom = DocumentHelper.parseText(content); 
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_023749']/code[text()!='']")!=null){
							dataMap.put("item1", dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_023749']/code[text()!='']").getText());
							}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_023800']/code[text()!='']")!=null){
							dataMap.put("item2", dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_023800']/code[text()!='']").getText());
							}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_023811']/code[text()!='']")!=null){
							dataMap.put("item3", dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_023811']/code[text()!='']").getText());
							}
							dataMap.put("applyManName", dom.selectSingleNode("/irb/applyorreport/applyer").getText());
							dataMap.put("applyDate", dom.selectSingleNode("/irb/applyorreport/applydate").getText());
							
							
							Map<String,IrbSingleForm> singleFormMap = InitConfig.formRequestUtil.getFormMap().get(formFileName);
							IrbSingleForm singleForm = 	singleFormMap.get("product_yw_1.0");
							String recContent = _getRecContent(formFileName, singleForm.getItemList(), dataMap); 
							IrbRec rec = new IrbRec();
							rec.setProjFlow(apply.getProjFlow());
							rec.setIrbFlow(irbFlow);
							String irbStageId = apply.getIrbStageId();
							rec.setIrbStageId(irbStageId);
							String irbStageName = apply.getIrbStageName();
							rec.setIrbStageName(irbStageName);
							rec.setRecTypeId(formFileName);
							String nameById = IrbRecTypeEnum.getNameById(formFileName);
							rec.setRecTypeName(nameById);
							rec.setRecVersion("1.0");
							rec.setRecContent(recContent);
							irbRecBiz.edit(rec);
							
							//审查表
							
							List<Element> workSheet = dom.selectNodes("/irb/reviewworksheet");
							for(Element ele : workSheet){ 
								if(ele.selectSingleNode("templet/title/item1[@id='1_040040']/code[text()!='']")!=null){
								dataMap.put("reviewElement1", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_040040']/code[text()!='']").getText()));
								}
								if(ele.selectSingleNode("templet/title/item1[@id='1_040056']/code[text()!='']")!=null){
								dataMap.put("reviewElement2", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_040056']/code[text()!='']").getText()));
								} 
								
								
								
								dataMap.put("suggest", ele.selectSingleNode("advice").getText());
								dataMap.put("decision", _getDecisionIdById(ele.selectSingleNode("decision").getText()));
								dataMap.put("preCommitteeName", ele.selectSingleNode("sign").getText());
								dataMap.put("signDate", ele.selectSingleNode("date").getText());
								
								formFileName = "RetrialWorksheet";
								singleFormMap = InitConfig.formRequestUtil.getFormMap().get(formFileName);
								singleForm = 	singleFormMap.get("product_yw_1.0");
								recContent = _getRecContent(formFileName, singleForm.getItemList(), dataMap); 
								rec = new IrbRec();
								rec.setProjFlow(apply.getProjFlow());
								rec.setIrbFlow(irbFlow);
								irbStageId = apply.getIrbStageId();
								rec.setIrbStageId(irbStageId);
								irbStageName = apply.getIrbStageName();
								rec.setIrbStageName(irbStageName);
								rec.setRecTypeId(formFileName);
								nameById = IrbRecTypeEnum.getNameById(formFileName);
								rec.setRecTypeName(nameById);
								rec.setRecVersion("1.0");
								rec.setRecContent(recContent);
								if(_getSysUserByName(ele.selectSingleNode("sign").getText()) !=null){
									rec.setOperUserFlow(_getSysUserByName(ele.selectSingleNode("sign").getText()).getUserFlow());
								}
								irbRecBiz.edit(rec);
							}
						}else if(apply.getIrbTypeId().equals(IrbTypeEnum.Revise.getId())){
							//申请表
							
							String formFileName = "ReviseApplication";
							Map<String,String> dataMap = new HashMap<String, String>();
							
							Document dom = DocumentHelper.parseText(content); 
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_010628']/code[text()!='']")!=null){
							dataMap.put("proposeAmender", conversionProposeAmender(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_010628']/code[text()!='']").getText()));
							}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_010753']/code[text()!='']")!=null){
							dataMap.put("reviseCategory",conversionReviseCategory( dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_010753']/code[text()!='']").getText()));
							}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_011249']/code[text()!='']")!=null){
							dataMap.put("isModifyImple", conversionIsModifyImple(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_011249']/code[text()!='']").getText()));
							}
							
							if(dom.selectSingleNode("/irb/applyorreport/templet/title[@id='2']/code[text()!='']")!=null){
								dataMap.put("reviseContentReason", dom.selectSingleNode("/irb/applyorreport/templet/title[@id='2']/code[text()!='']").getText());
							}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='3_011413']/code[text()!='']")!=null){
								dataMap.put("reviseAffect1", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='3_011413']/code[text()!='']").getText()));
							}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='3_011449']/code[text()!='']")!=null){
								dataMap.put("reviseAffect2", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='3_011449']/code[text()!='']").getText()));
							}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='3_011627']/code[text()!='']")!=null){
								dataMap.put("reviseAffect3", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='3_011627']/code[text()!='']").getText()));
							}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='3_011641']/code[text()!='']")!=null){
								dataMap.put("reviseAffect4", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='3_011641']/code[text()!='']").getText()));
							}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='3_011701']/code[text()!='']")!=null){
								dataMap.put("reviseAffect5", conversionProgress7(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='3_011701']/code[text()!='']").getText()));
							}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='3_033318']/code[text()!='']")!=null){
								dataMap.put("reviseAffect6", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='3_033318']/code[text()!='']").getText()));
							}
							dataMap.put("applyManName", dom.selectSingleNode("/irb/applyorreport/applyer").getText());
							dataMap.put("applyDate", dom.selectSingleNode("/irb/applyorreport/applydate").getText());
							
							
							Map<String,IrbSingleForm> singleFormMap = InitConfig.formRequestUtil.getFormMap().get(formFileName);
							IrbSingleForm singleForm = 	singleFormMap.get("product_yw_1.0");
							String recContent = _getRecContent(formFileName, singleForm.getItemList(), dataMap); 
							IrbRec rec = new IrbRec();
							rec.setProjFlow(apply.getProjFlow());
							rec.setIrbFlow(irbFlow);
							String irbStageId = apply.getIrbStageId();
							rec.setIrbStageId(irbStageId);
							String irbStageName = apply.getIrbStageName();
							rec.setIrbStageName(irbStageName);
							rec.setRecTypeId(formFileName);
							String nameById = IrbRecTypeEnum.getNameById(formFileName);
							rec.setRecTypeName(nameById);
							rec.setRecVersion("1.0");
							rec.setRecContent(recContent);
							irbRecBiz.edit(rec);
							
							//审查表
							
							List<Element> workSheet = dom.selectNodes("/irb/reviewworksheet");
							for(Element ele : workSheet){ 
								if(ele.selectSingleNode("templet/title/item1[@id='1_035728']/code[text()!='']")!=null){
								dataMap.put("reviewElement1", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_035728']/code[text()!='']").getText()));
								}
								if(ele.selectSingleNode("templet/title/item1[@id='1_035739']/code[text()!='']")!=null){
								dataMap.put("reviewElement2", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_035739']/code[text()!='']").getText()));
								} 
								if(ele.selectSingleNode("templet/title/item1[@id='1_035751']/code[text()!='']")!=null){
									dataMap.put("reviewElement3", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_035751']/code[text()!='']").getText()));
									}
								if(ele.selectSingleNode("templet/title/item1[@id='1_035802']/code[text()!='']")!=null){
									dataMap.put("reviewElement4", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_035802']/code[text()!='']").getText()));
									}
								if(ele.selectSingleNode("templet/title/item1[@id='1_035812']/code[text()!='']")!=null){
									dataMap.put("reviewElement5", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_035812']/code[text()!='']").getText()));
									}
								if(ele.selectSingleNode("templet/title/item1[@id='1_035823']/code[text()!='']")!=null){
									dataMap.put("reviewElement6", conversionProgress7(ele.selectSingleNode("templet/title/item1[@id='1_035823']/code[text()!='']").getText()));
									}
								if(ele.selectSingleNode("templet/title/item1[@id='1_051840']/code[text()!='']")!=null){
									dataMap.put("reviewElement7", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_051840']/code[text()!='']").getText()));
									}
								if(ele.selectSingleNode("templet/title/item1[@id='1_051854']/code[text()!='']")!=null){
									dataMap.put("reviewElement8", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_051854']/code[text()!='']").getText()));
									}
								if(ele.selectSingleNode("templet/title/item1[@id='1_051908']/code[text()!='']")!=null){
									dataMap.put("reviewElement9", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_051908']/code[text()!='']").getText()));
									}
								
								
								
								dataMap.put("suggest", ele.selectSingleNode("advice").getText());
								dataMap.put("decision", _getDecisionIdById(ele.selectSingleNode("decision").getText()));
								dataMap.put("preCommitteeName", ele.selectSingleNode("sign").getText());
								dataMap.put("signDate", ele.selectSingleNode("date").getText());
								
								formFileName = "ReviseWorksheet";
								singleFormMap = InitConfig.formRequestUtil.getFormMap().get(formFileName);
								singleForm = 	singleFormMap.get("product_yw_1.0");
								recContent = _getRecContent(formFileName, singleForm.getItemList(), dataMap); 
								rec = new IrbRec();
								rec.setProjFlow(apply.getProjFlow());
								rec.setIrbFlow(irbFlow);
								irbStageId = apply.getIrbStageId();
								rec.setIrbStageId(irbStageId);
								irbStageName = apply.getIrbStageName();
								rec.setIrbStageName(irbStageName);
								rec.setRecTypeId(formFileName);
								nameById = IrbRecTypeEnum.getNameById(formFileName);
								rec.setRecTypeName(nameById);
								rec.setRecVersion("1.0");
								rec.setRecContent(recContent);
								if(_getSysUserByName(ele.selectSingleNode("sign").getText()) !=null){
									rec.setOperUserFlow(_getSysUserByName(ele.selectSingleNode("sign").getText()).getUserFlow());
								}
								irbRecBiz.edit(rec);
							}
						}else if(apply.getIrbTypeId().equals(IrbTypeEnum.Sae.getId())){
							
						}else if(apply.getIrbTypeId().equals(IrbTypeEnum.Violate.getId())){
							
						}else if(apply.getIrbTypeId().equals(IrbTypeEnum.Terminate.getId())){
							
						}else if(apply.getIrbTypeId().equals(IrbTypeEnum.Finish.getId())){
							
						}
						sum++;
				  }
			  }
		  }
		  statement.close();
		  conn.close();
		  
		  return sum;
	}
	private String conversionIsModifyImple(String text) {
		if("不适用".equals(text)){
			return "1";
		}else if("是".equals(text)){
			return "2";
		}
		return "";
	}
	private String conversionReviseCategory(String text) {
		if("研究设计".equals(text)){
			return "1";
		}else if("研究步骤".equals(text)){
			return "2";
		}else if("受试者例数".equals(text)){
			return "3";
		}else if("纳入排除标准".equals(text)){
			return "4";
		}else if("干预措施".equals(text)){
			return "5";
		}else if("知情同意书".equals(text)){
			return "6";
		}else if("招募材料".equals(text)){
			return "7";
		}else if("其他".equals(text)){
			return "8";
		}
		return "";
	}
	private String conversionProposeAmender(String text) {
		if("项目资助方".equals(text)){
			return "1";
		}else if("研究中心".equals(text)){
			return "2";
		}else if("主要研究者".equals(text)){
			return "3";
		}
		return "";
	}
	@RequestMapping("/synOther")
	@ResponseBody
	public  Integer synOther() throws Exception{
			Connection conn = null;
		  Class.forName("oracle.jdbc.driver.OracleDriver");//加入oracle的驱动，“”里面是驱动的路径
		   
		  String url = "jdbc:oracle:thin:@192.168.1.11:1521:demo";// 数据库连接，oracle代表链接的是oracle数据库；thin:@MyDbComputerNameOrIP代表的是数据库所在的IP地址（可以保留thin:）；1521代表链接数据库的端口号；ORCL代表的是数据库名称

		  String UserName = "irb";// 数据库用户登陆名 ( 也有说是 schema 名字的 )

		  String Password = "irb123456";// 密码

		  conn = DriverManager.getConnection(url, UserName, Password);
		   int sum = 0;
		  Statement statement = conn.createStatement();
		  ResultSet rs =  statement.executeQuery("select * from project_irb where INSTI_NUMBER='HeN'");
		  while(rs.next()){
			  String irbNo = rs.getString("SQSL_NUM");
			  String content = "";
			  try{
					BufferedReader reader = new BufferedReader(rs.getCharacterStream("IRT_OTHER_INFO"));//项目其它信息xml结构 
					String temp = null;
					StringBuffer sb = new StringBuffer(100);
					int count = 0;
					while((temp=reader.readLine())!=null){
						if(count>0){
							sb.append("\n");
						}
						sb.append(temp);
						count++;
					}
					content = sb.toString();
					reader.close();
				}
				catch(Exception e){
					e.printStackTrace();
				}
			  if(StringUtil.isNotBlank(irbNo)){
				 IrbApplyExample example = new IrbApplyExample();
				 example.createCriteria().andIrbNoEqualTo(irbNo);
				 List<IrbApply> irbList = irbMapper.selectByExample(example);
				  if(irbList != null && irbList.size()>0){
					  IrbApply apply = irbList.get(0);
					  String irbFlow = apply.getIrbFlow();
						if(apply.getIrbTypeId().equals(IrbTypeEnum.Init.getId())){
							//申请表
							
							//审查表
						}else if(apply.getIrbTypeId().equals(IrbTypeEnum.Retrial.getId())){
							
						}else if(apply.getIrbTypeId().equals(IrbTypeEnum.Revise.getId())){
							//申请表
							
							
						}else if(apply.getIrbTypeId().equals(IrbTypeEnum.Sae.getId())){
							//申请表
							
						}else if(apply.getIrbTypeId().equals(IrbTypeEnum.Violate.getId())){

							String formFileName = "ViolateApplication";
							Map<String,String> dataMap = new HashMap<String, String>();
							
							Document dom = DocumentHelper.parseText(content); 
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_080445']/item2[@id='1_080445_080047']/code[text()!='']")!=null){
							dataMap.put("majorViolation1", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_080445']/item2[@id='1_080445_080047']/code[text()!='']").getText()));
							}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_080445']/item2[@id='1_080445_080243']/code[text()!='']")!=null){
								dataMap.put("majorViolation2", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_080445']/item2[@id='1_080445_080243']/code[text()!='']").getText()));
								}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_080445']/item2[@id='1_080445_080349']/code[text()!='']")!=null){
								dataMap.put("majorViolation3", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_080445']/item2[@id='1_080445_080349']/code[text()!='']").getText()));
								}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_080445']/item2[@id='1_080445_080421']/code[text()!='']")!=null){
								dataMap.put("majorViolation4", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_080445']/item2[@id='1_080445_080421']/code[text()!='']").getText()));
								}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_080445']/item2[@id='1_080445_080452']/code[text()!='']")!=null){
								dataMap.put("majorViolation5", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_080445']/item2[@id='1_080445_080452']/code[text()!='']").getText()));
								}
							
							
							
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_033214']/code[text()!='']")!=null){
								dataMap.put("violation1", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_033214']/code[text()!='']").getText()));
								}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_033254']/code[text()!='']")!=null){
								dataMap.put("violation2", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_033254']/code[text()!='']").getText()));
								}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_033328']/code[text()!='']")!=null){
								dataMap.put("violation3", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_033328']/code[text()!='']").getText()));
								}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_031428']/code[text()!='']")!=null){
								dataMap.put("violation4", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_031428']/code[text()!='']").getText()));
								}
							


							
							
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='2_020908']/code[text()!='']")!=null){
								dataMap.put("violationAffect1", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='2_020908']/code[text()!='']").getText()));
								}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='2_020920']/code[text()!='']")!=null){
								dataMap.put("violationAffect2", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='2_020920']/code[text()!='']").getText()));
								}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='2_020933']/code[text()!='']")!=null){
								dataMap.put("violationAffect3", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='2_020933']/code[text()!='']").getText()));
								}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title[@id='3']/code[text()!='']")!=null){
								dataMap.put("violateMeasures", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title[@id='3']/code[text()!='']").getText()));
								}
							
							
							dataMap.put("applyManName", dom.selectSingleNode("/irb/applyorreport/applyer").getText());
							dataMap.put("applyDate", dom.selectSingleNode("/irb/applyorreport/applydate").getText());
							
							
							Map<String,IrbSingleForm> singleFormMap = InitConfig.formRequestUtil.getFormMap().get(formFileName);
							IrbSingleForm singleForm = 	singleFormMap.get("product_yw_1.0");
							String recContent = _getRecContent(formFileName, singleForm.getItemList(), dataMap); 
							IrbRec rec = new IrbRec();
							rec.setProjFlow(apply.getProjFlow());
							rec.setIrbFlow(irbFlow);
							String irbStageId = apply.getIrbStageId();
							rec.setIrbStageId(irbStageId);
							String irbStageName = apply.getIrbStageName();
							rec.setIrbStageName(irbStageName);
							rec.setRecTypeId(formFileName);
							String nameById = IrbRecTypeEnum.getNameById(formFileName);
							rec.setRecTypeName(nameById);
							rec.setRecVersion("1.0");
							rec.setRecContent(recContent);
							irbRecBiz.edit(rec);
							
							//审查表
							
							List<Element> workSheet = dom.selectNodes("/irb/reviewworksheet");
							for(Element ele : workSheet){ 
								if(ele.selectSingleNode("templet/title/item1[@id='1_034648']/code[text()!='']")!=null){
								dataMap.put("reviewElement1", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_034648']/code[text()!='']").getText()));
								}
								if(ele.selectSingleNode("templet/title/item1[@id='1_034701']/code[text()!='']")!=null){
									dataMap.put("reviewElement2", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_034701']/code[text()!='']").getText()));
									}
								if(ele.selectSingleNode("templet/title/item1[@id='1_034713']/code[text()!='']")!=null){
									dataMap.put("reviewElement3", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_034713']/code[text()!='']").getText()));
									}
								if(ele.selectSingleNode("templet/title/item1[@id='1_081338']/code[text()!='']")!=null){
									dataMap.put("reviewElement4", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_081338']/code[text()!='']").getText()));
									}
								if(ele.selectSingleNode("templet/title/item1[@id='1_081430']/code[text()!='']")!=null){
									dataMap.put("reviewElement5", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_081430']/code[text()!='']").getText()));
									}
								if(ele.selectSingleNode("templet/title/item1[@id='1_034724']/code[text()!='']")!=null){
									dataMap.put("reviewElement6", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_034724']/code[text()!='']").getText()));
									}
								
								dataMap.put("suggest", ele.selectSingleNode("advice").getText());
								dataMap.put("decision", _getDecisionIdById(ele.selectSingleNode("decision").getText()));
								dataMap.put("preCommitteeName", ele.selectSingleNode("sign").getText());
								dataMap.put("signDate", ele.selectSingleNode("date").getText());
								
								formFileName = "ViolateWorksheet";
								singleFormMap = InitConfig.formRequestUtil.getFormMap().get(formFileName);
								singleForm = 	singleFormMap.get("product_yw_1.0");
								recContent = _getRecContent(formFileName, singleForm.getItemList(), dataMap); 
								rec = new IrbRec();
								rec.setProjFlow(apply.getProjFlow());
								rec.setIrbFlow(irbFlow);
								irbStageId = apply.getIrbStageId();
								rec.setIrbStageId(irbStageId);
								irbStageName = apply.getIrbStageName();
								rec.setIrbStageName(irbStageName);
								rec.setRecTypeId(formFileName);
								nameById = IrbRecTypeEnum.getNameById(formFileName);
								rec.setRecTypeName(nameById);
								rec.setRecVersion("1.0");
								rec.setRecContent(recContent);
								if(_getSysUserByName(ele.selectSingleNode("sign").getText()) !=null){
									rec.setOperUserFlow(_getSysUserByName(ele.selectSingleNode("sign").getText()).getUserFlow());
								}
								irbRecBiz.edit(rec);
							}
						}else if(apply.getIrbTypeId().equals(IrbTypeEnum.Terminate.getId())){
							
						}else if(apply.getIrbTypeId().equals(IrbTypeEnum.Finish.getId())){
							String formFileName = "FinishApplication";
							Map<String,String> dataMap = new HashMap<String, String>();
							
							Document dom = DocumentHelper.parseText(content); 
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_072757']/code[text()!='']")!=null){
							dataMap.put("projStartTime", (dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_072757']/code[text()!='']").getText()));
							}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_072809']/code[text()!='']")!=null){
								dataMap.put("projEndTime", (dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_072809']/code[text()!='']").getText()));
								}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_072825']/code[text()!='']")!=null){
								dataMap.put("researchProgress1", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_072825']/code[text()!='']").getText()));
								}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_072838']/code[text()!='']")!=null){
								dataMap.put("researchProgress2", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_072838']/code[text()!='']").getText()));
								}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_072838']/code[text()!='']/explain")!=null){
								dataMap.put("progress2Explain", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_072838']/code[text()!='']/explain").getText()));
								}
							if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_081741']/code[text()!='']")!=null){
								dataMap.put("researchProgress3", conversionProgress7(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_081741']/code[text()!='']").getText()));
								}
							
							dataMap.put("applyManName", dom.selectSingleNode("/irb/applyorreport/applyer").getText());
							dataMap.put("applyDate", dom.selectSingleNode("/irb/applyorreport/applydate").getText());
							
							
							Map<String,IrbSingleForm> singleFormMap = InitConfig.formRequestUtil.getFormMap().get(formFileName);
							IrbSingleForm singleForm = 	singleFormMap.get("product_yw_1.0");
							String recContent = _getRecContent(formFileName, singleForm.getItemList(), dataMap); 
							IrbRec rec = new IrbRec();
							rec.setProjFlow(apply.getProjFlow());
							rec.setIrbFlow(irbFlow);
							String irbStageId = apply.getIrbStageId();
							rec.setIrbStageId(irbStageId);
							String irbStageName = apply.getIrbStageName();
							rec.setIrbStageName(irbStageName);
							rec.setRecTypeId(formFileName);
							String nameById = IrbRecTypeEnum.getNameById(formFileName);
							rec.setRecTypeName(nameById);
							rec.setRecVersion("1.0");
							rec.setRecContent(recContent);
							irbRecBiz.edit(rec);
							
							//审查表
							
							List<Element> workSheet = dom.selectNodes("/irb/reviewworksheet");
							for(Element ele : workSheet){ 
								if(ele.selectSingleNode("templet/title/item1[@id='1_034027']/code[text()!='']")!=null){
								dataMap.put("reviewElement1", conversionProgress7(ele.selectSingleNode("templet/title/item1[@id='1_034027']/code[text()!='']").getText()));
								}
								if(ele.selectSingleNode("templet/title/item1[@id='1_034043']/code[text()!='']")!=null){
									dataMap.put("reviewElement2", conversionProgress7(ele.selectSingleNode("templet/title/item1[@id='1_034043']/code[text()!='']").getText()));
									}
								if(ele.selectSingleNode("templet/title/item1[@id='1_034054']/code[text()!='']")!=null){
									dataMap.put("reviewElement3", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_034054']/code[text()!='']").getText()));
									}
								if(ele.selectSingleNode("templet/title/item1[@id='1_034111']/code[text()!='']")!=null){
									dataMap.put("reviewElement4", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_034111']/code[text()!='']").getText()));
									}
								if(ele.selectSingleNode("templet/title/item1[@id='1_034126']/code[text()!='']")!=null){
									dataMap.put("reviewElement5", conversionProgress2(ele.selectSingleNode("templet/title/item1[@id='1_034126']/code[text()!='']").getText()));
									}
								
								
								dataMap.put("suggest", ele.selectSingleNode("advice").getText());
								dataMap.put("decision", _getDecisionIdById(ele.selectSingleNode("decision").getText()));
								dataMap.put("preCommitteeName", ele.selectSingleNode("sign").getText());
								dataMap.put("signDate", ele.selectSingleNode("date").getText());
								
								formFileName = "FinishWorksheet";
								singleFormMap = InitConfig.formRequestUtil.getFormMap().get(formFileName);
								singleForm = 	singleFormMap.get("product_yw_1.0");
								recContent = _getRecContent(formFileName, singleForm.getItemList(), dataMap); 
								rec = new IrbRec();
								rec.setProjFlow(apply.getProjFlow());
								rec.setIrbFlow(irbFlow);
								irbStageId = apply.getIrbStageId();
								rec.setIrbStageId(irbStageId);
								irbStageName = apply.getIrbStageName();
								rec.setIrbStageName(irbStageName);
								rec.setRecTypeId(formFileName);
								nameById = IrbRecTypeEnum.getNameById(formFileName);
								rec.setRecTypeName(nameById);
								rec.setRecVersion("1.0");
								rec.setRecContent(recContent);
								if(_getSysUserByName(ele.selectSingleNode("sign").getText()) !=null){
									rec.setOperUserFlow(_getSysUserByName(ele.selectSingleNode("sign").getText()).getUserFlow());
								}
								irbRecBiz.edit(rec);
							}
						}
						sum++;
				  }
			  }
		  }
		  statement.close();
		  conn.close();
		  
		  return sum;
	}
	@RequestMapping("/synInit")
	@ResponseBody
	public  Integer synInit() throws Exception{
			Connection conn = null;
		  Class.forName("oracle.jdbc.driver.OracleDriver");//加入oracle的驱动，“”里面是驱动的路径
		   
		  String url = "jdbc:oracle:thin:@192.168.1.11:1521:demo";// 数据库连接，oracle代表链接的是oracle数据库；thin:@MyDbComputerNameOrIP代表的是数据库所在的IP地址（可以保留thin:）；1521代表链接数据库的端口号；ORCL代表的是数据库名称

		  String UserName = "irb";// 数据库用户登陆名 ( 也有说是 schema 名字的 )

		  String Password = "irb123456";// 密码

		  conn = DriverManager.getConnection(url, UserName, Password);
		   int sum = 0;
		  Statement statement = conn.createStatement();
		  ResultSet rs =  statement.executeQuery("select * from project_irb where INSTI_NUMBER='HeN' and IRB_TYPE='初始审查申请'");
		  while(rs.next()){
			  String irbNo = rs.getString("SQSL_NUM");
			  String content = "";
			  try{
					BufferedReader reader = new BufferedReader(rs.getCharacterStream("IRT_OTHER_INFO"));//项目其它信息xml结构 
					String temp = null;
					StringBuffer sb = new StringBuffer(100);
					int count = 0;
					while((temp=reader.readLine())!=null){
						if(count>0){
							sb.append("\n");
						}
						sb.append(temp);
						count++;
					}
					content = sb.toString();
					reader.close();
				}
				catch(Exception e){
					e.printStackTrace();
				}
			  if(StringUtil.isNotBlank(irbNo)){
				 IrbApplyExample example = new IrbApplyExample();
				 example.createCriteria().andIrbNoEqualTo(irbNo);
				 List<IrbApply> irbList = irbMapper.selectByExample(example);
				  if(irbList != null && irbList.size()>0){
					  IrbApply apply = irbList.get(0);
					  String irbFlow = apply.getIrbFlow();
						
						String formFileName = "InitApplication";
						Map<String,String> dataMap = new HashMap<String, String>();
						
						Document dom = DocumentHelper.parseText(content); 
						if(dom.selectSingleNode("/irb/irbSetInfo/plantype")!=null){
							dataMap.put("researchType", conversionPlantType(dom.selectSingleNode("/irb/irbSetInfo/plantype").getText()));
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/reviewAnalysis")!=null){
							dataMap.put("obserStudyType", "1");
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/previewAnalysis")!=null){
							dataMap.put("obserStudyType", "2");
						}
//						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_072838']/code[text()!='']")!=null){
//							dataMap.put("pastAcquisition", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_072838']/code[text()!='']").getText()));
//						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content1")!=null){
							dataMap.put("researchInfo1", conversionResearchInfo1(dom.selectSingleNode("/irb/irbSetInfo/content1").getText()));
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content2")!=null){
							dataMap.put("researchInfo2", conversionResearchInfo2(dom.selectSingleNode("/irb/irbSetInfo/content2").getText()));
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content3")!=null){
							dataMap.put("researchInfo3", conversionResearchInfo2(dom.selectSingleNode("/irb/irbSetInfo/content3").getText()));
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content20")!=null){
							dataMap.put("researchInfo4", conversionProgress2(dom.selectSingleNode("/irb/irbSetInfo/content20").getText()));
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content21")!=null){
							dataMap.put("researchInfo41", conversionProgress2(dom.selectSingleNode("/irb/irbSetInfo/content21").getText()));
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content22")!=null){
							dataMap.put("researchInfo42", conversionProgress2(dom.selectSingleNode("/irb/irbSetInfo/content22").getText()));
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content4")!=null){
							dataMap.put("researchInfo5", conversionProgress2(dom.selectSingleNode("/irb/irbSetInfo/content4").getText()));
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content5")!=null){
							dataMap.put("researchInfo51", conversionProgress2(dom.selectSingleNode("/irb/irbSetInfo/content5").getText()));
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content6")!=null){
							dataMap.put("researchInfo52", conversionProgress2(dom.selectSingleNode("/irb/irbSetInfo/content6").getText()));
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content7")!=null){
							dataMap.put("researchInfo53", conversionProgress2(dom.selectSingleNode("/irb/irbSetInfo/content7").getText()));
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content7")!=null){
							dataMap.put("researchInfo6", conversionResearchInfo6(dom.selectSingleNode("/irb/irbSetInfo/content7").getText()));
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content9")!=null){
							dataMap.put("recruSubject1", conversionRecruSubject1(dom.selectSingleNode("/irb/irbSetInfo/content9").getText()));
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content10")!=null){
							if("广告".equals(dom.selectSingleNode("/irb/irbSetInfo/content10").getText())){
								dataMap.put("recruSubject2", "1");
							}else if("诊疗过程".equals(dom.selectSingleNode("/irb/irbSetInfo/content10").getText())){
								dataMap.put("recruSubject2", "2");
							}else if("数据库".equals(dom.selectSingleNode("/irb/irbSetInfo/content10").getText())){
								dataMap.put("recruSubject2", "3");
							}else if("中介".equals(dom.selectSingleNode("/irb/irbSetInfo/content10").getText())){
								dataMap.put("recruSubject2", "4");
							}else if("其它".equals(dom.selectSingleNode("/irb/irbSetInfo/content10").getText())){
								dataMap.put("recruSubject2", "5");
							}
						}
						
						if(dom.selectSingleNode("/irb/irbSetInfo/content11")!=null){
							if("健康者".equals(dom.selectSingleNode("/irb/irbSetInfo/content11").getText())){
								dataMap.put("recruSubject3", "1");
							}else if("患者".equals(dom.selectSingleNode("/irb/irbSetInfo/content11").getText())){
								dataMap.put("recruSubject3", "2");
							}else if("弱势群体".equals(dom.selectSingleNode("/irb/irbSetInfo/content11").getText())){
								dataMap.put("recruSubject3", "3");
							}else if("孕妇".equals(dom.selectSingleNode("/irb/irbSetInfo/content11").getText())){
								dataMap.put("recruSubject3", "4");
							}
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content12")!=null){
							if("儿童/未成年人".equals(dom.selectSingleNode("/irb/irbSetInfo/content12").getText())){
								dataMap.put("recruSubject31", "1");
							}else if("认知障碍或健康状况而没有能力做出知情同意的成人".equals(dom.selectSingleNode("/irb/irbSetInfo/content12").getText())){
								dataMap.put("recruSubject31", "2");
							}else if("申办者/研究者的雇员或学生".equals(dom.selectSingleNode("/irb/irbSetInfo/content12").getText())){
								dataMap.put("recruSubject31", "3");
							}else if("教育/经济地位低下的人员".equals(dom.selectSingleNode("/irb/irbSetInfo/content12").getText())){
								dataMap.put("recruSubject31", "4");
							}else if("疾病终末期患者".equals(dom.selectSingleNode("/irb/irbSetInfo/content12").getText())){
								dataMap.put("recruSubject31", "5");
							}else if("囚犯".equals(dom.selectSingleNode("/irb/irbSetInfo/content12").getText())){
								dataMap.put("recruSubject31", "6");
							}else if("其他".equals(dom.selectSingleNode("/irb/irbSetInfo/content12").getText())){
								dataMap.put("recruSubject31", "7");
							}
						}
						
						if(dom.selectSingleNode("/irb/irbSetInfo/other_content")!=null){
							dataMap.put("recruSubject31_other",dom.selectSingleNode("/irb/irbSetInfo/other_content").getText());
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content13")!=null){
							if("临床判断".equals(dom.selectSingleNode("/irb/irbSetInfo/content13").getText())){
								dataMap.put("recruSubject32", "1");
							}else if("量表".equals(dom.selectSingleNode("/irb/irbSetInfo/content13").getText())){
								dataMap.put("recruSubject32", "2");
							}else if("仪器".equals(dom.selectSingleNode("/irb/irbSetInfo/content13").getText())){
								dataMap.put("recruSubject32", "3");
							}
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content14")!=null){
							if("不适用".equals(dom.selectSingleNode("/irb/irbSetInfo/content14").getText())){
								dataMap.put("recruSubject33", "1");
							}else if("没有通过经济利益引诱其中止妊娠".equals(dom.selectSingleNode("/irb/irbSetInfo/content14").getText())){
								dataMap.put("recruSubject33", "2");
							}else if("研究人员不参与中止妊娠的决策".equals(dom.selectSingleNode("/irb/irbSetInfo/content14").getText())){
								dataMap.put("recruSubject33", "3");
							}else if("研究人员不参与新生儿生存能力的判断".equals(dom.selectSingleNode("/irb/irbSetInfo/content14").getText())){
								dataMap.put("recruSubject33", "3");
							}
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content23")!=null){
							if("是否合理考虑了研究对特殊疾病人群、特定地区人群/族群造成的影响".equals(dom.selectSingleNode("/irb/irbSetInfo/content23").getText())){
								dataMap.put("recruSubject34", "1");
							}else if("是否合理考虑了外界因素对个人知情同意的影响".equals(dom.selectSingleNode("/irb/irbSetInfo/content23").getText())){
								dataMap.put("recruSubject34", "2");
							}else if("是否有向该人群/族群进行咨询的计划".equals(dom.selectSingleNode("/irb/irbSetInfo/content23").getText())){
								dataMap.put("recruSubject34", "3");
							}else if("研究是否包括促进地区医疗保健与研究能力发展的计划".equals(dom.selectSingleNode("/irb/irbSetInfo/content23").getText())){
								dataMap.put("recruSubject34", "3");
							}
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content15")!=null){
							dataMap.put("recruSubject35", conversionResearchInfo2(dom.selectSingleNode("/irb/irbSetInfo/content15").getText()));
						}
						
						
						if(dom.selectSingleNode("/irb/irbSetInfo/sum")!=null){
							dataMap.put("sum", (dom.selectSingleNode("/irb/irbSetInfo/sum").getText()));
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/fashion")!=null){
							if("按随访观察时点，分次支付".equals(dom.selectSingleNode("/irb/irbSetInfo/fashion").getText())){
								dataMap.put("payType", "1");
							}else if("按完成的随访观察工作量，一次性支付".equals(dom.selectSingleNode("/irb/irbSetInfo/fashion").getText())){
								dataMap.put("payType", "2");
							}else if("完成全部随访观察后支付".equals(dom.selectSingleNode("/irb/irbSetInfo/fashion").getText())){
								dataMap.put("payType", "3");
							}
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content16")!=null){
							if("医生/研究者".equals(dom.selectSingleNode("/irb/irbSetInfo/content16").getText())){
								dataMap.put("informProcess1", "1");
							}else if("医生".equals(dom.selectSingleNode("/irb/irbSetInfo/content16").getText())){
								dataMap.put("informProcess1", "2");
							}else if("研究者".equals(dom.selectSingleNode("/irb/irbSetInfo/content16").getText())){
								dataMap.put("informProcess1", "3");
							}else if("研究护士".equals(dom.selectSingleNode("/irb/irbSetInfo/content16").getText())){
								dataMap.put("informProcess1", "4");
							}else if("研究助理".equals(dom.selectSingleNode("/irb/irbSetInfo/content16").getText())){
								dataMap.put("informProcess1", "5");
							}
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content17")!=null){
							if("私密房间/受试者接待室".equals(dom.selectSingleNode("/irb/irbSetInfo/content17").getText())){
								dataMap.put("informProcess2", "1");
							}else if("诊室".equals(dom.selectSingleNode("/irb/irbSetInfo/content17").getText())){
								dataMap.put("informProcess2", "2");
							}else if("病房".equals(dom.selectSingleNode("/irb/irbSetInfo/content17").getText())){
								dataMap.put("informProcess2", "3");
							}else if("其它".equals(dom.selectSingleNode("/irb/irbSetInfo/content17").getText())){
								dataMap.put("informProcess2", "4");
							}
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/content18")!=null){
							if("受试者签字".equals(dom.selectSingleNode("/irb/irbSetInfo/content18").getText())){
								dataMap.put("informProcess3", "1");
							}else if("法定代理人签字".equals(dom.selectSingleNode("/irb/irbSetInfo/content18").getText())){
								dataMap.put("informProcess3", "2");
							}
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/con")!=null){
							dataMap.put("informException", dom.selectSingleNode("/irb/irbSetInfo/con").getText());
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104214']/item2[@id='1_104214_104247']/code[text()!='']")!=null){
							dataMap.put("informException11", conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104214']/item2[@id='1_104214_104247']/code[text()!='']").getText()));
						}
						
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104214']/item2[@id='1_104214_104332']/code[text()!='']")!=null){
							dataMap.put("informException12",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104214']/item2[@id='1_104214_104332']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104214']/item2[@id='1_104214_104458']/code[text()!='']")!=null){
						dataMap.put("informException13",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104214']/item2[@id='1_104214_104458']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104642']/item2[@id='1_104642_104704']/code[text()!='']")!=null){
						dataMap.put("informException14",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104642']/item2[@id='1_104642_104704']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104642']/item2[@id='1_104642_104803']/code[text()!='']")!=null){
							dataMap.put("informException15",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104642']/item2[@id='1_104642_104803']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104642']/item2[@id='1_104642_104845']/code[text()!='']")!=null){
							dataMap.put("informException16",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104642']/item2[@id='1_104642_104845']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104642']/item2[@id='1_104642_104940']/code[text()!='']")!=null){
							dataMap.put("informException17",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104642']/item2[@id='1_104642_104940']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104642']/item2[@id='1_104642_105024']/code[text()!='']")!=null){
							dataMap.put("informException18",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104642']/item2[@id='1_104642_105024']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104642']/item2[@id='1_104642_105113']/code[text()!='']")!=null){
							dataMap.put("informException19",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104642']/item2[@id='1_104642_105113']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104642']/item2[@id='1_104642_105158']/code[text()!='']")!=null){
							dataMap.put("informException110",(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104642']/item2[@id='1_104642_105158']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104642']/item2[@id='1_104642_105458']/code[text()!='']")!=null){
							dataMap.put("informException111",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_104642']/item2[@id='1_104642_105458']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_105933']/item2[@id='1_105933_105952']/code[text()!='']")!=null){
							dataMap.put("informException21",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_105933']/item2[@id='1_105933_105952']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_110047']/item2[@id='1_110047_110108']/code[text()!='']")!=null){
							dataMap.put("informException22",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_110047']/item2[@id='1_110047_110108']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_110047']/item2[@id='1_110047_110816']/code[text()!='']")!=null){
							dataMap.put("informException23",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_110047']/item2[@id='1_110047_110816']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_110047']/item2[@id='1_110047_110940']/code[text()!='']")!=null){
							dataMap.put("informException24",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_110047']/item2[@id='1_110047_110940']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_110047']/item2[@id='1_110047_111031']/code[text()!='']")!=null){
							dataMap.put("informException25",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_110047']/item2[@id='1_110047_111031']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_110047']/item2[@id='1_110047_111201']/code[text()!='']")!=null){
							dataMap.put("informException26",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_110047']/item2[@id='1_110047_111201']/code[text()!='']").getText()));
						}
//						
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_112127']/item2[@id='1_112127_112156']/code[text()!='']")!=null){
							dataMap.put("informException31",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_042256']/item2[@id='1_042256_042338']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_112139']/item2[@id='1_112139_112343']/code[text()!='']")!=null){
							dataMap.put("informException32",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_112139']/item2[@id='1_112139_112343']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_112139']/item2[@id='1_112139_112420']/code[text()!='']")!=null){
							dataMap.put("informException33",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_042304']/item2[@id='1_112139_112420']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_112139']/item2[@id='1_112139_112509']/code[text()!='']")!=null){
							dataMap.put("informException34",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_042304']/item2[@id='1_112139_112509']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_113434']/item2[@id='1_113434_113543']/code[text()!='']")!=null){
							dataMap.put("informException41",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_113434']/item2[@id='1_113434_113543']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_113519']/item2[@id='1_113519_113650']/code[text()!='']")!=null){
							dataMap.put("informException42",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_113519']/item2[@id='1_113519_113650']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_113519']/item2[@id='1_113519_124011']/code[text()!='']")!=null){
							dataMap.put("informException43",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_113519']/item2[@id='1_113519_124011']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_113519']/item2[@id='1_113519_124029']/code[text()!='']")!=null){
							dataMap.put("informException44",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_113519']/item2[@id='1_113519_124029']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_124328']/item2[@id='1_124328_124357']/code[text()!='']")!=null){
							dataMap.put("informException51",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_124328']/item2[@id='1_124328_124357']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_124340']/item2[@id='1_124340_124432']/code[text()!='']")!=null){
							dataMap.put("informException52",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_124340']/item2[@id='1_124340_124432']/code[text()!='']").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_124340']/item2[@id='1_124340_124447']/code[text()!='']")!=null){
							dataMap.put("informException53",conversionProgress2(dom.selectSingleNode("/irb/applyorreport/templet/title/item1[@id='1_124340']/item2[@id='1_124340_124447']/code[text()!='']").getText()));
						}
						dataMap.put("researcherDeclare", "1");
						if(dom.selectSingleNode("/irb/irbSetInfo/count1")!=null){
							dataMap.put("inProjNum", (dom.selectSingleNode("/irb/irbSetInfo/count1").getText()));
						}
						if(dom.selectSingleNode("/irb/irbSetInfo/count2")!=null){
							dataMap.put("targetProjNum", (dom.selectSingleNode("/irb/irbSetInfo/count2").getText()));
						}
						if(dom.selectSingleNode("/irb/applyorreport/applyer")!=null){
						dataMap.put("applyManName", dom.selectSingleNode("/irb/applyorreport/applyer").getText());
						}
						if(dom.selectSingleNode("/irb/applyorreport/applydate")!=null){
						dataMap.put("applyDate", dom.selectSingleNode("/irb/applyorreport/applydate").getText());
						}
						
						Map<String,IrbSingleForm> singleFormMap = InitConfig.formRequestUtil.getFormMap().get(formFileName);
						IrbSingleForm singleForm = 	singleFormMap.get("product_yw_1.0");
						String recContent = _getRecContent(formFileName, singleForm.getItemList(), dataMap); 
						IrbRec rec = new IrbRec();
						rec.setProjFlow(apply.getProjFlow());
						rec.setIrbFlow(irbFlow);
						String irbStageId = apply.getIrbStageId();
						rec.setIrbStageId(irbStageId);
						String irbStageName = apply.getIrbStageName();
						rec.setIrbStageName(irbStageName);
						rec.setRecTypeId(formFileName);
						String nameById = IrbRecTypeEnum.getNameById(formFileName);
						rec.setRecTypeName(nameById);
						rec.setRecVersion("1.0");
						rec.setRecContent(recContent);
						irbRecBiz.edit(rec);
						
						//审查表
						sum++;
				  }
			  }
		  }
		  statement.close();
		  conn.close();
		  
		  return sum;
	}
	private String conversionRecruSubject1(String text) {
		if("医生".equals(text)){
			return "1";
		}else if("研究者".equals(text)){
			return "2";
		}else if("研究助理".equals(text)){
			return "3";
		}else if("研究护士".equals(text)){
			return "4";
		}else if("其他".equals(text)){
			return "5";
		}
		return "";
	}
	private String conversionResearchInfo6(String text) {
		if("Ⅰ类".equals(text)){
			return "1";
		}else if("Ⅱ类".equals(text)){
			return "2";
		}else if("Ⅲ类".equals(text)){
			return "3";
		}
		return "";
	}
	private String conversionResearchInfo2(String text) {
		if("有".equals(text)){
			return "1";
		}else if("无".equals(text)){
			return "0";
		}
		return "";
	}
	private String conversionResearchInfo1(String text) {
		if("企业".equals(text)){
			return "1";
		}else if("政府".equals(text)){
			return "2";
		}else if("学术团体".equals(text)){
			return "3";
		}else if("本单位".equals(text)){
			return "4";
		}else if("自筹".equals(text)){
			return "5";
		}
		return "";
	}
	private String conversionPlantType(String text) {
		if("实验性研究".equals(text)){
			return "1";
		}else if("观察性研究".equals(text)){
			return "2";
		}else if("利用人的生物标本的研究".equals(text)){
			return "3";
		}
		return "";
	}
	
	
	@RequestMapping("/synThesis")
	@ResponseBody
	public  Integer  synThesis(PubFileForm fileForm ,HttpServletRequest req) throws Exception {
		Connection conn = null; 
		  Class.forName("oracle.jdbc.driver.OracleDriver");//加入oracle的驱动，“”里面是驱动的路径
		   
		  String url = "jdbc:oracle:thin:@192.168.1.11:1521:demo";// 数据库连接，oracle代表链接的是oracle数据库；thin:@MyDbComputerNameOrIP代表的是数据库所在的IP地址（可以保留thin:）；1521代表链接数据库的端口号；ORCL代表的是数据库名称

		  String UserName = "irb";// 数据库用户登陆名 ( 也有说是 schema 名字的 )

		  String Password = "irb123456";// 密码

		  conn = DriverManager.getConnection(url, UserName, Password);
		   int sum = 0;
		  Statement statement = conn.createStatement();
		  Statement statement1 = conn.createStatement();
		  ResultSet rs =  statement.executeQuery("select * from paper_info where INSTI_NUMBER='HeN'");
		  while(rs.next()){
			  SrmAchThesis thesis = new SrmAchThesis();
			  thesis.setThesisFlow(rs.getString("PAPER_FLOW"));
			  thesis.setThesisName(rs.getString("PP_THEME"));
			  thesis.setPublishJour(rs.getString("PP_PERIODICAL"));
			  thesis.setPublishDate(rs.getString("PP_YEAR"));
			  
			  thesis.setVolumeCode(rs.getString("PP_BOOK"));
			  thesis.setJourCode(rs.getString("PP_PERIOD"));
			  
			  if(StringUtil.isEquals(rs.getString("PP_BEGINPAGE"), rs.getString("PP_ENDPAGE"))){
				  thesis.setPageNoRange(rs.getString("PP_BEGINPAGE"));
			  }else {
				  thesis.setPageNoRange(rs.getString("PP_BEGINPAGE")+"-"+rs.getString("PP_ENDPAGE"));
			  }
			  GeneralMethod.setRecordInfo(thesis, true);
			  thesis.setOperStatusId(AchStatusEnum.FirstAudit.getId());
			  thesis.setOperStatusName(AchStatusEnum.FirstAudit.getName());
			  
			 
			  ResultSet rs1 =  statement1.executeQuery("select * from paper_user where PAPER_FLOW='"+thesis.getThesisFlow()+"' ");
			  if(rs1.next()){
				  SrmAchThesisAuthor author = new SrmAchThesisAuthor();
				  author.setAuthorFlow(PkUtil.getUUID());
				  author.setThesisFlow(thesis.getThesisFlow());
				  if("第1作者".equals(rs1.getString("PP_USER_TYPE"))){
					  author.setTypeId("1");
					  author.setTypeName("第一作者");
				  }else if("通讯作者".equals(rs1.getString("PP_USER_TYPE"))){
					  author.setTypeId("0");
					  author.setTypeName("通讯作者");
					  author.setIsCorresponding("1");
				  }
				  author.setAuthorName(rs1.getString("USER_NAME"));
				  GeneralMethod.setRecordInfo(author, true);
				  thesisAuthorMapper.insert(author);
				  
				  thesis.setApplyOrgFlow("24708495ccdc4c3da3affdd1ebce474b");
				  thesis.setApplyOrgName("河南中医学院第一附属医院");
				  thesis.setApplyUserFlow(_getSysUserByName(author.getAuthorName()).getUserFlow());
				  thesis.setApplyUserName(author.getAuthorName());
			  }
			  thesisMapper.insert(thesis);
			 sum++;
		  }
		  statement.close();
		  conn.close();
		  return sum;
	}
	@RequestMapping("/synBook")
	@ResponseBody
	public  Integer  synBook() throws Exception {
		Connection conn = null; 
		  Class.forName("oracle.jdbc.driver.OracleDriver");//加入oracle的驱动，“”里面是驱动的路径
		   
		  String url = "jdbc:oracle:thin:@192.168.1.11:1521:demo";// 数据库连接，oracle代表链接的是oracle数据库；thin:@MyDbComputerNameOrIP代表的是数据库所在的IP地址（可以保留thin:）；1521代表链接数据库的端口号；ORCL代表的是数据库名称

		  String UserName = "irb";// 数据库用户登陆名 ( 也有说是 schema 名字的 )

		  String Password = "irb123456";// 密码

		  conn = DriverManager.getConnection(url, UserName, Password);
		   int sum = 0;
		  Statement statement = conn.createStatement();
		  Statement statement1 = conn.createStatement();
		  ResultSet rs =  statement.executeQuery("select * from LItERaTURE_INFO where INSTI_NUMBER='HeN'");
		  while(rs.next()){
			  SrmAchBook book = new SrmAchBook();
			  book.setBookFlow(rs.getString("LItERaTURE_FLOW"));
			  book.setBookName(rs.getString("LT_NAME"));
			  book.setPublishOrg(rs.getString("LT_PUBLISHER"));
			  book.setPubPlaceName(rs.getString("LT_PUBLISHADDR"));
			  book.setOperStatusId(AchStatusEnum.FirstAudit.getId());
			  book.setOperStatusName(AchStatusEnum.FirstAudit.getName());
			  book.setPublishDate(rs.getString("LT_YEAR"));
			  book.setIsbnCode(rs.getString("LT_VERSION"));
			  GeneralMethod.setRecordInfo(book, true);
			  
			 
			  ResultSet rs1 =  statement1.executeQuery("select * from LItERaTURE_USER where LItERaTURE_FLOW='"+book.getBookFlow()+"' ");
			  if(rs1.next()){
				  SrmAchBookAuthor author = new SrmAchBookAuthor();
				  author.setAuthorFlow(PkUtil.getUUID());
				  author.setBookFlow(book.getBookFlow());
				  
				  if("编委".equals(rs1.getString("lt_user_type"))){ 
					  author.setWriteTypeId("4");
					  author.setWriteTypeName("编委");
				  }else if("副主编".equals(rs1.getString("lt_user_type"))){
					  author.setWriteTypeId("3");
					  author.setWriteTypeName("副主编");
				  }else if("主编".equals(rs1.getString("lt_user_type"))){
					  author.setWriteTypeId("1");
					  author.setWriteTypeName("主编");
				  }
				  author.setAuthorName(rs1.getString("USER_NAME"));
				  GeneralMethod.setRecordInfo(author, true);
				 bookAuthorMapper.insert(author);
				  
				  book.setApplyOrgFlow("24708495ccdc4c3da3affdd1ebce474b");
				  book.setApplyOrgName("河南中医学院第一附属医院");
				  book.setApplyUserFlow(_getSysUserByName(author.getAuthorName()).getUserFlow());
				  book.setApplyUserName(author.getAuthorName());
			  }
			  bookMapper.insert(book);
			 sum++;
		  }
		  statement.close();
		  conn.close();
		  return sum;
	}
	@RequestMapping("/synPatent")
	@ResponseBody
	public  Integer  synPatent() throws Exception {
		Connection conn = null; 
		  Class.forName("oracle.jdbc.driver.OracleDriver");//加入oracle的驱动，“”里面是驱动的路径
		   
		  String url = "jdbc:oracle:thin:@192.168.1.11:1521:demo";// 数据库连接，oracle代表链接的是oracle数据库；thin:@MyDbComputerNameOrIP代表的是数据库所在的IP地址（可以保留thin:）；1521代表链接数据库的端口号；ORCL代表的是数据库名称

		  String UserName = "irb";// 数据库用户登陆名 ( 也有说是 schema 名字的 )

		  String Password = "irb123456";// 密码

		  conn = DriverManager.getConnection(url, UserName, Password);
		   int sum = 0;
		  Statement statement = conn.createStatement();
		  Statement statement1 = conn.createStatement();
		  ResultSet rs =  statement.executeQuery("select * from PATENT_INFO where INSTI_NUMBER='HeN'");
		  while(rs.next()){
			  SrmAchPatent patent = new SrmAchPatent();
			  patent.setPatentFlow(rs.getString("pa_flow"));
			  patent.setPatentName(rs.getString("pa_name"));
			  
			  if("发明专利".equals(rs.getString("PA_TYPE"))){
				  patent.setTypeId("1");
				  patent.setTypeName("发明专利");
			  }else if("实用新型专利".equals(rs.getString("PA_TYPE"))){
				  patent.setTypeId("2");
				  patent.setTypeName(" 实用新型");
			  }
			  patent.setApplyDate(rs.getString("apply_date"));
			  patent.setApplyCode(rs.getString("apply_no"));
			  patent.setOpenCode(rs.getString("patent_no"));
			  patent.setAuthorizeDate(rs.getString("accredit_date"));
			  patent.setAuthorizeCode(rs.getString("letter_no"));
			  patent.setOperStatusId(AchStatusEnum.FirstAudit.getId());
			  patent.setOperStatusName(AchStatusEnum.FirstAudit.getName());
			  GeneralMethod.setRecordInfo(patent, true);
			  
			 
			  ResultSet rs1 =  statement1.executeQuery("select * from patent_USER where pa_FLOW='"+patent.getPatentFlow()+"' ");
			  if(rs1.next()){
				  SrmAchPatentAuthor author = new SrmAchPatentAuthor();
				  author.setAuthorFlow(PkUtil.getUUID());
				  author.setPatentFlow(patent.getPatentFlow());
				  
				  
				  author.setAuthorName(rs1.getString("USER_NAME"));
				  GeneralMethod.setRecordInfo(author, true);
				 patentAuthorMapper.insert(author);
				  
				 patent.setApplyOrgFlow("24708495ccdc4c3da3affdd1ebce474b");
				 patent.setApplyOrgName("河南中医学院第一附属医院");
				 patent.setApplyUserFlow(_getSysUserByName(author.getAuthorName()).getUserFlow());
				 patent.setApplyUserName(author.getAuthorName());
			  }
			  patentMapper.insert(patent);
			 sum++;
		  }
		  statement.close();
		  conn.close();
		  return sum;
	}
	@RequestMapping("/synSat")
	@ResponseBody
	public  Integer  synSat() throws Exception {
		Connection conn = null; 
		  Class.forName("oracle.jdbc.driver.OracleDriver");//加入oracle的驱动，“”里面是驱动的路径
		   
		  String url = "jdbc:oracle:thin:@192.168.1.11:1521:demo";// 数据库连接，oracle代表链接的是oracle数据库；thin:@MyDbComputerNameOrIP代表的是数据库所在的IP地址（可以保留thin:）；1521代表链接数据库的端口号；ORCL代表的是数据库名称

		  String UserName = "irb";// 数据库用户登陆名 ( 也有说是 schema 名字的 )

		  String Password = "irb123456";// 密码

		  conn = DriverManager.getConnection(url, UserName, Password);
		   int sum = 0;
		  Statement statement = conn.createStatement();
		  Statement statement1 = conn.createStatement();
		  ResultSet rs =  statement.executeQuery("select * from PRICE_INFO where INSTI_NUMBER='HeN'");
		  while(rs.next()){
			  SrmAchSat sat = new SrmAchSat();
			  sat.setSatFlow(rs.getString("pr_flow"));
			  sat.setSatName(rs.getString("pr_name"));
			  sat.setPrizedDate(rs.getString("pr_date"));
			  sat.setProjSourceName(rs.getString("pr_dept"));
			  sat.setPrizedLevelName(rs.getString("pr_level"));
			  
			  sat.setOperStatusId(AchStatusEnum.FirstAudit.getId());
			  sat.setOperStatusName(AchStatusEnum.FirstAudit.getName());
			  GeneralMethod.setRecordInfo(sat, true);
			  
			 
			  ResultSet rs1 =  statement1.executeQuery("select * from PRICE_USER where pr_FLOW='"+sat.getSatFlow()+"' ");
			  if(rs1.next()){
				  SrmAchSatAuthor author = new SrmAchSatAuthor();
				  author.setAuthorFlow(PkUtil.getUUID());
				  author.setSatFlow(sat.getSatFlow());
				  author.setAuthorName(rs1.getString("USER_NAME"));
				  GeneralMethod.setRecordInfo(author, true);
				satAuthorMapper.insert(author);
				  
				sat.setApplyOrgFlow("24708495ccdc4c3da3affdd1ebce474b");
				sat.setApplyOrgName("河南中医学院第一附属医院");
				sat.setApplyUserFlow(_getSysUserByName(author.getAuthorName()).getUserFlow());
				sat.setApplyUserName(author.getAuthorName());
			  }
			  satMapper.insert(sat);
			 sum++;
		  }
		  statement.close();
		  conn.close();
		  return sum;
	}
}
