<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
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
	<jsp:param name="resedu" value="true"/>
</jsp:include>

<script type="text/javascript">
$(document).ready(function(){
	loadMyCourseList($("#myCourse"));
	
});
function joinMyCourseList(courseFlow){
	 var msg="确认把该课程加入我的课程中吗？";
	 jboxConfirm(msg,function(){
	 var url = "<s:url value='/resedu/course/joinMyCourseList'/>?courseFlow="+courseFlow;
	 jboxPost(url,null,
				function(resp){
		           if(resp!='${GlobalConstant.OPRE_FAIL}'){
     	              jboxTip('${GlobalConstant.OPRE_SUCCESSED}');
     	              var tipSpan=$("#"+resp+"_tip");
     	              $(tipSpan).html($("#tipCopy").html());
                  }
				},
				null,false);
	 });
}
$(function(){
    var tabCourse = $('#icon');
    tabCourse.on('click',function(e){e.stopPropagation();});
    tabCourse.on('click',function(){
    	loadUserInfo();
    	$("#right").show();
    });
    $(document).on('click',function(){$("#right").hide();});
});

function loadUserInfo(){
	var url ="<s:url value='/resedu/student/loadUserInfo'/>";
	jboxLoad("right",url,false); 
}
function loadMyCourseList(obj){
	jboxStartLoading();
	$(".level1 a").removeClass("cur");
	$(".level2").hide();
	$(obj).addClass("cur");
	showCourse();
	jboxEndLoading();
}
function loadStudyRecord(obj){
	jboxStartLoading();
	$(".level1 a").removeClass("cur");
	$(".level2").hide();
	$(obj).addClass("cur");
	showStudyRecord();
	jboxEndLoading();
}
function checkFindCourse(obj){
	$(".level1 a").removeClass("cur");
	$(".level2").hide();
	$(obj).addClass("cur");
	$(obj).parent().next("ul").show();
	$(obj).parent().next("ul").children().first().find("a").click();
	
}
function loadFindCourse(schDeptFlow,obj){
	$(obj).parent().prevAll("li").find("a").removeClass("hove1");
	$(obj).parent().nextAll("li").find("a").removeClass("hove1");
	$(obj).addClass("hove1");
	$("#checkSchDeptFlow").val(schDeptFlow);
	showFindCourse();
}

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
	var id=$("#tagContent").attr("id");
	var url="<s:url value ='/resedu/student/showStuCourse'/>?studyStatus="+studyStatusVal+"&courseTypeId="+courseTypeIdVal+"&showSort=N";
	jboxLoad(id,url,true);
}

function showStudyRecord(){
	var url="<s:url value='/resedu/student/studyRecord'/>";
	jboxPost(url,$("#studyRecordForm").serialize(),function(resp){
		$("#tagContent").html(resp);
	},null,false);
}
function showFindCourse(){
	var data=$("#findCourseCondition").serialize();
	var url="<s:url value='/resedu/student/loadFindCourse'/>";
	jboxPost(url,data,function(resp){
		$("#tagContent").html(resp);
	},null,false);
		
}
function checkCredit(obj){
	if($(obj).attr("checked")){
		$("#isCredit").val("Y");
	}else{
		$("#isCredit").val("N");
	}
}
function checkPeriod(obj){
	if($(obj).attr("checked")){
		$("#isPeriod").val("Y");
	}else{
		$("#isPeriod").val("N");
	}
}

function checkAll(obj){
	var id=$(obj).attr("id");
	if(id=="allNot"){
		$("#creditBox").removeAttr("checked");
		$("#isCredit").val("N");
		$("#periodBox").removeAttr("checked");
		$("#isPeriod").val("N");
	}
}

function searchCourse(){
	if($("#schDeptUl").is(":hidden")){
		checkFindCourse($("#findCourse"));
	}else{
		showFindCourse();
	}
}
</script>

