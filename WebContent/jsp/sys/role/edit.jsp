<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
	function doSave() {
		if(false==$("#roleForm").validationEngine("validate")){
			return ;
		}
		var url = "<s:url value='/sys/role/save'/>";
		var data = $('#roleForm').serialize();
		jboxPost(url, data, function() {
			window.parent.frames['mainIframe'].window.search();
			jboxClose();
		});

	}
	
	function setRegPage(flag){
		if(flag=="Y"){
			$('#regPageId').attr("disabled" , false);
		}else if(flag=="N"){
			$('#regPageId').attr("disabled" , true).children().first().attr("selected" , "selected");
		}
		
	}
</script>
</head>
<body>
	<form id="roleForm" action="<s:url value="/sys/role/save"/>" method="post">
	<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">
				<div>
					<table width="800" cellpadding="0" cellspacing="0" class="basic">
						<tr>
							<th>角色名称：
								<input name="roleFlow" type="hidden" value="${sysRole.roleFlow}">
							</th>
							<td>
								<input class="validate[required] xltext" name="roleName" type="text" value="${sysRole.roleName}"/>										
								<input type="hidden" name="wsId" value="${sessionScope.currWsId}">
							</td>
						</tr>
						<tr>
							<th>父角色：</th>
							<td>
								<select class="xlselect" name="parentRoleFlow" style="80px;">
									<option value="">请选择</option>
									<c:forEach items="${sysRoleList}" var="parentRole">
										<c:if test="${sysRole.roleFlow!=parentRole.roleFlow}">
										<option value="${parentRole.roleFlow}" <c:if test="${parentRole.roleFlow==sysRole.parentRoleFlow }">selected</c:if>>${parentRole.roleName}</option>
										</c:if>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>角色级别：</th>
							<td>
								<c:if test="${sessionScope.currWsId==GlobalConstant.EDC_WS_ID || sessionScope.currWsId==GlobalConstant.GCP_WS_ID}">
									<input id="${roleLevelEnumSysLevel.id }" class="validate[required]" type="radio" name="roleLevelId"  value="${roleLevelEnumSysLevel.id }" <c:if test="${roleLevelEnumSysLevel.id == sysRole.roleLevelId}">checked</c:if> />
                                       <label for="${roleLevelEnumSysLevel.id }">${roleLevelEnumSysLevel.name}</label>&#12288;
                                       <input id="${roleLevelEnumProjLevel.id }" class="validate[required]" type="radio"  name="roleLevelId" value="${roleLevelEnumProjLevel.id }" <c:if test="${roleLevelEnumProjLevel.id == sysRole.roleLevelId}">checked</c:if> />
                                       <label for="${roleLevelEnumProjLevel.id }">${roleLevelEnumProjLevel.name }</label>									
								</c:if>
								<c:if test="${sessionScope.currWsId!=GlobalConstant.EDC_WS_ID && sessionScope.currWsId!=GlobalConstant.GCP_WS_ID}">
									<input id="${roleLevelEnumSysLevel.id }" class="validate[required]" type="radio" name="roleLevelId"  value="${roleLevelEnumSysLevel.id }" checked/>
                                       <label for="${roleLevelEnumSysLevel.id }">${roleLevelEnumSysLevel.name}</label>&#12288;
								</c:if>
							</td>
						</tr>	
						<c:if test="${sessionScope.currWsId==GlobalConstant.SRM_WS_ID}">					
						<tr id="isReg">
							<th>是否开放注册：</th>
							<td>
									<input id="allow_reg_flag_y" onchange="setRegPage('${GlobalConstant.FLAG_Y}');" class="validate[required]" type="radio" name="allowRegFlag"  value="${GlobalConstant.FLAG_Y}" onclick <c:if test="${GlobalConstant.FLAG_Y == sysRole.allowRegFlag}">checked<c:set var="regPageFlag" value="Y"></c:set></c:if> />
                                       <label for="allow_reg_flag_y">是</label>&#12288;
                                    <input id="allow_reg_flag_n" onchange="setRegPage('${GlobalConstant.FLAG_N}');" class="validate[required]" type="radio"  name="allowRegFlag" value="${GlobalConstant.FLAG_N}" <c:if test="${GlobalConstant.FLAG_N == sysRole.allowRegFlag}">checked</c:if> />
                                       <label for="allow_reg_flag_n">否</label>		
							</td>
						</tr>
						<tr>
							<th>注册界面：</th>
							<td>
								<select id="regPageId" name="regPageId" class="validate[required] xlselect" <c:if test='${regPageFlag!="Y"}'> disabled="disabled"</c:if>>
										<option value="">请选择</option>
									<c:forEach items="${regPageEnumList}" var="regPageEnum">
										<option value="${regPageEnum.id}" <c:if test='${regPageEnum.id==sysRole.regPageId}'>selected="selected"</c:if>>${regPageEnum.name}</option>
									</c:forEach>
								</select>
							</td>
						</tr>							
						</c:if>
						<c:if test="${sessionScope.currWsId==GlobalConstant.EDU_WS_ID}">					
						<tr>
							<th>功能界面：</th>
							<td>
								<select id="regPageId" name="regPageId" class="validate[required] xlselect" >
										<option value="">请选择</option>
									<c:forEach items="${userPageEnumList}" var="userPage">
										<option value="${userPage.id}" <c:if test='${userPage.id==sysRole.regPageId}'>selected="selected"</c:if>>${userPage.name}</option>
									</c:forEach>
								</select>
							</td>
						</tr>							
						</c:if>
						<c:if test="${sessionScope.currWsId==GlobalConstant.NJMUEDU_WS_ID}">					
						<tr>
							<th>功能界面：</th>
							<td>
								<select id="regPageId" name="regPageId" class="validate[required] xlselect" >
										<option value="">请选择</option>
									<c:forEach items="${njmuUserPageEnumList}" var="userPage">
										<option value="${userPage.id}" <c:if test='${userPage.id==sysRole.regPageId}'>selected="selected"</c:if>>${userPage.name}</option>
									</c:forEach>
								</select>
							</td>
						</tr>							
						</c:if>
						<tr>
							<th>排序码：</th>
							<td>
								<input class="validate[required,custom[integer]] xltext" name="ordinal" type="text" value="${sysRole.ordinal}"/>
							</td>
						</tr>
						<tr>
							<th>备注：</th>
							<td>
								<textarea class="xltxtarea" name="remark">${sysRole.remark}</textarea>
							</td>
						</tr>
					</table>
					<div class="button" style="width: 800px;">
						<input class="search" type="button" value="保&#12288;存" onclick="doSave();" />
						<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	</form>
</body>
</html>