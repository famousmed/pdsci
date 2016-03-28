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
		<c:set var="enumKey" value="registryTypeEnum${param.recTypeId}"/>
		<c:if test="${applicationScope[enumKey].haveItem eq GlobalConstant.FLAG_Y}">
			<c:forEach items="${deptReqList}" var="deptReq">
			<c:set value="${deptReq.itemId}finishCount" var="finishKey"/>
<%-- 			<c:set value="${deptReq.itemId}appealCount" var="appealKey"/> --%>
				<div class="goal-category-head classButton" onclick="showRecList('${deptReq.reqFlow}');">
					<span class="j_stage_name">
						<span style="display: inline-block;width: 20%;">${deptReq.itemName}&nbsp;></span>
						<span style="display: inline-block;width: 12%;">要求数：${deptReq.reqNum}</span>
						<span style="display: inline-block;width: 12%;">完成数：${recCountMap[finishKey]+0}</span>
						<span style="display: inline-block;width: 12%;">申述数：${appealMap[deptReq.itemId].appealNum+0}</span>
						<c:if test="${!empty param.rotationFlow}">
<%-- 							<c:set value="${param.resultFlow}${deptReq.recTypeId}${deptReq.itemId}" var="preKey"/> --%><%-- ${recFinishMap[preKey]+0} --%>
							<span style="display: inline-block;width: 20%;">完成比例：${pdfn:transPercent(recCountMap[finishKey],deptReq.reqNum,2)}</span>
						</c:if>
<%-- 						<span style="display: inline-block;width: 12%;">申述数：${recCountMap[appealKey]+0}</span> --%>
					</span>
					<div class="operButton" style="float: right;margin-right: 10px;">
						<div class="operContainer" style="width: 40px;">
							<a class="btn btn-sm btn-success registryA" style="height: 15px;line-height: 15px;background-color: #fff;" href="javascript:;">
								<img src="<s:url value='/css/skin/${skinPath}/images/icon-reorder.png'/>" style="margin-top: 2px;">
							</a>
							<div class="operMenu  registryA" style="display: none; margin-left:-65px;margin-top:-1px;z-index: 1;position: absolute;">
								<table class="basic" style="background-color: #fff;color: #333;width: 100px;">
									<tr class="menuHover"><td style="height: 30px;line-height: 30px;" onclick="loadForm('','${deptReq.reqFlow}');">登记</td></tr>
									<tr class="menuHover"><td style="height: 30px;line-height: 30px;" onclick="editAppeal('${appealMap[deptReq.itemId].appealFlow}','${deptReq.reqFlow}');">申述</td></tr>
								</table>
							</div>
						</div>
					</div>
				</div>
				
				<ul id="${deptReq.reqFlow}" class="e-list task-list" style="display: none;">
					<c:forEach items="${recListMap[deptReq.itemId]}" var="rec" varStatus="status">
						<li class="editable rec" style="position: relative;" onclick="loadForm('${rec.recFlow}','${deptReq.reqFlow}');">
						<span style="display: inline-block;width: 20px;margin-left: 5px;margin-top: 11px;">
							<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id}">
								<img title="已审核" src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
							</c:if>
							<!--<c:if test="${rec.statusId eq recStatusEnumEdit.id}">
								<img src="<s:url value='/css/skin/${skinPath}/images/shu.gif'/>"/>
							</c:if>-->
						</span>
						<span class="mark">
						<i></i>
						</span>
						<span style="width: 35px; height: 35px; text-align: left; display: inline-block;padding-left:10px;">${status.count}</span>
						<span class="j_title  ellipsis" style="display: inline-block;width: 75%;">
							<div style="float: left;width: 100px;text-align: left;">${pdfn:transDate(rec.operTime)}</div>
							<c:forEach items="${viewListMap[rec.recFlow]}" var="viewInfo">
								<div style="float: left;font-weight: bold;">${viewInfo.title}：</div>
								<div style="float: left;width: 12%;text-align: left;overflow: hidden;margin-right: 5px;">${viewInfo.value}</div>
							</c:forEach>
						</span>
						<span style="float: right;margin-right: 20px;">
							<!--<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id}">
								<font color="#428bca">审核通过</font>
							</c:if>-->
							<c:if test="${empty rec.auditStatusId || rec.auditStatusId eq recStatusEnumTeacherAuditN.id}">
								[<a onclick="operRec({'recFlow':'${rec.recFlow}','recordStatus':'${GlobalConstant.RECORD_STATUS_N}'});">删除</a>]
								<c:if test="${!empty rec.auditStatusId}">
									[<a onclick="appraiseList('${rec.recFlow}');">审核意见</a>]
								</c:if>
							</c:if>
						</span>
						</li>
					</c:forEach>
					<li class="editable rec" style="position: relative;">
						<span style="display: inline-block;width: 20px;margin-left: 5px;margin-top: 11px;">
							<c:if test="${appealMap[deptReq.itemId].auditStatusId eq recStatusEnumTeacherAuditY.id}">
								<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
							</c:if>
						</span>
						<span class="mark">
						<i></i>
						</span>
						<span style="width: 35px; height: 35px; text-align: left; display: inline-block;padding-left:10px;">${status.count}</span>
						<span class="j_title  ellipsis">
							<a style="color:black;text-decoration: none;">${pdfn:transDate(appealMap[deptReq.itemId].operTime)}</a>
							&#12288;申述数：${appealMap[deptReq.itemId].appealNum}
							&#12288;申述理由：${appealMap[deptReq.itemId].appealReason}
						</span>
					</li>
				</ul>
			</c:forEach>
			
