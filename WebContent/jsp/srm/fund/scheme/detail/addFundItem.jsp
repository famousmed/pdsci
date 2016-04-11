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
		function saveFundSchemeDetail() {
			var url = "<s:url value='/srm/fund/scheme/detail/saveFundSchemeDetail'/>";
			jboxStartLoading();
			jboxPost(url , $('#fundItemelForm').serialize() , function(){
				$("#searchFundSchemeDetailForm",window.parent.frames['jbox-message-iframe'].document).submit(); 
				doClose();
			} , null , true);
		}
		function doClose() {
			jboxClose();
		}
</script>
</head>
<body>
	<div style="margin-top: 25px;">
		<form id="fundItemelForm">
			<table class="mation" style="width: 400px" >
				<tr>
					<th style="text-align: center;">选择</th>
					<th >经费项目名</th>
				<tr>
				<c:forEach items="${fundItemInfoList}" var="fundItemInfo">
					<tr>
						<td style="text-align:center;">
							<input style="margin-top: 7px;" value="${fundItemInfo.item.itemFlow}" name="itemFlow" type="checkbox"  class="validate[required]" >
						</td>
						<td>${fundItemInfo.item.itemName}</td>
					</tr>													
				</c:forEach>
			</table>
			<div align="center">
				<input type="button" value="保存" class="dingdan-d" style="width: 70px"  onclick="saveFundSchemeDetail();"  />
					 <input type="hidden" name="schemeFlow" value="${param.schemeFlow}" /> 
					 <input type="button" class="dingdan-d" onclick="doClose();" value="关闭">
			</div>
		</form>
	</div>
</body>
</html>