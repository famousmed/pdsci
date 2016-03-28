<%@ include file="/jsp/jspf/prelude.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学习中心-课程详情</title>
<meta name="keywords" content=""/>
<meta name="description" content=""/>

<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="edu_basic" value="true"/>
	<jsp:param name="res_edu_jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="courseDetail" value="true"/>
</jsp:include>


<script type="text/javascript">
function changeUser(){
	  //获取学生总人数
	 var allUserAmount=parseInt($("#countUser").val());
	 flagCount();
	 //获取当前学生起始位置
	 var userStartAmount=parseInt($("#userStartSort").val());
	 //获取当前学生结束位置
	 var userEndAmount=parseInt($("#userEndSort").val());
	   if(userEndAmount>(allUserAmount+5-(allUserAmount%5))){
		 $("#userStartSort").val("1");
		 $("#userEndSort").val("5"); 
	  }
	   userStartAmount=parseInt($("#userStartSort").val());
	   userEndAmount=parseInt($("#userEndSort").val());
	   var userBox=$(".userLi");
		  $.each(userBox , function(i , n){
			  $(n).hide();
		    if(parseInt($(n).attr("id"))>=userStartAmount && parseInt($(n).attr("id"))<=userEndAmount)
			    $(n).show();  
			});
}
function flagCount(){
	 var userStartAmount=$("#userStartSort").val(); 
	 var userEndAmount=$("#userEndSort").val();
	 userStartAmount=parseInt(userStartAmount)+5;
	 userEndAmount=parseInt(userEndAmount)+5;
	 $("#userStartSort").val(userStartAmount);
	 $("#userEndSort").val(userEndAmount);
}
 $(document).ready(function(){
	 changeTag("content1",$("#tag1"),"<s:url value='/resedu/course/studentChapter?courseFlow=${course.courseFlow}'/>");
	 var userBox=$(".userLi");
	  $.each(userBox , function(i , n){
	    if(parseInt($(n).attr("id"))>=1 && parseInt($(n).attr("id"))<=5)
		    $(n).show();  
		});
});
 
 function continueStudy(){
	 var url = "<s:url value='/jsp/res/edu/student/courseDetail.jsp'/>?source=${param.source}";
	 window.location.href = url;
 }
 
 function collection(){
	 $("#gzkc-a").css("background-image","url(<s:url value='/jsp/edu/css/images/gzh-on.png'/>)");
 }
 
 
 function shrinkContent(){
	 var mainDiv=$("#mainContent");
	 var rightDiv=$("#rightContent");
	 $(mainDiv).removeClass("videoLists-l");
	 $(mainDiv).removeClass("videoLists-r");
	 $(rightDiv).show();
	 $(mainDiv).addClass("videoLists-l");
 }
 
 function joinMyCourseList(courseFlow){
	 var msg="确认把该课程加入我的课程中吗？";
	 jboxConfirm(msg,function(){
	 var url = "<s:url value='/resedu/course/joinMyCourseList'/>?courseFlow="+courseFlow;
	 jboxPost(url,null,
				function(resp){
		           if(resp!='${GlobalConstant.OPRE_FAIL}'){
		        	   jboxTip('${GlobalConstant.OPRE_SUCCESSED}');
		        	   window.location.reload(true);
		           }
				},
				null,false);
	 });
 }
 function startStudy(firstChapterFlow){
	 if(firstChapterFlow!=""){
		 var url = "<s:url value='/resedu/course/chapterDetail'/>?chapterFlow="+firstChapterFlow;
		 window.location.href = url;
	 }else{
		 jboxInfo("这门课尚未添加任何章节！");
	 }
 }
 function continueStudy(){
	 var url = "<s:url value='/resedu/course/continueStudy'/>?courseFlow=${course.courseFlow}";
	 window.location.href = url;
 }
 function changeTag(contentId,obj,url){
	 var tags = $(".tag");
	    $.each(tags , function(i , n){
	    	$(n).removeClass("on");
	    });
	    $(obj).addClass("on");
	    var contents=$('.content');
	    $.each(contents , function(i , n){
	    	$(n).hide();
	    });
	    jboxLoad(contentId,url,false);
	    $("#"+contentId).show();
 }
 function checkChapter(nowChapterFlow,courseFlow){
	  var url = "<s:url value='/resedu/course/checkChapter'/>?chapterFlow="+nowChapterFlow+"&courseFlow="+courseFlow;
	 jboxPost(url,null,function(resp){
		            if(resp==nowChapterFlow){
		            	url="<s:url value='/resedu/course/chapterDetail'/>?chapterFlow="+nowChapterFlow;
						window.location.href=url;
		            }else{
		            	jboxTip(resp);
		            }
		},function(resp){},false); 
 }
 function showAndHide(parentFlow,obj){
	 var sonNodeFlows=$(".sonNode_"+parentFlow);
	 $.each(sonNodeFlows , function(i , n){
		 $(n).slideToggle("normal");
	 }); 
	 if(!$(obj).parent().hasClass("learnchapter-active")){
		 $(obj).parent().addClass("learnchapter-active");
	 }else if($(obj).parent().hasClass("learnchapter-active")){
		 $(obj).parent().removeClass("learnchapter-active");
	 }
 }
