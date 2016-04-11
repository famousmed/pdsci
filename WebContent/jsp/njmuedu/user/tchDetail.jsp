<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
    <jsp:param name="basic" value="true"/>
    <jsp:param name="jbox" value="true"/>
    <jsp:param name="userCenter" value="true"/>
	<jsp:param name="findCourse" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
</jsp:include>
<script>
   
    function doClose(){
    	jboxClose();
    }
</script>
<head>
<body style="background:#fff; margin:0 10px; ">      	
        	<!--  <div class="registerMsg-m2 fl">
    	<div class="registerMsg-m-inner registerBgw">
        	<div class="registerMsg-tabs">-->
               <div class="clear"></div> 
              <div>
         <p class="courseP">基本信息</p>
         <div class="part" style="margin-bottom:10px;">
 	     <table border="0" cellpadding="0" cellspacing="0" class="course-table course-table1" style=" width:100%;border:1px solid #d4e7f0;">
 	       <col width="15%">
 	       <col width="35%">
 	       <col width="15%">
 	       <col width="35%">
 	       <tr>
 	         <th >登录名：</th>
 	         <td >${eduUserExt.sysUser.userCode }</td>
 	         <th >姓名：</th>
 	         <td >${eduUserExt.sysUser.userName }</td>
 	       </tr>
 	       <tr>
 	         <th>性别：</th>
 	         <td>${eduUserExt.sysUser.sexName }</td>
 	         <th>学校：</th>
 	         <td>${eduUserExt.sysUser.orgName }</td>
 	       </tr>
 	       <tr>
 	         <th>手机号：</th>
 	         <td>${eduUserExt.sysUser.userPhone }</td>
 	         <th>邮箱：</th>
 	         <td>${eduUserExt.sysUser.userEmail }</td>
 	       </tr>
 	       <tr>
 	         <th>职务：</th>
 	         <td>${eduUserExt.sysUser.postName }</td>
 	         <th>职称：</th>
 	         <td>${eduUserExt.sysUser.titleName }</td>
 	       </tr>
 	       <tr>
 	         <th style="border-bottom:none;">学历：</th>
 	         <td>${eduUserExt.sysUser.educationName }</td>
 	         <th style="border-bottom:none;">学位：</th>
 	         <td>${eduUserExt.sysUser.degreeName }</td>
 	       </tr>
		 </table>
		 </div>
		 <p  class="courseP">所授课程</p>
		 <div class="part" style="margin-bottom:10px;">
		  <table  border="0" cellpadding="0" cellspacing="0" class="course-table course-table1" >
		    <c:forEach items="${njmuEduCourseTypeEnumList }" var="type">
		    <tr><td style=" background:#ecf2f6;border-bottom:1px solid #d4e7f0" >${type.name }</td></tr>
		    <tr>
		      <td style="text-align:left; padding-left:50px; border-bottom:1px solid #d4e7f0">
		        <c:if test="${empty teacherChapterMap[type.id][eduUserExt.userFlow] }">
		                                暂无此类课程
		        </c:if>
		        <c:forEach items="${teacherChapterMap[type.id][eduUserExt.userFlow] }" var="chapterExt">
		           ${chapterExt.course.courseName }&#12288;${chapterExt.chapterNo}&nbsp;${chapterExt.chapterName }<br/>
		        </c:forEach>
		      </td>
		    </tr>
		    </c:forEach>
		  </table>
		</div> 
		 <div class="part " style="margin-top:10px;"> 
		  <table  border="0" cellpadding="0" cellspacing="0" class="course-table course-table1" >
		     <tr>
		       <th style="border-bottom:1px solid #d4e7f0;">问题数</th>
		       <th style="border-bottom:1px solid #d4e7f0;">已回答</th>
		       <th style="border-bottom:1px solid #d4e7f0;">未回答</th>
		       <!-- 
		       <th style="border-bottom:1px solid #d4e7f0;">操作</th>
		        -->
		     </tr>
		     <tr>
		       <td >${countQuestionMap['All'][eduUserExt.userFlow] }</td>
		       <td >${countQuestionMap[eduQuestionStatusEnumAnswered.id][eduUserExt.userFlow] }</td>
		       <td >${countQuestionMap[eduQuestionStatusEnumUnanswered.id][eduUserExt.userFlow] }</td>
		       <!--  <td ><a href="javascript:void(0)">通知</a></td> -->
		     </tr>
		  </table>
		  </div>
					<div style="width: 600px;" class="editBtn">
					   <input type="button" class="search2" value="关闭" onclick='doClose();'/>
					</div>
 </div>
    <!--</div>
          </div>
        </div>-->
        </body>
        </html>