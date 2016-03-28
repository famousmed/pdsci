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
function search(){
	$("#searchForm").submit();
}
/* function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	form.submit();
} */
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/gcp/qcList" />" method="get">
				检查开始日期：
				<input type="text" name="startDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${param.startDate}" class="xltext ctime" style="margin-right: 0px"/>
				~
				<input type="text" name="endDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${param.endDate}" class="xltext ctime"/>
				<input type="button" class="search"	onclick="search();" value="查&#12288;询">
			</form>
		</div> 
		<div>
			<table class="xllist">
				<tr>
					<th width="4%">序号</th>
					<th width="24%">项目名称</th>		
					<th width="7%">期类别</th>	
					<th width="15%">项目来源</th>	
					<th width="8%">组长/参加</th>	
					<th width="10%">承担科室</th>
					<th width="17%">检查日期</th>
					<th width="15%">检查部门</th>
				</tr>
				<c:forEach items="${qcRecordList}" var="qcRecord" varStatus="seq">
				<tr>
					<td>${seq.count}</td>
					<td>${projFormMap[qcRecord.projFlow].proj.projShortName}</td>
					<td>${projFormMap[qcRecord.projFlow].proj.projSubTypeName}</td>
					<td>${projFormMap[qcRecord.projFlow].proj.projShortDeclarer}</td>
					<td>
						<c:if test="${projFormMap[qcRecord.projFlow].isLeader eq projOrgTypeEnumLeader.id}">${projOrgTypeEnumLeader.name }</c:if>
    					<c:if test="${projFormMap[qcRecord.projFlow].isLeader eq projOrgTypeEnumParti.id}">${projOrgTypeEnumParti.name }</c:if>
					</td>
					<td>${projFormMap[qcRecord.projFlow].proj.applyDeptName }</td>
					<td>${qcRecord.qcStartDate}~${qcRecord.qcEndDate}</td>
					<td>${qcRecord.qcDepartment}</td>
				</tr>
				</c:forEach>
				<c:if test="${empty qcRecordList}">
					<tr align="center"><td colspan="8">无记录！</td></tr>
				</c:if>
			</table>
			<%-- <p>
				<c:set var="pageView" value="${pdfn:getPageView2(projList, 10)}" scope="request"></c:set>
				<pd:pagination toPage="toPage"/>
			</p> --%>
		</div>
	</div> 
</div>
</body>
</html>