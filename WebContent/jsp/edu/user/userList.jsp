<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/jsp/edu/htmlhead-edu.jsp">
	<jsp:param name="findCourse" value="true"/>
</jsp:include>
<script type="text/javascript">
//var height=(window.screen.height)*0.6;
//var width=(window.screen.width)*0.6;
	function lookUser(userFlow){
		var url = "<s:url value='/edu/user/studentInfo?userFlow='/>"+ userFlow;
		jboxOpen(url, "学生信息", 900, 450);
	}
</script>
<body>
<div class="registerMsg-m2 fl">
   <div class="registerMsg-m-inner registerBgw">
      <div class="registerMsg-tabs"> 
    <form id="searchForm" action="<s:url value='/edu/user/userList'/>" method="post">
    <input id="currentPage" type="hidden" name="currentPage" value=""/>
    <input type="hidden" id="url" value="<s:url value='/edu/user/userList'/>">
   	<div class="module-tabs">
   	  <ul class="fl type">
		<li class="on">学生信息</li>
	 </ul>
      <div class="title-r fr">
      	<div class="searchBox fl">
      	   <input type="text"  placeholder="请输入学校名称/学生姓名" name="condition" value="${param.condition}" />
      	   <img onclick="submitForm('<s:url value='/edu/user/userList'/>');" src="<s:url value='/jsp/edu/css/images/search1.png'/>" style="cursor: pointer;" title="搜索"/> 
      	</div>
      	
          <div class="tabs-title  module-tabs fl">
          	<ul>
              	<li <c:if test="${empty param.statusId}">class="on"</c:if>  onclick="changeStatusId('','<s:url value='/edu/user/userList'/>');"><a href="javascript:void(0);" >全部</a></li>
                  <li <c:if test="${param.statusId==userStatusEnumReged.id }">class="on"</c:if> onclick="changeStatusId('${userStatusEnumReged.id }','<s:url value='/edu/user/userList'/>');"><a href="javascript:void(0);" >${userStatusEnumReged.name }</a></li>
              </ul>
              <input type="hidden" name="statusId" id="statusId" />
          </div>
      </div>
    </div>
	<div style="margin-top: 10px;"> 
	<table border="0" cellpadding="0" cellspacing="0" class="course-table">
		<tr>
			<th width="9%">姓名</th>
			<th width="11%">学校</th>
			<th width="12%">专业</th>
			<th width="7%">届别</th>
			<th width="11%">学号</th>
			<th width="16%">身份证</th>
			<th width="18%">学分</th>
			<th width="8%">状态</th>
			<th>操作</th>
		</tr>
		<c:forEach items="${userList }" var="userExt">
		<tr>
			<td>${userExt.sysUser.userName }</td>
			<td>${userExt.sysUser.orgName }</td>
			<td>${userExt.majorName }</td>
			<td>${userExt.period }</td>
			<td>${userExt.sid }</td>
			<td>${userExt.sysUser.idNo }</td>
			<td>${userExt.credit}</td>
			<td>${userExt.sysUser.statusDesc}</td>
			<td>
				<c:if test="${userExt.sysUser.statusId==userStatusEnumReged.id}">[<a href="javascript:checkUser('${userExt.userFlow }')">审核</a>]&nbsp;[<a href="javascript:lookUser('${userExt.userFlow }')">查看</a>]</c:if>
				<c:if test="${userExt.sysUser.statusId==userStatusEnumActivated.id}">[<a href="javascript:lookUser('${userExt.userFlow }')">查看</a>]</c:if>
			</td>
		</tr>
		</c:forEach>
		<c:if test="${empty userList}">
		<tr style="background: none;"><td colspan="9" style="border:none;"><br><br><img src="<s:url value='/jsp/edu/css/images/tanhao.png'/>"/></td></tr>
		<tr><td colspan="9" style="border:none;">暂无记录！</td></tr>
		</c:if>
	</table>
	<div></div>
	</div>
	</form>
	<c:if test="${not empty userList}">
	      <div class="pages text-center">
      <div class="pagination">
    <ul class="pagination">
      <c:set var="pageView" value="${pdfn:getPageView(userList)}" scope="request"></c:set>
	   <pd:pagination-edu toPage="toPage"/>	   
    </ul>
  </div>
  </div> 
   </c:if>    
</div>
  
          </div>
        </div>
    
</body>