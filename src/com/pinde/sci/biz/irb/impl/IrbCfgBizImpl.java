package com.pinde.sci.biz.irb.impl;

import java.util.ArrayList;
import java.util.List;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.irb.IIrbCfgBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.IrbCfgMapper;
import com.pinde.sci.enums.irb.IrbTypeEnum;
import com.pinde.sci.model.irb.ApplyFileTemp;
import com.pinde.sci.model.mo.IrbCfg;
@Service
@Transactional(rollbackFor=Exception.class)
public class IrbCfgBizImpl implements IIrbCfgBiz {
	@Autowired
	private IrbCfgMapper irbCfgMapper;
	
	@SuppressWarnings("unchecked")
	@Override
	public int saveApplyFile(ApplyFileTemp applyFile) throws Exception {
		IrbCfg cfg = this.irbCfgMapper.selectByPrimaryKey(GlobalConstant.APPLY_FILE_CFG_CODE);
		if(cfg == null){
			cfg = new IrbCfg();
		}
		String content = cfg.getCfgBigValue();
		Document dom = null;
		Element root = null;
		Element fileElement = null;
		String irbType = StringUtil.defaultIfEmpty(applyFile.getIrbType(),"");
		String projCategroy =  StringUtil.defaultIfEmpty(applyFile.getPjType(),"");
		String name =  StringUtil.defaultIfEmpty(applyFile.getName(), "");
		String fileType =  StringUtil.defaultIfEmpty(applyFile.getFileType(), "");
		String version =  StringUtil.defaultIfEmpty(applyFile.getVersion(), "");
		String versionDate =  StringUtil.defaultIfEmpty(applyFile.getVersionDate(), "");
		String showNotice =  StringUtil.defaultIfEmpty(applyFile.getShowNotice(), "");
		if(StringUtil.isNotBlank(content)){//非第一次添加
			dom = DocumentHelper.parseText(content);
			root = dom.getRootElement();
			/*查找irbType*/
			String irbTypeXpath= "/applyFile/irbType[@value='"+irbType+"']";
			List<Element> findIrbTypes = dom.selectNodes(irbTypeXpath);
			Element irbTypeElement = null;
			if(findIrbTypes!=null&&!findIrbTypes.isEmpty()){
				irbTypeElement = findIrbTypes.get(0);
			}else{
				irbTypeElement = root.addElement("irbType").addAttribute("value", irbType);
			}
			Element findElement = irbTypeElement;
			if(IrbTypeEnum.Init.getId().equals(irbType)){//初始审查
			 	String xpath = "/applyFile/irbType[@value='"+irbType+"']/projCategroy[@value='"+projCategroy+"']";
			 	List<Element> findElements = dom.selectNodes(xpath);
				if(findElements!=null&&!findElements.isEmpty()){
					findElement = findElements.get(0);
				}else{
					findElement = irbTypeElement.addElement("projCategroy").addAttribute("value", projCategroy);
				}
			}
			fileElement = findElement.addElement("file");
		}else{//第一次添加
			dom = DocumentHelper.createDocument();
			root = dom.addElement("applyFile");
			Element irbTypeElement  =  root.addElement("irbType");
			irbTypeElement.addAttribute("value", irbType);
			if(IrbTypeEnum.Init.getId().equals(irbType)){//初始审查
				fileElement = irbTypeElement.addElement("projCategroy").addAttribute("value", projCategroy).addElement("file");
			}else{
				fileElement = irbTypeElement.addElement("file");
			}
		}
		fileElement.addAttribute("id", PkUtil.getUUID());
		fileElement.addElement("name").setText(name);
		fileElement.addElement("fileType").setText(fileType);
		fileElement.addElement("version").setText(version);
		fileElement.addElement("versionDate").setText(versionDate);
		fileElement.addElement("showNotice").setText(showNotice);
		
		cfg.setCfgBigValue(dom.asXML());
		
		if(StringUtil.isNotBlank(cfg.getCfgCode())){//修改
			GeneralMethod.setRecordInfo(cfg, false);
			return this.irbCfgMapper.updateByPrimaryKeySelective(cfg);
		}else{//新增
			cfg.setCfgCode(GlobalConstant.APPLY_FILE_CFG_CODE);	//新增送审文件
			cfg.setCfgDesc("送审文件清单");
			GeneralMethod.setRecordInfo(cfg, true);
			return this.irbCfgMapper.insertSelective(cfg);
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ApplyFileTemp> queryApplyFileList(ApplyFileTemp applyFile) throws Exception {
		List<ApplyFileTemp> list = null;
		if(applyFile!=null){
			IrbCfg cfg = this.irbCfgMapper.selectByPrimaryKey(GlobalConstant.APPLY_FILE_CFG_CODE);
			if(cfg!=null&&StringUtil.isNotBlank(cfg.getCfgBigValue())){
				Document dom = DocumentHelper.parseText(cfg.getCfgBigValue());
				StringBuilder xpath = new StringBuilder("/applyFile/irbType[@value='"+applyFile.getIrbType()+"']");
				if(StringUtil.isNotBlank(applyFile.getPjType())){
					xpath.append("/projCategroy[@value='"+applyFile.getPjType()+"']");
				}
				xpath.append("/file");
				List<Element> findFiles = dom.selectNodes(xpath.toString());
				if(findFiles!=null){
					list = new ArrayList<ApplyFileTemp>();
					ApplyFileTemp apyile = null;
					for (Element el : findFiles) {
						apyile = new ApplyFileTemp();
						apyile.setName(el.element("name")==null?"":el.element("name").getTextTrim());
						apyile.setFileType(el.element("fileType")==null?"":el.element("fileType").getTextTrim());
						apyile.setVersion(el.element("version")==null?"":el.element("version").getTextTrim());
						apyile.setVersionDate(el.element("versionDate")==null?"":el.element("versionDate").getTextTrim());
						apyile.setShowNotice(el.element("showNotice")==null?"":el.element("showNotice").getTextTrim());
						apyile.setId(el.attributeValue("id"));
						list.add(apyile);
					}
				}
			}
		}
		return list;
	}

	@Override
	public int operaApplyFile(ApplyFileTemp applyFile, String opera) throws Exception{
		if(applyFile!=null){
			IrbCfg cfg = this.irbCfgMapper.selectByPrimaryKey(GlobalConstant.APPLY_FILE_CFG_CODE);
			if(cfg == null){
				cfg = new IrbCfg();
			}
			if(StringUtil.isNotBlank(cfg.getCfgBigValue())){
				Document dom = DocumentHelper.parseText(cfg.getCfgBigValue());
				Element findElement = queryApplyFileElement(applyFile,dom);
				if("edit".equals(opera)){//修改
					String name =  StringUtil.defaultIfEmpty(applyFile.getName(), "");
					String fileType =  StringUtil.defaultIfEmpty(applyFile.getFileType(), "");
					String version =  StringUtil.defaultIfEmpty(applyFile.getVersion(), "");
					String versionDate =  StringUtil.defaultIfEmpty(applyFile.getVersionDate(), "");
					String showNotice =  StringUtil.defaultIfEmpty(applyFile.getShowNotice(), "");
					//文件名
					Node nameNode = findElement.selectSingleNode("name");
					if (nameNode == null) {
						nameNode = findElement.addElement("name");
					}
					nameNode.setText(name);
					//文件类型
					Node fileTypeNode = findElement.selectSingleNode("fileType");
					if (fileTypeNode == null) {
						fileTypeNode = findElement.addElement("fileType");
					}
					fileTypeNode.setText(fileType);
					//版本号
					Node versionNode = findElement.selectSingleNode("version");
					if (versionNode == null) {
						versionNode = findElement.addElement("version");
					}
					versionNode.setText(version);
					//版本日期
					Node versionDateNode = findElement.selectSingleNode("versionDate");
					if (versionDateNode == null) {
						versionDateNode = findElement.addElement("versionDate");
					}
					versionDateNode.setText(versionDate);
					//受理通知->送审材料中是否显示
					Node showNoticeNode = findElement.selectSingleNode("showNotice");
					if (showNoticeNode == null) {
						showNoticeNode = findElement.addElement("showNotice");
					}
					showNoticeNode.setText(showNotice);
				}else if("del".equals(opera)){//删除
					findElement.getParent().remove(findElement);
				}
				cfg.setCfgBigValue(dom.asXML());
				GeneralMethod.setRecordInfo(cfg, false);
				return this.irbCfgMapper.updateByPrimaryKeySelective(cfg);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public ApplyFileTemp queryApplyFile(ApplyFileTemp applyFile)throws Exception {
		if(applyFile!=null){
			IrbCfg cfg = this.irbCfgMapper.selectByPrimaryKey(GlobalConstant.APPLY_FILE_CFG_CODE);
			if(cfg!=null&&StringUtil.isNotBlank(cfg.getCfgBigValue())){
				Document dom = DocumentHelper.parseText(cfg.getCfgBigValue());
				Element findElement = queryApplyFileElement(applyFile,dom);
				ApplyFileTemp findApplyFile = new ApplyFileTemp();
				if (findElement != null) {
					findApplyFile.setName(findElement.element("name")==null?"":findElement.element("name").getTextTrim());
					findApplyFile.setFileType(findElement.element("fileType")==null?"":findElement.element("fileType").getTextTrim());
					findApplyFile.setVersion(findElement.element("version")==null?"":findElement.element("version").getTextTrim());
					findApplyFile.setVersionDate(findElement.element("versionDate")==null?"":findElement.element("versionDate").getTextTrim());
					findApplyFile.setShowNotice(findElement.element("showNotice")==null?"":findElement.element("showNotice").getTextTrim());
					findApplyFile.setId(findElement.attributeValue("id"));
				}
				return findApplyFile;
				}
			
		}
		return null;
	}

	@Override
	public Element queryApplyFileElement(ApplyFileTemp applyFile ,Document dom )throws Exception {
		StringBuilder xpath = new StringBuilder("/applyFile/irbType[@value='"+applyFile.getIrbType()+"']");
		if(StringUtil.isNotBlank(applyFile.getPjType())){
			xpath.append("/projCategroy[@value='"+applyFile.getPjType()+"']");
		}
		xpath.append("/file[@id='"+applyFile.getId()+"']");
		return (Element) dom.selectSingleNode(xpath.toString());
	}
	

}
