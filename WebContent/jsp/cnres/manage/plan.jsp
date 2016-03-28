<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	function getPlanList(assignYear){
		planList(assignYear);
	}
	
	$(function(){
		var li = $("#${param.assignYear}");
		if(li.length>0){
			$(".tab_select").toggleClass("tab");
			$(".tab_select").toggleClass("tab_select");
			$(li).toggleClass("tab_select");
			$(li).toggleClass("tab");
		}
	});
	
	function planInfo(orgFlow) {
		var data={
				"assignYear":"${sysCfgMap['res_reg_year']}",
				"orgFlow":orgFlow
			};
		jboxPostLoad("content","<s:url value='/cnres/singup/manage/planInfo'/>?source=${param.source}",data,true);
	}
</script>

      <div class="main_hd">
        <h2>
       		 住培招录计划
        </h2>
        <div class="title_tab" id="toptab">
          <ul>
            <li class="tab_select" onclick="getPlanList('${sysCfgMap['res_reg_year']}');"><a>${sysCfgMap['res_reg_year']}</a></li>
          </ul>
        </div>
      </div>
      <div class="main_bd" id="div_table_0">
        <div class="div_table" style="padding-top: 20px;">
        	<div style="float: right;font-size: 16px;padding-bottom: 10px;">
	       	   计划招录合计：${totalNum} 
   			</div>
          <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <th style="text-align: left;padding-left: 40px;width: 120px;">基地编号</th>
              <th style="text-align: left;padding-left: 40px;">基地名称</th>
              <th style="width: 150px;">计划招录总数</th>
              <th style="width: 200px;">详情</th>
            </tr>
            <c:forEach items="${orgList}" var="org">
            <c:if test="${GlobalConstant.USER_LIST_LOCAL != param.source or org.orgFlow eq param.orgFlow }">
            	<tr>
            		<td style="text-align: left;padding-left: 40px;width: 120px;">${org.orgCode}</td>
            		<td style="text-align: left;padding-left: 40px;">${org.orgName}</td>
            		<td style="width: 150px;">${speAssignNumMap[org.orgFlow] }</td>
            		<td style="width: 200px;">
            			<a class="btn" href="javascript:void(0);" onclick="planInfo('${org.orgFlow}');">详情</a>
            		</td>
            	</tr>
            </c:if>
            </c:forEach>
            <c:if test="${empty orgList}">
            	<tr>
            		<td colspan="4">无记录</td>
            	</tr>
            </c:if>
          </table>
        </div>
      </div>
      
