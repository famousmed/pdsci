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
		if(false==$("#popForm").validationEngine("validate")){
			return ;
		}
		var url = "<s:url value="/sys/role/savepop"/>";
		var data = $('#popForm').serialize();
		jboxPost(url, data, function() {
			//window.parent.frames['mainIframe'].window.search();
			jboxClose();
		});
	}
	function doSelectAll(obj){
		var $check = $(obj);
		$check.parent().next().find(":checkbox").attr("checked",obj.checked);
	}
</script>
</head>
<body>
<div class="mainright">
<form id="popForm" action="<s:url value="/sys/role/savepop"/>" method="post">
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">
				<div>
					<table width="800" cellpadding="0" cellspacing="0" class="basic">
						<tr>
							<td class="mation-nab" style="width: 100px;">角色名称：
								<input name="roleFlow" type="hidden" value="${sysRole.roleFlow}">
								<input name="wsId" type="hidden" value="${sysRole.wsId}">
							</td>
							<td>
								${sysRole.roleName}
							</td>
						</tr>
						<c:set var="total" value="0" scope="page"></c:set>
						<c:forEach items="${workStation.moduleList}" var="module">
							<c:set var="canShowModule" value="false" scope="page"></c:set>
							<c:if test="${sessionScope.currWsId=='srm' }">
								<c:set var="canShowModule" value="${pdfn:canShowByVersion(module.version)}" scope="page"></c:set>
							</c:if>
							<c:if test="${sessionScope.currWsId!='srm' }">
								<c:set var="canShowModule" value="true" scope="page"></c:set>
							</c:if>
							<c:if test="${sessionScope.currWsId=='res'}">
<%-- 								<c:set var="canShowModule" value="${pdfn:canShowByVersionForRes(module.version)}" scope="page"/> --%>
							</c:if>
							<c:if test="${canShowModule == true }">
								<tr>
									<td class="mation-nab" title="<font color='red'>${module.remark}</font>">
										<input id="allCheck${module.moduleId}" type="checkbox" value="" onchange="doSelectAll(this)">&#12288;<label for="allCheck${module.moduleId}">${module.moduleName}：</label>
									</td>
									<td>
										<c:forEach items="${module.menuSetList}" var="menuSet" varStatus="status">
											<c:set var="canShowMemuSet" value="false" scope="page"></c:set>
											<c:if test="${sessionScope.currWsId=='srm' }">
												<c:set var="canShowMemuSet" value="${pdfn:canShowByVersion(menuSet.version)}" scope="page"></c:set>
											</c:if>
											<c:if test="${sessionScope.currWsId!='srm' }">
												<c:set var="canShowMemuSet" value="true" scope="page"></c:set>
											</c:if>
											<c:if test="${canShowMemuSet == true }">
												<c:forEach items="${menuSet.menuList}" var="menu" varStatus="status">
													<c:if test="${!fn:contains(menu.menuId,'xtpz-xtpz') and !fn:contains(menu.menuId,'xtpz-fwxy')}">
														<c:set var="canShowMemu" value="false" scope="page"></c:set>
														<c:if test="${sessionScope.currWsId=='srm' }">
															<c:set var="canShowMemu" value="${pdfn:canShowByVersion(menu.version)}" scope="page"></c:set>
														</c:if>	
														<c:if test="${sessionScope.currWsId!='srm' }">
															<c:set var="canShowMemu" value="true" scope="page"></c:set>
														</c:if>
														
														<c:if test="${canShowMemu == true }">
															<c:set var="total" value="${total+1 }" scope="page"></c:set>
															<span style="width: 220px;display:block; float:left; color: ;"><input id="${menu.menuId}" name="menuId" type="checkbox" value="${menu.menuId}" class="validate[required]" <c:if test="${pdfn:contain(menu.menuId, menuIds)}">checked</c:if>>
															&#12288;<label for="${menu.menuId}">${menuSet.setName}-${menu.menuName}
															<c:set var="actionNum" value="0" scope="page"></c:set>
															<c:forEach items="${menu.actionList}" var="action" varStatus="status">
																<p style="padding:0;text-indent:1em;line-height:1em;">&#12288;<input id="${action.actionId}" name="menuId" type="checkbox" value="${action.actionId}" class="" <c:if test="${pdfn:contain(action.actionId, menuIds)}">checked</c:if>>
																<label for="${action.actionId}">
																<i><font color="gray">&#12288;${action.actionName}</font></i>
																</label>
																</p>
																<c:set var="actionNum" value="${actionNum+1 }" scope="page"></c:set>
															</c:forEach>
															</label>&#12288;
															</span>		
																<c:if test="${((total) mod 3)==0 }">
																	<br>
																</c:if>
															</c:if>
														</c:if>
												</c:forEach>
											</c:if>
										</c:forEach>
									</td>
								</tr>			
								<c:set var="total" value="0" scope="page"></c:set>
							</c:if>					
						</c:forEach>
					</table>
					<div class="button" style="width: 800px;">
						<input class="search" type="button" value="保&#12288;存"
										onclick="doSave();" />
						<input class="search" type="button" value="关&#12288;闭"
										onclick="jboxClose();" />
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</div>
</body>
</html>