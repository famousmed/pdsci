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
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
function editProduct(contractFlow,workFlow,contactFlow) {
	jboxOpen("<s:url value='/erp/crm/editProduct'/>?contractFlow="+contractFlow+"&type=implement&workFlow="+workFlow+"&contactFlow="+contactFlow,"编辑产品安装地点及版本", 800, 500);
}
function save(){
	if(false == $("#workOrderForm").validationEngine("validate")){
		return false;
	}
	var Trs = $(".customerUserTr");
	var datas = [];
	$.each(Trs, function(index, domEle){
		var userFlow = $(domEle).find("input[name='userFlow']").val();
		if(userFlow != ""){
			var userName = $(domEle).find("input[name='userName']").val();
			var deptName = $(domEle).find("input[name='deptName']").val();
			var postName = $(domEle).find("input[name='postName']").val();
			var userTelphone = $(domEle).find("input[name='userTelphone']").val();
			var userCelphone = $(domEle).find("input[name='userCelphone']").val();
			var data = {
				"userFlow":userFlow,
				"userName":userName,	
				"deptName":deptName, 
				"postName":postName, 
				"userTelphone":userTelphone,	
				"userCelphone":userCelphone	
			};
			datas.push(data);
		}
	});
	var requestData = {
		"workFlow":$("#workFlow").val(),
		"contactFlow":"${contactOrder.contactFlow}",
		"assignDate":$("input[name='assignDate']").val(),
		"assignDeptName":$("select[name='assignDeptFlow'] option:selected").text(),
		"assignDeptFlow":$("select[name='assignDeptFlow'] option:selected").val(),
		"assignUserFlow":$("#workOrderForm").find("select[name='assignUserFlow'] option:selected").val(),
		"assignUserName":$("#workOrderForm").find("select[name='assignUserFlow'] option:selected").text(),
		"customerUserList":datas,
		"requireCompleteDate":$("#requireCompleteDate").text(), 
		"contactGenerateDate":$("#contactGenerateDate").text(), 
		"salesAdvice":$("#salesAdvice").text().trim(), 
		"dealTypeId":$("input[name='dealTypeId']:checked").val(),
		"taskState":$("#taskState").val()
	};
	$("#saveButton").attr("disabled",true);
	var url = "<s:url value='/erp/implement/saveWorkOrder'/>";
	jboxPostJson(
			url, 
			JSON.stringify(requestData),
			//requestData,
			function(resp){
				if("${GlobalConstant.SAVE_FAIL}" != resp){
					jboxTip("${GlobalConstant.SAVE_SUCCESSED}");
					window.parent.frames['mainIframe'].window.slideDown("${contactOrder.contactFlow}");
					$("#workFlow").val(resp);
					$("#saveButton").removeAttr("disabled");
					setTimeout(function(){
						jboxCloseMessager();
					},1000);
				}
			}, null, false);
}

function crossImplementing(workFlow){
	if(false == $("#workOrderForm").validationEngine("validate")){
		return false;
	}
	jboxConfirm("确认派工? 派工后派工单将不可修改！",  function(){
		var url = "<s:url value='/erp/implement/crossImplementing'/>";
		jboxPost(url, $("#workOrderForm").serialize(), function(resp){
			if("${GlobalConstant.OPRE_SUCCESSED}" == resp){
				window.parent.frames['mainIframe'].window.search();//审核派工
				setTimeout(function(){
					jboxCloseMessager();
				},1000);
			}
		}, null, true);
	});
}

$(document).ready(function(){
	//查询客户联系人
	customerUsers("${contactOrder.customerFlow}");				
	changeAssignUser();
	loadProduct('${param.workFlow}','${param.contactFlow}');
});

function loadProduct(workFlow,contactFlow){
	var url="<s:url value='/erp/implement/workOrderProduct'/>?contactFlow=" + contactFlow+"&workFlow="+workFlow;
	jboxLoad("productDiv", url, false);
}

var customerUserHash = new Array();
function customerUsers(customerFlow) {
	var url = "<s:url value='/erp/crm/searchCustomerUserJson'/>?customerFlow="+customerFlow;
	jboxPost(url, null, function(data){
		if(data!=null){
			for (var i = 0; i < data.length; i++) {
				if("${customerUser.userFlow}" != data[i].userFlow){
					customerUserHash[data[i].userFlow] = data[i];
				}
			}
		}
	},null,false);
}

function customerUserRelative(obj) {
	var userFlow = $(obj).val();
	if(userFlow != ''){
		var user = customerUserHash[userFlow];
		$(obj).closest("tr").find("input[name='userFlow']").val(user.userFlow);
		$(obj).closest("tr").find("input[name='userName']").val(user.userName);
		$(obj).closest("tr").find("input[name='deptName']").val(user.deptName);
		$(obj).closest("tr").find("td:eq(1)").text(user.deptName==null?"":user.deptName);
		$(obj).closest("tr").find("input[name='postName']").val(user.postName);
		$(obj).closest("tr").find("td:eq(2)").text(user.postName==null?"":user.postName);
		$(obj).closest("tr").find("input[name='userTelphone']").val(user.userTelphone);
		$(obj).closest("tr").find("td:eq(3)").text(user.userTelphone==null?"":user.userTelphone);
		$(obj).closest("tr").find("input[name='userCelphone']").val(user.userCelphone);
		$(obj).closest("tr").find("td:eq(4)").text(user.userCelphone==null?"":user.userCelphone);
	}else{
		$(obj).closest("tr").find("input[name='userFlow']").val("");
		$(obj).closest("tr").find("input[name='userName']").val("");
		$(obj).closest("tr").find("input[name='deptName']").val("");
		$(obj).closest("tr").find("td:eq(1)").text("");
		$(obj).closest("tr").find("input[name='postName']").val("");
		$(obj).closest("tr").find("td:eq(2)").text("");
		$(obj).closest("tr").find("input[name='userTelphone']").val("");
		$(obj).closest("tr").find("td:eq(3)").text("");
		$(obj).closest("tr").find("input[name='userCelphone']").val("");
		$(obj).closest("tr").find("td:eq(4)").text("");
	}
}

function selectSingle(obj) {
	var value = $(obj).val();
	var name = $(obj).attr("name");
	$("input[name="+name+"][value!="+value+"]:checked").attr("checked",false);
}

