<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
</jsp:include>
</head>
<script type="text/javascript">
	var reqTypeConfig = {
			"${resRecTypeEnumCaseRegistry.id}":{
				title:"大病历登记",
				width:400,
				height:250
			},
			"${resRecTypeEnumDiseaseRegistry.id}":{
				title:"病种登记",
				appeal:"申述病种",
				width:700,
				height:500
			},
			"${resRecTypeEnumOperationRegistry.id}":{
				title:"手术登记",
				appeal:"申述手术",
				width:700,
				height:500
			},
			"${resRecTypeEnumSkillRegistry.id}":{
				title:"操作技能登记",
				appeal:"申述操作技能",
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
	function registry(recFlow,isRead,reqFlow){
		jboxOpen("<s:url value='/res/rec/showRegistryForm'/>?recTypeId=${param.recTypeId}&schDeptFlow=${param.schDeptFlow}&rotationFlow=${param.rotationFlow}&recFlow="+recFlow+"&isRead="+isRead+"&reqFlow="+reqFlow,reqTypeConfig.${param.recTypeId}.title,reqTypeConfig.${param.recTypeId}.width,reqTypeConfig.${param.recTypeId}.height);
	}
	//申述
	function editAppeal(recTypeId,itemName){
		jboxOpen("<s:url value='/res/rec/editAppeal'/>?schDeptFlow=${param.schDeptFlow}&rotationFlow=${param.rotationFlow}&recTypeId="+recTypeId+"&itemName="+itemName,reqTypeConfig[recTypeId].appeal,700,400);
	}
	
	function opreResRec(rec,recTypeId){
		var info = "确认删除?";
		if("statusId" in rec){
			info = "确认提交?";
		}
		jboxConfirm(info,function(){
			jboxPost("<s:url value='/res/rec/opreResRec'/>",rec,function(resp){
				if(resp=="${GlobalConstant.DELETE_SUCCESSED}" || resp=="${GlobalConstant.OPRE_SUCCESSED}"){
					window.$("#"+recTypeId).click();
				}
			},null,true);
		},null);
	}
	
	function openRecList(reqFlow){
		$("#"+reqFlow).slideToggle(500);
		if(reqFlow in openRec){
			delete openRec[reqFlow];
		}else{
			openRec[reqFlow] = reqFlow;
		}
	}
	
	$(function(){
		if(!$.isEmptyObject(openRec)){
			var newOpenRec = openRec;
			openRec = {};
			for(var key in newOpenRec){
				openRecList(key);
			}
		}
	});
</script>
<body>
	<div id="main">
		<div class="mainright">
			<div class="content">
				<div style="padding-top: 10px;padding-left: 5px;padding-right: 5px;padding-bottom: 5px;">
					<c:if test="${!(param.recTypeId eq resRecTypeEnumCampaignRegistry.id)}">
					<span >
						 总要求数：${recCountMap['reqNum']+0} 例,
						 总完成数：${recCountMap['finishCount']+0} 例,
						 总审核数：${recCountMap['auditCount']+0} 例,
						 <c:if test="${!(param.recTypeId eq resRecTypeEnumCaseRegistry.id)}">
							 总申述量：${recCountMap['appealCount']+0} 例,
						 </c:if>
						 完成比例：${pdfn:getPercent((recCountMap['finishCount']+0),(recCountMap['reqNum']+0))},
						 审核比例：${pdfn:getPercent((recCountMap['auditCount']+0),(recCountMap['reqNum']+0))}
						<c:if test="${!(param.recTypeId eq resRecTypeEnumCaseRegistry.id)}">
							<label style="float: right;padding-right: 10px;"><input type="checkbox"/>未合格</label>
						</c:if>
					</span>
					</c:if>
					
					<c:if test="${param.recTypeId eq resRecTypeEnumCaseRegistry.id}">
					<table class="xllist" style="margin-top: 10px;">
						<tbody>
							<tr>
								<th style="width: 200px;">审核状态</th>
								<th style="width: 200px;">住院号</th>
								<th style="width: 200px;">诊断类型</th>
								<th >操作</th>
							</tr>
						</tbody>
						<tbody>
							<c:forEach items="${recList}" var="rec">
							<tr>
								<td>${empty rec.auditStatusId?'未审核':rec.auditStatusName}</td>
								<td>${recMap[rec.recFlow]['hospitalNumbers']}</td>
								<td>${recMap[rec.recFlow]['diagnoseType']}</td>
								<td >
									<span style="text-align:left;width: 135px;display: inline-block;">
									<c:if test="${rec.statusId eq recStatusEnumSubmit.id}">
										<a href="javascript:registry('${rec.recFlow}',true);" style="color: blue">查看</a>
									</c:if>
									<c:if test="${rec.statusId eq recStatusEnumEdit.id}">
										<a href="javascript:registry('${rec.recFlow}',false);" style="color: blue">编辑</a>
										&#12288;
										<a href="javascript:opreResRec({'recFlow':'${rec.recFlow}','statusId':'${recStatusEnumSubmit.id}'},'${resRecTypeEnumCaseRegistry.id}');" style="color: blue">提交</a>
										&#12288;
										<a href="javascript:opreResRec({'recFlow':'${rec.recFlow}','recordStatus':'${GlobalConstant.RECORD_STATUS_N}'},'${resRecTypeEnumCaseRegistry.id}');" style="color: blue">删除</a>
									</c:if>
									</span>
									<a href="#" style="color: blue">审核意见</a>
								</td>
							</tr>
							</c:forEach>
						</tbody>
						<c:if test="${empty recList}">
							<tr><td colspan="4">无记录</td></tr>
						</c:if>
					</table>
					</c:if>
					
					<c:if test="${param.recTypeId eq resRecTypeEnumDiseaseRegistry.id}">
						<c:forEach items="${deptReqList}" var="deptReq">
						<c:set value="${deptReq.itemName}auditCount" var="key"/>
						<c:set value="${deptReq.itemName}appealCount" var="appealKey"/>
						<c:set value="${deptReq.itemName}finishCount" var="finishKey"/>
						<div style="cursor: pointer;height: 40px;border: 1px solid #ccc;margin-top: 10px;" class="ith">
						<div style="float: left;width: 89%;padding-top: 10px;padding-bottom:10px;" onclick="openRecList('${deptReq.reqFlow}');">
							<span style="margin-right: 20px;display:inline-block;width: 20%;">病种名称：${deptReq.itemName}</span>
							<span style="margin-right: 20px;display:inline-block;width: 10%;">要求数：${deptReq.reqNum}</span>
							<span style="margin-right: 20px;display:inline-block;width: 10%;">完成数：${recCountMap[finishKey]+0}</span>
							<span style="margin-right: 20px;display:inline-block;width: 10%;">审核数：${recCountMap[key]+0}</span>
							<span style="margin-right: 20px;display:inline-block;width: 10%;">申述数：${recCountMap[appealKey]+0}</span>
							<span style="margin-right: 20px;display:inline-block;width: 10%;">审核申述数：${recCountMap[key]+recCountMap[appealKey]+0}</span>
							<span style="margin-right: 20px;display:inline-block;width: 10%;">掌握程度：</span>
						</div>
						<div style="float: right;margin-top: 10px;margin-right: 10px;width: 9%;">
							<span>
								<a href="javascript:registry('',false,'${deptReq.reqFlow}');" style="color: blue;">登记</a>
								&#12288;
								<a href="javascript:editAppeal('${deptReq.recTypeId}','${deptReq.itemName}');" style="color: blue">申述</a>
							</span>
						</div>
						</div>
						<div id="${deptReq.reqFlow}" style="display: none;border: 1px solid #ccc;border-top: none;border-bottom: none;">
							<c:if test="${!empty recListMap[deptReq.itemName]}">
							<table cellpadding="0" class="i-trend-main-table i-trend-main-div-table" cellspacing="0" border="0" style="width: 100%;">
								<tr style="height: 40px;">
									<th width="100px">病人姓名</th>
									<th width="100px">治疗措施</th>
									<th width="100px">类型</th>
									<th width="100px">入院日期</th>
									<th width="100px">状态</th>
									<th width="100px">病历类型</th>
									<th width="100px">备注</th>
									<th width="100px">操作</th>
								</tr>
								<c:forEach items="${recListMap[deptReq.itemName]}" var="rec">
									<tr style="height: 40px;">
										<td>${recMap[rec.recFlow]['patientName']}</td>
										<td>${recMap[rec.recFlow]['treatMeasure']}</td>
										<td>${recMap[rec.recFlow]['recType']}</td>
										<td>${recMap[rec.recFlow]['inHosDate']}</td>
										<td>${recMap[rec.recFlow]['recStatus']}</td>
										<td>${recMap[rec.recFlow]['caseType']}</td>
										<td>${recMap[rec.recFlow]['remark']}</td>
										<td>
											<c:if test="${rec.statusId eq recStatusEnumSubmit.id}">
												<a href="javascript:registry('${rec.recFlow}',true);" style="color: blue">查看</a>
											</c:if>
											<c:if test="${rec.statusId eq recStatusEnumEdit.id}">
												<a href="javascript:registry('${rec.recFlow}',false);" style="color: blue">编辑</a>
												&#12288;
												<a href="javascript:opreResRec({'recFlow':'${rec.recFlow}','statusId':'${recStatusEnumSubmit.id}'},'${resRecTypeEnumDiseaseRegistry.id}');" style="color: blue">提交</a>
												&#12288;
												<a href="javascript:opreResRec({'recFlow':'${rec.recFlow}','recordStatus':'${GlobalConstant.RECORD_STATUS_N}'},'${resRecTypeEnumDiseaseRegistry.id}');" style="color: blue">删除</a>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</table>
							</c:if>
							<c:if test="${empty recListMap[deptReq.itemName]}">
								<div style="height: 30px;padding-top: 10px;border-bottom:1px solid #ccc;" align="center">无记录</div>
							</c:if>
						</div>
						</c:forEach>
					</c:if>
					
					<c:if test="${param.recTypeId eq resRecTypeEnumOperationRegistry.id}">
					<c:forEach items="${deptReqList}" var="deptReq">
						<c:set value="${deptReq.itemName}auditCount" var="key"></c:set>
						<c:set value="${deptReq.itemName}appealCount" var="appealKey"></c:set>
						<c:set value="${deptReq.itemName}finishCount" var="finishKey"></c:set>
						<div style="cursor: pointer;height: 40px;border: 1px solid #ccc;margin-top: 10px;" class="ith">
						<div style="float: left;width: 89%;padding-top: 10px;padding-bottom:10px;" onclick="openRecList('${deptReq.reqFlow}');">
							<span style="margin-right: 20px;display:inline-block;width: 20%;">手术名称：${deptReq.itemName}</span>
							<span style="margin-right: 20px;display:inline-block;width: 10%;">要求数：${deptReq.reqNum}</span>
							<span style="margin-right: 20px;display:inline-block;width: 10%;">完成数：${recCountMap[finishKey]+0}</span>
							<span style="margin-right: 20px;display:inline-block;width: 10%;">审核数：${recCountMap[key]+0}</span>
							<span style="margin-right: 20px;display:inline-block;width: 10%;">申述数：${recCountMap[appealKey]+0}</span>
							<span style="margin-right: 20px;display:inline-block;width: 10%;">审核申述数：${recCountMap[key]+recCountMap[appealKey]+0}</span>
							<span style="margin-right: 20px;display:inline-block;width: 10%;">掌握程度：</span>
						</div>
						<div style="float: right;margin-top: 10px;margin-right: 10px;width: 9%;">
							<span>
								<a href="javascript:registry('',false,'${deptReq.reqFlow}');" style="color: blue">登记</a>
								&#12288;
								<a href="javascript:editAppeal('${deptReq.recTypeId}','${deptReq.itemName}');" style="color: blue">申述</a>
							</span>
						</div>
						</div>
						<div id="${deptReq.reqFlow}" style="display: none;border: 1px solid #ccc;border-top: none;border-bottom: none;">
							<c:if test="${!empty recListMap[deptReq.itemName]}">
							<table cellpadding="0" class="i-trend-main-table i-trend-main-div-table" cellspacing="0" border="0" style="width: 100%;">
											<tr style="height: 40px;">
												<th width="100px">病人姓名</th>
												<th width="100px">具体名称</th>
												<th width="100px">手术日期</th>
												<th width="100px">目的</th>
												<th width="100px">掌握情况</th>
												<th width="100px">术中职务</th>
												<th width="100px">备注</th>
												<th width="100px">操作</th>
											</tr>
											<c:forEach items="${recListMap[deptReq.itemName]}" var="rec">
												<tr style="height: 40px;">
													<td>${recMap[rec.recFlow]['patientName']}</td>
													<td>${recMap[rec.recFlow]['specificName']}</td>
													<td>${recMap[rec.recFlow]['operationDate']}</td>
													<td>${recMap[rec.recFlow]['objective']}</td>
													<td>${recMap[rec.recFlow]['masterStep']}</td>
													<td>${recMap[rec.recFlow]['operatePost']}</td>
													<td>${recMap[rec.recFlow]['remark']}</td>
													<td>
														<c:if test="${rec.statusId eq recStatusEnumSubmit.id}">
															<a href="javascript:registry('${rec.recFlow}',true);" style="color: blue">查看</a>
														</c:if>
														<c:if test="${rec.statusId eq recStatusEnumEdit.id}">
															<a href="javascript:registry('${rec.recFlow}',false);" style="color: blue">编辑</a>
															&#12288;
															<a href="javascript:opreResRec({'recFlow':'${rec.recFlow}','statusId':'${recStatusEnumSubmit.id}'},'${resRecTypeEnumOperationRegistry.id}');" style="color: blue">提交</a>
															&#12288;
															<a href="javascript:opreResRec({'recFlow':'${rec.recFlow}','recordStatus':'${GlobalConstant.RECORD_STATUS_N}'},'${resRecTypeEnumOperationRegistry.id}');" style="color: blue">删除</a>
														</c:if>
													</td>
												</tr>
											</c:forEach>
										</table>
							</c:if>
							<c:if test="${empty recListMap[deptReq.itemName]}">
								<div style="height: 30px;padding-top: 10px;border-bottom:1px solid #ccc;" align="center">无记录</div>
							</c:if>
						</div>
						</c:forEach>
					</c:if>
					
					<c:if test="${param.recTypeId eq resRecTypeEnumSkillRegistry.id}">
					<c:forEach items="${deptReqList}" var="deptReq">
						<c:set value="${deptReq.itemName}auditCount" var="key"></c:set>
						<c:set value="${deptReq.itemName}appealCount" var="appealKey"></c:set>
						<c:set value="${deptReq.itemName}finishCount" var="finishKey"></c:set>
						<div style="cursor: pointer;height: 40px;border: 1px solid #ccc;margin-top: 10px;" class="ith">
						<div style="float: left;width: 89%;padding-top: 10px;padding-bottom:10px;" onclick="openRecList('${deptReq.reqFlow}');">
							<span style="margin-right: 20px;display:inline-block;width: 20%;">操作名称：${deptReq.itemName}</span>
							<span style="margin-right: 20px;display:inline-block;width: 10%;">要求数：${deptReq.reqNum}</span>
							<span style="margin-right: 20px;display:inline-block;width: 10%;">完成数：${recCountMap[finishKey]+0}</span>
							<span style="margin-right: 20px;display:inline-block;width: 10%;">审核数：${recCountMap[key]+0}</span>
							<span style="margin-right: 20px;display:inline-block;width: 10%;">申述数：${recCountMap[appealKey]+0}</span>
							<span style="margin-right: 20px;display:inline-block;width: 10%;">审核申述数：${recCountMap[key]+recCountMap[appealKey]+0}</span>
							<span style="margin-right: 20px;display:inline-block;width: 10%;">掌握程度：</span>
						</div>
						<div style="float: right;margin-top: 10px;margin-right: 10px;width: 9%;">
							<span>
								<a href="javascript:registry('',false,'${deptReq.reqFlow}');" style="color: blue">登记</a>
								&#12288;
								<a href="javascript:editAppeal('${deptReq.recTypeId}','${deptReq.itemName}');" style="color: blue">申述</a>
							</span>
						</div>
						</div>
						<div id="${deptReq.reqFlow}" style="display: none;border: 1px solid #ccc;border-top: none;border-bottom: none;">
							<c:if test="${!empty recListMap[deptReq.itemName]}">
							<table cellpadding="0" class="i-trend-main-table i-trend-main-div-table" cellspacing="0" border="0" style="width: 100%;">
											<tr style="height: 40px;">
												<th width="100px">病人姓名</th>
												<th width="100px">操作日期</th>
												<th width="100px">目的</th>
												<th width="100px">操作类别</th>
												<th width="100px">失败原因</th>
												<th width="100px">备注</th>
												<th width="100px">操作</th>
											</tr>
											<c:forEach items="${recListMap[deptReq.itemName]}" var="rec">
												<tr style="height: 40px;">
													<td>${recMap[rec.recFlow]['patientName']}</td>
													<td>${recMap[rec.recFlow]['operateDate']}</td>
													<td>${recMap[rec.recFlow]['objective']}</td>
													<td>${recMap[rec.recFlow]['operateType']}</td>
													<td>${recMap[rec.recFlow]['failReason']}</td>
													<td>${recMap[rec.recFlow]['remark']}</td>
													<td>
														<c:if test="${rec.statusId eq recStatusEnumSubmit.id}">
															<a href="javascript:registry('${rec.recFlow}',true);" style="color: blue">查看</a>
														</c:if>
														<c:if test="${rec.statusId eq recStatusEnumEdit.id}">
															<a href="javascript:registry('${rec.recFlow}',false);" style="color: blue">编辑</a>
															&#12288;
															<a href="javascript:opreResRec({'recFlow':'${rec.recFlow}','statusId':'${recStatusEnumSubmit.id}'},'${resRecTypeEnumSkillRegistry.id}');" style="color: blue">提交</a>
															&#12288;
															<a href="javascript:opreResRec({'recFlow':'${rec.recFlow}','recordStatus':'${GlobalConstant.RECORD_STATUS_N}'},'${resRecTypeEnumSkillRegistry.id}');" style="color: blue">删除</a>
														</c:if>
													</td>
												</tr>
											</c:forEach>
										</table>
							</c:if>
							<c:if test="${empty recListMap[deptReq.itemName]}">
								<div style="height: 30px;padding-top: 10px;border-bottom:1px solid #ccc;" align="center">无记录</div>
							</c:if>
						</div>
						</c:forEach>
					</c:if>
					
					<c:if test="${param.recTypeId eq resRecTypeEnumCampaignRegistry.id}">
						<table class="xllist"  style="margin-top: 10px;">
						                <tr>
						                  <th style="width: 100px;">日期</th>
						                  <th>内容</th>
						                  <th style="width: 100px;">活动形式</th>
						                  <th style="width: 100px;">学时</th>
						                  <th style="width: 80px;">主讲人</th>
						                  <th style="width: 200px;">审核状态</th>
						                  <th style="width: 200px;">操作</th>
						                </tr>
						                <c:forEach items="${recList}" var="rec">
						                <tr>
						                	<td>${recMap[rec.recFlow]['activeDate']}</td>
						                	<td style="text-align: left;padding-left:10px;">${recMap[rec.recFlow]['activeDetail']}</td>
						                	<td>${recMap[rec.recFlow]['activeType']}</td>
						                	<td>${recMap[rec.recFlow]['classHour']}</td>
						                	<td>${recMap[rec.recFlow]['lecturer']}</td>
						                	<td>${empty rec.auditStatusId?'未审核':rec.auditStatusName}</td>
						                	<td >
						                	<span style="text-align:left;display: inline-block;width: 135px">
						                	<c:if test="${rec.statusId eq recStatusEnumSubmit.id}">
												<a href="javascript:registry('${rec.recFlow}',true);" style="color: blue">查看</a>
											</c:if>
						                	<c:if test="${rec.statusId eq recStatusEnumEdit.id}">
							                	<a href="javascript:registry('${rec.recFlow}',false);" style="color: blue">编辑</a>
							                	&#12288;
							                	<a href="javascript:opreResRec({'recFlow':'${rec.recFlow}','statusId':'${recStatusEnumSubmit.id}'},'${resRecTypeEnumCampaignRegistry.id}');" style="color: blue">提交</a>
												&#12288;
												<a href="javascript:opreResRec({'recFlow':'${rec.recFlow}','recordStatus':'${GlobalConstant.RECORD_STATUS_N}'},'${resRecTypeEnumCampaignRegistry.id}');" style="color: blue">删除</a>
							                </c:if>
							                </span>
							                <a href="#" style="color: blue">审核意见</a>
						                	</td>
						                </tr>
						               </c:forEach>
						               <c:if test="${empty recList}">
											<tr><td colspan="7">无记录</td></tr>
										</c:if>
						 </table>
					 </c:if>
					 
				</div>
		       	</div>
			</div>
		</div>
	</body>
</html>