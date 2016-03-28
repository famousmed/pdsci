<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
	function search(){
		if(false==$("#sysDeptForm").validationEngine("validate")){
			return ;
		}
		$("#searchForm").submit();
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<table class="basic" style="width: 100%">
				<tr>
					<td>
						<form id="searchForm" action="<s:url value='/sch/doc/schDept'/>" method="get">
						年份:
						<input onchange="search();" style="margin-right: 0px;width: 100px" name="schYear" onclick="WdatePicker({dateFmt:'yyyy'})" readonly="readonly" type="text" value="${param.schYear}" class="validate[required]"/>
						&#12288;
						科室：<select style="width: 150px;" name="schDeptFlow" onchange="search();">
								<option></option>
								<c:forEach items="${schDeptList}" var="schDept">
									<option value="${schDept.schDeptFlow}" ${param.schDeptFlow eq schDept.schDeptFlow?'selected':''}>${schDept.schDeptName}</option>
								</c:forEach>
						</select>
						</form>
					</td>
				</tr>
			</table>
			
			<div style="width:100%; margin-top: 10px;margin-bottom: 10px;">
				<c:set value="${pdfn:getCurrDate()}" var="today"></c:set>
				<c:if test="${!empty schStartDate && !empty schEndDate}">
					<c:set value="${schStartDate.substring(0,4)}" var="startYear"></c:set>
					<c:set value="${schEndDate.substring(0,4)}" var="endYear"></c:set>
					<c:set value="${schStartDate.substring(5,7)}" var="startMonth"></c:set>
					<c:set value="${schEndDate.substring(5,7)}" var="endMonth"></c:set>
					<c:set value="${(endYear-startYear)*12+(endMonth-startMonth)}" var="dateDiff"/>
				</c:if>
				<table class="xllist" style="font-size: 14px;width: 100%">
						<tr>
							<th style="text-align: center;width: 100px;">科室</th>
							<th style="text-align: center;width: 100px;">届数</th>
							<c:if test="${!empty schStartDate && !empty schEndDate}">
							<c:set value="${startMonth}" var="month"></c:set>
							<c:set value="${startYear}" var="year"></c:set>
							<c:forEach begin="0" end="${dateDiff}" var="step">
								<th>${year}-${(month<10 && step!=0)?0:''}${month}</th>
								<c:set value="${month==12?year+1:year}" var="year"></c:set>
								<c:set value="${month==12?1:month+1}" var="month"></c:set>
							</c:forEach>
							</c:if>
						</tr>
						<c:forEach items="${schDeptList}" var="schDept">
							<c:if test="${((!empty param.schDeptFlow) && (schDept.schDeptFlow eq param.schDeptFlow)) || empty param.schDeptFlow}">
								<c:if test="${!empty sessionNumberMap[schDept.schDeptFlow]}">
								
								<c:forEach items="${sessionNumberMap[schDept.schDeptFlow]}" var="sessionNumber" varStatus="sStatus">
									<tr>
									<c:if test="${sStatus.first}">
										<td rowspan="${sessionNumberMap[schDept.schDeptFlow].size()}">${schDept.schDeptName}</td>
									</c:if>
									<td>${sessionNumber}</td>
									<c:if test="${!empty schStartDate && !empty schEndDate}">
										<c:set value="${startMonth}" var="month"></c:set>
										<c:set value="${startYear}" var="year"></c:set>
										<c:forEach begin="0" end="${dateDiff}" var="step">
											<c:set value="${schDept.schDeptFlow}${sessionNumber}" var="arrResultMapKey"></c:set>
											<td>
											<c:set value="" var="flag"></c:set>
											<c:forEach items="${arrResultMap[arrResultMapKey]}" var="arrResult" varStatus="rStatus">
												<c:set value="${arrResult.schEndDate.substring(0,7)}" var="resultEndDate"></c:set>
												<c:set value="${arrResult.schStartDate.substring(0,7)}" var="resultStartDate"></c:set>
												<c:set value="${year}-${(month<10 && step!=0)?0:''}${month}" var="currentDate"></c:set>
												<c:set value="${arrResult.schStartDate.substring(5,7)}" var="resultStartMonth"></c:set>
												<c:set value="${arrResult.schEndDate.substring(5,7)}" var="resultEndMonth"></c:set>
												<c:set value="${arrResult.schStartDate.substring(8,10)}" var="resultStartDay"></c:set>
												<c:set value="${arrResult.schEndDate.substring(8,10)}" var="resultEndDay"></c:set>
												<c:if test="${resultEndDate.compareTo(currentDate)>=0 && resultStartDate.compareTo(currentDate)<=0}">
													<c:set value="${(resultStartMonth eq month && resultStartDay eq '16')?'blue':((resultEndMonth eq month && resultEndDay eq '15')?'red':'')}" var="color"></c:set>
													${empty flag?'':'<br>'}<font color="${color}">${arrResult.doctorName}</font>
													<c:set value="${arrResult.doctorName}" var="flag"></c:set>
												</c:if>
											</c:forEach>
											</td>
											<c:set value="${month==12?year+1:year}" var="year"></c:set>
											<c:set value="${month==12?1:month+1}" var="month"></c:set>
										</c:forEach>
									</c:if>
									</tr>
								</c:forEach>
								</c:if>
							</c:if>
						</c:forEach>
						<c:if test="${empty arrResultMap}">
							<tr><td align="center" colspan="${dateDiff+3}">无记录</td></tr>
						</c:if>
					</table>
			</div>
	</div>
</div>
</div>
</body>
</html>