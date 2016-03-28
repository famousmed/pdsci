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
	
	function viewConfirm(){
		jboxConfirm("确认<font color='red'>${window.visitName}</font>这次访视?",function (){
			var url = "<s:url value='/gcp/researcher/savePatientVisit'/>";
			var getdata = $('#patientVisitForm').serialize();
			jboxPost(url, getdata, function(data) {
				if('${GlobalConstant.OPRE_SUCCESSED}'==data){
					window.parent.frames['mainIframe'].window.goVisitInfo($("[name='visitFlow']").val()); 
					jboxClose();		
				}
			});
		});
	}	
	
</script>
</head>
	<body>
			<div class="mainright">
	<div class="content">	
		<div class="title1 clearfix">
		<div style="margin-top: 5px;">
			<form id="patientVisitForm">
			<input type="hidden" name="patientFlow" value="${patient.patientFlow}"/>
			<input type="hidden" name="visitDate" value="${param.date}"/>
			<input type="hidden" name="visitFlow" value="${window.visitFlow}"/>
			<table class="xllist">
				<tbody>
					<tr>
						<th colspan="10" style="text-align: left;">
							&#12288;受试者信息
						</th>
					</tr>
					<tr>
						<td style="text-align: left;" colspan="2">
							&#12288;&#12288;受试者编号：${patient.patientCode} 
							&#12288;姓名缩写：${patient.patientNamePy}
						</td>
					</tr>
					<tr>
						<th colspan="10" style="text-align: left;">
							&#12288;访视信息
						</th>
					</tr>
					<tr>
						<td style="text-align: right;width: 30%">上次访视日期：</td>
						<td style="text-align: left;">
							&nbsp;${empty lastVisitDate?"无":lastVisitDate}
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">本次访视：</td>
						<td style="text-align: left;">
							&nbsp;${window.visitName}
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">本次访视窗：</td>
						<td style="text-align: left;">
							&nbsp;${window.windowVisitLeft}~${window.windowVisitRight}
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">本次访视日期：</td>
						<td style="text-align: left;">
							&nbsp;${param.date}
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">是否超窗：</td>
						<td style="text-align: left;">
							&nbsp;${window.outWindowTypeName}
						</td>
					</tr>
				</tbody>
			</table>
			</form>
		</div>
			<div style="text-align: center;margin-top: 10px;">
			<input type="button" class="search" value="确&#12288;认" onclick="viewConfirm();"/>
			<input type="button" class="search" value="关&#12288;闭" onclick="jboxClose();"/></div>
		</div></div></div>
</body>
</html>