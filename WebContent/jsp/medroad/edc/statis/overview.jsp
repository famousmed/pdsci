<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/medroad/css/stat_overview.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/echarts/echarts.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
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
	jboxLoad("content","<s:url value='/medroad/statis/overview'/>",true);
}
function showData(){
	$("#view").removeClass("tab_select");
	$("#data").addClass("tab_select");
	jboxLoad("overviewDiv","<s:url value='/medroad/statis/overviewData'/>",true);
}
</script>
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
     <div class="inner" style="background-color:#fff">
     <div class="info_hd append_ask">
     	<h4>分析病例总数：320例</h4>
     	<div class="ext_info help" id="js_ask">
                   
        	</div>
    	</div>
       <div class="info_bd" style="height: 1800px;">
     		<div class="sub_title">年龄分布</div>
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