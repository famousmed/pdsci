<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
    <jsp:param name="basic" value="true"/>
    <jsp:param name="jbox" value="true"/>
    <jsp:param name="userCenter" value="true"/>
	<jsp:param name="findCourse" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script>
    function doClose(){
    	jboxClose();
    }
    function saveTeacher(){
    	if("${sessionScope.currUser}" == "" || "${sessionScope.currUser}" == null){
    		jboxInfo("登录失效！请重新登录！");
    	}
    	if(false == $("#editForm").validationEngine("validate")){
			return false;
		}
    	var url = "<s:url value='/njmuedu/user/saveStudentOrTeacher'/>";
		jboxPost(url,$("#editForm").serialize(),
				function(resp){
					if(resp == "${GlobalConstant.USER_CODE_REPETE}"){
						jboxTip(resp);
						$("input[name='userCode']").focus();
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
						var url = "<s:url value='/njmuedu/user/userList'/>";
						top.window.loadContent(url);
						top.window.jboxTip("${GlobalConstant.SAVE_SUCCESSED}");
						jboxClose();
					}
				},
				function(resp){},false);
    }
    
    function checkUniqueUser(){
		var userCode = $("input[name='userCode']").val();
		var userPhone = $("input[name='userPhone']").val();
		var userEmail = $("input[name='userEmail']").val();
		if(userCode != "" || userPhone != "" || userEmail != ""){
			var url = "<s:url value='/njmuedu/user/checkUser'/>";
			jboxPost(url,$("#editForm").serialize(),
					function(resp){
						if(resp == "${GlobalConstant.USER_CODE_REPETE}"){
							jboxTip(resp);
							$("input[name='userCode']").focus();
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
  function getDept(){
	  var orgFlow=$("#orgFlow");
	  var deptFlow=$("#deptFlow");
      if($(orgFlow).val()!=""){
    	  var url = "<s:url value='/njmuedu/user/getDept'/>?orgFlow="+$(orgFlow).val();
    	  jboxPost(url,null,
					function(resp){
						if(resp){
							$(deptFlow).html("");
							$(deptFlow).append("<option value=''>请选择</option>");
							for(var i=0;i<resp.length;i++){
								var option="<option value="+resp[i].deptFlow+">"+resp[i].deptName+"</option>";
								$(deptFlow).append(option);
							}
						}
		  },null,false);
      }
  }
</script>
<head>
<body style="background:#fff; margin:0 10px;">      	
<div class="clear"></div> 
<div>
	<p class="courseP">基本信息</p>
	<form id="editForm" method="post" style="position: relative;">
	<input type="hidden" name="userFlow" value="${eduUserExt.userFlow }"/>
	<input type="hidden" name="type" value="${param.type }"/>
	<div class="part editTeacher">
	<table border="0" cellpadding="0" cellspacing="0" class="course-table course-table1" style="border:1px solid #d4e7f0;">
		<col width="15%">
		<col width="35%">
		<col width="15%">
		<col width="35%">
		<tr>
			<th><span style="color: red">*</span>&nbsp;登录名：</th>
            <td>
				<input type="text" name="userCode" class="validate[required,maxSize[25]]" value="${eduUserExt.sysUser.userCode}" onchange="checkUniqueUser();"/>
			</td>
			<th><span style="color: red">*</span>&nbsp;姓名：</th>
			<td>
				<input type="text" class="validate[required,maxSize[25]]" name="userName" value="${eduUserExt.sysUser.userName }"/>
			</td>
		</tr>
		<tr>
			<th><span style="color: red">*</span>&nbsp;性别：</th>
			<td>
				<select name="sexId" style="width: 53%" class="validate[required]">
                   <option value="">请选择</option>
                   <c:forEach var="sex" items="${userSexEnumList}">
                   		<c:if test="${sex.id != userSexEnumUnknown.id}">
                   			<option value="${sex.id}" <c:if test="${eduUserExt.sysUser.sexId eq sex.id}">selected="selected"</c:if>>${sex.name}</option>
                   		</c:if>	 
                   </c:forEach>
                </select>
			</td>
			<th>出生日期：</th>
			<td>
			    <input onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="txt validate[required]" name="userBirthday" value="${eduUserExt.sysUser.userBirthday}" type="text" readonly="readonly"/>
			</td>
		</tr>
		<tr>
		   <th><span style="color: red">*</span>&nbsp;学校：</th>
			<td>
			  <c:if test="${param.flag=='admin' }">
			     <input type="hidden" name="orgFlow" <c:if test="${empty eduUserExt.sysUser.orgFlow }">value="${sessionScope.currUser.orgFlow }"</c:if> <c:if test="${not empty eduUserExt.sysUser.orgFlow }">value="${eduUserExt.sysUser.orgFlow }"</c:if>/> 
			  </c:if>
				<select name="orgFlow" id="orgFlow" class="validate[required]" style="width: 53%" <c:if test="${param.flag=='admin' }"> disabled="disabled"</c:if> onchange="getDept();">
					<option value="">请选择</option>
					<c:forEach items="${orgList}" var="org">
						<option value="${org.orgFlow}" <c:if test="${(eduUserExt.sysUser.orgFlow eq org.orgFlow)||(empty eduUserExt.sysUser.orgFlow && sessionScope.currUser.orgFlow eq org.orgFlow && param.flag =='admin' )}">selected="selected"</c:if> >${org.orgName}</option>
					</c:forEach>
				</select>
			</td>
			<th><span style="color: red">*</span>&nbsp;院系：</th>
			<td>
			   <select name="deptFlow" id="deptFlow" style="width: 53%" class="validate[required]">
			        <option value="">请选择</option>
			        <c:forEach items="${deptList }" var="dept">
			            <option value="${dept.deptFlow }" <c:if test="${eduUserExt.sysUser.deptFlow eq dept.deptFlow }">selected</c:if>>${dept.deptName }</option>
			        </c:forEach>
			   </select>
			</td>
		</tr>
		<tr>
		
			<th>手机号：</th>
			<td>
				<input type="text" name="userPhone" class="validate[custom[phone]]" value="${eduUserExt.sysUser.userPhone}" onchange="checkUniqueUser();" />
			</td>
			<th>邮箱：</th>
			<td>
				<input type="text" name="userEmail" class="validate[custom[email]]" value="${eduUserExt.sysUser.userEmail}" onchange="checkUniqueUser();"/>
			</td>
		</tr>
		<tr>
			<th><span style="color: red">*</span>&nbsp;学号：</th>
			<td>
				<input type="text" name="sid"  value="${eduUserExt.sid}" class="validate[required]"/>
			</td>
			<th><span style="color: red">*</span>&nbsp;专业：</th>
			<td>
				<select name="majorId" style="width: 53%" class="validate[required]">
					<option value="">请选择</option>
					<c:forEach var="dict" items="${dictTypeEnumNjmuCourseMajorList }">
					<option value="${dict.dictId }" <c:if test="${eduUserExt.majorId eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<th><span style="color: red">*</span>&nbsp;届别：</th>
			<td>
				<input onClick="WdatePicker({dateFmt:'yyyy'})" class="txt validate[required]" name="period" value="${eduUserExt.period}" type="text" readonly="readonly"/>
			</td>
			<th>身份证号：</th>
			<td>
				<input class="txt validate[custom[chinaIdLoose]]" type="text" name="idNo" value="${eduUserExt.sysUser.idNo}" onchange="checkUser();"/>
			</td>
		</tr>
	</table>
	</div>
	</form>
	<div style="width: 600px;" class="editBtn">
	 	<input type="button" class="search" value="保存" onclick='saveTeacher();' />
	 	<input type="button" class="search2" value="关闭" onclick='doClose();'/>
	</div>
 </div>

</body>
</html>