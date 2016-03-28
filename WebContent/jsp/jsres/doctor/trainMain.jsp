<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
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

function trainInfo(){
	jboxLoad("trainContent","<s:url value='/jsp/jsres/doctor/trainInfo.jsp'/>",false);
}
</script>
<div class="main_hd">
    <h2>培训信息
    </h2>
    <div class="title_tab" id="toptab">
        <ul>
            <li class="tab_select"><a href="javascript:void(0);" onclick="trainInfo();">2012-01-01</a></li>
            &#12288;&#12288;<input class="btn_green" type="button" value="新增"/>
        </ul>
    </div>
</div>
<div class="main_bd" id="div_table_0" >
    <div id="trainContent">
    </div>
</div>
