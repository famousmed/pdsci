<c:forEach items="${contractExtList }" var="contractExt" varStatus="num">
				<tr id="contractTr_${contractExt.contractFlow }" class="contractTr" <c:if test="${contractExt.contractFlow eq checkContractFlow }">style="background-color:pink;"</c:if>>
					<td style="text-align: left;">
					    <font style="margin-left: 3px;margin-right: 4px;">[${num.count }]</font>${contractExt.contractNo }
					</td>
					<td><a href="javascript:customerInfo('${contractExt.customer.customerFlow }')">${contractExt.customer.customerName }</a></td>
					<td>${contractExt.contractName }</td>
					<td>${contractExt.contractCategoryName }</td>
					<td>${contractExt.contractTypeName }</td>
					<c:if test="${empty param.signDeptFlow and (sessionScope[GlobalConstant.USER_LIST_SCOPE] == GlobalConstant.USER_LIST_GLOBAL)}">
					<td>${contractExt.signDeptName }</td>
					</c:if>
					<td>${contractExt.chargeUserName }</td>
					<td>${contractExt.signDate }</td>
					<td>${contractExt.maintainDueDate }</td>
					<td><label class="money">${contractExt.contractFund }</label></td>
					<td>[<a href="javascript:contractInfo('${contractExt.contractFlow }');" onclick="checkedView('${contractExt.contractFlow }');">查看</a>] <!-- | -->
						<!-- [<a href="javascript:payPlanList();">回款</a>]  -->
						<c:if test="${(pdfn:contain('action-erp-zjl-crmhtgl-crmhtcx-scht', sessionScope.currUserMenuIdList) and (sessionScope[GlobalConstant.USER_LIST_SCOPE] == GlobalConstant.USER_LIST_CHARGE)) or sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE}">
					    | [<a href="javascript:deleteContract('${contractExt.contractFlow }');">删除</a>]
					    </c:if>
						<input type="hidden" id="sub_${contractExt.contractFlow }" name="parentNode" value="${contractFlow }"/>
					</td>
				
</c:forEach>
