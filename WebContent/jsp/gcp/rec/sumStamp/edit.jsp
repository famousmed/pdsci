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
	function save(){
		var form = $("#editForm");
		var requestData = form.serialize();
		var url = "<s:url value='/gcp/rec/saveSumStamp'/>";
	 	jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				window.parent.frames['mainIframe'].window.loadStamp();
				jboxClose();
			}
		},null,true);
	}
</script>
</head>
<style>
.edit3{text-align: left;border:none;}
</style>
<body>
	<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div class="title1 clearfix">
				<form id="editForm" style="position: relative;">
				<input type="hidden" name="projFlow" value="${param.projFlow}"> 
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<tr>
						<th width="180px" >主要研究者确认：</th>
						<td >
						<textarea name="resConfirm" rows="3" style="width:97%;margin:8px 0px; " placeholder="请填写主要研究者确认信息"><c:choose><c:when test="${empty ssForm.resConfirm }">完成的研究例数与总结报告一致,临床试验项目文件已经归档,已审阅总结报告并签名,已经向伦理委员会提交结题报告。</c:when><c:otherwise>${ssForm.resConfirm }</c:otherwise></c:choose></textarea>
						</td>
					</tr>
					<tr>
						<th >主要研究者（签字）：</th>
						<td>
							<input type="text" name="resSign" class="xltext"  <c:choose><c:when test="${empty ssForm.resSign }">value="${proj.applyUserName}"</c:when><c:otherwise>value="${ssForm.resSign }"</c:otherwise></c:choose> >
						</td>
					</tr>
					<tr>
						<th>机构办公室确认：</th>
						<td>
						<textarea name="orgConfirm" rows="3" style="width:97%;margin:8px 0px; " placeholder="请填写机构办公室确认信息"><c:choose><c:when test="${empty ssForm.orgConfirm }">归档的临床试验项目文件完整,剩余试验用药品已经退还申办者,试验经费全部到帐,主要研究者已在总结报告上签名,同意盖章。</c:when><c:otherwise>${ssForm.orgConfirm }</c:otherwise></c:choose></textarea>
							
						</td>
					</tr>
					<tr>
						<th>项目管理员（签字）：</th>
						<td>
							<input type="text" name="adminSign" class="xltext" value="${ssForm.adminSign }">
						</td>
					</tr>
					<tr>
						<th >办公室主任（签字）：</th>
						<td>
							<input type="text" name="dirSign" class="xltext" value="${ssForm.dirSign }" >
						</td>
					</tr>
					<tr>
						<th>日&#12288;期：</th>
						<td>
							<input type="text" name="date"  class="xltext ctime" readonly="readonly"  <c:choose><c:when test="${empty ssForm.date }">value="${pdfn:getCurrDate()}"</c:when><c:otherwise>value="${ssForm.date }"</c:otherwise></c:choose> onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" >
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div style="width: 100%;" align="center" >
			<input class="search" type="button" value="保&#12288;存" onclick="save()"  />
		</div>
</div></div></div>
</body>
</html>