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
function saveAudit(status) {
	if(!$("#implementForm").validationEngine("validate")){
		return false;
	}
	var tip="确认审核通过？";
	if(status=='${GlobalConstant.RECORD_STATUS_N}'){
		tip="确认审核不通过？";
	}
	if(status=='${GlobalConstant.FLAG_F}'){
		tip="确认提交至总经理审批？";
	}
	var url = "<s:url value='/erp/sales/saveContactOrderAudit'/>?status="+status;
	jboxConfirm(tip , function(){
		jboxPost(url , $('#implementForm').serialize() , function(resp){
			if(resp!='${GlobalConstant.SAVE_FAIL}'){
				jboxTip('${GlobalConstant.OPRE_SUCCESSED}');
				setTimeout(function(){
					window.parent.frames['mainIframe'].$("#checkContactFlow").val(resp);
					window.parent.frames['mainIframe'].window.search();
					jboxClose();
				},1000);
			}else{
				jboxTip('${GlobalConstant.OPRE_FAIL}');
			}
		} , null  , false);
	});
}

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
	var url = "<s:url value='/erp/sales/lastContactOrder'/>?contactFlow=" + contactFlow;
	jboxOpen(url, "末次工作联系单详情", w, 600);
}

function auditOpinion(contactFlow){
	var url="<s:url value='/erp/sales/contactOrderAuditOpinion'/>?contactFlow="+contactFlow;
	jboxOpen(url,"审核记录", 700, 400);
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
						<col width="10%"/>
						<col width="25%"/>
						<col width="11%"/>
						<col width="22%"/>
						<col width="10%"/>
						<col width="22%"/>
					</colgroup>	
					<c:choose>
					<c:when test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] == GlobalConstant.USER_LIST_PERSONAL }">
						<tr>
							<td style="text-align: right;padding-right: 10px;"><font color="red">销售意见<br/>/需求</font>&#12288;</td>
							<td colspan="5">
								<textarea rows="3" style="width: 95%;height: 93%;" name="auditContent" placeholder="请输入销售意见/需求" class="validate[maxSize[250],required]"></textarea>
							</td>
						</tr>
					</c:when>
					
					<c:when test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] == GlobalConstant.USER_LIST_LOCAL }">
						<c:if test="${not empty auditForm.auditContent}">
						<tr>
							<td style="text-align: right;padding-right: 10px;line-height: 25px;">销售意见<br/>/需求&#12288;</td>
							<td colspan="5">
					            ${auditForm.auditContent }
							</td>
						</tr>
						</c:if>
						<tr>
							<td style="text-align: right;padding-right: 10px;" rowspan="2"><font color="red">商务审核</font></td>
							<td colspan="2">
							            维护到期日： ${erpContract.maintainDueDate }
							</td>
							<td colspan="3">
							 <c:if test="${lastContactOrder.contactFlow != contactOrder.contactFlow}">   
							           末次更新时间：
							   <span title="末次工作联系单详情" style="margin-right: 10px;cursor: pointer;" onclick="lastContactOrder('${lastContactOrder.contactFlow}');">${lastContactOrder.applyDate}</span>
							 </c:if>
							</td>
						</tr>
						<tr>
							<td colspan="5">
								意见：<input type="text" name="auditContent" class="inputText validate[required]" style="width:90%;text-align: left;"/>
							</td>
						</tr>
					</c:when>
				
					<c:when test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] == GlobalConstant.USER_LIST_GLOBAL }">
						<c:if test="${not empty auditForm.auditContent}">
						<tr>
							<td style="text-align: right;padding-right: 10px;line-height: 25px;">销售意见<br/>/需求&#12288;</td>
							<td colspan="5">
							   ${auditForm.auditContent}
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
							 <c:if test="${lastContactOrder.contactFlow != contactOrder.contactFlow }">   
							           末次更新时间：
							   <span title="末次工作联系单详情" style="margin-right: 10px;cursor: pointer;" onclick="lastContactOrder('${lastContactOrder.contactFlow}');">${lastContactOrder.applyDate }</span>
							 </c:if>
							</td>
						</tr>
						<tr>
							<td colspan="5">意见：${businessAuditForm.auditContent}</td>
						</tr>
						</c:if>
						<tr>
							<td style="text-align: right;padding-right: 10px;"><font color="red">总经理意见</font></td>
							<td colspan="5"><input type="text" name="auditContent" class="inputText validate[required]" style="width:90%;text-align: left;"/></td>
						</tr>
					</c:when>
					<c:when test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.MANAGER_FLAG}">
					   <tr>
							<td style="text-align: right;padding-right: 10px;"><font color="red">总经理意见</font></td>
							<td colspan="5"><input type="text" name="auditContent" class="inputText validate[required]" style="width:90%;text-align: left;"/></td>
						</tr>
					</c:when>
					<c:when test="${(sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.BUSINESS_FLAG) or (sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.BUSINESS_DEPT_FLAG)}">
					    <tr>
							<td style="text-align: right;padding-right: 10px;" rowspan="2"><font color="red">商务审核</font></td>
							<td colspan="2">
							            维护到期日： ${erpContract.maintainDueDate }
							</td>
							<td colspan="3">
							 <c:if test="${lastContactOrder.contactFlow != contactOrder.contactFlow}">   
							           末次更新时间：
							   <span title="末次工作联系单详情" style="margin-right: 10px;cursor: pointer;" onclick="lastContactOrder('${lastContactOrder.contactFlow}');">${lastContactOrder.applyDate}</span>
							 </c:if>
							</td>
						</tr>
						<tr>
							<td colspan="5">
								意见：<input type="text" name="auditContent" class="inputText validate[required]" style="width:90%;text-align: left;"/>
							</td>
						</tr>
					</c:when>
					</c:choose>
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
					<c:if test="${(sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.USER_LIST_PERSONAL) or (sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.USER_LIST_GLOBAL)}">
			       		<input type="button" value="审核通过" onclick="saveAudit('${GlobalConstant.RECORD_STATUS_Y}');" class="search"/>
			       		<input type="button" value="审核不通过" onclick="saveAudit('${GlobalConstant.RECORD_STATUS_N}');" class="search"/>
			       	</c:if>
			       	<c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.MANAGER_FLAG}">
			       	    <input type="button" value="审核通过" onclick="saveAudit('${GlobalConstant.RECORD_STATUS_Y}');" class="search"/>
			       	</c:if>
			       	<c:if test="${(sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.BUSINESS_FLAG) or (sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.BUSINESS_DEPT_FLAG)}">
			       	    <input type="button" value="审核通过至审核完成" onclick="saveAudit('${GlobalConstant.RECORD_STATUS_Y}');" class="search"/>
			       		<input type="button" value="审核通过至总经理审批" onclick="saveAudit('${GlobalConstant.FLAG_F}');" class="search"/>
			       	</c:if>
			       	<c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.USER_LIST_LOCAL }">
			       		<input type="button" value="审核通过至审核完成" onclick="saveAudit('${GlobalConstant.RECORD_STATUS_Y}');" class="search"/>
			       		<input type="button" value="审核通过至总经理审批" onclick="saveAudit('${GlobalConstant.FLAG_F}');" class="search"/>
			       		<input type="button" value="审核不通过" onclick="saveAudit('${GlobalConstant.RECORD_STATUS_N}');" class="search"/>
			       	</c:if>
		       		<input type="button" value="关&#12288;闭" onclick="jboxCloseMessager();" class="search"/>
		    	</div>
			</form>
			</div>
		</div>
	</div>
</body>
</html>