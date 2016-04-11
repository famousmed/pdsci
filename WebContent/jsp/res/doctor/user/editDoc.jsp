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
					<input type="text" name="doctorCode" value="${doctor.doctorCode}"/>
				</td>
				<th>用户名：</th>
				<td>
					<input type="text" name="userCode" value="${user.userCode}" class="<c:if test="${!(sysCfgMap['sys_user_check_user_code'] eq GlobalConstant.FLAG_N)}">validate[required,custom[userCode]]</c:if>"/>
					<font color="red">*</font>
				</td>
			</tr>
			<tr>
				<th>真实姓名：</th>
				<td>
					<input type="text" name="userName" value="${user.userName}" class="validate[required,custom[chinese]]"/>
					<font color="red">*</font>
				</td>
				<th>证件号码：</th>
				<td>
					<input type="text" name="idNo" value="${user.idNo}" class="validate[required,custom[chinaIdLoose]]" onblur="cutBirthday(this.value);"/>
					<font color="red">*</font>
				</td>
				<th>出生日期：</th>
				<td>
					<input type="text" name="userBirthday" value="${user.userBirthday}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<th>性别：</th>
				<td>
					<select name="sexId" class="validate[required]">
						<option></option>
						<option value="${userSexEnumMan.id}" ${user.sexId eq userSexEnumMan.id?'selected':''}>${userSexEnumMan.name}</option>
						<option value="${userSexEnumWoman.id}" ${user.sexId eq userSexEnumWoman.id?'selected':''}>${userSexEnumWoman.name}</option>
					</select>
					<font color="red">*</font>
				</td>
				<th>手机：</th>
				<td>
					<input type="text" name="userPhone" value="${user.userPhone}" class="validate[required,custom[mobile]]"/>
					<font color="red">*</font>
				</td>
				<th >Email：</th>
				<td colspan="3">
					<input type="text" name="userEmail" value="${user.userEmail}" class="validate[required,custom[email]]"/>
					<font color="red">*</font>
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
					<%-- <select name="sessionNumber" class="validate[required]" id="sessionNumber" onchange="selRotation();">
						<option></option>
						<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
							<option value="${dict.dictName}" ${doctor.sessionNumber eq dict.dictName?'selected="selected"':''}>${dict.dictName}</option>
						</c:forEach>
					</select>
					<font color="red">*</font> --%>
				</td>
				<th><span class="trainNameSpan trainExtralSpan">培养</span>年限：</th>
				<td colspan="3">${doctor.trainingYears }
					<%-- <select name="trainingYears" class="validate[required]">
						<option></option>
						<c:forEach items="${dictTypeEnumTrainingYearsList}" var="dict">
							<option value="${dict.dictName}" ${doctor.trainingYears eq dict.dictName?'selected':''}>${dict.dictName}</option>
						</c:forEach>
					</select>
					<font color="red">*</font> --%>
				</td>
			</tr>
			<tr>
				<th><span class="trainNameSpan">培训</span>基地：</th>
				<td>${doctor.orgName}</td>
				<th><span class="trainNameSpan">培训</span>专业：</th>
				<td>${doctor.trainingSpeName}
					<%-- <select name="trainingSpeId" class="validate[required]" id="trainingSpeId" onchange="selRotation();">
						<option></option>
						<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
							<option value="${dict.dictId}" ${doctor.trainingSpeId eq dict.dictId?'selected="selected"':''}>${dict.dictName}</option>
						</c:forEach>
					</select>
					<font color="red">*</font> --%>
				</td>
				<th>轮转方案：</th>
				<td colspan="3">${doctor.rotationName }
					<%-- <select name="rotationFlow" class="validate[required]" id="rotationFlow" onclick="checkCondition();">
						<option></option>
						<c:forEach items="${rotationList}" var="rotation">
								<option class="_${rotation.sessionNumber} _${rotation.doctorCategoryId} _${rotation.speId} _rotation" value="${rotation.rotationFlow}" ${doctor.rotationFlow eq rotation.rotationFlow?'selected':''}>${rotation.rotationName}</option>
						</c:forEach>
					</select>
					<font color="red">*</font> --%>
				</td>
			</tr>
			<tr>
				<th><span class="userNameSpan">医师</span>状态：</th>
				<td>${doctor.doctorStatusName }
					<%-- <select name="doctorStatusId" class="validate[required]">
						<option></option>
						<c:forEach items="${resDoctorStatusEnumList}" var="status">
							<option value="${status.id}" ${doctor.doctorStatusId eq status.id?'selected':''}>${status.name}</option>
						</c:forEach>
					</select>
					<font color="red">*</font> --%>
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
					<%-- <input type="text" name="completeDate" value="${doctor.completeDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" readonly="readonly"/> --%>
				</td>
				<th class="${resDoctorStatusEnumGraduation.id}">结业证书编号：</th>
				<td class="${resDoctorStatusEnumGraduation.id}">${doctor.completeNo}<%-- <input type="text" name="completeNo" value="${doctor.completeNo}"/> --%></td>
			</tr>
		</table>
		
		<table style="width:100%;">
			<caption>
				<label onclick="infoOper('educationInfo',this);" style="cursor: pointer;float: right;margin-right: 40px;">
					<img title="收缩" src="<s:url value='/jsp/hbres/images/up.png'/>" style="display: none;margin-top: 20px;"/>
					<img title="展开" src="<s:url value='/jsp/hbres/images/down.png'/>" style="margin-top: 20px;"/>
				</label>
				教育信息
			</caption>
		</table>
		<div id="educationInfo" style="display: none;">
		<table style="width:100%;">
			<colgroup>
			<col width="12%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="24%"/>
			</colgroup>
			<tr>
				<th><span class="schoolNameSpan">毕业</span>院校：</th>
				<td>
					<select name="graduatedId">
						<option></option>
						<c:forEach items="${dictTypeEnumGraduateSchoolList}" var="dict">
							<option value="${dict.dictId}" ${doctor.graduatedId eq dict.dictId?'selected':''}>${dict.dictName}</option>
						</c:forEach>
					</select>
				</td>
				<th><span class="educationSpan">学历：</span></th>
				<td>
				<span class="educationSpan">
					<select name="educationId">
						<option></option>
						<c:forEach items="${dictTypeEnumUserEducationList}" var="dict">
							<option value="${dict.dictId}" ${user.educationId eq dict.dictId?'selected':''}>${dict.dictName}</option>
						</c:forEach>
					</select>
				</span>
				</td>
				<th><span class="degreeSpan">学位：</span></th>
				<td>
				<span class="degreeSpan">
					<select name="degreeId">
						<option></option>
						<c:forEach items="${dictTypeEnumUserDegreeList}" var="dict">
							<option value="${dict.dictId}" ${user.degreeId eq dict.dictId?'selected':''}>${dict.dictName}</option>
						</c:forEach>
					</select>
				</span>
				</td>
			</tr>
			<tr>
				<th>所学专业：</th>
				<td>
					<input type="text" name="specialized" value="${doctor.specialized}"/>
				</td>
				<th><span class="graduateSpan">毕业证书号：</span></th>
				<td>
					<span class="graduateSpan"><input type="text" name="certificateNo" value="${doctor.certificateNo}"/></span>
				</td>
				<th><span class="graduateSpan">毕业时间：</span></th>
				<td>
					<span class="graduateSpan"><input type="text" name="graduationTime" value="${doctor.graduationTime}" 
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" readonly="readonly"/></span>
				</td>
			</tr>
			<tr>
				<th>计算机能力：</th>
				<td>
					<input type="text" name="computerSkills" value="${doctor.computerSkills}"/>
				</td>
				<th style="width: 12%;">外语能力：</th>
				<td colspan="3">
					<input type="text" name="foreignSkills" value="${doctor.foreignSkills}"/>
				</td>
			</tr>
		</table>
		</div>
		
		<div id="workInfo" style="display: ;">
		<table style="width:100%;">
			<caption>
				<label onclick="infoOper('workInfoDiv',this);" style="cursor: pointer;float: right;margin-right: 40px;">
					<img title="收缩" src="<s:url value='/jsp/hbres/images/up.png'/>" style="display: none;margin-top: 20px;"/>
					<img title="展开" src="<s:url value='/jsp/hbres/images/down.png'/>" style="margin-top: 20px;"/>
				</label>
				工作信息
			</caption>
		</table>
		<div id="workInfoDiv" style="display: none;">
		<table style="width:100%;" style="display: none;">
			<colgroup>
			<col width="12%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="24%"/>
			</colgroup>
			<tr>
				<th>工作单位：</th>
				<td><input type="text" name="workOrgName" value="${doctor.workOrgName}"/></td>
				<th>入院时间：</th>
				<td>
					<input type="text" name="inHosDate" value="${doctor.inHosDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" readonly="readonly"/>
				</td>
				<th>科室：</th>
				<td>
					<select name="deptFlow">
						<option></option>
						<c:forEach items="${deptList}" var="dept">
							<option value="${dept.deptFlow}" ${user.deptFlow eq dept.deptFlow?'selected="selected"':''}>${dept.deptName}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>职称：</th>
				<td>
					<select name="titleId">
						<option></option>
						<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
       						<option value="${title.dictId}" ${user.titleId eq title.dictId?'selected="selected"':''}>${title.dictName}</option>
       					</c:forEach>
					</select>
				</td>
				<th>职务：</th>
				<td colspan="3">
					<select name="postId">
						<option></option>
						<c:forEach items="${dictTypeEnumUserPostList}" var="post">
     						<option value="${post.dictId}" ${user.postId eq post.dictId?'selected="selected"':''}>${post.dictName}</option>
       					</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		</div>
		</div>
		
		<table style="width:100%;">
			<caption>
				<label onclick="infoOper('certificateInfo',this);" style="cursor: pointer;float: right;margin-right: 40px;">
					<img title="收缩" src="<s:url value='/jsp/hbres/images/up.png'/>" style="display: none;margin-top: 20px;"/>
					<img title="展开" src="<s:url value='/jsp/hbres/images/down.png'/>" style="margin-top: 20px;"/>
				</label>
				证书情况
			</caption>
		</table>
		<div id="certificateInfo" style="display: none;">
		<table style="width:100%;">
			<colgroup>
			<col width="12%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="24%"/>
			</colgroup>
			<tr>
				<th>执业医师资格证号：</th>
				<td><input type="text" name="qualifiedNo" value="${doctor.qualifiedNo}"/></td>
				<th>获取时间：</th>
				<td colspan="3"><input type="text" name="qualifiedDate" value="${doctor.qualifiedDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" readonly="readonly"/></td>
			</tr>
			<tr>
				<th>执业医师注册证号：</th>
				<td><input type="text" name="regNo" value="${doctor.regNo}"/></td>
				<th>获取时间：</th>
				<td><input type="text" name="regDate" value="${doctor.regDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" readonly="readonly"/></td>
				<th>执业地点：</th>
				<td colspan="5"><input type="text" name="regAddress" value="${doctor.regAddress}"/></td>
			</tr>
		</table>
		</div>
		
		<!-- 教育经历 -->
		<!-- <div id="edu" style="padding-top: 10px;"></div> -->
		
		<!-- 工作经历 -->
		<!-- <div id="work" style="padding-top: 10px;"></div> -->
		
		</form>
		<p style="text-align: center;">
       		<input type="button" onclick="saveDoc();"  class="search" value="保&#12288;存"/>
       		<c:if test="${!param.isMenu}">
       			<input type="button" onclick="jboxClose();" class="search" value="关&#12288;闭"/>
       		</c:if>
       </p>
		</div>
	</div>
</div>
</body>
</html>