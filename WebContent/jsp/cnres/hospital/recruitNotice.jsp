<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	$(document).ready(function(){
		$("li").click(function(){
			$(".tab_select").addClass("tab");
			$(".tab_select").removeClass("tab_select");
			$(this).removeClass("tab");
			$(this).addClass("tab_select");
		});
	});
	
	function recruitUsers(speId,assignPlan,key){
		var data={
				"speId":speId,
				"assignPlan":assignPlan, 
				"key":key
			};
		jboxPostLoad("content","<s:url value='/cnres/singup/hospital/recruitUsers'/>",data,true);
	}
	
</script>
      	<div style="line-height: 40px;padding-top: 10px;padding-bottom: 10px;padding-left:40px;padding-right: 40px;font-size: 16px;">
			<span class="fr">
	                        计划招录人数：${totalAssignPlan}&#12288;
	                        通知复试人数：${totalRetestNum}&#12288;
	                       预录取人数：<span id="totalRetestNum" style="color: red;">${totalRecruitNum}</span>
			</span>
	   </div> 
        <div class="div_table">
          <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <th style="text-align: left;padding-left: 20px;">专业代码</th>
              <th style="text-align: left;padding-left: 20px;">专业基地名称</th>
              <th>计划招收人数</th>
              <th>填报志愿人数</th>
              <th>通知复试人数</th>
              <th>预录取人数</th>
              <th>操作</th>
            </tr>
            <c:forEach items="${doctorTrainingSpeList}" var="dict">
            <c:set var="speId" value="${dict.dictId}"></c:set>
            <c:set var="assignPlan" value="${speAssignMap[speId].assignPlan}"></c:set>
            <c:if test="${!empty assignPlan and assignPlan>0}">
	            <tr>
	            	<td style="text-align: left;padding-left: 20px;">${speId}</td>
	                <td style="text-align: left;padding-left: 20px;">${dict.dictName}</td>
	                <td>${assignPlan}</td>
	                <td>${recruitNumMap[speId] }</td>
	                <td>${retestNumMap[speId] }</td>
	                <td>${recruitYNumMap[speId] }</td>
	                <td>
		                <a class="btn" onclick="recruitUsers('${speId}','${assignPlan}');">人员名单</a>
	            	</td>
	            </tr>
            </c:if>
            </c:forEach>
          </table>
        </div>
