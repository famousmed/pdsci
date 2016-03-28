package com.pinde.sci.ctrl.srm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IExpertBiz;
import com.pinde.sci.biz.srm.IExpertGroupBiz;
import com.pinde.sci.biz.srm.IExpertGroupProjBiz;
import com.pinde.sci.biz.srm.IExpertGroupsUserBiz;
import com.pinde.sci.biz.srm.IExpertProjBiz;
import com.pinde.sci.biz.srm.IGradeItemBiz;
import com.pinde.sci.biz.srm.IGradeSchemeBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.srm.SrmExpertGroupExtMapper;
import com.pinde.sci.enums.srm.EvaluationStatusEnum;
import com.pinde.sci.enums.srm.EvaluationWayEnum;
import com.pinde.sci.enums.srm.ExpertScoreResultEnum;
import com.pinde.sci.model.mo.SrmExpert;
import com.pinde.sci.model.mo.SrmExpertGroup;
import com.pinde.sci.model.mo.SrmExpertProj;
import com.pinde.sci.model.mo.SrmExpertProjEval;
import com.pinde.sci.model.mo.SrmGradeItem;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.SrmExpertGroupProjExt;
import com.pinde.sci.model.srm.SrmExpertProjExt;

@Controller
@RequestMapping("/srm/expert/proj")
public class ExpertProjController extends GeneralController{

	@Autowired
	private IExpertProjBiz expertProjBiz;
	@Autowired
	private IGradeSchemeBiz gradeSchemeBiz;
	@Autowired
	private SrmExpertGroupExtMapper expertGroupExtMapper;
	@Autowired
	private IGradeItemBiz gradeItemBiz;
	@Autowired
	private IExpertGroupProjBiz expertGroupProjBiz;
	@Autowired
	private IExpertGroupBiz experGroupBiz;
	@Autowired
	private IExpertGroupsUserBiz expertGroupUserBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IExpertBiz expertBiz;
	
