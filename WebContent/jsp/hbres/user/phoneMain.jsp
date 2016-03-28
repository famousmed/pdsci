<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>安全中心</title>
<c:choose>
<c:when test="${GlobalConstant.RES_ROLE_SCOPE_DOCTOR eq param.source }">
<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
</c:when>
<c:otherwise>
	<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
</c:otherwise>
</c:choose>
<script>
function toggleOl(id) {
	var flag = true;
	$(".strategy_selected").each(function(){
		if ($(this).attr("id")==id) {
			flag = false;
		}
		$(".strategy_selected").removeClass("strategy_selected");
		$(this).toggle();
	});
	if (flag) {
		$("#"+id).addClass("strategy_selected");
		$("#"+id).toggle();
	}
}

function phoneAccMain() {
	var url = "<s:url value='/hbres/singup/user/phoneAccMain?userFlow=${user.userFlow}'/>&source=${param.source}";
	if ("${GlobalConstant.RES_ROLE_SCOPE_DOCTOR}" == "${param.source}") {
		window.location.href = url;
	} else {
		jboxLoad("content",url,true);
	}
}

function phoneSmsMain() {
	var url = "<s:url value='/hbres/singup/user/phoneSmsMain?userFlow=${user.userFlow}'/>&source=${param.source}";
	if ("${GlobalConstant.RES_ROLE_SCOPE_DOCTOR}" == "${param.source}") {
		window.location.href = url;
	} else {
		jboxLoad("content",url,true);
	}
}
</script>
</head>
<body>
<c:if test="${GlobalConstant.RES_ROLE_SCOPE_DOCTOR eq param.source }">
<div class="main_wrap">
    <div class="user-contain">
</c:if>
<div class="main_hd">
   <h2>修改手机号</h2>
</div>
<div class="main_bd">
    <div class="mobile-container">
	<div class="mobile-content">
		<p class="ft-14">请先确认当前绑定的手机号<span style="color: #F37800">&nbsp;${user.userPhone }&nbsp;</span>是否能接受短信，再选择修改方式：</p>
		<div class="choosemobile">
			<div class="choosemobile-item"  onclick="toggleOl('accountOl');">
			    <h3 class="ctitle">无法接收短信</h3>
			    <p class="descri">原手机号已丢失或停用，使用非手机身份验证方式修改</p>
			    <i class="icon"></i>
		 	</div>
		 	<ol class="select-strategy" style="display: none;" id="accountOl">
               <li class="fn-clear">
                    <i class="icon"></i>
                    <div class="descri">
                        <h3 class="ctitle">通过“验证账户信息+验证登录密码”</h3>
                    </div>
                    <div class="c-button">
                    	<a onclick="phoneAccMain();" class="btn_blue">立即修改</a>
                    </div>
                </li>
            </ol>
		 	<div class="choosemobile-item" onclick="toggleOl('smsOl');">
		        <h3 class="ctitle">能接收短信</h3>
		        <p class="descri">通过原手机号接收短信校验码的方式修改</p>
		        <i class="icon"></i>
    		</div>
    		<ol class="select-strategy" style="display:none ;" id="smsOl">
               <li class="fn-clear">
                    <i class="icon"></i>
                    <div class="descri">
                        <h3 class="ctitle">通过“验证短信+验证登录密码”</h3>
                    </div>
                    <div class="c-button">
                    	<a onclick="phoneSmsMain();" class="btn_blue">立即修改</a>
                    </div>
                </li>
            </ol>
		 </div>
	</div>
</div>
</div>
<c:if test="${GlobalConstant.RES_ROLE_SCOPE_DOCTOR eq param.source }">
  </div>
  </div>
</c:if>
</body>
</html>
