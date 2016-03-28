<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${'open' eq param.type }">
<%@include file="/jsp/common/doctype.jsp" %>
	<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	</jsp:include>
</c:if>
<html>
<head>
<script>
<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR) && empty rec}">
	$("#appraisalForm").hide();
	$("#tipContent").html('<div style="margin: 10px 10px;height:300px;">该医师还未填写实习总鉴定！</div>');
</c:if>
<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR) || recStatusEnumTeacherAuditY.id eq rec.auditStatusId || recStatusEnumHeadAuditY.id eq rec.headAuditStatusId}">
	$(document).ready(function(){
		hideButton();
	});
</c:if>
function hideButton() {
	$('input,textarea').attr("readonly","readonly");
	$("select,:checkbox,:radio").attr("disabled", "disabled");
	$(":button").hide();
	<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_LEADER && !empty rec && empty formDataMap['groupAppraise']}">
		$("[name='groupAppraise']").attr("readonly",false);
		$(".submitBtn").show();
	</c:if>
	<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_ADMIN && !empty rec && empty formDataMap['orgAppraise']}">
		$("[name='orgAppraise']").attr("readonly",false);
		$(".submitBtn").show();
	</c:if>
	<c:if test="${param.roleFlag eq GlobalConstant.USER_LIST_GLOBAL && !empty rec && empty formDataMap['collegeAppraise']}">
		$("[name='collegeAppraise']").attr("readonly",false);
		$(".submitBtn").show();
	</c:if>
}

$(document).mouseup(function(f) {
	if ($(window).width() - f.pageX < 800) {
		return;
	}
	if ($(f.target).closest("div.mfp-content").length) {
		return;
	}
	if (f.target.nodeName == "SELECT") {
		if ($(event.target).closest($("#report")).length) {
			return;
		}
	}
	$("#report").hide();
});

function show(){
	$("#report").show();
}

function saveForm(){
	if($("#appraisalForm").validationEngine("validate")){
		var data = $('#appraisalForm').serialize();
		<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_ADMIN}">
			data+="&auditStatusId=${recStatusEnumTeacherAuditY.id}&auditStatusName=${recStatusEnumTeacherAuditY.name}";
		</c:if>
		<c:if test="${param.roleFlag eq GlobalConstant.USER_LIST_GLOBAL}">
			data+="&headAuditStatusId=${recStatusEnumHeadAuditY.id}&headAuditStatusName=${recStatusEnumHeadAuditY.name}";
		</c:if>
		jboxPost("<s:url value='/res/rec/saveRegistryForm'/>",data,function(){
			if ("open" == "${param.type}") {
				window.parent.frames['mainIframe'].window.$("#tags").find(".selectTag a").click();
				jboxClose();
			} else {
				window.$("#tags").find(".selectTag a").click();
			}
		},null,true);
	}
}

