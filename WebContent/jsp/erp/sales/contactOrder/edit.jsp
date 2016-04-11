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
	<jsp:param name="jquery_ui_combobox" value="true"/>
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
<script type="text/javascript" src="<s:url value='/js/j.suggest.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
var customerHash = new Array();
var contractHash = new Array();
var contactUserHash = new Array();
var contactProductHash = new Array();
$(document).ready(function(){
	var customerFlow='${contactOrder.customerFlow}';
	if(customerFlow!=""){
		fillContractHash(customerFlow,null);
		fillContactUserHash(customerFlow,null);
	}
	setUserName('applyUser');
	checkServiceType();
});

function checkServiceType(){
	var serviceTypes=$(".demandMatterCheck");
	$.each(serviceTypes,function(i,n){
		changeMainTainType($(n));
	});
}
function save() {
	if(!$("#implementForm").validationEngine("validate")){
		return false;
	}
	$("#consumerName").val($("#consumerNameTdText").val());
	$("#consumerAddress").val($("#consumerAddressTdText").val());
	var contractOrderData=$("#implementForm").serializeJson();
	var userFlow=$("#userFlow").val();
	var userName=$("#userName").val();
	var postName=$("#postName").val();
	var deptName=$("#deptName").val();
	var telPhone=$("#telPhone").val();
	var celPhone=$("#celPhone").val();
	var customerAddress=$("#customerAddress").val();
	var consumerAddress=$("#consumerAddress").val();
	var contractStatusId=$("#contractStatusId").val();
	var contactStatusName = $("input[name='contactStatusName']").val();
	var data={
		'contactOrder':contractOrderData,
		'userFlow':userFlow,
		'userName':userName,
		'postName':postName,
		'deptName':deptName,
		'telPhone':telPhone,
		'celPhone':celPhone,
		'customerAddress':customerAddress,
		'consumerAddress':consumerAddress,
		'contractStatusId':contractStatusId,
		'contactStatusName':contactStatusName
	};
	var url = "<s:url value='/erp/sales/saveContactOrder'/>";
	jboxPostJson(url,JSON.stringify(data),function(resp){
		if(resp!='${GlobalConstant.SAVE_FAIL}'){
			jboxTip('${GlobalConstant.SAVE_SUCCESSED}');
			window.parent.frames['mainIframe'].$("#checkContactFlow").val(resp);
			setTimeout(function(){
				window.parent.frames['mainIframe'].window.search();
				jboxCloseMessager();
			},1000);
		}else{
			jboxTip('${GlobalConstant.SAVE_FAIL}');
		}
	},null,false);
}

$(function(){
	/*查询客户*/
	loadCustomerList();
});
 

function loadCustomerList() {
	var customers = new Array();
	var url = "<s:url value='/erp/crm/searchCustomerJson'/>";
	jboxPost(url,null,function(data){
		if(data!=null){
			for (var i = 0; i < data.length; i++) {
				customerHash[data[i].customerFlow] = data[i];
				customers[i]=new Array(data[i].customerFlow,data[i].customerName,data[i].aliasName);
			}
		}
	},null,false);
	$("#searchParam_Customer").suggest(customers,{
		attachObject:'#suggest_Customer',
		dataContainer:'#result_Customer',
		triggerFunc:function(customerFlow){
			customerRelative(customerFlow);
		},
	    enterFunc:function(customerFlow){
	    	customerRelative(customerFlow);
	    }
	});
}
function blank(a){
	return a==null?"":a;
}



function fillContractHash(customerFlow,htmlContent){
	var url = "<s:url value='/erp/sales/searchContractJson'/>?customerFlow="+customerFlow;
	var content="";
	jboxPost(url,null,function(data){
		if(data!=null){
			content = '<select class="inputText" id="contractFlow" name="contractFlow" onchange="contractRelative(this.value);" style="width: 300px;">'+
			'<option value="">请选择</option>';
			for (var i = 0; i < data.length; i++) {
				contractHash[data[i].contractFlow] = data[i];
				content += '<option value="'+data[i].contractFlow+'">'+data[i].contractName+"     "+data[i].signDate+'</option>';
			}
			content += '</select>';
			content += '<span id="contractInfo" style="margin-left: 10px;"></span>';
			if(htmlContent!=null){
				htmlContent(content);
			}
		}
	},null,false);
}

