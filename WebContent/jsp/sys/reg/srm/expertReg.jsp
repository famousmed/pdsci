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
$(document).ready(function(){
	$("#orgFlow").scombobox({
		forbidInvalid : true,
		invalidAsValue : true,
		expandOnFocus : false
	});
	$(".scombobox-display").addClass("validate[required]");
	$(".scombobox-list").css("margin-top","40px");
});

function operate(op){
	if(op=="_prev"){
		$("#regForm").validationEngine("detach");	
		var action = $("#regForm").attr('action');
		action+='?'+op;
		$("#regForm").attr('action' , action);
		$('#regForm').submit();
	}else{
		if($("#orgFlow option:selected").val()=='请选择'){
			jboxTip("请选择您所在的机构");
			$(".scombobox-display").focus();
			return false;
		}
		jboxConfirm("确认注册的机构是:"+$("#orgFlow option:selected").text()+"?" , function(){
			$('#prev').attr({"disabled":"disabled"});
			$('#finish').attr({"disabled":"disabled"});
			jboxStartLoading();
			var action = $("#regForm").attr('action');
			action+='?'+op;
			$("#regForm").attr('action' , action);
			$('#regForm').submit();
		});
	}
	
	
}
</script>
<style>
body,html{
	overflow:hidden;
	position:relative;
}
</style>
</head>

<body>
<div id="register">
   <div id="logo"><img src="<s:url value='/css/skin/${skinPath}/images/tleft.png'/>" /></div>
