package com.pinde.sci.biz.irb.impl;

import java.util.ArrayList;
import java.util.List;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.irb.IIrbApplyBiz;
import com.pinde.sci.biz.irb.IIrbRecBiz;
import com.pinde.sci.biz.irb.IIrbResearcherBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.IrbProcessMapper;
import com.pinde.sci.dao.base.IrbRecMapper;
import com.pinde.sci.enums.irb.IrbRecTypeEnum;
import com.pinde.sci.form.irb.IrbApplyFileForm;
import com.pinde.sci.form.irb.IrbArchiveForm;
import com.pinde.sci.model.mo.IrbApply;
import com.pinde.sci.model.mo.IrbProcess;
import com.pinde.sci.model.mo.IrbProcessExample;
import com.pinde.sci.model.mo.IrbRec;
import com.pinde.sci.model.mo.IrbRecExample;
import com.pinde.sci.model.mo.IrbRecExample.Criteria;
import com.pinde.sci.model.mo.SysUser;
@Service
@Transactional(rollbackFor=Exception.class)
public class IrbRecBizImpl implements IIrbRecBiz {
	@Autowired
	private IrbRecMapper irbRecMapper;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IIrbApplyBiz irbApplyBiz;
	@Autowired
	private IIrbResearcherBiz researcherBiz;
	@Autowired
	private IrbProcessMapper irbProcessMapper;

