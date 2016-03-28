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

function search() {
	jboxStartLoading();
	$("#searchForm").submit();
}
function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	jboxStartLoading();
	form.submit();
}
function viewAll(talentsFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/aid/talents/assess?talentsFlow='/>"+talentsFlow+"&viewAll=Y", "查看全部", 900, 600);
}
</script>
</head>
<body>

 <div class="mainright" id="mainright">
    <div class="content">
	  <form id="searchForm" action="<s:url value="/srm/aid/talents/list/${role}"/>?view=Y" method="post">
	   <div class="title1 clearfix">
		<p>
			
	 		&nbsp;单位：
	 		<input type="text" name="orgName" value="${param.orgName}" class="xltext"/>
	 		部门：
	 		<input type="text" name="deptName" value="${param.deptName}" class="xltext"/>
	 		姓名：
	 		<input type="text" name="userName" value="${param.userName}" class="xltext" style="width:120px;"/>
	 		评价状态：
	 		<select name="assessStatusId" class="xlselect" style="width: 80px;">
	 			<option value="">全部</option>
	 			<c:forEach items="${aidAssessStatusEnumList}" var="status">
	 				<option value="${status.id}" <c:if test="${status.id == param.assessStatusId}">selected="selected"</c:if> >${status.name }</option>
	 			</c:forEach>
	 		</select>
			<input type="button" class="search" onclick="search();" value="查&#12288;询">
		</p>
		</div>
  <table class="xllist">
  	<thead>
         <tr>
            <th width="10%">姓名</th>
            <th width="15%">单位</th>
            <th width="10%">部门</th>
            <!-- <th width="10%">职务</th>
            <th width="10%">职称</th> -->
            <th width="10%">赴国家(地区)</th>
            <th width="15%">研修项目名称</th>
            <th width="17%">研修起止时间</th>
            <th width="10%">申请资助经费</th>
            <th width="8%">评价状态</th>
            <th width="6%">操作</th>
         </tr>
     </thead>
     <c:forEach items="${aidList}" var="aid">
     <tr>
	     <td>${aid.userName }</td>
	     <td>${aid.orgName }</td>
	     <td>${aid.deptName }</td>
	    <%--  <td>${aid.postName }</td>
	     <td>${aid.titleName }</td> --%>
	     <td>${aid.studyCountry}</td>
	     <td>${aid.studyName}</td>
	     <td>${aid.startDate}~${aid.endDate}</td>
	     <td>${aid.applyFee}</td>
	     <td>${aid.assessStatusName}</td>
	     <td>[<a href="javascript:void(0)" onclick="viewAll('${aid.talentsFlow }')">查看</a>]</td>
	 </tr>
     </c:forEach>
  </table>
 	<p>
		<input type="hidden" id="currentPage" name="currentPage" value="${param.currentPage}">
	    <c:set var="pageView" value="${pdfn:getPageView2(aidList, 10)}" scope="request"></c:set>
		<pd:pagination toPage="toPage"/>
	</p>
	  </form>
  </div>
</div> 	

</body>
</html>