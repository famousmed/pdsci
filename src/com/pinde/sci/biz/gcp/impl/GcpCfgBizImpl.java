package com.pinde.sci.biz.gcp.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.gcp.IGcpCfgBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.GcpCfgMapper;
import com.pinde.sci.enums.gcp.GcpProjStageEnum;
import com.pinde.sci.form.gcp.GcpCfgFileForm;
import com.pinde.sci.model.mo.GcpCfg;

/**
 * 
 * @author tiger
 *
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class GcpCfgBizImpl implements IGcpCfgBiz {
	@Resource
	private GcpCfgMapper gcpCfgMapper;

	@Override
	public int saveFinishFileTemplate(GcpCfgFileForm fileForm) throws Exception {
		if(fileForm != null){
			Document dom = null;
			Element root = null;
			String id = StringUtil.defaultIfEmpty(fileForm.getId(),"");
			String fileName = StringUtil.defaultIfEmpty(fileForm.getFileName(),"");
			String stage = StringUtil.defaultIfEmpty(fileForm.getStage(),"");
			
			GcpCfg gcpCfg = gcpCfgMapper.selectByPrimaryKey(GlobalConstant.GCP_FINISH_FILE_CFG_CODE);
			if(gcpCfg == null){
				//第一次新增XML
				dom = DocumentHelper.createDocument();
				root = dom.addElement("finishFile");
				//阶段
				GcpProjStageEnum[] stageEnums =  GcpProjStageEnum.values();
				for(GcpProjStageEnum enums : stageEnums){
					Element stageElement = root.addElement("stage");
					stageElement.addAttribute("value", enums.getId());
					if(stage.equals(enums.getId())){
						Element fileElement = stageElement.addElement("file").addAttribute("id", PkUtil.getUUID());
						fileElement.addElement("fileName").setText(fileName);
					}
				}
				gcpCfg = new GcpCfg();
				gcpCfg.setCfgCode(GlobalConstant.GCP_FINISH_FILE_CFG_CODE);
				gcpCfg.setCfgDesc("归档文件清单");
				
				gcpCfg.setCfgBigValue(dom.asXML());
				GeneralMethod.setRecordInfo(gcpCfg, true);
				return gcpCfgMapper.insert(gcpCfg);
			}
			
			String cfgBigValue = gcpCfg.getCfgBigValue();
			dom = DocumentHelper.parseText(cfgBigValue);
			
			if(StringUtil.isNotBlank(fileForm.getId())){//修改file
				String fileXpath = "//file[@id='"+id+"']";
				Node fileNode = dom.selectSingleNode(fileXpath);
				Node fileNameNode = fileNode.selectSingleNode("fileName");
				fileNameNode.setText(fileName);
			}else{//新增file
				String stageXpath ="/finishFile/stage[@value='"+stage+"']";
			    Element stageElement = (Element) dom.selectSingleNode(stageXpath);
				Element fileElement = stageElement.addElement("file");
				fileElement.addAttribute("id", PkUtil.getUUID());
				fileElement.addElement("fileName").setText(fileName);
			}
			gcpCfg.setCfgBigValue(dom.asXML());
			GeneralMethod.setRecordInfo(gcpCfg, false);
			return gcpCfgMapper.updateByPrimaryKeyWithBLOBs(gcpCfg);
		}
		return GlobalConstant.ZERO_LINE;
	}
	

	@SuppressWarnings("unchecked")
	@Override
	public List<GcpCfgFileForm> searchFinishFileTemplateList(GcpCfgFileForm fileForm) throws Exception {
		List<GcpCfgFileForm> fileFormList = new ArrayList<GcpCfgFileForm>();
		if(fileForm != null){
			GcpCfg gcpCfg = gcpCfgMapper.selectByPrimaryKey(GlobalConstant.GCP_FINISH_FILE_CFG_CODE);
			if(gcpCfg != null){
				Document dom = DocumentHelper.parseText(gcpCfg.getCfgBigValue());
				String stageXpath;
				if(StringUtil.isNotBlank(fileForm.getStage())){
					stageXpath = "/finishFile/stage[@value='"+fileForm.getStage()+"']";
				}else{
					stageXpath = "/finishFile/stage";
				}
				List<Element> stageElements = dom.selectNodes(stageXpath);//阶段
				if(stageElements != null && !stageElements.isEmpty()){
					for (Element se : stageElements) {
						List<Element> fileElements = se.selectNodes("file");//文件
						if(fileElements != null && !fileElements.isEmpty()){
							for(Element fe :fileElements){
								GcpCfgFileForm file = new GcpCfgFileForm();
								file.setStage(se.attributeValue("value"));
								file.setId(fe.attributeValue("id"));
								file.setFileName(fe.element("fileName") == null ? "" : fe.element("fileName").getTextTrim());
								fileFormList.add(file);
							}
						}
					}
				}
			}
		}
		return fileFormList;
	}

	@Override
	public GcpCfgFileForm getFinishFileTemplateById(String id) throws Exception {
		GcpCfgFileForm fileForm = null;
		if(StringUtil.isNotBlank(id)){
			GcpCfg gcpCfg = gcpCfgMapper.selectByPrimaryKey(GlobalConstant.GCP_FINISH_FILE_CFG_CODE);
			if(gcpCfg != null){
				Document dom = DocumentHelper.parseText(gcpCfg.getCfgBigValue());
				String xpath =  "//file[@id='"+id+"']";
				Element e = (Element) dom.selectSingleNode(xpath);
				fileForm = new GcpCfgFileForm();
				fileForm.setStage(e.getParent().attributeValue("value"));
				fileForm.setId(e.attributeValue("id"));
				fileForm.setFileName(e.element("fileName") == null ? "" : e.element("fileName").getTextTrim());
			}
		}
		return fileForm;
	}


	@Override
	public int delFileTemplateById(String id, String fileType) throws Exception {
		if(StringUtil.isNotBlank(id) && StringUtil.isNotBlank(fileType)){
			GcpCfg gcpCfg = gcpCfgMapper.selectByPrimaryKey(fileType);
			if(gcpCfg != null){
				Document dom = DocumentHelper.parseText(gcpCfg.getCfgBigValue());
				String xpath = "//file[@id='"+id+"']";
				Element fileElement = (Element) dom.selectSingleNode(xpath);
				fileElement.getParent().remove(fileElement);
				
				gcpCfg.setCfgBigValue(dom.asXML());
				GeneralMethod.setRecordInfo(gcpCfg, false);
				return gcpCfgMapper.updateByPrimaryKeySelective(gcpCfg);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	//---------------------送审文件------------------------------


	@Override
	public int saveApplyFileTemplate(GcpCfgFileForm fileForm) throws Exception {
		if(fileForm != null){
			Document dom = null;
			Element root = null;
			String id = StringUtil.defaultIfEmpty(fileForm.getId(),"");
			String fileName = StringUtil.defaultIfEmpty(fileForm.getFileName(),"");
			String version = StringUtil.defaultIfEmpty(fileForm.getVersion(),"");
			String versionDate = StringUtil.defaultIfEmpty(fileForm.getVersionDate(),"");
			String temple = StringUtil.defaultIfEmpty(fileForm.getTemple(),"");
			
			GcpCfg gcpCfg = gcpCfgMapper.selectByPrimaryKey(GlobalConstant.GCP_APPLY_FILE_CFG_CODE);
			if(gcpCfg == null){
				//第一次新增XML
				dom = DocumentHelper.createDocument();
				root = dom.addElement("applyFile");
				Element fileElement = root.addElement("file").addAttribute("id", PkUtil.getUUID());
				fileElement.addElement("fileName").setText(fileName);
				fileElement.addElement("version").setText(version);
				fileElement.addElement("versionDate").setText(versionDate);
				fileElement.addElement("temple").setText(temple);
				
				gcpCfg = new GcpCfg();
				gcpCfg.setCfgCode(GlobalConstant.GCP_APPLY_FILE_CFG_CODE);
				gcpCfg.setCfgDesc("送审文件清单");
				
				gcpCfg.setCfgBigValue(dom.asXML());
				GeneralMethod.setRecordInfo(gcpCfg, true);
				return gcpCfgMapper.insert(gcpCfg);
			}
			
			String cfgBigValue = gcpCfg.getCfgBigValue();
			dom = DocumentHelper.parseText(cfgBigValue);
			if(StringUtil.isNotBlank(fileForm.getId())){//修改file
				String fileXpath = "//file[@id='"+id+"']";
				Node fileNode = dom.selectSingleNode(fileXpath);
				Node fileNameNode = fileNode.selectSingleNode("fileName");
				fileNameNode.setText(fileName);
				Node versionNode = fileNode.selectSingleNode("version");
				versionNode.setText(version);
				Node versionDateNode = fileNode.selectSingleNode("versionDate");
				versionDateNode.setText(versionDate);
				Node templeNode = fileNode.selectSingleNode("temple");
				if(templeNode==null){
					Element ele = (Element)fileNode;
					ele.addElement("temple").setText(temple);
				}else {
					templeNode.setText(temple);
				}
			}else{//新增file
				root = dom.getRootElement();
				Element fileElement = root.addElement("file").addAttribute("id", PkUtil.getUUID());
				fileElement.addElement("fileName").setText(fileName);
				fileElement.addElement("version").setText(version);
				fileElement.addElement("versionDate").setText(versionDate);
				fileElement.addElement("temple").setText(temple);
			}
			gcpCfg.setCfgBigValue(dom.asXML());
			GeneralMethod.setRecordInfo(gcpCfg, false);
			return gcpCfgMapper.updateByPrimaryKeyWithBLOBs(gcpCfg);
		}
		return GlobalConstant.ZERO_LINE;
	}

	
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<GcpCfgFileForm> searchAppLyFileTemplateList() throws Exception {
		List<GcpCfgFileForm> fileFormList = new ArrayList<GcpCfgFileForm>();
		GcpCfg gcpCfg = gcpCfgMapper.selectByPrimaryKey(GlobalConstant.GCP_APPLY_FILE_CFG_CODE);
		if(gcpCfg != null){
			Document dom = DocumentHelper.parseText(gcpCfg.getCfgBigValue());
			String fileXpath = "//file";
			List<Element> fileElements = dom.selectNodes(fileXpath);//文件
			if(fileElements != null && !fileElements.isEmpty()){
				for(Element fe :fileElements){
					GcpCfgFileForm file = new GcpCfgFileForm();
					file.setStage(fe.attributeValue("value"));
					file.setId(fe.attributeValue("id"));
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


	@Override
	public GcpCfgFileForm getApplyFileTemplateById(String id) throws Exception {
		GcpCfgFileForm fileForm = null;
		if(StringUtil.isNotBlank(id)){
			GcpCfg gcpCfg = gcpCfgMapper.selectByPrimaryKey(GlobalConstant.GCP_APPLY_FILE_CFG_CODE);
			if(gcpCfg != null){
				Document dom = DocumentHelper.parseText(gcpCfg.getCfgBigValue());
				String xpath =  "//file[@id='"+id+"']";
				Element fe = (Element) dom.selectSingleNode(xpath);
				fileForm = new GcpCfgFileForm();
				fileForm.setStage(fe.getParent().attributeValue("value"));
				fileForm.setId(fe.attributeValue("id"));
				fileForm.setFileName(fe.element("fileName") == null ? "" : fe.element("fileName").getTextTrim());
				fileForm.setVersion(fe.element("version") == null ? "" : fe.element("version").getTextTrim());
				fileForm.setVersionDate(fe.element("versionDate") == null ? "" : fe.element("versionDate").getTextTrim());
				fileForm.setTemple(fe.element("temple") == null ? "" : fe.element("temple").getTextTrim());
			}
		}
		return fileForm;
	}
	
	@Override
	public int saveQcRemindConfig(GcpCfg cfg){
		if(cfg!=null){
			if(StringUtil.isNotBlank(cfg.getCfgCode())){
				GeneralMethod.setRecordInfo(cfg, false);
				return gcpCfgMapper.updateByPrimaryKeySelective(cfg);
			}else{
				cfg.setCfgCode(GlobalConstant.GCP_QC_REMIND);
				GeneralMethod.setRecordInfo(cfg, true);
				cfg.setCfgDesc("质控提醒配置");
				return gcpCfgMapper.insertSelective(cfg);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public GcpCfg readGcpCfg(String cfgCode){
		return gcpCfgMapper.selectByPrimaryKey(cfgCode);
	}
	
	@Override
	public String createQcConfigXml(Map<String,String[]> configMap){
		Document dom = DocumentHelper.createDocument();
		Element root = dom.addElement("configInfo");
		try{
			for(String key : configMap.keySet()){
				Element item = root.addElement("item");
				item.addAttribute("name",key);
				for(String value : configMap.get(key)){
					Element v = item.addElement("value");
					v.setText(value);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return dom.asXML();
	}
	
	@Override
	public Map<String,List<String>> createQcConfigMap(String configInfo){
		Map<String,List<String>> qcConfigMap = null;
		try{
			Document dom = DocumentHelper.parseText(configInfo);
			Element root = dom.getRootElement();
			if(root != null){
				List<Element> items = root.elements("item");
				if(items!=null && items.size()>0){
					qcConfigMap = new HashMap<String, List<String>>();
					for(Element element : items){
						List<Element> values = element.elements("value");
						String name = element.attributeValue("name");
						if(values!=null && values.size()>0){
							for(Element v : values){
								if(qcConfigMap.get(name)==null){
									List<String> valueList = new ArrayList<String>();
									valueList.add(v.getTextTrim());
									qcConfigMap.put(name,valueList);
								}else{
									qcConfigMap.get(name).add(v.getTextTrim());
								}
							}
						}
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return qcConfigMap;
	}
}
