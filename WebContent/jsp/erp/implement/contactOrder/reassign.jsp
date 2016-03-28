<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="true"/>
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
function saveReassign(){
	var deptFlow=$("#deptFlow").val();
	var tip="确认改派？";
		var url = "<s:url value='/erp/implement/saveReassign'/>?deptFlow="+deptFlow+"&receiveFlag=N";
		jboxConfirm(tip , function(){
			jboxPost(url , window.parent.frames['jbox-message-iframe'].$('#implementForm').serialize() , function(resp){
				if(resp!='${GlobalConstant.SAVE_FAIL}'){
					jboxTip('${GlobalConstant.OPRE_SUCCESSED}');
					window.parent.frames['mainIframe'].$("#checkContactFlow").val(resp);
					setTimeout(function(){
						window.parent.frames['mainIframe'].window.search();
						jboxCloseMessager();
					},1000);
				}else{
					jboxTip('${GlobalConstant.OPRE_FAIL}');
				}
			} , null, false);
		});
}
</script>
</head>
<body>
         <form style="position: relative;" id="reassignForm">
             <input type="hidden" name="contactFlow" value="${contactFlow }"/>
			<table width="100%" cellpadding="0" cellspacing="0" class="basic">
				<colgroup>
					<col width="30%"/>
					<col width="70%"/>
				</colgroup>
				<tr>
					<td style="text-align: right;padding-right: 10px;">改派部门：</td>
					<td>
						<select id="deptFlow" name="deptFlow" class="validate[required]">
							<option value="">请选择</option>
							<c:forEach var="dept" items="${deptList }">
								<option value="${dept.deptFlow }">${dept.deptName }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
			</table>
		  </form>
			<div class="button">
				<input type="button" value="确&#12288;定" onclick="saveReassign();" class="search"/>
		       	<input type="button" value="关&#12288;闭" onclick="jboxClose();" class="search"/>
		    </div>
</body>
</html>