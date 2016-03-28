package com.pinde.sci.ctrl.srm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IExpertBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.SrmExpert;
import com.pinde.sci.model.mo.SysUser;
/**
 * 
 * @author tiger
 *
 */
@Controller
@RequestMapping("/srm/expert")
public class ExpertController extends GeneralController{
	
	@Autowired
	private IExpertBiz expertBiz;
	@Autowired
	private IUserBiz userBiz;
	
	@RequestMapping(value="/list")
	public String list(SysUser sysUser, Integer currentPage,HttpServletRequest request, Model model){
		
		Map<String,SysUser> userMap = new HashMap<String,SysUser>();
		List<SrmExpert> expertList = new ArrayList<SrmExpert>();

		List<String> expertFlowList = new ArrayList<String>();//���ר����ˮ��
		List<SysUser> userList = expertBiz.searchExpertFormSysUser(sysUser);
		for(SysUser u :userList){
			userMap.put(u.getUserFlow(), u);
			expertFlowList.add(u.getUserFlow());
		}
		 
		if(!expertFlowList.isEmpty()){
			PageHelper.startPage(currentPage, getPageSize(request));
			expertList = expertBiz.searchExpertList(expertFlowList);
			model.addAttribute("expertList", expertList);
		}
		
		model.addAttribute("userMap", userMap);
		
		return "/srm/expert/list";
	}
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	@ResponseBody
	public String save(SysUser user , SrmExpert expert){
		//�Ա�
		user.setSexName(UserSexEnum.getNameById(user.getSexId()));
		//ְ��
		user.setTitleName(DictTypeEnum.UserTitle.getDictNameById(user.getTitleId()));
		//ѧλ
		user.setDegreeName(DictTypeEnum.UserDegree.getDictNameById(user.getDegreeId()));
		
		//ѧ��
		user.setEducationName(DictTypeEnum.UserEducation.getDictNameById(user.getEducationId()));
		expert.setEducation(DictTypeEnum.UserEducation.getDictNameById(user.getEducationId()));
		//ְ��
		user.setPostName(DictTypeEnum.UserPost.getDictNameById(user.getPostId()));
		expert.setPost(DictTypeEnum.UserPost.getDictNameById(user.getPostId()));
		
		int result = expertBiz.updateSysUserAndSrmExpert(user,expert);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}

	
	@RequestMapping(value="/editBySelf")
	public String editBySelf(Model model){
		SysUser user = GlobalContext.getCurrentUser();
		return "redirect:edit?userFlow="+user.getUserFlow();
	}
	
	@RequestMapping(value="/edit")
	public String edit(String userFlow, Model model){
		if(StringUtil.isNotBlank(userFlow)){
			SysUser user = this.userBiz.readSysUser(userFlow);
			SrmExpert expert = this.expertBiz.readExpert(userFlow);
			model.addAttribute("user" , user);
			model.addAttribute("expert" , expert);
		}
		return "srm/expert/edit";
	}
	
//	@RequestMapping(value="/edit")
//	public String edit(@RequestParam(value="userFlow",required=true) String userFlow , Model model){
//		SrmExpert expert = this.expertBiz.readExpert(userFlow);//�����û���ˮ�Ų���ר��
//		model.addAttribute("expert" , expert);
//		return "srm/expert/edit";
//	}
//	/**
//	 * ͨ��ö����ʵ������ר�ҵļ����͵ȼ�����
//	 * @param expert
//	 * @return
//	 */
//	@RequestMapping(value="/saveExpert" , method=RequestMethod.POST)
//	@ResponseBody
//	public String saveExpert(SrmExpert expert){
//		//expert.setCreditName(DictTypeEnum.ExpertCredit.getDictNameById(expert.getCreditId()));//ͨ��ö�ٻ�ȡ�����ȼ�ID
//		//expert.setTechAreaName(DictTypeEnum.ExpertTechArea.getDictNameById(expert.getTechAreaId()));//ͨ��ö�ٻ�ȡ��������ID
//		this.expertBiz.saveExpert(expert);
//		return GlobalConstant.SAVE_SUCCESSED;
//	}
}
