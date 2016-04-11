<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<script type="text/javascript">

function showWorkOrder(workFlow){
	checkedView(workFlow);
	var $tr = $("#tr_"+workFlow);
	var contentWorkFlow = $("#content_"+workFlow);
	if($.trim(contentWorkFlow.html())==""){
		var url = "<s:url value='/erp/implement/editWorkOrder'/>?workFlow=" + workFlow + "&type=load";
		jboxLoad("content_"+workFlow, url, false);
	}
	$tr.slideToggle("normal");
}

function checkedView(workFlow){
	var prevCheckedWorkFlow = $("input[name='prevCheckedWorkFlow']").val();
	$.each($(".listTrs"),function(i,n){
		$(n).css("background-color","");
	});
	$("#checkedTr_"+workFlow).css("background-color","pink");
	if("" != prevCheckedWorkFlow && prevCheckedWorkFlow != workFlow){
		$("#tr_"+prevCheckedWorkFlow).hide();
	}
	$("input[name='prevCheckedWorkFlow']").val(workFlow);
}

</script>
<input type="hidden" name="prevCheckedWorkFlow"/>
<table class="xllist" style="width: 100%;">
		<colgroup>
		    <col width="20%"/>
			<col width="20%"/>
			<col width="20%"/>
			<col width="20%"/>
			<col width="20%"/>
		<!-- 	<col width="20%"/> -->
		</colgroup>
		<tr>
		    <th>派工单编号</th>
			<th>派工时间</th>
			<th>接收部门</th>
			<th>实施工程师</th>
			<!-- <th>回访结果</th> -->
			<th>状态</th>
		</tr>
		<c:forEach items="${workOrderList}" var="workOrder">
			<tr class="listTrs" id="checkedTr_${workOrder.workFlow}" onclick="showWorkOrder('${workOrder.workFlow}');" style="cursor: pointer;">
				<td>${workOrder.workNo}</td>
				<td>${workOrder.assignDate}</td>
				<td>${workOrder.assignDeptName}</td>
				<td>${workOrder.assignUserName}</td>
				<%-- <td>
					<c:if test="${isSolvedMap[workOrder.workFlow] == GlobalConstant.FLAG_Y}">已解决问题</c:if> 
					<c:if test="${isSolvedMap[workOrder.workFlow] == GlobalConstant.FLAG_N}">未解决问题</c:if>
				</td> --%>
				<td>${workOrder.workStatusName}</td>
			</tr>
			<tr id="tr_${workOrder.workFlow}" style="display: none;">
				<td colspan="5">
		             <div id="content_${workOrder.workFlow}"></div>
				</td>
			</tr>
		</c:forEach>
		<c:if test="${empty workOrderList}">
			<tr>
				<td colspan="5">无记录</td>
			</tr>
		</c:if>
</table>
 <c:if test="${param.closeFlag=='close'}">
	<div class="button">
	    <input type="button" class="search" value="关&#12288;闭" onclick="jboxCloseMessager();" >
	</div>			    
    </c:if>
