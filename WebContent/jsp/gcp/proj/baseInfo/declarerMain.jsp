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
	function search() {
		$("#searchForm").submit();
	}
	
	function selDeclarer(orgFlow){
		var jboxIfram = window.parent.frames["jbox-iframe"];
		if ($("#"+orgFlow).attr("checked") != "checked") {
			$("[name='orgs']").each(function(){
				$(this).attr("checked",false);
			});
			$("#"+orgFlow).attr("checked",true);
			var orgName = $("#"+orgFlow).attr("orgName");
			jboxIfram.$("#projDeclarerFlow").val(orgFlow);
			jboxIfram.$("#projDeclarer").val(orgName);
			jboxIfram.$("#projShortDeclarer").val(orgName);
		} else {
			$("#"+orgFlow).attr("checked",false);
			jboxIfram.$("#projDeclarerFlow").val("");
			jboxIfram.$("#projDeclarer").val("");
			jboxIfram.$("#projShortDeclarer").val("");
		} 
	}
	
	function add(){
		if ($("[id='cloneTr']:visible").length == 0) {
			$(".orgTr").each(function(){
				$(this).hide();
			});
			$('#sysOrgList').append($("#clong tr:eq(0)").clone());
		}
	}
	
	function save(){
		if(false==$("#orgForm").validationEngine("validate")){
			return false;
		}
		var url = "<s:url value='/gcp/proj/saveOrg'/>";
		var getdata = $('#orgForm').serialize();
		jboxPost(url, getdata, function(data) {
			if('${GlobalConstant.SAVE_FAIL}'!=data){
				jboxTip("${GlobalConstant.SAVE_SUCCESSED}");
				$("#orgFlow").val(data);
				search();	
			}
		},null,false);
	}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" action="<s:url value="/gcp/proj/declarerMain" />"	method="post">
					机构名称：
					<input type="text" id="searchOrgName" name="orgName" value="${param.orgName}" class="xltext"/>
					<input type="hidden" id="orgFlow" name="orgFlow" value=""/> 
					<input type="button" class="search" onclick="search();" value="查&#12288;询">
					<input type="button" class="search" onclick="add();" value="新&#12288;增">
				</form>
			</div>	
			<form id="orgForm" style="position:relative; ">		
			<table id="orgTable" class="xllist">
				<colgroup>
					<col width="6%" />
					<col width="25%" />
					<col width="20%" />
					<col width="20%" />
					<col width="10%" />
					<col width="20%" />
				</colgroup>
				<thead>
				<tr>
					<th></th>
					<th>申办方名称</th>
					<th>所属地区</th>
					<th>地址</th>
					<th>负责人</th>
					<th>负责人联系方式</th>
				</tr>
				</thead>						
				<tbody id="sysOrgList">
				<c:forEach items="${orgList}" var="org">
					<tr style="height:20px;cursor: pointer;" onclick="selDeclarer('${org.orgFlow}');" class="orgTr">
						<td>
							<input type="checkbox" id="${org.orgFlow}" name="orgs" value="${org.orgFlow}" onclick="selDeclarer('${org.orgFlow}');" orgName="${org.orgName}" />
						</td>
						<td>${org.orgName}</td>
						<td>${org.orgProvName}${org.orgCityName}${org.orgAreaName}</td>
						<td>${org.orgAddress}</td>
						<td>${(orgInfoFormMap[org.orgFlow])['orgInfo.name']}</td>
						<td>${(orgInfoFormMap[org.orgFlow])['orgInfo.phone']}</td>
					</tr>
				</c:forEach>
				</tbody>
				<c:if test="${empty orgList}">
					<tr><td align="center" colspan="6">无记录</td></tr>
				</c:if>
			</table>
			</form>
	</div>
</div>
<table style="display: none; width: 100%;" id="clong">
	<tr id="cloneTr">
		<td style="width:6%">
			[<label onclick="save()" style="color:blue;cursor: pointer;" >保存</label>]
		</td>
		<td style="width:25%">
			<input type="text" name="orgName" value="" class="inputText validate[required]" style="width: 90%;"/>
			<font color="red">*</font>
		</td>
		<td style="width:20%"></td>
		<td style="width:20%">
			<input type="text" name="orgAddress" value="" class="inputText validate[required]" style="width: 90%;"/>
		</td>
		<td style="width:10%">
			<input type="text" name="orgInfo.name" value="" class="inputText validate[required]" style="width: 90%;"/><font color="red">*</font>
		</td>
		<td style="width:20%">
			<input type="text" name="orgInfo.phone" value="" class="inputText validate[required]" style="width: 90%;"/><font color="red">*</font>
		</td>
	</tr>
</table>
</body>
</html>