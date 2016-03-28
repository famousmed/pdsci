<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>医学教育知识平台</title>
<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="userCenter" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>

<script type="text/javascript">
function showTable(){
	$("#picture").removeAttr("src");
	$("#picture").hide();
	$("#table_li").addClass("on");
	$("#picture_li").removeClass("on");
	$("#table_self").show();
	$("#table_condition").show();
}
function showPicture(url){
	$("#table_self").hide();
	$("#table_condition").hide();
	$("#table_li").removeClass("on");
	$("#picture_li").addClass("on");
	$("#picture").show();
	$("#picture").attr("src",url);
	$("#picture").location.reload();	
}
function submitForm(url){
	var form=$("#searchForm");
	var requestData = form.serialize();
	jboxPost(url,requestData,function(resp){
		$("#content").html(resp);
	},null,false);
}

$(document).ready(function(){
	loadContent('<s:url value='/njmuedu/user/userList'/>');

	 $(".level2").click(function(){
			$("#condition").val("");
	    	var level1Box=$(".level1");
	    	 $.each(level1Box, function(i , n){
	      		$(n).find("a").removeClass("cur");
	      	});
	    	 if(!$(this).prev().find("a").hasClass("cur")){	
	    		 $(this).prev().find("a").addClass("cur");
	    	}
	    });
	     $(".level1").click(function(){
	    	var level2Box=$(".level2");
	    	$.each(level2Box, function(i , n){
	      		$(n).find("a").removeClass("hove1");
	      	});
	    }); 

});
function changeSort(sortVal){
	var orderBy=$("#sort");
	orderBy.val(sortVal);
	submitForm();
}
function loadContent(url,title){
	jboxPostLoad("content",url,$("#searchForm").serialize(),true);
}
function loadSetUserInfo(){
	$("#registerMsg-r").hide();
	var url = "<s:url value='/njmuedu/user/setUserInfo'/>";
	jboxLoad("content",url,true);
}

function loadSetUserPasswd(){
	$("#registerMsg-r").hide();
	var url = "<s:url value='/njmuedu/user/setUserPasswd'/>";
	jboxLoad("content",url,true);
}
function checkUser(userFlow){
	jboxConfirm("确认审核通过？",function(){
		var url = "<s:url value='/sys/user/activate?userFlow='/>"+userFlow;
		jboxGet(url,null,function(resp){
			if(resp=="${GlobalConstant.ACTIVATE_SUCCESSED}"){
				jboxTip("${GlobalConstant.ACTIVATE_SUCCESSED}");
				loadUserList();
			}
		});
	},null,false);
}

function changeStatusId(statusId,url){
	$("#statusId").val(statusId);
	submitForm(url);
}

function editTchIntro(userFlow,userName){
	//jboxOpen("<s:url value='/njmuedu/user/editTchIntro'/>?userFlow="+userFlow,userName+"的简介", 700, 250);
	jboxOpen("<s:url value='/njmuedu/user/editTeacher'/>?flag=admin&userFlow="+userFlow,userName+"的个人信息", 900,500);
	
}

function addTeacher(){
	jboxOpen("<s:url value='/njmuedu/user/editTeacher'/>?flag=admin&type=teacher","新增老师",900,500);
}

function addStudent(){
	jboxOpen("<s:url value='/njmuedu/user/editStudent'/>?flag=admin&type=student","新增学生",900,450);
}

function editStudent(userFlow){
	jboxOpen("<s:url value='/njmuedu/user/editStudent'/>?flag=admin&type=student&userFlow="+userFlow,"编辑学生信息",900,450);
}

function searchTchDetail(userFlow,userName){
	jboxOpen("<s:url value='/njmuedu/user/tchDetail'/>?userFlow="+userFlow,userName+"的个人信息", 900, 450);
}
function toPage(page) {
	if(page!=undefined){
		$("#currentPage").val(page);			
	}
	var url=$("#url").val();
	jboxPostLoad("content",url,$("#searchForm").serialize(),true);
}
</script>
</head>
<body>
<jsp:include page="/jsp/njmuedu/include/top.jsp"/>
<!--content-->
<div class="register cbody clearfix">
   <div class="menu-warp fl">
    <ul class="menu">
       <li class="level1"><a href="javascript:void(0)" class="cur">教学管理</a>
      </li>
      <ul class="level2" style="display:block;">
        <li><a class="hove1" href="javascript:loadContent('<s:url value='/njmuedu/user/userList'/>');">学生信息</a></li>
        <li><a href="javascript:loadContent('<s:url value='/njmuedu/user/tchInfo'/>','教师信息');">教师信息</a></li>
      </ul>
      <li class="level1"><a  href="javascript:void(0);">教学概况</a>
		</li>
		<ul class="level2" style="display:block;">
			<li><a href="javascript:loadContent('<s:url value='/njmuedu/user/courseInfo'/>');">课程概况</a></li>
			<li><a href="javascript:loadContent('<s:url value='/njmuedu/user/lessionInfo'/>');">教师授课情况</a></li>
			<li><a href="javascript:loadContent('<s:url value='/njmuedu/user/scheduleInfo'/>');">学生学习进度</a></li>
			<%-- <li><a href="javascript:loadContent('<s:url value='/njmuedu/user/testInfo'/>');">测验考试情况</a></li> --%>
			<li><a href="javascript:loadContent('<s:url value='/njmuedu/user/creditInfo'/>');">学分情况</a></li>
		</ul>
       <li class="level1" onclick="loadSetUserInfo();"><a href="javascript:void(0);">个人设置</a>
       </li>
		<li class="level1" onclick="loadSetUserPasswd();"><a href="javascript:void(0);">修改密码</a>
		</li>
		  
     </ul>
   </div>
   <!--right-->
    <div id="content">
   
    </div><!--right-->
</div>
<!--/content-->
</body>
</html>