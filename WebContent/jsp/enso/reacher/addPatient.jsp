<jsp:include page="/jsp/enso/htmlhead-enso.jsp">
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
	jboxPost("<s:url value='/enso/savePatient'/>",$("#patientForm").serialize(),function(resp){
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
<div class="main_hd">
    <form id="recruitResultForm">
		<h2 class="underline">
			添加受试者
		</h2> 
	</form>
</div>
<div class="main_bd" id="div_table_0" >
	<form id="patientForm" style="position:relative;">
		<input type="hidden" name="user.userFlow" value="${user.userFlow}"/>
		<input type="hidden" name="doctor.doctorFlow" value="${doctor.doctorFlow}"/>
		<div class="search_table">
		<h4>基本信息</h4>
		<table border="0" cellpadding="0" cellspacing="0" class="base_info" >
			<tbody>
			    <tr>
			    	<th>姓&#12288;&#12288;名：</th>
			        <td><input name="patientName"  class="validate[required] input" style="width:250px;"/><span style="color: red;">*</span></td>
			        <th>性&#12288;&#12288;别：</th>
			        <td colspan="2">
			        	&nbsp;<label><input type="radio" class='validate[required]' value="${userSexEnumMan.id }" style="width:auto;" name="sexId" />&nbsp;${userSexEnumMan.name}</label>&#12288;
                        <label><input type="radio" class='validate[required]' value="${userSexEnumWoman.id }" style="width:auto;" name="sexId" />&nbsp;${userSexEnumWoman.name}</label>&#12288;<span style="color: red;">*</span>
			        </td>
			    </tr>
			    <tr>
			        <th>证件号：</th>
			        <td ><input name="patientCode"  class="validate[required,custom[chinaIdLoose]] input " onblur="writeBirthday(this);" style="width:250px;"/><span style="color: red;">*</span></td>     
			    	 <th>生&#12288;&#12288;日：</th>
			        <td colspan="2"><input name="patientBirthday" readonly="readonly" id="patientBirthday" class="validate[required] input " style="width:250px;"/><span style="color: red;">*</span></td>
			    </tr>
			     <tr>
			    	<th>来&#12288;&#12288;源：</th>
			        <td>&nbsp;<label><input type="radio" class='validate[required]' style="width:auto;" name="patientSourceId" value='${patientSourceEnumOutPatient.id}' />&nbsp;门诊</label>&#12288;
                        <label><input type="radio" class='validate[required]' style="width:auto;" name="patientSourceId" value='${patientSourceEnumInPatient.id}' />&nbsp;住院</label>&#12288;<span style="color: red;">*</span></td>
			        <th>病历/住院号：</th>
			        <td colspan="2">
			        	<input name="patientNo"  class=" input" style="width:250px;"/>
			        </td>
			    </tr>
			    <tr>
			    	<th>手&#12288;&#12288;机：</th>
			        <td><input name="patientPhone"  class="validate[required,custom[mobile]] input" style="width:250px;"/><span style="color: red;">*</span></td>
		       		<th></th>
		       		<td colspan="2"></td>
		       		<!-- 
		       		<th>电子邮箱：</th>
			    	<td colspan="2"><input name="patientEmail"  class="validate[required,custom[email]] input" />&#12288;<span style="color: red;">*</span></td>	        
		       		 -->
			    </tr>
			    <!-- 
			    <tr>
			    	<th>通讯地址：</th>
			        <td colspan="4"><input name="patientAddress"  class=" input"  style="width:560px;"/>&#12288;</td>
			    </tr>
			     -->
			    <tr>
			    	<th>备注：</th>
			        <td colspan="4"><textarea name="patientStageNote"  class="input" style="height: 100px;width: 560px;margin-top: 5px;margin-bottom: 5px;text-indent:0"></textarea></td>
			    </tr>
			 </tbody>
		</table>
	</div>
		</form>
		<div class="btn_info">
			<input type="button" style="width:100px;" class="btn_blue" onclick="savePatient();" value="保&#12288;存"></input>
		</div>
</div>
