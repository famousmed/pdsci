<%@ include file="/jsp/jspf/prelude.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>医学教育知识平台-课程详细</title>
<meta name="keywords" content=""/>
<meta name="description" content=""/>
<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="courseDetail" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
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
	 changeTag("content1",$("#tag1"),"<s:url value='/njmuedu/user/studentChapter?courseFlow=${courseFlow}'/>");
	 var userBox=$(".userLi");
	 $.each(userBox , function(i , n){
	    if(parseInt($(n).attr("id"))>=1 && parseInt($(n).attr("id"))<=5)
		    $(n).show();  
	 });
});
 
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
 
 function continueStudy(){
	 var url = "<s:url value='/njmuedu/course/continueStudy'/>?courseFlow=${courseFlow}";
	 window.location.href = url;
 }
 
 function collection(){
	 var url = "<s:url value='/njmuedu/course/collection'/>?collectionTypeId=${njmuEduCollectionTypeEnumCourse.id}&resourceFlow=${courseFlow}";
	 jboxPost(url,null,function(resp){
					if(resp == "${GlobalConstant.FLAG_N}"){
						//alert("取消关注！");
						$("#gzkc-a").css("background-image","");
					}else if(resp == "${GlobalConstant.FLAG_Y}"){
						//alert("关注成功！");
						$("#gzkc-a").css("background-image","url(<s:url value='/jsp/njmuedu/css/images/gzh-on.png'/>)");
					}
				},function(resp){},false);
 }
 
 function checkChapter(nowChapterFlow,courseFlow){
	 var url = "<s:url value='/njmuedu/course/checkChapter'/>?chapterFlow="+nowChapterFlow+"&courseFlow="+courseFlow;
	 jboxPost(url,null,function(resp){
		            if(resp==nowChapterFlow){
		            	url="<s:url value='/njmuedu/course/chapter'/>"+"/"+resp;
						window.location.href=url;
		            }else{
		            	jboxTip(resp);
		            }
				},function(resp){},false);
 }
 function joinMyCourseList(courseFlow){
	 var url = "<s:url value='/njmuedu/course/joinMyCourseList'/>?courseFlow="+courseFlow;
	 var msg="确认把该课程加入我的课程中吗？";
	 jboxConfirmBasic(msg,function(){
	 jboxPost(url,null,
				function(resp){
		           window.location.reload(true);
				},
				null,true);
	 });
 }
 function startStudy(firstChapterFlow){
	 if(firstChapterFlow!=""){
		 var url = "<s:url value='/njmuedu/course/chapter'/>"+"/"+firstChapterFlow;
		 window.location.href = url;
	 }else{
		 jboxInfo("这门课尚未添加任何章节！");
	 }
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
</script>
</head>
<body>
<jsp:include page="/jsp/njmuedu/include/top.jsp"/>
<!--videoList-->
<div class="videoList cbody clearfix">

 	<div class="video-title">
     <h3 class="fl"><a href="<s:url value='/njmuedu/user/student'/>" title="点击返回" >&lt;&lt;</a>&nbsp;&nbsp;${courseExt.courseName }</h3>
   </div>
   <div class="clear"></div>
   <div class="course-study">
      <a href="javascript:void(0)" onclick="startStudy('${sonChapterFlowList[0]}');" class="picture fl">
             <img class="fl" src="<s:url value='${sysCfgMap["upload_base_url"]}/${courseExt.courseImg }'/>" onerror="this.src='<s:url value="/jsp/njmuedu/css/images/loginbar.jpg"/>'" width="261" height="178" /> 
      </a>
      <ul class="info fl">
          <li> 
              <div class="info_num">
               <c:out value="${fn:length(userList) }" default="0"/> 
              </div>
              <div>学习人数</div>
          </li>
          
          <li> 
              <div class="info_num"><c:out value="${courseExt.coursePeriod }" default="0"/></div><%-- <i>分钟</i><c:out value="${allSec }" default="0"/><i>秒</i></div> --%>
              <div>总学时</div>
          </li>
          
          <li> 
              <div class="info_num"><c:out value="${finishMin }" default="0"/><i>分钟</i><c:out value="${finishSec }" default="0"/><i>秒</i></div>
              <div>已学时长</div>
          </li>
     </ul>
     <c:choose>

       <c:when test="${empty studentCourseList }">
       <a href="javascript:void(0)" onclick="joinMyCourseList('${courseExt.courseFlow}');" class="concerned-icon">
         <em>加入课程</em>
       </a>
       </c:when>
       <c:when test="${empty scheduleMap }">
       <a href="javascript:void(0)" onclick="startStudy('${sonChapterFlowList[0]}');" class="concerned-icon">
         <em >开始学习</em>
       </a>
       </c:when>
       <c:when test="${not empty scheduleMap and not empty studentCourseList}">
         <c:choose>
           <c:when test="${studentCourseList.get(0).studyStatusId eq njmuEduStudyStatusEnumFinish.id}">
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
  </div>
  
  
  
	<!--videoList-l-->
 <div class="border fl">
  <div class="videoList-l fl">
      
      <div class="videot1">
          <p>
              <a class="tag" id="tag1" onclick="changeTag('content1',this,'<s:url value='/njmuedu/user/studentChapter?courseFlow=${courseFlow}'/>');">课程章节</a>
	          <a class="tag" id="tag2" onclick="changeTag('content2',this,'<s:url value='/njmuedu/user/studentNotice?courseFlow=${courseFlow}'/>');">最新通知</a>
	          <a class="tag" id="tag3" onclick="changeTag('content3',this,'<s:url value='/njmuedu/user/studentCourseFile?courseFlow=${courseFlow}'/>');">课程资料</a>
	          <!-- <a href="javascript:loadCourseTest();">随堂测试</a> -->
          </p>
      </div>
      <div class="showcontent">
        <div class="content" id="content1" style="display:block">
          		<!--课程章节 -->
        </div>
      	<div class="content" id="content2" style="display:block">
         		<!-- 最新通知 -->
        </div>
        
        <div class="content" id="content3">
        		<!-- 课程资料 -->
        </div>
      </div>
  </div>   
</div>
 	<!--/videoList-l--> 
   
  <!--siderbar--> 
  <div class="siderbar fr">
    <dl>
      <dt>
         <c:choose>
           <c:when test="${courseExt.courseTypeId eq njmuEduCourseTypeEnumRequired.id }">
             <input class="fr r-bnt" type="button" value="${courseExt.courseTypeName }" />
           </c:when>
           <c:when test="${courseExt.courseTypeId eq njmuEduCourseTypeEnumOptional.id }">
             <input class="fr i-bnt" type="button" value="${courseExt.courseTypeName }" />
           </c:when>
           <c:when test="${courseExt.courseTypeId eq njmuEduCourseTypeEnumPublic.id }">
             <input class="fr b-bnt" type="button" value="${courseExt.courseTypeName }" />
           </c:when>
         </c:choose>课程介绍</dt>
    <dd> 
    	<span>${eduCourse.courseIntro }</span>
        <div onclick="collection();">
        	<a href="javascript:void(0)" id="gzkc-a"
		         <c:if test="${not empty collectionList}">
		         style="background-image: url(<s:url value='/jsp/njmuedu/css/images/gzh-on.png'/>)"
		         </c:if> >收藏此课程</a>
        </div>
     </dd>
  </dl>
  <dl>
        <dt>授课老师：
         <c:forEach items="${teacherList }" var="teacher" varStatus="num">
            ${teacher.sysUser.userName }<c:if test="${num.count!=fn:length(teacherList) }">，</c:if>
         </c:forEach>
        </dt>
        <dd style="font-size: 13px;text-indent:0;">教师简介：<br/>
           <c:forEach items="${teacherList }" var="teacher" varStatus="num">
            ${teacher.intro }<c:if test="${num.count!=fn:length(teacherList) }"><br/></c:if>
           </c:forEach>
        </dd>
    </dl>
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
			   <img class="t-face" src="${sysCfgMap['upload_base_url']}${sysUserMap[user.userFlow].userHeadImg}" onerror="this.src='<s:url value="/jsp/njmuedu/css/images/head-icon.png"/>'"  />
            <a href="javascript:void(0);">${user.userName }</a>
         </li>
       </c:forEach>  
      </ul>
  </dd>
  </dl>              
  </div>
  <!--/ siderbar--> 
</div>
<!--/videoList-->
</body>
</html>