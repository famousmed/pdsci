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
		jboxOpen("<s:url value='/edc/projOrg/edit'/>", "新增机构信息", 500, 400);
	}
	function edit(recordFlow) {
		jboxOpen("<s:url value='/edc/projOrg/edit?recordFlow='/>"+ recordFlow, "编辑机构信息", 500, 400);
	}		
	function del(recordFlow,recordStatus) {
		var msg = "";
		if(recordStatus=='${GlobalConstant.RECORD_STATUS_N}'){
			msg = "停用";
		}else if(recordStatus=='${GlobalConstant.RECORD_STATUS_Y}'){
			msg = "启用";
		}
		jboxConfirm("确认"+msg+"该记录吗？",  function() {
				doDel(recordFlow,recordStatus);
		});
	}
	function doDel(recordFlow,recordStatus) {
		jboxGet( "<s:url value='/edc/projOrg/del?recordFlow='/>" + recordFlow+"&recordStatus="+recordStatus,null,function(){
			window.parent.frames['mainIframe'].location.reload(true);
		},null,true);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<input type="button" class="search" onclick="add();" value="新&#12288;增">
		</div>
		<div>
			<table class="xllist">
				<tr>
					<th width="50px">中心号</th>
					<th width="200px">机构名称</th>
					<th width="100px">机构角色</th>
					<th width="150px">机构承担病例数</th>
					<th width="200px">操作</th>
				</tr>
				<c:forEach items="${pubProjOrgList}" var="projOrg">
					<tr style="height: 20px">
						<td>${projOrg.centerNo}</td>
						<td>${applicationScope.sysOrgMap[projOrg.orgFlow].orgName}</td>
						<td>${projOrg.orgTypeName}</td>
						<td>
							${projOrg.patientCount}
						</td>
						<td>
							<c:if test="${projOrg.recordStatus == GlobalConstant.RECORD_STATUS_Y }">
							[<a	href="javascript:edit('${projOrg.recordFlow}');">编辑</a>] |
							[<a	href="javascript:del('${projOrg.recordFlow}','${GlobalConstant.RECORD_STATUS_N}');">停用</a>] 
							</c:if>
							<c:if test="${projOrg.recordStatus == GlobalConstant.RECORD_STATUS_N }">
							[<a	href="javascript:del('${projOrg.recordFlow}','${GlobalConstant.RECORD_STATUS_Y}');">启用</a>] 
							</c:if>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${pubProjOrgList == null || pubProjOrgList.size()==0 }"> 
					<tr> 
						<td align="center" colspan="5">无记录</td>
					</tr>
				</c:if>
			</table>
		</div>
	</div>
</div>
</body>
</html>