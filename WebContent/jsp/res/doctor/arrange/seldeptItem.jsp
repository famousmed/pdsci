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
<style type="text/css">
	caption{line-height:40px;text-align:left;font-weight:bold; padding-left:10px; border-bottom:1px solid #ddd;color:#f60;}
</style>
<script type="text/javascript">
	function saveDoctorDept(groupFlow,schDeptFlow,schDeptName,recordFlow){
		if($("#deptNum"+groupFlow).val() == $("font."+groupFlow+":hidden").length){
			if($("img."+groupFlow+"._"+schDeptFlow).is(":hidden")){
				jboxTip("当前组合不能选择更多科室!");
				return ;
			}
		}
		var url = "<s:url value='/sch/doc/saveDoctorDept'/>";
		var getdata = {
				"recordFlow":recordFlow,
				"doctorFlow":'${doctor.doctorFlow}',
				"doctorName":'${doctor.doctorName}',
				"rotationFlow":'${doctor.rotationFlow}',
				"rotationName":'${doctor.rotationName}',
				"sessionNumber":'${doctor.sessionNumber}',
				"firstYear":$("#first"+groupFlow+schDeptFlow).text(),
				"secondYear":$("#second"+groupFlow+schDeptFlow).text(),
				"thirdYear":$("#third"+groupFlow+schDeptFlow).text(),
				"groupFlow":groupFlow,
				"schDeptFlow":schDeptFlow,
				"schDeptName":schDeptName,
				"ordinal":$("font").index($("font."+groupFlow+"._"+schDeptFlow))
		};
		jboxPost(url, getdata, function(data) {
			if(data=='${GlobalConstant.SAVE_SUCCESSED}'){
				$("."+groupFlow+"._"+schDeptFlow).each(function(){
					if($(this).is(":hidden")){
						$(this).show();
					}else{
						$(this).hide();
					}
				});
			}
		},null,false);
	}
	
	function openDetail(rotationName, rotationFlow){
		//jboxOpenContent($("#"+rotationFlow),"轮转说明",800,300);
		var url = "<s:url value='/sch/template/editRotation'/>?roleFlag=${param.roleFlag}&viewFlag=${GlobalConstant.FLAG_Y}&rotationFlow="+rotationFlow;
		jboxOpen(url, rotationName, 800, 500);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div>
				<table class="basic" width="100%">
					<tr>
						<td>
							医师姓名：<font style="font-weight: bold;">${doctor.doctorName}</font>
							&#12288;&#12288;
							轮转方案：<font title="点击查看方案说明" style="font-weight: bold;cursor: pointer;color: blue;"  onclick="openDetail('${doctor.rotationName}','${doctor.rotationFlow}');">${doctor.rotationName}</font>
							<c:if test="${empty resultList}">
								<font style="float: right;margin-right: 10px;">Tip ：<font color="blue">再次点击可取消选科!</font></font>
							</c:if>
						</td>
					</tr>
				</table>
				<c:if test="${empty rotationGroupList}">
				<table class="basic" width="100%" style="margin-top: 10px;">
					<tr>
						<td style="text-align: center;">
							暂时还没有组合科室可供选择!
						</td>
					</tr>
				</table>
				</c:if>
			</div>
			<div id="dept" style="width:100%; margin-top: 10px;margin-bottom: 10px;">
			<c:forEach items="${rotationGroupList}" var="rotationGroup">
				<input type="hidden" id="deptNum${rotationGroup.groupFlow}" value="${rotationGroup.deptNum}" />
				<table border="0"  cellspacing="0" cellpadding="0" style="width: 100%;margin-bottom: 10px;">
					<caption>${rotationGroup.groupName}</caption>
				</table>
					<table width="100%" class="xllist" style="font-size: 14px" id="${rotationGroup.groupFlow}">
						<tr>
							<th style="text-align: center;width: 200px;">轮转科室</th>
							<th style="text-align: center;">时间(月数)</th>
							<th style="text-align: center;">轮转时间</th>
							<th style="text-align: center;">备注(培养要求)</th>
							<th style="text-align: center;">选科</th>
						</tr>
						<c:forEach items="${rotationDeptMap[rotationGroup.groupFlow]}" var="rotationDept">
							<c:set value="${rotationGroup.groupFlow}${rotationDept.schDeptFlow}" var="doctorDeptKey"/>
							<tr>
								<td >${rotationDept.schDeptName}</td>
								<td>${rotationDept.schMonth}个月</td>
								<td>
									<span id="first${doctorDeptKey}">${rotationDept.firstYear}</span>
									${empty rotationDept.secondYear?'':'+'}
									<span id="second${doctorDeptKey}">${rotationDept.secondYear}</span>
									${empty rotationDept.thirdYear?'':'+'}
									<span id="third${doctorDeptKey}">${rotationDept.thirdYear}</span>
								</td>
								<td >${rotationDept.deptNote}</td>
								<td >
									<c:if test="${!empty doctorDeptMap[doctorDeptKey] && !empty resultList}">
										<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
									</c:if>
									<c:if test="${empty resultList}">
										<a href="javascript:saveDoctorDept('${rotationGroup.groupFlow}','${rotationDept.schDeptFlow}','${rotationDept.schDeptName}','${doctorDeptMap[doctorDeptKey].recordFlow}')">
											<img class="${rotationGroup.groupFlow} _${rotationDept.schDeptFlow}"  style="cursor: pointer;${empty doctorDeptMap[doctorDeptKey]?'display: none':''}" title="取消" src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
											<font class="${rotationGroup.groupFlow} _${rotationDept.schDeptFlow}" style="${!empty doctorDeptMap[doctorDeptKey]?'display: none':''}">[选择]</font>
										</a>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</table>
				</c:forEach>
			</div>
	</div>
</div>
</div>
</body>
</html>