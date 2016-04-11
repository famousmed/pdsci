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
function doClose(){
	jboxClose();
}
function change(irbFlow,obj){
	var url="<s:url value='/irb/meeting/saveIrbSettle' />"
	var requestData = {"irbFlow":irbFlow,"meetingFlow":'${param.meetingFlow}'}
	jboxPost(url,requestData,function(resp){
		if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
			if($(obj).val()=="撤销"){
				$(obj).val("上会");
			}else {
				$(obj).val("撤销");
			}
			if($(obj).parent().prev("td").html()=="已上会"){
				$(obj).parent().prev("td").html("未上会");
			}else {
				$(obj).parent().prev("td").html("已上会");
			}
			window.parent.frames["mainIframe"].window.reload();
		}
	},null,true);
}
function reload(){
	window.location.reload();
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
<div class="title1 clearfix">
		<table class="xllist" width="100%" id="detailTable">
			<thead>
				<tr>
					<th>序号</th><th>项目名称</th><th>伦理审查类别</th><th>受理号</th><th>状态</th><th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${irbList }" var="irb" varStatus="statu">
					<tr>
					<td style="width: 7%;">${statu.count }</td>
					<td style="width: 40%;">${irb.projShortName }</td>
					<td style="width: 20%;">${irb.irbTypeName }</td>
					<td style="width: 14%;">${irb.irbNo }</td>
					<td style="width: 9%;"><c:if test="${empty irb.meetingFlow}">未上会</c:if><c:if test="${!empty irb.meetingFlow}">已上会</c:if></td>
					<td style="width: 10%;"><input type="button" id="operButton" <c:if test="${empty irb.meetingFlow}"> value="上会" </c:if> <c:if test="${!empty irb.meetingFlow}"> value="撤销" </c:if> class="search" onclick="change('${irb.irbFlow}',this);"/></td>
				</tr> 
				</c:forEach>
			</tbody>
		</table>
	</div>
	</div></div>
</body>
</html>