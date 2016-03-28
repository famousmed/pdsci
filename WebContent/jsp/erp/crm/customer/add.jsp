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
						<th colspan="8" style="text-align: left;padding-left: 10px">客户信息</th>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;"><span style="color: red">*</span>&nbsp;客户名称：</td>
						<td colspan="3"><input name="customerName" onblur="checkCustomer();" class="validate[required,maxSize[50]] inputText" style="width: 95%;text-align: left;" type="text" value=""/></td>
						<td style="text-align: right;padding-right: 10px;">别&#12288;&#12288;名：</td>
						<td colspan="3"><input name="aliasName" class="validate[maxSize[250]] inputText" style="width: 95%; text-align: left;" type="text" value=""/></td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;"><span style="color: red">*</span>&nbsp;地&#12288;&#12288;区：</td>
						<td colspan="3">
							<div id="provCityAreaId">
								<select id="customerProvId" name="customerProvId" class="validate[required] province inputText" data-value="" data-first-title="选择省"></select>
								<select id="customerCityId" name="customerCityId" class="validate[required] city inputText" data-value="" data-first-title="选择市"></select>
								<select id="customerAreaId" name="customerAreaId" class="area inputText" data-value="" data-first-title="选择地区"></select>
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
						<td colspan="3"><input name="customerAddress" placeholder="请输入街道信息，不要重复输入省、市、区" class="validate[maxSize[100]] inputText" style="width: 95%;text-align: left;" type="text" value=""/></td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">网&#12288;&#12288;站：</td>
						<td colspan="3"><input name="customerSite" class="validate[maxSize[100],custom[url]] inputText" style="width: 95%;text-align: left;" type="text" value="" onfocus="if(this.value==''){this.value='http://'}" onblur="if(this.value=='http://'){this.value=''}"/></td>
						<td style="text-align: right;padding-right: 10px;">邮&#12288;&#12288;编：</td>
						<td>
							<input name="zipCode" class="validate[custom[chinaZip]] inputText" style="width: 90%;text-align: left;" type="text" />
						</td>
						<td style="text-align: right;padding-right: 10px;">总&nbsp;机&nbsp;号：</td>
						<td>
							<input name="telPhone" class="validate[maxSize[50],custom[phone2]] inputText" style="width: 90%;text-align: left;" type="text" />
						</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;"><span style="color: red">*</span>&nbsp;类&#12288;&#12288;别：</td>
						<td id="typeTd" colspan="7">
							<select name="customerTypeId" class="validate[required] inputText" onchange="showHospitalType(this.value)">
				            	<option value="">请选择</option>
				             	<c:forEach var="customerType" items="${customerTypeEnumList}">
						            <option value="${customerType.id}" >${customerType.name}</option>
						        </c:forEach>
							</select>
						</td>
						
						<!-- 医院 -->
						<td class="hospitalTd" style="display: none; text-align: right;padding-right: 10px;"><span style="color: red">*</span>&nbsp;级&#12288;&#12288;别：</td>
						<td class="hospitalTd" style="display: none; ">
							<select name="hospitalGradeId" class="validate[required] inputText">
				            	<option value="">请选择</option>
				             	<c:forEach var="hospitalGrade" items="${dictTypeEnumHospitalGradeList}">
						            <option value="${hospitalGrade.dictId}" >${hospitalGrade.dictName}</option>
						        </c:forEach>
							</select>&nbsp;
							<select name="hospitalLevelId" class="inputText">
				            	<option value="">请选择</option>
				             	<c:forEach var="hospitalLevel" items="${dictTypeEnumHospitalLevelList}">
						            <option value="${hospitalLevel.dictId}" >${hospitalLevel.dictName}</option>
						        </c:forEach>
							</select>
						</td>
						<td class="hospitalTd" style="display: none; text-align: right;padding-right: 10px;">医院类型：</td>
						<td class="hospitalTd" colspan="3" style="display: none; line-height: 25px;">
							<c:forEach var="hospitalType" items="${dictTypeEnumHospitalTypeList}">
				             	<input name="hospitalTypeId" id="hospitalTypeId_${hospitalType.dictId}" type="checkBox" value="${hospitalType.dictId}"><label for="hospitalTypeId_${hospitalType.dictId}">&nbsp;${hospitalType.dictName}</label>&nbsp;
						    </c:forEach>
						</td>
						<!-- 学校 -->
						<td class="schoolTd" style="display: none; text-align: right;padding-right: 10px;">级&#12288;&#12288;别：</td>
						<td class="schoolTd" colspan="5" style="display: none; ">
							<c:forEach var="schoolType" items="${dictTypeEnumSchoolTypeList}">
				             	<input name=schoolTypeId id="schoolTypeId_${schoolType.dictId}" type="checkBox" value="${schoolType.dictId}" onchange="selectSingle(this)"><label for="schoolTypeId_${schoolType.dictId}">&nbsp;${schoolType.dictName}</label>&#12288;
						    </c:forEach>
						</td>
					</tr>
					
					<tr>	
						<td style="text-align: right;padding-right: 10px;">合同客户：</td>
						<td id="isContractTd" colspan="7">
							<input name="isContract" id="isContract_Y" type="checkBox" value="${GlobalConstant.FLAG_Y}" onchange="selectContract(this);"><label for="isContract_Y">&nbsp;是</label>&#12288;
							<input name="isContract" id="isContract_N" type="checkBox" value="${GlobalConstant.FLAG_N}" onchange="selectContract(this);" checked><label for="isContract_N">&nbsp;否</label>&#12288;
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
						<td style="text-align: right;padding-right: 10px;">备&#12288;&#12288;注：</td>
				     	<td colspan="7" style="text-align:left;padding-left: 3px;">
				     		<textarea name="remark" placeholder="请输入客户备注" class="validate[maxSize[250]] xltxtarea"></textarea>
				     	</td>
				    </tr>
				</table>
			</form>
			
			<form id="customerUserForm">
				<table cellpadding="0" cellspacing="0" class="xllist" style="width: 100%;border-top: 0px;">
					<colgroup>
						<col width="3%"/>
						<col width="6%"/>
						<col width="5%"/>
						<col width="7%"/>
						<col width="9%"/>
						<!-- <col width="11%"/>
						<col width="8%"/> -->
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="9%"/>
						<col width="7%"/>
						<col width="10%"/>
					</colgroup>
					<tr>
						<th colspan="13" style="text-align: left;padding-left: 10px">联系人信息
							<img title="删除" src="<s:url value="/css/skin/${skinPath}/images/del1.png" />" style="float: right;margin-right: 20px;cursor: pointer;" onclick="del();"/>
							<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="float: right;margin-right: 10px;cursor: pointer;" onclick="add();"/>
						</th>
					</tr>
					<tr>
						<th></th>
						<th><span style="color: red">*</span>&nbsp;姓名</th>
						<th>性别</th>
						<th>科室</th>
						<th>职务</th>
						<!-- <th>身份证号</th>
						<th>出生日期</th> -->
						<th>固话</th>
						<th>手机</th>		
						<th>邮箱</th>
						<th>QQ</th>
						<th>部门负责人</th>		
						<th>备注</th>		
					</tr>
					<tbody id="customerUserTb">
					
					</tbody>
				</table>
				<div class="button" style="width: 100%;">
					<input class="search" type="button" id="saveButton" value="保&#12288;存" onclick="save();" />
				</div>
			</form>
			</div>
		</div>
	</div>
