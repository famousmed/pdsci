<script type="text/javascript">
	function toPage(page) {
		if(page){
			$("#currentPage").val(page);			
		}
		orgList($("#currentPage").val());
	} 
	
</script>
<div class="main_hd">
    <form id="recruitResultForm">
		<h2 class="underline">
		<!-- 
			机构编码：<input type="text" value="${orgCode }" id="orgCode" class="select">&#12288;
		 -->
		
			机构名称：<input type="text" value="${orgName }" id="orgName" class="select" style="width: 200px;">&#12288;
			<input class=" btn_green " type="button" onclick="toPage();"  value="查询"/>
			<font style="float: right;padding-right: 30px;font-size: 14px;">入组总数：${totleCount }</font>
		</h2> 
	</form>
</div>
<div class="main_bd" id="div_table_0" >
    <div class="div_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid" style="width: 100%">
            <tr>
                <th>机构代码</th>
                <th>机构名称</th>
                <th>入组人数</th>
                 <th>发药数量</th>
                 <th>操作</th>
            </tr>
            <c:forEach items="${orgList}" var="org">
           		 <tr>
	                <td>${sysOrgMap[org.orgFlow].orgCode }</td>
	                <td>${org.orgName }</td>
	                <td>${orgPatientCountMap[org.orgFlow] }</td>
	                <td></td>
	                 <td ><a class="btn" onclick="patients('${org.orgFlow}','');">详情</a></td>
	            </tr>
            </c:forEach>
        </table>
    </div>
      <div class="page" style="padding-right: 40px;">
       	 <input id="currentPage" type="hidden" name="currentPage"  />
          <c:set var="pageView" value="${pdfn:getPageView(orgList)}" scope="request"></c:set>
  		 <pd:pagination-hbres toPage="toPage"/>	 
       </div>
</div>
      
