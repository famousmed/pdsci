package com.pinde.sci.ctrl.res;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IPubWorkLogBiz;
import com.pinde.sci.biz.res.IResAssessCfgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.enums.pub.LogTypeEnum;
import com.pinde.sci.model.mo.PubWorkLog;
/**
 * 
 * @author tiger
 *
 */
@Controller
@RequestMapping("/res/log")
public class ResLogController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(ResLogController.class);
	
	@Resource
	private IPubWorkLogBiz workLogBiz;
	
	@RequestMapping(value="/list")
	public String list(String logTypeId){
		return "res/log/list";
	}
	
	/**
	 * 加载日志列表
	 * @param logTypeId
	 * @return
	 */
	@RequestMapping(value="/loadLog")
	public String loadLog(String logTypeId, Integer currentPage,HttpServletRequest request, Model model){
		if(LogTypeEnum.Day.getId().equals(logTypeId)){
			return "res/log/dayLogList";
		}else{
			PubWorkLog workLog = new PubWorkLog();
			workLog.setLogTypeId(logTypeId);
			PageHelper.startPage(currentPage, getPageSize(request));
			List<PubWorkLog> workLogList = workLogBiz.searchWorkLogList(workLog, null, null, null);
			model.addAttribute("workLogList", workLogList);
			return "res/log/weekLogList";
		}
	}
	
	/**
	 * 编辑日志
	 * @param logTypeId
	 * @return
	 */
	@RequestMapping(value="/edit")
	public String edit(String logFlow, Model model){
		if(StringUtil.isNotBlank(logFlow)){
			PubWorkLog workLog = workLogBiz.readWorkLog(logFlow);
			model.addAttribute("workLog", workLog);
		}
		return "res/log/edit";
	}
	
	/**
	 * 保存日志
	 * @param workLog
	 * @return
	 */
	@RequestMapping(value="/saveLog")
	@ResponseBody
	public String saveLog(PubWorkLog workLog){
		int result = workLogBiz.saveWorkLog(workLog);
		if(GlobalConstant.ZERO_LINE != result){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 获取日志JSON数据
	 * @param workLog
	 * @param startDate
	 * @param endDate
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/getWorkLogListJsonData")
	@ResponseBody
	public Object getWorkLogListJsonData(PubWorkLog workLog, String startDate, String endDate, Model model){
		List<PubWorkLog> workLogList = workLogBiz.searchWorkLogList(workLog, startDate, endDate, null);
		return workLogList;
	}
	
	
	/**
	 * 获取一条日志记录
	 * @param workLog
	 * @return
	 */
	@RequestMapping(value="/getLog")
	public String getLog(String logFlow, Model model){
		if(StringUtil.isNotBlank(logFlow)){
			PubWorkLog workLog = workLogBiz.readWorkLog(logFlow);
			model.addAttribute("workLog", workLog);
		}
		return "res/log/view";
	}
	
	/**
	 * 删除日志
	 * @param workLog
	 * @return
	 */
	@RequestMapping(value="/delLog")
	@ResponseBody
	public String delLog(String logFlow, Model model){
		if(StringUtil.isNotBlank(logFlow)){
			PubWorkLog workLog = new PubWorkLog();
			workLog.setLogFlow(logFlow);
			workLog.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			int result = workLogBiz.saveWorkLog(workLog);
			if(GlobalConstant.ZERO_LINE != result){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
}
