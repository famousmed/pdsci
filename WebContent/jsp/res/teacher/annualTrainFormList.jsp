<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>

<script type="text/javascript">
	function toSearch(){
		$(".selectTag").click();
	}
	
	function auditRecs(){
		jboxConfirm("确认审核通过所有年度培训记录？",function(){
			var data = null;
			$("[recFlows]").each(function(){
				data+=("&recFlows="+$(this).attr("recFlows"));
			});
			jboxPost("<s:url value='/res/teacher/auditRecs'/>?headAuditStatusId=${recStatusEnumHeadAuditY.id}&headAuditStatusName=${recStatusEnumHeadAuditY.name}",data,function(resp){
				if("${GlobalConstant.OPRE_SUCCESSED_FLAG}"==resp){
					jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					toSearch();
				}
			},null,false);
		});
	}
	
	function print(){
		<c:if test="${empty param.year}">
			return jboxTip("请选择培训年度！");
		</c:if>
		jboxTip("打印中,请稍等...");
		var url = "<s:url value='/res/doc/printAnnualTrain'/>"
					+"?userFlow=${param.doctorFlow}"+
					"&trainYear=${param.year}";
		window.location.href = url;
	}
</script>
	
</head>
<body>
<div class="mainright">
	<div class="content">
		<form id="searchForm" action="" method="post">
			<table class="basic" style="width: 100%;margin-top: 10px;">
				<tr>
					<td>
						姓名：
						<select name="doctorFlow" onchange="toSearch();" style="width: 100px;">
							<option/>
							<c:forEach items="${userList}" var="user">
								<option value="${user.userFlow}" <c:if test="${param.doctorFlow eq user.userFlow}">selected</c:if>>${user.userName}</option>
							</c:forEach>
						</select>
						&#12288;
						年度：
						<input type="text" name="year" value="${param.year}" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy'});" style="width: 50px;" onchange="toSearch();"/>
						<c:if test="${!empty recList}">
							<input type="button" value="打&#12288;印" class="search" onclick="print();" style="float: right;margin-top: 5px;"/>
						</c:if>
					</td>
				</tr>
			</table>
		</form>
		
		<table class="xllist" style="margin-top: 10px;">
			<tr>
				<th style="width: 16%;">轮转科室</th>
 				<th style="width: 16%;">学习类型</th>
 				<th style="width: 16%;">培训内容</th>
 				<th style="width: 16%;">培训日期</th>
 				<th style="width: 16%;">学分数/学时数</th>
 				<th style="width: 20%;">备注</th>
			</tr>
			
			<c:set var="academicScore" value="0"/>
			<c:set var="classHourScore" value="0"/>
			<c:if test="${GlobalConstant.RES_ROLE_SCOPE_HEAD eq param.roleFlag}">
				<c:set var="needAudit" value="false"/>
			</c:if>
			<c:forEach items="${recList}" var="rec">
				<c:set var="recData" value="${recDataMap[rec.recFlow]}" />
				<c:if test="${GlobalConstant.RES_ROLE_SCOPE_HEAD eq param.roleFlag && !needAudit && empty rec.headAuditStatusId}">
					<c:set var="needAudit" value="true"/>
				</c:if>
				<tr recFlows="${rec.recFlow}">
					<td>${rec.schDeptName}</td>
					<td>${recData.studyType}</td>
					<td>${recData.trainContent}</td>
					<td>${recData.trainDate}</td>
					<td>
						${recData.academicScore} / ${recData.classHourScore}
						<c:set var="academicScore" value="${academicScore+recData.academicScore}"/>
						<c:set var="classHourScore" value="${classHourScore+recData.classHourScore}"/>
					</td>
					<td>${recData.remarks}</td>
				</tr>
			</c:forEach>
			
			<c:if test="${!empty recList}">
				<tr>
					<td rowspan="2">合计</td>
					<td>学时数：</td>
					<td>${classHourScore}</td>
					<td>其中，I类学分：</td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>总学分：</td>
					<td>${academicScore}</td>
					<td>其中，II类学分：</td>
					<td></td>
					<td></td>
				</tr>
			</c:if>
			
			<c:if test="${empty param.doctorFlow}">
				<tr><td colspan="6">请选择学员！</td></tr>
			</c:if>
			<c:if test="${!empty param.doctorFlow && empty recList}">
				<tr><td colspan="6">无记录</td></tr>
			</c:if>
		</table>
		
		<c:if test="${needAudit}">
			<div style="text-align: center;margin-top: 10px;">
				<input type="button" class="search" value="审核通过" onclick="auditRecs();"/>
			</div>
		</c:if>
	</div>
</div>
</body>
</html>
