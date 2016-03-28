<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="compatible" value="true"/>
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
	<jsp:param name="jquery_ztree" value="true"/>
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<script type="text/javascript">
		$(document).ready(function(){
		});
		function back(){
			var url = "<s:url value='/resedu/manage/course/courseList/${sessionScope[GlobalConstant.USER_LIST_SCOPE] }'/>?courseFlow=${course.courseFlow}";
			window.location.href=url;
		}
		function chooseUser(type){
			var w = $('.mainright').width()*0.8;
			var h = $('.mainright').height()*0.8;
			var url = "<s:url value='/resedu/manage/course/searchUserInfo'/>?type="+type+"&show=Y&courseFlow=${course.courseFlow}";
			jboxOpen(url, "选择人员",w, h);
		}
	</script>
</head>
<body>	
<div class="mainright">
   <div class="content">
     <div class="clearfix" style="padding: 10px;">
     	<c:if test="${empty sysCfgMap['upload_base_url']}">请联系系统管理员先在系统配置中配置文件上传的路径</c:if>
     	<c:if test="${not empty sysCfgMap['upload_base_url']}">
		<form id="editForm" action="<s:url value='/resedu/manage/course/saveCourse'/>" style="position: relative;" enctype="multipart/form-data" method="post">
		<input name="courseFlow" type="hidden" value="${course.courseFlow}"/>
		<input name="chapterFlow" type="hidden" value="${chapter.chapterFlow}"/>
		<input type="hidden" id="videoStatus" value=""/>
		<input type="hidden" id="imgStatus" value=""/>
   		<table class="basic" style="width: 100%;">
   		  <colgroup>
   		     <col width="16%"/>
   		     <col width="16%"/>
   		     <col width="16%"/>
   		     <col width="16%"/>
   		     <col width="16%"/>
   		     <col width="16%"/>
   		  </colgroup>
   			<tr>
                <td class="bs_name" colspan="6">课程信息</td>
            </tr>
            <tr>
                <th>课程名称：</th>
                <td colspan="3">${course.courseName}</td>
                <th>主讲人：</th>
                <td>${course.courseSpeaker }</td>
            </tr>
            <tr>
                <th>学分：</th>
            	<td>${course.courseCredit}</td>
                <th>学时：</th>
            	<td>${course.coursePeriod}</td>
                <th>上传科室：</th>
            	<td>${course.deptName }</td>
            </tr>
            <tr>
               <th>课程类别:</th>
               <td>${course.courseCategoryName }</td>
            </tr>
            <tr>
            	<th>必修人员范围：</th>
            	<td colspan="5" style="padding-left:0;">
            	 <table width="100%">
            	  <colgroup>
            	    <col width="15%"/>
            	    <col width="85%"/>
            	  </colgroup>
            	   <tr>
            	      <td>${requiredUserScopeEnumMajor.name }：</td>
            	      <td>
            	       <c:if test="${empty refMap['requireMajors'] }">无</c:if>
            	       <ul>
            	          <c:forEach items="${refMap['requireMajors'] }" var="item" varStatus="num">
            	           <li style="float: left;line-height: 20px;">
            	              ${item.refName }
            	              <c:if test="${num.count!=fn:length(refMap['requireMajors']) }">，</c:if>
            	           </li>
            	          </c:forEach>
            	       </ul>
            	      </td>
            	   </tr>
            	   <tr>
            	      <td>${requiredUserScopeEnumDept.name }：</td>
            	      <td>
            	      <c:if test="${empty refMap['requireDepts'] }">无</c:if>
            	       <ul>
            	          <c:forEach items="${refMap['requireDepts'] }" var="item" varStatus="num">
            	           <li style="float: left;line-height: 20px;">
            	             ${item.refName }
            	             <c:if test="${num.count!=fn:length(refMap['requireDepts']) }">，</c:if>
            	           </li>
            	          </c:forEach>
            	       </ul>
            	      </td>
            	   </tr>
            	   <tr>
            	      <td>${requiredUserScopeEnumUser.name }：</td>
            	      <td>
            	        <ul id="requiredUl"></ul>
            	                   已选择&nbsp;<a onclick="chooseUser('required');" style="cursor: pointer;"><font color="red">${fn:length(refMap['requireUserList']) }</font></a>&nbsp;人
            	      	<c:if test="${fn:length(refMap['requireUserList'])>0}">
            	        &#12288;<input type="button" value="&nbsp;&nbsp;查看&nbsp;&nbsp;"  onclick="chooseUser('required');" />
            	        </c:if>
            	      </td>
            	   </tr>
            	 </table>
            	</td>
            </tr>
            <tr>
            	<th>计分人员范围：</th>
            	<td colspan="5" style="padding-left:0;">
            	 <table width="100%">
            	  <colgroup>
            	    <col width="15%"/>
            	    <col width="85%"/>
            	  </colgroup>
            	   <tr>
            	      <td>${scoreUserScopeEnumMajor.name }：</td>
            	      <td>
            	      <c:if test="${empty refMap['scoreMajors'] }">无</c:if>
            	       <ul>
            	          <c:forEach items="${refMap['scoreMajors'] }" var="item" varStatus="num">
            	            <li style="float: left;line-height: 20px;">${item.refName }
            	            <c:if test="${num.count!=fn:length(refMap['scoreMajors']) }">，</c:if>
            	            </li>
            	          </c:forEach>
            	       </ul>
            	      </td>
            	   </tr>
            	   <tr>
            	      <td>${scoreUserScopeEnumDept.name }：</td>
            	      <td>
            	      <c:if test="${empty refMap['scoreDepts'] }">无</c:if>
            	       <ul>
            	          <c:forEach items="${refMap['scoreDepts'] }" var="item" varStatus="num">
            	          <li style="float: left;line-height: 20px;">${item.refName }
            	          <c:if test="${num.count!=fn:length(refMap['scoreDepts']) }">，</c:if>
            	          </li>
            	          </c:forEach>
            	       </ul>
            	      </td>
            	   </tr>
            	   <tr>
            	      <td>${scoreUserScopeEnumUser.name }：</td>
            	      <td>
            	        <ul id="scoreUl"></ul>
            	                   已选择&nbsp;<a onclick="chooseUser('score');" style="cursor: pointer;"><font color="red">${fn:length(refMap['scoreUserList']) }</font></a>&nbsp;人
            	        <c:if test="${fn:length(refMap['scoreUserList'])>0}">
            	        &#12288;<input type="button" value="&nbsp;&nbsp;查看&nbsp;&nbsp;"  onclick="chooseUser('score');" />
            	        </c:if>
            	      </td>
            	   </tr>
            	 </table>
            	</td>
            </tr>
            <tr>
            	<th>计学时人员范围：</th>
            	<td colspan="5" style="padding-left:0;">
            	 <table width="100%">
            	  <colgroup>
            	    <col width="15%"/>
            	    <col width="85%"/>
            	  </colgroup>
            	   <tr>
            	      <td>${periodUserScopeEnumMajor.name }：</td>
            	      <td>
            	      <c:if test="${empty refMap['periodMajors'] }">无</c:if>
            	       <ul>
            	          <c:forEach items="${refMap['periodMajors'] }" var="item" varStatus="num">
            	           <li style="float: left;line-height: 20px;">${item.refName }
            	           <c:if test="${num.count!=fn:length(refMap['periodMajors']) }">，</c:if>
            	           </li>
            	          </c:forEach>
            	       </ul>
            	      </td>
            	   </tr>
            	   <tr>
            	      <td>${periodUserScopeEnumDept.name }：</td>
            	      <td>
            	       <c:if test="${empty refMap['periodDepts'] }">无</c:if>
            	       <ul>
            	          <c:forEach items="${refMap['periodDepts'] }" var="item" varStatus="num">
            	          <li style="float: left;line-height: 20px;">${item.refName }
            	          <c:if test="${num.count!=fn:length(refMap['periodDepts']) }">，</c:if>
            	          </li>
            	          </c:forEach>
            	       </ul>
            	      </td>
            	   </tr>
            	   <tr>
            	      <td>${periodUserScopeEnumUser.name }：</td>
            	      <td>
            	        <ul id="periodUl"></ul>
            	           已选择&nbsp;<a onclick="chooseUser('period');" style="cursor: pointer;"><font color="red">${fn:length(refMap['periodUserList']) }</font></a>&nbsp;人
            	        <c:if test="${fn:length(refMap['periodUserList'])>0}">
            	        &#12288;<input type="button" value="&nbsp;&nbsp;查看&nbsp;&nbsp;"  onclick="chooseUser('period');" />
            	        </c:if>
            	      </td>
            	   </tr>
            	 </table>
            	</td>
            </tr>
			<tr>
				<th style="width: 17%;">课程图片：</th>
				<td colspan="5">
			       <span id="uploadCourseImgName"><a href="${sysCfgMap['upload_base_url']}${course.courseImg}" target="_blank" title="点击查看大图">${course.courseImgName }</a></span>
				</td>
			</tr>
			<tr>
				<th>课程介绍：</th>
				<td colspan="5" style="line-height: 30px;">${course.courseIntro}</td>
			</tr>
			</table>
		</form>
		</c:if>
    </div>
    <p align="center" style="width:100%">
        <c:if test="${param.closeFlag!='Y' }">
		  <input class="search" type="button" value="返&#12288;回"  onclick="back();" />
	    </c:if>
	    <c:if test="${param.closeFlag=='Y' }">
	      <input class="search" type="button" value="关&#12288;闭"  onclick="jboxCloseMessager();" />
	    </c:if>
	</p>
  </div> 	
</div>

</body>
</html>