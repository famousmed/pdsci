<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>医学教育知识平台</title>
<meta name="keywords" content=""/>
<meta name="description" content=""/>
<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="courseDetail" value="true"/>
	<jsp:param name="teachCourses" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
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
	  var userBox=$(".userLi");
	  $.each(userBox , function(i , n){
	    if(parseInt($(n).attr("id"))>=1 && parseInt($(n).attr("id"))<=5)
		    $(n).show();  
		});
	  //loadSurvey();
	  toNext(1);
});

function showAndHide(parentFlow,obj){
	  
	  var sonNodeFlows=$(".sonNode_"+parentFlow);
	 $.each(sonNodeFlows , function(i , n){
		 $(n).slideToggle("slow");
	 }); 
	 if(!$(obj).parent().hasClass("learnchapter-active")){
		 $(obj).parent().addClass("learnchapter-active");
	 }else if($(obj).parent().hasClass("learnchapter-active")){
		 $(obj).parent().removeClass("learnchapter-active");
	 }
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

function loadNotice(){
	$("#switch_control").hide();
	var url ="<s:url value='/njmuedu/user/notice?courseFlow=${courseFlow}'/>";
	jboxLoad("content2",url,false);
}

function loadCourseFile(){
	$("#switch_control").hide();
	var url ="<s:url value='/njmuedu/user/courseFile?courseFlow=${courseFlow}'/>";
	jboxLoad("content3",url,false);
}

function loadCourseTest() {
	$("#switch_control").hide();
	 var url ="<s:url value='/njmuedu/user/studentCourseTest?courseFlow=${courseFlow}'/>";
	 jboxLoad("content4",url,false); 
}

function loadSurvey(){
	$("#switch_control").show();
	var url ="<s:url value='/njmuedu/course/studySurvey?courseFlow=${courseFlow}'/>";
	$.ajax({
		type : "get",
		url : url,
		cache : false,
		success : function(resp) {
			$("#htmltemp").val(resp);
			document.getElementById("test11").innerHTML = "<c:out value='"+resp+"' escapeXml='true' />";
		}
	});
}

function loadSurvey2(){
	var url ="<s:url value='/njmuedu/course/survey?courseFlow=${courseFlow}'/>"
	//var url ="<s:url value='/njmuedu/course/studySurvey?courseFlow=${courseFlow}'/>";
	jboxLoad("content1",url,false);
	loadCourseEvaluateContent();
}
function submitForm(){
	
   var form=$("#searchForm");
    form.submit();
}
function loadStudySurveyContent(){
	var url ="<s:url value='/njmuedu/course/studySurvey?courseFlow=${courseFlow}'/>";
	jboxLoad("studySurveyContent",url,false);
}
function loadQuestionSurveyContent(){
	var url ="<s:url value='/njmuedu/course/questionSurvey?courseFlow=${courseFlow}'/>";
	jboxLoad("questionSurveyContent",url,false);
}
function loadCourseEvaluateContent(){
	var url ="<s:url value='/njmuedu/course/courseEvaluateSurvey?courseFlow=${courseFlow}'/>";
	jboxLoad("courseEvaluateContent",url,false);
}

function toNext(flag){
	if(flag>0 && flag<=5){
		/* var url = "<s:url value="/njmuedu/course/courseDetail/${courseFlow}"/>?flag="+flag;
		window.location.href=url; */
		var url = "<s:url value="/njmuedu/course/loadCourseStatistics"/>?flag="+flag+"&courseFlow=${courseFlow}";
		$("#statistics").attr("src",url);
		$("#switch li a").each(function(index,obj){
			var $obj = $(obj);
			var class_str = $obj.attr("class");
			var class_str_sub = class_str.split("_");
			if(index+1==flag){
				$obj.attr("class",class_str_sub[0]+"_w");
			}else{
				$obj.attr("class",class_str_sub[0]+"_b");
			}
		});
	}
}

</script>
</head>
<body>
<a id="editTarget"></a>
<jsp:include page="/jsp/njmuedu/include/top.jsp"/>
<c:out value="" escapeXml=""></c:out>
<!--videoList-->
<div class="videoList cbody clearfix">
 	<div class="video-title">
     <h3 class="fl"><a href="<s:url value='/${sessionScope.currView}'/>" title="点击返回" >&lt;&lt;</a>&nbsp;&nbsp;${courseExt.courseName }</h3>
   </div>
   <div class="clear"></div>
   <div class="course-study">
      <a href="" class="picture fl">
             <img class="fl" src="<s:url value='${sysCfgMap["upload_base_url"]}${courseExt.courseImg }'/>" onerror="this.src='<s:url value="/jsp/njmuedu/css/images/loginbar.jpg"/>'" width="261" height="178" /> 
       </a>
      <ul class="info fl t-info">
          <li> 
              <div class="info_num">
                  <c:out value="${countOneCourse }" default="0"/>
              </div>
              <div>学习人数</div>
        </li>
          
          <li> 
              <div class="info_num">
               <c:out value="${countYetCourse }" default="0"/>
              </div>
              <div>已学人数</div>
          </li>
          
        <li> 
              <div class="info_num">
               <c:out value="${courseExt.courseCredit }" default="0"/>
              </div>
              <div>学分</div>
          </li>
     </ul>
  </div>
  
  
  
	<!--videoList-l-->
<div class="border fl">
  <div class="videoList-l fl">
      
      <div class="videot1" id="switch_info">
          <p>
              <a href="javascript:loadSurvey();" class="on">概况</a>
	          <a href="javascript:loadNotice();">通知</a>
	          <a href="javascript:loadCourseFile();">课程资料</a>
	          <!-- <a href="javascript:loadCourseTest();">随堂测试</a> -->
          </p>
          <span class="fr">
              <a class="switch" id="switch_control">切换视图</a>
              <ul class="switch_list" id="switch" style="display:none">
                 <li><a href="javascript:void(0);" onclick="toNext(1);" <c:choose><c:when test="${flag==1 }">class="xxjd_w"</c:when><c:otherwise>class="xxjd_b"</c:otherwise></c:choose>>学习进度</a></li>
                 <li><a href="javascript:void(0);" onclick="toNext(2);" <c:choose><c:when test="${flag==2 }">class="wdqk_w"</c:when><c:otherwise>class="wdqk_b"</c:otherwise></c:choose> >问答情况</a></li>
                 <li><a href="javascript:void(0);" onclick="toNext(3);" <c:choose><c:when test="${flag==3 }">class="kcpj_w"</c:when><c:otherwise>class="kcpj_b"</c:otherwise></c:choose> >课程评价</a></li>
                 <%-- <li><a href="javascript:void(0);" onclick="toNext(4);" <c:choose><c:when test="${flag==4 }">class="kscy_w"</c:when><c:otherwise>class="kscy_b"</c:otherwise></c:choose> >考试测验</a></li> --%>
                 <li><a href="javascript:void(0);" onclick="toNext(5);" <c:choose><c:when test="${flag==5 }">class="xfqk_w"</c:when><c:otherwise>class="xfqk_b"</c:otherwise></c:choose> >学分情况</a></li>
              </ul>  
          </span>
      </div>
      <script>
  	$(function(){
	    var tabCourse = $('#switch_control');
	    tabCourse.on('click',function(e){e.stopPropagation();});
	    tabCourse.on('click',function(){
	    	$("#switch").show();
	    });
	    $(document).on('click',function(){$("#switch").hide();});
	});
      </script>
 
      <div class="showcontent">
      <div class="content1" id="content1" style="display:block">
			<iframe id="statistics" name="statistics"   style="border:0;height: 800px;width:810px;"></iframe>
        </div>
        
      	<div style="overflow: auto;height: 100%;width: 100%" id="mainDiv">
      	<div class="content" id="content2" >
         		<!-- 最新通知 -->
        </div>
        </div>
        
        <div class="content" id="content3">
        		<!-- 课程资料 -->
        </div>
        
        <div class="content" id="content4">
        		<!-- 随堂测试 -->
        </div>
        
        
      </div>
   <script>
   function byclass(classname){
		if(document.getElementsByClassName){
			return document.getElementsByClassName(classname)
		}else{
			var tags=document.getElementsByTagName('*');
			var divs=[];
			for(var i=0; i<tags.length;i++){
				if(tags[i].className==classname){
					divs.push(tags[i]);
					}
				}
				return divs;
			}
		}
		
	var aLi=byclass('videot1')[0].getElementsByTagName('p')[0].getElementsByTagName('a');
	var aDiv=byclass('showcontent')[0].children;
	for(var i=0;i<aLi.length;i++){
		aLi[i].index=i;
		aLi[i].onclick=function(){
			for(var i=0;i<aLi.length;i++){
				aLi[i].className="";
				aDiv[i].style.display="";
				}
			this.className='on';
			aDiv[this.index].style.display="block";
			}
		}
   </script>
  </div>   
</div>
  <!--/videoList-l--> 
  <!--siderbar     课程介绍--> 
  <div class="siderbar fr">
  	<div class="border">
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
         </c:choose>             
                    课程介绍</dt>
    <dd> 
    	<span>${courseExt.courseIntro }</span>
        <div onclick="collection();">
        	<%-- <a href="javascript:void(0)" id="gzkc-a"
		         <c:if test="${not empty collectionList}">
		         	style="background-image: url(<s:url value='/jsp/njmuedu/css/images/gzh-on.png'/>)"
		         </c:if> >收藏此课程</a> --%>
        </div>
     </dd>
  </dl>
  </div>
  
  <div class="border">
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
			   <img class="t-face" src="${sysCfgMap['upload_base_url']}${sysUserMap[user.userFlow].userHeadImg}" onerror="this.src='<s:url value="/jsp/njmuedu/css/images/head-icon.png"/>'" />
            <a href="javascript:void(0);">${user.userName }</a>
         </li>
       </c:forEach>  
      </ul>
  </dd>
  </dl> 
  </div>
         
  </div>
  <!--/ siderbar--> 
</div>
<!--/videoList-->
</body>
</html>