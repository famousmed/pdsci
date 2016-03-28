<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
	<jsp:param name="findCourse" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
</jsp:include>
<style type="text/css">
#bubble_p{font-family: Microsoft YaHei;color: #5d6266;font-size: 13px;}
</style>
<script>
function display(userFlow){
 var id = "a_"+userFlow;
 var content = $("#box_"+userFlow).html();
 jboxBubble(id,content,"right",true);
}
function disappear(userFlow){
	jboxBubbleClose();
}
$(function(){
	$("#condition").keyup(function(){   
		  if(event.keyCode == 13){
			  submitForm("<s:url value='/njmuedu/user/tchInfo'/>");
		  }
	  });
	
});
</script>
<body style="background:#f4f4f4;">      	
<div class="registerMsg-m2 fl">
<div class="registerMsg-m-inner registerBgw">
<div class="registerMsg-tabs">

<div class="module-tabs">
	<ul class="fl type">
		<li class="on">教师信息</li>
		
	</ul>
	<form id="searchForm" method="post"  class="fr" onsubmit="return false;">
	<input type="hidden" id="url" value="<s:url value='/njmuedu/user/tchInfo'/>">
	<input id="currentPage" type="hidden" name="currentPage" value=""/>
		<div class="searchBox fl" >
			<input type="text" name="condition" value="${param.condition }" id="condition" placeholder="教师名称/所在学校"/>
			<img onclick="submitForm('<s:url value='/njmuedu/user/tchInfo'/>');" src="<s:url value='/jsp/njmuedu/css/images/search1.png'/>" style="cursor: pointer;"/>
		</div>
		<div class=" module-tabs fl">
			<ul>
				<li><a  href="javascript:void(0);" onclick="addTeacher();" class="add"><img src="<s:url value='/jsp/njmuedu/css/images/add.png'/>" />新增</a></li>
			</ul>
		</div>
	</form>
</div>
<div class="clear"></div> 

<div style="margin-top: 10px;">
   <table border="0" cellpadding="0" cellspacing="0" class="course-table">
     <col width="10%">
     <col width="20%">
     <col width="20%">
     <col width="20%">
     <col width="10%">
     <col width="20%">
		<thead>
		<tr id="top">
			<th>姓名</th>
			<th>学校</th>
			<th>手机号</th>
			<th>邮箱</th>
			<th>带课数</th>
			<th>操作</th>
		</tr>
		</thead>
		<c:if test="${empty eduUserExtList}">
		 <tr style="background: none;"><td colspan="6" style="border:none;"><br><br><img src="<s:url value='/jsp/njmuedu/css/images/tanhao.png'/>"/></td></tr>
		  <tr><td colspan="6" style="border:none;">暂无记录！</td></tr>
		</c:if>
		<c:forEach items="${eduUserExtList }" var="eduUserExt">
		<tr>
		    <td>${eduUserExt.sysUser.userName }</td> 
		    <td>${eduUserExt.sysOrg.orgName }</td>
		    <td>${eduUserExt.sysUser.userPhone }</td>
		    <td>${eduUserExt.sysUser.userEmail }</td>
		    <td>
		      <div class="tab-tip">
		       <a href="javascript:void(0);" onclick="display('${eduUserExt.userFlow }');" id="a_${eduUserExt.userFlow }" title="点击查看详细" >${searchAndCountCourseMap['countCourseMap'][eduUserExt.userFlow] }</a>
		      <div class="box" id="box_${eduUserExt.userFlow }" >
		       <c:forEach items="${searchAndCountCourseMap['searchCourseMap'][eduUserExt.userFlow] }" var="course">
		          <p id="bubble_p" onclick="disappear('${eduUserExt.userFlow }');">${course.courseName }</p>
		       </c:forEach>
		       <c:if test="${empty searchAndCountCourseMap['searchCourseMap'][eduUserExt.userFlow] }">
		       		<p id="bubble_p" onclick="disappear('${eduUserExt.userFlow }');">暂无记录！</p>
		       </c:if>
		      </div>
		      </div>
		    </td>
		    <td>
		     <a href="javascript:void(0)" onclick="editTchIntro('${eduUserExt.userFlow}','${eduUserExt.sysUser.userName}');">编辑</a>&nbsp;|
		     <a href="javascript:void(0)" onclick="searchTchDetail('${eduUserExt.userFlow}','${eduUserExt.sysUser.userName}');">查看</a>
		    </td>   
		</tr>
		</c:forEach>
	</table>
	<c:if test="${not empty eduUserExtList }">
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