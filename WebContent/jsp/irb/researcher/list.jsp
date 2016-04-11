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

	function apply(){
		jboxConfirm("确认新增伦理审查申请？" ,function(){
			window.location.href="<s:url value='/irb/researcher/applyMain'/>?roleScope=${roleScope}";
		});
	}
	$(document).ready(function(){
		$("#count").html('${fn:length(projList)}');
	});
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<p style="text-align: left;font-size: 16px;">
				${sessionScope.currUser.userName},您目前承担的项目数为：<span id="count" style="color: red"></span>&#12288;如需添加新项目请点击右侧"初始审查申请"按钮
				(申请成功后项目会显示在下方列表当中).
				<input type="button" class="search" style="width: 100px;float: right" onclick="apply();" value="初始审查申请">&#12288;
			</p>
		</div>
		<table class="xllist">
			<thead>
				<tr>
					<th width="5%" >序号</th>
					<c:if test="${GlobalConstant.FLAG_Y eq pdfn:getSysCfg('irb_projno_flag') }">
						<th width="10%" >项目编号</th>
					</c:if>
					<th width="25%" >项目名称</th>
					<th width="15%" >项目类别</th>
					<th width="15%" >项目来源</th>
					<th width="10%" >批件日期</th>
					<th width="10%" >批件有效期</th>
					<th width="10%" >跟踪审查日期</th>
					<th width="5%" >操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${projList }" var="proj" varStatus="vs">
					<tr>
						<td>${vs.count }</td>
						<c:if test="${GlobalConstant.FLAG_Y eq pdfn:getSysCfg('irb_projno_flag') }">
							<td>${proj.projNo }</td>
						</c:if>
						<td>${proj.projShortName }</td>
						<td>${proj.projSubTypeName }</td>
						<td>${proj.projShortDeclarer}</td>
						<td>${pdfn:split(irbDateMap[proj.projFlow],"_")[0] }</td>
						<td>${pdfn:split(irbDateMap[proj.projFlow],"_")[1] }${empty pdfn:split(irbDateMap[proj.projFlow],"_")[1]?"": "个月"}</td>
						<td>${pdfn:split(irbDateMap[proj.projFlow],"_")[2] }</td>
						<td>[<a href="<s:url value='/irb/researcher/process'/>?projFlow=${proj.projFlow}&roleScope=${roleScope}">进入</a>]</td>
					</tr>
				</c:forEach>
			</tbody>
			<c:if test="${projList == null || projList.size() == 0 }"> 
				<tr> 
					<td align="center" colspan="9">无记录</td>
				</tr>
			</c:if>
		</table>
	</div>
</div>
</body>
</html>