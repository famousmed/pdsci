<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
	<jsp:param name="findCourse" value="true"/>
</jsp:include>
<script type="text/javascript">
/*时间轴开始*/
$(function(){
	systole();
});
function systole(){
	if(!$(".history").length){
		return;
	}
	$("#history").find("li").hide();
	
	var $warpEle = $(".history-date"),
		$targetA = $warpEle.find("h2 a"),
		parentH,
		eleTop = [];
	
	parentH = $warpEle.parent().height();
	$warpEle.find("ul").children(":not('h2:first')").each(function(idx){
		eleTop.push($(this).position().top);
		$(this).css({"margin-top":-eleTop[idx]}).children().hide();
	}).animate({"margin-top":0}, 1000).children().fadeIn();

	$warpEle.find("ul").children(":not('h2:first')").addClass("bounceInDown").css({"-webkit-animation-duration":"2s","-webkit-animation-delay":"0","-webkit-animation-timing-function":"ease","-webkit-animation-fill-mode":"both"}).end().children("h2").css({"position":"relative"});
	$("#history").find("li").show(1600);
}
function toggleList(obj){
	if($("h2").length>1){
		$(obj).parent().nextUntil("h2").filter("li").slideToggle();
		return false;
	}
}
/*时间轴结束*/
function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	form.submit();
}
function loadMore(){
	url = "<s:url value='/njmuedu/studyHistory/showHistory'/>";
	var currentPage = $("#currentPage").val();
	var requestData ={
		"currentPage":currentPage,
		"currYear":$("#currYear").val(),
		"currDate":$("#currDate").val(),
		"isLoad":"${GlobalConstant.FLAG_Y}"
	}; 
	jboxPost(url,requestData,function(resp){
		if(resp!=""){
			$("#history_ul").append(resp);
			$("#currentPage").val(parseInt(currentPage)+1);
			$("#currYear").val($("#currYear_load").val());
			$("#currDate").val($("#currDate_load").val());
			$("#currYear_load").remove();
			$("#currYear_load").remove();
		}else{
			jboxTip("记录已全部加载！");
		}
	},function(){
		jboxTip("未能成功加载，请刷新后重试！");
	},false);
}

function change(type){
	if(type=="h"){
		$("#horz").show();
		$("#vtc").hide();
		$(".modelButton_v").show();
		$(".modelButton_h").hide();
	}else if(type=="v"){
		$("#horz").hide();
		$("#vtc").show();
		$(".modelButton_v").hide();
		$(".modelButton_h").show();
	}
}

