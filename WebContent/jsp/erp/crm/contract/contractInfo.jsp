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
	<jsp:param name="jquery_mask" value="true"/>
</jsp:include>
<script type="text/javascript" src="<s:url value='/js/j.suggest.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
$(document).ready(function(){
	moneyMask();
});

function doBack(){
	if ("add"=="${param.source}") {
		window.parent.frames["mainIframe"].window.location.reload();
	}else{
		var page = $("#currentPage2",window.top.frames["mainIframe"].document).val();
		if(page==null){
			page=1;
		}
		window.parent.frames["mainIframe"].window.toPage(page);
	}
	jboxCloseMessager();
}

function moneyMask(){
	var moneyBox=$(".money");
	$.each(moneyBox,function(i,n){
		$(n).mask('000,000,000,000,000', {reverse: true});
	});
	
}

function editContractInfo(contractFlow) {
	var mainIframe = window.parent.frames["mainIframe"];
	var width = mainIframe.document.body.scrollWidth;
	jboxOpen("<s:url value='/erp/crm/editContractInfo'/>?contractFlow="+contractFlow,"编辑合同信息", width, 600);
}

function editProduct(contractFlow) {
	jboxOpen("<s:url value='/erp/crm/editProduct'/>?contractFlow="+contractFlow,"编辑合同产品", 1000, 500);
}

function editLinkMan(contractFlow) {
	var mainIframe = window.parent.frames["mainIframe"];
	var width = mainIframe.document.body.scrollWidth;
	jboxOpen("<s:url value='/erp/crm/editLinkMan'/>?contractFlow="+contractFlow,"编辑联系人信息", width, 400);
}

function readLinkMan(recordFlow,contractFlow) {
	if(recordFlow!=""){
		jboxOpen("<s:url value='/erp/crm/readLinkMan'/>?recordFlow="+recordFlow+"&customerFlow=${resultMap['contractExt'].customerFlow }","编辑联系人", 800, 400);
	}else{
		jboxOpen("<s:url value='/erp/crm/readLinkMan'/>?recordFlow="+recordFlow+"&contractFlow="+contractFlow+"&customerFlow=${resultMap['contractExt'].customerFlow }","新增联系人", 800, 400);
	}
	
}

function editPayPlan(contractFlow) {
	jboxOpen("<s:url value='/erp/crm/editPayPlan'/>?contractFlow="+contractFlow,"编辑回款计划", 800, 400);
}

function payPlanList() {
	window.location.href="<s:url value='/erp/crm/payPlanList'/>";
}
function search(){
	var form=$("#clientForm");
	form.submit();
}
function contractInfo(contractFlow) {
	var mainIframe = window.parent.frames["mainIframe"];
	var width = mainIframe.document.body.scrollWidth;
	if (width >1100) {
		width = 1000;
	}
	var url = "<s:url value='/erp/crm/contractInfo'/>?contractFlow="+contractFlow+"&status=main&type=open";
	jboxOpen(url, "合同详细信息", width, 600);
}
function searchUser(){
	$("#clientForm").submit();
}
function updateStatus(flag,recordFlow,userName){
	var msg = "";
	if (flag == '${GlobalConstant.RECORD_STATUS_N}') {
		msg = "停用";
	} else if (flag == '${GlobalConstant.RECORD_STATUS_Y}') {
		msg = "启用";
	}else if (flag == '${GlobalConstant.RECORD_STATUS_D}') {
		msg = "删除";
	}
	msg = "确认" + msg + "联系人&nbsp;<b>"+userName+"</b>&nbsp;" + "吗？";
	jboxConfirm(msg,function () {
		var url = "<s:url value='/erp/crm/changeContractUserStatus'/>?recordFlow=" + recordFlow + "&flag=" + flag;
		jboxPost(url, null,
				function(resp){
					if(resp == "${GlobalConstant.OPERATE_SUCCESSED}"){
						search();
						jboxTip("${GlobalConstant.OPERATE_SUCCESSED}"); 
					}
				},null,true);	
	});
}
function searchCustomerLinkMan(customerFlow,contractFlow) {
	 if(customerFlow==""){
		jboxTip("请先填写正确的客户名称！"); 
	 }else{
		jboxOpen("<s:url value='/erp/crm/searchCustomerLinkManList'/>?customerFlow="+customerFlow+"&contractFlow="+contractFlow,"客户联系人", 600, 400); 
	 }
}
function updateToCustomerUser(recordFlow,userName,customerFlow){
	var data = {
			userName:userName
		};
	jboxPost("<s:url value='/erp/crm/customerUserNameConfirm'/>?customerFlow="+customerFlow,data,function(resp){
		if(resp == '${GlobalConstant.OPRE_SUCCESSED}'){
			var url="<s:url value='/erp/crm/updateToCustomerUser'/>?recordFlow="+recordFlow+"&customerFlow="+customerFlow;
			var msg="确认将 "+userName+" 同步到客户联系人？";
			jboxConfirm(msg,function () {
				jboxPost(url, null,
						function(resp){
							if(resp == "${GlobalConstant.OPERATE_SUCCESSED}"){
								search();
							}
						},null,true);	
			});
		} else if(resp == "${GlobalConstant.OPRE_FAIL}"){
			jboxInfo("当前客户已存在该联系人，不能同步!");
		}
	},null,false);
}

