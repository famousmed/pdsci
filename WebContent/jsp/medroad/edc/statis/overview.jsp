<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/medroad/css/stat_overview.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/echarts/echarts.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<link rel="stylesheet" type="text/css" 	href="<s:url value='/jsp/medroad/css/dropdown.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script>
var chartData ;
var colors = ['#749f83','#44b549','rgb(74, 144, 226)'];
$(document).ready(function(){
	chartData = {
		charts:[
			<c:forEach items="${observationCfgFormMap }" var="map" varStatus='status'>
			 	{
			 		attrCode:'${map.key}',
			 		name:'${map.value.elementName }',
			 		sum:'${attrGroupCountMap[map.key]['SUM']}',
			 		titleData:getTitleData('${map.key}'),
			 		piedata:[
			 		     <c:forEach items="${attrCodeMap[map.key]}" var="codeMap" varStatus='status2'> 
			                {value:'${empty attrGroupCountMap[map.key][codeMap.key] ?0:attrGroupCountMap[map.key][codeMap.key]}',name:'${codeMap.value}'}
			                <c:if test="${!status2.last}">,</c:if>
			            </c:forEach>
		 		      ]
			 		,
			 		bardata:[
			 		     <c:forEach items="${attrCodeMap[map.key]}" var="codeMap" varStatus='status2'> 
				 		    {
			 		            name: '${codeMap.value}',
			 		            type: 'bar',
			 		            stack: 'sum',
			 		            label: {
			 		                normal: {
			 		                    show: true,
			 		                    position: 'insideRight'
			 		                }
			 		            },
			 		           itemStyle:{
					                normal:{color:colors[${status2.index}]}
					            },
			 		            data: [${empty attrGroupCountMap[map.key][codeMap.key] ?0:attrGroupCountMap[map.key][codeMap.key]}]
			 		        }
			                <c:if test="${!status2.last}">,</c:if>
			            </c:forEach>
		 		      ]
			 		
				}
			 	<c:if test="${!status.last}">,</c:if>
			</c:forEach>
		]
	}
});
function getChartDataByAttrCode(attrCode){
	for(var i=0;i<chartData.charts.length;i++){
		if(chartData.charts[i].attrCode == attrCode){
			return chartData.charts[i];
		}
	}
}
function getTitleData(attrCode){
	var titleData = [];
	  <c:forEach items="${attrCodeMap}" var="map" varStatus='status'> 
	  	if('${map.key}'==attrCode){
	  	  <c:forEach items="${map.value}" var="codeMap" varStatus='status'> 
	  			titleData.push('${codeMap.value}');
	  	  </c:forEach>
	  	}
	  </c:forEach>
	  return titleData;
}



