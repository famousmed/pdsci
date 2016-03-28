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
	function add(){
		 $("tr:eq(2)").clone().appendTo("table"); 
	}
</script>
</head>
<body>
<form id="sysOrgForm" style="height: 100px;" >
	<div class="title1 clearfix">
				<table  class="xllist" >
					<tr>
						<th  rowspan="2" width="10%">年份</th>
						<th colspan="2"   width="25%" >一类学分</th>
						<th rowspan="2"   width="25%">二类学分</th>
						<th rowspan="2"  width="20%">职业道德（是否完成）</th>
						<th  rowspan="2"  width="20%">学分是否完成</th>
					</tr>
					<tr>
						<th>国家级</th><th>省级</th>
					</tr>
					<tr><td><input type="text" style="width: 50px;text-align: center;" ></td>
						<td><input type="text" style="width: 50px;text-align: center;" ></td>
						<td><input type="text" style="width: 50px;text-align: center;" ></td>
						<td><input type="text" style="width: 50px;text-align: center;" ></td>
						<td><select style="width: 100px;"><option></option><option>是</option><option>否</option></select></td>
						<td><select style="width: 100px;"><option></option><option>是</option><option>否</option></select></td>
					</tr>
				</table>
				<div class="button" >
					<input class="search" type="button" value="新&#12288;增" onclick="add();" />
					<input class="search" type="button" value="保&#12288;存" onclick="saveOrg();" />
				</div>
			</div>
</form>
</body>
</html>