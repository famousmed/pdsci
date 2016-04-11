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
	<jsp:param name="jquery_cxselect" value="true"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="false"/>
	<jsp:param name="jquery_placeholder" value="false"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<style type="text/css">
	table.formBasic th,table.formBasic td{padding: 0px;text-align: center;}
</style>
<script type="text/javascript">
function showImg(obj,type,status){
	$("."+type).hide();
	$('.'+type,obj).show();
	$("."+type+"Hid").val(status);
}
function saveForm(){
	if($("#registryCheckForm").validationEngine("validate")){
		jboxPost("<s:url value='/res/rec/saveRegistryForm'/>",$("#registryCheckForm").serialize(),function(resp){
			if(resp=="${GlobalConstant.SAVE_SUCCESSED}"){
					top.document.mainIframe.$("#tags .selectTag a").click();
					jboxClose();
		}				
	},null,true);
		}
	}
function save(){	
	if($("#registryCheckForm").validationEngine("validate")){
		jboxConfirm("确认保存？保存之后不可修改！",function(){
			jboxPost("<s:url value='/res/rec/saveRegistryForm'/>",$("#registryCheckForm").serialize(),function(resp){
				if(resp=="${GlobalConstant.SAVE_SUCCESSED}"){
						top.document.mainIframe.$("#tags .selectTag a").click();
						jboxClose();
			}				
		},null,true);
		});
	}
	
	 if(!$("#registryCheckForm").validationEngine("validate")){
			return;
		}
	}
	function isInt(num){
		return !isNaN(num) && num!="";
	}
function check(num){
	var item = $(".score");
	var sum = 0;
	item.each(function(){
		var value = this.value;
		if(isInt(value)){
			value = parseInt(value);
		}else{
			value = 0;
		}
		sum+=value;
	});
	<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
		$("#total label").text(sum);
		$("#total input").val(sum);
	</c:if>
}
$(function(){
	$(".ctrlInput").attr("readonly",true);
	$(".ctrlInput.${param.roleFlag}").attr("readonly",false);
	<c:if test="${!empty rec.headAuditStatusId}">
		$(".toggleView,.toggleView2").toggle();
// 		$(".toggleView2").toggle();
	 </c:if>
	 <c:if test="${!empty rec.adminAuditStatusId}">
		$(".toggleView3").toggle();
	</c:if>
});

