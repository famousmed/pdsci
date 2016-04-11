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
	function saveDoctorDept(groupFlow,schDeptFlow,schDeptName,recordFlow,isRequired,standardDeptId){
		if($("#deptNum"+groupFlow).val() == $("font."+groupFlow+":hidden").length){
			if($("img."+groupFlow+"._"+schDeptFlow+"._"+standardDeptId).is(":hidden")){
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
				"firstYear":$("#first"+groupFlow+standardDeptId+schDeptFlow).text(),
				"secondYear":$("#second"+groupFlow+standardDeptId+schDeptFlow).text(),
				"thirdYear":$("#third"+groupFlow+standardDeptId+schDeptFlow).text(),
				"groupFlow":groupFlow,
				"schDeptFlow":schDeptFlow,
				"schDeptName":schDeptName,
				"isRequired":isRequired,
				"standardDeptId":standardDeptId,
				"ordinal":$("font").index($("font."+groupFlow+"._"+schDeptFlow+"._"+standardDeptId))
		};
		jboxPost(url, getdata, function(data) {
			if(data=='${GlobalConstant.SAVE_SUCCESSED}'){
				$("."+groupFlow+"._"+schDeptFlow+"._"+standardDeptId).toggle();
				<c:if test="${!(param.flag eq 'rosteringHandDept')}">
					window.parent.frames["mainIframe"].window.search();
				</c:if>
				<c:if test="${param.flag eq 'rosteringHandDept'}">
					window.parent.frames["mainIframe"].window.loadDeptList("${doctor.doctorFlow}");
				</c:if>
			}
		},null,false);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<c:if test="${!(param.flag eq 'rosteringHandDept')}">
				<div>
					医师姓名：<font color="blue">${doctor.doctorName}</font>&#12288;轮转方案：<font color="blue">${doctor.rotationName}</font>
				</div>
			</c:if>
			<div id="dept" style="width:100%; margin-top: 10px;margin-bottom: 10px;">
			<c:forEach items="${rotationGroupList}" var="rotationGroup">
				<input type="hidden" id="deptNum${rotationGroup.groupFlow}" value="${rotationGroup.deptNum}" />
					<fieldset>
						<legend>${rotationGroup.groupName}</legend>
						<table width="100%" class="xllist" style="font-size: 14px" id="${rotationGroup.groupFlow}">
							<tr>
								<th style="text-align: center;width: 200px;">轮转科室</th>
								<th style="text-align: center;">时间(月数)</th>
								<th style="text-align: center;">轮转时间</th>
								<th style="text-align: center;">备注(培养要求)</th>
								<th style="text-align: center;">选科</th>
							</tr>
							<c:forEach items="${rotationDeptMap[rotationGroup.groupFlow]}" var="rotationDept">
								<c:set value="${rotationGroup.groupFlow}${rotationDept.standardDeptId}${rotationDept.schDeptFlow}" var="doctorDeptKey"/>
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
										<a href="javascript:saveDoctorDept('${rotationGroup.groupFlow}','${rotationDept.schDeptFlow}','${rotationDept.schDeptName}','${doctorDeptMap[doctorDeptKey].recordFlow}','${rotationDept.isRequired}','${rotationDept.standardDeptId}')">
											<img class="${rotationGroup.groupFlow} _${rotationDept.schDeptFlow} _${rotationDept.standardDeptId}"  style="cursor: pointer;${empty doctorDeptMap[doctorDeptKey]?'display: none':''}" title="取消" src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
											<font class="${rotationGroup.groupFlow} _${rotationDept.schDeptFlow} _${rotationDept.standardDeptId}" style="${!empty doctorDeptMap[doctorDeptKey]?'display: none':''}">[选择]</font>
										</a>
									</td>
								</tr>
							</c:forEach>
						</table>
					</fieldset>
				</c:forEach>
			</div>
	</div>
</div>
</div>
</body>
</html>