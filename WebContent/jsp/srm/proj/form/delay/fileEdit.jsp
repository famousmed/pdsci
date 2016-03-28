<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
	function doSave(){
		
		$('#fileForm').submit();
	}
	
	var callBack = function(result){
		if(result=="1"){
			jboxTip("保存成功");
			doClose();
		}else{
			jboxTip("保存失败");
		}
		
	};
	function refreshOpener(){
		window.parent.frames['mainIframe'].location.reload(true);
	}
	function doClose() {
		refreshOpener();
		jboxClose();
	}
</script>
</head>
<body>
	<form id="fileForm" action="<s:url value="saveFile"/>" method="post" enctype="multipart/form-data" target="screct_frame">
		<input type="hidden" name="projFlow" value="${param.projFlow}"/>
		<input type="hidden" name="recFlow" value="${param.projRecFlow}"/>
		<div>
			<table>
				<tbody>
					<tr>
						<td height="10px;"></td>
					</tr>
					<tr>
						<td>
							<p class="xixititle"></p>
							<table class="mation">
								<tr>
									<td class="mation-nab">附件名称：
										<input name="fileFlow"  type="hidden" value="${file.fileFlow}">
									</td>
									<td>
										<input class="validate[required] name" style="width: 200px" name="fileName" type="text" value="${file.fileName}"/>
									</td>
								</tr>
								<tr>
									<td class="mation-nab">附件内容：</td>
									<td>
										<input type="file" name="file" class="validate[required] " style="width: 200px"/>
									</td>
								</tr>
								<tr>
									<td class="mation-nab">备注：</td>
									<td>
									<input class="name" style="width: 500px" name="fileRemark" type="text" value="${file.fileRemark}" />
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<table class="hddata" align="center">
								<tr>
									<td><input class="xiugaidata" type="button" value="保存" onclick="doSave();" /></td>
									<td><input class="close" type="button" value="关闭" onclick="doClose();" /></td>
								</tr>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</form>
	
	<iframe name="screct_frame" style="display: none"></iframe>
</body>
</html>