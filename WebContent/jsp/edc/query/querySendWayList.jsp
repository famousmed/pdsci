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
function callOutQueryEvent(queryFlow,queryTypeName,sendWayId){
	window.parent.frames['mainIframe'].window.showCallOut(queryFlow,queryTypeName,sendWayId,true);
}
function showAllSdvCallOut(){
	if($("#all").attr("checked")=="checked"){
		<c:forEach items="${queryList}" var="query"> 
			window.parent.frames['mainIframe'].window.showCallOut('${query.queryFlow}','${query.queryTypeName}','${query.sendWayId}',false);
		</c:forEach> 
	}else {
		window.parent.frames['mainIframe'].window.hideJCallOut();
		window.parent.frames['mainIframe'].window.hideSelect();
	}
}
</script>

</head>
<body>
		<p style="margin-bottom: 10px">发送方式：${ param.sendWayId }  &#12288;&#12288;&#12288;&#12288;&#12288;&#12288;
		<!-- 
		<c:if test="${param.sendWayId == edcQuerySendWayEnumSdv.id }"> 
		<input type="checkbox" id="all" onchange="showAllSdvCallOut();"/><label for="all">显示全部SDV疑问</label>
		</c:if>
		 -->
		</p>
		<table class="xllist"> 
			<tr>
				<th width="50px">序号</th>
				<th width="100px">疑问类型</th>
				<th width="200px">疑问内容</th>
			</tr>
			<c:forEach items="${queryList}" var="query" varStatus="status">
				<tr  style="cursor: pointer;" onclick="callOutQueryEvent('${query.queryFlow}','${query.queryTypeName }','${query.sendWayId }');">
					<td>${status.index+1}</td>
					<td>${query.queryTypeName}</td>
					<td>${query.queryContent }</td>
				</tr>
			</c:forEach>
		</table>
</body>
</html>