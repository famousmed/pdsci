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
<script type="text/javascript">
	function save(){
		jboxConfirm("确认保存快审主审综合意见？",function(){
			var saveForm = $("#saveForm");
			if(saveForm.validationEngine("validate")){
				var url= "<s:url value='/irb/secretary/saveQuickOpinion'/>";
				var requestData=saveForm.serialize();
				jboxPost(url,requestData,function(resp){
					if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
						window.location.href="<s:url value='/irb/committee/list/${GlobalConstant.IRB_COMMITTEE_SECRETARY}'/>";
					}
				},null,true);
			}
		},null);
	}
	function changeReviewWay(obj){
		var typeId = $(obj).val();
		if(typeId=='${irbReviewTypeEnumFast.id}'){
			$("#tr_reviewWay").show();
			$("#tr_reviewOpinion").show();
			$("#print_input").show();
		}else{
			$("#tr_reviewWay").hide();
			$("#tr_reviewOpinion").hide();
			$("#print_input").hide();
		}
	}
	function showWorkSheet(irbFlow,authId,recordFlow,userName){
		jboxOpen('<s:url value="/irb/committee/irbWorksheet"/>?irbFlow='+irbFlow+'&irbAuthTypeId='+authId+'&irbUserFlow='+recordFlow+'&open=${GlobalConstant.FLAG_Y}&source=quickOpinion',"审查工作表（"+userName+"）",850,650);
	}
	function print(){
		var url ="<s:url value='/irb/printOther'/>?watermarkFlag=${GlobalConstant.FLAG_N}&irbFlow=${irb.irbFlow}&recTypeId=${irbRecTypeEnumQuickOpinion.id}";
		window.location.href= url;
	}
	
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
	<form id="saveForm">
<div class="title1 clearfix">
		<table class="xllist" width="450px">
				<tr>
					<th colspan="4" align="left">&#12288;快审主审综合意见</th>
				</tr>
				<tr>
					<td width="15%">伦理委员会名称：</td><td colspan="3" style="text-align: left; padding-left: 20px;">${irbInfo.irbName}</td>
				</tr>
				<tr>
					<td>项目名称：</td><td colspan="3" style="text-align: left; padding-left: 20px;">${irb.projName}&#12288;&#12288;${irb.projSubTypeName}&#12288;&#12288;${irb.projDeclarer}</td>
				</tr>
				<tr>
					<td width="15%">伦理审查类别：</td><td colspan="3" style="text-align: left; padding-left: 20px;">${irb.irbTypeName}</td>
				</tr>
				<tr>
					<td width="15%">受理号：</td><td colspan="3" style="text-align: left; padding-left: 20px;">${irb.irbNo}</td>
				</tr>
				<tr>
					<th width="15%">主审委员</th>
					<th width="25%">审查决定</th>
					<th width="45%">审查意见</th>
					<th width="15%">审查工作表</th>
				</tr>
				<c:forEach items="${irbUserList }" var="irbUser">
					<c:if test="${irbUser.authId!=irbAuthTypeEnumConsultant.id }">
						<tr>
							<td width="15%">
							${irbUser.userName }<c:if test="${irbUser.authId==irbAuthTypeEnumCommitteePRO.id }">：方案</c:if><c:if test="${irbUser.authId==irbAuthTypeEnumCommitteeICF.id }">：知情同意书</c:if>
							</td>
							<td>
								<span id="authDecision_${irbUser.recordFlow }">${irbUser.authDecision }</span>
							</td>
							<td>
								<span id="authNote_${irbUser.recordFlow }">${irbUser.authNote }</span>
							</td>
							<td style="width:25%">
								[<a href="javascript:showWorkSheet('${irb.irbFlow }','${irbUser.authId }','${irbUser.recordFlow }','${irbUser.userName }');">审查工作表</a>]
							</td>
						</tr>
					</c:if>
				</c:forEach>
				<tr>
					<td width="15%">审查流程：</td><td colspan="3" style="text-align: left;padding-left: 20px;">
						<c:if test="${!empty irb.irbDecisionId }">
							<c:if test="${irb.meetingArrange==irbReviewTypeEnumFast.id }">
								${irbReviewTypeEnumFast.arrange }
							</c:if>
							<c:if test="${irb.meetingArrange==irbReviewTypeEnumMeeting.id }">
								${irbReviewTypeEnumMeeting.arrange }
							</c:if>
						</c:if>
						<c:if test="${empty irb.irbDecisionId }">
							<select name="reviewWayId" class="xlselect" onchange="changeReviewWay(this)">
								<option value="${irbReviewTypeEnumFast.id }">${irbReviewTypeEnumFast.arrange }</option>
								<option value="${irbReviewTypeEnumMeeting.id }">${irbReviewTypeEnumMeeting.arrange }</option>
							</select>
						</c:if>
					</td>
				</tr>
				<tr id="tr_reviewWay">
					<td width="15%">审查决定：</td><td colspan="3" style="text-align: left;padding-left: 20px;">
					<c:choose>
						<c:when test="${!empty irb.irbDecisionId }">${irb.irbDecisionName }</c:when>
						<c:otherwise>
							<c:forEach items="${irbDecisionEnumList }" var="dec" varStatus="statu">
								<c:if test="${pdfn:countMatches(dec.irbTypeId,irb.irbTypeId)==1 }">
									<input type="radio" name="irbDecisionId" id="irbDecisionId_${statu.count }" value="${dec.id }" <c:if test="${statu.first }">checked="checked"</c:if> /><label style="margin-right: 10px;" for="irbDecisionId_${statu.count }" >${dec.name }</label>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr id="tr_reviewOpinion">
					<td width="15%">审查意见：</td>
					<td colspan="3" style="text-align: left; padding-left: 20px;">
					<c:choose>
						<c:when test="${!empty irb.irbDecisionId }"><pre style="font-family: Microsoft Yahei;">${qForm.reviewOpinion }</pre></c:when>
						<c:otherwise>
							<textarea name="reviewOpinion" rows="3" style="width: 400px; margin: 3px 0;"></textarea>
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
					<td width="15%">秘书签字：</td>
					<td colspan="3" style="text-align: left;padding-left: 20px;">
					<c:choose>
						<c:when test="${!empty irb.irbDecisionId }">${qForm.operUserName }</c:when>
						<c:otherwise>${empty qForm.operUserName?sessionScope.currUser.userName:qForm.operUserName }</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
					<td width="15%">日期：</td>
					<td colspan="3" style="text-align: left;padding-left: 20px;">
					<c:choose>
						<c:when test="${!empty irb.irbDecisionId }">${irb.irbReviewDate }</c:when>
						<c:otherwise><input type="text" name="operTime" class="validate[required] text-input xltext ctime" value="${pdfn:getCurrDate()}"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"></c:otherwise>
					</c:choose>
					</td>
				</tr>
		</table>
		<div class="button">
			<input type="hidden" name="irbFlow" value="${param.irbFlow }" />
			<c:if test="${empty irb.irbDecisionId}">
			<input type="button" class="search" onclick="save()" value="保&#12288;存">
			</c:if>
			<input class="search" id="print_input" showFlag="${GlobalConstant.FLAG_Y }" type="button" value="打&#12288;印" onclick="print();" />
		</div>
	</div>
	</form>
	</div></div>
</body>
</html>