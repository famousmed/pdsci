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

<script type="text/javascript">
	$(document).ready(function(){
		<c:if test="${empty sessionScope.gcpCurrProj && param.type != 'projInfo'}">
			selectProj();
		</c:if>
		dataCount();
	});
	
	function selectProj(){
		jboxOpen("<s:url value='/gcp/researcher/userProjList'/>", "选择项目", 800, 600,false);
	}

	$(document).ready(function(){
		dataCount();
		selPatientStage($(".selOne:checked").val());
		var listWidth = document.body.clientWidth - 30;
		var listHeight = document.body.clientHeight - 68;
		$("#listDiv").css({
			width:listWidth,
			height:listHeight,
			overflow:"auto"
		});
	});
	
	function dataCount(){
		if($("#data tr").not(":hidden").length>0){
			$("#dataFoot").hide();
		}else{
			$("#dataFoot").show();
		}
	}
	
	function ae(patientFlow, recordFlow){
		var url = "<s:url value='/gcp/researcher/editAe'/>?editFlag=${GlobalConstant.FLAG_N}&patientFlow=" + patientFlow + "&recordFlow=" + recordFlow ;
		jboxOpen(url,"不良事件报告",800,600);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">	
		<div class="title1 clearfix">
			<div>
				当前项目：
				<c:if test="${param.type != 'projInfo' }">
					<a href="javascript:selectProj();" style="color:blue">${empty proj.projShortName?pdfn:cutString(proj.projName,10,true,3):proj.projShortName}</a>
				</c:if>
				<c:if test="${param.type eq 'projInfo' }">
					${empty proj.projShortName?pdfn:cutString(proj.projName,10,true,3):proj.projShortName}
				</c:if>
			</div>
			<div class="title1">
			<table class="xllist">
				<thead>
				<tr id="top">
					<th width="10%">受试者编号</th>
					<th width="10%">受试者姓名缩写</th>
					<th width="15%">AE名称</th>
					<th width="8%">是否SAE</th>
					<th width="20%">因果关系</th>
					<th width="10%">报告类型</th>
					<th width="10%">报告日期</th>
					<th width="8%">是否提交伦理</th>
					<c:if test="${param.type != 'projInfo' }">
					<th width="10%">明细</th>
					</c:if>
				</tr>
				</thead>
				<tbody id="data">
				<c:forEach items="${patientAeList}" var="patientAe">
				<tr>
					<td  width="10%">${patientAe.patientCode}</td>
					<td  width="10%">${patientAe.patientNamePy}</td>
					<td  width="15%">${patientAe.aeName}</td>
					<td  width="8%">
						<c:if test="${patientAe.isSae eq GlobalConstant.FLAG_Y}">是</c:if>
						<c:if test="${patientAe.isSae eq GlobalConstant.FLAG_N}">否</c:if>
					</td>
					<td  width="20%">${patientAe.aeRelations}</td>
					<td  width="10%">${patientAe.reportType}</td>
					<td  width="10%">${patientAe.reportDate}</td>
					<td  width="8%">${patientAe.isSubmitIrb}</td>
					<c:if test="${param.type != 'projInfo' }">
					<td  width="10%">[<a href="javascript:ae('${patientAe.patientFlow}','${patientAe.recordFlow}');">明细</a>]</td>
					</c:if>
				</tr>
				</c:forEach>
				</tbody>
				<tr id="dataFoot"><td align="center" colspan="10">无记录</td></tr>
			</table>
			</div>
</div></div></div>
</body>
</html>