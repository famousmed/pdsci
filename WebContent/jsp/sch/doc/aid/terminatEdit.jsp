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
</jsp:include>
<script type="text/javascript">
	function filterDoctor(){
		$("[name='doctorFlow']").val("");
		var sessionNumber = $("#sessionNumber").val();
		var trainingSpeId = $("#trainingSpeId").val();
		var emptySessionNumber = sessionNumber == null || sessionNumber == '';
		var emptyTrainingSpeId = trainingSpeId == null || trainingSpeId == '';
		$(".name").hide();
		$(".name" + (emptySessionNumber?"":("._"+sessionNumber)) + (emptyTrainingSpeId?"":("._"+trainingSpeId))).show();
	}
	
	function saveTerminat(){
		if(!$("#schDoctor").validationEngine("validate")){
			return ;
		}
		var url = "<s:url value='/sch/doc/aid/saveTerminat'/>";
		var getdata = $('#schDoctor').serialize();
		jboxPost(url, getdata, function(data) {
			if('${GlobalConstant.SAVE_SUCCESSED}'==data){
				window.parent.frames['mainIframe'].window.search(); 
				jboxClose();		
			}
		});
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="schDoctor">
			<div id="dept" style="width:100%; margin-top: 10px;margin-bottom: 10px;position: relative;" align="center">
				<table class="basic" style="font-size: 14px;width: 100%">
						<tr>
							<th>届数：</th>
							<td>
								<select id="sessionNumber" class="xlselect" onchange="filterDoctor();">
									<option></option>
									<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
										<option value="${dict.dictName}">${dict.dictName}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>培训专业：</th>
							<td>
								<select id="trainingSpeId" class="xlselect" onchange="filterDoctor();">
									<option></option>
									<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
										<option value="${dict.dictId}">${dict.dictName}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>姓名：</th>
							<td>
								<select name="doctorFlow" style="margin-right: 0px" class="xlselect validate[required]">
									<option></option>
									<c:forEach items="${doctorList}" var="doctor">
										<option class="name _${doctor.sessionNumber} _${doctor.trainingSpeId}" value="${doctor.doctorFlow}">${doctor.doctorName}</option>
									</c:forEach>
								</select>
								<font color="red" >*</font>
							</td>
						</tr>
						<tr>
							<th>终止时间：</th>
							<td><input name="terminatDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" type="text" value="${pdfn:getCurrDate()}" class="xltext ctime"/></td>
						</tr>
						<tr>
							<th>终止原因：</th>
							<td>
								<textarea name="terminatReason" class="xltxtarea" style="margin-left: 0px"></textarea>
							</td>
						</tr>
					</table>
			</div>
			</form>
			<div align="center">
				<input type="button" class="search" onclick="saveTerminat();" value="保&#12288;存"/>
				&#12288;
				<input type="button" class="search" onclick="jboxClose();" value="关&#12288;闭"/>
			</div>
	</div>
</div>
</div>
</body>
</html>