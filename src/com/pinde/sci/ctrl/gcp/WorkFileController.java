package com.pinde.sci.ctrl.gcp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.gcp.IWorkFileBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.pub.WorkpaperTypeEnum;
import com.pinde.sci.model.mo.PubDiary;
import com.pinde.sci.model.mo.PubRegulation;
import com.pinde.sci.model.mo.PubWorkpaper;
import com.pinde.sci.model.mo.SysDept;
/**
 * 
 * @author tiger
 *
 */
@Controller
@RequestMapping("gcp/workFile")
public class WorkFileController extends GeneralController{
	private static Logger logger = LoggerFactory.getLogger(WorkFileController.class);
	@Autowired
	private IWorkFileBiz workFileBiz;
	@Autowired
	private IDeptBiz deptBiz;
	/**
	 * 工作日志
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/diaryCalendar"},method={RequestMethod.GET})
	public String calendar(Model model){
		List<PubDiary> diaryList = workFileBiz.searchDiaryList();
		model.addAttribute("diaryList", diaryList);
		return "gcp/workFile/diary/calendar";
	}
	
	/**
	 * 编辑工作日志
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/editDiary"})
	public String editDiary(String diaryFlow,Model model){
		if(StringUtil.isNotBlank(diaryFlow)){
			PubDiary diary = workFileBiz.readDiary(diaryFlow);
			model.addAttribute("diary", diary);
		}
		return "gcp/workFile/diary/edit";
	}
	
	/**
	 * 保存工作日志
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/saveDiary"})
	@ResponseBody
	public String saveDiary(PubDiary diary){
		int result = workFileBiz.saveDiary(diary);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 删除工作日志
	 * @param diaryFlow
	 * @return
	 */
	@RequestMapping(value={"/delDiary"})
	@ResponseBody
	public String delDiary(String diaryFlow){
		if(StringUtil.isNotBlank(diaryFlow)){
			PubDiary diary = new PubDiary();
			diary.setDiaryFlow(diaryFlow);
			diary.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			int result = workFileBiz.saveDiary(diary);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	//*****************法规文件********************
	/*SOP	
	药品注册管理方法	
	认定复核标准	
	临床试验指导原则	
	复核认定标准*/
	
	/**
	 * 加载法规文件
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/regulationFiles"})
	public String regulationFiles(PubRegulation regulation, Model model){
		List<PubRegulation> regulationFileList = workFileBiz.searchRegulaionFileList(regulation);
		Map<String, List<PubRegulation>> regulationMap = new HashMap<String, List<PubRegulation>>();
		//根据regulationTypeId组织Map
 		for(PubRegulation reg : regulationFileList){
			String regulationTypeId = reg.getRegulationTypeId();
			if(StringUtil.isNotBlank(regulationTypeId)){
				List<PubRegulation> temp = regulationMap.get(reg.getRegulationTypeId());
				if(temp == null){
					temp = new ArrayList<PubRegulation>();
				}
				temp.add(reg);
				regulationMap.put(reg.getRegulationTypeId(), temp);
			}
		}
		model.addAttribute("regulationFileList", regulationFileList);
		model.addAttribute("regulationMap", regulationMap);
		return "gcp/workFile/regulations/list";
	}
	
	/**
	 * 跳转至新增法规文件
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/addRegulationFile"})
	public String addRegulationFile(Model model){
		return "gcp/workFile/regulations/file";
	}
	
	/**
	 * 保存法规文件
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/saveRegulationFile"})
	@ResponseBody
	public String saveRegulationFile(MultipartFile file, PubRegulation regulation){
		int result = workFileBiz.saveRegulationFile(file, regulation);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	
	/**
	 * 删除法规文件
	 * @param regulationFlow
	 * @param fileFlow
	 * @return
	 */
	@RequestMapping(value={"/delRegulationFile"})
	@ResponseBody
	public String delRegulationFile(String regulationFlow, String fileFlow){
		if(StringUtil.isNotBlank(regulationFlow) && StringUtil.isNotBlank(fileFlow)){
			int result = workFileBiz.delRegulationFile(regulationFlow, fileFlow);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	/**
	 * 排序码
	 * @param elementFlow
	 * @return
	 */
	@RequestMapping(value = {"/saveOrder" },method={RequestMethod.POST})
	@ResponseBody
	public String saveOrder(String[] regulationFlow){	
		if(regulationFlow.length > 0){
			int result = workFileBiz.saveOrder(regulationFlow);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	//----------专业组文件------------
	/**
	 * 科室列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/deptList")
	public String deptList(Model model){
		SysDept dept = new SysDept();
		dept.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		dept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysDept> deptList = this.deptBiz.searchDept(dept);
		model.addAttribute("deptList", deptList);
		return "gcp/workFile/regulations/deptList";
	}
	
	
	//*********************工作文件****************************
	/**
	 * 加载工作文件列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/workpaperList")
	public String workpaperList(PubWorkpaper workpaper, Model model){
		List<PubWorkpaper> workpaperList = workFileBiz.searchWorkpaperList(workpaper);
		model.addAttribute("workpaperList", workpaperList);
		return "gcp/workFile/workpaper/list";
	}
	/**
	 * 跳转至编辑工作文件
	 * @param recordFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/editWorkpaper")
	public String editWorkPaper(String recordFlow, String viewFlag, Model model){
		if(StringUtil.isNotBlank(recordFlow)){
			PubWorkpaper workpaper = workFileBiz.readWorkpaper(recordFlow);
			model.addAttribute("workpaper", workpaper);
			
			if(GlobalConstant.FLAG_Y.equals(viewFlag)){//滑动显示内容
				return "gcp/workFile/workpaper/view";
			}
		}
		return "gcp/workFile/workpaper/edit";
	}
	
	/**
	 * 保存工作文件
	 * @param workpaper
	 * @return
	 */
	@RequestMapping(value = "/saveWorkpaper")
	@ResponseBody
	public String saveWorkpaper(PubWorkpaper workpaper){
		String workpaperTypeId = workpaper.getWorkpaperTypeId();
		if(StringUtil.isNotBlank(workpaperTypeId)){
			workpaper.setWorkpaperTypeName(WorkpaperTypeEnum.getNameById(workpaperTypeId));
		}
		int result = workFileBiz.saveWorkpaper(workpaper);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 删除工作文件
	 * @param recordFlow
	 * @return
	 */
	@RequestMapping(value = "/delWorkpaper")
	@ResponseBody
	public String delWorkpaper(String recordFlow){
		if(StringUtil.isNotBlank(recordFlow)){
			PubWorkpaper workpaper = new PubWorkpaper();
			workpaper.setRecordFlow(recordFlow);
			workpaper.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			int result = workFileBiz.saveWorkpaper(workpaper);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
}