function submitForm(){
	jboxConfirm("提交后不可再编辑，确认提交?",function(){
		saveForm();
	});
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
		<form id="appraisalForm" method="post">
		<input type="hidden" name="doctorFlow" value="${param.operUserFlow}"/>
		<input type="hidden" name="schDeptFlow" value="${param.schDeptFlow}"/>
		<input type="hidden" name="formFileName" value="${formFileName}"/>
		<input type="hidden" name="recFlow" value="${rec.recFlow}"/>
		<input type="hidden" name="processFlow" value="${currRegProcess.processFlow}"/>
			<div class="title1 clearfix">
				<table class="basic" width="100%">
					<tr>
						<th colspan="6" style="text-align: left;">&#12288;毕业实习总鉴定</th>
					</tr>
					<tr style="font-weight: bold;">
						<td style="text-align: left;">&#12288;&#12288;实习科目：<input type="text" name="internSubjects" class="inputText" value="${formDataMap['internSubjects']}"
							style="width: 60%;text-align: left;"
							/></td>
					</tr>
					<tr>
						<td  width="100px;" style="text-align: left;">&#12288;&#12288;共缺时间：
						<input type="text" name="lackTime" class="inputText"  value="${formDataMap['lackTime']}"
							style="width:100px;"/>
							&#12288;&#12288;其中病假：<input type="text" name="sickLeaveDays" class="inputText"  value="${formDataMap['sickLeaveDays']}"
							style="width:100px;"/>天
							&#12288;&#12288;事假：<input type="text" name="leaveDays" class="inputText"  value="${formDataMap['leaveDays']}"
							style=" width:100px;"/>天
							&#12288;&#12288;旷实习：<input type="text" name="absentDays" class="inputText"  value="${formDataMap['absentDays']}"
							style="width:100px;"/>天
						</td>
						
					</tr>
					<tr>
					<td>
						&#12288;&#12288;自我鉴定：<br/>
						<textarea name="selfIdentifi" style="width: 95%;padding-left:20px;margin-bottom:10px;padding-right:20px;height: 500px;">${formDataMap['selfIdentifi']}</textarea>
					</td>
					</tr>
				</table>
				<c:if test="${(!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_LEADER) && !empty formDataMap['groupAppraise']) || param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_LEADER}">
					<fieldset class="basic" style="margin-left:0;margin-right: 0;">
						<legend>实习大组意见</legend>
						<div>
							<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_LEADER && !empty rec && empty formDataMap['groupAppraise']}">
								<textarea name="groupAppraise" style="width: 100%;height: 50px;" class="validate[required]">${formDataMap['groupAppraise']}</textarea>
							</c:if>
							<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_LEADER) || empty rec || !empty formDataMap['groupAppraise']}">
								${formDataMap['groupAppraise']}
								<input type="hidden" name="groupAppraise" value="${formDataMap['groupAppraise']}"/>
							</c:if>
							<div>
								<span style="float: right;padding-right: 10px;">
									<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_LEADER && !empty rec && empty formDataMap['groupAuditDate']}">
										<input class="inputText" type="text" name="groupAuditDate" value="${empty formDataMap['groupAuditDate']?(pdfn:getCurrDate()):formDataMap['groupAuditDate']}" readonly="readonly"
										<c:if test="${empty formDataMap['groupAppraise']}">
										onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"
										</c:if>
										/>
									</c:if>
									<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_LEADER) || empty rec || !empty formDataMap['groupAuditDate']}">
										${formDataMap['groupAuditDate']}
										<input type="hidden" name="groupAuditDate" value="${formDataMap['groupAuditDate']}"/>
									</c:if>
								</span>
							</div>
						</div>
					</fieldset>
				</c:if>
				<c:if test="${(!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_ADMIN) && !empty formDataMap['orgAppraise']) || param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_ADMIN}">
					<fieldset class="basic" style="margin-left:0;margin-right: 0;">
						<legend>实习单位意见</legend>
						<div>
							<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_ADMIN && !empty rec && empty formDataMap['orgAppraise']}">
								<textarea name="orgAppraise" style="width: 100%;height: 50px;" class="validate[required]">${formDataMap['orgAppraise']}</textarea>
							</c:if>
							<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_ADMIN) || empty rec || !empty formDataMap['orgAppraise']}">
								${formDataMap['orgAppraise']}
								<input type="hidden" name="orgAppraise" value="${formDataMap['orgAppraise']}"/>
							</c:if>
							<div>
								<span style="float: right;padding-right: 10px;">
									<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_ADMIN && !empty rec && empty formDataMap['orgAuditDate']}">
										<input class="inputText" type="text" name="orgAuditDate" value="${empty formDataMap['orgAuditDate']?(pdfn:getCurrDate()):formDataMap['orgAuditDate']}" readonly="readonly"
										<c:if test="${empty formDataMap['orgAppraise']}">
										onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"
										</c:if>
										/>
									</c:if>
									<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_ADMIN) || empty rec || !empty formDataMap['orgAuditDate']}">
										${formDataMap['orgAuditDate']}
										<input type="hidden" name="orgAuditDate" value="${formDataMap['orgAuditDate']}"/>
									</c:if>
								</span>
							</div>
						</div>
					</fieldset>
				</c:if>
				<c:if test="${(!(param.roleFlag eq GlobalConstant.USER_LIST_GLOBAL) && !empty formDataMap['collegeAppraise']) || param.roleFlag eq GlobalConstant.USER_LIST_GLOBAL}">
					<fieldset class="basic" style="margin-left:0;margin-right: 0;">
						<legend>学校考核意见</legend>
						<div>
							<c:if test="${param.roleFlag eq GlobalConstant.USER_LIST_GLOBAL && !empty rec && empty formDataMap['collegeAppraise']}">
								<textarea name="collegeAppraise" style="width: 100%;height: 50px;" class="validate[required]">${formDataMap['collegeAppraise']}</textarea>
							</c:if>
							<c:if test="${!(param.roleFlag eq GlobalConstant.USER_LIST_GLOBAL) || empty rec || !empty formDataMap['collegeAppraise']}">
								${formDataMap['collegeAppraise']}
								<input type="hidden" name="collegeAppraise" value="${formDataMap['collegeAppraise']}"/>
							</c:if>
							<div>
								<span style="float: right;padding-right: 10px;">
									<c:if test="${param.roleFlag eq GlobalConstant.USER_LIST_GLOBAL && !empty rec && empty formDataMap['collegeAuditDate']}">
										<input class="inputText" type="text" name="collegeAuditDate" value="${empty formDataMap['collegeAuditDate']?(pdfn:getCurrDate()):formDataMap['collegeAuditDate']}" readonly="readonly" 
										<c:if test="${empty formDataMap['collegeAppraise']}">
										onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"
										</c:if>
										/>
									</c:if>
									<c:if test="${!(param.roleFlag eq GlobalConstant.USER_LIST_GLOBAL) || empty rec || !empty formDataMap['collegeAuditDate']}">
										${formDataMap['collegeAuditDate']}
										<input type="hidden" name="collegeAuditDate" value="${formDataMap['collegeAuditDate']}"/>
									</c:if>
								</span>
							</div>
						</div>
					</fieldset>
				</c:if>
			</div>
			<div class="button" >
				<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
					<input class="search" type="button" value="保&#12288;存" onclick="saveForm();" />
				</c:if>
				<c:if test="${(param.roleFlag eq GlobalConstant.USER_LIST_GLOBAL && empty formDataMap['collegeAppraise']) ||
							 (param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_ADMIN && empty formDataMap['orgAppraise'])  ||
							 (param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_LEADER && empty formDataMap['groupAppraise'])}">
					<input class="search submitBtn" type="button" value="提&#12288;交" onclick="submitForm();" />
				</c:if>
			</div>
			</form>
		</div>
	</div>
	<div id="tipContent"></div>
	<div style="display: none">
		<!-- 模板 -->
		<table class="xllist" id="teachRecordTemplate">
       		<tr>
				<td><input type="checkbox" name="teachRecordIds"/></td>
				<td>
					<input type="text"  name="teachRecord_teachTime" value="" class="inputText validate[required]" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px;"/>
				</td>
				<td>
					<input type="text" name="teachRecord_teacher" style="width:90%" class="inputText validate[required]" value="" class="inputText"/>
				</td>
				<td>
					<select name="teachRecord_teachType" class="inputText validate[required]">
						<option value="" ></option>
						<c:forEach var="dict" items="${dictTypeEnumTeachTypeList}" varStatus="num">
							<option value="${dict.dictName}" >${dict.dictName}</option>
						</c:forEach>
					</select>
				</td>
				<td>
					<input type="text" name="teachRecord_teachContent" style="width:90%" class="inputText validate[required]" value="" class="inputText"/>
				</td>
			</tr>
		</table>
	</div>	
</body>
</html>