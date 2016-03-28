<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
<c:set var="provIds"></c:set>
<script type="text/javascript">
function doDel(recordFlow){
	jboxConfirm("确认删除该条数据吗？",function () {
		var url = "<s:url value='/sys/user/delRegion?recordFlow='/>"+recordFlow;
		jboxGet(url,null,function(){
			$("#"+recordFlow).remove();
		});		
	});
}
function allotRegion(userFlow){
	jboxOpen("<s:url value='/sys/user/allotRegion?userFlow='/>"+userFlow,"分配用户地区权限:${sysUser.userName}", 600, 600);
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
<form id="regionForm">
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<thead>
					<tr>
						<th style="width: 100%;" colspan="3">用户名称：${sysUser.userName}
							<input name="userFlow" type="hidden" value="${sysUser.userFlow}">
							<input name="orgFlow" type="hidden" value="${sysUser.orgFlow}">
						</th>
					</tr>
					<tr>
						<th style="width: 30%;">范围级别：
						</th>
						<th style="width: 50%;">地区名称：
						</th>
						<th style="width: 20%;">操作
						</th>
					</tr>
					</thead>
					<tbody id="provTable">
						<c:forEach items="${erpUserRegionPopedomList}" var="erpUserRegionPopedom" varStatus="status">
						<tr id="${erpUserRegionPopedom.recordFlow}">
							<td>
								${erpUserRegionPopedom.regionTypeName }
							</td>
							<td>
								${erpUserRegionPopedom.provName }-${erpUserRegionPopedom.cityName }-${erpUserRegionPopedom.areaName }
							</td>
							<td>
								[<a href="javascript:doDel('${erpUserRegionPopedom.recordFlow}');" >删除</a>]
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
</form>
				<div class="button" style="width: 800px;">
					<input class="search" type="button" value="添加省级权限" onclick="allotRegion('${sysUser.userFlow}');" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>