<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="main">
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
        
					<table class="xllist">
                                <thead>
                                <tr>
									<th style=" text-align: left;padding-left: 15px;" colspan="5">${findInfo.irbName }</th>
								</tr>
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
            </div>
    </div>
      </div>
</div>
