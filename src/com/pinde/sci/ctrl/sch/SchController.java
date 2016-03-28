package com.pinde.sci.ctrl.sch;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.MathUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sch.ISchArrangeBiz;
import com.pinde.sci.biz.sch.ISchDeptBiz;
import com.pinde.sci.biz.sch.ISchDoctorBiz;
import com.pinde.sci.biz.sch.ISchDoctorDeptBiz;
import com.pinde.sci.biz.sch.ISchRotationBiz;
import com.pinde.sci.biz.sch.ISchRotationDeptBiz;
import com.pinde.sci.biz.sch.ISchRotationGroupBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.sch.SchArrangeStatusEnum;
import com.pinde.sci.enums.sch.SchArrangeTypeEnum;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SchArrange;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/sch")
public class SchController extends GeneralController{   
	
	private static Logger logger = LoggerFactory.getLogger(SchController.class);
	
	@Resource
	private ISchDoctorBiz schDoctortBiz;
	@Resource
	private ISchRotationBiz schRotationtBiz;
	@Resource
	private ISchRotationDeptBiz schRotationtDeptBiz;
	@Resource
	private ISchRotationGroupBiz schRotationtGroupBiz;
	@Resource
	private ISchDeptBiz schDeptBiz;
	@Resource
	private ISchDoctorDeptBiz schDoctorDeptBiz;
	@Resource
	private ISchArrangeBiz arrangeBiz;
	
	@RequestMapping(value = {"/arrange" },method = RequestMethod.GET)
	public String doctorList (Model model) throws Exception{
		SchArrange processArrange = null;
		SysUser currUser = GlobalContext.getCurrentUser();
		List<SchArrange> arrangeList = arrangeBiz.searchSchArrange(currUser.getOrgFlow());
		for(int i = 0 ; i < arrangeList.size(); i++){
			SchArrange arrange = arrangeList.get(i);
			if(!SchArrangeTypeEnum.Auto.getId().equals(arrange.getArrangeTypeId())){
				arrangeList.remove(i);
				i--;
			}else{
				if(SchArrangeStatusEnum.Process.getId().equals(arrange.getArrangeStatusId())){
					arrangeList.remove(arrange);
					i--;
					processArrange = arrange;
				}
			}
		}
		model.addAttribute("processArrange",processArrange);
		model.addAttribute("arrangeList",arrangeList);
		
		List<ResDoctor> unSchDoctorList = arrangeBiz.searchUnSchDoctor(currUser.getOrgFlow());
		model.addAttribute("unSchDoctorCount",unSchDoctorList.size());
		
		Integer selDeptCount = 0;
		Integer unSelDepCount = 0;
		for(ResDoctor  doctor : unSchDoctorList){
			if(GlobalConstant.FLAG_Y.equals(doctor.getSelDeptFlag())){
				selDeptCount++;
			}else {
				unSelDepCount++;
			}
		}
		model.addAttribute("selDeptCount", selDeptCount);
		model.addAttribute("unSelDepCount", unSelDepCount);
		return "sch/arrange/rostering";
	}
	
	@RequestMapping(value = {"/rostering" },method = RequestMethod.GET)
	@ResponseBody
	public String rostering(String beginDate) throws Exception{
		arrangeBiz.rostering(beginDate);
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
//	@RequestMapping(value = {"/countIndex" },method = RequestMethod.GET)
//	@ResponseBody
//	public String countIndex(String arrangeFlow,Model model) throws Exception{
//		arrangeBiz.countIndex(arrangeFlow);
//		return GlobalConstant.OPRE_SUCCESSED;
//	}
//
//	@RequestMapping(value = {"/permProcess" },method = RequestMethod.GET)
//	@ResponseBody
//	public String permProcess(String arrangeFlow,Model model) throws Exception{
//		List<SchArrangeProcess> arrangeProcessList = arrangeBiz.process(arrangeFlow);
//		int maxTotal = 0;
//		int currTotal = 0;
//		for(SchArrangeProcess process : arrangeProcessList){
//			String max = StringUtil.defaultIfEmpty(process.getMaxPerm(),"0");
//			String curr = StringUtil.defaultIfEmpty(process.getCurrPerm(),"0");
//			maxTotal = maxTotal + Integer.parseInt(max);
//			currTotal = currTotal + Integer.parseInt(curr);
//		}
//		if(maxTotal==currTotal){
//			return "100%";
//		}else{
//			return MathUtil.scale2Double(((double)currTotal*100d/(double)maxTotal))+"%" ;
//		}
//	}
//
//	@RequestMapping(value = {"/countProcess" },method = RequestMethod.GET)
//	@ResponseBody
//	public String countProcess(String arrangeFlow,Model model) throws Exception{
//		List<SchArrangeProcess> arrangeProcessList = arrangeBiz.process(arrangeFlow);
//		int maxTotal = 0;
//		int currTotal = 0;
//		for(SchArrangeProcess process : arrangeProcessList){
//			String max = StringUtil.defaultIfEmpty(process.getMaxPerm(),"0");
//			String curr = StringUtil.defaultIfEmpty(process.getCurrCountPerm(),"0");
//			maxTotal = maxTotal + Integer.parseInt(max);
//			currTotal = currTotal + Integer.parseInt(curr);
//		}
//		if(maxTotal==currTotal){
//			return "100%";
//		}else{
//			return MathUtil.scale2Double(((double)currTotal*100d/(double)maxTotal))+"%" ;
//		}
//	}
//	
//	@RequestMapping(value = {"/schConfirm" },method = RequestMethod.GET)
//	@ResponseBody
//	public String schConfirm(String arrangeFlow,Model model) throws Exception{
//		arrangeBiz.schConfirm(arrangeFlow);
//		return GlobalConstant.OPRE_SUCCESSED;
//	}
//	
//	@RequestMapping(value = {"/doConfirm" },method = RequestMethod.GET)
//	@ResponseBody
//	public String doConfirm(SchArrange arrange,Model model) throws Exception{
//		arrange.setArrangeStatusId(SchArrangeStatusEnum.Confirm.getId());
//		arrange.setArrangeStatusName(SchArrangeStatusEnum.Confirm.getName());
//		GeneralMethod.setRecordInfo(arrange, false);
//		arrangeBiz.modifyArrange(arrange);
//		return GlobalConstant.OPRE_SUCCESSED;
//	}
}

