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
	function saveApply() {
		if(false==$("#sysApplyForm").validationEngine("validate")){
			return ;
		}
	}
</script>
</head>
<body>

<form id="sysApplyForm" style="padding-left: 30px;height: 100px;" >
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">
				<table width="800" cellpadding="0" cellspacing="0" class="basic">
					<tr>
						<th width="20%">课题题目：</th>
						<td width="80%" colspan="3">
							<input class="validate[required] xltext" style="width: 380px;" name="idNo" type="text" value="${sysApply.idNo}" >
						</td>
					</tr>
					<tr>
						<th width="20%">实验人员：</th>
						<td width="30%">
							<input class="validate[required] xltext" name="idNo" type="text" value="${sysApply.idNo}" >
						</td>
						<th width="20%">联系电话：</th>
						<td width="30%">
							<input class="validate[required] xltext" name="idNo" type="text" value="${sysApply.idNo}" >
						</td>
					</tr>
					<tr>
						<th width="20%">导师：</th>
						<td width="30%">
							<input class="validate[required] xltext" name="idNo" type="text" value="${sysApply.idNo}" >
						</td>
						<th width="20%">联系电话：</th>
						<td width="30%">
							<input class="validate[required] xltext" name="idNo" type="text" value="${sysApply.idNo}" >
						</td>
					</tr>
					<tr>
						<th>科室：</th>
						<td>
							<input class="validate[required] xltext" name="userName" type="text" value="${sysApply.userName}" >
						</td>
						<th>其它：</th>
						<td>
							<input class="validate[required] xltext" name="userName" type="text" value="${sysApply.userName}" >
						</td>
					</tr>					
					<tr>
						<th>开始时间：</th>
						<td>
							<input class="validate[required] xltext" name="userPhone" type="text" value="${sysApply.userPhone}" >
						</td>
						<th>结束时间：</th>
						<td>
							<input class="validate[required] xltext" name="userEmail" type="text" value="${sysApply.userEmail}" >
						</td>
					</tr>				
					<tr>
						<th>动物：</th>
						<td>
							<input class="validate[required] xltext" name="userPhone" type="text" value="${sysApply.userPhone}" >
						</td>
						<th>品系/数量：</th>
						<td>
							<input class="validate[required] xltext" style="width: 60px" name="userEmail" type="text" value="${sysApply.userEmail}" >/
							<input class="validate[required] xltext" style="width: 30px" name="userEmail" type="text" value="${sysApply.userEmail}" >
						</td>
					</tr>			
					<tr>
						<th>许可证编号：</th>
						<td>
							<input class="validate[required] xltext" name="userPhone" type="text" value="${sysApply.userPhone}" >
						</td>
						<th>合格证编号：</th>
						<td>
							<input class="validate[required] xltext" name="userPhone" type="text" value="${sysApply.userPhone}" >
						</td>
					</tr>			
					<tr>
						<th>实验内容：</th>
						<td colspan="3">
							<textarea class="validate[required]" name="userPhone" value="${sysApply.userPhone}" cols="100" rows="5" ></textarea>
						</td>
					</tr>
				</table>
				<div class="button" style="width: 800px;">
					<input class="search" type="button" value="保&#12288;存" onclick="saveUser();" />
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>