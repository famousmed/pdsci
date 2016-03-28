<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
	var reqTypeConfig = {
			"${resRecTypeEnumCaseRegistry.id}":{
				title:"大病历登记",
				width:700,
				height:450
			},
			"${resRecTypeEnumDiseaseRegistry.id}":{
				title:"病种登记",
				width:700,
				height:500
			},
			"${resRecTypeEnumOperationRegistry.id}":{
				title:"手术登记",
				width:700,
				height:500
			},
			"${resRecTypeEnumSkillRegistry.id}":{
				title:"操作技能登记",
				width:700,
				height:500
			},
			"${resRecTypeEnumCampaignRegistry.id}":{
				title:"登记活动",
				width:700,
				height:400
			},
	};
	
	//登记
	function registry(recFlow,isRead,schDeptFlow,rotationFlow){
		jboxOpen("<s:url value='/res/rec/showRegistryForm'/>?recTypeId=${param.recTypeId}&schDeptFlow="+schDeptFlow+"&rotationFlow="+rotationFlow+"&recFlow="+recFlow+"&isRead="+isRead,reqTypeConfig.${param.recTypeId}.title,reqTypeConfig.${param.recTypeId}.width,reqTypeConfig.${param.recTypeId}.height);
	}
	function appraiseList(recFlow){
		jboxOpen("<s:url value='/res/rec/appraiseList'/>?recFlow="+recFlow,"审核过程",700,450);
	}
</script>
<div class="i-trend-main-div" style="padding: 15px 10px;">
	<div style="color:blue;margin-bottom: 10px;margin-right: 10px;" align="right">
		<label>
			<input onclick="$('.selectTag a').click();" type="checkbox" id="isCurrentFlag" value="${GlobalConstant.FLAG_Y}" ${param.isCurrentFlag eq GlobalConstant.FLAG_Y?'checked':''} />
			&nbsp;查询当前轮转科室审核信息
		</label>
	</div>
	 <c:choose>
     <c:when test="${param.recTypeId!=resRecTypeEnumAfterSummary.id }">
	<table class="xllist">
	        <tr>
		     <th>专业</th>
		     <th>年级</th>
		     <th>研究生</th>
		     <th>轮转科室</th>
		     <th>填写时间</th>
		     <th>带教老师审核状态</th>
<!-- 		     <th>科主任审核状态</th> -->
		     <th>操作</th>
		   </tr>
		   <c:forEach items="${recExtList }" var="recExt">
		   <tr>
		   	<td>${recExt.doctorExt.specialized }</td>
		   	<td>${recExt.doctorExt.sessionNumber }</td>
		   	<td>${recExt.doctorExt.sysUser.userName }</td>
		   	<td>${recExt.schDeptName }</td>
		   	<td>${pdfn:transDateForPattern(recExt.operTime,"yyyy-MM-dd") }</td>
		   	<td>
		   		${empty recExt.auditStatusId?'未审核':(recExt.auditStatusId eq recStatusEnumTeacherAuditY?'审核通过':'审核不通过')}
		   	</td>
		   	<!--  <td>
		   		${empty recExt.headAuditStatusId?'未审核':(recExt.headAuditStatusId eq recStatusEnumHeadAuditY?'审核通过':'审核不通过')}
		   	</td>-->
		   	<td>
		   		<a href="javascript:registry('${recExt.recFlow}',true,'${recExt.schDeptFlow}','${recExt.doctorExt.rotationFlow}');" style="color:blue;">登记信息</a>
		   		|
		   		<a href="javascript:appraiseList('${recExt.recFlow}');" style="color:blue;">审核意见</a>
		   	</td>
		   </tr>
		   </c:forEach>
		   <c:if test="${empty recExtList}">
		   		<tr><td colspan="8">无记录</td></tr>
		   </c:if>
	</table>
		 </c:when>
		 <c:when test="${param.recTypeId==resRecTypeEnumAfterSummary.id }">
	<table class="xllist">
	        <tr>
		     <th>专业</th>
		     <th>年级</th>
		     <th>研究生</th>
		     <th>轮转科室</th>
		     <th>轮转时间</th>
		     <th>带教老师审核状态</th>
		     <th>科主任审核状态</th>
		     <th>操作</th>
		   </tr>
		   <c:forEach items="${recExtList }" var="recExt">
		   <tr>
		   	<td>${recExt.doctorExt.specialized }</td>
		   	<td>${recExt.doctorExt.sessionNumber }</td>
		   	<td>${recExt.doctorExt.sysUser.userName }</td>
		   	<td>${recExt.schDeptName }</td>
		   	<td>${recExt.process.startDate}~${recExt.process.endDate}</td>
		   	<td>
		   		${empty recExt.auditStatusId?'未审核':(recExt.auditStatusId eq recStatusEnumTeacherAuditY?'审核通过':'审核不通过')}
		   	</td>
		   	<td>
		   		${empty recExt.headAuditStatusId?'未审核':(recExt.headAuditStatusId eq recStatusEnumHeadAuditY?'审核通过':'审核不通过')}
		   	</td>
		   	<td></td>
		   </tr>
		   </c:forEach>
		   <c:if test="${empty recExtList}">
		   		<tr><td colspan="8">无记录</td></tr>
		   </c:if>
	</table>
		 </c:when>
     </c:choose>
</div>
