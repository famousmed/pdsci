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
	<jsp:param name="jquery_validation" value="false"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<c:set value="0" var="regTypeNum"/>
<c:forEach items="${registryTypeEnumList}" var="registryType">
	<c:set value="res_registry_type_${registryType.id}" var="viewCfgKey"/>
	<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y && GlobalConstant.FLAG_Y eq registryType.haveReq}">
		<c:set value="${regTypeNum+1}" var="regTypeNum"/>
	</c:if>
</c:forEach>
<c:set value="false" var="noRegTypeCfg"/>
<c:if test="${regTypeNum==0}">
	<c:set value="1" var="regTypeNum"/>
	<c:set value="true" var="noRegTypeCfg"/>
</c:if>

<style type="text/css">
	table.basic td,table.basic th{padding: 0;text-align: center;}
	caption{line-height:40px;text-align:left;font-weight:bold; padding-left:10px; border-bottom:1px solid #ddd;color:#f60;}
</style>
<c:set value="schUnitEnum${sysCfgMap['res_rotation_unit']}" var="unitKey"/>
<script type="text/javascript">
	$(function(){
		<c:forEach items="${schStageEnumList}" var="stage">
			$("#${stage.id}").append($(".sort${stage.id}"));
		</c:forEach>
	});
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<table class="basic" style="width: 100%;margin-top: 10px;">
			<tr>
				<c:if test="${rotation.isStage eq GlobalConstant.FLAG_Y}">
					<th width="10%" rowspan="2">轮转阶段</th>
				</c:if>
				<th width="10%" rowspan="2">标准科室</th>
				<th width="15%" rowspan="2">轮转时间</th>
				<th width="50%" colspan="${regTypeNum}">轮转要求</th>
				<th width="15%" rowspan="2">备注</th>
			</tr>
			<tr>
				<c:forEach items="${registryTypeEnumList}" var="registryType">
					<c:set value="res_registry_type_${registryType.id}" var="viewCfgKey"/>
					<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y && GlobalConstant.FLAG_Y eq registryType.haveReq}">
						<th width="${50/regTypeNum}%">${registryType.name}</th>
					</c:if>
				</c:forEach>
			</tr>
<!-- 			<tr> -->
<!-- 				<th colspan="99" style="text-align: left;padding-left: 10px;">必轮科室</th> -->
<!-- 			</tr> -->
<%-- 			<c:forEach items="${mustRotationDeptList}" var="rotationDept"> --%>
<!-- 				<tr> -->
<%-- 					<td>${rotationDept.standardDeptName}</td> --%>
<!-- 					<td> -->
<%-- 						${rotationDept.schMonth}${applicationScope[unitKey].name} --%>
<!-- 					</td> -->
<%-- 					<c:forEach items="${registryTypeEnumList}" var="registryType"> --%>
<%-- 						<c:set value="res_registry_type_${registryType.id}" var="viewCfgKey"/> --%>
<%-- 						<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y && GlobalConstant.FLAG_Y eq registryType.haveReq}"> --%>
<!-- 							<td> -->
<%-- 								<c:set var="key" value="${rotationDept.recordFlow}${registryType.id}"/> --%>
<%-- 								<c:forEach items="${reqMap[key]}" var="req"> --%>
<%-- 									${req.itemName}${!empty req.itemName?'：':''}${req.reqNum}例<br/> --%>
<%-- 								</c:forEach> --%>
<!-- 							</td> -->
<%-- 						</c:if> --%>
<%-- 					</c:forEach> --%>
<%-- 					<c:if test="${noRegTypeCfg}"> --%>
<!-- 						<td></td> -->
<%-- 					</c:if> --%>
<%-- 					<td>${rotationDept.deptNote}</td> --%>
<!-- 				</tr> -->
<%-- 			</c:forEach> --%>
			<c:forEach items="${groupList}" var="group">
				<tr class="sort${group.schStageId}">
					<th colspan="99" style="text-align: left;padding-left: 10px;">${group.groupName}</th>
				</tr>
				<c:forEach items="${groupRotationDeptListMap[group.groupFlow]}" var="rotationDept">
					<tr class="sort${group.schStageId}">
						<c:if test="${rotation.isStage eq GlobalConstant.FLAG_Y}">
							<td>${group.schStageName}</td>
						</c:if>
						<td>${rotationDept.standardDeptName}</td>
						<td>
							${rotationDept.schMonth}${applicationScope[unitKey].name}
						</td>
						<c:forEach items="${registryTypeEnumList}" var="registryType">
							<c:set value="res_registry_type_${registryType.id}" var="viewCfgKey"/>
							<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y && GlobalConstant.FLAG_Y eq registryType.haveReq}">
								<td>
									<c:set var="key" value="${rotationDept.recordFlow}${registryType.id}"/>
									<c:forEach items="${reqMap[key]}" var="req">
										${req.itemName}${!empty req.itemName?'：':''}${req.reqNum}例<br/>
									</c:forEach>
								</td>
							</c:if>
						</c:forEach>
						<c:if test="${noRegTypeCfg}">
							<td></td>
						</c:if>
						<td>${rotationDept.deptNote}</td>
					</tr>
				</c:forEach>
			</c:forEach>
			
			<c:forEach items="${schStageEnumList}" var="stage">
				<tbody id="${stage.id}">
				</tbody>
			</c:forEach>
		</table>
	</div>
</div>
</body>
</html>