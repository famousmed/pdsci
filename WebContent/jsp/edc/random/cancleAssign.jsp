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
	function cancleAssign(recFlow) {
		jboxConfirm("确认撤销申请?",function(){
			jboxGet("<s:url value='/edc/random/doCancleAssign'/>?recFlow="+recFlow,null,function(resp){
					window.parent.frames['mainIframe'].location.reload(true);
					jboxClose();
			},null,true);
		});
	}
</script>
</head>
<body>

<form id="assignForm" style="height: 100%" >
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">				
				<table cellpadding="0" cellspacing="0" class="xllist" width="100%">	
					<thead>
					<tr>
						<th style="text-align: left" colspan="6">&#12288;您可以撤销以下申请信息 </th>
					</tr>
					<tr>
						<th width="100px">受试者编号</th>
						<c:if test="${isBlind}">
						<th width="100px">药物编码</th>
						</c:if>
						<th width="100px">申请类别</th>
						<th width="100px">申请时间</th>
						<th width="100px">申请人</th>
						<th width="50px">操作</th>
					</tr>	
					</thead>
					<tbody>
					<c:if test="${randomRec.promptStatusId  != edcRandomPromptStatusEnumPrompted.id 
					&& visitFlag!=GlobalConstant.FLAG_Y  && !empty randomRec.recordFlow }"> 
					<tr>
						<td>${randomRec.patientCode }</td>
						<c:if test="${isBlind}">
						<td>${randomRec.drugPack }</td>
						</c:if>
						<td>${randomRec.assignLabelName }</td>
						<td>${pdfn:transDateTime(randomRec.assignTime) }</td>
						<td>${randomRec.assignUserName}</td>
						<td>[<a href="javascript:cancleAssign('${randomRec.recordFlow }');">撤销</a>]</td>
					</tr>
					</c:if>
					</tbody>
				</table>
				<div class="button" style="width: 700px;">
				<!-- 
					<input type="button" class="search" onclick="doClose();" value="关闭"> -->
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>