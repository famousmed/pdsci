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
var width=(window.screen.width)*0.7;
var height=(window.screen.height)*0.7;
function add(){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/thesis/edit'/>", "编辑论文信息", width, height);
}

function delThesis(thesisFlow){
	url="<s:url value='/srm/ach/thesis/delete?thesisFlow='/>" + thesisFlow;
	jboxConfirm("确认删除？", function() {
		jboxGet(url , null , function(){
			window.parent.frames['mainIframe'].location.reload(true);
		} , null , true);
	});
}

function search(){
	jboxStartLoading();
	$("#searchForm").submit();
}

function edit(thesisFlow){
	jboxOpen("<s:url value='/srm/ach/thesis/edit?thesisFlow='/>"+ thesisFlow, "编辑论文信息", width, height);
}

function submitAudit(thesisFlow){
	var url = "<s:url value='/srm/ach/thesis/submitAudit?thesisFlow='/>"+thesisFlow;
	jboxConfirm("确认送审,送审后无法修改?",function () {
		jboxGet(url,null,function(resp){
			if(resp=="1"){
				jboxTip("送审成功");
				window.location.href="<s:url value='/srm/ach/thesis/list'/>";	
			}
		},null,false);			
	});
}

function view(thesisFlow){
	jboxOpen("<s:url value='/srm/ach/thesis/edit?thesisFlow='/>"+ thesisFlow+"&editFlag=${GlobalConstant.FLAG_N}", "查看论文信息",width, height);
}

function auditProcess(flow){
	jboxOpen("<s:url value='/srm/achProcess/auditProcess?flow='/>"+ flow , "操作记录" , width, height);
}

function lookFactor(issnCode){
	jboxOpen("<s:url value = '/sys/impactorFactor/getImpactorFactorByISSN2?issn='/>"+ issnCode, "最新SCI收录期刊影响因子" , 1000, 400);
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
		  <form id="searchForm" action="<s:url value="/srm/ach/thesis/list"/>" method="post">
			 <p>
		 		&#12288;论文题目：
		 		<input type="text" name="thesisName" value="${param.thesisName}" class="xltext"/>
		 		&#12288;出版/发表时间：
		 		<input class="xltext ctime" style="width:160px;" type="text" name="publishDate" value="${param.publishDate}" onClick="WdatePicker({dateFmt:'yyyy-MM'})"  class="ctime" readonly="readonly"/>
		 		<%-- &#12288;作者姓名：
		 		<input type="text" name="authorName" value="${param.authorName}" class="xltext"/>
			</p>
			<p>
		 		发表期刊 /论文集：
		 		<input type="text" name="publishJour" value="${param.publishJour}" class="xltext"/>
		 		&#12288;刊物类型：
				<select name="jourTypeId" class="xlselect" onchange="search();">
					<option value="">请选择</option>
					 <c:forEach items="${dictTypeEnumJournalTypeList }" var="dict">
					 	<option <c:if test="${param.jourTypeId eq dict.dictId }">selected="selected"</c:if> value="${dict.dictId }" >${dict.dictName }</option>
		             </c:forEach>
				</select> --%>
				
				<input type="button" class="search" onclick="search();" value="查&#12288;询">
				<input type="button" class="search" onclick="add();" value="新&#12288;增">
				<input type="hidden" id="currentPage" name="currentPage">
			</p>
		</form>
	</div>
	
	<table class="xllist">
		<thead>
			<tr>
				<th width="20%">论文题目</th>
				<th width="15%">作者</th>
				<th width="10%">发表/出版日期</th>
				<th width="6%">论文类型</th>
				<th width="14%">项目来源</th>
				<th width="10%">审核状态</th>
				<th width="10%">操作记录</th>
				<th width="15%">操作</th>
			</tr>
	  	</thead>
		<c:forEach items="${thesisList}" var="thesis">
		<tr>
			<td>${thesis.thesisName }</td>
			<td width="20%">
				<c:forEach items="${allAuthorMap}" var="entry">
				<c:if test="${entry.key==thesis.thesisFlow}">
					<c:forEach items="${entry.value}" var="author">
					${author.authorName}&nbsp;
					</c:forEach>
				</c:if>
				</c:forEach>
			</td>
			<td>${thesis.publishDate}</td>
			<td>${thesis.typeName }</td>
			<td>${thesis.projSourceName}</td>
			<td>${thesis.operStatusName}</td>
			<td>
				<a href="javascript:void(0);" onclick="auditProcess('${thesis.thesisFlow}')">[查看操作记录]</a>
			</td>
			<td width="20%">
				<c:choose>
					<c:when test="${thesis.operStatusId != achStatusEnumSubmit.id and thesis.operStatusId != achStatusEnumFirstAudit.id}">
						<c:if test="${thesis.operStatusId eq achStatusEnumApply.id or thesis.operStatusId eq achStatusEnumRollBack.id}">
						<a href="javascript:void(0)" onclick="submitAudit('${thesis.thesisFlow}');">[送审]</a>              
						</c:if>
						<a href="javascript:void(0)" onclick="edit('${thesis.thesisFlow}');">[编辑]</a>              
						<a href="javascript:void(0)" onclick="delThesis('${thesis.thesisFlow}');">[删除]</a>          
						<a href="javascript:void(0)" onclick="lookFactor('${thesis.issnCode}');">[查看影响因子]</a>          
					</c:when>
					<c:otherwise>
						<a href="javascript:void(0)" onclick="view('${thesis.thesisFlow}');">[查看]</a>           
					</c:otherwise>
				</c:choose> 
			</td>
		</tr>
		</c:forEach>
	</table>
		<p>
			<c:set var="pageView" value="${pdfn:getPageView2(thesisList , 10)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>
		</p>
   </div>
</div> 	
</body>
</html>