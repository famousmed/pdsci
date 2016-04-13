<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>临床科研信息化管理系统</title>
<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
function editFormHidden(isHidden){
	if(isHidden){
		$("#editForm").hide();
		$("#down").show();
		$("#up").hide();
	}else{
		$("#editForm").show();
		$("#up").show();
		$("#down").hide();
	}
	
}
function idToggle(){
	$("#show").show();
	$("#hide").hide();
	$("#idshow").hide();
}
</script>
</head>
<body style="width:100%; min-width: inherit; height:100%;background-image:none; background:#fff;">
	<div class="infoAudit">
		<table border="0" width="945" cellspacing="0" cellpadding="0" style="margin-top: 0px;">
			<caption>受试者信息</caption>
			
			<tr>
				<th width="15%">姓名：</th>
				<td width="25%">${patient.patientName}</td>
				<th width="15%">性别：</th>
				<td width="25%">${patient.sexName }</td>
			</tr>
			<tr>
				<th width="15%">证件号：</th>
				<td width="25%"><span id="hide">${pdfn:encryptIdNo(patient.patientCode,4)}</span>
				<span id="show" style="display: none">${patient.patientCode}</span>
				&#12288;<a href="javascript:idToggle();" id="idshow">显示</a></td>
				<th>生日：</th>
				<td >${patient.patientBirthday}</td>
			</tr>
			<tr>
				<th>来源：</th>
				<td >${patient.patientSourceName}</td>
				<th>病例/住院号：</th>
				<td colspan="3">${patient.patientNo}</td>
			</tr>
			<tr>
				<th>手机：</th>
				<td >${patient.patientPhone }</td>
				<!-- 
				<th>电子邮箱：</th>
				<td ></td>
				 -->
				
			</tr>
			<tr>
				<th>备注：</th>
				<td colspan="3">${patient.patientStageNote }</td>
			</tr>
		</table>
		 <div>
		     <p class="caption">已参加临床试验记录
		     <span class="fr">
		    <!-- 
		     <a title="收缩" id="up" onclick=""><img src="<s:url value='/jsp/hbres/images/up.png'/>"/></a>
		     <a title="展开" id="down" onclick="" style="display: none"><img src="<s:url value='/jsp/hbres/images/down.png'/>"/></a>
		     -->
             </span>
             </p>
		     <table id='history' class="grid">
		         <thead>
		             <tr>
		                 <th style="text-align:center;">项目名称</th>
		                 <th style="text-align:center;">项目类型</th>
		                 <th style="text-align:center;">适应症</th>
		                 <th style="text-align:center;">入组时间</th>
		                 <th style="text-align:center;">状态</th>
		                 <th style="text-align:center;">备注</th>
		             </tr>
		         </thead>
		         
		             <c:forEach items="${patientList}" var="patient">
		             	<c:if test="${patient.projFlow != edcCurrProj.projFlow }">
		                 <tr>
		                     <td style="text-align:center;">${projMap[patient.projFlow].projShortName}</td>
		                     <td style="text-align:center;">${projMap[patient.projFlow].projSubTypeName}</td>
		                     <td style="text-align:center;"></td>
		                     <td style="text-align:center;">${pdfn:transDate (patient.inDate)}</td>
		                     <td style="text-align:center;">${patient.patientStageName}</td>
		                     <td style="text-align:center;"></td>
		                 </tr>
		                 </c:if>
		             </c:forEach>
		     </table>
		 </div>
		 
		<div align="center" style="margin-top: 20px; margin-bottom:20px;">
			<a class="btn_grey" id="closeBtn" href="javascript:jboxClose();">&nbsp;关&nbsp;闭&nbsp;</a>
		</div>
	</div>
</body>
</html>