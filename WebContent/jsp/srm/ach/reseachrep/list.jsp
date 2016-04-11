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

function add() {
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/reseachrep/edit'/>", "编辑研究报告信息", width, height);
}

function deleReseachrep(reseachrepFlow) {
	url="<s:url value='/srm/ach/reseachrep/delete?reseachrepFlow='/>" + reseachrepFlow,
	jboxConfirm("确认删除？",function() {
		jboxStartLoading();
		jboxGet(url , null , function(){
			window.parent.frames['mainIframe'].location.reload(true);
		} , null , true);
	});
}

function search() {
	jboxStartLoading();
	$("#searchForm").submit();
}

function edit(reseachrepFlow) {
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/reseachrep/edit?reseachrepFlow='/>"+ reseachrepFlow, "编辑研究报告信息", width, height);
}

function submitAudit(reseachrepFlow){
	var url = "<s:url value='/srm/ach/reseachrep/submitAudit?reseachrepFlow='/>"+reseachrepFlow;
	jboxConfirm("确认送审,送审后无法修改?",function () {
		jboxStartLoading();
		jboxGet(url,null,function(resp){
			if(resp=="1"){
				jboxTip("送审成功");
				search();	
			}
		},null,false);			
	});
}

function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	jboxStartLoading();
	form.submit();
}

function view(reseachrepFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/reseachrep/edit?reseachrepFlow='/>"+ reseachrepFlow+"&editFlag=${GlobalConstant.FLAG_N}", "查看研究报告信息",width, height);
}

function auditProcess(flow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/achProcess/auditProcess?flow='/>"+ flow , "操作记录" , width, height);
}
</script>
</head>
<body>

<div class="mainright">
    <div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/srm/ach/reseachrep/list"/>" method="post">
				<p>
				&#12288;报告题目：
				<input type="text" name="repTitle" value="${param.repTitle}" class="xltext"/>
				&#12288;提交时间：
				<input type="text" name="submitDate" value="${param.submitDate}" class="xltext ctime" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
				<input type="button" class="search" onclick="search();" value="查&#12288;询">
				<input type="button" class="search" onclick="add();" value="新&#12288;增">
				<input type="hidden" id="currentPage" name="currentPage">
				</p>
			 </form>
		<br/>

		<table class="xllist">
		  	<thead>
		         <tr>
		            <th width="20%">报告题目</th>
		            <th width="10%">采纳对象</th>
		            <th width="15%">所有作者</th>
		            <th width="10%">提交时间</th>
		            <th width="10%">项目来源</th>
		            <th width="10%">审核状态</th>
		            <th width="10%">操作记录</th>
		            <th width="15%">操作</th>
		         </tr>
		     </thead>
		     <c:forEach items="${reseachrepList}" var="rep">
		     <tr>
			     <td>${rep.repTitle }</td>
			     <td>${rep.acceptObjectName }</td>
			     <td>
				     <c:forEach items="${allAuthorMap}" var="entry">
					     <c:if test="${entry.key==rep.reseachrepFlow}">
					     	<c:forEach items="${entry.value}" var="author">
					    	 ${author.authorName}&nbsp;
					    	</c:forEach>
					     </c:if>
				     </c:forEach>
			     </td>
			     <td>${rep.submitDate }</td>
			     <td>${rep.projSourceName}</td>
			     <td>${rep.operStatusName}</td>
			     <td><a href="javascript:void(0);" onclick="auditProcess('${rep.reseachrepFlow}');">[查看操作记录]</a></td>
			     <td>
			        <c:choose>
					 <c:when test="${rep.operStatusId != achStatusEnumSubmit.id and rep.operStatusId != achStatusEnumFirstAudit.id}">
					     <c:if test="${rep.operStatusId eq achStatusEnumApply.id or rep.operStatusId eq achStatusEnumRollBack.id}">
						 <a href="javascript:void(0)" onclick="submitAudit('${rep.reseachrepFlow}');">[送审]</a>              
						 </c:if>             
					     <a href="javascript:void(0)" onclick="edit('${rep.reseachrepFlow}');">[编辑]</a>              
					     <a href="javascript:void(0)" onclick="deleReseachrep('${rep.reseachrepFlow}');">[删除]</a>              
					 </c:when>
					 <c:otherwise>
					     <a href="javascript:void(0)" onclick="view('${rep.reseachrepFlow}');">[查看]</a>           
					 </c:otherwise>
				    </c:choose>
			      </td>
			 </tr>
		     </c:forEach>
		</table>
	 		<p>
		    <c:set var="pageView" value="${pdfn:getPageView2(reseachrepList , 10)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>
			</p>
	 	</div>
  	</div>
</div> 	

</body>
</html>