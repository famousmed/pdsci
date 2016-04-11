<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
	<jsp:param name="findCourse" value="true"/>
</jsp:include>
<script>
$(function(){
	$("#condition").keyup(function(){   
		  if(event.keyCode == 13){
			  submitForm("<s:url value='/njmuedu/user/scheduleInfo'/>");
		  }
	  });
	
});
</script>
<body>      	
        	<div class="registerMsg-m2 fl">
    	<div class="registerMsg-m-inner registerBgw">
        	<div class="registerMsg-tabs">
        	<form id="searchForm" method="post" onsubmit="return false;">
              <div class="module-tabs">
                	<ul class="fl type">
                        <li class="on">学生学习进度</li>
                     </ul>
                    <div class="title-r fr">
                     
                     <input type="hidden" id="url" value="<s:url value='/njmuedu/user/scheduleInfo'/>">
                     <input id="currentPage" type="hidden" name="currentPage" value=""/>
                	 <div class="searchBox fl" id="table_condition">
                	   <input type="text" name="condition" value="${param.condition }"  id="condition" placeholder="学号/学生名称/学校/专业/课程"/>
                	   <img onclick="submitForm('<s:url value='/njmuedu/user/scheduleInfo'/>');" src="<s:url value='/jsp/njmuedu/css/images/search1.png'/>" style="cursor: pointer;"/>
                	 </div>
                	
                	 <div class="tabs-title  module-tabs fl">
        	           <ul>
                       <li id="table_li" class="on" onclick="showTable();"><a href="javascript:void(0);" >表格</a></li>
                       <li id="picture_li" onclick="showPicture('<s:url value='/njmuedu/user/scheduleInfoChart'/>');"><a href="javascript:void(0);" >图表</a></li>
                       </ul>
                      </div>
                	</div>
                </div>
                
              <div style="margin-top: 10px;" id="table_self">
 	     <table border="0" cellpadding="0" cellspacing="0" class="course-table">
 	       <col width="10%">
 	       <col width="10%">
 	       <col width="15%">
 	       <col width="15%">
 	       <col width="15%">
 	       <col width="10%">
 	       <col width="10%">
 	       <col width="15%">
 	       <tr>
 	          <th>学号</th>
 	          <th>姓名</th>
 	          <th>学校</th>
 	          <th>专业</th>
 	          <th>课程名称</th>
 	          <th>已完成</th>
 	          <th>剩余章节数</th>
 	          <th>完成比例</th>
 	       </tr>
 	       <c:if test="${empty eduUserExtList}">
			<tr style="background: none;"><td colspan="8" style="border:none;"><br><br><img src="<s:url value='/jsp/njmuedu/css/images/tanhao.png'/>"/></td></tr>
			<tr><td colspan="8" style="border:none;">暂无记录！</td></tr>
		  </c:if>
 	       <c:forEach items="${eduUserExtList }" var="eduUserExt">
 	          <tr>
 	            <td>${eduUserExt.sid }</td>
 	            <td>${eduUserExt.sysUser.userName }</td>
 	            <td>${eduUserExt.sysOrg.orgName }</td>
 	            <td>${eduUserExt.majorName }</td>
 	            <td colspan="4">
 	              <table width="100%">
 	                 <col width="25%">
 	                 <col width="25%">
 	                 <col width="25%">
 	                 <col width="25%">
 	                 <c:forEach items="${eduUserExt.courseList }" var="course" varStatus="num">
 	                   <tr>
 	                     <td style="<c:if test="${num.last }">border-bottom-width: 0px;</c:if> text-align: left;">&nbsp;${course.courseName }</td>
 	                     <td <c:if test="${num.last }">style="border-bottom-width: 0px;"</c:if>><c:out value="${resultMap[course.courseFlow]['finishMap'][eduUserExt.userFlow] }" default="0"/></td>
 	                     <td <c:if test="${num.last }">style="border-bottom-width: 0px;"</c:if>><c:out value="${resultMap[course.courseFlow]['notFinishMap'][eduUserExt.userFlow] }" default="0"/></td>
 	                     <td <c:if test="${num.last }">style="border-bottom-width: 0px;"</c:if>><c:out value="${resultMap[course.courseFlow]['pointMap'][eduUserExt.userFlow] }" default="0"/>%</td>
 	                   </tr>
 	                 </c:forEach>
 	              </table>
 	            </td>
 	          </tr>
 	       </c:forEach>
		</table>
		<c:if test="${not empty eduUserExtList}">
	      <div class="pages text-center">
      <div class="pagination">
    <ul class="pagination">
      <c:set var="pageView" value="${pdfn:getPageView(eduUserExtList)}" scope="request"></c:set>
	   <pd:pagination-njmuedu toPage="toPage"/>	   
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