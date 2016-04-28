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
          <h3>项目文档</h3>
         <table class="grid" style="border-top-width: 0px;">
         	<c:forEach items="${fileList}" var="file">
				<tr><td style="text-align: left;padding-left: 20px;">
				<a  style="color: black;" href="<s:url value='/pub/file/down'/>?fileFlow=${file.fileFlow}">
				${file.fileName}</a></td>
				</tr>
         	</c:forEach>
         	<c:if test="${empty fileList }">
         		<tr><td >无记录</td></tr>
         	</c:if>
		</table>
        </div>
        </div>
</div>
