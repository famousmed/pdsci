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
	<jsp:param name="jquery_cxselect" value="true"/>
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
	function saveOrg() {
		if(false==$("#sysOrgForm").validationEngine("validate")){
			return ;
		}
		var orgProvNameText = $("#orgProvId option:selected").text();
		if(orgProvNameText=="选择省"){
			orgProvNameText = "";
		}
		var orgCityNameText = $("#orgCityId option:selected").text();
		if(orgCityNameText=="选择市"){
			orgCityNameText = "";
		}
		var orgAreaNameText = $("#orgAreaId option:selected").text();
		if(orgAreaNameText=="选择地区"){
			orgAreaNameText = "";
		}
		$("#orgProvName").val(orgProvNameText);
		$("#orgCityName").val(orgCityNameText);
		$("#orgAreaName").val(orgAreaNameText);
		var url = "<s:url value='/sys/org/save'/>";
		var data = $('#sysOrgForm').serialize();
		jboxPost(url, data, function() {
			window.parent.frames['mainIframe'].window.search();
			jboxClose();
		});
	}
</script>
</head>
<body>
<form id="sysOrgForm" style="height: 100px;" >
<input name="orgFlow" value="${param.orgFlow}" type="hidden"/>
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">
				<table width="800" cellpadding="0" cellspacing="0" class="basic">
					<tr>
						<th width="20%">机构代码：</th>
						<td width="30%"><input class="xltext" name="orgCode" type="text" value="${sysOrg.orgCode }"/></td>
						<th width="20%">机构名称：</th>
						<td width="30%"><input class="validate[required] xltext" name="orgName" type="text" value="${sysOrg.orgName }"/></td>
					</tr>
					<%-- 是否显示机构类型 --%>
