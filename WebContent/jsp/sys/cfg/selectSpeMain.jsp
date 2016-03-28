<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/jsres/css/exam.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script>
$(document).ready(function(){
	$(".sub-tabs-title li").click(function(){
		$(".on").removeClass("on");
		$(this).addClass("on");
	});
	$('sub-tabs-title li').first().addClass("on");
	$(".on").click();
});

function trainSpe(trainCategoryType,cfgCode){
	var url =  "<s:url value='/sys/cfg/spePage'/>?cfgCode="+cfgCode+"&trainCategoryType="+trainCategoryType;
	jboxLoad("trainSpeContent",url,false);
}
</script>
<html>
	<body>
	<div class="mainright">
  <div class="content">
		<div class="main_hd">
		    <div class="sub-tabs-title">
		    	<ul>
		            <li class="on" onclick="trainSpe('${trainCategoryTypeEnumAfter2014.id}','${cfgCode}');"><a href="javascript:void(0);">当前专业基地</a></li>
		            <li onclick="trainSpe('${trainCategoryTypeEnumBefore2014.id}','${cfgCode}');"><a href="javascript:void(0);">2014年前专业基地</a></li>
		        </ul>
		     </div>
		</div>
	<div>
	    <div id="trainSpeContent">
	    </div>
	</div>
	</div>
	</div>
	</body>
</html>