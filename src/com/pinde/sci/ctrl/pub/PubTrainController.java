package com.pinde.sci.ctrl.pub;

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

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IPubTrainSummaryBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.enums.pub.TrainSummaryTypeEnum;
import com.pinde.sci.model.mo.PubTrainSummary;

@Controller
@RequestMapping("/pub/train")
public class PubTrainController extends GeneralController{
	private static Logger logger = LoggerFactory.getLogger(PubTrainController.class);
	@Autowired
	private IPubTrainSummaryBiz summaryBiz;
	
	/**
	 * ������ѵ�ƻ����ܽ�
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/summaryList"},method={RequestMethod.GET})
	public String summaryList(Model model){
		List<PubTrainSummary> summaryList = summaryBiz.searchSummaryList();
		String year = DateUtil.getYear();
		Map<String,Integer> countMap = this.summaryBiz.countTrain(year);
		model.addAttribute("summaryList", summaryList);
		model.addAttribute("countMap", countMap);
		model.addAttribute("year", year);
		return "gcp/train/list";
	}
	
	/**
	 * �༭��ѵ�ƻ����ܽ�
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/editTrainSummary"})
	public String editTrainSummary(String recordFlow, String viewFlag, Model model){
		if(StringUtil.isNotBlank(recordFlow)){
			PubTrainSummary summary = summaryBiz.readSummary(recordFlow);
			model.addAttribute("summary", summary);
			
			if(GlobalConstant.FLAG_Y.equals(viewFlag)){//������ʾ����
				return "gcp/train/view";
			}
		}
		return "gcp/train/edit";
	}
	
	/**
	 * ������ѵ�ƻ����ܽ�
	 * @param summary
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/saveTrainSummary"})
	@ResponseBody
	public String saveTrainSummary(PubTrainSummary summary, Model model){
		summary.setSummaryTypeName(TrainSummaryTypeEnum.getNameById(summary.getSummaryTypeId()));
		int result = summaryBiz.save(summary);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}else{
			return GlobalConstant.SAVE_FAIL;
		}
	}
	
	/**
	 * ɾ����ѵ�ƻ����ܽ�
	 * @param summary
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/delTrainSummary"})
	@ResponseBody
	public String delTrainSummary(String recordFlow, Model model){
		if(StringUtil.isNotBlank(recordFlow)){
			PubTrainSummary summary = new PubTrainSummary();
			summary.setRecordFlow(recordFlow);
			summary.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			int result = summaryBiz.save(summary);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
}