$(document).ready(function(){
	<c:forEach items="${observationCfgFormMap }" var="map">
		<c:choose>
			<c:when test="${map.value.chartType=='Pie'}">
				getPieChart('${map.key}');
			</c:when>
			<c:when test="${map.value.chartType=='Bar'}">
				getBarChart('${map.key}');
			</c:when>
			<c:otherwise>
				getPieChart('${map.key}');
			</c:otherwise>
		</c:choose>
	</c:forEach>
});
function getBarChart(attrCode){
	$("#list_"+attrCode).hide();
	var data = getChartDataByAttrCode(attrCode);
	$("#chart_"+attrCode).css({height:150,width:800});
	var myChart = echarts.init(document.getElementById('chart_'+attrCode)); 
	option = {
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		   
		    legend: {
		        data: data.titleData
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis:  {
		        type: 'value',
		        boundaryGap: [0, '100%']
		    },
		    yAxis: {
		        type: 'category',
		        data: ['合计：'+data.sum],
		    },
		    series:data.bardata
		};
	  myChart.setOption(option); 
}
function getPieChart(attrCode){
	$("#list_"+attrCode).show();
	var data = getChartDataByAttrCode(attrCode);
	$("#chart_"+attrCode).css({height: 250,width: 300,float: 'left'});
	 var myChart3 = echarts.init(document.getElementById("chart_"+attrCode)); 
	  option3 = {
			    title : {
			        x:'center'
			    },
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    legend: {
			        orient: 'vertical',
			        left: 'left'
			    },
			    series : [
			        {
			            name: data.name,
			            type: 'pie',
			            radius : '65%',
			            center: ['50%', '50%'],
			            data:data.piedata,
			            label:{
			            	normal:{
			            		show :true,
			            		
			            		formatter :'{b}: {d}%'
			            	}
			            },
			            itemStyle: {
			                emphasis: {
			                    shadowBlur: 10,
			                    shadowOffsetX: 0,
			                    shadowColor: 'rgba(0, 0, 0, 0.5)'
			                }
			            }
			        }
			    ]
			};
	  myChart3.setOption(option3); 
}
function showView(){
	$("#view").addClass("tab_select");
	$("#data").removeClass("tab_select");
	//jboxLoad("content","<s:url value='/medroad/statis/overview'/>",true);
	$("#dataDetail").hide();
	$("#overviewDiv").show();
}
function showData(){
	$("#view").removeClass("tab_select");
	$("#data").addClass("tab_select");
	//jboxLoad("overviewDiv","<s:url value='/medroad/statis/overviewData'/>",true);
	
	$("#dataDetail").show();
	$("#overviewDiv").hide();
}
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
	
	 $("input[type='radio']:checked").closest("label").addClass("selected");
	 $("input[type='checkbox']:checked").closest("label").addClass("selected");
});
$(function(){
	var dropBtn = $('.jsDropdownBt');
	dropBtn.on('click',function(e){e.stopPropagation();});
	dropBtn.on('click',function(){
		$(this).find("div").stop().show();
    });
    $(document).on('click',function(){$(".jsDropdownList").hide();});
});

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