</div>
<div class="mainright">
  <div id="content">
	<h1 class="reg_title">专家信息注册</h1>
    <p class="line">如已拥有帐户信息，则<a href="<s:url value='/index.jsp'/>" class="line_c">在此登录</a></p>
    <p style="color: red">${requestScope.eroMsg}</p>
    <div class="quyu clearfix">
    <form id="regForm" name="regForm" action="<s:url value='/reg/srm/regist'/>" style="" method="post">
    	<dl>			
			 <dt class="dt_l">用户名：</dt>
	            <dd class="dd_r clearfix"><input name="user.userCode" value="${form.user.userCode}" type="text" class="validate[required,custom[userCode]] input_kuang address" />
	                  <span class="check_tips succ_tips" style="padding-left: 0px;"><b style="color: red;padding: 0px;margin: 0px;">*</b>以字母开头,长度6-18,只能包含字符、数字和下划线</span></dd>
	            <dt class="dt_l">姓名：</dt>
	            <dd class="dd_r clearfix"><input name="user.userName" value="${form.user.userName}" type="text" class="validate[required,custom[chinese]] input_kuang address" />
	                  <span class="check_tips succ_tips" style="padding-left: 0px;"><b style="color: red;padding: 0px;margin: 0px;">*</b>姓名</span></dd>
	            <dt class="dt_l">性别：</dt>            
	            <dd class="radio clearfix">
						 <input id="${userSexEnumMan.id }" type="radio" name="user.sexId"  value="${userSexEnumMan.id }" <c:if test="${userSexEnumMan.id == form.user.sexId}">checked</c:if> />
		                 <label for="${userSexEnumMan.id }">${userSexEnumMan.name}</label>&#12288;&#12288;
		                 <input id="${userSexEnumWoman.id }" type="radio"  name="user.sexId" value="${userSexEnumWoman.id }" <c:if test="${userSexEnumWoman.id == form.user.sexId}">checked</c:if> />
		                 <label for="${userSexEnumWoman.id }">${userSexEnumWoman.name }</label>            	
	                <span class="check_tips"><b style="color: red;margin-left: 130px;">*</b></span></dd>
	            <dt class="dt_l">身份证号：</dt>
	            <dd class="dd_r clearfix"><input name="user.idNo" value="${form.user.idNo}" type="text" class="validate[required,custom[chinaIdLoose]] input_kuang address" />
	                  <span class="check_tips" style="padding-left: 0px;"><b style="color: red;padding: 0px;margin: 0px;">*</b>身份证号</span></dd>
	            <dt class="dt_l">手机号：</dt>
	            <dd class="dd_r clearfix"><input name="user.userPhone" value="${form.user.userPhone}" type="text" class="validate[required,custom[mobile]] input_kuang address" />
	                  <span class="check_tips succ_tips" style="padding-left: 0px;"><b style="color: red;padding: 0px;margin: 0px;">*</b>手机号</span></dd>
	            <dt class="dt_l">Email：</dt>
	            <dd class="dd_r clearfix"><input name="user.userEmail" value="${form.user.userEmail}" type="text" class="validate[required,custom[email]] input_kuang address" />
	                  <span class="check_tips" style="padding-left: 0px;"><b style="color: red;padding: 0px;margin: 0px;">*</b>Email</span></dd>
	            <dt class="dt_l">设置密码：</dt>
	            <dd class="dd_r clearfix"><input id="userPasswd" name="user.userPasswd" value="${form.user.userPasswd}" type="password" class="validate[required,custom[password]] input_kuang address" />
	                  <span class="check_tips" style="padding-left: 0px;"><b style="color: red;padding: 0px;margin: 0px;">*</b>密码长度8~20位，数字、字母、字符至少包含两种</span></dd>
	            <dt class="dt_l">确认密码：</dt>
	            <dd class="dd_r clearfix"><input name="userPasswd2" type="password" value="${form.user.userPasswd}" class="validate[required,equals[userPasswd]] input_kuang address" data-errormessage-pattern-mismatch="密码设置不一致"/>
	                  <span class="check_tips" style="padding-left: 0px;"><b style="color: red;padding: 0px;margin: 0px;">*</b>密码长度8~20位，数字、字母、字符至少包含两种</span></dd>
	            <dt class="dt_l">所在机构：</dt>
	            <dd class="dd_r clearfix">
	            		<select class="validate[required] input_kuang address" name="user.orgFlow" id="orgFlow" style="80px;">
							<option value="请选择">请检索</option>
							<c:forEach var="sysOrg" items="${applicationScope.sysOrgList}">
							<option value="${sysOrg.orgFlow}" <c:if test="${sysOrg.orgFlow==form.user.orgFlow}">selected</c:if>>${sysOrg.orgName}</option>
							</c:forEach>
						</select>
						<b style="color: red;margin-left: 10px;">*<font color="red">支持按中文字检索</font></b>
				</dd>
			<dt class="dt_l">毕业院校：</dt>
	        <dd class="dd_r clearfix">
	        	<input name="expert.graduateSchool" value="${form.expert.graduateSchool}" class="validate[required] input_kuang address"/>
	        	<span class="check_tips succ_tips" style="padding-left: 0px;"><b style="color: red;padding: 0px;margin: 0px;">*</b>不能超过50个字</span>
	        </dd>
	        <dt class="dt_l">工作年份：</dt>
	        <dd class="dd_r clearfix">
	        	<input name="expert.beginWorkYear" value="${form.expert.beginWorkYear}"  class="validate[required] input_kuang address ctime" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})"/>
	       		<b style="color: red;margin-left: 10px;">*</b>
	        </dd>
	        <dt class="dt_l">传真：</dt>
	        <dd class="dd_r clearfix">
	        	<input name="expert.fax" value="${form.expert.fax}" class="validate[required] input_kuang address"/>
	        	<span class="check_tips succ_tips" style="padding-left: 0px;"><b style="color: red;padding: 0px;margin: 0px;">*</b>不能超过20个数字</span>
	        </dd>
	        <dt class="dt_l">专业：</dt>
	        <dd class="dd_r clearfix">
	        	<input name="expert.majorName" value="${form.expert.majorName}" class="validate[required] input_kuang address"/>
	        	<span class="check_tips succ_tips" style="padding-left: 0px;"><b style="color: red;padding: 0px;margin: 0px;">*</b>专业</span>
	        </dd>
	        <dt class="dt_l">学历：</dt>
	        <dd class="dd_r clearfix">
	        	<select name="user.educationId" class="validate[required] input_kuang address" style="80px">
	        		<option value="">请选择</option>
	        		<c:forEach items="${dictTypeEnumUserEducationList}" var="education">
	        			<option value="${education.dictId}" <c:if test='${form.user.educationId==education.dictId}'>selected="selected"</c:if>>${education.dictName}</option>
	        		</c:forEach>
	        	</select>
	        	<b style="color: red;margin-left: 10px;">*</b>
	        </dd>
	        <dt class="dt_l">单位职务：</dt>
	        <dd class="dd_r clearfix">
        		<select name="user.postId" class="validate[required] input_kuang address">
					<option value=''>请选择</option>
					<c:forEach items="${dictTypeEnumUserPostList}" var='dict'>
						<option value='${dict.dictId}' <c:if test='${form.user.postId eq dict.dictId}'>selected="selected"</c:if> >${dict.dictName}</option>
					</c:forEach>
				</select>
				<b style="color: red;margin-left: 10px;">*</b>
	        </dd>
	        <dt class="dt_l">联系地址：</dt>
	        <dd class="dd_r clearfix">
	        	<input name="expert.address" value="${form.expert.address}" class="validate[required] input_kuang address"/>
	        	<span class="check_tips succ_tips" style="padding-left: 0px;"><b style="color: red;padding: 0px;margin: 0px;">*</b>您的住址</span>
	        </dd>
	        <dt class="dt_l">邮政编码：</dt>
	        <dd class="dd_r clearfix">
	        	<input name="expert.postcode" value="${form.expert.postcode}" class="validate[required] input_kuang address"/>
	        	<span class="check_tips succ_tips" style="padding-left: 0px;"><b style="color: red;padding: 0px;margin: 0px;">*</b>您所在地区的邮编</span>
	        </dd>
	        <dt class="dt_l">研究领域：</dt>
	        <dd class="dd_r clearfix">
	        	<input name="expert.techAreaName" value="${form.expert.techAreaName}" class="validate[required] input_kuang address"/>
	        	<span class="check_tips succ_tips" style="padding-left: 0px;"><b style="color: red;padding: 0px;margin: 0px;">*</b>主要研究方向</span>
	        </dd>
	        <dt class="dt_l">取得奖项：</dt>
	        <dd class="dd_r clearfix">
	        	<input name="expert.award" value="${form.expert.award}" class="validate[required] input_kuang address"/>
	        	<span class="check_tips succ_tips" style="padding-left: 0px;"><b style="color: red;padding: 0px;margin: 0px;">*</b>您曾获取的奖项 ,字数不得超过100字</span>
	        </dd>
	        <dt class="dt_l">劳务支付方式：</dt>
	        <dd class="dd_r clearfix">
	        	<select name="expert.laborPayId" class="validate[required] input_kuang address" style="80px;">
	        		<option value="">请选择</option>
	        		<option value="1" <c:if test='${form.expert.laborPayId=="1"}'>selected="selected"</c:if>>银行汇款方式支付</option>
	        		<option value="2" <c:if test='${form.expert.laborPayId=="2"}'>selected="selected"</c:if>>邮政汇款地址支付</option>
	        	</select>
	        	<b style="color: red;margin-left: 10px;">*</b>
	        </dd>
	        <dt class="dt_l">开户银行：</dt>
	        <dd class="dd_r clearfix">
	        	<input name="expert.accountBank" value="${form.expert.accountBank}" class="validate[required] input_kuang address"/>
	        	<span class="check_tips succ_tips" style="padding-left: 0px;"><b style="color: red;padding: 0px;margin: 0px;">*</b>请如实填写</span>
	        </dd>
	        <dt class="dt_l">开户名：</dt>
	        <dd class="dd_r clearfix">
	        	<input name="expert.accountName" value="${form.expert.accountName}" class="validate[required] input_kuang address"/>
	        	<span class="check_tips succ_tips" style="padding-left: 0px;"><b style="color: red;padding: 0px;margin: 0px;">*</b>请如实填写</span>
	        </dd>
	        <dt class="dt_l">银行卡号：</dt>
	        <dd class="dd_r clearfix">
	        	<input name="expert.accountNo" value="${form.expert.accountNo}" class="validate[required] input_kuang address"/>
	        	<span class="check_tips succ_tips" style="padding-left: 0px;"><b style="color: red;padding: 0px;margin: 0px;">*</b>请如实填写</span>
	        </dd>
	        <dt class="dt_l">收款人：</dt>
	        <dd class="dd_r clearfix">
	        	<input name="expert.recipient" value="${form.expert.recipient}" class="validate[required] input_kuang address"/>
	        	<span class="check_tips succ_tips" style="padding-left: 0px;"><b style="color: red;padding: 0px;margin: 0px;">*</b>请如实填写</span>
	        </dd>
	        <dt class="dt_l">收款人地址：</dt>
	        <dd class="dd_r clearfix">
	        	<input name="expert.recipientAddress" value="${form.expert.recipientAddress}" class="validate[required] input_kuang address"/>
	        	<span class="check_tips succ_tips" style="padding-left: 0px;"><b style="color: red;padding: 0px;margin: 0px;">*</b>请如实填写</span>
	        </dd>
	        <dt class="dt_l">&nbsp;</dt>
  		   <dd class="dd_r clearfix">
	             <div class="sub_login">
					<input id="prev" class="no_bg" type="button" onclick="operate('_prev');" value="上一步" name="_prev"/>
	             	<input id="finish" class="no_bg" type="button" onclick="operate('_finish')" value="完成" name="_finish" style="margin-left: 100px;"/>
	             </div>
	       </dd>
			
		</dl>
		</form>
    </div>
</div>

<div id="footer"></div>
</div>
</body>
</html>