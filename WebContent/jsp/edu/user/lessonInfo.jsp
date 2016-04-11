<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/jsp/edu/htmlhead-edu.jsp">
	<jsp:param name="findCourse" value="true"/>
</jsp:include>
<script type="text/javascript">
function searchLesson(){
	var url = "<s:url value='/edu/user/lessionInfo'/>";
	jboxPostLoad("content",url,$("#searchForm").serialize(),true);
}

</script>
<body>
<div class="registerMsg-m2 fl">
   <div class="registerMsg-m-inner registerBgw">
      <div class="registerMsg-tabs"> 
    <form id="searchForm"  method="post">
     <input type="hidden" id="url" value="<s:url value='/edu/user/lessionInfo'/>">
     <input id="currentPage" type="hidden" name="currentPage" value=""/>
   	<div class="module-tabs">
   	     <ul class="fl type">
             <li class="on">教师授课信息</li>
         </ul>
      <div class="title-r fr">
      	<div class="searchBox fl" id="table_condition">
      	   <input type="text"  placeholder="姓名/所属学校" name="condition" value="${param.condition}" />
      	   <img onclick="searchLesson();" src="<s:url value='/jsp/edu/css/images/search1.png'/>" style="cursor: pointer;" title="搜索"/> 
      	</div>
      	
        <div class="tabs-title  module-tabs fl">
        	<ul>
              <li id="table_li" class="on" onclick="showTable();"><a href="javascript:void(0);" >表格</a></li>
              <li id="picture_li" onclick="showPicture('<s:url value='/edu/user/lessionInfoChart'/>');"><a href="javascript:void(0);" >图表</a></li>
          </ul>
        </div>
      </div>
    </div>
	<div style="margin-top: 10px;" id="table_self"> 
	<table  border="0" cellpadding="0" cellspacing="0" class="course-table" style="width: 100%;">
		<col width="10%">
		<col width="10%">
		<col width="10%">
		<col width="10%">
		<col width="10%">
		<col width="10%">
		<col width="10%">
		<col width="10%">
		<col width="10%">
		<col width="10%">
		<tr>
			<th>姓名</th>
			<th>所属学校</th>
			<th>所授课程</th>
			<th>好评数</th>
			<th>中评数</th>
			<th>差评数</th>
			<th>点赞数</th>
			<th>被关注量</th>
			<th>回答问题数</th>
			<th>待回复问题数</th>
		</tr>
		<c:forEach items="${eduUserExtList}" var="eduUserExt">
		<tr>
			<td>${eduUserExt.sysUser.userName }</td>
			<td>${eduUserExt.sysOrg.orgName }</td>
			<td colspan="8">
			  <table width="100%">
			  <col width="12.5%">
			  <col width="12.5%">
			  <col width="12.5%">
			  <col width="12.5%">
			  <col width="12.5%">
			  <col width="12.5%">
			  <col width="12.5%">
			  <col width="12.5%">
			   <c:forEach items="${eduUserExt.courseList }" var="course" varStatus="num">
			      <tr>
			        <td <c:if test="${num.last }">style="border-bottom-width: 0px;"</c:if>>${course.courseName }</td>
			        <td <c:if test="${num.last }">style="border-bottom-width: 0px;"</c:if>>${resultMap[eduUserExt.userFlow][course.courseFlow].highScoreCount }</td>
			        <td <c:if test="${num.last }">style="border-bottom-width: 0px;"</c:if>>${resultMap[eduUserExt.userFlow][course.courseFlow].middleScoreCount }</td>
			        <td <c:if test="${num.last }">style="border-bottom-width: 0px;"</c:if>>${resultMap[eduUserExt.userFlow][course.courseFlow].lowScoreCount }</td>
			        <td <c:if test="${num.last }">style="border-bottom-width: 0px;"</c:if>>${resultMap[eduUserExt.userFlow][course.courseFlow].praiseCount }</td>
			        <td <c:if test="${num.last }">style="border-bottom-width: 0px;"</c:if>>${resultMap[eduUserExt.userFlow][course.courseFlow].collectionCount}</td>
			        <td <c:if test="${num.last }">style="border-bottom-width: 0px;"</c:if>>${resultMap[eduUserExt.userFlow][course.courseFlow].answeredCount }</td>
			        <td <c:if test="${num.last }">style="border-bottom-width: 0px;"</c:if>>${resultMap[eduUserExt.userFlow][course.courseFlow].unansweredCount }</td>
			      </tr>
			   </c:forEach>
			  </table>
			</td>
			
		</tr>
		</c:forEach>
		
		<c:if test="${empty eduUserExtList}">
			<tr style="background: none;"><td colspan="9" style="border:none;"><br><br><img src="<s:url value='/jsp/edu/css/images/tanhao.png'/>"/></td></tr>
			<tr><td colspan="9" style="border:none;">暂无记录！</td></tr>
		</c:if>
	</table>
	 <c:if test="${not empty eduUserExtList}">
	      <div class="pages text-center">
      <div class="pagination">
    <ul class="pagination">
      <c:set var="pageView" value="${pdfn:getPageView(eduUserExtList)}" scope="request"></c:set>
	   <pd:pagination-edu toPage="toPage"/>	   
    </ul>
  </div>
  </div> 
   </c:if> 
	</div>
	</form>
	
    <iframe id="picture" style="width:100%;height: 450px; border: 0px; display: none;"></iframe>
</div>
          </div>
        </div>
</body>