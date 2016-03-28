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
	
	function searchUser(){
		toPage("${param.currentPage}");
	}
	
	function editDoc(doctorFlow){
		jboxOpen("<s:url value='/res/manager/editDocSimple'/>?roleFlag=${param.roleFlag}&doctorFlow="+doctorFlow,"编辑医师信息",950,490);
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
				<form id="searchForm" method="post" action="<s:url value='/res/manager/userList'/>">
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
							
<%-- 							<c:if test="${sysCfgMap['res_for_use'] eq 'local'}"> --%>
								&#12288;&#12288;
<!-- 								<input type="button" value="新&#12288;增" class="search" onclick="editDoc('');"/> -->
<%-- 							</c:if> --%>
<!-- 							[<a style="color: blue;cursor: pointer;" onclick="editDoc('');">新&nbsp;增</a>] -->
							</td>
						</tr>
					</table>
				</form>
				<table class="basic" width="100%">
					<tr>
						<th colspan="10" style="text-align: left;">&#12288;人员管理</th>
					</tr>
					<tr style="font-weight: bold;">
						<td style="text-align: center;padding: 0px;width: 8%;">姓名</td>
						<td style="text-align: center;padding: 0px;">性别</td>
						<td style="text-align: center;padding: 0px;">手机</td>
						<td style="text-align: center;padding: 0px;">身份证</td>
						<td style="text-align: center;padding: 0px;width: 8%;">届数</td>
						<td style="text-align: center;padding: 0px;width: 10%;">专业</td>
<!-- 						<td style="text-align: center;padding: 0px;width: 15%;">毕业院校</td> -->
						<td style="text-align: center;padding: 0px;width: 15%;">轮转方案</td>
						<c:if test="${param.doctorCategoryId eq recDocCategoryEnumIntern.id}">
							<td style="text-align: center;padding: 0px;width: 9%;">组别</td>
						</c:if>
						<td style="text-align: center;padding: 0px;width: 8%;">状态</td>
						<td style="text-align: center;padding: 0px;width: 8%;">操作</td>
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
							<td style="text-align: center;padding: 0px;">${doctor.rotationName}</td>
							<c:if test="${param.doctorCategoryId eq recDocCategoryEnumIntern.id}">
								<td style="text-align: center;padding: 0px;">
									<select name="groupId" class="validate[required]" onchange="changeGroupRelated('${doctor.doctorFlow}',this.value,'groupId');">
										<option></option>
										<c:forEach items="${dictTypeEnumResGroupList}" var="group">
											<option value="${group.dictId}" ${doctor.groupId eq group.dictId?'selected':''}>${group.dictName}</option>
										</c:forEach>
									</select>
								</td>
							</c:if>
							<td style="text-align: center;padding: 0px;">${doctor.doctorStatusName}</td>
							<td style="text-align: center;padding: 0px;">
								<a style="color: blue;cursor: pointer;" onclick="editDoc('${doctor.doctorFlow}');">编辑</a>
							</td>
						</tr>
					</c:forEach>
					
					<c:if test="${empty param.doctorCategoryId}">
						<tr><td style="text-align: center;" colspan="9">请选择人员类型!</td></tr>
					</c:if>
					<c:if test="${!empty param.doctorCategoryId}">
						<c:if test="${empty doctorList}">
							<tr><td style="text-align: center;" colspan="9">无记录</td></tr>
						</c:if>
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