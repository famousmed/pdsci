<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_form" value="false" />
	<jsp:param name="jquery_ui_tooltip" value="true" />
	<jsp:param name="jquery_ui_combobox" value="false" />
	<jsp:param name="jquery_ui_sortable" value="false" />
	<jsp:param name="jquery_cxselect" value="true" />
	<jsp:param name="jquery_scrollTo" value="false" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="false" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
</jsp:include>
<style type="text/css">
.btn {
		display: inline-block;
		overflow: visible;
		padding: 0 22px;
		height: 30px;
		line-height: 30px;
		vertical-align: middle;
		text-align: center;
		text-decoration: none;
		border-radius: 3px;
		-moz-border-radius: 3px;
		-webkit-border-radius: 3px;
		font-size: 14px;
		border-width: 1px;
		border-style: solid;
		cursor: pointer;
		}
</style>
<script type="text/javascript">
	function search(){
		$("#searchForm").submit();
	}
	function toPage(page) {
		if(page){
			$("#currentPage").val(page);			
		}
		search();
	}
	
	function pageSearch(){
		toPage("${param.currentPage}");
	}
	
	function searchUser(){
		pageSearch();
	}
	
	function editDoc(doctorFlow){
		jboxOpen("<s:url value='/res/platform/editDocSimple'/>?roleFlag=${param.roleFlag}&doctorFlow="+doctorFlow,"编辑医师信息",950,490);
	}
	
	function changeGroupRelated(doctorFlow,value,type){
		var url = "<s:url value='/res/doc/user/saveGroupRelated'/>";
		var data = {
			doctorFlow:doctorFlow,
			value:value,
			type:type
		};
		jboxPost(url, data, null,null,true);
	}
	
	$(function(){
		<c:if test="${empty param.doctorCategoryId}">
			if($("[name='doctorCategoryId'] option").length == 2){
				$("[name='doctorCategoryId'] option:last").attr("selected","selected").parent().change();
			}
		</c:if>
	});
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" method="post" action="<s:url value='/res/platform/userInfoList'/>">
					<input id="currentPage" type="hidden" name="currentPage" value=""/>
					<table  class="basic" width="100%" style="margin-bottom: 10px;">
						<tr>
							<td>
							人员类型：
							<select name="doctorCategoryId" onchange="search();">
								<option></option>
								<c:forEach items="${recDocCategoryEnumList}" var="category">
									<c:set var="res_doctor_category_key" value="res_doctor_category_${category.id }"/>
									<c:if test="${sysCfgMap[res_doctor_category_key]==GlobalConstant.FLAG_Y }">
									<option value="${category.id}" ${param.doctorCategoryId eq category.id?'selected':''}>${category.name}</option>
									</c:if>
								</c:forEach>
							</select>
							&#12288;&#12288;
							届数：
							<select name="sessionNumber" onchange="search();">
								<option></option>
								<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
									<option value="${dict.dictName}" ${param.sessionNumber eq dict.dictName?'selected':''}>${dict.dictName}</option>
								</c:forEach>
							</select>
							&#12288;&#12288;
							专业：
							<select name="trainingSpeId" onchange="search();">
								<option></option>
								<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
									<option value="${dict.dictId}" ${param.trainingSpeId eq dict.dictId?'selected':''}>${dict.dictName}</option>
								</c:forEach>
							</select>
							&#12288;&#12288;
							姓名：
							<input type="text" name="doctorName" value="${param.doctorName}" onchange="search();" style="width: 80px;">
							&#12288;&#12288;
							 培训基地：
							<select name="orgFlow" onchange="search();" style="width: 150px;">
								<option></option>
								<c:forEach items="${applicationScope.sysOrgList}" var="org">
									<option value="${org.orgFlow}" ${param.orgFlow eq org.orgFlow?'selected':''}>${org.orgName}</option>
								</c:forEach>
							</select>
							&#12288;&#12288;
<!-- 							[<a style="color: blue;cursor: pointer;" onclick="editDoc('');">新&nbsp;增</a>] -->
							<input type="button" value="新&#12288;增" class="search" onclick="editDoc('');"/>
							</td>
						</tr>
					</table>
				</form>
				<table class="basic" width="100%">
					<tr>
						<th colspan="9" style="text-align: left;">&#12288;实习安排</th>
					</tr>
					<tr style="font-weight: bold;">
						<td style="text-align: center;padding: 0px;width: 10%;">姓名</td>
						<td style="text-align: center;padding: 0px;">性别</td>
						<td style="text-align: center;padding: 0px;">手机</td>
						<td style="text-align: center;padding: 0px;">身份证</td>
						<td style="text-align: center;padding: 0px;width: 5%;">届数</td>
						<td style="text-align: center;padding: 0px;width: 15%;">专业</td>
<!-- 						<td style="text-align: center;padding: 0px;width: 20%;">毕业院校</td> -->
						<td style="text-align: center;padding: 0px;width: 25%;">培训基地</td>
						<c:if test="${param.doctorCategoryId eq recDocCategoryEnumIntern.id}">
							<td style="text-align: center;padding: 0px;width: 9%;">组间职务</td>
						</c:if>
						<td style="text-align: center;padding: 0px;width: 10%;">操作</td>
					</tr>
					<c:forEach items="${doctorList}" var="doctor">
						<tr>
							<td style="text-align: center;padding: 0px;">${doctor.doctorName}</td>
							<td style="text-align: center;padding: 0px;">${doctor.sysUser.sexName}</td>
							<td style="text-align: center;padding: 0px;">${doctor.sysUser.userPhone}</td>
							<td style="text-align: center;padding: 0px;">${doctor.sysUser.idNo}</td>
							<td style="text-align: center;padding: 0px;">${doctor.sessionNumber}</td>
							<td style="text-align: center;padding: 0px;">${doctor.trainingSpeName}</td>
<%-- 							<td style="text-align: center;padding: 0px;">${doctor.graduatedName}</td> --%>
							<td>${doctor.orgName}</td>
							<c:if test="${param.doctorCategoryId eq recDocCategoryEnumIntern.id}">
								<td style="text-align: center;padding: 0px;">
									<select name="groupRoleId" onchange="changeGroupRelated('${doctor.doctorFlow}',this.value,'groupRoleId');">
										<option></option>
										<c:forEach items="${groupRoleEnumList}" var="groupRole">
											<option value="${groupRole.id}" ${doctor.groupRoleId eq groupRole.id?'selected':''}>${groupRole.name}</option>
										</c:forEach>
									</select>
								</td>
							</c:if>
							<td style="text-align: center;padding: 0px;"><a style="color:blue;cursor:pointer;" onclick="editDoc('${doctor.doctorFlow}');">编辑</a></td>
						</tr>
					</c:forEach>
					
					<c:if test="${empty doctorList && !empty param.doctorCategoryId}">
						<tr><td style="text-align: center;" colspan="8">无记录</td></tr>
					</c:if>
					<c:if test="${empty param.doctorCategoryId}">
						<tr><td style="text-align: center;" colspan="8">请选择医师类型！</td></tr>
					</c:if>
				</table>
				<div>
				   	<c:set var="pageView" value="${pdfn:getPageView(doctorList)}" scope="request"/>
					<pd:pagination toPage="toPage"/>
				</div>
			</div>
		</div>
	</div>
</body>
</html>