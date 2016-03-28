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
	<jsp:param name="jquery_fixedtable" value="true"/>
</jsp:include>
<script type="text/javascript">
function doClose() {
	jboxClose();
}
function showDetail(){
	$("#detailTable").slideToggle("slow");
}

function save(){
	jboxConfirm("审查决定保存后不可修改，确认保存？",function(){
		var url = "<s:url value='/irb/meeting/saveVoteDecision' />";
		var inputs = $("input[name='userFlows']");
		var values = [];
		inputs.each(function(){
			value = this.value;
			var obj = {"userFlow":value,"decisionId":$("#decisionId_"+value).val(),"conflict":$("#conflict_"+value).val(),"userName":$("#userName_"+value).val()};
			values.push(obj);
		});
		var mDecisionId = $("input[name='mDecisionId']:checked").val();
		var requestData= {"irbFlow":$("#irbFlow").val(),"meetingFlow":$("#meetingFlow").val(),"voteList":values,"mDecisionId":mDecisionId,'operType':'${param.operType}'};
		jboxPostJson(url,JSON.stringify(requestData),function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				if ('edit' == '${param.operType}') {
					doBack();
				} else {
					window.parent.frames["mainIframe"].window.reload();
					doClose();
				}
			}
		},null,true);
	},null);
}

function chooseTd(obj,decisionId,userFlow){
	var thisTd = $(obj); 
	var flag = true;
	if (thisTd.attr("class") == "chooseTd") {
		flag = false;
	}
	//改样式
	var tds = thisTd.parent("tr").children();
	var oldDec = "";
	tds.each(function(){
		if ($(this).attr("class") == "chooseTd") {
			if ($(this) != thisTd) {
				oldDec = $(this).attr("decId");
			}
			$(this).removeClass("chooseTd");
		} 
	});
	
	//为后台取值做准备
	if (flag) {
		if (decisionId == 'conflict') {
			$("#conflict_"+userFlow).val('${GlobalConstant.FLAG_Y}');
			$("#decisionId_"+userFlow).val('');
		} else {
			$("#decisionId_"+userFlow).val(decisionId);
			$("#conflict_"+userFlow).val('');
		}
	} else {
		$("#conflict_"+userFlow).val('');
		$("#decisionId_"+userFlow).val('');
	}
	
	//改变票数（原选项）
	if (oldDec != '') {
		var oldVoteCount = $("#"+oldDec+"_voteCount").val();
		if (flag) {
			oldVoteCount = parseInt(oldVoteCount) - 1;
		}
		$("#"+oldDec+"_vote").html(oldVoteCount);
		$("#"+oldDec+"_voteCount").val(oldVoteCount);
	}
	//改变票数（现选项）
	var voteCount = $("#"+decisionId+"_voteCount").val();
	if (flag) {
		thisTd.addClass("chooseTd");
		voteCount = parseInt(voteCount) + 1;
	} else {
		voteCount = parseInt(voteCount) - 1;
	}
	$("#"+decisionId+"_vote").html(voteCount);
	$("#"+decisionId+"_voteCount").val(voteCount);
	
	//改变会议决定(最多票数的被选中)
	var maxCount = '0';
	var maxDecId = '';
	$("[name='voteCount']").each(function(){
		if (parseInt(maxCount) < parseInt($(this).val())) {
			maxCount = $(this).val();
			maxDecId = $(this).attr("decId");
		}
	});
	if (maxDecId != '') {
		$("#irbDecisionId_"+maxDecId).attr("checked","checked");
	}
}

function print(){
	var url ="<s:url value='/irb/printOther'/>?watermarkFlag=${GlobalConstant.FLAG_N}&irbFlow=${irbForm.irb.irbFlow}&recTypeId=${irbRecTypeEnumMeetingDecision.id}";
	window.location.href= url;
}

function doBack(){
	window.location.href="<s:url value='/irb/researcher/process'/>?projFlow=${irbForm.irb.projFlow}&roleScope=${param.roleScope}&irbFlow=${irbForm.irb.irbFlow}";
}

$(document).ready(function(){
	//会议决定(最多票数的被选中)
	if ('${maxVoteDec}' != '') {
		$("#irbDecisionId_${maxVoteDec}").attr("checked","checked");
	}
});
</script>
<style type="text/css">
.chooseTd{background-image:url('<s:url value='/css/skin/${skinPath}/images/gou.gif' />');background-repeat: no-repeat;background-position: center;}
table.xllist th#th_sp{font-weight: normal;padding: 0 5px; width: 190px;}
</style>
</head>
<body>
<div class="mainright">
<form id="saveForm">
	<div class="content">
