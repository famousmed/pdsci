<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>医学教育知识平台-我的课程</title>
<meta name="keywords" content=""/>
<meta name="description" content=""/>
<jsp:include page="/jsp/edu/htmlhead-edu.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="userCenter" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script type="text/javascript">
$(document).ready(function(){
	var url="<s:url value ='/edu/user/showStuCourse'/>?studyStatus=${eduStudyStatusEnumUnderway.id}";
	jboxLoad("content",url,true);
	$("#a-stuCourse").addClass("cur");
	loadRecommendCourse();
});
function selectCourseTypeId(typeId){
   	var courseTypeId=$("#courseTypeId");
   	courseTypeId.val(typeId);
   	showCourse();
}

function checkStatus(status){
	var studyStatus=$("#studyStatus");
	studyStatus.val(status);
	showCourse();
}

function showCourse(){
	var studyStatusVal=$("#studyStatus").val();
	var courseTypeIdVal=$("#courseTypeId").val();
	var id=$("#content").attr("id");
	var url="<s:url value ='/edu/user/showStuCourse'/>?studyStatus="+studyStatusVal+"&courseTypeId="+courseTypeIdVal;
	$("#content").html("");
	jboxLoad(id,url,true);
}

function loadStuCourse(){
	$("#registerMsg-r").show();
	clearChoose();
	var url="<s:url value ='/edu/user/showStuCourse'/>?studyStatus=${eduStudyStatusEnumUnderway.id}";
	jboxLoad("content",url,true);
}

function loadSetCollection(){
	$("#registerMsg-r").show();
	clearChoose();
	var url = "<s:url value='/edu/user/setCollection'/>?flag=s";
	jboxLoad("content",url,true);
}
function loadSetUserInfo(){
	$("#registerMsg-r").hide();
	clearChoose();
	var url = "<s:url value='/edu/user/setUserInfo'/>";
	jboxLoad("content",url,true);
	$("#a-stuCourse").removeClass("cur");
	$("#a-setUserInfo").addClass("cur");
}

function loadSetUserPasswd(){
	$("#registerMsg-r").hide();
	clearChoose();
	var url = "<s:url value='/edu/user/setUserPasswd'/>";
	jboxLoad("content",url,true);
}

function loadRecommendCourse(){
	var sortType=$('#sortType').val();
	var url= "<s:url value='/edu/user/recommendCourse'/>?sortType="+sortType;
	jboxLoad("content-right",url,true);
}
function changeRecommendSort(sortType){
	$("#sortType").val(sortType);
	loadRecommendCourse();
}
function loadStudyHistory(){
	$("#registerMsg-r").hide();
	$(".level1 a").removeClass("cur");
	$("#a-history").addClass("cur");
	var url = "<s:url value='/edu/studyHistory/showHistory'/>";
	jboxLoad("content",url,true);
}
function loadQuestionList(){
	$("#registerMsg-r").hide();
	$(".level1 a").removeClass("cur");
	$("#a-history").addClass("cur");
	var url = "<s:url value='/edu/studyHistory/questionList'/>";
	jboxLoad("content",url,true);
}
function questionSearchSubmit(){
	url = "<s:url value='/edu/studyHistory/questionList'/>";
	$("#registerMsg-r").hide();
	jboxPostLoad("content",url,$("#questionSearchForm").serialize(),true);
}
function loadMyCredit(){
	$(".level1 a").removeClass("cur");
	$("#a-history").addClass("cur");
	$("#registerMsg-r").hide();
	var url = "<s:url value='/edu/studyHistory/myCredit'/>";
	jboxLoad("content",url,true);
}
function loadMyTest(){
	$(".level1 a").removeClass("cur");
	$("#a-history").addClass("cur");
	$("#registerMsg-r").hide();
	var url = "<s:url value='/edu/studyHistory/myTest'/>";
	jboxLoad("content",url,true);
}
function clearChoose(){
	var $obj = $(".hove1");
	if($obj!=null){
		$obj.attr("class"," ");
		$obj.mouseover(function(){
			$(this).attr("class"," hove1");
		});
		$obj.mouseout(function(){
			$(this).attr("class"," ");
		});
		$obj.click(function(){
			$(this).attr("class"," hove1");
			$(this).unbind("mouseout");
		});
	}
}
</script>
</head>
<body>
 <jsp:include page="/jsp/edu/include/top.jsp"/>
   
