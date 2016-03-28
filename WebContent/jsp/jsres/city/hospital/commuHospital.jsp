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
function commuHospitalInfo(){
	var url = "<s:url value='/jsp/jsres/province/hospital/commuHospitalInfo.jsp'/>";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='450px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,"社区培训基地详情", 1000,450);
}
</script>
</head>
<body>
	<div class="infoAudit">
          <div class="div_table">
           <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <colgroup>
              <col width="27%"/>
              <col width="27%"/>
              <col width="27%"/>
              <col width="19%"/>
            </colgroup>
	           <thead>
	           <tr>
	              <th>社区名称</th>
	              <th>签订培养协议时间</th>
	              <th>社区类型</th>
	              <th>详情</th>
	           </tr>
	           </thead>
	           <tbody>
	           <tr>
	               <td>鼓楼区社区医院</td>
	               <td>2015-05-12</td>
	               <td>社区服务中心</td>
	               <td><a class="btn" onclick="commuHospitalInfo();">详情</a></td>
	           </tr>
	           <tr>
	               <td>玄武区社区医院</td>
	               <td>2015-07-20</td>
	               <td>社区服务中心</td>
	               <td><a class="btn" onclick="commuHospitalInfo();">详情</a></td>
	           </tr>
	           </tbody>
           </table>
          </div>
          <div class="btn_info">
          	<c:if test="${'audit'==param.type }">
				<input type="button" style="width:100px;" class="btn_blue" onclick="" value="通过"></input>
				<input type="button" style="width:100px;" class="btn_red" onclick="" value="不通过"></input>
			</c:if>
			<input type="button" style="width:100px;" class="btn_grey" onclick="javascript:jboxClose();" value="关闭"></input>
		  </div>
    </div>
</body>
</html>