</head>
<body class="sc_bg">
<div class="mainright">
     <div class="sc_top">
       <div class="sc_wr">
         <div class="sc_logo">
            <img src="<s:url value='/jsp/res/images/sc_logo.png' />">
         </div>
         <form id="findCourseCondition">
           <span class="sc_ipt_wr">
             <input type="text" class="sc_ipt" name="courseName" value="${param.courseName }"/>
             <input type="hidden" id="isCredit" name="isCredit" value="${param.isCredit }"/>
             <input type="hidden" id="isPeriod" name="isPeriod" value="${param.isPeriod }"/>
             <input type="hidden" id="checkSchDeptFlow" name="checkSchDeptFlow" value="${param.checkSchDeptFlow }"/>
             <input type="hidden" id="showSort" name="showSort" value="N"/>
           </span>
           <span>
             <input type="button" class="search_btn" value="搜索" onclick="searchCourse();"/>
           </span>
           <div class="sc_g">
             <label><input type="checkBox" id="allNot" <c:if test="${(empty param.isCredit or param.isCredit eq 'N') and (empty param.isPeriod and param.isPeriod eq 'N' )}">checked</c:if> onclick="checkAll(this);"/>全部</label>
             <label><input type="checkBox" id="creditBox" <c:if test="${param.isCredit eq 'Y' }">checked</c:if> onclick="checkCredit(this);"/>计学分</label>
             <label><input type="checkBox" id="periodBox" <c:if test="${param.isPeriod eq 'Y' }">checked</c:if> onclick="checkPeriod(this);"/>计学时</label>
           </div>
         </form>
         <div class="sc_top_right">
            <div class="sc_photo">
                 <a style="cursor: pointer;"><img id="icon" class="toux" src="<s:url value='/jsp/res/images/photo.png'/>" style="width: 40px;height: 40px;" title="查看个人信息" ></a>
                 <%-- <span class="sc_top_name">
                   <h3><a href="javascript:personalCenter();">${sessionScope.currUser.userName}</a></h3>         
                 </span> --%>
            
            </div>
         </div>
        </div> 
      </div>
    <div class="sc_wr">
      <div class="sc_content">
         <div class="menu-wrap fl" id="findCourseDiv">
            <ul class="sc_menu">
               <li class="level1"><a id="myCourse" href="javascript:void(0)" onclick="loadMyCourseList(this);">我的课程</a></li>
            </ul>
            <ul class="sc_menu">
               <li class="level1"><a id="studyRecord" href="javascript:void(0)" onclick="loadStudyRecord(this);">学习记录</a></li>
            </ul>
            <ul class="sc_menu">
               <li class="level1"><a id="findCourse" href="javascript:void(0)" onclick="checkFindCourse(this);">发现课程</a></li>
            <ul class="level2" id="schDeptUl">
               <li><a href="javascript:void(0);" onclick="loadFindCourse('',this);">全部</a></li>
               <c:forEach items="${schDeptList }" var="schDept">
               <li><a id="schDept_${schDept.schDeptFlow }" href="javascript:void(0);" onclick="loadFindCourse('${schDept.schDeptFlow }',this);">${schDept.schDeptName }</a></li>
               </c:forEach>
            </ul>  
            </ul>
         </div>
         <div class="menu-wrap fl" id="personalCenterDiv" style="display: none;">
            <ul class="sc_menu">
               <li class="level1"><a href="javascript:void(0)" class="cur">个人中心</a></li>
            <ul class="level2" style="display:block;">
               <li><a href="javascript:loadContent('<s:url value='/edu/user/userList'/>');">我的课程</a></li>
               <li><a href="javascript:loadContent('<s:url value='/edu/user/tchInfo'/>','教师信息');">学习记录</a></li>
               <li><a href="javascript:loadContent('<s:url value='/edu/user/tchInfo'/>','教师信息');">个人设置</a></li>
               <li><a href="javascript:loadMain('<s:url value='/sys/user/security'/>');">修改密码</a></li>
            </ul>  
            </ul>
         </div>
         
         <div class="row_main">
         <div class="sc_middle">
           <div class="sc_m_inner" id="tagContent" style="border:none;"></div>
         </div>
         </div>
         <div class="sc_right fr" id="right" style="display:none;"></div>
      </div>
    </div>
     <input type="hidden" id="studyStatus"/>
     <input type="hidden" id="courseTypeId"/>
</div>
</body>
</html>