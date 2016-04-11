<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<style type="text/css">
.btn{border:1px solid #e3e3e3; border-radius:0;}
.operContainer a:hover{ border:1px solid #e3e3e3; border-radius:0;}
.basic td{ text-align:center; padding:0;}
.basic td:hover{background:#428bca;color:#fff;}
</style>
<head>
<script type="text/javascript">
	function showRecList(reqFlow){
		$("#"+reqFlow).slideToggle(500);
		if(reqFlow in openRec){
			delete openRec[reqFlow];
		}else{
			openRec[reqFlow] = reqFlow;
		}
	}
	
	function appraiseList(recFlow){
		jboxOpen("<s:url value='/res/rec/appraiseList'/>?recFlow="+recFlow,"审核过程",700,450);
	}
	
	function operRec(rec){
		jboxConfirm("确认删除?",function(){
			jboxPost("<s:url value='/res/rec/opreResRec'/>",rec,function(resp){
				if(resp=="${GlobalConstant.DELETE_SUCCESSED}" || resp=="${GlobalConstant.OPRE_SUCCESSED}"){
					$(".recTypeTag.active").click();
				}
			},null,true);
		},null);
	}
	
	function operAppeal(appeal){
		jboxConfirm("确认删除?",function(){
			jboxPost("<s:url value='/res/rec/operAppeal'/>",appeal,function(resp){
				if(resp=="${GlobalConstant.DELETE_SUCCESSED}" || resp=="${GlobalConstant.OPRE_SUCCESSED}"){
					$(".recTypeTag.active").click();
				}
			},null,true);
		},null);
	}
	
	$(function(){
		$(".registryA").click(function(e){
			e.stopPropagation();
		});
		if(!$.isEmptyObject(openRec)){
			var newOpenRec = openRec;
			openRec = {};
			for(var key in newOpenRec){
				showRecList(key);
			}
		}
		/* $(".classButton").on("mouseenter mouseleave",function(){
			$(this).find(".operButton").toggle();
		}); */
		$(".operContainer").on("mouseenter mouseleave",function(){
			$(this).find(".operMenu").slideToggle(100);
		});
		$("[onclick]").click(function(e){
			e.stopPropagation();
		});
	});
</script>
</head>
<body>
	<div class="goal-category">
		<c:if test="${!(param.recTypeId eq registryTypeEnumCaseRegistry.id || param.recTypeId eq registryTypeEnumCampaignRegistry.id)}">
			<c:forEach items="${deptReqList}" var="deptReq">
			<c:set value="${deptReq.itemName}finishCount" var="finishKey"/>
				<div class="goal-category-head classButton" onclick="showRecList('${deptReq.reqFlow}');">
					<span class="j_stage_name">
						<span style="display: inline-block;width: 10%;">${deptReq.itemName}&nbsp;></span>
						<span style="display: inline-block;width: 12%;">要求数：${deptReq.reqNum}</span>
						<span style="display: inline-block;width: 12%;">完成数：${recCountMap[finishKey]+0}</span>
						<span style="display: inline-block;width: 12%;">申述数：${appealMap[deptReq.itemName].appealNum+0}</span>
						<c:if test="${!empty param.rotationFlow}">
							<span style="display: inline-block;width: 20%;">完成比例：${pdfn:transPercent(recCountMap[finishKey],deptReq.reqNum,2)}</span>
						</c:if>
					</span>
				</div>
				
				<ul id="${deptReq.reqFlow}" class="e-list task-list" style="display: none;">
					<c:forEach items="${recListMap[deptReq.itemName]}" var="rec" varStatus="status">
						<li class="editable rec" style="position: relative;" onclick="loadForm('${rec.recFlow}','${deptReq.reqFlow}');">
						<span style="display: inline-block;width: 20px;margin-left: 5px;margin-top: 11px;">
							<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id}">
								<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
							</c:if>
						</span>
						<span class="mark">
						<i></i>
						</span>
						<span style="width: 35px; height: 35px; text-align: left; display: inline-block;padding-left:10px;">${status.count}</span>
						<span class="j_title  ellipsis">
							<a style="color:black;text-decoration: none;">${pdfn:transDate(rec.operTime)}</a>
							<c:forEach items="${viewListMap[rec.recFlow]}" var="viewInfo">
								&#12288;${viewInfo.title}：${viewInfo.value}
							</c:forEach>
						</span>
						<span style="float: right;margin-right: 20px;">
							<!--<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id}">
								<font color="#428bca">审核通过</font>
							</c:if>-->
							<c:if test="${empty rec.auditStatusId || rec.auditStatusId eq recStatusEnumTeacherAuditN.id}">
								<c:if test="${!empty rec.auditStatusId}">
									[<a onclick="appraiseList('${rec.recFlow}');">审核意见</a>]
								</c:if>
							</c:if>
						</span>
						</li>
					</c:forEach>
					<li class="editable rec" style="position: relative;">
						<span style="display: inline-block;width: 20px;margin-left: 5px;margin-top: 11px;">
							<c:if test="${appealMap[deptReq.itemName].auditStatusId eq recStatusEnumTeacherAuditY.id}">
								<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
							</c:if>
						</span>
						<span class="mark">
						<i></i>
						</span>
						<span style="width: 35px; height: 35px; text-align: left; display: inline-block;padding-left:10px;">${status.count}</span>
						<span class="j_title  ellipsis">
							<a style="color:black;text-decoration: none;">${pdfn:transDate(appealMap[deptReq.itemName].operTime)}</a>
							&#12288;申述数：${appealMap[deptReq.itemName].appealNum}
							&#12288;申述理由：${appealMap[deptReq.itemName].appealReason}
						</span>
					</li>
				</ul>
			</c:forEach>
			
			<c:set value="otherfinishCount" var="finishKey"/>
			<div class="goal-category-head classButton" onclick="showRecList('${param.recTypeId}other');">
				<span class="j_stage_name">
					<span style="display: inline-block;width: 10%;">其他&nbsp;></span>
					<span style="display: inline-block;width: 12%;">完成数：${recCountMap[finishKey]+0}</span>
				</span>
			</div>
			
			<ul id="${param.recTypeId}other" class="e-list task-list" style="display: none;">
				<c:forEach items="${recListMap['other']}" var="rec" varStatus="status">
					<li class="editable rec" style="position: relative;" onclick="loadForm('${rec.recFlow}','${deptReq.reqFlow}');">
					<span style="display: inline-block;width: 20px;margin-left: 5px;margin-top: 11px;">
						<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id}">
							<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
						</c:if>
					</span>
					<span class="mark">
					<i></i>
					</span>
					<span style="width: 35px; height: 35px; text-align: left; display: inline-block;padding-left:10px;">${status.count}</span>
					<span class="j_title  ellipsis">
						<a style="color:black;text-decoration: none;">${pdfn:transDate(rec.operTime)}</a>
						<c:forEach items="${viewListMap[rec.recFlow]}" var="viewInfo">
							&#12288;${viewInfo.title}：${viewInfo.value}
						</c:forEach>
					</span>
					<span style="float: right;margin-right: 20px;">
						<c:if test="${empty rec.auditStatusId || rec.auditStatusId eq recStatusEnumTeacherAuditN.id}">
							<c:if test="${!empty rec.auditStatusId}">
								[<a onclick="appraiseList('${rec.recFlow}');">审核意见</a>]
							</c:if>
						</c:if>
					</span>
					</li>
				</c:forEach>
			</ul>
		</c:if>
		
		<c:if test="${param.recTypeId eq registryTypeEnumCaseRegistry.id || param.recTypeId eq registryTypeEnumCampaignRegistry.id}">
			<div class="goal-category-head classButton">
				<span class="j_stage_name">
				<c:if test="${param.recTypeId eq registryTypeEnumCaseRegistry.id}">
					<c:set value="${registryTypeEnumCaseRegistry.id}reqNum" var="reqKey"/>
					<c:set value="${registryTypeEnumCaseRegistry.id}finish" var="finishKey"/>
					<span style="display: inline-block;width: 12%;">要求数：${recCountMap[reqKey]+0}</span>
					<span style="display: inline-block;width: 12%;">完成数：${recCountMap[finishKey]+0}</span>
					<c:if test="${!empty param.rotationFlow}">
						<c:set value="${param.resultFlow}${registryTypeEnumCaseRegistry.id}" var="preKey"/>
						<span style="display: inline-block;width: 15%;">完成比例：${pdfn:transPercent(recCountMap[finishKey],recCountMap[reqKey],2)}</span>
					</c:if>
				</c:if>
				<c:if test="${param.recTypeId eq registryTypeEnumCampaignRegistry.id}">
					<span style="display: inline-block;">参加活动数：${recList.size()+0}</span>
				</c:if>
				</span>
			</div>
			<ul class="e-list task-list">
				<c:forEach items="${recList}" var="rec" varStatus="status">
					<li class="editable" style="position: relative;" onclick="loadForm('${rec.recFlow}','');">
					<span style="display: inline-block;width: 20px;margin-left: 5px;margin-top: 11px;">
						<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id}">
							<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
						</c:if>
						<!--<c:if test="${rec.statusId eq recStatusEnumEdit.id}">
							<img src="<s:url value='/css/skin/${skinPath}/images/shu.gif'/>"/>
						</c:if>-->
					</span>
					<span class="mark">
					<i></i>
					</span>
					<span style="width: 35px; height: 35px; text-align: left; display: inline-block;padding-left:10px;">${status.count}</span>
					<span class="j_title  ellipsis">
						<a style="color:black;text-decoration: none;">${pdfn:transDate(rec.operTime)}</a>
						<c:forEach items="${viewListMap[rec.recFlow]}" var="viewInfo">
							&#12288;${viewInfo.title}：${viewInfo.value}
						</c:forEach>
					</span>
					<span style="float: right;margin-right: 20px;">
						<!--<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id}">
							<font color="#428bca">审核通过</font>
						</c:if>-->
						<c:if test="${empty rec.auditStatusId || rec.auditStatusId eq recStatusEnumTeacherAuditN.id}">
							<c:if test="${!empty rec.auditStatusId}">
								[<a onclick="appraiseList('${rec.recFlow}');">审核意见</a>]
							</c:if>
						</c:if>
					</span>
					</li>
				</c:forEach>
			</ul>
		</c:if>
	</div>
	
</body>
</html>