	/**
	 * 专家评审默认进入页面(目前只显示网评)
	 * @param userFlow
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/confirm")
	public String confirm(String userFlow , Model model,HttpServletRequest request){
		SrmExpertProjExt srmExpertProjExt = new SrmExpertProjExt();
		srmExpertProjExt.setUserFlow(GlobalContext.getCurrentUser().getUserFlow());
		srmExpertProjExt.setRecordStatus(GlobalConstant.FLAG_Y);
		srmExpertProjExt.setAgreeFlag(GlobalConstant.NULL);//表示没有点过同意按钮的
		SrmExpertGroupProjExt srmExpertGroupProjExt = new SrmExpertGroupProjExt();
		srmExpertGroupProjExt.setEvalStatusId(EvaluationStatusEnum.Submit.getId());//评审设置为提交的状态 专家评审才能看到
		srmExpertProjExt.setSrmExpertGroupProjExt(srmExpertGroupProjExt );
		
//		HashMap<String,Object> map=new HashMap<String, Object>();
//		SrmExpertGroup expertGroup=new SrmExpertGroup();
		//评审项目通知
		List<SrmExpertProjExt> expertProjList = this.expertProjBiz.searchExpertProj(srmExpertProjExt);
//		for(SrmExpertProjExt list:expertProjList){
//				//如果评审方式是网络评审
//				if(EvaluationWayEnum.NetWorkWay.getId().equals(list.getSrmExpertGroupProjExt().getEvaluationWayId())){
//					map.put(list.getProjFlow(), list);
//				}
//				//如果评审方式是会议评审
//				else{
//					expertGroup = experGroupBiz.readSrmExpertGroup(list.getSrmExpertGroupProjExt().getGroupFlow());
//					map.put(list.getProjFlow(), expertGroup);
//				}
//		}
//		model.addAttribute("map", map);
		model.addAttribute("expertProjList" , expertProjList);
		
		SrmExpert expert = expertBiz.readExpert(GlobalContext.getCurrentUser().getUserFlow());
		model.addAttribute("expert", expert);
		return "srm/expert/proj/confirm";
	}
	
	/**
	 * 专家是否同意评审该项目
	 * @param expertProjFlow
	 * @param flag
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/saveConfirm",method={RequestMethod.POST})
	public @ResponseBody String saveConfirm( String expertProjFlow , String flag , Model model){
		SrmExpertProj expertProj = expertProjBiz.read(expertProjFlow);
		expertProj.setAgreeFlag(flag);
		expertProjBiz.modifyByFlow(expertProj);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	/**
	 * 评审时间过期 就隐藏
	 * @param recordFlow
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/hide",method={RequestMethod.POST})
	public @ResponseBody String hide(String recordFlow, Model model,HttpServletRequest request){
		SrmExpertProj expertProj = expertProjBiz.read(recordFlow);
		expertProjBiz.saveForHide(expertProj);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	/**
	 * 评审项目列表
	 * @param scoreType
	 * @param pjName
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/list",method={RequestMethod.GET,RequestMethod.POST})
	public String list( String scoreType,String pjName, Model model,HttpServletRequest request){
		SrmExpertProjExt srmExpertProjExt = new SrmExpertProjExt();
		srmExpertProjExt.setUserFlow(GlobalContext.getCurrentUser().getUserFlow());
		srmExpertProjExt.setRecordStatus(GlobalConstant.FLAG_Y);
		srmExpertProjExt.setAgreeFlag(GlobalConstant.FLAG_Y);//表示没有点过同意按钮的
		if(StringUtil.isNotBlank(scoreType)){
			if(scoreType.equals(GlobalConstant.FLAG_Y)){
				srmExpertProjExt.setScoreTotal(GlobalConstant.NOT_NULL);
			}else if(scoreType.equals(GlobalConstant.FLAG_N)){
				srmExpertProjExt.setScoreTotal(GlobalConstant.NULL);
			}
		} 
		if(StringUtil.isNotBlank(pjName)){
			srmExpertProjExt.setProjName("%"+pjName+"%");
		}
		SrmExpertGroupProjExt srmExpertGroupProjExt = new SrmExpertGroupProjExt();
		srmExpertGroupProjExt.setEvalStatusId(EvaluationStatusEnum.Submit.getId());//评审设置为提交的状态 专家评审才能看到
		srmExpertProjExt.setSrmExpertGroupProjExt(srmExpertGroupProjExt );
		//评审项目通知
		List<SrmExpertProjExt> expertProjList = this.expertProjBiz.searchExpertProj(srmExpertProjExt);
		model.addAttribute("expertProjList",expertProjList);
		return "srm/expert/proj/list";
	}
	
	/**
	 * 专家打分
	 * @param expertProjFlow
	 * @param model
	 * @return
	 * @throws DocumentException 
	 */
	@RequestMapping(value="/score",method={RequestMethod.GET})
	public String score(String expertProjFlow , Model model) throws DocumentException{
		//评分记录保存对象
		SrmExpertProj expertProj = expertProjBiz.read(expertProjFlow);
		model.addAttribute("expertProj", expertProj);
		
		SrmExpertProjEval groupProj = expertGroupProjBiz.searchSrmExpertGroupProjByFlow(expertProj.getEvalSetFlow());
		
		if(StringUtil.isNotBlank(groupProj.getSchemeFlow())){
			SrmGradeItem item = new SrmGradeItem();
			item.setSchemeFlow(groupProj.getSchemeFlow());
			List<SrmGradeItem> gradeItem = gradeItemBiz.searchGradeItem(item);
			model.addAttribute("gradeItem",gradeItem); 
		}
		//评分值
		Map<String,String> scoreItemMap = new HashMap<String, String>();
		String scoreItem = expertProj.getScoreItem();
		if(StringUtil.isNotBlank(scoreItem)){
			Document document = DocumentHelper.parseText(scoreItem);
			List<Element> eleList = document.selectNodes("/scoreItem/score");
			for(Element ele :eleList){
				scoreItemMap.put(ele.attributeValue("itemFlow"), ele.getText()); 
			}
			model.addAttribute("scoreItemMap", scoreItemMap);
		}
		return "srm/expert/proj/score";
	}
	
