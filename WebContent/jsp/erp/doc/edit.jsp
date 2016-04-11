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
	<jsp:param name="jquery_cxselect" value="true"/>
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
<style>
.edit3{text-align: left;border:none;}
</style>
<script type="text/javascript" src="<s:url value='/js/j.suggest.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
function share() {
	if ($("[name='isPublic']:checked").val() == "${GlobalConstant.FLAG_N }") {
		$("#shareTr").show();
	} else {
		$("#shareTr").hide();
	}
}

function selectSingle(obj) {
	var value = $(obj).val();
	var name = $(obj).attr("name");
	$("input[name="+name+"][value!="+value+"]:checked").attr("checked",false);
	//修改
	var data = {
		docFlow:"${param.docFlow}",
		isPublic : value
	};
	var url = "<s:url value='/erp/doc/modifyErpDoc'/>";
	jboxPost(url, data, null, null, false);
	if("${GlobalConstant.FLAG_Y}"== value){
		$("#isPublicText").text("是");
	}else{
		$("#isPublicText").text("否");
	}
	refreshLog();
}

$(document).ready(function(){
	if("${param.docCategory}" == "created"){
		init();
	}
	share();
	readCase("${param.docFlow}");
});

function init(){
	$(".editDiv").hover(function() {
		$(this).find("span[class='showSpan']").hide();
		$(this).find("span[class='editSpan']").show();
		if ($("#searchParam_Label").is(":visible")) {
			$("#addLabelImg").hide();
		}
	},function(){
		$(this).find("span[class='editSpan']").hide();
		$(this).find("span[class='showSpan']").show();
	});
}

function modifyErpDoc(obj, property){
	if(false == $("#erpDocForm").validationEngine("validate")){
		return false;
	}
	$(obj).addClass("edit3");
	if($(obj).val()==$(obj).attr("oldvalue")){
		return;
	}
	var docFlow = $("input[name='docFlow']").val();
	var data = "";
	if(property=="docName"){
		data = {
			docFlow	: docFlow,
			docName : $(obj).val()
		};
	}else if(property=="docSummary"){
		data = {
			docFlow	: docFlow,
			docSummary : $(obj).val()
		};
	}else if(property=="docTypeId"){
		var docTypeId = $(obj).val();
		data = {
			docFlow	: docFlow,
			docTypeId : docTypeId
		}; 
	}
	var url = "<s:url value='/erp/doc/modifyErpDoc'/>";
	jboxPost(url, data, null, null, false);
	$(obj).attr("oldvalue",$(obj).val());
	if($(obj).attr("name")=="docName"){
		window.parent.frames['mainIframe'].$("#${erpDoc.docFlow}_docName").text($(obj).val());
	}
	refreshLog();
}

function refreshLog(){
	setTimeout(function(){
		$(".selectTag :first-child").trigger("click");
	},500);
}

function changeDocTypeId(obj){
	var docTypeId = $(obj).val();
	if(""==docTypeId){
		$("#docTypeIdSpan").html("");
	}else{
		var docTypeName = $("select[name='docTypeId'] option[value='"+docTypeId+"']:selected").text();
		$("#docTypeIdSpan").html(docTypeName);
	}
}

function changeStyle(obj,stylename){
	$(obj).removeClass(stylename);
}

function comments(){
	selectTag('<s:url value="/erp/doc/comments"/>','fkjpl');
}

function readCase(docFlow){
	var url ="<s:url value="/erp/doc/searchDocLogs"/>?reqTypeId=${reqTypeEnumGET.id}&docFlow=" + docFlow;
	selectTag(url,'cyqk');
}

function logs(docFlow){
	var url ="<s:url value="/erp/doc/searchDocLogs"/>?docFlow=" + docFlow;
	selectTag(url,'czrz');
}

function selectTag(url, id) {
    // 操作标签
    var tag = document.getElementById("tags").getElementsByTagName("li");
    var taglength = tag.length;
    for (i = 0; i < taglength; i++) {
        tag[i].className = "ui-bluetag";
    }
    document.getElementById(id).parentNode.className = "selectTag";
    // 操作内容
    jboxLoad("contentDiv",url,true);
}

