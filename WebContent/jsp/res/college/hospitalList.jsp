<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_form" value="false" />
	<jsp:param name="jquery_ui_tooltip" value="true" />
	<jsp:param name="jquery_ui_combobox" value="false" />
	<jsp:param name="jquery_ui_sortable" value="false" />
	<jsp:param name="jquery_cxselect" value="true" />
	<jsp:param name="jquery_scrollTo" value="false" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="false" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
</jsp:include>

<style type="text/css">
	.toolkit-lg {
		min-height: 49px;
	}
	
	.toolkit-bar {
		border-bottom: 1px solid #ddd;
		min-height: 48px;
		border-top: 1px solid #ddd;
	}
	
	.toolkit {
		/* min-height: 37px; */
		position: relative;
	}
	
	.bg-f6 {
		background-color: #f6f6f6;
	}
	
	.toolkit-bar>ul {
		margin-right: 0;
	}
	
	.toolkit>ul {
		margin-right: -5px;
	}
	
	.toolkit-bar>ul {
		margin-right: 0;
	}
	
	.fl {
		float: left !important;
	}
	
	.fr {
		float: right !important;
	}
	
	ul,ol {
		list-style: none;
		margin: 0;
		padding: 0;
	}
	
	.toolkit-bar>.toolkit-list:first-child>.toolkit-item:first-child {
		margin-left: 12px;
	}
	
	.toolkit-lg.toolkit-bar .toolkit-item-tab {
		margin-top: 0;
		font-size: 14px;
	}
	
	.toolkit-bar .toolkit-item-tab {
		margin-bottom: -1px;
		margin-top: 0;
	}
	
	.toolkit>ul>li {
		margin-right: 10px;
		float: left;
	}
	
	.toolkit-lg.toolkit-bar .toolkit-item-tab>a {
		line-height: 46px;
	}
	
	.toolkit-bar .toolkit-item-tab.active>a {
		border-bottom: 2px solid #69b1df;
		color: #0088cc;
	}
	
	.toolkit-bar .toolkit-item-tab>a:hover {
		color: #0088cc;
	}
	
	.toolkit-bar .toolkit-item-tab>a {
		padding: 1px 5px 0;
		border-bottom: 2px solid transparent;
		color: #888;
		display: block;
		text-decoration: none;
		line-height: 34px;
	}
	
	a:hover,a:focus {
		color: #2a6496;
		outline: 0;
		text-decoration: underline;
	}
	
	a {
		cursor: pointer;
		background: transparent;
		color: #428bca;
		text-decoration: none;
	}
/* 	#closeCol:HOVER { */
/* 		background-color: pink; */
/* 	} */
</style>

<script>
	var slideIndex = 8;
	
	$(document).click(function(){
		toggleView(false);
	});
	
	$(function(){
		$("#detail,[onclick]").click(function(e){
			e.stopPropagation();
		});
	});
	
	function toggleView(flag){
		var right = parseFloat($("#detail").css("right").replace("px",""));
		slide(right,flag);
	}
	
	function slide(right,flag){
		setTimeout(function(){
			var endFlag;
			if(flag)
				endFlag = right<0;
			else
				endFlag = right>=-(slideIndex*100);
			if(endFlag){
				if(flag)
				right+=slideIndex;
				else
				right-=slideIndex;	
				$("#detail").css("right",right+"px");
				slide(right,flag);
			}else{
				if(!flag){
					$("#detail").hide();
					$("#hospitalDetail").empty();
				}else{
					$(".active").click();
				}
			}
		},1);
	}
	
	function search(){
		$("#orgForm").submit();
// 		window.location.href="<s:url value='/res/platform/hospitalList'/>?currentPage="+$("#currentPage").val();
	}
	
	function searchUser(){
		toPage("${param.currentPage}");
	}
	
	function toPage(page) {
		if(page){
			$("#currentPage").val(page);			
		}
		search();
	}
	
	function loadDetail(){
		$("#detail").show();
		toggleView(true);
	}
	
	function addOrg() {
		jboxOpen("<s:url value='/sys/org/edit'/>","新增机构信息", 900, 300);
	}
	
	function editOrg(orgFlow) {
		jboxOpen("<s:url value='/sys/org/edit'/>?orgFlow="+orgFlow,"编辑机构信息", 900, 300);
	}
	
	function addUser(orgFlow,userFlow) {
		var url = "<s:url value='/sys/user/edit/${GlobalConstant.USER_LIST_GLOBAL}'/>?roleFlow=${sysCfgMap['res_admin_role_flow']}&orgFlow="+orgFlow+"&userFlow="+userFlow;
		jboxOpen(url,"管理员账号信息", 900, 400);
	}
	
	function resetPasswd(userFlow){
		jboxConfirm("确认将该用户的密码重置为:${GlobalConstant.INIT_PASSWORD} 吗？",function () {
			var url = "<s:url value='/sys/user/resetPasswd?userFlow='/>"+userFlow;
			jboxGet(url,null,function(){
				//searchUser();			
			});		
		});
	}
	
	function selActive(li){
		$(".active").removeClass("active");
		$(li).addClass("active");
	}
	
	function loadHospitalInfo(){
		jboxLoad("hospitalDetail","<s:url value='/res/platform/hospitalDetail'/>",true);
	}
	
	function loadInternList(){
		jboxLoad("hospitalDetail","<s:url value='/res/platform/internList'/>",true);
	}
	 function xieTong(flow){
		  jboxOpen("<s:url value='/res/platform/jointAll'/>?flow="+flow,"机构",850,500);
		} 
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="orgForm" action="<s:url value='/res/platform/hospitalList'/>" method="post">
					<table class="basic" style="width: 100%;margin-bottom: 10px;">
						<tr>
							<td>
								医院名称：<input type="text" name="orgName" value="${param.orgName}" onchange="search();"/>
