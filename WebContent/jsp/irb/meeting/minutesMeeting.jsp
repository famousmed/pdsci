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
function doClose(){
	jboxClose();
}
function save(){
	var saveForm = $("#saveForm");
	if(saveForm.validationEngine("validate")){
		var url="<s:url value='/irb/meeting/saveMinutes'/>";
		var requestData = saveForm.serialize();
		jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				reload();
			}
		},null,true);
	}
}
function reload(){
	window.location.reload();
}

function downMinutes() {
	var url ="<s:url value='/irb/printOther'/>?watermarkFlag=${GlobalConstant.FLAG_N}&irbFlow=${param.irbFlow}&recTypeId=minutes";
 	window.location.href=url;
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
					<th align="left" >申请人报告</th>
				</tr>
				<tr>
					<td><textarea rows="1" style="width: 100%; height: 100%" name="title" class="validate[required] text-input"><c:if test="${empty form.title }">${irbForm.proj.applyUserName }主任报告研究概况。</c:if><c:if test="${!empty form.title }">${form.title}</c:if></textarea></td>
				</tr>
				<tr>
					<th align="left" >伦理委员会提问与研究者答疑</th>
				</tr>
				<tr>
					<td><textarea rows="5" style="width: 100%" name="question" class="text-input">${form.question}</textarea></td>
				</tr>
				<tr>
					<th align="left" >利益冲突声明</th>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 20px;">
					委员：
					<c:if test="${!empty param.meetingCheck}">
					   <c:if test="${fn:length(quitList)>0 }">
						<c:forEach items="${quitList}" var="form" varStatus="statu">
							${form.userName}<c:if test="${fn:length(quitList)>1&&!statu.last}">、</c:if>
						</c:forEach>
					   </c:if>
					    <c:if test="${fn:length(quitList)==0 }">
					    	无
					    </c:if>
					 </c:if>
					 <c:if test="${empty param.meetingCheck}">
					 	<c:forEach items="${filterUserList}" var="user">
					 		<input type="checkbox" id="${user.userFlow }" name="userFlows" value="${user.userFlow }" <c:if test="${GlobalConstant.FLAG_Y eq conflictMap[user.userFlow] }"> checked</c:if>/>
					 		<label for="${user.userFlow }">${user.userName }</label>&#12288;
					 	</c:forEach>
					 </c:if>   
					</td>
				</tr>
				<tr>
					<th align="left" >伦理委员会讨论</th>
				</tr>
				<tr>
					<td><textarea rows="5" style="width: 100%" name="discussion" class=" text-input">${form.discussion}</textarea></td>
				</tr>
			</tbody>
		</table>
		<div class="button">
			<input type="hidden" name="irbFlow" value="${param.irbFlow}"/>
			<c:if test="${meeting.meetingStatus!=GlobalConstant.FLAG_Y && empty param.meetingCheck}"><input type="button" class="search" onclick="save();" value="保&#12288;存"></c:if>
			<input class="search" type="button" value="下&#12288;载" onclick="downMinutes();" />
			<input type="button" class="search" onclick="doClose();" value="关&#12288;闭">
		</div>
	</form>
	</div>
	</div>
</div>
</body>
</html>