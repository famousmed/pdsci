<script type="text/javascript">
function auditOpinion(contactFlow){
	var url="<s:url value='/erp/sales/contactOrderAuditOpinion'/>?contactFlow="+contactFlow;
	jboxOpen(url,"审核记录", 700, 400);
}
</script>
<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<colgroup>
						<col width="13%"/>
						<col width="24%"/>
						<col width="13%"/>
						<col width="60%"/>
					</colgroup>
					<tr>
						<th colspan="4" style="text-align: left;padding-left: 10px">工作联系单</th>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">编&#12288;&#12288;号</td>
						<td colspan="3">${contactOrder.contactNo }</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;" rowspan="2">客户名称</td>
						<td rowspan="2"><a href="javascript:customerInfo('${contactOrder.customerFlow }');">${contactOrder.customerName }</a></td>
						<td style="text-align: right;padding-right: 10px;">合同名称</td>
						<td colspan="3">
				             <a href="javascript:contractInfo('${contactOrder.contractFlow }');">${contactOrder.contractName }</a>
						</td>
					</tr>
					<tr>
					    <td style="text-align: right;padding-right: 10px;">合同状态</td>
						<td style="text-align: left;" id="contractStatusTd">
						  <c:forEach items="${contractStatusEnumList }" var="status">
						      <c:if test="${status.id eq contactOrderForm.contractStatusId }">${status.name }</c:if>
						  </c:forEach>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">客户地址</td>
						<td colspan="3" id="customerAddressTd">${contactOrderForm.customerAddress }</td>
					</tr>
					<tr>
					    <td style="text-align: right;padding-right: 10px;">最终使用方名称</td>
						<td id="consumerNameTd">
						   ${contactOrder.consumerName }
						</td>
					    <td style="text-align: right;padding-right: 10px;">最终使用方地址</td>
					    <td id="consumerAddressTd">${contactOrderForm.consumerAddress }</td>
					</tr>
				</table>
				<table width="100%" cellpadding="0" cellspacing="0" class="basic" style="border-top:none;">
					<colgroup>
						<col width="12%"/>
						<col width="25%"/>
						<col width="11%"/>
						<col width="22%"/>
						<col width="10%"/>
						<col width="20%"/>
					</colgroup>	
					<tr>
						<td style="text-align: right;padding-right: 10px;" rowspan="2">联&nbsp;系&nbsp;&nbsp;人</td>
						<td rowspan="2" id="contactUserTd">
						    <label title="<c:if test="${not empty userCategoryMap[contactOrderForm.userFlow] }">（${userCategoryMap[contactOrderForm.userFlow] }）</c:if>">${contactOrderForm.userName }</label>
						</td>
						<td style="text-align: right;padding-right: 10px;">部&#12288;&#12288;门</td>
						<td id="deptNameTd">${contactOrderForm.deptName }</td>
						<td style="text-align: right;padding-right: 10px;">职&#12288;&#12288;务</td>
						<td id="postNameTd">${contactOrderForm.postName }</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">固&#12288;&#12288;话</td>
						<td id="telPhoneTd">${contactOrderForm.telPhone }</td>
						<td style="text-align: right;padding-right: 10px;">手&#12288;&#12288;机</td>
						<td id="celPhoneTd">${contactOrderForm.celPhone }</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">需求事项</td>
						<td colspan="5">${contactOrder.demandMatterName }</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">服务类型</td>
						<td colspan="5">${contactOrder.serviceTypeName }</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">产品/项目名称</td>
						<td colspan="5" id="contractProductTd">${contactOrder.productTypeName }
						  <c:if test="${(not empty contactOrder.productTypeName) and (not empty contactOrder.orderProductName) }">、</c:if>
				          ${contactOrder.orderProductName }
						</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">备&#12288;&#12288;注</td>
						<td colspan="5">${contactOrder.remark }</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">要求完成时间</td>
						<td>${contactOrder.demandDate } </td>
						<td style="text-align: right;padding-right: 10px;">紧急程度</td>
						<c:set var="auditRecordFlag" value="${(auditCount>1 or (sessionScope[GlobalConstant.USER_LIST_SCOPE] == GlobalConstant.USER_LIST_PERSONAL and auditCount>0))?true:false}"/>
						<td colspan="${auditRecordFlag?1:3}">${contactOrder.demandStatusName}</td>
						<c:if test="${auditRecordFlag}">
							<td style="text-align: right;padding-right: 10px;">审核记录</td>
							<td>
								[<a href="javascript:auditOpinion('${contactOrder.contactFlow}');">审核记录</a>]
							</td>
						</c:if>
					</tr>
				</table>