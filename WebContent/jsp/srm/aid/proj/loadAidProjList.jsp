<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="mainright">
<div class="content">
	<table class="xllist" style="width: 100%; margin-top: 20px;">
		<thead>
			<tr>
				<th width="5%" rowspan="2">年份</th>
				<th width="10%" rowspan="2">项目编号</th>
				<th width="15%" rowspan="2">项目名称</th>
				<th width="10%" rowspan="2">项目分类</th>
				<th width="20%" rowspan="2">项目类型</th>
				<th width="20%" rowspan="2">起止时间</th>
				<th width="10%" rowspan="2">项目负责人</th>
				<th width="10%" rowspan="2">操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${aidProjList}" var="aidProj">
				<tr>
					<td><span>${aidProj.projYear }</span></td>
					<td>${aidProj.projNo }</td>
					<td>${aidProj.projName}</td>
					<td>${aidProj.projCategoryName}</td>
					<td>${aidProj.projTypeName}</td>
					<td>&#12288;${aidProj.projStartTime}~${aidProj.projEndTime}</td>
					<td>${aidProj.applyUserName }</td>
					<td>
					  	<a href="<s:url value='/srm/aid/proj/view?projFlow=${aidProj.projFlow}&typeId=${aidProj.projSubCategoryId}'/>">[查看]</a>
					  	<c:if test="${param.projSubCategoryId eq sysCfgMap['srm_aid_needAudit_category'] and aidProjStatusEnumPass.id != aidProj.statusId and sessionScope.projListScope eq GlobalConstant.USER_LIST_LOCAL}">
					  		<a href="javascript:void(0)" onclick="audit('${aidProj.projFlow}');">[审核]</a>
					  	</c:if>
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
</div>
</div>
