<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="overview">
	<img src="<s:url value='/jsp/edu/css/images/xxjd.png'/>" />问答情况
</div>
<div class="module-tabs">
      <div class="title-r fr">
      	<div class="searchBox fl">
<form id="questionSurveyForm">
          <p>
           <input type="text"  placeholder="学校名称/专业名称" name="condition" value="${param.condition}" />
      	   <img onclick="submitForm('questionSurvey');" src="<s:url value='/jsp/edu/css/images/search1.png'/>" style="cursor: pointer;" title="搜索"/>                  
         </p>
        </form>
     	</div>
      </div>
</div> 
<div style="margin-top: 10px;"> 
<table border="0" width="100%" class="course-table">
<col width="20%">
<col width="20%">
<col width="20%">
<col width="20%">
<col width="20%">
<tr>
  <th>学校</th>
  <th>专业</th>
  <th>问题数</th>
  <th>已回答</th>
  <th>未回答</th>
</tr>
<c:if test="${empty orgList }">
    <tr>
      <td colspan="5">无记录！</td>
    </tr>
 </c:if>
   <c:forEach items="${orgList }" var="org">
     <tr>
        <td>${org.orgName }</td>
        <td colspan="4">
         <table width="100%" border="0">
         <col width="25%">
         <col width="25%">
         <col width="25%">
         <col width="25%">
          <c:forEach items="${org.majorFormList }" var="majorForm"> 
           <tr>
             <td>${majorForm.majorName }</td>
             <td>${questionCountFormMap['all'][org.orgFlow][majorForm.majorId] }</td>
             <td>${questionCountFormMap[eduQuestionStatusEnumAnswered.id][org.orgFlow][majorForm.majorId] }</td>
             <td>${questionCountFormMap[eduQuestionStatusEnumUnanswered.id][org.orgFlow][majorForm.majorId] }</td>
           </tr>
           </c:forEach>
         </table>
        </td>
     </tr>
  </c:forEach>
</table>
</div>
<div class="fanye">
<a href=""><img src="<s:url value='/jsp/edu/css/images/fanye-l.png'/>" /></a>
点击箭头可翻页
<a href=""><img src="<s:url value='/jsp/edu/css/images/fanye-r.png'/>" /></a>
</div>