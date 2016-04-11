<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="true"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="echarts" value="true"/>
</jsp:include>
<script type="text/javascript">
</script>
</head>

<body>
<div class="mainright">
	<div class="content">
    <div id="main" style="background:#f4f4f4; height:200px; width:64%;display: inline-block; float:right; margin-right:1%;"></div>
    </div>
 </div>
    <script type="text/javascript">
       require(
            [
                'echarts',
                'echarts/chart/line',   // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表
                'echarts/chart/bar'
            ],
            function (ec) {
                var myChart = ec.init(document.getElementById('main'));
                var option = {
                	    tooltip : {
                	        trigger: 'axis'
                	    },
                	    legend: {
                	        data:['合同数']
                	    },
                	    toolbox: {
                	        show : true,
                	        feature : {
                	            mark : {show: true},
                	            dataView : {readOnly:false},
                	            magicType : {show: true, type: ['line', 'bar']},
                	            restore : {show: true},
                	            saveAsImage : {show: true}
                	        }
                	    },
                	    calculable : false,
                	    dataZoom : {
                	        show : true,
                	        realtime : true,
                	        start : 0,
                	        end : 15
                	    },
                	    xAxis : [
                	        {
                	            type : 'category',
                	            boundaryGap : true,
                	            data : function (){
                	                var list = [];
                	                for (var i = '${thisYear}'; i >=2001 ; i--) {
                	                    list.push(i);
                	                }
                	                return list;
                	            }()
                	        }
                	    ],
                	    yAxis : [
                	        {
                	            type : 'value'
                	        }
                	    ],
                	    series : [
                	        {
                	            name:'合同数',
                	            type:'line',
                	            data:function (){
                	                var list = [];
                	                <c:forEach items="${resultMap['yearContractList']}" var="yearContract">
                	         	    list.push("${yearContract}");
                	         	    </c:forEach>
                	                return list;
                	            }()
                	        }
                	    ]
                	};
                myChart.setOption(option);
            }
        );
       var ecConfig = require('echarts/config');
       function eConsole(param) {
           var mes = '【' + param.type + '】';
           if (typeof param.seriesIndex != 'undefined') {
               mes += '  seriesIndex : ' + param.seriesIndex;
               mes += '  dataIndex : ' + param.dataIndex;
           }
           if (param.type == 'hover') {
               document.getElementById('hover-console').innerHTML = 'Event Console : ' + mes;
           }
           else {
               document.getElementById('console').innerHTML = mes;
           }
           console.log(param);
       }
       myChart.on(ecConfig.EVENT.CLICK, eConsole);
       myChart.on(ecConfig.EVENT.DBLCLICK, eConsole);
       //myChart.on(ecConfig.EVENT.HOVER, eConsole);
       myChart.on(ecConfig.EVENT.DATA_ZOOM, eConsole);
       myChart.on(ecConfig.EVENT.LEGEND_SELECTED, eConsole);
       myChart.on(ecConfig.EVENT.MAGIC_TYPE_CHANGED, eConsole);
       myChart.on(ecConfig.EVENT.DATA_VIEW_CHANGED, eConsole);
    </script>
</body>
</html>