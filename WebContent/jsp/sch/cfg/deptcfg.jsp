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

<style type="text/css">
	.selSysDept span{color: red;}
</style>

<script type="text/javascript">
	var currentStatus = "${param.currentStatus}";
	function viewDept(deptFlow){
		if(deptFlow){
			$(".selSysDept").removeClass("selSysDept");
			$(".TR_"+deptFlow).addClass("selSysDept");
			$("[class^='SCH']").hide();
			$(".SCH_"+deptFlow).show();
		}else{
			$(".selSysDept").removeClass("selSysDept");
			$("[class^='SCH']").show();
		}
		if(!$("[class^='SCH']:visible").length) 
			$("#recordStatus").show();
		else 
			$("#recordStatus").hide();
		
// 		if($(".selSysDept").length) 
// 			$("#showAllBtn").show();
// 		else
// 			$("#showAllBtn").hide();
	}
	
	function schDeptRelCfg(){
		jboxOpen("<s:url value='/sch/cfg/schDeptRelCfg'/>","标准科室与轮转科室关系配置",700,500);
	}
	
	function addDept(){
		var deptFlow =  $(".selSysDept").attr("deptFlow") || "";
		var orgFlow = "${orgFlow}";
		jboxOpen("<s:url value='/sch/cfg/editDept'/>?deptFlow="+deptFlow+"&orgFlow="+orgFlow, "新增部门",800, 425);
	}
	function editDept(schDeptFlow){
		var deptFlow =  $(".selSysDept").attr("deptFlow") || "";
		var orgFlow = "${orgFlow}";
		jboxOpen("<s:url value='/sch/cfg/editDept'/>?schDeptFlow="+schDeptFlow+"&deptFlow="+deptFlow+"&orgFlow="+orgFlow, "编辑部门信息", 800, 425);
	}
	
	function delDept(schDeptFlow,deptFlow){
		jboxConfirm("确认删除?",function () {
			var url = "<s:url value='/sch/cfg/delDept'/>?schDeptFlow=" + schDeptFlow;
			jboxPost(url,null,function(resp){
				if(resp == '${GlobalConstant.DELETE_SUCCESSED}'){
					location.href = "<s:url value='/sch/cfg/deptcfg/${roleFlag}'/>?deptFlow="+deptFlow;
					//window.parent.frames['mainIframe'].window.reload(true);
					//doClose();
				}
			},null,true);
		});
	}
	//部门操作
	function add(){
		jboxOpen("<s:url value='/sys/dept/edit?orgFlow=${orgFlow}'/>","编辑部门信息", 500, 300);
	}

	function edit(deptFlow){
		jboxOpen("<s:url value='/sys/dept/edit?deptFlow='/>"+deptFlow,"编辑部门信息", 500, 300);
	}
	function del(deptFlow,recordStatus){
		var msg = "";
		if (recordStatus == '${GlobalConstant.RECORD_STATUS_N}') {
			msg = "停用";
		} else if (recordStatus == '${GlobalConstant.RECORD_STATUS_Y}') {
			msg = "启用";
		}
		jboxConfirm("确认"+msg+"该记录吗？",function () {
			var url = "<s:url value='/sys/dept/delete?deptFlow='/>" + deptFlow+ "&recordStatus=" + recordStatus;
			jboxGet(url,null,function(){
				search("${orgFlow}");					
			});			
		});
	}
	
	//切换机构
	function changeOrg(orgFlow){
		var deptFlow = $(".selSysDept").attr("deptFlow") || "";
		location.href = "<s:url value='/sch/cfg/deptcfg/${roleFlag}'/>?orgFlow="+orgFlow+"&deptFlow="+deptFlow;
	}
	
	function search(orgFlow){
		<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq roleFlag}">
			changeOrg(orgFlow);
		</c:if>
		<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq roleFlag)}">
			var deptFlow = $(".selSysDept").attr("deptFlow") || "";
			location.href = "<s:url value='/sch/cfg/deptcfg/${roleFlag}'/>?deptFlow="+deptFlow;
		</c:if>
	}
	
	function mapTheDept(){
		var orgFlow = $("#orgHome").val() || "";
		var needDept = $("[needMap]");
		if(needDept.length){
			var data = "";
			needDept.each(function(){
				data+=("&deptFlow="+$(this).attr("deptFlow"));
			});
			jboxConfirm("确认开始初始化轮转科室？",function(){
				jboxPost("<s:url value='/sch/cfg/mapTheDept'/>?orgFlow="+orgFlow+data,null,function(resp){
					if(resp="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
						top.jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
						search(orgFlow);
					}
				},null,false);
			},null);
		}else{
			jboxTip("暂无需要关联科室！");
		}
	}
	
	$(document).ready(function(){
		viewDept("${param.deptFlow}");
		$("#schDeptCountT").text($("#schDeptCount").val());
		//$("#${param.deptFlow}").text("${schDeptList.size()}");
	});
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		 <div class="title1 clearfix">
		 	<table class="basic" style="width:100%;margin-bottom: 10px;">
		 		<tr>
		 			<td>
