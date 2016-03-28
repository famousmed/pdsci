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
$(function(){
	$('#graduateDate').datepicker();
});
</script>
</head>
<body>
<div class="div_search">
		<table border="0" cellpadding="0" cellspacing="0" class="base_info">
            <colgroup>
              <col width="40%"/>
              <col width="60%"/>
            </colgroup>
            <thead>
            </thead>
	           <tbody>
	           <tr>
	               <th>姓&#12288;&#12288;名：</th>
	               <td>林燕</td>
	           </tr>
	           <tr>
	               <th>身份证号：</th>
	               <td>320586199006285426</td>
	           </tr>
	           <tr>
	               <th>结业证书编号：</th>
	               <td><input type="text" class="input" value="" /></td>
	           </tr>
	           </tbody>
           </table>
          <div class="btn_info">
			<input type="button" style="width:100px;" class="btn_blue"  onclick="" value="结业"></input>
			<input type="button" style="width:100px;" class="btn_grey" onclick="javascript:jboxClose();" value="关闭"></input>
		 </div>
 </div>
</body>
</html>