<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<ul id="tags">
	<li id="tag0"
		<c:if test='${param.pageName=="step1" || empty param.pageName}'>class="selectTag"</c:if>><a
		onclick="nextOpt('step1')" href="javascript:void(0)">项目基本情况</a></li>
	<li id="tag1"
		<c:if test='${param.pageName=="step2"}'>class="selectTag"</c:if>><a
		onclick="nextOpt('step2')" href="javascript:void(0)">项目简介</a></li>
	<li id="tag2"
		<c:if test='${param.pageName=="step3"}'>class="selectTag"</c:if>><a
		onclick="nextOpt('step3')" href="javascript:void(0)">引进项目推广情况</a></li>
	<li id="tag3"
		<c:if test='${param.pageName=="step4"}'>class="selectTag"</c:if>><a
		onclick="nextOpt('step4')" href="javascript:void(0)">主要完成人情况</a></li>
	<li id="tag4"
		<c:if test='${param.pageName=="step5"}'>class="selectTag"</c:if>><a
		onclick="nextOpt('step5')" href="javascript:void(0)">附件</a></li>
</ul>