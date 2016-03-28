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
</jsp:include>
<script type="text/javascript">
    function back(){
    	var url="<s:url value='/resedu/manage/course/courseList/personal'/>";
    	window.location.href=url;
    }
    function testResultInfo(paperFlow){
    	var url="<s:url value='/resedu/manage/course/testResultInfo'/>?paperFlow="+paperFlow;
    	var w = $('.mainright').width()*0.8;
		var h = $('.mainright').height()*0.8;
		jboxOpen(url, "查看考试结果",w, h);
    }
    function addTestPaper(){
    	var w = $('.mainright').width();
    	var h = $('.mainright').height();
    	var url="<s:url value='/resedu/manage/course/addTestPaper'/>";
    	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
    	jboxMessager(iframe,'出题',w,h,null,false);
        
    }
    function bindTest(paperFlow,courseFlow){
    	var checkBox=$("#check_"+paperFlow);
    	var type="";
    	if(checkBox.is(":checked")){
    		type="add";
    	}else{
    		type="del";
    	}
    	var url="<s:url value='/resedu/manage/course/changePaperBind'/>?paperFlow="+paperFlow+"&courseFlow="+courseFlow+"&type="+type;
    	 jboxPost(url,null,function(resp){
 		           if(resp=='${GlobalConstant.ONE_LINE}'){
 		        	   jboxTip('${GlobalConstant.OPRE_SUCCESSED}');
 		           }else if(resp=='${GlobalConstant.CAN_NOT_BIND_FLAG}'){
 		        	   jboxTip('${GlobalConstant.CAN_NOT_BIND}');
 		        	   checkBox.removeAttr("checked");
 		           }else{
 		        	  jboxTip('${GlobalConstant.OPRE_FAIL}');
 		        	   checkBox.removeAttr("checked");
 		           }
 		           var testCount=$("#testCount").val();
 		           var courseTestCount=$("#content").find('input:checkbox[name="courseTestCount"]:checked').length;
 		           //alert("testCount="+testCount+"  courseTestCount="+courseTestCount);
 		           if(testCount>0 && courseTestCount>0 && testCount==courseTestCount){
 		        	  $("#selfFlag").attr("checked","checked");
 		        	   $("#selfFlag").attr("disabled","disabled");
 		           }else{
 		        	  $("#selfFlag").removeAttr("checked");
 		        	   $("#selfFlag").removeAttr("disabled");
 		           }
 				},
 				null,false);
    }
 
    function searchSelfTest(obj){
       if($(obj).attr("checked")=="checked"){
    	   $(obj).val("Y");
       }else{
    	   $(obj).val("N");
       }
       loadTestList();
    }
    function loadTestList(){
    	var selfFlag=$("#selfFlag").val();
    	var url ="<s:url value='/resedu/manage/course/loadTestList?courseFlow=${course.courseFlow}'/>&selfFlag="+selfFlag;
   	    jboxLoad("content",url,false);
    }
    
    $(document).ready(function(){
    	loadTestList();
    });
</script>
</head>
<body>
    <div class="mainright">
	 <div class="content">
	  <div class="title1 clearfix">
         <table class="basic" style="width: 100%;">
             <colgroup>
   		     <col width="12%"/>
   		     <col width="12%"/>
   		     <col width="12%"/>
   		     <col width="12%"/>
   		     <col width="12%"/>
   		     <col width="12%"/>
   		  </colgroup>
              <tr>
                <td colspan="6">课程信息</td>
              </tr>
            <tbody>
             <tr>
               <th>课程名称：</th>
               <td colspan="3">${course.courseName }</td>
               <th>课程类别：</th>
               <td>${course.courseCategoryName }</td>
             </tr>
             <tr>
               <th>主&nbsp;讲&nbsp;&nbsp;人：</th>
               <td>${course.courseSpeaker }</td>
               <th>课程状态：</th>
               <td>${course.courseStatusName }</td>
               <th>上传日期：</th>
               <td>${pdfn:transDateTimeForPattern(course.uploadTime,"yyyy-MM-dd HH:mm:ss","yyyy-MM-dd") }</td>
             </tr>
             <tr>
               <th>学&#12288;&#12288;分：</th>
               <td>${course.courseCredit }</td>
               <th>学&#12288;&#12288;时：</th>
               <td>${course.coursePeriod }</td>
               <th>及&nbsp;格&nbsp;&nbsp;线：</th>
               <td>60</td>
             </tr>
             </tbody>
         </table>
         <table class="xllist" style="width: 100%;margin-top: 10px;">
             <colgroup>
             <col width="9%"/>
   		     <col width="13%"/>
   		     <col width="13%"/>
   		     <col width="13%"/>
   		     <col width="13%"/>
   		     <col width="13%"/>
   		     <col width="13%"/>
   		     <col width="13%"/>
   		  </colgroup>
             <thead>
                <tr>
                   <td colspan="8" style="text-align: left;padding-left: 10px;">
                                                                 试卷信息
                      &#12288;<input type="checkBox" id="selfFlag" value="${param.selfFlag }" class="只显示本课程试卷" onclick="searchSelfTest(this);"
                      <c:if test="${param.selfFlag eq 'Y'}">checked</c:if>/>
                      <label for="selfFlag">只显示本课程试卷</label>
                   </td>
                </tr>
                <tr>
                   <th>选择试卷</th>
                   <th>考卷名称</th>
                   <th>考试时间（分钟）</th>
                   <th>出题方式</th>
                   <th>出卷人</th>
                   <th>总分</th>
                   <th>及格分</th>
                   <th>操作</th>
                </tr>
             </thead>
             <tbody id="content">
              
             </tbody>
         </table>
            <p align="center" style="width:100%">
                <input class="search" type="button" value="出&#12288;题"  onclick="addTestPaper();" />
				<input class="search" type="button" value="返&#12288;回"  onclick="back();" />
			</p>
	  </div>
	  </div>
	</div>
	
</body>
</html>