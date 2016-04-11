<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<ul id="tags">
    <li id='tag0' <c:if test='${param.pageName=="step1" || empty param.pageName}'>class="selectTag"</c:if>><a onclick="nextOpt('step1')" href="javascript:void(0)">项目概况</a></li>
    <li id='tag1' <c:if test='${param.pageName=="step2"}'>class="selectTag"</c:if>><a onclick="nextOpt('step2')" href="javascript:void(0)">人员情况</a></li>
    <li id='tag2' <c:if test='${param.pageName=="step3"}'>class="selectTag"</c:if>><a onclick="nextOpt('step3')" href="javascript:void(0)">经费情况</a></li>
</ul>