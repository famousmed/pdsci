<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
</jsp:include>
<script type="text/javascript">
	$(document).ready(function(){
		<c:if test="${not empty doctorList}">
			$("#dataFoot").hide();
		</c:if>
		selRotation();
	});
	
	function selDept(doctorFlow){
		jboxOpen("<s:url value='/sch/doc/seldept_item'/>?doctorFlow="+doctorFlow,"医师选科",800,500);
	}
	
	function search(){
		$("#doctorSearchForm").submit();
	}
	
	function viewSelection(){
		if($("#selection").attr("checked")){
			$(".data").hide();
			$(".selection").show();
			if($(".selection").length<=0){
				$("#dataFoot").show();
			}
		}else{
			$(".data").show();
			$("#dataFoot").hide();
		}
	}
	
	function selRotation(){
		var speId = $("#speId").val();
		var sessionNumber = $("#sessionNumber").val();
		
		$(".rotation").hide();
		$(".rotation"+(valueIsNotBlank(speId)?("."+speId):"")+(valueIsNotBlank(sessionNumber)?("._"+sessionNumber):"")).show();
	}
	
	function valueIsNotBlank(value){
		return value!=null && $.trim(value) != "";
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form action="<s:url value='/sch/doc/searchSeldept'/>" id="doctorSearchForm" method="post">
			<div>
				届数：<select id="sessionNumber" name="sessionNumber" class="xlselect" style="width: 60px" onchange="selRotation();">
						<option></option>
						<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
							<option value="${dict.dictName}" ${dict.dictName eq param.sessionNumber?'selected="selected"':''}>${dict.dictName}</option>
						</c:forEach>
					</select>
				培训专业：
					<select id="speId" name="trainingSpeId" class="xlselect"  onchange="selRotation();">
						<option></option>
						<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
							<option value="${dict.dictId}" ${param.trainingSpeId eq dict.dictId?'selected=\'selected\'':''}>${dict.dictName}</option>
						</c:forEach>
					</select>
				方案：<select name="rotationFlow" class="xlselect" style="width: 200px">
						<option></option>
						<c:forEach items="${rotationMap}" var="rotation">
							<option class="rotation ${rotation.value.speId} _${rotation.value.sessionNumber}" value="${rotation.value.rotationFlow}" ${rotation.value.rotationFlow eq param.rotationFlow?'selected="selected"':''}>${rotation.value.rotationName}</option>
						</c:forEach>
					</select>
				医师姓名：<input name="doctorName" type="text" value="${param.doctorName}" style="width: 40px;" class="xltext"/>
				<label>只看未完成：<input type="checkbox" id="selection" onclick="viewSelection();" /></label>
				&#12288;
				<input type="button" class="search" onclick="search();" value="查&#12288;询"/>
				&#12288;
				<div style="margin-top: 5px">Tip:&#12288;<font color="red">红色</font>为未完成选科医师</div>
			</div>
			</form>
			<div id="dept" style="width:100%; margin-top: 10px;margin-bottom: 10px;">
		
				<table width="100%" class="xllist" style="font-size: 14px">
						<tr>
							<th style="text-align: center;width: 100px;"  rowspan="2">医师姓名</th>
							<th style="text-align: center;width: 100px;"  rowspan="2">届数</th>
							<th style="text-align: center;width: 100px;"  rowspan="2">年限</th>
							<th style="text-align: center;width: 20%"  rowspan="2">轮转方案</th>
							<th style="text-align: center;width: 5%" colspan="3">选科</th>
							<th style="text-align: center;" rowspan="2">操作</th>
						</tr>
						<tr>
							<th style="width: 15%">第一年</th><th style="width: 15%">第二年</th><th style="width: 15%">第三年</th>
						</tr>
						<c:forEach items="${doctorList}" var="doctor">
							<tr class="data ${!(doctor.selDeptFlag eq GlobalConstant.FLAG_Y)?'selection':''}">
								<td style="${!(doctor.selDeptFlag eq GlobalConstant.FLAG_Y)?'color:red;':''}">${doctor.doctorName}</td>
								<td>${doctor.sessionNumber}</td>
								<td>${rotationMap[doctor.rotationFlow].rotationYear}</td>
								<td>${rotationMap[doctor.rotationFlow].rotationName}</td>
								<c:if test="${empty doctorDeptMap[doctor.doctorFlow]}">
									<td>-</td>
									<td>-</td>
									<td>-</td>
								</c:if>
								<c:set value="" var="firstDept"></c:set>
								<c:set value="" var="secondDept"></c:set>
								<c:set value="" var="thirdDept"></c:set>
								<c:if test="${!empty doctorDeptMap[doctor.doctorFlow]}">
									<c:forEach items="${doctorDeptMap[doctor.doctorFlow]}" var="doctorDept" varStatus="status">
										<c:if test="${!empty doctorDept.schMonth && !(doctorDept.schMonth eq '0')}">
											<c:set value="${firstDept}${empty firstDept?'':'，'}${doctorDept.schDeptName}" var="firstDept"></c:set>
										</c:if>
									</c:forEach>
									<td><font style="color:blue">${firstDept}</font>${empty firstDept?'-':''}</td>
									<td><font style="color:blue">${secondDept}</font>${empty secondDept?'-':''}</td>
									<td><font style="color:blue">${thirdDept}</font>${empty thirdDept?'-':''}</td>
								</c:if>
								<td>
									<c:if test="${!empty rotationGroupMap[doctor.rotationFlow] && (empty resultMap[doctor.doctorFlow])}">
										[<a href="javascript:selDept('${doctor.doctorFlow}');" >选科</a>]
									</c:if>
									${empty rotationGroupMap[doctor.rotationFlow] || !(empty resultMap[doctor.doctorFlow])?'-':''}
								</td>
							</tr>
						</c:forEach>
						<tr id="dataFoot"><td align="center" colspan="8">无记录</td></tr>
					</table>
			</div>
	</div>
</div>
</div>
</body>
</html>