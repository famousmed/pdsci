<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/medroad/css/stat_overview.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<link rel="stylesheet" type="text/css" 	href="<s:url value='/jsp/medroad/css/dropdown.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/ajaxfileupload.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
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
	var drugAmount = $("#drugAmount").val();
	var drugFlow = $("#drugFlow").val();
	if(drugAmount &&drugFlow){
		if(parseInt(drugAmount)>parseInt(drugFlow.split("_")[2])){
			jboxTip("发药量大于库存量!");
			return;
		}
	}
	jboxPost("<s:url value='/medroad/saveVisitDate'/>?visitFlow=${visit.visitFlow}",$("#recipeForm").serialize(),function(resp){
		jboxTip(resp);
		$("."+'${visit.visitFlow}'+'_visitDate').html($("#visitDate").val());
		loadDetail('${visit.visitFlow}');
	},null,true);
}
function userRecipeFile(type){
	$.ajaxFileUpload({
		url:"<s:url value='/medroad/userRecipeFile'/>?filetype="+type+"&visitFlow=${visit.visitFlow}",
		secureuri:false,
		fileElementId:type+'File',
		dataType: 'json',
		success: function (data){
			if(data=="${GlobalConstant.UPLOAD_SUCCESSED}"){
				jboxTip('${GlobalConstant.UPLOAD_SUCCESSED}');
				loadDetail('${visit.visitFlow}');
			}else{
				jboxTip('${GlobalConstant.UPLOAD_FAIL}');
			}
		},
		error: function (data, status, e){
			jboxTip('${GlobalConstant.UPLOAD_FAIL}');
		},
		complete:function(){
			$("#imageFile").val("");
		}
	});
}

