<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	function confirmUserList(speId, assignPlan, recruitCount, confirmCount, key){
		var data={
				"speId":speId,
				"assignPlan":assignPlan,
				"key":key
			};
		jboxPostLoad("content","<s:url value='/cnres/singup/hospital/confirmUserList'/>?assignPlanCount=${assignPlanCount}&recruitCount="+recruitCount+"&confirmCount="+confirmCount, data, true);
	}
</script>
      	<div style="line-height: 40px;padding-top: 10px;padding-bottom: 10px;padding-left:40px;padding-right: 40px;font-size: 16px;">
			<span  class="fr">
				计划招录人数：${assignPlanCount}&#12288;
				预录取人数：${recruitCount}&#12288;
				确认录取人数：<span style="color: red;">${confirmCount}</span>
			</span>
	   </div> 
        <div class="div_table">
          <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <th style="text-align: left;padding-left: 20px;">专业代码</th>
              <th style="text-align: left;padding-left: 20px;">专业基地名称</th>
              <th>计划招收人数</th>
              <th>预录取人数</th>
              <th>确认录取人数</th>
              <th>操作</th>
            </tr>
            <c:forEach items="${doctorTrainingSpeList}" var="dict">
            	<c:set var="speId" value="${dict.dictId}"/>
            	<c:set var="assignPlan" value="${assignPlanMap[speId].assignPlan}"/>
            	<c:if test="${!empty assignPlan and assignPlan > 0}">
	            <tr>
	            	<td style="text-align: left;padding-left: 20px;">${speId}</td>
	                <td style="text-align: left;padding-left: 20px;">${dict.dictName}</td>
	                <td>${assignPlan}</td>
	                <td>${recruitCountMap[speId]}</td>
	                <td>${confirmCountMap[speId]}</td>
	                <td>
		                <a class="btn" onclick="confirmUserList('${speId}','${assignPlan}','${recruitCountMap[speId]}','${confirmCountMap[speId]}');">人员名单</a>
	            	</td>
	            </tr>
	            </c:if>
            </c:forEach>
          </table>
        </div>
