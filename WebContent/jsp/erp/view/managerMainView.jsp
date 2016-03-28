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
	      <div class="khqk kh">
	        <h1>客户情况</h1>
	        <div class="content_kh">
	           <dl class="khqk_green">
	             <dt class="khzs">客户总数</dt>
	             <dd>${resultMap['allCustomer'] }</dd>
	           </dl>
	           <dl class="khqk_grey">
	             <dt class="khzs_wht">无合同的客户数量</dt>
	             <dd>${resultMap['customerHasNotContract'] }</dd>
	           </dl>
	           <dl class="khqk_grey">
	             <dt class="khzs_yht">有合同的客户数量</dt>
	             <dd>${resultMap['customerHasContract'] }</dd>
	           </dl>
	        </div>
	      </div>
	      
	       <div class="htqk kh">
	        <h1>合同情况</h1>
	        <div class="content_kh">
	           <dl>
	             <dt class="htzs">合同总数</dt>
	             <dd>${resultMap['allContract'] }</dd>
	           </dl>
	           <div class="htqk_form" id="htqk_form">图表-折线图</div>
	        </div>
	      </div>



         <div class="cwqk kh">
	        <h1>财务情况</h1>
	        <div class="content_kh">
	           <div class="cwqk_form" id="cwqk_form">图表-饼图</div>
	            <dl>
	             <dt>${thisYear }年</dt>
	             <dd>
	             <h2>${pdfn:tranNum(resultMap["thisYearMap"]["all"],4)}万</h2>
	             <p>到&nbsp;&nbsp;&nbsp;账：${pdfn:tranNum(resultMap["thisYearMap"]["already"],4)}万</p>
	             <p>未到账：${pdfn:tranNum(resultMap["thisYearMap"]["no"],4)}万</p>
	             </dd>
	           </dl>
	            <dl>
	             <dt>${lastYear }年</dt>
	             <dd>
	             <h2>${pdfn:tranNum(resultMap["lastYearMap"]["all"],4)}万</h2>
	             <p>到&nbsp;&nbsp;&nbsp;账：${pdfn:tranNum(resultMap["lastYearMap"]["already"],4)}万</p>
	             <p>未到账：${pdfn:tranNum(resultMap["lastYearMap"]["no"],4)}万</p>
	             </dd>
	           </dl>
	            <dl>
	             <dt>${beforeYear }年</dt>
	             <dd>
	             <h2>${pdfn:tranNum(resultMap["beforeYearMap"]["all"],4)}万</h2>
	             <p>到&nbsp;&nbsp;&nbsp;账：${pdfn:tranNum(resultMap["beforeYearMap"]["already"],4)}万</p>
	             <p>未到账：${pdfn:tranNum(resultMap["beforeYearMap"]["no"],4)}万</p>
	             </dd>
	           </dl>
	        </div>
	      </div>
	      
	     <div class="gzqk kh">
	        <h1>工作情况</h1>
	        <div class="content_kh">
	           <dl class="lxd">
	             <dt>未完成联系单</dt>
	             <dd>${resultMap['noCompleteContact'] }</dd>
	           </dl>
	           <dl class="pgd">
	             <dt>未完成派工单</dt>
	             <dd>${resultMap['noCompleteWork'] }</dd>
	           </dl>
	           <dl class="lxd_wsh">
	             <dt>待总经理审核的联系单</dt>
	             <dd>${resultMap['waitAuditContact'] }</dd>
	           </dl>
	        </div>
	      </div> 
	      
	     
	  </div>
	</div>
</body>
<script type="text/javascript">
require(
        [
            'echarts',
            'echarts/chart/line',   // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表
            'echarts/chart/bar'
        ],
        function (ec) {
            var myChart = ec.init(document.getElementById('htqk_form'));
            var option = {
            	    tooltip : {
            	        trigger: 'axis'
            	    },
            	    legend: {
            	        data:['合同数'],
            	        color : '#ccc'
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
            	        end : 20
            	    },
            	    xAxis : [
            	        {
            	            type : 'category',
            	            boundaryGap : true,
            	            axisLine:{
            	        		lineStyle:{
            	        			color:'#ccc'
            	        		}
            	        	},
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
            	            type : 'value',
            	            axisLine:{
            	        		lineStyle:{
            	        			color:'#ccc'
            	        		}
            	        	}
            	        }
            	    ],
            	    series : [
            	        {
            	        	itemStyle : {
            	        		normal : {
            	        			lineStyle:{
                	        			color:'#429cce'
                	        		}
            	        		}
            	        		
            	        	},
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
                    //document.getElementById('console').innerHTML = mes;
                }
                console.log(param);
            }
            myChart.setOption(option);
            myChart.on(ecConfig.EVENT.CLICK, eConsole);
            myChart.on(ecConfig.EVENT.DBLCLICK, eConsole);
            //myChart.on(ecConfig.EVENT.HOVER, eConsole);
            myChart.on(ecConfig.EVENT.DATA_ZOOM, eConsole);
            myChart.on(ecConfig.EVENT.LEGEND_SELECTED, eConsole);
            myChart.on(ecConfig.EVENT.MAGIC_TYPE_CHANGED, eConsole);
            myChart.on(ecConfig.EVENT.DATA_VIEW_CHANGED, eConsole);
        }
    );
   
  
</script>
<script type="text/javascript">
require(
        [
            'echarts',
            'echarts/chart/pie',   // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表
        ],
        function (ec) {
            var myChart = ec.init(document.getElementById('cwqk_form'));
            var labelTop = {
            	    normal : {
            	        label : {
            	            show : true,
            	            position : 'center',
            	            formatter : '{b}',
            	            textStyle: {
            	                baseline : 'bottom'
            	            },
            	            color : '#fb9e00'
            	        },
            	        labelLine : {
            	            show : false
            	        }
            	    }
            	};
            	var labelFromatter = {
            	    normal : {
            	        label : {
            	            formatter : function (a,b,c){return '${pdfn:getPercentByString(resultMap["allMap"]["already"],resultMap["allMap"]["all"])}'},
            	            textStyle: {
            	                baseline : 'top',
            	                color : 'fb9e00'
            	            }
            	        }
            	    },
            	};
            	var labelBottom = {
            	    normal : {
            	        color: '#ffe8c0',
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
            	var radius = [40, 55];
            	option = {
            	    legend: {
            	    	orient : 'vertical',
            	        x : '150',
            	        y : '80',
            	        data:[
            	            '到账','未到账'
            	        ]
            	    },
            	    title : {
            	        text: '合同总金额：'+'${pdfn:tranNum(resultMap["allMap"]["all"],4)}'+" 万元",
            	        subtext: '',
            	        x: '10',
            	        y: '10',
            	        textStyle : {
            	        	color : '#fb9e00'
            	        }
            	    },
            	    series : [
            	        {
            	            type : 'pie',
            	            center : ['30%', '50%'],
            	            radius : radius,
            	            x: '0%', // for funnel
            	            itemStyle : labelFromatter,
            	            data : [
            	                {name:'未到账', value:'${pdfn:tranNum(resultMap["allMap"]["no"],4)}', itemStyle : labelBottom},
            	                {name:'到账', value:'${pdfn:tranNum(resultMap["allMap"]["already"],4)}',itemStyle : labelTop}
            	            ]
            	        }
            	    ]
            	};
            	        
            myChart.setOption(option);
        }
    );
</script>
</html>