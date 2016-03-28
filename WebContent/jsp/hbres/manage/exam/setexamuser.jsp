<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
	<jsp:param name="font" value="true"/>
	<jsp:param name="echarts" value="true"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/hbres/css/exam.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script src="<s:url value='/js/echarts/echarts.js'/>"></script>
<script type="text/javascript">
function createPieChart(ec){
	var piechart = ec.init(document.getElementById('piechart'));
	piechart.showLoading({"text":"图表正在加载数据..."});
	var pieLabel = [];
	var pieValue = [];
	jboxGet("<s:url value='/hbres/singup/exam/test'/>", null , function(resp){
    	$.each(resp , function(i,p){
    		pieLabel[i]=p['name'];
    		pieValue[i]={"value":p['value'],"name":p['name']};
    	});
    	piechart.hideLoading();
    	
    	var pieoption = {
    		    title : {
    		        text: '考点学生分布',
    		        subtext: '饼状图',
    		        x:'center'
    		    },
    		    tooltip : {
    		        trigger: 'item',
    		        formatter: "{a} <br/>{b} : {c} ({d}%)"
    		    },
    		    legend: {
    		        orient : 'vertical',
    		        x : 'left',
    		        data:pieLabel
    		    },
    		    calculable : true,
    		    series : [
    		        {
    		            name:'考点',
    		            type:'pie',
    		            radius : '55%',
    		            center: ['50%', '60%'],
    		            itemStyle:{
    		            	normal:{
    		            		label:{
    		            			show:true,
    		            			formatter:'{b} : {c} ({d}%)'
    		            		},
    		            		labelLine:{show:true}
    		            	}
    		            },
    		            data:pieValue
    		        }
    		    ]
    		};
    	piechart.setOption(pieoption);
    } , null , false);
	
}

function createBarChart(ec){
	var barchart = ec.init(document.getElementById('barchart'));
	barchart.showLoading({"text":"图表正在加载数据..."});
	var barLabel = [];
	var barValue = [];
	jboxGet("<s:url value='/hbres/singup/exam/test'/>", null , function(resp){
    	$.each(resp , function(i,p){
    		barLabel[i]=p['name'];
    		barValue[i]=p['value'];
    	});
    	barchart.hideLoading();
    	var baroption = {
    	        tooltip: {
    	            show: true
    	        },
    	        legend: {
    	            data:['人数']
    	        },
    	        xAxis : [
    	            {
    	                type : 'category',
    	                data : barLabel
    	            }
    	        ],
    	        yAxis : [
    	            {
    	                type : 'value'
    	            }
    	        ],
    	        series : [
    	            {
    	                "name":"人数",
    	                "type":"bar",
    	                "data":barValue,
    	                itemStyle: {
    	                    normal: {
    	                        label : {
    	                            show: true, position: 'insideTop'
    	                        }
    	                    }
    	                }
    	            }
    	        ],
    	        grid:{
    	        	x:40,
    	        	y:40,
    	        	x2:20,
    	        	y2:40
    	        }
    	    };
    	barchart.setOption(baroption);
    	$("#barchart").hide();
    } , null , false);
}

function creatChart(ec){
	createPieChart(ec);
	createBarChart(ec);
}
// 使用
require(
    [
        'echarts',
        'echarts/chart/pie',
        'echarts/chart/bar',
    ],
    creatChart
);



$(function(){
	
	$("#qiehuan").toggle(function(){
		$('#piechart').hide();
		$('#barchart').show();
	},function(){
		$('#piechart').show();
		$('#barchart').hide();
	});
	
});

</script>
      <div class="main_hd">
        <h2>考试管理
       <span class="tips">当前考试：${sessionScope.currExam.examName}</span>
       </h2>
         <jsp:include page="./nvtab.jsp">
             <jsp:param value="2" name="tabIndex"/>
         </jsp:include>
      </div>
      
      <div class="main_bd" id="div_table_0" >
       <div class="div_search">
        <div class="news_boxin exam_user">
          <h4>参考人员确认:</h4>
          <div class="boxin">
          <ul class="fl">
            <li><%-- ${sysCfgMap['res_reg_year']}年 --%>已审核报名人员数：<strong>${regNum}</strong>人</li>
            <li><%-- ${sysCfgMap['res_reg_year']}年 --%>已加入考试人员数：<strong>${examUserNum}</strong>人</li>
            <li><%-- ${sysCfgMap['res_reg_year']}年 --%>未加入考试人员数：<span id="surplusUserNum"><strong>${surplusUserNum}</strong></span>人</li>
          </ul>
          <c:if test='${sessionScope.currExam.examStatusId eq examStatusEnumArrange.id}'>
           <div class="tool_bar fr">
               <input type="button" class="btn_green" style=" width:100px;" value="加入考试" onclick="submitSetExamUser();"></input>
           </div>
           <script>
               function submitSetExamUser(){
            	   if(! (parseInt($("#surplusUserNum").text())>0)){
            		   jboxTip("暂无要设置的学员");
            		   return;
            	   }
            	   jboxConfirm("确认设置？",function(){
            		   var url = "<s:url value='/hbres/singup/exam/submitsetexamuser'/>";
            		   jboxStartLoading();
                	   jboxPost(url , null , function(resp){
                		   jboxEndLoading();
                		   if(resp=="1"){
                			   examRoomManage();
                		   }else{
                			   jboxTip(resp);
                		   }
                	   }, null , false);
            	   });
            	  
               }
           </script>
           </c:if>
          </div>
        </div>
       </div> 
       
       <div class="news_boxin chart"  style="margin: 0 40px;" >
          <h4>
          <span class="fl">参考人员分布:</span>
          <input class="fr btn_green change" type="button" id="qiehuan" value="切换"/>
          </h4>
          <div>
            <div id="piechart" style="height: 350px; margin:0 20px;"></div>
            <div id="barchart" style="height: 350px;"></div>
          </div>
        </div>
        
      </div>
        
      
