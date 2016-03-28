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
function add(){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/copyright/edit'/>", "著作权信息", width, height);
}

function edit(copyrightFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/copyright/edit'/>?copyrightFlow="+copyrightFlow, "著作权信息", width, height);
}

function deleCopyright(copyrightFlow){
	url="<s:url value='/srm/ach/copyright/delCopyright'/>?copyrightFlow=" + copyrightFlow,
	jboxConfirm("确认删除？" , function(){
		jboxStartLoading();
		jboxGet(url , null , function(){
			window.parent.frames['mainIframe'].location.reload(true);
		} , null , true);
	});
}

function search(){
	jboxStartLoading();
	$("#searchForm").submit();
}

function submitAudit(copyrightFlow){
	var url = "<s:url value='/srm/ach/copyright/submitAudit?copyrightFlow='/>"+copyrightFlow;
	jboxConfirm("确认送审,送审后无法修改?",function () {
		jboxStartLoading();
		jboxGet(url,null,function(resp){
			if(resp=="1"){
				jboxTip("送审成功");
				window.location.href="<s:url value='/srm/ach/copyright/list'/>";	
			}
		},null,false);			
	});
}

function view(copyrightFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/copyright/edit?copyrightFlow='/>"+ copyrightFlow+"&editFlag=${GlobalConstant.FLAG_N}", "查看著作权信息",width, height);
}

function auditProcess(flow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/achProcess/auditProcess?flow='/>"+ flow , "操作记录" , width, height);
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
	<form id="searchForm" action="<s:url value="/srm/ach/copyright/list"/>" method="post">
		<p>
			&#12288;著作权名称：	
			<input class="xltext" name="copyrightName" type="text" value="${param.copyrightName}"/>
			&#12288;登记号：	
			<input class="xltext" name="registerCode" type="text" value="${param.registerCode}"/>
			<input class="search" type="button" value="查&#12288;询" onclick="search()"/>
			<input class="search" type="button" value="新&#12288;增" onclick="add()"/>
			<input type="hidden" id="currentPage" name="currentPage">
		</p>
	</form> 
	</div>
	
	<table class="xllist">
	<thead>
		<tr>
			<th width="10%">登记号</th>
			<th width="20%">著作权名称</th>
			<th width="10%">著作权类型</th>
			<th width="15%">所有作者</th>
			<th width="10%">出版日期</th>
			<th width="10%">审核状态</th>
			<th width="10%">操作记录</th>
			<th width="15%">操作</th>
		</tr>
	</thead>
	<c:forEach items="${copyrightList}" var="copyright"> 
	<tr>
		<td>${copyright.registerCode}</td>
		<td>${copyright.copyrightName}</td>
		<td>${copyright.copyrightTypeName}</td>
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
		<td><a href="javascript:void(0);" onclick="auditProcess('${copyright.copyrightFlow}')">[查看操作记录]</a></td>
		<td>
			<c:choose>
				<c:when test="${copyright.operStatusId != achStatusEnumSubmit.id and copyright.operStatusId != achStatusEnumFirstAudit.id}">
					<c:if test="${copyright.operStatusId eq achStatusEnumApply.id or copyright.operStatusId eq achStatusEnumRollBack.id}">
					<a href="javascript:void(0)" onclick="submitAudit('${copyright.copyrightFlow}');">[送审]</a>              
					</c:if>             
					<a href="javascript:void(0)" onclick="edit('${copyright.copyrightFlow}');">[编辑]</a>              
					<a href="javascript:void(0)" onclick="deleCopyright('${copyright.copyrightFlow}');">[删除]</a>              
				</c:when>
				<c:otherwise>
					<a href="javascript:void(0)" onclick="view('${copyright.copyrightFlow}','look');">[查看]</a>           
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	</c:forEach>
	</table>
	<p>
	    <c:set var="pageView" value="${pdfn:getPageView2(copyrightList, 10)}" scope="request"></c:set>
		<pd:pagination toPage="toPage"/>
	</p>
   </div> 	
 </div>
</body>
</html>