<%-- 					<c:set var="showJglx" value="hidden" scope="page"></c:set> --%>
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${sessionScope.currWsId=='edc'}"> --%>
<%-- 							<c:set var="showJglx" value="" scope="page"></c:set> --%>
<%-- 						</c:when> --%>
<%-- 						<c:when test="${sessionScope.currWsId=='edu'}"> --%>
<%-- 							<c:set var="showJglx" value="" scope="page"></c:set> --%>
<%-- 						</c:when> --%>
<%-- 						<c:otherwise> --%>
<%-- 							<c:set var="showJglx" value="none" scope="page"></c:set> --%>
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
						<c:set value="${sessionScope.currWsId eq GlobalConstant.EDC_WS_ID || sessionScope.currWsId eq GlobalConstant.EDU_WS_ID || sessionScope.currWsId eq GlobalConstant.RES_WS_ID || sessionScope.currWsId eq GlobalConstant.NJMUEDU_WS_ID}" var="showType"/>
						<tr>
							<c:if test="${showType}">
								<th>机构类型：</th>
								<td id="typeTd">
									<script type="text/javascript">
										function selLevel(typeId){
											var condition = typeId=="${orgTypeEnumHospital.id}" && "${sessionScope.currWsId eq GlobalConstant.RES_WS_ID}"=="true";
											$(".level").toggle(condition);
											$("#typeTd").attr("colspan",condition?"1":"3");
											$("[name='orgLevelId']").attr("disabled",!condition);
										}
										<c:if test="${sessionScope.currWsId eq GlobalConstant.RES_WS_ID}">
											$(function(){
												$("[name='orgTypeId']").change();
											});
										</c:if>
									</script>
									<select name="orgTypeId" class="xlselect" <c:if test="${sessionScope.currWsId eq GlobalConstant.RES_WS_ID}">onchange="selLevel(this.value);"</c:if>>
										<option value="">请选择</option>
										<c:forEach var="orgType" items="${orgTypeEnumList}">
											<c:if test="${!(orgType.id eq orgTypeEnumDeclare.id || orgType.id eq orgTypeEnumCRO.id)}">
												<option value="${orgType.id}" <c:if test="${sysOrg.orgTypeId==orgType.id}">selected="selected"</c:if>>${orgType.name}</option>
											</c:if>
										</c:forEach>
									</select>
								</td>
							</c:if>
							<c:if test="${!(sessionScope.currWsId eq GlobalConstant.RES_WS_ID)}">
								<th>机构电话：</th>
								<td <c:if test="${!showType}">colspan="3"</c:if>><input class="validate[custom[phone]] xltext" name="orgPhone" type="text" value="${sysOrg.orgPhone}"/></td>
							</c:if>
							<c:if test="${sessionScope.currWsId eq GlobalConstant.RES_WS_ID}">
								<th class="level">机构等级：</th>
								<td class="level">
									<select name="orgLevelId" class="xlselect">
										<option/>
										<c:forEach items="${orgLevelEnumList}" var="level">
											<option value="${level.id}" <c:if test="${level.id eq sysOrg.orgLevelId}">selected</c:if>>${level.name}</option>
										</c:forEach>
									</select>
								</td>
							</c:if>
						</tr>
						<c:if test="${sessionScope.currWsId eq GlobalConstant.RES_WS_ID}">
							<tr>
								<th>机构电话：</th>
								<td colspan="3"><input class="validate[custom[phone]] xltext" name="orgPhone" type="text" value="${sysOrg.orgPhone}"/></td>
							</tr>
						</c:if>
					<%-- 是否显示主管部门 --%>
					<c:set var="showZgbm" value="none" scope="page"></c:set>
					<c:choose>
						<c:when test="${sessionScope.currWsId=='srm' and applicationScope.sysCfgMap['srm_for_use']=='global'}">
							<c:set var="showZgbm" value="" scope="page"></c:set>
						</c:when>
						<c:otherwise>
							<c:set var="showZgbm" value="none" scope="page"></c:set>
						</c:otherwise>
					</c:choose>
					<tr style="display:${showZgbm}">
						<th>主管部门：</th>
						<td colspan="3">
							<select class="xlselect" name="chargeOrgFlow">
								<option value="">请选择</option>
								<c:forEach var="chargeOrg" items="${applicationScope.sysOrgList}">
								<c:if test="${not pdfn:contain(chargeOrg.orgFlow,childOrgFlowList)}">
									<c:if test="${sysorg.orgFlow!=chargeOrg.orgFlow}">
									<option value="${chargeOrg.orgFlow}" <c:if test="${chargeOrg.orgFlow==sysOrg.chargeOrgFlow }">selected</c:if>>${chargeOrg.orgName}</option>
								</c:if>
								</c:if>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>所属地区：</th>
						<td colspan="3">
							<c:if test="${empty param.orgFlow}">
								<div id="provCityAreaId">
									<select id="orgProvId" name="orgProvId" class="province xlselect" data-value="${sessionScope.currWsId == GlobalConstant.EDC_WS_ID?'':applicationScope.sysCfgMap['srm_default_orgProvId']}" data-first-title="选择省"></select>
									<select id="orgCityId" name="orgCityId" class="city xlselect" data-value="${sessionScope.currWsId == GlobalConstant.EDC_WS_ID?'':applicationScope.sysCfgMap['srm_default_orgCityId']}" data-first-title="选择市"></select>
									<select id="orgAreaId" name="orgAreaId" class="area xlselect" data-value="" data-first-title="选择地区"></select>
								</div>
							</c:if>
							<c:if test="${not empty param.orgFlow}">
								<div id="provCityAreaId">
									<select id="orgProvId" name="orgProvId" class="province xlselect" data-value="${sysOrg.orgProvId}" data-first-title="选择省"></select>
									<select id="orgCityId" name="orgCityId" class="city xlselect" data-value="${sysOrg.orgCityId}" data-first-title="选择市"></select>
									<select id="orgAreaId" name="orgAreaId" class="area xlselect" data-value="${sysOrg.orgAreaId}" data-first-title="选择地区"></select>
								</div>
							</c:if>
							<input id="orgProvName" name="orgProvName" type="hidden" value="${sysOrg.orgProvName}">
							<input id="orgCityName" name="orgCityName" type="hidden" value="${sysOrg.orgCityName}">
							<input id="orgAreaName" name="orgAreaName" type="hidden" value="${sysOrg.orgAreaName}">
							<script type="text/javascript">
								// 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件 
								$.cxSelect.defaults.url = "<s:url value='/js/provCityAreaJson.min.json'/>"; 
								$.cxSelect.defaults.nodata = "none"; 
	
								$("#provCityAreaId").cxSelect({ 
								    selects : ["province", "city", "area"], 
								    nodata : "none",
									firstValue : ""
								}); 
							</script>
						</td>
					</tr>
					<tr>
						<th>机构地址：</th>
						<td colspan="3"><input style="width: 560px;" class="xltext" name="orgAddress" type="text" value="${sysOrg.orgAddress}"/></td>
					</tr>
					<tr>
						<th>排序码：</th>
						<td colspan="3">
						    <input type="text" name="ordinal" value="${sysOrg.ordinal}" class="validate[maxSize[5] , custom[integer]] xltext"/>
						</td>
					</tr>	
				</table>
				<div class="button" style="width: 800px;">
					<input class="search" type="button" value="保&#12288;存" onclick="saveOrg();" />
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>