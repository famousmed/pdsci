<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
function courseDetail(courseFlow){
	var url = "<s:url value='/edu/user/checkRole'/>";
	jboxPost(url,null,function(resp){
				if(resp == "${GlobalConstant.STUDENT_ROLE}"){
					url = "<s:url value='/edu/course/stuCourseDetail/'/>" + courseFlow;
				}else{
					url = "<s:url value='/edu/course/courseDetail/'/>" + courseFlow;
				}
				window.location.href = url;
			},null,false);
}
</script>
<div class="registerMsg-m fl">
<div class="registerMsg-m-inner registerBgg">
<div class="registerMsg-tabs"> 

<div class="module-tabs" style="display: block;">
      <ul class="fl">
         <c:forEach items="${eduCollectionTypeEnumList}" var="type">
            <li <c:if test="${param.collectionTypeId eq type.id }">class="on"</c:if> ><a onclick="selectCollectionTypeId('${type.id}');" >${type.name}</a></li>
      	</c:forEach>
      </ul>
</div>
	
 <div class="module-content">
 	<!-- 课程  -->
 	<c:if test="${not empty courseList}">
   	<table style="width:100%;" class="collection-table">
   		<colgroup>
   		<col width="50%"/>
   		<col width="30%"/>
   		<col width="20%"/>
   		</colgroup>
   		<tr>
   			<th>课程名称</th>
   			<th>类别</th>
   			<th>操作</th>
   		</tr>
   		
   		<c:forEach items="${courseList}" var="course">
   		<tr>
   			<td>
	   			<a href="javascript:void(0);" onclick="courseDetail('${course.courseFlow}')">${course.courseName}</a>
   			</td>
   			<td>${course.courseTypeName}</td>
   			<td class="collectiondelete"><a href="javascript:void(0);" onclick="delConllection('${course.courseFlow}','${eduCollectionTypeEnumCourse.id}');"></a></td>
   		</tr>
   		</c:forEach>
   		
   	</table>
 	</c:if>
 	
 	<!-- 章节 -->
 	<c:if test="${not empty chapterList}">
   	<table style="width:100%;" class="collection-table">
   		<colgroup>
   		<col width="50%"/>
   		<col width="30%"/>
   		<col width="20%"/>
   		</colgroup>
   		<tr>
   			<th>章节名称</th>
   			<th>教师</th>
   			<th>操作</th>
   		</tr>
   		<c:forEach items="${chapterList}" var="chapter">
   		<tr>
   			<td>
   				 <a href="<s:url value='/edu/course/chapter/${chapter.chapterFlow}'/>">${chapter.chapterName }</a>
   			</td>
   			<td>${teacherMap[chapter.teacherId]}</td>
   			<td class="collectiondelete"><a href="javascript:void(0);" onclick="delConllection('${chapter.chapterFlow}','${eduCollectionTypeEnumChapter.id}');"></a></td>
   		</tr>
   		</c:forEach>
   	</table>
 	</c:if>
 	
 	<!-- 暂无收藏 -->
 	<c:if test="${empty chapterList && empty courseList}">
		<div class="nomessage nomq" style="text-align: center;"> 
			<img src="${ctxPath }/jsp/edu/css/images/tanhao.png">           
			<p>暂无收藏！</p>
		</div>
 	</c:if>
</div>
</div>
</div>
</div>

