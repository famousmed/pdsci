<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
	function saveUserInfo(){
		if(false == $("#userInfoForm").validationEngine("validate")){
			return false;
		}
		var url = "<s:url value='/njmuedu/user/saveUserInfo'/>";
		jboxPost(url,$("#userInfoForm").serialize(),
				function(resp){
					if(resp == "${GlobalConstant.USER_CODE_REPETE}"){
						jboxTip(resp);
						$("input[name='idNo']").focus();
					}
					if(resp == "${GlobalConstant.USER_ID_NO_REPETE}"){
						jboxTip(resp);
						$("input[name='idNo']").focus();
					}
					if(resp == "${GlobalConstant.USER_PHONE_REPETE}"){
						jboxTip(resp);
						$("input[name='userPhone']").focus();
					}
					if(resp == "${GlobalConstant.USER_EMAIL_REPETE}"){
						jboxTip(resp);
						$("input[name='userEmail']").focus();
					}
					if(resp == "${GlobalConstant.SAVE_SUCCESSED}"){
						disabledUserCode();
						var userName = $("input[name='userName']").val();
						$("#currUserName").text(userName);
						$("#userName-r").text(userName);
						var orgName = $("select[name='orgFlow'] option:selected").text();
						$("#orgName-r").text(orgName);
						//头像
						$("#t-face-r").attr("src",$("#showImg").attr("src"));
						$("#t-face").attr("src",$("#showImg").attr("src"));
						//loadSetUserInfo();
						jboxTip("${GlobalConstant.SAVE_SUCCESSED}");
					}
				},null,false);
	}
	
	function checkUser(){
		var userCode = $("input[name='userCode']").val();
		var idNo = $("input[name='idNo']").val();
		var userPhone = $("input[name='userPhone']").val();
		var userEmail = $("input[name='userEmail']").val();
		if(userCode != "" || idNo != "" || userPhone != "" || userEmail != ""){
			var url = "<s:url value='/njmuedu/user/checkUser'/>";
			jboxPost(url,$("#userInfoForm").serialize(),
					function(resp){
						if(resp == "${GlobalConstant.USER_CODE_REPETE}"){
							jboxTip(resp);
							$("input[name='idNo']").focus();
						}
						if(resp == "${GlobalConstant.USER_ID_NO_REPETE}"){
							jboxTip(resp);
							$("input[name='idNo']").focus();
						}
						if(resp == "${GlobalConstant.USER_PHONE_REPETE}"){
							jboxTip(resp);
							$("input[name='userPhone']").focus();
						}
						if(resp == "${GlobalConstant.USER_EMAIL_REPETE}"){
							jboxTip(resp);
							$("input[name='userEmail']").focus();
						}
					},null,false);
		}
	}
	function chooseImg(){
		return $("#imageFile").click();
	}
	$(function(){
		$("#imageFile").live("change",function(){
			uploadImage();
		});
	});
	function uploadImage(){
		$.ajaxFileUpload({
			url:"<s:url value='/njmuedu/user/uploadImg'/>",
			secureuri:false,
			fileElementId:'imageFile',
			dataType: 'json',
			success: function (data, status){
				if(data.indexOf("success")==-1){
					jboxTip(data);
				}else{
					jboxTip('${GlobalConstant.UPLOAD_SUCCESSED}');
					var arr = new Array();
					arr = data.split(":");
					$("#userHeadImg").val(arr[1]);
					var url = "${sysCfgMap['upload_base_url']}"+ arr[1];
					$("#showImg").attr("src",url);
					
				}
			},
			error: function (data, status, e){
				jboxTip('${GlobalConstant.UPLOAD_FAIL}');
			},
			complete:function(){
				$("#imageFile").val("");
			}
		});
	}
	
$(function($) {
	disabledUserCode();
	disabled();
});
	
function disabledUserCode(){
	var $userCode = $("input[name='userCode']");
	var userCode = $userCode.val();
	var userEmail = $("input[name='userEmail']").val();
	if(userCode != userEmail){
		$userCode.addClass("disable");
		$userCode.attr("disabled","disabled");
	}
}

