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
function doClose() {
	jboxClose();
}
function save(){
	if(false==$("#saveForm").validationEngine("validate")){
		return ;
	}
	jboxConfirm("保存后不可修改，确认保存？",function(){
		var url = "<s:url value='/irb/committee/saveVote'/>";
		var requestData = $("#saveForm").serialize();
		jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				window.parent.frames["mainIframe"].window.reload();
				doClose();
			}
		},null,true);
	},null);
}
function change(obj){
	var id = $(obj).attr("id");
	var opinionObj = $("#opinion");
	var decisionObjs = $("input[name='decisionId'][id!="+id+"]");
	if ("irbDecisionId_conflict" == id) {
		if($(obj).attr("checked") == "checked"){
			opinionObj.attr("disabled",true);
			decisionObjs.each(function(){
				$(this).attr("checked",false);
				$(this).attr("disabled",true);
			});
		}else{
			opinionObj.attr("disabled",false);
			decisionObjs.each(function(){
				$(this).attr("disabled",false);
			});
		}
	}
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
	<form id="saveForm">
		<table class="xllist nofix">
			<thead>
				<tr>
					<th  colspan="4">投票单</th>
				</tr>
				<tr>
					<td width="10%" >项目：</td>
					<td colspan="3" style="text-align: left;padding-left: 10px;">${irb.projName }
					&#12288;${irb.projSubTypeName }&#12288;${irb.projShortDeclarer }
					</td>
				</tr>
				<tr>
					<td width="10%" >审查类别：</td>
					<td  colspan="3" style="text-align: left;padding-left: 10px;">${irb.irbTypeName}</td>
				</tr>
				<tr>
					<td width="10%" >审查意见：</td>
					<td  colspan="3" style="text-align: left;padding-left: 10px;">
					<c:choose>
						<c:when test="${!empty voteForm.userFlow }"><pre style="font-family: Microsoft Yahei;">${voteForm.opinion }</pre></c:when>
						<c:otherwise>
						<textarea rows="3" name="opinion" id="opinion"  style="width: 95%;margin: 3px 0;">${suggest }</textarea></c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
					<td width="20%" >决定：</td>
					<td  colspan="3" style="text-align: left;padding-left: 10px;">
					<c:choose>
						<c:when test="${!empty voteForm.decisionId }">
							${voteForm.decisionName }
						</c:when>
						<c:otherwise>
							<c:forEach items="${irbDecisionEnumList }" var="dec" varStatus="statu">
								<c:if test="${pdfn:countMatches(dec.irbTypeId,irb.irbTypeId)==1 }">
									<input type="radio" name="decisionId" class="validate[required]" id="irbDecisionId_${statu.count }" onchange="change(this)" value="${dec.id }"/><label style="margin-right: 10px;" for="irbDecisionId_${statu.count }" >${dec.name }</label>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<c:if test="${empty voteForm.userFlow }">
				<tr>
					<td width="20%" >利益冲突声明：</td>
					<td  colspan="3" style="text-align: left;padding-left: 10px;">
						<input type="checkbox" name="decisionId"  onchange="change(this)" id="irbDecisionId_conflict" value="${GlobalConstant.IRB_DECISION_CONFLICT}" /><label style="margin-right: 10px;" for="irbDecisionId_conflict" >利益冲突退出</label>
					</td>
				</tr>
				</c:if>
				<tr>
					<td width="10%" >签名：</td>
					<td style="text-align: left;padding-left: 10px;">${sessionScope.currUser.userName }</td>
					<td width="10%" >日期：</td>
					<td style="text-align: left;padding-left: 10px;">
					<c:choose>
						<c:when test="${!empty voteForm.date }">
							${voteForm.date }
						</c:when>
						<c:otherwise>
							<input type="text" name="date" id="date" class="validate[required] text-input xltext ctime" value="${pdfn:getCurrDate()}"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="button">
			<input type="hidden" name="irbFlow" value="${param.irbFlow }">
			<c:if test="${empty voteForm.userFlow }"><input type="button" class="search" value="保&#12288;存" onclick="save();" /></c:if>
			<input type="button" class="search" onclick="doClose();" value="关&#12288;闭">
		</div>
	</form>
	</div>
	</div>
</div>
</body>
</html>