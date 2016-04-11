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
	
	function show(type){
		jboxStartLoading();
		var url = "<s:url value='/irb/overview'/>?type="+type+"&startDate="+$("#startDate").val()+"&endDate="+$("#endDate").val();
		window.location.href=url;
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
				<p>
					审查日期：
					<input type="text" id="startDate" value="${param.startDate }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px"/> ~ 
					<input type="text" id="endDate" value="<c:if test="${empty param.endDate }">${pdfn:getCurrDate() }</c:if><c:if test="${!empty param.endDate }">${ param.endDate }</c:if>" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px"/>&#12288;
					<input type="checkbox" value="irb" id="irb" onclick="show('irb');" <c:if test="${param.type=='irb' || empty param.type}">checked</c:if> /><label for="irb">审查类别</label>&#12288;
					<input type="checkbox" id="proj" value="proj" onclick="show('proj');" <c:if test="${param.type=='proj' }">checked</c:if>/><label for="proj">研究类别</label>&#12288;
					<input type="checkbox" id="dec" value="dec" onclick="show('dec');" <c:if test="${param.type=='dec' }">checked</c:if>/><label for="dec">决定类别</label>&#12288;
					<input type="button" value="查&#12288;询" class="search" onclick="show('')"/>
					&#12288;<font color="blue">Tip：该列表只统计已填写快审主审综合意见/会议审查决定表的项目.</font>
				</p>
		<hr/>
		</div>
	<c:if test="${param.type=='irb' || empty param.type}">
		<table class="xllist nofix" >
				<tr>
					<th width="200" >伦理审查类别</th>
					<th width="100" >会议审查</th>
					<th width="100" >会议报告</th>
					<th width="100" >合计</th>
					<td rowspan="${fn:length(irbTypeEnumList)+2 }" >
						<jsp:include page="irb_type_chart.jsp"></jsp:include> 
					</td>
				</tr>
				<c:set var="fastAmount" value="0"/>
				<c:set var="meetingAmount" value="0"/>
				<c:set var="fastAndMeetingAmount" value="0"/>
				<c:forEach items="${irbTypeEnumList}" var="type" varStatus="status">
					<tr>
						<td>${type.scName}</td>
						<td>
							${meetingTypeCountMap[type.id][status.index]}
						</td>
						<td>
							${fastTypeCountMap[type.id][status.index]}
						</td>
						<td>
							${fastTypeCountMap[type.id][status.index] + meetingTypeCountMap[type.id][status.index]}
						</td>
					</tr>
					
					<c:set var="fastAmount" value="${fastAmount  + fastTypeCountMap[type.id][status.index]}"/>
					<c:set var="meetingAmount" value="${meetingAmount + meetingTypeCountMap[type.id][status.index]}"/>
					<c:set var="fastAndMeetingAmount" value="${fastAndMeetingAmount  + fastTypeCountMap[type.id][status.index] + meetingTypeCountMap[type.id][status.index]}"/>
				</c:forEach>
				<tr >
					<td>合计</td>
					<td><c:out value="${meetingAmount}"/></td>
					<td><c:out value="${fastAmount}"/></td>
					<td><c:out value="${fastAndMeetingAmount}"/></td>
				</tr>
			</tbody>
		</table>
		</c:if>
		<c:if test="${param.type=='proj' }">
		<table class="xllist nofix" style="margin-top: 5px">
				<tr>
					<th width="200" >研究类别</th>
					<th width="100" >会议审查</th>
					<th width="100" >会议报告</th>
					<th width="100" >合计</th>
					<td rowspan="${fn:length(gcpProjSubTypeEnumList)+2 }" >
						<jsp:include page="proj_type_chart.jsp"></jsp:include> 
					</td>
				</tr>
				<c:set var="gcpFastAmount" value="0"/>
				<c:set var="gcpMmeetingAmount" value="0"/>
				<c:set var="gcpFastAndMeetingAmount" value="0"/>
				<c:forEach items="${gcpProjSubTypeEnumList}" var="type" varStatus="status">
					<tr>
						<td>${type.name}</td>
						<td>
							${gcpMeetingTypeCountMap[type.id][status.index]}
						</td>
						<td>
							${gcpFastTypeCountMap[type.id][status.index]}
						</td>
						<td>
							${gcpFastTypeCountMap[type.id][status.index] + gcpMeetingTypeCountMap[type.id][status.index]}
						</td>
					</tr>
					
					<c:set var="gcpFastAmount" value="${gcpFastAmount  + gcpFastTypeCountMap[type.id][status.index]}"/>
					<c:set var="gcpMmeetingAmount" value="${gcpMmeetingAmount + gcpMeetingTypeCountMap[type.id][status.index]}"/>
					<c:set var="gcpFastAndMeetingAmount" value="${gcpFastAndMeetingAmount  + gcpFastTypeCountMap[type.id][status.index] + gcpMeetingTypeCountMap[type.id][status.index]}"/>
				</c:forEach>	
				<tr >
					<td>合计</td>
					<td><c:out value="${gcpMmeetingAmount}"/></td>
					<td><c:out value="${gcpFastAmount}"/></td>
					<td><c:out value="${gcpFastAndMeetingAmount}"/></td>
				</tr>
		</table>
		</c:if>
		<c:if test="${param.type=='dec'}">
		<table class="xllist nofix" style="margin-top: 5px">
				<tr>
					<th width="200" >决定类别</th>
					<th width="100" >会议审查</th>
					<th width="100" >会议报告</th>
					<th width="100" >合计</th>
					<td rowspan="${fn:length(irbDecisionEnumList)+2 }">
						<jsp:include page="dec_type_chart.jsp"></jsp:include> 
					</td>
				</tr>
				<c:set var="decFastAmount" value="0"/>
				<c:set var="decMmeetingAmount" value="0"/>
				<c:set var="decFastAndMeetingAmount" value="0"/>
				<c:forEach items="${irbDecisionEnumList}" var="type" varStatus="status">
					<tr>
						<td>${type.name}</td>
						<td>
							${decMeetingTypeCountMap[type.id][status.index]}
						</td>
						<td>
							${decFastTypeCountMap[type.id][status.index]}
						</td>
						<td>
							${decFastTypeCountMap[type.id][status.index] + decMeetingTypeCountMap[type.id][status.index]}
						</td>
					</tr>
					
					<c:set var="decFastAmount" value="${decFastAmount  + decFastTypeCountMap[type.id][status.index]}"/>
					<c:set var="decMmeetingAmount" value="${decMmeetingAmount + decMeetingTypeCountMap[type.id][status.index]}"/>
					<c:set var="decFastAndMeetingAmount" value="${decFastAndMeetingAmount  + decFastTypeCountMap[type.id][status.index] + decMeetingTypeCountMap[type.id][status.index]}"/>
				</c:forEach>	
				<tr >
					<td>合计</td>
					<td><c:out value="${decMmeetingAmount}"/></td>
					<td><c:out value="${decFastAmount}"/></td>
					<td><c:out value="${decFastAndMeetingAmount}"/></td>
				</tr>
			</tbody>
				</table>
				</c:if>
	</div>
</div>
</body>
</html>