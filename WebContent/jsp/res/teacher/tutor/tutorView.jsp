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
		<div id="userListHome">
		
		</div>
	</div>
</div>
</body>
</html>