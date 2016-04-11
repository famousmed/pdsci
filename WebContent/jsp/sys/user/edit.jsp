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
	function saveUser() {
		if(false==$("#sysUserForm").validationEngine("validate")){
			return ;
		}
		var url = "<s:url value='/sys/user/save'/>";
		var getdata = $('#sysUserForm').serialize();
		jboxPost(url, getdata, function(data) {
			if('${GlobalConstant.SAVE_SUCCESSED}'==data){
				try{
					window.parent.frames['mainIframe'].window.searchUser(); 
				}catch(e){
					
				}
				jboxClose();		
			}
		},null,true);
	}
	function searchDept(orgFlow,deptFlow) {
		if(orgFlow==""){
			return;
		}
		var url = "<s:url value='/sys/user/getDept'/>?orgFlow="+orgFlow+"&deptFlow="+deptFlow;
		jboxGet(url,null,function(resp){
			$("#deptSelectId").html(resp);
			if($("#mulDeptTr").is(":visible")){
				$("#"+$("#deptFlow").val()).hide();
			}
		},null,false);
	}
	function makeBirthdayByIdCard(idNo){	
		var sId = idNo;
		var birthDayObj = $("#userBirthday");
		var vBi = birthDayObj.val();
		if(vBi==""){
			if(sId.length==15){
				birthDayObj.val("19"+sId.substr(6,2)+"-"+sId.substr(8,2)+"-"+sId.substr(10,2)); 			
			}else if(sId.length==18){
				birthDayObj.val(sId.substr(6,4)+"-"+sId.substr(10,2)+"-"+sId.substr(12,2));
			}
		}
	}
	
	function mulDept(){
		if($("#deptFlow").val()==""){
			jboxTip("默认科室必须选择!");
			return;
		}
		$("#mulDeptTr").toggle();
		$("#"+$("#deptFlow").val()).hide();
	}
	function mulChange(){
		$(".otherDept").show();
		$("#"+$("#deptFlow").val()).hide();
	}
	
</script>
</head>
<body>

