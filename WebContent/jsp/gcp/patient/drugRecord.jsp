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
	<jsp:param name="jquery_fixedtable" value="true"/>
</jsp:include>
</head>
	<body>
			<div class="mainright">
	<div class="content">	
		<div class="title1 clearfix">
		<div>受试者编号：${patient.patientCode}&#12288; 受试者姓名缩写：${patient.patientNamePy}</div>
		<div style="margin-top: 5px;">
			<table class="xllist">
				<colgroup>
					<col width="3%"></col>
					<col width="12%"></col>
					<col width="18%"></col>
					<col width="8%"></col>
					<col width="12%"></col>
					<col width="7%"></col>
					<col width="8%"></col>
					<col width="7%"></col>
				</colgroup>
				<thead>
				<tr>
					<th>序号</th>
					<th>发药时间</th>
					<th>药物名称</th>
					<th>药物编号</th>
					<th>处方时间</th>
					<th>处方医生</th>
					<th>处方状态</th>
					<th>发药人</th>
				</tr>
				</thead>
				<tbody>
					<c:forEach items="${patientRecipeList}" var="recipe" varStatus="seq">
						<c:set value="${patientRecipeDrugMap[recipe.recipeFlow].size()}" var="rowspan"/>
						<c:forEach items="${patientRecipeDrugMap[recipe.recipeFlow]}" var="recipeDrug" varStatus="status">
							<tr>
								<c:if test="${status.first}">
									<td rowspan="${rowspan}">${seq.index+1}</td>
									<td rowspan="${rowspan}">${pdfn:transDateTime(recipe.sendDate)}</td>
								</c:if>
								<td>${recipeDrug.drugName}</td>
								<c:if test="${status.first}">
									<td rowspan="${rowspan}">${recipeDrug.drugPack}</td>
									<td rowspan="${rowspan}">${pdfn:transDateTime(recipe.recipeDate)}</td>
									<td rowspan="${rowspan}">${recipe.recipeDoctorName}</td>
									<td rowspan="${rowspan}">${recipe.recipeStatusName}</td>
									<td rowspan="${rowspan}">${recipe.sendUserName}</td>
								</c:if>
							</tr>
						</c:forEach>
					</c:forEach>
				</tbody>
				<c:if test="${empty patientRecipeList}">
					<tr><td align="center" colspan="8">无记录</td></tr>
				</c:if>
			</table>
			</div>
			<div style="text-align: center;margin-top: 10px;"><input type="button" class="search" value="关&#12288;闭" onclick="jboxClose();"/></div>
		</div></div></div>
</body>
</html>