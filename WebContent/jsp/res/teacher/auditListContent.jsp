<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<style type="text/css">

</style>
<script type="text/javascript">
	function recAuditList(doctorFlow){
		var url="<s:url value='/res/teacher/recAuditList' />?recTypeId=${param.recTypeId}&roleFlag=${param.roleFlag}&doctorFlow="+doctorFlow+"&isCurrentFlag="+($("#isCurrentFlag:checked").length>0?$("#isCurrentFlag:checked").val():"");
		var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='100%' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
		jboxMessager(iframe, "审核列表", 900,550,null,true);
	}
	
	function auditRec(operUserFlow,schDeptFlow,recFlow,processFlow,rotationFlow){
		var width=(window.screen.width)*0.6;
		var height = 500;
		var url = "<s:url value='/res/teacher/showAudit'/>";
		if(${param.recTypeId eq resRecTypeEnumAfterEvaluation.id || param.recTypeId eq resRecTypeEnumAfterSummary.id}){
			url = "<s:url value='/res/rec/showRegistryForm'/>";
			width = 1000;
		}
		url+=("?recFlow="+recFlow+"&recTypeId=${param.recTypeId}&roleFlag=${param.roleFlag}&processFlow="+processFlow+"&operUserFlow="+operUserFlow+"&schDeptFlow="+schDeptFlow+"&rotationFlow="+rotationFlow);
		//jboxOpen(url,"审核明细",width,height,true);
		location.href = url;
	}
	
	$(function(){
		if(doctorFlow!=""){
			$("."+doctorFlow).css("background-color","pink");
		}
	});
</script>
<div class="i-trend-main-div" style="padding: 15px 10px;">
	<div style="color:blue;margin-bottom: 10px;margin-right: 10px;" align="right">
		<label>
			<input onclick="$('.selectTag a').click();" type="checkbox" id="isCurrentFlag" value="${GlobalConstant.FLAG_Y}" ${param.isCurrentFlag eq GlobalConstant.FLAG_Y?'checked':''} />
			&nbsp;查询当前轮转科室审核信息
		</label>
	</div>
	 <c:choose>
     <c:when test="${param.recTypeId!=resRecTypeEnumAfterSummary.id && param.recTypeId!=resRecTypeEnumAfterEvaluation.id}">
		<table class="xllist">
		       <tr>
			     <th>住院医师</th>
			     <th>专业</th>
			     <th>届别</th>
			     <th>要求填写数</th>
			     <th>已完成数</th>
			     <th>待审核数/已审核数</th>
			     <th>操作</th>
			   </tr>
			   <c:set value="0" var="dataCount"/>
			   <c:forEach items="${recExtList}" var="recExt">
			   		<c:set value="${recExt.doctorExt.doctorFlow}notAuditCount" var="notAuditKey"/>
			   		<c:if test="${countMap[notAuditKey]+0 != 0}">
				   		<c:set value="${recExt.doctorExt.doctorFlow}reqCount" var="reqKey"/>
				   		<c:set value="${recExt.doctorExt.doctorFlow}finishCount" var="finishKey"/>
				   		<c:set value="${recExt.doctorExt.doctorFlow}auditCount" var="auditKey"/>
					   <tr class="${recExt.doctorExt.doctorFlow}">
						   <td>${recExt.doctorExt.sysUser.userName}</td>
						   <td>${recExt.doctorExt.specialized}</td>
						   <td>${recExt.doctorExt.sessionNumber}</td>
						   <td>${countMap[reqKey]+0}</td>
						   <td>${countMap[finishKey]+0}</td>
						   <td>${countMap[notAuditKey]+0}/${countMap[auditKey]+0}</td>
						   <td><a href="javascript:void(0);" onclick="recAuditList('${recExt.doctorExt.doctorFlow}');" style="color:blue;">审核</a></td>
					   </tr>
				   </c:if>
				   <c:set value="${(countMap[notAuditKey]+0) + dataCount}" var="dataCount"/>
			   </c:forEach>
			   <c:if test="${dataCount == 0}"><tr><td colspan="7">无记录</td></tr></c:if>
		</table>
	 </c:when>
   
	 <c:when test="${param.recTypeId==resRecTypeEnumAfterSummary.id || param.recTypeId==resRecTypeEnumAfterEvaluation.id}">
		<table class="xllist">
		        <tr>
			     <th>住院医师</th>
			     <th>专业</th>
			     <th>届别</th>
			     <th>操作</th>
			   </tr>
			   <c:forEach items="${recExtList}" var="recExt">
			   		<c:set value="${recExt.doctorExt.doctorFlow}reqCount" var="reqKey"/>
			   		<c:set value="${recExt.doctorExt.doctorFlow}finishCount" var="finishKey"/>
			   		<c:set value="${recExt.doctorExt.doctorFlow}auditCount" var="auditKey"/>
			   		<c:set value="${recExt.doctorExt.doctorFlow}notAuditCount" var="notAuditKey"/>
				   <tr class="${recExt.doctorExt.doctorFlow}">
					   <td>${recExt.doctorExt.sysUser.userName}</td>
					   <td>${recExt.doctorExt.specialized}</td>
					   <td>${recExt.doctorExt.sessionNumber}</td>
					   <td><a href="javascript:void(0);" onclick="auditRec('${recExt.operUserFlow}','${recExt.schDeptFlow}','${recExt.recFlow}','${recExt.process.processFlow}','${recExt.doctorExt.rotationFlow}');" style="color:blue;">审核</a></td>
				   </tr>
			   </c:forEach>
		</table>
	 </c:when>
	 <%-- <c:when test="${param.recTypeId==resRecTypeEnumAfterEvaluation.id}">
		<table class="xllist">
		        <tr>
			     <th>住院医师</th>
			     <th>专业</th>
			     <th>届别</th>
			     <th>操作</th>
			   </tr>
			   <c:forEach items="${recExtList}" var="recExt">
			   		<c:set value="${recExt.doctorExt.doctorFlow}reqCount" var="reqKey"/>
			   		<c:set value="${recExt.doctorExt.doctorFlow}finishCount" var="finishKey"/>
			   		<c:set value="${recExt.doctorExt.doctorFlow}auditCount" var="auditKey"/>
			   		<c:set value="${recExt.doctorExt.doctorFlow}notAuditCount" var="notAuditKey"/>
				   <tr id="${recExt.doctorExt.doctorFlow}">
					   <td>${recExt.doctorExt.sysUser.userName}</td>
					   <td>${recExt.doctorExt.specialized}</td>
					   <td>${recExt.doctorExt.sessionNumber}</td>
					   <td><a href="javascript:void(0);" onclick="recAuditList('${recExt.doctorExt.doctorFlow}');" style="color:blue;">审核</a></td>
				   </tr>
			   </c:forEach>
		</table>
	 </c:when> --%>
     </c:choose>
</div>
