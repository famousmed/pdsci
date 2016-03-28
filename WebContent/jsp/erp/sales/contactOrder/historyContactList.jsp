<table class="xllist">
				<colgroup>
					<col width="4%"/>
					<col width="10%"/>
					<col width="15%"/>
					<col width="15%"/>
					<col width="12%"/>
					<col width="12%"/>
					<col width="12%"/>
					<col width="10%"/>
					<col width="10%"/>
				</colgroup>
				<thead>
				<tr>
					<th>序号</th>
					<th>联系单编号</th>
					<th>客户名称</th>
					<th>产品/项目名称</th>
					<th>需求事项</th>
					<th>申请人</th>
					<th>申请时间</th>
					<th>审核状态</th>
					<th>操作</th>
				</tr>
				</thead>						
				<tbody>
				   <c:if test="${empty contactOrderList  }">
				      <tr><td colspan="9">无记录</td></tr>
				   </c:if>
				   <c:forEach items="${contactOrderList }" var="contactOrder" varStatus="num">
				      <tr class="contactTr" id="contactTr_${contactOrder.contactFlow }">
				        <td>${num.count }</td>
				        <td>${contactOrder.contactNo }</td>
				        <td><a href="javascript:customerInfo('${contactOrder.customerFlow }');" >${contactOrder.customerName }</a></td>
				        <td>
				        ${contactOrder.productTypeName }
				        <c:if test="${(not empty contactOrder.productTypeName) and (not empty contactOrder.orderProductName) }">、</c:if>
				        ${contactOrder.orderProductName }
				        </td>
				        <td>${contactOrder.demandMatterName }</td>
				        <td>${contactOrder.applyUserName }</td>
				        <td>${contactOrder.applyDate }</td>
				        <td>${contactOrder.contactStatusName }</td>
				        <td>
				             [<a href="javascript:info('${contactOrder.contactFlow }');" onclick="checkedView('${contactOrder.contactFlow }');">详情</a>]
				        </td>
				      </tr>
				   </c:forEach>
				</tbody>
			</table>
			<div class="button">
			    <input type="button" class="search" value="关&#12288;闭" onclick="jboxCloseMessager();" >
			</div>