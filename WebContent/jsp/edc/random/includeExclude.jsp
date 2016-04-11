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
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
			<p>
			受试者编号：${patient.patientCode }
			&#12288;&#12288;受试者拼音缩写：${patient.patientNamePy }
			</p>
		<div class="title1 clearfix" align="center">
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">	
					<tr>
						<th colspan="2" style="text-align: left;">&#12288;纳入标准
						</th>
					</tr>
					<c:forEach items="${inList}" var="in">
						<tr>
							<td width="200px">${in.ieName }</td>
							<td width="50px" style="text-align: center;padding-left: 0;">
								<c:if test="${appItemInputTypeEnumNumber.id == in.inputTypeId}">
									${patientIeMap[in.ieFlow] }
								</c:if>
								<c:if test="${appItemInputTypeEnumBool.id == in.inputTypeId}">
									<c:if test="${'true' == patientIeMap[in.ieFlow] }">
										是
									</c:if>
									<c:if test="${'false' == patientIeMap[in.ieFlow] }">
										否
									</c:if>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				<c:if test="${inList == null || inList.size()==0 }"> 
					<tr> 
						<td style="text-align: center;" colspan="2">无记录</td>
					</tr>
				</c:if>
				<tr>
					<th colspan="2" style="text-align: left;">&#12288;排除标准
					</th>
				</tr>
				<c:forEach items="${exList}" var="ex">
				<tr>
					<td width="200px">${ex.ieName }</td>
					<td width="50px" style="text-align: center;padding-left: 0;">
						<c:if test="${appItemInputTypeEnumNumber.id == ex.inputTypeId}">
							${patientIeMap[ex.ieFlow] }
						</c:if>
						<c:if test="${appItemInputTypeEnumBool.id == ex.inputTypeId}">
							<c:if test="${'true' == patientIeMap[ex.ieFlow] }">
								是
							</c:if>
							<c:if test="${'false' == patientIeMap[ex.ieFlow] }">
								否
							</c:if>
						</c:if>
					</td>
				</tr>
				</c:forEach>
				<c:if test="${exList == null || exList.size()==0 }"> 
					<tr> 
						<td style="text-align: center;" colspan="2">无记录</td>
					</tr>
				</c:if>
			</table>
	</div>
	</div>
</div>
</body>
</html>