function fillContactUserHash(customerFlow,htmlContent){
	var content="";
	var url="<s:url value='/erp/sales/searchCustomerUserJson'/>?customerFlow="+customerFlow;
	jboxPost(url,null,function(data){
		if(data!=null){
		    content = '<select class="inputText validate[required]"  onchange="contactUserRelative(this.value);">'+
			'<option value="">请选择</option>';
			for (var i = 0; i < data["customerUserList"].length; i++) {
				contactUserHash[data["customerUserList"][i].userFlow] = data["customerUserList"][i];
				content += '<option value="'+data["customerUserList"][i].userFlow+'" title="'+data["customerUserList"][i].deptName+'">'+data["customerUserList"][i].userName+'</option>';
			}
			content += '</select>';
			if(htmlContent!=null){
				htmlContent(content);
			}
		}
	},null,false);
}

function refreshFillContactUserHash(customerFlow,htmlContent){
	var contractFlow=$("#contractFlow").val();
	var url;
	if(contractFlow!=""){
		url = "<s:url value='/erp/sales/searchCustomerUserJson'/>?customerFlow="+customerFlow+"&contractFlow="+contractFlow;
	}else{
		url = "<s:url value='/erp/sales/searchCustomerUserJson'/>?customerFlow="+customerFlow;
	}
	var content="";
	jboxPost(url,null,function(data){
		if(data!=null){
		    content = '<select class="inputText validate[required]"  onchange="contactUserRelative(this.value);">'+
			'<option value="">请选择</option>';
			for (var i = 0; i < data["customerUserList"].length; i++) {
				contactUserHash[data["customerUserList"][i].userFlow] = data["customerUserList"][i];
					if(data["userCategoryMap"][data["customerUserList"][i].userFlow]){
						content += '<option value="'+data["customerUserList"][i].userFlow+'" title="'+data["customerUserList"][i].deptName+'('+data["userCategoryMap"][data["customerUserList"][i].userFlow]+')">'+data["customerUserList"][i].userName+'</option>';
					}
				    else{
					content += '<option value="'+data["customerUserList"][i].userFlow+'" title="'+data["customerUserList"][i].deptName+'">'+data["customerUserList"][i].userName+'</option>';
				    }
			}
			content += '</select>';
			if(htmlContent!=null){
				htmlContent(content);
			}
		}
	},null,false);
}
function customerRelative(customerFlow) {
	var customer = customerHash[customerFlow];
	//客户地址
	$("#customerAddressTd").html(blank(customer.customerProvName)+blank(customer.customerCityName)+blank(customer.customerAreaName)+blank(customer.customerAddress));
	$("#customerAddress").val(blank(customer.customerProvName)+blank(customer.customerCityName)+blank(customer.customerAreaName)+blank(customer.customerAddress));
	contractRelative('');
	contactUserRelative('');
	searchConsumerInfo(customerFlow);
	//合同号
	fillContractHash(customerFlow,function(resp){
		$("#contractNameTd").html(resp);
	});
	//联系人
	fillContactUserHash(customerFlow,function(resp){
		$("#contactUserTd").html(resp);
	});
}

function searchConsumerInfo(consumerFlow){
	var customer = customerHash[consumerFlow];
    var consumerNameTd=$("#consumerNameTd");
    var consumerAddressTd=$("#consumerAddressTd");
    consumerNameTd.text("");
	consumerAddressTd.text("");
    var consumerAddress=blank(customer.customerProvName)+blank(customer.customerCityName)+blank(customer.customerAreaName)+blank(customer.customerAddress);
    var consumerNameTdText='<input type="text" value="'+customer.customerName+'" id="consumerNameTdText" class="inputText" style="width:200px; text-align:left;"/>';
    var consumerAddressTdText='<input type="text" value="'+consumerAddress+'" id="consumerAddressTdText" class="inputText" style="width:400px; text-align:left;"/>';
    consumerNameTd.append(consumerNameTdText);
    consumerAddressTd.append(consumerAddressTdText);
    $("#consumerFlow").val(customer.customerFlow);
    $("#consumerName").val(customer.customerName);
    $("#consumerAliasName").val(customer.aliasName);
    $("#consumerAddress").val(blank(customer.customerProvName)+blank(customer.customerCityName)+blank(customer.customerAreaName)+blank(customer.customerAddress));
}

