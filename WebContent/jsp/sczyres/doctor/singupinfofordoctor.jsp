<script>
$(function(){
	$("#toptab li").click(function(){
		$(".tab_select").addClass("tab");
		$(".tab_select").removeClass("tab_select");
		$(this).removeClass("tab");
		$(this).addClass("tab_select");
		if($(this).attr('id')=="singup"){
			singup();
		}
		if($(this).attr("id")=="swap"){
			jboxLoad("singupinfo" , "<s:url value='/sczyres/doctor/swap'/>" , true);
		}
		
	});
});

function print(userFlow){
	jboxTip("打印中,请稍等...");
	var url = '<s:url value="/sczyres/doctor/print"/>?userFlow=' + userFlow;
	window.location.href = url;
}

function printAdmissionCard(userFlow){
	jboxTip("打印中,请稍等...");
	var url = '<s:url value="/sczyres/doctor/printAdmissionCard"/>?userFlow=' + userFlow;
	window.location.href = url;
}
</script>
<div class="main_hd">
     <h2>
     	网上报名
     	<!-- 报名审核通过且orgFlow=f804202731d940de95159619e96e22bf -->
     	<c:if test="${regStatusEnumPassed.id eq doctor.doctorStatusId and sczyRecDocTypeEnumAgency.id != doctor.doctorTypeId and doctor.orgFlow eq 'f804202731d940de95159619e96e22bf'}">
	     	<a href="javascript:void(0);" onclick="printAdmissionCard('${user.userFlow}');" class="btn_blue" style="float: right;margin-top: 30px; margin-right: 10px;">打印准考证</a>
     	</c:if>
     </h2> 
    <div class="title_tab" id="toptab">
        <ul>
            <li class="tab_select" id='singup'><a>报名信息</a></li>
            <!-- <li class="tab" id='swap'><a>志愿调剂</a></li> -->
        </ul>
    </div>
</div>
<div id="singupinfo">
<jsp:include page='/jsp/sczyres/doctor/singupinfo.jsp'/>

<div style="text-align: center;margin-bottom: 20px;">
	<a href="javascript:void(0);" onclick="print('${user.userFlow}');" id="printBtn" class="btn_blue">打&nbsp;&nbsp;印</a>
</div>
</div>
