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

	function searchProj() {
		jboxStartLoading();
		$("#searchForm").submit();
	}
	
	
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" 
				method="post">
				<p>
					项目编号：<input type="text" name="projNo" value="${param.projNo}" class="xltext" style="width: 150px" />
					项目名称：
					<input type="text" name="projName" value="${param.projName}" class="xltext" style="width:250px" />
					审查类别：
					<select class="xlselect">
						<option></option>
						<c:forEach items="${irbTypeEnumList }" var="irbType">
							<option>${irbType.name }</option>
						</c:forEach>
					</select>
				</p>
			</form>
		</div>
		<table class="xllist">
			<thead>
				<tr>
					<th width="10%" >项目编号</th>
					<th width="25%" >项目名称</th>
					<th width="15%" >项目类别</th>
					<th width="10%" >伦理审查类别</th>
					<th width="10%" >主要研究者</th>
					<th width="10%" >受理日期</th>
					<th width="5%" >操作</th>
				</tr>
			</thead>
			<tbody>
					<tr>
						<td>2014-KY-0510</td>
						<td>喉返神经损伤、再支配机制的实验研究</td>
						<td>临床科研</td>
						<td>初始审查申请</td>
						<td>方琪</td>
						<td>2014-01-20</td>
						<td>[<a href="<s:url value='/irb/secretary/review'/>">进入</a>]</td>
					</tr>
					<tr>
						<td>2014-YW-0310</td>
						<td>硫化氢对腹膜透析腹膜纤维化的干预作用及机制研究</td>
						<td>药物试验-II期</td>
						<td>研究进展报告</td>
						<td>阮天晴</td>
						<td>2014-01-23</td>
						<td>[<a href="<s:url value='/irb/secretary/review'/>">进入</a>]</td>
					</tr>
			</tbody>
		</table>
	</div>
</div>
</body>
</html>