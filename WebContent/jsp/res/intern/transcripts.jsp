<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_form" value="false" />
	<jsp:param name="jquery_ui_tooltip" value="true" />
	<jsp:param name="jquery_ui_combobox" value="false" />
	<jsp:param name="jquery_ui_sortable" value="false" />
	<jsp:param name="jquery_cxselect" value="true" />
	<jsp:param name="jquery_scrollTo" value="false" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="false" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
</jsp:include>
<script>
$(document).ready(function(){
	showCanvas('hxkchart',15,12,55,5,20,8);
	showCanvas('xhkchart',11,22,40,8,14,4);
	showCanvas('xxgchart',12,8,32,9,23,5);
});
</script>
<script type="text/javascript" src="<s:url value='/js/echarts/echarts-all.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
   <script type="text/javascript">
   function showCanvas (id,jxjl,glbc,sxbl,cjqj,lccz,xsjz){
	   var myChart = echarts.init(document.getElementById(id)); 
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
	     		            restore : {show: false},
	     		            saveAsImage : {show: false}
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
	     		                {value:jxjl, name:'教学记录'},
	     		                {value:glbc, name:'管理病床'},
	     		                {value:sxbl, name:'书写病历'},
	     		                {value:cjqj, name:'参加抢救'},
	     		               {value:lccz, name:'临床操作'},
	     		              {value:xsjz, name:'学术讲座'}
	     		            ]
	     		        }
	     		    ]
	     		};
	     		              

	     // 为echarts对象加载数据 
	     myChart.setOption(option); 
                }
    </script>
    <style>
    .btn-warning {
color: #fff;
background-color: #f0ad4e;
border-color: #eea236;
}
.btn {
display: inline-block;
padding: 6px 12px;
margin-bottom: 0;
font-size: 14px;
font-weight: normal;
line-height: 1.428571429;
text-align: center;
white-space: nowrap;
vertical-align: middle;
cursor: pointer;
background-image: none;
border: 1px solid transparent;
border-radius: 4px;
-webkit-user-select: none;
-moz-user-select: none;
-ms-user-select: none;
-o-user-select: none;
user-select: none;
}
    </style>
    <style>

