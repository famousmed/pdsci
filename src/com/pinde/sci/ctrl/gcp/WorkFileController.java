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
	 * ������־
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
	 * �༭������־
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
	 * ���湤����־
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
	 * ɾ��������־
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
	
	//*****************�����ļ�********************
	/*SOP	
	ҩƷע�������	
	�϶����˱�׼	
	�ٴ�����ָ��ԭ��	
	�����϶���׼*/
	
	/**
	 * ���ط����ļ�
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/regulationFiles"})
	public String regulationFiles(PubRegulation regulation, Model model){
		List<PubRegulation> regulationFileList = workFileBiz.searchRegulaionFileList(regulation);
		Map<String, List<PubRegulation>> regulationMap = new HashMap<String, List<PubRegulation>>();
		//����regulationTypeId��֯Map
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
	 * ��ת�����������ļ�
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/addRegulationFile"})
	public String addRegulationFile(Model model){
		return "gcp/workFile/regulations/file";
	}
	
	/**
	 * ���淨���ļ�
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
	 * ɾ�������ļ�
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
	 * ������
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
	
	//----------רҵ���ļ�------------
	/**
	 * �����б�
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
	
	
	//*********************�����ļ�****************************
	/**
	 * ���ع����ļ��б�
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
	 * ��ת���༭�����ļ�
	 * @param recordFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/editWorkpaper")
	public String editWorkPaper(String recordFlow, String viewFlag, Model model){
		if(StringUtil.isNotBlank(recordFlow)){
			PubWorkpaper workpaper = workFileBiz.readWorkpaper(recordFlow);
			model.addAttribute("workpaper", workpaper);
			
			if(GlobalConstant.FLAG_Y.equals(viewFlag)){//������ʾ����
				return "gcp/workFile/workpaper/view";
			}
		}
		return "gcp/workFile/workpaper/edit";
	}
	
	/**
	 * ���湤���ļ�
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
	 * ɾ�������ļ�
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
