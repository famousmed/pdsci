<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
	<jsp:param name="findCourse" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
</jsp:include>

<body>      	
        	<div class="registerMsg-m2 fl">
    	<div class="registerMsg-m-inner registerBgw">
        	<div class="registerMsg-tabs">
              <div class="module-tabs">
                	<ul class="fl type">
                        <li class="on">测验考试情况</li>
                     </ul>
                     <form id="searchForm" method="post"  class="fr">
                     <input id="currentPage" type="hidden" name="currentPage" value=""/>
                     <input type="hidden" id="url" value="<s:url value='/njmuedu/user/testInfo'/>">
                	 <div class="searchBox fl" >
                	   <input type="text" name="condition" value="${param.condition }" placeholder="学号/学生名称/学校/专业/课程"/>
                	   <img onclick="submitForm('<s:url value='/njmuedu/user/testInfo'/>');" src="<s:url value='/jsp/njmuedu/css/images/search1.png'/>" style="cursor: pointer;"/>
                	 </div>
                	</form>
                </div>
               <div class="clear"></div> 
              <div style="margin-top: 10px;">
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
 	          <th>分数</th>
 	          <th>操作</th>
 	       </tr>
 	       <c:if test="${empty eduUserExtList }">
 	       <tr style="background: none;"><td colspan="7" style="border:none;"><br><br><img src="<s:url value='/jsp/njmuedu/css/images/tanhao.png'/>"/></td></tr>
			<tr><td colspan="7" style="border:none;">暂无记录！</td></tr>
			</c:if>
 	       <c:forEach items="${eduUserExtList }" var="eduUserExt">
 	          <tr>
 	            <td>${eduUserExt.sid }</td>
 	            <td>${eduUserExt.sysUser.userName }</td>
 	            <td>${eduUserExt.sysOrg.orgName }</td>
 	            <td>${eduUserExt.majorName }</td>
 	            <td colspan="3">
 	              <table width="100%">
 	                 <col width="40%">
 	                 <col width="30%">
 	                 <col width="30%">
 	                 <c:forEach items="${eduUserExt.courseList }" var="course" varStatus="num">
 	                   <tr>
 	                     <td style="<c:if test="${num.last }">border-bottom-width: 0px;</c:if> text-align: left;">&nbsp;${course.courseName }</td>
 	                     <td <c:if test="${num.last }">style="border-bottom-width: 0px;"</c:if>></td>
 	                     <td <c:if test="${num.last }">style="border-bottom-width: 0px;"</c:if>>[<a href="javascript:void(0);">查看</a>]</td>
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
     </div>
          </div>
        </div>