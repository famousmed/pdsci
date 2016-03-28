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
	<jsp:param name="jquery_cxselect" value="true"/>
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
	function search() {
		$("#searchForm").submit();
	}
	function distributeUser(orgFlow){
		jboxOpen("<s:url value='/gcp/declarer/editUser'/>?orgFlow="+orgFlow,"分配人员", 650, 300);
	}
	
	function editOrg(orgFlow){
		var boxName = "新增机构";
		if(orgFlow != null && orgFlow != ""){
			boxName = "编辑机构";
		}
		jboxOpen("<s:url value='/gcp/declarer/editOrg'/>?orgFlow="+orgFlow,boxName, 700, 450);
	}
	
	function lock(userFlow){
		jboxConfirm("确认锁定该用户吗？锁定后该用户将不能登录系统！",function () {
			var url = "<s:url value='/sys/user/lock?userFlow='/>"+userFlow;
			jboxGet(url,null,function(){
				search();			
			});		
		});
	}
	
	function resetPassword(userFlow){
		jboxConfirm("确认将该用户的密码重置为:${GlobalConstant.INIT_PASSWORD} 吗？",function () {
			var url = "<s:url value='/sys/user/resetPasswd?userFlow='/>"+userFlow;
			jboxGet(url,null,null);		
		});
	}
	
	function activate(userFlow){
		jboxConfirm("确认解锁该用户吗？",function () {
			var url = "<s:url value='/sys/user/activate?userFlow='/>"+userFlow;
			jboxGet(url,null,function(){
				search();			
			});
		});
	}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" action="<s:url value="/gcp/declarer/list" />"	method="post">
					机构名称：
					<input type="text" name="orgName" value="${param.orgName}" class="xltext"/> 
					所属省份：
					<span id="provCityAreaId">
						<select id="orgProvId" name="orgProvId" class="province xlselect" data-value="${param.orgProvId}" data-first-title="选择省" style="width: 120px;"></select>
						<select id="orgCityId" name="orgCityId" class="city xlselect" data-value="${param.orgCityId}" data-first-title="选择市" style="width: 120px;"></select>
						<select id="orgAreaId" name="orgAreaId" class="area xlselect" data-value="${param.orgAreaId}" data-first-title="选择地区" style="width: 120px;"></select>
					</span> 
					<script type="text/javascript">
						// 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件 
						$.cxSelect.defaults.url = "<s:url value='/js/provCityAreaJson.min.json'/>"; 
						$.cxSelect.defaults.nodata = "none"; 

						$("#provCityAreaId").cxSelect({ 
						    selects : ["province", "city", "area"],
						    //selects : ["province"], 
						    nodata : "none",
							firstValue : ""
						}); 
					</script>
					<input id="currentPage" type="hidden" name="currentPage" value=""/> 
					<input type="button" class="search" onclick="search();" value="查&#12288;询">
					<input type="button" class="search" onclick="editOrg('');" value="新&#12288;增">
				</form>
			</div>			
			<table id="orgTable" class="xllist">
				<thead>
				<tr>
					<th width="15%">申办方名称</th>
					<th width="15%">所属地区</th>
					<th width="15%">地址</th>
					<th width="10%">负责人</th>
					<th width="10%">负责人联系方式</th>
					<th width="15%">操作</th>
				</tr>
				</thead>						
				<tbody>
				<c:forEach items="${orgList}" var="org">
					<tr>
						<td>${org.orgName}</td>
						<td>${org.orgProvName}${org.orgCityName}${org.orgAreaName}</td>
						<td>${org.orgAddress}</td>
						<td>${(orgInfoFormMap[org.orgFlow])['orgInfo.name']}</td>
						<td>${(orgInfoFormMap[org.orgFlow])['orgInfo.phone']}</td>
						<td>
							<c:if test="${!(userMap[org.orgFlow].statusId eq userStatusEnumLocked.id)}">
								[<a onclick="editOrg('${org.orgFlow}');" style="cursor: pointer;">编辑</a>]
								[<a onclick="resetPassword('${userMap[org.orgFlow].userFlow}')" style="cursor: pointer;">重置密码</a>]
								[<a onclick="lock('${userMap[org.orgFlow].userFlow}');" style="cursor: pointer;">锁定</a>]
							</c:if>
							<c:if test="${userMap[org.orgFlow].statusId eq userStatusEnumLocked.id}">
								[<a onclick="activate('${userMap[org.orgFlow].userFlow}');" style="cursor: pointer;">解锁</a>]
							</c:if> 
						</td>
					</tr>
				</c:forEach>
				</tbody>
				<c:if test="${empty orgList}">
					<tr><td align="center" colspan="6">无记录</td></tr>
				</c:if>
			</table>
	</div>
</div>
</body>
</html>