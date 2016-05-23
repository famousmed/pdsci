<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script>
function nextPage(pagenum){
	var currentDiv = $(".wsdiv:visible");
	if(pagenum=="-1"){
		if(currentDiv.prev("div").hasClass("wsdiv")){
			currentDiv.hide();
			currentDiv.prev(".wsdiv").show();
		}
	}else if(pagenum=="1"){
		if(currentDiv.next("div").hasClass("wsdiv")){
			currentDiv.hide();
			currentDiv.next(".wsdiv").show();
		}
	}
}
</script>
</head>

<body>
<c:set var="pageSize" value="5"/>
<div id="register">
<div id="logo"><img src="<s:url value='/css/skin/${skinPath}/images/${applicationScope.sysCfgMap["sys_login_img"]}_head.png'/>" /></div>
</div>
<div class="mainright1">
<div style="height:80px;">&nbsp;</div>
<div id="station">
	<c:set var="currentPage" value="1"/>
 	<c:forEach items="${applicationScope.workStationList}"  varStatus="status">	
 	<c:if test="${status.index % pageSize eq 0}">
 	<div class="wsdiv"  style="display:<c:if test='${!status.first }'>none</c:if>">
 	<ul>
 	<c:forEach items="${applicationScope.workStationList}" var="workStation"  begin="${status.index}" end="${status.index+pageSize-1}">						        		
		<c:if test="${pdfn:contain(workStation.workStationId, sessionScope.currUserWorkStationIdList) or sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE}">
		<li style="width:350px;">		
			<a href="<s:url value='/main/${workStation.workStationId}'/>">
				<img src="<s:url value='/css/skin/${skinPath}/images/${workStation.workStationId}.png' />" />${workStation.workStationName}
			</a>
		</li>
		</c:if>
		</c:forEach>
		
		<%-- 如果当前工作站没选中，默认显示第一个工作站 --%>
		<c:if test="${fn:length(sessionScope.currUserWorkStationIdList)==1}">
			<script type="text/javascript">
				$(document).ready(function(){
					window.location.href="<s:url value='/main/${sessionScope.currUserWorkStationIdList[0]}'/>?time="+new Date();
				});
			</script>
		</c:if>
    </ul>
    <c:set var="currentPage" value="${currentPage+1 }"/>
    </div>
    </c:if>
    </c:forEach>
    <div class="fy-btn">
    	<c:if test="${fn:length(applicationScope.workStationList)>5 }"> 
	    	<a href="javascript:nextPage('-1');"><img src="<s:url value='/css/skin/${skinPath}/images/pre.png' />"/></a>
	    	<a href="javascript:nextPage('1');"><img src="<s:url value='/css/skin/${skinPath}/images/next.png' />"/></a>
    	</c:if>
    </div>
</div>
<div class="footer">Copyright © <a href="http://www.pharmasun.cn" target="_blank">法默生临床试验管理系统</a> <img src="css/img/logos.png" width="16" height="16"> 南京迈拓医药科技有限公司 All rights reserved. v2015.1</div>
</div>
</div>
</body>
</html>