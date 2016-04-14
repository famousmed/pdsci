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
	function add() {
		jboxOpen("<s:url value='/edc/proj/edit'/>" ,  "新增项目信息", 900, 500);
	}
	function edit(projFlow) {
		jboxOpen("<s:url value='/edc/proj/edit?projFlow='/>"+projFlow , "编辑项目信息", 900, 500);
	}
	function projOrgList(projFlow) {
		window.location.href="<s:url value='/edc/projOrg/list?projFlow='/>" + projFlow;
	}
	
	function delProj(projFlow,recordStatus) {
		var msg = "";
		if(recordStatus=='${GlobalConstant.RECORD_STATUS_N}'){
			msg = "删除";
		}else if(recordStatus=='${GlobalConstant.RECORD_STATUS_Y}'){
			msg = "启用";
		}
		jboxConfirm("确认"+msg+"该记录吗？" , function(){
			doDel(projFlow,recordStatus);
		});
	}
	function doDel(projFlow,recordStatus) {
		jboxGet("<s:url value='/edc/proj/delete?projFlow='/>" + projFlow+"&recordStatus="+recordStatus,null,function(){
			search();					
		});	
	}
	function search() {
		jboxStartLoading();
		$("#searchForm").submit();
	}
	function assignPM(projFlow) {
		jboxOpen("<s:url value='/edc/proj/assignPM?projFlow='/>"+projFlow , "添加项目管理员" ,980, 500);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/edc/proj/list" />" method="post">
				项目编号：<input type="text" name="projNo" value="${param.projNo}" class="xltext"/>
				项目名称：<input type="text" name="projName" value="${param.projName}" class="xltext"/> 
				<input type="button" class="search"	onclick="search();" value="查&#12288;询"> 
				<input type="button" class="search" onclick="add();" value="新&#12288;增">
			</form>
		</div>
		<div>
			<table class="xllist">
				<tr>
					<th width="100px;">项目编号</th>
					<th width="100px;">CFDA编号</th>
					<th width="250px;">项目名称</th>				
					<th width="100px;">项目简称</th>
					<th width="100px;">期类别</th>
					<th width="150px;">操作</th>
				</tr>
				<c:forEach items="${projList}" var="proj">
					<tr style="height: 20px">
						<td>${proj.projNo }</td>
						<td>${proj.cfdaNo }</td>
						<td>${proj.projName }</td>					
						<td>${proj.projShortName }</td>
						<td>
							${proj.projSubTypeName }
						</td>
						<td>
							<c:if test="${proj.recordStatus == GlobalConstant.RECORD_STATUS_Y }">
							[<a	href="javascript:edit('${proj.projFlow}');">编辑</a>] |
							[<a	href="javascript:assignPM('${proj.projFlow}');">添加PM</a>] |
							[<a	href="javascript:delProj('${proj.projFlow}','${GlobalConstant.RECORD_STATUS_N}');">删除</a>] 
							</c:if>
							<c:if test="${proj.recordStatus == GlobalConstant.RECORD_STATUS_N }">
							[<a	href="javascript:delProj('${proj.projFlow}','${GlobalConstant.RECORD_STATUS_Y}');">启用</a>] 
							</c:if> 
						</td>
					</tr>
				</c:forEach>
				<c:if test="${projList == null || projList.size()==0 }"> 
					<tr> 
						<td align="center" colspan="6">无记录</td>
					</tr>
				</c:if>
			</table>
		</div>
	</div> 
</div>
</body>
</html>