	@Override
	public int edit(IrbRec irbRec) {
		if(irbRec!=null){
			irbRec.setOperTime(DateUtil.getCurrDateTime());
			if(irbRec.getRecTypeId().contains("Worksheet")){
				SysUser user = userBiz.readSysUser(irbRec.getOperUserFlow());
				if(user!=null){
					irbRec.setOperUserName(user.getUserName());
				}
			}else{
				SysUser currUser = GlobalContext.getCurrentUser();
				irbRec.setOperUserFlow(currUser.getUserFlow());
				irbRec.setOperUserName(currUser.getUserName());
			}
			
			if(StringUtil.isNotBlank(irbRec.getRecFlow())){//修改
				GeneralMethod.setRecordInfo(irbRec, false);
				return this.irbRecMapper.updateByPrimaryKeySelective(irbRec);
			}else{//新增
				irbRec.setRecFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(irbRec, true);
				return this.irbRecMapper.insertSelective(irbRec);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<IrbRec> queryList(IrbRec irbRec) {
		IrbRecExample example = new IrbRecExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(irbRec!=null){
			if(StringUtil.isNotBlank(irbRec.getProjFlow())){
				criteria.andProjFlowEqualTo(irbRec.getProjFlow());
			}
			if(StringUtil.isNotBlank(irbRec.getRecTypeId())){
				criteria.andRecTypeIdEqualTo(irbRec.getRecTypeId());
			}
			if(StringUtil.isNotBlank(irbRec.getRecVersion())){
				criteria.andRecVersionEqualTo(irbRec.getRecVersion());
			}
			if(StringUtil.isNotBlank(irbRec.getIrbFlow())){
				criteria.andIrbFlowEqualTo(irbRec.getIrbFlow());
			}
			if(StringUtil.isNotBlank(irbRec.getOperUserFlow())){
				criteria.andOperUserFlowEqualTo(irbRec.getOperUserFlow());
			}
			example.setOrderByClause("create_Time");
		}
		return this.irbRecMapper.selectByExampleWithBLOBs(example);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<IrbApplyFileForm> queryUploadFile(IrbRec irbRec) throws Exception {
		List<IrbApplyFileForm> list = null;
		if(irbRec != null&&StringUtil.isNotBlank(irbRec.getIrbFlow())){
			irbRec.setRecTypeId(IrbRecTypeEnum.ApplyFile.getId());
			List<IrbRec> irbRecList = this.queryList(irbRec);
			if(irbRecList!=null&&!irbRecList.isEmpty()&&StringUtil.isNotBlank(irbRecList.get(0).getRecContent())){
				String content = irbRecList.get(0).getRecContent();
				Document dom = DocumentHelper.parseText(content);
				String xpath = "/applyFile/file";
				List<Element> fileNodes = dom.selectNodes(xpath);
				list = new ArrayList<IrbApplyFileForm>();
				IrbApplyFileForm form = null;
				for (Element e : fileNodes) {
					form = new IrbApplyFileForm();
					form.setFileTempId(e.attributeValue("id"));
					boolean isConfirm = false;
					if("true".equals(e.attributeValue("confirm"))){
						isConfirm = true;
					}
					form.setConfirm(isConfirm);
					form.setFileFlow(e.element("fileFlow")==null?"":e.element("fileFlow").getTextTrim());
					form.setFileName(e.element("fileName")==null?"":e.element("fileName").getTextTrim());
					form.setShowNotice(e.element("showNotice")==null?"":e.element("showNotice").getTextTrim());
					form.setFileType(e.element("fileType")==null?"":e.element("fileType").getTextTrim());
					form.setVersion(e.element("version")==null?"":e.element("version").getTextTrim());
					form.setVersionDate(e.element("versionDate")==null?"":e.element("versionDate").getTextTrim());
					form.setUrl(e.element("url")==null?"":e.element("url").getTextTrim());
					list.add(form);
				}
			}
		}
		return list;
	}

	@Override
	public Element queryUploadFile(Document dom, String fileId){
		if(StringUtil.isNotBlank(fileId)&& dom!=null){
			String xpath = "/applyFile/file[@id='"+fileId+"']";
			return (Element) dom.selectSingleNode(xpath);
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<IrbApplyFileForm> queryApplyOrModify(String irbFlow, String type) throws Exception {
		List<IrbApplyFileForm> list = null;
		if(StringUtil.isNotBlank(irbFlow)&&StringUtil.isNotBlank(type)){
			IrbRec irbRec = new IrbRec();
			irbRec.setIrbFlow(irbFlow);
			irbRec.setRecTypeId(IrbRecTypeEnum.AddModNotice.getId());
			List<IrbRec> irbList = this.queryList(irbRec);
			if(irbList!=null&&!irbList.isEmpty()&&StringUtil.isNotBlank(irbList.get(0).getRecContent())){
				Document dom = DocumentHelper.parseText(irbList.get(0).getRecContent());
				String xpath = "/notices/notice";
				List<Element> noticeElements = dom.selectNodes(xpath);
				if(noticeElements!=null&&!noticeElements.isEmpty()){
					Element noticeElement = noticeElements.get(noticeElements.size()-1);
					List<Element> fileElement = null;
					if(GlobalConstant.NOTICE_TYPE_APPLY.equals(type)){//需提交文件
					    Element applyFileElement = noticeElement.element("applyFile");
						if(applyFileElement!=null){
							fileElement = applyFileElement.elements("file");
						}
					} else if(GlobalConstant.NOTICE_TYPE_MODIFY.equals(type)){//需修改文件
						Element modiElement = noticeElement.element("modifyFile");
						if(modiElement!=null){
							fileElement = modiElement.elements("file");
						}
					}
					if(fileElement!=null){
						list = new ArrayList<IrbApplyFileForm>();
						IrbApplyFileForm form = null;
						for (Element fe : fileElement) {
							form = new IrbApplyFileForm();
							form.setFileTempId(fe.attributeValue("id"));
							form.setFileName(fe.element("fileName").getTextTrim());
							Element sugElement = fe.element("suggest");
							if(sugElement!=null){
								form.setSuggest(sugElement.getTextTrim());
							}
							Element fileFlowElement = fe.element("fileFlow");
							if(fileFlowElement!=null){
								form.setFileFlow(fileFlowElement.getTextTrim());
							}
							list.add(form);
						}
					}
				}
			}
		}
		return list;
	}

	@Override
	public boolean checkNotice(String irbFlow,String recVersion) throws Exception {
		if(StringUtil.isNotBlank(irbFlow)){
			IrbRec temp = new IrbRec();
			temp.setIrbFlow(irbFlow);
			temp.setRecTypeId(IrbRecTypeEnum.AddModNotice.getId());
			if (StringUtil.isNotBlank(recVersion)) {
				temp.setRecVersion(recVersion);
			}
			IrbRec irbRec = readIrbRec(temp);
			if(irbRec!=null){
				return true;
			}
		}
		return false;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<IrbApplyFileForm> queryConfirmFile(String irbFlow)throws Exception {
		List<IrbApplyFileForm> list = null;
		IrbRec irbRec = new IrbRec();
		irbRec.setIrbFlow(irbFlow);
		irbRec.setRecTypeId(IrbRecTypeEnum.ApplyFile.getId());
		List<IrbRec> irbList = this.queryList(irbRec);
		if(irbList!=null&&!irbList.isEmpty()&&StringUtil.isNotBlank(irbList.get(0).getRecContent())){
			Document dom = DocumentHelper.parseText(irbList.get(0).getRecContent());
			String xpath = "/applyFile/file[@confirm='true']";
			List<Element> fileElements = dom.selectNodes(xpath);
			if(fileElements!=null&&!fileElements.isEmpty()){
				list = new ArrayList<IrbApplyFileForm>();
				IrbApplyFileForm form = null;
				for (Element e : fileElements) {
					form = new IrbApplyFileForm();
					form.setFileTempId(e.attributeValue("id"));
					form.setFileFlow(e.element("fileFlow").getTextTrim());
					form.setFileName(e.element("fileName").getTextTrim());
					if(e.element("showNotice")!=null){ 
						form.setShowNotice(e.element("showNotice").getTextTrim());
					}
					if(e.element("fileType")!=null){
						form.setFileType(e.element("fileType").getTextTrim());
					}
					if(e.element("version")!=null){
						form.setVersion(e.element("version").getTextTrim());
					}
					if(e.element("versionDate")!=null){
						form.setVersionDate(e.element("versionDate").getTextTrim());
					}
					if(e.element("url")!=null){
						form.setUrl(e.element("url").getTextTrim());
					}
					list.add(form);
				}
			}
		}
		return list;
	}

	@Override
	public IrbApplyFileForm queryUploadFile(String irbFlow, String fileId)
			throws Exception {
		IrbApplyFileForm form = null;
		if(StringUtil.isNotBlank(irbFlow)&&StringUtil.isNotBlank(fileId)){
			IrbRec irbRec = new IrbRec();
			irbRec.setIrbFlow(irbFlow);
			irbRec.setRecTypeId(IrbRecTypeEnum.ApplyFile.getId());
			List<IrbRec> irbList = this.queryList(irbRec);
			if(irbList!=null&&!irbList.isEmpty()&&StringUtil.isNotBlank(irbList.get(0).getRecContent())){
				Document dom = DocumentHelper.parseText(irbList.get(0).getRecContent());
				String xpath = "/applyFile/file[@id='"+fileId+"']";
				Element fileElement = (Element) dom.selectSingleNode(xpath);
				if(fileElement!=null){
					form = new IrbApplyFileForm();
					form.setFileTempId(fileElement.attributeValue("id"));
					boolean confirm = false;
					if("true".equals(fileElement.attributeValue("confirm"))){
						confirm = true;
					}
					form.setConfirm(confirm);
					form.setFileFlow(fileElement.element("fileFlow").getTextTrim());
					form.setFileName(fileElement.element("fileName").getTextTrim());
					form.setFileRemark(fileElement.element("fileRemark").getTextTrim());
					Element fileTypeEl =  fileElement.element("fileType");
					if(fileTypeEl!=null){
						form.setFileType(fileTypeEl.getTextTrim());
					}
					Element versionEl =  fileElement.element("version");
					if(versionEl!=null){
						form.setVersion(versionEl.getTextTrim());
					}
					Element versionDateEl =  fileElement.element("versionDate");
					if(versionDateEl!=null){
						form.setVersionDate(versionDateEl.getTextTrim());
					}
					Element urlDateEl =  fileElement.element("url");
					if(urlDateEl!=null){
						form.setUrl(urlDateEl.getTextTrim());
					}
				}
			}
		}
		return form;
	}

	@Override
	public IrbRec readIrbRec(String irbFlow, String formFileName) {
		IrbRecExample example = new IrbRecExample();
		example.createCriteria().andIrbFlowEqualTo(irbFlow).andRecTypeIdEqualTo(formFileName).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<IrbRec> recList = irbRecMapper.selectByExampleWithBLOBs(example);
		if(recList!=null && recList.size()>0){
			return recList.get(0);
		}
		return null;
	}

	@Override
	public IrbRec readIrbRec(IrbRec irbRec) {
		if(irbRec!=null){
			List<IrbRec> list= this.queryList(irbRec);
			if(list!=null&&!list.isEmpty()){
				return list.get(0);
			}
		}
		return null;
	}
	
	@Override
	public IrbRec readIrbRec(String recFlow) {
		IrbRec rec = irbRecMapper.selectByPrimaryKey(recFlow);
		return rec;
	}

	@Override
	public List<IrbRec> queryRecListByIrbFlow(String irbFlow) {
		IrbRecExample example = new IrbRecExample();
		com.pinde.sci.model.mo.IrbRecExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(irbFlow)){
			criteria.andIrbFlowEqualTo(irbFlow);
		}
		return irbRecMapper.selectByExample(example);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<IrbArchiveForm> queryArchiveFile(String irbFlow) throws Exception {
		List<IrbArchiveForm> list = null;
		if(StringUtil.isNotBlank(irbFlow)){
			IrbRec rec = new IrbRec();
			rec.setIrbFlow(irbFlow);
			rec.setRecTypeId(IrbRecTypeEnum.Archive.getId());
			IrbRec findRec = this.readIrbRec(rec);
			if(findRec!=null&&StringUtil.isNotBlank(findRec.getRecContent())){
				Document dom = DocumentHelper.parseText(findRec.getRecContent());
				List<Element> achList = dom.selectNodes("//archive");
				if(achList!=null&&!achList.isEmpty()){
					list = new ArrayList<IrbArchiveForm>();
					IrbArchiveForm form = null;
					for (Element e : achList) {
						form = new IrbArchiveForm();
						form.setDate(e.elementTextTrim("date"));
						form.setFileFlow(e.elementTextTrim("fileFlow"));
						form.setUrl(e.elementTextTrim("url"));
						form.setName(e.elementTextTrim("name"));
						form.setRecType(e.elementTextTrim("recType"));
						form.setId(e.attributeValue("id"));
						list.add(form);
					}
				}
			}
		}
		return list;
	}

	@Override
	public void saveArchiveFile(IrbArchiveForm form) throws Exception {
			if(form!=null){
				IrbRec rec = new IrbRec();
				String irbFlow = form.getIrbFlow();
				rec.setIrbFlow(irbFlow);
				rec.setRecTypeId(IrbRecTypeEnum.Archive.getId());
				IrbRec findIrbRec = this.readIrbRec(rec);
				Document dom = null;
				Element root = null;
				if(findIrbRec==null){
					dom = DocumentHelper.createDocument();
					root = dom.addElement("archives");
					IrbApply apply = this.irbApplyBiz.queryByFlow(irbFlow);
					rec.setProjFlow(apply.getProjFlow());
					rec.setIrbStageId(apply.getIrbStageId());
					rec.setIrbStageName(apply.getIrbStageName());
					rec.setRecTypeName(IrbRecTypeEnum.Archive.getName());
					findIrbRec = rec;
				}else {
					dom = DocumentHelper.parseText(findIrbRec.getRecContent());
					root = dom.getRootElement();
				}
				String name = form.getName();
				String fileFlow = form.getFileFlow();
				String date = form.getDate();
				if (StringUtil.isBlank(date)) {
					date = DateUtil.getCurrDate();
				}
				String recType = form.getRecType();
				String url = form.getUrl();
				Element archiveElement = (Element) dom.selectSingleNode("//archive[name='"+name+"' and recType = '"+recType+"']");
				if(archiveElement!=null){
					archiveElement.element("name").setText(StringUtil.defaultIfEmpty(name, ""));
					archiveElement.element("fileFlow").setText(StringUtil.defaultIfEmpty(fileFlow, ""));
					archiveElement.element("date").setText(StringUtil.defaultIfEmpty(date, ""));
					archiveElement.element("recType").setText(StringUtil.defaultIfEmpty(recType, ""));
					archiveElement.element("url").setText(StringUtil.defaultIfEmpty(url, ""));
					findIrbRec.setRecContent(dom.asXML());
					edit(findIrbRec);
				}else{
					String uuid = PkUtil.getUUID();
					archiveElement = root.addElement("archive").addAttribute("id", uuid);
					archiveElement.addElement("name").setText(StringUtil.defaultIfEmpty(name, ""));
					archiveElement.addElement("fileFlow").setText(StringUtil.defaultIfEmpty(fileFlow, ""));
					archiveElement.addElement("date").setText(StringUtil.defaultIfEmpty(date, ""));
					archiveElement.addElement("recType").setText(StringUtil.defaultIfEmpty(recType, ""));
					archiveElement.addElement("url").setText(StringUtil.defaultIfEmpty(url, ""));
					findIrbRec.setRecContent(dom.asXML());
					edit(findIrbRec);
				}
		}
	}

	@Override
	public int saveArchiveFile(List<IrbArchiveForm> list,String irbFlow) throws Exception {
		if(list!=null&&!list.isEmpty()&&StringUtil.isNotBlank(irbFlow)){
			IrbRec rec = new IrbRec();
			rec.setIrbFlow(irbFlow);
			rec.setRecTypeId(IrbRecTypeEnum.Archive.getId());
			IrbRec findIrbRec = this.readIrbRec(rec);
			if(findIrbRec!=null&&StringUtil.isNotBlank(findIrbRec.getRecContent())){
				Document dom = DocumentHelper.parseText(findIrbRec.getRecContent());
				for (IrbArchiveForm form : list) {
					Element archiveElement = (Element) dom.selectSingleNode("//archive[@id='"+form.getId()+"']");
					if(archiveElement!=null){
						archiveElement.element("date").setText(StringUtil.defaultIfEmpty(form.getDate(), ""));
					}
				}
				findIrbRec.setRecContent(dom.asXML());
				/*插入process*/
				IrbApply irb = this.irbApplyBiz.queryByFlow(irbFlow);
				IrbProcess process = this.readIrbProcess(irb);
				if(process==null){
					this.researcherBiz.saveProcess(irb, null);
				}else{
					this.modifyIrbProcess(process);
				}
				
				return this.edit(findIrbRec);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	private IrbProcess readIrbProcess(IrbApply irb){
		IrbProcess process = null;
		if(irb!=null){
			IrbProcessExample example = new IrbProcessExample();
			example.createCriteria().andIrbFlowEqualTo(irb.getIrbFlow()).andIrbStageIdEqualTo(irb.getIrbStageId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			List<IrbProcess> pList = this.irbProcessMapper.selectByExample(example);
			if(pList!=null&&!pList.isEmpty()){
				return pList.get(0);
			}
		}
		return process;
	}
	private void modifyIrbProcess(IrbProcess process){
		if(process!=null){
			process.setOperTime(DateUtil.getCurrDate());
			SysUser currentUser = GlobalContext.getCurrentUser();
			process.setOperUserFlow(currentUser.getUserFlow());
			process.setOperUserName(currentUser.getUserName());
			GeneralMethod.setRecordInfo(process, false);
			this.irbProcessMapper.updateByPrimaryKeySelective(process);
		}
	}

	@Override
	public int operApplyFile(String[] ids, String irbFlow,String oper) throws Exception {
		if(ids!=null&&ids.length>0&&StringUtil.isNotBlank(irbFlow)){
			IrbRec rec = new IrbRec();
			rec.setIrbFlow(irbFlow);
			rec.setRecTypeId(IrbRecTypeEnum.Archive.getId());
			IrbRec findIrbRec = this.readIrbRec(rec);
			if(findIrbRec!=null&&StringUtil.isNotBlank(findIrbRec.getRecContent())){
				Document dom = DocumentHelper.parseText(findIrbRec.getRecContent());
				if(dom!=null){
					if("del".equals(oper)){//删除
						for (String id : ids) {
							Element el =  (Element) dom.selectSingleNode("//archive[@id='"+id+"']");
							el.getParent().remove(el);
						}
					}else if("sort".equals(oper)){//排序
						Document newDom = DocumentHelper.createDocument();
						Element root = newDom.addElement("archives");
						for (String id : ids) {
							Element el =  (Element) dom.selectSingleNode("//archive[@id='"+id+"']");
							Element newEl = (Element) el.clone();
							root.add(newEl);
						}
						dom = newDom;
					}
					
					findIrbRec.setRecContent(dom.asXML());
					return this.edit(findIrbRec);
				}
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
}
