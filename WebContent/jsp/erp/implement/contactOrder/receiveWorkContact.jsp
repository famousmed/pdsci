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
<script type="text/javascript">
function customerInfo(customerFlow,customerName){
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/crm/customerInfo'/>?customerFlow=" + customerFlow+"&type=open&no=third";
	jboxOpen(url,customerName, w, h); 
}
function contractInfo(contractFlow) {
	var mainIframe = window.parent.frames["mainIframe"];
	var width = mainIframe.document.body.scrollWidth;
	var url = "<s:url value='/erp/crm/contractInfo'/>?contractFlow="+contractFlow+"&status=main&type=open";
	jboxOpen(url, "合同详细信息", width, 600);
}

function lastContactOrder(contactFlow){
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/sales/contactOrderInfo'/>?contactFlow=" + contactFlow;
	jboxOpen(url, "末次工作联系单详情", w, 600);
}
function reassign(contactFlow) {
		var url = "<s:url value='/erp/implement/reassign'/>?contactFlow="+contactFlow;
		jboxOpen(url,"改派联系单", 400, 100);
}
function saveReceive(){
	if($("#implementForm").validationEngine("validate")){
	var tip="确认接收？";
	jboxConfirm(tip , function(){
		var url = "<s:url value='/erp/implement/saveReassign'/>?receiveFlag=Y";
		jboxPost(url , $("#implementForm").serialize() , function(resp){
			if(resp!='${GlobalConstant.SAVE_FAIL}'){
				jboxTip('${GlobalConstant.OPRE_SUCCESSED}');
				window.parent.frames['mainIframe'].$("#checkContactFlow").val(resp);
				setTimeout(function(){
					window.parent.frames['mainIframe'].window.search();
					jboxCloseMessager();
				},1000);
			}else{
				jboxTip('${GlobalConstant.OPRE_FAIL}');
			}
		} , null, false);
	});
	}
}
function selectSingle(obj) {
	var value = $(obj).val();
	var name = $(obj).attr("name");
	$("input[name="+name+"][value!="+value+"]:checked").attr("checked",false);
}

$(document).ready(function(){
	var contactFlow='${contactOrder.contactFlow}';
	var url="<s:url value='/erp/sales/loadContactOrderContent'/>?contactFlow="+contactFlow;
	jboxLoad("contentDiv", url, false);
});


</script>
</head>
<body>
<div class="mainright">
<div class="content">
	<div class="title1 clearfix">
			<form id="implementForm">
			    <input type="hidden" name="contactFlow" value="${contactOrder.contactFlow }"/>
				<div id="contentDiv"></div>
				<table width="100%" cellpadding="0" cellspacing="0" class="basic" style="border-top:none;">
					<colgroup>
						<col width="12%"/>
						<col width="25%"/>
						<col width="11%"/>
						<col width="22%"/>
						<col width="10%"/>
						<col width="20%"/>
					</colgroup>	
					  <c:if test="${not empty auditForm.auditContent}">
						<tr>
							<td style="text-align: right;padding-right: 10px;line-height: 25px;">销售意见<br/>/需求&#12288;</td>
							<td colspan="5">
							    <%-- <c:forEach items="${contactOrderForm.auditList }" var="audit">
							        <c:if test="${audit.auditStatusId eq contactOrderStatusEnumSalePassed.id }">
							            ${audit.auditContent }
							        </c:if>
							    </c:forEach> --%>  
					            ${auditForm.auditContent }
							</td>
						</tr>
					  </c:if>
					  <c:if test="${not empty businessAuditForm.auditContent}">
						<tr>
							<td style="text-align: right;padding-right: 10px;" rowspan="2">商务审核</td>
							<td colspan="2">
							            维护到期日： ${erpContract.maintainDueDate }
							</td>
							<td colspan="3">
							 <c:if test="${not empty lastContactOrder.contactFlow and lastContactOrder.contactFlow != contactOrder.contactFlow }">   
							            末次更新时间：${lastContactOrder.applyDate }
							     <span title="末次工作联系单详情" style="margin-right: 10px;cursor: pointer;" onclick="lastContactOrder('${lastContactOrder.contactFlow}');">>></span>
							    </c:if>
							 
							</td>
						</tr>
						<tr>
							<td colspan="5">
								意见：${businessAuditForm.auditContent}
							</td>
						</tr>
						</c:if>
				    <c:if test="${not empty managerAuditForm.auditContent}">
						<tr>
							<td style="text-align: right;padding-right: 10px;">总经理意见</td>
							<td colspan="5">${managerAuditForm.auditContent}</td>
						</tr>
					</c:if>
					<tr>
						<td style="text-align: right;padding-right: 10px;" rowspan="2">
							<font color="red">${sessionScope.currUser.deptName }<br/>处理进度</font>
						</td>
						<td colspan="2">
							预计解决时间：<input name="planFinishTime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="text-align:left;"<c:if test="${not empty contactOrderForm.disposeForm.planFinishTime }">value="${contactOrderForm.disposeForm.planFinishTime }"</c:if> readonly="readonly" class="validate[custom[dateFormat]] inputText" type="text"/>
						</td>
						<td colspan="3">
							处理方式：
							<c:forEach var="dealType" items="${dealTypeEnumList}">
								<input type="checkbox" id="dt_${dealType.id }" name="method" value="${dealType.id }" <c:if test="${dealType.id eq contactOrderForm.disposeForm.method }">checked</c:if> onchange="selectSingle(this)"/><label for="dt_${dealType.id }">&nbsp;${dealType.name}</label>&#12288;
							</c:forEach>
						</td>
						</tr>
						<tr>
						<td colspan="5">
							意见：<input name="result" type="text" class="inputText validate[required]" style="width:765px;text-align: left;" value="${contactOrderForm.disposeForm.result }"/>
						</td>
					</tr>
					<tr>
					    <td style="text-align: right;padding-right: 10px;">申请部门</td>
						<td>${dept.deptName }</td>
						<td style="text-align: right;padding-right: 10px;">申&nbsp;请&nbsp;&nbsp;人</td>
						<td>${contactOrder.applyUserName }</td>
						<td style="text-align: right;padding-right: 10px;">申请时间</td>
						<td>${contactOrder.applyDate }</td>
					</tr>
				</table>
				<div class="button">
					<input type="button" value="接&#12288;收" onclick="saveReceive('${contactOrder.contactFlow}')" class="search"/>
					<input type="button" value="改&#12288;派" onclick="reassign('${contactOrder.contactFlow}');" class="search"/>
		       		<input type="button" value="关&#12288;闭" onclick="jboxCloseMessager();" class="search"/>
		    	</div>
			</form>
			</div>
		</div>
	</div>
</body>
</html>