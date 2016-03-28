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

function edit(thesisFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/thesis/edit?thesisFlow='/>"+ thesisFlow+"&editFlag=${GlobalConstant.FLAG_N}", "查看论文信息",width, height);
}

function audit(thesisFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/thesis/audit?thesisFlow='/>"+thesisFlow, "审核", 700, 400);
}

function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	jboxStartLoading();
	form.submit();
}

function lookFactor(issnCode){
	jboxStartLoading();
	jboxOpen("<s:url value = '/sys/impactorFactor/getImpactorFactorByISSN2?issn='/>"+ issnCode, "最新SCI收录期刊影响因子" , 1000, 400);
}

</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
		<form id="searchForm" action="<s:url value="/srm/ach/thesis/auditList/charge"/>" method="post">
		<p>
	 		&#12288;论文题目：
	 		<input type="text" name="thesisName" value="${param.thesisName}" class="xltext"/>
	 		&#12288;出版/发表时间：
	 		<input class="xltext ctime" style="width: 157px;" type="text" name="publishDate" value="${param.publishDate }" onClick="WdatePicker({dateFmt:'yyyy-MM'})"  readonly="readonly"/>
	 		&#12288;项目来源：
			<select name="projSourceId" class="xlselect">
				<option value="">请选择</option>
				<c:forEach items="${dictTypeEnumProjSourceList }" var="dict">
				<option <c:if test="${param.projSourceId eq dict.dictId }">selected="selected"</c:if> value="${dict.dictId }">${dict.dictName }</option>
				</c:forEach>
			</select>
        </p>
		<p>
          	&#12288;申报单位：
			<select id="org" name="orgFlow" class="xlselect">
				<option value="">请选择</option>
				<c:forEach var="org" items="${firstGradeOrgList}">
				<option <c:if test="${param.orgFlow eq org.orgFlow }">selected="selected"</c:if> value="${org.orgFlow}">${org.orgName}</option>
				</c:forEach>
			</select>
		  	<input type="button" class="search" onclick="search();" value="查&#12288;询">
		</p>
	 	</form>
		</div>
		
	<table class="xllist">
		<thead>
			<tr>
				<th>论文题目</th>
				<th>申报单位</th>
				<th>论文类型</th>
				<th>作者</th>
				<th>发表/出版日期</th>
				<th>项目来源</th>
				<th>操作</th>
			</tr>
		</thead>
	   
		<c:forEach items="${thesisList}" var="thesis">
		<c:if test="${thesis.operStatusId eq achStatusEnumFirstAudit.id}">
     	<tr>
		     <td>${thesis.thesisName}</td>
		     <td>${thesis.applyOrgName}</td>
		     <td>${thesis.typeName}</td>
		     <td>
	       		<c:forEach items="${allAuthorMap}" var="entry">
				     <c:if test="${entry.key==thesis.thesisFlow}">
				     	<c:forEach items="${entry.value}" var="author">
				    	 ${author.authorName}&nbsp;
				    	</c:forEach>
				     </c:if>
			    </c:forEach>
		     </td>
		     <td>${thesis.publishDate}</td>
		     <td>${thesis.projSourceName}</td>
		     <td>
		       <a href="javascript:void(0)" onclick="edit('${thesis.thesisFlow}');">[查看]</a>
		       <a href="javascript:void(0)" onclick="lookFactor('${thesis.issnCode}');">[查看影响因子]</a>
		     </td>
		</tr>
	    </c:if>
	   </c:forEach>
	</table>
  	<%-- <p>
		<input type="hidden" id="currentPage" name="currentPage">
	    <c:set var="pageView" value="${pdfn:getPageView2(thesisList, 10)}" scope="request"></c:set>
		<pd:pagination toPage="toPage"/>
	</p> --%>
  	</div>
</div> 	
</body>
</html>