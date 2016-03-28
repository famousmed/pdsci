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
	function showDecisionFile(fileName,irbFlow){
		var url = "<s:url value='/irb/secretary/decisionDetail'/>?irbFlow="+irbFlow+"&type=view";
		var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='800px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
		jboxMessager(iframe,fileName,800,600);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content" style="padding-top: 15px;">
		<table class="xllist">
			<thead>
				<tr>
					<th width="20%">伦理审查类型</th>
					<th width="14%">受理号</th>
					<th width="15%">主审委员</th>
					<th width="12%">审查日期</th>
					<th width="12%">审查决定</th>
					<c:if test="${applicationScope.sysCfgMap['gcp_irb_sys_on']==GlobalConstant.FLAG_Y }"><th width="12%">决定文件</th></c:if>
					<th width="15%">跟踪审查日期</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${irbApplyList }" var="irb">
					<tr>
						<td width="20%">${irb.irbTypeName }</td>
						<td width="14%">${irb.irbNo }</td>
						<td width="15%">
							<c:if test="${!empty committeeMap[irb.irbFlow]}">
								<c:forEach items="${committeeMap[irb.irbFlow]}" var="irbUser" varStatus="statu">
					                ${irbUser.userName}<c:if test="${fn:length(committeeMap[irb.irbFlow])>1&&!statu.last}">、</c:if>
					            </c:forEach>
							</c:if>
						</td>
						<td width="12%">${irb.irbReviewDate }</td>
						<td width="12%">${irb.irbDecisionName }</td>
						<c:if test="${applicationScope.sysCfgMap['gcp_irb_sys_on']==GlobalConstant.FLAG_Y }">
						<td width="12%">
							<c:if test="${irbRecTypeEnumApproveFile.id eq fileTypeMap[irb.irbFlow]}">
								[<a href="javascript:showDecisionFile('${irbRecTypeEnumApproveFile.name}','${irb.irbFlow}');">批件</a>]
							</c:if>
							<c:if test="${irbRecTypeEnumOpinionFile.id eq fileTypeMap[irb.irbFlow]}">
								[<a href="javascript:showDecisionFile('${irbRecTypeEnumOpinionFile.name}','${irb.irbFlow}');">意见</a>]
							</c:if>
						</td>
						</c:if>
						<td width="15%">${irb.trackDate }</td>
					</tr>
				</c:forEach>
				<c:if test="${empty irbApplyList }"><tr><td colspan="7">无记录！</td></tr></c:if>
			</tbody>
		</table>
	</div>
</div>
</body>
</html>