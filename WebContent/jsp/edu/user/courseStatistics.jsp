<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>医学教育知识平台</title>
<meta name="keywords" content=""/>
<meta name="description" content=""/>
<jsp:include page="/jsp/edu/htmlhead-edu.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="courseDetail" value="true"/>
	<jsp:param name="teachCourses" value="true"/>
</jsp:include>
<style type="text/css">
.overview{text-align: left;}
</style>
<script type="text/javascript">
function toPage(page) {
	if(page!=undefined){
		$("#currentPage").val(page);			
	}
	$("#searchForm").submit();
}
function showEvaluate(obj, orgFlow, majorId, evaluate){
	var title ="中评";
	if(obj=="lowScoreCount"){
		title ="差评";
	}
	if(obj=="leaveMessageCount"){
		title ="留言";
	}
	jboxOpen("<s:url value='/edu/course/searchCourseSchedule'/>?courseFlow=${courseFlow}&userFlow=${sessionScope.currUser.userFlow}&condition="+obj +"&orgFlow=" +orgFlow +"&majorId=" + majorId +"&evaluateFlag=" + evaluate, "查看"+title, 900,450);
}
</script>
</head>
<body style="background: none;">
      <c:choose>
      <c:when test="${flag==1 }">
        	<div class="overview">
				<img src="<s:url value='/jsp/edu/css/images/xxjd.png'/>" />学习进度
			</div>
			<!-- 报表开始 -->
			<div style="text-align: center;">
			<jsp:include page="survey/study_schedule_chart.jsp" ></jsp:include>
			</div>
			<!-- 报表结束 -->
			<div class="module-tabs">
			      <div class="title-r fr">
			      	<div class="searchBox fl">
			      	<form id="searchForm" method="post" action="<s:url value='/edu/course/courseDetail/${courseFlow}'/>">
			      	   <input type="text"  placeholder="学校名称/学生姓名/专业" name="condition" value="${param.condition}" />
			      	   <input type="hidden" name="flag" value="${flag }"/>
			      	   <img onclick="submitForm();" src="<s:url value='/jsp/edu/css/images/search1.png'/>" style="cursor: pointer;" title="搜索"/> 
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
			<div class="pages text-center">
      <div class="pagination">
    <ul class="pagination">
      <c:set var="pageView" value="${pdfn:getPageView(eduUserExtList)}" scope="request"></c:set>
	   <pd:pagination-edu toPage="toPage"/>	   

    </ul>
  </div>
  </div>
			</div>
			</c:when>
			<c:when test="${flag==2}">
				<div class="overview">
					<img src="<s:url value='/jsp/edu/css/images/wdqk.png'/>" />问答情况
				</div>
				<!-- 报表开始 -->
				<div style="text-align: center;">
					<jsp:include page="survey/question_chart.jsp" ></jsp:include>
				</div>
				<!-- 报表结束 -->
				<div class="module-tabs">
				      <div class="title-r fr">
				      	<div class="searchBox fl">
				<form id="searchForm" method="post" action="<s:url value='/edu/course/courseDetail/${courseFlow}'/>">
				          <p>
				          <input type="hidden" name="flag" value="${flag }"/>
				           <input type="text"  placeholder="学校名称/专业名称" name="condition" value="${param.condition}" />
				      	   <img onclick="submitForm();" src="<s:url value='/jsp/edu/css/images/search1.png'/>" style="cursor: pointer;" title="搜索"/>                  
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
				          <c:forEach items="${org.majorFormList }" var="majorForm" varStatus="num"> 
				           <tr>
				             <td <c:if test="${num.last }">style="border-bottom-width: 0px;"</c:if>>${majorForm.majorName }</td>
				             <td <c:if test="${num.last }">style="border-bottom-width: 0px;"</c:if>>${questionCountFormMap['all'][org.orgFlow][majorForm.majorId] }</td>
				             <td <c:if test="${num.last }">style="border-bottom-width: 0px;"</c:if>>${questionCountFormMap[eduQuestionStatusEnumAnswered.id][org.orgFlow][majorForm.majorId] }</td>
				             <td <c:if test="${num.last }">style="border-bottom-width: 0px;"</c:if>>${questionCountFormMap[eduQuestionStatusEnumUnanswered.id][org.orgFlow][majorForm.majorId] }</td>
				           </tr>
				           </c:forEach>
				         </table>
				        </td>
				     </tr>
				  </c:forEach>
				</table>
				</div>
			</c:when>
				<c:when test="${flag==3}">
					<div class="overview">
						<img src="<s:url value='/jsp/edu/css/images/kcpj.png'/>" />课程评价
					</div>
				<!-- 报表开始 -->
				<div style="text-align: center;">
					<jsp:include page="survey/evaluate_chart.jsp" ></jsp:include>
				</div>
				<!-- 报表结束 -->
					<div class="module-tabs">
					      <div class="title-r fr">
					      	<div class="searchBox fl">
								<form id="searchForm" action="<s:url value='/edu/course/courseDetail/${courseFlow }'/>" method="post">
					          	<p>
					          	   <input type="hidden" name="flag" value="${flag }"/>
						           <input type="text"  placeholder="专业名称" name="condition" value="${param.condition}" />
						      	   <img onclick="submitForm();" src="<s:url value='/jsp/edu/css/images/search1.png'/>" style="cursor: pointer;" title="搜索"/>                  
					         	</p>
						        </form>
					     	</div>
					      </div>
					</div> 
					<div style="margin-top: 10px;"> 
					<table border="0" width="100%" class="course-table">
					<col width="20%">
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
					      <td colspan="8">无记录！</td>
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
					        	<a href="javascript:void(0);" onclick="showEvaluate('middleScoreCount','${orgExt.orgFlow}','${majorForm.majorId}','');">${resultMap[orgExt.orgFlow][majorForm.majorId].middleScoreCount}</a>
					        </td>
					        <td>
					        	<a href="javascript:void(0);" onclick="showEvaluate('lowScoreCount','${orgExt.orgFlow}','${majorForm.majorId}','');">${resultMap[orgExt.orgFlow][majorForm.majorId].lowScoreCount}</a>
					        </td>
					        <td>
					       		<a href="javascript:void(0);" onclick="showEvaluate('leaveMessageCount','${orgExt.orgFlow}','${majorForm.majorId}','evaluate');">${resultMap[orgExt.orgFlow][majorForm.majorId].leaveMessageCount}</a>
					        </td>
					     </tr>
						</c:forEach>
					  </c:forEach>
					</table>
					</div>
				</c:when>
				<c:when test="${flag==4}">
					<div class="overview">
						<img src="<s:url value='/jsp/edu/css/images/kscy.png'/>" />考试测验情况
					</div>
				<!-- 报表开始 -->
				<div style="text-align: center;">
					
				</div>
				<!-- 报表结束 -->
					<div class="module-tabs">
					      <div class="title-r fr">
					      	<div class="searchBox fl">
								<form id="searchForm" action="<s:url value='/edu/course/courseDetail/${courseFlow }'/>" method="post">
					          	<p>
					          	   <input type="hidden" name="flag" value="${flag }"/>
						           <input type="text"  placeholder="学校/专业/姓名/学号" name="condition" value="${param.condition}" />
						      	   <img onclick="submitForm();" src="<s:url value='/jsp/edu/css/images/search1.png'/>" style="cursor: pointer;" title="搜索"/>                  
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
					  <th>姓名</th>
					  <th>学校</th>
					  <th>专业</th>
					  <th>学号</th>
					  <th>分数情况</th>
					</tr>
					 <c:if test="${empty eduUserExtList}">
					    <tr>
					      <td colspan="5">无记录！</td>
					    </tr>
					 </c:if>
					 	
					 <c:forEach items="${eduUserExtList}" var="eduUserExt">
					     <tr>
					       <td>${eduUserExt.sysUser.userName }</td>
					       <td>${eduUserExt.sysOrg.orgName }</td>
					       <td>${eduUserExt.majorName }</td>
					       <td>${eduUserExt.sid }</td>
					       <td><a href="javascript:void(0);" onclick="">详细</a></td>
					     </tr>
					 </c:forEach>
					</table>
					</div>
				</c:when>
				<c:when test="${flag==5}">
					<div class="overview">
						<img src="<s:url value='/jsp/edu/css/images/xfqk.png'/>" />学分情况
					</div>
				<!-- 报表开始 -->
				<div style="text-align: center;">
					
				</div>
				<!-- 报表结束 -->
					<div class="module-tabs">
					      <div class="title-r fr">
					      	<div class="searchBox fl">
								<form id="searchForm" action="<s:url value='/edu/course/courseDetail/${courseFlow }'/>" method="post">
					          	<p>
					          	   <input type="hidden" name="flag" value="${flag }"/>
						           <input type="text"  placeholder="学校/专业/姓名/学号" name="condition" value="${param.condition}" />
						      	   <img onclick="submitForm();" src="<s:url value='/jsp/edu/css/images/search1.png'/>" style="cursor: pointer;" title="搜索"/>                  
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
					  <th>姓名</th>
					  <th>学校</th>
					  <th>专业</th>
					  <th>学号</th>
					  <th>获得学分</th>
					</tr>
					 <c:if test="${empty eduUserExtList}">
					    <tr>
					      <td colspan="5">无记录！</td>
					    </tr>
					 </c:if>
					 	
					 <c:forEach items="${eduUserExtList}" var="eduUserExt">
					     <tr>
					       <td>${eduUserExt.sysUser.userName }</td>
					       <td>${eduUserExt.sysOrg.orgName }</td>
					       <td>${eduUserExt.majorName }</td>
					       <td>${eduUserExt.sid }</td>
					       <td><c:out value="${userAndCourseCreditMap[eduUserExt.userFlow] }" default="0"/></td>
					     </tr>
					 </c:forEach>
					</table>
					</div>
				</c:when>
			</c:choose>

</body>
</html>