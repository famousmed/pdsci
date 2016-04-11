package com.pinde.sci.biz.edc.impl;

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
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcProjBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.EdcProjParamMapper;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.dao.edc.PubProjEdcMapper;
import com.pinde.sci.enums.gcp.GcpProjSubTypeEnum;
import com.pinde.sci.form.pub.ProjFileForm;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjExample;
import com.pinde.sci.model.mo.PubProjExample.Criteria;
@Service
@Transactional(rollbackFor=Exception.class)
public class EdcProjParamBizImpl implements IEdcProjBiz {
	@Resource
	private PubProjMapper pubProjMapper;
	@Resource
	private PubProjEdcMapper pubProjEdcMapper;
	@Resource
	private EdcProjParamMapper projParamMapper;
	@Autowired
	private IFileBiz fileBiz;
	
	@Override
	public PubProj read(String projFlow) {
		return pubProjMapper.selectByPrimaryKey(projFlow);
	}

	@Override
	public void save(PubProj proj) {
		if(StringUtil.isNotBlank(proj.getProjSubTypeId())){
			proj.setProjSubTypeName(GcpProjSubTypeEnum.getNameById(proj.getProjSubTypeId()));
		}
		if(StringUtil.isBlank(proj.getProjFlow())){
			add(proj);
		}else{
			mod(proj);
		}
	}

	@Override
	public void add(PubProj proj) {
		proj.setProjFlow(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(proj, true);
		pubProjMapper.insert(proj);
	}

	@Override
	public void mod(PubProj proj) {
		GeneralMethod.setRecordInfo(proj, false);
		pubProjMapper.updateByPrimaryKeySelective(proj);
	}

	@Override
	public void del(PubProj proj) {
		GeneralMethod.setRecordInfo(proj, false);
		pubProjMapper.updateByPrimaryKeySelective(proj);
	}

	@Override
	public List<PubProj> search(PubProj proj) {
		PubProjExample example = new PubProjExample();
		Criteria criteria = example.createCriteria();
		if(StringUtil.isNotBlank(proj.getRecordStatus())){
			criteria.andRecordStatusEqualTo(proj.getRecordStatus());
		}
		if(StringUtil.isNotBlank(proj.getProjNo())){
			criteria.andProjNoEqualTo(proj.getProjNo());
		}
		if(StringUtil.isNotBlank(proj.getProjName())){
			criteria.andProjNameLike("%"+proj.getProjName()+"%");
		}
		return pubProjMapper.selectByExample(example);
	}

	@Override
	public List<PubProj> searchForUser(PubProj proj,String userFlow) {
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("userFlow", userFlow);
		paramMap.put("projNo", proj.getProjNo());
		paramMap.put("projName", "%"+StringUtil.defaultString(proj.getProjName())+"%");
		return pubProjEdcMapper.selectUserProjList(paramMap);
	}

	@Override
	public EdcProjParam readProjParam(String projFlow) {
		return projParamMapper.selectByPrimaryKey(projFlow);
	}

	@Override
	public void addProjParam(EdcProjParam record) {
		GeneralMethod.setRecordInfo(record, true);
		projParamMapper.insert(record);
	}

	@Override
	public void modify(EdcProjParam param) {
		GeneralMethod.setRecordInfo(param, false);
		projParamMapper.updateByPrimaryKeySelective(param);
	}
	
	@SuppressWarnings("unchecked")
    @Override
    public List<ProjFileForm> searchProjFiles(String projFlow) throws Exception {
        if(StringUtil.isNotBlank(projFlow)){
            List<ProjFileForm> fileList = new ArrayList<ProjFileForm>();
            PubProj proj = pubProjMapper.selectByPrimaryKey(projFlow);
            if(proj != null && StringUtil.isNotBlank(proj.getProjInfo())){
                Document dom = DocumentHelper.parseText(proj.getProjInfo());
                String fileXpath = "projInfo/files/file";
                List<Element> fileElements = dom.selectNodes(fileXpath);
                if(fileElements != null && !fileElements.isEmpty()){
                    for (Element fe : fileElements) {
                    	ProjFileForm file = new ProjFileForm();
                        file.setFileFlow(fe.element("fileFlow").getText());
                        file.setFileName(fe.element("fileName").getText());
                        file.setIsShared(fe.element("isShared").getText());
                        fileList.add(file);
                    }
                }
            }
            return fileList;
        }
        return null;
    }
	
	@Override
	public int savePubFile(MultipartFile[] files,String projFlow) throws Exception{
		if(StringUtil.isNotBlank(projFlow) && files != null && files.length>0){
			PubProj proj = pubProjMapper.selectByPrimaryKey(projFlow);
            if(proj != null){
            	String projInfo = proj.getProjInfo();
            	if (StringUtil.isBlank(projInfo)) {
            		projInfo = "<projInfo/>";
            	}
            	Document dom = DocumentHelper.parseText(projInfo);
            	Element root = (Element)dom.selectSingleNode("projInfo");
            	Element filesEle = (Element)root.selectSingleNode("files");
            	if (filesEle == null) {
            		filesEle = root.addElement("files");
            	}
    			for (int i=0;i<files.length;i++) {
    				MultipartFile file = files[i];
    				if(file!=null){
    					String fileFlow = PkUtil.getUUID();
    					String fileName = file.getOriginalFilename();
    					Element fileEle = filesEle.addElement("file");
    					fileEle.addElement("fileFlow").setText(fileFlow);
    					fileEle.addElement("fileName").setText(fileName);
    					fileEle.addElement("isShared").setText("");
    					
    					PubFile pubFile = new PubFile();
    					pubFile.setFileFlow(fileFlow);
    					pubFile.setFileName(fileName);
    					String suffix = fileName.substring(fileName.lastIndexOf(".")+1);
						pubFile.setFileContent(file.getBytes());
						pubFile.setFileSuffix(suffix);
    					fileBiz.saveFile(pubFile);
    				}
    			}
    			proj.setProjInfo(dom.asXML());
    			mod(proj);
            }
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int modPubFile(String fileFlow,String isShared,String recordStatus,String projFlow) throws Exception{
		if(StringUtil.isNotBlank(projFlow)){
			PubProj proj = pubProjMapper.selectByPrimaryKey(projFlow);
            if(proj != null){
            	String projInfo = proj.getProjInfo();
            	if (StringUtil.isBlank(projInfo)) {
            		projInfo = "<projInfo/>";
            	}
            	Document dom = DocumentHelper.parseText(projInfo);
            	Element root = (Element)dom.selectSingleNode("projInfo");
            	Element fileEle = (Element)root.selectSingleNode("files/file[fileFlow='"+fileFlow+"']");
            	if (fileEle != null) {
            		if (StringUtil.isNotBlank(recordStatus)) {//删除操作
            			System.err.println("==recordStatus="+recordStatus);
            			Element filesEle = (Element)root.selectSingleNode("files");
            			if (filesEle != null) {
            				filesEle.remove(fileEle);
            			}
            		} else {//是否机构浏览操作
            			Element isSharedEle = (Element)fileEle.selectSingleNode("isShared");
                		if (isSharedEle == null) {
                			fileEle.addElement("isShared").setText(isShared);
                		} else {
                			isSharedEle.setText(isShared);
                		}
            		}
            	}
    			proj.setProjInfo(dom.asXML());
    			mod(proj);
            }
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}
	
}
