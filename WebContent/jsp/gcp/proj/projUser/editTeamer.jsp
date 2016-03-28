<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
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
	function search(){
		$("#searchForm").submit();
	}
	function save(){
		if(false==$("#searchForm").validationEngine("validate")){
			jboxTip("请先选择需要授权的角色!");
			return false;
		}
		
		var checkboxs = $("input[name='userFlow']:checked");
		var userFlows = "";
		checkboxs.each(function(){
			var userFlow = this.value;
			userFlows = userFlows + "&userFlow=" + userFlow;
		});
		var deptFlow = $("select[name='deptFlow']").val();
		var roleFlow = $("input[name='roleFlow']:checked").val();
		var url = "<s:url value='/gcp/proj/saveProjMember'/>" ;
		jboxPost(
				url,
				userFlows + "&projFlow=${param.projFlow}" + "&deptFlow=" + deptFlow + "&roleFlow=" + roleFlow,
				function(resp){
					if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
						window.location.reload(true);
						window.parent.frames['mainIframe'].window.loadResearchUser();
						jboxTip("保存成功！");
					}
				},null,true);
		}
</script>
<style type="text/css">
	table.xllist tr th, table.xllist tr td{text-align: center;padding: 0;margin: 0;}
</style>
</head>
<body>
	<div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
		<form id="searchForm" action="<s:url value='/gcp/proj/editTeamer'/>" method="post">
			<input name="projFlow" type="hidden" value="${param.projFlow}" />
  			<div style="margin-bottom: 10px;">
  				<p>
  				姓名：<input type="text" name="userName" class="xltext" value="${param.userName}" onchange="search()">
				&nbsp;所属科室：
				<select name="deptFlow" class="xlselect" onchange="search()">
					<option value="">全部</option>
					<c:forEach items="${sysDeptList}" var="dept">
					<option value="${dept.deptFlow}" <c:if test="${param.deptFlow eq dept.deptFlow}">selected="selected"</c:if>>${dept.deptName}</option>
					</c:forEach>
				</select>
				</p>
				<p>
				&nbsp;研究岗位：
				<c:forEach items="${applicationScope.sysRoleWsMap[GlobalConstant.GCP_WS_ID]}" var="role" varStatus="status">
					<c:if test="${roleLevelEnumProjLevel.id == role.roleLevelId}">
					<input type="radio" id="${role.roleFlow}" name="roleFlow" class="validate[required]" value="${role.roleFlow}" onclick="search()" <c:if test="${status.first || role.roleFlow==param.roleFlow}">checked="checked"</c:if> /> <label for="${role.roleFlow}">${role.roleName}&#12288;</label>
					</c:if>
				</c:forEach>
				<input type="button" class="search" onclick="search()" value="查&#12288;询"/>
				</p>
   			</div>
			     <table class="xllist" width="100%" id="irbUsers" >
		            <thead>
		            	<tr>
		            		<th width="6%" >勾选</th>
		            		<th width="10%" >姓名</th>
		            		<th width="7%" >性别</th>
		            		<th width="15%" >科室</th>
		            		<th width="15%" >职务</th>
		            		<th width="12%" >职称</th>
		            		<th width="14%" >手机</th>
		            		<th width="21%" >GCP培训日期</th>
		            	</tr>
		            </thead>
		            <c:forEach items="${userList}" var="user">
		            	<tr>
			            	<td width="6%"><input type="checkbox" name="userFlow" value="${user.userFlow}" 
			            				<c:if test="${not empty projUserMap[user.userFlow]}">checked="checked"</c:if>
			            				<c:if test="${projUserMap[user.userFlow].roleFlow eq applicationScope.sysCfgMap[GlobalConstant.RESEARCHER_ROLE_FLOW] and proj.applyUserFlow eq user.userFlow}">disabled="disabled"</c:if>  />
           				 	</td>
			            	<td width="10%">${user.userName}</td>
			            	<td width="7%">${user.sexName}</td>
			            	<td width="15%">${user.deptName}</td>
			            	<td width="15%">${user.postName}</td>
			            	<td width="12%">${user.titleName}</td>
			            	<td width="14%">${user.userPhone}</td>
			            	<td width="21%">${trainDateMap[user.userFlow]}</td>
		            	</tr>
		            </c:forEach>
		            </table>
			<p align="center" style="width:100%">
				<input class="search" type="button" value="保&#12288;存"  onclick="save();" />
			</p>
		</form>
         </div>
        
     </div> 	
   </div>
</body>
</html>