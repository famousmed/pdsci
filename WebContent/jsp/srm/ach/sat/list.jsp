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
	jboxOpen("<s:url value='/srm/ach/sat/edit'/>", "科技信息", width, height);
}
function edit(satFlow){
	jboxOpen("<s:url value='/srm/ach/sat/edit'/>?satFlow="+satFlow, "编辑科技信息", width, height);
}

function submitAudit(satFlow){
	var url = "<s:url value='/srm/ach/sat/submitAudit?satFlow='/>"+satFlow;
	jboxConfirm("确认送审,送审后无法修改?",function () {
		jboxGet(url,null,function(resp){
			jboxTip("送审成功");
			window.location.href="<s:url value='/srm/ach/sat/list'/>";	
		},null,false);			
	});
}

function view(satFlow){
	jboxOpen("<s:url value='/srm/ach/sat/edit'/>?satFlow=" + satFlow + "&editFlag=${GlobalConstant.FLAG_N}", "查看科技信息", width, height);
}
function auditProcess(flow){
	jboxOpen("<s:url value='/srm/achProcess/auditProcess?flow='/>"+ flow , "操作记录" , width, height);
}

function delSat(satFlow){
	var url = '<s:url value="/srm/ach/sat/delete"/>?satFlow='+satFlow;
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

function audit(){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/thesis/audit'/>", "审核", width, height);
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
		<form id="searchForm" action="<s:url value="/srm/ach/sat/list"/>" method="post">
		<p>
			&#12288;科技名称：	
			<input class="xltext" name="satName" type="text" value="${param.satName}"/>
			&#12288;获奖日期：
			<input readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="ctime" style="width: 158px;" name="prizedDate" type="text" value="${param.prizedDate}" />
			
			<input class="search" type="button" value="查&#12288;询" onclick="search()"/>
			<input class="search" type="button" value="新&#12288;增" onclick="add()"/>
			<input type="hidden" id="currentPage" name="currentPage">
		</p>
		</form>
	 </div>
	 
    <table class="xllist">
	   	 <tr>
	       <th>科技名称</th>
	       <th>科技作者</th>
	       <th>获奖级别</th>
	       <th>获奖等级</th>
	       <th>获奖日期</th>
	       <!-- <th>创建时间</th> -->
	       <th>审核状态</th>
		   <th>操作记录</th>
	       <th>操作</th>
	    </tr>
	  	<c:forEach items="${satList}" var="sat">
	   	 <tr>
	     	 <td>${sat.satName}</td>
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
	     	 <%-- <td>${pdfn:transDate(sat.createTime) }</td> --%>
	     	 <td>${sat.operStatusName}</td>
	       	 <td>
	       	 	<a href="javascript:void(0);" onclick="auditProcess('${sat.satFlow}')">[查看操作记录]</a>
	       	 </td>
			 <td width="15%">
			   	<c:choose>
				   <c:when test="${sat.operStatusId != achStatusEnumSubmit.id and sat.operStatusId != achStatusEnumFirstAudit.id}">
				       <c:if test="${sat.operStatusId eq achStatusEnumApply.id or sat.operStatusId eq achStatusEnumRollBack.id}">
				       		<a href="javascript:void(0)" onclick="submitAudit('${sat.satFlow}');">[送审]</a>              
				       </c:if>
				       <a href="javascript:void(0)" onclick="edit('${sat.satFlow}');">[编辑]</a>              
				       <a href="javascript:void(0)" onclick="delSat('${sat.satFlow}');">[删除]</a>              
				   </c:when>
				   <c:otherwise>
				       <a href="javascript:void(0)" onclick="view('${sat.satFlow}');">[查看]</a>           
				   </c:otherwise>
				</c:choose>
             </td>
	   </tr>
	  </c:forEach>
	</table>
 	<p>
	    <c:set var="pageView" value="${pdfn:getPageView2(satList, 10)}" scope="request"></c:set>
		<pd:pagination toPage="toPage"/>
	</p>
    </div>
 </div> 	

</body>
</html>