<!-- 		 				<input type="button" class="search" value="标准科室与轮转科室关系配置" onclick="schDeptRelCfg();"/> -->
						<input type="button" class="search" value="初始化轮转科室" onclick="mapTheDept();"/>
						&#12288;
					 	<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq roleFlag}">
						选择机构：
						<select id="orgHome" onchange="changeOrg(this.value);">
							<c:forEach items="${applicationScope.sysOrgList}" var="org">
								<option value="${org.orgFlow}"
								<c:if test="${orgFlow eq org.orgFlow}">selected</c:if>
								>${org.orgName}</option>
							</c:forEach>
						</select>
					 	</c:if>
		 			</td>
		 		</tr>
		 	</table>
		 	<div style="width: 40%;float: left">
		 		<table class="basic" style="width: 100%">
					<tr>
						<th style="text-align: left;padding-left: 20px;">
						医院科室
						<a style="float: right; padding-right: 10px;" href="javascript:add('${orgFlow}')"><img title="新增" src="<s:url value='/css/skin/${skinPath}/images/add.png'/>"></a>
						</th>
					</tr>
					<c:forEach items="${deptList}" var="dept">
						<tr class="viewTd TR_${dept.deptFlow}" deptFlow="${dept.deptFlow}" <c:if test="${schDeptCountMap[dept.deptFlow].size()+0 == 0}"> needMap</c:if>>
							<td valign="top" style="text-align: left;padding-left: 20px;">
								<span onclick="viewDept('${dept.deptFlow}');" style="cursor: pointer;">${dept.deptName}（<font id="${dept.deptFlow}">${schDeptCountMap[dept.deptFlow].size()+0}</font>）</span>
								<a style="float: right;margin-right: 10px;color: blue;cursor: pointer;" onclick="del('${dept.deptFlow}','${GlobalConstant.RECORD_STATUS_Y eq dept.recordStatus?GlobalConstant.RECORD_STATUS_N:GlobalConstant.RECORD_STATUS_Y}');">
									<c:if test="${GlobalConstant.RECORD_STATUS_Y eq dept.recordStatus}">
										停用
									</c:if>
									<c:if test="${GlobalConstant.RECORD_STATUS_N eq dept.recordStatus}">
										启用
									</c:if>
								</a>
								<font style="float: right;">&#12288;|&#12288;</font>
								<a style="float: right;color: blue;cursor: pointer;" onclick="edit('${dept.deptFlow}');">编辑</a>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty deptList}">
						<tr><td>暂无医院科室</td></tr>
					</c:if>
				</table>
		 	</div>
		 <c:if test="${!empty deptList}">
		<div id="dept" style="width:58%; margin-left:10px;margin-bottom: 10px;float: left">
			<table class="xllist" > 
				<thead>
				<tr><th colspan="6" style="text-align: left;padding-left: 10px;">
					<span id="showAllBtn" onclick="viewDept('');" style="cursor: pointer;font-weight: normal;color: blue;">显示全部</span>
					<a style="float: right; padding-right: 10px;" href="javascript:addDept()"><img title="新增" src="<s:url value='/css/skin/${skinPath}/images/add.png'/>"></a>
					<font style="float: right;margin-right: 10px;">总轮转科室数：<font id="schDeptCountT"></font></font>
				</th></tr>
				<tr>
					<th width="200px">医院科室</th>
					<th width="200px">轮转科室</th>
					<th width="200px">标准科室</th>
					<th width="100px">容纳人数</th>
					<th width="100px">对外</th>
					<th width="100px">操作</th>
				</tr>
				</thead>
				<c:forEach items="${deptList}" var="dept">
					<c:set value="${schDeptCount+schDeptCountMap[dept.deptFlow].size()}" var="schDeptCount"/>
					<c:forEach items="${schDeptCountMap[dept.deptFlow]}" var="schDept">
						<tr 
							<c:if test="${GlobalConstant.FLAG_Y eq schDept.isExternal}">
							title="
							<table>
								<tr>
									<th colspan='2'>外院信息</th>
								</tr>
								<tr>
									<td style='text-align: right;height:20px;'>名称 ：</td>
									<td>${deptExtRelMap[schDept.schDeptFlow].relOrgName}</td>
								</tr>
								<tr>
									<td style='text-align: right;height:20px;'>医院科室：</td>
									<td>${deptExtRelMap[schDept.schDeptFlow].relDeptName}</td>
								</tr>
								<tr>
									<td style='text-align: right;height:20px;'>轮转科室：</td>
									<td>${deptExtRelMap[schDept.schDeptFlow].relSchDeptName}</td>
								</tr>
							</table>
							" 
							</c:if>
						class="SCH_${dept.deptFlow}">
							<td>
							<c:if test="${GlobalConstant.FLAG_Y eq schDept.isExternal}">
								<font color="red">*</font>
							</c:if>
							${schDept.deptName}
							</td>
							<td>${schDept.schDeptName}</td>
							<td>
								<c:forEach items="${deptRelMap[schDept.schDeptFlow]}" var="deptRel" varStatus="status">
									<c:if test="${!status.first}">
										,
									</c:if>
									${deptRel.standardDeptName}
								</c:forEach>
								<c:if test="${empty deptRelMap[schDept.schDeptFlow]}">未关联</c:if>
							</td>
							<td>${schDept.deptNum}</td>
							<td>
								<c:if test="${schDept.external eq GlobalConstant.FLAG_N}">
									否
								</c:if>
								<c:if test="${schDept.external eq GlobalConstant.FLAG_Y}">
									是
								</c:if>
							</td>
							<td>
								<a href="javascript:editDept('${schDept.schDeptFlow}')" style="color: blue">编辑</a>&#12288;|&#12288;<a href="javascript:delDept('${schDept.schDeptFlow}','${schDept.deptFlow}')" style="color: blue">删除</a>
							</td>
						</tr>
					</c:forEach>
				</c:forEach>
				<tr id="recordStatus" style="<c:if test="${!empty schDeptCountMap}">display: none;</c:if>"><td align="center" colspan="7">暂无轮转科室</td></tr>
			</table>
			<input type="hidden" id="schDeptCount" value="${schDeptCount+0}">
		</div>
		</c:if>
	</div> 
</div>
</div>
</body>
</html>