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
</head>
<body>
	<div>
			<table class="xllist"> 
				<thead>
				<tr>
					<th width="80px">机构名称</th>
					<th width="50px">受试者编号</th>
					<th width="100px">访视名称</th>
					<th width="80px">模块名称</th>
					<th width="80px">元素名称</th>
					<th width="50px">录入序号</th>
					<th width="100px">属性名称</th>
					<th width="50px">录入值</th>
					<th width="120px">描述</th>
				</tr>
				</thead>
				<tbody>
					<c:forEach items="${ dataList}" var="data">
						<tr>
							<td width="80px">${applicationScope.sysOrgMap[patientMap[data.patientFlow].orgFlow].orgName }</td>
							<td width="50px">${patientMap[data.patientFlow].patientCode }</td>
							<td width="100px">${sessionScope.projDescForm.visitMap[data.visitFlow].visitName }</td>
							<td width="80px">${sessionScope.projDescForm.moduleMap[data.moduleCode].moduleName }</td>
							<td width="80px">${sessionScope.projDescForm.elementMap[data.elementCode].elementName }</td>
							<td width="50px">${data.elementSerialSeq }</td>
							<td width="100px">${sessionScope.projDescForm.attrMap[data.attrCode].attrName }</td>
							<td width="50px">${data.attrValue }</td>
							<td width="120px">${data.attrValueTip }</td>
						</tr>
					</c:forEach>
				</tbody>
				<c:if test="${dataList == null || dataList.size()==0 }"> 
					<tr> 
						<td align="center" colspan="9">无记录</td>
					</tr>
				</c:if>
			</table>
   </div>
</body>
</html>