function changeAssignUser(){
	var thisDept = $("[name='thisDept']:checked").val();
	if(thisDept == "${GlobalConstant.FLAG_N}") {
		getDept();
		
	}else{
		$("#assignUserTd").html($("#assignUserListClone").html());
	}
}

function getDept(){
	var url = "<s:url value='/erp/implement/getDept'/>?orgFlow=${sessionScope.currUser.orgFlow}";
	jboxGet(url, null, function(data){
		if(data!=null){
			var content = '<select name="assignDeptFlow" class="inputText validate[required]">'+
			'<option value="">请选择</option>';
			for (var i = 0; i < data.length; i++) {
				//过滤本部门
				if("${sessionScope.currUser.deptFlow}" != data[i].deptFlow){
					var selected = "";
					if ("${workOrder.assignDeptFlow}"==data[i].deptFlow) {
						selected = "selected";
					}
					content += '<option value="'+data[i].deptFlow+'"'+selected+'>'+data[i].deptName+'</option>';
				}
			}
			content += '</select><span id="deptUserSpan"></span>';
			$("#assignUserTd").html(content);
			//非本部门用户（编辑）
			/* if("${param.type}" == "edit"){
				deptUserRelative("${workOrder.assignDeptFlow}");
			} */
		}
	},null,false);
}

function deptUserRelative(deptFlow){
	if (deptFlow != "") {
		var url = "<s:url value='/erp/implement/getDeptUsers'/>?deptFlow="+deptFlow;
		jboxGet(url,null,function(data){
			if(data!=null){
				var content = '&#12288;<select name="assignUserFlow" class="assignUserFlow inputText validate[required]">'+
				'<option value="">请选择</option>';
				for (var i = 0; i < data.length; i++) {
					var selected = "";
					if ("${workOrder.assignUserFlow}"==data[i].userFlow) {
						selected = "selected"
					}
					content += '<option value="'+data[i].userFlow+'" '+selected+'>'+data[i].userName+'</option>';
				}
				content += '</select>';
				$("#deptUserSpan").html(content);
			}
		},null,false);
	}else{
		$("#deptUserSpan").html("");
	}
}

function completeWorkOrder(){
	if(false == $("#workOrderForm").validationEngine("validate")){
		return false;
	}
	jboxConfirm("确认完成?" ,  function(){
		var content = $("#specificContent").val().trim();
		var arriveDate = $("input[name='arriveDate']").val();
		var completeDate = $("input[name='completeDate']").val();
		var isCompleted = $("input[name='isCompleted']:checked").val();
		var data = {
			workFlow : "${workOrder.workFlow}",
			content : content,
			arriveDate : arriveDate,
			completeDate : completeDate,
			isCompleted : isCompleted
		};
		var url = "<s:url value='/erp/implement/completeWorkOrder'/>";
		jboxPost(url, data, function(resp){
			if("${GlobalConstant.OPRE_SUCCESSED}" == resp){
				window.parent.frames['mainIframe'].window.search();
				jboxClose();
			}
		}, null, true);
	});
}

function implementedAudit(workStatusId){
	if(false == $("#workOrderForm").validationEngine("validate")){
		return false;
	}
	var prompt = "确认审核通过?";
	if("${workOrderStatusEnumCompleteUnPassed.id}" == workStatusId){
		prompt = "确认审核不通过?意见或建议内容将不保存";
	}
	jboxConfirm(prompt,  function(){
		var isSatisfied = $("input[name='isSatisfied']:checked").val();
		var advice = $("input[name='advice']").val();
		var signUser = $("input[name='signUser']").val();
		var signDate = $("input[name='signDate']").val();
		var adviceRecorderUserFlow = $("input[name='adviceRecorderUserFlow']").val();
		var adviceRecorder = $("#adviceRecorder").text();
		var auditContent= $("#auditContent").val();
		var data = {
			workFlow : "${workOrder.workFlow}",
			isSatisfied : isSatisfied,
			advice : advice,
			signUser : signUser,
			signDate : signDate,
			adviceRecorderUserFlow : adviceRecorderUserFlow,
			adviceRecorder : adviceRecorder,
			workStatusId : workStatusId,
			auditContent : auditContent,
		};
		var url = "<s:url value='/erp/implement/implementedAudit'/>";
		jboxPost(url, data, function(resp){
			if("${GlobalConstant.OPRE_SUCCESSED}" == resp){
				if('${sessionScope[GlobalConstant.TYPE_SCOPE]}'!='${GlobalConstant.ASSISTANT_AUDIT}'){
					window.parent.frames['mainIframe'].window.slideDown("${contactOrder.contactFlow}");
				}else{
					window.parent.frames['mainIframe'].window.search();
				}
				jboxCloseMessager();
			}
		}, null, true);
	});
}

function managerAudit(flag){
		var departmentManagerUserFlow = $("input[name='departmentManagerUserFlow']").val();
		var departmentManager = $("#departmentManager").text();
		var departmentManagerSignDate = $("input[name='departmentManagerSignDate']").val();
		var departmentManagerAuditContent=$("#departmentManagerAuditContent").val();
		var data = {
			workFlow : "${workOrder.workFlow}",
			departmentManagerUserFlow : departmentManagerUserFlow,
			departmentManager : departmentManager,
			departmentManagerSignDate : departmentManagerSignDate,
			departmentManagerAuditContent:departmentManagerAuditContent
		};
		var url = "<s:url value='/erp/implement/managerAudit'/>?flag="+flag;
		jboxPost(url, data, function(resp){
			if("${GlobalConstant.OPRE_SUCCESSED}" == resp){
				window.parent.frames['mainIframe'].window.search();
				jboxCloseMessager();
			}
		}, null, true);
}

