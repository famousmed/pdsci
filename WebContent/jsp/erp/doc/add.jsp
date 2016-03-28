<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
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
function share() {
	if ($("[name='isPublic']:checked").val()=="${GlobalConstant.FLAG_N }") {
		$("#shareTr").show();
	} else {
		$("#shareTr").hide();
		$("#shareUserSpan").html(null);
	}
}

function selectSingle(obj) {
	var value = $(obj).val();
	var name = $(obj).attr("name");
	$("input[name="+name+"][value!="+value+"]:checked").attr("checked",false);
}

function userMain(){
	var url = "<s:url value='/erp/doc/userMain'/>?type=add";
	jboxOpen(url, "选择共享个人/部门", 800, 500);
}

function delRecord(recordFlow) {
	$("#"+recordFlow+"_span").remove();
}

function saveDoc() {
	if(false == $("#fileForm").validationEngine("validate")){
		return false;
	}
	var url ="<s:url value='/erp/doc/saveDocFile'/>";
	$("#saveButton").attr("disabled",true);
	jboxSubmit(
			$("#fileForm"),
			url,
			function(resp){
				if("${GlobalConstant.SAVE_SUCCESSED}" != resp){
					$("#saveButton").removeAttr("disabled");
				}else{
					window.parent.frames["mainIframe"].window.search();
					jboxCloseMessager();
				}
			},null,true);
}

$(document).ready(function(){
	init();
});

function init(){
	$(".editDiv").hover(function() {
		$(this).find("span[class='showSpan']").hide();
		$(this).find("span[class='editSpan']").show();
	},function(){
		$(this).find("span[class='editSpan']").hide();
		$(this).find("span[class='showSpan']").show();
	});
}

</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="fileForm" style="position: relative;" enctype="multipart/form-data" method="post">
			<table width="100%" cellpadding="0" cellspacing="0" class="basic">
				<colgroup>
					<col width="22%"/>
					<col width="78%"/>
				</colgroup>
				<tbody>
				<tr>
					<td style="text-align: right;padding-right: 10px;">文&#12288;&#12288;档：</td>
					<td>
						<input type="file" name="file" class="validate[required]"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;padding-right: 10px;">文档摘要：</td>
					<td>
						<input name="docSummary" type="text" placeholder="请输入文档摘要" class="xltext" style="width: 390px;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;padding-right: 10px;">文档类型：</td>
					<td>
						<select class="xlselect" name="docTypeId" style="width: 108px;">
					        <option value="">请选择</option>
							<c:forEach var="docType" items="${dictTypeEnumDocTypeList}">
								<option value="${docType.dictId}" >${docType.dictName}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;padding-right: 10px;">公共文档：</td>
					<td>
						<input id="isPublic_${GlobalConstant.FLAG_Y }" name="isPublic" type="checkbox" value="${GlobalConstant.FLAG_Y }" onclick="selectSingle(this);share();"/><label for="isPublic_${GlobalConstant.FLAG_Y }">&nbsp;是</label>&nbsp;
						<input id="isPublic_${GlobalConstant.FLAG_N }" name="isPublic" type="checkbox" value="${GlobalConstant.FLAG_N }" onclick="selectSingle(this);share();"  checked/><label for="isPublic_${GlobalConstant.FLAG_N }">&nbsp;否</label>&nbsp;
					</td>
				</tr>
				<tr class="editDiv" id="shareTr">
					<td style="text-align: right;padding-right: 10px;">共享给其他人：</td>
					<td>
						<span id="shareUserSpan"></span>
						<img title="添加共享人" src="<s:url value="/css/skin/${skinPath}/images/add_user.png" />" style="cursor: pointer;" onclick="userMain();" />
					</td>
				</tr>
				</tbody>
			</table>
			</form>
		</div>
		<div class="button">
			<input type="button" id="saveButton" class="search" value="保&#12288;存" onclick="saveDoc();" />
			<input type="button" class="search" value="关&#12288;闭" onclick="jboxCloseMessager();" >
		</div>
	</div>
</div>
</body>
</html>