<script type="text/javascript" src="<s:url value='/js/echarts/echarts.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/enso/css/base.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript">
	function toPage(page) {
		if(page){
			$("#currentPage").val(page);			
		}
		orgList($("#currentPage").val());
	} 
	$(document).ready(function(){
		var myChart = echarts.init(document.getElementById('chart1')); 
		option = {
			    tooltip : {
			        formatter: "{a} <br/>{b} : {c}%"
			    },
			    series: [
			        {
			            name: '药品使用量',
			            type: 'gauge',
			            detail: {formatter:'{value}%'},
			            data: [{value: 60, name: '已使用药物'}]
			        }
			    ]
			};
		  myChart.setOption(option); 
	});
</script>
<div class="main_hd">
    <form id="recruitResultForm">
		<h2 class="underline">
			药品管理
		</h2> 
	</form>
</div>
<div class="main_bd" id="div_table_0" >
 <div class="info_bd" >
    		<div class="sub_content">
              <div id="chart1" style="height: 500px;width: 400px;float: left;margin-top: -40px;"></div>
               <div class="" style="margin-left: 10px;margin-top: 40px;float: left;margin-bottom: 20px;">
               <div style="margin-bottom: 10px;">
               <span class="msg_icon_wrp"> <i class="icon_msg_mini info" style="height: 10px;float: left"></i>药品总数：30&#12288;&#12288;
               已发药：18(60%)&#12288;&#12288;剩余库存：12&#12288;&#12288;预警线:24(80%)</span>
            </div>
             		<table border="0" cellpadding="0" cellspacing="0" class="grid">
               			<tr><th width="50px;">序号</th><th width="100px;">药品编号</th><th width="100px;">库存量</th><th width="100px;">状态</th><th>受试者编号</th><th>发药时间</th></tr>
               			<c:forEach begin="1" end="30" var="temp" varStatus="status">
               			<tr style="color:<c:if  test="${status.index>18 }">red</c:if>" >
               				<td>${status.index }</td><td>0100${status.index }</td><td>1</td>
               				<td>${status.index<=18?'已发药':'未发药' }</td>
	               			<td>${status.index<=18?pdfn:getRandomNum(4):'' }</td>
	               			<td>
	               			<c:if  test="${status.index<=18 }">03-${0+status.index }</c:if>
	               			<c:if  test="${status.index<=18 }"></c:if>
	               			</td>
	               			</tr>
               			</c:forEach>
               		</table>
               		
               		   
               </div>
          </div>
       </div>
</div>
      