</script>
<style>
#register {
background: url("<s:url value='/css/skin/${skinPath}/images/station_bg.jpg' />") repeat-x;
height: 75px;
text-align: left;
}
#logo {
margin: 0 auto;
width: 1150px;
height: 75px;
line-height: 75px;
}
#logo img {
vertical-align: middle;
padding-top: 20px;
}
#footer {
margin: 0 auto;
margin-top: 15px;
margin-bottom: 30px;
width: 900px;
text-align: center;
color: #999999;
font-size: 13px;
height: 100px;
}
</style>
</head>
<body>
<div id="register">
   <div id="logo"><img src="<s:url value='/css/skin/${skinPath}/images/${applicationScope.sysCfgMap["sys_login_img"]}_head.png'/>" /></div>
</div>
<!--videoList-->
<div class="videoList cbody clearfix">
	<c:set var="tagId" value="${param.source=='deptCourse'?'deptCourseLi':'' }"/>
	<c:set var="backUrl" value="/jsp/res/edu/student/main.jsp?tagId=${tagId }"/>
	<c:if test="${param.source=='teacher'}">
		<c:set var="backUrl" value="/jsp/res/edu/teacher/courseList.jsp"/>
	</c:if>
	<c:if test="${param.source=='manage'}">
		<c:set var="backUrl" value="/jsp/res/edu/manage/courseList.jsp"/>
	</c:if>
 	<div class="video-title">
     <h3 class="fl"><%-- <a href="<s:url value='${backUrl }'/>" title="点击返回" >&lt;&lt;</a> --%>&nbsp;&nbsp;${course.courseName }</h3>
   </div>
   <div class="clear"></div>
   <div class="course-study">
      <a href="javascript:void(0)" onclick="continueStudy();" class="picture fl">
             <img class="fl" src="<s:url value='${sysCfgMap["upload_base_url"]}${course.courseImg }'/>" onerror="this.src='<s:url value="/jsp/edu/css/images/loginbar.jpg"/>'" width="261" height="178" /> 
      </a>
      <ul class="info fl">
          <li> 
              <div class="info_num">
               <c:out value="${chooseCount }" default="0"/> 
              </div>
              <div>学习人数</div>
          </li>
          <li> 
              <div class="info_num">
               <c:out value="${studentCourse.courseCredit }" default="${course.courseCredit }"/> 
              </div>
              <div>学时</div>
          </li>
          <li> 
              <div class="info_num">
               <c:out value="${studentCourse.coursePeriod }" default="${course.coursePeriod }"/> 
              </div>
              <div>学分</div>
          </li>
          
     </ul>
     <c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] == 'student'}">
      <c:choose>
       <c:when test="${empty studentCourse }">
       <a href="javascript:void(0)" onclick="joinMyCourseList('${courseExt.courseFlow}');" class="concerned-icon">
         <em>加入课程</em>
       </a>
       </c:when>
       <c:when test="${empty scheduleMap }">
       <a href="javascript:void(0)" onclick="startStudy('${sonChapterFlowList[0]}');" class="concerned-icon">
         <em >开始学习</em>
       </a>
       </c:when>
       <c:when test="${not empty scheduleMap and not empty studentCourse}">
         <c:choose>
           <c:when test="${studentCourse.studyStatusId eq eduStudyStatusEnumFinish.id}">
             <a href="javascript:void(0)" class="concerned-icon">
               <em >课程已经学完</em>
             </a>
           </c:when>
           <c:otherwise>
             <a href="javascript:void(0)" onclick="continueStudy();" class="concerned-icon">
             <em >继续学习</em>
             </a>
           </c:otherwise>  
       </c:choose>
       </c:when>
     </c:choose>
     </c:if>
     <c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] != 'student'}">
        <a href="javascript:void(0)" onclick="startStudy('${course.courseFlow}');" class="concerned-icon">
	         <em>进入课堂</em>
	       </a>
     </c:if>
  </div>
  
  
  
	<!--videoList-l-->
 <div class="border fl">
  <div id="mainContent" class="videoLists-l fl">
      <div class="videot1">
          <p>
              <a class="tag" id="tag1" onclick="changeTag('content1',this,'<s:url value='/resedu/course/studentChapter?courseFlow=${course.courseFlow}'/>');" class="on">章节列表</a>
	          <a class="tag" id="tag2" onclick="changeTag('content2',this,'<s:url value='/resedu/course/loadNotice?courseFlow=${course.courseFlow}'/>');">最新通知</a>
	          <a class="tag" id="tag3" onclick="changeTag('content3',this,'<s:url value='/resedu/course/loadCourseFile?courseFlow=${course.courseFlow}'/>');">课程资料</a>
	          <a class="tag" id="tag4" onclick="changeTag('content4',this,'<s:url value='/resedu/student/loadCourseExam?courseFlow=${course.courseFlow}'/>');">课程考试</a>
          </p>
      </div>
      <div class="showcontent">
        <div class="content" id="content1" style="display:block">
         		<!-- 章节列表 -->
        </div>
        
      	<div class="content" id="content2" style="display:block">
         		<!-- 最新通知 -->
        </div>
        
        <div class="content" id="content3" style="display:none;">
        		<!-- 课程资料 -->
        </div>
        
        <div class="content" id="content4" style="display:none;">
       	        <!-- 考试 -->
        </div>
        
      </div>
  </div>   
