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
	function modPasswd() {
		if(false==$("#modPasswdForm").validationEngine("validate")){
			return ;
		}
		if($("#userPasswd").val()== $("#userPasswdNew").val()){
			alert("新密码不能与原密码相同,请重新输入");
			return ;
		}
		if($("#userPasswdNew").val()!= $("#userPasswdNew2").val()) {
			alert("两次密码输入不一致,请重新输入");
			return ;
		}
		var url = "<s:url value='/sys/user/savePasswd'/>";
		var data = $('#modPasswdForm').serialize();
		jboxPost(url, data, function() {
			jboxClose();
		});
	}
</script>
</head>
<body>
<form id="modPasswdForm">
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">
   		 		<table cellpadding="0" cellspacing="0" class="basic">
           			<tr>
                        <th width="250px;">原始密码：</th>
                        <td>
                            <input class="validate[required] xltext" id="userPasswd"  name="userPasswd" type="password" />
                        </td>
                    </tr>
                    <tr>
                        <th>请输入新密码：</th>
                        <td>
                            <input class="validate[required] xltext" id="userPasswdNew" name="userPasswdNew" type="password"/>                                         
                        </td>
                    </tr>
                    <tr>
                        <th>请再次输入新密码：</th>
                        <td>
                            <input class="validate[required] xltext" id="userPasswdNew2" name="userPasswdNew2" type="password">
                        </td>
                     </tr>
                </table>
				<div class="button">
					<input type="hidden" name="userFlow" value="${param.userFlow}" />
					<input type="button" value="保&#12288;存" class="search" onclick="modPasswd()" />
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>