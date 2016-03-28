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

function doctorInfo(userFlow){
	var url = "<s:url value='/jsres/doctor/doctorInfo?userFlow='/>" + userFlow;
	jboxLoad("doctorContent", url, false);
}

function trainInfo(type){
	jboxLoad("doctorContent","<s:url value='/jsp/jsres/doctor/trainInfo.jsp'/>?type="+type,false);
}

/* function editTrainInfo(){
	jboxLoad("doctorContent","<s:url value='/jsp/jsres/doctor/editTrainInfo.jsp'/>",false);
} */

function editTrainInfo(recruitFlow){
	var url = "<s:url value='/jsres/doctor/editTrainInfo?recruitFlow='/>"+recruitFlow +"&openType=open";
	var title = "新增";
	if(recruitFlow){
		title = "修改"
	}
	jboxOpen(url, title + "培训记录", 800, 400);
}

function viewTrainInfo(recruitFlow){
	var url = "<s:url value='/jsres/doctor/editTrainInfo?recruitFlow='/>"+recruitFlow;
	jboxLoad("doctorContent", url, false);
}

</script>
<div class="main_hd">
    <h2>培训信息&#12288;&#12288;<input class="btn_green" type="button" onclick="editTrainInfo();" value="添加培训记录"></h2>
    <div class="title_tab" id="toptab">
        <ul>
            <li class="tab_select"  onclick="doctorInfo('${sessionScope.currUser.userFlow}');"><a href="javascript:void(0);">基本信息</a></li>
            <c:forEach items="${recruitList}" var="recruit">
	            <li class="tab" onclick="viewTrainInfo('${recruit.recruitFlow}');"><a href="javascript:void(0);">${recruit.catSpeName}</a></li>
            </c:forEach>
        </ul>
    </div>
</div>
<div class="main_bd" id="div_table_0" >
    <div id="doctorContent">
    </div>
</div>
