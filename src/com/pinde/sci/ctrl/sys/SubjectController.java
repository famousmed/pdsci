package com.pinde.sci.ctrl.sys;

import java.util.Arrays;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sys.ISubjectBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.model.mo.SysSubjCode;

@Controller
@RequestMapping("/sys/subject")
public class SubjectController extends GeneralController {
	@Autowired
	private ISubjectBiz subjectBiz;
	

	@RequestMapping(value="/tree",method=RequestMethod.GET)
	public String tree(String id){
		return "sys/subject/tree";
	}
	
	/**
	 * 获取所有已启用学科代码
	 * @return 指定格式的json
	 */
	@RequestMapping(value="/getAllDataJson")
	public @ResponseBody String getAllDataJson(){
		List<SysSubjCode> subjList = subjectBiz.getAll("Y");//获取所有已启用学科代码
		StringBuilder sb = new StringBuilder();
		sb.append("[");
		sb.append("{\"id\":0, \"pId\":-1, \"name\":\"学科代码\",\"open\":true,\"t\":\"根节点\"},");
		for (SysSubjCode sub : subjList) {
			sb.append("{");
			sb.append("\"id\":").append(sub.getSubjId()).append(",");
			sb.append("\"pId\":").append(StringUtil.replaceNull(sub.getParSubjId(),"0")).append(",");
			sb.append("\"name\":").append("\"").append(sub.getSubjName()).append("\",");
			sb.append("\"t\":").append("\"")
			  .append("学科代码：").append(sub.getSubjId()).append("&#10;")
			  .append("学科名称：").append(sub.getSubjName()).append("&#10;")
			  .append("排&#12288;&#12288;序：").append(sub.getOrdinal())
			  .append("\"");
			sb.append("},");
		}
		sb.deleteCharAt(sb.length()-1);
		sb.append("]");
		return sb.toString();
	}

	/**
	 * 新增学科代码
	 * @param subjName 学科名称
	 * @param subjId 学科代码
	 * @param parSubjId 父类学科代码
	 * @param ordinal 排序
	 * @return 0：失败，1：成功
	 */
	@RequestMapping(value="/addJson",method=RequestMethod.POST)
	public @ResponseBody int addJson(String subjName, String subjId,String parSubjId, Integer ordinal ){
		if(StringUtil.isNotBlank(subjName)&&StringUtil.isNotBlank(subjId)){
			/*校验学科代码id是否存在*/
			int checkResult = this.checkSubjId(subjId);
			if(checkResult == 1){
				return 0;
			}
			SysSubjCode subj = new SysSubjCode();
			subj.setSubjFlow(PkUtil.getUUID());
			subj.setSubjName(subjName);
			subj.setSubjId(subjId);
			if("0".equals(parSubjId)){
				parSubjId = null;
			}
			subj.setParSubjId(parSubjId);
			if(ordinal==null){
				ordinal = 0;
			}
			subj.setOrdinal(ordinal);
			subj.setCreateTime(DateUtil.getCurrDateTime());
			subj.setCreateUserFlow(GlobalContext.getCurrentUser().getUserFlow());
			subj.setRecordStatus("Y");//默认启用
			return this.subjectBiz.save(subj);
		}
		return 0;
	}
	/**
	 * 批量更新启用停用状态
	 * @param subjIdList id列表
	 * @return 0：失败，大于0：成功
	 */
	@RequestMapping(value="/deleteJson",method=RequestMethod.POST)
	public @ResponseBody int deleteJson( String listString){
		List<String> subjIdList = null;
		if(StringUtil.isNotBlank(listString)){
			String[] arr = listString.split(",");
			subjIdList =  Arrays.asList(arr);
		}
		if(subjIdList!=null&&subjIdList.size()>0){
			return this.subjectBiz.updateByIds(subjIdList);
		}
		return 0;
	}
	/**
	 * 更新学科代码
	 * @param subject
	 * @return 0：失败，1：成功
	 */
	@RequestMapping(value="/updateJson",method=RequestMethod.POST)
	public @ResponseBody int updateJson(SysSubjCode subject){
		int updateResult = 0;
		if(subject!=null&&StringUtil.isNotBlank(subject.getSubjId())&&StringUtil.isNotBlank(subject.getSubjName())&&subject.getOrdinal()!=null){
			SysSubjCode findSubj = this.subjectBiz.getByFlow(subject.getSubjFlow());
			if(findSubj!=null){
				/*校验学科代码id是否存在*/
				if(StringUtil.isNotEquals(subject.getSubjId(), findSubj.getSubjId())){
					int checkResult = this.checkSubjId(subject.getSubjId());
					if(checkResult == 1){
						return 0;
					}
				}
				String parentId = findSubj.getSubjId();
				findSubj.setSubjId(subject.getSubjId());
				findSubj.setSubjName(subject.getSubjName());
				findSubj.setOrdinal(subject.getOrdinal());
				findSubj.setModifyTime(DateUtil.getCurrDateTime());
				findSubj.setModifyUserFlow(GlobalContext.getCurrentUser().getUserFlow());
				updateResult = this.subjectBiz.update(findSubj);
				this.subjectBiz.updateParentId(subject.getSubjId(), parentId);
			}
		}
		return updateResult;
	}
	@RequestMapping(value="/getByIdJson",method=RequestMethod.POST)
	public @ResponseBody SysSubjCode getByIdJson(String id){
		if(StringUtil.isNotBlank(id)){
			return this.subjectBiz.getById(id);
		}
		return null;
	}
	/**
	 * 校验学科代码id是否存在
	 * @param subjId 学科代码id
	 * @return 0：不存在，1：存在
	 */
	@RequestMapping(value="/checkSubjIdJson",method=RequestMethod.POST)
	public @ResponseBody int checkSubjIdJson(String subjId){
		return checkSubjId(subjId); 
	}
	/**
	 * 校验学科代码id是否存在
	 * @param subjId 学科代码id
	 * @return 0：不存在，1：存在
	 */
	public int checkSubjId(String subjId){
		if(StringUtil.isNotBlank(subjId)){
			SysSubjCode subj = this.subjectBiz.getById(subjId);
			if(subj!=null){
				return 1;
			}
		}
		return 0; 
	}
}
