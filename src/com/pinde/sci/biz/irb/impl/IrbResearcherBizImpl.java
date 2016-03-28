package com.pinde.sci.biz.irb.impl;

import java.util.List;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.irb.IIrbRecBiz;
import com.pinde.sci.biz.irb.IIrbResearcherBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.IrbApplyMapper;
import com.pinde.sci.dao.base.IrbProcessMapper;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.dao.base.SysDeptMapper;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.dao.sys.SysUserExtMapper;
import com.pinde.sci.enums.irb.IrbRecTypeEnum;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.form.irb.IrbApplyFileForm;
import com.pinde.sci.form.sys.SysUserForm;
import com.pinde.sci.model.irb.ProjInfoForm;
import com.pinde.sci.model.mo.IrbApply;
import com.pinde.sci.model.mo.IrbApplyExample;
import com.pinde.sci.model.mo.IrbApplyExample.Criteria;
import com.pinde.sci.model.mo.IrbProcess;
import com.pinde.sci.model.mo.IrbProcessExample;
import com.pinde.sci.model.mo.IrbRec;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjExample;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysDeptExample;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserExample;

@Service
@Transactional(rollbackFor=Exception.class)
public class IrbResearcherBizImpl implements IIrbResearcherBiz {
	@Autowired
	private PubProjMapper projMapper;
	@Autowired
	private SysDeptMapper deptMapper;
	@Autowired
	private SysUserMapper userMapper;
	@Autowired
	private IrbApplyMapper applyMapper;
	@Autowired
	private IFileBiz fileBiz;
	@Autowired
	private IIrbRecBiz irbRecBiz;
	@Autowired
	private IrbProcessMapper processMapper;
	@Autowired
	private SysUserExtMapper sysUserExtMapper;
	@Autowired
	private IUserBiz userBiz;
	

	@Override
	public List<PubProj> searchProjList(PubProj proj) {
		PubProjExample example = new PubProjExample();
		com.pinde.sci.model.mo.PubProjExample.Criteria criteria =  example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(proj.getProjNo())){
			criteria.andProjNoEqualTo(proj.getProjNo());
		}
		if(StringUtil.isNotBlank(proj.getProjShortName())){
			criteria.andProjShortNameLike("%"+proj.getProjShortName()+"%");
		}
		if(StringUtil.isNotBlank(proj.getApplyOrgFlow())){
			criteria.andApplyOrgFlowEqualTo(proj.getApplyOrgFlow());
		}
		
		if(StringUtil.isNotBlank(proj.getApplyDeptFlow())){
			criteria.andApplyDeptFlowEqualTo(proj.getApplyDeptFlow());
		}
		
