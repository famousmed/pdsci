<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
	function checkPasswd(){
		var userPasswd2 = $("input[name='userPasswd2']").val();
		var userPasswd3 = $("input[name='userPasswd3']").val();
		if(userPasswd2 != "" && userPasswd3 != ""){
			if(userPasswd2 != userPasswd3){
				jboxTip("新密码与确认新密码不一致！");
				$("input[name='userPasswd3']").focus();
			}
		}
	}

	function saveUserPasswd(){
		if(false == $("#passwdForm").validationEngine("validate")){
			return false;
		}
		jboxConfirm("确认修改密码?" ,  function(){
			var url = "<s:url value='/njmuedu/user/saveUserPasswd'/>";
			jboxPost(url,$("#passwdForm").serialize(),
					function(resp){
						if(resp == "${GlobalConstant.PASSWD_ERROR}"){
							jboxTip(resp);
						}
						if(resp == "${GlobalConstant.OPRE_SUCCESSED}"){
							jboxTip(resp);
							loadSetUserPasswd();
						}
					},null,false);
		});
	}
</script>
<div class="right fr" style="margin-top: 10px;">
	<h3>修改密码</h3>
	<form id="passwdForm" action="<s:url value='/njmuedu/user/saveUserPasswd'/>" style="position: relative;" method="post">
	<input type="hidden" name="userFlow" value="${sessionScope.currUser.userFlow}"/>
    <table width="372" border="0">
      <tr>
        <td class="txtinfo" colspan="2">原密码</td>
      </tr>
      <tr>
        <td colspan="2"><input class="txt validate[required]" type="password" name="userPasswd"  value=""/></td>
      </tr>
      <tr>
        <td class="txtinfo" colspan="2">新密码</td>
      </tr>
      <tr>
        <td colspan="2"><input class="txt validate[required,minSize[6],maxSize[16]]" type="password" name="userPasswd2" placeholder="新密码（6-16位字母、数字或符号的组合）" onchange="checkPasswd()" value=""/></td>
      </tr>
      <tr>
        <td class="txtinfo" colspan="2">确认新密码</td>
      </tr>
      <tr>
        <td colspan="2"><input class="txt validate[required,minSize[6],maxSize[16]]" type="password" name="userPasswd3" placeholder="确认新密码（6-16位字母、数字或符号的组合）" onchange="checkPasswd()" value=""/></td>
      </tr>
      <tr>
      	<td><input type="button" class="btn" value="修&nbsp;&nbsp;改" onclick="saveUserPasswd();"/></td>
        </tr>
      </table>
</form>
  </div>