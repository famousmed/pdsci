<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<style type="text/css">
	.i-trend-main-table td{
		text-align: left;
		padding-left: 30px;
		border-left: none;
		border-right: none;
	}
</style>

<table cellpadding="0" class="i-trend-main-table" cellspacing="0" border="0"  style="width: 100%;border-style:hidden;">
	<colgroup>
		<col width="33%" />
		<col width="33%" />
		<col width="33%" />
	</colgroup>
  <tr>
	<td>到达时间：${workOrderForm.arriveDate}</td>
    <td>完成时间：${workOrderForm.completeDate}</td>
    <td></td>
  </tr>
  <tr>
    <td colspan="3">具体内容：${workOrderForm.content}</td>
  </tr>
  <tr>
    <td>客户意见：
    	<c:forEach var="satisfaction" items="${satisfactionEnumList}">
			<c:if test="${workOrderForm.isSatisfied == satisfaction.id}">${satisfaction.name}</c:if>
		</c:forEach>
    </td>
    <td>客户签字：${workOrderForm.signUser}</td>
    <td>签字日期：${workOrderForm.signDate}</td>
  </tr>
  <tr>
    <td colspan="3">意见或建议内容：${workOrderForm.advice}</td>
  </tr>
  <%-- <tr>
    <td>回访结果：
    	<c:if test="${workOrderForm.isSolved == GlobalConstant.FLAG_Y}">已解决问题</c:if>
		<c:if test="${workOrderForm.isSolved == GlobalConstant.FLAG_N}">未解决问题</c:if>
    </td>
    <td>客户联系人：${workOrderForm.customerLinkman}</td>
    <td>回访日期：${workOrderForm.visitDate}</td>
  </tr>
   <tr>
    <td colspan="3">回访内容：${workOrderForm.visitContent}</td>
  </tr> --%>
</table>

