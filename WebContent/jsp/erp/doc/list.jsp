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
.edit3{text-align: center;border:none;}
</style>
<script type="text/javascript">
function search(){
	$("#searchForm").submit();
}

function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	jboxStartLoading();
	form.submit();
}

function batch(type){
	var checkboxs = $("input[name='doc']:checked");
	if(checkboxs.length == 0){
		jboxTip("请先勾选记录！");
		$("select[id='batchSel'] option:selected").attr("selected",false);
		return false;
	}
	if(type=="share"){
		var url = "<s:url value='/erp/doc/userMain'/>?type=" + type;
		jboxOpen(url, "选择共享个人/部门(批量共享)", 800, 500, false);
	}else if(type=="del"){
		jboxConfirm("确认批量删除文档?",  function(){
			jboxStartLoading();
			var docFlow = "";
			$("input[name='doc']:checked").each(function (index, domEle) { 
				docFlow +=  "," +  $(this).val();
			});
			docFlow = docFlow.substring(1);
			var data = {
				docFlow : docFlow
			};
			var url = "<s:url value='/erp/doc/batchDelDoc'/>";
			jboxPost(url, data, function(resp){
				if("${GlobalConstant.DELETE_SUCCESSED}" == resp){
					search();
				}
			}, null, true);
		});
	}
	$("select[id='batchSel'] option:selected").attr("selected",false);
}

$(document).ready(function(){
	init();
});

function init(){
	$(".docDiv").hover(function() {
		$(this).find("span[class='showSpan']").hide();
		$(this).find("span[class='editSpan']").show();
	},function(){
		$(this).find("span[class='editSpan']").hide();
		$(this).find("span[class='showSpan']").show();
	});
}

function selDoc(obj){
	if ($(obj).attr("checked")=="checked") {
		$(obj).closest("tr").find("span[name='seq']").removeClass();
		$(obj).closest("tr").find("span[name='selDoc']").removeClass();
	} else {
		$(obj).closest("tr").find("span[name='seq']").addClass("showSpan");
		$(obj).closest("tr").find("span[name='selDoc']").addClass("editSpan");
	}
}

function selAll(obj){
	if (obj.checked) {
		$(".docDiv").each(function(i){
			$(this).find("span[name='seq']").hide();
			$(this).find("span[name='selDoc']").show();
			$(this).find("[name='doc']").attr("checked",true);
			$(this).find("span[name='seq']").removeClass();
			$(this).find("span[name='selDoc']").removeClass();
		 });
	} else {
		$(".docDiv").each(function(i){
			$(this).find("span[name='seq']").show();
			$(this).find("span[name='selDoc']").hide();
			$(this).find("[name='doc']").attr("checked",false);
			$(this).find("span[name='seq']").addClass("showSpan");
			$(this).find("span[name='selDoc']").addClass("editSpan");
		 });
	}
}

function add(){
	var url="<s:url value='/erp/doc/addDoc'/>";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='600px;' height='400px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe, "上传文档", 600, 400);
}

function share(docFlow) {
	var url = "<s:url value='/erp/doc/userMain'/>?type=edit&docFlow=" + docFlow;
	<c:if test="${docCategory == 'shared' }">
		url += "&docCategory=${docCategory}";
	</c:if>
	jboxOpen(url, "选择共享个人/部门", 800, 500, false);
}

function editDoc(docFlow){
	jboxOpen("<s:url value='/erp/doc/editDoc'/>?docCategory=${docCategory}&docFlow="+docFlow, "文档", 600, 650);
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
	}, null, false);
}

function delDoc(docFlow){
	var url = "<s:url value='/erp/doc/delDoc'/>?docFlow=" + docFlow;
	jboxConfirm("确认删除文档?",  function(){
		jboxPost(url, null, function(resp){
			if("${GlobalConstant.DELETE_SUCCESSED}" == resp){
				search();
			}
		}, null, true);
	});
}