function saveVisit(){
	if(false == $("#workOrderForm").validationEngine("validate")){
		return false;
	}
	jboxConfirm("确认完成客户回访? 完成后派工单将关闭！",  function(){
		var customerLinkman = $("input[name='customerLinkman']").val();
		var visitDate = $("input[name='visitDate']").val();
		var isSolved = $("input[name='isSolved']:checked").val();
		var visitContent = $("#visitContent").val().trim();
		var visitor = $("input[name='visitor']").val();
		var contactFlow = "${contactOrder.customerFlow}"; 
		var data = {
			workFlow : "${workOrder.workFlow}",
			customerLinkman : customerLinkman,
			visitDate : visitDate,
			isSolved : isSolved,
			visitContent : visitContent,
			visitor : visitor,
			contactFlow : contactFlow
		};
		var url = "<s:url value='/erp/implement/saveVisit'/>";
		jboxPost(url, data, function(resp){
			if("${GlobalConstant.OPRE_SUCCESSED}" == resp){
				window.parent.frames['mainIframe'].window.slideDown("${contactOrder.contactFlow}");
				jboxCloseMessager();
			}
		}, null, true);
	});
}

function audit(){
	if(false == $("#workOrderForm").validationEngine("validate")){
		return false;
	}
	jboxOpenContent2($("#open").html(),'提示',300,100);
}

function doClose(){
	var openDialog = dialog.get('openDialog');
	if(openDialog!=null&&openDialog.open){
		openDialog.close().remove();
	}
}

function printRec(workFlow){
	jboxStartLoading();
	url = "<s:url value='/erp/implement/printInfo'/>?workFlow="+workFlow;
	window.location.href=url;
	setTimeout(function(){
		jboxEndLoading();
	},3000);
}

function applyTargetAudit(workFlow){
	jboxConfirm("确认审核通过? 派工单将移交至"+'${workOrder.assignDeptName}'+'审核！',  function(){
		var url = "<s:url value='/erp/implement/applyTargetAudit'/>";
		jboxPost(url, $("#workOrderForm").serialize(), function(resp){
			if("${GlobalConstant.OPRE_SUCCESSED}" == resp){
				window.parent.frames['mainIframe'].window.search();//审核派工
				setTimeout(function(){
					jboxCloseMessager();
				},1000);
			}
		}, null, true);
	});
}
function applyTargetUnPassed(workFlow){
	jboxConfirm("确认审核不通过? 派工单将打回至"+'${contactOrder.receiveDeptName}'+'修改！',  function(){
		var url = "<s:url value='/erp/implement/applyTargetUnPassed'/>";
		jboxPost(url, $("#workOrderForm").serialize(), function(resp){
			if("${GlobalConstant.OPRE_SUCCESSED}" == resp){
				window.parent.frames['mainIframe'].window.search();//审核派工
				setTimeout(function(){
					jboxCloseMessager();
				},1000);
			}
		}, null, true);
	});
}