.infoAudit{ overflow-y:scroll;padding:20px;height:505px;background:#fff;}
.infoAudit h1{ line-height:40px;  text-align:center; font-size:16px; color:#333;}
.infoAudit h2{line-height:40px; border-bottom:2px solid #44b549;padding-left:10px; color:#44b549; text-indend:10px;font-size:14px;}
table{ margin:10px 0;border-collapse: collapse;}
caption,th,td{height:40px;}
caption{line-height:40px;text-align:left;font-weight:bold; padding-left:10px; border-bottom:1px solid #ddd;color:#f60;}
th{text-align:right;font-weight:500;padding-right:5px; color:#333;}
td{text-align:left; padding-left:5px; color:#999;}
table a{ color:#00f;}
.btn{padding-left:22px; padding-right:22px;}
.blue-btn{ background:#44b549; border: 1px solid #3ea543; color:#fff;}
.blue-btn:hover{ background:#3ea543;}
.red-btn{background:#f90; border: 1px solid #f49200; color:#fff;}
.red-btn:hover{ background:#f60;}
.h-btn{background:#eee;border: 1px solid #ddd; }
.h-btn:hover{ background:#ddd;}
textarea{ width:100%; height:150px;padding:0; resize:none; outline:none;text-indent:28px; line-height:24px; font-family:'微软雅黑'; }
</style>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
			<div style="width: 400px;float: left;margin-right: 20px;">
				<table class="basic">
					<tr>
						<th colspan="6" style="text-align: left;">&#12288;实习课程成绩单</th>
					</tr>
					<tr style="font-weight: bold;">
						<td width="200px;" style="text-align: center;">课程</td>
						<td width="200px;" style="text-align: center;">成绩</td>
					</tr>

					<tr>
						<td  width="100px;" style="text-align: center;">医德医风</td>
						<td  style="text-align: center;">
							4
						</td>
					</tr>
					<tr>
						<td  width="100px;" style="text-align: center;">医学文案</td>
						<td style="text-align: center;">3</td>
					</tr>
					<tr>
						<td  width="100px;" style="text-align: center;color: red">内科诊疗技能</td>
						<td style="text-align: center;color: red">4</td>
					</tr>
					<tr>
						<td  width="100px;" style="text-align: center;">外科诊疗技能</td>
						<td style="text-align: center;">4</td>
					</tr>
					<tr>
						<td  width="100px;" style="text-align: center;">妇产科诊疗技能</td>
						<td style="text-align: center;">5</td>
					</tr>
					<tr>
						<td  width="100px;" style="text-align: center;">儿科诊疗技能</td>
						<td style="text-align: center;">3</td>
					</tr>
					<tr>
						<td  width="100px;" style="text-align: center;">传染科诊疗</td>
						<td style="text-align: center;">5</td>
					</tr>
					<tr>
						<td  width="100px;" style="text-align: center;">眼科诊疗</td>
						<td style="text-align: center;">5</td>
					</tr>
					<tr>
						<td  width="100px;" style="text-align: center;">耳鼻喉科诊疗</td>
						<td style="text-align: center;">4</td>
					</tr>
					<tr>
						<td  width="100px;" style="text-align: center;">皮肤科诊疗</td>
						<td style="text-align: center;">4</td>
					</tr>
					<tr>
						<td  width="100px;" style="text-align: center;">心电图解读</td>
						<td style="text-align: center;">4</td>
					</tr>
					<tr>
						<td  width="100px;" style="text-align: center;">X光片解读</td>
						<td style="text-align: center;">4</td>
					</tr>
					<tr>
						<td  width="100px;" style="text-align: center;">护理操作</td>
						<td style="text-align: center;">4</td>
					</tr>
					<tr>
						<td  width="100px;" style="text-align: center;">社区医疗卫生</td>
						<td style="text-align: center;">4</td>
					</tr>
					<tr>
						<td  width="100px;" style="text-align: center;">选修一</td>
						<td style="text-align: center;">4</td>
					</tr>
					<tr>
						<td  width="100px;" style="text-align: center;">选修二</td>
						<td style="text-align: center;">4</td>
					</tr>
				</table>
				</div>
				
				<div style="margin-left: 50px;margin-top: 10px;"> 
					<button type="button" class="btn btn-warning" >
					     内&#12288;科
					</button>
					<table border="0"  cellspacing="0" cellpadding="0" style="width: 60%">
						<caption>呼吸科</caption>
				     	 <tr>
							<th style="text-align: left;width: 300px;">&#12288;&#12288;实习时间：2014-03-01 至 2014-05-15</th>
							<td  rowspan="4">
								<div id="hxkchart" style="height: 180px;">
								</div>
							</td>
						</tr>
						 <tr>
							<th style="text-align: left">&#12288;&#12288;指导老师：李凯</th>
						</tr>
						 <tr>
							<th style="text-align: left">&#12288;&#12288;实习记录：98%&#12288;缺勤请假：0</th>
						</tr>
						<tr>
							<th style="text-align: left">&#12288;&#12288;出科成绩：98</th>
						</tr>
					</table>
					<table border="0"  cellspacing="0" cellpadding="0" style="width: 60%">
						<caption>消化科</caption>
				     	 <tr>
							<th style="text-align: left;width: 300px;">&#12288;&#12288;实习时间：2014-05-16 至 2014-06-15</th>
							<td  rowspan="4">
								<div id="xhkchart" style="height: 180px;">
								</div>
							</td>
						</tr>
						 <tr>
							<th style="text-align: left">&#12288;&#12288;指导老师：王飞</th>
						</tr>
						 <tr>
							<th style="text-align: left">&#12288;&#12288;实习记录：98%&#12288;缺勤请假：0</th>
						</tr>
						<tr>
							<th style="text-align: left">&#12288;&#12288;出科成绩：98</th>
						</tr>
					</table>
					<table border="0"  cellspacing="0" cellpadding="0" style="width: 60%">
						<caption>心血管</caption>
				     	 <tr>
							<th style="text-align: left;width: 300px;">&#12288;&#12288;实习时间：2014-06-16 至 2014-07-15</th>
							<td  rowspan="4">
								<div id="xxgchart" style="height: 180px;">
								</div>
							</td>
						</tr>
						 <tr>
							<th style="text-align: left">&#12288;&#12288;指导老师：王军</th>
						</tr>
						 <tr>
							<th style="text-align: left">&#12288;&#12288;实习记录：95%&#12288;缺勤请假：0</th>
						</tr>
						<tr>
							<th style="text-align: left">&#12288;&#12288;出科成绩：93</th>
						</tr>
					</table>
					
					
	</div>
			</div>
		</div>
	</div>
</body>
</html>