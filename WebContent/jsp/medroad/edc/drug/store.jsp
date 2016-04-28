<link rel="stylesheet" type="text/css" 	href="<s:url value='/jsp/medroad/css/stat_overview.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/echarts/echarts.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
	function toPage(page) {
		if(page){
			$("#currentPage").val(page);			
		}
		orgList($("#currentPage").val());
	} 
	$(document).ready(function(){
		/*
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
		  */
		 var drugFlow;
		<c:forEach items="${drugList }" var="drug">
			drugFlow = '${drug.drugFlow}';
			$("#"+drugFlow+"_sumAmount").html($("#"+drugFlow+"_sumAmountHidden").val());
			$("#"+drugFlow+"_sumUseAmount").html($("#"+drugFlow+"_sumUseAmountHidden").val());
			$("#"+drugFlow+"_sumStoreAmount").html($("#"+drugFlow+"_sumStoreAmountHidden").val());
		</c:forEach>
	});
</script>
<div class="main_hd">
    <form id="recruitResultForm">
		<h2 class="underline">
			库存记录
		</h2> 
	</form>
</div>
<div class="main_bd" id="div_table_0" >
 <div class="info_bd" >
 <c:forEach items="${drugList }" var="drug">
<div class="info_box" id="" style="margin-left: 20px;margin-top: 20px;margin-right: 20px;">
            <div class="inner">
                <div class="info_hd append_ask">
                    <h4>${drug.drugName }</h4>
                    <div class="ext_info help">
                    	包装单位：${drug.minPackUnitName}
                    </div>
                </div>
                <table class="ui_trendgrid ui_trendgrid_3">
        <tbody><tr>
            <td class="first" style="height: 70px;">
                <div class="ui_trendgrid_item">
                    <div class="ui_trendgrid_chart"></div>
                    <dl>
                        <dt><b>入库记录</b></dt>
                        <dd class="ui_trendgrid_number"><strong>${empty drugInMap[drug.drugFlow]?0: drugInMap[drug.drugFlow].size() }</strong><em class="ui_trendgrid_unit"></em></dd>
                    </dl>
                </div>
            </td>
            <td>
                <div class="ui_trendgrid_item">
                    <div class="ui_trendgrid_chart"></div>
                    <dl>
                        <dt><b>入库总数</b></dt>
                        <dd class="ui_trendgrid_number"><strong id="${drug.drugFlow }_sumAmount">0</strong><em class="ui_trendgrid_unit"></em></dd>
                    </dl>
                </div>
            </td>
            <td>
                <div class="ui_trendgrid_item">
                    <div class="ui_trendgrid_chart"></div>
                    <dl>
                        <dt><b>已使用药物</b></dt>
                        <dd class="ui_trendgrid_number"><strong id="${drug.drugFlow }_sumUseAmount">0</strong><em class="ui_trendgrid_unit"></em></dd>
                    </dl>
                </div>
            </td>
            <td class="last">
                <div class="ui_trendgrid_item">
                    <div class="ui_trendgrid_chart"></div>
                    <dl>
                        <dt><b>总库存量</b></dt>
                        <dd class="ui_trendgrid_number"><strong id="${drug.drugFlow }_sumStoreAmount">60</strong><em class="ui_trendgrid_unit"></em></dd>
                    </dl>
                </div>
            </td>
        </tr>
    </tbody>
    </table>
      </div>
      <div class="inner"  style="border-top-width: 0px;border-bottom-width: 0px;">
      	<table border="0" cellpadding="0" cellspacing="0" class="grid" style="border: 0px;" >
      		<tr><td>入库时间</td>
      			<td>批号</td>
      			<td>入库数量</td>
   				<td>已使用药物</td>
   				<td>库存量</td>
      		</tr>
      		
   			<c:set var="sumAmount" value="0"/>
   			<c:set var="sumUseAmount" value="0"/>
   			<c:set var="sumStoreAmount" value="0"/>
      		<c:forEach items="${drugInMap[drug.drugFlow] }" var="in">
      			<c:set var="useAmount" value="${drugLotMap[drug.drugFlow][in.lotNo] }"/>
	      		<tr>
	      			<td>${pdfn:transDate(in.inDate) }</td>
	      			<td>${in.lotNo }</td>
	      			<td>${in.drugAmount }</td>
	      			<td>${in.drugAmount - useAmount }</td>
	      			<td>${useAmount}</td>
	      		</tr>
	      		<c:set var="sumAmount" value="${sumAmount+ in.drugAmount}"/>
	   			<c:set var="sumUseAmount" value="${sumUseAmount+ in.drugAmount - useAmount}"/>
	   			<c:set var="sumStoreAmount" value="${sumStoreAmount+ useAmount}"/>
      		</c:forEach>
      		<input type="hidden" id="${drug.drugFlow}_sumAmountHidden" value="${sumAmount}"/>
     		<input type="hidden" id="${drug.drugFlow}_sumUseAmountHidden" value="${sumUseAmount}"/>
      		<input type="hidden" id="${drug.drugFlow}_sumStoreAmountHidden" value="${sumStoreAmount}"/>
      		<c:if test="${empty drugInMap[drug.drugFlow] }">
      			<tr>
	      			<td colspan="5">无记录</td>
	      		</tr>
      		</c:if>
      	</table>
      </div>
        
    		<div class="sub_content" style="display: none">
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
       </c:forEach>       </div>
</div>
      
