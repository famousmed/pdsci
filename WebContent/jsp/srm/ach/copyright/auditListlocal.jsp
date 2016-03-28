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
var height=(window.screen.height)*0.7;
var width=(window.screen.width)*0.7;
function search(){
	jboxStartLoading();
	$("#searchForm").submit();
}

function audit(copyrightFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/copyright/audit?copyrightFlow='/>"+copyrightFlow, "审核", 950, 650);
}

function view(copyrightFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/copyright/edit?copyrightFlow='/>"+ copyrightFlow+"&editFlag=${GlobalConstant.FLAG_N}", "查看著作信息",width, height);
}

function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	jboxStartLoading();
	form.submit();
}
</script>
</head>
<body>
<div class="mainright">
  <div class="content">
    <div class="title1 clearfix">
	<form id="searchForm" action="<s:url value="/srm/ach/copyright/auditList/local"/>" method="post">
 	<p>
 		&#12288;著作权名称：
 		<input type="text" name="copyrightName"  class="xltext" value="${param.copyrightName }"/>
 		&#12288;&#12288;出版日期：
 		<input class="xltext ctime" style="width: 160px;" type="text" name="publishDate"  value="${param.publishDate }" onClick="WdatePicker({dateFmt:'yyyy-MM'})"  readonly="readonly"/>
	</p>
	<p>
		&#12288;&#12288;&#12288;&#12288;作者：
		<input type="text" class="xltext" name="authorName" value="${param.authorName}"/>
 		&#12288;&#12288;&#12288;登记号：
        <input type="text" name="registerCode" value="${param.registerCode }" class="xltext"/>
		
		&#12288;&#12288;审核结果：
		<input type="radio" name="operStatusId" id="achStatusEnumAll"  
			<c:if test="${param.operStatusId eq GlobalConstant.FLAG_Y}">checked="checked"</c:if> value="${GlobalConstant.FLAG_Y}" /><label for="achStatusEnumAll">全部</label> 
		<input type="radio" name="operStatusId" id="achStatusEnum_Submit" 
			<c:if test="${empty param.operStatusId }">checked="checked"</c:if> <c:if test="${param.operStatusId eq achStatusEnumSubmit.id}">checked="checked"</c:if> value="${achStatusEnumSubmit.id }" /><label for="achStatusEnum_Submit">${achStatusEnumSubmit.name}</label> 
		<input type="radio"  name="operStatusId" id="achStatusEnum_FirstAudit"
			<c:if test="${param.operStatusId eq achStatusEnumFirstAudit.id }">checked="checked"</c:if> value="${achStatusEnumFirstAudit.id }" /><label for="achStatusEnum_FirstAudit">${achStatusEnumFirstAudit.name}</label> 
		&#12288;&#12288;
		<input type="button" class="search" onclick="search();" value="查&#12288;询">
	</p>
	</form>
	</div>
	
    <table class="xllist">
    <tr style="height: 20px">
       <th>登记号</th>
       <th>著作权名称</th>
       <th>著作权类型</th>
       <th>所有作者</th>
       <th>出版日期</th>
       <th>审核状态</th>
       <th>操作</th>
    </tr>
  	<c:forEach items="${copyrightList}" var="copyright">
    <tr>
		<td>${copyright.registerCode }</td>
		<td>${copyright.copyrightName }</td>
		<td>${copyright.copyrightTypeName }</td>
		<td>
      	<c:forEach items="${allAuthorMap}" var="entry">
      		<c:if test="${entry.key == copyright.copyrightFlow}">
      			<c:forEach items="${entry.value}" var="author">
      				${author.authorName}&nbsp;
      			</c:forEach>
      		</c:if>
      	</c:forEach>
      	</td>
		<td>${pdfn:transDate(copyright.publishDate)}</td>
		<td>${copyright.operStatusName}</td>
		<td>
			<c:if test="${copyright.operStatusId eq achStatusEnumSubmit.id }">
			<a href="javascript:void(0)" onclick="audit('${copyright.copyrightFlow}');">[审核]</a>
			</c:if>
			<c:if test="${copyright.operStatusId eq achStatusEnumFirstAudit.id }">
			<a href="javascript:void(0)" onclick="view('${copyright.copyrightFlow}');">[查看]</a>
			</c:if>
		</td>
	</tr>
	</c:forEach>
    </table>
	<%-- <p>
		<input type="hidden" id="currentPage" name="currentPage">
	    <c:set var="pageView" value="${pdfn:getPageView2(copyrightList, 10)}" scope="request"></c:set>
		<pd:pagination toPage="toPage"/>
	</p> --%>
  </div> 	
</div>
 
</body>
</html>