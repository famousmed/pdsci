<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/medroad/css/stat_overview.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/echarts/echarts.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<link rel="stylesheet" type="text/css" 	href="<s:url value='/jsp/medroad/css/dropdown.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script>
$(document).ready(function(){
	var myChart = echarts.init(document.getElementById('chart1')); 
	option = {
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		   
		    legend: {
		        data: ['<18岁', '18-65岁','≥65岁']
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis:  {
		        type: 'value'
		    },
		    yAxis: {
		        type: 'category',
		        data: ['04-25'],
		    },
		    series: [
		        {
		            name: '<18岁',
		            type: 'bar',
		            stack: '总量',
		            label: {
		                normal: {
		                    show: true,
		                    position: 'insideRight'
		                }
		            },
		            itemStyle:{
		                normal:{color:'#749f83'}
		            },
		            data: [120]
		        },
		        {
		            name: '18-65岁',
		            type: 'bar',
		            stack: '总量',
		            label: {
		                normal: {
		                    show: true,
		                    position: 'insideRight'
		                }
		            },
		            itemStyle:{
		                normal:{color:'rgb(74, 144, 226)'}
		            },
		            data: [320]
		        },
		        {
		            name: '≥65岁',
		            type: 'bar',
		            stack: '总量',
		            label: {
		                normal: {
		                    show: true,
		                    position: 'insideRight'
		                }
		            },
		            itemStyle:{
		                normal:{color:'#44b549'}
		            },
		            data: [40]
		        }
		    ]
		};
	  myChart.setOption(option); 
	  
	  var myChart2 = echarts.init(document.getElementById('chart2')); 
		option2 = {
			    tooltip : {
			        trigger: 'axis',
			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
			        }
			    },
			    legend: {
			        data: ['0', '1','2']
			    },
			    grid: {
			        left: '3%',
			        right: '4%',
			        bottom: '3%',
			        containLabel: true
			    },
			    xAxis:  {
			        type: 'value'
			    },
			    yAxis: {
			        type: 'category',
			        data: ['04-25'],
			    },
			    series: [
			        {
			            name: '0',
			            type: 'bar',
			            stack: '总量',
			            label: {
			                normal: {
			                    show: true,
			                    position: 'insideRight'
			                }
			            },
			            itemStyle:{
			                normal:{color:'#749f83'}
			            },
			            data: [120]
			        },
			        {
			            name: '1',
			            type: 'bar',
			            stack: '总量',
			            label: {
			                normal: {
			                    show: true,
			                    position: 'insideRight'
			                }
			            },
			            itemStyle:{
			                normal:{color:'rgb(74, 144, 226)'}
			            },
			            data: [320]
			        },
			        {
			            name: '2',
			            type: 'bar',
			            stack: '总量',
			            label: {
			                normal: {
			                    show: true,
			                    position: 'insideRight'
			                }
			            },
			            itemStyle:{
			                normal:{color:'#44b549'}
			            },
			            data: [40]
			        }
			    ]
			};
		  myChart2.setOption(option2); 
	  
	  var myChart3 = echarts.init(document.getElementById('chart3')); 
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
			            name: '临床分期',
			            type: 'pie',
			            radius : '65%',
			            center: ['50%', '50%'],
			            data:[
			                {value:32,name:'TX'},
			                {value:28,name:'T0'},
			                {value:27,name:'Tis'},
			                {value:15,name:'NX'}
			            ],
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
	  var myChart4 = echarts.init(document.getElementById('chart4')); 
		option4 = {
			    tooltip : {
			        trigger: 'axis',
			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
			        }
			    },
			    legend: {
			        data: ['1', '2','>3']
			    },
			    grid: {
			        left: '3%',
			        right: '4%',
			        bottom: '3%',
			        containLabel: true
			    },
			    xAxis:  {
			        type: 'value'
			    },
			    yAxis: {
			        type: 'category',
			        data: ['04-25'],
			    },
			    series: [
			        {
			            name: '1',
			            type: 'bar',
			            stack: '总量',
			            label: {
			                normal: {
			                    show: true,
			                    position: 'insideRight'
			                }
			            },
			            itemStyle:{
			                normal:{color:'#d48265'}
			            },
			            data: [210]
			        },
			        {
			            name: '2',
			            type: 'bar',
			            stack: '总量',
			            label: {
			                normal: {
			                    show: true,
			                    position: 'insideRight'
			                }
			            },
			            itemStyle:{
			                normal:{color:'#2f4554'}
			            },
			            data: [120]
			        },
			        {
			            name: '>3',
			            type: 'bar',
			            stack: '总量',
			            label: {
			                normal: {
			                    show: true,
			                    position: 'insideRight'
			                }
			            },
			            data: [36]
			        }
			    ]
			};
		  myChart4.setOption(option4); 
		  
		  var myChart5 = echarts.init(document.getElementById('chart5')); 
			option5 = {
				    tooltip : {
				        trigger: 'axis',
				        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
				            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
				        }
				    },
				    legend: {
				        data: ['手术', '放疗','生物治疗','其他']
				    },
				    grid: {
				        left: '3%',
				        right: '4%',
				        bottom: '3%',
				        containLabel: true
				    },
				    xAxis:  {
				        type: 'value'
				    },
				    yAxis: {
				        type: 'category',
				        data: ['04-25'],
				    },
				    series: [
				        {
				            name: '手术',
				            type: 'bar',
				            stack: '总量',
				            label: {
				                normal: {
				                    show: true,
				                    position: 'insideRight'
				                }
				            },
				            itemStyle:{
				                normal:{color:'#749f83'}
				            },
				            data: [120]
				        },
				        {
				            name: '放疗',
				            type: 'bar',
				            stack: '总量',
				            label: {
				                normal: {
				                    show: true,
				                    position: 'insideRight'
				                }
				            },
				            itemStyle:{
				                normal:{color:'rgb(74, 144, 226)'}
				            },
				            data: [320]
				        },
				        {
				            name: '生物治疗',
				            type: 'bar',
				            stack: '总量',
				            label: {
				                normal: {
				                    show: true,
				                    position: 'insideRight'
				                }
				            },
				            itemStyle:{
				                normal:{color:'#44b549'}
				            },
				            data: [45]
				        }
				        ,
				        {
				            name: '其他',
				            type: 'bar',
				            stack: '总量',
				            label: {
				                normal: {
				                    show: true,
				                    position: 'insideRight'
				                }
				            },
				            
				            data: [20]
				        }
				    ]
				};
			  myChart5.setOption(option5); 
		  
		  var myChart6 = echarts.init(document.getElementById('chart6')); 
		  option6 = {
				    title : {
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
				    },
				    calculable : true,
				    series : [
				       
				        {
				            name:'合并药物数量',
				            type:'pie',
				            radius : [30, 110],
				            center : ['50%', '50%'],
				            roseType : 'area',
				            data:[
				                {value:32, name:'<3'},
				                {value:28, name:'3-5'},
				                {value:27, name:'6-10'},
				                {value:15, name:'>10'},
				                {value:7, name:'>15'}
				            ]
				        }
				    ]
				};

			  myChart6.setOption(option6); 
});
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
});
$(function(){
	var dropBtn = $('.jsDropdownBt');
	dropBtn.on('click',function(e){e.stopPropagation();});
	dropBtn.on('click',function(){
		$(this).find("div").stop().show();
    });
    $(document).on('click',function(){$(".jsDropdownList").hide();});
});
$(".frm_checkbox_label").click(function(){
	if($(this).hasClass("selected")){
		$(this).find("input[type='checkbox']").attr("checked",false);
		$(this).removeClass("selected");
	}else{
		if($(this).find("input[type='checkbox']").attr("name")=="chartType"){
			$("input[type='checkbox'][name='chartType']").attr("checked",false);
			$("input[type='checkbox'][name='chartType']").parent().removeClass("selected");
		}
		
		
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
          </ul>
        </div>
      </div>
    <div id="overviewDiv" class="main_bd user_analysis" >
     <div class="page_msg mini top_interval">
     <div class="wrp_overview">
     <div class="info_box">
     <div class="inner" style="background-color:#fff;padding: 0px 0px; ">
     <div class="info_hd append_ask">
     	<h4>分析病例总数：${patientDataMap.size() }例</h4>
     	<div class="ext_info help" id="js_ask">
                   
        	</div>
    	</div>
       <div class="info_bd" style="height: 1800px;">
     		<div class="sub_title" style="cursor: pointer;">年龄分布</div>
     		<div class="popover pos_left" style="left: 30px; top: 15px; display:none;" id="js_ask_trend_content">
                        <div class="popover_inner" style="padding: 20px;">
                            <div class="popover_content">
                            	<p style="margin-bottom: 5px;">图表类型：</p>
                            	<label class="vote_checkbox_label frm_checkbox_label " 
									for="" > <i class="icon_checkbox"></i> <span
									type="label_content">柱状图</span>
									<input name="chartType" type="checkbox" <c:if test="${true}">checked="checked"</c:if> value="bar" class="frm_checkbox">
								</label>
								<label class="vote_checkbox_label frm_checkbox_label " 
									for="" > <i class="icon_checkbox"></i> <span
									type="label_content">饼状图</span>
									<input name="chartType" type="checkbox" <c:if test="${true}">checked="checked"</c:if> value="pie" class="frm_checkbox">
								</label>
								<label class="vote_checkbox_label frm_checkbox_label " 
									for="" > <i class="icon_checkbox"></i> <span
									type="label_content">列表</span>
									<input name="showData" type="checkbox" <c:if test="${true}">checked="checked"</c:if> value="list" class="frm_checkbox">
								</label>
								<p style="margin-top: 10px;margin-bottom: 5px;">数据选项：</p>
								<label class="vote_checkbox_label frm_checkbox_label " 
									for="" > <i class="icon_checkbox"></i> <span
									type="label_content">范围</span>
									<input name="datatype" type="checkbox" <c:if test="${true}">checked="checked"</c:if> value="rang" class="frm_checkbox">
								</label>
								<label class="vote_checkbox_label frm_checkbox_label " 
									for="" > <i class="icon_checkbox"></i> <span
									type="label_content">记录数</span>
									<input name="datatype" type="checkbox" <c:if test="${true}">checked="checked"</c:if> value="records" class="frm_checkbox">
								</label>
                            </div>
                        </div>
                        <i class="popover_arrow popover_arrow_out">
                        </i>
                        <i class="popover_arrow popover_arrow_in">
                        </i>
                    </div>
     		<div class="sub_content">
               <div id="chart1" style="height: 150px;width: 800px;"></div>
           </div>
           <div class="sub_title">瘤种</div>
     		<div class="sub_content">
               <div >
             		<table border="0" cellpadding="0" cellspacing="0" class="grid" style="100%">
               			<tr><th width="100px;">瘤种</th><th width="100px;">个数</th><th ></th></tr>
               			<tr><td>肺癌</td><td>32</td><td><div class="ui_progress">
                                                  <div style="width:32.666666666666668%;" class="ui_progress_bar"></div>
	                                          </div></td></tr>
               			<tr><td>结直肠癌</td><td>23</td><td><div class="ui_progress">
                                                  <div style="width:23.666666666666668%;" class="ui_progress_bar"></div>
	                                          </div></td></tr>
               			<tr><td>食道癌</td><td>22</td><td><div class="ui_progress">
                                                  <div style="width:22.666666666666668%;" class="ui_progress_bar"></div>
	                                          </div></td></tr>
               			<tr><td>鼻咽癌</td><td>15</td><td><div class="ui_progress">
                                                  <div style="width:15.666666666666668%;" class="ui_progress_bar"></div>
	                                          </div></td></tr>
               			<tr><td>其他</td><td>8</td><td><div class="ui_progress">
                                                  <div style="width:8.666666666666668%;" class="ui_progress_bar"></div>
	                                          </div></td></tr>
               		</table>
               </div>
           </div>
           <div class="sub_title">临床分期</div>
     		<div class="sub_content">
     			<div id="chart3" style="height: 250px;width: 300px;float: left"></div>
       	        <div class="table_wrp line_wrp_table_phone" style="width:500px;height: 250px;">
             		<table border="0" cellpadding="0" cellspacing="0" class="grid" style="100%">
               			<tr><th width="100px;">Figo</th><th width="100px;">TNM</th><th width="100px;">Duke</th><th width="50px;"></th><th ></th></tr>
               			<tr>
               				<td>I</td><td>TX</td><td>A</td>
               				<td>32</td>
	               			<td><div class="ui_progress">
                                      <div style="width:32.666666666666668%;" class="ui_progress_bar"></div>
                               </div></td></tr>
               			<tr>
               				<td>II</td><td>T0</td><td>B</td>
               				<td>28</td>
               				<td><div class="ui_progress">
                                                  <div style="width:28.666666666666668%;" class="ui_progress_bar"></div>
	                                          </div></td></tr>
               			<tr><td>III</td><td>Tis</td><td>C</td>
               			<td>27</td>
               			<td><div class="ui_progress">
                                                  <div style="width:27.666666666666668%;" class="ui_progress_bar"></div>
	                                          </div></td></tr>
               			<tr><td>IV</td><td>NX</td><td>D</td>
               			<td>15</td>
               			<td><div class="ui_progress">
                                                  <div style="width:15.666666666666668%;" class="ui_progress_bar"></div>
	                                          </div></td></tr>
               		</table>
               </div>
           </div>
            <div class="sub_title">EOCG PS</div>
     		<div class="sub_content">
       	        <div id="chart2" style="height: 150px;width: 800px;"></div>
           </div>
            <div class="sub_title">转移部位</div>
     		<div class="sub_content">
       	       <div id="chart4" style="height: 150px;width: 800px;"></div>
           </div>
           <div class="sub_title">合并治疗</div>
     		<div class="sub_content">
       	        <div id="chart5" style="height: 150px;width: 800px;"></div>
           </div>
            <div class="sub_title">合并药物数量</div>
     		<div id="chart6" style="height: 300px;width: 400px;float: left"></div>
       	        <div class="table_wrp line_wrp_table_phone" style="width:400px;height: 250px;margin-right: 10px;">
             		<table border="0" cellpadding="0" cellspacing="0" class="grid">
               			<tr><th width="100px;">合并药物数量</th><th width="100px;"></th><th ></th></tr>
               			<tr>
               				<td><3</td>
               				<td>32</td>
	               			<td><div class="ui_progress">
                                      <div style="width:32.666666666666668%;" class="ui_progress_bar"></div>
                               </div></td></tr>
               			<tr>
               				<td>3-5</td>
               				<td>28</td>
               				<td><div class="ui_progress">
                                                  <div style="width:28.666666666666668%;" class="ui_progress_bar"></div>
	                                          </div></td></tr>
               			<tr><td>6-10</td>
               			<td>27</td>
               			<td><div class="ui_progress">
                                                  <div style="width:27.666666666666668%;" class="ui_progress_bar"></div>
	                                          </div></td></tr>
               			<tr><td>>10</td>
               			<td>15</td>
               			<td><div class="ui_progress">
                                                  <div style="width:15.666666666666668%;" class="ui_progress_bar"></div>
	                                          </div></td></tr>
                        <tr><td>>15</td>
               			<td>7</td>
               			<td><div class="ui_progress">
                                                  <div style="width:7.666666666666668%;" class="ui_progress_bar"></div>
	                                          </div></td></tr>
               		</table>
               </div>
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