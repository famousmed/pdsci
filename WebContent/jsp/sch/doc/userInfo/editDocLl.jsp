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

	
	
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
		<table class="xllist" style="width: 100%">
				<tr>
					<th  colspan="6" style="text-align: left;">&#12288;教育经历<span style="float: right;padding-right: 10px"><a href="javascript:void(0)"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addFile('projFileTb')"></img></a>&#12288;<a href="javascript:void(0)"><img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('projFileTb')"></img></a></span></th>
				</tr>
				<tr><th>开始时间</th><th>结束时间</th><th>毕业院校</th><th>专业</th><th>学历</th><th>学位</th></tr>
				<tr>
					<td width="100px">2008-09</td>
					<td width="100px">2014-09</td>
					<td>清华大学</td>
					<td>计算机科学与技术</td>
					<td>研究生</td>
					<td>硕士</td>
				</tr>
		</table>
		
		<table class="xllist" style="width: 100%;margin-top: 20px;">
				<tr>
					<th  colspan="6" style="text-align: left;">&#12288;工作经历<span style="float: right;padding-right: 10px"><a href="javascript:void(0)"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addFile('projFileTb')"></img></a>&#12288;<a href="javascript:void(0)"><img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('projFileTb')"></img></a></span></th>
				</tr>
				<tr><th>开始时间</th><th>结束时间</th><th>工作单位</th><th>工作专业</th><th>技术职称</th></tr>
				<tr>
					<td width="100px">2008-09</td>
					<td width="100px">2014-09</td>
					<td>南京品德信息</td>
					<td>软件开发</td>
					<td>程序员</td>
				</tr>
		</table>
		</div>
	</div>
</div>
</body>
</html>