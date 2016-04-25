<jsp:include page="/jsp/medroad/htmlhead-medroad.jsp">
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
/*
$(function(){
	$('.datepicker').datepicker();
});*/



function savePatient(){
	if(false==$("#patientForm").validationEngine("validate")){
		return ;
	}
	jboxPost("<s:url value='/medroad/savePatient'/>",$("#patientForm").serialize(),function(resp){
		jboxTip(resp);
		addPatient();
	},null);
}
function writeBirthday(obj){
	var idNo = obj.value;
	var birthDayObj = $("#patientBirthday");
	var birthDay="";
	if(idNo.length==15){
		birthDay = "19"+idNo.substr(6,2)+"-"+idNo.substr(8,2)+"-"+idNo.substr(10,2); 	
	}else if(idNo.length==18){
		birthDay = idNo.substr(6,4)+"-"+idNo.substr(10,2)+"-"+idNo.substr(12,2);
	}else{
		return false;
	}
	birthDayObj.val(birthDay);
	//$("#patientBirthday").val(birthDay);
}
</script>

 <div class="col_main" id="content">
       <div class="content_main">
        <div class="index_form">
          <h3>诊疗方案</h3>
         <table class="${projForm.proj.projFlow }" style="margin-bottom: 20px;border: 1px solid #ddd;border-top: 0px;width: 100%;">
			<tr><td  style="padding-left: 20px;padding-top:20px;font-size: 16px;">未维护</td></tr>
			<tr><td  style="padding-left: 20px;font-size: 14px;width: 100%"><pre style="font-family: Microsoft Yahei;line-height:25px;white-space: pre-wrap ">
			</pre>
			</td></tr>
		</table>
        </div>
        <div class="index_form">
          <h3>临床路径释义</h3>
          <table class="${projForm.proj.projFlow }" style="margin-bottom: 20px;border: 1px solid #ddd;border-top: 0px;width: 100%;">
			<tr><td  style="padding-left: 20px;padding-top:20px;font-size: 16px;">未维护</td></tr>
			<tr><td  style="padding-left: 20px;font-size: 14px;width: 100%"><pre style="font-family: Microsoft Yahei;line-height:25px;white-space: pre-wrap ">
			</pre>
			</td></tr>
		</table>
        </div>
        </div>
</div>
