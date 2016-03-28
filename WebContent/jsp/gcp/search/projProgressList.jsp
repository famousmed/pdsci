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
	<jsp:param name="jquery_scrollTo" value="true"/>
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
</script>
</head>
<body>
<div class="mainright">
	<div class="content" style="padding-top: 10px;">
		
		    <form id="searchForm" action="<s:url value='/gcp/projProgressList?searchFlag=${GlobalConstant.FLAG_Y}'/>" method="post">
		    <dl>   
		      <dt style="float: left;margin-left: 10px;">项目名称：</dt>
		      <dt style="float: left;margin-left: 5px;"><input type="text" name="projName" value="${param.projName }" class="xltext"/></dt>
		      <dt style="float: left;margin-left: 10px;">项目类别：</dt>
		      <dt style="float: left;margin-left: 5px;">
				<select name="projCategoryId" onchange="search()" class="xlselect" style="width: 120px;">
					<option value="">全部</option>
					<option value="${projCategroyEnumYw.id }" <c:if test="${param.projCategoryId==projCategroyEnumYw.id}">selected="selected"</c:if> >${projCategroyEnumYw.name}</option>
					<option value="${projCategroyEnumKy.id }" <c:if test="${param.projCategoryId==projCategroyEnumKy.id}">selected="selected"</c:if> >${projCategroyEnumKy.name}</option>
					<option value="${projCategroyEnumQx.id }" <c:if test="${param.projCategoryId==projCategroyEnumQx.id}">selected="selected"</c:if> >${projCategroyEnumQx.name}</option>
				</select>
		      </dt>
		      <dt>
		         <input type="button" onclick="search();" value="查&#12288;询" class="search">
		      </dt>
		    </dl>
		    </form>
		    <table class="xllist" style="width:100%; margin-top: 10px;">
			<thead>
				<tr>
					<th width="5%">序号</th>
					<th width="25%">项目名称</th>
					<th width="10%">期类别</th>
					<th width="12%">项目来源</th>
					<th width="9%">启动会议日期</th>
					<th width="9%">合同总例数</th>
					<th width="9%">入组/完成</th>
					<th width="9%">脱落</th>
					<th width="9%">SAE例数</th>
				</tr>
			</thead>
			<tbody id="fundTb">
			<c:if test="${empty projList and param.searchFlag eq GlobalConstant.FLAG_Y}">
			<tr>
				<td colspan="9">无记录！</td>
			</tr>
			</c:if>
			<c:forEach items="${projList}" var="proj" varStatus="status">
			<tr>
				<td width="5%">${status.count}</td>
				<td width="25%">${proj.projName}</td>
				<td width="10%">${proj.projSubTypeName}</td>
				<td width="12%">${proj.projDeclarer}</td>
				<td width="9%">${startMeetingDateMap[proj.projFlow]}</td>
				<td width="9%">
					<c:if test="${empty contractCaseNumMap[proj.projFlow]}">0</c:if>
					${contractCaseNumMap[proj.projFlow]}
				</td>
				<td width="9%">
					<c:if test="${empty stageMap[proj.projFlow][patientStageEnumIn.id]}">0</c:if>${stageMap[proj.projFlow][patientStageEnumIn.id]}/<c:if test="${empty stageMap[proj.projFlow][patientStageEnumFinish.id]}">0</c:if>${stageMap[proj.projFlow][patientStageEnumFinish.id]}
				</td>
				<td width="9%">
					<c:if test="${empty stageMap[proj.projFlow][patientStageEnumOff.id]}">0</c:if>${stageMap[proj.projFlow][patientStageEnumOff.id]}
				</td>
				<td width="9%">
					<c:if test="${empty saeMap[proj.projFlow]}">0</c:if>${saeMap[proj.projFlow]}
				</td>
			</tr>
			</c:forEach>	       
			</tbody>
			</table>
	</div> 
</div>
</body>
</html>