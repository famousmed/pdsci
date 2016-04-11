<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script type="text/javascript">

	function searchProj() {
		jboxStartLoading();
		$("#searchForm").submit();
	}
	
	function toPage(page) {
		if(page!=undefined){
			$("#currentPage").val(page);			
		}
		searchProj();
	}

	//加载申请单位
	function loadApplyOrg(){
		//清空
		var org = $('#org');
		org.html('<option value="">请选择</option>');
		var chargeOrgFlow = $('#chargeOrg').val();
		if(!chargeOrgFlow){
			return ;
		}
		var url = "<s:url value='/sys/org/loadApplyOrg'/>?orgFlow="+chargeOrgFlow;
		jboxStartLoading();
		jboxGet(url , null , function(data){
			$.each(data , function(i , n){
				org.append('<option value="'+n.orgFlow+'">'+n.orgName+'</option>');
			});
		} , null , false);
	}
	
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<form id="searchForm" method="post" action="<s:url value="/srm/aid/proj/auditAidProjListOfXk/${sessionScope.projListScope}?projCategoryId=xk"/>">
			<div class="title1 clearfix">
			<p>
				<c:if test='${sessionScope.projListScope eq GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL}'>
				        主管部门：<select id="chargeOrg" name="chargeOrgFlow" onchange="loadApplyOrg();" class="xlselect">
            			<option value="">请选择</option>
            			<c:forEach var="chargeOrg" items="${childrenOrgList}">
            				<option value="${chargeOrg.orgFlow}" <c:if test="${param.chargeOrgFlow==chargeOrg.orgFlow}">selected</c:if>>${chargeOrg.orgName}</option>
            			</c:forEach>
            		</select>
            		申报单位：<select id="org" name="orgFlow" class="xlselect">
            			<option value="">请选择</option>
            			<c:forEach var="org" items="${orgList}">
            				<option value="${org.orgFlow}" <c:if test="${param.orgFlow==org.orgFlow}">selected</c:if>>${org.orgName}</option>
            			</c:forEach>
            		</select>
				</c:if>
				
		    	<c:if test='${sessionScope.projListScope eq GlobalConstant.PROJ_STATUS_SCOPE_CHARGE}'>
	           		申报单位：<select name="orgFlow" class="xlselect">
	           			<option value="">请选择</option>
	           			<c:forEach var="org" items="${childrenOrgList}">
	           				<option  value="${org.orgFlow}" <c:if test="${param.orgFlow==org.orgFlow}">selected</c:if>>${org.orgName}</option>
	           			</c:forEach>
	           		</select>
           	   </c:if>
					学科名称：<input type="text" name="projName" value="${param.projName}" class="xltext" style="width: 300px" />
					<input id="currentPage" type="hidden" name="currentPage"/>
					<input type="button" class="search" onclick="searchProj();" value="查&#12288;询">
			</p>
			</div>
		
		    
		    <table class="xllist">
			<thead>
				<tr>
					<th width="5%">年份</th>
					<th width="30%">学科名称</th>
					<th width="20%">学科分类</th>
					<th width="20%">学科类型</th>
					<th width="13%">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${aidProjList}" var="aidProj">
					<tr>
						<td>${aidProj.projYear}</td>
						<td>${aidProj.projName}</td>
						<td>${aidProj.projCategoryName}</td>
						<td>${aidProj.projTypeName}</td>
						<td>
							<a href="<s:url value='/srm/aid/proj/view?projFlow=${aidProj.projFlow}&typeId=${aidProj.projSubCategoryId}'/>">[查看]</a>
						</td>
					</tr>
				</c:forEach>
				
			<c:if test="${empty aidProjList}">
				<tr>
					<td colspan="10">无记录</td>
				</tr>
			</c:if>
			</tbody>
		</table>
		<c:set var="pageView" value="${pdfn:getPageView(aidProjList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>
		</form>
		
	</div>
</div>
</body>
</html>