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
	function saveSponsor(){
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		var url = "<s:url value='/gcp/proj/saveSponsor'/>";
		var requestData = $("#projForm").serialize();
		jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				window.parent.frames['mainIframe'].window.loadBaseInfo();
				jboxClose();
			}
		},null,true);
	}
</script>
<style type="text/css">
	.basic tbody th{text-align: left;padding-left: 10px;}
	.basic td.td_title{text-align: right;padding: 0;}
</style>
</head>
<body>
	<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div class="title1 clearfix">
				<form id="projForm" style="position: relative;"> 
				<input type="hidden" id="projFlow" name="projFlow" value="${projInfoForm.proj.projFlow}">
				<input type="hidden" name="projInfo" value='${projInfoForm.proj.projInfo}'/>
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<tr>
						<th colspan="6">项目来源</th>
					</tr>
					<tr>
						<td width="20%" class="td_title">项目来源全称：</td>
						<td colspan="5"><input type="text" class="validate[required] xltext" style="margin-right: 3px;width: 435px;" name="projDeclarer" style="width: 55%" value="${projInfoForm.proj.projDeclarer}"/>
						<font class="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="td_title">项目来源简称：</td>
						<td width="20%"><input type="text"  class="validate[required] xltext" style="margin-right: 3px;" name="projShortDeclarer" value="${projInfoForm.proj.projShortDeclarer}"/>
						<font class="red">*</font>
						</td>
						<td width="11%" class="td_title">地址：</td>
						<td width="20%"><input type="text"  class="xltext" name="declarerAddress" value='${projInfoForm.declarerAddress}'/></td>
						<td width="11%" class="td_title">邮编：</td>
						<td width="20%">
							<input type="text"  class="xltext" name="declarerZip" value='${projInfoForm.declarerZip}'/>
						</td>
					</tr>
					<tr>
						<td class="td_title">联系人：</td>
						<td>
							<input type="text"  class="xltext" name="dLinkMan" value='${projInfoForm.dLinkMan}'/>
						</td>
						<td  class="td_title">手机：</td>
						<td >
							<input type="text"  class="xltext" name="dLinkManPhone" value='${projInfoForm.dLinkManPhone}'/>
						</td>
						<td class="td_title">邮件：</td>
						<td>
							<input type="text"  class="xltext" name="dLinkManEmail" value='${projInfoForm.dLinkManEmail}'/>
						</td>
					</tr>
					<tr>
						<th colspan="6">CRO</th>
					</tr>
					<tr>
						<td  class="td_title">CRO：</td>
						<td colspan="5"><input type="text" class="xltext" name="CROName" style="width: 435px;" value="${projInfoForm.CROName}"/>
						</td>
					</tr>
					<tr>
						<td  class="td_title">法人代表：</td>
						<td ><input type="text"  class="xltext" name="CROLegalRepresent" value='${projInfoForm.CROLegalRepresent}'/></td>
						<td  class="td_title">地址：</td>
						<td ><input type="text"  class="xltext" name="CROAddress" value='${projInfoForm.CROAddress}'/></td>
						<td  class="td_title">邮编：</td>
						<td >
							<input type="text"  class="xltext" name="CROZip" value='${projInfoForm.CROZip}'/>
						</td>
					</tr>
					<tr>
						<td  class="td_title">（CRO）联系人：</td>
						<td >
							<input type="text"  class="xltext" name="CROLinkMan" value='${projInfoForm.CROLinkMan}'/>
						</td>
						<td  class="td_title">手机：</td>
						<td >
							<input type="text"  class="xltext" name="CROLinkManPhone" value='${projInfoForm.CROLinkManPhone}'/>
						</td>
						<td  class="td_title">邮件：</td>
						<td >
							<input type="text"  class="xltext" name="CROLinkManEmail" value='${projInfoForm.CROLinkManEmail}'/>
						</td>
					</tr>
					</table>
					
			</form>
		</div>
		<div style="width: 100%;margin-top: 10px;" align="center" >
			<input class="search" type="button" value="保&#12288;存" onclick="saveSponsor()"  />
			<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
		</div>
</div></div></div>
</body>
</html>