<form id="sysUserForm" style="height: 100px;" >
<input type="hidden" name="roleFlow" value="${param.roleFlow}"/>
<div class="content" style="height: 400px;overflow: auto;">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">
				<table width="800" cellpadding="0" cellspacing="0" class="basic">
					<tr>
						<th width="20%"><font color="red">*</font>登录名：</th>
						<td width="30%">
					 		<input type="hidden" name="userFlow" value="${sysUser.userFlow}" />
							<c:if test="${sysUser.statusId == userStatusEnumAdded.id  }">
								未注册
                             	<input type="hidden" name="userCode" value="${sysUser.userCode}" /> 
							</c:if>
							<c:if test="${sysUser.statusId != userStatusEnumAdded.id  }">
					 		<input class="<c:if test="${!(sysCfgMap['sys_user_check_user_code'] eq GlobalConstant.FLAG_N)}">validate[required,custom[userCode]]</c:if> xltext"  name="userCode" type="text" value="${sysUser.userCode}" type="text"/>
							 <%-- <c:if test="${empty sysUser.userFlow }">
                             	<input class="validate[required,custom[userCode]] xltext"  name="userCode" type="text" value="${sysUser.userCode}" type="text"/>
                             </c:if>
                            <c:if test="${not empty sysUser.userFlow }">
                             	${sysUser.userCode}
                             	<input type="hidden" name="userCode" value="${sysUser.userCode}" /> 
                             </c:if> --%>
                             </c:if>
						</td>
						<th width="20%">身份证号：</th>
						<td width="30%">
							<input class="validate[custom[chinaIdLoose]] xltext" name="idNo" type="text" value="${sysUser.idNo}" onblur="makeBirthdayByIdCard(this.value)">
						</td>
					</tr>
					<tr>
						<th><font color="red">*</font>姓名：</th>
						<td>
							<input class="validate[required] xltext" name="userName" type="text" value="${sysUser.userName}" >
						</td>
						<th><font color="red">*</font>性别：</th>
						<td>
							<input id="${userSexEnumMan.id }" class="validate[required]" type="radio" name="sexId"  value="${userSexEnumMan.id }" <c:if test="${userSexEnumMan.id == sysUser.sexId}">checked</c:if> />
                            <label for="${userSexEnumMan.id }">${userSexEnumMan.name}</label>&#12288;
                            <input id="${userSexEnumWoman.id }" class="validate[required]" type="radio"  name="sexId" value="${userSexEnumWoman.id }" <c:if test="${userSexEnumWoman.id == sysUser.sexId}">checked</c:if> />
                            <label for="${userSexEnumWoman.id }">${userSexEnumWoman.name }</label>
						</td>
					</tr>					
					<tr>
						<th>手机号码：</th>
						<td>
							<c:choose>
							<c:when test="${sessionScope.userListScope eq GlobalConstant.USER_LIST_PERSONAL && GlobalConstant.FLAG_N eq sysCfgMap['user_edit_phone']}">
								${sysUser.userPhone}
								<input name="userPhone" type="hidden" value="${sysUser.userPhone}" >
							</c:when>
							<c:otherwise>
								<input class="validate[custom[mobile]] xltext" name="userPhone" type="text" value="${sysUser.userPhone}" >
							</c:otherwise>
							</c:choose>
						</td>
						<th>电子邮箱：</th>
						<td>
							<c:choose>
							<c:when test="${sessionScope.userListScope eq GlobalConstant.USER_LIST_PERSONAL && GlobalConstant.FLAG_N eq sysCfgMap['user_edit_mail']}">
								${sysUser.userEmail}
								<input name="userEmail" type="hidden" value="${sysUser.userEmail}" >
							</c:when>
							<c:otherwise>
								<input class="validate[custom[email]] xltext" name="userEmail" type="text" value="${sysUser.userEmail}" >
							</c:otherwise>
							</c:choose>
						</td>
					</tr>					
					<tr>
						<th>出生日期：</th>
						<td>
							<input class="xltext ctime" id="userBirthday" name="userBirthday" type="text" value="${sysUser.userBirthday}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
						</td>
						<th></th>
						<td>
							
						</td>
					</tr>
					<tr>
						<th>学历：</th>
						<td>
							<select name="educationId" class="xlselect">
								<option></option>
								<c:forEach var="dict" items="${dictTypeEnumUserEducationList }">
		                   				<option value="${dict.dictId }" <c:if test="${sysUser.educationId eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
	                   			</c:forEach>
							</select>
						</td>
						<th>学位：</th>
						<td>
							<select name="degreeId" class="xlselect">
									<option></option>
									<c:forEach items="${dictTypeEnumUserDegreeList}" var="degree">
       									<option value="${degree.dictId}" <c:if test='${sysUser.degreeId==degree.dictId}'>selected="selected"</c:if>>${degree.dictName}</option>
       								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>职称：</th>
						<td>
							<select name="titleId" class="xlselect">
									<option></option>
									<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
       									<option value="${title.dictId}" <c:if test='${sysUser.titleId==title.dictId}'>selected="selected"</c:if>>${title.dictName}</option>
       								</c:forEach>
							</select>
						</td>
						<th>职务：</th>
						<td>
							<select name="postId" class="xlselect">
									<option></option>
									<c:forEach items="${dictTypeEnumUserPostList}" var="post">
       									<option value="${post.dictId}" <c:if test='${sysUser.postId==post.dictId}'>selected="selected"</c:if>>${post.dictName}</option>
       								</c:forEach>
							</select>
						</td>
					</tr>
					<c:if test="${sessionScope.userListScope!=GlobalConstant.USER_LIST_PERSONAL }">
					<tr>
						<th><font color="red">*</font>机构名称：</th>
						<td>
							<c:if test="${sessionScope.userListScope==GlobalConstant.USER_LIST_GLOBAL }">
								<select class="validate[required] xlselect" name="orgFlow" style="80px;" onchange="searchDept(this.value,'');">
									<option value="">请选择</option>
									<c:forEach var="sysOrg" items="${applicationScope.sysOrgList}">
									<option value="${sysOrg.orgFlow}" <c:if test="${sysOrg.orgFlow==sysUser.orgFlow || sysOrg.orgFlow eq param.orgFlow}">selected</c:if>>${sysOrg.orgName}</option>
									</c:forEach>
								</select>	
								<script type="text/javascript">									
									$(document).ready(function(){
										<c:if test="${empty sysUser}">
											$("[name='orgFlow']").change();
										</c:if>
										<c:if test="${not empty sysUser}">
											searchDept('${sysUser.orgFlow}','${sysUser.deptFlow}');
										</c:if>
									});							
								</script>
							</c:if>
							<c:if test="${sessionScope.userListScope==GlobalConstant.USER_LIST_LOCAL }">
								<input type="hidden" name="orgFlow" value="${sessionScope.currUser.orgFlow }"/>
								${sessionScope.currUser.orgName}
								<script type="text/javascript">
								$(document).ready(function(){
									searchDept('${sessionScope.currUser.orgFlow}','${sysUser.deptFlow}');											
								});										
								</script>
							</c:if>
						</td>
						<%-- 什么情况下需要显示部门  --%>
						<c:set var="deptStype" value="style='visibility:visible;'"></c:set>
						<c:choose>
							<c:when test="${sessionScope.currWsId==GlobalConstant.SRM_WS_ID }">
								<c:if test="${applicationScope.sysCfgMap['srm_for_use']=='global' and sessionScope.userListScope==GlobalConstant.USER_LIST_GLOBAL}">
									<c:set var="deptStype" value="style='visibility:hidden;'"></c:set>
								</c:if>
							</c:when>
							<c:when test="${sessionScope.currWsId==GlobalConstant.EDC_WS_ID 
							or sessionScope.currWsId==GlobalConstant.EDU_WS_ID
							or sessionScope.currWsId==GlobalConstant.NJMUEDU_WS_ID}">
								<c:set var="deptStype" value="style='visibility:hidden;'"></c:set>
							</c:when>
							<c:when test="${sessionScope.currWsId==GlobalConstant.IRB_WS_ID }">
								<c:set var="deptStype" value="style='visibility:visible;'"></c:set>
							</c:when>
							<c:when test="${sessionScope.currWsId==GlobalConstant.GCP_WS_ID }">
								<c:set var="deptStype" value="style='visibility:visible;'"></c:set>
							</c:when>
							<c:otherwise>
							
							</c:otherwise>
						</c:choose>
						<c:if test="${sessionScope.currWsId!=GlobalConstant.EDU_WS_ID and sessionScope.currWsId!=GlobalConstant.NJMUEDU_WS_ID}">
						<th ${deptStype}>部门名称
							<c:if test="${ applicationScope.sysCfgMap['sys_user_dept_flag']==GlobalConstant.FLAG_Y }">
								[<a href="javascript:mulDept();">多选</a>]
							</c:if>
						</th>
						<td id="deptSelectId" ${deptStype}>
						</td>
						</c:if>
					</tr>
					<c:if test="${ applicationScope.sysCfgMap['sys_user_dept_flag']==GlobalConstant.FLAG_Y }">
					<tr style="display: <c:if test='${empty userDeptMap}'>none</c:if>" id="mulDeptTr">
						<th >多部门选择</th>
						<td colspan="3">
							<c:forEach items="${sysDeptList}" var="dept">
								<label id="${dept.deptFlow }"  class="otherDept">
								<input type="checkbox" name="mulDeptFlow" value="${dept.deptFlow }"
								<c:if test="${!empty userDeptMap[dept.deptFlow ] }">checked</c:if>
								/>${dept.deptName}&#12288;&#12288;</label>
							</c:forEach>
						</td>
					</tr>
					</c:if>
					</c:if>
				</table>
				<div class="button" style="width: 800px;">
					<input class="search" type="button" value="保&#12288;存" onclick="saveUser();" />
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>