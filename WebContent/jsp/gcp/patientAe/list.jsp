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
	function selectProj(){
		jboxOpen("<s:url value='/gcp/researcher/userProjList'/>", "选择项目", 800, 600,false);
	}	
	function editAe(recordFlow){
		var url = "<s:url value='/gcp/researcher/editAe'/>?type=GCP&patientFlow=${param.patientFlow}&orgFlow=${param.orgFlow}&patientCode=${param.patientCode}&patientNamePy=${param.patientNamePy}&recordFlow=" + recordFlow;
		if(${empty param.visitFlow}){
			window.location.href = url;
		}else{
			jboxOpen(url+"&editFlag=${GlobalConstant.FLAG_N}","不良事件报告",800,600);
		}
		
	}
	function ae(){
		var url = "<s:url value='/gcp/researcher/editAe'/>?beforePage=${param.beforePage}&type=GCP&patientFlow=${param.patientFlow}&orgFlow=${param.orgFlow}&patientCode=${param.patientCode}&patientNamePy=${param.patientNamePy}";
		if(${!empty param.visitFlow}){
			url+=("&visitFlow=${param.visitFlow}");
		}
		window.location.href = url;
	}
	function back(){
		var url = "<s:url value='/gcp/researcher/patientList'/>";
		window.location.href = url;
	}
	
</script>
</head>
<body>
<div class="mainright">
	<div class="content">	
		<div class="title1 clearfix">
			<c:if test="${empty param.visitFlow}">
				<div>
					当前项目：<span style="color:blue">${empty proj.projShortName?pdfn:cutString(proj.projName,10,true,3):proj.projShortName}</span>
					&#12288;受试者编号：<span style="color:blue">${param.patientCode}</span>&#12288;受试者姓名缩写：<span style="color:blue">${param.patientNamePy}</span>
					<input type="button" value="新&#12288;增" class="search" onclick="ae();"/>
					<input type="button" value="返&#12288;回" class="search" onclick="back();"/>
				</div>
			</c:if>
			<div class="title1">
			<table class="xllist">
				<thead>
				<tr id="top">
					<th width="25%">AE名称</th>
					<th width="10%">是否SAE</th>
					<th width="20%">因果关系</th>
					<th width="10%">报告类型</th>
					<th width="12%">报告日期</th>
					<th width="15%">是否提交伦理</th>
					<th width="8%">详情</th>
				</tr>
				</thead>
				<tbody id="data">
				<c:forEach items="${patientAeList}" var="patientAe">
				<tr>
					<td width="25%">${patientAe.aeName}</td>
					<td width="10%">
						<c:if test="${patientAe.isSae eq GlobalConstant.FLAG_Y}">是</c:if>
						<c:if test="${patientAe.isSae eq GlobalConstant.FLAG_N}">否</c:if>
					</td>
					<td width="20%">${patientAe.aeRelations}</td>
					<td width="10%">${patientAe.reportType}</td>
					<td width="12%">${patientAe.reportDate}</td>
					<td width="15%">${patientAe.isSubmitIrb}</td>
					<td width="8%">[<a href="javascript:editAe('${patientAe.recordFlow}');">明细</a>]</td>
				</tr>
				</c:forEach>
				</tbody>
				<tr style="display:${empty patientAeList?'':'none;'}"><td align="center" colspan="7">无记录</td></tr>
			</table>
			</div>
</div></div></div>
</body>
</html>