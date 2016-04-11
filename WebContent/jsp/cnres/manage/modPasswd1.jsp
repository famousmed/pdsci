<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
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
		jboxPost(url, data, function(resp) {
			window.parent.jboxTip(resp);
			jboxClose();
		}, null , false);
	}
</script>
</head>
<body>
<form id="modPasswdForm">
			<div style="padding-top: 50px;padding-left: 30px;">
   		 		<table>
           			<tr>
                        <th style="text-align: right;line-height: 40px;"><span style="color:red;">*&nbsp;&nbsp;</span>当前密码：</th>
                        <td style="text-align: left;">
                            <input style="width: 200px;" class="validate[required] input" id="userPasswd"  name="userPasswd" type="password" />
                        </td>
                    </tr>
                    <tr>
                        <th style="text-align: right;line-height: 40px;"><span style="color:red;">*&nbsp;&nbsp;</span>新密码：</th>
                        <td style="text-align: left;">
                            <input style="width: 200px;" class="validate[required] input" id="userPasswdNew" name="userPasswdNew" type="password"/>                                         
                        </td>
                    </tr>
                    <tr>
                        <th style="text-align: right;line-height: 40px;"><span style="color:red;">*&nbsp;&nbsp;</span>确认新密码：</th>
                        <td style="text-align: left;">
                            <input style="width: 200px;" class="validate[required] input" id="userPasswdNew2" name="userPasswdNew2" type="password">
                        </td>
                     </tr>
                </table>
				<div style="padding-left: 170px;padding-top:10px;">
					<input type="hidden" name="userFlow" value="${param.userFlow}" />
					<input type="button" value="确&nbsp;认" class="btn" onclick="modPasswd()" />
				</div>
			</div>
</form>
</body>
</html>