<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="head">
   <div class="head_inner">
     <h1 class="logo">
       <a href="<s:url value='/jszy/doctor/index'/>">${sysCfgMap['sys_title_name']}</a>
     </h1>
     <c:if test="${not param.notShowAccount}">
     <div class="account">
       <h2 style="text-align: right;">您好，${!empty sessionScope.currUser.userName?sessionScope.currUser.userName:sessionScope.currUser.userCode }</h2>
       <div class="head_right">
        <a href="<s:url value='/jszy/doctor/index'/>">首页</a>&#12288;
        <c:if test='${param.notice}'>
           <a onclick="msg();">公告</a>&#12288;
        </c:if>
         <a href="<s:url value='/inx/jszy/logout'/>">退出</a>
       </div>
     </div>
     </c:if>
   </div>
 </div>