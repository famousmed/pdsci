<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
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
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<style type="text/css">
	[type='text']{width:150px;height: 22px;}
	select{width: 153px;height: 27px;}
	#boxHome .item:HOVER{background-color: #eee;}
</style>

<script type="text/javascript">
	/**
	*模糊查询加载
	*/
// 	(function($){
// 		$.fn.likeSearchInit = function(option){
// 			option.clickActive = option.clickActive || null;
			
// 			var searchInput = this;
// 			searchInput.on("keyup focus",function(){
// 				$("#boxHome").show();
// 				if($.trim(this.value)){
// 					$("#boxHome .item").hide();
// 					var items = $("#boxHome .item[value*='"+this.value+"']").show();
// 					if(!items){
// 						$("#boxHome").hide();
// 					}
// 				}else{
// 					$("#boxHome .item").show();
// 				}
// 			});
// 			searchInput.on("blur",function(){
// 				if(!$("#boxHome.on").length){
// 					$("#boxHome").hide();
// 				}
// 			});
// 			$("#boxHome").on("mouseenter mouseleave",function(){
// 				$(this).toggleClass("on");
// 			});
// 			$("#boxHome .item").click(function(){
// 				$("#boxHome").hide();
// 				var value = $(this).attr("value");
// 				$("#itemName").val(value);
// 				searchInput.val(value);
// 				if(option.clickActive){
// 					option['clickActive']($(this).attr("flow"));
// 				}
// 			});
// 		};
// 	})(jQuery);
	//======================================
	
	$(document).ready(function(){
		calculateDay();
		changeOthers($("#schDeptFlow").val());
	});
	
	function filterDoctor(){
		$("#doctorFlow").val("");
		var sessionNumber = $("[name='sessionNumber']").val();
		var trainingSpeId = $("[name='trainingSpeId']").val();
		var emptySessionNumber = sessionNumber == null || sessionNumber == '';
		var emptyTrainingSpeId = trainingSpeId == null || trainingSpeId == '';
		$(".name").hide();
		$(".name" + (emptySessionNumber?"":("._"+sessionNumber)) + (emptyTrainingSpeId?"":("._"+trainingSpeId))).show();
	}
	
	function chooseDoctor(){
		$("[name='doctorFlow']").val($("#doctorFlow").val());
		$("[name='doctorName']").val($("#doctorFlow option:selected").attr("doctorName"));
		$("#schDeptFlow option:selected").attr("selected",false);
		$(".schDept").hide();
		$(".schDept_"+$("#doctorFlow").val()).show();
	}
	
	function changeOthers(){
		$("#teacherTd").html($("#schDeptFlow option:selected").attr("teacherName"));
		$("#headTd").html($("#schDeptFlow option:selected").attr("headName"));
		$("[name='schDeptFlow']").val($("#schDeptFlow").val());
		$("[name='schDeptName']").val($("#schDeptFlow option:selected").text());
		$("[name='teacherFlow']").val($("#schDeptFlow option:selected").attr("teacherFlow"));
		$("[name='teacherName']").val($("#schDeptFlow option:selected").attr("teacherName"));
		$("[name='headFlow']").val($("#schDeptFlow  option:selected").attr("headFlow"));
		$("[name='headName']").val($("#schDeptFlow  option:selected").attr("headName"));
	}

	function save(){
		if(false == $("#editForm").validationEngine("validate")){
			return false;
		}
		var startDate = $("input[name='startDate']").val();
		var endDate = $("input[name='endDate']").val();
		if(endDate < startDate){
			jboxTip("结束日期不能早于开始日期！");
			return false;
		}
		var intervalDay = $("input[name='intervalDay']").val();
		if("${GlobalConstant.FLAG_Y}" != "${isRegister}" && "${sysCfgMap['res_absence_max_day']}" !="" && intervalDay>parseInt("${sysCfgMap['res_absence_max_day']}")){
			return jboxTip("请假不能超过${sysCfgMap['res_absence_max_day']}天！");
		}
		var title ="本次请假由<span style='color: blue;'>"+startDate+"</span>至<span style='color: blue;'>"+endDate+"</span>共计<span style='color: red;'>"+intervalDay+"</span>天！确认请假？";
		jboxConfirm(title,function(){
			jboxStartLoading();
			var url = "<s:url value='/res/doc/saveDoctorAbsence'/>";
			jboxSubmit($('#editForm'), url, function(resp){
					if("${GlobalConstant.SAVE_SUCCESSED}" == resp){
						window.parent.frames['mainIframe'].location.reload(true);
						setTimeout(function(){
							jboxClose();
						},1000);
					}				
				},function(resp){
					alert("error");
				});	
		});
	}
	
	function calculateDay(){
		var startDate = $("input[name='startDate']").val();
		var endDate = $("input[name='endDate']").val();
		if("" == startDate || "" == endDate){
			return;
		}
		if(endDate < startDate){
			jboxTip("结束日期不能早于开始日期！");
			return;
		}
		var url = "<s:url value='/res/doc/calculateAbsenceDay'/>";
		var data = {
				startDate : startDate,
				endDate : endDate
		};
		jboxPost(url, data,
			function(resp){
				$("input[name='intervalDay']").val(resp+1);
			}, null, false);
	}
	
	function doClose(){
		jboxClose();
	}
	
	function reChoose(obj){
		   $(obj).hide();
		   $("#down").hide();
		   $("#file").show();
	}
