<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>江苏省住院医师规范化培训管理平台</title>
<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
function addCommuHospital(){
	jboxOpen("<s:url value='/jsp/jsres/hospital/hos/editCommuHospital.jsp'/>","添加社区培训基地",1050,550);
}

function commuHospitalInfo(){
	jboxOpen("<s:url value='/jsp/jsres/province/hospital/commuHospitalInfo.jsp'/>?type=open","添加社区培训基地",1050,550);
}

</script>
</head>
<body>
		<div class="div_table">
		  <table border="0" cellpadding="0" cellspacing="0" class="grid">
		    <colgroup>
		      <col width="25%"/>
		      <col width="20%"/>
		      <col width="20%"/>
		      <col width="15%"/>
		      <col width="10%"/>
		      <col width="10%"/>
		    </colgroup>
		    <tbody>
		      <tr>
		        <th>社区名称</th>
		        <th>签订培养协议时间</th>
		        <th>社区类型</th>
		        <th>详情</th>
		        <th>修改</th>
		        <th>删除</th>
		      </tr>
		      <tr>
		        <td>鼓楼区社区医院</td>
		        <td>2015-05-12</td>
		        <td>社区服务中心</td>
		        <td><a class="btn" onclick="commuHospitalInfo();">详情</a></td>
		        <td><a class="btn" onclick="addCommuHospital();">修改</a></td>
		        <td><a class="btn">删除</a></td>
		      </tr>
		    </tbody>
		  </table>
		</div>
		<div class="page" style="padding-right:40px;">
		   <span>
		   <!-- 前一页 -->
		   <strong class="page_num">/</strong>
		   <!-- 后一页 -->
		   <input type="text" class="input" style="width:50px;"/>
		   <a class="btn">跳转</a>
		   </span>
		</div>
	<div class="btn_info">
		<input class="btn_blue" style="width:100px;" onclick="addCommuHospital();" type="button" value="添加"/>
	</div>
</body>
</html>