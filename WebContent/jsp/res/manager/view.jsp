<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/res/teacher/Style.css'/>"></link>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
</jsp:include>

<script type="text/javascript">
	function scroll(){
		setTimeout(function(){
			$(".list li:first").animate({marginTop : "-25px"},500,function(){
				$(".list").append($(this).css({marginTop : "0px"}));
				scroll();
			});
		},3000);
	}
	$(function(){
		if($(".list li").length>1){
			scroll();
		}
	});
	
	function changeDept(deptFlow){
		location.href = "<s:url value='/res/manager/view'/>?deptFlow="+deptFlow;
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content" >
		<div>
			<table class="basic" style="margin-top: 10px; width:700px;float: left;">
				<tr>
				<td width="80px"> 最新通知：</td>
				<td width="500px">
				 <div class="scroll">  
					<ul class="list">
						 <c:forEach items="${infos}" var="info">
						 	<li><a href="<s:url value='/res/platform/noticeView'/>?infoFlow=${info.infoFlow}" target="_blank">${info.infoTitle}</a> <img src="<s:url value='/jsp/hbres/images/new.png'/>"/></li>  
						 </c:forEach>
						 <c:if test="${empty infos}">
						 	<li>暂无通知!</li>
						 </c:if>
	               </ul> 
	               </div> 
	               </td>
	               <td width="100px">
					<span style="text-align:center;"> <a href="<s:url value='/res/doc/noticeList'/>?fromSch=true&isView=true&roleFlag=${roleFlag}">>>查看更多</a></span>
					</td>
				</tr>
			</table> 
		</div>
		<div style="float: left;margin-top: 10px;width: 100%;">
			<div style="width: 20%;float: left;">
				<table class="xllist">
					<tr>
						<th>科室名称</th>
						<th>轮转人数</th>
						<th>待入科人数</th>
					</tr>
					<c:forEach items="${deptList}" var="dept">
						<tr onclick="changeDept('${dept.deptFlow}');" style="cursor: pointer;<c:if test="${param.deptFlow eq dept.deptFlow}">background: pink;</c:if>">
							<td>${dept.deptName}</td>
							<td>${processListMap[dept.deptFlow].size()+0}</td>
							<td>${willInResultListMap[dept.deptFlow].size()+0}</td>
						</tr>
					</c:forEach>
					<c:if test="${empty deptList}">
						<tr><td colspan="99">无记录</td></tr>
					</c:if>
				</table>
			</div>
			<div style="width: 79%;float: right;">
				<table class="xllist">
					<tr>
						<th colspan="99" style="text-align: left;padding-left: 10px;">轮转中学员</th>
					</tr>
					<tr>
						<th style="width: 10%;">姓名</th>
						<th style="width: 5%;">性别</th>
						<th style="width: 10%;">手机</th>
						<th style="width: 10%;">入院时间</th>
						<th style="width: 10%;">人员类型</th>
						<th style="width: 10%;">轮转科室</th>
						<th style="width: 16%;">计划轮转时间</th>
						<th style="width: 10%;">入科时间</th>
					</tr>
					
					<c:forEach items="${processListMap[param.deptFlow]}" var="process">
						<c:set var="user" value="${userMap[process.userFlow]}"/>
						<c:set var="doctor" value="${doctorMap[process.userFlow]}"/>
						<tr>
							<td>${user.userName}</td>
							<td>${user.sexName}</td>
							<td>${user.userPhone}</td>
							<td>${doctor.inHosDate}</td>
							<td>${doctor.doctorCategoryName}</td>
							<td>${process.schDeptName}</td>
							<td>${process.schStartDate}~${process.schEndDate}</td>
							<td>${process.startDate}</td>
						</tr>
					</c:forEach>
					
					<c:if test="${empty param.deptFlow}">
						<tr><td colspan="99">请选择科室</td></tr>
					</c:if>
					<c:if test="${!empty param.deptFlow && empty processListMap[param.deptFlow]}">
						<tr><td colspan="99">无记录</td></tr>
					</c:if>
				</table>
				<table class="xllist" style="margin-top: 10px;">
					<tr>
						<th colspan="99" style="text-align: left;padding-left: 10px;">待入科学员</th>
					</tr>
					<tr>
						<th style="width: 10%;">姓名</th>
						<th style="width: 5%;">性别</th>
						<th style="width: 10%;">手机</th>
						<th style="width: 10%;">入院时间</th>
						<th style="width: 10%;">人员类型</th>
						<th style="width: 10%;">轮转科室</th>
						<th style="width: 16%;">计划轮转时间</th>
						<th style="width: 10%;">备注</th>
					</tr>
					
					<c:forEach items="${willInResultListMap[param.deptFlow]}" var="result">
						<c:set var="user" value="${userMap[result.doctorFlow]}"/>
						<c:set var="doctor" value="${doctorMap[result.doctorFlow]}"/>
						<c:set var="currDate" value="${pdfn:getCurrDate()}"/>
						<c:set var="overDay" value="${pdfn:signDaysBetweenTowDate(currDate,result.schStartDate)}"/>
						<tr>
							<td style="<c:if test="${overDay>0}">color:red;</c:if>">${user.userName}</td>
							<td>${user.sexName}</td>
							<td>${user.userPhone}</td>
							<td>${doctor.inHosDate}</td>
							<td>${doctor.doctorCategoryName}</td>
							<td>${result.schDeptName}</td>
							<td>${result.schStartDate}~${result.schEndDate}</td>
							<td>
								<c:if test="${overDay>0}">
									已超过入科日期${overDay}天
								</c:if>
							</td>
						</tr>
					</c:forEach>
					
					<c:if test="${empty param.deptFlow}">
						<tr><td colspan="99">请选择科室</td></tr>
					</c:if>
					<c:if test="${!empty param.deptFlow && empty willInResultListMap[param.deptFlow]}">
						<tr><td colspan="99">无记录</td></tr>
					</c:if>
				</table>
			</div>
		</div>
	</div>
</div>
</body>
</html>