function printRegistryCheck(){
	jboxTip("打印中,请稍等...");
	var url = "<s:url value='/res/rec/printRegistryCheck'/>?recFlow=${param.recFlow}";
	window.location.href = url;
}
</script>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix"><div align="right" style="margin-top: 10px;" >
				<form id="registryCheckForm" style="position: relative;">
				<input type="hidden" name="processFlow" value="${currRegProcess.processFlow}"/>
				 <c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}">
					 <input type="hidden" name="headAuditStatusId" value="${recStatusEnumHeadAuditY.id}"/>
				 </c:if>
				 <c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_ADMIN}">
					 <input type="hidden" name="adminAuditStatusId" value="${recStatusEnumAdminAuditY.id}"/>
				 </c:if>
				<h1 align="center" style="margin-bottom: 10px;">年度考核登记表(
					<c:if test="${ param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
						<input type="text" style="width: 40px;"  class="toggleView inputText" name="year" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy'});" value="<c:out value="${formDataMap['year']}" default="${pdfn:getCurrYear()}"/>" />
						<label style="display: none;" class="toggleView">${formDataMap['year']}</label>
					</c:if>
					<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_DOCTOR }">
						<label class="inputText" style="width: 100px;display: inline-block;">${formDataMap['year']}</label>
						<input type="hidden" name="year" value="${formDataMap['year']}"/>
					</c:if>
					年度)</h1>
				 <input type="hidden" name="formFileName" class="inputText" value="${formFileName}"/>
				 <input type="hidden" name="recFlow" value="${rec.recFlow}"/>
					<table class="basic" style="width: 100%;">
						<tr>
							<td style="width: 17%; text-align: center;">姓名</td>
							<td style="width: 20%;text-align: center;">
								<input type="text" style="width: 80%;" class="toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="name" value="<c:out value="${formDataMap['name']}" default="${sessionScope.currUser.userName}"/>"/>
								<div style="display: none;width: 100%;text-align: left;" class="toggleView">${formDataMap['name']}</div>
							</td>
							<td style="width: 10%;text-align: center;">工号</td>
							<td style="width: 20%;text-align: center;">
								<input type="text"  style="width: 120px;" class="toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="JobNumber" value="<c:out value="${formDataMap['JobNumber']}" default="${sessionScope.currDoctor.doctorCode}"/>"/>
								<label style="display: none;" class="toggleView">${formDataMap['JobNumber']}</label>
							</td>
							<td style="width: 13%;text-align: center;">科室</td>
							<td style="text-align: center;">
								<c:if test="${ param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
									<select name="schDeptFlow"  style="width: 80%;" class="toggleView validate[required] ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" onchange="$('#department').val($(':selected',this).text());">
										<option value="">请选择</option>
										<c:forEach items="${deptList}" var="dept">
											<option value="${dept.schDeptFlow}" <c:if test="${empty formDataMap['schDeptFlow']?(dept.schDeptFlow==process.schDeptFlow):(dept.schDeptFlow==formDataMap['schDeptFlow'])}">selected</c:if>>${dept.schDeptName}</option>
										</c:forEach>
									</select>
									<label style="display: none;" class="toggleView">${formDataMap['department']}</label>
									<input type="hidden" id="department" name="department" value="${empty formDataMap['department']?process.schDeptName:formDataMap['department']}"/>
									</c:if>
									<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_DOCTOR }">
										<label class="" style="display: inline-block;">${formDataMap['department']}</label>
										<input type="hidden" name="department" value="${formDataMap['department']}"/>
									</c:if>
							</td>
						</tr>
						<tr>
							<td style="text-align: center;">现聘任职务(岗位)</td>
							<td colspan="3" style="text-align: center;">
								<c:set var="postAndTitle" value="${sessionScope.currUser.postName}（${sessionScope.currUser.titleName}）"/>
								<input type="text"  style="width:340px;text-align: left;" class="toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="post" value="${empty formDataMap['post']?postAndTitle:formDataMap['post']}"/>
								<div style="display: none;text-align: left;" class="toggleView">${ formDataMap['post']}</div>
							</td>
							<td style="text-align: center;">病假(天)</td>
							<td style="text-align: center;">
								<input type="text" style="width: 80%;"  onchange="check(this.value)" class="score toggleView validate[custom[integer]] inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="sickLeave" value="${formDataMap['sickLeave']}"/>
								<label style="display: none;" class="toggleView">${formDataMap['sickLeave']}</label>
							</td>
						</tr>
						<tr>
							<td style="text-align: center;">家庭地址</td>
							<td  colspan="3" style="text-align: center;">
								<input type="text" style="width: 340px;"  class="toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="address" value="${formDataMap['address']}" />
								<div style="display: none;width: 100%;text-align: left;" class="toggleView">${formDataMap['address']}</div>
							</td>
							<td style="text-align: center;">事假(天)</td>
							<td style="text-align: center;"> 
								<input type="text"  style="width: 80%;"  onchange="check(this.value)" class="score toggleView validate[custom[integer]] inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="compassionateLeave" value="${formDataMap['compassionateLeave']}"/>
								<label style="display: none;" class="toggleView">${formDataMap['compassionateLeave']}</label>
							</td>
						</tr>
						<tr>
							<td style="text-align: center;">固定电话</td>
							<td style="text-align: center;">
								<input type="text"  style="width: 80%;text-align: left;" class="toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="fixedTelephone" value="${formDataMap['fixedTelephone']}"/>
								<div style="display: none;width: 100%;text-align: left;" class="toggleView">${formDataMap['fixedTelephone']}</div>
							</td>
							<td style="text-align: center;">手机</td>
							<td style="text-align: center;">
								<input type="text"  style="width: 80%;text-align: left;" class="toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="cellphone" value="${empty formDataMap['cellphone']?sessionScope.currUser.userPhone:formDataMap['cellphone']}"/>
								<label style="display: none;" class="toggleView">${ formDataMap['cellphone']}</label>
							</td>
							<td style="text-align: center;">产休假(天)</td>
							<td style="text-align: center;">
								<input type="text" style="width: 80%;" onchange="check(this.value)" class="score toggleView validate[custom[integer]] inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="holiday" value="${formDataMap['holiday']}"/>
								<label style="display: none;" class="toggleView">${formDataMap['holiday']}</label>
							</td>
						</tr>
						<tr>
							<td style="text-align: center;">学会任职</td>
							<td colspan="3" style="text-align: center;">
								<input type="text" style="width: 340px;text-align: left;" class="toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="serve" value="${formDataMap['serve']}"/>
								<div style="display: none;width: 100%;text-align: left;" class="toggleView">${formDataMap['serve']}</div>
							</td>
							<td style="text-align: center;">合计(天)</td>
							<td id="total" style="text-align: center;">
								<input type="text" style="width: 80%;" class="toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="total" value="${formDataMap['total']}"/>
								<label style="display: none;" class="toggleView">${formDataMap['total']}</label>
							</td>
						</tr>
						<tr>
							<td colspan="7" style="text-align: center;">请对照岗位职责，将本年度取得成绩（徳、能、勤、绩）进行小结</td>
						</tr>
						<tr>
							<td colspan="7">
								<c:if test="${ param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
									<div>
										<textarea placeholder="请填写" class="toggleView ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" style="width: 100%; height:200px; border: none;" name="summary">${formDataMap['summary']}</textarea>
									</div>
									<div>
										<div style="display: none; text-align: left;height: 100px;"  class="toggleView">${formDataMap['summary']}</div>
									</div>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_DOCTOR }">
									<div style="width: 100px;height:100px; ">${formDataMap['summary']}</div>
									<input type="hidden" name="summary" value="${formDataMap['summary']}"/>
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="7" style="text-align: center;">还需提高的方面及明年打算</td>
						</tr>
						<tr>
							<td colspan="7">
								<c:if test="${ param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
									<div>
										<textarea placeholder="请填写" class="toggleView ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" style="width: 100%; height:200px; border: none;" name="nextYearPlan">${formDataMap['nextYearPlan']}</textarea>
									</div>
									<div>
										<div style="display: none; text-align: left;height: 100px;"  class="toggleView">${formDataMap['nextYearPlan']}</div>
									</div>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_DOCTOR }">
									<div style="width: 100px;height:100px; ">${formDataMap['nextYearPlan']}</div>
									<input type="hidden" name="nextYearPlan" value="${formDataMap['nextYearPlan']}"/>
								</c:if>
							<br>
							<span style="float: right;margin-bottom: 6px;">本人签名:
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
									<input type="text" class="toggleView validate[required] inputText" name="mySignature" value="<c:out value="${formDataMap['mySignature']}" default="${sessionScope.currUser.userName}"/>" style="width: 100px;text-align: left;"/>
									<label style="display: none;" class="toggleView">${formDataMap['mySignature']}</label>	
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_DOCTOR }">
									<label style="width: 100px;display: inline-block;">${formDataMap['mySignature']}</label>
									<input type="hidden" name="mySignature" value="${formDataMap['mySignature']}"/>
								</c:if>&#12288;签名时间：
							<c:if test="${ param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
									<input type="text" class="toggleView inputText validate[required]" name="mySignatureDate" value="<c:out value="${formDataMap['mySignatureDate']}" default="${pdfn:getCurrDate()}"/>" style="width: 100px;text-align: left;" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
									<label style="display: none;" class="toggleView">${formDataMap['mySignatureDate']}&#12288;</label>
								</c:if>
							<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_DOCTOR }">
									<label style="width: 100px;display: inline-block;">${formDataMap['mySignatureDate']}</label>
									<input type="hidden" name="mySignatureDate" value="${formDataMap['mySignatureDate']}"/>
							</c:if>
							</span>
							</td>
						</tr>
						</table>
						<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD || ((param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR || param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_ADMIN) && !empty rec.headAuditStatusId)}">
						<table class="basic formBasic" style="width: 100%; margin-top: 10px;">
						<tr>
							<td>科室考核意见</td>
							<td colspan="6">
								<c:if test="${ param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
									<textarea class="toggleView2" placeholder="请填写" style="width: 100%;height:100px; border: none;" name="departmentAssessment">${formDataMap['departmentAssessment']}</textarea>
									<div style="display: none;height: 100px; text-align: left;padding-left: 10px;" class="toggleView2">${formDataMap['departmentAssessment']}</div>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD}">
									<div style="height: 100px; text-align: left;padding-left: 10px;">${formDataMap['departmentAssessment']}</div>
									<input type="hidden" name="departmentAssessment" value="${formDataMap['departmentAssessment']}"/>
								</c:if>
							</td>
						</tr>
						<tr>
							<td rowspan="8" style="widows: 17%;">科室评论</td>
							<td style="width: 22%;">评价项目</td>
							<td style="width: 13%;">优秀</td>
							<td style="width: 13%;">良好</td>
							<td style="width: 13%;">达标</td>
							<td style="width: 13%;">尚可</td>
							<td style="width: 13%;">欠缺</td>
						</tr>
						<tr>
							<td>
								团队协作、奉献精神
								<input type="hidden" class="teamworkHid" name="teamwork" value="${formDataMap['teamwork']}"/>
							</td>
							<td onclick="showImg(this,'teamwork','优秀');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
									<c:if test="${empty rec.headAuditStatusId}">
										<img class="teamwork" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
									</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="teamwork"  <c:if test="${'优秀' eq formDataMap['teamwork']}">checked</c:if> value="优秀"/> --%>
									<c:if test="${'优秀' eq formDataMap['teamwork']}">
										<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
									</c:if>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '优秀' eq formDataMap['teamwork']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="teamwork" value="${formDataMap['teamwork']}"/> --%>
								</c:if>
							</td>
						
							<td onclick="showImg(this,'teamwork','良好');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
									<c:if test="${empty rec.headAuditStatusId }">
										<img  class="teamwork" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
									</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="teamwork" <c:if test="${'良好' eq formDataMap['teamwork']}">checked</c:if> value="良好"/> --%>
									<c:if test="${'良好' eq formDataMap['teamwork']}">
										<label style="display: none;" class="toggleView2">
											<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
										</label>
									</c:if>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '良好' eq formDataMap['teamwork']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="teamwork" value="${formDataMap['teamwork']}"/> --%>
								</c:if>
							</td>
							<td onclick="showImg(this,'teamwork','达标');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}"> 
								<c:if test="${empty rec.headAuditStatusId}">
								<img  class="teamwork" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="teamwork" <c:if test="${'达标' eq formDataMap['teamwork']}">checked</c:if> value="达标"/> --%>
									<c:if test="${'达标' eq formDataMap['teamwork']}">
										<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
									</c:if>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '达标' eq formDataMap['teamwork']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="teamwork" value="${formDataMap['teamwork']}"/> --%>
								</c:if>
							</td>
							<td onclick="showImg(this,'teamwork','尚可');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
								<c:if test="${empty rec.headAuditStatusId}">
									<img  class="teamwork" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="teamwork" <c:if test="${'尚可' eq formDataMap['teamwork']}">checked</c:if> value="尚可"/> --%>
									<c:if test="${'尚可' eq formDataMap['teamwork']}">
										<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
									</c:if>
								</c:if>		
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '尚可' eq formDataMap['teamwork']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="teamwork" value="${formDataMap['teamwork']}"/> --%>
								</c:if>
							</td>
							<td onclick="showImg(this,'teamwork','欠缺');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
									<c:if test="${empty rec.headAuditStatusId}">
										<img  class="teamwork" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
									</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="teamwork" <c:if test="${'欠缺' eq formDataMap['teamwork']}">checked</c:if> value="欠缺"/> --%>
									<c:if test="${'欠缺' eq formDataMap['teamwork']}">
										<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
									</c:if>
