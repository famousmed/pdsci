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
<script type="text/javascript">
	$(document).ready(function(){
		selRotation();
		<c:if test="${!schDoctor.selDeptFlag eq GlobalConstant.FLAG_Y}">
			selRotation();
		</c:if>
	});

	function saveDoctor() {
		if(!$("#schDoctor").validationEngine("validate")){
			return ;
		}
		var url = "<s:url value='/sch/doc/userInfo/saveDoctor'/>";
		var getdata = $('#schDoctor').serialize();
		jboxPost(url, getdata, function(data) {
			if('${GlobalConstant.SAVE_SUCCESSED}'==data){
				window.parent.frames['mainIframe'].window.search(); 
				jboxClose();		
			}
		});
	}
	
	function doClose(){
		jboxClose();
	}
	
	function selRotation(){
		var speId = $("#speId").val();
		var sessionNumber = $("#sessionNumber").val();
		if(speId != null && speId != '' && sessionNumber != null && sessionNumber != ''){
			$(".rotation").hide();
			$("."+speId+"._"+sessionNumber).show();
		}else{
			$(".rotation").hide();
		}
		if(speId != '${schDoctor.trainingSpeId}' || sessionNumber != '${schDoctor.sessionNumber}'){
			$("[name='rotationFlow']").val('');
		}else{
			$("select[name='rotationFlow']").val('');
			$("option[value='${schDoctor.rotationFlow}']").attr("selected",true);
		}
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
		<form id="schDoctor">
		<input type="hidden" name="doctorFlow" value="${schDoctor.doctorFlow}"/>
		<c:set value="${schDoctor.selDeptFlag eq GlobalConstant.FLAG_Y}" var="selDeptFlag"></c:set>
		<c:if test="${selDeptFlag}">
			<input type="hidden" name="sessionNumber" value="${schDoctor.sessionNumber}"/>
			<input type="hidden" name="trainingSpeId" value="${schDoctor.trainingSpeId}"/>
			<input type="hidden" name="rotationFlow" value="${schDoctor.rotationFlow}"/>
		</c:if>
		<table class="basic">
			<tbody>
				<tr>
					<th width="150px">工号：</th>
					<td width="200px">
						<input type="text" ${!empty schDoctor.doctorFlow?'readonly=\'readonly\'':''} class="validate[required] xltext"  name="doctorCode" value="${schDoctor.doctorCode}" style="margin-right: 0px"/>
						<font color="red" >*</font>
					</td>
					<th width="150px">姓名：</th>
					<td width="200px">
						<input type="text" class="validate[required,maxSize[10]] xltext"  name="doctorName" value="" style="margin-right: 0px"/>
						<font color="red" >*</font>
					</td>
				</tr>
				<tr>
					<th>性别：</th>
					<td>
						<select name="sexId" class="validate[required] xlselect" style="margin-right: 0px">
							<option></option>
							<option value="${userSexEnumMan.id}">${userSexEnumMan.name}</option>
							<option value="${userSexEnumWoman.id}">${userSexEnumWoman.name}</option>
						</select>
						<font color="red" >*</font>
					</td>
					<th>身份证：</th>
					<td>
						<input type="text" class="validate[custom[chinaIdLoose]] xltext"  name="idNo" value="" style="margin-right: 0px"/>
					</td>
				</tr>
				<tr>
					<th>毕业院校：</th>
					<td>
						<select name="graduatedId" class="xlselect" style="margin-right: 0px">
							<option></option>
							<c:forEach items="${dictTypeEnumGraduateSchoolList}" var="dict">
								<option value="${dict.dictId}" ${schDoctor.graduatedId eq dict.dictId?'selected=\'selected\'':''}>${dict.dictName}</option>
							</c:forEach>
						</select>
					</td>
					<th></th>
					<td></td>
				</tr>
				<tr>
					<th>学历：</th>
					<td>
						<select name="educationId" class="xlselect" style="margin-right: 0px">
							<option></option>
							<c:forEach items="${dictTypeEnumUserEducationList}" var="dict">
								<option value="${dict.dictId}">${dict.dictName}</option>
							</c:forEach>
						</select>
					</td>
					<th>学位：</th>
					<td>
						<select name="degreeId" class="xlselect" style="margin-right: 0px">
							<option></option>
							<c:forEach items="${dictTypeEnumUserDegreeList}" var="dict">
								<option value="${dict.dictId}">${dict.dictName}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>届数：</th>
					<td>
						<select ${selDeptFlag?'disabled="true"':''} id="sessionNumber" name="sessionNumber" class="validate[required] xlselect" style="margin-right: 0px" onchange="selRotation();">
							<option></option>
							<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
								<option value="${dict.dictName}" ${schDoctor.sessionNumber eq dict.dictName?'selected=\'selected\'':''}>${dict.dictName}</option>
							</c:forEach>
						</select>
						<font color="red" >*</font>
					</td>
					<th>专业：</th>
					<td>
						<input type="text" class=" xltext"  name="specialized" value="${schDoctor.specialized}" style="margin-right: 0px"/>
					</td>
				</tr>
				<tr>
					<th>培训专业：</th>
					<td>
						<select ${selDeptFlag?'disabled="true"':''} id="speId" name="trainingSpeId" class="validate[required] xlselect" style="margin-right: 0px" onchange="selRotation();">
							<option></option>
							<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
								<option value="${dict.dictId}" ${schDoctor.trainingSpeId eq dict.dictId?'selected=\'selected\'':''}>${dict.dictName}</option>
							</c:forEach>
						</select>
						<font color="red" >*</font>
					</td>
					<th>轮转信息：</th>
					<td>
						<select ${selDeptFlag?'disabled="true"':''} name="rotationFlow" class="validate[required] xlselect" style="margin-right: 0px">
							<option></option>
							<c:forEach items="${rotationList}" var="rotation">
								<option class="rotation ${rotation.speId} _${rotation.sessionNumber}" value="${rotation.rotationFlow}" ${schDoctor.rotationFlow eq rotation.rotationFlow?'selected=\'selected\'':''}>${rotation.rotationName}</option>
							</c:forEach>
						</select>
						<font color="red" >*</font>
					</td>
				</tr>
				<tr>
					<th>手机：</th>
					<td>
						<input type="text" class="validate[custom[mobile]] xltext"  name="phoneNumber" value="" style="margin-right: 0px"/>
					</td>
					<th>邮件：</th>
					<td>
						<input type="text" class="validate[custom[email]] xltext"  name="email" value="" style="margin-right: 0px"/>
					</td>
					
				</tr>
				<tr>
					<th>医师状态：</th>
					<td>
						<select name="doctorStatusId" class="validate[required] xlselect" style="margin-right: 0px">
							<option></option>
							<option value="${schDoctorStatusEnumTraining.id}" ${schDoctor.doctorStatusId eq schDoctorStatusEnumTraining.id || empty schDoctor.doctorFlow?'selected=\'selected\'':''}>${schDoctorStatusEnumTraining.name}</option>
							<option value="${schDoctorStatusEnumGraduation.id}" ${schDoctor.doctorStatusId eq schDoctorStatusEnumGraduation.id?'selected=\'selected\'':''}>${schDoctorStatusEnumGraduation.name}</option>
						</select>
						<font color="red" >*</font>
					</td>
					<th>停用：</th>
					<td>
						<input type="checkbox" name="recordStatus" ${schDoctor.recordStatus eq GlobalConstant.RECORD_STATUS_N?'checked=\'checked\'':''} value="${GlobalConstant.RECORD_STATUS_N}"/>
					</td>
				</tr>
			</tbody>
		</table>
		</form>
		<p style="text-align: center;">
	       		<input type="button" onclick="javascript:saveDoctor();"  class="search" value="保&#12288;存"/>
	       		<input type="button" onclick="javascript:doClose()" class="search" value="关&#12288;闭"/>
	       </p>
		</div>
	</div>
</div>
</body>
</html>