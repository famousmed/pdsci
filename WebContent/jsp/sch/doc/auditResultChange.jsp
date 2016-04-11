<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="slideRight" value="true"/>
</jsp:include>
<style type="text/css">
	.basic.list td {text-align: center;padding: 0;}
	.basic.list th {text-align: center;padding: 0;}
</style>
<script type="text/javascript">
	String.prototype.htmlFormart = function(){
		var html = this;
		for(var index in arguments){
			html = html.replace("{"+index+"}",arguments[index]);
		}
		return html;
	};
	
	function loadResultList(doctorFlow,doctorName){
		$("#doctorName").text(doctorName);
		$("#resultContent").show();
		$("#resultList").empty();
		jboxPost("<s:url value='/sch/template/doctorResultList'/>",{
			doctorFlow:doctorFlow,
			},
			function(resp){
				if(resp.resultList.length){
					var processMap = resp.processMap;
					$("#auditButton").show();
					for(var index in resp.resultList){
						var result = (resp.resultList)[index];
						var process = processMap[result.resultFlow];
						var status = "";
						if(process){
							if(process.isCurrentFlag == "${GlobalConstant.FLAG_Y}"){
								status = "轮转中";
							}else if(process.schFlag == "${GlobalConstant.FLAG_Y}"){
								status = "已出科";
							}
						}
						var docInfo = $("#template").html();
						docInfo = docInfo.htmlFormart(result.schDeptName,result.schStartDate,result.schEndDate,status);
						$("#resultList").append("<tr>"+docInfo+"</tr>");
					}
					
					$("#agree").click(function(){
						resultAudit({
							doctorFlow:doctorFlow,
							schStatusId:"${schStatusEnumAuditY.id}",
							schStatusName:"${schStatusEnumAuditY.name}",
							schFlag:"${GlobalConstant.FLAG_Y}"
						},"同意");
					});
					$("#notAgree").click(function(){
						resultAudit({
							doctorFlow:doctorFlow,
							schStatusId:"",
							schStatusName:""
						},"不同意");
					});
				}else{
					$("#auditButton").hide();
					$("#resultList").append('<tr><td colspan="3">无记录！</td></tr>');
				}
		},null,false);
	}
	
	function resultAudit(data,title){
		jboxConfirm("确认"+title+"该学员的计划变更？",function(){
			jboxPost("<s:url value='/res/doc/confirmRosting'/>",data,function(resp){
				if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
					top.jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					location.href="<s:url value='/sch/arrange/auditResultChange'/>";
				}
			},null,false);
		},null);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div style="height: 250px;margin-top: 10px;overflow: auto;">
		<table class="basic list" width="100%">
			<tr>
				<th width="10%">姓名</th>
				<th width="5%">性别</th>
				<th width="5%">年龄</th>
				<th width="15%">证件号</th>
				<th width="10%">手机号码</th>
				<th width="5%">届数</th>
				<th width="10%">专业</th>
				<th width="15%">轮转方案</th>
				<th width="10%">操作</th>
			</tr>
			<c:forEach items="${doctorList}" var="doctor">
				<tr>
					<td>${doctor.doctorName}</td>
					<td>${userMap[doctor.doctorFlow].sexName}</td>
					<td>${pdfn:calculateAge(userMap[doctor.doctorFlow].userBirthday)}</td>
					<td>${userMap[doctor.doctorFlow].idNo}</td>
					<td>${userMap[doctor.doctorFlow].userPhone}</td>
					<td>${doctor.sessionNumber}</td>
					<td>${doctor.trainingSpeName}</td>
					<td>${doctor.rotationName}</td>
					<td>
						<a style="color:blue;cursor: pointer;" onclick="loadResultList('${doctor.doctorFlow}','${doctor.doctorName}');">
							排班计划
						</a>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${empty doctorList}">
				<tr><td colspan="10">暂无变更信息！</td></tr>
			</c:if>
		</table>
		</div>
		<div id="resultContent" style="display: none;width: 100%;">
			<div style="margin-bottom: 10px;font-size: 15px;">医师姓名：<font id="doctorName" style="font-weight: bold;"></font></div>
			<table class="basic list" width="100%">
				<tr>
					<th width="25%">轮转科室</th>
					<th width="50%">轮转时间</th>
					<th width="25%">轮转状态</th>
				</tr>
				<tbody id="resultList">
					
				</tbody>
			</table>
			<div id="auditButton" style="width: 100%;text-align: center;margin-top: 10px;">
				<input id="agree" type="button" value="同意变更" class="search">
				<input id="notAgree" type="button" value="不同意变更" class="search">
			</div>
		</div>
		<table style="display: none;">
			<tr id="template">
				<td>{0}</td>
				<td>{1} ~ {2}</td>
				<td>{3}</td>
			</tr>
		</table>
	</div>
</div>
</body>
</html>