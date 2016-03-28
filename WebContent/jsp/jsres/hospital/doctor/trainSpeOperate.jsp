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
</script>
</head>
<body>
<div class="div_search">
	<table border="0" cellpadding="0" cellspacing="0" class="base_info">
            <colgroup>
              <col width="30%"/>
              <col width="70%"/>
            </colgroup>
	           <tbody>
	           <tr>
	               <th>原培训专业：</th>
	               <td>儿科</td>
	           </tr>
	           <tr>
	               <th>目标培训专业：</th>
	               <td>
	               		<select class="select" style="width: 156px;" >
	               			<option value="">请选择</option>
						    <option value="">儿科</option>
						    <option value="">心内科</option>
						    <option value="">神经内科</option>
						    <option value="">急诊科</option>
						    <option value="">皮肤科</option>
						    <option value="">精神科</option>
						    <option value="">康复医学科</option>
						    <option value="">外科</option>
					    </select>
					</td>
	           </tr>
	           </tbody>
           </table>
          <div align="center" style="margin-top: 20px; margin-bottom:20px;">
			<input type="button" style="width:100px;" class="btn_blue"  onclick="javascript:;" value="变更"></input>
			<input type="button" style="width:100px;" class="btn_grey" onclick="javascript:jboxClose();" value="关闭"></input>
		 </div>
 </div>
</body>
</html>