<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/enso/css/stat_overview.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<link rel="stylesheet" type="text/css" 	href="<s:url value='/jsp/enso/css/dropdown.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script>

$(document).ready(function(){
	$(".tab_navs li").bind("click",function(){
		$(".selected").removeClass("selected");
		$(this).addClass("selected");
	});
	
	jboxEndLoading();
});
$(document).ready(function(){
	$(".jsDropdownBt").bind("click",function(){
		$(this).next(".jsDropdownList").show();
	});
	$(".jsDropdownItem").bind("click",function(){
		$(this).parents(".jsDropdownList").hide();
		$(this).parent().parent().parent().siblings(".jsDropdownBt").find(".jsBtLabel").html(($(this).html()));
		$(this).parent().parent().parent().siblings(".jsDropdownHidden").val($(this).attr("data-value"));
	});
	
	
});

$(function(){
	var dropBtn = $('.jsDropdownBt');
	dropBtn.on('click',function(e){e.stopPropagation();});
	dropBtn.on('click',function(){
		$(this).find("div").stop().show();
    });
    $(document).on('click',function(){$(".jsDropdownList").hide();});
});
function togleShow(moduleCode){
	if($("#"+moduleCode+"_div").is(":visible")==true){
		$("#"+moduleCode+"_href").text("编辑");
		$("#"+moduleCode+"_div").hide();
	}else {
		$("#"+moduleCode+"_href").text("收起");
		$("#"+moduleCode+"_div").show();
	}
}
$(document).ready(function(){
	$(".frm_radio_label").click(function(){
		if(!$(this).hasClass("selected")){
			$(this).siblings().each(function(){
				$(this).removeClass("selected");
				$(this).find("input[type='radio']").attr("checked",false);
			});
			$(this).addClass("selected");
			$(this).find("input[type='radio']").attr("checked",true);
		}
	});
	$(".frm_checkbox_label").click(function(){
		if($(this).hasClass("selected")){
			$(this).find("input[type='checkbox']").attr("checked",false);
			$(this).removeClass("selected");
		}else{
			$(this).addClass("selected");
			$(this).find("input[type='checkbox']").attr("checked",true);
		}
	});
	
  $("#to_top").click(function(){
	  $("#indexBody").scrollTo('.content_main',500, { offset:{ top:0} } );
  });
  //下拉/raido/checkbox默认值
	  $(".jsBtLabelSel").each(function(){
		  $(this).html($(this).parent().next("div").find("li .selected").attr("data-name"));
	  }); 
  
	  $("input[type='radio']:checked").closest("label").addClass("selected");
	  $("input[type='checkbox']:checked").closest("label").addClass("selected");
  
});
function saveData(status){
	var datas =[];
	$("#inputForm input").each(function(){
		if($(this).attr("type") == "radio" ){
			if($(this).attr("checked")=="checked"){
				var data ={
						attrCode:$(this).attr("name"),
						attrValue: $(this).val(),
						elementSerialSeq:$(this).attr("elementSerialSeq")
					};
					datas.push(data);
			}
		}else if($(this).attr("type") == "checkbox" ){
			var attrValue = "";
			$("[name='"+attrCode+"']").each(function(){
				if($(this).attr("checked")=="checked"){
					if(attrValue!=""){
						attrValue += ","+$(this).val();
					}else {
						attrValue = $(this).val();
					}
		        }
			});
			var data ={
				attrCode:$(this).attr("name"),
				attrValue: attrValue,
				elementSerialSeq:$(this).attr("elementSerialSeq")
			};
			datas.push(data);
		}else {
			var data ={
				attrCode:$(this).attr("name"),
				attrValue: $(this).val(),
				elementSerialSeq:$(this).attr("elementSerialSeq")
			};
			datas.push(data);
		}
	});
	
	jboxStartLoading();
	jboxPostJson("<s:url value='/enso/saveData'/>?visitFlow=${param.visitFlow}&status="+status,JSON.stringify(datas),function(resp){
		if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
			jboxTip(resp);
			datainput('${param.visitFlow}');
		}
	},null,true);
}