function disabled(){
	var $idNo = $("input[name='idNo']");
	$idNo.addClass("disable");
	$idNo.attr("disabled","disabled");
	
	var $userName = $("input[name='userName']");
	$userName.addClass("disable");
	$userName.attr("disabled","disabled");
	
	var $userEmail = $("input[name='userEmail']");
	$userEmail.addClass("disable");
	$userEmail.attr("disabled","disabled");
	
	var $orgFlow = $("select[name='orgFlow']");
	$orgFlow.addClass("disable");
	$orgFlow.attr("disabled","disabled");
	
	var $majorId = $("select[name='majorId']");
	$majorId.addClass("disable");
	$majorId.attr("disabled","disabled");
}
</script> 
<div class="right fr" style="margin-top: 10px;">
	<h3>个人设置</h3>
	<form id="userInfoForm" style="position: relative;" method="post">
	<input type="hidden" name="userFlow" value="${user.userFlow}"/>
    <table style="width:372px;"  border="0" class="fl">
      <tr>
        <td class="txtinfo" colspan="2">用户名<c:if test="${user.userCode == user.userEmail}"><span style="color: red;">(首次允许修改，修改后可凭用户名登录系统)</span></c:if></td>
      </tr>
      <tr>
        <td colspan="2">
        	<input class="txt validate[required]" type="text" name="userCode" value="${user.userCode}" 
        	<c:if test="${user.userCode != user.userEmail}">disabled="disabled"</c:if> />
        </td>
      </tr>
      <tr>
        <td class="txtinfo" colspan="2">真实姓名</td>
      </tr>
      <tr>
        <td colspan="2"><input class="txt validate[required]" type="text" name="userName" value="${user.userName}"/></td>
      </tr>
      <tr>
        <td class="txtinfo" colspan="2">身份证号</td>
      </tr>
      <tr>
        <td colspan="2"><input class="txt validate[custom[chinaIdLoose]]" type="text" name="idNo" value="${user.idNo}" onchange="checkUser();"/></td>
      </tr>
      <tr>
        <td class="txtinfo" colspan="2">手机号</td>
      </tr>
      <tr>
        <td colspan="2"><input class="txt" type="text" name="userPhone" value="${user.userPhone}" onchange="checkUser();"/></td>
      </tr>
       <tr>
        <td class="txtinfo" colspan="2">邮箱</td>
      </tr>
      <tr>
        <td colspan="2"><input class="txt validate[custom[email]]" type="text" name="userEmail" value="${user.userEmail}" onchange="checkUser();"/></td>
      </tr>
      <tr>
        <td class="txtinfo" colspan="2">学校</td>
      </tr>
      <tr>
        <td colspan="2">
        	<select name="orgFlow" class="xlselect" style="width: 372px;">
        		<option value="">请选择</option>
        		<c:forEach items="${orgList}" var="org">
        			<option value="${org.orgFlow}" <c:if test="${user.orgFlow eq org.orgFlow}">selected="selected"</c:if> >${org.orgName}</option>
        		</c:forEach>
        	</select>
        </td>
      </tr>
     <%--  <tr>
        <td class="txtinfo" colspan="2">专业</td>
      </tr>
      <tr>
        <td colspan="2">
        	<select name="majorId" class="xlselect" style="width: 372px;">
               <option value="">请选择</option>
               <c:forEach var="dict" items="${dictTypeEnumCourseMajorList}">
               <option value="${dict.dictId }" <c:if test="${eduUser.majorId eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
               </c:forEach>
            </select>
        </td>
      </tr> --%>
      <tr>
      	<td><input type="button" class="btn" value="保&nbsp;&nbsp;存" onclick="saveUserInfo();"/></td>
      </tr>
      </table>
       <div class="upload-pic fr">
        	<input type="button" class="btn fl" value="上传头像" onclick="chooseImg()" />
        	<input type="file" id="imageFile" name="imageFile" style="display: none"/>
        	<input type="hidden" name="userHeadImg" id="userHeadImg"/>
            <p class="fr">仅支持jpg、png、bmp、gif格式，且文件<span>小于2M</span>。</p>
            <div class="clear"></div>
            <div class="pic">
    	  			<img src="${sysCfgMap['upload_base_url']}${user.userHeadImg}" onerror="this.src='<s:url value="/jsp/njmuedu/css/images/up-pic.jpg"/>'" id="showImg" width="200px" height="200px"/>
            </div>
           <!-- <input type="button"  class="btn up-btn"  value="保&nbsp;&nbsp;存" /> -->
        </div>
</form>
</div>      
