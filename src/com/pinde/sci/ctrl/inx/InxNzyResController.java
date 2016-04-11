package com.pinde.sci.ctrl.inx;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pinde.core.page.PageHelper;
import com.pinde.sci.biz.hbres.NoticeBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.sczyres.InxBiz;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.dao.base.SysLogMapper;
import com.pinde.sci.model.mo.InxInfo;

@Controller
@RequestMapping("/inx/nzyres")
public class InxNzyResController extends GeneralController{

	@Autowired
	private InxBiz inxBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private IUserBiz userBiz;
	@Resource
	private IResDoctorBiz resDoctorBiz;
	@Autowired
	private NoticeBiz noticeBiz;
	@Autowired
	private SysLogMapper logMapper;
	
	/**
	 * œ‘ æµ«¬ΩΩÁ√Ê
	 * @return
	 */
	@RequestMapping("")
	public String showLogin(Model model){
		InxInfo info = new InxInfo();
		PageHelper.startPage(1,2);
		List<InxInfo> infos = this.noticeBiz.findNotice(info);
		model.addAttribute("infos",infos);
		return "inx/nzyres/login";
	}
}
