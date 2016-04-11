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
	function doSave() {
		if(false==$("#sysDeptForm").validationEngine("validate")){
			return ;
		}
		var url = "<s:url value='/sys/dept/save'/>";
		var data = $('#sysDeptForm').serialize();
		jboxPost(url, data, function() {
			window.parent.frames['mainIframe'].window.search($("[name='orgFlow']").val());
			jboxClose();
		},null,true);
	
	}
</script>
</head>
<body>	
<form id="sysDeptForm" action="<s:url value="/sys/dept/save"/>"style="padding-left: 33px;height: 100px;" >
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">
				<table width="400px;" cellpadding="0" cellspacing="0" class="basic">
					<tr>
						<th>机构名称:</th>
						<td>
						<c:if test="${sessionScope.deptListScope==GlobalConstant.DEPT_LIST_GLOBAL }">
							<select class="validate[required] xlselect" name="orgFlow"  >
								<c:if test="${fn:length(orgList)>0} }">
									<option value="">请选择</option>
								</c:if>
								<c:forEach var="org" items="${orgList}">
									<option value="${org.orgFlow}" <c:if test="${org.orgFlow==sysDept.orgFlow or org.orgFlow==param.orgFlow}">selected="selected"</c:if>>${org.orgName}</option>
								</c:forEach>
							</select>
						</c:if>
						<c:if test="${sessionScope.deptListScope==GlobalConstant.DEPT_LIST_LOCAL }">
							<input type="hidden" name="orgFlow" value="${sessionScope.currUser.orgFlow }"/>
							${sessionScope.currUser.orgName}
						</c:if>
						</td>
					</tr>
					<tr>
						<th>部门代码:</th>
						<td>
							<input class="validate[required,custom[number]] xltext" name="deptCode" type="text" value="${sysDept.deptCode }" />
						</td>
					</tr>
					<tr>
						<th>部门名称:</th>
						<td>
							<input class="validate[required,minSize[1],maxSize[25]] xltext" name="deptName" type="text" value="${sysDept.deptName }" />
						</td>
					</tr>
					<tr>
						<th>排序码:</th>
						<td>
							<input class="validate[required,custom[integer]] xltext" name="ordinal" type="text" value="${sysDept.ordinal }" />
							
						</td>
					</tr>
				</table>
				<div class="button" style="width: 400px;">                            		
					<input  type="hidden" name="deptFlow" value="${sysDept.deptFlow }"/>
					<input type="button" value="保&#12288;存" class="search" onclick="doSave();" />
					<input type="button" class="search" onclick="jboxClose();" value="关&#12288;闭">
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>