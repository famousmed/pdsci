package com.pinde.sci.biz.res.impl;

import java.util.List;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.QName;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.res.IResAssessCfgBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.ResAssessCfgMapper;
import com.pinde.sci.enums.res.ResAssessTypeEnum;
import com.pinde.sci.form.res.ResAssessCfgForm;
import com.pinde.sci.form.res.ResAssessCfgItemForm;
import com.pinde.sci.form.res.ResAssessCfgTitleForm;
import com.pinde.sci.model.mo.ResAssessCfg;
import com.pinde.sci.model.mo.ResAssessCfgExample;
import com.pinde.sci.model.mo.SysUser;
/**
 * 
 * @author tiger
 *
 */
@Service
@Transactional(rollbackFor=Exception.class)
public class ResAssessCfgBizImpl implements IResAssessCfgBiz {
	@Autowired
	private ResAssessCfgMapper assessCfgMapper;
	
	@Override
	public int editAssessCfgTitle(ResAssessCfg assesscfg, ResAssessCfgTitleForm titleForm) throws Exception {
		SysUser currUser = GlobalContext.getCurrentUser();
		if(currUser != null){
			Document dom = null;
			Element root = null;
			String titleId = StringUtil.defaultIfEmpty(titleForm.getId(),"");
			String titleName = StringUtil.defaultIfEmpty(titleForm.getName(),"");
			
			ResAssessCfg existAssessCfg = readResAssessCfg(assesscfg.getCfgFlow());
			if(existAssessCfg == null){
				//第一次新增XML
				dom = DocumentHelper.createDocument();
				root = dom.addElement("assessCfg");
				Element titleElement = root.addElement("title").addAttribute("id", PkUtil.getUUID());
				titleElement.addAttribute("name",titleName);
				
				existAssessCfg = new ResAssessCfg();
				existAssessCfg.setOrgFlow(currUser.getOrgFlow());
				String cfgCodeId = assesscfg.getCfgCodeId();
				existAssessCfg.setCfgCodeId(cfgCodeId);
				existAssessCfg.setCfgCodeName(ResAssessTypeEnum.getNameById(cfgCodeId));
				
				existAssessCfg.setCfgBigValue(dom.asXML());
				return saveAssessCfg(existAssessCfg);
			}else{
				dom = DocumentHelper.parseText(existAssessCfg.getCfgBigValue());
				root = dom.getRootElement();
				
				if(StringUtil.isBlank(titleId)){//新增title节点
					Element titleElement = root.addElement("title");
					titleElement.addAttribute("id", PkUtil.getUUID());
					titleElement.addAttribute("name", titleName);
				}else{
					String titleXpath = "//title[@id='"+titleId+"']";
					Element titleElement = (Element) dom.selectSingleNode(titleXpath);
					//titleElement.setAttributeValue("name", titleName);
					titleElement.attribute("name").setValue(titleName);
				}
				existAssessCfg.setCfgBigValue(dom.asXML());
				return saveAssessCfg(existAssessCfg);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public ResAssessCfg readResAssessCfg(String cfgFlow) {
		if(StringUtil.isNotBlank(cfgFlow)){
			return assessCfgMapper.selectByPrimaryKey(cfgFlow);
		}
		return null;
	}
	
	@Override
	public int deleteTitle(String cfgFlow, String id) throws Exception {
		if(StringUtil.isNotBlank(cfgFlow) && StringUtil.isNotBlank(id)){
			ResAssessCfg existAssessCfg = readResAssessCfg(cfgFlow);
			if(existAssessCfg != null){
				Document dom = DocumentHelper.parseText(existAssessCfg.getCfgBigValue());
				String titleXpath = "//title[@id='"+id+"']";
				Element titleElement = (Element) dom.selectSingleNode(titleXpath);
				titleElement.getParent().remove(titleElement);
				existAssessCfg.setCfgBigValue(dom.asXML());
				return saveAssessCfg(existAssessCfg);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int saveAssessCfg(ResAssessCfg assessCfg) {
		if(StringUtil.isNotBlank(assessCfg.getCfgFlow()) ){
			GeneralMethod.setRecordInfo(assessCfg, false);
			return assessCfgMapper.updateByPrimaryKeyWithBLOBs(assessCfg);
		}else{
			assessCfg.setCfgFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(assessCfg, true);
			return assessCfgMapper.insert(assessCfg);
		}
	}

	@Override
	public List<ResAssessCfg> searchAssessCfgList(ResAssessCfg assessCfg) {
		ResAssessCfgExample example = new ResAssessCfgExample();
		com.pinde.sci.model.mo.ResAssessCfgExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(assessCfg.getOrgFlow())){
			criteria.andOrgFlowEqualTo(assessCfg.getOrgFlow());
		}
		if(StringUtil.isNotBlank(assessCfg.getCfgCodeId())){
			criteria.andCfgCodeIdEqualTo(assessCfg.getCfgCodeId());
		}
		return assessCfgMapper.selectByExampleWithBLOBs(example);
	}

	@Override
	public int saveAssessItemList(ResAssessCfgForm form) throws Exception {
		String cfgFlow = form.getCfgFlow();
		List<ResAssessCfgItemForm> itemFormList = form.getItemFormList();
		if(itemFormList != null && !itemFormList.isEmpty()){
			ResAssessCfg existAssessCfg = readResAssessCfg(cfgFlow);
			if(existAssessCfg != null){
				Document dom = DocumentHelper.parseText(existAssessCfg.getCfgBigValue());
				for(ResAssessCfgItemForm item : itemFormList){
					String titleId = item.getTitleId();
					String name = item.getName();
					String score = item.getScore();
					String titleXpath = "//title[@id='"+titleId+"']";
					Element titleElement = (Element) dom.selectSingleNode(titleXpath);
					Element itemElement = titleElement.addElement("item");
					itemElement.addAttribute("id", PkUtil.getUUID());
					itemElement.addElement("name").setText(name);
					itemElement.addElement("score").setText(score);
				}
				existAssessCfg.setCfgBigValue(dom.asXML());
				return saveAssessCfg(existAssessCfg);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}


	@Override
	public int modifyItem(String cfgFlow, ResAssessCfgItemForm itemForm) throws Exception {
		String id = itemForm.getId();
		if(StringUtil.isNotBlank(cfgFlow) && StringUtil.isNotBlank(id)){
			ResAssessCfg existAssessCfg = readResAssessCfg(cfgFlow);
			if(existAssessCfg != null){
				Document dom = DocumentHelper.parseText(existAssessCfg.getCfgBigValue());
				String name = itemForm.getName();
				String score = itemForm.getScore();
				String itemXpath = "//item[@id='"+id+"']";
				Node itemNode = dom.selectSingleNode(itemXpath);
				Node nameNode = itemNode.selectSingleNode("name");
				nameNode.setText(name);
				Node scoreNode = itemNode.selectSingleNode("score");
				scoreNode.setText(score);
				
				existAssessCfg.setCfgBigValue(dom.asXML());
				return saveAssessCfg(existAssessCfg);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int deleteItem(String cfgFlow, String id) throws Exception {
		if(StringUtil.isNotBlank(cfgFlow) && StringUtil.isNotBlank(id)){
			ResAssessCfg existAssessCfg = readResAssessCfg(cfgFlow);
			if(existAssessCfg != null){
				Document dom = DocumentHelper.parseText(existAssessCfg.getCfgBigValue());
				String itemXpath = "//item[@id='"+id+"']";
				Element itemElement = (Element) dom.selectSingleNode(itemXpath);
				itemElement.getParent().remove(itemElement);
				existAssessCfg.setCfgBigValue(dom.asXML());
				return saveAssessCfg(existAssessCfg);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
}
