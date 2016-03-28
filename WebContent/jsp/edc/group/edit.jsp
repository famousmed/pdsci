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
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="false"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
	function save() {
		if(false==$("#groupForm").validationEngine("validate")){
			return ;
		}
		jboxPost("<s:url value='/edc/visit/saveEdcGroup'/>", $('#groupForm').serialize(), function() {	
			window.parent.frames['mainIframe'].location.reload(true);
			doClose();
		});
	}
	
	function doClose() {
		jboxClose();
	}
</script>
</head>
<body>

<form id="groupForm" style="padding-left: 10px;height: 100px;" >
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0"  align="center">				
				<table width="400" cellpadding="0" cellspacing="0" class="basic">					
					<tr>
						<th>序号：</th>
						<td>
							<input name="groupFlow" type="hidden" value="${group.groupFlow }" />
							<input class="validate[custom[integer]] xltext" name="ordinal" type="text" value="${group.ordinal }" />
						</td>  
					</tr>
					<tr>
						<th>一级揭盲：</th>
						<td>
							<input class="xltext" name="groupCode" type="text" value="${group.groupCode }" />
						</td>  
					</tr>
					<tr>
						<th>二级揭盲：</th>
						<td>
							<c:if test="${!empty group.groupFlow }">
								${group.groupName }
							</c:if>
							<c:if test="${empty group.groupFlow }">
								<input class="validate[required] xltext" name="groupName" type="text" value="${group.groupName }" />
							</c:if>
						</td>  
					</tr>
					<tr>
						<th>比例：</th>
						<td>
							<input class="xltext" name="proportion" type="text" value="${group.proportion }" />
						</td>  
					</tr>
				</table>
				<div class="button" style="width: 400px;">
					<input type="button" class="search" value="保&#12288存" onclick="save();" />
					<input type="button" class="search" value="关&#12288闭" onclick="doClose();">
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>