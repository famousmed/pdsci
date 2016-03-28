<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	$(document).ready(function(){
	});
	function gradeInput(currentPage){
		if(!currentPage){
			currentPage = 1;
		}
		var url = "<s:url value='/hbres/singup/hospital/gradeinput'/>?currentPage="+currentPage;
		jboxPostLoad("div_table_0", url, $("#gradeInputForm").serialize(), true);
	}
	
	function recruitUsers(speId , graduatedId , key , batchOper){
		var data={
				"speId":speId,
				"graduatedId":graduatedId,
				"key":key,
				"batchOper":batchOper
			};
		jboxPostLoad("content","<s:url value='/hbres/singup/hospital/getdoctors'/>",data,true);
	}
</script>
<div class="main_hd">
	<h2 class="underline">招录管理</h2>
</div>
<div id="docCountInfo" class="search_table" style="margin-bottom:0;margin-top:20px;">
    <span class="tip_right"><em>●</em>计划招录人数：<strong>${totalAssignPlan}</strong>人</span>
    <span class="tip_right"><em>●</em>填报人数：<strong>${totalFillNum}</strong>人</span>
    <!-- 
    <span class="tip_right"><em>●</em>通知复试人数：<strong>${totalRetestNum}</strong>人</span>
    <span class="tip_right"><em>●</em>预录取人数：<strong>${totalRecruitNum}</strong>人</span>
     -->
    <span class="tip_right"><em>●</em>确认录取人数：<strong>${totalConfirmCount}</strong>人</span>
    <span><a href="<s:url value='/hbres/singup/hospital/exportdoctor'/>" class="btn_green">导出填报学员</a></span>
</div>
<div class="main_bd" id="div_table_0" >
        <div class="div_table">
          <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <th style="text-align: left;padding-left: 20px;">专业代码</th>
              <th style="text-align: left;padding-left: 20px;">专业基地名称</th>
              <th>计划招收人数</th>
              <th>填报志愿人数</th>
              <th>通知复试人数</th>
              <!-- <th>预录取人数</th>-->
              <!-- <th>调剂人数</th> -->
              <th>确认录取人数</th>
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
	                <td>${recruitNumMap[speId]}</td>
	                <td>${retestNumMap[speId] }</td>
	                <!-- <td>${recruitYNumMap[speId] }</td> -->
	                <!-- <td>${swapCountMap[speId]}</td> -->
	                <td>${confirmCountMap[speId]}</td>
	                <td>
		                <a class="btn" onclick="recruitUsers('${speId}');">人员名单</a>
	            	</td>
	            </tr>
            </c:if>
            </c:forEach>
          </table>
        </div>
</div>
      