function customerInfo(customerFlow,customerName){
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/crm/customerInfo'/>?customerFlow=" + customerFlow+"&type=open&no=third";
	jboxOpen(url,customerName, w, h); 
}

function addIn(contractFlow, planFlow) {
	var msg = "到账";
	var contractCategoryId = "${resultMap['contractExt'].contractCategoryId}";
	if("${contractCategoryEnumPurchase.id}" == contractCategoryId){
		msg = "付款";
	}
	var url = "<s:url value='/erp/sales/addIn'/>?contractFlow=" + contractFlow + "&planFlow=" + planFlow + "&contractCategoryId=" + contractCategoryId;
	jboxOpen(url,"新增" + msg, 400, 200);
}

function billInfo() {
	jboxOpen("<s:url value='/erp/sales/editBill'/>","发票单详情", 850, 420);
}
</script>
</head>
<body>
<div class="mainright">
<div class="content">
	<div class="title1 clearfix">
			<form id="clientForm" method="post" action="<s:url value="/erp/crm/contractInfo" />">
				<input type="hidden" name="contractFlow" value="${resultMap['contractExt'].contractFlow }">
				<input type="hidden" name="type" value="${param.type }"/>
				<input type="hidden" name="status" value="${param.status }"/>
				<input type="hidden" name="source" value="${param.source }"/>
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<colgroup>
						<col width="10%"/>
						<col width="20%"/>
						<col width="10%"/>
						<col width="20%"/>
						<col width="10%"/>
						<col width="20%"/>
					</colgroup>
					<tr>
						<th colspan="6" style="text-align: left;padding-left: 10px">合同信息
						<c:if test="${not empty resultMap['contractExt'].contractNo }">&#12288;[${resultMap['contractExt'].contractNo }]</c:if>
						<c:if test="${'open' != param.type }">
						<img title="编辑" src="<s:url value="/css/skin/${skinPath}/images/gcp_main_edit.png" />" style="float: right;margin-right: 10px;cursor: pointer;" onclick="editContractInfo('${resultMap['contractExt'].contractFlow }');"/>
						</c:if>
						</th>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">合同类别：</td>
						<td>${resultMap['contractExt'].contractCategoryName }</td>
						<%-- <c:when test="${resultMap['contractExt'].contractCategoryId != contractCategoryEnumPurchase.id and contractExt.contractCategoryId != contractCategoryEnumTrialAgreement.id and resultMap['contractExt'].contractCategoryId != contractCategoryEnumSell.id}">  --%>
						<td style="text-align: right;padding-right: 10px;">合同类型：</td>
						<td>${resultMap['contractExt'].contractTypeName }</td>
						<%--  </c:when> --%>
						<c:choose>
						 <c:when test="${resultMap['contractExt'].contractCategoryId == contractCategoryEnumSell.id }"> 
						<td style="text-align: right;padding-right: 10px;">经 销 商：</td>
						<td><a href="javascript:customerInfo('${resultMap['contractExt'].consumerFlow }','${resultMap['contractExt'].consumerName }')">${resultMap['contractExt'].consumerName }</a></td>
						 </c:when>
						 <c:otherwise>
						  <td></td>
						  <td></td>
						 </c:otherwise>
						</c:choose>
					</tr>
					<tr>
					    <td style="text-align: right;padding-right: 10px;">
					     <c:choose>
					      <c:when test="${(resultMap['contractExt'].contractCategoryId eq contractCategoryEnumSales.id) or (resultMap['contractExt'].contractCategoryId eq contractCategoryEnumSecond.id) or (resultMap['contractExt'].contractCategoryId eq contractCategoryEnumTrialAgreement.id)}">
					                    买&#12288;&#12288;方：
					      </c:when>
					      <c:otherwise>
					       <c:choose>
					         <c:when test="${resultMap['contractExt'].contractCategoryId eq contractCategoryEnumSell.id}">
					                                  使&nbsp;用&nbsp;&nbsp;方：
					         </c:when>
					         <c:otherwise>
					                                   卖&#12288;&#12288;方：
					         </c:otherwise>
					        </c:choose>
					      </c:otherwise>
					     </c:choose>
					    </td>
						<td>
						   <c:if test="${param.status!='main' }">
						     <a href="javascript:customerInfo('${resultMap['contractExt'].customer.customerFlow }','${resultMap['contractExt'].customer.customerName }')">${resultMap['contractExt'].customer.customerName }</a>
						   </c:if>
						   <c:if test="${param.status=='main' }">
						      ${resultMap['contractExt'].customer.customerName }
						   </c:if>
						</td>
						<td style="text-align: right;padding-right: 10px;">使用部门：</td>
						<td>${resultMap['contractExt'].customerDept}</td>
					    <td style="text-align: right;padding-right: 10px;">合同名称：</td>
						<td>${resultMap['contractExt'].contractName}</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">
						    <c:choose>
					         <c:when test="${(resultMap['contractExt'].contractCategoryId eq contractCategoryEnumSales.id) or (resultMap['contractExt'].contractCategoryId eq contractCategoryEnumSecond.id) or (resultMap['contractExt'].contractCategoryId eq contractCategoryEnumTrialAgreement.id) or (resultMap['contractExt'].contractCategoryId eq contractCategoryEnumSell.id)}">
					                          卖&#12288;&#12288;方：
					         </c:when>
					        <c:otherwise>
					                           买&#12288;&#12288;方：
					        </c:otherwise>
					     </c:choose>
						</td>
						<td>
							${resultMap['contractExt'].contractOwnName }
						</td>
						<td style="text-align: right;padding-right: 10px;">负责部门：</td>
						<td>${resultMap['contractExt'].signDeptName}</td>
						<td style="text-align: right;padding-right: 10px;">合同负责人：</td>
						<td>${resultMap['contractExt'].chargeUserName}</td>
					</tr>
					<tr>
					    <td style="text-align: right;padding-right: 10px;">签&nbsp;订&nbsp;人：</td>
						<td>${resultMap['contractExt'].signUserName}</td>
						<td style="text-align: right;padding-right: 10px;">签订日期：</td>
						<td>${resultMap['contractExt'].signDate}</td>
						<td style="text-align: right;padding-right: 10px;">合同到期日：</td>
						<td>${resultMap['contractExt'].contractDueDate}</td>
					</tr>
					<tr>
					    <td style="text-align: right;padding-right: 10px;">维护到期日：</td>
						<td>${resultMap['contractExt'].maintainDueDate}</td>
					    <td style="text-align: right;padding-right: 10px;">合同金额：</td>
						<td><label class="money">${resultMap['contractExt'].contractFund}</label>元</td>
						<td style="text-align: right;padding-right: 10px;">合同状态：</td>
						<td>${resultMap['contractExt'].contractStatusName}</td>
					</tr>
					<tr>
					    <td style="text-align: right;padding-right: 10px;">电子原件：</td>
						<td colspan="5">
						  <c:if test="${not empty resultMap['contractExt'].contractFileFlow }">
						   <a id="down" href='<s:url value="/pub/file/down?fileFlow=${resultMap['contractExt'].contractFileFlow}"/>'>${resultMap['file'].fileName}</a>
						  </c:if>
						</td>
					</tr>
					<c:if test="${resultMap['contractExt'].contractCategoryId eq contractCategoryEnumSecond.id }">
					<tr>
					    <td style="text-align: right;padding-right: 10px;">关联主合同：</td>
					    <td colspan="5">
					       <c:if test="${empty resultMap['mainRefExtList'] }">
					                               无记录
					       </c:if>
					       <c:forEach items="${resultMap['mainRefExtList'] }" var="ref" varStatus="num">
					          <span style="line-height: 25px;">${num.count }.&#12288;
					          <c:if test="${param.status=='main' }">
					            <c:if test="${not empty ref.contract.contractNo }">${ref.contract.contractNo }：</c:if>${ref.contract.contractName }
					          </c:if>
					          <c:if test="${param.status!='main' }"> 
					            <a href="javascript:contractInfo('${ref.contract.contractFlow }');"><c:if test="${not empty ref.contract.contractNo }">${ref.contract.contractNo }：</c:if>${ref.contract.contractName }</a>
					          </c:if>
					          </span><br/>
					        
					       </c:forEach>
					    </td> 
					</tr>
					</c:if>
					<c:if test="${resultMap['contractExt'].subCount>0 }">
					   <tr>
					    <td style="text-align: right;padding-right: 10px;">相关子合同：</td>
					    <td colspan="5">
					       <c:if test="${empty resultMap['subRefExtList'] }">
					                               无记录
					       </c:if>
					       <c:forEach items="${resultMap['subRefExtList'] }" var="ref" varStatus="num">
					          <span style="line-height: 25px;">${num.count }.&#12288;
					          <c:if test="${param.status=='main' }">
					            <c:if test="${not empty ref.contract.contractNo }">${ref.contract.contractNo }：</c:if>${ref.contract.contractName }
					          </c:if>
					          <c:if test="${param.status!='main' }"> 
					            <a href="javascript:contractInfo('${ref.contract.contractFlow }');"><c:if test="${not empty ref.contract.contractNo }">${ref.contract.contractNo }：</c:if>${ref.contract.contractName }</a>
					          </c:if>
					          </span><br/>
					       </c:forEach>
					    </td> 
					</tr>
					 </c:if>
				</table>
				
				<table cellpadding="0" cellspacing="0" class="xllist" style="width: 100%;border-top: 0px;">
					<colgroup>
						<col width="3%"/>
						<col width="25%"/>
						<col width="20%"/>
						<col width="12%"/>
						<col width="15%"/>
						<col width="10%"/>
						<col width="15%"/>
					</colgroup>
					<tr>
						<th colspan="7" style="text-align: left;padding-left: 10px">合同产品
						<c:if test="${'open' != param.type }">
						<img title="编辑" src="<s:url value="/css/skin/${skinPath}/images/gcp_main_edit.png" />" style="float: right;margin-right: 20px;cursor: pointer;" onclick="editProduct('${resultMap['contractExt'].contractFlow }');"/>
						</c:if>
						</th>
					</tr>
					<tr>
						<th></th>
						<th>产品/项目名称</th>
						<th>备注</th>
						<!-- <th>使用人</th> -->
						<th>安装地点</th>
						<th>版本号</th>
						<th>注册文件客户名</th>
						<th>注册文件有效期</th>
					</tr>
					<tbody>
					  <c:forEach items="${resultMap['productList']}" var="product" varStatus="num">
						<tr>
							<td>${num.count }</td>
							<td>${product.productTypeName }</td>
							<td>${product.productItem }</td>
							<%-- <td>
							  <c:forEach items="${resultMap['productUserMap'][product.productFlow] }" var="user" varStatus="num">
							       ${user.userName }
							       <c:if test="${!num.last }">，</c:if>
							  </c:forEach>
							</td> --%>
							<td>
							   ${product.installPlace }
							</td>
							<td>
							   ${product.versions }
							</td>
							<td>
							   ${product.regFileClientName }
							</td>
							<td>
							   ${product.regFileIndate }
							</td>
						</tr>
					  </c:forEach>
					</tbody>
				</table>
				<table cellpadding="0" cellspacing="0" class="xllist" style="width: 100%;border-top: 0px;">
					<colgroup>
						<col width="3%"/>
						<col width="8%"/>
						<col width="5%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="7%"/>
						<col width="11%"/>
						<col width="11%"/>
						<col width="15%"/>
						<!-- <col width="10%"/> -->
						<col width="7%"/>
						<c:if test="${'open' != param.type or userEdit == GlobalConstant.FLAG_Y}">
						<col width="13%"/>
						</c:if>
					</colgroup>
					<tr>
						<th colspan="11" style="text-align: left;padding-left: 10px">联系人信息
						<c:if test="${'open' != param.type or param.userEdit == GlobalConstant.FLAG_Y}">
							<img title="编辑" src="<s:url value="/css/skin/${skinPath}/images/gcp_main_edit.png" />" style="float: right;margin-right: 20px;cursor: pointer;" onclick="editLinkMan('${resultMap['contractExt'].contractFlow }');"/>
							<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="float: right;margin-right: 10px;cursor: pointer;" onclick="readLinkMan('','${resultMap['contractExt'].contractFlow }');"/>
							<img title="选择客户联系人" src="<s:url value="/css/skin/${skinPath}/images/add_user.png" />" style="float: right;margin-right: 10px;cursor: pointer;"
							 <c:choose>
							   <c:when test="${resultMap['contractExt'].contractCategoryId eq contractCategoryEnumSell.id }">
							      onclick="searchCustomerLinkMan('${resultMap['contractExt'].consumerFlow }','${resultMap['contractExt'].contractFlow }');"
							   </c:when>
							   <c:otherwise>
							      onclick="searchCustomerLinkMan('${resultMap['contractExt'].customer.customerFlow }','${resultMap['contractExt'].contractFlow }');" 
							   </c:otherwise>  
							 </c:choose>/>
						</c:if>
						</th>
					</tr>
					<tr>
						<th colspan="11" style="text-align: left;padding-left: 10px">
						
						科室：<input type="text" name="deptName" value="${param.deptName }" style="width: 100px;"/>&#12288;
						姓名：<input type="text" name="userName" value="${param.userName }" style="width: 100px;"/>&#12288;
						<img title="点击查询" src="<s:url value="/css/skin/${skinPath}/images/search.gif" />" style="cursor: pointer;" onclick="searchUser();" />
						</th>
					</tr>
					<tr>
						<th></th>
						<th>姓名</th>
						<th>性别</th>
						<th>科室</th>
						<th>职务</th>
						<th>人员类别</th>
						<th>固话</th>
						<th>手机</th>		
						<th>邮箱</th>
						<!-- <th>QQ</th> -->
						<th>主要联系人</th>	
						<c:if test="${'open' != param.type or param.userEdit == GlobalConstant.FLAG_Y}">
						<th>操作</th>
						</c:if>
					</tr>
					<tbody id="linkManTb">
					 <c:if test="${empty resultMap['userList'] }">
					   <tr>
					     <td colspan="11">无记录</td>
					   </tr>
					 </c:if>
					 <c:forEach items="${resultMap['userList'] }" var="user" varStatus="num">
						<tr <c:if test="${user.recordStatus eq GlobalConstant.FLAG_N}"> style="background-color:#eeeeee;"</c:if>>
							<td>
							  ${num.count }
							  <input type="hidden" name="userFlow" value="${user.userFlow }"/>
							  <input type="hidden" name="recordFlow" value="${user.recordFlow }">
							</td>
							<td>${user.customerUser.userName }</td>
							<td>${user.customerUser.sexName }</td>
							<td>${user.customerUser.deptName }</td>
							<td>${user.customerUser.postName }</td>
							<td>${user.userCategoryName }</td>
							<td>${user.customerUser.userTelphone }</td>
							<td>${user.customerUser.userCelphone }</td>
							<td>${user.customerUser.userEmail }</td>
							<%-- <td>${user.userQq }</td> --%>
							<td>
							 <c:if test="${user.isMain eq GlobalConstant.RECORD_STATUS_Y }">是</c:if>
							 <c:if test="${user.isMain eq GlobalConstant.RECORD_STATUS_N }">否</c:if>
							</td>
							<c:if test="${'open' != param.type or param.userEdit == GlobalConstant.FLAG_Y}">
								<td style="text-align: left;padding-left: 5px;">
								 <c:if test="${user.recordStatus eq GlobalConstant.RECORD_STATUS_Y }">
								   <a href="javascript:void(0);" onclick="readLinkMan('${user.recordFlow }','${user.userName }','');"> [编辑]</a>&nbsp;|
								 </c:if>
								 <c:choose>
								  <c:when test="${user.recordStatus eq GlobalConstant.RECORD_STATUS_Y }">
								   <a href="javascript:void(0);" onclick="updateStatus('${GlobalConstant.RECORD_STATUS_N}','${user.recordFlow }','${user.userName }');"> [停用]</a>
								  </c:when>
								  <c:when test="${user.recordStatus eq GlobalConstant.RECORD_STATUS_N }">
								   <a href="javascript:void(0);" onclick="updateStatus('${GlobalConstant.RECORD_STATUS_Y}','${user.recordFlow }','${user.userName }');"> [启用]</a>
								  </c:when>
								  </c:choose>
								<%--   <c:if test="${pdfn:contain(user.recordFlow,resultMap['customerUserFlowList']) == false and pdfn:contain(user.userFlow,resultMap['customerUserFlowList']) == false and (pdfn:contain('action-erp-swgl-crmhtgl-crmhtcx-tblxr', sessionScope.currUserMenuIdList) or sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE or pdfn:contain('action-erp-zjl-crmhtgl-crmhtcx-tblxr', sessionScope.currUserMenuIdList)) and (user.recordStatus eq GlobalConstant.RECORD_STATUS_Y)}">
								      |&nbsp;<a href="javascript:void(0);" onclick="updateToCustomerUser('${user.recordFlow}','${user.userName }','${resultMap['contractExt'].customer.customerFlow }');">[同步]</a>
								  </c:if> --%>
								  <c:if test="${(pdfn:contain('action-erp-zjl-crmhtgl-crmhtcx-sclxr', sessionScope.currUserMenuIdList) and sessionScope[GlobalConstant.USER_LIST_SCOPE] == GlobalConstant.USER_LIST_CHARGE) or sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE}">
								      |&nbsp;<a href="javascript:void(0);" onclick="updateStatus('${GlobalConstant.RECORD_STATUS_D}','${user.recordFlow }','${user.userName }');">[删除]</a>
								  </c:if>
								</td>
							</c:if>
						</tr>
					 </c:forEach>	
					</tbody>
				</table>
				<table cellpadding="0" cellspacing="0" class="xllist" style="width: 100%;border-top: 0px;">
					<c:if test="${'open' != param.type }">
					<colgroup>
						<col width="3%"/>
						<col width="19%"/>
						<col width="19%"/>
						<col width="19%"/>
						<col width="19%"/>
						<col width="21%"/>
					</colgroup>
					<tr>
						<th colspan="6" style="text-align: left;padding-left: 10px">款项执行计划
						<c:if test="${'open' != param.type }">
						<img title="编辑" src="<s:url value="/css/skin/${skinPath}/images/gcp_main_edit.png" />" style="float: right;margin-right: 20px;cursor: pointer;" onclick="editPayPlan('${resultMap['contractExt'].contractFlow }');"/>
						</c:if>
						</th>
					</tr>
					</c:if>
					<c:if test="${'open' == param.type }">
					<colgroup>
						<col width="3%"/>
						<col width="24%"/>
						<col width="24%"/>
						<col width="24%"/>
						<col width="25%"/>
					</colgroup>
					<tr>
						<th colspan="5" style="text-align: left;padding-left: 10px">款项执行计划
						<c:if test="${'open' != param.type }">
						<img title="编辑" src="<s:url value="/css/skin/${skinPath}/images/gcp_main_edit.png" />" style="float: right;margin-right: 20px;cursor: pointer;" onclick="editPayPlan('${resultMap['contractExt'].contractFlow }');"/>
						</c:if>
						</th>
					</tr>
					</c:if>
					<tr>
						<th></th>
						<th>计划日期</th>
						<th>计划金额</th>
						<th>
							<c:set var="contractCategoryId" value="${resultMap['contractExt'].contractCategoryId}"/>
							<c:if test="${contractCategoryId == contractCategoryEnumPurchase.id}">付款金额</c:if>
							<c:if test="${contractCategoryId != contractCategoryEnumPurchase.id}">到账金额</c:if>
						</th>
						<th>状态</th>
						<c:if test="${'open' != param.type }">
						<th>操作</th>
						</c:if>
					</tr>
					<tbody>
					<c:if test="${empty resultMap['payPlanList']}">
					   <tr>
					     <td colspan="6">无记录</td>
					   </tr>
					</c:if>
					<c:forEach items="${resultMap['payPlanList'] }" var="payPlan" varStatus="num">
						<tr>
							<td>${num.count}</td>
							<td>${payPlan.planDate}</td>
							<td><label class="money">${payPlan.payFund}</label>元</td>
							<%-- <td>${payPlan.planStatusName }</td> --%>
							<td><label class="money">${payPlan.balanceFund}</label>元</td>
							<td>${payPlan.planStatusName}</td>
							<td>
								<c:if test="${payPlan.payFund > payPlan.balanceFund and 'open' != param.type}">
									<a href="javascript:void(0);" onclick="addIn('${payPlan.contractFlow}','${payPlan.planFlow}');">
									[<c:if test="${contractCategoryId == contractCategoryEnumPurchase.id}">新增付款</c:if>
									 <c:if test="${contractCategoryId != contractCategoryEnumPurchase.id}">新增到账</c:if>]
									</a>
								</c:if>
							</td>
						</tr>
						<c:forEach items="${resultMap['balanceMap'][payPlan.planFlow]}" var="payBalance" varStatus="status">
						<tr>
							<td colspan="6">
								<ul>
									<li>
										<span style="display:inline-block;text-align:left;width: 3%;"></span>
										<span>
										[${status.count}]&nbsp;${payBalance.payDate}&nbsp;
										<c:if test="${contractCategoryId == contractCategoryEnumPurchase.id}">付款</c:if>
										<c:if test="${contractCategoryId != contractCategoryEnumPurchase.id}">到账</c:if>
										&nbsp;<label class="money">${payBalance.payFund}</label>元&#12288;
										<!-- <a href="javascript:void(0);" onclick="billInfo();"> [发票单]</a> -->
										</span>
									</li>
								</ul>
							</td>
						</tr>
						</c:forEach>
				    </c:forEach>
					</tbody>
				</table>
				<div class="button" style="width: 100%">
					<c:if test="${'main' == param.status }">
						<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
					</c:if>
					<c:if test="${'main' != param.status and 'messager' != param.status}">
						<input class="search" type="button" value="关&#12288;闭" onclick="doBack();" />
					</c:if>
					<c:if test="${'messager' == param.status }">
				          <input class="search" type="button" value="关&#12288;闭" onclick="jboxCloseMessager();"/>
				    </c:if>
				</div>
			</form>
			</div>
		</div>
	</div>
</body>
</html>