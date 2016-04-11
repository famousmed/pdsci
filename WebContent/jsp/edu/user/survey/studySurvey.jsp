<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="any" uri="http://www.anychart.com" %>
<div class="overview">
	<img src="<s:url value='/jsp/edu/css/images/xxjd.png'/>" />学习进度
</div>
<!-- 报表开始 -->
<div >
<jsp:include page="study_schedule_chart.jsp" ></jsp:include>
</div>
<!-- 报表结束 -->
<div class="module-tabs">
      <div class="title-r fr">
      	<div class="searchBox fl">
      	<form id="studySurveyForm">
      	   <input type="text"  placeholder="学校名称/学生姓名/专业" name="condition" value="${param.condition}" />
      	   <img onclick="submitForm('studySurvey');" src="<s:url value='/jsp/edu/css/images/search1.png'/>" style="cursor: pointer;" title="搜索"/> 
      	</form>
      	</div>
      </div>
</div> 
<div style="margin-top: 10px;"> 
<table border="0" width="100%" class="course-table">
<col width="15%">
<col width="17%">
<col width="17%">
<col width="17%">
<col width="17%">
<col width="17%">
<tr>
  <th>姓名</th>
  <th>学校</th>
  <th>专业</th>
  <th>已完成章节</th>
  <th>未完成章节</th>
  <th>完成进度</th>
</tr>
 <c:if test="${empty eduUserExtList }">
    <tr>
      <td colspan="6">无记录！</td>
    </tr>
 </c:if>
 <c:forEach items="${eduUserExtList }" var="eduUserExt">
     <tr>
        <td>${eduUserExt.sysUser.userName }</td>
        <td>${eduUserExt.sysOrg.orgName }</td>
        <td>${eduUserExt.majorName }</td>
        <td>${studySurveyMap['finishMap'][eduUserExt.userFlow] }</td>
        <td>${studySurveyMap['notFinishMap'][eduUserExt.userFlow] }</td>
        <td>${studySurveyMap['pointMap'][eduUserExt.userFlow] }%</td>
     </tr>
  </c:forEach>
</table>
</div>
<div class="fanye">
<a href="javascript:void(0);" onclick="toNext(${flag-1});"><img src="<s:url value='/jsp/edu/css/images/fanye-l.png'/>" /></a>
点击箭头可翻页
<a href="javascript:void(0);" onclick="toNext(${flag+1});"><img src="<s:url value='/jsp/edu/css/images/fanye-r.png'/>" /></a>
</div>
