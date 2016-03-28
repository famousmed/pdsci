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
function search(){
	window.location.href="<s:url value='/edc/query/dcflist'/>?orgFlow="+$("#orgFlow").val();
}

function showDcf(dcfFlow){
	jboxOpen("<s:url value='/edc/query/showDcf'/>?dcfFlow="+dcfFlow+"&type=dcflist","DCF",$('.mainright').width(),600);
}

$(document).ready(function(){
	init();
});
function init(){
	$(".visitModuleTd").hover(function() {
		$(this).find("div").stop().animate({left: "210", opacity:1}, "slow").css("display","block");
	},function(){
		$(this).find("div").stop().animate({left: "0", opacity: 0}, "slow");
	});
}
</script>
</head>

<body>

	<div class="mainright">
	<div class="content">
			<div style="margin-top: 5px">
				&#12288;&#12288;参与机构：
			<select  name="orgFlow" id="orgFlow" class="xlname" style="width:200px;" onchange="search();">
				<option value=""></option>
				<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList)}" var="projOrg">
					<option value="${projOrg.orgFlow}" <c:if test="${projOrg.orgFlow==param.orgFlow }">selected</c:if>>${projOrg.centerNo }&#12288;${applicationScope.sysOrgMap[projOrg.orgFlow].orgName}</option>
				</c:forEach>
			</select>&#12288;
				<hr/>
	</div>
			<div class="title1 clearfix">
			<form method="post" enctype="multipart/form-data">
				<table class="xllist" >
					<tr height="40px">
					<th style="text-align: center" width="35%">DCF编号</th>
					<th style="text-align: center" width="25%">DCF类型</th>
					<th style="text-align: center" width="20%">发行日期</th>
					<th style="text-align: center" width="20%">发行人</th>
				</tr>
					<c:forEach items="${dcfList }"  var="dcf" >
					<tr> 
						<td class="visitModuleTd" width="35%">
							<a href="<s:url value='/edc/query/downDcf'/>?dcfFlow=${ dcf.dcfFlow}" title="下载">${dcf.dcfNo}</a>
							<div style="display:none ;vertical-align: middle;float: right">
								<a href="javascript:showDcf('${ dcf.dcfFlow}');">[查看]</a>
								<a href="<s:url value='/edc/query/downDcf'/>?dcfFlow=${ dcf.dcfFlow}">[下载]</a>
							</div>
						</td>
						<td style="text-align: center" width="25%">${fn:indexOf(dcf.dcfNo,'SDV')>0?'SDV疑问':'手工疑问/逻辑检查'}</td>
						<td style="text-align: center" width="20%">${pdfn:transDate(dcf.dcfDate)}</td>
						<td style="text-align: center" width="20%">${ dcf.dcfUserName}</td>
					</tr> 
					</c:forEach>
					<c:if test="${dcfList == null || dcfList.size()==0 }"> 
						<tr> 
							<td align="center" colspan="4">无记录</td>
						</tr>
					</c:if>
				</table>
			</form>
		</div>
	</div>
	</div>
</body>
</html>