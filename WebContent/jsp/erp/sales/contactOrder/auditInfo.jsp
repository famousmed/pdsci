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
            ${auditForm.auditContent}
		</td>
	</tr>
	</c:if>
	
       <c:if test="${not empty businessAuditForm.auditContent}">
		<tr>
			<td style="text-align: right;padding-right: 10px;" rowspan="2">商务审核</td>
			<td colspan="2">
			            维护到期日： ${erpContract.maintainDueDate}
			</td>
			<td colspan="3">
				<c:if test="${lastContactOrder.contactFlow != contactOrder.contactFlow }">   
				          末次更新时间：${lastContactOrder.applyDate }
				  <%-- <span title="末次工作联系单详情" style="margin-right: 10px;cursor: pointer;" onclick="lastContactOrder('${lastContactOrder.contactFlow}');">>></span> --%>
				</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="5">意见：${businessAuditForm.auditContent}</td>
		</tr>
	</c:if>
	
	<c:if test="${not empty managerAuditForm.auditContent}">
		<tr>
			<td style="text-align: right;padding-right: 10px;">总经理意见</td>
			<td colspan="5">${managerAuditForm.auditContent }</td>
		</tr>
	</c:if>
	
	<c:if test="${contactOrder.contactStatusId eq contactOrderStatusEnumReceived.id}">
		<tr>
		<td style="text-align: right;padding-right: 10px;" rowspan="2">
			${contactOrder.receiveDeptName }<br/>处理进度
		</td>
		<td colspan="2">
			预计解决时间：${contactOrderForm.disposeForm.planFinishTime}
		</td>
		<td colspan="3">
			处理方式：
			<c:forEach var="dealType" items="${dealTypeEnumList}">
				<c:if test="${dealType.id eq contactOrderForm.disposeForm.method}">${dealType.name}</c:if>
			</c:forEach>
		</td> 
		</tr>
		<tr>
		<td colspan="5">
			意见：${contactOrderForm.disposeForm.result}
		</td>
	</tr>
	</c:if>
 	
	<tr>
	    <td style="text-align: right;padding-right: 10px;">申请部门</td>
		<td>${contactOrder.applyDeptName }</td>
		<td style="text-align: right;padding-right: 10px;">申&nbsp;请&nbsp;&nbsp;人</td>
		<td>${contactOrder.applyUserName }</td>
		<td style="text-align: right;padding-right: 10px;">申请时间</td>
		<td>${contactOrder.applyDate }</td>
	</tr>
	<c:if test="${param.historyFlag eq 'Y' }">
	 <tr>
	    <td style="text-align: right;padding-right: 10px;"><font color="red">客户回访</font></td>
	    <td colspan="5">
	       <a href="javascript:searchVisitOpinion('${contactOrder.contactFlow }');" onclick="checkedView('${contactOrder.contactFlow }');"><font color="red">查看回访记录</font></a>
	    </td>
	 </tr>
	</c:if>
</table>


