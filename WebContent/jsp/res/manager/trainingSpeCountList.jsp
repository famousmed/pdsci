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
	<jsp:param name="jquery_validation" value="false"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>

<style type="text/css">
	[type='text']{width:150px;height: 22px;}
	select{width: 153px;height: 27px;}
</style>

<script type="text/javascript">
	function search(){
		jboxStartLoading();
		$("#searchForm").submit();
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value='/res/manager/trainingSpeCountList'/>" method="post">
				<table class="basic" width="100%" style="margin-bottom: 10px;">
					<tr>
						<td style="text-align: left;">
							&#12288;届&#12288;数：
							<select id="sessionNumber" name="sessionNumber" style="width: 90px" onchange="search();">
								<option value="">请选择</option>
								<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
									<option value="${dict.dictName}" ${param.sessionNumber eq dict.dictName?'selected':''}>${dict.dictName}</option>
								</c:forEach>
							</select>
							&#12288;&#12288;人员类型：
							<select name="doctorCategoryId" style="width: 100px;" onchange="search();">
								<option value="">请选择</option>
								<c:forEach items="${recDocCategoryEnumList}" var="category">
									<c:set var="res_doctor_category_key" value="res_doctor_category_${category.id }"/>
									<c:if test="${sysCfgMap[res_doctor_category_key]==GlobalConstant.FLAG_Y }">
									<option value="${category.id}" ${param.doctorCategoryId eq category.id?'selected':''}>${category.name}</option>
									</c:if>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>
			</form>
		</div>
		
		<table border="0" cellpadding="0" cellspacing="0" class="xllist" style="width: 100%">
            <tr>
                <th width="80%">专业名称</th>
                <th width="20%">专业人数</th>
            </tr>
			<c:if test="${not empty trainingSpeFormMap}">
	            <c:forEach var="dict" items="${dictTypeEnumDoctorTrainingSpeList}">
	            <tr>
	                <td>${dict.dictName}</td>
	                <td>${trainingSpeFormMap[dict.dictId]==null?'0':trainingSpeFormMap[dict.dictId]}</td>
	            </tr>
	        	</c:forEach>
	        </c:if>
			<c:if test="${empty trainingSpeFormMap}">
	            <tr>
	                <td colspan="2">无记录！</td>
	            </tr>
	        </c:if>
        </table>
	</div>
</div>
</body>
</html>
