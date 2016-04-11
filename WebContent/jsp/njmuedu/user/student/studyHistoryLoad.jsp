<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    		<c:set var="currYear" value=""/>
			<c:set var="preYear" value="${param.currYear }"/>
			<c:set var="currDate" value=""/>
			<c:set var="preDate" value="${param.currDate }"/>
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
		<c:if test="${not empty historyList }">	
		<input type="hidden" id="currYear_load"  value="${currYear}"/>
		<input type="hidden" id="currDate_load"  value="${currDate}"/>
		</c:if>	