function contractRelative(contractFlow) {
	if (contractFlow != '') {
		//合同状态
		var contractStatusName = contractHash[contractFlow].contractStatusName;
		var contractStatusId = contractHash[contractFlow].contractStatusId;
		var contractName = contractHash[contractFlow].contractName;
		var productNameTd=$("#productNameTd");
		$("#contractStatusTd").html(contractStatusName);
		$("#contractStatusId").val(contractStatusId);
		$("#contractName").val(contractName);
		var a = $('<a></a>');
		$(a).attr("href","javascript:contractInfo('"+contractFlow+"');");
		$(a).text(">>");
		$("#contractInfo").html(a);
		var contractCategoryId=contractHash[contractFlow].contractCategoryId;
		if(contractCategoryId=='${contractCategoryEnumSell.id}'){
			var consumerFlow=contractHash[contractFlow].consumerFlow;
			searchConsumerInfo(consumerFlow);
		}else{
			var consumerFlow=contractHash[contractFlow].customerFlow;
			searchConsumerInfo(consumerFlow);
		}
		//产品名称、备注
		var url = "<s:url value='/erp/crm/searchContractProductJson'/>?contractFlow="+contractFlow;
		jboxPost(url,null,function(data){
			if(data!=null){
				var content = '';
				var productItem = '';
				var check='';
				if (data.length == 1) {
					validate = "disabled";
				} else {
					validate = 'class="validate[required]"';
				}
				if(data.length==1){
					check='checked';
				}
				else{
					check='';
					productNameTd.html('<span class="red">*</span>产品名称');
				}
				for (var i = 0; i < data.length; i++) {
					contactProductHash[data[i].productFlow] = data[i];
					var productId = data[i].productTypeId;
					if (productId == null) {
						productId = data[i].productTypeName;
					}
					content += '<input type="checkbox" id="product_'+productId+'"  name="productTypeId" value="'+productId+'" '+validate+' '+check+'/><label for="product_'+productId+'">&nbsp;'+data[i].productTypeName+'</label>&#12288;';
					if (data.length >1) {
						if (blank(data[i].productItem) != "") {
							productItem += data[i].productTypeName + "：" +blank(data[i].productItem)+"；";
						}
					} else {
						productItem += blank(data[i].productItem);
						content +='<input type="hidden" id="product_'+productId+'"  name="productTypeId" value="'+data[i].productTypeName+'"/>';
					}
				}
				$("#contractProductTd").html(content);
				$("#productItem").val(productItem);
			}
		},null,false);
		var customerFlow=$("#result_Customer").val();
		//联系人
		refreshFillContactUserHash(customerFlow,function(resp){
			$("#contactUserTd").html(resp);
		});
	} else {
		$("#contractProductTd").html($("#productSpan").html());
		$("#contractProductTd").append('<input type="checkbox" id="orderProject" onclick="appendInput(this);"><label for="orderProject"> 定制项目</label>  <span id="xmSpan"></span>');
		$("#productItem").val("");
		$("#contractStatusTd").html("");
		$("#contractStatusId").val("");
		$("#contractName").val("");
		$("#contractInfo").html("");
	}
}

function contactUserRelative(userFlow) {
	if (userFlow != '') {
		var user = contactUserHash[userFlow];
		$("#deptNameTd").html(user.deptName);
		$("#postNameTd").html(user.postName);
		$("#telPhoneTd").html(user.userTelphone);
		$("#celPhoneTd").html(user.userCelphone);
		$("#deptName").val(user.deptName);
		$("#postName").val(user.postName);
		$("#telPhone").val(user.userTelphone);
		$("#celPhone").val(user.userCelphone);
		$("#userFlow").val(user.userFlow);
		$("#userName").val(user.userName);
	} else {
		$("#deptNameTd").html("");
		$("#postNameTd").html("");
		$("#telPhoneTd").html("");
		$("#celPhoneTd").html("");
		$("#deptName").val("");
		$("#postName").val("");
		$("#telPhone").val("");
		$("#celPhone").val("");
		$("#userFlow").val("");
		$("#userName").val("");
	}
}

function selectSingle(obj) {
	var value = $(obj).val();
	var name = $(obj).attr("name");
	$("input[name="+name+"][value!="+value+"]:checked").attr("checked",false);
}

