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
	function reviewList(projFlow){
		jboxOpen("<s:url value='/irb/secretary/reviewList'/>?projFlow="+projFlow,"伦理审查记录", 870,400);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<p>
			注：<font color="blue">蓝色</font>为距跟踪审查日期${pdfn:getSysCfg('irb_track_remaind') }天内的项目；<font color="red">红色</font> 为超过跟踪审查日期的项目
			</p>
		</div>
		<table class="xllist">
			<thead>
				<tr>
					<c:if test="${GlobalConstant.FLAG_Y eq pdfn:getSysCfg('irb_projno_flag') }">
						<th width="10%" >项目编号</th>
					</c:if>
					<th width="25%" >项目名称</th>
					<th width="15%" >项目类别</th>
					<th width="10%" >主要研究者</th>
					<th width="10%" >审查记录</th>
					<th width="10%" >跟踪审查日期</th>
				</tr>
			</thead> 
			<tbody>
				<c:forEach items="${pjFlowList}" var="projFlow">
					<tr
					<c:if test="${trackMap[irbMap[projFlow].irbFlow]==GlobalConstant.FLAG_N}"> style="background-color:#FFD2D2" </c:if>
					<c:if test="${trackMap[irbMap[projFlow].irbFlow]==GlobalConstant.FLAG_Y}"> style="background-color:#97CBFF" </c:if>
					>
						<c:if test="${GlobalConstant.FLAG_Y eq pdfn:getSysCfg('irb_projno_flag') }">
							<td>${projMap[projFlow].projNo }</td>
						</c:if>
						<td>${projMap[projFlow].projName }</td>
						<td>${projMap[projFlow].projCategoryName }-${projMap[projFlow].projSubTypeName }</td>
						<td>${projMap[projFlow].applyUserName }</td>
						<td>[<a href="javascript:reviewList('${projFlow }');">审查记录</a>]</td>
						<td>${irbMap[projFlow].trackDate }</td>
					</tr>
				</c:forEach>
			</tbody>
			<c:if test="${pjFlowList == null || pjFlowList.size()==0 }"> 
					<tr> 
						<td align="center" colspan="6">无记录</td>
					</tr>
			</c:if>
		</table>
	</div>
</div>
</body>
</html>