</div>
 	<!--/videoList-l--> 
   
  <!--siderbar--> 
  <div id="rightContent" class="siderbar fr">
    <dl>
      <dt>
      	<c:choose>
	       <c:when test="${studentCourse.courseTypeId eq eduCourseTypeEnumRequired.id }">
		       <input class="fr r-bnt" type="button" value="必修" />
	       </c:when>
	       <c:otherwise>
	           <input class="fr i-bnt" type="button" value="选修" />
	       </c:otherwise>
	     </c:choose>课程介绍</dt>
    <dd style="font-size: 13px;text-indent:0;"> 
    	${course.courseIntro }
        <%-- <div onclick="collection();">
        	<a href="javascript:void(0)" id="gzkc-a"
		         <c:if test="${not empty collectionList}">
		         style="background-image: url(<s:url value='/jsp/edu/css/images/gzh-on.png'/>)"
		         </c:if> >收藏此课程</a>
        </div> --%>
     </dd>
  </dl>
  <%-- <dl>
        <dt>授课老师：${teacher.userName }</dt>
        <dd style="font-size: 13px;text-indent:0;">教师简介：<br/>熊继柏，男，1942年出生，湖南省石门县人，湖南中医药大学教授，研究生导师，全国第四批、第五批老中医药专家学术经验继承人指导老师，中医药师承教育博士生导师，湖南省名中医，湖南中医药大学第一附属医院学术顾问。
        </dd>
    </dl> --%>
    <dl>
  <dt>
    <span  class="changeUser fr" onclick="changeUser();"></span> ${fn:length(userList) }位同学
    <input type="hidden" id="countUser" value="${fn:length(userList) }"/>
    <input type="hidden" id="userStartSort" value="1"/>
    <input type="hidden" id="userEndSort" value="5"/>
  </dt>
  <dd>
  <ul class="users">
      <c:forEach items="${userList }" var="user" varStatus="num">
          <li id="${num.count }" class="userLi" style="display: none;">
			   <img class="t-face" src="${sysCfgMap['upload_base_url']}${eduUserMap[user.userFlow].userImg}" onerror="this.src='<s:url value="/jsp/edu/css/images/head-icon.png"/>'" />
            <a href="javascript:void(0);">${user.userName }</a>
         </li>
       </c:forEach>  
  </ul>
  </dd>
  </dl>              
  </div>
  <!--/ siderbar--> 
</div>
<div id="footer">技术支持：南京品德信息技术有限公司<br />Copyright © 2001- 2014 Character Technology, Inc. All rights reserved.</div>
</body>
</html>