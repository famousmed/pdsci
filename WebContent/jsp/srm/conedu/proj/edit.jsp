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
				<table width="800" cellpadding="0" cellspacing="0" class="basic">
					<tr>
						<th width="20%">年份：</th>
						<td width="30%"><input type="text"  class="xltext ctime" name="projYear" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})" /></td>
						<th width="20%">项目级别：</th>
						<td width="30%">
							<select name="orgTypeId" class="xlselect">
								<option value=""></option>
								<option value="">国家级继续医学教育项目</option>
								<option value="">国家级继续医学教育项目（备案项目）</option>
							</select>
						</td>
					</tr>
					<tr style="display:${showJglx}">
						<th>项目名称：</th>
						<td >
							<input class="validate[required] xltext" name="orgName" type="text" value="${sysOrg.orgName }"/>
						</td>
						<th>所属学科：</th>
						<td colspan="3">
							<input class="validate[required] xltext" name="orgName" type="text" value="${sysOrg.orgName }"/>
						</td>
					</tr>
					<tr style="display:${showZgbm}">
						<th>主办单位：</th>
						<td >
							<input class="validate[required] xltext" name="orgName" type="text" value="${sysOrg.orgName }"/>
						</td>
						<th>项目负责人：</th>
						<td >
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
						<th>电话：</th>
						<td >
							 <input type="text" name="ordinal" value="${sysOrg.ordinal}" class="validate[maxSize[5] , custom[integer]] xltext"/>
						</td>
						<th>起止时间：</th>
						<td >
							 <input type="text" name="ordinal" value="${sysOrg.ordinal}" class="validate[maxSize[5] , custom[integer]] xltext"/>
						</td>
					</tr>
					<tr>
						<th>举办地点：</th>
						<td >
						    <input type="text" name="ordinal" value="${sysOrg.ordinal}" class="validate[maxSize[5] , custom[integer]] xltext"/>
						</td>
						<th>申请学分：</th>
						<td >
						    <input type="text" name="ordinal" value="${sysOrg.ordinal}" class="validate[maxSize[5] , custom[integer]] xltext"/>
						</td>
					</tr>	
					<tr>
						<th>教学对象：</th>
						<td >
						    <input type="text" name="ordinal" value="${sysOrg.ordinal}" class="validate[maxSize[5] , custom[integer]] xltext"/>
						</td>
						<th>拟招生人数：</th>
						<td >
						    <input type="text" name="ordinal" value="${sysOrg.ordinal}" class="validate[maxSize[5] , custom[integer]] xltext"/>
						</td>
					</tr>	
					<tr>
						<th>申报表：</th>
						<td >
						    <a href="#">[上传]</a>
						</td>
						<th>申报结果：</th>
						<td >
						    <select class="xlselect" ><option></option><option>通过</option><option>不通过</option></select>
						</td>
					</tr>	
					<tr>
						<th>项目编号：</th>
						<td >
						    <input type="text" name="ordinal" value="${sysOrg.ordinal}" class="validate[maxSize[5] , custom[integer]] xltext"/>
						</td>
						<th>备注：</th>
						<td >
						    <input type="text" name="ordinal" value="${sysOrg.ordinal}" class="validate[maxSize[5] , custom[integer]] xltext"/>
						</td>
					</tr>	
				</table>
				<div class="button" style="width: 800px;">
					<input class="search" type="button" value="保&#12288;存" onclick="saveOrg();" />
				</div>
			</div>
</div>
</form>
</body>
</html>