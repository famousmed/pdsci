<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
function add(orgFlow) {
	jboxOpen("<s:url value='/sys/user/edit/${GlobalConstant.USER_LIST_LOCAL}'/>?orgFlow="+orgFlow,"新增用户信息", 900, 400);
}
function edit(userFlow) {
	jboxOpen("<s:url value='/sys/user/edit/${GlobalConstant.USER_LIST_LOCAL}?userFlow='/>"+ userFlow,"编辑用户信息", 900, 400);
}
function allotRole(userFlow){
	jboxOpen("<s:url value='/sys/user/allotRole?userFlow='/>"+ userFlow,"分配用户角色", 900, 500);
}
function resetPasswd(userFlow){
	jboxConfirm("确认将该用户的密码重置为:${GlobalConstant.INIT_PASSWORD} 吗？",function () {
		var url = "<s:url value='/sys/user/resetPasswd?userFlow='/>"+userFlow;
		jboxGet(url,null,function(){
			//searchUser();			
		});		
	});
}

function activate(userFlow){
	jboxConfirm("确认解锁该用户吗？",function () {
		var url = "<s:url value='/sys/user/activate?userFlow='/>"+userFlow;
		jboxGet(url,null,function(){
			searchUser();			
		});
	});
}
function lock(userFlow){
	jboxConfirm("确认锁定该用户吗？锁定后该用户将不能登录系统！",function () {
		var url = "<s:url value='/sys/user/lock?userFlow='/>"+userFlow;
		jboxGet(url,null,function(){
			searchUser();			
		});		
	});
}
function searchUser(){
	jboxStartLoading();
	$("#searchForm").submit();
}
function searchDept(orgFlow,deptFlow) {
	if(orgFlow==""){
		return;
	}
	var url = "<s:url value='/sys/user/getDept'/>?orgFlow="+orgFlow+"&deptFlow="+deptFlow;
	jboxGet(url,null,function(resp){
		$("#deptSelectId").html(resp);
	},null,false);
}
function toPage(page) {
	if(page!=undefined){
		$("#currentPage").val(page);			
	}
	searchUser();
}