<!-- 								&#12288; -->
<!-- 								<label> -->
<%-- 									<input type="checkbox" name="orgTypeId" value="${orgTypeEnumHospital_S.id}" <c:if test="${param.orgTypeId eq orgTypeEnumHospital_S.id}">checked</c:if> onchange="search();"/> 规培基地 --%>
<!-- 								</label> -->
								<input type="button" class="search" onclick="addOrg();" value="新&#12288;增" style="float: right;margin-right: 10px;margin-top: 4px;"/>
								<input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage}"/>
							</td>
						</tr>
					</table>
				</form>
				<table class="basic" width="100%">
					<tr>
						<th width="20%" style="text-align: center;padding: 0px;">医院名称</th>
						<th width="20%" style="text-align: center;padding: 0px;">协同医院</th>
						<th width="10%" style="text-align: center;padding: 0px;">是否为规培基地</th>
						<th width="10%" style="text-align: center;padding: 0px;">联系人</th>
						<th width="10%" style="text-align: center;padding: 0px;">联系方式</th>
						<th width="10%" style="text-align: center;padding: 0px;">管理员账户</th>
						<th width="200px" style="text-align: center;padding: 0px;">操作</th>
					</tr>
					<c:forEach items="${orgList}" var="org">
						<c:set var="user" value="${userMap[org.orgFlow]}"/>
						<tr>
							<td style="text-align: center;padding: 0px;">${org.orgName}</td>
								 
							<td style="text-align: center;padding: 0px;">
								<c:forEach items="${jointOrgMap[org.orgFlow]}" var="joint" varStatus="relStatus">
										<c:if test="${!relStatus.first}">
											,
										</c:if>
										${joint.jointOrgName }
								</c:forEach>
							</td>
							<td style="text-align: center;padding: 0px;">
	            				${org.orgLevelName}
<%-- 								${org.orgTypeId eq orgTypeEnumHospital_S.id?'是':'否'} --%>
							</td>
							<td style="text-align: center;padding: 0px;">${user.userName}</td>
							<td style="text-align: center;padding: 0px;">${user.userPhone}</td>
							<td style="text-align: center;padding: 0px;">${user.userCode}</td>
							<td>
								<a style="color: blue;cursor: pointer;" onclick="editOrg('${org.orgFlow}');">编辑</a> 
								|
								<a style="color: blue;cursor: pointer;" onclick="addUser('${org.orgFlow}','${user.userFlow}');">账户维护</a>
								<c:if test="${!empty user}">
									|
									<a style="color: blue;cursor: pointer;" onclick="resetPasswd('${user.userFlow}');">重置密码</a>
								</c:if>
									|
									<a style="color: blue;cursor: pointer;" onclick="xieTong('${org.orgFlow}');">协同机构维护</a>
<!-- 								&#12288;|&#12288; -->
<!-- 								<a style="color: blue;cursor: pointer;" onclick="loadDetail();">医院详情</a> -->
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty orgList}">
						<tr><td colspan="5" style="text-align: center;">无记录</td></tr>
					</c:if>
				</table>
				<div>
				   	<c:set var="pageView" value="${pdfn:getPageView(orgList)}" scope="request"/>
					<pd:pagination toPage="toPage"/>
				</div>
			</div>
		</div>
	</div>
	<div id="detail" style="height: 100%;
	background: url(<s:url value='/css/skin/${skinPath}/images/detail_shadow.jpg'/>) left repeat-y;
	width: 800px;
	padding-left:11px; 
	position: fixed;
	z-index: 1000;
	display: none;
	right: -800px;
	top: 0">
		<div class="toolkit bg-f6 toolkit-lg toolkit-bar" style="width: 100%;height: 100%;background-color: white;">
			<div id="closeCol" style="transition: background 0.5s;float: left;height: 100%;width: 10px;position: fixed;opacity:0.4;cursor: pointer;" title="关闭" onclick="toggleView(false);"></div>
				<ul class="j_e-nav-tab toolkit-list fl" style="background-color: #f9f9f9;width: 100%;margin:5px;">
					<li class="j_mainline_link toolkit-item toolkit-item-tab j_mainline_link_task router active" onclick="selActive(this);loadHospitalInfo();">
						<a>医院概况</a>
					</li>
					<li class="j_mainline_link toolkit-item toolkit-item-tab j_mainline_link_task router" onclick="selActive(this);loadInternList();">
						<a>实习名单</a>
					</li>
				</ul>
				<div id="hospitalDetail" style="height: 100%;width: 100%;overflow: auto;"></div>
		</div>
	</div>
</body>
</html>