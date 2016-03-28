<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
	<jsp:param name="findCourse" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
</jsp:include>
<script>
$(function(){
	$("#condition").keyup(function(){   
		  if(event.keyCode == 13){
			  submitForm("<s:url value='/njmuedu/user/courseInfo'/>");
		  }
	  });
	
});
</script>
<body>      	
        	<div class="registerMsg-m2 fl">
    	<div class="registerMsg-m-inner registerBgw">
        	<div class="registerMsg-tabs">
        
              <div class="module-tabs">
               	<ul class="fl type">
                   	<li class="on">课程概况</li>
                   </ul>
                   <form id="searchForm" method="post"  class="fr" onsubmit="return false;">
               	<div class="searchBox fl" id="table_condition">
               	   <input type="text" name="searchCondition" value="${param.searchCondition }"  id="condition" placeholder="类别/课程名称/教师"/>
               	   <img onclick="submitForm('<s:url value='/njmuedu/user/courseInfo'/>');" src="<s:url value='/jsp/njmuedu/css/images/search1.png'/>" style="cursor: pointer;"/>
               	</div>
               	<div class="tabs-title  module-tabs fl">
	          		<ul>
	              		<li id="table_li" class="on" onclick="showTable();"><a href="javascript:void(0);" >表格</a></li>
                       <%--  <li id="picture_li" onclick="showPicture('<s:url value='/njmuedu/user/courseInfoChart'/>');"><a href="javascript:void(0);" >图表</a></li> --%>
	              </ul>
	          	</div>
               	</form>
			</div>
               <div class="clear"></div> 
              <div style="margin-top: 10px;" id="table_self">
 	<table border="0" cellpadding="0" cellspacing="0" class="course-table">
						<thead>
						<tr id="top">
							<th width="8%">类别</th>
							<th width="20%">课程名称</th>
							<th width="16%">授课老师</th>
							<th width="10%">学时数</th>
							<th width="5%">学分</th>
							<th width="10%">章节数</th>
							<th width="5%">评分</th>
							<th width="8%">学习人数</th>
							<th width="8%">完成人数</th>
							<th width="10%">完成比例</th>
						</tr>
						</thead>
						
						<tbody>
						<c:if test="${empty courseList }">
 	       <tr style="background: none;"><td colspan="10" style="border:none;"><br><br><img src="<s:url value='/jsp/njmuedu/css/images/tanhao.png'/>"/></td></tr>
			<tr><td colspan="10" style="border:none;">暂无记录！</td></tr>
			</c:if>
						<c:forEach items="${courseList}" var="course">
							<tr>
							    <td>
							    <c:choose>
			                         <c:when test="${course.courseTypeId eq njmuEduCourseTypeEnumRequired.id }">
			                            <input class="r-bnt" type="button" value="${course.courseTypeName }" />
			                         </c:when>
			                         <c:when test="${course.courseTypeId eq njmuEduCourseTypeEnumOptional.id }">
			                            <input class="i-bnt" type="button" value="${course.courseTypeName }" />
			                         </c:when>
			                         <c:when test="${course.courseTypeId eq njmuEduCourseTypeEnumPublic.id }">
			                            <input class="b-bnt" type="button" value="${course.courseTypeName }" />
			                         </c:when>
			                      </c:choose>
							    </td>
								<td><a href="<s:url value='/njmuedu/course/courseDetail/${course.courseFlow }'/>">${course.courseName}</a></td>
								<td>
								  <c:choose>
								    <c:when test="${not empty teacherMap[course.courseFlow] }">
								      <c:forEach items="${teacherMap[course.courseFlow] }" var="teacher">
								      ${teacher.userName }&#12288;
								      </c:forEach>
								    </c:when>
								    <c:otherwise>
								               
								    </c:otherwise>
								  </c:choose>
								</td>
								<td>
									${course.coursePeriod}
								</td>
								<td>
									${course.courseCredit}
								</td>
								<td>
									<c:if test="${not empty parentChapterNullMap[course.courseFlow]}">${parentChapterNullMap[course.courseFlow]}章</c:if>
									<c:if test="${empty parentChapterNullMap[course.courseFlow]}">0章</c:if>
									<c:if test="${not empty parentChapterNotNullMap[course.courseFlow]}">${parentChapterNotNullMap[course.courseFlow]}节</c:if>
									<c:if test="${empty parentChapterNotNullMap[course.courseFlow]}">0节</c:if>
								</td>
								<td>
									<c:if test="${not empty scoreMap[course.courseFlow]}">${scoreMap[course.courseFlow]}分</c:if>
									<c:if test="${empty scoreMap[course.courseFlow]}">0分</c:if>
								</td>
								<td>
									<c:if test="${not empty studentCountMap[course.courseFlow]}">${studentCountMap[course.courseFlow]}</c:if>
									<c:if test="${empty studentCountMap[course.courseFlow]}">0</c:if>
								</td>
								<td>
									<c:if test="${not empty studyFinishCountMap[course.courseFlow]}">${studyFinishCountMap[course.courseFlow]}</c:if>
									<c:if test="${empty studyFinishCountMap[course.courseFlow]}">0</c:if>
								</td>
								<td >
								  <c:choose>
								    <c:when test="${studyFinishCountMap[course.courseFlow]==0 or empty studyFinishCountMap[course.courseFlow]}">
								       0.00%
								    </c:when>
								    <c:otherwise>
									${pdfn:getPercent(studyFinishCountMap[course.courseFlow],studentCountMap[course.courseFlow])}
								    </c:otherwise>
								  </c:choose>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
 </div> 
             <iframe id="picture" style="width:100%;height: 450px; border: 0px; display: none;"></iframe>      
              
     

            </div>
          </div>
        </div>