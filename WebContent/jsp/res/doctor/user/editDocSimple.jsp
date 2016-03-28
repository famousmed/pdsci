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
	td{text-align:left; padding-left:5px; }
	[type='text']{width:150px;height: 22px;}
	select{width: 153px;height: 27px;}
</style>

<script type="text/javascript">
	var isSch = {
			<c:forEach items="${recDocCategoryEnumList}" var="category">
				<c:set var="res_doctor_category_key" value="res_doctor_category_${category.id }"/>
				<c:if test="${sysCfgMap[res_doctor_category_key]==GlobalConstant.FLAG_Y }">
					<c:set var="isSchKey" value="res_doctor_category_${category.id}_sch"/>
					"${category.id}":"${sysCfgMap[isSchKey]}",
				</c:if>
			</c:forEach>
	};

	var condition = "._${doctor.doctorCategoryId}._${doctor.trainingSpeId}";
	function saveDoc(){
		if($("#resDoctor").validationEngine("validate")){
			var url = "<s:url value='/res/doc/user/saveDocSimple'/>";
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
	
	function changeDocCategory(){
		selRotation();
		var doctorCategoryId = $("#doctorCategoryId").val();
		changeUserInfo(doctorCategoryId);
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
	
	function changeUserInfo(doctorCategoryId){
		$("#workInfo").hide();
		$("#work").hide();
		$(".userNameSpan").html("学员");
		$(".schoolNameSpan").html("在读");
		$(".graduateSpan").hide();
		$(".educationSpan").show();
		$(".degreeSpan").hide();
		$(".deptSpan").hide();
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
			$(".deptSpan").hide();
			$(".${recDocCategoryEnumGraduate.id}").hide();
		} else if (doctorCategoryId=="${recDocCategoryEnumScholar.id}") {//进修生
			$(".schoolNameSpan").html("毕业");
			$(".graduateSpan").show();	//增加毕业证号和毕业时间
			$(".degreeSpan").show();	//增加学位
			$(".trainNameSpan").html("进修");
			$("#work").show();	//增加工作经历
			$(".deptSpan").hide();
			$(".${recDocCategoryEnumGraduate.id}").hide();
		} else if (doctorCategoryId=="${recDocCategoryEnumEightYear.id}") {//八年制
			$(".educationSpan").hide();	//隐藏学历
			$(".${recDocCategoryEnumGraduate.id}").hide();
		} else if (doctorCategoryId=="${recDocCategoryEnumIntern.id}") {//实习生
			$(".trainNameSpan").html("实习");
			$(".deptSpan").show();
			$(".${recDocCategoryEnumGraduate.id}").hide();
		}else if (doctorCategoryId=="${recDocCategoryEnumGraduate.id}") {//研究生
			$(".${recDocCategoryEnumGraduate.id}").show();
		}
		
		$("#rotationInfo").toggle("${GlobalConstant.FLAG_N}"!=isSch[doctorCategoryId]);
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
	
	$(document).ready(function(){
		changeUserInfo("${doctor.doctorCategoryId}");
		changeTerminat("${doctor.doctorStatusId}");
		loadEdu();
	 	loadWork();
	});

	function loadEdu(){
		jboxLoad("edu","<s:url value='/pub/resume/loadView?type=education&userFlow=${user.userFlow}&editFlag=${GlobalConstant.FLAG_N}&source=resDoc'/>");
	}

	function loadWork(){
		jboxLoad("work","<s:url value='/pub/resume/loadView?type=work&userFlow=${user.userFlow}&editFlag=${GlobalConstant.FLAG_N}&source=resDoc'/>");
	}
	
	function lock(userFlow){
		jboxConfirm("确认锁定该用户吗？锁定后该用户将不能登录系统！",function () {
			var url = "<s:url value='/sys/user/lock?userFlow='/>"+userFlow;
			jboxGet(url,null,function(){
				var url="javascript:activate('${user.userFlow}');";
				$("#userStatusSpan").html('${userStatusEnumLocked.name}&#12288;[<a href='+url+'>解锁</a>]');			
			});		
		});
	}
	
	function activate(userFlow){
		jboxConfirm("确认解锁该用户吗？",function () {
			var url = "<s:url value='/sys/user/activate?userFlow='/>"+userFlow;
			jboxGet(url,null,function(){
				var url="javascript:lock('${user.userFlow}');";
				$("#userStatusSpan").html('${userStatusEnumActivated.name}&#12288;[<a href='+url+'>锁定</a>]');			
			});
		});
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
	
	function doClose(){
		jboxClose();
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
	<div class="title1 clearfix" style="padding:0; ">
		<form id="resDoctor" style="position: relative;">
		<input type="hidden" name="doctorFlow" value="${doctor.doctorFlow}"/>
		<input type="hidden" name="userFlow" value="${user.userFlow}"/>
		<input type="hidden" name="roleFlag" value="${param.roleFlag}"/>
		
		<table style="width:100%;">
			<caption>个人信息</caption>
			<colgroup>
			<col width="14%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="20%"/>
			</colgroup>
			<tr>
				<th>人员类型：</th>
				<td>
					<c:if test="${!rotationInUse}">
						<select name="doctorCategoryId" class="validate[required]" id="doctorCategoryId" onchange="changeDocCategory();">
							<option></option>
							<c:forEach items="${recDocCategoryEnumList}" var="category">
								<c:set var="res_doctor_category_key" value="res_doctor_category_${category.id }"/>
								<c:if test="${sysCfgMap[res_doctor_category_key]==GlobalConstant.FLAG_Y }">
								<option value="${category.id}" ${doctor.doctorCategoryId eq category.id?'selected':''}>${category.name}</option>
								</c:if>
							</c:forEach>
						</select>
						<font color="red">*</font>
					</c:if>
					<c:if test="${rotationInUse}">
						<label>${doctor.doctorCategoryName}</label>
					</c:if>
				</td>
				<th>工号/学号：</th>
				<td>
					<input type="text" name="doctorCode" value="${doctor.doctorCode}" />
				</td>
				<th>用户名：</th>
				<td>
					<c:if test="${empty user}">
						<input type="text" name="userCode" value="${user.userCode}" class="<c:if test="${!(sysCfgMap['sys_user_check_user_code'] eq GlobalConstant.FLAG_N)}">validate[required,custom[userCode]]</c:if>"/>
						<font color="red">*</font>
					</c:if>
					<c:if test="${!empty user}">
						${user.userCode}
						<input type="hidden" name="userCode" value="${user.userCode}"/>
					</c:if>
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
					<input type="text" name="idNo" value="${user.idNo}" class="validate[custom[chinaIdLoose]]" onblur="cutBirthday(this.value);"/>
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
					<input type="text" name="userPhone" value="${user.userPhone}" class="validate[custom[mobile]]"/>
				</td>
				<th >Email：</th>
				<td colspan="3">
					<input type="text" name="userEmail" value="${user.userEmail}" class="validate[custom[email]]"/>
				</td>
			</tr>
			<tr>
				<th>入院时间：</th>
				<td>
					<input type="text" name="inHosDate" value="${user.userBirthday}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" readonly="readonly"/>
				</td>
				<th>人员分类：</th>
				<td colspan="3">
					<select name="doctorTypeId">
						<option value=""></option>
						<c:forEach items="${dictTypeEnumDoctorTypeList}" var="dict">
							<option value="${dict.dictId}" <c:if test="${doctor.doctorTypeId eq dict.dictId}">selected="selected"</c:if>>${dict.dictName }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		
		<table id="rotationInfo" style="width:100%;">
			<caption>培训信息</caption>
			<colgroup>
			<col width="14%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="20%"/>
			</colgroup>
			<tr>
				<th>届数：</th>
				<td>
					<select name="sessionNumber" class="validate[required]" id="sessionNumber" onchange="selRotation();">
						<option></option>
						<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
							<option value="${dict.dictName}" ${doctor.sessionNumber eq dict.dictName?'selected="selected"':''}>${dict.dictName}</option>
						</c:forEach>
					</select>
					<font color="red">*</font>
				</td>
				<th><span class="trainNameSpan trainExtralSpan">培养</span>年限：</th>
				<td>
					<select name="trainingYears" class="validate[required]">
						<option></option>
						<c:forEach items="${dictTypeEnumTrainingYearsList}" var="dict">
							<option value="${dict.dictName}" ${doctor.trainingYears eq dict.dictName?'selected':''}>${dict.dictName}</option>
						</c:forEach>
					</select>
					<font color="red">*</font>
				</td>
				<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag}">
				<th><span class="deptSpan">所属部门：</span></th>
				<td>
					<span class="deptSpan">
					<select name="deptFlow" class="validate[required]">
						<option></option>
						<c:forEach items="${deptList}" var="dept">
							<option value="${dept.deptFlow}" ${user.deptFlow eq dept.deptFlow?'selected':''}>${dept.deptName}</option>
						</c:forEach>
					</select>
					<font color="red">*</font>
					</span>
				</td>
				</c:if>
			</tr>
			<tr>
				<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag}">
					<th><span class="trainNameSpan">培训</span>基地：</th>
					<td>
						<select name="orgFlow" class="validate[required]" >
							<option>
							<c:forEach items="${orgList}" var="org">
								<option value="${org.orgFlow}" ${org.orgFlow eq doctor.orgFlow?'selected':''}>${org.orgName}</option>
							</c:forEach>
						</select>
						<font color="red">*</font>
					</td>
				</c:if>
				<th><span class="trainNameSpan">培训</span>专业：</th>
				<td>
					<c:if test="${!rotationInUse}">
						<select name="trainingSpeId" class="validate[required]" id="trainingSpeId" onchange="selRotation();">
							<option></option>
							<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
								<option value="${dict.dictId}" ${doctor.trainingSpeId eq dict.dictId?'selected="selected"':''}>${dict.dictName}</option>
							</c:forEach>
						</select>
						<font color="red">*</font>
					</c:if>
					<c:if test="${rotationInUse}">
						<label>${doctor.trainingSpeName}</label>
					</c:if>
				</td>
				<th><label class="rotationAttr">轮转方案：</label></th>
				<td colspan="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag?'1':'3'}">
					<c:if test="${!rotationInUse}">
						<select name="rotationFlow" class=" rotationAttr" id="rotationFlow" onclick="checkCondition();">
							<option></option>
							<c:forEach items="${rotationList}" var="rotation">
									<option class="_${rotation.doctorCategoryId} _${rotation.speId} _rotation" value="${rotation.rotationFlow}" ${(doctor.rotationFlow eq rotation.rotationFlow)?'selected':''}>${rotation.rotationName}</option>
							</c:forEach>
						</select>
						<font class="rotationAttr" color="red"></font>
					</c:if>
					<c:if test="${rotationInUse}">
						<label>${doctor.rotationName}</label>
					</c:if>
				</td>
			</tr>
			<tr>
				<th><span class="userNameSpan">医师</span>状态：</th>
				<td>
					<select name="doctorStatusId" class="validate[required]" onchange="changeTerminat(this.value);">
						<option></option>
						<c:forEach items="${resDoctorStatusEnumList}" var="status">
							<option value="${status.id}" ${doctor.doctorStatusId eq status.id?'selected':''}>${status.name}</option>
						</c:forEach>
					</select>
					<font color="red">*</font>
				</td>
				<th class="${recDocCategoryEnumGraduate.id}">导师姓名：</th>
				<td class="${recDocCategoryEnumGraduate.id}">
					<select name="tutorFlow" onchange="$('#tutorName').val($(':selected',this).text());">
						<option/>
						<c:forEach items="${tutorList}" var="tutor">
							<option value="${tutor.userFlow}" <c:if test="${tutor.userFlow eq doctor.tutorFlow}">slected</c:if>>${tutor.userName}</option>
						</c:forEach>
					</select>
					<input type="hidden" id="tutorName" name="tutorName" value="${doctor.tutorName}"/>
				</td>
				<th class="${recDocCategoryEnumGraduate.id}">研究方向：</th>
				<td class="${recDocCategoryEnumGraduate.id}">
					<input type="text" name="researchDirection" value="${doctor.researchDirection}"/>
				</td>
				<th class="${resDoctorStatusEnumTerminat.id}">终止原因：</th>
				<td class="${resDoctorStatusEnumTerminat.id}">
					<input type="text" name="terminatReason" value="${doctor.terminatReason}"/>
				</td>
				<th class="${resDoctorStatusEnumTerminat.id}">终止时间：</th>
				<td class="${resDoctorStatusEnumTerminat.id}">
					<input type="text" name="terminatDate" value="${doctor.terminatDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" readonly="readonly"/>
				</td>
				<th class="${resDoctorStatusEnumGraduation.id}">结业证书号：</th>
				<td class="${resDoctorStatusEnumGraduation.id}">
					<input type="text" name="completeNo" value="${doctor.completeNo}"/>
				</td>
				<th class="${resDoctorStatusEnumGraduation.id}">结业时间：</th>
				<td class="${resDoctorStatusEnumGraduation.id}">
					<input type="text" name="completeDate" value="${doctor.completeDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" readonly="readonly"/>
				</td>
			</tr>
			<c:if test="${!empty user.userFlow}">
			<tr>
				<th>账号状态：</th>
				<td colspan="5">
					<span id="userStatusSpan">
						${user.statusDesc }&#12288;
						<c:if test="${user.statusId==userStatusEnumActivated.id}">
							[<a href="javascript:lock('${user.userFlow}');" >锁定</a>]
						</c:if> 
						<c:if test="${user.statusId==userStatusEnumLocked.id}">
							[<a href="javascript:activate('${user.userFlow}');" >解锁</a>]
						</c:if>
					</span>
				</td>
			</tr>
			</c:if>
		</table>
		<%-- 
		<table style="width:100%;">
			<caption>教育背景</caption>
			<colgroup>
			<col width="14%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="20%"/>
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
				<td >
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
				<th>外语能力：</th>
				<td colspan="3">
					<input type="text" name="foreignSkills" value="${doctor.foreignSkills}"/>
				</td>
			</tr>
		</table>
		
		<div id="workInfo" style="display: ;">
		<table style="width:100%;">
			<caption>工作信息</caption>
			<colgroup>
			<col width="14%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="20%"/>
			</colgroup>
			<tr>
				<th>工作单位：</th>
				<td><input type="text" name="workOrgName" value="${doctor.workOrgName}"/></td>
				<th>入院时间：</th>
				<td>
					<input type="text" name="inHosDate" value="${doctor.inHosDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" readonly="readonly"/>
				</td>
				<!-- 
				<th>科室：</th>
				<td>
					<select name="deptFlow">
						<option></option>
						<c:forEach items="${deptList}" var="dept">
							<option value="${dept.deptFlow}" ${user.deptFlow eq dept.deptFlow?'selected="selected"':''}>${dept.deptName}</option>
						</c:forEach>
					</select>
				</td>
				 -->
				 <th></th>
				 <td></td>
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
		
		<table style="width:100%;">
			<caption>证书情况</caption>
			<colgroup>
			<col width="14%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="20%"/>
			<col width="12%"/>
			<col width="20%"/>
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
				<td><input type="text" name="regAddress" value="${doctor.regAddress}"/></td>
			</tr>
		</table>
		
		<!-- 教育经历 -->
		<div id="edu" style="padding-top: 10px;"></div>
		
		<!-- 工作经历 -->
		<div id="work" style="padding-top: 10px;"></div>
		--%>
		</form>
		<p style="text-align: center;">
       		<input type="button" onclick="saveDoc();"  class="search" value="保&#12288;存"/>
       		<c:if test="${!param.isMenu}">
       			<input type="button" onclick="doClose();" class="search" value="关&#12288;闭"/>
       		</c:if>
       </p>
		</div>
	</div>
</div>
</body>
</html>