function delDocShare(docFlow){
	var url = "<s:url value='/erp/doc/delDocShare'/>?docFlow=" + docFlow;
	jboxConfirm("确认删除共享给我的文档?",  function(){
		jboxPost(url, null, function(resp){
			if("${GlobalConstant.DELETE_SUCCESSED}" == resp){
				search();
			}
		}, null, true);
	});
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" name="searchForm" action="<s:url value="/erp/doc/list/${docCategory}"/>" method="post">
				<table style="width: 100%">
					<tr>
	                    <td align="left">
	                    	<div style="margin-bottom: 10px">
								名&#12288;&#12288;称：<input type="text" name="docName" value="${param.docName}"  placeholder="文档/文件名称" class="xltext" style="width: 100px;"/>
								<c:if test="${docCategory != 'created' }">创&nbsp;建&nbsp;&nbsp;人：<input type="text" name="userName" value="${param.userName}"  class="xltext" style="width: 100px;"/></c:if>
								创建时间：<input type="text" name="createTime" value="${param.createTime}" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:100px;margin: 0"/>&nbsp;~
								        <input type="text" name="afterDate" value="${param.afterDate}" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:100px;"/>
							</div>
							<div>
								文件类型：<select class="xlselect" name="fileType" style="width: 108px;">
					            	<option value="">请选择</option>
							        <c:forEach var="fileType" items="${fileTypeList}">
							            <option value="${fileType}" <c:if test="${param.fileType eq fileType}">selected="selected"</c:if>>${fileType}</option>
							        </c:forEach>
								</select>
								文档类型：<select class="xlselect" name="docTypeId" style="width: 108px;">
					            	<option value="">请选择</option>
							        <c:forEach var="docType" items="${dictTypeEnumDocTypeList}">
							            <option value="${docType.dictId}" <c:if test="${param.docTypeId  eq docType.dictId}">selected="selected"</c:if>>${docType.dictName}</option>
							        </c:forEach>
								</select>
								排&#12288;&#12288;序：<select class="xlselect" name="sortType" style="width: 108px;">
					            	<option value="CREATE_TIME DESC" <c:if test="${param.sortType eq 'CREATE_TIME DESC'}">selected="selected"</c:if>>文档创建时间</option>
					            	<option value="MODIFY_TIME DESC" <c:if test="${param.sortType eq 'MODIFY_TIME DESC'}">selected="selected"</c:if>>文档更新时间</option>
								</select>
								<input type="button" class="search" onclick="search();" value="查&#12288;询" >
							    <input id="currentPage" type="hidden" name="currentPage" value=""/>
							</div>
						</td>
						<td width="230px" align="right">
							<c:if test="${docCategory == 'created' or docCategory == 'shared'}">
							批量：<select class="xlselect" id="batchSel" onchange="batch(this.value);" style="width: 80px;margin: 0">
			            		<option value=""></option>
			            		<option value="share">批量共享</option>
			            		<c:if test="${docCategory == 'created'}">
			            			<option value="del">批量删除</option>
			            		</c:if>
							</select>
							</c:if>
							<input type="button" class="search" onclick="add();" value="新建文档">
						</td>
					</tr>
				</table>
				</form>
			</div>		
			<table class="xllist">
				<colgroup>
					<col width="5%"/>
					<col width="80%"/>
					<col width="15%"/>
				</colgroup>
				<tr>
					<th style="text-align: left;padding-left: 10px;border-right: 0;">
						<c:if test="${docCategory == 'created' or docCategory == 'shared'}">
							<input type="checkBox" onclick="selAll(this);" title="全选">
						</c:if>
						<c:if test="${docCategory == 'public' or docCategory == 'all'}">序号</c:if>
					</th>
					<th style="text-align: left;padding-left: 10px;border-right: 0;">文档名称</th>
					<th style="text-align: right;padding-right: 10px;border-right: 0;">创建日期</th>
				</tr>
				<tbody>
				<c:if test="${docCategory == 'created'}">
					<c:forEach items="${erpDocList}" var="erpDoc" varStatus="status">
					<tr class="docDiv">
						<td style="text-align: left;padding-left: 10px;border-right: 0;">
							<span name="seq" class="showSpan">${status.count}</span>
							<span name="selDoc" class="editSpan" style="display:none;">
								<input name="doc" type="checkBox" value="${erpDoc.docFlow}" onclick="selDoc(this);">
							</span>
						</td>
						<td style="text-align: left;padding-left: 10px;border-right: 0;" id="${erpDoc.docFlow}_docName">
							<a target="_self" href="javascript:void(0);" onclick="docLog('${erpDoc.fileFlow}','${erpDoc.docFlow}','${erpDoc.docName}');">${erpDoc.docName}</a>
						</td>
						<td style="text-align: right;padding-right: 10px;">
							<span class="showSpan">${pdfn:transDate(erpDoc.createTime)}</span>
							<span class="editSpan" style="display:none;">
								<a href="javascript:editDoc('${erpDoc.docFlow}');">编辑</a> |
								<a href="javascript:share('${erpDoc.docFlow}');">共享</a> |
								<a href="javascript:delDoc('${erpDoc.docFlow}');">删除</a>
							</span>
						</td>
					</tr>
					</c:forEach>
				</c:if>
				<c:if test="${docCategory == 'shared'}">
					<c:forEach items="${erpDocList}" var="erpDoc" varStatus="status">
					<tr class="docDiv">
						<td style="text-align: left;padding-left: 10px;border-right: 0;">
							<span name="seq" class="showSpan">${status.count}</span>
							<span name="selDoc" class="editSpan" style="display:none;">
								<input name="doc" type="checkBox" value="${erpDoc.docFlow}" onclick="selDoc(this);">
							</span>
						</td>
						<td style="text-align: left;padding-left: 10px;border-right: 0;">
							<a target="_self" href="javascript:void(0);" onclick="docLog('${erpDoc.fileFlow}','${erpDoc.docFlow}','${erpDoc.docName}');">${erpDoc.docName}</a>
						</td>
						<td style="text-align: right;padding-right: 10px;">
							<span class="showSpan">${pdfn:transDate(erpDoc.createTime)}</span>
							<span class="editSpan" style="display:none;">
								<a href="javascript:editDoc('${erpDoc.docFlow}');">查看</a> |
								<a href="javascript:share('${erpDoc.docFlow}');">共享</a>
							</span>
						</td>
					</tr>
					</c:forEach>
				</c:if>
				<c:if test="${docCategory == 'public'}">
					<c:forEach items="${erpDocList}" var="erpDoc" varStatus="status">
					<tr class="docDiv">
						<td style="text-align: left;padding-left: 10px;border-right: 0;">
							${status.count}
						</td>
						<td style="text-align: left;padding-left: 10px;border-right: 0;">
							<a target="_self" href="javascript:void(0);" onclick="docLog('${erpDoc.fileFlow}','${erpDoc.docFlow}','${erpDoc.docName}');">${erpDoc.docName}</a>
						</td>
						<td style="text-align: right;padding-right: 10px;">
							<span class="showSpan">${pdfn:transDate(erpDoc.createTime)}</span>
							<span class="editSpan" style="display:none;">
								<a href="javascript:editDoc('${erpDoc.docFlow}');">查看</a> 
							</span>
						</td>
					</tr>
					</c:forEach>
				</c:if>
				<c:if test="${docCategory == 'all'}">
					<c:forEach items="${erpDocList}" var="erpDoc" varStatus="status">
					<tr class="docDiv">
						<td style="text-align: left;padding-left: 10px;border-right: 0;">
							${status.count}
						</td>
						<td style="text-align: left;padding-left: 10px;border-right: 0;">
							<a target="_self" href="javascript:void(0);" onclick="docLog('${erpDoc.fileFlow}','${erpDoc.docFlow}','${erpDoc.docName}');">${erpDoc.docName}</a>
						</td>
						<td style="text-align: right;padding-right: 10px;">
							<span class="showSpan">${pdfn:transDate(erpDoc.createTime)}</span>
							<span class="editSpan" style="display:none;">
								<a href="javascript:editDoc('${erpDoc.docFlow}');">查看</a> 
							</span>
						</td>
					</tr>
					</c:forEach>
				</c:if>
				</tbody>
				<c:if test="${empty erpDocList}">
					<tr>
						<td colspan="3">无记录！</td>
					</tr>
				</c:if>
			</table>
			<p>
			   	<c:set var="pageView" value="${pdfn:getPageView2(erpDocList, 10)}" scope="request"/> 
				<pd:pagination toPage="toPage"/>
			</p>
	</div>
</div>
</body>
</html>