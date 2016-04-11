<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<table class="xllist">
    <thead>
    <tr><th colspan="5" class="th_sp">伦理委员会人员名单</th></tr>
      <tr>
            <th width="10%">姓名</th>
            <th width="10%">性别</th>
            <th width="25%">单位部门</th>
            <th width="10%">职称</th>
            <th width="10%">伦理职务</th>
        </tr>
    </thead>
    <tbody>
    <c:forEach items="${userList }" var="user">
        <tr>
           <td>${sysUserMap[user.recordFlow].userName }</td><td>${sysUserMap[user.recordFlow].sexName }</td><td>${sysUserMap[user.recordFlow].orgName }</td><td>${sysUserMap[user.recordFlow].titleName }</td><td>${user.roleName }</td>
        </tr>
     </c:forEach>   
    </tbody>
</table>
           
