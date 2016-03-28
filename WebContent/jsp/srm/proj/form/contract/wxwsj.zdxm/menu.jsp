<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<ul id="tags" style="margin-bottom: 10px;">
    <li id='tag0' <c:if test='${param.pageName=="step1" || empty param.pageName}'>class="selectTag"</c:if>><a onclick="nextOpt('step1')" href="javascript:void(0)">项目信息</a></li>
    <li id='tag1' <c:if test='${param.pageName=="step2"}'>class="selectTag"</c:if>><a onclick="nextOpt('step2')" href="javascript:void(0)">项目进度及考核指标</a></li>
    <li id='tag2' <c:if test='${param.pageName=="step3"}'>class="selectTag"</c:if>><a onclick="nextOpt('step3')" href="javascript:void(0)">项目承担单位、参加单位及主要研究开发人员</a></li>
    <li id='tag3' <c:if test='${param.pageName=="step4"}'>class="selectTag"</c:if>><a onclick="nextOpt('step4')" href="javascript:void(0)">项目经费预算</a></li>
</ul>