function resetCustomerName(name){
	 var customerFlow=$("#result_"+name).val();
	 var customerName=$("#searchParam_"+name);
	 if(customerFlow==""){
		 customerName.val("");
	 }
}
function resetCustomerFlow(name){
	 var customerFlow=$("#result_"+name);
	 customerFlow.val("");
}
function setUserName(id){
	 $("#"+id+"Name").val($("#"+id+"Flow").find("option:selected").text());
}
//重置客户名称
function resetCustomerName(){
	 var customerFlow=$("#result_Customer").val();
	 var customerName=$("#searchParam_Customer");
	 if(customerFlow==""){
		 customerName.val("");
	 }
}
//重置客户流水号
function resetCustomerFlow(){
	 var customerFlow=$("#result_Customer");
	 customerFlow.val("");
}
function contractInfo(contractFlow) {
	var mainIframe = window.parent.frames["mainIframe"];
	var width = mainIframe.document.body.scrollWidth;
	var url = "<s:url value='/erp/crm/contractInfo'/>?contractFlow="+contractFlow+"&status=main&type=open";
	jboxOpen(url, "合同详细信息", 1000, 600);
}

function appendInput(obj){
	if($(obj).attr("checked")=="checked"){
		$("#xmSpan").append($("#inputSpan").html());
	}else{
		$("#xmSpan").html("");
	}
    
}

