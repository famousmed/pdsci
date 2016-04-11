<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script>
if ("${param.type}" == 'show') {
	$(document).ready(function(){
		hideButton();
	});
}
function hideButton() {
	$(":input[type='button'][showFlag!='${GlobalConstant.FLAG_Y }']").each(function(){
		$(this).hide();
	});
	$('input').attr("readonly","readonly");
	$('textarea').attr("readonly","readonly");
	$("select").attr("disabled", "disabled");
	$(":checkbox").attr("disabled", "disabled");
	$(":radio").attr("disabled", "disabled");
}

function saveForm(){
	jboxPost("<s:url value='/irb/researcher/saveApplication'/>?formFileName=${formFileName}",$('#initApplicationForm').serialize(),null,null,true);
}
function print(){
	var url ="<s:url value='/irb/print'/>?watermarkFlag=${GlobalConstant.FLAG_N}&irbFlow=${sessionScope.currIrb.irbFlow}&recTypeId=${irbRecTypeEnumRetrialApplication.id}";
	window.location.href= url;
}
function doClose() {
	top.$.jBox.close('jbox-iframe');
}
</script> 
</head>
<body>
	<div class="mainright">
	<div class="content" align="center">
	<div style="margin-top: 5px;text-align: center;width: 100%;">
		<font size="3"><b>复审申请</b></font>
	</div>
	<div class="title1 clearfix">
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
      		<tr>
				<th colspan="4" style="text-align: left;">&nbsp;项目信息</th>
			</tr>		
      		<tr>
				<td width="20%" style="text-align: right;">项目名称：</td>
				<td width="30%" colspan="3">
					${proj.projName}
				</td>
			</tr>
			<tr>
				<td width="20%" style="text-align: right;">期类别：</td>
				<td width="30%">
					${proj.projSubTypeName }
				</td>
				<td width="20%" style="text-align: right;">项目来源：</td>
				<td width="30%">
					${proj.projDeclarer }
				</td>
			</tr>
			<tr>
				<td width="20%" style="text-align: right;">专业组：</td>
				<td width="30%">
					${proj.applyDeptName }
				</td>
				<td width="20%" style="text-align: right;">主要研究者：</td>
				<td width="30%">
					${proj.applyUserName }
				</td>
			</tr>
		</table>
</div>
	<div style="text-align: left;width: 100%;">
		<b>修正情况</b>
	</div>
<div class="title1 clearfix">
<form id="initApplicationForm" >
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
      		<tr>
      			<th style="text-align: left;">&nbsp;●&#12288;完全按照伦理审查意见修改的部分</th>
      		</tr>	
      		<tr>
      			<td><textarea style="width: 100%;border: 0;min-height: 70px;" name="item1" placeholder="请填写完全按照伦理审查意见修改的部分">${formDataMap['item1'] }</textarea></td>
      		</tr>
      		<tr>
      			<th style="text-align: left;">&nbsp;●&#12288;参考伦理审查意见修改的部分</th>
      		</tr>
      		<tr>
      			<td><textarea style="width: 100%;border: 0;min-height: 70px;" name="item2" placeholder="请填写参考伦理审查意见修改的部分">${formDataMap['item2'] }</textarea></td>
      		</tr>
      		<tr>
      			<th style="text-align: left;">&nbsp;●&#12288;没有按照伦理审查意见进行修改的说明</th>
      		</tr>
      		<tr>
      			<td><textarea style="width: 100%;border: 0;min-height: 70px;" name="item3" placeholder="请填写没有按照伦理审查意见进行修改的说明">${formDataMap['item3'] }</textarea></td>
      		</tr>
		</table>
		<div class="title1 clearfix">
			<table width="100%" cellpadding="0" cellspacing="0" class="basic">
				<tr>
					<th width="20%" style="text-align: center;">申请人签字</th>
					<td width="30%">
						<input type="text" name="applyManName" value="${empty formDataMap['applyManName'] ?sessionScope.currUser.userName:formDataMap['applyManName']}">
					</td>
					<th width="20%" style="text-align: center;">日期</th>
					<td width="30%">
						<input type="text" name="applyDate" value="${empty formDataMap['applyDate']?pdfn:getCurrDate():formDataMap['applyDate'] }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
					</td>
				</tr>
			</table>
		</div>
</form>
</div>
<div class="button" >
	<c:if test="${sessionScope.currIrb.irbStageId==irbStageEnumApply.id || 'edit' eq param.operType}">
		<input class="search" type="button" value="保&#12288;存" onclick="saveForm();" />
	</c:if>
	<input class="search" type="button" showFlag="${GlobalConstant.FLAG_Y }" value="打&#12288;印" onclick="print();" />
	<c:if test="${param.open==GlobalConstant.FLAG_Y && param.showType != 'messager'}">
		<input class="search" type="button" value="关&#12288;闭" onclick="doClose();" />
	</c:if>
</div>
</div></div>
</body>
</html>