<!--content-->
<div class="register cbody clearfix">
   <div class="menu-warp fl">
    <ul class="menu">
		<li class="level1" onclick="loadStuCourse();"><a href="javascript:void(0);" id="a-stuCourse">我的课程</a></li>
		<li class="level1" onclick="loadSetCollection();"><a href="javascript:void(0);">我的收藏</a></li>
		<li class="level1"><a href="javascript:void(0);" id="a-history">学习日志</a></li>
		<ul class="level2" style="display:block;">
			<li onclick="loadStudyHistory();"><a  href="javascript:void(0);">学习记录</a></li>
			<li onclick="loadQuestionList();"><a  href="javascript:void(0);">我的问答</a></li>
			<li onclick="loadMyTest();"><a  href="javascript:void(0);">我的测验</a></li>
			<li onclick="loadMyCredit();"><a  href="javascript:void(0);">我的学分</a></li>
		</ul>
		<li class="level1" onclick="loadSetUserInfo();"><a href="javascript:void(0);" id="a-setUserInfo">个人设置</a></li> 
		<li class="level1" onclick="loadSetUserPasswd();"><a href="javascript:void(0);" >修改密码</a></li> 
     </ul>
   </div>

  <!--registerMsg-m-->
    <!--  <div class="registerMsg-m fl">
    	<div class="registerMsg-m-inner">
        	<div class="registerMsg-tabs" id="content">-->
            	
                <input type="hidden" id="studyStatus"/>
                <input type="hidden" id="courseTypeId"/>
                 <input type="hidden" id="sortType"/>
                <div id="content">
                	<!-- 这里填充根据条件查询的课程列表 -->
                </div>
                
            <!--  </div>
        </div>
    </div> -->
     <script>

	

</script> 
   <!--/registerMsg-m--> 

  <!--registerMsg-r-->
  <div class="registerMsg-r fr" id="registerMsg-r">
    	<div class="registerMsg-r-top">
        	<dl>
           	  <dt class="fl">
		  			<img class="t-face" id="t-face-r" src="${sysCfgMap['upload_base_url']}${sessionScope[GlobalConstant.CURR_EDU_USER].userImg}" onerror="this.src='<s:url value="/jsp/edu/css/images/head-icon.png"/>'"/>
           	  </dt>
              <dd class="fl">
              	<span id="userName-r">${sessionScope.currUser.userName}</span>
                <p id="orgName-r">${sessionScope.currUser.orgName}</p>
              </dd>
            </dl>
          <ul>
            	<li>
                	<c:out value="${countCourseTypeMap[eduCourseTypeEnumRequired.id] }" default="0"/><p>${eduCourseTypeEnumRequired.name }</p>
                </li>
                <li>
                	<c:out value="${countCourseTypeMap[eduCourseTypeEnumOptional.id] }" default="0"/><p>${eduCourseTypeEnumOptional.name }</p>
                </li>
                <li>
                	<c:out value="${allCredit }" default="0"/><p>学分获得</p>
                </li>
            </ul>
            <a href="javascript:void(0)" onclick="loadSetUserInfo();"><img src="<s:url value='/jsp/edu/css/images/pen.png'/>" width="15" height="15" /></a>
      </div>
      
      	<div class="registerMsg-r-bottom">
          <div id="content-right">
          
         </div>
        </div>
  </div>  
   <!--/registerMsg-r--> 

</div>
<!--footer-->
 <jsp:include page="/jsp/edu/include/foot.jsp"/>
</body>
</html>