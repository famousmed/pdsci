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
</head>
<style>
.divPic{background-image: url('<s:url value='/css/skin/${skinPath}/images/gou.gif' />');background-repeat: no-repeat;background-position: center;}

.viewTd img {border: 0;position: relative;vertical-align: middle;}
</style>
<body>
	<script type="text/javascript">
		function searchPatient(){
			window.location.href="<s:url value='/edc/random/manage'/>?orgFlow="+$("#orgFlow").val();
		}
		function assignTrend(){
			if ($("#orgFlow").val()=="") {
				jboxTip("请选择机构!");
				return;
			}
			var mainIframe = window.parent.frames["mainIframe"];
			var width = mainIframe.document.body.scrollWidth;
			var height = mainIframe.document.body.scrollHeight;
			jboxOpen("<s:url value='/edc/random/assignTrend'/>?orgFlow="+$("#orgFlow").val(),"申请走势",width,height);
		}
		function showRandomInfo(patientFlow){
			jboxOpen("<s:url value='/edc/random/showRandomInfo'/>?patientFlow="+patientFlow,"随机信息",660,550);
		}
	</script>
	

<div class="mainright">
		<div class="content">
		<div class="title1 clearfix">
			&#12288;&#12288;机构：
			<select id="orgFlow" name="orgFlow" class="xlname" style="width:300px;" onchange="searchPatient(this.value);">
				<option value=""></option>
				<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList)}" var="projOrg">
					<option value="${projOrg.orgFlow}" <c:if test="${projOrg.orgFlow==param.orgFlow }">selected</c:if>>${projOrg.centerNo }&#12288;${applicationScope.sysOrgMap[projOrg.orgFlow].orgName}</option>
				</c:forEach>
			</select>&#12288;
			合计：${fn:length(patientList) }&#12288;&#12288;
			<img src="<s:url value='/css/skin/${skinPath}/images/trend.png'/>" title="走势图" style="cursor: pointer;" onclick="assignTrend();"/>
</div>	
		<table class="xllist">
			<tr>
				<th width="50px">序号</th>
				<th width="100px">受试者编号</th>
				<th width="100px">姓名</th>
				<c:if test="${isBlind }">
				<th width="50px">药物编码</th>
				</c:if>
				<th width="200px">预后因素</th>
				<th width="120px">入组时间</th>
				<th width="100px">入组医生</th>
				<th width="120px">揭盲时间</th>
				<th width="100px">揭盲医生</th>
			</tr>
			<c:forEach items="${ patientList}" var="patient">
			<tr style="cursor: pointer;"  ondblclick="showRandomInfo('${patient.patientFlow}');"
			<c:if test="${randomRecMap[patient.patientFlow].promptStatusId  == edcRandomPromptStatusEnumPrompted.id }">style="color: red"</c:if>
			>
				<td>${patient.patientSeq }</td>	
				<td>
					${patient.patientCode }
					<c:if test="${(!isBlind && !empty randomRecMap[patient.patientFlow].drugGroup) || randomMap[patient.patientFlow].promptStatusId  == edcRandomPromptStatusEnumPrompted.id }">(<font color="red">${randomRecMap[patient.patientFlow].drugGroup }</font>)</c:if>
				</td>	
				<td>${patient.patientName }</td>
				<c:if test="${isBlind }">	
				<td>${randomRecMap[patient.patientFlow].drugPack }</td>
				</c:if>	
				<td>${randomRecMap[patient.patientFlow].drugFactorName}</td>
				<td>${pdfn:transDateTime(patient.inDate) }</td>	
				<td>${patient.inDoctorName }</td>	
				<td>${pdfn:transDateTime(randomRecMap[patient.patientFlow].promptTime) }</td>	
				<td>${randomRecMap[patient.patientFlow].promptUserName }</td>	
			</tr>
			</c:forEach>
			<c:if test="${empty patientList }"> 
				<tr> 
					<td align="center" style="text-align: center;" colspan="10">无记录</td>
				</tr>
			</c:if>	
		</table></div></div>
</body>
</html>