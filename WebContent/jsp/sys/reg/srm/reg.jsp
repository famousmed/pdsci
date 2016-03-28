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
		var url = "<s:url value='/reg/srm/saveReg'/>";
		var data = $('#regForm').serialize();
		$('#nxt').attr({"disabled":"disabled"});
		jboxStartLoading();
		jboxPost(url, data, function(resp) {
			if('${GlobalConstant.USER_REG_SUCCESSED}'==resp){				
				jboxClose();		
				window.setTimeout(function () {window.location.href="<s:url value='/reg/srm/success'/>";},1000);	
			}
		});
		
	}
	
	function agreement(){
		jboxOpenContent($('#agreement').html() , '用户协议' , 800 , 600);
	}
</script>
</head>

<body>
<div id="register">
   <div id="logo"><img src="<s:url value='/css/skin/${skinPath}/images/srm_head.png'/>" /></div>

</div>
<div class="mainright">
  <div id="content">
	<h1 class="reg_title">信息注册</h1>
    <p class="line">如已拥有帐户信息，则<a href="<s:url value='/index.jsp'/>" class="line_c">在此登录</a></p>
    
    
    <div class="quyu clearfix">
    	     <div class="prof">
    	     <form id="regForm" name="regForm" action="<s:url value='/reg/srm/regist'/>" method="post" style="position:relative;">
             <span class="check_id">请选择注册的身份：</span>
             <br />
             		<c:forEach items="${sysRoleList}" var="sysRole">
						<input id="${sysRole.roleFlow}" name="roleFlow" class="validate[required]" type="radio" value="${sysRole.roleFlow}" <c:if test="${sysRole.roleFlow==form.roleFlow}">checked</c:if>>
						<label for="${sysRole.roleFlow}"><span style='font-size: 14px; font-weight: bold;'>${sysRole.roleName}</span></label>
						<p class="check_prof">${sysRole.remark}</p>
					</c:forEach>
					
                     <p>点击“下一步”，表明您同意并愿意遵守<a href="javascript:void(0);" onclick="agreement();" class="line_c">用户协议</a></p> 
                      <div class="sub_login">
	             		<input id="nxt class="no_bg" type="submit" value="下一步" name="_next"/>
                      </div>
               </form>     	
               </div> 

    </div>
    
</div>
<div id='agreement' style='display: none;'>
	${sysCfgMap['sys_agreement']}
</div>
<div id="footer"></div>
</div>
</body>
</html>