<%-- 			<c:set value="otherfinishCount" var="finishKey"/> --%>
<%-- 			<div class="goal-category-head classButton" onclick="showRecList('${param.recTypeId}other');"> --%>
<!-- 				<span class="j_stage_name"> -->
<!-- 					<span style="display: inline-block;width: 20%;">自定义填写&nbsp;></span> -->
<%-- 					<span style="display: inline-block;width: 12%;">完成数：${recCountMap[finishKey]+0}</span> --%>
<!-- 				</span> -->
<!-- 				<div class="operButton" style="float: right;margin-right: 10px;"> -->
<!-- 					<div class="operContainer" style="width: 40px;"> -->
<!-- 						<a class="btn btn-sm btn-success registryA" style="height: 15px;line-height: 15px;background-color: #fff;" href="javascript:;"> -->
<%-- 							<img src="<s:url value='/css/skin/${skinPath}/images/icon-reorder.png'/>" style="margin-top: 2px;"> --%>
<!-- 						</a> -->
<!-- 						<div class="operMenu  registryA" style="display: none; margin-left:-65px;margin-top:-1px;z-index: 1;position: absolute;"> -->
<!-- 							<table class="basic" style="background-color: #fff;color: #333;width: 100px;"> -->
<!-- 								<tr class="menuHover"><td style="height: 30px;line-height: 30px;" onclick="loadForm('','');">登记</td></tr> -->
<!-- 							</table> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
			
