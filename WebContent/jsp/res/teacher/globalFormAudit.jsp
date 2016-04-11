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
	<jsp:param name="jquery_validation" value="false"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="false"/>
	<jsp:param name="jquery_placeholder" value="false"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
	<style type="text/css">
		table.c.basic td,table.c.basic td{padding: 0;text-align: center;}
	</style>
	<script type="text/javascript">
 	function edit(flow){
 		var url="<s:url value='/res/rec/showRegistryForm'/>?roleFlag=${roleFlag}&recTypeId=${param.recTypeId}&operUserFlow=${doctor.doctorFlow}&schDeptFlow=${doctor.deptFlow }&recFlow="+flow;
 		jboxOpen(url,"年度培训记录",800,500);
 	}
 	function del(flow){
 		jboxConfirm("确认删除？", function() {
 			url="<s:url value='/res/rec/delResrec'/>?recFlow="+flow+"&recordStatus=${GlobalConstant.RECORD_STATUS_N}";
 			jboxPost(url , null , function(obj){
 				if(obj=="${GlobalConstant.DELETE_SUCCESSED}"){
 					$("#tags .selectTag a").click();
 				}
 		});
 		});
 	} 
 	
 	function search(){
 		$("#searchForm").submit();
 	}
	</script>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" action="<s:url value='/res/teacher/globalFormAudit/${roleFlag}'/>">
					<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
					<table class="basic" style="width: 100%;">
						<tr>
							<td>
								部门：
								<select name="deptFlow" onchange="search();">
									<option value=""></option>
									<c:forEach items="${sDeptList}" var="dept">
										<option value="${dept.deptFlow}" <c:if test="${param.deptFlow eq dept.deptFlow}">selected</c:if>>${dept.deptName}</option>
									</c:forEach>
								</select>
								&#12288;
								姓名：
								<input type="text" name="userName" value="${param.userName}" onchange="search();"/>
							</td>
						</tr>
					</table>
				</form>
				<table class="basic c" style="width: 100%;margin-top: 10px;">
					<tr>
						<th>姓名</th>
						<th>性别</th>
						<th>手机</th>
						<th>入院时间</th>
						<th>人员类型</th>
						<th>身份证</th>
						<th>届数</th>
						<th>培训专业</th>
					</tr>
					<c:forEach items="${userList}" var="user">
						<tr onclick="$('#${user.userFlow}').toggle(200);" style="cursor: pointer;">
							<td>${user.userName}</td>
							<td>${user.sexName}</td>
							<td>${user.userPhone}</td>
							<td>${doctorMap[user.userFlow].inHosDate}</td>
							<td>${doctorMap[user.userFlow].doctorCategoryName}</td>
							<td>${user.idNo}</td>
							<td>${doctorMap[user.userFlow].sessionNumber}</td>
							<td>${doctorMap[user.userFlow].trainingSpeName}</td>
						</tr>
						<tr>
							<td id="${user.userFlow}" colspan="8" style="padding-bottom: 10px;padding-right: 10px;padding-left: 10px;text-align: left;display: none;">
								<c:forEach items="${recListMap[user.userFlow]}" var="rec">
									<div class="ith" style="cursor: pointer;border: 1px solid #ccc;margin-top: 10px;padding: 10px;">
										<div style="float: right;">
											<a style="color: blue;cursor: pointer;" onclick="edit('${rec.recFlow}')">审核</a>	
				<!-- 							| -->
				<%-- 							<a style="color: blue;cursor: pointer;" onclick="del('${rec.recFlow}');">删除</a> --%>
										</div>
										<div style="width: 80%;">
											<c:forEach items="${viewListMap[rec.recFlow]}" var="viewInfo">
												&#12288;${viewInfo.title}：${viewInfo.value}
											</c:forEach>
										</div>
									</div>
								</c:forEach>
							</td>
						</tr>
					</c:forEach>
				</table>
				
				
				<c:if test="${empty recList}">
					<div class="ith" style="cursor: pointer;border: 1px solid #ccc;margin-top: 10px;padding: 10px;text-align: center;">
						无记录
					</div>
				</c:if>
			</div>
		</div>
		</div>
</body>
</html>