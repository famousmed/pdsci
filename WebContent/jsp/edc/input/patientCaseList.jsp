<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<script type="text/javascript" src="<s:url value='/js/jquery-1.8.3.min.js'/>">?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<style type="text/css"> 
*{margin:0;padding:0;list-style-type:none;}
a,img{border:0;}
body{font:12px/180% Arial, Helvetica, sans-serif, "新宋体";}

.banner{width:100%;overflow:hidden;height:470px;}
.banList{height:470px}
.banList li{height:470px;z-index:1;}
.banList li.active{opacity:1;transform:scale(1);z-index:2;}
.fomW{position:absolute;bottom:20px;left:50%;height:20px;z-index:9;width:1000px;margin-left:-500px}
.jsNav{text-align:center;}
.jsNav a{display:inline-block;background:#fff;width:15px;height:15px;border-radius:50%;margin:0 5px;}
.jsNav a.current{background:#fc8f0f;cursor:pointer}
</style>
</head>
	<body style="background-color: black">
		<div class="banner">
	<ul class="banList">
	<c:forEach items="${dataList }" var="data" varStatus="status">
	<font color="white" imgFlow="${data.imageFlow}">${data.time}<br/>${data.note}</font>
		<c:if test="${status.first }">
			<li class="active" imgFlow="${data.imageFlow }"><a href="#"><img style="width: 100%;height: 100%" src="${data.imageUrl}"/></a></li>
		</c:if>
		<c:if test="${!status.first }">
			<li style="display: none" imgFlow="${data.imageFlow }"><a href="#"><img src="${data.imageUrl}"/></a></li>
		</c:if>
	</c:forEach> 
	</ul>
	<div class="fomW">
		<div class="jsNav">
			<c:forEach items="${dataList }" var="data"  varStatus="status">
				<c:if test="${status.first }">
					<a href="javascript:;" class="trigger current" imgFlow="${data.imageFlow }"></a>
				</c:if>
				<c:if  test="${!status.first }">
				<a href="javascript:;" class="trigger" imgFlow="${data.imageFlow }"></a>
				</c:if>
			</c:forEach>
		</div>
	</div>
</div>
	
<script type="text/javascript"> 
$(".trigger").bind("click",function(){
	$(".current").removeClass("current");
	$(this).addClass("current");
	var imgFlow = $(this).attr("imgFlow");
	$("li").hide();
	$("li[imgFlow='"+imgFlow+"']").show();
	$("font").hide();
	$("font[imgFlow='"+imgFlow+"']").show();
});
</script>

</body>
</html>