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
		function crf(patientFlow){
			<c:if test="${ projParam.projLock ==  GlobalConstant.FLAG_Y}">
			jboxTip("当前项目已锁定!");
			return;
			</c:if>
			
			if($("#inputModel").attr("checked")=="checked"){
				jboxOpen("<s:url value='/edc/query/crf'/>?patientFlow="+patientFlow, "疑问澄清", 1000, 600);
			}else {
				window.location.href="<s:url value='/edc/query/crf'/>?patientFlow="+patientFlow;
			}
		}
	</script>
		<table class="xllist">
			<tr>
				<th width="50px">序号</th>
				<th width="100px">受试者编码</th>
				<th width="150px">已发疑问数</th>
				<th width="150px">已解决疑问数</th>
				<th width="150px">待解决疑问数</th>
			</tr>
			<c:forEach items="${patientList}" var="patient">
				<c:set var="solvedMap" value="${patientQueryCountMap[patient.patientFlow][edcQuerySolveStatusEnumSolved.id]}"/>
				<c:set var="unSolvedMap" value="${patientQueryCountMap[patient.patientFlow][edcQuerySolveStatusEnumUnSolve.id]}"/>
				<tr style="height: 20px">
					<td>${patient.patientSeq}</td>
					<td>${patient.patientCode}</td>
					<td>${summaryMap[patient.patientFlow] }</td>
					<td>Sdv:&#12288;${!empty solvedMap[edcQuerySendWayEnumSdv.id]?solvedMap[edcQuerySendWayEnumSdv.id]:0}&#12288;
						Manual:&#12288;${!empty solvedMap[edcQuerySendWayEnumManual.id]?solvedMap[edcQuerySendWayEnumManual.id]:0}&#12288;
						Logic:&#12288;${!empty solvedMap[edcQuerySendWayEnumLogic.id]?solvedMap[edcQuerySendWayEnumLogic.id]:0}&#12288;</td>
					<td>
					<a href="javascript:crf('${patient.patientFlow }');">
					Sdv:&#12288;<font color='red'>${!empty unSolvedMap[edcQuerySendWayEnumSdv.id]?unSolvedMap[edcQuerySendWayEnumSdv.id]:0}</font>&#12288;
						Manual:&#12288;<font color='red'>${!empty unSolvedMap[edcQuerySendWayEnumManual.id]?unSolvedMap[edcQuerySendWayEnumManual.id]:0}</font>&#12288;
						Logic:&#12288;<font color='red'>${!empty unSolvedMap[edcQuerySendWayEnumLogic.id]?unSolvedMap[edcQuerySendWayEnumLogic.id]:0}</font>&#12288;
						</a>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${patientList == null || patientList.size()==0 }"> 
				<tr> 
					<td align="center" colspan="5">无记录</td>
				</tr>
			</c:if>
		</table>
</body>
</html>