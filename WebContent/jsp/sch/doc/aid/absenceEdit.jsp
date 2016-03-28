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
		var sessionNumber = $("[name='sessionNumber']").val();
		var trainingSpeId = $("[name='trainingSpeId']").val();
		var emptySessionNumber = sessionNumber == null || sessionNumber == '';
		var emptyTrainingSpeId = trainingSpeId == null || trainingSpeId == '';
		$(".name").hide();
		$(".name" + (emptySessionNumber?"":("._"+sessionNumber)) + (emptyTrainingSpeId?"":("._"+trainingSpeId))).show();
	}
	
	function saveAbsence(){
		if(!$("#schDoctorAbsence").validationEngine("validate")){
			return ;
		}
		var doctorData = $("[value='"+$("[name='doctorFlow']").val()+"']").attr("class").split(" ");
		$("[value='"+doctorData[1].substring(1)+"']").attr("selected",true);
		$("[value='"+doctorData[2].substring(1)+"']").attr("selected",true);
		var url = "<s:url value='/sch/doc/aid/saveAbsence'/>";
		var getdata = $('#schDoctorAbsence').serialize() + "&doctorName="+$("[value='"+$("[name='doctorFlow']").val()+"']").text();
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
			<form id="schDoctorAbsence">
			<div id="dept" style="width:100%; margin-top: 10px;margin-bottom: 10px;position: relative;" align="center">
				<input type="hidden" name="absenceFlow" value="${docAbsence.absenceFlow}"/>
				<table  class="basic" style="font-size: 14px;width: 100%">
					<tr>
						<th>届数：</th>
						<td>
							<select name="sessionNumber" class="xlselect" onchange="filterDoctor();">
								<option></option>
								<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
									<option value="${dict.dictName}" ${dict.dictName eq docAbsence.sessionNumber?'selected="selected"':''}>${dict.dictName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>培训专业：</th>
						<td>
							<select name="trainingSpeId" class="xlselect" onchange="filterDoctor();">
								<option></option>
								<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
									<option value="${dict.dictId}" ${dict.dictId eq docAbsence.trainingSpeId?'selected="selected"':''}>${dict.dictName}</option>
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
									<option class="name _${doctor.sessionNumber} _${doctor.trainingSpeId}" value="${doctor.doctorFlow}"  ${doctor.doctorFlow eq docAbsence.doctorFlow?'selected="selected"':''}>${doctor.doctorName}</option>
								</c:forEach>
							</select>
							<font color="red" >*</font>
						</td>
					</tr>
						<tr>
							<th>开始时间：</th>
							<td><input style="margin-right: 3px" name="startDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" type="text" value="${empty docAbsence?pdfn:getCurrDate():docAbsence.startDate}" class="xltext ctime validate[required]"/><font color="red" >*</font></td>
						</tr>
						<tr>
							<th>结束时间：</th>
							<td><input style="margin-right: 3px" name="endDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" type="text" value="${docAbsence.endDate}" class="xltext ctime validate[required]"/><font color="red" >*</font></td>
						</tr>
						<tr>
							<th>缺勤原因：</th>
							<td>
								<textarea placeholder="病假或其他原因"  name="absenceReson" style="margin-left: 0px" class="xltxtarea">${docAbsence.absenceReson}</textarea>
							</td>
						</tr>
					</table>
			</div>
			</form>
			<div align="center">
				<input type="button" class="search" onclick="saveAbsence();" value="保&#12288;存"/>
				&#12288;
				<input type="button" class="search" onclick="jboxClose();" value="关&#12288;闭"/>
			</div>
	</div>
</div>
</div>
</body>
</html>