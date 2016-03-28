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
$(document).ready(function(){
	selUnsolvedQuery();
});

function showQueryEvent(queryFlow){
	var url ='<s:url value='/edc/query/showQueryEvent'/>?queryFlow='+queryFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='220px' marginheight='0' marginwidth='0' frameborder='0' scrolling='no' src='"+url+"'></iframe>";
	jboxMessager(iframe,'疑问项明细',$('.main_fix').width(),250,queryFlow);	
}

</script>


</head>
<style>
.divPicSdving{background-image: url('<s:url value='/css/skin/${skinPath}/images/shu.gif' />');background-repeat: no-repeat;background-position: center;}
.divPicSdved{background-image: url('<s:url value='/css/skin/${skinPath}/images/gou.gif' />');background-repeat: no-repeat;background-position: center;}
.viewTd img {border: 0;position: relative;vertical-align: middle;}
</style>
<body>
		<table class="xllist">
			<tr>
				<th width="50px">疑问状态</th>
				<th width="150px">DCF编号</th>
				<th width="100px">受试者编号</th>
				<th width="50px">序号</th>
				<th width="100px">疑问类型</th>
				<th width="200px">疑问内容</th>
				<th width="100px">发送方式</th>
				<th width="100px">发送人</th>
				<th width="150px">发送时间</th>
			</tr>
			<c:forEach items="${queryList}" var="query">
				<tr style="cursor: pointer;" onclick="showQueryEvent('${query.queryFlow}');" class="query_${query.solveStatusId } queryTr">
					<td>
						<input type="hidden" name="queryFlow" value="${query.queryFlow }"/>
						<input type="hidden" id="${query.queryFlow }_queryStatusId" value="${query.queryStatusId }"/>
						<c:choose>
							<c:when test="${query.dmStatus == GlobalConstant.FLAG_Y }">
								<img src="<s:url value='/css/skin/${skinPath}/images/gou2.gif'/>" title="DM确认"/>
							</c:when>
							<c:when test="${query.craStatus == GlobalConstant.FLAG_Y }">
								<img src="<s:url value='/css/skin/${skinPath}/images/gou1.gif'/>" title="CRA确认"/>
							</c:when>
							<c:when test="${query.solveStatusId == edcQuerySolveStatusEnumSolved.id }">
								<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>" title="提交更新"/>
							</c:when>
							<c:when test="${query.queryStatusId == edcQueryStatusEnumSended.id }">
								<img src="<s:url value='/css/skin/${skinPath}/images/sendQuery.gif'/>" title="已发送"/>
							</c:when>
						</c:choose>
					</td>
					<td>${query.dcfNo}
						<input type="hidden" id="${query.queryFlow }_dcfNo" value="${query.dcfNo }"/>
					</td>
					<td>${query.patientCode}</td>
					<td>${query.querySeq}</td>
					<td>${query.queryTypeName}</td>
					<td>${query.queryContent}</td>
					<td>${query.sendWayName}</td>
					<td>${query.sendUserName}</td>
					<td>${pdfn: transDateTime(query.sendTime)}</td>
				</tr>
			</c:forEach>
			<c:if test="${queryList == null || queryList.size()==0 }"> 
				<tr> 
					<td align="center" colspan="9">无记录</td>
				</tr>
			</c:if>
		</table>
</body>
</html>