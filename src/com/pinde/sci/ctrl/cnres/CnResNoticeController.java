package com.pinde.sci.ctrl.cnres;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.sci.biz.cnres.ICnResNoticeBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.model.mo.InxInfo;

/**
 * ¹«¸æÎ¬»¤
 * @author shenzhen
 *
 */
@Controller
@RequestMapping("/cnres/notice")
public class CnResNoticeController extends GeneralController{

	@Autowired
	private ICnResNoticeBiz ICnResNoticeBiz;
	
	@ResponseBody
	@RequestMapping("/save")
	public String saveNotice(String infoFlow , String title , String content){
		InxInfo info = new InxInfo();
		info.setInfoFlow(infoFlow);
		info.setInfoTitle(title);
		info.setInfoContent(content);
		ICnResNoticeBiz.save(info);
		return GlobalConstant.OPERATE_SUCCESSED;
	}

	@RequestMapping("/findnoticebyflow")
	@ResponseBody
	public Object findNoticeByFlow(String infoFlow){
		return this.ICnResNoticeBiz.findNoticByFlow(infoFlow);
	}
	
	@RequestMapping(value="/view")
	public String message(Model model,String infoFlow) throws Exception{
		model.addAttribute("msg", ICnResNoticeBiz.findNoticByFlow(infoFlow));
		return "cnres/message";
	}
	
	@ResponseBody
	@RequestMapping("/delnotice")
	public String delNotice(String infoFlow){
		this.ICnResNoticeBiz.delNotice(infoFlow);
		return GlobalConstant.DELETE_SUCCESSED;
	}
}
