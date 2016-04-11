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
	function search(){
		$("#searchForm").submit();	
	}
	function toPage(page){
		var form = $("#searchForm");
		$("#currentPage").val(page);
		form.submit();
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
	<form id="searchForm" action="<s:url value="/gcp/proj/clinicalTestList" />" method="post">
	<div class="title1 clearfix">
		<div style="margin-bottom: 10px">
			&#12288;阶段：
            <c:forEach var="stageEnum" items="${gcpProjStageEnumList}">
            	<c:if test="${stageEnum.id != gcpProjStageEnumTerminate.id}">
          		<input type="checkbox" name="projStageId" value="${stageEnum.id}" id="projStageId_${stageEnum.id}"
						<c:forEach items="${paramValues.projStageId}" var="cId">
							<c:if test="${cId eq stageEnum.id}">checked="checked"</c:if>
						</c:forEach>
          		 /><label for="projStageId_${stageEnum.id}">${stageEnum.name}</label>&#12288;
          		 </c:if>
            </c:forEach>
        </div>
       <div>
			&#12288;类别：
			<c:forEach var="categroy" items="${projCategroyEnumList}">
				<c:if test="${categroy.id != projCategroyEnumXk.id and categroy.id != projCategroyEnumRc.id}">
				<input type="checkbox" name="projCategoryId" value="${categroy.id}" id="projCategoryId_${categroy.id}"
						<c:forEach items="${paramValues.projCategoryId}" var="cId">
							<c:if test="${cId eq categroy.id}">checked="checked"</c:if>
						</c:forEach>
				 /><label for="projCategoryId_${categroy.id}">${categroy.name}</label>&#12288;
				</c:if>
            </c:forEach>
            
            &#12288;期类别：
            <select name="projSubTypeId" class="xlselect" onchange="search()" style="width: 80px;">
            	<option value="">请选择</option>
                <c:forEach var="subType" items="${gcpProjSubTypeEnumList}">
               		<option value="${subType.id}" <c:if test="${param.projSubTypeId eq subType.id}">selected="selected"</c:if>>${subType.name}</option>
                </c:forEach>
            </select>
            
            &#12288;承担科室：
           <select name="applyDeptFlow" class="xlselect" style="width: 120px;" onchange="search()">
				<option value="">请选择</option>
				<c:forEach items="${sysDeptList}" var="dept">
					<option value="${dept.deptFlow}" <c:if test="${dept.deptFlow eq param.applyDeptFlow}">selected="selected"</c:if> >${dept.deptName}</option>
				</c:forEach>
			</select>
			<input type="button" class="search" onclick="search()" value="查&#12288;询">
			<input type="hidden" id="currentPage" name="currentPage">
		</div>
		</div>
		</form>
		
		<table class="xllist" > 
			<thead>
			<tr>
				<th width="5%">序号</th>
				<th width="25%">项目名称</th>
				<th width="7%">期类别</th>
				<th width="13%">项目来源简称</th>
				<th width="10%">注册分类</th>
				<th width="10%">CFDA批件号</th>
				<th width="10%">组长/参加</th>
				<th width="10%">承担科室</th>
				<th width="10%">主要研究者</th>
			</tr>
			</thead>
			<c:forEach items="${projList}" var="proj" varStatus="status">
			<tr>
				<td>${status.count}</td>
				<td>${proj.projName}</td>
				<td>${proj.projSubTypeName}</td>
				<td>${proj.projShortDeclarer}</td>
				<td>${projInfoFormMap[proj.projFlow].registCategory}</td>
				<td>${proj.cfdaNo}</td>
				<td>
					<c:if test="${projInfoFormMap[proj.projFlow].isLeader eq projOrgTypeEnumLeader.id}">${projOrgTypeEnumLeader.name }</c:if>
    				<c:if test="${projInfoFormMap[proj.projFlow].isLeader eq projOrgTypeEnumParti.id}">${projOrgTypeEnumParti.name }</c:if>
				</td>
				<td>${proj.applyDeptName}</td>
				<td>${proj.applyUserName}</td>
			</tr>
		   </c:forEach>
		</table>
		
		<p>
			<c:set var="pageView" value="${pdfn:getPageView2(projList,10)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>
		</p>
		</div>
	</div> 
</body>
</html>