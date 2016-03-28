<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<script type="text/javascript">
	$(document).ready(function(){
		$(".parentA").click(function(event){
	        event.stopPropagation();
	    });
		
		if("${param.type}"=="add"){
			addCheckedRecords();
			addCheckedRecords2();
		}
	});
</script>

<div class="mainright">
<div class="content">
<div class="title1 clearfix">

<form id="usersForm" action="<s:url value="/erp/doc/searchShareUsers" />" method="post">
	&#12288;所属部门：
    <select id="deptFlow" name="deptFlow" class="xlselect" onchange="searchShareUsers();">
        <option value="">请选择</option>
        <c:forEach items="${deptList}" var="dept">
           <option value="${dept.deptFlow}"  ${dept.deptFlow eq param.deptFlow?'selected="selected"':''}>${dept.deptName}</option>
         </c:forEach>
    </select>
	 姓名：<input type="text" id="userName" name="userName" value="${param.userName}"  class="xltext"/>	
	     <input type="button" class="search" onclick="searchShareUsers();" value="查&#12288;询">
</form>
<table class="xllist" > 
	<colgroup>
		<col width="5%"/>
		<col width="14%"/>
		<col width="10%"/>
		<col width="20%"/>
		<col width="24%"/>
		<col width="26%"/>
	</colgroup>
	<tr>
		<th><%-- <input type="checkBox" onclick="selectAll('${shareTypeEnumUser.id}', this);"> --%></th>
		<th>姓名</th>
		<th>性别</th>
		<th>部门</th>
		<th>手机</th>
		<th>邮件</th>
	</tr>
	<tbody>
		<c:forEach items="${sysUserList}" var="sysUser">
		<c:set var="userFlow_my" value="${sysUser.userFlow}_my"/>
		<c:set var="userFlow_other" value="${sysUser.userFlow}_other"/>
		<c:if test="${sysUser.userCode!=GlobalConstant.ROOT_USER_CODE or sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE }">
		<tr <c:if test="${!(not empty docShareMap[userFlow_other] and param.docCategory=='shared')}">
				style="height:20px;cursor: pointer;" onclick="selShare('${shareTypeEnumUser.id}', '${sysUser.userFlow}','${sysUser.userName}','tr');"
			</c:if>
		 >	
			<td>
				<input type="checkbox" id="${sysUser.userFlow}" name="recordFlow" class="parentA" shareRecordName="${sysUser.userName}"
				<c:if test="${not empty docShareMap[userFlow_my] or not empty docShareMap[userFlow_other]}">checked="checked"</c:if>
				<c:if test="${not empty docShareMap[userFlow_other] and param.docCategory=='shared'}">disabled="disabled"</c:if>
				onclick="selShare('${shareTypeEnumUser.id}', '${sysUser.userFlow}','${sysUser.userName}','');"
				  style="cursor: pointer;"/>
			</td>	
			<td>${sysUser.userName}</td>
			<td>${sysUser.sexName}</td>
			<td>${sysUser.deptName}</td>
			<td>${sysUser.userPhone}</td>
			<td>${sysUser.userEmail}</td>
		</tr>
		</c:if>
		</c:forEach>
	</tbody>
	<c:if test="${empty sysUserList}"> 
		<tr> 
			<td colspan="6">无记录</td>
		</tr>
	</c:if>
</table>

</div>
</div>
</div>
