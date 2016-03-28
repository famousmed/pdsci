package com.pinde.sci.ctrl.srm;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.pinde.sci.biz.srm.ISrmAchProcessBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.model.mo.SrmAchProcess;

/**
 * 成果记录controller
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/srm/achProcess")
public class AchProcessController extends GeneralController{

	@Autowired
	private ISrmAchProcessBiz srmAchProcessBiz;
	
	/**
	 * 审核记录查看
	 * @return
	 */
	@RequestMapping("/auditProcess")
	public String auditProcess(String flow , Model model){
		SrmAchProcess achProcess = new SrmAchProcess();
		achProcess.setAchFlow(flow);
		achProcess.setRecordStatus(GlobalConstant.FLAG_Y);
		List<SrmAchProcess> achProcessList = this.srmAchProcessBiz.searchAchProcess(achProcess);
		model.addAttribute("achProcessList" , achProcessList);
		return "srm/ach/thesis/auditProcess";
	}
}
