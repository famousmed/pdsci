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
function showDlgw(){
	$("#dlgwTr").show(500);
}
function hideDlgw(){
	$("#dlgwTr").hide(500);
}
</script>
</head>
<body>
<div class="title1 clearfix">
	<div class="content">
		<table class="xllist" width="600px">
			<thead>
				<tr>
					<th  colspan="2" align="left">选择主审委员/独立顾问</th>
				</tr>
				<tr>
					<td width="200px" >主审委员：方案</td>
					<td style="text-align: left;">&#12288;<select style="width: 100px">
						<option></option>
						<option>沈海琦</option>
						<option>马振华</option>
						<option>陈亚新</option>
						<option>刘晓东</option>
					</select></td>
				</tr>
				<tr>
					<td width="200px" >主审委员：知情同意</td>
					<td style="text-align: left;">&#12288;<select style="width: 100px">
						<option></option>
						<option>沈海琦</option>
						<option>马振华</option>
						<option>陈亚新</option>
						<option>刘晓东</option>
					</select></td>
				</tr>
				<tr>
					<td width="200px" >独立顾问</td>
					<td style="text-align: left;">&#12288;<input type="radio" name="dlgw" checked="checked" id="dlgw0"  onclick="hideDlgw();"><label for="dlgw0">无&#12288;</label><input type="radio" onclick="showDlgw();" id="dlgw1" name="dlgw"><label for="dlgw1">有</label></td>
				</tr>
				<tr style="display: none" id="dlgwTr">
					<td  colspan="2" style="text-align: left">&#12288;姓&#12288;&#12288;名：<input type="text" style="width: 100px">&#12288;<img src="<s:url value='/css/skin/${skinPath}/images/search.gif'/>"/>
					<p>&#12288;咨询问题：<textarea rows="3" style="width: 250px"></textarea></p>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="button" style="width: 400px;">
					<input type="button" class="search" value="保存" onclick="saveOrg();" />
					<input type="button" class="search" onclick="doClose();" value="关闭">
		</div>
	</div>
	</div>
</body>
</html>