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
function doClose() 
{
	jboxClose();
}
function showDetail(){
	$("#detailTable").slideToggle("slow");
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
<div class="title1 clearfix">
		<table class="xllist" width="450px">
				<tr>
					<th colspan="3" align="left">&#12288;快审主审综合意见</th>
				</tr>
				<tr>
					<td width="150px">伦理委员会名称：</td><td colspan="2">研究伦理委员会</td>
				</tr>
				<tr>
					<td>项目名称：</td><td colspan="2">喉返神经损伤、再支配机制的实验研究</td>
				</tr>
				<tr>
					<th>主审委员</th><th>审查意见</th><th>审查工作表</th>
				</tr>
				<tr>
					<td width="150px">张林：方案</td><td>同意</td><td>[<a href="#">审查工作表</a>]</td>
				</tr>
				<tr>
					<td width="150px">孙辉：知情同意</td><td >做必要修改后同意</td><td>[<a href="#">审查工作表</a>]</td>
				</tr>
				<tr>
					<td width="150px">审查流程</td><td colspan="2" style="text-align: left;">&#12288;<select style="width: 200px"><option></option>
					<option>提交会议报告</option>
					<option>提交会议审查</option></select></td>
				</tr>
				<tr>
					<td width="150px">秘书签字</td><td colspan="2" style="text-align: left;">&#12288;<input type="text" style="width: 200px"/></td>
				</tr>
				<tr>
					<td width="150px">日期</td><td colspan="2" style="text-align: left;">&#12288;<input type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 200px"/></td>
				</tr>
		</table>
		<div class="button" style="width: 450px;">
		</div>
	</div>
	</div></div>
</body>
</html>