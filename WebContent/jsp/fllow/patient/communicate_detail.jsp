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
$(document).ready(function(){
	if($("#customerUserTb tr").length<=0){
		add();
	}
});

function showHospitalType(customerType){
	if ("${customerTypeEnumHospital.id}" == customerType) {
		$(".hospitalTd").show();
		$(".schoolTd").hide();
		$("#typeTd").attr("colspan","");
	}else if("${customerTypeEnumSchool.id}" == customerType) {
		$(".hospitalTd").hide();
		$(".schoolTd").show();
		$("#typeTd").attr("colspan","");
	}else{
		$(".hospitalTd").hide();
		$(".schoolTd").hide();
		$("#typeTd").attr("colspan","7");
	}
}

function add(){
	$('#customerUserTb').append($("#clone tr:eq(0)").clone());
}

function del(){
	var mIds = $("#customerUserTb input[name='userFlow']:checked");
	if(mIds.length == 0){
		jboxTip("请勾选要删除的！");
		return false;
	}
	jboxConfirm("确认删除？", function() {
		mIds.each(function(){
			$(this).parent().parent().remove();
		});
	});
}

function save(){
	var customerNameFlag = $("#customerNameFlag").val();
	if("${GlobalConstant.FLAG_N}"==customerNameFlag){
		jboxTip("${GlobalConstant.CRM_CUSTOMER_NAME_EXIST}");
		return false;
	}
	var $customerSite = $("input[name='customerSite']");
	var customerSite = $customerSite.val();
	if(customerSite.trim().toLowerCase()=="http://"){
		$customerSite.val("");
		customerSite = $customerSite.val();
	}
	if(false == $("#customerForm").validationEngine("validate")){
		return false;
	}
	var trs = $("#customerUserTb").children();
	var datas = [];
	$.each(trs, function(i,n){
		var userFlow = $(n).find("input[name='userFlow']").val();
		var deptName = $(n).find("input[name='deptName']").val();
		var postName = $(n).find("input[name='postName']").val();
		var userName = $(n).find("input[name='userName']").val();
		var sexId = $(n).find("select[name='sexId']").val();
		/* var idNo = $(n).find("input[name='idNo']").val();
		var birthday = $(n).find("input[name='birthday']").val(); */
		var userQq = $(n).find("input[name='userQq']").val();
		var userTelphone = $(n).find("input[name='userTelphone']").val();
		var userCelphone = $(n).find("input[name='userCelphone']").val();
		var userEmail = $(n).find("input[name='userEmail']").val();
		var isMain = $(n).find("select[name='isMain']").val();
		var remark = $(n).find("input[name='remark']").val();
		var data={
			"userFlow":userFlow,
			"deptName":deptName, 
			"postName":postName, 
			"userName":userName, 
			"sexId":sexId, 
			/* "idNo":idNo, 
			"birthday":birthday, */ 
			"userQq":userQq, 
			"userTelphone":userTelphone, 
			"userCelphone":userCelphone, 
			"userEmail":userEmail, 
			"isMain":isMain, 
			"remark":remark
		};
		if(deptName=="" && postName=="" && userName=="" && userQq=="" && userTelphone=="" && userCelphone=="" && userEmail=="" && isMain=="" && remark==""){
			$(n).remove();
		}else{
			datas.push(data);
		}
	});
	if(false == $("#customerUserForm").validationEngine("validate")){
		return false;
	}
	var customerProvName = $("[name='customerProvId'] option:selected").text();
	if(customerProvName=="选择省"){
		customerProvName = "";
	}
	var customerCityName = $("[name='customerCityId'] option:selected").text();
	if(customerCityName=="选择市"){
		customerCityName = "";
	}
	var customerAreaName = $("[name='customerAreaId'] option:selected").text();
	if(customerAreaName=="选择地区"){
		customerAreaName = "";
	}
	$("[name='customerProvName']").val(customerProvName);
	$("[name='customerCityName']").val(customerCityName);
	$("[name='customerAreaName']").val(customerAreaName);
	var customerFlow = $("input[name='customerFlow']").val(); 
	var customerName = $("input[name='customerName']").val(); 
	var aliasName = $("input[name='aliasName']").val(); 
	var customerProvId = $("#customerProvId").val(); 
	var customerCityId = $("#customerCityId").val(); 
	var customerAreaId = $("#customerAreaId").val(); 
	var customerAddress = $("input[name='customerAddress']").val(); 
	var customerTypeId = $("select[name='customerTypeId']").val(); 
	var customerGradeId = $("select[name='customerGradeId']").val(); 
	var hospitalGradeId = $("select[name='hospitalGradeId']").val(); 
	var hospitalLevelId = $("select[name='hospitalLevelId']").val(); 
	var zipCode = $("input[name='zipCode']").val(); 
	var telPhone = $("input[name='telPhone']").val(); 
	var schoolTypeId = $("input[name='schoolTypeId']:checked").val();
	var isContract = $("input[name='isContract']:checked").val(); 
	var hospitalTypeId = ""; 
	$("input[name='hospitalTypeId']:checked").each(function(i,n){
		if(i==0){
			hospitalTypeId = $(this).val();
		}else{
			hospitalTypeId = hospitalTypeId +","+ $(this).val();
		}
	});
	var remark = $("textarea[name='remark']").val(); 
	var customer = {
		"customerFlow":customerFlow, 
		"customerName":customerName, 
		"aliasName":aliasName, 
		"customerProvId":customerProvId, 
		"customerCityId":customerCityId, 
		"customerAreaId":customerAreaId, 
		"customerProvName":customerProvName, 
		"customerCityName":customerCityName, 
		"customerAreaName":customerAreaName,
		"customerSite":customerSite, 
		"customerAddress":customerAddress, 
		"customerTypeId":customerTypeId, 
		"customerGradeId":customerGradeId, 
		"hospitalGradeId":hospitalGradeId, 
		"hospitalLevelId":hospitalLevelId, 
		"hospitalTypeId":hospitalTypeId,
		"zipCode":zipCode,
		"telPhone":telPhone,
		"schoolTypeId":schoolTypeId,
		"isContract":isContract,
		"remark":remark
	};
	$("#saveButton").attr("disabled",true);
	var requestData = {"customer":customer, "customerUserList":datas};
	var url = "<s:url value='/erp/crm/saveCustomerAndUser'/>";
	jboxPostJson(
			url,
			JSON.stringify(requestData),
			function(resp){
				if("${GlobalConstant.SAVE_FAIL}" != resp){
					jboxTip("${GlobalConstant.SAVE_SUCCESSED}");
					setTimeout(function(){
						var w = $('.mainright').width();
						var h = $('.mainright').height();
						var url = "<s:url value='/erp/crm/customerInfo'/>?customerFlow=" + resp+"&source=add";
						var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
						jboxMessager(iframe,'客户详细信息',w,h,null,false);
					},1000);
				}
			}, null, false);
}

