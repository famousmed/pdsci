<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<ul id="tags" style="margin-bottom: 30px;">
    <li id='tag0' <c:if test='${param.pageName=="step1" || empty param.pageName}'>class="selectTag"</c:if>><a onclick="nextOpt('step1')" href="javascript:void(0)">信息表</a></li>
    <li id='tag1' <c:if test='${param.pageName=="step2"}'>class="selectTag"</c:if>><a onclick="nextOpt('step2')" href="javascript:void(0)">申请人简历</a></li>
    <li id='tag2' <c:if test='${param.pageName=="step3"}'>class="selectTag"</c:if>><a onclick="nextOpt('step3')" href="javascript:void(0)">研究项目信息</a></li>
    <li id='tag3' <c:if test='${param.pageName=="step4"}'>class="selectTag"</c:if>><a onclick="nextOpt('step4')" href="javascript:void(0)">年度计划及年度目标、工作条件和环境保障</a></li>
    <li id='tag4' <c:if test='${param.pageName=="step5"}'>class="selectTag"</c:if>><a onclick="nextOpt('step5')" href="javascript:void(0)">单位及合作单位的意见</a></li>
    <li id='tag5' <c:if test='${param.pageName=="step6"}'>class="selectTag"</c:if>><a onclick="nextOpt('step6')" href="javascript:void(0)">项目组成员登记表</a></li>
    <li id='tag6' <c:if test='${param.pageName=="step7"}'>class="selectTag"</c:if>><a onclick="nextOpt('step7')" href="javascript:void(0)">经费预算表</a></li>
    <li id='tag7' <c:if test='${param.pageName=="step8"}'>class="selectTag"</c:if>><a onclick="nextOpt('step8')" href="javascript:void(0)">科室、单位及上级主管部门的意见</a></li>
    <li id='tag8' <c:if test='${param.pageName=="step9"}'>class="selectTag"</c:if>><a onclick="nextOpt('step9')" href="javascript:void(0)">附件清单</a></li>
</ul>