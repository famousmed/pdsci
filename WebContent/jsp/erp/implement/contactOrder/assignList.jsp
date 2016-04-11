<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<script type="text/javascript">
function implementing(workFlow,contactFlow){
	if(false == $("#workOrderForm").validationEngine("validate")){
		return false;
	}
	jboxConfirm("确认派工? 派工后派工单将不可修改！",  function(){
		var url = "<s:url value='/erp/implement/implementing'/>?workFlow=" + workFlow;
		jboxPost(url, null, function(resp){
			if("${GlobalConstant.OPRE_SUCCESSED}" == resp){
				window.parent.frames['mainIframe'].window.slideDown(contactFlow);
				setTimeout(function(){
					jboxCloseMessager();
				},1000);
			}
		}, null, true);
	});
}

function applyAudit(workFlow, contactFlow){
	jboxConfirm("确认送审?",  function(){
		var url = "<s:url value='/erp/implement/applyAudit'/>?workFlow=" + workFlow;
		jboxPost(url, null, function(resp){
			if("${GlobalConstant.OPRE_SUCCESSED}" == resp){
				window.parent.frames['mainIframe'].window.slideDown(contactFlow);
			}
		}, null, true);
	});
}

function delWorkOrder(workFlow,contactFlow){
	jboxConfirm("确认删除?",  function(){
		var url = "<s:url value='/erp/implement/delWorkOrder'/>?workFlow=" + workFlow;
		jboxPost(url, null, function(resp){
			if("${GlobalConstant.DELETE_SUCCESSED}" == resp){
				window.parent.frames['mainIframe'].window.slideDown(contactFlow);
			}
		}, null, true);
	});
}
function recallWorkOrder(workFlow,contactFlow){
	jboxConfirm("确认撤回?",  function(){
		var statusId='${workOrderStatusEnumSave.id}';
		var url = "<s:url value='/erp/implement/recallWorkOrder'/>?workFlow=" + workFlow +"&statusId=" + statusId;
		jboxPost(url, null, function(resp){
			if("${GlobalConstant.ONE_LINE}" == resp){
				jboxTip('${GlobalConstant.OPERATE_SUCCESSED}');
				window.parent.frames['mainIframe'].window.slideDown(contactFlow);
			}
		}, null, false);
	});
}
</script>
			
<table cellpadding="0" class="i-trend-main-table" cellspacing="0" border="0" style="width: 100%;">
	<colgroup>
	    <col width="20%" />
		<col width="20%" />
		<col width="20%" />
		<col width="20%" />
		<col width="20%" />
	</colgroup>
	<c:forEach items="${workOrderList}" var="workOrder">
		<tr style="height: 40px;">
		    <td>${workOrder.workNo}</td>
			<td>${workOrder.assignDate}</td>
			<td>${workOrder.assignUserName}</td>
			<td>${workOrder.workStatusName}</td>
			<td>
				<c:if test="${workOrder.workStatusId != workOrderStatusEnumSave.id and workOrder.workStatusId != workOrderStatusEnumApplyTargetUnPassed.id}">
					[<a href="javascript:viewWorkOrder('${workOrder.workFlow}','${param.contactFlow }');">查看</a>]
				</c:if>
				<c:if test="${workOrder.workStatusId == workOrderStatusEnumSave.id or workOrder.workStatusId == workOrderStatusEnumApplyTargetUnPassed.id}">
					[<a href="javascript:editWorkOrder('${workOrder.workFlow}','${workOrder.customerFlow}','${param.contactFlow }');">编辑</a>]
					| [<a href="javascript:delWorkOrder('${workOrder.workFlow}','${workOrder.contactFlow}');">删除</a>]
					<c:if test="${workOrder.assignDeptFlow == sessionScope.currUser.deptFlow}">
						| [<a href="javascript:implementing('${workOrder.workFlow}','${workOrder.contactFlow}');">派工</a>]
					</c:if>
					<c:if test="${not empty workOrder.assignDeptFlow and workOrder.assignDeptFlow != sessionScope.currUser.deptFlow}">
						| [<a href="javascript:applyAudit('${workOrder.workFlow}','${workOrder.contactFlow}');">送审</a>]
					</c:if>
				</c:if>
				
				<c:if test="${workOrder.workStatusId == workOrderStatusEnumImplemented.id}">
					| [<a href="javascript:implementedAuditWorkOrder('${workOrder.workFlow}','${workOrder.workStatusId}','${workOrder.contactFlow}');">审核</a>]
				</c:if>
				<c:if test="${workOrder.workStatusId == workOrderStatusEnumImplementing.id}">
					| [<a href="javascript:recallWorkOrder('${workOrder.workFlow}','${workOrder.contactFlow}');">撤回</a>]
				</c:if>
				<%-- <c:if test="${workOrder.workStatusId == workOrderStatusEnumPassed.id}">
					| [<a href="javascript:visit('${workOrder.workFlow}');">回访</a>]
				</c:if> --%>
				
			</td>
		</tr>
	</c:forEach>
	<c:if test="${empty workOrderList}">
		<tr style="height: 40px;">
			<td colspan="5">无记录</td>
		</tr>
	</c:if>
</table>
   
