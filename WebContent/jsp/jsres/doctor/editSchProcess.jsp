<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>江苏省住院医师规范化培训管理平台</title>
<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script type="text/javascript">
$(document).ready(function(){
	$('#beginDate , #endDate').datepicker();
});
</script>
</head>
<body>
<div class="div_search">
	<table border="0" cellpadding="0" cellspacing="0" class="base_info">
            <colgroup>
              <col width="18%"/>
              <col width="32%"/>
              <col width="18%"/>
              <col width="32%"/>
            </colgroup>
	           <tbody>
	           <tr>
	               <th>培训基地：</th>
	               <td>
	               		<select class="select" style="width: 156px;" >
						    <option value="">苏州市广济医院</option>
						    <option value="" selected>苏州市九龙医院</option>
					    </select>
					</td>
					<th>轮转科室：</th>
	               <td>
	               		<select class="select" style="width: 156px;" >
	               			<option value="">请选择</option>
						    <option value="">内科</option>
						    <option value="">儿科</option>
						    <option value="">消化内科</option>
						    <option value="">神经内科</option>
						    <option value="">心内科</option>
					    </select>
					</td>
	           </tr>
	           <tr>
	               <th>开始时间：</th>
	               <td>
	               	   <input type="text" readonly="readonly" id="beginDate" class="validate[required] input" style="width: 150px;margin-left: 0;"/>
				   </td>
				   <th>结束时间：</th>
	               <td>
	               	   <input type="text" readonly="readonly" id="endDate" class="validate[required] input" style="width: 150px;margin-left: 0;"/>
				   </td>
	           </tr>
	           <tr>
	               <th>带教老师：</th>
	               <td><input type="text" class="input" style="width: 150px;margin-left: 0;" class="validate[required]" value=""/></td>
	          	   <th>科主任：</th>
	               <td><input type="text" class="input" style="width: 150px;margin-left: 0;" class="validate[required]" value=""/></td>
	           </tr>
	           </tbody>
           </table>
          <div align="center" style="margin-top: 20px; margin-bottom:20px;">
			<input type="button" style="width:100px;" class="btn_blue"  value="保存"></input>
			<input type="button" style="width:100px;" class="btn_grey" onclick="javascript:jboxClose();" value="关闭"></input>
		 </div>
 </div>
</body>
</html>