<%-- 			<ul id="${param.recTypeId}other" class="e-list task-list" style="display: none;"> --%>
<%-- 				<c:forEach items="${recListMap['other']}" var="rec" varStatus="status"> --%>
<%-- 					<li class="editable rec" style="position: relative;" onclick="loadForm('${rec.recFlow}','${deptReq.reqFlow}');"> --%>
<!-- 					<span style="display: inline-block;width: 20px;margin-left: 5px;margin-top: 11px;"> -->
<%-- 						<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id}"> --%>
<%-- 							<img title="已审核" src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/> --%>
<%-- 						</c:if> --%>
<!-- 					</span> -->
<!-- 					<span class="mark"> -->
<!-- 					<i></i> -->
<!-- 					</span> -->
<%-- 					<span style="width: 35px; height: 35px; text-align: left; display: inline-block;padding-left:10px;">${status.count}</span> --%>
<!-- 					<span class="j_title  ellipsis" style="display: inline-block;width: 75%;"> -->
<%-- 						<div style="float: left;width: 100px;text-align: left;">${pdfn:transDate(rec.operTime)}</div> --%>
<%-- 						<c:forEach items="${viewListMap[rec.recFlow]}" var="viewInfo"> --%>
<%-- 							<div style="float: left;font-weight: bold;">${viewInfo.title}：</div> --%>
<%-- 							<div style="float: left;width: 12%;text-align: left;overflow: hidden;margin-right: 5px;">${viewInfo.value}</div> --%>
<%-- 						</c:forEach> --%>
<!-- 					</span> -->
<!-- 					<span style="float: right;margin-right: 20px;"> -->
<%-- 						<c:if test="${empty rec.auditStatusId || rec.auditStatusId eq recStatusEnumTeacherAuditN.id}"> --%>
<%-- 							[<a onclick="operRec({'recFlow':'${rec.recFlow}','recordStatus':'${GlobalConstant.RECORD_STATUS_N}'});">删除</a>] --%>
<%-- 							<c:if test="${!empty rec.auditStatusId}"> --%>
<%-- 								[<a onclick="appraiseList('${rec.recFlow}');">审核意见</a>] --%>
<%-- 							</c:if> --%>
<%-- 						</c:if> --%>
<!-- 					</span> -->
<!-- 					</li> -->
<%-- 				</c:forEach> --%>
<!-- 			</ul> -->
		</c:if>
		
		<c:if test="${applicationScope[enumKey].haveItem eq GlobalConstant.FLAG_N}">
			<div class="goal-category-head classButton">
				<span class="j_stage_name">
				<c:if test="${applicationScope[enumKey].haveReq eq GlobalConstant.FLAG_Y}">
					<c:set value="${applicationScope[enumKey].id}reqNum" var="reqKey"/>
					<c:set value="${applicationScope[enumKey].id}finish" var="finishKey"/>
					<span style="display: inline-block;width: 12%;">要求数：${recCountMap[reqKey]+0}</span>
					<span style="display: inline-block;width: 12%;">完成数：${recCountMap[finishKey]+0}</span>
					<c:if test="${!empty param.rotationFlow}">
						<c:set value="${param.resultFlow}${applicationScope[enumKey].id}" var="preKey"/>
						<span style="display: inline-block;width: 20%;">完成比例：${pdfn:transPercent(recCountMap[finishKey],recCountMap[reqKey],2)}</span>
					</c:if>
				</c:if>
				<c:if test="${applicationScope[enumKey].haveReq eq GlobalConstant.FLAG_N}">
					<span style="display: inline-block;">${applicationScope[enumKey].name}数：${recList.size()+0}</span>
				</c:if>
				</span>
				<div class="operButton" style="float: right;margin-right: 10px;">
					<div class="operContainer" style="width: 40px;">
						<a class="btn btn-sm btn-success registryA" style="height: 15px;line-height: 15px;background-color: #fff;" href="javascript:;">
							<img src="<s:url value='/css/skin/${skinPath}/images/icon-reorder.png'/>" style="margin-top: 2px;">
						</a>
						<div class="operMenu  registryA" style="display: none;margin-left:-65px;margin-top:-1px;z-index: 1;position: absolute;">
							<table class="basic" style="background-color: #fff;color: #333;width: 100px;">
								<tr class="menuHover"><td style="height: 30px;line-height: 30px;" onclick="javascript:loadForm('');">登记</td></tr>
							</table>
						</div>
					</div>
				</div>
			</div>
			
			<ul class="e-list task-list">
				<c:forEach items="${recList}" var="rec" varStatus="status">
					<li class="editable" style="position: relative;" onclick="loadForm('${rec.recFlow}','');">
					<span style="display: inline-block;width: 20px;margin-left: 5px;margin-top: 11px;">
						<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id}">
							<img title="已审核" src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
						</c:if>
						<!--<c:if test="${rec.statusId eq recStatusEnumEdit.id}">
							<img src="<s:url value='/css/skin/${skinPath}/images/shu.gif'/>"/>
						</c:if>-->
					</span>
					<span class="mark">
					<i></i>
					</span>
					<span style="width: 20px; height: 35px; text-align: left; display: inline-block;padding-left:10px;">${status.count}</span>
					<span class="j_title  ellipsis" style="display: inline-block;width: 75%;">
						<div style="float: left;width: 100px;text-align: left;">${pdfn:transDate(rec.operTime)}</div>
						<c:forEach items="${viewListMap[rec.recFlow]}" var="viewInfo">
							<div style="float: left;font-weight: bold;">${viewInfo.title}：</div>
							<div style="float: left;width: 12%;text-align: left;overflow: hidden;margin-right: 5px;">${viewInfo.value}</div>
						</c:forEach>
					</span>
					<span style="float: right;margin-right: 20px;">
						<!--<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id}">
							<font color="#428bca">审核通过</font>
						</c:if>-->
						<c:if test="${empty rec.auditStatusId || rec.auditStatusId eq recStatusEnumTeacherAuditN.id}">
							[<a onclick="operRec({'recFlow':'${rec.recFlow}','recordStatus':'${GlobalConstant.RECORD_STATUS_N}'});">删除</a>]
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