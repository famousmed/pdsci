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
</script>
<style type="text/css">
.none {
	border-collapse: collapse;
	table-layout: fixed;
}

.none td {
	border: 0 none;
	border-collapse: collapse;
	padding-bottom: 3px;
	padding-top: 3px;
}
</style>
</head>
<body>
<div class="content" style="height: 100%;overflow: auto;">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">				
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">	
					<tr>
						<th width="22%">中心号：</th>
						<td width="28%">
							${pubProjOrg.centerNo }
						</td>
						<th width="22%">随机号：</th>
						<td width="28%">
							${randomInfo.randomRec.randomCode}
						</td>   
					</tr>
					<tr>
						<th width="22%">出生年月：</th>
						<td width="28%">
							${randomInfo.patient.patientBirthday }
						</td>
						<th width="22%">预后因素：</th>
						<td width="28%">
							${randomInfo.randomRec.drugFactorName}
						</td>   
					</tr>
					<tr>
						<th width="22%">申请类别：</th>
						<td colspan="3">
							${randomInfo.randomRec.assignLabelName}
						</td>
					</tr>
					<tr>
						<th width="22%">申请人：</th>
						<td width="28%">
							${randomInfo.randomRec.assignUserName}
						</td>
						<th width="22%">申请时间：</th>
						<td width="28%">
							${pdfn:transDateTime(randomInfo.randomRec.assignTime)}
						</td>
					</tr>
					<tr>
						<th width="22%">破盲状态：</th>
						<td colspan="3">
							${empty randomInfo.randomRec.promptStatusName?edcRandomPromptStatusEnumUnPrompt.name:randomInfo.randomRec.promptStatusName}
						</td>
					</tr>
					<tr>
						<th width="22%">破盲人：</th>
						<td width="28%">
							${randomInfo.randomRec.promptUserName}
						</td>
						<th width="22%">破盲时间：</th>
						<td width="28%">
							${pdfn:transDateTime(randomInfo.randomRec.promptTime)}
						</td>
					</tr>
					<tr>
						<th width="22%">药物编码：</th>
						<td width="28%">
							${randomInfo.randomRec.drugPack}
						</td>
						<th width="22%">药物组别：</th>
						<td width="28%">
							<c:choose>
								<c:when test="${!isBlind || randomInfo.randomRec.promptStatusId  == edcRandomPromptStatusEnumPrompted.id}">${randomInfo.randomRec.drugGroup }</c:when>
								<c:otherwise>***</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<c:if test="${!empty randomInfo.drugRecList }">
					<tr>
						<th width="22%">申请过程：</th>
						<td colspan="3">
						<c:forEach items="${randomInfo.drugRecList }" var="rec">
							${pdfn:transDateTime(rec.assignTime) }&#12288;
							${rec.assignLabelName }&#12288;药物编码：${rec.drugPack }<br/>
						</c:forEach>
						</td>
					</tr>
					</c:if>
				</table>
				<div class="button" style="width: 100%;" align="center">
					<input type="button" class="search" onclick="doClose();" value="关&#12288;闭">
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>