<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	function retestUsers(speId,assignPlan,currentPage,userName,graduatedId){
		var data={
				"speId":speId,
				"assignPlan":assignPlan, 
				"currentPage":currentPage,
				"userName":userName, 
				"graduatedId":graduatedId
			};
		jboxPostLoad("content","<s:url value='/cnres/singup/hospital/retestUsers'/>",data,true);
	}
	
	function noticeRetestMain(){
		if ($("input[name='speId']:checked").length<1) {
			jboxTip("请至少选择一条记录！");
			return;
		}
		jboxOpen("<s:url value='/cnres/singup/hospital/noticeRetestMain'/>?operType=batch","复试通知",1000,500);
	}
	
	function checkAll(obj) {
		if (obj.checked) {
			$("input[name='speId']").attr("checked",true);
		} else {
			$("input[name='speId']").attr("checked",false);
		}
	}
	
	function retest(){
		jboxLoad("div_table_0","<s:url value='/cnres/singup/hospital/retest'/>",true);
	}
</script>
      	<div style="line-height: 40px;padding-top: 10px;padding-bottom: 10px;padding-left:40px;padding-right: 40px;font-size: 16px;">
			<span class="fl">
				<a class="btn" onclick="noticeRetestMain();">通知复试</a>
			</span>
			<span class="fr">
	                        计划招录人数：${totalAssignPlan}&#12288;通知复试人数：<span id="totalRetestNum" style="color: red;">${totalRetestNum}</span>
			</span>
	   </div> 
        <div class="div_table">
          <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <th style="text-align: left;padding-left: 20px;"><input type="checkbox" id="allChecked" onclick="checkAll(this)" title="全选"></th>
              <th style="text-align: left;padding-left: 20px;">专业代码</th>
              <th style="text-align: left;padding-left: 40px;">专业基地名称</th>
              <th>计划招收人数</th>
              <th>填报志愿人数</th>
              <th>复试人数</th>
              <th>操作</th>
            </tr>
            <c:forEach items="${doctorTrainingSpeList}" var="dict">
            <c:set var="speId" value="${dict.dictId}"></c:set>
            <c:set var="assignPlan" value="${speAssignMap[speId].assignPlan}"></c:set>
            <c:if test="${!empty assignPlan and assignPlan>0}">
	            <tr>
	            	<td style="text-align: left;padding-left: 20px;">
		              	<input type="checkbox" id="speId_${speId}" name="speId" value="${speId}">
	                </td>
	            	<td style="text-align: left;padding-left: 20px;">${speId}</td>
	                <td style="text-align: left;padding-left: 40px;">${dict.dictName}</td>
	                <td>${assignPlan}</td>
	                <td>${recruitNumMap[speId] }</td>
	                <td>${retestNumMap[speId] }</td>
	                <td>
		                <a class="btn" onclick="retestUsers('${speId}','${assignPlan}');">人员名单</a>
	            	</td>
	            </tr>
            </c:if>
            </c:forEach>
          </table>
        </div>