function editDoc(doctorFlow,userFlow){
	jboxOpen("<s:url value='/res/doc/user/editDoc'/>?roleFlag=${GlobalConstant.USER_LIST_GLOBAL}&doctorFlow="+doctorFlow+"&userFlow="+userFlow,(doctorFlow=='')?"新增医师信息":"编辑医师信息",1100,500);
}
function selRole(userFlow,roleFlow){
	jboxGet("<s:url value='/res/manager/selRole'/>?userFlow="+userFlow+"&roleFlow="+roleFlow,null,null,null,true);
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				 <form id="searchForm" action="<s:url value="/res/manager/manageUser" />" method="post">
							部&#12288;&#12288;门：
							<span id="deptSelectId">
								<script type="text/javascript">
									$(document).ready(function(){
										searchDept('${sessionScope.currUser.orgFlow}','${param.deptFlow}');	
										$("#deptFlow").live("change",function (){
											searchUser();
										});
									});										
								</script>
							</span>
				     	身份证：<input type="text" name="idNo" value="${param.idNo}"  class="xltext "/>
				     	手机号：<input type="text" name="userPhone" value="${param.userPhone}"  class="xltext "/>
				     	&#12288;Email：<input type="text" name="userEmail" value="${param.userEmail}"  class="xltext "/>
				     	<br>  <br>    	
						<c:if test="${sessionScope.userListScope==GlobalConstant.USER_LIST_LOCAL }">
							<input type="hidden" name="orgFlow" value="${sessionScope.currUser.orgFlow }"/>
						</c:if>
				     	姓&#12288;&#12288;名： <input type="text" name="userName" value="${param.userName}"  class="xltext "/>
						用户状态：
						<input id="all" name="statusId" type="radio" value="" onclick="searchUser();" 
							<c:if test='${empty param.statusId}'>checked="checked"</c:if>>
						<label for="all">全部</label>&#12288;
						<c:if test="${sessionScope.currWsId==GlobalConstant.EDC_WS_ID}">
							<input id="${userStatusEnumAdded.id}" name="statusId" type="radio" value="${userStatusEnumAdded.id}" onclick="searchUser();" 
								<c:if test='${param.statusId==userStatusEnumAdded.id}'>checked="checked"</c:if>>
							<label for="${userStatusEnumAdded.id }">${userStatusEnumAdded.name}</label>&#12288;
						</c:if>
						<c:if test="${sessionScope.currWsId==GlobalConstant.SRM_WS_ID}">		
							<input id="${userStatusEnumReged.id}" name="statusId" type="radio" value="${userStatusEnumReged.id}" onclick="searchUser();" 
								<c:if test='${param.statusId==userStatusEnumReged.id}'>checked="checked"</c:if>>
							<label for="${userStatusEnumReged.id }">${userStatusEnumReged.name}</label>&#12288;
						</c:if>
						<input id="${userStatusEnumActivated.id}" name="statusId" type="radio" value="${userStatusEnumActivated.id}" onclick="searchUser();" 
							<c:if test='${param.statusId==userStatusEnumActivated.id}'>checked="checked"</c:if>>
						<label for="${userStatusEnumActivated.id }">${userStatusEnumActivated.name}</label>&#12288;
						<input id="${userStatusEnumLocked.id}" name="statusId" type="radio" value="${userStatusEnumLocked.id}" onclick="searchUser();" 
							<c:if test='${param.statusId==userStatusEnumLocked.id}'>checked="checked"</c:if>>
						<label for="${userStatusEnumLocked.id }">${userStatusEnumLocked.name}</label>&#12288;
						<input id="currentPage" type="hidden" name="currentPage" value=""/>
				     	<input type="button" class="search" onclick="searchUser();" value="查&#12288;询">
						<c:if test="${sessionScope.currWsId!=GlobalConstant.SRM_WS_ID}">
							<input type="button" class="search" onclick="add($('#orgFlow').val());" value="新&#12288;增">
						</c:if>
						<c:if test="${sessionScope.currWsId==GlobalConstant.SRM_WS_ID}">
							<c:if test="${applicationScope.sysCfgMap['srm_add_user_flag'] ==  GlobalConstant.FLAG_Y }">
				     				<input type="button" class="search" onclick="add($('#orgFlow').val());" value="新&#12288;增">
			     			</c:if>
						</c:if>
				</form>
			</div>
	<table class="xllist" > 
		<tr>
			<!-- <th width="20px"></th> -->
			<th width="50px">姓名</th>
			<th width="50px">状态</th>
			<th width="30px">性别</th>
			<th width="60px">部门</th>
			<th width="80px">身份证</th>
			<th width="60px">手机</th>
			<th width="150px">邮件</th>
			<th width="200px">角色</th>
			<th width="180px" >操作</th>
		</tr>
			<c:set var="userNum" value="0"></c:set>
			<c:forEach items="${sysUserList}" var="sysUser">
			<c:set value="false" var="isDoctor"></c:set>
			<c:if test="${sysUser.userCode!=GlobalConstant.ROOT_USER_CODE or sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE }">
			<c:set var="userNum" value="${userNum+1 }"></c:set>
			
			<tr style="height:20px ">
				<td title="${sysUser.userCode}">${sysUser.userName}</td>
				<td>${sysUser.statusDesc}</td>
				<td>${sysUser.sexName}</td>
				<td>${sysUser.deptName}</td>
				<td>${sysUser.idNo}</td>
				<td>${sysUser.userPhone}</td>
				<td>${sysUser.userEmail}</td>
				<td style="text-align: left;">
<%-- 					<c:if test="${!empty applicationScope.sysCfgMap['res_doctor_role_flow']}"> --%>
<!-- 						&#12288; -->
<!-- 						<label> -->
<%-- 							<input type="checkbox" onclick="selRole('${sysUser.userFlow}',this.value);" value="${applicationScope.sysCfgMap['res_doctor_role_flow']}" <c:if test="${pdfn:contain(applicationScope.sysCfgMap['res_doctor_role_flow'],sysUserRoleMap[sysUser.userFlow]) }">checked='checked'</c:if>/>${!empty sysRoleMap[sysCfgMap['res_doctor_role_flow']]?sysRoleMap[sysCfgMap['res_doctor_role_flow']].roleName:'学员'}&#12288; --%>
<!-- 						</label> -->
<%-- 					</c:if> --%>
					<c:if test="${!empty applicationScope.sysCfgMap['res_teacher_role_flow']}">
						&#12288;
						<label>
							<input type="checkbox" onclick="selRole('${sysUser.userFlow}',this.value)" value="${applicationScope.sysCfgMap['res_teacher_role_flow'] }" <c:if test="${pdfn:contain(applicationScope.sysCfgMap['res_teacher_role_flow'],sysUserRoleMap[sysUser.userFlow]) }">checked='checked'</c:if>/>${!empty sysRoleMap[sysCfgMap['res_teacher_role_flow']]?sysRoleMap[sysCfgMap['res_teacher_role_flow']].roleName:'带教老师'}
						</label>
					</c:if>
					<c:if test="${!empty applicationScope.sysCfgMap['res_head_role_flow']}">
						&#12288;
						<label>
							<input type="checkbox" onclick="selRole('${sysUser.userFlow}',this.value);" value="${applicationScope.sysCfgMap['res_head_role_flow']}" <c:if test="${pdfn:contain(applicationScope.sysCfgMap['res_head_role_flow'],sysUserRoleMap[sysUser.userFlow]) }">checked='checked'</c:if>/>${!empty sysRoleMap[sysCfgMap['res_head_role_flow']]?sysRoleMap[sysCfgMap['res_head_role_flow']].roleName:'科主任'}
						</label>
					</c:if>
					<c:if test="${!empty applicationScope.sysCfgMap['res_manager_role_flow']}">
						&#12288;
						<label>
							<input type="checkbox" onclick="selRole('${sysUser.userFlow}',this.value)" value="${applicationScope.sysCfgMap['res_manager_role_flow'] }" <c:if test="${pdfn:contain(applicationScope.sysCfgMap['res_manager_role_flow'],sysUserRoleMap[sysUser.userFlow]) }">checked='checked'</c:if>/>${!empty sysRoleMap[sysCfgMap['res_manager_role_flow']]?sysRoleMap[sysCfgMap['res_manager_role_flow']].roleName:'基地主任'}
						</label>
					</c:if>
				</td>
				<c:if test="${applicationScope.sysCfgMap['sys_weixin_qiye_flag']==GlobalConstant.FLAG_Y}">
				<td width="60px" title="${sysUser.weiXinId}">${sysUser.weiXinStatusDesc}</td>
				</c:if>
				<td style="text-align: left;padding-left: 5px;">				
					<c:if test="${sysUser.statusId==userStatusEnumAdded.id}">
						等待验证...
					</c:if>	
					<c:if test="${sysUser.statusId==userStatusEnumReged.id}">
					[<a href="javascript:audit('${sysUser.userFlow}');" >审核</a>]
					<c:if test="${sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE}"> | 
					[<a href="javascript:edit('${sysUser.userFlow}');" >编辑</a>]
					</c:if>
					</c:if>						
					<c:if test="${sysUser.statusId==userStatusEnumActivated.id}">
					[<a href="javascript:edit('${sysUser.userFlow}');" >编辑</a>] | 
					[<a href="javascript:resetPasswd('${sysUser.userFlow}');" >重置密码</a>] | 
					[<a href="javascript:lock('${sysUser.userFlow}');" >锁定</a>] 
					</c:if>
					
					<c:if test="${sysUser.statusId==userStatusEnumLocked.id}">
					[<a href="javascript:activate('${sysUser.userFlow}');" >解锁</a>]
					</c:if>
					<%-- [<a href="javascript:markExpert('${sysUser.userFlow}');" >标记为专家</a>] --%>
				</td>
			</tr>
			</c:if>
		   </c:forEach>
		   <c:if test="${userNum == 0 }"> 
		   		<c:set var="colNum" value="10"></c:set>
		   		<c:if test="${sessionScope.currWsId=='srm' and applicationScope.sysCfgMap['srm_for_use']=='local'}">
					<c:set var="colNum" value="10"></c:set>
				</c:if>
				<tr> 
					<td align="center" colspan="${colNum }">无记录</td>
				</tr>
			</c:if>
	</table>
	<c:set var="pageView" value="${pdfn:getPageView(sysUserList)}" scope="request"></c:set>
	<pd:pagination toPage="toPage"/>
	</div>
</div>
</body>
</html>