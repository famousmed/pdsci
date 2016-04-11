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
function edit(flow) {
	jboxStartLoading();
	jboxOpen("<s:url value='/fstu/dec/edit'/>?flow="+flow+"&roleFlag=${roleFlag}","进修管理",1000,500);
	
}

function del(flow){
	jboxConfirm("确认删除？", function() {
		url="<s:url value='/fstu/dec/saveStudy'/>?studyFlow="+flow+"&recordStatus=${GlobalConstant.RECORD_STATUS_N}";
		jboxPost(url , null , function(obj){
			if(obj=="${GlobalConstant.DELETE_SUCCESSED}"){
				search();
			}
	});
	});
} 
	function toPage(page) {
		if(page){
			$("#currentPage").val(page);			
		}
		search();
	}
</script>
</head>
<body>

 <div class="mainright" id="mainright">
    <div class="content">
	  <form id="searchForm" action="<s:url value='/fstu/dec/fstuStudy/${roleFlag}'/>" method="post">
	   <div class="title1 clearfix">
	   <input id="currentPage" type="hidden" name="currentPage" value=""/>
			<table class="basic" style="width: 100%;">
				<tr>
					<td>
					姓名：
					<input type="text" class="" onchange="search();" name="userName" value="${param.userName}"/>&#12288;
					单位名称： <input type="text" name="OrgName" onchange="search();" value="${param.OrgName}" class=""/>&#12288;
<!-- 					身份证号码： -->
<%-- 					<input type="text" name="projName" value="${param.projName}" class="xltext"  /> --%>
					<input id="currentPage" type="hidden" name="currentPage" value=""/>
					<c:if test="${roleFlag==GlobalConstant.USER_LIST_LOCAL }">
					<input type="button" class="search" onclick="edit('');" value="新&#12288;增">
					</c:if>
					</td>
				</tr>
			</table>				
		</div>
  <table class="xllist">
  	<thead>
         <tr>
        	 <th width="10%">姓名</th>
            <th width="15%">单位</th>
            <th width="10%">性别</th>
            <th width="10%">出生年月</th>
            <th width="10%">科室</th>
             <th width="10%">职务</th>
            <th width="10%">职称</th>
            <th width="12%">进修单位</th>
            <th width="10%">进修科目</th>
            <th width="10%">开始时间</th>
            <th width="10%">结束时间</th>
            <th width="10%">进修月份</th>
            <th width="10%">操作</th>
         </tr>
     </thead>
     <tbody>
	   <c:forEach items="${studyList}"  var="study">
	     	<tr>
	     		<td>${sysUserMap[study.userFlow].userName}</td>
	     		<td>${sysUserMap[study.userFlow].orgName}</td>
	     		<td>${sysUserMap[study.userFlow].sexName}</td>
	     		<td>${sysUserMap[study.userFlow].userBirthday}</td>
	     		<td>${sysUserMap[study.userFlow].deptName}</td>
	     		<td>${sysUserMap[study.userFlow].postName}</td>
	     		<td>${sysUserMap[study.userFlow].titleName}</td>
	     		<td>${study.studyOrgName}</td>
	     		<td>${study.studySubject}</td>
	     		<td>${study.startDate }</td>
	     		<td>${study.endDate }</td>
	     		<td>${study.studyMonth}</td>
			   	<td>
			   	<c:if test="${roleFlag==GlobalConstant.USER_LIST_LOCAL }">
			   	<c:if test="${empty study.auditStatusId || study.auditStatusId==achStatusEnumRollBack.id}">
				   	<a style="cursor:pointer; color: blue;" onclick="edit('${study.studyFlow}')">编辑</a> |
				   	<a style="cursor:pointer; color: blue;" onclick="del('${study.studyFlow}')">删除</a>
				</c:if>
				<c:if test="${study.auditStatusId==achStatusEnumFirstAudit.id || study.auditStatusId==achStatusEnumSubmit.id}">
					
						<a style="cursor:pointer;  color: blue;" onclick="edit('${study.studyFlow}')">查看</a> 
					</c:if>
			   	</c:if>
				<c:if test="${roleFlag==GlobalConstant.USER_LIST_CHARGE }">
					<c:if test="${study.auditStatusId!=achStatusEnumFirstAudit.id}">
				   		<a style="cursor:pointer; color: blue; " onclick="edit('${study.studyFlow}')">审核</a>
				   	</c:if>
					<c:if test="${study.auditStatusId==achStatusEnumFirstAudit.id}">
							<a style="cursor:pointer;  color: blue;" onclick="edit('${study.studyFlow}')">查看</a> 
					</c:if>
				</c:if>
			   	</td>
	       </tr>
	    </c:forEach>
	    <c:if test="${empty studyList}">
	    	<tr><td colspan="99">无记录</td></tr>
	    </c:if>
	   </tbody>
  </table>
				<div>
				   	<c:set var="pageView" value="${pdfn:getPageView(studyList)}" scope="request"/>
					<pd:pagination toPage="toPage"/>
				</div>
	  </form>
  </div>
</div> 	

</body>
</html>