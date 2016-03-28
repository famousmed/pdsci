<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	function TJ(){
		jboxStartLoading();
		$("#form").submit();
	}
	function toPage(page){
		var form = $("#form");
		$("#currentPage").val(page);
		jboxStartLoading();
		form.submit();
	}
</script>
</head>
<body>

<div class="mainright">
	<div class="content">
	<form id="form" action="<s:url value='/resedu/student/reasonTestreRultChaTestPaper'/>" method="post">
	<div style="margin-top: 10px">
		<input type="hidden" id="currentPage" name="currentPage"/>
		<input type="hidden" name="courseFlow" value="${param.courseFlow}"/>
		 考&nbsp;卷&nbsp;&nbsp;名&nbsp;&nbsp;称：&nbsp;&nbsp;<input type="text" class="xltext" name="paperName" value="${param.paperName}"/>
		 是&nbsp;&nbsp;否&nbsp;&nbsp;及&nbsp;&nbsp;&nbsp;格：&nbsp;<select name="passFlag" class="xltext" style="height:30px;width: 168px ">
					<option value="">请选择</option>
					<option value="Y" <c:if test="${param.passFlag=='Y'}">selected="selected"</c:if>>是</option>
					<option value="N" <c:if test="${param.passFlag=='N'}">selected="selected"</c:if>>否</option>
				</select>
		 出题方式：&nbsp;<select name="paperTypeId" class="xlselect" style="height:30px;width: 168px ">
					<option value="">请选择</option>
					<c:forEach items="${paperTypeEnumList}" var="paperType">
					<option value="${paperType.id}" <c:if test="${param.paperTypeId==paperType.id}">selected="selected"</c:if>>${paperType.name}</option>
					</c:forEach>
				</select>
		
	</div>
	<div style="margin-top: 10px;margin-bottom: 10px;">
		起始考试时间：&nbsp;<input type="text" class="ctime" name="testTime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" readonly="readonly" value="${param.testTime}"/>
		截止考试时间：&nbsp;<input type="text" class="ctime" name="testTimeTwo" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" readonly="readonly" value="${param.testTimeTwo}"/>
		<input type="button" class="search" onclick="TJ();" value="查询">
	</div>
		
			
		
	</form>
	</div>

	
	<table class="xllist">
	
		<colgroup>
			<col width="20%"/>
			<col width="10%"/>
			<col width="10%"/>
			<col width="10%"/>
			<col width="10%"/>
			<col width="10%"/>
			<col width="20%"/>
			<col width="10%"/>
		</colgroup>
		
		<tr>
			<th >考卷名称</th>
			<th >考生姓名</th>
			<th >考试得分</th>
			<th >及格分</th>
			<th >总得分</th>
			<th >是否及格</th>
			<th >考试时间</th>
			<th>出题方式</th>
		</tr>
		
			<c:forEach items="${list}" var="list">
			<tr>
				<td>${list.paperName}</td>
				<td>${list.userName}</td>
				<td>${list.testScore}</td>
				<td>${list.testpaper.passScore}</td>
				<td>${list.totleScore}</td>
				
				<c:if test="${list.passFlag==GlobalConstant.FLAG_Y}">
					<td>是</td>
				</c:if>
				<c:if test="${list.passFlag!=GlobalConstant.FLAG_Y}">
					<td>否</td>
				</c:if>
				
				<td>${pdfn:transDateTimeForPattern(list.testTime,"yyyyMMddHHmmss","yyyy-MM-dd") }</td>
				<td>${list.testpaper.paperTypeName}</td>
				
				</tr>
			</c:forEach>
	</table>
	       
		<p>
			<c:set var="pageView" value="${pdfn:getPageView(list)}" scope="request"/> 
			<pd:pagination toPage="toPage"/>
		</p>
 		<p align="center" style="width:100%;margin-top: 20px;">
				  <input class="search" type="button" value="关&#12288;闭"  onclick="jboxClose();" />
	    </p>
	</div>
	   
</body>
</html>