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
</script>
</head>
<body>
<div class="title1 clearfix">
	<div class="content">
		<table class="xllist" width="600px">
			<thead>
				<tr>
					<td width="200px" >项目</td>
					<td style="text-align: left;">&#12288;<input type="text" style="width: 300px"/><img src="<s:url value='/css/skin/${skinPath}/images/search.gif'/>"/></td>
				</tr>
				<tr>
					<td >经费日期</td>
					<td style="text-align: left;">&#12288;<input type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></td>
				</tr>
				<tr>
					<td >经费类别</td>
					<td style="text-align: left;">&#12288;<select style="width: 135px">
							<option></option>
							<option>临床试验</option>
							<option>临床科研</option>
							<option>预算</option>
							<option>其他</option>
						</select>
					</td>
				</tr>
				<tr>
					<td >摘要及用途</td>
					<td style="text-align: left;">&#12288;<input type="text"/></td>
				</tr>
				<tr>
					<td  >金额</td>
					<td style="text-align: left;">&#12288;<input type="text"/></td>
				</tr>
			</tbody>
		</table>
		<div class="button" style="width: 600px;">
					<input type="button" class="search" value="保存" onclick="saveOrg();" />
					<input type="button" class="search" onclick="doClose();" value="关闭">
		</div>
	</div>
	</div>
</body>
</html>