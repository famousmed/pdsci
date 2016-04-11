package com.pinde.sci.ctrl.inx;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.inx.IinxColumnManageBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.model.mo.InxColumn;
@Controller
@RequestMapping("/inx/manage/column")
public class InxColumnManageController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(InxColumnManageController.class);
	@Autowired
	private IinxColumnManageBiz columnBiz;
	
	@RequestMapping(value="/add")
	public String showAdd(){
		return "inx/manage/editColumn";
	}
	/**
	 * ��ʾ�б�
	 * @return
	 */
	@RequestMapping(value="/list")
	public String showList(){
		return "inx/manage/tree";
	}
	
	/**
	 * �༭��Ŀ
	 * @return 
	 */
	@RequestMapping(value="/editJson")
	public @ResponseBody String editJson(InxColumn column){
		String result = "";
		if(column!=null&&checkInput(column)){
			if(StringUtil.isNotBlank(column.getColumnFlow())){
				result = this.columnBiz.update(column)+"";
			}else{
				result =  this.columnBiz.save(column);
			}
		}
		return result;
	}
	/**
	 * ���ǰ������
	 * @param column
	 * @return true��ͨ����false:��ͨ��
	 */
	private boolean checkInput(InxColumn column){
		if(StringUtil.isEmpty(column.getColumnName())||StringUtil.isBlank(column.getColumnName())){
			return false;
		}
		if(StringUtil.isEmpty(column.getParentColumnId())||StringUtil.isBlank(column.getParentColumnId())){
			return false;
		}
		if(column.getOrdinal()==null){
			return false;
		}
		return true;
	}
	/**
	 * ͣ��
	 * @return 
	 */
	@RequestMapping(value="/deleteJson")
	public @ResponseBody String deleteJson(@RequestBody List<String> ids){
		if(ids!=null&&!ids.isEmpty()){
			int delResult = this.columnBiz.updateRecordStatus(ids, GlobalConstant.RECORD_STATUS_N);
			if(delResult>0){
				return GlobalConstant.DELETE_SUCCESSED;
			
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}

	/**
	 * ��ȡ��Ŀ
	 * @param columnId
	 * @return
	 */
	@RequestMapping(value="/getColumnJson")
	public @ResponseBody InxColumn  getColumnJson(String columnId){
		if(StringUtil.isNotBlank(columnId)){
			InxColumn col = this.columnBiz.getById(columnId);
			return col;
		}
		return null;
	}
	
	/**
	 * ��ȡ������������Ŀ
	 * @return ָ����ʽ��json
	 */
	@RequestMapping(value="/getAllDataJson")
	public @ResponseBody String getAllDataJson(){
		List<InxColumn> colList = columnBiz.getAll(GlobalConstant.RECORD_STATUS_Y);//��ȡ������������Ŀ
		StringBuilder sb = new StringBuilder();
		sb.append("[");
		sb.append("{\"id\":\"0\", \"pId\":\"-1\", \"name\":\"������Ŀ\",\"open\":true,\"t\":\"������Ŀ\"},");
		for (InxColumn col : colList) {
			sb.append("{");
			sb.append("\"id\":").append("\"").append(col.getColumnId()).append("\"").append(",");
			sb.append("\"pId\":").append("\"").append(StringUtil.replaceNull(col.getParentColumnId(),"0")).append("\"").append(",");
			sb.append("\"name\":").append("\"").append(col.getColumnName()).append("\",");
			sb.append("\"t\":").append("\"")
			  .append("���룺").append(col.getColumnId()).append("<br>")
			  .append("����").append(col.getOrdinal()==null?"":col.getOrdinal().toString())
			  .append("\"");
			sb.append("},");
		}
		sb.deleteCharAt(sb.length()-1);
		sb.append("]");
		return sb.toString();
	}
	
}
