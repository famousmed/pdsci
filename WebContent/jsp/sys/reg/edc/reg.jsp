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
	function doRegister(){
		if(false==$("#regForm").validationEngine("validate")){
			return ;
		}
		var url = "<s:url value='/reg/edc/saveReg'/>";
		var data = $('#regForm').serialize();
		jboxPost(url, data, function(resp) {
			if('${GlobalConstant.USER_REG_SUCCESSED}'==resp){				
				jboxClose();		
				window.setTimeout(function () {window.location.href="<s:url value='/reg/edc/success'/>";},1000);	
			}
		});
		
	}
</script>
</head>

<body>
<div id="register">
   <div id="logo"><img src="<s:url value='/css/skin/${skinPath}/images/edc_head.png'/>" /></div>
</div>
<div class="mainright">
  <div id="content">
	<h1 class="reg_title">信息注册</h1>
    <p class="line">如已拥有帐户信息，则<a href="<s:url value='/index.jsp'/>" class="line_c">在此登录</a></p>
    <div class="quyu clearfix">
    	<dl>    		
			<form id="regForm" name="regForm" action="<s:url value='/reg/edc/saveReg'/>" style="position:relative;">
	            <dt class="dt_l">用户名：</dt>
	            <dd class="dd_r clearfix"><input name="userCode" type="text" class="<c:if test="${!(sysCfgMap['sys_user_check_user_code'] eq GlobalConstant.FLAG_N)}">validate[required,custom[userCode]]</c:if> input_kuang address" />
	                  <span class="check_tips succ_tips">以字母开头,长度6-18,只能包含字符、数字和下划线</span></dd>
	            <dt class="dt_l">姓名：</dt>
	            <dd class="dd_r clearfix"><input name="userName" type="text" class="validate[required,custom[chinese]] input_kuang address" />
	                  <span class="check_tips succ_tips">填写提供给项目管理员的姓名</span></dd>
	            <dt class="dt_l">性别：</dt>            
	            <dd class="radio clearfix">
						<input id="${userSexEnumMan.id }" type="radio" name="sexId"  value="${userSexEnumMan.id }" <c:if test="${userSexEnumMan.id == sysUser.sexId}">checked</c:if> />
		                 &#12288;<label for="${userSexEnumMan.id }">${userSexEnumMan.name}</label>&#12288;&#12288;
		                 <input id="${userSexEnumWoman.id }" type="radio"  name="sexId" value="${userSexEnumWoman.id }" <c:if test="${userSexEnumWoman.id == sysUser.sexId}">checked</c:if> />
		                 &#12288;<label for="${userSexEnumWoman.id }">${userSexEnumWoman.name }</label>            	
	                <span class="check_tips"></span></dd>
	            <dt class="dt_l">身份证号：</dt>
	            <dd class="dd_r clearfix"><input name="idNo" type="text" class="validate[required,custom[chinaIdLoose]] input_kuang address" />
	                  <span class="check_tips">填写提供给项目管理员的身份证号</span></dd>
	            <dt class="dt_l">手机号：</dt>
	            <dd class="dd_r clearfix"><input name="userPhone" type="text" class="validate[required,custom[mobile]] input_kuang address" />
	                  <span class="check_tips succ_tips">填写提供给项目管理员的手机号</span></dd>
	            <dt class="dt_l">Email：</dt>
	            <dd class="dd_r clearfix"><input name="userEmail" type="text" class="validate[required,custom[email]] input_kuang address" />
	                  <span class="check_tips">填写提供给项目管理员的Email</span></dd>
	            <dt class="dt_l">设置密码：</dt>
	            <dd class="dd_r clearfix"><input id="userPasswd" name="userPasswd" type="password" class="validate[required,custom[password]] input_kuang address" />
	                  <span class="check_tips">密码长度8~20位，数字、字母、字符至少包含两种</span></dd>
	            <dt class="dt_l">确认密码：</dt>
	            <dd class="dd_r clearfix"><input name="userPasswd2" type="password" class="validate[required,equals[userPasswd]] input_kuang address" />
	                  <span class="check_tips">密码长度8~20位，数字、字母、字符至少包含两种</span></dd>
	            <dt class="dt_l">&nbsp;</dt>
	  		   <dd class="dd_r clearfix">点击“立即注册”，表明您同意并愿意遵守<a href="#" class="line_c">用户协议</a>及<a href="#" class="line_c">隐私保护</a></dd>
	           <dt class="dt_l">&nbsp;</dt>
	  		   <dd class="dd_r clearfix">
	             <div class="sub_login">
					<input type="hidden" name="userFlow" value="${sysUser.userFlow }"/>
	             	<input class="no_bg" type="button" value="立即注册" onclick="doRegister();"/>
	             </div></dd>
			</form>
        </dl>
    </div>
</div>

<div id="footer"></div>
</div>
</body>
</html>
