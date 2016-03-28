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
</head>
  
<body>    

	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<div id="main" style="float:left;height:500px;width:620px;padding:0px;"></div>
				<div id="pc" style="float:right;height:500px;width:600px;padding:0px;"></div>
			</div>
		</div>
	</div>
		<%--注意 此段js只能置于此位置  否则echarts无法正常生成 --%>
		
		<script type="text/javascript">
		var curIndx = 0;
		var mapType = [ // 23个省
		               '江苏', '青海', '四川', '海南', '陕西', 
		               '甘肃', '云南', '湖南', '湖北', '黑龙江',
		               '贵州', '山东', '江西', '河南', '河北',
		               '山西', '安徽', '福建', '浙江', '广东', 
		               '吉林', '辽宁', '台湾',
		               // 5个自治区
		               '新疆', '广西', '宁夏', '内蒙古', '西藏', 
		               // 4个直辖市
		               '北京', '天津', '上海', '重庆',
		               // 2个特别行政区
		               '香港', '澳门'
		             ];
	    var pcChart;
	    var myChart;
	    var colorList;
	    require(
	        [
				'echarts',
				'echarts/chart/map'
	        ],
	        function(ec) {
	            colorList = require('zrender/tool/color').getGradientColors(
	                ['red','yellow','lightskyblue'], 10
	            );
	            myChart = ec.init(document.getElementById('main'));
	            pcChart = ec.init(document.getElementById('pc'));
	            myChart.setOption(getChinaMapChartOption());
	            window.onresize = myChart.resize;
	            var ecConfig = require('echarts/config');
	            myChart.on(ecConfig.EVENT.MAP_SELECTED, mapSelected);  
	            
	            mapSelected(true);  //初始加载江苏各地市   
	        }
	    );
	   
		function getChinaMapChartOption()
		{
			var  chinaMapChartOption = {
			title: {
	        	text : '全国34个省级行政区',
	    	},
		    tooltip : {
		        trigger: 'item'
		    },
		    series : [
		        {
		            tooltip: {
		                trigger: 'item',
		                formatter: '{b}'
		            },
		            name: '中国',
		            type: 'map',
		            mapType: 'china',
		            mapLocation: {
		                x: 'left',
		                width: 600
		            },
		            selectedMode : 'single',
		            itemStyle:{
		                normal:{label:{show:true}},
		                emphasis:{label:{show:true}}
		            },
		            data:[
		                  {name: '江苏', selected:true}
		              ]
		        }
		    	],
		      animation: false
		  };
		  return chinaMapChartOption;
	  	}
	  
	    function mapSelected(param){
	        var len = mapType.length;		   
			var mt = mapType[curIndx % len];
			var selected = param.selected;
			for (var i in selected) {
			       if (selected[i]) {
			              mt = i;
			              while (len--) {
			                 if (mapType[len] == mt) {
			                      curIndx = len;
			                 }
			              }
			             break;
			       }
			}

		    datas = eval('(' + "[{name:'南京',value:13},{name:'无锡市',value:4},{name:'徐州市',value:4},{name:'连云港市',value:1}]" + ')');
			var option = {
    		    title: {
    		        text : '江苏',       
    		    },
    		    tooltip : {
    		        trigger: 'item',
    		        //formatter: '{b}'
    		    },
    		    legend: {
    		        orient: 'vertical',
    		        x:'right',
    		        data:['系统用户数量']
    		    },
    		    dataRange: {    	 
    		        min: 0,
    		        max: 100,   //此处由于echarts的bug 默认的max最小值为100且为100的整数倍&nbsp;      
    		        color:['orange','yellow'],
    		        text:['高','低'], // 文本，默认为数值文本
    		        calculable : true
    		    },
    		    toolbox: {
    		        show : false,
    		        orient : 'vertical',
    		        x: 'right',
    		        y: 'center',
    		        feature : {
    		            mark : true,
    		            dataView : {readOnly: true},
    		            restore : true,
    		            saveAsImage : true
    		        }
    		    },
    		    series : [
    		        {
    		            name: '系统用户数量',
    		            type: 'map',
    		            mapType: 'china',
    		            selectedMode : 'single',
    		            itemStyle:{
    		                normal:{label:{show:true}},
    		                emphasis:{label:{show:true}}
    		            },
    		            data:datas
    		        }
    		    ]
    		};
			option.tooltip.formatter = '{b}：{c}';
			option.series[0].mapType = mt;
			option.title.text = mt + "-系统用户分布";
			pcChart.setOption(option, true);
	    }
	    </script>
</body>
</html>
