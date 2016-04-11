<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	table{ margin:10px 0;border-collapse: collapse;}
	caption,th,td{height:40px;}
	caption{line-height:40px;text-align:left;font-weight:bold; padding-left:10px; border-bottom:1px solid #ddd;color:#f60;margin-bottom: 10px;}
	th{text-align:right;font-weight:500;padding-right:5px; color:#333;}
	td{text-align:left; padding-left:5px;}
	[type='text']{width:150px;height: 22px;}
	select{width: 153px;height: 27px;}
</style>

<script type="text/javascript">
	var condition = "._${doctor.doctorCategoryId}._${doctor.trainingSpeId}";
	function saveDoc(){
		if($("#resDoctor").validationEngine("validate")){
			var url = "<s:url value='/res/doc/user/saveDoc'/>";
			var getdata = $('#resDoctor').serialize();
			jboxPost(url, getdata, function(data) {
				if('${GlobalConstant.SAVE_SUCCESSED}'==data){
					window.parent.frames['mainIframe'].window.searchUser(); 
					jboxClose();
				}
			},null,true);
		}
	}
	
	$(function(){
		$(".xltext,.xlselect").css("margin-right","0px");
		$("._rotation").hide();
		selRotation();
	});
	
	function cutBirthday(idNo){	
		$("[name='userBirthday']").val(idNo.substr(6,4)+"-"+idNo.substr(10,2)+"-"+idNo.substr(12,2));
	}
	
	function selRotation(){
		$("#rotationFlow").val("");
		$("._rotation").hide();
// 		var sessionNumber = $("#sessionNumber").val();
		var doctorCategoryId = $("#doctorCategoryId").val();
		var trainingSpeId = $("#trainingSpeId").val();
		if(doctorCategoryId && trainingSpeId){
			var selector = "._"+doctorCategoryId+"._"+trainingSpeId;
			$(selector).show();
			if(condition==selector){
				$(selector+"[value='${doctor.rotationFlow}']").attr("selected","selected");
			}else{
				$(selector+":first").attr("selected","selected");
			}
		}
	}
	
	function checkCondition(){
		if(!$("#doctorCategoryId").val()){
			jboxTip("请选择人员类型!");
			return;
		}
// 		if(!$("#sessionNumber").val()){
// 			jboxTip("请选择届数!");
// 			return;
// 		}
		if(!$("#trainingSpeId").val()){
			jboxTip("请选择专业!");
			return;
		}
	}
	
	function infoOper(id,a){
		$("#"+id).slideToggle();
		$(a).find("img").toggle();
	}
	
	function changeUserInfo(doctorCategoryId){
		$("#workInfo").hide();
		$("#work").hide();
		$(".userNameSpan").html("学员");
		$(".schoolNameSpan").html("在读");
		$(".graduateSpan").hide();
		$(".educationSpan").show();
		$(".degreeSpan").hide();
		$(".trainNameSpan").html("培训");
		$(".trainExtralSpan").html("培养");
		if (doctorCategoryId=="${recDocCategoryEnumDoctor.id}" || 
				doctorCategoryId=="${recDocCategoryEnumInDoctor.id}" ||
				doctorCategoryId=="${recDocCategoryEnumOutDoctor.id}" ||
				doctorCategoryId=="${recDocCategoryEnumFieldTrain.id}" ||
				doctorCategoryId=="${recDocCategoryEnumUnderGrad.id}" ||
				doctorCategoryId=="${recDocCategoryEnumSpecialist.id}" ||
				doctorCategoryId=="${recDocCategoryEnumGeneralDoctor.id}") 
		{//住院医师、本院规培、外院规培、外地委培、本科生、专科医师、普通医生
			$(".userNameSpan").html("医师");	
			$(".schoolNameSpan").html("毕业");
			$(".graduateSpan").show();	//增加毕业证号和毕业时间
			$(".degreeSpan").show();	//增加学位
			$("#workInfo").show();	//增加工作单位和职务
			$("#work").show();	//增加工作经历
		} else if (doctorCategoryId=="${recDocCategoryEnumScholar.id}") {//进修生
			$(".schoolNameSpan").html("毕业");
			$(".graduateSpan").show();	//增加毕业证号和毕业时间
			$(".degreeSpan").show();	//增加学位
			$(".trainNameSpan").html("进修");
			$("#work").show();	//增加工作经历
		} else if (doctorCategoryId=="${recDocCategoryEnumEightYear.id}") {//八年制
			$(".educationSpan").hide();	//隐藏学历
		} else if (doctorCategoryId=="${recDocCategoryEnumIntern.id}") {//实习生
			$(".trainNameSpan").html("实习");
		}
	}
	

	$(document).ready(function(){
		changeUserInfo("${doctor.doctorCategoryId}");
		changeTerminat("${doctor.doctorStatusId}");
		loadEdu();
	 	loadWork();
	});
	
	function loadEdu(){
		jboxLoad("edu","<s:url value='/pub/resume/loadView?type=education&userFlow=${user.userFlow}&editFlag=${GlobalConstant.FLAG_Y}&source=resDoc'/>");
	}

	function loadWork(){
		jboxLoad("work","<s:url value='/pub/resume/loadView?type=work&userFlow=${user.userFlow}&editFlag=${GlobalConstant.FLAG_Y}&source=resDoc'/>");
	}
	
	//根据医师状态决定展示终止还是结业内容
	function changeTerminat(doctorStatusId){
		if ("${resDoctorStatusEnumTerminat.id}"==doctorStatusId) {
			$(".${resDoctorStatusEnumTerminat.id}").show();
			$(".${resDoctorStatusEnumGraduation.id}").hide();
		} else if ("${resDoctorStatusEnumGraduation.id}"==doctorStatusId) {
			$(".${resDoctorStatusEnumGraduation.id}").show();
			$(".${resDoctorStatusEnumTerminat.id}").hide();
		} else {
			$(".${resDoctorStatusEnumTerminat.id}").hide();
			$(".${resDoctorStatusEnumGraduation.id}").hide();
		}
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
		<form id="resDoctor" style="position: relative;">
		<input type="hidden" name="doctorFlow" value="${doctor.doctorFlow}"/>
		<input type="hidden" name="userFlow" value="${user.userFlow}"/>
		<table style="width:100%;">
			<caption>个人信息</caption>
			<colgroup>
			<col width="12%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="24%"/>
			</colgroup>
			<tr>
				<th>人员类型：</th>
				<td>
					${doctor.doctorCategoryName}
					<input type="hidden" id="doctorCategoryId" name="doctorCategoryId" value="${doctor.doctorCategoryId}">
				</td>
				<th>工号：</th>
				<td>
					${doctor.doctorCode}
				</td>
				<th>用户名：</th>
				<td>
					${user.userCode}
				</td>
			</tr>
			<tr>
				<th>真实姓名：</th>
				<td>
				${user.userName}
				</td>
				<th>证件号码：</th>
				<td>
					${user.idNo}
				</td>
				<th>出生日期：</th>
				<td>
					${user.userBirthday}
				</td>
			</tr>
			<tr>
				<th>性别：</th>
				<td>
				${user.sexName}
<!-- 					<select name="sexId" class="validate[required]"> -->
<!-- 						<option></option> -->
<%-- 						<option value="${userSexEnumMan.id}" ${user.sexId eq userSexEnumMan.id?'selected':''}>${userSexEnumMan.name}</option> --%>
<%-- 						<option value="${userSexEnumWoman.id}" ${user.sexId eq userSexEnumWoman.id?'selected':''}>${userSexEnumWoman.name}</option> --%>
<!-- 					</select> -->
<!-- 					<font color="red">*</font> -->
				</td>
				<th>手机：</th>
				<td>
					${user.userPhone}
				</td>
				<th >Email：</th>
				<td colspan="3">
					${user.userEmail}
				</td>
			</tr>
		</table>
		
		<table style="width:100%;">
			<caption>培训信息</caption>
			<colgroup>
			<col width="12%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="24%"/>
			</colgroup>
			<tr>
				<th>届数：</th>
				<td>${doctor.sessionNumber}
				</td>
				<th><span class="trainNameSpan trainExtralSpan">培养</span>年限：</th>
				<td colspan="3">${doctor.trainingYears }
				</td>
			</tr>
			<tr>
				<th><span class="trainNameSpan">培训</span>基地：</th>
				<td>${doctor.orgName}</td>
				<th><span class="trainNameSpan">培训</span>专业：</th>
				<td>${doctor.trainingSpeName}
				</td>
				<th>轮转方案：</th>
				<td colspan="3">${doctor.rotationName }
				</td>
			</tr>
			<tr>
				<th><span class="userNameSpan">医师</span>状态：</th>
				<td>${doctor.doctorStatusName }
				</td>
				<th class="${resDoctorStatusEnumTerminat.id}">终止原因：</th>
				<td class="${resDoctorStatusEnumTerminat.id}">
					${doctor.terminatReason}
				</td>
				<th class="${resDoctorStatusEnumTerminat.id}">终止时间：</th>
				<td class="${resDoctorStatusEnumTerminat.id}">
					${doctor.terminatDate}
				</td>
				<th class="${resDoctorStatusEnumGraduation.id}">结业时间：</th>
				<td class="${resDoctorStatusEnumGraduation.id}">${doctor.completeDate }
				</td>
				<th class="${resDoctorStatusEnumGraduation.id}">结业证书编号：</th>
				<td class="${resDoctorStatusEnumGraduation.id}">${doctor.completeNo}</td>
			</tr>
		</table>
		
<!-- 		<table style="width:100%;"> -->
<!-- 			<caption> -->
<!-- 				教育信息 -->
<!-- 			</caption> -->
<!-- 		</table> -->
<!-- 		<div id="educationInfo"> -->
<!-- 		<table style="width:100%;"> -->
<!-- 			<colgroup> -->
<!-- 			<col width="12%"/> -->
<!-- 			<col width="20%"/> -->
<!-- 			<col width="12%"/> -->
<!-- 			<col width="20%"/> -->
<!-- 			<col width="12%"/> -->
<!-- 			<col width="24%"/> -->
<!-- 			</colgroup> -->
<!-- 			<tr> -->
<!-- 				<th><span class="schoolNameSpan">毕业</span>院校：</th> -->
<!-- 				<td> -->
<%-- 					${doctor.graduatedName } --%>
<!-- 				</td> -->
<!-- 				<th><span class="educationSpan">学历：</span></th> -->
<!-- 				<td> -->
<%-- 					${user.educationName } --%>
<!-- 				</td> -->
<!-- 				<th><span class="degreeSpan">学位：</span></th> -->
<!-- 				<td> -->
<%-- 					${user.degreeName } --%>
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<th>所学专业：</th> -->
<!-- 				<td> -->
<%-- 					${doctor.specialized} --%>
<!-- 				</td> -->
<!-- 				<th><span class="graduateSpan">毕业证书号：</span></th> -->
<!-- 				<td> -->
<%-- 					${doctor.certificateNo} --%>
<!-- 				</td> -->
<!-- 				<th><span class="graduateSpan">毕业时间：</span></th> -->
<!-- 				<td> -->
<%-- 					${doctor.graduationTime} --%>
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<th>计算机能力：</th> -->
<!-- 				<td> -->
<%-- 					${doctor.computerSkills} --%>
<!-- 				</td> -->
<!-- 				<th style="width: 12%;">外语能力：</th> -->
<!-- 				<td colspan="3"> -->
<%-- 					${doctor.foreignSkills} --%>
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 		</table> -->
<!-- 		</div> -->
		
<!-- 		<div id="workInfo" style="display: ;"> -->
<!-- 		<table style="width:100%;"> -->
<!-- 			<caption> -->
<!-- 				工作信息 -->
<!-- 			</caption> -->
<!-- 		</table> -->
<!-- 		<div id="workInfoDiv"> -->
<!-- 		<table style="width:100%;"> -->
<!-- 			<colgroup> -->
<!-- 			<col width="12%"/> -->
<!-- 			<col width="20%"/> -->
<!-- 			<col width="12%"/> -->
<!-- 			<col width="20%"/> -->
<!-- 			<col width="12%"/> -->
<!-- 			<col width="24%"/> -->
<!-- 			</colgroup> -->
<!-- 			<tr> -->
<!-- 				<th>工作单位：</th> -->
<%-- 				<td>${doctor.workOrgName}</td> --%>
<!-- 				<th>入院时间：</th> -->
<!-- 				<td> -->
<%-- 					${doctor.inHosDate} --%>
<!-- 				</td> -->
<!-- 				<th>科室：</th> -->
<!-- 				<td> -->
<%-- 					${user.deptName } --%>
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<th>职称：</th> -->
<!-- 				<td> -->
<%-- 					${user.titleName } --%>
<!-- 				</td> -->
<!-- 				<th>职务：</th> -->
<!-- 				<td colspan="3"> -->
<%-- 					${user.postName } --%>
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 		</table> -->
<!-- 		</div> -->
<!-- 		</div> -->
		
<!-- 		<table style="width:100%;"> -->
<!-- 			<caption> -->
<!-- 				证书情况 -->
<!-- 			</caption> -->
<!-- 		</table> -->
<!-- 		<div id="certificateInfo"> -->
<!-- 		<table style="width:100%;"> -->
<!-- 			<colgroup> -->
<!-- 			<col width="12%"/> -->
<!-- 			<col width="20%"/> -->
<!-- 			<col width="12%"/> -->
<!-- 			<col width="20%"/> -->
<!-- 			<col width="12%"/> -->
<!-- 			<col width="24%"/> -->
<!-- 			</colgroup> -->
<!-- 			<tr> -->
<!-- 				<th>执业医师资格证号：</th> -->
<%-- 				<td>${doctor.qualifiedNo}</td> --%>
<!-- 				<th>获取时间：</th> -->
<%-- 				<td colspan="3">${doctor.qualifiedDate}</td> --%>
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<th>执业医师注册证号：</th> -->
<%-- 				<td>${doctor.regNo}</td> --%>
<!-- 				<th>获取时间：</th> -->
<%-- 				<td>${doctor.regDate}</td> --%>
<!-- 				<th>执业地点：</th> -->
<%-- 				<td colspan="5">${doctor.regAddress}</td> --%>
<!-- 			</tr> -->
<!-- 		</table> -->
<!-- 		</div> -->
		
		</form>
		<p style="text-align: center;">
       		<input type="button" onclick="jboxClose();" class="search" value="关&#12288;闭"/>
       </p>
		</div>
	</div>
</div>
</body>
</html>