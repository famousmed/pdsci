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
<script>
function change(sendWayId){
	window.location.href="<s:url value='/edc/inspect/showAllQuery?patientFlow=${patient.patientFlow}&sendWayId='/>"+sendWayId;
}

</script>
</head>

<body>
	<div class="mainright">
	<div class="content">
			<div style="margin-top: 5px">
			&#12288;参与机构：${sysOrgMap[patient.orgFlow].orgName }
			&#12288;受试者编码：${patient.patientCode }
			&#12288;发送方式：<select style="width: 200px" id="sendWayId" onchange="change(this.value);">
						<option></option>
						<option value="SDV" <c:if test="${sendWayId eq 'SDV'}">selected</c:if>>SDV疑问</option>
						<option value="NOTSDV" <c:if test="${sendWayId eq 'NOTSDV'}">selected</c:if>>手工疑问/逻辑检查</option>		
				</select>
				<hr/>
	</div>
			<div class="title1 clearfix">
				<table class="xllist" >
				<tr height="40px">
					<th style="text-align: center" width="6%">序号</th>
					<th style="text-align: center" width="12%">疑问类型</th>
					<th style="text-align: center" width="16%">访视名称</th>
					<th style="text-align: center" width="12%">数据项</th>
					<th style="text-align: center" width="20%">疑问内容</th>
					<th style="text-align: center" width="12%">发送方式</th>
					<th style="text-align: center" width="9%">发送人</th>
					<th style="text-align: center" width="13%">发送时间</th>
				</tr>
					<c:forEach items="${queryList}" var="query" >
					<c:forEach items="${queryEventMap[query.queryFlow] }"  var="data" varStatus="status" >
					<tr> 
						<c:set var="queryLength" value="${fn:length(queryEventMap[query.queryFlow])}"></c:set>
						<c:if test="${status.index == 0 }"> 
						<td style="text-align: center" rowspan="${queryLength}" width="6%">${query.querySeq }</td>
						<td style="text-align: center" rowspan="${queryLength}" width="12%">${query.queryTypeName}</td>
						</c:if>
						<td style="text-align: center" width="16%">${data.visitName}</td>
						<td style="text-align: center" width="12%">${data.elementName }.${data.attrName }</td>
						<c:if test="${status.index == 0 }"> 
						<td style="text-align: center" rowspan="${queryLength }" width="20%">${query.queryContent }</td>
						<td style="text-align: center" rowspan="${queryLength }" width="12%">${query.sendWayName}</td>
						<td style="text-align: center" rowspan="${queryLength }" width="9%">${query.sendUserName}</td>
						<td style="text-align: center" rowspan="${queryLength }" width="13%">${pdfn: transDateTime(query.sendTime)}</td>
						</c:if>
					</tr> 
					</c:forEach>
					</c:forEach>
					<c:if test="${queryList == null || queryList.size()==0 }"> 
					<tr> 
						<td align="center" colspan="8">无记录</td>
					</tr>
					</c:if>
				</table>
		</div>
	</div>
	</div>
</body>
</html>