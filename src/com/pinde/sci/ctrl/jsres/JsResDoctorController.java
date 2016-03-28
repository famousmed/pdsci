package com.pinde.sci.ctrl.jsres;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.JaxbUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.jsres.IJsResDoctorBiz;
import com.pinde.sci.biz.jsres.IJsResDoctorRecruitBiz;
import com.pinde.sci.biz.jsres.IResOrgSpeBiz;
import com.pinde.sci.biz.pub.IPubUserResumeBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.jsres.JsResDoctorAuditStatusEnum;
import com.pinde.sci.enums.res.TrainCategoryEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.form.jsres.JsResDoctorInfoForm;
import com.pinde.sci.form.jsres.UserResumeExtInfoForm;
import com.pinde.sci.model.mo.PubUserResume;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.ResOrgSpe;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/jsres/doctor")
public class JsResDoctorController extends GeneralController {
	@Autowired
	private IJsResDoctorBiz jsResDoctorBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IResDoctorBiz resDoctorBiz;
	@Autowired
	private IPubUserResumeBiz userResumeBiz;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IResOrgSpeBiz resBaseSpeBiz;
	@Autowired
	private IJsResDoctorRecruitBiz jsResDoctorRecruitBiz;
	
	/**
	 * סԺҽʦ������
	 */
	@RequestMapping(value="/doctor")
	public String index(Model model){
		return "jsres/doctor/index";
	}
	
	/**
	 * ��ѵ��Ϣ
	 */
	@RequestMapping(value="/main")
	public String main(Model model){
		//��ȡ��ѵ��¼
		SysUser currUser = GlobalContext.getCurrentUser();
		ResDoctorRecruit recruit = new ResDoctorRecruit();
		recruit.setDoctorFlow(currUser.getUserFlow());
		List<ResDoctorRecruit> recruitList = jsResDoctorRecruitBiz.searchResDoctorRecruitList(recruit);
		model.addAttribute("recruitList", recruitList);
		return "jsres/doctor/main";
	}
	
	/**
	 * ���˻�����Ϣ
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/doctorInfo")
	public String doctorInfo(String userFlow, String viewFlag, Model model){
		SysUser sysUser = userBiz.readSysUser(userFlow);
		ResDoctor resDoctor = resDoctorBiz.readDoctor(userFlow);
		model.addAttribute("user", sysUser);
		model.addAttribute("doctor", resDoctor);
		PubUserResume pubUserResume = userResumeBiz.readPubUserResume(userFlow);
		if(pubUserResume != null){
			String xmlContent =  pubUserResume.getUserResume();
			if(StringUtil.isNotBlank(xmlContent)){
				//xmlת����JavaBean
				UserResumeExtInfoForm  userResumeExt = JaxbUtil.converyToJavaBean(xmlContent, UserResumeExtInfoForm.class);
				model.addAttribute("userResumeExt", userResumeExt);
			}
		}
		if(GlobalConstant.FLAG_Y.equals(viewFlag)){
			return "jsres/doctor/doctorInfo";
		}
		return "jsres/doctor/editDoctorInfo";
	}
	
	/**
	 * ������˻�����Ϣ
	 * @param doctorInfoForm
	 * @return
	 */
	@RequestMapping(value="/saveDoctorInfo")
	@ResponseBody
	public String saveDoctorInfo(JsResDoctorInfoForm doctorInfoForm){
		int result = jsResDoctorBiz.saveDoctorInfo(doctorInfoForm);
		if(GlobalConstant.ZERO_LINE != result){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * ��ת���ϴ�ɨ���
	 * @return
	 */
	@RequestMapping("/uploadFile")
	public String uploadFile(){
		return "jsres/doctor/uploadFile";
	}
	
	/**
	 * �༭��ѵ��Ϣ
	 * @return
	 */
	@RequestMapping("/editTrainInfo")
	public String editTrainInfo(String recruitFlow, String openType, Model model){
		//����
		SysOrg search = new SysOrg();
		List<SysOrg> orgList = orgBiz.searchOrg(search);
		model.addAttribute("orgList", orgList);
		if(StringUtil.isNotBlank(recruitFlow)){
			ResDoctorRecruit doctorRecruit = jsResDoctorRecruitBiz.readResDoctorRecruit(recruitFlow);
			model.addAttribute("doctorRecruit", doctorRecruit);
		}
		if(StringUtil.isNotBlank(openType)){
			return "jsres/doctor/editTrainInfo";
		}
		return "jsres/doctor/trainInfo";
	}
	
	/**
	 * ��ѯ����רҵ
	 * @return
	 */
	@RequestMapping(value="/searchResBaseSpeList",method={RequestMethod.POST})
	@ResponseBody
	public List<ResOrgSpe> searchResBaseSpeList(ResOrgSpe resOrgSpe, Model model){
		resOrgSpe.setRecordStatus(GlobalConstant.FLAG_Y);
		List<ResOrgSpe> speList = resBaseSpeBiz.searchResOrgSpeList(resOrgSpe,null);
		
		return speList;
	}
	
	/**
	 * ���桢�ύ��ѵ��Ϣ
	 * @param recruitWithBLOBs
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/saveResDoctorRecruit",method={RequestMethod.POST})
	@ResponseBody
	public String saveResDoctorRecruit(ResDoctorRecruitWithBLOBs recruitWithBLOBs, String auditFlag, Model model){
		if(StringUtil.isNotBlank(recruitWithBLOBs.getDoctorStatusId())){
			recruitWithBLOBs.setDoctorStatusName(DictTypeEnum.DoctorStatus.getDictNameById(recruitWithBLOBs.getDoctorStatusId()));
		}else{
			recruitWithBLOBs.setDoctorStatusName("");
		}
		if(StringUtil.isNotBlank(recruitWithBLOBs.getDoctorStrikeId())){
			recruitWithBLOBs.setDoctorStrikeName(DictTypeEnum.DoctorStrike.getDictNameById(recruitWithBLOBs.getDoctorStrikeId()));
		}else{
			recruitWithBLOBs.setDoctorStrikeName("");
		}
		if(GlobalConstant.FLAG_Y.equals(auditFlag)){//�ύ������ˣ�
			recruitWithBLOBs.setAuditStatusId(JsResDoctorAuditStatusEnum.Auditing.getId());
			recruitWithBLOBs.setAuditStatusName(JsResDoctorAuditStatusEnum.Auditing.getName());
			int result = jsResDoctorRecruitBiz.saveDoctorRecruit(recruitWithBLOBs);
			if(GlobalConstant.ZERO_LINE != result){
				return GlobalConstant.OPRE_SUCCESSED;
			}
			return GlobalConstant.OPRE_FAIL;
		}else{//����(δ�ύ)
			recruitWithBLOBs.setAuditStatusId(JsResDoctorAuditStatusEnum.NotSubmit.getId());
			recruitWithBLOBs.setAuditStatusName(JsResDoctorAuditStatusEnum.NotSubmit.getName());
			int result = jsResDoctorRecruitBiz.saveDoctorRecruit(recruitWithBLOBs);
			if(GlobalConstant.ZERO_LINE != result){
				return GlobalConstant.SAVE_SUCCESSED;
			}
			return GlobalConstant.SAVE_FAIL;
		}
	}
	
}
