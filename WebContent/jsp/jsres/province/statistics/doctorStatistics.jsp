<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>江苏省住院医师规范化培训管理平台</title>
<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/jsres/css/exam.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript">
$(document).ready(function(){
	$("li").click(function(){
		$(".tab_select").addClass("tab");
		$(".tab_select").removeClass("tab_select");
		$(this).removeClass("tab");
		$(this).addClass("tab_select");
	});
	if ("${param.liId}" != "") {
		$("#${param.liId}").addClass("tab_select");
	} else {
		$('li').first().addClass("tab_select");
	}
	$(".tab_select a").click();
});

function oneStatistics(){
	jboxLoad("hosContent","<s:url value='/jsp/jsres/province/statistics/oneStatistics.jsp'/>?type=${param.type}",false);
}

function secondStatistics(){
	jboxLoad("hosContent","<s:url value='/jsp/jsres/province/statistics/secondStatistics.jsp'/>?type=${param.type}",false);
}

function nationStatistics(){
	jboxLoad("hosContent","<s:url value='/jsp/jsres/province/statistics/nationStatistics.jsp'/>?type=${param.type}",false);
}

function basicStatistics(){
	jboxLoad("hosContent","<s:url value='/jsp/jsres/province/statistics/basicStatistics.jsp'/>?type=${param.type}",false);
}

</script>
</head>
<body>
<div class="main_hd">
	<h2>在培医师统计</h2>
    <div class="title_tab" style="margin-top: 0;">
        <ul>
            <li class="tab_select"><a href="javascript:void(0);" onclick="oneStatistics();">西医在培医师统计</a></li>
            <li class="tab"><a href="javascript:void(0);" onclick="secondStatistics();">中医在培医师统计</a></li>
            <li class="tab"><a href="javascript:void(0);" onclick="nationStatistics();">国家专业在培医师统计</a></li>
            <li class="tab"><a href="javascript:void(0);" onclick="basicStatistics();">基地在培医师统计</a></li>
        </ul>
    </div>
</div>
<div class="main_bd">
    <div id="hosContent">
    </div>
</div>
</body>
</html>
