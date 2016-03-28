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

	function search(){
		$("#searchForm").submit();
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="title1 clearfix">
				<form id="searchForm" action="<s:url value="/irb/committeeReview"/>" method="post">
				<p>
					&#12288;年度：
					<select id="year" name="year" onchange="search()" class="xlselect" style="width:120px;">
						<option value="2013" <c:if test="${param.year=='2013' || currYear=='2013'}"> selected="selected" </c:if> >2013</option>
						<option value="2014" <c:if test="${param.year=='2014'|| currYear=='2014'}"> selected="selected" </c:if> >2014</option>
						<option value="2015" <c:if test="${param.year=='2015' || currYear=='2015'}"> selected="selected" </c:if>>2015</option>
						<option value="2016" <c:if test="${param.year=='2016' || currYear=='2016'}"> selected="selected" </c:if>>2016</option>
					</select>
					伦理委员会：
					<select name="irbInfoFlow" class="xlselect" style="width: 200px;" onchange="search();">
						<c:forEach items="${irbInfoList}" var="irbInfo">
							<option value="${irbInfo.recordFlow}" 
								<c:if test="${irbInfo.recordFlow eq param.irbInfoFlow}">selected="selected"</c:if>
								>${irbInfo.irbName}</option>
						</c:forEach>
					</select>
				</p>
				</form>
		</div>
	<div class="content">
		<table class="xllist" >
				<tr>
					<th>委员姓名</th>
					<th>角色名称</th>
					<th>主审项目数</th>
					<th>参加会议数</th>
				</tr>
				<c:forEach items="${filterList}" var="infoUser">
					<tr >
						<td>${infoUser.userName}</td>
						<td>${infoUser.roleName}</td>
						<td>
							<c:if test="${empty irbUserMap[infoUser.userFlow].size()}">0</c:if>
							<c:if test="${! empty irbUserMap[infoUser.userFlow].size()}">${irbUserMap[infoUser.userFlow].size()}</c:if>
						</td>
						<td>
							<c:if test="${empty meetingUserMap[infoUser.userFlow].size()}">0</c:if>
							<c:if test="${! empty meetingUserMap[infoUser.userFlow].size()}">${meetingUserMap[infoUser.userFlow].size()}</c:if>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty filterList}"> 
				<tr> 
					<td align="center" colspan="4">无记录</td>
				</tr>
			</c:if>
			</tbody>
		</table>
	</div>
</div>
</body>
</html>