$(".sub_title").click(function(){
	$(".popover").hide();
	$(this).next(".popover").show();
});
$(function(){
	var dropBtn = $('.sub_title');
	dropBtn.on('click',function(e){e.stopPropagation();});
	dropBtn.on('click',function(){
		$(this).next(".popover").show();
    });
    $(document).on('click',function(){$(".popover").hide();});
    
    var dropDiv = $('.popover');
	dropDiv.on('click',function(e){e.stopPropagation();});
	dropDiv.on('click',function(){
		$(this).show();
    });
    
});
function test(){
	jboxLoad("overviewDiv","<s:url value='/jsp/medroad/edc/statis/sample.jsp'/>");
}
function saveChartType(attrCode,chartType){
	jboxGet("<s:url value='/medroad/statis/saveChartType'/>?attrCode="+attrCode+"&chartType="+chartType,null,function(resp){
		if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
			//刷新图片
			if(chartType=="Pie"){
				getPieChart(attrCode);
			}else {
				getBarChart(attrCode);
			}
		}
	},null,false);
}
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
            <li id="view" class="tab_select" onclick="showView();"><a>概况</a></li>
            <li id="data" class="'tab'" onclick="showData();"><a>数据明细</a></li>
            <!-- 
            <li id="data" class="'tab'" onclick="test();"><a>数据明细</a></li>
             -->
          </ul>
        </div>
      </div>
    <div id="overviewDiv" class="main_bd user_analysis" style="position: relative;">
     <div class="page_msg mini top_interval">
     <div class="wrp_overview">
     <div class="info_box">
     <div class="inner" style="background-color:#fff;padding: 0px 0px; ">
     <div class="info_hd append_ask">
     	<h4>分析病例总数：${patientDataMap.size() }例</h4>
     	<div class="ext_info help" id="js_ask">
                   
        	</div>
    	</div>
       <div class="info_bd" >
       	<c:forEach items="${observationCfgFormMap }" var="map">
     		<div class="sub_title" style="cursor: pointer;">${map.value.elementName }</div>
     		<div class="popover pos_left" style="left: 10px;  display:none;" id="js_ask_trend_content">
                        <div class="popover_inner" style="padding: 20px;">
                            <div class="popover_content">
                            	<p style="margin-bottom: 5px;">图表类型：</p>
                            	<label class="vote_radio_label frm_radio_label " onclick="saveChartType('${map.key}','Bar');"
									for="" > <i class="icon_radio"></i> <span
									type="label_content">柱状图</span>
									<input name="chartType_${map.key }" type="radio" <c:if test="${map.value.chartType=='Bar'}">checked="checked"</c:if> value="Bar" class="frm_radio">
								</label>
								<label class="vote_radio_label frm_radio_label " onclick="saveChartType('${map.key}','Pie');"
									for="" > <i class="icon_radio"></i> <span
									type="label_content">饼状图</span>
									<input name="chartType_${map.key }" type="radio" <c:if test="${map.value.chartType=='Pie'}">checked="checked"</c:if> value="Pie" class="frm_radio">
								</label>
								<!-- 
								<label class="vote_checkbox_label frm_checkbox_label " 
									for="" > <i class="icon_checkbox"></i> <span
									type="label_content">列表</span>
									<input name="showData" type="checkbox" <c:if test="${true}">checked="checked"</c:if> value="list" class="frm_checkbox">
								</label>
								 -->
								
								<p style="margin-top: 10px;margin-bottom: 5px;">数据选项：</p>
								<label class="vote_checkbox_label frm_checkbox_label " 
									for="" > <i class="icon_checkbox"></i> <span
									type="label_content">范围&#12288;</span>
									<input name="datatype" type="checkbox"  value="rang" class="frm_checkbox">
								</label>
								<label class="vote_checkbox_label frm_checkbox_label " 
									for="" > <i class="icon_checkbox"></i> <span
									type="label_content">记录数</span>
									<input name="datatype" type="checkbox"  value="records" class="frm_checkbox">
								</label>
                            </div>
                        </div>
                        <i class="popover_arrow popover_arrow_out">
                        </i>
                        <i class="popover_arrow popover_arrow_in">
                        </i>
                    </div>
		     		<div class="sub_content" style="height: 260px;">
			               <div id="chart_${map.key }" style="height: 250px;width: 300px;"></div>
			             
			            <div id="list_${map.key }" class="table_wrp line_wrp_table_phone" style="width:500px;height: 250px;display:none">
			            
			             		<table border="0" cellpadding="0" cellspacing="0" class="grid" style="100%">
               			<tr><th width="100px;">${map.value.elementName}</th><th width="100px;">个数</th><th ></th></tr>
               			 <c:forEach	items="${attrCodeMap[map.key]}" var="codeMap">
               			<tr><td>${codeMap.value }</td><td>${attrGroupCountMap[map.key][codeMap.key] }</td><td><div class="ui_progress">
                                                  <div style="width:${attrGroupCountMap[map.key][codeMap.key] / attrGroupCountMap[map.key]['SUM']*100}%;" class="ui_progress_bar"></div>
	                                          </div></td></tr>
                        </c:forEach>
               		</table>
			              	 </div>
			              
        			  </div>
           </c:forEach>
           
     </div>
       
      </div>
      </div>
      </div>
      </div>
   </div>
   <div class="wrp_overview" id="dataDetail" style="display: none">
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
								<c:forEach items="${patientDataMap }" var="dataMap">
								<tr style="border-bottom: 1px solid #e7e7eb;">
									<td class="table_cell tl js_new_user">${pdfn:encryptIdNo(patientMap[dataMap.key].patientCode,4)} </td>
									<c:forEach items="${observationCfgFormMap }" var="map">
									<c:set var="val" value="${dataMap.value[map.value.attrCode].attrValue}"/>
										<td class="table_cell tr js_new_user" attr-code='${map.value.attrCode}'>${!empty attrCodeMap[map.key] ?attrCodeMap[map.key][val]:val}</td>
									</c:forEach>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>