function changeMainTainType(obj){
	var demandMatter=$(obj).val();
	var serviceTypeTd=$("#serviceTypeTd");
	if($(obj).attr("checked")=="checked"){
		$(serviceTypeTd).html($("#"+demandMatter+"DictEnum").clone());
	}
}
</script>
</head>
<body>
<div class="mainright">
<div class="content">
	<div class="title1 clearfix">
			<form id="contractOrderForm">
			<input type="hidden" id="userFlow" name="userFlow" value="${contactOrderForm.userFlow }"/>
			<input type="hidden" id="userName" name="userName" value="${contactOrderForm.userName }"/>
			<input type="hidden" id="postName" name="postName" value="${contactOrderForm.postName }"/>
			<input type="hidden" id="deptName" name="deptName" value="${contactOrderForm.deptName }"/>
			<input type="hidden" id="telPhone" name="telPhone" value="${contactOrderForm.telPhone }"/>
			<input type="hidden" id="celPhone" name="celPhone" value="${contactOrderForm.celPhone }"/>
			<input type="hidden" id="customerAddress" name="customerAddress" value="${contactOrderForm.customerAddress }"/>
			<input type="hidden" id="consumerAddress" name="consumerAddress" value="${contactOrderForm.consumerAddress }"/>
			<input type="hidden" id="contractStatusId" name="contractStatusId" value="${contactOrderForm.contractStatusId }"/>
			</form>
			<form id="implementForm" style="position: relative;">
			<input type="hidden" name="contactStatusName" value="${contactOrder.contactStatusName}"/>
			<input type="hidden" name="contactFlow" value="${contactOrder.contactFlow}"/>
			<input type="hidden" id="contractName" name="contractName" value="${contactOrder.contractName}"/>
			<input type="hidden" name="consumerFlow" id="consumerFlow" value="${contactOrder.consumerFlow }"/>
			<input type="hidden" name="consumerName" id="consumerName" value="${contactOrder.consumerName }"/>
			<input type="hidden" name="consumerAliasName" id="consumerAliasName" value="${contactOrder.consumerAliasName }"/>		
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<colgroup>
						<col width="13%"/>
						<col width="25%"/>
						<col width="12%"/>
						<col width="50%"/>
					</colgroup>
					<tr>
						<th colspan="4" style="text-align: left;padding-left: 10px">工作联系单</th>
					</tr>
					<c:if test="${not empty contactOrder.contactNo }">
					<tr>
						<td style="text-align: right;padding-right: 10px;">编&#12288;&#12288;号</td>
						<td colspan="3">${contactOrder.contactNo }</td>
					</tr>
					</c:if>
					<tr>
						<td style="text-align: right;padding-right: 10px;" rowspan="2"><span class="red">*</span>客户名称</td>
						<td rowspan="2">
							<input id="searchParam_Customer" name="customerName" value="${contactOrder.customerName }" placeholder="输入客户名称/别名" class="inputText validate[required]"  style="width: 180px;text-align: left;" onblur="resetCustomerName();" onchange="resetCustomerFlow();"/>
				        	<div id="suggest_Customer" class="ac_results" style="margin:0;position: fixed; z-index: 100;width: 370px;"></div>
				        	<input type="hidden" id="result_Customer" name="customerFlow" value="${contactOrder.customerFlow }"/>
						</td>
						<td style="text-align: right;padding-right: 10px;">合同名称</td>
						<td colspan="3" id="contractNameTd">
							<select class="inputText" style="width: 300px;" id="contractFlow" name="contractFlow" onchange="contractRelative(this.value);">
								<option value="">请选择</option>
				             	<c:forEach var="contract" items="${contractList}">
						            <option value="${contract.contractFlow}" <c:if test="${contract.contractFlow eq contactOrder.contractFlow }">selected</c:if>>${contract.contractName}&#12288;&#12288;${contract.signDate }</option>
						        </c:forEach>
							</select>
							<span id="contractInfo" style="margin-left: 10px;"><c:if test="${not empty contactOrder.contractFlow }"><a title="查看合同信息" href="javascript:contractInfo('${contactOrder.contractFlow }');">>></a></c:if></span>
						</td>
					</tr>
					<tr>
					    <td style="text-align: right;padding-right: 10px;">合同状态</td>
						<td style="text-align: left;" id="contractStatusTd">
						  <c:forEach items="${contractStatusEnumList }" var="status">
						      <c:if test="${status.id eq contactOrderForm.contractStatusId }">${status.name }</c:if>
						  </c:forEach>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">客户地址</td>
						<td colspan="3" id="customerAddressTd">${contactOrderForm.customerAddress }</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">最终使用方名称</td>
						<td id="consumerNameTd">
						   <input type="text" value="${contactOrder.consumerName }" id="consumerNameTdText" class="inputText" style="width:200px; text-align:left;"/>
						</td>
					    <td style="text-align: right;padding-right: 10px;">最终使用方地址</td>
					    <td id="consumerAddressTd">
					       <input type="text" value="${contactOrderForm.consumerAddress }" id="consumerAddressTdText" class="inputText" style="width:400px;text-align:left;"/>
					    </td>
					</tr>
				</table>
				<table width="100%" cellpadding="0" cellspacing="0" class="basic" style="border-top:none;">
					<colgroup>
						<col width="13%"/>
						<col width="25%"/>
						<col width="12%"/>
						<col width="20%"/>
						<col width="10%"/>
						<col width="20%"/>
					</colgroup>	
					<tr>
						<td style="text-align: right;padding-right: 10px;" rowspan="2"><span class="red">*</span>联&nbsp;系&nbsp;&nbsp;人</td>
						<td rowspan="2" id="contactUserTd">
						  <select class="inputText validate[required]"  onchange="contactUserRelative(this.value);">
						     <option value="">请选择</option>
						     <c:forEach items="${customerUserList }" var="customerUser">
						         <option value="${customerUser.userFlow }" title="${customerUser.deptName }<c:if test="${not empty userCategoryMap[customerUser.userFlow] }">（${userCategoryMap[customerUser.userFlow] }）</c:if>" <c:if test="${customerUser.userFlow eq contactOrderForm.userFlow }">selected</c:if>>${customerUser.userName }</option>
						     </c:forEach>
						  </select>
						</td>
						<td style="text-align: right;padding-right: 10px;">部&#12288;&#12288;门</td>
						<td id="deptNameTd">${contactOrderForm.deptName }</td>
						<td style="text-align: right;padding-right: 10px;">职&#12288;&#12288;务</td>
						<td id="postNameTd">${contactOrderForm.postName }</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">固&#12288;&#12288;话</td>
						<td id="telPhoneTd">${contactOrderForm.telPhone }</td>
						<td style="text-align: right;padding-right: 10px;">手&#12288;&#12288;机</td>
						<td id="celPhoneTd">${contactOrderForm.celPhone }</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;"><span class="red">*</span>需求事项</td>
						<td colspan="5">
							<c:forEach var="demandMatter" items="${demandMatterEnumList}">
						        <input type="checkbox" id="dm_${demandMatter.id }" class="validate[required] demandMatterCheck" name="demandMatterId" value="${demandMatter.id }" onchange="selectSingle(this);" onclick="changeMainTainType(this);"<c:if test="${contactOrder.demandMatterId eq demandMatter.id}">checked</c:if>/><label for="dm_${demandMatter.id }">&nbsp;${demandMatter.name}</label>&#12288;
						    </c:forEach>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;"><span class="red">*</span>服务类型</td>
						<td colspan="5" id="serviceTypeTd">
						</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;" id="productNameTd">产品/项目名称</td>
						<td colspan="5" id="contractProductTd">
						    <c:if test="${empty contactOrder.contractFlow }">
						       <c:forEach var="dict" items="${dictTypeEnumProductTypeList}">
						          <input type="checkbox" id="product_${dict.dictId }"  name="productTypeId" value="${dict.dictId }"
						            <c:if test="${dict.dictName eq checkMap[dict.dictId]}">checked="checked"</c:if>/>
								  <label for="product_${dict.dictId }">&nbsp;${dict.dictName}</label>&#12288;
						       </c:forEach>
						       <input type="checkbox" id="orderProject" onclick="appendInput(this);" <c:if test="${not empty contactOrder.orderProductName }">checked</c:if>>
						       <label for="orderProject">&nbsp;定制项目</label>&#12288;
						       <span id="xmSpan">
						        <c:if test="${not empty contactOrder.orderProductName }">
						          <input type="text" name="productTypeId" class="inputText validate[maxSize[10]]" style="width: 200px;" value="${contactOrder.orderProductName }"/>
						        </c:if>
						       </span>
						    </c:if>
							<c:if test="${not empty contactOrder.contractFlow }">
							<c:forEach items="${productList}" var="contractProduct" varStatus="num">
							    <input type="checkbox" id="contractProduct_${num.count }"  name="productTypeId" class="validate[required]"
							    <c:forEach var="product" items="${productNameList }"> 
							      <c:if test="${not empty contractProduct.productTypeId }">value="${contractProduct.productTypeId }"</c:if> 
							      <c:if test="${empty contractProduct.productTypeId }">value="${contractProduct.productTypeName }"</c:if> 
							      <c:if test="${product eq contractProduct.productTypeName }">checked="checked"</c:if>
							      </c:forEach>/>
								<label for="contractProduct_${num.count }">&nbsp;${contractProduct.productTypeName}</label>&#12288;
							</c:forEach>
							</c:if>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">备&#12288;&#12288;注</td>
						<td colspan="5">
						 <textarea id="productItem" class="xltxtarea validate[maxSize[250]]" name="remark" style="width: 770px;text-align: left;">${contactOrder.remark }</textarea>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;"><span class="red">*</span>要求完成时间</td>
						<td>
							<input onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" style="text-align:left;" name="demandDate" <c:if test="${not empty contactOrder.demandDate}">value="${contactOrder.demandDate }"</c:if>  readonly="readonly" class="validate[required] inputText" type="text"/>
						</td>
						<td style="text-align: right;padding-right: 10px;"><span class="red">*</span>紧急程度</td>
						<td colspan="3">
							<c:forEach var="demandState" items="${demandStateEnumList}">
						        <input type="checkbox" id="demandState_${demandState.id }" class="validate[required]" name="demandStatusId" <c:if test="${empty contactOrder.demandStatusId and demandState.id eq 'Normal'}">checked</c:if><c:if test="${demandState.id eq contactOrder.demandStatusId}">checked</c:if> value="${demandState.id }" onchange="selectSingle(this)"/><label for="demandState_${demandState.id }">&nbsp;${demandState.name}</label>&#12288;
						    </c:forEach>
						</td>
					</tr>
					<tr>
					    <td style="text-align: right;padding-right: 10px;">申请部门</td>
						<td>
						    <c:if test="${not empty contactOrder.applyDeptName }">${contactOrder.applyDeptName }</c:if>
						    <c:if test="${empty contactOrder.applyDeptName }">${sessionScope.currUser.deptName }</c:if>
						    <input type="hidden"  name="applyDeptName" 
						       <c:if test="${not empty contactOrder.applyDeptName }">value="${contactOrder.applyDeptName}"</c:if>
						       <c:if test="${empty contactOrder.applyDeptName }">value="${sessionScope.currUser.deptName }"</c:if>/>
						    <input type="hidden"  name="applyDeptFlow" 
						       <c:if test="${not empty contactOrder.applyDeptFlow }">value="${contactOrder.applyDeptFlow}"</c:if>
						       <c:if test="${empty contactOrder.applyDeptFlow }">value="${sessionScope.currUser.deptFlow }"</c:if>/>
						</td>
						<td style="text-align: right;padding-right: 10px;"><span class="red">*</span>申&nbsp;请&nbsp;&nbsp;人</td>
						<td>
						    <c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] != GlobalConstant.USER_LIST_LOCAL}">
						       ${sessionScope.currUser.userName }
						    <input type="hidden"  name="applyUserName" value="${sessionScope.currUser.userName }"/>
						    <input type="hidden"  name="applyUserFlow" value="${sessionScope.currUser.userFlow }"/>
						    </c:if>
						    <c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.USER_LIST_LOCAL }">
						        <select name="applyUserFlow" id="applyUserFlow" class="inputText validate[required]" onchange="setUserName('applyUser');">
							      <option value="">请选择</option>
						           <c:forEach var="user" items="${userList}">
						            <option value="${user.userFlow}" <c:if test="${empty contactOrder.contactFlow }">${user.userFlow eq sessionScope.currUser.userFlow?"selected":"" }</c:if><c:if test="${not empty contactOrder.contactFlow and contactOrder.applyUserFlow eq user.userFlow}">selected</c:if>>${user.userName}</option>
						           </c:forEach>
						        </select> 
						        <input type="hidden" id="applyUserName" name="applyUserName" 
						        <c:if test="${empty contactOrder.applyUserName }">${sessionScope.currUser.userName }</c:if>
						        <c:if test="${not empty contactOrder.applyUserName}">
						           ${contactOrder.applyUserName }
						        </c:if>
						        />
						    </c:if>
						</td>
						<td style="text-align: right;padding-right: 10px;"><span class="red">*</span>申请时间</td>
						<td>
							<input onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" name="applyDate" style="text-align:left;" <c:if test="${empty contactOrder.applyDate }">value="${pdfn:getCurrDateTime('yyyy-MM-dd HH:mm') }"</c:if><c:if test="${not empty contactOrder.applyDate}">value="${contactOrder.applyDate }"</c:if> readonly="readonly" class="validate[required] inputText" type="text"/>
						</td>
					</tr>
				</table>
				<c:if test="${param.type != 'audit' }">
				<div class="button">
					<c:if test="${param.type != 'show'}">
					<input class="search" type="button" value="保&#12288;存" onclick="save();" />
					</c:if>
					<input class="search" type="button" value="关&#12288;闭" onclick="jboxCloseMessager();" />
				</div>
				</c:if>
			</form>
			</div>
		</div>
	</div>

