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
function edit(appraisalFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/appraisal/edit'/>?appraisalFlow="+appraisalFlow+"&editFlag=${GlobalConstant.FLAG_N}", "查看鉴定信息", width, height);
}

function search() {
	jboxStartLoading();
	$("#searchForm").submit();
}

function audit(appraisalFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/appraisal/audit?appraisalFlow='/>"+appraisalFlow, "审核", 700, 400);
}

function loadApplyOrg(){
	//清空
	var org = $('#org');
	org.html('<option value="">请选择</option>');
	var chargeOrgFlow = $('#chargeOrg').val();
	if(!chargeOrgFlow){
		return ;
	}
	url="<s:url value='/sys/org/loadApplyOrg'/>?orgFlow="+chargeOrgFlow
	jboxStartLoading();
	jboxGet(url,null,function(resp){
		$.each(resp , function(i , n){
			org.append('<option value="'+n.orgFlow+'">'+n.orgName+'</option>');
		});
				
	},null,false);			
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
		<form id="searchForm" action="<s:url value="/srm/ach/appraisal/auditList/global"/>" method="post">
		<p>
	 		&#12288;鉴定名称：
	 		<input type="text" name="appraisalName"  class="xltext" value="${param.appraisalName}"/>
	 		&#12288;鉴定日期：
	 		<input class="xltext ctime" style="width:157px;" type="text" name="appraisalDate" value="${param.appraisalDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  readonly="readonly"/>
			&#12288;项目来源：
			<select name="projSourceId" class="xlselect">
				<option value="">请选择</option>
				<c:forEach items="${dictTypeEnumProjSourceList }" var="dict">
				<option <c:if test="${param.projSourceId eq dict.dictId }">selected="selected"</c:if> value="${dict.dictId }" >${dict.dictName }</option>
				</c:forEach>
			</select>
		</p>
		<p>
            &#12288;主管部门：
			<select id="chargeOrg" name="chargeOrgFlow" onchange="loadApplyOrg();" class="xlselect">
				<option value="">请选择</option>
				<c:forEach var="chargeOrg" items="${firstGradeOrgList}">
				<option <c:if test="${param.chargeOrgFlow eq  chargeOrg.orgFlow }">selected="selected"</c:if> value="${chargeOrg.orgFlow}">${chargeOrg.orgName}</option>
				</c:forEach>
			</select>
			&#12288;申报单位：
			<select id="org" name="orgFlow" class="xlselect">
				<option value="">请选择</option>
				<c:forEach var="org" items="${secondGradeOrgList}">
				<option <c:if test="${param.orgFlow eq org.orgFlow }">selected="selected"</c:if> value="${org.orgFlow}">${org.orgName}</option>
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
            <th>成果名称</th>
            <th>成果完成人</th>
            <th>申报单位</th>
            <th>鉴定日期</th>
            <th>鉴定结论</th>
            <th>项目来源</th>
            <th>鉴定形式</th>
            <th>操作</th>
         </tr>
	</thead>
    <c:forEach items="${appraisalList}" var="appraisal">
	<c:if test="${appraisal.operStatusId eq achStatusEnumFirstAudit.id}">
       <tr>
	       <td>${appraisal.appraisalName }</td>
	       <td>
       		<c:forEach items="${allAuthorMap}" var="entry">
			     <c:if test="${entry.key==appraisal.appraisalFlow}">
			     	<c:forEach items="${entry.value}" var="author">
			    	 ${author.authorName}&nbsp;
			    	</c:forEach>
			     </c:if>
		     </c:forEach>
	       </td>
	       <td>${appraisal.applyOrgName }</td>
	       <td>${appraisal.appraisalDate }</td>
	       <td>${appraisal.appraisalResultName }</td>
	       <td>${appraisal.projSourceName}</td>
	       <td>${appraisal.appraisalTypeName}</td>
	       <td>
	        <a href="javascript:void(0)" onclick="edit('${appraisal.appraisalFlow}');">[查看]</a>
	       </td>
	   </tr>
    </c:if>
    </c:forEach>
  </table>
  	<%-- <p>
		<input type="hidden" id="currentPage" name="currentPage">
	    <c:set var="pageView" value="${pdfn:getPageView2(appraisalList, 10)}" scope="request"></c:set>
		<pd:pagination toPage="toPage"/>
	</p> --%>
   </div>
</div> 	

</body>
</html>