<div class="title1 clearfix">
		<table class="xllist" >
			<tr>
					<th colspan="3" align="left" width="700px">&#12288;审查决定</th>
				</tr>
				<tr>
					<td width="300px">伦理委员会名称：</td>
					<td colspan="2" style="text-align: left;padding-left: 10px;">${irbInfo.irbName }</td>
				</tr>
				<tr>
					<td width="300px">项目名称：</td>
					<td colspan="2" style="text-align: left;padding-left: 10px;" >
						${irbForm.irb.projName }&#12288;&#12288;${irbForm.irb.projSubTypeName }&#12288;&#12288;${irbForm.irb.projDeclarer }
					</td>
				</tr>
				<tr>
					<td width="300px">伦理审查类别：</td>
					<td colspan="2" style="text-align: left;padding-left: 10px;" >${irbForm.irb.irbTypeName }</td>
				</tr>
				<tr>
					<th width="300px">投票意见</th>
					<th width="200px">票数</th>
					<th width="60%">会议决定</th>
				</tr>
				<c:forEach items="${decisionList}" var="dec" varStatus="statu">
					<tr>
						<td>${dec.name }</td>
						<td>
						<span id="${dec.id }_vote">${empty voteCountMap[dec.id]?0:voteCountMap[dec.id] }</span>
						<input type="hidden" id="${dec.id }_voteCount"  name="voteCount"  decId="${dec.id}" value="${empty voteCountMap[dec.id]?0:voteCountMap[dec.id]}">
						</td>
						<td style="text-align: left;color: blue;padding-left: 20px;" >
							<input type="radio" name="mDecisionId" id="irbDecisionId_${dec.id }" value="${dec.id }" 
							<c:if test="${statu.first || dec.id==irbForm.irb.irbDecisionId }">checked="checked"</c:if> 
							<c:if test="${!empty irbForm.irb.irbDecisionId && 'edit' != param.operType}"> disabled="disabled" </c:if> />
							<label style="margin-right: 10px;" for="irbDecisionId_${dec.id }" >${dec.name }</label>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td>因利益冲突退出</td>
					<td>
						<span id="conflict_vote">${empty voteCountMap[GlobalConstant.IRB_DECISION_CONFLICT]?0:voteCountMap[GlobalConstant.IRB_DECISION_CONFLICT]}</span>
						<input type="hidden" id="conflict_voteCount"  name="voteCount"  decId="conflict" value="${empty voteCountMap[GlobalConstant.IRB_DECISION_CONFLICT]?0:voteCountMap[GlobalConstant.IRB_DECISION_CONFLICT]}">
					</td>
					<td></td>
				</tr>
		</table>
	
		<table class="xllist"  id="detailTable"   >
			<thead>
				<tr>
					<th style="background-color: #6CB4E7;color: #fff; text-align: left;padding-left: 15px;" colspan="${fn:length(decisionList)+2}">
					投票详情
					</th>
				</tr>
				<tr>
					<th width="200" rowspan="2">委员
					</th>
					<th width="600" colspan="${fn:length(decisionList)+1}">
						 投票决定
					</th>
				</tr>
				<tr>
					<c:forEach items="${decisionList}" var="dec">
					<th id="th_sp">
						${dec.name}
					</th>
					</c:forEach>
					<th id="th_sp">
						利益冲突退出
					</th>
				</tr>
				<c:forEach items="${filterUserList }" var="user">
					<tr>
						<td>
							${user.userName }
							<c:set var="voteKey" value="vote_${user.userFlow }"></c:set>
							<input type="hidden" name="userFlows" value="${user.userFlow }">
							<input type="hidden" id="decisionId_${user.userFlow }" name="decisionId_${user.userFlow }" value="${empty voteMap[voteKey]?'':voteMap[voteKey] }">
							<input type="hidden" id="conflict_${user.userFlow }" name="conflict_${user.userFlow }" value="${empty voteMap[conflictKey]?'':voteMap[conflictKey] }">
							<input type="hidden" id="userName_${user.userFlow }" name="userName_${user.userFlow }" value="${user.userName }">
						</td>
						<c:forEach items="${decisionList}" var="dec">
							<td decId="${dec.id}" <c:if test="${dec.id eq voteMap[voteKey]}"> class="chooseTd" </c:if> 
								<c:if test="${(empty irbForm.irb.irbDecisionId&&meeting.meetingStatus!=GlobalConstant.FLAG_Y) || 'edit' eq param.operType}"> onclick="chooseTd(this,'${dec.id}','${user.userFlow}')" </c:if>>
							</td>
						</c:forEach>
						<c:set var="conflictKey" value="conflict_${user.userFlow }"></c:set>
							<td decId="conflict" <c:if test="${GlobalConstant.FLAG_Y eq voteMap[conflictKey]}"> class="chooseTd" </c:if> 
								<c:if test="${(empty irbForm.irb.irbDecisionId&&meeting.meetingStatus!=GlobalConstant.FLAG_Y) || 'edit' eq param.operType}">onclick="chooseTd(this,'conflict','${user.userFlow}')"</c:if>>
							</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="button">
			<input type="hidden" name="irbFlow" id="irbFlow" value="${irbForm.irb.irbFlow }">
			<input type="hidden" id="meetingFlow" name="meetingFlow" value="${meeting.meetingFlow }">
			<c:if test="${(empty irbForm.irb.irbDecisionId&&meeting.meetingStatus!=GlobalConstant.FLAG_Y) || 'edit' eq param.operType}">
				<input type="button" class="search" value="保&#12288;存" onclick="save();" />
			</c:if>
			<input class="search" type="button" showFlag="${GlobalConstant.FLAG_Y }" value="打&#12288;印" onclick="print();" />
			<c:if test="${empty param.closeButton}">
				<input type="button" class="search" onclick="doClose();" value="关&#12288;闭">
			</c:if>
			<c:if test="${'edit' eq param.operType}">
				<input type="button" class="search" value="返&#12288;回" onclick="doBack();" />	
			</c:if>
		</div>
	</div>
	</div>
	</form>
	</div>
</body>
</html>