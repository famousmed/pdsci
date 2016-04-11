<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<script type="text/javascript">
var currSelDoc;
$(function(){
	$("#internshipArchives").slideInit({
		width:950,
		speed:500,
		outClose:true
	});
});

function internshipArchives(doctorFlow){
	currSelDoc = doctorFlow;
	$("#internshipArchives").rightSlideOpen(function(){
		$("#internshipArchives .selectTag").click();
	});
}

function archivesSelTag(selObj,type){
	$("#internshipArchives .selectTag").removeClass("selectTag");
	$(selObj).addClass("selectTag");
	
	var url = "<s:url value='/res/rec/showRecForm'/>?roleFlag=${GlobalConstant.RES_ROLE_SCOPE_LEADER}&recTypeId="+type+"&operUserFlow="+currSelDoc;
	jboxLoad("internshipArchivesTagContent",url,false);
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
		<div class="title1 clearfix">组别：${doctor.groupName }</div>
		<table class="xllist">
			<thead>
				<tr>
					<th width="100">姓名</th>
					<th width="100">性别</th>
					<th width="120">手机号</th>
					<th width="100">请假/缺勤天数</th>
					<th width="200">当前轮转科室</th>
					<th width="200">下一轮转科室</th>
					<!-- 
					<th width="20%">届数</th>
					<th width="30%">轮转方案</th>
					 -->
					<th width="100">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${doctorList}" var="doctor">
					<tr>
						<td>${doctor.doctorName}</td>
						<td>${userMap[doctor.doctorFlow].sexName}</td>
						<td>${userMap[doctor.doctorFlow].userPhone}</td>
						<td>${absenceSumMap[doctor.doctorFlow]+0}</td>
						<td>
							<c:if test="${!empty currResultMap[doctor.doctorFlow]}">
								${currResultMap[doctor.doctorFlow].schDeptName}
								<br>
								(
								${currResultMap[doctor.doctorFlow].schStartDate}
								~ 
							 	${currResultMap[doctor.doctorFlow].schEndDate}
							 	)
						 	</c:if>
					 	</td>
						<td>
							<c:if test="${!empty nextResultMap[doctor.doctorFlow]}">
								${nextResultMap[doctor.doctorFlow].schDeptName}
								<br>
								(
								${nextResultMap[doctor.doctorFlow].schStartDate}
								~
								${nextResultMap[doctor.doctorFlow].schEndDate}
								)
							</c:if>
						</td>
						<td style="text-align: center;">
							<a onclick="internshipArchives('${doctor.doctorFlow}')" style="color: blue;cursor: pointer;">实习档案</a>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty doctorList}">
					<tr><td align="center" colspan="99">无记录</td></tr>
				</c:if>
			</tbody>
		</table>
		</div>
	</div>
</div>
<div id="internshipArchives">
	<div id="archivesInfo" style="width: 98%;height: 100%;background-color: white;padding: 10px;overflow: auto;">
		<ul id="tags">
			<li class="selectTag" onclick="archivesSelTag(this,'${resRecTypeEnumEthics.id}');" style="cursor: pointer;"><a>${resRecTypeEnumEthics.name}</a></li>
			<li onclick="archivesSelTag(this,'${resRecTypeEnumDocument.id}');" style="cursor: pointer;"><a>${resRecTypeEnumDocument.name}</a></li>
			<li onclick="archivesSelTag(this,'${resRecTypeEnumAppraisal.id}');" style="cursor: pointer;"><a>${resRecTypeEnumAppraisal.name}</a></li>
	    </ul>
	    <div id="tagContent" class="divContent">
	    	<div id="internshipArchivesTagContent"></div>
	    </div>
	</div>
</div>
</body>
</html>