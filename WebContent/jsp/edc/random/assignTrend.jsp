<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="any" uri="http://www.anychart.com" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
</jsp:include>
<script type="text/javascript" src="<s:url value='/js/echarts/echarts-all.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
$(document).ready(function(){
	showCanvas();
});

function showCanvas(){
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
 		        text: '当前机构：${applicationScope.sysOrgMap[projOrg.orgFlow].orgName}',
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
     <div id="chart" style="height: 80%;width:100%;margin: 20px 0 50 0;">
     </div>
  </div>
  </div>
   </body></html>