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
function showProj(){
	var w = window.parent.frames["mainIframe"].document.body.clientWidth;
	var h = window.parent.frames["mainIframe"].document.body.clientHeight;
	var url ='<s:url value="/irb/office/showProj"/>';
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='"+w+"px' height='"+h+"px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'项目名称',w,h);
}
function saveStamp() {
	
	if(false==$("#stampForm").validationEngine("validate")){
		return false;
	}
	
	var url = "<s:url value="/irb/office/saveStamp"/>";
	var requestData = $("#stampForm").serialize();
	jboxPost(url,requestData,function(resp){
		if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
			window.parent.frames['mainIframe'].location.reload(true);
			jboxClose();
		}
	},null,true);
}

function selectStampName(name) {
	//alert($(name).val());
	var stampName = $(name).val();
	$("input[name='stampName']").val(stampName);
}
</script>
</head>
<body>
<div class="mainright" id="mainright">
<div class="content">
<div class="title1 clearfix">
	<div class="content">
		<form id="stampForm" method="post">
		<table class="basic" style="width: 100%">
			<tr>
				<th>项目：</th>
				<td>
					&#12288;<input type="text" name="projName" value="${stamp.projName}" id="projName" placeholder="请选择一个项目 " readonly="readonly" class="validate[required] xltext" style="width: 300px"/>
					<img style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/search.gif'/>" onclick="showProj();"/>
					<input type="hidden" name="projFlow" value="${stamp.stampDate}" id="projFlow"/>
					<input type="hidden" name="stampFlow" value="${stamp.stampFlow}"/>
				</td>
			</tr>
			<tr>
				<th>盖章日期：</th>
				<td>&#12288;<input type="text" name="stampDate" value="${stamp.stampDate}" class="validate[required] ctime" readonly="readonly" style="width: 160px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></td>
			</tr>
			<tr>
				<th>盖章文件名称：</th>
				<td>
					&#12288;<input type="text" name="stampName" readonly="readonly" value="${stamp.stampName}" class="validate[required] xltext" placeholder="请选择一个盖章文件名称 "/>
					&#12288;<select class="xlselect" name="stampNameOption" onchange="selectStampName(this);">
						<option value="">请选择</option>
						<option value="伦理审查批件">伦理审查批件</option>
						<option value="伦理审查意见">伦理审查意见</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>份数：</th>
				<td>&#12288;<input type="text" name="stampNum" value="${stamp.stampNum}" class="validate[custom[integer]] validate[maxSize[5]] xltext"/></td>
			</tr>
			<tr>
				<th>盖章人：</th>
				<td>
					&#12288;<c:choose>
						<c:when test="${not empty stamp.stampUserName}">
							<input type="text" name="stampUserName" value="${stamp.stampUserName}" class="validate[required] xltext"/>
						</c:when>
						<c:otherwise>
							<input type="text" name="stampUserName"  value="${currUser.userName}" class="validate[required] xltext"/>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
		</form>
		<p style="text-align: center;">
			<input type="button" class="search" value="保&#12288;存" onclick="saveStamp();" />
			<input type="button" class="search" value="关&#12288;闭" onclick="doClose();" />
		</p>
	</div>
	</div>
</div>
</div>
</body>
</html>