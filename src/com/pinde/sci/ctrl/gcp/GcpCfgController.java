package com.pinde.sci.ctrl.gcp;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.gcp.IGcpCfgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.enums.gcp.GcpProjStageEnum;
import com.pinde.sci.form.gcp.GcpCfgFileForm;
import com.pinde.sci.model.mo.GcpCfg;
/**
 * 
 * @author tiger
 *
 */
@Controller
@RequestMapping("/gcp/cfg")
public class GcpCfgController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(GcpCfgController.class);
	
	@Autowired
	private IGcpCfgBiz gcpCfgBiz;
	//------------------归档文件------------------------
	/**
	 * 加载归档文件清单
	 * @param fileForm
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/finishFileList" },method={RequestMethod.GET,RequestMethod.POST})
	public String finishFileList(GcpCfgFileForm fileForm, Model model) throws Exception{
		if(StringUtil.isBlank(fileForm.getStage())){//默认查询准备阶段
			fileForm.setStage(GcpProjStageEnum.Apply.getId());
		}
		List<GcpCfgFileForm> fileList = this.gcpCfgBiz.searchFinishFileTemplateList(fileForm);
		model.addAttribute("fileList", fileList);
		return "gcp/cfg/finishFile/list";
	}

	
	
	/**
	 * 跳转到新增、修改归档文件页面
	 * @param id
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editFinishFile",method={RequestMethod.GET})
	public String editFinishFile(String id, Model model) throws Exception{
		if(StringUtil.isNotBlank(id)){
			GcpCfgFileForm file = gcpCfgBiz.getFinishFileTemplateById(id);
			model.addAttribute("file", file);
		}
	     return "gcp/cfg/finishFile/edit";
	} 
	
	/**
	 * 保存归档文件
	 * @param fileForm
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveFinishFile")
	@ResponseBody
	public String saveFinishFile(GcpCfgFileForm fileForm) throws Exception{
		int result =  gcpCfgBiz.saveFinishFileTemplate(fileForm);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	
	/**
	 * 删除一条文件
	 * @param id
	 * @param fileType 文件类型
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/delFileById")
	@ResponseBody
	public String delFileById(String id, String fileType) throws Exception{
		if(StringUtil.isNotBlank(id)){
			int result =  gcpCfgBiz.delFileTemplateById(id, fileType);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}

	//------------------送审文件------------------------
	
	/**
	 * 跳转到新增、修改送审文件页面
	 * @param id
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editApplyFile",method={RequestMethod.GET})
	public String editApplyFile(String id, Model model) throws Exception{
		if(StringUtil.isNotBlank(id)){
			GcpCfgFileForm file = gcpCfgBiz.getApplyFileTemplateById(id);
			model.addAttribute("file", file);
		}
	     return "gcp/cfg/applyFile/edit";
	} 
	
	/**
	 * 保存送审文件
	 * @param fileForm
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveApplyFile")
	@ResponseBody
	public String saveApplyFile(GcpCfgFileForm fileForm) throws Exception{
		int result =  gcpCfgBiz.saveApplyFileTemplate(fileForm);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	
	/**
	 * 加载送审文件列表
	 * @param fileForm
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/applyFileList" },method={RequestMethod.GET,RequestMethod.POST})
	public String applyFileList(Model model) throws Exception{
		List<GcpCfgFileForm> fileList = this.gcpCfgBiz.searchAppLyFileTemplateList();
		model.addAttribute("fileList", fileList);
		return "gcp/cfg/applyFile/list";
	}
	
	/**
	 * 配置质控管理提醒
	 */
	@RequestMapping(value = {"/qcRemindConfig" },method={RequestMethod.GET,RequestMethod.POST})
	public String qcRemindConfig(Model model){
		GcpCfg cfg = gcpCfgBiz.readGcpCfg(GlobalConstant.GCP_QC_REMIND);
		if(cfg == null){
			cfg = new GcpCfg();
			if(gcpCfgBiz.saveQcRemindConfig(cfg) == GlobalConstant.ZERO_LINE){
				return null;
			}
		}else{
			if(StringUtil.isNotBlank(cfg.getCfgBigValue())){
				Map<String,List<String>> qcConfigMap = gcpCfgBiz.createQcConfigMap(cfg.getCfgBigValue());
				model.addAttribute("qcConfigMap",qcConfigMap);
			}
		}
		return "gcp/cfg/qcConfig/qcRemindConfig";
	}
	
	/**
	 * 保存提醒配置
	 */
	@RequestMapping(value="/saveQcRemindConfig")
	@ResponseBody
	public String saveQcRemindConfig(HttpServletRequest request){
		Map<String,String[]> configMap = request.getParameterMap();
		if(configMap != null){
			String configInfo = gcpCfgBiz.createQcConfigXml(configMap);
			GcpCfg cfg = new GcpCfg();
			cfg.setCfgCode(GlobalConstant.GCP_QC_REMIND);
			cfg.setCfgBigValue(configInfo);
			if(gcpCfgBiz.saveQcRemindConfig(cfg)!=GlobalConstant.ZERO_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
}
