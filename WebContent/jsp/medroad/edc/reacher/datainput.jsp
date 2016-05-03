<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/medroad/css/stat_overview.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<link rel="stylesheet" type="text/css" 	href="<s:url value='/jsp/medroad/css/dropdown.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>

<script>

$(document).ready(function(){
	if($("#elementCode").val()==''){
		$("#indexBody").scrollTo('.bd_bg',0, { offset:{ top:0} } );
	}else {
		setTimeout(function(){
			$("#indexBody").scrollTo('.'+$("#elementCode").val()+'_tbody',0, { offset:{ top:0} } );
		},500);
		
	}
	
	$(".tab_navs li").bind("click",function(){
		$(".selected").removeClass("selected");
		$(this).addClass("selected");
	});
	
	jboxEndLoading();
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
/*
function radioCheckboxClick(obj){
	if($(obj).attr("inputTypeId")=="radio"){
		if(!$(obj).hasClass("selected")){
			$(obj).siblings().each(function(){
				$(this).removeClass("selected");
				$(this).find("input[type='radio']").attr("checked",false);
			});
			$(obj).addClass("selected");
			$(obj).find("input[type='radio']").attr("checked",true);
		}
	}else if($(obj).attr("inputTypeId")=="checkbox"){
		if($(obj).hasClass("selected")){
			$(obj).find("input[type='checkbox']").attr("checked",false);
			$(obj).removeClass("selected");
		}else{
			$(obj).addClass("selected");
			$(obj).find("input[type='checkbox']").attr("checked",true);
		}
	}
}*/
function initRadioCheckbox(){
	<c:if test="${edcPatientVisit.inputOperStatusId != edcInputStatusEnumSubmit.id}">
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
	
	//初始化下拉
	$(".jsDropdownBt").bind("click",function(){
		$(this).next(".jsDropdownList").show();
	});
	</c:if>
	
	
	$(".jsDropdownItem").bind("click",function(){
		$(this).parents(".jsDropdownList").hide();
		$(this).parent().parent().parent().siblings(".jsDropdownBt").find(".jsBtLabel").html(($(this).html()));
		$(this).parent().parent().parent().siblings(".jsDropdownHidden").val($(this).attr("data-value"));
	});
	
	
	//下拉/raido/checkbox默认值
	  $(".jsBtLabelSel").each(function(){
		  $(this).html($(this).parent().next("div").find("li .selected").attr("data-name"));
	  }); 
	
	  $("input[type='radio']:checked").closest("label").addClass("selected");
	  $("input[type='checkbox']:checked").closest("label").addClass("selected");
}
$(document).ready(function(){
	initRadioCheckbox();
	
	aliveVisitSel();
});
function aliveVisitSel(){
	$("#visitSelBt").bind("click",function(){
		$(this).next(".jsDropdownList").show();
	});
}
function saveData(status){
	
	var datas =[];
	$("#inputForm input").each(function(){
		if($(this).attr("name")=="elementSerialSeq" || $(this).attr("name")=="visitDate" || $(this).attr("name")=="visitWindow" ){
			return true;
		}
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
			var attrCode = $(this).attr("name");
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
	var visitdata = "&visitDate="+$("#visitDate").val()+"&visitWindow="+$("#visitWindow").val();
	if(status == '${edcInputStatusEnumSubmit.id }'){
		if(${!isSingle}){ 
			jboxGet("<s:url value='/medroad/checkSubmit'/>",null,function(resp){
				if(resp == '${GlobalConstant.OPRE_SUCCESSED}'){
					jboxConfirm("确认提交?提交后无法修改数据",function(){
						jboxStartLoading();
						jboxPostJson("<s:url value='/medroad/saveData'/>?status="+status+"&operUserFlow=${operUserFlow}"+visitdata,JSON.stringify(datas),function(resp){
							if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
								jboxTip(resp);
								jboxEndLoading();
								datainput('${param.visitFlow}','${inputOperFlow}');
							}
						},null,true);
					});
				}else {
					jboxTip(resp);
					//$(".fail").show();
				}
			},null,true);
		}else {
			jboxConfirm("确认提交?提交后无法修改数据",function(){
				jboxStartLoading();
				jboxPostJson("<s:url value='/medroad/saveData'/>?status="+status+"&operUserFlow=${operUserFlow}"+visitdata,JSON.stringify(datas),function(resp){
					if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
						jboxTip(resp);
						jboxEndLoading();
						datainput('${param.visitFlow}','${inputOperFlow}');
					}
				},null,true);
			});
		}
	}else {
		jboxStartLoading();
		jboxPostJson("<s:url value='/medroad/saveData'/>?status="+status+"&operUserFlow=${operUserFlow}"+visitdata,JSON.stringify(datas),function(resp){
			if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
				jboxTip(resp);
				//datainput('${param.visitFlow}');
				jboxEndLoading();
			}
		},null,true);
	}
}

function addTr(elementCode){
	var currTrCount = $("#"+elementCode+"_TBODY").children().length;
	 var tr =  ($("#"+elementCode+"_TBODY tr:eq(0)").clone(true));
	 
	 //重置序号列以外的name
	  tr.find("input").each(function(){
		 $(this).attr("elementSerialSeq",currTrCount+1);
	  });
	 
	 $("#"+elementCode+"_TBODY").append(tr);
	 
	 //重置值
	 tr.find("td input[name=elementSerialSeq] :first").val(currTrCount+1);
	 tr.find("td div :first").html(currTrCount+1);
	 //tr.find("td input[name$=SerialSeq]").val(currTrCount+1);
	  
	 tr.find("td :text[attrType!='${GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}']").val("");
	 tr.find("td :checkbox[attrType!='${GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}']").attr("checked",false);
	 tr.find("td :radio[attrType!='${GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}']").attr("checked",false);
	 tr.find("td select[attrType!='${GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}']").val("");
	 
}
function delTr(elementCode){
	var seqStr  ="";
	$("#"+elementCode+"_TBODY").find("input[name=elementSerialSeq]:checked").each(function(){
		if(seqStr==""){
			seqStr+=$(this).val();
		}else {
			seqStr+=","+$(this).val();
		}
	});
	if(seqStr != ""){
		jboxConfirm("确认删除？",function () {
			jboxGet("<s:url value='/edc/input/delSerialSeqData'/>?elementCode="+elementCode+"&elementSerialSeq="+seqStr,null,function(){
				//$("#"+elementCode+"_TBODY").find("input[name=elementSerialSeq]:checked").closest("tr").remove();
				jboxLoad("div_table_0","<s:url value='/medroad/datainput'/>?visitFlow=${currVisit.visitFlow}&elementCode="+elementCode,false);
			},null);	
		});
	}else {
		jboxTip("请选择要删除的数据!");
	}
	//window.location.href="<s:url value='/edc/input/inputMain?patientFlow='/>"+patientFlow+"&visitFlow="+visitFlow+"&inputOperFlow="+currOperFlow+"&inputStatusId="+inputStatusId;
}
function scrollToModule(recordFlow){
	 $("#indexBody").scrollTo('.'+recordFlow,500, { offset:{ top:-20} } );
}
$(".to_top").click(function(){
	  $("#indexBody").scrollTo('.main_hd',500, { offset:{ top:0} } );
});
//疑问相关
$(document).ready(function(){
	
	var dropBtn = $('.ask');
	dropBtn.on('click',function(e){e.stopPropagation();});
	dropBtn.on('click',function(){
		 $(".rich_buddy").hide();
         $("."+$(this).attr("moduleCode")+"_query").css({"left":$(this).position().left+30,"top":$(this).position().top-20});
         jboxLoad($(this).attr("moduleCode")+"_query","<s:url value='/medroad/querydata'/>?visitFlow=${ param.visitFlow}&attrCode="+$(this).attr("attrCode")+"&recordFlow=${edcPatientVisit.recordFlow}",false);
         $("."+$(this).attr("moduleCode")+"_query").show();
    });
	
	var dropDiv = $('.rich_buddy');
	dropDiv.on('click',function(e){e.stopPropagation();});
	dropDiv.on('click',function(){
		$(this).find(".rich_buddy").stop().show();
    });
    $(document).on('click',function(){$(".rich_buddy").hide();});
});

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
	
		<div class="dropdown_menu time" style="width: 300px;" ><a href="javascript:;" id='visitSelBt' class="btn dropdown_switch jsDropdownBt">
			
			<label class="jsBtLabel" ><c:if test="${empty currVisit }">请选择访视</c:if>
			<c:if test="${!empty param.visitFlow }">${currVisit.visitName }</c:if>
			</label><i class="arrow"></i></a>
			<div class="dropdown_data_container jsDropdownList"  style="display: none;">
			    <ul class="dropdown_data_list">
			    		<li class="dropdown_data_item ">  
			                <a onclick="datainput('','');" href="javascript:;" class="jsDropdownItem" data-value="" data-index="0" data-name="00">&#12288;</a>
			            </li>
			    	<c:forEach items="${visitList }" var="visit" varStatus="index">
			    		  <li class="dropdown_data_item visit" >  
			                <a onclick="datainput('${visit.visitFlow}','${inputOperFlow}');" href="javascript:;" class="jsDropdownItem" data-value="${visit.visitFlow}" data-index="${index }" data-name="${visit.visitName}" >${visit.visitName}</a>
			              </li>
			    	</c:forEach>
			    </ul>
			</div>
			
		</div>
		<c:if test="${!empty edcPatientVisit }">
   		 <div class="section_tab" style="float: right;padding-right: 50px;">
	        <ul class="tab_navs">
	        	<script>
		        	$(document).ready(function(){
		        		$(".tab_nav :last").addClass("no_extra");
		        	});
	        	</script>
	        		<c:if test="${!empty edcPatientVisit.inputOper1Name}">
	                <li class="tab_nav  <c:if test="${operUserFlow == edcPatientVisit.inputOper1Flow}">selected</c:if>">
	                    <a href="javascript:datainput('${currVisit.visitFlow}','${edcPatientVisit.inputOper1Flow}');" class="js_typeSelect" type="1">录入员：${edcPatientVisit.inputOper1Name }            
	                    </a>
	                </li>
	                </c:if>
	                <c:if test="${!isSingle}">
	                 <li class="tab_nav   <c:if test="${edcPatientVisit.inputOper1Flow!=operUserFlow}">selected</c:if>" >
	                    <a href="javascript:datainput('${currVisit.visitFlow}','${!empty edcPatientVisit.inputOper2Name?edcPatientVisit.inputOper2Flow:sessionScope.currUser.userFlow}');" class="js_typeSelect" type="2">录入员：${edcPatientVisit.inputOper2Name }    
	                    </a>
	                </li>
	                </c:if>
	        </ul>
   		 </div>
   		 </c:if>
    </div>
    <form id="inputForm" name="inputForm">
    <c:if test="${!empty param.visitFlow && currVisit.isVisit == GlobalConstant.FLAG_Y && false}">
<div class="index_form visitDate" style="margin-bottom: 10px;" >
         <h3>访视窗
         </h3>
          <div  class="caseDiv" >
          	<jsp:include page="/jsp/medroad/edc/reacher/datainput_visit.jsp" ></jsp:include>
          </div>
  </div>
</c:if>
<c:if test="${empty param.visitFlow || empty sessionScope.projDescForm.visitModuleMap[currVisit.visitFlow]}">
<div class="index_form" style="margin-bottom: 10px;">
          <h3>未发现病例</h3>
          	<ul class="form_main">
		     <li>
			    <strong>无记录!</strong>
			 </li>
          </ul>
        </div>
</c:if>

<!-- 模块 -->
<c:forEach items="${sessionScope.projDescForm.visitModuleMap[currVisit.visitFlow]}" var="visitModule" varStatus="status">
 <c:set var="commCode" value="${currVisit.visitFlow }_${visitModule.moduleCode  }"></c:set>
 	<div class="index_form ${visitModule.recordFlow }" style="margin-bottom: 10px;position: relative;" >
         <h3>${visitModule.moduleName}
         	<a href="javascript:togleShow('${visitModule.moduleCode }');" id="${visitModule.moduleCode }_href" style="float: right" >收起</a>
         </h3>
         <div id="${visitModule.moduleCode }_div" class="caseDiv" style="position: relative;" > 
         			<!-- 元素 -->
        				<c:forEach items="${sessionScope.projDescForm.visitModuleElementMap[commCode]}" var="visitElement">
	         					<c:set var="elementCode" value="${visitElement.elementCode }"/>
			   					<c:set var="commAttrCode" value="${currVisit.visitFlow }_${visitModule.moduleCode }_${ elementCode}"></c:set>
			   					<!-- 单次录入 -->
			   					<c:if test="${sessionScope.projDescForm.elementMap[elementCode].elementSerial eq GlobalConstant.FLAG_N}">
				   					<!-- 属性 --> 
				   					<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode]}" var="attr" >
				   						<c:set var="value" value="${pdfn:getVisitDataNoCheck(attr.attrCode,elementSerialSeqValueMap[elementCode]['1'],operUserFlow,edcPatientVisit) }"/>
				   						<c:set var="commCodeFlow" value="${commAttrCode}_${attr.attrCode}"></c:set>
				   						 <c:set var="showEleName" value="${sessionScope.projDescForm.elementMap[elementCode].isViewName!=GlobalConstant.FLAG_N }"/>
										  <c:set var="elementName" value="${sessionScope.projDescForm.elementMap[elementCode].elementName }"/>
										  <c:set var="attrName" value="${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }"/>
										  <c:set var="attrUnit" value="${sessionScope.projDescForm.attrMap[attr.attrCode].attrUnit }"/>
										  <c:set var="attrNote" value="${sessionScope.projDescForm.attrMap[attr.attrCode].attrNote}"/>
				   						<c:choose>
				   							<c:when test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumRadio.id or 
											  sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumCheckbox.id}">
											  <!-- 单选/复选 -->
											  	<jsp:include page="/jsp/medroad/edc/reacher/datainput_radio.jsp" flush="true">
											  		<jsp:param value="${visitModule.moduleCode }" name="moduleCode"/>
											 		<jsp:param value="${showEleName }" name="showEleName"/>
													<jsp:param value="${elementName }" name="elementName"/>
													<jsp:param value="${attrName}" name="attrName"/>
													<jsp:param value="${value}" name="value"/>
													<jsp:param value="${attr.attrCode}" name="attrCode"/>
													<jsp:param value="${commCodeFlow}" name="commCodeFlow"/>
													<jsp:param value="${attrUnit}" name="attrUnit"/>
													<jsp:param value="${attrNote}" name="attrNote"/>
													<jsp:param value="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId }" name="inputTypeId"/>
												</jsp:include>
				   								
											</c:when>
											
											<c:when test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumSelect.id }">
												<!-- 下拉 -->
												<jsp:include page="/jsp/medroad/edc/reacher/datainput_select.jsp" flush="true">
													<jsp:param value="${visitModule.moduleCode }" name="moduleCode"/>
													<jsp:param value="${showEleName }" name="showEleName"/>
													<jsp:param value="${elementName }" name="elementName"/>
													<jsp:param value="${attrName}" name="attrName"/>
													<jsp:param value="${value}" name="value"/>
													<jsp:param value="${attr.attrCode}" name="attrCode"/>
													<jsp:param value="${commCodeFlow}" name="commCodeFlow"/>
													<jsp:param value="${attrUnit}" name="attrUnit"/>
													<jsp:param value="${attrNote}" name="attrNote"/>
												</jsp:include>
											</c:when>
											<c:otherwise>
												<!-- 文本 -->
												<jsp:include page="/jsp/medroad/edc/reacher/datainput_text.jsp" flush="true">
													<jsp:param value="${visitModule.moduleCode }" name="moduleCode"/>
													<jsp:param value="${showEleName }" name="showEleName"/>
													<jsp:param value="${elementName }" name="elementName"/>
													<jsp:param value="${attrName}" name="attrName"/>
													<jsp:param value="${value}" name="value"/>
													<jsp:param value="${attr.attrCode}" name="attrCode"/>
													<jsp:param value="${attrUnit}" name="attrUnit"/>
													<jsp:param value="${attrNote}" name="attrNote"/>
												</jsp:include>
											</c:otherwise>
											</c:choose>
											
				   					</c:forEach>
			   					</c:if>
			   					<!-- 多次录入 -->
			   					<c:if test="${sessionScope.projDescForm.elementMap[elementCode].elementSerial eq GlobalConstant.FLAG_Y}">
									<div class="vote_meta_detail js_vote_type vote_meta_radio">
										<table  class="grid repVertb" style="margin-bottom: 20px;">
												<tr>
													<th style="width: 80px;" class="${elementCode }_tbody"><img title="新增"
														src="<s:url value="/css/skin/${skinPath}/images/add3.png" />"
														style="cursor: pointer;" onclick="addTr('${elementCode}');" /> <img
														title="删除"
														src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>"
														onclick="delTr('${elementCode}')" style="cursor: pointer;" />
													</th>
													<th style="width: 50px;">序号</th>
													<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr">
														<th width="150px;">${sessionScope.projDescForm.attrMap[attr.attrCode].attrName}</th>
													</c:forEach>
												</tr>
												<tbody id="${elementCode }_TBODY">
												<c:set var="seqValueMap" value="${elementSerialSeqValueMap[elementCode]}"></c:set>
												<c:choose>
													<c:when test="${fn:length(elementSerialSeqValueMap[elementCode])>0}">
														<c:forEach items="${seqValueMap }" var="valueMapRecord" >
															<tr id="serialSeqTr">
																<td style="text-align: center;padding: 0;">
																<label class="vote_checkbox_label frm_checkbox_label"  
																for="" inputTypeId="checkbox"> <i class="icon_checkbox"></i> <span
																type="label_content"></span> 
																<input 	name="elementSerialSeq" value="${valueMapRecord.key }"  type="checkbox"
																 class="frm_checkbox">
															</label>
																</td>
																<td style="text-align: center;padding: 0;"><div>${valueMapRecord.key }</div></td>
																<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr"
																varStatus="status">
																<c:set var="value" value="${pdfn:getVisitData(attr.attrCode,valueMapRecord.value,operUserFlow,edcPatientVisit) }"></c:set>
																	<td>
																	<c:choose>
											  							<c:when test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumSelect.id }">
											  								<div class="dropdown_menu time" >
																				<a href="javascript:;" class="btn dropdown_switch jsDropdownBt" style="text-decoration: none;">
																					<label class="jsBtLabel jsBtLabelSel">${value }</label> <i
																					class="arrow"></i>
																				</a>
																				<div class="dropdown_data_container jsDropdownList"
																					style="display: none;">
																					<ul class="dropdown_data_list">
																						<li class="dropdown_data_item "><a onclick="return false;"  style="text-decoration: none;color: black"
																							href="javascript:;" class="jsDropdownItem" data-value=""
																							data-index="0" data-name="00">&#12288;</a></li>
																						<c:forEach
																							items="${sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}"
																							var="code">
																							<c:set var="edcAttrCode"
																								value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />
																							<li class="dropdown_data_item "><a onclick="return false;" style="text-decoration: none;color: black"
																								href="javascript:;"
																								class="jsDropdownItem <c:if test="${value==edcAttrCode.codeValue }">selected</c:if>" 
																								data-value="${edcAttrCode.codeValue }" data-index=""
																								data-name="${edcAttrCode.codeName }">${edcAttrCode.codeName}</a>
																							</li>
																						</c:forEach>
																
																					</ul>
																				</div>
																				<input type="hidden" class="jsDropdownHidden"
																					name="${attr.attrCode }" value="${value }" elementSerialSeq="${ valueMapRecord.key}" />
																			</div>
											  							</c:when>
											  							<c:otherwise>
											  							<span
																				class="frm_input_box" style="width: 100px;">
											  								<input autofocus="" type="text" placeholder=""
																					class="frm_input js_option_input frm_msg_content"
																					name="${attr.attrCode}" elementSerialSeq="${ valueMapRecord.key}" value="${value }"
																				autocomplete="off">
																				</span>
											  							</c:otherwise>
										   							</c:choose>
									   							</td>
																</c:forEach>
															</tr>
														</c:forEach>
													</c:when>
													<c:otherwise>
													<!-- 默认一条记录 -->
													<td width="50px" style="text-align: center;padding: 0;">
														<label class="vote_checkbox_label frm_checkbox_label"  
																for="" inputTypeId="checkbox"> <i class="icon_checkbox"></i> <span
																type="label_content"></span> 
																<input 	name="elementSerialSeq" value="1"  type="checkbox"
																 class="frm_checkbox">
															</label>
														<td width="50px" style="text-align: center;padding: 0;"><div>1</div></td>
														<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }"   var="attr" varStatus="status">
										   						<td>
										   							<c:choose>
											  							<c:when test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumSelect.id }">
											  								<div class="dropdown_menu time" >
																				<a href="javascript:;" class="btn dropdown_switch jsDropdownBt" style="text-decoration: none;">
																					<label class="jsBtLabel jsBtLabelSel"></label> <i
																					class="arrow"></i>
																				</a>
																				<div class="dropdown_data_container jsDropdownList"
																					style="display: none;">
																					<ul class="dropdown_data_list">
																						<li class="dropdown_data_item "><a onclick="return false;"  style="text-decoration: none;color: black"
																							href="javascript:;" class="jsDropdownItem" data-value=""
																							data-index="0" data-name="00">&#12288;</a></li>
																						<c:forEach
																							items="${sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}"
																							var="code">
																							<c:set var="edcAttrCode"
																								value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />
																							<li class="dropdown_data_item "><a onclick="return false;" style="text-decoration: none;color: black"
																								href="javascript:;"
																								class="jsDropdownItem "
																								data-value="${edcAttrCode.codeValue }" data-index=""
																								data-name="${edcAttrCode.codeName }">${edcAttrCode.codeName}</a>
																							</li>
																						</c:forEach>
																
																					</ul>
																				</div>
																				<input type="hidden" class="jsDropdownHidden"
																					name="${attr.attrCode }" value="${value }" elementSerialSeq="1" />
																			</div>
											  							</c:when>
											  							<c:otherwise>
											  							<span
																				class="frm_input_box" style="width: 100px;">
											  								<input autofocus="" type="text" placeholder=""
																					class="frm_input js_option_input frm_msg_content"
																					name="${attr.attrCode}" elementSerialSeq="1" value=""
																				autocomplete="off">
																				</span>
											  							</c:otherwise>
										   							</c:choose>
										   						</td>
											   				</c:forEach>
													</c:otherwise>
												</c:choose>
												</tbody>
										</table>	
									</div>				   						
			   					</c:if>
			   				</c:forEach>
			   				
				   			<c:if test="${empty  sessionScope.projDescForm.visitModuleElementMap[commCode]}">
								    <strong>无记录!</strong>
				   			</c:if>
		         			<!-- 疑问 -->
							<div id="${visitModule.moduleCode}_query" class="rich_buddy popover  ${visitModule.moduleCode}_query"  style="width:450px;left: 480px; top: 10px; display:none;">
							   
					        </div>
				    </div>
					         			
  </div>
 </c:forEach>
 </form>
 
</div>

<c:if test="${!empty param.visitFlow && sessionScope.projDescForm.visitModuleMap[currVisit.visitFlow].size()>0}">
	<jsp:include page="/jsp/medroad/edc/reacher/inputAssist2.jsp" ></jsp:include>
</c:if>
<input type="hidden" id="elementCode" value="${param.elementCode}"/>
</body>
</html>
