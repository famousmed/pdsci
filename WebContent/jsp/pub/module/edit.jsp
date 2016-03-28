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
	function saveModule() {
		if(false==$("#form").validationEngine("validate")){
			return ;
		}
		jboxPost("<s:url value='/pub/module/saveModule'/>", $('#form').serialize(), function() {
			if ('add'=='${type}') {
				window.parent.frames['mainIframe'].window.showModule('${param.moduleTypeId}');
			} else {
				window.parent.frames['mainIframe'].window.location.href="<s:url value='/pub/module/show'/>?moduleCode=${pubModule.moduleCode}";
			}
			jboxClose();
		});
	}
	
</script>
</head>

<body>
<div style="margin-top: 25px;" >
<form id="form" style="padding-left: 40px;height: 100px;" >
	<table class="mation" style="width: 400px">
		<tr style="height:26px">
			<td style="text-align: right" width="100px">名&#12288;&#12288;称：</td>
			<td >
			<input name="moduleFlow" type="hidden" value="${pubModule.moduleFlow}"/>
				<input  name="moduleName" class="validate[required] text"   value="${pubModule.moduleName}"/>
			</td>
		</tr>
		<tr>
			<td style="text-align: right" width="100px">缩&#12288;&#12288;写：</td>
			<td >
				<input   type="text" name="moduleShortName" class="validate[required] text" value="${pubModule.moduleShortName}"/>
			</td>
		</tr>
		<tr>
			<td style="text-align: right" width="100px">序&#12288;&#12288;号：</td>
			<td >
				<input   type="text" class="text validate[custom[number]]" name="ordinal" value="${pubModule.ordinal}"/>
			</td>
		</tr>
		<tr>
			<td style="text-align: right" width="100px">模块类型：</td>
			<td >
				<select id="moduleTypeId" name="moduleTypeId" class="text">
	     			<c:forEach var="dict" items="${dictTypeEnumModuleTypeList}">
	     				<option value="${dict.dictId }" <c:if test="${param.moduleTypeId== dict.dictId }">selected</c:if>>${dict.dictName }(${dict.dictId })</option>
	     			</c:forEach>
     			</select>
			</td>
		</tr>
		<tr>
			<td style="text-align: right" width="100px">展示类型：</td>
			<td >
				<select id="moduleStyleId" name="moduleStyleId" class="text">
	     			<c:forEach var="moduleStyle" items="${moduleStyleEnumList}">
	     				<option value="${moduleStyle.id }" <c:if test="${pubModule.moduleStyleId== moduleStyle.id }">selected</c:if>>${moduleStyle.name }</option>
	     			</c:forEach>
     			</select>
			</td>
		</tr>
	</table>
	<div align="center">
		<input type="button" class="search" value="保&#12288;存" onclick="saveModule();"/>
		<input type="button" class="search" onclick="jboxClose();" value="关&#12288;闭">
	</div>
</form>
</div>
</body>
</html>