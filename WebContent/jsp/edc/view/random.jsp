<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="any" uri="http://www.anychart.com" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
</jsp:include>
<script type="text/javascript" src="<s:url value='/js/echarts/echarts-all.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<link rel="stylesheet" href="<s:url value='/jsp/edc/view/org_proj.css'/>?v=${applicationScope.sysCfgMap['sys_version']}" type="text/css">
<style>
	.e-list li .mark > i {
		background: url('<s:url value='/css/skin/${skinPath}/images/label.png' />') no-repeat;
		display: inline-block;
		width: 5px;
		height: 25px;
		vertical-align: middle;
		margin-top: 12px;
	}
</style>
<script type="text/javascript">
$(document).ready(function(){
	if ("true"=="${multiOrg}") {
		showCanvas();
		showCanvas0();
	} else {
		showCanvas2();
	}
});
function showCanvas0 (){
    var myChart = echarts.init(document.getElementById('chart0')); 
    var barLabel = ["总承担病例数","入组总数"];
 
 	var totalPatientCount = 0;
 	
 	<c:forEach items="${projOrgList }" var="org">
 		totalPatientCount += parseInt("${org.patientCount}");
 	</c:forEach>
	var value = [totalPatientCount,${assignMap['assignNum']['inNum']+0}];
	   for(var i=1;i<'${maxVisit}';i++){
		   barLabel.push("第"+i+"次随访");
	   }
	<c:forEach  var="num" begin='1' end='${maxVisit}'>
	 	value.push("${visitCountMap[num]}");
 	</c:forEach>
     	option = {
     		    title : {
     		        text: '入组概况',
     		        subtext: "总承担病例数："+totalPatientCount+"  总入组例数：${assignMap['assignNum']['inNum']+0}"
     		    },
     		    tooltip : {
     		        trigger: 'axis'
     		    },
     		    toolbox: {
     		        show : true,
     		        feature : {
     		            restore : {show: true},
     		            saveAsImage : {show: true}
     		        }
     		    },
     		    calculable : true,
     		    xAxis : [
     		        {
     		        	axisLabel: {rotate: 0},
     		            type : 'category',
     		            data : barLabel
     		        }
     		    ],
     		    yAxis : [
     		        {
     		        	max:totalPatientCount+1,
     		            type : 'value'
     		        }
     		    ],
     		    series : [
     		        {
     		            name:'承担病例数',
     		            type:'bar',
     		            data:value,
     		       		itemStyle: {
		                    normal: {
		                        label : {
		                            show: true, position: 'top'
		                        }
		                    }
	                	}
     		        }
     		    ]
     		};

     // 为echarts对象加载数据 
     myChart.setOption(option); 
}
function showCanvas (){
    var myChart = echarts.init(document.getElementById('chart')); 
    var barLabel = [];
 	var planInValue = [];
 	var realInValue = [];
 	var totalPatientCount = 0;
 	var maxValue = 0;
 	<c:forEach items="${projOrgList }" var="org">
 		if (parseInt("${org.patientCount}")>maxValue) {
 			maxValue = parseInt("${org.patientCount}");
 		}
 		totalPatientCount += parseInt("${org.patientCount}");
 		barLabel.push("${applicationScope.sysOrgMap[org.orgFlow].orgName}");
 		planInValue.push("${org.patientCount}");
 		realInValue.push("${assignMap['assignNum'][org.orgFlow]+0}");
 	</c:forEach>
     	option = {
     		    title : {
     		        text: '机构入组概况',
     		        subtext: "总承担病例数："+totalPatientCount+"  总入组例数：${assignMap['assignNum']['inNum']+0}"
     		    },
     		    tooltip : {
     		        trigger: 'axis'
     		    },
     		    legend: {
     		        data:['承担病例数','入组例数']
     		    },
     		    toolbox: {
     		        show : true,
     		        feature : {
     		            restore : {show: true},
     		            saveAsImage : {show: true}
     		        }
     		    },
     		    calculable : true,
     		    xAxis : [
     		        {
     		        	axisLabel: {rotate: 10},
     		            type : 'category',
     		            data : barLabel
     		        }
     		    ],
     		    yAxis : [
     		        {
     		        	max:maxValue+1,
     		            type : 'value'
     		        }
     		    ],
     		    series : [
     		        {
     		            name:'承担病例数',
     		            type:'bar',
     		            data:planInValue,
     		       		itemStyle: {
		                    normal: {
		                        label : {
		                            show: true, position: 'top'
		                        }
		                    }
	                	}
     		        },
     		        {
     		            name:'入组例数',
     		            type:'bar',
     		            data:realInValue,
     		           	itemStyle: {
		                    normal: {
		                        label : {
		                            show: true, position: 'top'
		                        }
		                    }
	                	}
     		        }
     		    ]
     		};

     // 为echarts对象加载数据 
     myChart.setOption(option); 
}
function infoToggle(id){
	$("#"+id).toggle();
}
function showCanvas2(){
    var myChart = echarts.init(document.getElementById('chart')); 
    var lineLabel = [];
 	var lineValue = [];
 	<c:forEach items="${assignMap['inDateList'] }" var="indate">
	  	<c:set var="inDateKey" value="${projOrg.orgFlow}_${indate }"></c:set>
	  	lineLabel.push("${indate }");
	  	lineValue.push("${assignMap['assignOrgNum'][inDateKey]+0 }");
	</c:forEach>
	if (lineLabel.length==0) {
		lineLabel.push("");
	  	lineValue.push("");
	}
 	option = {
 		    title : {
 		        text: '入组随机申请记录',
 		        subtext: "承担病例数：${projOrg.patientCount}  入组例数：${assignMap['assignNum'][projOrg.orgFlow]+0}"
 		    },
 		    tooltip : {
 		        trigger: 'axis'
 		    },
 		    legend: {
 		        data:['入组例数']
 		    },
 		    toolbox: {
 		        show : true,
 		        feature : {
 		            restore : {show: true},
 		            saveAsImage : {show: true}
 		        }
 		    },
 		    calculable : true,
 		    xAxis : [
 		        {
 		            type : 'category',
 		            boundaryGap: true,
 		            data : lineLabel
 		        }
 		    ],
 		    yAxis : [
 		        {
 		            type : 'value',
 		            axisLabel : {
 		                formatter: '{value}'
 		            }
 		        }
 		    ],
 		    series : [
 		        {
 		            name:'入组例数',
 		            type:'line',
 		            data:lineValue,
 		            itemStyle: {
	                    normal: {
	                        label : {
	                            show: true, position: 'top'
	                        }
	                    }
               		}
 		        }
 		    ]
 		};
 		                    

     // 为echarts对象加载数据 
     myChart.setOption(option); 
}
</script>
</head>
  <body>
 <div class="mainright">
 <div class="content">
<div class="col-tb ps-r" > 
		<div class="col-cell j_center" style="width:100%; min-width: 440px;">
		<c:if test="${multiOrg==true }">
			<div class="group-view e-list-group" style="margin-top:10px; ">
				<div class="e-list-head" style="cursor: pointer;" onclick="infoToggle('rzgk');"><strong style="color: blue">入组概况</strong>
				
				</div>
				<div id="rzgk">
				  <div id="chart0" style="height: 320px;width:600px;;margin: 20px 0 50 0;"></div>
				</div>
			</div>	 
			</c:if>
			<div class="group-view e-list-group" style="margin-top:10px; ">
				<div class="e-list-head" style="cursor: pointer;" onclick="infoToggle('jgrzxq');"><strong style="color: blue">机构入组概况</strong>
				
				</div>
				<div id="jgrzxq">
				  <div id="chart" style="height: 320px;width:100%;margin: 20px 0 50 0;"></div>
				</div>
			</div>	 
			</div></div>
  </div>
  </div>
   </body></html>