</div>
</div>
<table style="display: none;" id="clone">
	<tr>
		<td width="3%;"><input type="checkbox" name="userFlow" value=""/></td>
		<td width="6%;"><input type="text" name="userName" class="validate[required,maxSize[10]] inputText" onchange="checkCustomerUserName(this);" style="width:90%;"/></td>
		<td width="5%;">
			<select name="sexId" class="inputText" style="width:90%;">
				<c:forEach var="userSex" items="${userSexEnumList}">
					<c:if test="${userSex.id != userSexEnumUnknown.id}">
						<option value="${userSex.id}" >${userSex.name}</option>
					</c:if>
				</c:forEach>
				<option value=""></option>
			</select>
		</td>
		<td width="7%;"><input type="text" name="deptName" class="validate[maxSize[50]] inputText" style="width:90%;"/></td>
		<td width="9%;"><input name="postName" type="text" class="validate[maxSize[25]] inputText" style="width:90%;"/></td>
		<!-- <td width="11%;"><input name="idNo" type="text" class="validate[custom[chinaId]] inputText" style="width:90%;" onblur="writeBirthday(this)"/></td>
		<td width="8%;">
			<input name="birthday" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:90%;" class="validate[custom[dateFormat]] inputText" type="text"/>
		</td> -->
		<td width="10%;"><input name="userTelphone" type="text" class="validate[custom[phone2]] inputText" style="width:90%;"/></td>
		<td width="10%;"><input name="userCelphone" type="text" class="validate[custom[mobile]] inputText" style="width:90%;"/></td>
		<td width="10%;"><input name="userEmail" type="text" class="validate[custom[email],maxSize[50]] inputText" style="width:90%;"/></td>
		<td width="9%;"><input name="userQq" type="text" class="validate[custom[qq]] inputText" style="width:90%;"/></td>
		<td width="7%;">
			<select name="isMain" class="inputText" style="width:90%;">
				<option value=""></option>
				<option value="${GlobalConstant.FLAG_Y}">是</option>
				<option value="${GlobalConstant.FLAG_N}">否</option>
			</select>
		</td>
		<td width="10%;"><input name="remark" type="text" class="validate[maxSize[100]] inputText" style="width:90%;"/></td>
	</tr>
</table>
</body>
</html>