</script>
</head>
<body>
	<div class="mainright" align="center">
	<div class="content">
	<div class="title1 clearfix" >
		<form id="editForm" style="position: relative;" enctype="multipart/form-data">
		<input type="hidden" name="absenceFlow" value="${doctorAbsence.absenceFlow}"/>
		<input type="hidden" name="intervalDay"/>
		<input type="hidden" name="doctorFlow" value="${doctorAbsence.doctorFlow}"/>
		<input type="hidden" name="doctorName" value="${doctorAbsence.doctorName}"/>
		<input type="hidden" name="schDeptFlow" value="${doctorAbsence.schDeptFlow}"/>
		<input type="hidden" name="schDeptName" value="${doctorAbsence.schDeptName}"/>
		<input type="hidden" name="teacherFlow" value="${doctorAbsence.teacherFlow}"/>
		<input type="hidden" name="teacherName" value="${doctorAbsence.teacherName}"/>
		<input type="hidden" name="headFlow" value="${doctorAbsence.headFlow}"/>
		<input type="hidden" name="headName" value="${doctorAbsence.headName}"/>
		<input type="hidden" name="isRegister" value="${empty doctorAbsence.isRegister?isRegister:doctorAbsence.isRegister}"/>
		<table class="basic" style="width: 100%;">
			<colgroup>
				<col width="17%"/>
				<col width="83%"/>
			</colgroup>
			<tbody>
			<c:if test="${GlobalConstant.FLAG_Y eq isRegister}">
				<tr>
					<th>届数：</th>
					<td>
						<select name="sessionNumber" onchange="filterDoctor();" class="validate[required]">
							<option></option>
							<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
								<option value="${dict.dictName}" ${dict.dictName eq doctorAbsence.sessionNumber?'selected="selected"':''}>${dict.dictName}</option>
							</c:forEach>
						</select>
						<font color="red" >*</font>
					</td>
				</tr>
				<tr>
					<th>培训专业：</th>
					<td>
						<select name="trainingSpeId" onchange="filterDoctor();" class="validate[required]">
							<option></option>
							<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
								<option value="${dict.dictId}" ${dict.dictId eq doctorAbsence.trainingSpeId?'selected="selected"':''}>${dict.dictName}</option>
							</c:forEach>
						</select>
						<font color="red" >*</font>
					</td>
				</tr>
				<tr>
					<th>姓名：</th>
					<td>
