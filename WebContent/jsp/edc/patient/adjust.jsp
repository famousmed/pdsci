<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
	function initPatient(){
		jboxOpen("<s:url value='/pub/patient/initProjPatient'/>","初始化机构样本", 600, 300);
	}
	function save(patientFlow,orgFlow){
		var url = "<s:url value='/pub/patient/saveAdjust'/>";
		jboxGet(url,data,function (){
			window.parent.frames['mainIframe'].window.location.reload();
			},null);
	}
</script>
</head>
<body>
	<script type="text/javascript">
		
	</script>
	<div style="width: 50%;float: left;overflow-y:auto;height: 100% "> 
		<table class="xllist">
			<tr>
				<th >样本号</th>
			</tr>
				<tr style="height: 20px">
				<td>
					<ul class="dbsx">
						<li>
							<c:forEach items="${patientList}" var="patient">
								<span ><a href="">${patient.patientCode}</a></span>
							</c:forEach>
						</li>
					</ul>
					</td>
				</tr>
		</table>
	</div>
	<div style="width: 5px;float: left">
	&#12288;
	</div>
	<div style="width: 45%;float: left">
		<table class="xllist">
			<tr><th>中心号</th><th>中心</th></tr>
			<c:forEach items="${pubProjOrgList }" var="projOrg"> 
				<c:if test="${param.orgFlow  != projOrg.orgFlow }"> 
					<tr>
						<td align="center" width="50px">${projOrg.centerNo }</td>
						<td align="center">${projOrg.orgName }</td>
					</tr>
				</c:if>
			</c:forEach>
		</table>
	</div>
</body>
</html>