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
         <div class="index_form" >
          <h3>项目概况</h3>
          <table border="0" cellpadding="0" cellspacing="0" class="grid" style="border-top: 0px;">
            	<tr >
            		<td style="width: 100px;padding-left: 20px;">项目名称：</td>
            		<td style="text-align: left;" colspan="3">${proj.projName}</td>
            	</tr>
            	<tr >
            		<td style="width: 100px;padding-left: 20px;">项目简称：</td>
            		<td style="text-align: left;width: 400px;">${proj.projShortName}</td>
            		<td style="width: 100px;padding-left: 20px;text-align: right">项目编号：</td>
            		<td style="text-align: left;">${proj.projNo}</td>
            	</tr>
            	<tr >
            		<td style="width: 100px;padding-left: 20px;">项目类型：</td>
            		<td style="text-align: left;width: 400px;">${proj.projSubTypeName}</td>
            		<td style="width: 100px;padding-left: 20px;text-align: right">计划病例数：</td>
            		<td style="text-align: left;">${projInfoForm.caseCount}</td>
            	</tr>
            	<tr >
            		<td style="width: 100px;padding-left: 20px;">&#12288;适应症：</td>
            		<td style="text-align: left;" >${projInfoForm.indication}</td>
            		<td style="width: 100px;padding-left: 20px;text-align: right">申办单位：</td>
            		<td style="text-align: left;">${proj.projShortDeclarer}</td>
            	</tr>
          </table>
        </div>
        <div class="index_form" style="margin-top: 20px;">
          <h3>项目介绍</h3>
         <table class="${projForm.proj.projFlow }" style="margin-bottom: 20px;border: 1px solid #ddd;border-top: 0px;width: 100%;">
			<tr><td  style="padding-left: 20px;padding-top:20px;font-size: 16px;">项目介绍：</td></tr>
			<tr><td  style="padding-left: 20px;font-size: 14px;width: 100%"><pre style="font-family: Microsoft Yahei;line-height:25px;white-space: pre-wrap ">
			${projInfoForm.info}</pre>
			</td></tr>
		</table>
        </div>
        </div>
</div>