<%-- 										<input type="hidden" name="teamwork" value="${formDataMap['teamwork']}"/> --%>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '欠缺' eq formDataMap['teamwork']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="teamwork" value="${formDataMap['teamwork']}"/> --%>
								</c:if>
							</td>
						</tr>
						<tr >
							<td>
								完成工作数量
								<input type="hidden" class="quantityHid" name="quantity" value="${formDataMap['quantity']}"/>
							</td>
							<td onclick="showImg(this,'quantity','优秀');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
								<c:if test="${empty rec.headAuditStatusId }">
									<img class="quantity" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="quantity" <c:if test="${'优秀' eq formDataMap['quantity']}">checked</c:if> value="优秀"/> --%>
									<c:if test="${'优秀' eq formDataMap['quantity']}">
										<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
									</c:if>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '优秀' eq formDataMap['quantity']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="quantity" value="${formDataMap['quantity']}"/> --%>
								</c:if>
							</td>
							<td onclick="showImg(this,'quantity','良好');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
								<c:if test="${empty rec.headAuditStatusId}">
									<img  class="quantity" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="quantity" <c:if test="${'良好' eq formDataMap['quantity']}">checked</c:if> value="良好"/> --%>
									<c:if test="${'良好' eq formDataMap['quantity']}">
										<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
									</c:if>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '良好' eq formDataMap['quantity']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="quantity" value="${formDataMap['quantity']}"/> --%>
								</c:if>
							</td>
							<td onclick="showImg(this,'quantity','达标');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
								<c:if test="${empty rec.headAuditStatusId}">
									<img class="quantity" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="quantity" <c:if test="${'达标' eq formDataMap['quantity']}">checked</c:if> value=达标/> --%>
									<c:if test="${'达标' eq formDataMap['quantity']}">
										<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
									</c:if>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '达标' eq formDataMap['quantity']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="quantity" value="${formDataMap['quantity']}"/> --%>
								</c:if>
							</td>
							<td onclick="showImg(this,'quantity','尚可');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
								<c:if test="${empty rec.headAuditStatusId}">
									<img class="quantity" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="quantity" <c:if test="${'尚可' eq formDataMap['quantity']}">checked</c:if> value="尚可"/> --%>
									<c:if test="${'尚可' eq formDataMap['quantity']}">
									<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
								</c:if>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '尚可' eq formDataMap['quantity']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="quantity" value="${formDataMap['quantity']}"/> --%>
								</c:if>
							</td>
							<td onclick="showImg(this,'quantity','欠缺');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
								<c:if test="${empty rec.headAuditStatusId }">
									<img class="quantity" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="quantity" <c:if test="${'欠缺' eq formDataMap['quantity']}">checked</c:if> value="欠缺"/> --%>
									<c:if test="${ '欠缺' eq formDataMap['quantity']}">
									<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
								</c:if>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '欠缺' eq formDataMap['quantity']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="quantity" value="${formDataMap['quantity']}"/> --%>
								</c:if>
							</td>
						</tr>
						<tr>
							<td>
								完成工作质量
								<input type="hidden" class="qualityHid" name="quality" value="${formDataMap['quality'] }"/>
							</td>
							<td onclick="showImg(this,'quality','优秀');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
								<c:if test="${empty rec.headAuditStatusId}">
									<img  class="quality" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="quality" <c:if test="${'优秀' eq formDataMap['quality']}">checked</c:if> value="优秀"/> --%>
									<c:if test="${ '优秀' eq formDataMap['quality']}">
									<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
								</c:if>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '优秀' eq formDataMap['quality']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="quality" value="${formDataMap['quality']}"/> --%>
								</c:if>
							</td>
							<td onclick="showImg(this,'quality','良好');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
								<c:if test="${empty rec.headAuditStatusId }">
									<img class="quality" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="quality" <c:if test="${'良好' eq formDataMap['quality']}">checked</c:if> value="良好"/> --%>
									<c:if test="${ '良好' eq formDataMap['quality']}">
									<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
								</c:if>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '良好' eq formDataMap['quality']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="quality" value="${formDataMap['quality']}"/> --%>
								</c:if>
							</td>
							<td onclick="showImg(this,'quality','达标');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
								<c:if test="${empty rec.headAuditStatusId }">
									<img class="quality" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="quality" <c:if test="${'达标' eq formDataMap['quality']}">checked</c:if> value="达标"/>  --%>
									<c:if test="${'达标' eq formDataMap['quality']}">
										<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
									</c:if>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '达标' eq formDataMap['quality']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="quality" value="${formDataMap['quality']}"/> --%>
								</c:if>
							</td >
							<td onclick="showImg(this,'quality','尚可');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
								<c:if test="${empty rec.headAuditStatusId}">
									<img class="quality" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="quality" <c:if test="${'尚可' eq formDataMap['quality']}">checked</c:if> value="尚可"/> --%>
									<c:if test="${ '尚可' eq formDataMap['quality']}">
									<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
								</c:if>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '尚可' eq formDataMap['quality']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="quality" value="${formDataMap['quality']}"/> --%>
								</c:if>	
								</td>
							<td onclick="showImg(this,'quality','欠缺');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
								<c:if test="${empty rec.headAuditStatusId }">
									<img class="quality" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="quality" <c:if test="${'欠缺' eq formDataMap['quality']}">checked</c:if> value="欠缺"/> --%>
									<c:if test="${'欠缺' eq formDataMap['quantity']}">
										<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
									</c:if>	
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '欠缺' eq formDataMap['quantity']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="quality" value="${formDataMap['quality']}"/> --%>
								</c:if>
							</td>
						</tr>
						<tr>
							<td>
								遵守劳动纪律、规章制度
								<input type="hidden" class="complyWithHid" name="complyWith" value="${formDataMap['complyWith'] }"/>
							</td>
							<td onclick="showImg(this,'complyWith','优秀');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
									<c:if test="${empty rec.headAuditStatusId}">
										<img class="complyWith" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
									</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="complyWith"  <c:if test="${'优秀' eq formDataMap['complyWith']}">checked</c:if> value="优秀"/> --%>
									<c:if test="${'优秀' eq formDataMap['complyWith']}">
										<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
									</c:if>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '优秀' eq formDataMap['complyWith']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 								<input type="hidden" name="complyWith" value="${formDataMap['complyWith']}"/> --%>
								</c:if>
								</td>
							<td onclick="showImg(this,'complyWith','良好');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
									<c:if test="${empty rec.headAuditStatusId}">
										<img class="complyWith" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
									</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="complyWith" <c:if test="${'良好' eq formDataMap['complyWith']}">checked</c:if> value="良好"/> --%>
									<c:if test="${'良好' eq formDataMap['complyWith']}">
										<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
									</c:if>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '良好' eq formDataMap['complyWith']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="complyWith" value="${formDataMap['complyWith']}"/> --%>
								</c:if>
								</td>
							<td onclick="showImg(this,'complyWith','达标');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
								<c:if test="${empty rec.headAuditStatusId}">
									<img class="complyWith" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="complyWith" <c:if test="${'达标' eq formDataMap['complyWith']}">checked</c:if> value="达标"/> --%>
									<c:if test="${'达标' eq formDataMap['complyWith']}">
									<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
									</c:if>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '达标' eq formDataMap['complyWith']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="complyWith" value="${formDataMap['complyWith']}"/> --%>
								</c:if>
								</td>
							<td onclick="showImg(this,'complyWith','尚可');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
									<c:if test="${empty rec.headAuditStatusId }">
										<img class="complyWith" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
									</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="complyWith" <c:if test="${'尚可' eq formDataMap['complyWith']}">checked</c:if> value="尚可"/> --%>
									<c:if test="${ '尚可' eq formDataMap['complyWith']}">
										<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
									</c:if>	
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '尚可' eq formDataMap['complyWith']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="complyWith" value="${formDataMap['complyWith']}"/> --%>
								</c:if>
								</td>
							<td onclick="showImg(this,'complyWith','欠缺');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
								<c:if test="${empty rec.headAuditStatusId}">
									<img class="complyWith" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="complyWith" <c:if test="${'欠缺' eq formDataMap['complyWith']}">checked</c:if> value="欠缺"/> --%>
									<c:if test="${'欠缺' eq formDataMap['complyWith']}">
									<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
								</c:if>
								</c:if>	
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '欠缺' eq formDataMap['complyWith']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="complyWith" value="${formDataMap['complyWith']}"/> --%>
								</c:if>
								</td>
						</tr>
						<tr>
							<td>考核等级</td>
							<td>优秀</td>
							<td>良好</td>
							<td>合格</td>
							<td>基本合格</td>
							<td>不合格</td>
						</tr>
						<tr>
							<td>
								<input type="hidden" class="LevelHid" name="Level" value="${formDataMap['Level'] }"/>
							</td>
							<td onclick="showImg(this,'Level','欠缺');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
								<c:if test="${empty rec.headAuditStatusId}">
									<img class="Level" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="Level" <c:if test="${'优秀' eq formDataMap['Level']}">checked</c:if> value="优秀"/> --%>
									<c:if test="${'欠缺' eq formDataMap['Level']}">
									<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
								</c:if>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '欠缺' eq formDataMap['Level']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="Level" value="${formDataMap['Level']}"/> --%>
								</c:if>
								</td>
							<td onclick="showImg(this,'Level','良好');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
								<c:if test="${empty rec.headAuditStatusId }">
									<img class="Level" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="Level" <c:if test="${'良好' eq formDataMap['Level']}">checked</c:if> value="良好"/> --%>
									<c:if test="${ '良好' eq formDataMap['Level']}">
										<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
									</c:if>
								</c:if>	
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '良好' eq formDataMap['Level']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="Level" value="${formDataMap['Level']}"/> --%>
								</c:if>
								</td>
							<td onclick="showImg(this,'Level','合格');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
								<c:if test="${empty rec.headAuditStatusId}">
									<img class="Level" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="Level" <c:if test="${'合格' eq formDataMap['Level']}">checked</c:if> value="合格"/> --%>
									<c:if test="${'合格' eq formDataMap['Level']}">
									<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
								</c:if>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '合格' eq formDataMap['Level']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="Level" value="${formDataMap['Level']}"/> --%>
								</c:if>
								</td>
							<td onclick="showImg(this,'Level','基本合格');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
								<c:if test="${empty rec.headAuditStatusId}">
								<img class="Level" style="display: none;" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="Level" <c:if test="${'基本合格' eq formDataMap['Level']}">checked</c:if> value="基本合格"/> --%>
									<c:if test="${'基本合格' eq formDataMap['Level']}">
									<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
								</c:if>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '基本合格' eq formDataMap['Level']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="Level" value="${formDataMap['Level']}"/> --%>
								</c:if>
							</td>
							<td onclick="showImg(this,'Level','不合格');">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
								<c:if test="${empty rec.headAuditStatusId}">
									<img class="Level" style="display: none;"  src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
