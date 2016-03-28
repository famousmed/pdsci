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
function modPasswd(userFlow) {
	jboxOpen("<s:url value='/sys/user/modPasswd?userFlow='/>"
			+ userFlow, "修改密码", 500, 300);
}
function edit(userFlow) {
	jboxOpen("<s:url value='/sys/user/edit/${GlobalConstant.USER_LIST_PERSONAL}?userFlow='/>"
			+ userFlow, "修改个人信息", 900, 400);
}
function modMailPassword(userFlow) {
	jboxOpen("<s:url value='/sys/cfg/modMailPassword?userFlow='/>"
			+ userFlow, "登记邮箱密码", 500, 250);
}

function authUserEmail(userFlow){
	jboxPost("<s:url value='/sys/user/auth/authUserEmail'/>?userFlow="+userFlow,null,function(resp){
		var result = resp['result'];
		if(result=="${GlobalConstant.OPRE_SUCCESSED}"){
			jboxInfoBasic("<font style='font-weight: bold;font-size: 15px;'>系统已发送一封邮件到您的邮箱&nbsp;<font color='#ff8b0f'>"
			+resp['userEmail']+"</font></font><br/>请登录邮箱，点击认证链接完成认证.",470);
		} else {
			jboxTip("${GlobalConstant.OPRE_FAIL}");
		}
	},null,false);
}

function authUserPhone(userFlow){
	jboxOpen("<s:url value='/sys/user/auth/authUserPhoneMain?userFlow='/>"
			+ userFlow, "手机号认证", 600, 330);
}

function emailMain(userFlow){
	window.location.href="<s:url value='/sys/user/edit/emailMain?userFlow='/>"+ userFlow;
}

function phoneMain(userFlow){
	window.location.href="<s:url value='/sys/user/edit/phoneMain?userFlow='/>"+ userFlow;
}

</script>
<style>
.ss3{text-align: right;padding-right: 80px;width: 210px;}
</style>
</head>
<body>

<form id="sysUserForm" style="height: 100px;" >
<div class="content">
	<div class="title1 clearfix">		
		<table border="0" cellspacing="0" cellpadding="0" class="safe">
  			<tr>
   			 <td>
    			<div id="safe">
    				<div class="ss1">登陆密码：</div>
   					<div class="ss3"><a href="javascript:modPasswd('${sessionScope.currUser.userFlow}')">修改</a></div></div>
    				<div class="ss2">互联网账号存在被盗风险，建议您定期更改密码以保护账户安全。</div>
    			</div>
    		 </td>
  			</tr>
  			<tr>
   			 <td>
   			  <div id="safe">
    			<div class="ss1">邮箱：</div>
    			<div class="ss3">
    				<c:choose>
						<c:when test="${GlobalConstant.FLAG_N eq sysCfgMap['user_edit_mail']}">
							<font color="#000">${sessionScope.currUser.userEmailStatusDesc }</font>&nbsp;
							<c:if test="${empty sessionScope.currUser.userEmailStatusId or userEmailStatusEnumUnauth.id eq sessionScope.currUser.userEmailStatusId  }">
								<a href="javascript:authUserEmail('${ sessionScope.currUser.userFlow}')">认证</a>
							</c:if>
							<c:if test="${sessionScope.currWsId==GlobalConstant.ERP_WS_ID }">
								&nbsp;<a href="javascript:modMailPassword('${sessionScope.currUser.userFlow}')">登记邮箱密码</a>
							</c:if>
							&nbsp;<a href="javascript:emailMain('${ sessionScope.currUser.userFlow}')">修改</a>
						</c:when>
						<c:otherwise>
							<c:if test="${sessionScope.currWsId==GlobalConstant.ERP_WS_ID }">
								<a href="javascript:modMailPassword('${sessionScope.currUser.userFlow}')">登记邮箱密码</a>
							</c:if>
							&nbsp;<a href="javascript:edit('${ sessionScope.currUser.userFlow}')">修改</a>
						</c:otherwise>
					</c:choose>
    			</div></div>
    			<div class="ss2">您验证的邮箱：${sessionScope.currUser.userEmail}。 </div>
   			 </div>
   			</td>
  			</tr>
			<tr>
   			 <td>
   			   <div id="safe">
    				<div class="ss1">手机号：</div>
    			 	<div class="ss3">
    			 		<c:choose>
						<c:when test="${GlobalConstant.FLAG_N eq sysCfgMap['user_edit_phone']}">
							<font color="#000">${sessionScope.currUser.userPhoneStatusDesc }</font>&nbsp;
							<c:if test="${empty sessionScope.currUser.userPhoneStatusId or userPhoneStatusEnumUnauth.id eq sessionScope.currUser.userPhoneStatusId  }">
								<a href="javascript:authUserPhone('${ sessionScope.currUser.userFlow}')">认证</a>
							</c:if>
							&nbsp;<a href="javascript:phoneMain('${ sessionScope.currUser.userFlow}')">修改</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:edit('${ sessionScope.currUser.userFlow}')">修改</a>
						</c:otherwise>
					</c:choose>
    			 	</div></div>
    				<div class="ss2">您验证的手机：${sessionScope.currUser.userPhone} 若已丢失或停用，请立即更换，避免账户被盗。 </div>
   			   </div>
   			</td>
  			</tr>
		</table>
	</div>
</div>
</form>
</body>
</html>