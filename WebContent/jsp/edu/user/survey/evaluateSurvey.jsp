<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="overview">
	<img src="<s:url value='/jsp/edu/css/images/xxjd.png'/>" />课程评价
</div>
<div class="module-tabs">
      <div class="title-r fr">
      	<div class="searchBox fl">
			<form id="courseEvaluateForm">
          	<p>
	           <input type="text"  placeholder="专业名称" name="condition" value="${param.condition}" />
	      	   <img onclick="submitForm('courseEvaluate');" src="<s:url value='/jsp/edu/css/images/search1.png'/>" style="cursor: pointer;" title="搜索"/>                  
         	</p>
	        </form>
     	</div>
      </div>
</div> 
<div style="margin-top: 10px;"> 
<table border="0" width="100%" class="course-table">
<col width="20%">
<col width="10%">
<col width="10%">
<col width="10%">
<col width="10%">
<col width="10%">
<col width="10%">
<tr>
  <th>学校</th>
  <th>专业</th>
  <th>点赞</th>
  <th>收藏</th>
  <th>好评</th>
  <th>中评</th>
  <th>差评</th>
  <th>留言</th>
</tr>
 <c:if test="${empty orgExtList}">
    <tr>
      <td colspan="6">无记录！</td>
    </tr>
 </c:if>
 	
 <c:forEach items="${orgExtList}" var="orgExt">
	<c:forEach items="${orgExt.majorFormList}" var="majorForm">
     <tr>
        <td>${orgExt.orgName}</td>
        <td>${majorForm.majorName}</td>
        <td>${resultMap[orgExt.orgFlow][majorForm.majorId].praiseCount}</td>
        <td>${resultMap[orgExt.orgFlow][majorForm.majorId].collectionCount}</td>
        <td>${resultMap[orgExt.orgFlow][majorForm.majorId].highScoreCount}</td>
        <td>
        	${resultMap[orgExt.orgFlow][majorForm.majorId].middleScoreCount}&nbsp;<a href="javascript:void(0);" onclick="showEvaluate('middleScoreCount','${orgExt.orgFlow}','${majorForm.majorId}');">查看</a>
        </td>
        <td>
        	${resultMap[orgExt.orgFlow][majorForm.majorId].lowScoreCount}&nbsp;<a href="javascript:void(0);" onclick="showEvaluate('lowScoreCount','${orgExt.orgFlow}','${majorForm.majorId}');">查看</a>
        </td>
        <td>
       		${resultMap[orgExt.orgFlow][majorForm.majorId].leaveMessageCount}&nbsp;<a href="javascript:void(0);" onclick="showEvaluate('leaveMessageCount','${orgExt.orgFlow}','${majorForm.majorId}');">查看</a>
        </td>
     </tr>
	</c:forEach>
  </c:forEach>
</table>
</div>
<div class="fanye">
<a href=""><img src="<s:url value='/jsp/edu/css/images/fanye-l.png'/>" /></a>
点击箭头可翻页
<a href=""><img src="<s:url value='/jsp/edu/css/images/fanye-r.png'/>" /></a>
</div>