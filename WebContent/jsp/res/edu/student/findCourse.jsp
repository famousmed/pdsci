
<script type="text/javascript">
$(document).ready(function(){
	$("#pageSpan").hide();
});
</script>
<style>
#content {
margin: 0 auto auto 0;
width: 100%;
border:0;
background:none;
}
h3 {
line-height: 48px;
font-size: 16px;
font-weight: normal;
color: #04618d;
margin-left: 20px;
}
.courseList-content li {
/*margin-right: 30px;*/
}
</style>
</head>
<body>
<!--content-->
<div class="mainright" style="margin-bottom: 30px;">
  <div class="top-tab">
           <c:if test="${param.showSort!='N' }">
			<div class="clearfix module-tabs">
              	<ul class="fl type">
           <li id="all_category" <c:if test="${empty param.courseCategoryId }">class="on"</c:if> onclick="checkFindCourseCategory('');">全部</li>
           <c:forEach items="${eduCourseCategoryEnumList }" var="courseCategory">
           <li id="courseCategory_${courseCategory.id }" <c:if test="${courseCategory.id eq param.courseCategoryId }">class="on"</c:if> onclick="checkFindCourseCategory('${courseCategory.id }');">${courseCategory.name }</li>
           </c:forEach>
        </ul>
              	
                <div class="title-r fr">
                	<div class="searchBox fl">
                	   <input type="text" id="courseName" value="${param.courseName }" placeholder="课程名称"/>
                	   <img onclick="loadFindCourse();" src="<s:url value='/jsp/edu/css/images/search1.png'/>" style="cursor: pointer;" title="搜索"/> 
                	</div>
                    <div class="tabs-title  module-tabs fl">
                    	<ul>
                        	<li <c:if test="${(param.order=='new') or (empty param.order) }">class="on"</c:if> id="new" onclick="changeSort('new');"><a href="javascript:void(0)" >最新</a></li>
                            <li <c:if test="${param.order=='hot' }">class="on"</c:if>id="hot" onclick="changeSort('hot');"><a href="javascript:void(0)" >最热</a></li>
                        </ul>
                    </div>
                </div>
              </div>
              </c:if>
              <div class="module-content courseList-content allCourse" style="width: 98%;margin-bottom: 30px;">
                	<ul style="display:block;" id="content">
                	  <c:if test="${empty courseExtList }">
                	      <div class="nomessage" style="text-align: center;"> 
								<img src="${ctxPath }/jsp/edu/css/images/tanhao.png">           
								<p>暂无课程！</p>
							</div>
                	   </c:if>
                	  <c:forEach items="${courseExtList }" var="courseExt">
                       <li class="course">
                   	    	<%-- <a href="<s:url value='/resedu/course/courseMain?courseFlow=${courseExt.courseFlow}'/>&scope=student" target="_blank">
                   	    	    <img src="<s:url value='${sysCfgMap["upload_base_url"]}${courseExt.courseImg }'/>" onerror="this.src='<s:url value="/jsp/res/edu/image/loginbar.jpg"/>'" width="218" height="141" /> 
                            </a> --%>
                            <dl>
                            	<dt><a href="<s:url value='/resedu/course/courseMain?courseFlow=${courseExt.courseFlow}'/>&scope=student" target="_blank">${courseExt.courseName }</a></dt>
                            	<dd class="countC">学时：${courseExt.coursePeriod }</dd>
                                <dd><input class="i-bnt" type="button" value="选修课" /><span class="fr" id="${courseExt.courseFlow}_tip"><img src="<s:url value='/jsp/res/images/icons_join.png' />">&nbsp;<a style="cursor:pointer;"  onclick="joinMyCourseList('${courseExt.courseFlow}')">加入课程</a></span></dd>
                                <dd style="clear:both;"><span class="fr"><img src="<s:url value='/jsp/edu/css/images/head-icon1.jpg'/>" width="18" height="14" />${courseExt.chooseCount }</span>学分：<c:out value="${courseExt.courseCredit }" default="0"/>分</dd>
                            </dl>
                        </li>
                      </c:forEach>  
                   </ul>
              </div>
              <c:if test="${not empty courseExtList }">
               <c:set var="pageView" value="${pdfn:getPageView(courseExtList)}" scope="request"></c:set>
	           <pd:pagination toPage="toPageFindCourse"/>
	          </c:if>
  </div>
</div>
<span id="tipCopy" style="display: none;">
    <img src="<s:url value='/jsp/res/images/icons_joined.png' />">&nbsp;已加入
</span>
<!--/content-->