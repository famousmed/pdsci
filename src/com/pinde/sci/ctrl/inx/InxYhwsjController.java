package com.pinde.sci.ctrl.inx;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.inx.IinxColumnManageBiz;
import com.pinde.sci.biz.inx.IinxInfoManageBiz;
import com.pinde.sci.biz.inx.IInxInfoBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.form.inx.InxInfoForm;
import com.pinde.sci.model.mo.InxColumn;
import com.pinde.sci.model.mo.InxInfo;
/**
 * 
 * @author tiger
 *
 */

@Controller
@RequestMapping("/inx/yhwsj")
public class InxYhwsjController extends GeneralController{
	
	private static Logger logger = LoggerFactory.getLogger(InxYhwsjController.class);
	@Autowired
	private IInxInfoBiz inxInfoBiz;
	@Autowired
	private IinxColumnManageBiz columnBiz;
	@Autowired
	private IinxInfoManageBiz infoManageBiz;
	
	/**
	 * ������ҳ��Ѷ�б�
	 * @param columnId
	 * @param jsp
	 * @param model
	 * @param endIndex
	 * @return
	 */
	@RequestMapping(value="/queryData",method={RequestMethod.GET})
	public String queryData(String columnId,String jsp, Model model,String endIndex,String imgUrl){
		InxInfoForm form = new InxInfoForm();
		form.setColumnId(columnId);
		PageHelper.startPage(1, Integer.parseInt(endIndex));
		List<InxInfo> infoList = inxInfoBiz.getList(form);
		model.addAttribute("infoList", infoList);
		if(GlobalConstant.FLAG_Y.equals(imgUrl)){
			//ͼƬ·��
			String imageBaseUrl = this.infoManageBiz.getImageBaseUrl();
			model.addAttribute("imageBaseUrl", imageBaseUrl);
		}
		return jsp;
	}	
	
	/**
	 * ��������ͼƬ
	 * @param columnId
	 * @param jsp
	 * @param model
	 * @param endIndex
	 * @return
	 */
	@RequestMapping(value="/queryImgNews",method={RequestMethod.GET})
	public String queryImgNews(String columnId,String jsp,Model model,String endIndex){
		String imageBaseUrl = this.infoManageBiz.getImageBaseUrl();//ͼƬurl��·��
		model.addAttribute("imageBaseUrl", imageBaseUrl);
		InxInfoForm form = new InxInfoForm();
		form.setColumnId(columnId);
		form.setHasImage(GlobalConstant.FLAG_Y);
		PageHelper.startPage(1, Integer.parseInt(endIndex));
		List<InxInfo> imgNewsList = inxInfoBiz.getList(form);
		model.addAttribute("imgNewsList", imgNewsList);
		return jsp;
	}	
	
	/**
	 * ��ҳ
	 * @param column
	 * @param model
	 * @return
	 */
	@RequestMapping(value="",method={RequestMethod.GET})
	public String index(InxColumn column, Model model){
		return "inx/yhwsj/index";
	}
	
	/**
	 * �鿴һ����Ѷ
	 * @param infoFlow
	 * @param columnId
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/getByInfoFlow",method={RequestMethod.GET})
	public String getByInfoFlow(String infoFlow, String endDate, String columnId, String nextFlag, Model model){
		if(StringUtil.isNotBlank(infoFlow)){
			InxInfo info = inxInfoBiz.getByInfoFlow(infoFlow);
			model.addAttribute("info", info);
			//�����
			if(info != null){
				Long viewNum = info.getViewNum();
				if(viewNum == null){
					viewNum = Long.valueOf(0);
				}
				viewNum ++;
				InxInfo update = new InxInfo();
				update.setInfoFlow(infoFlow);
				update.setViewNum(viewNum);
				inxInfoBiz.modifyInxInfo(update);
			}
			//��һƪ
			if((!GlobalConstant.FLAG_N.equals(nextFlag)) && StringUtil.isNotBlank(columnId)){
				InxInfoForm form = new InxInfoForm();
				form.setColumnId(columnId);
				form.setEndDate(endDate);
				PageHelper.startPage(1, 10);
				List<InxInfo> infoList = inxInfoBiz.getList(form);
				if(infoList != null && !infoList.isEmpty()){
					InxInfo nextInfo = null;
					for(int i = 0; i < infoList.size(); i++){
						if(infoList.get(i).getInfoFlow().equals(infoFlow) && (i+1)<infoList.size()){
							nextInfo = infoList.get(i+1);
							model.addAttribute("nextInfo", nextInfo);
							break;
						}
					}
				}
			}
		}
		return "inx/yhwsj/news_children";
	}
	
	/**
	 * ���ط���
	 * @param columnId
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/queryByColumnId",method={RequestMethod.GET})
	public ModelAndView queryByColumnId(String columnId, Model model){
		ModelAndView mav = new ModelAndView();
		if(StringUtil.isNotBlank(columnId)){
			//����
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("columnId", columnId);
			List<InxColumn> classifyList = columnBiz.searchInxColumnList(paramMap);
			mav.addObject("classifyList", classifyList);
		}
		mav.setViewName("inx/yhwsj/news");
		return mav;
	}
	
	
	/**
	 * ������Ѷ�б�
	 * @param columnId
	 * @param currentPage
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="loadInfoList",method={RequestMethod.GET})
	public ModelAndView loadInfoList(String columnId, Integer currentPage, HttpServletRequest request, String isWithBlobs, Model model){
		ModelAndView mav = new ModelAndView();
		InxInfoForm form = new InxInfoForm();
		form.setColumnId(columnId);
		if(GlobalConstant.FLAG_Y.equals(isWithBlobs)){
			form.setIsWithBlobs(GlobalConstant.FLAG_Y);
		}
		List<InxInfo> infoList2 = new ArrayList<InxInfo>();
		PageHelper.startPage(currentPage, getPageSize(request));
		if(columnId.length() > 4){//����
			infoList2 = this.inxInfoBiz.queryClassifyList(form);
		}else{
			infoList2 = this.inxInfoBiz.getList(form);
		}
		mav.addObject("infoList2", infoList2);
		//������Ѷ����
		/*if(infoList2 != null &&  !infoList2.isEmpty()){
			InxInfo firstInfo = inxInfoBiz.getByInfoFlow(infoList2.get(0).getInfoFlow());
			mav.addObject("firstInfo", firstInfo);
		}*/
		//ͼƬ·��
		String imageBaseUrl = this.infoManageBiz.getImageBaseUrl();
		mav.addObject("imageBaseUrl", imageBaseUrl);
		if(GlobalConstant.FLAG_Y.equals(isWithBlobs)){
			//mav.setViewName("inx/yhwsj/expert");
		}else{
			mav.setViewName("inx/yhwsj/infoList");
		}
		return mav;
	}
	
	/**
	 * �˳�
	 * @param request
	 * @return
	 */
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "inx/yhwsj/index";
	}
		
}
