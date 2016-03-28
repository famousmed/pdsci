<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
	function saveNotice(){
		if(false == $("#noticeForm").validationEngine("validate")){
			return false;
		}
		var url = "<s:url value='/njmuedu/user/saveNotice'/>";
		jboxPost(url,$("#noticeForm").serialize(),
				function(resp){
					if(resp == "${GlobalConstant.RELEASE_SUCCESSED}"){
						var saveBtn = $("#saveBtn").val();
						if(saveBtn =="修改"){
							jboxTip("${GlobalConstant.UPDATE_SUCCESSED}");
						}else{
							jboxTip("${GlobalConstant.RELEASE_SUCCESSED}");
						}
					}
					var url ="<s:url value='/njmuedu/user/notice?courseFlow=${param.courseFlow}'/>";
			 		jboxLoad("content2",url,false);
				},null,false);
	}
	
	/* function toPage(page){
		$("#currentPage").val(page);
		var url ="<s:url value='/njmuedu/user/teacherNotice?courseFlow=${courseFlow}&currentPage='/>"+page;
 		jboxLoad("content1",url,false);
	} */
	
	function delNotice(noticeFlow){
		jboxConfirm("确认删除此条通知?", function(){
			var url = "<s:url value='/njmuedu/user/delNotice?noticeFlow='/>" + noticeFlow;
			jboxPost(url, null, function(resp){
						if(resp == "${GlobalConstant.DELETE_SUCCESSED}"){
							jboxTip("${GlobalConstant.DELETE_SUCCESSED}");
							var url ="<s:url value='/njmuedu/user/notice?courseFlow=${param.courseFlow}'/>";
					 		jboxLoad("content2",url,false);
						}
					}, null, false);
		});
	}
	
	function editNotice(noticeFlow,obj){
		var url ="<s:url value='/njmuedu/user/editNotice?noticeFlow='/>" + noticeFlow;
		jboxPost(url, null, function(resp){
					if(resp != "" || resp != null){
						//$(obj).scrollTop(1);
						//$(obj).scrollTo("#noticeForm", 1000);
						$("#noticeDiv").show();
						$("#notice-a").text("取消发布");
						$(obj).parent().hide();
						$(obj).parent().siblings().show();
						$("#noticeFlow").val(resp.noticeFlow);
						$("#noticeTitle").val(resp.noticeTitle);
						$("#noticeContent").text(resp.noticeContent);
						$("#saveBtn").val("修改");
						$("#backBtn").show();
					}
				},null,false);
	}
	
	function back(){
		loadNotice();
	}
	
	function releaseNotice(obj){
		var text = $(obj).text();
		var noticeDiv = $("#noticeDiv").css("display");
		$("#noticeDiv").slideToggle("normal",function(){
			if(noticeDiv == "block"){
				$(obj).text("发布通知");
			}else{
				$(obj).text("取消发布");
			}
			$(".noticeList").show();
		});
	}
</script>
<div class="uploading fr">
	<ul>
		<li>
			<a href="javascript:void(0);" onclick="releaseNotice(this);" id="notice-a">发布通知</a>
		</li>
	</ul>
</div>
<br/>
<div class="words clearfix" style="display: none;" id ="noticeDiv">
	<br/>
	<form id="noticeForm" style="position: relative;" method="post">
	<input type="hidden" name="courseFlow" value="${param.courseFlow}"/>
	<input type="hidden" name="noticeFlow" id="noticeFlow"/>
 			<img class="headimages" src="${sysCfgMap['upload_base_url']}${sessionScope[GlobalConstant.CURRENT_USER].userHeadImg}" onerror="this.src='<s:url value="/jsp/njmuedu/css/images/17326850.jpg"/>'" height="24" width="24"/>
	<input name="noticeTitle" id="noticeTitle" class="inputwords validate[required]" type="text" placeholder="请输入通知标题">
	<textarea name="noticeContent" id="noticeContent" class="temptexarea validate[maxSize[2000]]" width="50" height="70"  rows="5" cols="55" placeholder="请输入通知内容"></textarea>
	<input type="button" class="fb-btn fr" value="返回" onclick="back();" id="backBtn" style="display: none; margin-left: 20px;"/>
	<input type="button" class="fb-btn fr" value="发布" onclick="saveNotice();" id="saveBtn"/>
	</form>
</div>
<br/>
<hr/>
<div class="aquestion" id="noticeList">
	<c:if test="${empty eduCourseNoticeExtList}">
		<div class="nomessage" style="text-align: center;"> 
			<img src="${ctxPath }/jsp/njmuedu/css/images/tanhao.png"/>           
			<p>暂无通知！</p>
		</div>
	</c:if>
	
	<c:forEach items="${eduCourseNoticeExtList}" var="noticeExt">
	<div class="noticeList">
		<span class="publishtime fr">发布于&nbsp;${pdfn:transDateTime(noticeExt.createTime)}</span>
			<img src="${sysCfgMap['upload_base_url']}${noticeExt.sysUser.userHeadImg}" onerror="this.src='<s:url value="/jsp/njmuedu/css/images/17326850.jpg"/>'" class="headimages" height="24" width="24">
		<span class="publishname">${noticeExt.userName}</span>
		<!-- <span class="labels">老师</span> -->
		<h3>${noticeExt.noticeTitle}</h3>
		<p class="zbr">${noticeExt.noticeContent}</p>
		
		<c:if test="${noticeExt.userFlow eq sessionScope.currUser.userFlow}">
			<a class="shanchu fr" href="javascript:void(0)" onclick="delNotice('${noticeExt.noticeFlow}')">删除</a>
			<a class="shanchu fr" href="#editTarget" onclick="editNotice('${noticeExt.noticeFlow}',this)" style="margin-right: 20px;">编辑</a>
		</c:if>
		<div class="clear"></div>
		<div class="line"></div>
	</div>
	</c:forEach>
</div>
<%-- <p>
    <c:set var="pageView" value="${pdfn:getPageView2(courseNoticeList, 10)}" scope="request"></c:set>
	<pd:pagination toPage="toPage"/>
</p> --%>