</script>
<style>
.btn_primary {
    background-color: #44b549;
    background-image: -moz-linear-gradient(top,#44b549 0,#44b549 100%);
    background-image: -webkit-gradient(linear,0 0,0 100%,from(#44b549),to(#44b549));
    background-image: -webkit-linear-gradient(top,#44b549 0,#44b549 100%);
    background-image: -o-linear-gradient(top,#44b549 0,#44b549 100%);
    background-image: linear-gradient(to bottom,#44b549 0,#44b549 100%);
    border-color: #44b549;
    color: #fff;
}
.caseDiv{
    line-height: 40px;
    border: 1px solid #e7e7e7;
    border-top: 0;
    padding: 0 20px;
    position: relative;
}

</style>
</head>
<body>
<div class="content_main">
	<div class="section_tab_wrap" style="margin-bottom: 20px;" >
	<!-- 
		<label>受试者编号：*****3031&#12288;</label>
	 -->
		<div class="dropdown_menu time" style="width: 300px;"><a href="javascript:;" class="btn dropdown_switch jsDropdownBt">
			
			<label class="jsBtLabel" ><c:if test="${empty param.visitFlow }">请选择访视</c:if>
			<c:if test="${!empty param.visitFlow }">${visit.visitName }</c:if>
			</label><i class="arrow"></i></a>
			<div class="dropdown_data_container jsDropdownList" style="display: none;">
			    <ul class="dropdown_data_list">
			    		<li class="dropdown_data_item ">  
			                <a onclick="datainput('');" href="javascript:;" class="jsDropdownItem" data-value="" data-index="0" data-name="00">&#12288;</a>
			            </li>
			    	<c:forEach items="${visitList }" var="visit" varStatus="index">
			    		  <li class="dropdown_data_item visit" >  
			                <a onclick="datainput('${visit.visitFlow}');" href="javascript:;" class="jsDropdownItem" data-value="${visit.visitFlow}" data-index="${index }" data-name="${visit.visitName}" >${visit.visitName}</a>
			              </li>
			    	</c:forEach>
			    </ul>
			</div>
		</div>
		<c:if test="${!empty edcPatientVisit }">
   		 <div class="section_tab" style="float: right;padding-right: 20px;">
	        <ul class="tab_navs">
	        		<c:if test="${!empty edcPatientVisit.inputOper1Name}">
	                <li class="tab_nav selected">
	                    <a href="javascript:void(0);" class="js_typeSelect" type="1">录入员：${edcPatientVisit.inputOper1Name }             
	                    </a>
	                </li>
	                </c:if>
	                <c:if test="${!empty edcPatientVisit.inputOper2Name}">
	                 <li class="tab_nav no_extra  " >
	                    <a href="javascript:void(0);" class="js_typeSelect" type="2">录入员：${edcPatientVisit.inputOper2Name }    
	                    </a>
	                </li>
	                </c:if>
	        </ul>
   		 </div>
   		 </c:if>
    </div>
<c:if test="${empty param.visitFlow }">
<div class="index_form" style="margin-bottom: 10px;">
          <h3>未发现病例</h3>
          	<ul class="form_main">
		     <li>
			    <strong>无记录!</strong>
			 </li>
          </ul>
        </div>
</c:if>
<form id="inputForm" name="inputForm">
<c:forEach items="${sessionScope.projDescForm.visitModuleMap[visit.visitFlow]}" var="visitModule" varStatus="status">
 <c:set var="commCode" value="${visit.visitFlow }_${visitModule.moduleCode  }"></c:set>
 	<div class="index_form ${visitModule.recordFlow }" style="margin-bottom: 10px;" >
         <h3>${visitModule.moduleName}
         	<a href="javascript:togleShow('${visitModule.moduleCode }');" id="${visitModule.moduleCode }_href" style="float: right" >收起</a>
         </h3>
         <div id="${visitModule.moduleCode }_div" class="caseDiv" >
	         				<c:forEach items="${sessionScope.projDescForm.visitModuleElementMap[commCode]}" var="visitElement">
			   					<c:set var="commAttrCode" value="${visit.visitFlow }_${visitModule.moduleCode }_${ visitElement.elementCode}"></c:set>
			   					<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode]}" var="attr" >
			   						<c:set var="value" value="${pdfn:getVisitData(attr.attrCode,elementSerialSeqValueMap[visitElement.elementCode]['1'],inputOperFlow,edcPatientVisit) }"></c:set>
			   						<c:set var="commCodeFlow" value="${commAttrCode}_${attr.attrCode}"></c:set>
			   						<c:choose>
			   							<c:when test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumRadio.id or 
										  sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumCheckbox.id}">
										  <c:set var="inputTypeId" value="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId }" />
			   								<div class="vote_meta_detail js_vote_type vote_meta_radio">
												<div class="frm_control_group">
													<label for="" class="frm_label" style="margin-top: -.3em;width: 8em">
													${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementName }.
													${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }</label>
													<div class="frm_controls vote_meta_radio">
														<c:forEach items="${sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">
														<c:set var="edcAttrCode" value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />
														
														<label class="vote_${inputTypeId }_label frm_${inputTypeId }_label" for="">
															<i class="icon_${inputTypeId }"></i>
															<span type="label_content">${edcAttrCode.codeName}</span>
															<input name="${attr.attrCode }" elementSerialSeq="1"  type="${inputTypeId }" 
															<c:if test="${fn:indexOf(value,edcAttrCode.codeValue)>-1 }">checked="checked"</c:if>
															value="${edcAttrCode.codeValue }" class="frm_${inputTypeId }" >
														</label>
														<!-- 
														<label class="frm_checkbox_label" for="">
															<i class="icon_checkbox"></i>
															<span type="label_content">${edcAttrCode.codeName}</span>
															<input type="checkbox"  class="frm_checkbox" value="${edcAttrCode.codeValue }" >
														</label>
														 -->
														</c:forEach>
													</div>
												</div>	
											</div>
										</c:when>
										<c:when test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumSelect.id }">
											<div class="vote_meta_detail" style="padding-top: 10px;">
												<div class="frm_control_group">
													<label for="" class="frm_label" style="margin-top: -.3em;width: 8em">
													${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementName }.
													${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }</label>
													<div class="frm_controls">
														<div class="dropdown_menu time" style="width: 300px;">
															<a href="javascript:;" class="btn dropdown_switch jsDropdownBt">
																<label class="jsBtLabel jsBtLabelSel" >${value}</label>
																<i class="arrow"></i>
															</a>
															<div class="dropdown_data_container jsDropdownList"  style="display: none;">
															    <ul class="dropdown_data_list">
															    		<li class="dropdown_data_item ">  
															                <a onclick="return false;" href="javascript:;" class="jsDropdownItem" data-value="" data-index="0" data-name="00">&#12288;</a>
															            </li>
															    		<c:forEach items="${sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">
															    		<c:set var="edcAttrCode" value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />
															    		  <li class="dropdown_data_item " >  
																                <a onclick="return false;" href="javascript:;" class="jsDropdownItem <c:if test="${value==edcAttrCode.codeValue }">selected</c:if>" data-value="${edcAttrCode.codeValue }" data-index="" data-name="${edcAttrCode.codeName }" >${edcAttrCode.codeName}</a>
																          </li>
															    		</c:forEach>
														               
															    </ul>
															</div>
															<input type="hidden" class="jsDropdownHidden" name="${attr.attrCode }" value="${value }" elementSerialSeq="1"/>
														</div>
														<p class="frm_msg fail" style="display: none"><span for="${attr.attrCode}_1" class="frm_msg_content" style="display: inline;">错误描述</span></p><span class="frm_tips"></span>
														
													</div>
												</div>
											</div>
										</c:when>
										<c:otherwise>
											<div class="vote_meta_detail" style="padding-top: 10px;">
												<div class="frm_control_group">
													<label for="" class="frm_label" style="margin-top: -.3em;width: 8em">
													${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementName }.
													${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }</label>
													<div class="frm_controls">
														<span class="frm_input_box with_counter counter_in append vote_title js_question_title count">
															<input autofocus="" type="text" placeholder=""  class="frm_input js_option_input frm_msg_content" name="${attr.attrCode}" elementSerialSeq="1" value="${value }" autocomplete="off">
															<em class="frm_input_append frm_counter"></em>
														</span>
														<p class="frm_msg fail" style="display: none"><span for="${attr.attrCode}" class="frm_msg_content" style="display: inline;">错误描述</span></p><span class="frm_tips"></span>
													</div>
												</div>
											</div>
										</c:otherwise>
										</c:choose>
										
			   					</c:forEach>
			   				</c:forEach>
			   				
				   			<c:if test="${empty  sessionScope.projDescForm.visitModuleElementMap[commCode]}">
								    <strong>无记录!</strong>
				   			</c:if>
	         			</div>
  </div>
 </c:forEach>
 </form>
</div>
<c:if test="${!empty param.visitFlow }">
	<jsp:include page="/jsp/enso/reacher/inputAssist.jsp" ></jsp:include>
</c:if>
</body>
</html>
