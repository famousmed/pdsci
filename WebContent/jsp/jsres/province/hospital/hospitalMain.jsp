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
function loadEditInfo(baseInfoName, baseFlow){
	var url="<s:url value='/jsres/base/findAllBaseInfo'/>?auditFlag=${param.auditFlag}&openType=open&baseInfoName="+baseInfoName+"&baseFlow="+baseFlow;
	jboxLoad("hosContent", url, false);
}
function trainSpeInfo(baseFlow){
	var url="<s:url value='/jsres/base/spePage'/>?openType=open&auditFlag=${param.auditFlag}&baseFlow="+baseFlow;
	jboxLoad("hosContent", url, false);
}

function coopBaseInfo(){
	jboxLoad("hosContent","<s:url value='/jsp/jsres/province/hospital/coopBase.jsp'/>?type=${param.type}",false);
}

function commuHospital(){
	jboxLoad("hosContent","<s:url value='/jsp/jsres/province/hospital/commuHospital.jsp'/>?type=${param.type}",false);
}
</script>
</head>
<body>
<div class="main_hd">
    <div class="title_tab" style="margin-top: 0;">
        <ul>
            <li class="tab_select" onclick="loadEditInfo('${GlobalConstant.BASIC_INFO}',${param.baseFlow });" style="cursor: pointer;"><a href="javascript:void(0);" >基本信息</a></li>
            <li class="tab" onclick="loadEditInfo('${GlobalConstant.TEACH_CONDITION}',${param.baseFlow });" style="cursor: pointer;"><a href="javascript:void(0);" >教学条件</a></li>
            <li class="tab" onclick="loadEditInfo('${GlobalConstant.ORG_MANAGE}',${param.baseFlow });" style="cursor: pointer;"><a href="javascript:void(0);" >组织管理</a></li>
            <li class="tab" onclick="loadEditInfo('${GlobalConstant.SUPPORT_CONDITION}',${param.baseFlow });" style="cursor: pointer;"><a href="javascript:void(0);" >支撑条件</a></li>
            <li class="tab" onclick="trainSpeInfo(${param.baseFlow});" style="cursor: pointer;"><a href="javascript:void(0);" >专业基地</a></li>
            <li class="tab"onclick="coopBaseInfo();"><a href="javascript:void(0);" >协同基地</a></li>
            <li class="tab"onclick="commuHospital();"><a href="javascript:void(0);" >社区培训基地</a></li>
        </ul>
    </div>
</div>
<div class="main_bd">
    <div id="hosContent">
    </div>
</div>
</body>
</html>