		if(StringUtil.isNotBlank(proj.getApplyUserName())){
			criteria.andApplyUserNameEqualTo(proj.getApplyUserName());
		}
		if(StringUtil.isNotBlank(proj.getApplyUserFlow())){
			criteria.andApplyUserFlowEqualTo(proj.getApplyUserFlow());
		}
		example.setOrderByClause("PROJ_NO");
		return projMapper.selectByExample(example);
	}

	@Override
	public ProjInfoForm readProjInfoForm(String projFlow) {
		ProjInfoForm infoForm = new ProjInfoForm();
		PubProj proj =  projMapper.selectByPrimaryKey(projFlow);
		//infoForm.set
		String content = proj.getProjInfo();
		proj.setProjInfo("");
		infoForm.setProj(proj);
		if(StringUtil.isNotBlank(content)){
			try {
				Document doc = DocumentHelper.parseText(content);
				//****************一般信息****************
				Node generalInfoNode = doc.selectSingleNode("projInfo/generalInfo");
				if(generalInfoNode != null ){
					//注册分类
					Node registCategoryNode = generalInfoNode.selectSingleNode("registCategory");
					infoForm.setRegistCategory(registCategoryNode==null?"":registCategoryNode.getText());
					//组长/参与
					Node isLeaderNode = generalInfoNode.selectSingleNode("isLeader");
					infoForm.setIsLeader(isLeaderNode==null?"":isLeaderNode.getText());
					//国际多中心
					Node interMulCenterNode = generalInfoNode.selectSingleNode("interMulCenter");
					infoForm.setInterMulCenter(interMulCenterNode==null?"":interMulCenterNode.getText());
				}
				
				//****************申办者****************
				Node declarerNode = doc.selectSingleNode("projInfo/declarer");
				if(declarerNode != null ){
					//申办者地址
					Node declarerAddressNode = declarerNode.selectSingleNode("declarerAddress");
					infoForm.setDeclarerAddress(declarerAddressNode==null?"":declarerAddressNode.getText());
					//申办者邮编
					Node declarerZipNode = declarerNode.selectSingleNode("declarerZip");
					infoForm.setDeclarerZip(declarerZipNode==null?"":declarerZipNode.getText());
					//申办者联系人
					Node dLinkManNode = declarerNode.selectSingleNode("dLinkMan");
					infoForm.setdLinkMan(dLinkManNode==null?"":dLinkManNode.getText());
					//申办者联系人手机
					Node dLinkManPhoneNode = declarerNode.selectSingleNode("dLinkManPhone");
					infoForm.setdLinkManPhone(dLinkManPhoneNode==null?"":dLinkManPhoneNode.getText());
					//申办者联系人邮箱
					Node dLinkManEmailNode = declarerNode.selectSingleNode("dLinkManEmail");
					infoForm.setdLinkManEmail(dLinkManEmailNode==null?"":dLinkManEmailNode.getText());
				}
				
				//****************CRO****************
				Node CRONode = doc.selectSingleNode("projInfo/CRO");
				if(CRONode != null ){
					//CRO名称
					Node CRONameNode = CRONode.selectSingleNode("CROName");
					infoForm.setCROName(CRONameNode==null?"":CRONameNode.getText());
					//法人
					Node CROLegalRepresentNode = CRONode.selectSingleNode("CROLegalRepresent");
					infoForm.setCROLegalRepresent(CROLegalRepresentNode==null?"":CROLegalRepresentNode.getText());
					//CRO地址
					Node CROAddressNode = CRONode.selectSingleNode("CROAddress");
					infoForm.setCROAddress(CROAddressNode==null?"":CROAddressNode.getText());
					//CRO邮编
					Node CROZipNode = CRONode.selectSingleNode("CROZip");
					infoForm.setCROZip(CROZipNode==null?"":CROZipNode.getText());
					//CRO联系人
					Node CROLinkManNode = CRONode.selectSingleNode("CROLinkMan");
					infoForm.setCROLinkMan(CROLinkManNode==null?"":CROLinkManNode.getText());
					//CRO联系人手机
					Node CROLinkManPhoneNode = CRONode.selectSingleNode("CROLinkManPhone");
					infoForm.setCROLinkManPhone(CROLinkManPhoneNode==null?"":CROLinkManPhoneNode.getText());
					//CRO联系人邮箱
					Node CROLinkManEmailNode = CRONode.selectSingleNode("CROLinkManEmail");
					infoForm.setCROLinkManEmail(CROLinkManEmailNode==null?"":CROLinkManEmailNode.getText());
				}
				
				//****************研究者信息****************
				Node researcherNode = doc.selectSingleNode("projInfo/researcher");
				if (researcherNode != null) {
					//科主任
					Node directorNode = researcherNode.selectSingleNode("director");
					infoForm.setDirector(directorNode==null?"":directorNode.getText());
				}
				String applyUserFlow = proj.getApplyUserFlow();
				SysUser user = userBiz.readSysUser(applyUserFlow);
				if (user != null) {
					infoForm.setResearcherPhone(user.getUserPhone());
					infoForm.setResearcherEmail(user.getUserEmail());
				}
				
				//****************临床研究单位****************
				Node projOrgNode = doc.selectSingleNode("projInfo/projOrg");
				if(projOrgNode != null ){
					//组长单位主要研究者
					Node leaderOrgLinkManNode = projOrgNode.selectSingleNode("leaderOrgLinkMan");
					infoForm.setLeaderOrgLinkMan(leaderOrgLinkManNode==null?"":leaderOrgLinkManNode.getText());
					//联系电话
					Node leaderOrgLinkManPhoneNode = projOrgNode.selectSingleNode("leaderOrgLinkManPhone");
					infoForm.setLeaderOrgLinkManPhone(leaderOrgLinkManPhoneNode==null?"":leaderOrgLinkManPhoneNode.getText());
					//邮件
					Node leaderOrgLinkManEmaiNode = projOrgNode.selectSingleNode("leaderOrgLinkManEmail");
					infoForm.setLeaderOrgLinkManEmail(leaderOrgLinkManEmaiNode==null?"":leaderOrgLinkManEmaiNode.getText());
					//组长单位伦理委员会联系人
					Node leaderOrgIrbLinkManNode = projOrgNode.selectSingleNode("leaderOrgIrbLinkMan");
					infoForm.setLeaderOrgIrbLinkMan(leaderOrgIrbLinkManNode==null?"":leaderOrgIrbLinkManNode.getText());
					//联系电话
					Node leaderOrgIrbLinkManPhoneNode = projOrgNode.selectSingleNode("leaderOrgIrbLinkManPhone");
					infoForm.setLeaderOrgIrbLinkManPhone(leaderOrgIrbLinkManPhoneNode==null?"":leaderOrgIrbLinkManPhoneNode.getText());
					//邮件
					Node leaderOrgIrbLinkManEmaiNode = projOrgNode.selectSingleNode("leaderOrgIrbLinkManEmail");
					infoForm.setLeaderOrgIrbLinkManEmail(leaderOrgIrbLinkManEmaiNode==null?"":leaderOrgIrbLinkManEmaiNode.getText());
				}
				
			} catch (DocumentException e) {
				e.printStackTrace();
			}
		}
		return infoForm;
	}

	@Override
	public List<SysDept> searchSysDept(String orgFlow) {
		SysDeptExample example = new SysDeptExample();
		example.createCriteria().andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		return deptMapper.selectByExample(example);
	}

	@Override
	public List<SysUser> searchSysUserByDept(String deptFlow) {
		SysUserExample user = new SysUserExample();
		user.createCriteria().andDeptFlowEqualTo(deptFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		user.setOrderByClause("NLSSORT(USER_NAME,'NLS_SORT = SCHINESE_PINYIN_M')");
		return userMapper.selectByExample(user);
	}

	@Override
	public void addProj(PubProj proj) {
		GeneralMethod.setRecordInfo(proj, true);
		projMapper.insert(proj);
	}

	@Override
	public void modifyProj(PubProj proj) {
		GeneralMethod.setRecordInfo(proj, false);
		projMapper.updateByPrimaryKeySelective(proj);
	}

	@Override
	public PubProj readPubProj(String projFlow) {
		return projMapper.selectByPrimaryKey(projFlow);
	}

	@Override
	public void addIrbApply(IrbApply apply) {
		GeneralMethod.setRecordInfo(apply, true);
		applyMapper.insert(apply);
		
	}
	public void addIrbProcess(IrbProcess process) {
		GeneralMethod.setRecordInfo(process, true);
		processMapper.insert(process);
	}
	@Override
	public void modifyIrbProcess(IrbProcess process) {
		GeneralMethod.setRecordInfo(process, false);
		processMapper.updateByPrimaryKeySelective(process);
	}
	public List<IrbProcess> searchProcess(String flow) {
		IrbProcessExample processExample = new IrbProcessExample();
		processExample.createCriteria().andIrbFlowEqualTo(flow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		processExample.setOrderByClause("IRB_STAGE_ID,create_time desc");
		return processMapper.selectByExample(processExample);
	}
	
	@Override
	public List<IrbApply> searchIrbApplyList(String projFlow,String irbTypeId) {
		IrbApplyExample example = new IrbApplyExample();
		Criteria criteria =  example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(irbTypeId)){
			criteria.andIrbTypeIdEqualTo(irbTypeId);
		}
		example.setOrderByClause("CREATE_TIME");
		return applyMapper.selectByExample(example);
	}
	@Override
	public List<IrbApply> searchIrbApplyList(String projFlow) {
		IrbApplyExample example = new IrbApplyExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("IRB_APPLY_DATE,CREATE_TIME");
		return applyMapper.selectByExample(example);
	}
	@Override
	public int saveApplyFile(PubFile pubFile, IrbRec irbRec,IrbApplyFileForm form) throws Exception {
		if(irbRec!=null&&form!=null){
			String fileFlow = "";
			if(pubFile!=null){
				if(StringUtil.isNotBlank(form.getFileFlow())){
					pubFile.setFileFlow(form.getFileFlow());
				}
				int saveFileResult = this.fileBiz.editFile(pubFile);
				if(saveFileResult==GlobalConstant.ZERO_LINE){
					return GlobalConstant.ZERO_LINE;
				}
				fileFlow = pubFile.getFileFlow();
			}
			Document dom = null;
			Element root = null;
			String content = null;
			IrbRec findIrbRec = this.irbRecBiz.readIrbRec(irbRec);
			if(findIrbRec!=null){
				irbRec.setRecFlow(findIrbRec.getRecFlow());
				content = findIrbRec.getRecContent();
			}
			if(StringUtil.isNotBlank(content)){
				dom = DocumentHelper.parseText(content);
				root = dom.getRootElement();
			}else{
				dom = DocumentHelper.createDocument();
				root = dom.addElement("applyFile");
			}
			Element fileElement = null;
			Element findFileElement = (Element) dom.selectSingleNode("/applyFile/file[@id='"+form.getFileTempId()+"']");
			String fileName = form.getFileName();
			String fileRemark = form.getFileRemark();
			String showNotice = form.getShowNotice();
			String version = form.getVersion();
			String versionDate = form.getVersionDate();
			String url = form.getUrl();
			if(StringUtil.isNotBlank(form.getFileTempId())&&findFileElement!=null){
				fileElement = findFileElement;
				fileElement.element("fileFlow").setText(StringUtil.defaultIfEmpty(fileFlow, ""));
				fileElement.element("fileName").setText(StringUtil.defaultIfEmpty(fileName, ""));
				fileElement.element("fileRemark").setText(StringUtil.defaultIfEmpty(fileRemark, ""));
				fileElement.element("showNotice").setText(StringUtil.defaultIfEmpty(showNotice, ""));
				if(StringUtil.isNotBlank(version)){
					fileElement.element("version").setText(version);
				}
				if(StringUtil.isNotBlank(versionDate)){
					fileElement.element("versionDate").setText(versionDate);
				}
				if(StringUtil.isNotBlank(url)){
					fileElement.element("url").setText(url);
				}
			}else{
				fileElement = root.addElement("file");
				fileElement.addAttribute("id", form.getFileTempId());
				fileElement.addElement("fileFlow").setText(StringUtil.defaultIfEmpty(fileFlow, ""));
				fileElement.addElement("fileName").setText(StringUtil.defaultIfEmpty(fileName, ""));
				fileElement.addElement("fileRemark").setText(StringUtil.defaultIfEmpty(fileRemark, ""));
				fileElement.addElement("showNotice").setText(StringUtil.defaultIfEmpty(showNotice, ""));
				if(StringUtil.isNotBlank(version)){
					fileElement.addElement("version").setText(version);
				}
				if(StringUtil.isNotBlank(versionDate)){
					fileElement.addElement("versionDate").setText(versionDate);
				}
				if(StringUtil.isNotBlank(url)){
					fileElement.addElement("url").setText(url);
				}
			}
			irbRec.setRecContent(dom.asXML());
			return this.irbRecBiz.edit(irbRec);
		}
		return GlobalConstant.ZERO_LINE;
	} 
/*@Override
	public void handProcess(IrbApply irb) {
		if(irb!=null && StringUtil.isNotBlank(irb.getIrbStageId())){
			if(IrbStageEnum.Apply.getId().equals(irb.getIrbStageId())){
				saveProcess(irb);
			}else if(IrbStageEnum.Handle.getId().equals(irb.getIrbStageId())){
				//回写申请
				IrbProcess preProcess = readIrbProcess(irb.getIrbFlow(),IrbStageEnum.Apply.getId());
				if(preProcess!=null){
					preProcess.setOperTime(DateUtil.getCurrDateTime());
					preProcess.setOperUserFlow(GlobalContext.getCurrentUser().getUserFlow());
					preProcess.setOperUserName(GlobalContext.getCurrentUser().getUserName());
					modifyIrbProcess(preProcess);
				}
				saveProcess(irb);
				
			}else if(IrbStageEnum.Review.getId().equals(irb.getIrbStageId())){
				//审查
				saveProcess(irb);
				
			}else if(IrbStageEnum.Decision.getId().equals(irb.getIrbStageId())){
				//传达决定
				saveProcess(irb);
			}else if(IrbStageEnum.Archive.getId().equals(irb.getIrbStageId())){
				//文件存档
				saveProcess(irb);
			}else if(IrbStageEnum.Filing.getId().equals(irb.getIrbStageId())){
				//归档
				saveProcess(irb);
			}
		}
	}

	private void saveProcess(IrbApply irb) {
		IrbProcess process = new IrbProcess();
		process.setProcessFlow(PkUtil.getUUID());
		process.setProjFlow(irb.getProjFlow());
		process.setIrbFlow(irb.getIrbFlow());
		process.setIrbStageId(irb.getIrbStageId());
		process.setIrbStageName(irb.getIrbStageName());
		addIrbProcess(process);
	}
	

	private IrbProcess readIrbProcess(String irbFlow, String id) {
		IrbProcessExample example = new IrbProcessExample();
		example.createCriteria().andIrbFlowEqualTo(irbFlow).andIrbStageIdEqualTo(id).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("CREATE_TIME");
		List<IrbProcess> list = processMapper.selectByExample(example);
		if(list!=null && list.size()>0){
			return list.get(list.size()-1);
		}
		return null;
	}
   */
	@Override
	public void modifyIrbApply(IrbApply irb) {
		GeneralMethod.setRecordInfo(irb, false);
		applyMapper.updateByPrimaryKeySelective(irb);
	}

	@Override
	public void delApplyFile(String irbFlow, String fileId) throws Exception {
		if(StringUtil.isNotBlank(irbFlow)&&StringUtil.isNotBlank(fileId)){
			IrbRec irbRec = new IrbRec();
			irbRec.setIrbFlow(irbFlow);
			irbRec.setRecTypeId(IrbRecTypeEnum.ApplyFile.getId());
			List<IrbRec>  irbRecList = this.irbRecBiz.queryList(irbRec);
			if(irbRecList!=null&&!irbRecList.isEmpty()){
				IrbRec findIrbRec = irbRecList.get(0);
				if(findIrbRec!=null&&StringUtil.isNotBlank(findIrbRec.getRecContent())){
					Document dom = DocumentHelper.parseText(findIrbRec.getRecContent());
					Element fileElement = (Element) dom.selectSingleNode("/applyFile/file[@id='"+fileId+"']");
					if(fileElement!=null){
						String fileFlow = fileElement.element("fileFlow").getTextTrim();
						if (StringUtil.isNotBlank(fileFlow)) {
							PubFile file = new PubFile();
							file.setFileFlow(fileFlow);
							file.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
							this.fileBiz.editFile(file);
						}
						fileElement.getParent().remove(fileElement);
					}
					findIrbRec.setRecContent(dom.asXML());
					this.irbRecBiz.edit(findIrbRec);
				}
			}
		}
		
	}

    @Override
	public IrbApply readIrbApply(String irbFlow) {
		return applyMapper.selectByPrimaryKey(irbFlow);
	} 
	@Override
	public List<SysUser> queryResUser(SysUserForm form) {
		SysUser currentUser = GlobalContext.getCurrentUser();
		form.getUser().setOrgFlow(currentUser.getOrgFlow());
		form.getUser().setStatusId(UserStatusEnum.Activated.getId());
		return sysUserExtMapper.selectResUserByForm(form);
	}

	@Override
	public void saveProcess(IrbApply irb, IrbProcess process) {
		if(irb!=null){
			if(process==null){
				process = new IrbProcess();
				process.setOperTime(DateUtil.getCurrDate());
			}
			SysUser currentUser = GlobalContext.getCurrentUser();
			process.setOperUserFlow(currentUser.getUserFlow());
			process.setOperUserName(currentUser.getUserName());
			process.setProcessFlow(PkUtil.getUUID());
			process.setProjFlow(irb.getProjFlow());
			process.setIrbFlow(irb.getIrbFlow());
			process.setIrbStageId(irb.getIrbStageId());
			process.setIrbStageName(irb.getIrbStageName());
			addIrbProcess(process);
		}
	} 
	
}
