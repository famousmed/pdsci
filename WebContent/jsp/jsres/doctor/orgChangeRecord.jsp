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
function doClose(){
	if ("messager"=="${param.open}") {
		jboxCloseMessager();
	} else {
		jboxClose();
	}
}
</script>
</head>
<body>
<div class="div_search">
	<table border="0" cellpadding="0" cellspacing="0" class="grid">
            <colgroup>
              <col width="25%"/>
              <col width="15%"/>
              <col width="25%"/>
              <col width="15%"/>
              <col width="20%"/>
            </colgroup>
            <thead>
	           <tr>
	              <th>转出培训基地</th>
	              <th>转出时间</th>
	              <th>转入培训基地</th>
	              <th>转入时间</th>
	              <th>状态</th>
	           </tr>
	       </thead>
	           <tbody>
	           <tr>
	               <td>苏州市广济医院</td>
	               <td>2013-06-18</td>
	               <td>苏州市九龙医院</td>
	               <td>2013-10-22</td>
	               <td>完成</td>
	           </tr>
	           <tr>
	               <td>苏州市九龙医院</td>
	               <td></td>
	               <td>苏州大学附属第二医院</td>
	               <td></td>
	               <td>已提交申请</td>
	           </tr>
	           </tbody>
           </table>
          <div align="center" style="margin-top: 20px; margin-bottom:20px;">
          	<c:if test="${'messager'!=param.open}">
			<input type="button" style="width:100px;" class="btn_grey" onclick="javascript:doClose();" value="关闭"></input>
			</c:if>
		 </div>
 </div>
</body>
</html>