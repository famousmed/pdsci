<link rel="stylesheet" type="text/css" 	href="<s:url value='/jsp/medroad/css/dropdown.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script>
$(document).ready(function(){
	$(".jsDropdownBt").bind("click",function(){
		$(".jsDropdownList").hide();
		$(this).next(".jsDropdownList").show();
	});
	$(".jsDropdownItem").bind("click",function(){
		$(this).parents(".jsDropdownList").hide();
		$(this).parent().parent().parent().siblings(".jsDropdownBt").find(".jsBtLabel").html(($(this).html()));
		
		
		//过滤
		$("#js_detail tr").each(function(){
			var isShow = true;
			$(this).find("td").each(function(){
				var attrCode = $(this).attr("attr-code");
				var attrValue = $(this).html();
				
				var filterValue = $(".jsBtLabel[attr-code='"+attrCode+"']").html();
				var originalName = $(".jsBtLabel[attr-code='"+attrCode+"']").attr("original-name");
				
				if(filterValue!=attrValue && filterValue!=originalName){
					isShow = false;
					return false;
				}else {
					isShow = true;
					return true;
				}
			});
			if(isShow){
				$(this).show();
			}else {
				$(this).hide();
			}
		});
	});
	
	$("#js_clear_filter").bind("click",function(){
		$(".jsBtLabel").each(function(){
			$(this).html($(this).attr("original-name"));
		});
		
		$("#js_detail tr").show();
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

</script>
<style>
.dropdown_switch .arrow {
	position: absolute;
	right: 10px;
	top: 50%;
	margin-top: -2.5px;
	display: inline-block;
	width: 0;
	height: 0;
	border-width: 5px;
	border-style: dashed;
	border-color: transparent;
	border-bottom-width: 0;
	border-top-color: #c6c6c6;
	border-top-style: solid;
}
</style>

		<div class="wrp_overview">
			<div class="info_box drop_hd_right" style="margin-bottom: 0px;border-bottom: 0px;">
				<div class="inner" id="js_actions">
				<div class="sub_menu menu_sub_menu" style="position: relative">
									<div class="button_group">
										<div id="js_single" style="display: block; float: left;">
										<c:forEach items="${observationCfgFormMap }" var="map">
										 <c:if	test="${!empty attrCodeMap[map.key]}">
											<div class="js_date_filter_drop menu_dropdown dropdown_menu"
												style="float: left; z-index: 100;">
												<a href="javascript:;"
													class="btn dropdown_switch jsDropdownBt"><label
													class="jsBtLabel" attr-code='${map.value.attrCode}' original-name='${ map.value.elementName}'>${map.value.elementName }</label><i class="arrow"></i></a>
												<div class=" jsDropdownList" 
													style="display:none ;position:relative;">
													<ul class="dropdown_data_list" style="border-right: 0px;">
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="" data-index="0"
															data-name="">${map.value.elementName }</a></li>
													 <c:set var="commCodeFlow" value="${commAttrCode}_${map.key}"></c:set>
													 <c:forEach	items="${attrCodeMap[map.key]}" var="codeMap">
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="${codeMap.key}" data-index="1"
															data-name="${map.value.attrCode}">${codeMap.value}</a></li>
													</c:forEach>
													</ul>
												</div>
											</div>
											</c:if>
											</c:forEach>
										</div>
									</div>
									<div class="right_box">
								<a target="_blank" id="js_download_detail" 
									href="javascript:void(0);">下载表格</a> 
									
									<a class="right_box_link">
									<i class="icon16_common reply_blue" id="js_clear_filter" style="margin-top: 15px;" title="清空"></i>
								</a>
									
							</div>
								</div>
							</div>
						</div>
						<table class="table" cellspacing="0" id="js_single_table" style="width: 100%;border-top: none;">
							<thead class="thead" style="background: transparent">
								<tr style="border-bottom: 1px solid #e7e7eb;">
									<th class="table_cell rank_area tl" data-type="new_user">受试者编码
									</th>
									<c:forEach items="${observationCfgFormMap }" var="map">
										<th class="table_cell rank_area tr" data-type="new_user">${map.value.elementName }
										</th>
										</c:forEach>
								</tr>
							</thead>
							<tbody class="tbody" id="js_detail">
								<c:forEach items="${patientDataMap }" var="patientMap">
								<tr style="border-bottom: 1px solid #e7e7eb;">
									<td class="table_cell tl js_new_user">${patientMap.key }</td>
									<c:forEach items="${observationCfgFormMap }" var="map">
									<c:set var="val" value="${patientMap.value[map.value.attrCode].attrValue}"/>
										<td class="table_cell tr js_new_user" attr-code='${map.value.attrCode}'>${!empty attrCodeMap[map.key] ?attrCodeMap[map.key][val]:val}</td>
									</c:forEach>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>

		</div>
