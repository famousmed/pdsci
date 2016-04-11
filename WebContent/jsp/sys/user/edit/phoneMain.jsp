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
	window.location.href="<s:url value='/sys/user/edit/phoneAccMain?userFlow=${user.userFlow}'/>";
}

function phoneSmsMain() {
	window.location.href="<s:url value='/sys/user/edit/phoneSmsMain?userFlow=${user.userFlow}'/>";
}
</script>
<style>
body {
margin: 0;
padding: 0;
background-color: #f9f9f9;
color: #4D4D4F;
}

</style>
</head>
<body>
<div class="mobile-head">
	<div class="logo-title">修改手机</div>
</div>
<div class="container">
	<div class="mobile-content">
		<p class="ft-14">请先确认当前绑定的手机号<span style="color: #F37800">&nbsp;${user.userPhone }&nbsp;</span>是否能接受短信，再选择修改方式：</p>
		<div class="choosemobile">
			<div class="choosemobile-item"  onclick="toggleOl('accountOl');">
			    <h3 class="ctitle">无法接收短信</h3>
			    <p class="desc">原手机号已丢失或停用，使用非手机身份验证方式修改</p>
			    <i class="icon"></i>
		 	</div>
		 	<ol class="select-strategy" style="display: none;" id="accountOl">
               <li class="fn-clear">
                    <i class="icon"></i>
                    <div class="desc">
                        <h3 class="ctitle">通过“验证账户信息+验证登录密码”</h3>
                    </div>
                    <div class="c-button">
                    	<input class="search" id="authBtn" type="button" value="立即修改" onclick="phoneAccMain();" />
                    </div>
                </li>
            </ol>
		 	<div class="choosemobile-item" onclick="toggleOl('smsOl');">
		        <h3 class="ctitle">能接收短信</h3>
		        <p class="desc">通过原手机号接收短信校验码的方式修改</p>
		        <i class="icon"></i>
    		</div>
    		<ol class="select-strategy" style="display:none ;" id="smsOl">
               <li class="fn-clear">
                    <i class="icon"></i>
                    <div class="desc">
                        <h3 class="ctitle">通过“验证短信+验证登录密码”</h3>
                    </div>
                    <div class="c-button">
                    	<input class="search" id="authBtn" type="button" value="立即修改" onclick="phoneSmsMain();" />
                    </div>
                </li>
            </ol>
		 </div>
	</div>
</div>
</body>
</html>