$(document).ready(function(){
	$("li").on("mouseenter mouseleave",function(){
		$(this).find("span").toggle();
	});
	
	//初始化下拉
	$(".jsDropdownBt").bind("click",function(){
		$(this).next(".jsDropdownList").show();
	});
	$(".jsDropdownItem").bind("click",function(){
		$(this).parents(".jsDropdownList").hide();
		$(this).parent().parent().parent().siblings(".jsDropdownBt").find(".jsBtLabel").html(($(this).html()));
		$(this).parent().parent().parent().siblings(".jsDropdownHidden").val($(this).attr("data-value"));
	});

});
function delRecipeFile(name,type,url){
	jboxConfirm("确认删除  "+name+" ?",function(){
		jboxGet("<s:url value='/medroad/delRecipeFile'/>?visitFlow=${visit.visitFlow}&type="+type+"&url="+url,null,function(resp){
			if(resp=="${GlobalConstant.OPERATE_SUCCESSED}"){
				jboxTip(resp);
				loadDetail('${visit.visitFlow}');
			}else{
				jboxTip(resp);
			}
		},null,true);
	});
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
	         <h3>处方用药</h3>
	          <div style="border: 1px solid #ddd;border-top-width: 0px;">
	          <c:if test="${drugList.size()==1 }">
					<c:set var="preparationUnitName" value="${drugList[0].preparationUnitName }"/>
				</c:if>
	          <c:choose>
	          		<c:when test="${empty  recipeList}">
	          				<div class="frm_controls" style="padding-left: 10px;float: left;">
									<div class="dropdown_menu time" style="width: 300px;float: left;margin-top: 6px;margin-left:-3px;">
										<a href="javascript:;" class="btn dropdown_switch jsDropdownBt">
											<label class="jsBtLabel jsBtLabelSel">--选择药物--</label> <i
											class="arrow"></i>
										</a>
										<div class="dropdown_data_container jsDropdownList" 
											style="display: none;">
											<ul class="dropdown_data_list">
												<c:forEach items="${drugList}" var="drug">
													<c:forEach items="${drugLotMap[drug.drugFlow]}" var="lotCountMap">
														<li class="dropdown_data_item "><a onclick="return false;"
															href="javascript:"
															class="jsDropdownItem"
															data-value="${drug.drugFlow}_${lotCountMap.key}_${lotCountMap.value}" data-index=""
															data-name="${drug.drugFlow }">${drug.drugName}--${lotCountMap.key}(${lotCountMap.value }${preparationUnitName })</a>
														</li>
													</c:forEach>
												</c:forEach>
											</ul>
										</div>
										<input type="hidden" class="jsDropdownHidden" id="drugFlow" 	name="drugFlow" value="" />
									</div>
									<div style="float: left">&#12288;发药量：
									<div class="dropdown_menu time" style="width: 100px;">
										<a href="javascript:;" class="btn dropdown_switch jsDropdownBt">
											<label class="jsBtLabel jsBtLabelSel"></label> <i
											class="arrow"></i>
										</a>
										<div class="dropdown_data_container jsDropdownList" 
											style="display: none;">
											<ul class="dropdown_data_list">
												<c:forEach
													step="1" begin="1" end="10"
													var="count">
													<li class="dropdown_data_item "><a onclick="return false;"
														href="javascript:;"
														class="jsDropdownItem "
														data-value="${count}" data-index=""
														data-name="${count}">${count }</a>
													</li>
												</c:forEach>
											</ul>
										</div>
										<input type="hidden" class="jsDropdownHidden" id="drugAmount" 	name="drugAmount" value="" />
									</div>&#12288;<span id="drugPreparationUnitName">${preparationUnitName }</span>
									</div>
								</div>
						          				
	          		</c:when>
	          		<c:otherwise>
	          			<c:forEach items="${recipeList }" var="recipe">
	          				<c:forEach items="${recipeDrugMap[recipe.recipeFlow] }" var="recipeDrug">
	          					<p>&#12288;药物名称：${recipeDrug.drugName}&#12288;批号：${recipeDrug.lotNo }&#12288;发药量：${recipeDrug.drugAmount }&#12288;${preparationUnitName }</p>
	          				</c:forEach>
	          			</c:forEach>
	          			
	          		</c:otherwise>
	          </c:choose>
	       
	          		<textarea name="doctorExplain" class="input" placeholder="处方医嘱" style="height: 100px;width: 630px;margin-top: 5px;margin-bottom: 5px;text-indent:0">${visitInfoMap.doctorExplain }</textarea>
	          </div>
		 </div>
		 <div class="index_form" style="margin-top: 10px;margin-left: 10px;margin-right: 10px;" >
	         <h3>检查单 <i id="js_ask_keys" class="icon18_common upload_gray " onclick="$('#labExamFile').click();" style="float: right;margin-top: 10px;cursor: pointer;"></i></h3>
	          <div style="border: 1px solid #ddd;border-top-width: 0px;padding-left: 30px;">
	         		<c:choose>
	         			<c:when test="${! empty visitInfoMap.labExam }">
	         				<ul>
	         					<c:forEach items="${visitInfoMap.labExam }" var="file">
	         					<li><a href="${sysCfgMap['upload_base_url']}${fn:split(file,':')[1] }" target="_blank">${fn:split(file,':')[0] }</a>
	         						<span style="display:none;float: right;margin-right: 20px;">
										<a href="javascript:delRecipeFile('${fn:split(file,':')[0]}','labExam','${fn:split(file,':')[1] }');" style="color: gray;">删除</a>
		            				</span>
	         					</li>
	         					</c:forEach>
	         				</ul>
	         			</c:when>
	         			<c:otherwise>未上传</c:otherwise>
	         		</c:choose>
	          </div>
	          <input type="file" id="labExamFile" name="recipeFile" style="display: none" onchange="userRecipeFile('labExam')"/>
		 </div>
		 <div class="index_form" style="margin-top: 10px;margin-left: 10px;margin-right: 10px;" >
	         <h3>病理 <i id="js_ask_keys" class="icon18_common upload_gray " onclick="$('#blFile').click();" style="float: right;margin-top: 10px;cursor: pointer;"></i> </h3>
	          <div style="border: 1px solid #ddd;border-top-width: 0px;padding-left: 30px;">
	          	<c:choose>
	         			<c:when test="${! empty visitInfoMap.bl }">
	         				<ul>
	         					<c:forEach items="${visitInfoMap.bl }" var="file">
	         					<li><a href="${sysCfgMap['upload_base_url']}${fn:split(file,':')[1] }" target="_blank">${fn:split(file,':')[0] }</a>
	         						<span style="display:none;float: right;margin-right: 20px;">
										<a href="javascript:delRecipeFile('${fn:split(file,':')[0]}','bl','${fn:split(file,':')[1] }');" style="color: gray;">删除</a>
		            				</span>
	         					</li>
	         					</c:forEach>
	         				</ul>
	         			</c:when>
	         			<c:otherwise>未上传</c:otherwise>
	         		</c:choose>
	          </div>
	          <input type="file" id="blFile" name="recipeFile" style="display: none" onchange="userRecipeFile('bl')"/>
		 </div>
		 <div class="index_form" style="margin-top: 10px;margin-left: 10px;margin-right: 10px;" >
	         <h3>影像 <i id="js_ask_keys" class="icon18_common upload_gray " onclick="$('#pacsFile').click();" style="float: right;margin-top: 10px;cursor: pointer;"></i> </h3>
	          <div style="border: 1px solid #ddd;border-top-width: 0px;padding-left: 30px;">
	          	<c:choose>
	         			<c:when test="${! empty visitInfoMap.pacs }">
	         				<ul>
	         					<c:forEach items="${visitInfoMap.pacs }" var="file">
	         					<li><a href="${sysCfgMap['upload_base_url']}${fn:split(file,':')[1] }" target="_blank">${fn:split(file,':')[0] }</a>
	         						<span style="display:none;float: right;margin-right: 10px;">
										<a href="javascript:delRecipeFile('${fn:split(file,':')[0]}','pacs','${fn:split(file,':')[1] }');" style="color: gray;">删除</a>
		            				</span>
	         					</li>
	         					</c:forEach>
	         				</ul>
	         			</c:when>
	         			<c:otherwise>未上传</c:otherwise>
	         		</c:choose>
	          </div>
	          <input type="file" id="pacsFile" name="recipeFile" style="display: none" onchange="userRecipeFile('pacs')"/>
		 </div>
		 <div class="index_form" style="margin-top: 10px;margin-left: 10px;margin-right: 10px;margin-bottom: 20px;" >
	         <h3>心电图  <i id="js_ask_keys" class="icon18_common upload_gray " onclick="$('#egFile').click();" style="float: right;margin-top: 10px;cursor: pointer;"></i></h3>
	          <div style="border: 1px solid #ddd;border-top-width: 0px;padding-left: 30px;">
	          		<c:choose>
	         			<c:when test="${! empty visitInfoMap.eg }">
	         				<ul>
	         					<c:forEach items="${visitInfoMap.eg }" var="file">
	         					<li><a href="${sysCfgMap['upload_base_url']}${fn:split(file,':')[1] }" target="_blank">${fn:split(file,':')[0] }</a>
	         						<span style="display:none;float: right;margin-right: 20px;">
										<a href="javascript:delRecipeFile('${fn:split(file,':')[0]}','eg','${fn:split(file,':')[1] }');" style="color: gray;">删除</a>
		            				</span>
	         					</li>
	         					</c:forEach>
	         				</ul>
	         			</c:when>
	         			<c:otherwise>未上传</c:otherwise>
	         		</c:choose>
	          </div>
	           <input type="file" id="egFile" name="recipeFile" style="display: none" onchange="userRecipeFile('eg')"/>
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
