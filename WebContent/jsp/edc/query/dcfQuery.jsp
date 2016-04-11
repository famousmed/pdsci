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
<script>
function change(sendWayId){
	if(sendWayId == "SDV"){
		$("#SDV").show();
		$("#NOTSDV").hide();
	}
	if(sendWayId == "NOTSDV"){
		$("#SDV").hide();
		$("#NOTSDV").show();
	}
	if(sendWayId == ""){
		$("#SDV").show();
		$("#NOTSDV").show();
	}
}

window.parent.frames['mainIframe'].window.searchQuery();
</script>
</head>

<body>
	<div class="mainright">
	<div class="content">
			<div style="margin-top: 5px">
			<c:choose>
				<c:when test="${param.type eq 'dcflist' }">
				&#12288;参与机构：${sysOrgMap[orgFlow].orgName }
				</c:when>
				<c:otherwise>
				&#12288;发送方式：<select style="width: 300px" id="sendWayId" onchange="change(this.value);">
						<option></option>
						<option value="SDV" <c:if test="${param.sendWayId eq 'SDV'}">selected</c:if>>SDV疑问</option>
						<option value="NOTSDV" <c:if test="${param.sendWayId eq '!SDV' }">selected</c:if>>手工疑问/逻辑检查</option>		
				</select>&#12288;
				参与机构：${sysOrgMap[param.orgFlow].orgName }
				</c:otherwise>
				</c:choose>
				<hr/>
	</div>
			<div class="title1 clearfix">
			<form method="post" enctype="multipart/form-data">
			<c:if test="${!empty sdvList }">
			<fieldset id="SDV"> 
				<legend><a href="<s:url value='/edc/query/downDcf'/>?dcfFlow=${ sdvDcf.dcfFlow}"><img src="<s:url value='/css/skin/${skinPath}/images/pdf.png'/>" style="cursor: pointer;" title="下载"/></a>SDV &#12288;发行编号:${sdvDcf.dcfNo }</legend>
				<table class="xllist" >
					<tr height="40px">
					<th style="text-align: center" width="8%">受试者编码</th>
					<th style="text-align: center" width="5%">序号</th>
					<th style="text-align: center" width="12%">数据项</th>
					<th style="text-align: center" width="10%">原始值</th>
					<th style="text-align: center" width="20%">疑问事项</th>
					<th style="text-align: center" width="10%">变更与修改<br/>选择 有/无</th>
					<th style="text-align: center" width="10%">修改值</th>
					<th style="text-align: center" width="10%">研究者签名</th>
					<th style="text-align: center" width="15%">日期</th>
				</tr>
					<c:forEach items="${sdvList}" var="query">
					<c:forEach items="${queryEventMap[query.queryFlow] }"  var="data" varStatus="status" >
					<tr> 
						<c:if test="${status.index == 0 }"> 
						<td style="text-align: center" rowspan="${fn:length(queryEventMap[query.queryFlow])}" width="8%">${query.patientCode }</td>
						<td style="text-align: center" rowspan="${fn:length(queryEventMap[query.queryFlow])}" width="5%">${query.querySeq }</td>
						</c:if>
						<td style="text-align: center" width="12%">${data.elementName }.${data.attrName }</td>
						<td style="text-align: center" width="10%">${data.attrValue }</td>
						<td style="text-align: center" width="20%">${query.queryContent}</td>
						<td style="text-align: center" width="10%">
							<c:if test="${ data.attrValue  !=  data.attrEventValue}">
								□无 &#12288;■有
							</c:if>
							<c:if test="${ data.attrValue  ==  data.attrEventValue}">
								■无 &#12288;□有
							</c:if>
						</td>
						<td style="text-align: center" width="10%">${data.attrEventValue  }</td>
						<td style="text-align: center" width="10%">${query.solveUserName }</td>
						<td style="text-align: center" width="15%">${pdfn:transDateTime(query.solveTime)}</td>
					</tr> 
					</c:forEach>
					</c:forEach>
				</table>
			</fieldset>
			</c:if>
			<c:if test="${!empty notSdvList }">
			<fieldset id="NOTSDV">
				<legend><a href="<s:url value='/edc/query/downDcf'/>?dcfFlow=${ notSdvDcf.dcfFlow}"><img src="<s:url value='/css/skin/${skinPath}/images/pdf.png'/>" style="cursor: pointer;" title="下载"/></a>手工疑问/逻辑检查&#12288;发行编号:${notSdvDcf.dcfNo }</legend>
				<table class="xllist" >
				<tr height="40px">
					<th style="text-align: center" width="8%">受试者编码</th>
					<th style="text-align: center" width="5%">序号</th>
					<th style="text-align: center" width="12%">数据项</th>
					<th style="text-align: center" width="10%">原始值</th>
					<th style="text-align: center" width="20%">疑问事项</th>
					<th style="text-align: center" width="10%">变更与修改<br/>选择 有/无</th>
					<th style="text-align: center" width="10%">修改值</th>
					<th style="text-align: center" width="10%">研究者签名</th>
					<th style="text-align: center" width="15%">日期</th>
				</tr>
					
					<c:forEach items="${notSdvList}" var="query" >
					<c:forEach items="${queryEventMap[query.queryFlow] }"  var="data" varStatus="status" >
					<tr> 
						<c:if test="${status.index == 0 }"> 
						<td style="text-align: center" rowspan="${fn:length(queryEventMap[query.queryFlow])}" width="8%">${query.patientCode }</td>
						<td style="text-align: center" rowspan="${fn:length(queryEventMap[query.queryFlow])}" width="5%">${query.querySeq }</td>
						</c:if>
						<td style="text-align: center" width="12%">${data.elementName }.${data.attrName }</td>
						<td style="text-align: center" width="10%">${data.attrValue }</td>
						<c:if test="${status.index == 0 }"> 
						<td style="text-align: center" rowspan="${fn:length(queryEventMap[query.queryFlow])}" width="20%">${query.queryContent }</td>
						</c:if>
						<td style="text-align: center" width="10%">
							<c:if test="${ data.attrValue  !=  data.attrEventValue}">
								□无 &#12288;■有
							</c:if>
							<c:if test="${ data.attrValue  ==  data.attrEventValue}">
								■无 &#12288;□有
							</c:if>
						</td>
						<td style="text-align: center" width="10%">${data.attrEventValue  }</td>
						<c:if test="${status.index == 0 }"> 
						<td style="text-align: center" rowspan="${fn:length(queryEventMap[query.queryFlow])}" width="10%">${query.solveUserName }</td>
						<td style="text-align: center" rowspan="${fn:length(queryEventMap[query.queryFlow])}" width="15%">${pdfn:transDateTime(query.solveTime) }</td>
						</c:if>
					</tr> 
					</c:forEach>
					</c:forEach>
				</table>
			</fieldset>
			</c:if>
			</form>
		</div>
	</div>
	</div>
</body>
</html>