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
<style>
.edit3{text-align: center;border:none;}
</style>
<script type="text/javascript">
$(document).ready(function(){
	var customerTypeId = $("select[name='customerTypeId']").val();
	showHospitalTypeTd(customerTypeId);
	showCustomerType(customerTypeId);
	var isChecked = $("#isContract_Y").attr("checked");
	if("${GlobalConstant.FLAG_Y}" != "${param.isContract}" || isChecked != "checked"){
		$("#customerGrade").hide();
		$(".customerGradeTd").hide();
	}else{
		$("#customerGrade").show();
		$(".customerGradeTd").show();
	}
	if ("${checkedFlow}" != "") {
		checkedView("${checkedFlow}",false);
	}
});

function checkedView(customerFlow,flag) {
	$(".checkedTr").css("background-color","");
	$(".checkedTr").removeClass("checkedTr");
	$("#"+customerFlow+"_Tr").addClass("checkedTr");
	$("#"+customerFlow+"_Tr").css("background-color","pink");
	if (flag) {
		$("#checkedFlow").val(customerFlow);
	} else {
		$("#checkedFlow").val("");
	}
}

function search(){
	var $customerName = $("input[name='customerName']");
	var customerNameVal = $customerName.val().trim();
	$customerName.val(customerNameVal);
	/* var $customerAddress = $("input[name='customerAddress']");
	var customerAddressVal = $customerAddress.val().trim();
	$customerAddress.val(customerAddressVal);
	var $customerSite = $("input[name='customerSite']");
	var customerSiteVal = $customerSite.val().trim();
	$customerSite.val(customerSiteVal);
	var $zipCode = $("input[name='zipCode']");
	var zipCodeVal = $zipCode.val().trim();
	$zipCode.val(zipCodeVal);
	var $telPhone = $("input[name='telPhone']");
	var telPhoneVal = $telPhone.val().trim();
	$telPhone.val(telPhoneVal); */
	$("#searchForm").submit();
}

function customerInfo(customerFlow) {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/crm/customerInfo'/>?customerFlow=" + customerFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'客户详细信息',w,h,null,false);
}

function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	jboxStartLoading();
	form.submit();
}

function selectSingle(obj) {
	var value = $(obj).val();
	var name = $(obj).attr("name");
	$("input[name="+name+"][value!="+value+"]:checked").attr("checked",false);
}
function selectIsContract(obj) {
	var value = $(obj).val();
	var name = $(obj).attr("name");
	$("input[name="+name+"][value!="+value+"]:checked").attr("checked",false);
	var isChecked = $("#isContract_Y").attr("checked");
	if("${GlobalConstant.FLAG_Y}" != value || isChecked != "checked"){
		$("#customerGrade").hide();
		$("select[name='customerGradeId']").val(null);
	}else{
		$("#customerGrade").show();
	}
}

function showHospitalTypeTd(customerTypeId){
	if("${customerTypeEnumHospital.id}" == customerTypeId) {
		$(".hospitalTypeTd").show();
	}else{
		$(".hospitalTypeTd").hide();
	}
}

function showCustomerType(customerTypeId){
	if("${customerTypeEnumHospital.id}" == customerTypeId){
		$("#hospitalP").show();
		$("#schoolP").hide();
		$("input[name='schoolTypeId']").each(function(){
			$(this).attr("checked",false);
		});
	}else if("${customerTypeEnumSchool.id}" == customerTypeId){
		$("#hospitalP").hide();
		$("#schoolP").show();
		$("select[name='hospitalGradeId']").val(null);
		$("select[name='hospitalLevelId']").val(null);
		$("input[name='hospitalTypeId']").each(function(){
			$(this).attr("checked",false);
		});
	}else{
		$("#hospitalP").hide();
		$("#schoolP").hide();
		$("select[name='hospitalGradeId']").val(null);
		$("select[name='hospitalLevelId']").val(null);
		$("input[name='hospitalTypeId']").each(function(){
			$(this).attr("checked",false);
		});
		$("input[name='schoolTypeId']").each(function(){
			$(this).attr("checked",false);
		});
	}
}

function modCustomerRemark(customerFlow,obj){
	if(false == $("#customerForm").validationEngine("validate")){
		return false;
	}
	$(obj).addClass("edit3");
	if($(obj).val()==$(obj).attr("oldvalue")){
		return;
	}
	var data = {
			customerFlow:customerFlow,
			remark : $(obj).val()
	};
	jboxPost("<s:url value='/erp/crm/modCustomerRemark'/>",data,null,null,false);
	$(obj).attr("oldvalue",$(obj).val());
}

function changeStyle(obj,stylename){
	$(obj).removeClass(stylename);
}