function customerInfo(customerFlow,customerName){
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/crm/customerInfo'/>?customerFlow=" + customerFlow+"&type=open&no=third";
	jboxOpen(url,customerName, w, h); 
}
function auditOpinion(workFlow){
	var url="<s:url value='/erp/implement/workOrderAuditOpinion'/>?workFlow="+workFlow;
	jboxOpen(url,"审核记录", 700, 400);
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content" id="disabledDiv">
			<div class="title1 clearfix">
				<form id="workOrderForm" style="position: relative;" >
					<input type="hidden" name="workFlow" id="workFlow" value="${workOrder.workFlow}"/>
					<table width="100%" cellpadding="0" cellspacing="0" style="border: 0; line-height: 25px; font-weight: bold;">
						<colgroup>
							<col width="60%" />
							<col width="40%" />
						</colgroup>
						<tr>
							<td><c:if test="${not empty workOrder.workNo}">派工单号：<span id="workNo">${workOrder.workNo }</span></c:if></td>
							<td>
								<c:if test="${not empty workOrder.workFlow and workOrder.workStatusId eq workOrderStatusEnumImplementing.id}">
									<img class="img_print" title="打印" style="cursor: pointer; float: right;" src="<s:url value='/css/skin/${skinPath}/images/printZhengshi.png'/>" onclick="printRec('${workOrder.workFlow}');"/>
								</c:if>
							</td>
						</tr>
						<tr>
							<td>联系单号：${contactOrder.contactNo}</td>
							<td style="text-align: right;">日期： 
								<c:if test="${param.type == 'add' || param.type == 'edit'}">
									<input onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"
										class="ctime xltext validate[required]" name="assignDate" type="text"
										value="${param.type == 'add'?pdfn:getCurrDateTime('yyyy-MM-dd HH:mm'):workOrder.assignDate}"
										style="width: 150px; margin: 0px;" />
								</c:if> 
								<c:if test="${param.type != 'add' && param.type != 'edit'}">
									${workOrder.assignDate}
								</c:if>
							</td>
						</tr>
					</table>
					<table width="100%" cellpadding="0" cellspacing="0" class="basic" style="margin-top: 5px;">
						<colgroup>
							<col width="60%" />
							<col width="40%" />
						</colgroup>
						<tr>
							<th colspan="2" style="text-align: left; padding-left: 10px">客户资料</th>
						</tr>
						<tr>
							<td>客户名称：<span id="customerName"><a href="javascript:customerInfo('${contactOrder.customerFlow}','${contactOrder.customerName}')">${contactOrder.customerName}</a></span></td>
							<td>要求完成时间：
								<c:if test="${param.type == 'add'}">
									<span id="requireCompleteDate">${contactOrder.demandDate}</span>
								</c:if>
								<c:if test="${param.type != 'add'}">
									<span id="requireCompleteDate">${workOrderForm.requireCompleteDate}</span>
								</c:if>
							</td>
						</tr>
						<tr>
							<td>单位地址： <c:if test="${param.type=='add'}">
									<span id="customerAddress">${contactOrderForm.customerAddress}</span>
								</c:if> <c:if test="${param.type != 'add'}">
									<span id="customerAddress">${workOrderForm.customerAddress}</span>
								</c:if>
							</td>
							<td>联系单生成时间： <c:if test="${param.type=='add'}">
									<span id="contactGenerateDate">${contactGenerateDate}</span>
								</c:if> <c:if test="${param.type != 'add'}">
									<span id="contactGenerateDate">${workOrderForm.contactGenerateDate}</span>
								</c:if>
							</td>
						</tr>
						<tr>
							<th colspan="2" style="text-align: left; padding-left: 10px">最终使用方资料</th>
						</tr>
					    <tr>
					        <td>最终使用方：<span id="consumerName"><a href="javascript:customerInfo('${contactOrder.consumerFlow}','${contactOrder.consumerName}')">${contactOrder.consumerName}</a></span></td>
					        <td>单位地址： <c:if test="${param.type=='add'}">
									<span id="consumerAddress">${contactOrderForm.consumerAddress}</span>
								</c:if> <c:if test="${param.type != 'add'}">
									<span id="consumerAddress">${workOrderForm.consumerAddress}</span>
								</c:if>
							</td>
					    </tr>
					</table>
					<table cellpadding="0" cellspacing="0" class="xllist" style="width: 100%; border-top: 0px;">
						<colgroup>
							<col width="16%" />
							<col width="13%" />
							<col width="13%" />
							<col width="13%" />
							<col width="13%" />
							<col/>
						</colgroup>
						<tr>
							<th colspan="5" style="text-align: left; padding-left: 10px">联系人信息
							</th>
						</tr>
						<tr>
							<th>姓名</th>
							<th>部门</th>
							<th>职务</th>
							<th>固话</th>
							<th>手机</th>
						</tr>
						<tbody>
							<c:if test="${param.type=='add'}">
								<tr class="customerUserTr">
									<td>
										<label title="<c:if test="${not empty userCategoryMap[contactOrderForm.userFlow] or not empty userRefMap[contactOrderForm.userFlow]}">（${userCategoryMap[contactOrderForm.userFlow] }<c:if test="${userCategoryMap[contactOrderForm.userFlow] and not empty userRefMap[contactOrderForm.userFlow]}">${userRefMap[contactOrderForm.userFlow] }</c:if>）</c:if>">${contactOrderForm.userName}</label> 
										<input type="hidden" name="userFlow" value="${contactOrderForm.userFlow}"> 
										<input type="hidden" name="userName" value="${contactOrderForm.userName}">
									</td>
									<td>
										${contactOrderForm.deptName}<input type="hidden" value="${contactOrderForm.deptName}" name="deptName"/>
									</td>
									<td>
										${contactOrderForm.postName}<input type="hidden" value="${contactOrderForm.postName}" name="postName"/>
									</td>
									<td>
										${contactOrderForm.telPhone}<input type="hidden" value="${contactOrderForm.telPhone}" name="userTelphone"/>
									</td>
									<td>
										${contactOrderForm.celPhone}<input type="hidden" value="${contactOrderForm.celPhone}" name="userCelphone"/>
									</td>
								</tr>
								<tr class="customerUserTr">
									<td id="customerUserTd">
										<select class="inputText" onchange="customerUserRelative(this);">
											<option value="">请选择</option>
											<c:forEach var="user" items="${customerUserList}">
												<c:if test="${user.userFlow != contactOrderForm.userFlow}">
													<option value="${user.userFlow}" title="<c:if test="${not empty user.deptName }">${user.deptName }</c:if><c:if test="${not empty userCategoryMap[user.userFlow] or not empty userRefMap[user.userFlow]}">（${userCategoryMap[user.userFlow] }<c:if test="${userCategoryMap[user.userFlow] and not empty userRefMap[user.userFlow]}">${userRefMap[user.userFlow] }</c:if>）</c:if>">${user.userName}</option>
												</c:if>
											</c:forEach>
										</select>
										<input type="hidden" name="userFlow"> 
										<input type="hidden" name="userName"> 
										<input type="hidden" name="deptName"/>
										<input type="hidden" name="postName"/>
										<input type="hidden" name="userTelphone"/>
										<input type="hidden" name="userCelphone"/>
									</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</c:if>
							<c:if test="${param.type =='edit'}">
								<c:forEach items="${workOrderForm.customerUserList}" var="customerUser" varStatus="status">
									<tr class="customerUserTr">
										<td>
											<c:if test="${status.first}">
												<label title="<c:if test="${not empty userCategoryMap[customerUser.userFlow] or not empty userRefMap[customerUser.userFlow]}">（${userCategoryMap[customerUser.userFlow] }<c:if test="${userCategoryMap[customerUser.userFlow] and not empty userRefMap[customerUser.userFlow]}">${userRefMap[customerUser.userFlow] }</c:if>）</c:if>">${customerUser.userName}</label> 
											</c:if>
											<c:if test="${!status.first}">
												<select class="inputText" onchange="customerUserRelative(this);">
													<option value="">请选择</option>
													<c:forEach var="user" items="${customerUserList}">
														<c:if test="${user.userFlow != orderCustomerUser.userFlow}">
															<option value="${user.userFlow}" ${user.userFlow == customerUser.userFlow?'selected':''} title="<c:if test="${not empty user.deptName }">${user.deptName }</c:if><c:if test="${not empty userCategoryMap[user.userFlow] or not empty userRefMap[user.userFlow]}">（${userCategoryMap[user.userFlow] }<c:if test="${userCategoryMap[user.userFlow] and not empty userRefMap[user.userFlow]}">${userRefMap[user.userFlow] }</c:if>）</c:if>">${user.userName}</option>
														</c:if>
													</c:forEach>
												</select>
											</c:if>
											<input type="hidden" name="userFlow" value="${customerUser.userFlow}"> 
											<input type="hidden" name="userName" value="${customerUser.userName}">
											<input type="hidden" name="deptName" value="${customerUser.deptName}"/>
											<input type="hidden" name="postName" value="${customerUser.postName}"/>
											<input type="hidden" name="userTelphone" value="${customerUser.userTelphone}"/>
											<input type="hidden" name="userCelphone" value="${customerUser.userCelphone}"/>
										</td>
										<td>${customerUser.deptName}</td>
										<td>${customerUser.postName}</td>
										<td>${customerUser.userTelphone}</td>
										<td>${customerUser.userCelphone}</td>
									</tr>
								</c:forEach>
								<c:if test="${workOrderForm.customerUserList.size() < 2}">
								<tr class="customerUserTr">
									<td id="customerUserTd">
										<select class="inputText" onchange="customerUserRelative(this);">
											<option value="">请选择</option>
											<c:forEach var="user" items="${customerUserList }">
												<c:if test="${user.userFlow != customerUser.userFlow}">
													<option value="${user.userFlow}">${user.userName}</option>
												</c:if>
											</c:forEach>
										</select>
										<input type="hidden" name="userFlow"> 
										<input type="hidden" name="userName"> 
										<input type="hidden" name="deptName"/>
										<input type="hidden" name="postName"/>
										<input type="hidden" name="userTelphone"/>
										<input type="hidden" name="userCelphone"/>
									</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								</c:if>
							</c:if>
							<c:if test="${param.type != 'add' && param.type != 'edit'}">
								<c:forEach items="${workOrderForm.customerUserList}" var="customerUser">
									<tr class="customerUserTr">
										<td><label title="<c:if test="${not empty userCategoryMap[customerUser.userFlow] or not empty userRefMap[customerUser.userFlow]}">（${userCategoryMap[customerUser.userFlow] }<c:if test="${userCategoryMap[customerUser.userFlow] and not empty userRefMap[customerUser.userFlow]}">${userRefMap[customerUser.userFlow] }</c:if>）</c:if>">${customerUser.userName}</label></td>
										<td>${customerUser.deptName}</td>
										<td>${customerUser.postName}</td>
										<td>${customerUser.userTelphone}</td>
										<td>${customerUser.userCelphone}</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
					
					
					<table cellpadding="0" cellspacing="0" class="basic" style="width: 100%; border-top: 0px;">
						<colgroup>
							<col width="16%" />
							<col width="84%" />
						</colgroup>
						<tr>
							<th colspan="2" style="text-align: left; padding-left: 10px">工作任务</th>
						</tr>
						<tr>
							<td style="text-align: right; padding-right: 10px;">产品/项目名称：</td>
							<td>
							  <div id="productDiv">
							  </div>
							</td>
						</tr>
						<tr>
							<td style="text-align: right; padding-right: 10px;">备&#12288;&#12288;注：</td>
							<td>${contactOrder.remark}</td>
						</tr>
						<c:if test="${param.type=='add' || param.type=='edit'}">
						    <tr>
							  <td style="text-align: right; padding-right: 10px;">任务说明：</td>
							  <td><textarea placeholder="请输入任务说明" id="taskState"  name="taskState" class="xltxtarea">${workOrderForm.taskState}</textarea></td>
						    </tr> 
						</c:if>
						<c:if test="${param.type!='add' and param.type!='edit'}">
						    <tr>
							  <td style="text-align: right; padding-right: 10px;">任务说明：</td>
							  <td>${workOrderForm.taskState}</td>
						    </tr> 
						</c:if>
						<tr>
							<td style="text-align: right; padding-right: 10px;">服务类型：</td>
							<td>${contactOrder.serviceTypeName}</td>
						</tr>
						<tr>
							<td style="text-align: right; padding-right: 10px;">处理意见：</td>
							<td id="salesAdvice">
								${param.type == 'add'?contactOrderDisposeForm.result:workOrderForm.salesAdvice}
							</td>
						</tr>
						<tr>
							<td style="text-align: right; padding-right: 10px;">处理方式：</td>
							<td>
								<c:if test="${param.type=='add' || param.type=='edit'}">
									<c:forEach var="dealType" items="${dealTypeEnumList}">
										<input type="checkbox" id="dealType_${dealType.id }" name="dealTypeId" value="${dealType.id}" <c:if test="${(contactOrderDisposeForm.method eq dealType.id) or (workOrderForm.dealTypeId eq dealType.id)}">checked</c:if> onchange="selectSingle(this)"/><label for="dealType_${dealType.id }">&nbsp;${dealType.name}</label>&#12288;
									</c:forEach>
								</c:if>
								<c:if test="${param.type!='add' && param.type!='edit' }">
									<c:forEach var="dealType" items="${dealTypeEnumList}">
										<c:if test="${workOrderForm.dealTypeId eq dealType.id}">${dealType.name}</c:if>
									</c:forEach>
								</c:if>
							</td>
						</tr>
						<tr>
							<td style="text-align: right; padding-right: 10px;">是否本部门处理：</td>
							<td>
								<c:if test="${param.type == 'add' || param.type == 'edit'}">
									<input type="checkbox" id="td_${GlobalConstant.FLAG_Y }" name="thisDept" value="${GlobalConstant.FLAG_Y }" onchange="selectSingle(this);changeAssignUser();"
										<c:if test="${(workOrder.assignDeptFlow eq sessionScope.currUser.deptFlow) or (empty workOrder.assignDeptFlow)}">checked</c:if>><label for="td_${GlobalConstant.FLAG_Y }">&nbsp;是&#12288;</label>
									<input type="checkbox" id="td_${GlobalConstant.FLAG_N }" name="thisDept" value="${GlobalConstant.FLAG_N }" onchange="selectSingle(this);changeAssignUser();"
										<c:if test="${(workOrder.assignDeptFlow != sessionScope.currUser.deptFlow) and (not empty workOrder.assignDeptFlow)}">checked</c:if>><label for="td_${GlobalConstant.FLAG_N }">&nbsp;否</label>
								</c:if> 
								<c:if test="${param.type != 'add' && param.type != 'edit'}">
									<c:if test="${workOrder.assignDeptFlow == sessionScope.currUser.deptFlow}">是</c:if>
									<c:if test="${workOrder.assignDeptFlow != sessionScope.currUser.deptFlow}">否</c:if>
								</c:if>
								<c:if test="${fn:length(auditFormList)>0}">
								    &#12288;&#12288;[<a href="javascript:auditOpinion('${workOrder.workFlow}');">审核记录</a>]
								</c:if>
							</td>
						</tr>
						<c:if test="${workOrder.workStatusId == workOrderStatusEnumApplyAudit.id and param.type!='info'}">
						   <tr>
						      <td style="text-align: right; padding-right: 10px;"><font style="color: red">${contactOrder.receiveDeptName }&#12288;<br/>审核意见：</font></td>
						      <td>
						         <input type="text"  class="inputText validate[required]" name="auditContent" style="width: 100%; text-align: left;"/>
						      </td>
						   </tr>
						</c:if>
						<c:if test="${not empty applyAuditForm.auditContent and workOrder.workStatusId != workOrderStatusEnumApplyAudit.id}">
						   <tr>
						      <td style="text-align: right; padding-right: 10px;">${applyAuditForm.auditDeptName }&#12288;<br/>审核意见：</td>
						      <td>${applyAuditForm.auditContent }</td>
						   </tr>
						</c:if>
						<c:if test="${workOrder.workStatusId == workOrderStatusEnumApplyTargetAudit.id}">
						   <tr>
						      <td style="text-align: right; padding-right: 10px;"><font style="color: red">${workOrder.assignDeptName }&#12288;<br/>审核意见：</font></td>
						      <td>
						         <input type="text"  class="inputText validate[required]" name="auditContent" style="width: 100%; text-align: left;"/>
						      </td>
						   </tr>
						</c:if>
						<c:if test="${(not empty applyTargetAuditForm.auditContent or not empty implementingAuditForm.auditContent)  and workOrder.workStatusId != workOrderStatusEnumApplyAudit.id}">
						   <tr>
						      <td style="text-align: right; padding-right: 10px;">${applyTargetAuditForm.auditDeptName }&#12288;<br/>审核意见：</td>
						      <td>${applyTargetAuditForm.auditContent }</td>
						   </tr>
						</c:if>
						<tr>
							<td style="text-align: right; padding-right: 10px;">分配工程师：</td>
							<c:if test="${param.type == 'add' || param.type == 'edit'}">
								<td id="assignUserTd"></td>
							</c:if>
							<c:if test="${sessionScope[GlobalConstant.TYPE_SCOPE] eq GlobalConstant.APPLY_TARGET_AUDIT and param.type=='applyTargetAudit'}">
							    <td>
							       <select name="assignUserFlow" id="assignUserFlow" class="inputText validate[required]">
				                      <option value="">请选择</option>
				                      <c:forEach var="user" items="${userList}">
					                  <option value="${user.userFlow}"
						              <c:if test="${workOrder.assignUserFlow eq user.userFlow}">selected="selected"</c:if>>${user.userName}</option>
				                      </c:forEach>
		                           </select>
							    </td>
							</c:if>
							<c:if test="${param.type != 'add' && param.type != 'edit' && param.type != 'auditTargetAudit'}">
								<td><c:if test="${workOrder.assignDeptFlow != sessionScope.currUser.deptFlow}">${workOrder.assignDeptName}</c:if>${workOrder.assignUserName}</td>
							</c:if>
						</tr>
						</tbody>
					</table>
					
					<!-- 1.完成 -->
					<table cellpadding="0" cellspacing="0" class="basic" style="width: 100%; border-top: 0px;">
						<colgroup>
							<col width="16%" />
							<col width="34%" />
							<col width="16%" />
							<col width="34%" />
						</colgroup>
						<c:if test="${param.type=='engineerEdit'}">
						   <c:if test="${not empty completeAuditForm.auditContent }">
						    <tr>
						      <td style="text-align: right; padding-right: 10px;"><font color="red">审核意见：</font></td>
						      <td colspan="3"><font color="red">${completeAuditForm.auditContent }</font></td>
						    </tr>
						   </c:if>
						   <tr>
							<td style="text-align: right; padding-right: 10px;">是否完成：</td>
							<td  colspan="3">
								<input type="checkbox" name="isCompleted" id="isCompleted_${GlobalConstant.FLAG_Y}" value="${GlobalConstant.FLAG_Y}" class="validate[required]" onchange="selectSingle(this)" <c:if test="${(GlobalConstant.FLAG_Y == workOrderForm.isCompleted) or (empty workOrderForm.isCompleted)}">checked="checked"</c:if>/>&nbsp;<label for="isCompleted_${GlobalConstant.FLAG_Y}">是</label>&nbsp;&nbsp;
								<input type="checkbox" name="isCompleted" id="isCompleted_${GlobalConstant.FLAG_N}" value="${GlobalConstant.FLAG_N}" class="validate[required]" onchange="selectSingle(this)" <c:if test="${GlobalConstant.FLAG_N == workOrderForm.isCompleted}">checked="checked"</c:if>/>&nbsp;<label for="isCompleted_${GlobalConstant.FLAG_N}">否</label>
							</td>
							</tr>
							<tr>
								<td style="text-align: right; padding-right: 10px;">具体内容：</td>
								<td colspan="3">
									<textarea placeholder="请输入具体内容" id="specificContent" name="content" class="xltxtarea validate[required]">${workOrderForm.content}</textarea>
								</td>
							</tr>
							<tr>
								<td style="text-align: right; padding-right: 10px;">到达时间：</td>
								<td>
									<input onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" class="inputText validate[required]" name="arriveDate" style="width: 140px; text-align: left;"
									 	<c:if test="${not empty workOrderForm.arriveDate}">value="${workOrderForm.arriveDate}"</c:if>
									 readonly="readonly" class="inputText ctime" type="text" />
								</td>
								<td style="text-align: right; padding-right: 10px;">完成时间：</td>
								<td>
									<input onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" class="inputText validate[required]" name="completeDate" style="width: 140px; text-align: left;" 
									 	<c:if test="${not empty workOrderForm.completeDate}">value="${workOrderForm.completeDate}"</c:if>
									readonly="readonly" class="inputText ctime" type="text" />
								</td>
							</tr>
						</c:if>
						<c:if test="${pdfn:getVisibleByWorkStatusId(workOrderStatusEnumImplemented.id, workOrder.workStatusId)}">
						<c:if test="${param.type != 'engineerEdit'}">
							<td style="text-align: right; padding-right: 10px;">是否完成：</td>
							<td colspan="3">
								<c:if test="${GlobalConstant.FLAG_Y eq workOrderForm.isCompleted}">是</c:if>
								<c:if test="${GlobalConstant.FLAG_N eq workOrderForm.isCompleted}">否</c:if>
							</td>
							<tr>
								<td style="text-align: right; padding-right: 10px;">具体内容：</td>
								<td colspan="3">
									${workOrderForm.content}
								</td>
							</tr>
							<tr>
								<td style="text-align: right; padding-right: 10px;">到达时间：</td>
								<td>${workOrderForm.arriveDate}</td>
								<td style="text-align: right; padding-right: 10px;">完成时间：</td>
								<td>${workOrderForm.completeDate}</td>
							</tr>
							<c:if test="${not empty completeAuditForm.auditContent and param.type=='assistantAudit'}">
						    <tr>
						      <td style="text-align: right; padding-right: 10px;">审核意见：</td>
						      <td colspan="3">${completeAuditForm.auditContent }</td>
						    </tr>
						</c:if>
						</c:if>	
						</c:if>	
						
						<!-- 2.客户意见 -->
						<c:if test="${pdfn:getVisibleByWorkStatusId(workOrderStatusEnumImplemented.id, workOrder.workStatusId)}">
						<c:if test="${param.type=='assistantAudit'}">
							<tr>
								<th colspan="4" style="text-align: left; padding-left: 10px">客户意见</th>
							</tr>
							<tr>
								<td colspan="4">
									<font style="font-weight: bold;">您是否满意本次服务，欢迎提出宝贵意见和建议：</font>
									<br/>
									<c:forEach var="satisfaction" items="${satisfactionEnumList}">
										<input type="checkbox" id="sf_${satisfaction.id}" name="isSatisfied" 
											<c:if test="${dealTypeEnumRemote.id != workOrderForm.dealTypeId}">class="validate[required]"</c:if>
											value="${satisfaction.id}" onchange="selectSingle(this);">
										<label for="sf_${satisfaction.id}">&nbsp;${satisfaction.name}&#12288;</label>
									</c:forEach>
									<br/><font style="font-weight: bold;">意见或建议内容：</font><br/>
									<input type="text" name="advice" class="inputText" style="width: 740px; text-align: left;" />
									<br/>
									<span style="float: right; display: block; padding-right: 40px;">
										<font style="font-weight: bold;">客户签字：</font> 
										<input type="text" name="signUser" class="inputText" style="width: 130px; text-align: left;" />
										<br/> 
										<font style="font-weight: bold;">日&#12288;&#12288;期：</font> 
										<input onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="signDate" style="width: 130px; text-align: left;"
											 readonly="readonly" class="validate[custom[dateFormat]] inputText" type="text" />
										<br/>
									</span>
								</td>
							</tr>
							<tr>
								<th colspan="4" style="text-align: left; padding-left: 10px">公司审核</th>
							</tr>
							<tr>
							    <td style="text-align: right; padding-right: 10px;">审核意见：</td>
						        <td colspan="3">
						            <input type="text"  class="inputText validate[required]" id="auditContent" name="auditContent" style="width: 100%; text-align: left;"/>
                                </td>
							</tr>
							<tr>
								<td style="text-align: right; padding-right: 10px; line-height: 25px;">客户反馈信息<br/>记录人签字：</td>
								<c:if test="${param.type=='assistantAudit'}">
									<input type="hidden" name="adviceRecorderUserFlow" value="${sessionScope.currUser.userFlow}"/>
									<td colspan="3" id="adviceRecorder">${sessionScope.currUser.userName}</td>
								</c:if>
							</tr>
						</c:if>
						</c:if>
						<c:if test="${pdfn:getVisibleByWorkStatusId(workOrderStatusEnumCompletePassed.id, workOrder.workStatusId)}">
						<tr>
							<th colspan="4" style="text-align: left; padding-left: 10px">客户意见</th>
						</tr>
						<tr>
							<td colspan="4">	
								<font style="font-weight: bold;">您是否满意本次服务，欢迎提出宝贵意见和建议：</font>
								<br/>
								<c:forEach var="satisfaction" items="${satisfactionEnumList}">
									<c:if test="${workOrderForm.isSatisfied == satisfaction.id}">${satisfaction.name}</c:if>
								</c:forEach>
								<br/>
								<font style="font-weight: bold;">意见或建议内容：</font>
								<br/>${workOrderForm.advice}<br/>
								<span style="float: right; display: block; padding-right: 40px;">
									<font style="font-weight: bold;">客户签字：</font>${workOrderForm.signUser}<br />
									<font style="font-weight: bold;">日&#12288;&#12288;期：</font>${workOrderForm.signDate}<br />
								</span>
							</td>
						</tr>
						<tr>
							<th colspan="4" style="text-align: left; padding-left: 10px">公司审核</th>
						</tr>
						<c:if test="${not empty completeAuditForm.auditContent }">
						<tr>
						    <td style="text-align: right; padding-right: 10px;">审核意见：</td>
						    <td colspan="3">${completeAuditForm.auditContent }</td>
						</tr>
						</c:if>
						<tr>
							<td style="text-align: right; padding-right: 10px; line-height: 25px;">客户反馈信息<br/>记录人签字：</td>
							<td colspan="3">${workOrderForm.adviceRecorder}</td>
						</tr>
						</c:if>	
							
						<!-- 3.派工单完成审核 -->	
						<c:if test="${pdfn:getVisibleByWorkStatusId(workOrderStatusEnumCompletePassed.id, workOrder.workStatusId)}">
							<c:if test="${param.type=='managerAudit'}">
								<input type="hidden" name="departmentManagerUserFlow" value="${sessionScope.currUser.userFlow}"/>
								<tr>
								   <td style="text-align: right; padding-right: 10px;">部门经理意见：</td>
								   <td colspan="3">
								       <textarea class="validate[required]" id="departmentManagerAuditContent" name="departmentManagerAuditContent" style="width: 95%;"></textarea>
								   </td>
								</tr>
								<tr>
									<td style="text-align: right; padding-right: 10px;">部门经理签字：</td>
									<td id="departmentManager">${sessionScope.currUser.userName}</td>
									<td style="text-align: right; padding-right: 10px;">日&#12288;&#12288;期：</td>
									<td>
										<input onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="departmentManagerSignDate" style="width: 130px; text-align: left;" value="${pdfn:getCurrDate()}" readonly="readonly" class="validate[custom[dateFormat]] inputText" type="text" />
									</td>
								</tr>
							</c:if>
						</c:if>
						<c:if test="${pdfn:getVisibleByWorkStatusId(workOrderStatusEnumPassed.id, workOrder.workStatusId)}">
							<c:if test="${not empty workOrderForm.departmentManagerAuditContent }">
							   <tr>
							     <td style="text-align: right; padding-right: 10px;">部门经理意见：</td>
							     <td>${workOrderForm.departmentManagerAuditContent }</td>
							   </tr>
							</c:if>
							<tr>
								<td style="text-align: right; padding-right: 10px;">部门经理签字：</td>
								<td>${workOrderForm.departmentManager}</td>
								<td style="text-align: right; padding-right: 10px;">日&#12288;&#12288;期：</td>
								<td>${workOrderForm.departmentManagerSignDate}</td>
							</tr>
						</c:if>
							
						<!-- 4.客户回访	-->
						<%-- <c:if test="${pdfn:getVisibleByWorkStatusId(workOrderStatusEnumPassed.id, workOrder.workStatusId)}">
						<c:if test="${param.type=='visit'}">
							<tr>
								<th colspan="4" style="text-align: left; padding-left: 10px">客户回访</th>
							</tr>
							<tr>
								<td style="text-align: right; padding-right: 10px;">客户联系人：</td>
								<td>
									<input type="text" name="customerLinkman" class="inputText validate[required]" style="width: 130px; text-align: left;" />
								</td>
								<td style="text-align: right; padding-right: 10px;">回访日期：</td>
								<td>
									<input onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="visitDate" style="width: 130px; text-align: left;" value="${pdfn:getCurrDate() }" readonly="readonly" class="validate[custom[dateFormat]] inputText validate[required]" type="text" />
								</td>
							</tr>
							<tr>
								<td colspan="4" style="line-height: 25px;">
								<font style="font-weight: bold;">回访结果：</font> 
								<input type="checkbox" id="is_${GlobalConstant.FLAG_Y}" name="isSolved" class="validate[required]" value="${GlobalConstant.FLAG_Y }" onchange="selectSingle(this);" checked><label for="is_${GlobalConstant.FLAG_Y }">&nbsp;已解决问题&#12288;</label>
								<input type="checkbox" id="is_${GlobalConstant.FLAG_N}" name="isSolved" class="validate[required]" value="${GlobalConstant.FLAG_N }" onchange="selectSingle(this);"><label for="is_${GlobalConstant.FLAG_N }">&nbsp;未解决问题</label> <br/>
								<textarea id="visitContent" name="visitContent" placeholder="请输入回访内容" class="xltxtarea validate[required]"></textarea></td>
							</tr>
							<tr>
								<td style="text-align: right; padding-right: 10px;">回访人：</td>
								<td colspan="3">
									<input type="text" name="visitor" value="${sessionScope.currUser.userName}" class="inputText validate[required]" style="width: 130px; text-align: left;" />
								</td>
							</tr>
						</c:if>
						</c:if>
						<c:if test="${pdfn:getVisibleByWorkStatusId(workOrderStatusEnumClosed.id, workOrder.workStatusId)}">
							<tr>
								<th colspan="4" style="text-align: left; padding-left: 10px">客户回访</th>
							</tr>
							<tr>
								<td style="text-align: right; padding-right: 10px;">客户联系人：</td>
								<td>${workOrderForm.customerLinkman}</td>
								<td style="text-align: right; padding-right: 10px;">回访日期：</td>
								<td>${workOrderForm.visitDate}</td>
							</tr>
							<tr>
								<td colspan="4" style="line-height: 25px;">
									<font style="font-weight: bold;">回访结果：</font>
									<c:if test="${workOrderForm.isSolved == GlobalConstant.FLAG_Y}">已解决问题</c:if>
									<c:if test="${workOrderForm.isSolved == GlobalConstant.FLAG_N}">未解决问题</c:if>
									<br/>
									${workOrderForm.visitContent}
								</td>
							</tr>
							<tr>
								<td style="text-align: right; padding-right: 10px;">回访人：</td>
								<td colspan="3">${workOrderForm.visitor}</td>
							</tr>
						</c:if> --%>
		
					</table>
					<div class="button" style="width: 730px;">
						<c:if test="${param.type=='add' || param.type=='edit'}">
							<input class="search" type="button" id="saveButton" value="保&#12288;存" onclick="save();" />
						</c:if>
						<c:if test="${param.type=='applyAudit'}">
							<input class="search" type="button"  value="审核通过至接收部门审核" onclick="applyTargetAudit('${workOrder.workFlow}');"/>
						</c:if>
						<c:if test="${param.type=='applyTargetAudit'}">
							<input class="search" type="button"  value="派&#12288;工" onclick="crossImplementing('${workOrder.workFlow}');"/>
						    <input class="search" type="button" value="审核不通过" onclick="applyTargetUnPassed('${workOrder.workFlow}');" />
						</c:if>
						<c:if test="${param.type=='engineerEdit'}">
							<input class="search" type="button" value="完&#12288;成" onclick="completeWorkOrder();" />
						</c:if>
						<c:if test="${param.type=='assistantAudit'}">
							<input class="search" type="button" value="审核通过" onclick="implementedAudit('${workOrderStatusEnumCompletePassed.id}');" />
							<input class="search" type="button" value="审核不通过" onclick="implementedAudit('${workOrderStatusEnumCompleteUnPassed.id}');" />
						</c:if>
						<c:if test="${param.type=='managerAudit'}">
						   <c:if test="${completeFlag=='Y' }"><input class="search" type="button" value="审核通过" onclick="audit();" /></c:if>
						   <c:if test="${completeFlag!='Y' }"><input class="search" type="button" value="审核通过" onclick="managerAudit('N')" /></c:if>
						</c:if>
						<c:if test="${param.type=='visit'}">
							<input class="search" type="button" value="完&#12288;成" onclick="saveVisit();" />
						</c:if>
						<input class="search" type="button" value="关&#12288;闭" onclick="jboxCloseMessager();" />
					</div>
				</form>
			</div>
		</div>
	</div>
	<span id="assignUserListClone" style="display: none;"> 
		<select name="assignUserFlow" class="inputText validate[required]">
				<option value="">请选择</option>
				<c:forEach var="user" items="${userList}">
					<option value="${user.userFlow}"
						<c:if test="${workOrder.assignUserFlow eq user.userFlow}">selected="selected"</c:if>>${user.userName}</option>
				</c:forEach>
		</select>
	</span>
	<div id="open">
	           联系单是否完成？
	    <div class="button" style="margin-top: 30px;">
	       <input type="button" value="&#12288;是&#12288;" class="search" onclick="managerAudit('Y');"/>
	       <input type="button" value="&#12288;否&#12288;" class="search" onclick="managerAudit('N')"/>
	       <input type="button" value="关&#12288;闭" class="search" onclick="doClose();"/>
	    </div>
	</div>
</body>
</html>