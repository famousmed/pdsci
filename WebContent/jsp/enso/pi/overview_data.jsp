<link rel="stylesheet" type="text/css" 	href="<s:url value='/jsp/enso/css/stat_overview.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<link rel="stylesheet" type="text/css" 	href="<s:url value='/jsp/enso/css/dropdown.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script>
	function showView() {
		$("#view").addClass("tab_select");
		$("#data").removeClass("tab_select");
		jboxLoad("content", "<s:url value='/jsp/enso/pi/overview.jsp'/>", true);
	}
	function showData() {
		$("#view").removeClass("tab_select");
		$("#data").addClass("tab_select");
		jboxLoad("content", "<s:url value='/jsp/enso/pi/overview_data.jsp'/>",
				true);
	}
	$(document).ready(function(){
		$(".jsDropdownBt").bind("click",function(){
			$(this).next(".jsDropdownList").show();
		});
		$(".jsDropdownItem").bind("click",function(){
			$(this).parents(".jsDropdownList").hide();
			$(this).parent().parent().parent().siblings(".jsDropdownBt").find(".jsBtLabel").html(($(this).html()));
		});
	});
	$(function(){
		var dropBtn = $('.jsDropdownBt');
		dropBtn.on('click',function(e){e.stopPropagation();});
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
<div class="main_hd">
	<h2>抽样分析</h2>
	<div class="title_tab" id="toptab">
		<ul>
			<li id="view" class="tab" onclick="showView();"><a>概况</a></li>
			<li id="data" class="tab_select" onclick="showData();"><a>数据明细</a></li>
		</ul>
	</div>

	<div class="main_bd user_analysis">
		<div class="wrp_overview">
			<div class="info_box drop_hd_right">

				<div class="sub_content table_wrap user_menu_sub"
					style="margin-top: 20px;">
					<div class="table_wrp">

						<div class="table_top" >
							<div id="js_table_date" style="float: left;">
								<div>
									<div class="button_group">
										<div id="js_single" style="display: block; float: left;">
											<div class="js_date_filter_drop menu_dropdown dropdown_menu"
												style="float: left; z-index: 100;">
												<a href="javascript:;"
													class="btn dropdown_switch jsDropdownBt"><label
													class="jsBtLabel">年龄</label><i class="arrow"></i></a>
												<div class=" jsDropdownList" 
													style="display:none ;position:relative;">
													<ul class="dropdown_data_list">
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="" data-index="0"
															data-name="不限">不限</a></li>

														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="7" data-index="1"
															data-name="最近7天"><18岁</a></li>
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="7" data-index="1"
															data-name="最近7天">18-65岁</a></li>
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="15" data-index="2"
															data-name="最近15天">≥65岁</a></li>
													</ul>
												</div>
											</div>
											<div class="js_date_filter_drop menu_dropdown dropdown_menu"
												style="float: left; z-index: 100;">
												<a href="javascript:;"
													class="btn dropdown_switch jsDropdownBt"><label
													class="jsBtLabel">癌种</label><i class="arrow"></i></a>
												<div class=" jsDropdownList" 
													style="display:none ;position:relative;">
													<ul class="dropdown_data_list">
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="" data-index="0"
															data-name="不限">不限</a></li>

														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="7" data-index="1"
															data-name="最近7天">肝癌</a></li>
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="7" data-index="1"
															data-name="最近7天">肺癌</a></li>
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="15" data-index="2"
															data-name="最近15天">结直肠癌</a></li>
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="15" data-index="2"
															data-name="最近15天">食道癌</a></li>
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="15" data-index="2"
															data-name="最近15天">鼻咽癌</a></li>
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="15" data-index="2"
															data-name="最近15天">其他</a></li>
													</ul>
												</div>
											</div>
											<div class="js_date_filter_drop menu_dropdown dropdown_menu"
												style="float: left; z-index: 100;">
												<a href="javascript:;"
													class="btn dropdown_switch jsDropdownBt"><label
													class="jsBtLabel">临床分期</label><i class="arrow"></i></a>
												<div class=" jsDropdownList" 
													style="display:none ;position:relative;">
													<ul class="dropdown_data_list">
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="" data-index="0"
															data-name="不限">I</a></li>

														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="7" data-index="1"
															data-name="最近7天">II</a></li>
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="7" data-index="1"
															data-name="最近7天">III</a></li>
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="15" data-index="2"
															data-name="最近15天">IV</a></li>
													</ul>
												</div>
											</div>
											
											<div class="js_date_filter_drop menu_dropdown dropdown_menu"
												style="float: left; z-index: 100;">
												<a href="javascript:;"
													class="btn dropdown_switch jsDropdownBt"><label
													class="jsBtLabel">转移部位</label><i class="arrow"></i></a>
												<div class=" jsDropdownList" 
													style="display:none ;position:relative;">
													<ul class="dropdown_data_list">
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="" data-index="0"
															data-name="不限">1</a></li>

														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="7" data-index="1"
															data-name="最近7天">2</a></li>
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="7" data-index="1"
															data-name="最近7天">大于 3个部位</a></li>
													</ul>
												</div>
											</div>
											
											<div class="js_date_filter_drop menu_dropdown dropdown_menu"
												style="float: left; z-index: 100;">
												<a href="javascript:;"
													class="btn dropdown_switch jsDropdownBt"><label
													class="jsBtLabel">合并治疗</label><i class="arrow"></i></a>
												<div class=" jsDropdownList" 
													style="display:none ;position:relative;">
													<ul class="dropdown_data_list">
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="" data-index="0"
															data-name="不限">手术</a></li>

														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="7" data-index="1"
															data-name="最近7天">放疗</a></li>
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="7" data-index="1"
															data-name="最近7天">生物治疗</a></li>
															<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="7" data-index="1"
															data-name="最近7天">其他</a></li>
													</ul>
												</div>
											</div>
											<div class="js_date_filter_drop menu_dropdown dropdown_menu"
												style="float: left; z-index: 100;">
												<a href="javascript:;"
													class="btn dropdown_switch jsDropdownBt"><label
													class="jsBtLabel">合并药物数量</label><i class="arrow"></i></a>
												<div class=" jsDropdownList" 
													style="display:none ;position:relative;">
													<ul class="dropdown_data_list">
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="" data-index="0"
															data-name="不限"><3个</a></li>

														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="7" data-index="1"
															data-name="最近7天">3-5个</a></li>
														<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="7" data-index="1"
															data-name="最近7天">6-10个</a></li>
															<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="7" data-index="1"
															data-name="最近7天">>10个</a></li>
															<li class="dropdown_data_item "><a
															onclick="return false;" href="javascript:;"
															class="jsDropdownItem" data-value="7" data-index="1"
															data-name="最近7天">>15个</a></li>
													</ul>
												</div>
											</div>
										</div>

									</div>

								</div>
							</div>


							<div class="right_box">
								<a target="_blank" id="js_download_detail"
									href="javascript:void(0);">下载表格</a> <a class="right_box_link">
									<i class="icon_msg_mini ask" id="js_table_ask"></i>
								</a>
							</div>

						</div>
						<table class="table" cellspacing="0" id="js_single_table" style="width: 100%">
							<thead class="thead" style="background: transparent">
								<tr style="border-bottom: 1px solid #e7e7eb;">
									<th class="table_cell rank_area tl" data-type="new_user">受试者编码
									</th>
									<th class="table_cell rank_area tr" data-type="new_user">年龄
									</th>
									<th class="table_cell rank_area tr" data-type="new_user">
										癌种
									</th>
									<th class="table_cell rank_area tr" data-type="cancel_user">
										临床分期
									</th>
									<th class="table_cell rank_area tr" data-type="netgain_user">
										转移部位
									</th>
									<th class="table_cell tr rank_area last_child no_extra"
										data-type="cumulate_user">合并治疗
									</th>
									<th class="table_cell tr rank_area last_child no_extra"
										data-type="cumulate_user">合并治疗药物数
									</th>
								</tr>
							</thead>
							<tbody class="tbody" id="js_detail">
								<c:forEach var="temp" begin="0" end="50" >
								<tr style="border-bottom: 1px solid #e7e7eb;">
									<td class="table_cell tl js_new_user">************${pdfn:getRandomNum(4)}</td>
									<td class="table_cell tr js_new_user">${pdfn:getRandomNum(2)}</td>
									<td class="table_cell tr js_cancel_user">
										<c:if test="${temp%5==0 }">肝癌</c:if>
										<c:if test="${temp%5==1 }">肺癌</c:if>
										<c:if test="${temp%5==2 }">结直肠癌</c:if>
										<c:if test="${temp%5==3 }">鼻咽癌</c:if>
										<c:if test="${temp%5==4 }">食道癌</c:if>
									<td class="table_cell tr js_new_user">
										<c:if test="${temp%4==0 }">I</c:if>
										<c:if test="${temp%4==1 }">IV</c:if>
										<c:if test="${temp%4==2 }">II</c:if>
										<c:if test="${temp%4==3 }">III</c:if>
									</td>
									<td class="table_cell tr js_netgain_user">
										<c:if test="${temp%3==0 }">1</c:if>
										<c:if test="${temp%3==1 }">3</c:if>
										<c:if test="${temp%3==2 }">2</c:if>
									</td>
									<td class="table_cell tr js_cumulate_user">
										<c:if test="${temp%3==0 }">手术</c:if>
										<c:if test="${temp%3==1 }">生物治疗</c:if>
										<c:if test="${temp%3==2 }">放疗</c:if>
									</td>
									<td class="table_cell tr js_cumulate_user">
										<c:if test="${temp%5==0 }"><3</c:if>
										<c:if test="${temp%5==1 }">3-5</c:if>
										<c:if test="${temp%5==2 }">6-10</c:if>
										<c:if test="${temp%5==3 }">>10</c:if>
										<c:if test="${temp%5==4 }"> >15</c:if>
									</td>
								</tr>
								
								</c:forEach>
								

							</tbody>
						</table>
					</div>
				</div>
			</div>

		</div>
	</div>

</div>
