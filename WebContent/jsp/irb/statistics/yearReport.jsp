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
<script type="text/javascript">
	$(function(){
		var recordFlow = $("#irbInfoFlow").val();
		var irbReviewDate = $("#year").val();
		jboxLoad("irbMember","<s:url value='/irb/cfg/info'/>?desction=${GlobalConstant.FLAG_N}&recordFlow="+recordFlow,false);
		jboxLoad("irb_Overview","<s:url value='/irb/overview'/>?type=irb&irbReviewDate="+irbReviewDate+"&irbInfoFlow="+recordFlow,false);
		jboxLoad("proj_Overview","<s:url value='/irb/overview'/>?type=proj&irbReviewDate="+irbReviewDate+"&irbInfoFlow="+recordFlow,false);
		jboxLoad("dec_Overview","<s:url value='/irb/overview'/>?type=dec&irbReviewDate="+irbReviewDate+"&irbInfoFlow="+recordFlow,false);
	});
	function search(){
		jboxStartLoading();
		$("#searchForm").submit();
	}
	
	function downYearReport() {
		var url ="<s:url value='/irb/printOther'/>?watermarkFlag=${GlobalConstant.FLAG_N}&recTypeId=yearReport&year="+$("#year").val()
				+"&irbInfoFlow="+$("#irbInfoFlow").val();
		window.location.href= url;
	}
</script>
<style type="text/css">
	.xllist th{background: #fff;}
	th.th_sp{padding-left: 15px;background: #ECF2FA;text-align: left;font-size: 14px;}
</style>
</head>
<body>
<div class="mainright">
	<form id="searchForm" action="<s:url value='/irb/yearReport'/>" method="post">
	<div class="title1 clearfix" style="padding-left: 15px;">
				<p>
					年度：
					<select id="year" name="year" onchange="search()" class="xlselect" style="width:120px;">
						<option value="2013" <c:if test="${param.year=='2013' || currYear=='2013'}"> selected="selected" </c:if> >2013</option>
						<option value="2014" <c:if test="${param.year=='2014' || currYear=='2014'}"> selected="selected" </c:if> >2014</option>
						<option value="2015" <c:if test="${param.year=='2015' || currYear=='2015'}"> selected="selected" </c:if>>2015</option>
						<option value="2016" <c:if test="${param.year=='2016' || currYear=='2016'}"> selected="selected" </c:if>>2016</option>
					</select>
					伦理委员会：
					<select id="irbInfoFlow" name="irbInfoFlow" onchange="search()" class="xlselect">
						<c:forEach items="${irbInfoList}" var="irbInfo" varStatus="statu">
							<option value="${irbInfo.recordFlow }" <c:if test="${param.irbInfoFlow==irbInfo.recordFlow|| statu.first}"> selected="selected" </c:if> >${irbInfo.irbName }</option>
						</c:forEach>
					</select>
					<input class="search" type="button" value="下&#12288;载" onclick="downYearReport();" />
				</p>
		</div>
	</form>
	<div class="content">
	<div id="irbMember">
	</div>
		<table class="xllist" style="margin-top: 15px;" id="irb_Overview"></table>
		<table class="xllist" id="proj_Overview" style="border-top: none;"></table>
		<table class="xllist" id="dec_Overview" style="border-top: none;"></table>
		<table class="xllist" style="margin-top: 15px">
				<thead>
					<tr><th colspan="4" class="th_sp">年度会议情况</th></tr>
					<tr>
					<th width="200" >年度审查会议数</th>
					<th width="100" >平均每次会议审查/报告项目数</th>
					<th width="100" >平均每次会议时间</th>
					<th width="100" >平均到会委员数</th>
				</tr>
					<tr >
						<td>${mMap["mCount"] }</td>
						<td>${mMap["avgMeeting"] }/${mMap["avgFast"] }</td>
						<td>${mMap["avgMeetTime"] }</td>
						<td>${mMap["avgMeetingMember"] }</td>
					</tr>
			</tbody>
		</table>
		<table class="xllist" style="margin-top: 15px">
				<thead>
				<tr><th colspan="5" class="th_sp">年度培训情况</th></tr>
				<tr><td colspan="5" style="text-align: left;font-weight: bold;color: #333;padding-left: 25px;">1.派出培训</td></tr>
                  <tr>
					<th width="200" >主办单位</th>
					<th width="100" >（培训）项目名称</th>
					<th width="100" >培训类别</th>
					<th width="100" >培训日期</th>
					<th width="100" >培训人数</th>
				</tr>
				<c:forEach items="${outList}" var="train">
					<tr >
						<td>${train.trainOrg }</td>
						<td>${train.trainName }</td>
						<td>${train.trainTypeName }</td>
						<td>${train.trainDate }</td>
						<td>${userCountMap[train.trainFlow]}</td>
					</tr>
				</c:forEach>
					<tr><td colspan="5" style="text-align: left;font-weight: bold;color: #333;padding-left: 25px;">2.机构内部培训</td></tr>
					 <tr>
					<th width="200" >主办单位</th>
					<th width="100" >（培训）项目名称</th>
					<th width="100" >培训类别</th>
					<th width="100" >培训日期</th>
					<th width="100" >培训人数</th>
				</tr>
				<c:forEach items="${innerList}" var="train">
					<tr >
						<td>${train.trainOrg }</td>
						<td>${train.trainName }</td>
						<td>${train.trainTypeName }</td>
						<td>${train.trainDate }</td>
						<td>${userCountMap[train.trainFlow]}</td>
					</tr>
				</c:forEach>
		</table>
</div>
</div>
</body>
</html>