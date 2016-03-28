<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="false"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="false"/>
	<jsp:param name="jquery_datePicker" value="false"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="false"/>
	<jsp:param name="jquery_placeholder" value="false"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>

<script type="text/javascript" defer="defer">
	function addParentUnit(dictId,dictName){
		var patrntPage = window.parent.frames['jbox-iframe'];
		window.parent.frames['jbox-iframe'].window.addUnit(dictId,dictName);
	}
</script>
</head>
<body>
	<div style="margin-top: 5px;"   >
   		 		<table class="xllist" style="width: 400px"  >
					<tr>
						<th colspan="5">单位</th>
					</tr>
						 <tr>
						 <td>
						 	<ul class="dbsx">
								<li>
									<c:forEach items="${dictTypeEnumStandardUnitList}" var="dict">
										<span ><a href="javascript:addParentUnit('${dict.dictId }','${dict.dictName }');">${dict.dictName}</a></span>
									</c:forEach>
								</li>
							</ul>
						 </td>
						</tr>
				</table>
   </div>
</body>
</html>