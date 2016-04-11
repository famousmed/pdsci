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
	jboxOpen("<s:url value='/srm/ach/appraisal/edit'/>", "添加鉴定信息", width, height);
}

function edit(appraisalFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/appraisal/edit'/>?appraisalFlow="+appraisalFlow, "编辑鉴定信息", width, height);
}

function delAppraisal(appraisalFlow){
	var url = '<s:url value="/srm/ach/appraisal/delete"/>?appraisalFlow='+appraisalFlow;
	jboxConfirm("确认删除？" , function(){
		jboxGet(url , null , function(){
			window.parent.frames['mainIframe'].location.reload(true);
		} , null , true);
	});
}

function search(){
	jboxStartLoading();
	$("#searchForm").submit();	
}

function submitAudit(appraisalFlow){
	var url = "<s:url value='/srm/ach/appraisal/submitAudit?appraisalFlow='/>"+appraisalFlow;
	jboxConfirm("确认送审,送审后无法修改?",function () {
		jboxGet(url,null,function(resp){
			jboxTip("送审成功");
			window.location.href="<s:url value='/srm/ach/appraisal/list'/>";	
		},null,false);			
	});
}

function view(appraisalFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/appraisal/edit'/>?appraisalFlow="+appraisalFlow+"&editFlag=${GlobalConstant.FLAG_N}", "查看鉴定信息", width, height);
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
		<form id="searchForm" action="<s:url value="/srm/ach/appraisal/list"/>" method="post">
		<p>
			&#12288;成果名称：	
			<input class="xltext" name="appraisalName" type="text" value="${param.appraisalName}"/>
			&#12288;鉴定日期：
		    <input onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="xltext ctime" style="width: 158px;" name="appraisalDate" type="text" value="${param.appraisalDate}" readonly="readonly"/>	
			
			<input class="search" type="button" value="查&#12288;询" onclick="search()"/>
			<input class="search" type="button" value="新&#12288;增" onclick="add()"/>
			<input type="hidden" id="currentPage" name="currentPage">
		</p>
		</form>
		</div>
		
		<table class="xllist">
		<thead>
			<tr>
				<th width="18%">成果名称</th>
				<th width="15%">成果完成人</th>
				<th width="10%">鉴定日期</th>
				<th width="10%">鉴定结论</th>
				<th width="12%">项目来源</th>
				<th width="10%">审核状态</th>
				<th width="10%">操作记录</th>
				<th width="15%">操作</th>
			</tr>
		</thead>
		<c:forEach items="${appraisalList}" var="appraisal">
		<tr>
			<td>${appraisal.appraisalName}</td>
			<td>
				<c:forEach items="${allAuthorMap}" var="entry">
				     <c:if test="${entry.key==appraisal.appraisalFlow}">
				     	<c:forEach items="${entry.value}" var="author">
				    	 ${author.authorName}&nbsp;
				    	</c:forEach>
				     </c:if>
			     </c:forEach>
			</td>
			<td>${appraisal.appraisalDate}</td>
			<td>${appraisal.appraisalResultName}</td>
			<td>${appraisal.projSourceName}</td>
			<td>${appraisal.operStatusName}</td>
			<td><a href="javascript:void(0);" onclick="auditProcess('${appraisal.appraisalFlow}')">[查看操作记录]</a></td>
			<td>
				<c:choose>
				<c:when test="${appraisal.operStatusId != achStatusEnumSubmit.id and appraisal.operStatusId != achStatusEnumFirstAudit.id}">
					<c:if test="${appraisal.operStatusId eq achStatusEnumApply.id or appraisal.operStatusId eq achStatusEnumRollBack.id}">
					<a href="javascript:void(0)" onclick="submitAudit('${appraisal.appraisalFlow}');">[送审]</a>              
					</c:if>
					<a href="javascript:void(0)" onclick="edit('${appraisal.appraisalFlow}');">[编辑]</a>              
					<a href="javascript:void(0)" onclick="delAppraisal('${appraisal.appraisalFlow}');">[删除]</a>              
				</c:when>
				<c:otherwise>
					<a href="javascript:void(0)" onclick="view('${appraisal.appraisalFlow}');">[查看]</a>           
				</c:otherwise>
				</c:choose> 
               </td>
			</tr>
		</c:forEach>
		</table>
		<p>
		    <c:set var="pageView" value="${pdfn:getPageView2(appraisalList, 10)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>
		</p>
	</div>
</div> 	
</body>
</html>