<%-- 						<input id="userSel" class="validate[required] xltext" type="text" name="userName" value="${study.userName}" autocomplete="off"/> --%>
<!-- 		               	<div style="width: 0px;height: 0px;overflow: visible;"> -->
<!-- 		               		<div id="boxHome" style="max-height: 250px;overflow: auto;border: 1px #ccc solid;background-color: white;min-width: 167px;border-top: none;position: relative;display: none;"> -->
<%-- 		               			<c:forEach items="${userList}" var="user"> --%>
<%-- 		               				<p class="item <c:if test="${user.userFlow ==study.userFlow}">selItem</c:if>" flow="${user.userFlow}" value="${user.userName}" style="height: 30px;padding:0;padding-left: 10px;">${user.userName}</p> --%>
<%-- 		               			</c:forEach> --%>
<!-- 		               		</div> -->
<!-- 		               	</div> -->
						
						<select id="doctorFlow" class="validate[required]" onchange="chooseDoctor();">
							<option></option>
							<c:forEach items="${doctorList}" var="doctor">
								<option class="name _${doctor.sessionNumber} _${doctor.trainingSpeId}" doctorName="${doctor.doctorName}" value="${doctor.doctorFlow}"  ${doctor.doctorFlow eq doctorAbsence.doctorFlow?'selected="selected"':''}>${doctor.doctorName}</option>
							</c:forEach>
						</select>
						<font color="red" >*</font>
					</td>
				</tr>
				</c:if>
				<tr>
					<th>${GlobalConstant.FLAG_Y eq isRegister?'缺勤':'请假'}类型：</th>
					<td>
						<select name="absenceTypeId" class="validate[required]">
							<option value="">请选择</option>
							<c:forEach var="absenceType" items="${absenceTypeEnumList}">
								<c:if test="${absenceType.id != absenceTypeEnumAbsenteeism.id || GlobalConstant.FLAG_Y eq isRegister}">
								<option value="${absenceType.id}" <c:if test="${doctorAbsence.absenceTypeId==absenceType.id}">selected="selected"</c:if> >${absenceType.name}</option>
								</c:if>
							</c:forEach>
						</select>
						<font color="red" >*</font>
					</td>
				</tr>
				<tr>
					<th>${GlobalConstant.FLAG_Y eq isRegister?'缺勤':'请假'}时间：</th>
					<td>
						<input type="text" name="startDate" value="${doctorAbsence.startDate}" onblur="calculateDay();" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="validate[required]" style="margin-right: 0px;" readonly="readonly"/>
						~ <input type="text" name="endDate" value="${doctorAbsence.endDate}" onblur="calculateDay();" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="validate[required]" style="margin-right: 0px;" readonly="readonly"/>
						<font color="red" >*</font>
					</td>
				</tr>
				<tr>
					<th>${GlobalConstant.FLAG_Y eq isRegister?'缺勤':'请假'}事由：</th>
					<td colspan="3" style="text-align:left;padding: 5px;">
					     <textarea placeholder="请假事由（限250字内）。"  class="validate[required] validate[maxSize[250]] xltxtarea" name="absenceReson">${doctorAbsence.absenceReson}</textarea>
			     	</td>
				</tr>
				<tr>
					<th>轮转科室：</th>
					<td colspan="3">
						<select id="schDeptFlow" class="validate[required]" onchange="changeOthers();">
							<option value="">请选择</option>
							<c:forEach var="process" items="${processList}">
								<option value="${process.schDeptFlow}" class="schDept schDept_${process.userFlow}"
								teacherFlow="${process.teacherUserFlow }" teacherName="${process.teacherUserName }" headFlow="${process.headUserFlow }" headName="${process.headUserName }"
								<c:if test="${doctorAbsence.schDeptFlow==process.schDeptFlow || (GlobalConstant.FLAG_Y != isRegister and empty doctorAbsence.schDeptFlow and GlobalConstant.FLAG_Y eq process.isCurrentFlag)}"> selected</c:if> >${process.schDeptName}</option>
							</c:forEach>
						</select>
						<font color="red" >*</font>
					</td>
				</tr>
				<tr>
					<th>${GlobalConstant.FLAG_Y eq isRegister?'缺勤':'请假'}材料：</th>
					<td colspan="3">
						<c:choose>
							<c:when test="${not empty file}">
								<a id="down" href='<s:url value="/pub/file/down?fileFlow=${file.fileFlow}"/>'>${file.fileName}</a>
								<input type="file" id="file" name="file" style="display: none;"/>
								<span style="float: right; padding-right: 10px;">
								<a id="reCheck" href="javascript:void(0);" onclick="reChoose(this);">[重新选择文件]</a>
								</span>
						  	</c:when>
							<c:otherwise>
								<input type="file" id="file" name="file"/>     
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>带教老师：</th>
					<td colspan="3" id="teacherTd">
						${doctorAbsence.teacherName }
					</td>
				</tr>
				<tr>
					<th>科主任：</th>
					<td colspan="3" id="headTd">${doctorAbsence.headName }</td>
				</tr>
			</tbody>
		</table>
		</form>
		<p style="text-align: center;">
	      	<input type="button" onclick="save();" class="search" value="保&#12288;存"/>
	      	<input type="button" onclick="doClose();" class="search" value="关&#12288;闭"/>
	    </p>
	</div>
	</div>
	</div>
</body>
</html>