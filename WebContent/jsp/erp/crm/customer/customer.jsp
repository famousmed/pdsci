<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<table width="100%" cellpadding="0" cellspacing="0" class="basic">
	<colgroup>
		<col width="12%"/>
		<col width="12%"/>
		<col width="12%"/>
		<col width="14%"/>
		<col width="12%"/>
		<col width="14%"/>
		<col width="10%"/>
		<col width="14%"/>
	</colgroup>
	<tr>
		<th colspan="8" style="text-align: left;padding-left: 10px">客户信息
		<c:if test="${param.type!='open' }">
		<img title="编辑" src="<s:url value="/css/skin/${skinPath}/images/gcp_main_edit.png" />" style="float: right;margin-right: 10px;cursor: pointer;" onclick="editCustomer('${customer.customerFlow}')"/>
		</c:if>
		</th>
	    
	</tr>
	<tr>
		<td style="text-align: right;padding-right: 10px;">客户名称：</td>
		<td colspan="3">${customer.customerName}</td>
		<td style="text-align: right;padding-right: 10px;">别&#12288;&#12288;名：</td>
		<td colspan="3">${customer.aliasName}</td>
	</tr>
	<tr>
		<td style="text-align: right;padding-right: 10px;">地&#12288;&#12288;区：</td>
		<td colspan="3">
			${customer.customerProvName}
			<c:if test="${not empty customer.customerCityName}">-${customer.customerCityName}</c:if>
			<c:if test="${not empty customer.customerAreaName}">-${customer.customerAreaName}</c:if>
		</td>
		<td style="text-align: right;padding-right: 10px;">地&#12288;&#12288;址：</td>
		<td colspan="3">${customer.customerAddress}</td>
	</tr>
	<tr>
		<td style="text-align: right;padding-right: 10px;">网&#12288;&#12288;站：</td>
		<td colspan="3">
			<c:set var="lowerSite" value="${pdfn:toLowerCase(customer.customerSite)}"/>
			<c:set var="site" value="${pdfn:contains(lowerSite,'http://')}"/>
			<c:choose>
				<c:when test="${site}">
					<a href="${customer.customerSite}" target="_blank">${customer.customerSite}</a>
				</c:when>
				<c:otherwise>
					<a href="http://${customer.customerSite}" target="_blank">${customer.customerSite}</a>
				</c:otherwise>
			</c:choose>
		</td>
		<td style="text-align: right;padding-right: 10px;">邮&#12288;&#12288;编：</td>
		<td>${customer.zipCode}</td>
		<td style="text-align: right;padding-right: 10px;">总&nbsp;机&nbsp;&nbsp;号：</td>
		<td>${customer.telPhone}</td>
	</tr>
	
	<tr>
	<c:choose>
		<c:when test="${customer.customerTypeId eq customerTypeEnumHospital.id}">
			<td style="text-align: right;padding-right: 10px;">类&#12288;&#12288;别：</td>
			<td>${customer.customerTypeName}</td>
			<td style="text-align: right;padding-right: 10px;">级&#12288;&#12288;别：</td>
			<td>${customer.hospitalGradeName}${customer.hospitalLevelName}</td>
			<td style="text-align: right;padding-right: 10px;">医院类型：</td>
			<td colspan="3">${customer.hospitalTypeName}</td>
		</c:when>
		<c:when test="${customer.customerTypeId eq customerTypeEnumSchool.id}">
			<td style="text-align: right;padding-right: 10px;">类&#12288;&#12288;别：</td>
			<td>${customer.customerTypeName}</td>
			<td style="text-align: right;padding-right: 10px;">级&#12288;&#12288;别：</td>
			<td colspan="5">${customer.schoolTypeName}</td>
		</c:when>
		<c:otherwise>
			<td style="text-align: right;padding-right: 10px;">类&#12288;&#12288;别：</td>
			<td colspan="7">${customer.customerTypeName}</td>
		</c:otherwise>
	</c:choose>
	</tr>
	<tr>
		<c:choose>
			<c:when test="${customer.isContract eq GlobalConstant.FLAG_Y}">
				<td style="text-align: right;padding-right: 10px;">合同客户：</td>
				<td>
					<c:if test="${customer.isContract eq GlobalConstant.RECORD_STATUS_Y}">是</c:if>
					<c:if test="${customer.isContract eq GlobalConstant.RECORD_STATUS_N}">否</c:if>
				</td>
				<td style="text-align: right;padding-right: 10px;">客户等级：</td>
				<td colspan="5">${customer.customerGradeName}</td>
			</c:when>
			<c:otherwise>
				<td style="text-align: right;padding-right: 10px;">合同客户：</td>
				<td colspan="7">
					<c:if test="${customer.isContract eq GlobalConstant.RECORD_STATUS_Y}">是</c:if>
					<c:if test="${customer.isContract eq GlobalConstant.RECORD_STATUS_N}">否</c:if>
				</td>
			</c:otherwise>
		</c:choose>
	</tr>
	<tr>
		<td style="text-align: right;padding-right: 10px;">备&#12288;&#12288;注：</td>
     	<td colspan="7" style="text-align:left;line-height: 25px;">
     		${customer.remark}
     	</td>
    </tr>
</table>