<span id="productSpan" style="display: none;">
	<c:forEach var="product" items="${dictTypeEnumProductTypeList}">
		<input type="checkbox" id="product_${product.dictId }"  name="productTypeId" value="${product.dictId }" /><label for="product_${product.dictId }">&nbsp;${product.dictName}</label>&#12288;
	</c:forEach>
</span>
<span id='inputSpan' style="display: none;">
     <input type="text" name="orderProductName" class="inputText validate[maxSize[10]]" style="width: 200px;"/>
</span>
<span id="PreSalesSupportDictEnum" >
    <c:forEach items="${dictTypeEnumPreSalesSupportList }" var="serviceType">
          <input type="checkbox" id="PreSalesSupport_${serviceType.dictId }" class="validate[required]" name="serviceTypeId" value="${serviceType.dictId }" <c:if test="${pdfn:contain(serviceType.dictId,serviceTypeList) }">checked</c:if>/><label for="PreSalesSupport_${serviceType.dictId }">&nbsp;${serviceType.dictName}</label>&#12288;
    </c:forEach>
</span>
<span id="SalesImplementDictEnum" >
    <c:forEach items="${dictTypeEnumSalesImplementList }" var="serviceType">
          <input type="checkbox" id="SalesImplement_${serviceType.dictId }" class="validate[required]" name="serviceTypeId" value="${serviceType.dictId }" <c:if test="${pdfn:contain(serviceType.dictId,serviceTypeList) }">checked</c:if>/><label for="SalesImplement_${serviceType.dictId }">&nbsp;${serviceType.dictName}</label>&#12288;
    </c:forEach>
</span>
<span id="ServiceDictEnum">
    <c:forEach items="${dictTypeEnumServiceList }" var="serviceType">
          <input type="checkbox" id="Service_${serviceType.dictId }" class="validate[required]" name="serviceTypeId" value="${serviceType.dictId }" <c:if test="${pdfn:contain(serviceType.dictId,serviceTypeList) }">checked</c:if>/><label for="Service_${serviceType.dictId }">&nbsp;${serviceType.dictName}</label>&#12288;
    </c:forEach>
</span>
</body>
</html>