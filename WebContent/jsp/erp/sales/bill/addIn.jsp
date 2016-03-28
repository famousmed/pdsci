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
	<jsp:param name="jquery_mask" value="true"/>
</jsp:include>
<script type="text/javascript">
$(document).ready(function(){
	moneyMask();
});

function moneyMask(){
	var moneyBox=$(".money");
	$.each(moneyBox,function(i,n){
		$(n).mask('000,000,000,000,000', {reverse: true});
	});
}

function reMoneyMask(){
	var moneyBox=$(".money");
	$.each(moneyBox,function(i,n){
		$(n).mask('000000000000000', {reverse: true});
	});
}

function save() {
	reMoneyMask();
	if(!$("#balanceForm").validationEngine("validate")){
		return false;
	}
	var url = "<s:url value='/erp/sales/saveBalance'/>?contractFlow=${param.contractFlow}&planFlow=${param.planFlow}";
	var msg = "到账";
	if("${param.contractCategoryId}" == "${contractCategoryEnumPurchase.id}"){
		msg = "付款";
	}
	jboxConfirm("确认保存"+msg+"金额? 保存后不可修改",  function(){
		jboxPost(url, $("#balanceForm").serialize(),
				function(resp){
					if("${GlobalConstant.SAVE_SUCCESSED}" == resp){
						setTimeout(function(){
							window.parent.frames['jbox-message-iframe'].window.search();
							jboxClose();
						},1000);
					}
				},null,true);
	});
}
</script>
</head>
<body>
<div class="mainright">
<div class="content">
	<div class="title1 clearfix">
			<form id="balanceForm" >
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<colgroup>
						<col width="30%"/>
						<col width="70%"/>
					</colgroup>
					<tr>
						<td style="text-align: right;padding-right: 10px;">
							<c:if test="${param.contractCategoryId == contractCategoryEnumPurchase.id}">付款日期：</c:if>
							<c:if test="${param.contractCategoryId != contractCategoryEnumPurchase.id}">到账日期：</c:if>
						</td>
						<td>
							<input type="text" name="payDate" class="xltext ctime validate[required]" value="${pdfn:getCurrDate()}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">金&#12288;&#12288;额：</td>
						<td>
							<input type="text" name="payFund" class="xltext validate[required,custom[number],maxSize[9]] money" style="width: 140px;margin-right: 0;"/>&nbsp;元
		                </td>
					</tr>
				</table>
				<div class="button">
					<input class="search" type="button" value="保&#12288;存" onclick="save();" />
					<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
				</div>
			</form>
			</div>
		</div>
	</div>
</body>
</html>