function selectSingle(obj) {
	var value = $(obj).val();
	var name = $(obj).attr("name");
	$("input[name="+name+"][value!="+value+"]:checked").attr("checked",false);
}

function writeBirthday(obj){	
	var idNo = obj.value;
	var birthDayObj = $(obj).parent().next().children();
	if(idNo.length==15){
		birthDayObj.val("19"+idNo.substr(6,2)+"-"+idNo.substr(8,2)+"-"+idNo.substr(10,2)); 			
	}else if(idNo.length==18){
		birthDayObj.val(idNo.substr(6,4)+"-"+idNo.substr(10,2)+"-"+idNo.substr(12,2));
	}
}

function selectContract(obj){
	var value = $(obj).val();
	var name = $(obj).attr("name");
	$("input[name="+name+"][value!="+value+"]:checked").attr("checked",false);
	if(value =="${GlobalConstant.FLAG_Y}"){
		$(".customerGradeTd").show();
		$("#isContractTd").attr("colspan","");
	}else{
		$(".customerGradeTd").hide();
		$("#isContractTd").attr("colspan","7");
	}
	var isChecked = $("#isContract_Y").attr("checked");
	if(isChecked != "checked"){
		$(".customerGradeTd").hide();
		$("#isContractTd").attr("colspan","7");
	}
}


function checkCustomer(){
	var $customerName = $("input[name='customerName']");
	var customerNameVal = $customerName.val().trim();
	$customerName.val(customerNameVal);
	if("" != customerNameVal){
		var oldCustomerName = $("#oldCustomerName").val();
		if(oldCustomerName == customerNameVal){
			jboxTip("${GlobalConstant.CRM_CUSTOMER_NAME_EXIST}");
			return false;
		}
		var data = {
			customerName:customerNameVal
		};
		var url = "<s:url value='/erp/crm/checkCustomer'/>";
		jboxPost(url, data,
				function(resp){
					if("${GlobalConstant.CRM_CUSTOMER_NAME_EXIST}"==resp){
						$("#customerNameFlag").val("${GlobalConstant.FLAG_N}");
						$("#oldCustomerName").val(customerNameVal);
						jboxTip(resp);
					}else{
						$("#customerNameFlag").val("${GlobalConstant.FLAG_Y}");
					}
				},null,false);
	}
}

function checkCustomerUserName(obj){
	var userName = $(obj).val();
	if(userName != ""){
		var num = 0;
		$("[name='userName']").each(function(){
			if(userName == $(this).val()){
				num++;
			}
		}); 
		if (num>1) {
			$(obj).focus();
			$(obj).val("");
			jboxInfo("当前客户已存在该联系人，不能重复添加!");
			return false;
		}
	}
}
</script>
</head>
<body>
<div class="mainright">
<div class="content">
	<div class="title1 clearfix">
		<div>
			匿名 提问：<br/><br/>
			<span style="font-size: 14px;">&#12288;&#12288;本人最近胃口不好喉部感觉有异物，喉部至胸口感觉酸酸热热，肚子感觉热热的，右上腹部胀偶尔疼痛，右腹部肋骨及背部肋骨偶尔疼痛，是什么原因？
			</span>
		</div>
	</div>
	<div style="border-bottom:1px solid #F0F0F0;"></div>
	<div style="margin-bottom: 20px;margin-top: 20px;">
	<p>张洪军 医生的回答：</p><br/>
	<b>问题分析：</b>您好，根据您的描述，无法明确或排除胃溃疡的诊断，可以通过胃镜检查来明确诊断。<br/><br/>
	<b>意见建议：</b>您好，建议您到医院消化内门诊就诊，通过胃镜检查，明确诊断。由于不能面诊，以上所述仅供参考。
	</div>
	<div style="border-bottom:1px solid #F0F0F0;"></div>
	<div style="margin-bottom: 20px;">
		<p>我的回复：</p><br/>
		<textarea rows="5" cols="50" style="width: 95%"></textarea><br/><br/>
		<input type="button" value="保&#12288;存" class="search" style="margin-left: 40%"/>
	</div>
</div>
</div>
</body>
</html>