<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
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
<style type="text/css">
table#splist2 td{text-align: left;padding-left: 12px;}
</style>
</head>
<script type="text/javascript">
	$(document).ready(function(){
		if ('${param.tagId}' != '') {
			$("#${param.tagId}").click();
		} else {
			$("li a:first").click();
		}
	});
	
	function selectTag(selfObj,url) {
		var selLi = $(selfObj).parent();
		selLi.siblings("li").removeClass("selectTag");
		selLi.addClass("selectTag");
		jboxLoad("tagContent",url,true);
	}
	
	function managePrint(fileType){
		var url ="<s:url value='/irb/printOther'/>?watermarkFlag=${GlobalConstant.FLAG_N}&irbFlow=${irbForm.irb.irbFlow}&recTypeId="+fileType;
		window.location.href= url;
	}
</script>
<body>
	<div id="main">
		<div class="mainright">
			<div class="content">
				<div style="margin-top: 5px">
					项目名称：<b>${irbForm.proj.projName } </b>&#12288;&#12288;&#12288;&#12288;伦理审查类别：<b>${irbForm.irb.irbTypeName }</b>
				</div>
				<div class="title1 clearfix">
					<table class="xllist nofix" id="splist2">
						<tr>
	                        <td width="22%">主要研究者：${irbForm.proj.applyUserName}</td>
	                        <td width="22%">专业组：${irbForm.proj.applyDeptName }</td>
	                        <td width="22%">送审日期：${irbForm.irb.irbApplyDate}</td>
	                        <td width="22%">受理日期：${irbForm.irb.irbAcceptedDate}</td>
	                        <td width="50px" style="text-align: right" rowspan="3">
								<img src="<s:url value='/css/skin/${skinPath}/images/irb_jdwj.png'/>" title="点击下载批件/意见" onclick="managePrint('${fileType}');" style="cursor: pointer;"/>
							</td>
                       	</tr>
						<tr>
                           <td>主审委员：<c:forEach items="${committeeList}" var="irbUser" varStatus="statu">${irbUser.userName}<c:if test="${fn:length(committeeList)>1&&!statu.last}">、</c:if></c:forEach></td>
                           <td>审查方式：${irbForm.irb.reviewWayName}</td>
                           <td>会议日期：${irbForm.irb.meetingDate}</td>
                           <td>审查结果：${irbForm.irb.irbDecisionName }</td>
                         </tr>
                         <tr>
                         	 <td>决定文件日期：<span id="decisionDate">${irbForm.irb.irbDecisionDate}</span></td>
                          	 <td>跟踪审查日期：${irbForm.irb.trackDate }</td>
                          	 <td></td>
                             <td></td>
                         </tr>
					</table>
					<br/>
					<div class="title1 clearfix">
						<ul id="tags">
							<c:if test="${irbForm.irb.reviewWayId==irbReviewTypeEnumFast.id }" >
								<li><a onclick="selectTag(this,'<s:url value="/irb/secretary/quickOpinion"/>?irbFlow=${param.irbFlow }')" href="javascript:void(0)">快审主审综合意见</a></li>
							</c:if>
							<c:if test="${irbForm.irb.meetingArrange==irbReviewTypeEnumMeeting.id }" >
								<li><a onclick="selectTag(this,'<s:url value='/irb/meeting/voteDesction'/>?irbFlow=${param.irbFlow }&closeButton=${GlobalConstant.FLAG_N}')" href="javascript:void(0)">会议审查决定表</a></li>
							</c:if>
							<li>
								<a id="decisionDetail" onclick="selectTag(this,'<s:url value='/irb/secretary/decisionDetail'/>?irbFlow=${param.irbFlow }');" href="javascript:void(0)">传达决定</a>
							</li>
							<li>
								<a onclick="selectTag(this,'<s:url value='/irb/cfg/info'/>?recordFlow=${irbForm.irb.irbInfoFlow }&desction=${GlobalConstant.FLAG_Y }')" href="javascript:void(0)">IRB成员名单</a>
							</li>
						</ul>
						<div id="tagContent">
						</div>
					</div>
					<%-- <div>
						<img src="<s:url value='/css/skin/${skinPath}/images/irb_cdjd.png'/>" usemap="#Map"  />
							<!-- 
							<td width="200px"><a href="#">申请/报告</a></td>
							<td width="200px"><a href="#">受理/处理</a></td>
							<td width="200px"><a href="#">审查</a></td>
							<td width="200px"><a href="#">传达决定</a></td>
							<td width="200px"><a href="#">文件存档</a></td>
							 -->
							<map name="Map">
							<c:if test="${irbForm.irb.reviewWayId==irbReviewTypeEnumFast.id }" >
						      <area shape="rect" coords="40,9,203,42" href="javascript:void(0)" onclick='load("<s:url value='/irb/secretary/quickOpinion'/>?irbFlow=${param.irbFlow }");'>
						     </c:if>
						      <area shape="rect" coords="242,9,399,40" href="javascript:void(0)" onclick='load("<s:url value='/irb/meeting/voteDesction'/>?irbFlow=${param.irbFlow }&closeButton=${GlobalConstant.FLAG_N}")'>
						      <area shape="rect" coords="445,9,604,45" href="javascript:void(0)" onclick='load("<s:url value='/irb/secretary/decisionDetail'/>?irbFlow=${param.irbFlow }");'>
						      <area shape="rect" coords="645,7,804,45" href="javascript:void(0)" onclick='load("<s:url value='/irb/cfg/info'/>?recordFlow=${irbForm.irb.irbInfoFlow }&desction=${GlobalConstant.FLAG_Y }");'>
						    </map>
						    <c:if test="${irbForm.irb.reviewWayId==irbReviewTypeEnumFast.id }" ><a href="javascript:void(0)" onclick='load("<s:url value='/irb/secretary/quickOpinion'/>?irbFlow=${param.irbFlow }");'><img src="<s:url value='/css/skin/${skinPath}/images/irb_cdjd_01.gif'/>"/></a></c:if><c:if test="${irbForm.irb.meetingArrange==irbReviewTypeEnumMeeting.id }" ><a href="javascript:void(0)" onclick='load("<s:url value='/irb/meeting/voteDesction'/>?irbFlow=${param.irbFlow }&closeButton=${GlobalConstant.FLAG_N}")'><img <c:choose><c:when test="${irbForm.irb.reviewWayId==irbReviewTypeEnumFast.id }">src="<s:url value='/css/skin/${skinPath}/images/irb_cdjd_02.gif'/>"</c:when><c:otherwise>src="<s:url value='/css/skin/${skinPath}/images/irb_cdjd_02_01.gif'/>"</c:otherwise></c:choose> /></a></c:if><a href="javascript:void(0)" onclick='load("<s:url value='/irb/secretary/decisionDetail'/>?irbFlow=${param.irbFlow }");'><img src="<s:url value='/css/skin/${skinPath}/images/irb_cdjd_03.gif'/>"/></a><a href="javascript:void(0)" onclick='load("<s:url value='/irb/cfg/info'/>?recordFlow=${irbForm.irb.irbInfoFlow }&desction=${GlobalConstant.FLAG_Y }");'><img src="<s:url value='/css/skin/${skinPath}/images/irb_cdjd_04.png'/>"/></a>
					</div>
					<div class="contentDiv" id="tagContent">
					</div> --%>
			</div>
		</div>
		</div>
		</div>
</body>
</html>