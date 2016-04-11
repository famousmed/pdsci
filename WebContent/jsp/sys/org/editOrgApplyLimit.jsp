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
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
	function saveApplyLimit(){
		if(false==$("#applyLimitForm").validationEngine("validate")){
			return false;
		}
		var cellIndex = 2;
		var datas = [];
		$("#applyLimitTable tr:eq(0) th:not(:first)").each(function(){
			var projTypeName = $(this).text().trim();
			var $td = $("#applyLimitTable tr:eq(1) td:nth-child("+cellIndex+")");
			var projTypeId = $td.children("input[name='projTypeId']").val();
			var limitNum = $td.children("input[name='limitNum']").val();
			var limitFlow = $td.children("input[name='limitFlow']").val();
			//alert(projTypeId + "、"+ projTypeName +"、" + limitNum);
			var data={
				"orgFlow" : "${sysOrg.orgFlow}",
				"orgName" : "${sysOrg.orgName}",
				"projCategroyId" : "${projCategroyEnumKy.id}",
				"projCategroyName" : "${projCategroyEnumKy.name}",
				"projTypeId" : projTypeId,
				"projTypeName" : projTypeName,
				"limitNum" : limitNum,
				"limitFlow" : limitFlow
			};
			datas.push(data);
			cellIndex++;
		});
		var requestData = {"applyLimitList":datas};
		$("#saveBtn").attr("disabled",true);
		var url = "<s:url value='/sys/org/saveOrgApplyLimitList'/>";
		jboxPostJson(
				url,
				JSON.stringify(requestData),
				function(resp){
					if("${GlobalConstant.SAVE_SUCCESSED}"==resp){
						window.parent.frames['mainIframe'].window.search();
						jboxClose();
					}
				}, null, true); 
	}
</script>
</head>
<body>
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">
				机构名称：${sysOrg.orgName}
				<form id="applyLimitForm" style="height: 100px;" >
				<table id="applyLimitTable" width="100%" cellpadding="0" cellspacing="0" class="basic" style="margin-top: 10px;">
					<tr>
						<th></th>
                       	<c:forEach var="projType" items="${dictTypeEnumProjTypeList}">
                       		<th style="text-align: center;">${projType.dictName}</th>
                       	</c:forEach>
					</tr>				
					<tr>
						<td style="text-align: center;width: 100px;">科研项目</td>
						<c:forEach var="projType" items="${dictTypeEnumProjTypeList}">
                       		<td style="text-align: center;">
                       			<input type="hidden" name="projTypeId" value="${projType.dictId}"/>
                       			<input type="text" name="limitNum" value="${applyLimitMap[projType.dictId].limitNum}" class="validate[custom[integer],maxSize[3]] xltext" style="width: 80%;"/>
                       			<input type="hidden" name="limitFlow" value="${applyLimitMap[projType.dictId].limitFlow}"/>
                       		</td>
                       	</c:forEach>
					</tr>				
				</table>
				</form>
				<div class="button" style="width: 800px;">
					<input id="saveBtn" class="search" type="button" value="保&#12288;存" onclick="saveApplyLimit();" />
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>