function docLog(fileFlow, docFlow, docName){
	var url = "<s:url value='/erp/doc/docLog'/>";
	var data = {
		docFlow : docFlow,
		docName : docName
	};
	jboxPost(url, data, function(){
		var downUrl = "<s:url value='/pub/file/down?fileFlow='/>" + fileFlow;
		window.location.href = downUrl;
		refreshLog();
	}, null, false);
}
</script>
</head>
<body>
<div class="mainright">
<div class="content">
<div class="title1 clearfix">
		<form id="erpDocForm" method="post">
		<input type="hidden" name="docFlow" value="${erpDoc.docFlow}"/>
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
			<tbody>
			<tr>
				<td>
					<c:if test="${param.docCategory == 'created'}">
						文档名称：<input name="docName" type="text" value="${erpDoc.docName}" oldvalue="${erpDoc.docName}" onfocus="changeStyle(this,'edit3');" onblur="modifyErpDoc(this,'docName');" class="validate[required,maxSize[100]] edit3" style="width: 85%;"/>
					</c:if>
					<c:if test="${param.docCategory != 'created'}">文档名称：${erpDoc.docName}</c:if>
				</td>
			</tr>
			<tr>
				<td>
					文件名称：<a target="_self" href="javascript:void(0);" onclick="docLog('${erpDoc.fileFlow}','${erpDoc.docFlow}','${erpDoc.docName}');">${erpDoc.fileName}</a>
				</td>
			</tr>
			<tr>
				<td>
					<c:if test="${param.docCategory == 'created'}">
						文档摘要：<input name="docSummary" type="text" 
						<c:if test="${empty erpDoc.docSummary}">placeholder="请输入文档摘要"</c:if> 
						<c:if test="${not empty erpDoc.docSummary}">value="${erpDoc.docSummary}" </c:if> oldvalue="${erpDoc.docSummary}"
						onfocus="changeStyle(this,'edit3');" onblur="modifyErpDoc(this,'docSummary');" class="validate[maxSize[2000]] edit3" style="width: 85%;"/>
					</c:if> 
					<c:if test="${param.docCategory != 'created'}">文档摘要：${erpDoc.docSummary}</c:if> 
				</td>
			</tr>
			<tr class="editDiv">
				<td>
					文档类型：<span id="docTypeIdSpan" class="showSpan">${erpDoc.docTypeName}</span>
					<span class="editSpan" style="display: none;">
					<select name="docTypeId" style="width: 108px;" oldvalue="${erpDoc.docTypeId}"  onchange="changeDocTypeId(this);" onblur="modifyErpDoc(this,'docTypeId');">
				        <option value="">请选择</option>
						<c:forEach var="docType" items="${dictTypeEnumDocTypeList}">
							<option value="${docType.dictId}" <c:if test="${erpDoc.docTypeId eq docType.dictId}">selected="selected"</c:if>>${docType.dictName}</option>
						</c:forEach>
					</select>
					</span>
				</td>
			</tr>
			<tr class="editDiv">
				<td>
					公共文档：<span class="showSpan" id="isPublicText">${erpDoc.isPublic eq GlobalConstant.FLAG_Y?'是':'否'}</span>
					<span class="editSpan" style="display: none;">
						<input id="isPublic_${GlobalConstant.FLAG_Y}" name="isPublic" <c:if test="${erpDoc.isPublic eq GlobalConstant.FLAG_Y}">checked="checked"</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" oldvalue="${erpDoc.isPublic}" onclick="selectSingle(this);share();"/><label for="isPublic_${GlobalConstant.FLAG_Y }">&nbsp;是</label>&nbsp;
						<input id="isPublic_${GlobalConstant.FLAG_N}" name="isPublic" <c:if test="${erpDoc.isPublic eq GlobalConstant.FLAG_N}">checked="checked"</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" oldvalue="${erpDoc.isPublic}" onclick="selectSingle(this);share();"/><label for="isPublic_${GlobalConstant.FLAG_N }">&nbsp;否</label>&nbsp;
					</span>
				</td>
			</tr>
			<tr class="editDiv" id="shareTr">
				<td>
					共享：
					<c:forEach items="${docShareList}" var="docShare" varStatus="status">
						<c:if test="${!status.last}">
							${docShare.shareRecordName}，
						</c:if>
						<c:if test="${status.last}">
							${docShare.shareRecordName}
						</c:if>
					</c:forEach>
				</td>
			</tr>
			</tbody>
		</table>
		</form>
		
		
		<ul id="tags" style="padding-top: 10px;">
			<%-- <li class="selectTag"><a onclick="comments('${erpDoc.docFlow}');" href="javascript:void(0)" id="fkjpl">反馈及评论</a></li> --%>
			<li><a onclick="readCase('${erpDoc.docFlow}');" href="javascript:void(0)" id="cyqk">查阅情况</a></li>
			<li><a onclick="logs('${erpDoc.docFlow}');" href="javascript:void(0)" id="czrz">操作日志</a></li>
	    </ul>
	    <table class="i-trend-table" cellpadding="0" cellspacing="0" >
		    <tbody>
		        <tr>
		          <td>
		            <div id="contentDiv" style="border:none;">
					</div>
		          </td>
		        </tr>
		    </tbody>
	    </table>

		<div class="button">
			<input type="button" class="search" value="关&#12288;闭" onclick="jboxClose();" >
		</div>			
</div>
</div>
</div>
</body>
</html>