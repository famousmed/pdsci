 <script>
 $(document).ready(function(){
	 $(".popover .frm_radio_label").click(function(){
			if(!$(this).hasClass("selected")){
				$(this).siblings().each(function(){
					$(this).removeClass("selected");
					$(this).find("input[type='radio']").attr("checked",false);
				});
				$(this).addClass("selected");
				$(this).find("input[type='radio']").attr("checked",true);
			}
		});
		$(".popover .frm_checkbox_label").click(function(){
			if($(this).hasClass("selected")){
				$(this).find("input[type='checkbox']").attr("checked",false);
				$(this).removeClass("selected");
			}else{
				$(this).addClass("selected");
				$(this).find("input[type='checkbox']").attr("checked",true);
			}
		});
	 
	 $(".popover .jsDropdownBt").bind("click",function(){
			$(this).next(".jsDropdownList").show();
		});
		
		
		
		$(".popover .jsDropdownItem").bind("click",function(){
			$(this).parents(".jsDropdownList").hide();
			$(this).parent().parent().parent().siblings(".jsDropdownBt").find(".jsBtLabel").html(($(this).html()));
			$(this).parent().parent().parent().siblings(".jsDropdownHidden").val($(this).attr("data-value"));
		});
	 
	 
	 $(".popover .jsBtLabelSel").each(function(){
		  $(this).html($(this).parent().next("div").find("li .selected").attr("data-name"));
	  }); 
	
	  $(".popover input[type='radio']:checked").closest("label").addClass("selected");
	  $(".popover input[type='checkbox']:checked").closest("label").addClass("selected");
		
	});
 function updateData(){
	 var attrValue = "";
	 if(${attr.inputTypeId == attrInputTypeEnumRadio.id}){
		 attrValue = $(".popover input[name='${attr.attrCode}']:checked").val();
 	 }else if(${attr.inputTypeId == attrInputTypeEnumCheckbox.id}){
			$(".popover [name='${attr.attrCode}']:checked").each(function(){
				if(attrValue!=""){
					attrValue += ","+$(this).val();
				}else {
					attrValue = $(this).val();
				}
			});
 	 }else {
 		attrValue = $(".popover input[name='${attr.attrCode}']").val();
 	 }
	 
	 
	 if($(".popover [name='${attr.attrCode}_eventNote']").val()==""){
		 $(".popover .frm_err_content").html("修改原因不能为空");
		 $(".popover .frm_err_content").show();
		 return;
	 }
	 if(attrValue =='${visitData.attrValue}'){
			$(".popover .frm_err_content").html("数据未修改"); 
			$(".popover .frm_err_content").show();
			return;
	 }
	 
	 $(".popover .frm_err_content").hide();
	 jboxConfirm("确认修改?",function(){
		 var data = {
			 	 "attrCode":'${attr.attrCode}',
			 	 "recordFlow":'${visitData.visitRecordFlow}',
			 	 "visitFlow":'${visitFlow}', 
			 	 "value":attrValue,
			 	 "dataName":$(".popover ."+"${attr.attrCode}"+"_label").html(),
			 	 "elementSerialSeq":'1',
			 	 "eventNote":$(".popover [name='${attr.attrCode}_eventNote']").val()
		 };
		 jboxPost("<s:url value='/medroad/updateData'/>",data,function(){
			
			 
			 
			// alert( $("input[name='${attr.attrCode}']:checked").closest("label").attr("inputTypeId"));
			 if(${attr.inputTypeId == attrInputTypeEnumCheckbox.id}){
				 $("input[name='${attr.attrCode}']").closest("label").removeClass("selected");
				 var values = attrValue.split(",");
				 for(var i = 0; i<values.length;i++){
					 $("."+data.attrCode+"_"+values[i]+"_label").addClass("selected");
				 }
			 }else if(${attr.inputTypeId == attrInputTypeEnumRadio.id}){
			    $("input[name='${attr.attrCode}']").closest("label").removeClass("selected");
				$("."+data.attrCode+"_"+data.value+"_label").addClass("selected");
			 }else if(${attr.inputTypeId == attrInputTypeEnumSelect.id}){
				 $("."+data.attrCode+"_label").html(data.dataName);
			 }else {
				 $("input[name='${attr.attrCode}']").val(data.value);
			 }
		 },null,true);
	 });
 }
 </script>
 <div class="popover_inner" style="height:320px;">
				        <div class="popover_content">
				            <div class="loadingArea rich_buddy_loading" style="display: none;"><span class="vm_box"></span><i class="icon_loading_small white"></i></div>
								<div class="rich_user_info">
								    <div class="rich_user_info_inner">
								        <div class="global_mod float_layout gap_top">
								            <strong class="global_info gap_top_item">
								                     	数据修改
								                <span class="icon_rich_user_sex icon18_common "></span>
								            </strong>
								            
								            <div class="global_extra">
								                <a class="btn btn_default  js_popAddToBlackList"  href="javascript:updateData();">保存修改</a>
								            </div>
								            
								        </div>
								        <div class="frm_control_group ">
								       			<c:set var="commAttrCode" value="${currVisit.visitFlow }_${attr.moduleCode }_${ attr.elementCode}"></c:set>
												<c:set var="commCodeFlow" value="${commAttrCode}_${attr.attrCode}"></c:set>
								           <c:choose>
				   							<c:when test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumRadio.id or 
											  sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumCheckbox.id}">
											  <!-- 单选/复选 -->
											  	<jsp:include page="/jsp/medroad/edc/reacher/datainput_radio.jsp" flush="true">
											  		<jsp:param value="${module.moduleCode }" name="moduleCode"/>
											 		<jsp:param value="Y" name="showEleName"/>
													<jsp:param value="${element.elementName }" name="elementName"/>
													<jsp:param value="${attr.attrName}" name="attrName"/>
													<jsp:param value="${visitData.attrValue}" name="value"/>
													<jsp:param value="${attr.attrCode}" name="attrCode"/>
													<jsp:param value="${commCodeFlow}" name="commCodeFlow"/>
													<jsp:param value="${attr.attrUnit}" name="attrUnit"/>
													<jsp:param value="${attr.attrNote}" name="attrNote"/>
													<jsp:param value="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId }" name="inputTypeId"/>
												</jsp:include>
				   								
											</c:when>
											
											<c:when test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumSelect.id }">
												<!-- 下拉 -->
												<jsp:include page="/jsp/medroad/edc/reacher/datainput_select.jsp" flush="true">
													<jsp:param value="${module.moduleCode }" name="moduleCode"/>
													<jsp:param value="Y" name="showEleName"/>
													<jsp:param value="${element.elementName }" name="elementName"/>
													<jsp:param value="${attr.attrName}" name="attrName"/>
													<jsp:param value="${visitData.attrValue}" name="value"/>
													<jsp:param value="${attr.attrCode}" name="attrCode"/>
													<jsp:param value="${commCodeFlow}" name="commCodeFlow"/>
													<jsp:param value="${attr.attrUnit}" name="attrUnit"/>
													<jsp:param value="${attr.attrNote}" name="attrNote"/>
												</jsp:include>
											</c:when>
											<c:otherwise>
												<!-- 文本 -->
												<jsp:include page="/jsp/medroad/edc/reacher/datainput_text.jsp" flush="true">
													<jsp:param value="${module.moduleCode }" name="moduleCode"/>
													<jsp:param value="Y" name="showEleName"/>
													<jsp:param value="${element.elementName }" name="elementName"/>
													<jsp:param value="${attr.attrName}" name="attrName"/>
													<jsp:param value="${visitData.attrValue}" name="value"/>
													<jsp:param value="${attr.attrCode}" name="attrCode"/>
													<jsp:param value="${attr.attrUnit}" name="attrUnit"/>
													<jsp:param value="${attr.attrNote}" name="attrNote"/>
												</jsp:include>
											</c:otherwise>
											</c:choose>
							              <label for="" class="frm_label" style="margin-top: -.1em; width: 8em">
												修改原因
											</label>
							                <span class="frm_textarea_box with_counter counter_in append count" >
		       									<textarea name="${attr.attrCode }_eventNote" class="frm_textarea" style="text-indent: 0px;"></textarea>
												<span  class="frm_err_content" style="display: none;color: #e15f63"></span>
		       								</span>
		       								
								        </div>
								        </div>
								    </div>
								</div>
				
									</div>