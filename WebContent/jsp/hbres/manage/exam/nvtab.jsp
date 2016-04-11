<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="title_tab" id="toptab">
    <ul>
        <li class="<c:if test='${param.tabIndex eq "1"}'>tab_select</c:if><c:if test='${param.tabIndex != "1"}'>tab</c:if>"><a href="javascript:void(0);" onclick="examSitePlan();">考点安排</a></li>
        <li class="<c:if test='${param.tabIndex eq "2"}'>tab_select</c:if><c:if test='${param.tabIndex != "2"}'>tab</c:if>"><a a href="javascript:void(0);" onclick="setExamUser();">人员分配</a></li>
        <li class="<c:if test='${param.tabIndex eq "3"}'>tab_select</c:if><c:if test='${param.tabIndex != "3"}'>tab</c:if>"><a href="javascript:void(0);" onclick="examRoomManage('');">考场分配</a></li>
        <li class="<c:if test='${param.tabIndex eq "4"}'>tab_select</c:if><c:if test='${param.tabIndex != "4"}'>tab</c:if>"><a href="javascript:void(0);" onclick="examUser();">人员信息</a></li>
        <li class="<c:if test='${param.tabIndex eq "5"}'>tab_select</c:if><c:if test='${param.tabIndex != "5"}'>tab</c:if>"><a href="javascript:void(0);" onclick="examPrint();">考场打印</a></li>
    </ul>
</div>