<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>

<table cellpadding="0" cellspacing="0" class="xllist" style="width: 100%;border-top: 0px;">
	<colgroup>
		<col width="6%"/>
		<col width="4%"/>
		<col width="9%"/>
		<col width="9%"/>
		<col width="11%"/>
		<col width="10%"/>
		<col width="17%"/>
		<col width="7%"/>
		<col width="10%"/>
		<c:if test="${param.type!='open' }">
		<col width="17%"/>
		</c:if>
	</colgroup>
	<tr>
		<th>姓名</th>
		<th>性别</th>
		<th>科室</th>
		<th>职务</th>
		<th>固话</th>
		<th>手机</th>		
		<th>邮箱</th>
		<th>部门负责人</th>		
		<th>备注</th>	
		<c:if test="${param.type!='open' }">	
		<th>操作</th>		
		</c:if>
	</tr>
	<tbody>
	<c:forEach items="${customerUserList}" var="user" varStatus="status">
		<tr <c:if test="${user.recordStatus eq GlobalConstant.FLAG_N}"> style="background-color:#eeeeee;"</c:if>>
			<td>${user.userName}</td>
			<td>${user.sexName}</td>
			<td>${user.deptName}</td>
			<td>${user.postName}</td>
			<td>${user.userTelphone}</td>
			<td>${user.userCelphone}</td>
			<td>${user.userEmail}</td>
			<td>
				<c:if test="${user.isMain eq GlobalConstant.FLAG_Y}">是</c:if>
				<c:if test="${user.isMain eq GlobalConstant.FLAG_N}">否</c:if>
			</td>
			<td>${user.remark}</td>
			<c:if test="${param.type!='open' }">
			<td>
				<c:set var="isSingle" value="${(sessionScope.userListScope==GlobalConstant.USER_LIST_PERSONAL and !userRefMap[user.userFlow])?false:true }"></c:set>
				<c:if test="${user.recordStatus eq GlobalConstant.FLAG_Y}">
					<c:if test="${sessionScope.userListScope==GlobalConstant.USER_LIST_LOCAL or sessionScope.userListScope==GlobalConstant.USER_LIST_PERSONAL}">
						[<a href="javascript:markUser('${user.userFlow}','${user.customerFlow}');">标注</a>]${isSingle?' |':'' }
					</c:if>
					<c:if test="${sessionScope.userListScope !=GlobalConstant.USER_LIST_PERSONAL or userCategoryMap[user.userFlow]}">
						[<a href="javascript:editCustomerUser('${user.userFlow}');">编辑</a>] |
						[<a href="javascript:void(0)" onclick="disableUser(this,'${user.userFlow}','${GlobalConstant.RECORD_STATUS_N}','${user.userName}');">停用</a>]
					</c:if>
				</c:if>
				<c:if test="${user.recordStatus eq GlobalConstant.FLAG_N}">
					<c:if test="${sessionScope.userListScope !=GlobalConstant.USER_LIST_PERSONAL or userCategoryMap[user.userFlow]}">
						[<a href="javascript:void(0)" onclick="disableUser(this,'${user.userFlow}','${GlobalConstant.RECORD_STATUS_Y}','${user.userName}');">启用</a>]
					</c:if>
				</c:if>
				<c:if test="${sessionScope.userListScope==GlobalConstant.USER_LIST_GLOBAL and (pdfn:contain('action-erp-zjl-khgl-khcx-sclxr', sessionScope.currUserMenuIdList) or sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE)}">
					| [<a href="javascript:void(0)" onclick="deleteCustomerUser('${user.userFlow}','${user.userName}')">删除</a>]
				</c:if>
			</td>
			</c:if>
		</tr>
	</c:forEach>
	</tbody>
	<c:if test="${empty customerUserList}">
		<tr>
			<td colspan="10">无记录</td>
		</tr>
	</c:if>
</table>