	/**
	 * 保存分数
	 * @param paramObj
	 * @param schemeFlow
	 * @param status 提交 还是 保存
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping(value="/saveScore",method={RequestMethod.POST})
	@ResponseBody
	public String saveScore(SrmExpertProj paramObj,String schemeFlow, String status , Model model,HttpServletRequest req){
		SrmExpertProj expertProj = expertProjBiz.read(paramObj.getExpertProjFlow());
//		SrmGradeScheme scheme = gradeSchemeBiz.readGradeScheme(schemeFlow);
		
		if(paramObj.getScoreResultId().equals(ExpertScoreResultEnum.Agree.getId())){
			expertProj.setScoreResultId(ExpertScoreResultEnum.Agree.getId()); 
			expertProj.setScoreResultName(ExpertScoreResultEnum.Agree.getName()); 
		}else if(paramObj.getScoreResultId().equals(ExpertScoreResultEnum.NotAgree.getId())){
			expertProj.setScoreResultId(ExpertScoreResultEnum.NotAgree.getId()); 
			expertProj.setScoreResultName(ExpertScoreResultEnum.NotAgree.getName());
		}
		expertProj.setScoreTotal(paramObj.getScoreTotal());
		expertProj.setExpertOpinion(paramObj.getExpertOpinion());
		expertProj.setEvalStatusId(status);
		expertProj.setEvalStatusName(EvaluationStatusEnum.getNameById(status));
		
//		expertProj.setSchemeFlow(schemeFlow);
//		expertProj.setSchemeName(scheme.getSchemeName());
		
		//评分方案列表 ，用于项目切换评分方案需求
		SrmGradeItem item = new SrmGradeItem();
		item.setSchemeFlow(schemeFlow);
		List<SrmGradeItem> gradeItem = gradeItemBiz.searchGradeItem(item);
		
		Document document = DocumentHelper.createDocument();
		//建立根节点
		Element rootElement = document.addElement("scoreItem");
		for(SrmGradeItem temp : gradeItem){
			Element scoreEle =  rootElement.addElement("score");
			scoreEle.addAttribute("ordinal", temp.getOrdinal()+"");
			scoreEle.addAttribute("itemFlow",temp.getItemFlow());
			scoreEle.setText(StringUtil.toHtml(req.getParameter(temp.getItemFlow()))); 
		}
		expertProj.setScoreItem(document.asXML());
		expertProjBiz.modifyByFlow(expertProj) ;
		return GlobalConstant.SAVE_SUCCESSED;
	}

	
//	@RequestMapping(value="/saveExpertNotice",method={RequestMethod.POST})
//	@ResponseBody
//	public String saveExpertNotice(String[] recordFlows,Model model,HttpServletRequest req){
//		if(recordFlows!=null && recordFlows.length>0	){
//			for(String recordFlow :recordFlows){
//				SrmExpertProj expertProj = expertProjBiz.read(recordFlow);
//				expertProj.setEmailNotifyFlag(req.getParameter(recordFlow+"_emailNotifyFlag"));
//				expertProj.setPhoneNotifyFlag(req.getParameter(recordFlow+"_phoneNotifyFlag"));
//				expertProj.setFeedbackInfo(req.getParameter(recordFlow+"_feedBackInfo"));
//				expertProjBiz.modifyWithOutBlobsByFlow(expertProj);
//			}
//		}
//		return GlobalConstant.SAVE_SUCCESSED;
//	}
	
	
	/**
	 * 完善专家信息
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/finishInfo",method={RequestMethod.GET})
	public String finishInfo(String userFlow, Model model){
		if(StringUtil.isNotBlank(userFlow)){
			SysUser user = userBiz.readSysUser(userFlow);
			model.addAttribute("user", user);
			SrmExpert expert = expertBiz.readExpert(userFlow);
			model.addAttribute("expert", expert);
		}
		return "srm/expert/finishInfo";
	}
}
