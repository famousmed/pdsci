<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
	<jsp:param name="findCourse" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
</jsp:include>
<script>
 function creditDetail(userFlow,userName){
	 jboxOpen("<s:url value='/njmuedu/user/creditDetail'/>?userFlow="+userFlow,userName+"的学分信息",900,500);
 }
 $(function(){
		$("#condition").keyup(function(){   
			  if(event.keyCode == 13){
				  submitForm("<s:url value='/njmuedu/user/creditInfo'/>");
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
                        <li class="on">学分管理</li>
                     </ul>
                     <form id="searchForm" method="post"  class="fr" onsubmit="return false;">
                     <input id="currentPage" type="hidden" name="currentPage" value=""/>
                     <input type="hidden" id="url" value="<s:url value='/njmuedu/user/creditInfo'/>">
                	 <div class="searchBox fl" >
                	   <input type="text" name="condition" value="${param.condition }" id="condition" placeholder="学生名称/学校/专业"/>
                	   <img onclick="submitForm('<s:url value='/njmuedu/user/creditInfo'/>');" src="<s:url value='/jsp/njmuedu/css/images/search1.png'/>" style="cursor: pointer;"/>
                	 </div>
                	</form>
                </div>
               <div class="clear"></div> 
              <div style="margin-top: 10px;">
 	     <table border="0" cellpadding="0" cellspacing="0" class="course-table">
 	       <col width="10%">
 	       <col width="20%">
 	       <col width="20%">
 	       <col width="10%">
 	       <col width="10%">
 	       <col width="10%">
 	       <col width="10%">
 	       <col width="10%">
						<thead>
						<tr id="top">
							<th>学生名称</th>
							<th>学校</th>
							<th>专业名称</th>
							<th>必修课</th>
							<th>选修课</th>
							<th>应得学分</th>
							<th>获得学分</th>
							<th>操作</th>
						</tr>
						</thead>
						<c:if test="${empty eduUserExtList }">
						   <tr style="background: none;"><td colspan="8" style="border:none;"><br><br><img src="<s:url value='/jsp/njmuedu/css/images/tanhao.png'/>"/></td></tr>
						   <tr><td colspan="8" style="border:none;">暂无记录！</td></tr>
						</c:if>
						<c:forEach items="${eduUserExtList }" var="eduUserExt">
						<tr>
						    <td>${eduUserExt.sysUser.userName }</td> 
						    <td>${eduUserExt.sysOrg.orgName }</td>
						    <td>${eduUserExt.majorName }</td>
						    <td>

						         ${fn:length(searchStudentChooseCourseMap['required'][eduUserExt.sysUser.userFlow]) }                                     
						    </td>
						    <td> 
						        ${fn:length(searchStudentChooseCourseMap['optional'][eduUserExt.sysUser.userFlow]) }                                  
						    </td>
						    <td>${searchStudentChooseCourseMap['allCreditMap'][eduUserExt.sysUser.userFlow] }</td>
						    <td>${searchStudentChooseCourseMap['actualCreditMap'][eduUserExt.sysUser.userFlow] }</td>   
						    <td><a href="javascript:void(0)" onclick="creditDetail('${eduUserExt.userFlow}','${eduUserExt.sysUser.userName }');">查看</a></td>
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