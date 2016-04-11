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
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<style>
.edit{background-color:#ECF2FA;text-align: left;border:none;}
.edit3{text-align: left;border:none;}
</style> 
<script type="text/javascript">
function changeStyle(obj,stylename){
	$(obj).removeClass(stylename);
}
	function uploadFile(){
		jboxOpen("<s:url value='/irb/researcher/applyFile'/>", "上传文件", 700,300);
	}
	function irbApply(){
		jboxConfirm("确认提交 复审  申请?",function(){
			$("#fsTable").append("<tr style='cursor: pointer;'><td>申请</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>");
		});
	}
	function approveFile(){
		<c:choose>
		<c:when test="${pdfn:getProcessClass(sessionScope.currIrb.irbStageId,irbStageEnumArchive.id) eq '2'}">
			jboxOpen("<s:url value='/irb/secretary/decisionDetail'/>?irbFlow=${sessionScope.currIrb.irbFlow}&type=view", "决定文件", 700,600);
		</c:when>
		<c:otherwise>
			jboxTip("本次伦理审查暂未传达决定!");
		</c:otherwise>
		</c:choose>
	}
	function viewIrbFile(){
		jboxOpen("<s:url value='/irb/committee/viewIrbFile'/>","送审文件",1000,600);
	}
	function irbUserList(){
		jboxOpen("<s:url value='/irb/researcher/irbUserList'/>","研究团队",1000,600);
	}
	function apply(){
		//jboxOpen("<s:url value='/irb/researcher/apply'/>?pjType=YW","审查申请表",1050,600);
		window.location.href="<s:url value='/irb/researcher/applyMain'/>?projFlow=${proj.projFlow}&roleScope=${param.roleScope}&from=${param.from}";
	}
	function receiptNotice(){
		jboxOpen("<s:url value='/irb/secretary/receiptNotice'/>","受理通知",600,500);
	}
	function irbMemberList(){
		jboxOpen("<s:url value='/irb/secretary/irbMemberList'/>","伦理委员会成员名单",600,500);
	}
	function selectCommittee(){
		jboxOpen("<s:url value='/irb/secretary/selectCommittee'/>","选择主审委员/独立顾问",400,350);
	}
	function voteDesction(){
		jboxOpen("<s:url value='/irb/meeting/voteDesction'/>","投票结果",800,600);
	}
	function quickOpinion(){
		jboxOpen("<s:url value='/irb/secretary/quickOpinion'/>","快审主审综合意见",500,450);
	}
	function archiveFile(){
		jboxOpen("<s:url value='/irb/secretary/archiveFile'/>","文件存档",750,600);
	}
	
	function doApply(){
		jboxOpen("<s:url value='/irb/researcher/doApply'/>?projFlow=${proj.projFlow}&roleScope=${param.roleScope}","伦理审查申请",400,150);
	}
	$(document).ready(function(){
		$("#"+'${sessionScope.currIrb.irbTypeId}').parent().addClass("selectTag");
		//$("#"+'${sessionScope.currIrb.irbTypeId}').click(); 
	});
	function showIrb(irbTypeId){
		window.location.href="<s:url value='/irb/researcher/process'/>?projFlow=${proj.projFlow}&irbTypeId="+irbTypeId+"&roleScope=${param.roleScope}";
		//$("#tagContent").html();
	}
	function selectIrb(irbFlow,irbTypeId){
		window.location.href="<s:url value='/irb/researcher/process'/>?projFlow=${proj.projFlow}&irbTypeId="+irbTypeId+"&irbFlow="+irbFlow+"&roleScope=${param.roleScope}";
	}
	function doBack(){
		if ("${sessionScope.currWsId}" == "${GlobalConstant.GCP_WS_ID}") {
			window.location.href="<s:url value='/gcp/proj/projInfo'/>?roleScope=${param.roleScope}&projFlow=${proj.projFlow}";
		} else {
			window.location.href="<s:url value='/irb/researcher/list/${param.roleScope}?quickDatePickType=Month'/>";
		}
	}
	function modIrbApplyDate(irbFlow,obj){
		$(obj).addClass("edit3");
		if($(obj).val()==$(obj).attr("oldvalue")){
			return;
		}
		var data = {
				irbFlow:irbFlow,
				irbApplyDate:$(obj).val()
		};
		jboxPost("<s:url value='/irb/secretary/modIrbApply'/>",data,null,null,true);
		$(obj).attr("oldvalue",$(obj).val());
	}
	function modIrbAcceptedDate(irbFlow,obj){
		$(obj).addClass("edit3");
		if($(obj).val()==$(obj).attr("oldvalue")){
			return;
		}
		var data = {
				irbFlow:irbFlow,
				irbAcceptedDate:$(obj).val()
		};
		jboxPost("<s:url value='/irb/secretary/modIrbApply'/>",data,null,null,true);
		$(obj).attr("oldvalue",$(obj).val());
	}
	function modIrbNo(irbFlow,obj){
		$(obj).addClass("edit3");
		if($(obj).val()==$(obj).attr("oldvalue")){
			return;
		}
		var data = {
				irbFlow:irbFlow,
				irbNo:$(obj).val()
		};
		jboxPost("<s:url value='/irb/secretary/modIrbApply'/>",data,null,null,true);
		$(obj).attr("oldvalue",$(obj).val());
	}
	function modIrbDecisionDate(irbFlow,obj){
		$(obj).addClass("edit3");
		if($(obj).val()==$(obj).attr("oldvalue")){
			return;
		}
		var data = {
				irbFlow:irbFlow,
				approveValidity:$("#approveValidity").val(),
				irbDecisionDate:$(obj).val()
		};
		jboxPost("<s:url value='/irb/secretary/modIrbApply'/>",data,null,null,true);
		$(obj).attr("oldvalue",$(obj).val());
	}
	function modIrbTrackDate(irbFlow,obj){
		$(obj).addClass("edit3");
		var trackdate = $(obj).val();
		if(trackdate==$(obj).attr("oldvalue")){
			return;
		}
		var data = {
				irbFlow:irbFlow,
				trackDate:trackdate
		}; 
		jboxPost("<s:url value='/irb/secretary/modIrbApply'/>",data,function(){
			$("#trackDateSpanRmaind").html(trackdate);
		},null,true);
		$(obj).attr("oldvalue",$(obj).val());
	}
	function modIrbStage(){
		jboxOpen("<s:url value='/irb/secretary/modIrbStage'/>?irbFlow=${sessionScope.currIrb.irbFlow}&stageId=${sessionScope.currIrb.irbStageId}","状态调整",300,150);
	}
	
</script>
</head>
<body> 
	<div class="mainright">
		<div class="content">
			<div style="margin-top: 5px">
				&#12288;项目名称：<b>${proj.projShortName }</b>  &#12288; 期类别：<b>${ proj.projSubTypeName}</b> &#12288; 项目来源：<b>${proj.projDeclarer }</b>
			</div>
			<div class="title1 clearfix">
				<ul id="tags">
					<c:forEach items="${irbTypeList }" var="irbTypeId">
						<li><a id="${irbTypeId }"
							onclick="showIrb('${irbTypeId}');" href="javascript:void(0);">
								${pdfn:getIrbTypeNameById(irbTypeId)}</a> 
						</li>
					</c:forEach>
						<input type="button" onclick="doApply();" value="伦理审查申请" class="search"/>
						<input type="button"  class="search" value="返&#12288;回" onclick="doBack();"/> 
					</ul>
					<div id="tagContent">
						<div class="tagContent selectTag" id="tagContent1">
						<!-- 初始审查 -->
						<c:choose>
							<c:when test="${sessionScope.currIrb.irbTypeId == irbTypeEnumInit.id }">
								<table class="tableStyle">
									<tr><th colspan="5" style="text-align: left;padding-left: 20px;">审查结果</th></tr>
									<tr>
			                           <td width="200px" style="text-align: left;">
			                           &#12288;提交审查日期：
				                           <c:if test="${param.roleScope != GlobalConstant.USER_LIST_GLOBAL}">
				                           		${sessionScope.currIrb.irbApplyDate}
				                           	</c:if>
				                           	<c:if test="${param.roleScope ==  GlobalConstant.USER_LIST_GLOBAL}">
				                           		<input type="text" class="edit3" onfocus="changeStyle(this,'edit3');" 
				                           			onblur="modIrbApplyDate('${sessionScope.currIrb.irbFlow}',this);"
				                           		oldvalue="${sessionScope.currIrb.irbApplyDate }" style="width: 100px;" name="irbApplyDate" value="${sessionScope.currIrb.irbApplyDate}"/>
				                           	</c:if>
			                           	</td>
			                          <td width="200px" style="text-align: left;">&#12288;受理日期：
			                           		<c:if test="${param.roleScope != GlobalConstant.USER_LIST_GLOBAL}">
				                           		${sessionScope.currIrb.irbAcceptedDate }
				                           	</c:if>
				                           	<c:if test="${param.roleScope ==  GlobalConstant.USER_LIST_GLOBAL}">
				                           		<input type="text" class="edit3" onfocus="changeStyle(this,'edit3');" 
				                           			onblur="modIrbAcceptedDate('${sessionScope.currIrb.irbFlow}',this);"
				                           		oldvalue="${sessionScope.currIrb.irbAcceptedDate }" style="width: 100px;" name="irbApplyDate" value="${sessionScope.currIrb.irbAcceptedDate }"/>
				                           	</c:if>
			                          </td>
			                           <td width="200px" style="text-align: left;">&#12288;受理号：
			                           		<c:if test="${param.roleScope != GlobalConstant.USER_LIST_GLOBAL}">
				                           		 	${sessionScope.currIrb.irbNo }
				                           	</c:if>
				                           	<c:if test="${param.roleScope ==  GlobalConstant.USER_LIST_GLOBAL}">
				                           		<input type="text" class="edit3" onfocus="changeStyle(this,'edit3');" 
				                           			onblur="modIrbNo('${sessionScope.currIrb.irbFlow}',this);"
				                           		oldvalue="${sessionScope.currIrb.irbNo }" style="width: 100px;" name="irbApplyDate" value="${sessionScope.currIrb.irbNo }"/>
				                           	</c:if>
			                          </td> 
			                           <td width="200px"  style="text-align: left;">
										&#12288;伦理委员会：${irbInfo.irbName}
										</td>
			                           <td width="80px" style="text-align: right" rowspan="3">
										  <img src="<s:url value='/css/skin/${skinPath}/images/irb_jdwj.png'/>" onclick="approveFile();" title="批件/意见" style="cursor: pointer;"/>
										</td>
		                       		 </tr>
									<tr>
										<td width="200px" style="text-align: left;">&#12288;审查方式：${sessionScope.currIrb.reviewWayName}</td>
				                      <c:choose>
				                      	<c:when test="${param.roleScope ==  GlobalConstant.USER_LIST_GLOBAL }">
				                        <td width="200px" style="text-align: left;">
				                           &#12288;主审委员：<c:forEach items="${irbCommitteeMap[sessionScope.currIrb.irbFlow]}" var="irbUser" varStatus="statu">
				                           ${irbUser.userName}<c:if test="${fn:length(irbCommitteeMap[sessionScope.currIrb.irbFlow])>1&&!statu.last}">、</c:if>
				                           </c:forEach>
				                        </td>
				                        <td width="200px" style="text-align: left;">&#12288;主审意见：
				                        	<c:forEach items="${irbCommitteeMap[sessionScope.currIrb.irbFlow]}" var="irbUser" varStatus="statu">
				                           	${irbUser.userName}：${irbUser.authDecision }
				                           	<c:if test="${fn:length(irbCommitteeMap[sessionScope.currIrb.irbFlow])>1&&!statu.last && !empty irbUser.authDecision}"><br>&#12288;
				                           	</c:if>
				                           </c:forEach>
				                           </td>
				                        <td width="200px" style="text-align: left;">&#12288;会议日期：${sessionScope.currIrb.meetingDate}</td>
				                           </c:when>
				                           <c:otherwise>
				                            <td width="200px" style="text-align: left;">&#12288;会议日期：${sessionScope.currIrb.meetingDate}</td>
				                            <td></td>
				                            <td></td>
				                           </c:otherwise>
		                         	 	</c:choose>
		                        	 </tr>
			                         <tr>
			                         	 <td width="200px" style="text-align: left;">&#12288;审查结果：${sessionScope.currIrb.irbDecisionName}</td>
			                             <td width="200px" style="text-align: left;">&#12288;批件/意见日期：
			                             	<c:if test="${pdfn:getProcessClass(sessionScope.currIrb.irbStageId,irbStageEnumArchive.id) eq '2'}">
				                             	<c:if test="${param.roleScope != GlobalConstant.USER_LIST_GLOBAL}">
				                             		${sessionScope.currIrb.irbDecisionDate}
				                             	</c:if>
				                             	 <c:if test="${param.roleScope ==  GlobalConstant.USER_LIST_GLOBAL}">
				                             	 		<input type="text" id="irbDecisionDate" class="edit3" onfocus="changeStyle(this,'edit3');" 
					                           			onblur="modIrbDecisionDate('${sessionScope.currIrb.irbFlow}',this);"
					                           		oldvalue="${sessionScope.currIrb.irbDecisionDate }" style="width: 100px;" name="irbDecisionDate" value="${sessionScope.currIrb.irbDecisionDate }"/>
				                             	 </c:if>
			                             	 </c:if>
			                             	 <input type="hidden" id="approveValidity" name="approveValidity" value="${sessionScope.currIrb.approveValidity }">
			                             </td>
			                           	 <td width="200px" style="text-align: left;">&#12288;跟踪审查日期：
			                           	 <c:if test="${!empty sessionScope.currIrb.approveDate }">
				                           	 <c:if test="${pdfn:getProcessClass(sessionScope.currIrb.irbStageId,irbStageEnumArchive.id) eq '2'}">
					                           	 <c:if test="${param.roleScope != GlobalConstant.USER_LIST_GLOBAL}">
					                           	 ${sessionScope.currIrb.trackDate}
					                           	 </c:if>
					                           	 <c:if test="${param.roleScope ==  GlobalConstant.USER_LIST_GLOBAL}">
						                           	<input type="text" id="trackDate" class="edit3" onfocus="changeStyle(this,'edit3');" 
						                           		onblur="modIrbTrackDate('${sessionScope.currIrb.irbFlow}',this);"
						                           		oldvalue="${sessionScope.currIrb.trackDate }" style="width: 100px;" name="trackDate" value="${sessionScope.currIrb.trackDate }"/>
						                         </c:if>
					                         </c:if>
			                           	 </c:if>
			                           	 <c:if test="${empty sessionScope.currIrb.approveDate }">
			                           	 <input type="hidden" id="trackFrequency" name="trackFrequency" value="">
			                           	 </c:if>
			                           	 </td>
			                          	 <td width="200px" style="text-align: left;">
			                          	 	&#12288;决定文件：<c:if test="${pdfn:getProcessClass(sessionScope.currIrb.irbStageId,irbStageEnumFiling.id) eq '2' }">
													<c:if test="${empty sessionScope.currIrb.approveDate}">意见</c:if>
													<c:if test="${!empty sessionScope.currIrb.approveDate}">批件</c:if>	
												</c:if>
										</td>
			                         </tr>
								</table>
							</c:when>
							<c:otherwise>
								<c:if test="${fn:length(irbList)>1 }">
								<div style="color:blue;padding-bottom: 5px;">Tip：蓝色为当前选中伦理审查,点击列表切换.</div>
								</c:if>
								<table class="xllist" width="600">
								<tr>
									<th width="150px">状态</th>
									<th width="150px">提交审查日期</th>
									<th width="150px">受理日期</th>
									<!-- 
									<th width="150px">主审委员</th>
									 -->
									<th width="150px">审查方式</th>
									<th width="150px">审查结果</th>
									<th width="150px">决定文件</th>
								</tr>
								<c:forEach items="${irbList}" var="irb" varStatus="status">
								<tr style="cursor: pointer;<c:if test='${sessionScope.currIrb.irbFlow == irb.irbFlow && fn:length(irbList)>1}'> background-color: #F0FFFF</c:if>" onclick="selectIrb('${irb.irbFlow}','${irb.irbTypeId }');">
									<td>${irb.irbStageName}</td>
									<td>${irb.irbApplyDate}</td>
									<td>${irb.irbAcceptedDate}</td>
									<!-- 
									<td><c:forEach items="${irbCommitteeMap[irb.irbFlow]}" var="irbUser" varStatus="statu">
				                           ${irbUser.userName}<c:if test="${fn:length(irbCommitteeMap[irb.irbFlow])>1&&!statu.last}">、</c:if></c:forEach></td>
									 -->
									<td>${irb.reviewWayName}</td>
									<td>${irb.irbDecisionName}</td>
									<td>
										<c:if test="${pdfn:getProcessClass(irb.irbStageId,irbStageEnumArchive.id) eq '2' }">
											<c:if test="${empty irb.approveDate}">意见</c:if>
											<c:if test="${!empty irb.approveDate}">批件</c:if>	
										</c:if>
									</td>
								</tr>
								</c:forEach>
							</table>
							</c:otherwise>
						</c:choose>
				
				<div class="flow_list" id="icn">
				<!-- 当前伦理审查进度 -->
				<ul>
			    	<li class="list_1_2" ><span>1</span><br/>申请/报告</li>
			        <li class="list_2_${pdfn:getProcessClass(sessionScope.currIrb.irbStageId,irbStageEnumHandle.id) }"><span>2</span><br/>受理/处理</li>
			        <li class="list_2_${pdfn:getProcessClass(sessionScope.currIrb.irbStageId,irbStageEnumReview.id) }"><span>3</span><br/>审查</li>
			        <li class="list_2_${pdfn:getProcessClass(sessionScope.currIrb.irbStageId,irbStageEnumDecision.id) }"><span>4</span><br/>传达决定</li>
			       <li class="list_2_${pdfn:getProcessClass(sessionScope.currIrb.irbStageId,irbStageEnumArchive.id) }"><span>5</span><br/>文件存档</li>
			   		<li class="list_3_${pdfn:getProcessClass(sessionScope.currIrb.irbStageId,irbStageEnumFiling.id) }" style="width: 112px;"><span style="padding-left: 50px;">6</span><br/>归档</li>
			    </ul>
				</div> 
				
					<div style="margin-top: 20px;">
						<table class="xllist">
							<tr><th colspan="2" style="text-align: left;padding-left: 20px;">审查信息&#12288;
							</th></tr>
							<tr>
								<td style="text-align: center;" width="200px">
								<c:if test="${pdfn:getProcessClass(sessionScope.currIrb.irbStageId,irbStageEnumHandle.id) eq '1'}" >
								<a href="<s:url value='/irb/researcher/applyMain'/>?projFlow=${proj.projFlow}&roleScope=${param.roleScope}&irbFlow=${sessionScope.currIrb.irbFlow}" style="color: blue;cursor: pointer;">申请/报告</a>
								</c:if>
								<c:if test="${pdfn:getProcessClass(sessionScope.currIrb.irbStageId,irbStageEnumHandle.id) eq '2'}" >
								申请报告
								</c:if>
								</td>
								<td style="text-align: left;padding-left: 30px;">
								<c:if test="${pdfn:getProcessClass(sessionScope.currIrb.irbStageId,irbStageEnumHandle.id) eq '2'}" >
									<a href="<s:url value='/irb/researcher/showMain'/>?projFlow=${proj.projFlow}&type=apply&id=projInfo&roleScope=${param.roleScope}" target="_blank" style="color: blue">项目基本信息</a>&#12288;|&#12288;
									<a href="<s:url value='/irb/researcher/showMain'/>?projFlow=${proj.projFlow}&type=apply&id=applyTable" target="_blank" style="color: blue">审查申请表</a>&#12288;|&#12288;
									<a href="<s:url value='/irb/researcher/showMain'/>?projFlow=${proj.projFlow}&type=apply&id=applyFile" target="_blank" style="color: blue">送审文件</a>&#12288;|&#12288;
									<a href="<s:url value='/irb/researcher/showMain'/>?projFlow=${proj.projFlow}&type=apply&id=projUser" target="_blank" style="color: blue">研究团队</a>
									<c:if test="${noticeFlag}" >
										&#12288;|&#12288;<a href="<s:url value='/irb/researcher/showMain'/>?projFlow=${proj.projFlow}&type=apply&id=modifyNotice" target="_blank" style="color: blue">补充修改通知</a>
									</c:if>
								</c:if>
								<c:if test="${pdfn:getProcessClass(sessionScope.currIrb.irbStageId,irbStageEnumHandle.id) eq '1'}" >
									<font color="red">该次审查暂未提交送审，请编辑&nbsp;
									<a href="<s:url value='/irb/researcher/applyMain'/>?projFlow=${proj.projFlow}&roleScope=${param.roleScope}&irbFlow=${sessionScope.currIrb.irbFlow}" style="color: blue;cursor: pointer;">申请/报告</a>&nbsp;！
									</font>
								</c:if>
								</td>
							</tr>
							<tr>
								<td style="text-align: center;">受理/处理</td>
								<td style="text-align: left;padding-left: 30px;">
								 <c:choose>
				                    <c:when test="${param.roleScope ==  GlobalConstant.USER_LIST_GLOBAL }">
										<c:if test="${pdfn:getProcessClass(sessionScope.currIrb.irbStageId,irbStageEnumReview.id) eq '2'}" >
											<a href="<s:url value='/irb/researcher/showMain'/>?projFlow=${proj.projFlow}&type=accept&id=accptNotice" target="_blank" style="color: blue">受理通知</a>&#12288;|&#12288;
											<a href="<s:url value='/irb/researcher/showMain'/>?projFlow=${proj.projFlow}&type=accept&id=reviewWay" target="_blank" style="color: blue">审查方式</a>&#12288;|&#12288;
											<a href="<s:url value='/irb/researcher/showMain'/>?projFlow=${proj.projFlow}&type=accept&id=committee" target="_blank" style="color: blue">主审委员/独立顾问</a>
										</c:if>
									</c:when>
								</c:choose>
								</td>
							</tr>
							<tr>
								<td style="text-align: center;">审查</td>
								<td style="text-align: left;padding-left: 30px;">
								<c:choose>
				                    <c:when test="${param.roleScope ==  GlobalConstant.USER_LIST_GLOBAL }">
										<c:if test="${pdfn:getProcessClass(sessionScope.currIrb.irbStageId,irbStageEnumDecision.id) eq '2'}" >
											<c:forEach items="${irbUserList}" var="irbUser">
											<a href="<s:url value='/irb/researcher/showMain'/>?projFlow=${proj.projFlow}&type=review&id=${irbUser.authId }_${irbUser.recordFlow}" target="_blank" style="color: blue">
												<c:if test="${irbUser.authId==irbAuthTypeEnumCommitteePRO.id }">方案审查表_${irbUser.userName }</c:if>
												<c:if test="${irbUser.authId==irbAuthTypeEnumCommitteeICF.id }">知情同意书审查表_${irbUser.userName }</c:if>
												<c:if test="${irbUser.authId==irbAuthTypeEnumCommittee.id }">审查工作表_${irbUser.userName }</c:if>
												<c:if test="${irbUser.authId==irbAuthTypeEnumConsultant.id }">独立顾问咨询表_${irbUser.userName }</c:if>
											</a>&#12288;|&#12288;
											</c:forEach>
											<c:if test="${sessionScope.currIrb.reviewWayId == irbReviewTypeEnumFast.id }">
												<a href="<s:url value='/irb/researcher/showMain'/>?projFlow=${proj.projFlow}&type=review&id=quickOpinion" target="_blank" style="color: blue">快速主审综合意见</a>&#12288;|&#12288;
											</c:if>
											<c:if test="${sessionScope.currIrb.meetingArrange==irbReviewTypeEnumMeeting.id }" >
												<a href="<s:url value='/irb/researcher/showMain'/>?projFlow=${proj.projFlow}&type=review&id=meetingDecision" target="_blank" style="color: blue">会议审查决定表</a>&#12288;|&#12288;
										    </c:if>
											<a href="<s:url value='/irb/researcher/showMain'/>?projFlow=${proj.projFlow}&type=review&id=meetingRecord" target="_blank" style="color: blue">会议记录</a>
										</c:if>
									</c:when>
								</c:choose>
								</td>
							</tr>
							<tr>
								<td style="text-align: center;">传达决定</td>
								<td style="text-align: left;padding-left: 30px;">
								<c:if test="${pdfn:getProcessClass(sessionScope.currIrb.irbStageId,irbStageEnumArchive.id) eq '2'}" >
				                    <c:if test="${param.roleScope ==  GlobalConstant.USER_LIST_GLOBAL }">
									    <a href="<s:url value='/irb/researcher/showMain'/>?projFlow=${proj.projFlow}&type=decision&id=approveFile" target="_blank" style="color: blue">
											<c:if test="${irbRecTypeEnumOpinionFile.id == fileType}">${irbRecTypeEnumOpinionFile.name}</c:if>
											<c:if test="${irbRecTypeEnumApproveFile.id == fileType}">${irbRecTypeEnumApproveFile.name}</c:if>			
										</a>&#12288;|&#12288;
								   		 <a href="<s:url value='/irb/researcher/showMain'/>?projFlow=${proj.projFlow}&type=decision&id=irbUsers" target="_blank" style="color: blue">IRB成员名单</a>
									</c:if>
								</c:if>
								</td>
							</tr>
							<tr>
								<td style="text-align: center;">文件存档</td>
								<td style="text-align: left;padding-left: 30px;">
								 <c:if test="${param.roleScope ==  GlobalConstant.USER_LIST_GLOBAL }">
									<c:if test="${pdfn:getProcessClass(sessionScope.currIrb.irbStageId,irbStageEnumFiling.id) eq '2'}" >
										<a href="<s:url value='/irb/researcher/showMain'/>?projFlow=${proj.projFlow}&type=archive&id=archiveFile" target="_blank" style="color: blue">文件存档</a>
									</c:if>
								</c:if>
								</td>
							</tr>
							<tr>
								<td style="text-align: center;">跟踪审查</td>
								<td style="text-align: left;padding-left: 30px;color: red">
									<c:if test="${!empty sessionScope.currIrb.trackDate}">
										请于&#12288;<span id="trackDateSpanRmaind">${sessionScope.currIrb.trackDate }</span>&#12288;前一个月提交年度/定期研究进展报告
									</c:if>
								</td>
							</tr>
							<c:if test="${param.roleScope ==  GlobalConstant.USER_LIST_GLOBAL && sessionScope.currIrb.irbStageId != irbStageEnumApply.id}">
							<tr> 
								<td style="text-align: center;">其他操作</td>
								<td style="text-align: left;padding-left: 30px;">
									<a href="<s:url value='/irb/researcher/applyMain'/>?projFlow=${proj.projFlow}&roleScope=${param.roleScope}&irbFlow=${sessionScope.currIrb.irbFlow}&operType=edit"  style="color: blue;cursor: pointer;">修改申请信息</a>
									<c:if test="${pdfn:getProcessClass(sessionScope.currIrb.irbStageId,irbStageEnumReview.id) eq '2'}">
										&#12288;|&#12288;<a href="<s:url value='/irb/secretary/chooseMember'/>?roleScope=${param.roleScope}&irbFlow=${sessionScope.currIrb.irbFlow}&operType=edit"  style="color: blue;cursor: pointer;">修改主审委员/独立顾问</a>
									</c:if>
									<c:if test="${pdfn:getProcessClass(sessionScope.currIrb.irbStageId,irbStageEnumArchive.id) eq '2'}">
										<c:if test="${sessionScope.currIrb.meetingArrange==irbReviewTypeEnumMeeting.id }" >
										&#12288;|&#12288;<a href="<s:url value='/irb/meeting/voteDesction'/>?roleScope=${param.roleScope}&irbFlow=${sessionScope.currIrb.irbFlow}&operType=edit&closeButton=${GlobalConstant.FLAG_N}"  style="color: blue;cursor: pointer;">修改会议审查决定表</a>
										</c:if>
									</c:if>
									<!-- <a href="javascript:modIrbStage();" style="color: blue">切换状态</a> -->
								</td>
							</tr>
							</c:if>
						</table>
					</div>
				
				
						</div>
					</div>
				</div>
			</div>
		</div>
</body>
</html>