function testDetail(){
	var height=(window.screen.height)*0.5;
	var width=(window.screen.width)*0.6;
	var url = "<s:url value='/jsp/njmuedu/user/student/testDetail.jsp'/>";
	jboxOpen(url, "测试详情", width, height);
}
</script> 
<style type="text/css">
.btn-sm{padding:0;line-height: 50px;}
.icon-th-large{background:url("<s:url value='/jsp/njmuedu/css/images/th_larger_g.png'/>"); background-repeat:no-repeat; background-position: 0px center;padding: 12px 22px; }
.icon-reorder{background:url("<s:url value='/jsp/njmuedu/css/images/reorder_w.png'/>"); background-repeat:no-repeat; background-position: 0px center;padding: 12px 22px; }
.icon-large{background:url("<s:url value='/jsp/njmuedu/css/images/th_larger_w.png'/>"); background-repeat:no-repeat; background-position: 0px center;padding: 12px 22px; }
.icon-th-reorder{background:url("<s:url value='/jsp/njmuedu/css/images/reorder_g.png'/>"); background-repeat:no-repeat; background-position: 0px center;padding: 12px 22px; }
.modelButton_h{float: right;margin-right: 0px;}
.modelButton_v{float: right;margin-right: 0px;}
</style>
<div class="time-right fr">
    <div class="title">
	  <h2 class="fl"><img src="<s:url value='/jsp/njmuedu/css/images/time.png'/>" />学习记录</h2>
		<div class="modelButton_v">
			<a class="btn-sm" data-status="vtc" href="javascript:change('v');" title="切换试图">
				<i class="icon-large"></i>
			</a>
			<a class="btn-sm active" data-status="horz" href="javascript:change('h');" title="切换列表">
				<i class="icon-th-reorder"></i>
			</a>
		</div>
		<div class="modelButton_h" style="display: none;" title="切换试图/列表">
			<a class="btn-sm" data-status="vtc" href="javascript:change('v');" title="切换试图">
				<i class="icon-th-large"></i>
			</a>
			<a class="btn-sm active" data-status="horz" href="javascript:change('h');" title="切换列表">
				<i class="icon-reorder"></i>
			</a>
	  </div>
	</div>
	<div id="vtc" style="display: none;">
	<form id="searchForm" class="fl" style="position: relative;display:block;" method="post">
	<input type="hidden" id="currentPage" value="3" />
	<div class="fl">
		<div class="history" id="history" style="height: auto;">
		<div class="history-date">
			<ul id="history_ul">
			<c:set var="currYear" value=""/>
			<c:set var="preYear" value=""/>
			<c:set var="currDate" value=""/>
			<c:set var="preDate" value=""/>
			<c:set var="currTime" value=""/>
			<c:forEach items="${historyList }" var="his">
				<c:set var="currYear" value="${pdfn:transDateForPattern(his.operTime,'yyyy') }"/>
				<c:set var="currDate" value="${pdfn:transDateForPattern(his.operTime,'MM.dd') }"/>
				<c:set var="currTime" value="${pdfn:transDateForPattern(his.operTime,'HH:mm') }"/>
				<c:if test="${currYear!=preYear }">
				<c:choose>
					<c:when test="${empty preYear }">
						<h2 class="first" style="position: relative;">
							<a href="javascript:void(0);" onclick="toggleList(this);">${currYear}年</a>
							<span class="timeline_title">记录详情</span>
						</h2>
					</c:when>
					<c:otherwise>
						<h2 class="date02 bounceInDown" style="margin-top: 0px; -webkit-animation: 2s ease 0ms both; position: relative;"><a href="javascript:void(0);" style="display: inline-block;" onclick="toggleList(this);">${currYear}年</a></h2>
					</c:otherwise>
				</c:choose>
				</c:if>
				<c:if test="${currDate!= preDate}">
				<li class="green bounceInDown" style="margin-top: 0px; -webkit-animation: 2s ease 0ms both; display: list-item;">
					<h4 style="display: block;">${currDate }<span>${currYear }</span></h4>
				</li>
				</c:if>
				<c:choose>
					<c:when test="${his.operTypeId==njmuEduStudyHistoryTypeEnumCourse.id}">
						<c:set var="liClass" value="green bounceInDown timeline_v"/>
						<c:set var="liHtml">
							<p>
								<i>观看了课程 <a href="<s:url value='/njmuedu/course/chapter/${dataMap[his.recordFlow].chapterFlow }'/>" target="_blank">${dataMap[his.recordFlow].course.courseName }&nbsp;&nbsp;${dataMap[his.recordFlow].chapterName }</a></i>
								<i class="fr time">${currTime }</i>
							</p>
						</c:set>
					</c:when>
					<c:when test="${his.operTypeId==njmuEduStudyHistoryTypeEnumTest.id}">
						<c:set var="liClass" value="green bounceInDown timeline_p"/>
						<c:set var="liHtml">
							<p>
								<i>完成了随堂测试<a href="#" target="_blank">第一章&nbsp;&nbsp;辩证唯物主义</a></i>
								<i class="fr time">${currTime }</i>
							</p>
						</c:set>
					</c:when>
					<c:otherwise>
						<c:set var="liClass" value="green bounceInDown timeline_q"/>
						<c:if test="${his.operTypeId==njmuEduStudyHistoryTypeEnumQuestion.id}">
							<c:set var="liHtml">
								<p>
								<i class="fl">在课程 <a href="<s:url value='/njmuedu/course/chapter/${dataMap[his.recordFlow].chapterExt.chapterFlow }'/>" target="_blank">${dataMap[his.recordFlow].course.courseName }&nbsp;&nbsp;${dataMap[his.recordFlow].chapterExt.chapterName }</a> 提问</i>
								<i class="fr time">${currTime }</i>
								</p>
								<p>
									${pdfn:cutString(dataMap[his.recordFlow].questionContent,40,true,3) }
								</p>
							</c:set>
						</c:if>
						<c:if test="${his.operTypeId==njmuEduStudyHistoryTypeEnumReply.id}">
							<c:set var="liHtml">
								<p>
								<i class="fl">回复了 <a href="#">${dataMap[his.recordFlow].questionExt.user.userName }</a></i>
								<i class="fr time">${currTime }</i>
								</p>
								<p>
								<a href="<s:url value='/njmuedu/course/chapter/${dataMap[his.recordFlow].questionExt.chapterExt.chapterFlow }'/>" style="margin:0;" target="_blank">对${dataMap[his.recordFlow].questionExt.chapterExt.chapterName }的提问</a>
								</p>
								<p>
									${pdfn:cutString(dataMap[his.recordFlow].answerContent,40,true,3) }
								</p>
							</c:set>
						</c:if>
					</c:otherwise>
				</c:choose>
				<li class="${liClass}" style="margin-top:0; -webkit-animation: 2s ease 0ms both; display: list-item;">
					<h3 style="display: block;border:none;"></h3>
					<dl style="display: block;">
						<dt class="time_list">
							${liHtml}
						</dt>
					</dl>
				</li>
		  <c:set var="preYear" value="${currYear }"/>
		  <c:set var="preDate" value="${currDate }"/>		
				</c:forEach>
				<input type="hidden" id="currYear"  value="${currYear}"/>
				<input type="hidden" id="currDate"  value="${currDate}"/>
				</ul>
			</div>
		</div>
		<div class="time_more"><a href="javascript:void(0);" onclick="loadMore();" title="点击加载更多">更多</a></div>
		<c:if test="${empty historyList }">
			<div class="nomessage" style="text-align: center;"> 
				<img src="${ctxPath }/jsp/njmuedu/css/images/tanhao.png">           
				<p>暂无学习记录！</p>
			</div>
		</c:if>
		</div>
		</form>
	</div>
	<div id="horz" style="padding-left:20px;padding-right: 20px; float:left;">
	<div class="title-r fr" style="margin-bottom: 5px;">
		<div class="searchBox fl" style="margin-right:0px;">
      	   <input type="text"  placeholder="课程名称/课程类别"  value="" />
      	   <img src="<s:url value='/jsp/njmuedu/css/images/search1.png'/>" style="cursor: pointer;" title="搜索"/> 
      	</div>
    </div> 
	<table border="0" cellpadding="0" cellspacing="0" class="course-table">
		<tr>
			<th width="30%">课程名称</th>
			<th width="15%">课程类别</th>
			<th width="15%">开始学习时间</th>
			<th width="15%">完成学习时间</th>
			<th width="10%">学分</th>
			<th width="15%">是否获得学分</th>
		</tr>
		<tr>
			<td>预防医学</td>
			<td><input class="r-bnt cType" type="button" value="必修" /></td>
			<td>2015-04-03 09:30</td>
			<td>2015-04-05 11:00</td>
			<td>5</td>
			<td>[<a href="javascript:void(0);" onclick="testDetail();">详情</a>]</td>
		</tr>
		
	</table>
	</div>
</div> 