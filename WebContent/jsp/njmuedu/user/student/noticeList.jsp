<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
/* function toPage(page){
	$("#currentPage").val(page);
	var url ="<s:url value='/njmuedu/user/studentNotice?courseFlow=${courseFlow}&currentPage='/>"+page;
	jboxLoad("content1",url,false);
} */

</script>
 
    
<div class="aquestion" id="noticeList">

	<c:if test="${empty eduCourseNoticeExtList}">
		<div class="nomessage" style="text-align: center;"> 
			<img src="${ctxPath }/jsp/njmuedu/css/images/tanhao.png"/>           
			<p>暂无通知！</p>
		</div>
	</c:if>
	
	<c:forEach items="${eduCourseNoticeExtList}" var="noticeExt">
		<span class="publishtime fr">发布于&nbsp;${pdfn:transDateTime(noticeExt.createTime)}</span>
		<a href="" target="_blank">
					<img src="${sysCfgMap['upload_base_url']}${noticeExt.sysUser.userHeadImg}" onerror="this.src='<s:url value="/jsp/njmuedu/css/images/17326850.jpg"/>'" class="headimages" height="24" width="24">
			<span class="publishname">${noticeExt.userName}</span>
		</a>       
		<span class="labels">老师</span>
		<h3>${noticeExt.noticeTitle}</h3>
		<p class="zbr">${noticeExt.noticeContent}</p>
		
		<c:if test="${noticeExt.userFlow eq sessionScope.currUser.userFlow}">
			<a class="shanchu fr" href="javascript:void(0)" onclick="delNotice('${noticeExt.noticeFlow}')">删除</a>
			<a class="shanchu fr" href="#editTarget" onclick="editNotice('${noticeExt.noticeFlow}')" style="margin-right: 20px;">编辑</a>
		</c:if>
		
		<div class="clear"></div>
		<div class="line"></div>
	</c:forEach>
	
</div>
<%-- <p>
    <c:set var="pageView" value="${pdfn:getPageView2(courseNoticeList, 10)}" scope="request"></c:set>
	<pd:pagination toPage="toPage"/>
</p> --%>
