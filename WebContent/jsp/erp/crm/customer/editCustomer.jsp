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
$(document).ready(function(){
	showHospitalType("${customer.customerTypeId}");
	if("${customer.isContract}" =="${GlobalConstant.FLAG_Y}"){
		$(".customerGradeTd").show();
		$("#isContractTd").attr("colspan","");
	}else{
		$(".customerGradeTd").hide();
		$("#isContractTd").attr("colspan","7");
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
	$("#saveButton").attr("disabled",true);
	var url = "<s:url value='/erp/crm/saveCustomer'/>";
	jboxPost(url,$("#customerForm").serialize(),
			function(resp){
				if("${GlobalConstant.SAVE_SUCCESSED}"==resp){
					window.parent.frames['jbox-message-iframe'].window.loadCustomer("${customer.customerFlow}");
					jboxClose();
				}
			},null,true);
}

function selectSingle(obj) {
	var value = $(obj).val();
	var name = $(obj).attr("name");
	$("input[name="+name+"][value!="+value+"]:checked").attr("checked",false);
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
	if(false == $("#customerForm").validationEngine("validate")){
		return false;
	}
	var $customerName = $("input[name='customerName']");
	var customerNameVal = $customerName.val().trim();
	$customerName.val(customerNameVal);
	if("" != customerNameVal){
		var oldCustomerName = $("#oldCustomerName").val();
		if(oldCustomerName == customerNameVal){
			jboxTip("${GlobalConstant.CRM_CUSTOMER_NAME_EXIST}");
			return false;
		}
		var customerFlow = $("input[name=customerFlow]").val();
		var data = {
			customerFlow:customerFlow,
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
			<form id="customerForm" method="post">
				<input type="hidden"  name="customerFlow" value="${customer.customerFlow}"/>
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
						<th colspan="8" style="text-align: left;padding-left: 10px">客户信息</th>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;"><span style="color: red">*</span>&nbsp;客户名称：</td>
						<td colspan="3"><input name="customerName" onblur="checkCustomer();" class="validate[required,maxSize[50]] inputText" style="width: 95%;text-align: left;" type="text" value="${customer.customerName}"/></td>
						<td style="text-align: right;padding-right: 10px;">别&#12288;&#12288;名：</td>
						<td colspan="3"><input name="aliasName" class="validate[maxSize[250]] inputText" style="width: 95%;text-align: left;" type="text" value="${customer.aliasName}"/></td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;"><span style="color: red">*</span>&nbsp;地&#12288;&#12288;区：</td>
						<td colspan="3">
							<div id="provCityAreaId">
								<select id="customerProvId" name="customerProvId" class="validate[required] province inputText" data-value="${customer.customerProvId}" data-first-title="选择省"></select>
								<select id="customerCityId" name="customerCityId" class="validate[required] city inputText" data-value="${customer.customerCityId}" data-first-title="选择市"></select>
								<select id="customerAreaId" name="customerAreaId" class="area inputText" data-value="${customer.customerAreaId}" data-first-title="选择地区"></select>
							</div>
							<input id="customerProvName" name="customerProvName" type="hidden"/>
							<input id="customerCityName" name="customerCityName" type="hidden"/>
							<input id="customerAreaName" name="customerAreaName" type="hidden"/>
							<!-- 获取地区权限数据 -->
							<c:set var="provIds"></c:set>
							<c:forEach items="${erpUserRegionPopedomList}" var="erpUserRegionPopedom" varStatus="status">
							<c:set var="provIds" value="${provIds},${erpUserRegionPopedom.provId }"></c:set>
							</c:forEach>
							<script type="text/javascript">
							$(document).ready(function(){
								var url = '<s:url value="/js/provCityAreaJson.min.json"/>';
								var provIds = "${provIds}";
								jboxGet(url,null, function(json) {
									// 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件 
									var newJsonData=new Array();
									var j=0;
									for(var i=0;i<json.length;i++){
										var provData = json[i];
										if(provIds.indexOf(provData.v)>-1){
											newJsonData[j++]=provData;
										}
									}
									$.cxSelect.defaults.url = newJsonData; 
									$.cxSelect.defaults.nodata = "none"; 
									$("#provCityAreaId").cxSelect({ 
									    selects : ["province", "city", "area"], 
									    nodata : "none",
										firstValue : ""
									}); 
								},null,false);
							});
							</script>
						</td>
					<td style="text-align: right;padding-right: 10px;">地&#12288;&#12288;址：</td>
						<td colspan="3"><input name="customerAddress" placeholder="请输入街道信息，不要重复输入省、市、区" class="validate[maxSize[100]] inputText" style="width: 95%;text-align: left;" type="text" value="${customer.customerAddress}"/></td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">网&#12288;&#12288;站：</td>
						<td colspan="3">
							<input name="customerSite" class="validate[maxSize[100],custom[url]] inputText" style="width: 95%;text-align: left;" type="text"
								 value="${customer.customerSite}"  onfocus="if(this.value==''){this.value='http://'}" onblur="if(this.value=='http://'){this.value=''}"/>
						</td>
						<td style="text-align: right;padding-right: 10px;">邮&#12288;&#12288;编：</td>
						<td>
							<input name="zipCode" value="${customer.zipCode}" class="validate[custom[chinaZip]] inputText" style="width: 90%;text-align: left;" type="text" />
						</td>
						<td style="text-align: right;padding-right: 10px;">总&nbsp;机&nbsp;号：</td>
						<td>
							<input name="telPhone" value="${customer.telPhone}" class="validate[maxSize[50],custom[phone2]] inputText" style="width: 90%;text-align: left;" type="text" />
						</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;"><span style="color: red">*</span>&nbsp;类&#12288;&#12288;别：</td>
						<td id="typeTd" colspan="7">
							<select name="customerTypeId" class="validate[required] inputText" onchange="showHospitalType(this.value)">
				            	<option value="">请选择</option>
				             	<c:forEach var="customerType" items="${customerTypeEnumList}">
						            <option value="${customerType.id}" <c:if test="${customer.customerTypeId eq customerType.id}">selected="selected"</c:if>>${customerType.name}</option>
						        </c:forEach>
							</select>
						</td>
						<!-- 医院 -->
						<td class="hospitalTd" style="display: none; text-align: right;padding-right: 10px;"><span style="color: red">*</span>级&#12288;&#12288;别：</td>
						<td class="hospitalTd" style="display: none; ">
							<select name="hospitalGradeId" class="validate[required] inputText">
				            	<option value="">请选择</option>
				             	<c:forEach var="hospitalGrade" items="${dictTypeEnumHospitalGradeList}">
						            <option value="${hospitalGrade.dictId}" <c:if test="${customer.hospitalGradeId eq hospitalGrade.dictId}">selected="selected"</c:if>>${hospitalGrade.dictName}</option>
						        </c:forEach>
							</select>&nbsp;
							<select name="hospitalLevelId" class="inputText">
				            	<option value="">请选择</option>
				             	<c:forEach var="hospitalLevel" items="${dictTypeEnumHospitalLevelList}">
						            <option value="${hospitalLevel.dictId}" <c:if test="${customer.hospitalLevelId eq hospitalLevel.dictId}">selected="selected"</c:if>>${hospitalLevel.dictName}</option>
						        </c:forEach>
							</select>
						</td>
						<td class="hospitalTd" style="display: none; text-align: right;padding-right: 10px;">医院类型：</td>
						<td class="hospitalTd" colspan="3" style="display: none; line-height: 25px;">
						    <c:forEach var="hospitalType" items="${dictTypeEnumHospitalTypeList}">
				             	<input name="hospitalTypeId" id="hospitalTypeId_${hospitalType.dictId}"
									<%-- <c:forEach var="typeId" items="${hospitalTypeIdList}">
										<c:if test="${typeId eq hospitalType.dictId}">checked="checked"</c:if>
								    </c:forEach> --%>
								    <c:if test="${pdfn:contain(hospitalType.dictId, hospitalTypeIdList)}">checked="checked"</c:if>
					             	type="checkBox" value="${hospitalType.dictId}"><label for="hospitalTypeId_${hospitalType.dictId}">&nbsp;${hospitalType.dictName}</label>&nbsp;
						    </c:forEach>
						</td>
						<!-- 学校 -->
						<td class="schoolTd" style="display: none; text-align: right;padding-right: 10px;">级&#12288;&#12288;别：</td>
						<td class="schoolTd" colspan="5" style="display: none; ">
							<c:forEach var="schoolType" items="${dictTypeEnumSchoolTypeList}">
				             	<input name=schoolTypeId id="schoolTypeId_${schoolType.dictId}" type="checkBox" value="${schoolType.dictId}" <c:if test="${customer.schoolTypeId eq schoolType.dictId}">checked="checked"</c:if> onchange="selectSingle(this)"><label for="schoolTypeId_${schoolType.dictId}">&nbsp;${schoolType.dictName}</label>&#12288;
						    </c:forEach>
						</td>
					</tr>
					<tr>	
						<td style="text-align: right;padding-right: 10px;">合同客户：</td>
						<td id="isContractTd" colspan="7">
							<input name="isContract" id="isContract_Y" type="checkBox" value="${GlobalConstant.FLAG_Y}" <c:if test="${customer.isContract eq GlobalConstant.FLAG_Y}">checked="checked"</c:if> onchange="selectContract(this);"><label for="isContract_Y">&nbsp;是</label>&#12288;
							<input name="isContract" id="isContract_N" type="checkBox" value="${GlobalConstant.FLAG_N}" <c:if test="${customer.isContract eq GlobalConstant.FLAG_N}">checked="checked"</c:if> onchange="selectContract(this);"><label for="isContract_N">&nbsp;否</label>&#12288;
						</td>
						<td class="customerGradeTd" style="display: none; text-align: right;padding-right: 10px;">客户等级：</td>
						<td class="customerGradeTd" style="display: none;" colspan="5">
							<select name="customerGradeId" class="inputText">
				            	<option value="">请选择</option>
				             	<c:forEach var="customerGrade" items="${dictTypeEnumCustomerGradeList}">
						            <option value="${customerGrade.dictId}" <c:if test="${customer.customerGradeId eq customerGrade.dictId}">selected="selected"</c:if>>${customerGrade.dictName}</option>
						        </c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">备&#12288;&#12288;注：</td>
				     	<td colspan="7" style="text-align:left;padding-left: 2px;">
				     		<textarea placeholder="请输入客户备注"  class="validate[maxSize[250]] xltxtarea" name="remark">${customer.remark}</textarea>
				     	</td>
				    </tr>
				</table>
				<div class="button" style="width: 100%;">
					<input class="search" type="button" value="保&#12288;存" id="saveButton" onclick="save();" />
					<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
				</div>
			</form>
			</div>
		</div>
	</div>
</div>
</div>
</body>
</html>