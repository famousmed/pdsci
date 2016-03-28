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
<script type="text/javascript">

	function search() {
		jboxStartLoading();
		$("#searchForm").submit();
	}
	
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/irb/committee/list/user" />" method="post">
				<p>
					项目名称：
					<input type="text" name="projName" value="${param.projName}" class="xltext" />
					审查类别：
					<select class="xlselect" name="irbTypeId">
						<option value="">全部</option>
						<c:forEach items="${irbTypeEnumList }" var="irbType">
							<option value="${irbType.id }" <c:if test="${irbType.id==param.irbTypeId }">selected="selected"</c:if> >${irbType.scName }</option>
						</c:forEach>
					</select>
					会议日期：<input type="text" name="meetingDate"  class="ctime" style="width: 150px" value="${param.meetingDate }"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
					<input type="radio" id="reviewStatus1" name="reviewStatus" value="unreview" onclick="jboxStartLoading();$('#searchForm').submit();" <c:if test="${empty param.reviewStatus || 'unreview'==param.reviewStatus}"> checked </c:if>><label for="reviewStatus1">未审查&nbsp;</label>
					<input type="radio" id="reviewStatus2" name="reviewStatus" value="reviewed" onclick="jboxStartLoading();$('#searchForm').submit();" <c:if test="${'reviewed'==param.reviewStatus }"> checked </c:if>><label for="reviewStatus2">已审查&nbsp;</label>
					<input type="radio" id="reviewStatus3" name="reviewStatus" value="all" onclick="jboxStartLoading();$('#searchForm').submit();" <c:if test="${'all'==param.reviewStatus }"> checked </c:if>><label for="reviewStatus3">全部&nbsp;</label>
					<input type="button" value="查&nbsp;询" onclick="search()" class="search">
				</p>
			</form>
		</div>
		<table class="xllist">
			<thead>
				<tr>
					<c:if test="${GlobalConstant.FLAG_Y eq pdfn:getSysCfg('irb_projno_flag') }">
						<th width="10%" >项目编号</th>
					</c:if>
					<th width="25%" >项目名称</th>
					<th width="10%" >项目类别</th>
					<th width="10%" >伦理审查类别</th>
					<th width="10%" >专业组</th>
					<th width="10%" >主要研究者</th>
					<th width="10%" >审查结果</th>
					<th width="5%" >操作</th>
				</tr>
			</thead>
			<tbody>
			 <c:forEach items="${irbApplyList}" var="irb" >
					<tr>
						<c:if test="${GlobalConstant.FLAG_Y eq pdfn:getSysCfg('irb_projno_flag') }">
							<td>${irb.projNo }</td>
						</c:if>
						<td>${irb.projName }</td>
						<td>${irb.projSubTypeName }</td>
						<td>${irb.irbTypeName }</td>
						<td>${empty projMap[irb.projFlow]?"":projMap[irb.projFlow].applyDeptName }</td>
						<td>${empty projMap[irb.projFlow]?"":projMap[irb.projFlow].applyUserName }</td>
						<td>${irb.irbDecisionName}</td>
						<td>[<a href="<s:url value='/irb/committee/review/user'/>?irbFlow=${irb.irbFlow}">进入</a>]</td>
					</tr>
			</c:forEach>
			</tbody>
			<c:if test="${empty irbApplyList}"> 
				<tr> 
					<td align="center" colspan="8">无记录</td>
				</tr>
			</c:if>
		</table>
	</div>
</div>
</body>
</html>