<%-- 									<input type="hidden" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} ctrlInput" name="Level" <c:if test="${'不合格' eq formDataMap['Level']}">checked</c:if> value="不合格"/> --%>
									<c:if test="${'不合格' eq formDataMap['Level']}">
									<label style="display: none;" class="toggleView2"><img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/></label>
								</c:if>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD && '不合格' eq formDataMap['Level']}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
<%-- 									<input type="hidden" name="Level" value="${formDataMap['Level']}"/> --%>
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="7">
								<div style="margin-bottom: 2px;">
									<div style="width: 200px;float: right;">
										签名时间：
										<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
											<input type="text" class="toggleView2 inputText validate[required] ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="departmentHeadDate" value="${empty formDataMap['departmentHeadDate']?pdfn:getCurrDate():formDataMap['departmentHeadDate']}" style="width: 100px;text-align: left;" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
											<label style="display: none;" class="toggleView2">${formDataMap['departmentHeadDate']}</label>
										</c:if>
										<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD }">
											<label>${formDataMap['departmentHeadDate']}</label>
											<input type="hidden" name="departmentHeadDate" value="${formDataMap['departmentHeadDate']}"/>
										</c:if>
									</div>
									<div style="width: 250px;float: right;">
										科室负责人签名：
										<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
											<input type="text" class="toggleView2 validate[required] inputText" name="departmentHead" value="${empty formDataMap['departmentHead']?sessionScope.currUser.userName:formDataMap['departmentHead']}" style="width: 100px;text-align: left;"/>
											<label style="display: none;" class="toggleView2">${formDataMap['departmentHead']}</label>
										</c:if>
										<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD }">
											<label>${formDataMap['departmentHead']}</label>
											<input type="hidden" name="departmentHead" value="${formDataMap['departmentHead']}"/>
										</c:if>		
									</div>
								</div>
							</td>
						</tr>
						</table>
						</c:if>
						<table class="basic formBasic" style="width: 100%;margin-top: 10px;">
						<c:if test="${!empty rec.headAuditStatusId}">
						<tr>
							<td style="width: 99px;">被考核人意见</td>
							<td colspan="6">
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR && empty rec.adminAuditStatusId}">
									<textarea class="toggleView3" placeholder="请填写" style="width: 100%; height:100px; border: none;" name="OpinionExamination">${formDataMap['OpinionExamination']}</textarea>
									<div style="display: none;text-align: left; height: 100px;padding-left: 10px;" class="toggleView3">${formDataMap['OpinionExamination']}</div>
								</c:if>
								<c:if test="${!(param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR && empty rec.adminAuditStatusId)}">
									<div style="width: 100%;height: 100px;text-align: left;padding-left: 10px;">${formDataMap['OpinionExamination']}</div>
									<input type="hidden" name="OpinionExamination" value="${formDataMap['OpinionExamination']}"/>
								</c:if>
								<div style="margin-bottom: 2px;">
									<div style="width: 200px;float: right;">
										签名时间：
										<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR && empty rec.adminAuditStatusId}">
											<input type="text" class="toggleView3 inputText" name="personDate" value="${empty formDataMap['personDate']?pdfn:getCurrDate():formDataMap['personDate']}"  style="width: 100px;text-align: left;" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
											<label style="display: none;" class="toggleView3">${formDataMap['personDate']}&#12288;</label>
										</c:if>
										<c:if test="${!(param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR && empty rec.adminAuditStatusId)}">
											<label>${formDataMap['personDate']}</label>
										</c:if>
									</div>
								<div style="width: 250px;float: right;">
								&#12288;被考核人签名：
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR && empty rec.adminAuditStatusId}">
									<input type="text" class="toggleView3 inputText"  style="width: 100px;text-align: left;" name="personExam" value="${empty formDataMap['personExam']?sessionScope.currUser.userName:formDataMap['personExam']}"/>
									<c:if test="${!empty formDataMap['personExam']}">
										<label style="display: none;width: 100px;" class="toggleView3 textInput">${formDataMap['personExam']}</label>
									</c:if>
								</c:if>
								<c:if test="${!(param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR && empty rec.adminAuditStatusId)}">
									<label>${formDataMap['personExam']}</label>
									<input type="hidden" name="personExam" value="${formDataMap['personExam']}"/>
								</c:if>
								</div>
							</div>
						</td>
						</tr>
						</c:if>
						
						<c:if test="${!empty rec.adminAuditStatusId || param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_ADMIN}">
							<tr>
								<td style="height: 50px;">院内复核意见</td>
								<td colspan="6">
									<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_ADMIN && empty rec.adminAuditStatusId}">
									<div>
										<textarea class="toggleView3" placeholder="请填写" style="width: 100%; height:100px; border: none;" name="orderReviewComments">${formDataMap['orderReviewComments']}</textarea>
									</div>
									<div>
										<div style="display: none; text-align: left;height: 100px;padding-left: 10px;" class="toggleView3">
											${formDataMap['orderReviewComments']}
										</div>
									</div>
										<br>
									</c:if>
									<c:if test="${!(param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_ADMIN && empty rec.adminAuditStatusId)}">
										<div style="width: 100%; height: 100px;padding-left: 10px;text-align: left;">${formDataMap['orderReviewComments']}</div>
										<input type="hidden" name="orderReviewComments" value="${formDataMap['orderReviewComments']}"/>
									</c:if>
								<div style="margin-bottom: 2px;">
								<div style="width: 200px;float: right;">
								签名时间：
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_ADMIN && empty rec.adminAuditStatusId}">
									<input type="text" class="toggleView3 inputText" name="orderReviewDate" value="${empty formDataMap['orderReviewDate']?pdfn:getCurrDate():formDataMap['orderReviewDate']}"  style="width: 100px;text-align: left;" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
									<label style="display: none;" class="toggleView3">${formDataMap['orderReviewDate']}&#12288;</label>
								</c:if>
								<c:if test="${!(param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_ADMIN && empty rec.adminAuditStatusId)}">
									<label>${formDataMap['orderReviewDate']}</label>
								</c:if>
							</div>
							</div>
							</tr>
							<tr>
								<td style="height: 50px;">备注</td>
								<td colspan="6">
									<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_ADMIN && empty rec.adminAuditStatusId}">
										<textarea class="toggleView3" placeholder="请填写" style="width: 100%; height:100px; border: none;" name="remarks">${formDataMap['remarks']}</textarea>
										<div style="display: none;text-align: left; height: 100px;text-align: left;padding-left: 10px;" class="toggleView3">${formDataMap['remarks']}</div>
									</c:if>
									<c:if test="${!(param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_ADMIN && empty rec.adminAuditStatusId)}">
										<div style="width: 100%;height: 100px;text-align: left;padding-left: 10px;">${formDataMap['remarks']}</div>
										<input type="hidden" name="remarks" value="${formDataMap['remarks']}"/>
									</c:if>
							</tr>
						</c:if>
					</table>
					
					</form>
					<div align="center" style="margin-top: 10px;">
<%-- 					<c:if test="${(empty formDataMap['mySignature'] || (!empty formDataMap['departmentHead'] && empty formDataMap['personExam'])) && param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">  --%>
						<input type="button" class="search" onclick="printRegistryCheck();" value="打&#12288;印">
						<c:if test="${(empty rec.headAuditStatusId || (!empty rec.headAuditStatusId && empty rec.adminAuditStatusId)) && param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
							<input type="button" class="search" onclick="saveForm();" value="保&#12288;存">
						</c:if>
						<c:if test="${(empty rec.headAuditStatusId && param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD) || (empty rec.adminAuditStatusId && param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_ADMIN)}">
							<input type="button" class="search" onclick="save();" value="提&#12288;交">
						</c:if>
<%-- 						<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR  &&  empty formDataMap['personExam']}"> --%>
<!-- 							<input type="button" class="search" onclick="save();" value="保&#12288;存"> -->
<%-- 						</c:if> --%>
						<input type="button" class="search" onclick="jboxClose();" value="关&#12288;闭">
					</div>
				</div>
			</div>
		</div>
		</div>
</body>
</html>