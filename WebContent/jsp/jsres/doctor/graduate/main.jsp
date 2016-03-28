<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>江苏省住院医师规范化培训管理平台</title>
<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="font" value="true"/>
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
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
	var selectLiId = "${param.liId}";
	if ($("#subMenuId").val()!="") {
		selectLiId = $("#subMenuId").val();
		$("#subMenuId").val("");
	}
	if (selectLiId != "") {
		$("#"+selectLiId).addClass("tab_select");
	} else {
		$('li').first().addClass("tab_select");
	}
	$(".tab_select a").click();
});

function doctorInfo(){
	jboxLoad("doctorContent","<s:url value='/jsp/jsres/doctor/doctorInfo.jsp'/>",false);
}

function graduateInfo(){
	jboxLoad("doctorContent","<s:url value='/jsp/jsres/doctor/graduate/graduateInfo.jsp'/>",false);
}

/* function reloadContent(url){
	jboxStartLoading();
	jboxLoad("graduateContent",url,true);
	jboxEndLoading();
} */
</script>
</head>
<body>
<div class="main_hd">
    <h2>结业信息
    </h2>
    <div class="title_tab" id="toptab">
        <ul>
            <li class="tab_select" id="doctorInfo"><a href="javascript:void(0);" onclick="doctorInfo();">基本信息</a></li>
            <li class="tab" id="graduateInfo"><a href="javascript:void(0);" onclick="graduateInfo();">西医</a></li>
        </ul>
    </div>
</div>
<div class="main_bd" id="div_table_0" >
    <div id="doctorContent">
    </div>
</div>
</body>
</html>