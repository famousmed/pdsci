<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/jsres/css/exam.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript">
$(document).ready(function(){
	$(".sub-tabs-title li").click(function(){
		$(".on").removeClass("on");
		$(this).addClass("on");
	});
	$('sub-tabs-title li').first().addClass("on");
	$(".on").click();
});

function trainSpe(trainCategoryType){
	var url ="<s:url value='/jsres/base/findTrainSpe'/>?orgFlow=${sessionScope.currUser.orgFlow}&trainCategoryType="+trainCategoryType;
	jboxLoad("trainSpeContent",url,false);
}
</script>
<div class="main_hd">
    <div class="sub-tabs-title">
    	<ul>
            <li class="on" onclick="trainSpe('${trainCategoryTypeEnumAfter2014.id}');"><a href="javascript:void(0);">当前专业基地</a></li>
            <li onclick="trainSpe('${trainCategoryTypeEnumBefore2014.id}');"><a href="javascript:void(0);">2014年前专业基地</a></li>
        </ul>
     </div>
</div>
<div class="main_bd">
    <div id="trainSpeContent">
    </div>
</div>
