<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
	<jsp:param name="findCourse" value="true"/>
</jsp:include>
<script type="text/javascript">
function answerDetail(questionFlow,teacherFlow){
	var height=(window.screen.height)*0.6;
	var width=(window.screen.width)*0.7;
	var url = "<s:url value='/njmuedu/studyHistory/answerDetail?questionFlow='/>"+ questionFlow+"&teacherFlow="+teacherFlow;
	jboxOpen(url, "回复详情", width, height);
}

$(function(){
	$("#myCourseName").keyup(function(){   
		  if(event.keyCode == 13){
			  questionSearchSubmit();
		  }
	  });
	
});
</script>
<body>
<div class="registerMsg-m2 fl">
   <div class="registerMsg-m-inner registerBgw">
      <div class="registerMsg-tabs"> 
    <form id="questionSearchForm"  onsubmit="return false;">
   	<div class="module-tabs">
   	  <div class="fl">
         <span class="titi"><img src="<s:url value='/jsp/njmuedu/css/images/talk.png'/>" />我的问答</span>
      </div>
      <div class="title-r fr">
      	<div class="searchBox fl">
      	   <input type="text"  placeholder="课程名称/问题内容" name="courseName" id="myCourseName" value="${param.courseName}" />
      	   <img onclick="questionSearchSubmit();" src="<s:url value='/jsp/njmuedu/css/images/search1.png'/>" style="cursor: pointer;" title="搜索"/> 
      	</div>
         <%--  <div class="tabs-title  module-tabs fl">
          	<ul>
              	<li <c:if test="${empty param.statusId}">class="on"</c:if> id="create_time" onclick="changeStatusId('');"><a href="javascript:void(0);" >全部</a></li>
                  <li <c:if test="${param.statusId==userStatusEnumReged.id }">class="on"</c:if>id="course_order" onclick="changeStatusId('${userStatusEnumReged.id }');"><a href="javascript:void(0);" >${userStatusEnumReged.name }</a></li>
              </ul>
              <input type="hidden" name="statusId" id="statusId" />
          </div> --%>
      </div>
    </div>
	<div style="margin-top: 10px;">
	<table border="0" cellpadding="0" cellspacing="0" class="course-table">
		<tr>
			<th width="10%">提问时间</th>
			<th>问题内容</th>
			<th width="15%">课程名称</th>
			<th width="20%">章节名称</th>
			<th width="10%">授课老师</th>
			<th width="8%">操作</th>
		</tr>
		<c:forEach items="${qList }" var="qExt">
		<tr>
			<td>${pdfn:transDateForPattern(qExt.questionTime,"yyyy-MM-dd HH:mm:ss") }</td>
			<td>${pdfn:cutString(qExt.questionContent,50,true,3) }</td>
			<td>${qExt.course.courseName }</td>
			<td>${qExt.chapterExt.chapterName }</td>
			<td>${qExt.chapterExt.teacher.userName }</td>
			<td>[<a href="javascript:void(0);" onclick="answerDetail('${qExt.questionFlow}','${qExt.chapterExt.teacher.userFlow }')">查看回复</a>]</td>
		</tr>
		</c:forEach>
		<c:if test="${empty qList}">
		<tr style="background: none;"><td colspan="6" style="border:none;"><br><br><img src="<s:url value='/jsp/njmuedu/css/images/tanhao.png'/>"/></td></tr>
		<tr><td colspan="6" style="border:none;">暂无记录！</td></tr>
		</c:if>
	</table>
	</div>
	</form>
</div>
          </div>
        </div>
</body>