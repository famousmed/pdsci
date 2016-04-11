<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>完善资料</title>
<meta name="keywords" content=""/>
<meta name="description" content=""/>
<jsp:include page="/jsp/edu/htmlhead-edu.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="complete" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
function checkUser(){
	var idNo = $("input[name='idNo']").val();
	if(idNo != "" ){
		var url = "<s:url value='/edu/user/checkUser'/>";
		jboxPost(url,$("#userInfoForm").serialize(),
				function(resp){
					if(resp == "${GlobalConstant.USER_ID_NO_REPETE}"){
						jboxTip(resp);
						$("input[name='idNo']").focus();
					}
				},null,false);
	}
}

function saveUserInfo(){
	if(false == $("#userInfoForm").validationEngine("validate")){
		return false;
	}
	var url = "<s:url value='/inx/edu/saveUserInfo'/>";
	jboxPost(url,$("#userInfoForm").serialize(),
			function(resp){
				if(resp == "${GlobalConstant.USER_ID_NO_REPETE}"){
					jboxTip(resp);
					$("input[name='idNo']").focus();
				}
				if(resp == "${GlobalConstant.SAVE_SUCCESSED}"){
					jboxTip(resp);
					userBtnSubmit();
				}
			},null,false);
}

function submitUserInfo(){
	if(false == $("#userInfoForm").validationEngine("validate")){
		return false;
	}
	
	jboxConfirm("提交审核？ 提交后您所填写的信息将不可更改！", function(){
			var url = "<s:url value='/inx/edu/submitUserInfo'/>";
			jboxPost(url,$("#userInfoForm").serialize(),
					function(resp){
						if(resp == "${GlobalConstant.USER_ID_NO_REPETE}"){
							jboxTip(resp);
							$("input[name='idNo']").focus();
						}
						if(resp == "${GlobalConstant.SAVE_SUCCESSED}"){
							disabled();
							$("#regimg").attr("src","<s:url value='/jsp/edu/css/images/examineimg.png'/>");
							jboxInfo("资料已提交管理员审核,请耐心等待！");
						}
					},null,false);
	});
	
}
$(function(){
	if("${eduUser}" != ""){
		userBtnSubmit();
	}
	if("${sysUser.statusId}"=="${userStatusEnumReged.id}"){
		disabled();
	}
});

function userBtnSubmit(){
	$("#btn-submit").removeClass();
	$("#btn-submit").addClass("btn-submit");
	$("#btn-submit").css("cursor","pointer");
	$("#btn-submit").attr("onclick","submitUserInfo();");
}

function disabled(){
	$('#lock input').attr('disabled' , "disabled");
	$("#lock input[type=button]").css("cursor","");
	$("#lock input[type=button]").removeClass();
	$("#lock input[type=button]").addClass("btn-grey");
	$('#lock input').attr('readonly' , "readonly");
	$('#lock select').attr('disabled' , "disabled");
}
</script>
</head>
<body>
<div class="rbody-form">
	<div class="registerLogo"><img src="<s:url value='/jsp/edu/css/images/registerLogo.png'/>" /></div>
  <div class="registerMassge">
      <h3><img src="<s:url value='/jsp/edu/css/images/edito.png'/>"/>个人资料完善</h3>
      <div class="regtable">
        <div class="regtableleft" id="lock">
        <form id="userInfoForm" style="position: relative;" method="post">
        <input type="hidden" name="userFlow" value="${sysUser.userFlow}"/>
        <table>
      	<tr>
        	<td width="100"><i>*</i>姓名：</td>
            <td><input class="txt validate[required]" type="text" name="userName" value="${sysUser.userName}"/></td>
            <Td></Td>
        </tr>
        <tr>
        	<td><i>*</i>身份证号：</td>
            <td><input class="txt validate[required,custom[chinaIdLoose]]" type="text" name="idNo" value="${sysUser.idNo}" onchange="checkUser();"/></td>
            <Td></Td>
        </tr>
        <tr>
        	<td><i>*</i>学校名称：</td>
            <td>
	           <select name="orgFlow" class="xlselect validate[required]">
		       		<option value="">请选择</option>
		       		<c:forEach items="${orgList}" var="org">
		       			<option value="${org.orgFlow}" <c:if test="${sysUser.orgFlow eq org.orgFlow}">selected="selected"</c:if> >${org.orgName}</option>
		       		</c:forEach>
		       	</select>
        	</td>
            <Td></Td>
        </tr>
        <tr>
        	<td><i>*</i>届别：</td>
            <td>
            	<input onClick="WdatePicker({dateFmt:'yyyy'})" class="ctime validate[required]" name="period" value="${eduUser.period}" type="text" readonly="readonly"/>
            </td>
            <Td></Td>
        </tr>
        <tr>
        	<td><i>*</i>专业：</td>
            <td>
                <select name="majorId" class="validate[required]">
	               <option value="">请选择</option>
	               <c:forEach var="dict" items="${dictTypeEnumCourseMajorList}">
	               <option value="${dict.dictId }" <c:if test="${eduUser.majorId eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
	               </c:forEach>
	            </select>
            </td>
            <Td></Td>
        </tr>
        <tr>
        	<td><i>*</i>学号：</td>
            <td><input class="txt validate[required]" type="text" name="sid" value="${eduUser.sid}"/></td>
            <Td></Td>
        </tr>
        <tr>
            <td></td>
        	<td class="btn1" >
       			<input type="button" class="btn-save" value="保&nbsp;存" onclick="saveUserInfo();" style="cursor: pointer;"/>
       			<input type="button" id="btn-submit" class="btn-grey" style="margin-left:10px;" value="提交审核"/>
        	</td>
            <Td></Td>
        </tr>
      </table>
      </form>
        </div>
        <div class="regtableright">
          <h6>注意事项：</h6>
          <p>请您务必完善个人信息，该信息将提交系统管理员审核并作为您获取考试结果、学分等的凭证。</p>
          <p>
         	<c:choose>
         		<c:when test="${sysUser.statusId eq userStatusEnumReged.id}">
         			<img src="<s:url value='/jsp/edu/css/images/examineimg.png'/>"/>
         		</c:when>
         		<c:otherwise>
		          	<img id="regimg" src="<s:url value='/jsp/edu/css/images/regimg.png'/>"/>
         		</c:otherwise>
         	</c:choose>
          </p>
        </div>
      </div>  
    </div>
     <div class="regform-foot">
		Copyright © 2001- 2014 Character Technology, Inc. All rights reserved.
    </div>
</div>
</body>
</html>