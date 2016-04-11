<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<ul id="tags">
    <li id='tag0' <c:if test='${param.pageName=="step1" || empty param.pageName}'>class="selectTag"</c:if>><a onclick="nextOpt('step1')" href="javascript:void(0)">基本信息</a></li>
    <li id='tag1' <c:if test='${param.pageName=="step2"}'>class="selectTag"</c:if>><a onclick="nextOpt('step2')" href="javascript:void(0)">立项依据</a></li>
    <li id='tag2' <c:if test='${param.pageName=="step3"}'>class="selectTag"</c:if>><a onclick="nextOpt('step3')" href="javascript:void(0)">研究内容</a></li>
    <li id='tag3' <c:if test='${param.pageName=="step4"}'>class="selectTag"</c:if>><a onclick="nextOpt('step4')" href="javascript:void(0)">研究方法</a></li>
    <li id='tag4' <c:if test='${param.pageName=="step5"}'>class="selectTag"</c:if>><a onclick="nextOpt('step5')" href="javascript:void(0)">工作基础</a></li>
    <li id='tag5' <c:if test='${param.pageName=="step6"}'>class="selectTag"</c:if>><a onclick="nextOpt('step6')" href="javascript:void(0)">预期成果</a></li>
    <li id='tag6' <c:if test='${param.pageName=="step7"}'>class="selectTag"</c:if>><a onclick="nextOpt('step7')" href="javascript:void(0)">进度与考核</a></li>
    <li id='tag7' <c:if test='${param.pageName=="step8"}'>class="selectTag"</c:if>><a onclick="nextOpt('step8')" href="javascript:void(0)">附件</a></li>
</ul>
