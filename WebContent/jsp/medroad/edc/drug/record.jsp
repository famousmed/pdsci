<script type="text/javascript" src="<s:url value='/js/echarts/echarts.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/medroad/css/base.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript">
	function toPage(page) {
		if(page){
			$("#currentPage").val(page);			
		}
		record($("#currentPage").val());
	} 
</script>
<div class="main_hd">
    <form id="recruitResultForm">
		<h2 class="underline">
			使用记录
		</h2> 
	</form>
</div>
<div class="main_bd" id="div_table_0" >
 <div class="div_table">
             		<table border="0" cellpadding="0" cellspacing="0" class="grid">
               			<tr><th >序号</th>
               				<th >药物名称</th>
               				<th >药物批号</th>
               				<th >发药量</th>
               				<th>受试者编号</th>
               				<th>发药时间</th>
               			</tr>
               				
               			<c:forEach items="${recipeDrugList }" var="recipeDrug" varStatus="status">
	               			<tr>
	               				<td>${status.index+1 }</td>
	               				<td>${recipeDrug.drugName }</td>
	               				<td>${recipeDrug.lotNo }</td>
	               				<td>${recipeDrug.drugAmount }</td>
		               			<td>${recipeMap[recipeDrug.recipeFlow].patientNamePy }
		               			</td>
		               			<td>${pdfn:transDate(recipeMap[recipeDrug.recipeFlow].recipeDate) }
		               			</td>
	               			</tr>
               			</c:forEach>
               		</table>
               		
           </div>   
            <div class="page" style="padding-right: 40px;">
       	 <input id="currentPage" type="hidden" name="currentPage" />
           <c:set var="pageView" value="${pdfn:getPageView(recipeDrugList)}" scope="request"></c:set>
	  		 <pd:pagination-hbres toPage="toPage"/>	 
        </div> 		   
</div>
      
