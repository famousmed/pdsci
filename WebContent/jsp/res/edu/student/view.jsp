<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<style type="text/css">
.col-tb {
display: table;
width: 100%;
}
.ps-r {
position: relative;
}
.col-tb>[class^="col-"], .col-tb>[class*=" col-"] {
display: table-cell;
vertical-align: top;
padding-right: 10px;
float: none;
}
.panel {
margin-bottom: 20px;
background-color: #fff;
border: 1px solid #ddd;
-webkit-box-shadow: 0 1px 1px rgba(0,0,0,.05);
box-shadow: 0 1px 1px rgba(0,0,0,.05);
}
.panel-head {
padding: 0 10px;
min-height: 38px;
background: #f9f9f9;
border-bottom: 1px solid #ddd;
}
.panel-head > h3 {
display: inline-block;
line-height: 37px;
font-size: 13px;
margin: 0;
color: inherit;
}
.panel>.list-group {
margin-bottom: 0;
}
.list-group {
padding-left: 0;
margin-bottom: 20px;
}

.panel-head+.list-group .list-group-item:first-child {
border-top-width: 0;
}
.panel>.list-group .list-group-item {
border-width: 1px 0;
border-radius: 0;
}
.list-group-item:first-child {
border-top-left-radius: 4px;
border-top-right-radius: 4px;
}
a.list-group-item {
color: #555;
}
.list-group-item {
position: relative;
display: block;
padding: 10px 15px;
margin-bottom: -1px;
border: 1px solid #ddd;
}
element.style {
width: 238px;
}
.panel-head+.list-group .list-group-item:first-child {
border-top-width: 0;
}
.panel>.list-group .list-group-item {
border-width: 1px 0;
border-radius: 0;
}
.list-group-item:first-child {
border-top-left-radius: 4px;
border-top-right-radius: 4px;
}
a.list-group-item {
color: #555;
}
.list-group-item {
position: relative;
display: block;
padding: 10px 15px;
margin-bottom: -1px;
border: 1px solid #ddd;
}
.ellipsis {
white-space: nowrap;
text-overflow: ellipsis;
overflow: hidden;
-o-text-overflow: ellipsis;
}
a {
cursor: pointer;
background: transparent;
color: #428bca;
text-decoration: none;
}
table.dataTable.no-footer {
border-color: #bebebe;
}
table.dataTable.no-footer {
border-bottom: 1px solid #111;
}
table.dataTable {
width: 100%;
margin: 0 auto;
clear: both;
border-collapse: separate;
border-spacing: 0;
}
table {
background-color: transparent;
}
table.dataTable thead th, table.dataTable thead td, table.dataTable.no-footer {
border-color: #bebebe;
}
table.dataTable thead th {
padding: 12px 10px;
}
table.dataTable thead th, table.dataTable thead td {
padding: 10px 18px;
border-bottom: 1px solid #111;
}
table.dataTable thead th, table.dataTable tfoot th {
font-weight: bold;
}
th {
text-align: left;
}
</style>
<script>
$(document).ready(function(){
	 var myChart = echarts.init(document.getElementById('studyChart')); 
     var labelTop = {
     	    normal : {
     	        label : {
     	            show : true,
     	            position : 'center',
     	            formatter : '{b}',
     	            textStyle: {
     	                baseline : 'bottom'
     	            }
     	        },
     	        labelLine : {
     	            show : false
     	        }
     	    }
     	};
     	var labelFromatter = {
     	    normal : {
     	        label : {
     	            formatter : function (a,b,c){return 100-c + '%'},
     	            textStyle: {
     	                baseline : 'center'
     	            }
     	        }
     	    },
     	}
     	var labelBottom = {
     	    normal : {
     	        color: '#ccc',
     	        label : {
     	            show : true,
     	            position : 'center'
     	        },
     	        labelLine : {
     	            show : false
     	        }
     	    },
     	    emphasis: {
     	        color: 'rgba(0,0,0,0)'
     	    }
     	};
     	var radius = [25, 28];
     	option = {
     		    tooltip : {
     		        trigger: 'item',
     		        formatter: "{b} : {c}"
     		    },
     		    toolbox: {
     		        show : true,
     		        feature : {
     		            restore : {show: true},
     		            saveAsImage : {show: true}
     		        }
     		    },
     		   
     		    series : [
     		        {
     		          
     		            type:'pie',
     		            radius : '65%',
     		            itemStyle : {
     		                normal : {
     		                    label : {
     		                        show : true
     		                    },
     		                    labelLine : {
     		                        show : true
     		                    }
     		                }
     		            },
     		            data:[
     		                {value:2, name:'未开始学习'},
     		                {value:3, name:'学习中'},
     		                {value:2, name:'已学完'}
     		            ]
     		        }
     		    ]
     		};
     		              

     // 为echarts对象加载数据 
     myChart.setOption(option); 
});
$(document).ready(function(){
	init();
});

function init(){
	$(".lidata").on("mouseenter mouseleave",function(){
		$(this).find(".showSpan,.editSpan").toggle();
	});
}

function preTrainForm(){
	var h = $('.main_fix').height();
	jboxOpen("<s:url value='/jsp/res/edu/student/preTrainForm.jsp'/>", "科室岗前培训表",700,h);
}	
</script>
</head>
<body>
	<div class="toolkit bg-f6 toolkit-lg toolkit-bar" style="border-top: solid #ccc 1px;">
		<ul class="j_e-nav-tab toolkit-list fl">
			<li class="j_mainline_link toolkit-item toolkit-item-tab j_mainline_link_task router">
			<a href="#" style="cursor: default;">学习中心</a>
			</li>
		</ul>
		<ul class="toolkit-list fr">
			<li class="toolkit-item dropdown-create create-stage fr task-tab-li"></li>
		</ul>
	</div>
	<div class="col-tb ps-r scrollwrapper" style="width: 99%;"> 
		<div class="col-cell j_center" style="width:100%; min-width: 400px;">
			<ul class=" e-list task-list" style="margin-top: 5px;">
				<li  style="position: relative;">
					<span class="mark"><i></i></span>
					<span class="j_title  ellipsis" style="padding-left: 10px;"><a href="<s:url value ='/jsp/res/edu/student/main.jsp?resultFlow=${param.resultFlow}&rotationFlow=${param.rotationFlow}&schDeptFlow=${param.schDeptFlow}'/>">课程学习</a></span>
				</li>
				<li  style="position: relative;">
					<span class="mark"><i></i></span>
					<span class="j_title  ellipsis" style="padding-left: 10px;"><a href="javascript:void();" onclick="preTrainForm();">科室岗前培训表</a></span>
				</li>
			</ul>
		</div>
		
		<div id="js_side" >
			<div class="panel" style="border: 1px solid #ddd; width: 350px;height: 300px;float: right;margin-right: 10px;margin-top: 10px;">
				<div class="panel-head"><h3>学习情况</h3></div>
				<div id="studyChart" style="height: 250px;"></div>
			</div>
			<div class="panel" style="border: 1px solid #ddd; width: 350px;float: right;margin-right: 10px;margin-top: 5px;">
				<div class="panel-head"><h3>我的课程情况</h3></div>
				<div  class="list-group">
					<span class="list-group-item  ellipsis router"  >必修课程：4&#12288;&#12288;已学完：3</span>
					<span class="list-group-item  ellipsis router" >选修课程：2&#12288;&#12288;已学完：1</span>
					<span class="list-group-item  ellipsis router"  >获得学分：15&#12288;&#12288;未获得学分：6</span>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
