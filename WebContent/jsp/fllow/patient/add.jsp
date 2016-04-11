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
		<div id="tagContent" >
			<div class="tagContent selectTag" id="tagContent0">
			<input type="hidden" id="customerNameFlag" name="customerNameFlag"/>
			<input type="hidden" id="oldCustomerName" name="oldCustomerName"/>
			<form id="customerForm" method="post" style="position: relative;">
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<colgroup>
						<col width="14%"/>
						<col width="12%"/>
						<col width="12%"/>
						<col width="16%"/>
						<col width="12%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="12%"/>
					</colgroup>
					<tr>
						<th colspan="8" style="text-align: left;padding-left: 10px">患者信息</th>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;"><span style="color: red">*</span>&nbsp;患者姓名：</td>
						<td colspan="3"><input name="customerName" onblur="checkCustomer();" class="validate[required,maxSize[50]] inputText" style="width: 95%;text-align: left;" type="text" value=""/></td>
						<td style="text-align: right;padding-right: 10px;">身份证号：</td>
						<td colspan="3"><input name="aliasName" class="inputText" style="width: 95%; text-align: left;" type="text" value=""/></td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;"><span style="color: red">*</span>&nbsp;性&#12288;&#12288;别：</td>
						<td colspan="3">
								<select class="inputText" style="width: 80px;">
									<option value=""></option>
									<option value="1">男</option><option value="2">女</option>
								</select>
						</td>
						<td style="text-align: right;padding-right: 10px;">联系方式：</td>
						<td colspan="3"><input name="customerAddress" placeholder="请输入手机号" class="validate[maxSize[100]] inputText" style="width: 95%;text-align: left;" type="text" value=""/></td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">联系地址：</td>
						<td colspan="3"><input name="customerSite" class="inputText" style="width: 95%;text-align: left;" type="text" value="" /></td>
						<td style="text-align: right;padding-right: 10px;">邮&#12288;&#12288;编：</td>
						<td>
							<input name="zipCode" class="validate[custom[chinaZip]] inputText" style="width: 90%;text-align: left;" type="text" />
						</td>
						<td style="text-align: right;padding-right: 10px;">座机号：</td>
						<td>
							<input name="telPhone" class="validate[maxSize[50],custom[phone2]] inputText" style="width: 90%;text-align: left;" type="text" />
						</td>
					</tr>
					<tr>	
						<td style="text-align: right;padding-right: 10px;">主&#12288;&#12288;诉：</td>
						<td id="isContractTd" colspan="7">
							<input class="inputText" name="isContract" id="isContract_Y" type="text" style="width: 95%;text-align: left;">
						</td>
						
						<td class="customerGradeTd" style="display: none; text-align: right;padding-right: 10px;">客户等级：</td>
						<td class="customerGradeTd" style="display: none;" colspan="5">
							<select name="customerGradeId" class="inputText">
				            	<option value="">请选择</option>
				             	<c:forEach var="customerGrade" items="${dictTypeEnumCustomerGradeList}">
						            <option value="${customerGrade.dictId}" >${customerGrade.dictName}</option>
						        </c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">现病史：</td>
				     	<td colspan="7" style="text-align:left;padding-left: 3px;">
				     		<textarea name="remark" placeholder="请输入现病史" class="validate[maxSize[250]] xltxtarea" style="height: 80px;"></textarea>
				     	</td>
				    </tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">既往史：</td>
				     	<td colspan="7" style="text-align:left;padding-left: 3px;">
				     		<textarea name="remark" placeholder="请输入既往史" class="validate[maxSize[250]] xltxtarea" style="height:80px;"></textarea>
				     	</td>
				    </tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">备&#12288;&#12288;注：</td>
				     	<td colspan="7" style="text-align:left;padding-left: 3px;">
				     		<textarea name="remark" placeholder="请输入患者备注" class="validate[maxSize[250]] xltxtarea" style="height: 60px;"></textarea>
				     	</td>
				    </tr>
				</table>
			</form>
				<div class="button" style="width: 100%;">
					<input class="search" type="button" id="saveButton" value="保&#12288;存" onclick="save();" />
				</div>
			</div>
		</div>
	</div>
</div>
</div>
</body>
</html>