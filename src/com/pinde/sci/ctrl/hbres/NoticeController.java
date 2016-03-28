package com.pinde.sci.ctrl.hbres;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.sci.biz.hbres.NoticeBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.model.mo.InxInfo;

/**
 * ¹«¸æÎ¬»¤
 * @author shenzhen
 *
 */
@Controller
@RequestMapping("/hbres/notice")
public class NoticeController extends GeneralController{

	@Autowired
	private NoticeBiz noticeBiz;
	
	@ResponseBody
	@RequestMapping("/save")
	public String saveNotice(String infoFlow , String title , String content){
		InxInfo info = new InxInfo();
		info.setInfoFlow(infoFlow);
		info.setInfoTitle(title);
		info.setInfoContent(content);
		noticeBiz.save(info);
		return GlobalConstant.OPERATE_SUCCESSED;
	}

	@RequestMapping("/findnoticebyflow")
	@ResponseBody
	public Object findNoticeByFlow(String infoFlow){
		return this.noticeBiz.findNoticByFlow(infoFlow);
	}
	
	@RequestMapping(value="/view")
	public String message(Model model,String infoFlow) throws Exception{
		model.addAttribute("msg", noticeBiz.findNoticByFlow(infoFlow));
		return "hbres/message";
	}
	
	@ResponseBody
	@RequestMapping("/delnotice")
	public String delNotice(String infoFlow){
		this.noticeBiz.delNotice(infoFlow);
		return GlobalConstant.DELETE_SUCCESSED;
	}
}