function resetOthers() {
	var customerName = $("input[name='customerName']").val();
	if (customerName != "") {
		document.searchForm.reset();
		$("input[name='isContract']").attr("checked",false);
		$("select[name='customerTypeId'] option:selected").attr("selected",false);
		$("input[name='hosGradeFlag']").attr("checked",false);
		showCustomerType(null);
		selectIsContract(null);
		$("#customerProvId").trigger("change");
		$("input[name='customerName']").val(customerName);
	}
}

function deleteCustomer(customerFlow, customerName){
	jboxConfirm("确认删除   " +customerName+ "？", function() {
		var url = "<s:url value='/erp/crm/deleteCustomer'/>?customerFlow=" + customerFlow;
		jboxPost(url, null,
			function(resp){
				if("${GlobalConstant.FLAG_N}"==resp){
					jboxInfo("客户已有合同 ，不允许删除！");
				}
				if("${GlobalConstant.DELETE_SUCCESSED}"==resp){
					jboxTip(resp);
					setTimeout(function(){
						search();
					},1000);
				}
		}, null, false);
	});		
}

function selectBigRegion(){
	var bigRegionTypeId = $("#bigRegionTypeId option:selected").val();
	var bigRegionValue = "";
	if("01"==bigRegionTypeId){
		bigRegionValue = "'310000','320000','330000','340000','370000'";
	} else if("02"==bigRegionTypeId){
		bigRegionValue = "'350000','440000','450000','460000','520000','530000'";
	} else if("03"==bigRegionTypeId){
		bigRegionValue = "'110000','120000','130000','140000','150000','210000','220000','230000'";
	} else if("04"==bigRegionTypeId){
		bigRegionValue = "'360000','410000','420000','430000','500000','510000','540000','610000','620000','630000','640000','650000'";
	}else{
		bigRegionValue="";
	}
	$("#bigRegionValue").val(bigRegionValue);
	var url = '<s:url value="/js/provCityAreaJson.min.json"/>';
	jboxGet(url,null, function(json) {
		// 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件 
		var newJsonData=new Array();
		var j=0;
		for(var i=0;i<json.length;i++){
			var provData = json[i];
			if(bigRegionValue!=""){
				if(bigRegionValue.indexOf(provData.v)>-1){
					newJsonData[j++]=provData;
				}
			}else{
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
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" name="searchForm" action="<s:url value="/erp/crm/searchCustomer/${sessionScope.userListScope}"/>" method="post">
				<input type="hidden" id="currentPage" name="currentPage" value=""/>
				<input type="hidden" id="currentPage2" name="currentPage2" value="${param.currentPage }"/>
				<input type="hidden" id="checkedFlow" name="checkedFlow" value="${checkedFlow }"/>
				<div style="margin-bottom: 10px">
					客户名称：<input type="text" name="customerName" value="${param.customerName}" placeholder="客户名称/别名" class="xltext" style="width: 210px;" onblur="resetOthers();"/>
					地&#12288;&#12288;区：
					<span id="provCityAreaId">
					<c:if test="${sessionScope.userListScope==GlobalConstant.USER_LIST_GLOBAL }">
						<select id="bigRegionTypeId" class="xlselect" name="bigRegionTypeId" onchange="selectBigRegion();" style="width: 130px;">
							<option value="00"  <c:if test="${param.bigRegionTypeId=='00' or empty param.bigRegionTypeId }">selected</c:if>>全国</option>
							<option value="01"  <c:if test="${param.bigRegionTypeId=='01' }">selected</c:if>>华东地区</option>
							<option value="02"  <c:if test="${param.bigRegionTypeId=='02' }">selected</c:if>>华南地区</option>
							<option value="03"  <c:if test="${param.bigRegionTypeId=='03' }">selected</c:if>>华北地区</option>
							<option value="04"  <c:if test="${param.bigRegionTypeId=='04' }">selected</c:if>>中西部地区</option>
						</select>
						<input type="hidden" id="bigRegionValue" name="bigRegionValue" value="${param.bigRegionValue}">
					</c:if>
						<select id="customerProvId" name="customerProvId" class="province xlselect" data-value="${param.customerProvId}" data-first-title="选择省" style="width: 130px;"></select>
						<select id="customerCityId" name="customerCityId" class="city xlselect" data-value="${param.customerCityId}" data-first-title="选择市" style="width: 130px;"></select>
						<select id="customerAreaId" name="customerAreaId" class="area xlselect" data-value="${param.customerAreaId}" data-first-title="选择地区" style="width: 130px;"></select>
					</span>
					<!-- 获取地区权限数据 -->
					<c:set var="provIds"></c:set>
					<c:forEach items="${erpUserRegionPopedomList}" var="erpUserRegionPopedom" varStatus="status">
					<c:set var="provIds" value="${provIds},${erpUserRegionPopedom.provId }"></c:set>
					</c:forEach>
					<c:choose>
						<c:when test="${sessionScope.userListScope==GlobalConstant.USER_LIST_GLOBAL }">
						<script type="text/javascript">
						$(document).ready(function(){
							selectBigRegion();
						});
						</script>
						</c:when>
						<c:when test="${sessionScope.userListScope!=GlobalConstant.USER_LIST_GLOBAL }">
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
						</c:when>
					</c:choose>
				</div>
				<div>
					类&#12288;&#12288;别：
					<select class="xlselect" name="customerTypeId" style="width: 218px;margin-left: -4px;" onchange="showCustomerType(this.value)">
		            	<option value="">请选择</option>
		             	<c:forEach var="customerType" items="${customerTypeEnumList}">
				            <option value="${customerType.id}" <c:if test="${param.customerTypeId eq customerType.id}">selected="selected"</c:if>>${customerType.name}</option>
				        </c:forEach>
					</select>
				            合同客户：
		            <input name="isContract" id="isContract_Y" type="checkBox" value="${GlobalConstant.FLAG_Y}" <c:if test="${param.isContract eq GlobalConstant.FLAG_Y}">checked="checked"</c:if> onchange="selectIsContract(this);"><label for="isContract_Y">&nbsp;是</label>&nbsp;
					<input name="isContract" id="isContract_N" type="checkBox" value="${GlobalConstant.FLAG_N}" <c:if test="${param.isContract eq GlobalConstant.FLAG_N}">checked="checked"</c:if> onchange="selectIsContract(this);"><label for="isContract_N">&nbsp;否</label>
					<span id="customerGrade" style="display: none;">
					&#12288;&#12288;客户等级：
					<select name="customerGradeId" class="xlselect" style="width: 130px;">
		            	<option value="">请选择</option>
		             	<c:forEach var="customerGrade" items="${dictTypeEnumCustomerGradeList}">
				            <option value="${customerGrade.dictId}" <c:if test="${param.customerGradeId eq customerGrade.dictId}">selected="selected"</c:if>>${customerGrade.dictName}</option>
				        </c:forEach>
					</select>
					</span>
					&#12288;&#12288;<input type="button" class="search" onclick="search();" value="查&#12288;询" />
					<p id="hospitalP" style="display: none;">
					级&#12288;&#12288;别：
					<select name="hospitalGradeId" class="xlselect" style="width:71px; margin-left: -3px;margin-right: 5px;">
		            	<option value="">请选择</option>
		             	<c:forEach var="hospitalGrade" items="${dictTypeEnumHospitalGradeList}">
				            <option value="${hospitalGrade.dictId}" <c:if test="${param.hospitalGradeId eq hospitalGrade.dictId}">selected="selected"</c:if> >${hospitalGrade.dictName}</option>
				        </c:forEach>
					</select>
					<select name="hospitalLevelId" class="xlselect" style="width:71px;margin-right: 5px;">
		            	<option value="">请选择</option>
		             	<c:forEach var="hospitalLevel" items="${dictTypeEnumHospitalLevelList}">
				            <option value="${hospitalLevel.dictId}" <c:if test="${param.hospitalLevelId eq hospitalLevel.dictId}">selected="selected"</c:if>>${hospitalLevel.dictName}</option>
				        </c:forEach>
					</select>
					<input type="checkbox" id="hosGradeFlag" name="hosGradeFlag" value="${GlobalConstant.FLAG_Y }" ${param.hosGradeFlag eq GlobalConstant.FLAG_Y?'checked':'' }><label for="hosGradeFlag" style="padding-right:21px;">&nbsp;及以上</label>
					医院类型：
					<c:forEach var="hospitalType" items="${dictTypeEnumHospitalTypeList}">
		             	<input name="hospitalTypeId" id="hospitalTypeId_${hospitalType.dictId}"
							<c:forEach var="typeId" items="${hospitalTypeIdList}">
								<c:if test="${typeId eq hospitalType.dictId}">checked="checked"</c:if>
						    </c:forEach>
			             	type="checkBox" value="${hospitalType.dictId}"><label for="hospitalTypeId_${hospitalType.dictId}">&nbsp;${hospitalType.dictName}</label>&nbsp;
				    </c:forEach>
				    </p>
				    <p id="schoolP" style="display: none;">
				  	级&#12288;&#12288;别：
				  	<c:forEach var="schoolType" items="${dictTypeEnumSchoolTypeList}">
		             	<input name=schoolTypeId id="schoolTypeId_${schoolType.dictId}" type="checkBox" value="${schoolType.dictId}" <c:if test="${param.schoolTypeId eq schoolType.dictId}">checked="checked"</c:if> onchange="selectSingle(this)"><label for="schoolTypeId_${schoolType.dictId}">&nbsp;${schoolType.dictName}</label>&nbsp;
				    </c:forEach>
				    </p>
				    <!-- <p>
				    	地&#12288;&#12288;址：<input name="customerAddress" class="xltext" type="text" value="${param.customerAddress}"/>
				    	网&#12288;&#12288;址：<input name="customerSite" class="xltext" type="text" value="${param.customerSite}"/>
				    	邮&#12288;&#12288;编：<input name="zipCode" class="xltext" type="text" value="${param.zipCode}" style="width: 50px;"/>
				    	总机号：<input name="telPhone" class="xltext" type="text" value="${param.telPhone}" style="width: 100px;"/>
				    </p> -->
				</div>
				</form>
			</div>		
			<form id="customerForm">	
			<table class="xllist">
				<colgroup>
					<col width="17%"/>
					<col width="6%"/>
					<col width="7%"/>
					<col class="hospitalTypeTd" style="display: none;" width="9%"/>
					<col class="customerGradeTd" style="display: none;" width="8%"/>
					<col width="13%"/>
					<col width="14%"/>
					<col width="9%"/>
					<col width="10%"/>
					<col width="7%"/>
				</colgroup>
				<thead>
				<tr>
					<th>客户名称</th>
					<th>类别</th>
					<th>级别</th>
					<th class="hospitalTypeTd" style="display: none;">医院类型</th>
					<th class="customerGradeTd" style="display: none;">客户等级</th>
					<th>地址</th>
					<th>网址</th>
					<th>总机号</th>
					<th>备注</th>
					<th>操作</th>
				</tr>
				</thead>						
				<tbody>
				<c:forEach items="${customerList}" var="customer">
					<tr id="${customer.customerFlow}_Tr">
						<td>
							<a href="javascript:customerInfo('${customer.customerFlow}');" 
								title="${customer.aliasName}<br/>${customer.customerProvName}
								<c:if test="${not empty customer.customerCityName}">-${customer.customerCityName}</c:if>
								<c:if test="${not empty customer.customerAreaName}">-${customer.customerAreaName}</c:if>">${customer.customerName}</a>
						</td>
						<td>${customer.customerTypeName}</td>
						<td>
							${customer.hospitalGradeName}${customer.hospitalLevelName}
							${customer.schoolTypeName}
						</td>
						<td class="hospitalTypeTd" style="display: none;">${customer.hospitalTypeName}</td>
						<td class="customerGradeTd" style="display: none;">${customer.customerGradeName}</td>
						<td title="${customer.customerProvName}
								<c:if test="${not empty customer.customerCityName}">-${customer.customerCityName}</c:if>
								<c:if test="${not empty customer.customerAreaName}">-${customer.customerAreaName}</c:if>">${customer.customerAddress}</td>
						<td>
							<c:set var="lowerSite" value="${pdfn:toLowerCase(customer.customerSite)}"/>
							<c:set var="site" value="${pdfn:contains(lowerSite,'http://')}"/>
							<c:choose>
								<c:when test="${site}">
									<a href="${customer.customerSite}" target="_blank">${customer.customerSite}</a>
								</c:when>
								<c:otherwise>
									<a href="http://${customer.customerSite}" target="_blank">${customer.customerSite}</a>
								</c:otherwise>
							</c:choose>
						</td>
						<td>${customer.telPhone}</td>
						<td>
						<input type="text" class="validate[maxSize[250]] edit3" style="text-align: left;width: 90%"  onfocus="changeStyle(this,'edit3');"   oldvalue="${customer.remark}" value="${customer.remark}" onblur="modCustomerRemark('${customer.customerFlow}',this);" />
						</td>
						<td>
							[<a href="javascript:customerInfo('${customer.customerFlow}');checkedView('${customer.customerFlow}','true');">查看</a>]
							<c:if test="${sessionScope.userListScope==GlobalConstant.USER_LIST_GLOBAL and (pdfn:contain('action-erp-zjl-khgl-khcx-sckh', sessionScope.currUserMenuIdList) or sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE)}">
								| [<a href="javascript:void(0)" onclick="deleteCustomer('${customer.customerFlow}','${customer.customerName}')">删除</a>]
							</c:if> 
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty customerList}">
					<tr>
						<td colspan="10">无记录</td>
					</tr>
				</c:if>
				</tbody>
			</table>
			</form>
			<p>
			   	<c:set var="pageView" value="${pdfn:getPageView2(customerList, 10)}" scope="request"/> 
				<pd:pagination toPage="toPage"/>
			</p>
	</div>
</div>
</body>
</html>