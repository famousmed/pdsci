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
function edit(satFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/sat/edit'/>?satFlow="+satFlow+"&editFlag=${GlobalConstant.FLAG_N}", "查看科技信息", width, height);
}

function search(){
	jboxStartLoading();
	$("#searchForm").submit();
}

function audit(satFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/sat/audit?satFlow='/>"+satFlow, "审核", 700, 400);
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
	  <form id="searchForm" action="<s:url value="/srm/ach/sat/auditList/charge"/>" method="post">
		 <p>
	 		&#12288;科技名称：
	 		<input type="text" name="satName"  class="xltext" value="${param.satName}"/>
	 		&#12288;获奖日期：
			<input readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="ctime" style="width: 158px;" name="prizedDate" type="text" value="${param.prizedDate}" />
	 		&#12288;项目来源：
	 	  	<select name="projSourceId" class="xlselect">
				<option value="">请选择</option>
				<c:forEach items="${dictTypeEnumProjSourceList }" var="dict">
				<option <c:if test="${param.projSourceId eq dict.dictId }">selected="selected"</c:if> value="${dict.dictId }" >${dict.dictName }</option>
				</c:forEach>
            </select>
        </p>
		<p>
	 		&#12288;申报单位：
            <select id="org" name="orgFlow" class="xlselect">
       			<option value="">请选择</option>
       			<c:forEach var="org" items="${firstGradeOrgList}">
   				<option  <c:if test="${param.orgFlow eq org.orgFlow }">selected="selected"</c:if> value="${org.orgFlow}">${org.orgName}</option>
       			</c:forEach>
             </select>
             &#12288;
			<input type="button" class="search" onclick="search();" value="查&#12288;询">
		</p>
		</form>
		</div>
		
		<table class="xllist">
			<thead>
				<tr>
					<th>科技名称</th>
					<th>科技作者</th>
					<th>获奖级别</th>
					<th>获奖等级</th>
					<th>获奖日期</th>
					<th>项目来源</th>
					<th>操作</th>
				</tr>
			</thead>
			<c:forEach items="${satList}" var="sat">
			<tr>
		 		<td>${sat.satName }</td>
				<td width="20%">
				 	<c:forEach items="${allAuthorMap}" var="entry">
					<c:if test="${entry.key==sat.satFlow}">
						<c:forEach items="${entry.value}" var="author">
						${author.authorName}&nbsp;
						</c:forEach>
					</c:if>
					</c:forEach>
				</td>
				<td>${sat.prizedGradeName}</td>
				<td>${sat.prizedLevelName}</td>
				<td>${sat.prizedDate}</td>
				<td>${sat.projSourceName}</td>
				<td>
					<a href="javascript:void(0)" onclick="edit('${sat.satFlow}');">[查看]</a>
				</td>
			</tr>
			</c:forEach>
		</table>
 	<%-- <p>
		<input type="hidden" id="currentPage" name="currentPage">
	    <c:set var="pageView" value="${pdfn:getPageView2(satList, 10)}" scope="request"></c:set>
		<pd:pagination toPage="toPage"/>
	</p> --%>
   </div>
</div> 	
</body>
</html>