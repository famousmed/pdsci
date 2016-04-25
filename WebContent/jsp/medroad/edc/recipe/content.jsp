<!-- 
<script type="text/javascript" src="<s:url value='/jsp/medroad/js/jquery.mCustomScrollbar.concat.min.js'/>"></script>    
<link rel="stylesheet" href="<s:url value='/jsp/medroad/css/jquery.mCustomScrollbar.css'/>">
 -->
<script type="text/javascript">
/*
$("#recipeContent").mCustomScrollbar({
	theme : "dark-thick"
})*/

function saveRecipe(){
	//var visitdata = "&visitDate="+$("#visitDate").val()+"&visitWindow="+$("#visitWindow").val();
	jboxPost("<s:url value='/medroad/saveVisitDate'/>?visitFlow=${visit.visitFlow}",$("#recipeForm").serialize(),function(resp){
		jboxTip(resp);
		$("."+'${visit.visitFlow}'+'_visitDate').html($("#visitDate").val());
	},null,true);
}
</script>
<div id="recipeContent" style="width: 100%;height: 100%;background-color: white;overflow: auto;">
	<div class="main_hd" >
    <form id="recipeForm">
		<h2 class="underline">
			${visit.visitName}&#12288;<input type="button" style="float: right;margin-right: 10px;margin-top: 30px;" class="btn_green" onclick="saveRecipe();" value="保&#12288;存"></input>
		</h2> 
		<div class="index_form" style="margin-top: 10px;margin-left: 10px;margin-right: 10px;" >
	         <h3>访视窗 </h3>
	          <div style="border: 1px solid #ddd;border-top-width: 0px;">
	          	<jsp:include page="/jsp/medroad/edc/reacher/datainput_visit.jsp" ></jsp:include>
	          </div>
		 </div>
		  <div class="index_form" style="margin-top: 10px;margin-left: 10px;margin-right: 10px;" >
	         <h3>检查内容</h3>
	          <div style="border: 1px solid #ddd;border-top-width: 0px;">
	          		<textarea name="doctorExplain" class="input" style="height: 100px;width: 650px;margin-top: 5px;margin-bottom: 5px;text-indent:0">${visitInfoMap.doctorExplain }</textarea>
	          </div>
		 </div>
		 <div class="index_form" style="margin-top: 10px;margin-left: 10px;margin-right: 10px;" >
	         <h3>理化检查 </h3>
	          <div style="border: 1px solid #ddd;border-top-width: 0px;padding-left: 30px;">
	         		 未上传
	          </div>
		 </div>
		 <div class="index_form" style="margin-top: 10px;margin-left: 10px;margin-right: 10px;" >
	         <h3>病理 </h3>
	          <div style="border: 1px solid #ddd;border-top-width: 0px;padding-left: 30px;">
	          	未上传
	          </div>
		 </div>
		 <div class="index_form" style="margin-top: 10px;margin-left: 10px;margin-right: 10px;" >
	         <h3>影像 </h3>
	          <div style="border: 1px solid #ddd;border-top-width: 0px;padding-left: 30px;">
	          	未上传
	          </div>
		 </div>
		 <div class="index_form" style="margin-top: 10px;margin-left: 10px;margin-right: 10px;margin-bottom: 20px;" >
	         <h3>心电图 </h3>
	          <div style="border: 1px solid #ddd;border-top-width: 0px;padding-left: 30px;">
	          		未上传
	          </div>
		 </div>
		 <!-- 
		  <div class="index_form" style="margin-top: 10px;margin-left: 10px;margin-right: 10px;margin-bottom: 20px;" >
	         <h3>CRF病例表 </h3>
	          <div style="border: 1px solid #ddd;border-top-width: 0px;padding-left: 30px;height: 250px;">
	          	<div style="margin-top: 10px;margin-left: 10px;cursor: pointer;height:200px;width:150px;float: left;background: url('<s:url value='/css/skin/${skinPath}/images/caseinfo_edit.jpg'/>' ) no-repeat;" >
	          	</div>
	          	<div style="margin-top: 10px;margin-left: 10px;cursor: pointer;height:200px;width:150px;float: left;background: url('<s:url value='/css/skin/${skinPath}/images/caseinfo_edit.jpg'/>' ) no-repeat;" >
	          	</div>
	          	<div style="margin-top: 10px;margin-left: 10px;cursor: pointer;height:200px;width:150px;float: left;background: url('<s:url value='/css/skin/${skinPath}/images/caseinfo_edit.jpg'/>' ) no-repeat;" >
	          	</div>
	          	<div style="margin-top: 10px;margin-left: 10px;cursor: pointer;height:200px;width:150px;float: left;background: url('<s:url value='/css/skin/${skinPath}/images/caseinfo_edit.jpg'/>' ) no-repeat;" >
	          	</div>
	          
	          </div>
		 </div>
		  -->
	</form>
</div>							
</div>
