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

<style type="text/css">
	table.basic th,table.basic td{text-align: center;padding: 0;}
</style>

<script type="text/javascript">
	function search(){
		if(false==$("#sysDeptForm").validationEngine("validate")){
			return ;
		}
		$("#searchForm").submit();
	}
	function tableFixed(div){
		$("#dateFixed,#topTitle").css("top",$(div).scrollTop()+"px");
		$("#deptFixed,#topTitle").css("left",$(div).scrollLeft()+"px");
	}
	$(function(){//tableContext
		heightFiexed();
	});
	
	function heightFiexed(){
		var height = document.body.clientHeight-110;
		$("#tableContext").css("height",height+"px");	
	}
	
	onresize = function(){
		heightFiexed();
	};
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<table class="basic" style="width: 100%">
				<tr>
					<td style="text-align: left;padding-left: 10px;">
						<form id="searchForm" action="<s:url value='/sch/doc/schDept'/>" method="get">
<!-- 						年份: -->
<%-- 						<input onchange="search();" style="margin-right: 0px;width: 100px" name="schYear" onclick="WdatePicker({dateFmt:'yyyy'})" readonly="readonly" type="text" value="${empty param.schYear?pdfn:getCurrYear():param.schYear}" class="validate[required]"/> --%>
						开始日期:
						<input onchange="search();" style="margin-right: 0px;width: 100px" name="startDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" type="text" value="${empty param.startDate?startDate:param.startDate}" class="validate[required]"/>
						&#12288;
						结束日期:
						<input onchange="search();" style="margin-right: 0px;width: 100px" name="endDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" type="text" value="${empty param.endDate?endDate:param.endDate}" class="validate[required]"/>
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
			
			<div id="tableContext" style="width:100%; margin-top: 10px;margin-bottom: 10px;overflow: auto;" onscroll="tableFixed(this);">
				<div id="dateFixed" style="height: 0px;overflow: visible;position: relative;">
					<table class="basic">
						<tr>
							<th style="width: 100px;min-width: 100px;max-width: 100px;">
								轮转科室
							</th>
							<c:forEach items="${titleDate}" var="title">
								<c:if test="${sysCfgMap['res_rotation_unit'] eq schUnitEnumWeek.id}">
									<c:set var="year" value="${title.substring(0,4)}"/>
									<c:set var="week" value="${title.substring(5)}"/>
									<c:set var="title" value="${year}年<br/>${week}周"/>
								</c:if>
								<th style="width: 80px;min-width: 80px;">${title}</th>
							</c:forEach>
						</tr>
					</table>
				</div>
				<div id="deptFixed" style="height: 0px;overflow: visible;position: relative;">
					<table class="basic" style="min-width: 100px;max-width: 100px;">
						<tr>
							<th style="width: 100px;width: 100px;min-width: 100px;">
								轮转科室
							</th>
						</tr>
						<c:forEach items="${schDeptList}" var="schDept">
							<tr>
								<td style="background: white;">${schDept.schDeptName}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div id="topTitle" style="width: 0px;overflow: visible;position: relative;height: 0px;">
				<table class="basic">
					<tr>
						<th style="min-width: 100px;max-width: 100px;">轮转科室</th>
					</tr>
				</table>
				</div>
				<table class="basic">
					<tr>
						<th style="width: 100px;min-width: 100px;">
							轮转科室
						</th>
						<c:forEach items="${titleDate}" var="title">
							<c:if test="${sysCfgMap['res_rotation_unit'] eq schUnitEnumWeek.id}">
								<c:set var="year" value="${title.substring(0,4)}"/>
								<c:set var="week" value="${title.substring(5)}"/>
								<c:set var="title" value="${year}年<br/>${week}周"/>
							</c:if>
							<th style="width: 80px;min-width: 80px;">${title}</th>
						</c:forEach>
					</tr>
					<c:forEach items="${schDeptList}" var="schDept">
						<tr>
							<td>${schDept.schDeptName}</td>
							<c:forEach items="${titleDate}" var="title">
								<c:set var="key" value="${schDept.schDeptFlow}${title}"/>
								<td style="line-height: 18px;"
									<c:if test="${!empty resultListMap[key]}">
									title="
										<table>
											<c:forEach items="${resultListMap[key]}" var="result" varStatus="status">
												<tr>
													<td>${result.doctorName}</td>
												</tr>
											</c:forEach>
										</table>
									"
									</c:if>
								>
									${resultListMap[key].size()+0}
								</td>
							</c:forEach>
						</tr>
					</c:forEach>
				</table>
			</div>
	</div>
</div>
</div>
</body>
</html>