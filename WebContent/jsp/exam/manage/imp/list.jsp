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
<script type="text/javascript">
function add() {
	jboxOpen("<s:url value='/exam/manage/imp/imp'/>","导入新题目", 900, 600);
}

function search() {
	jboxStartLoading();
	$("#searchForm").submit();
}

function doImp(){
	var treeObj = $.fn.zTree.getZTreeObj("bookTree");
	if(treeObj!=null){
		var nodes = treeObj.getSelectedNodes();
		var id = "";
		if(nodes!=null&&nodes.length>0){
			id = nodes[0].id;
			var isParent = nodes[0].isParent;
			if(isParent==true){
				jboxTip("该节点不能导入题目数据");
				return;
			}
			if(nodes[0].getParentNode().count!=0){
				jboxTip("请先处理父节点错误关系");
				return;
			}
			var url = "<s:url value='/exam/manage/book/imp'/>?bookFlow="+id;
			jboxLoad("rightDiv",url,true);
		}else{
			jboxTip("请选择书目");
			return;
		}
	}else{
		jboxTip("请搜索书目");
		return;
	}
}

function doImpResult(){
	var treeObj = $.fn.zTree.getZTreeObj("bookTree");
	if(treeObj!=null){
		var nodes = treeObj.getSelectedNodes();
		var id = "";
		if(nodes!=null&&nodes.length>0){
			id = nodes[0].id;
			var isParent = nodes[0].isParent;
			if(isParent==true){
				jboxTip("该节点不能导入题目数据");
				return;
			}
			if(nodes[0].getParentNode().count!=0){
				jboxTip("请先处理父节点错误关系");
				return;
			}
			var url = "<s:url value='/exam/manage/book/impResult'/>?bookFlow="+id;
			jboxLoad("rightDiv",url,true);
		}else{
			jboxTip("请选择书目");
			return;
		}
	}else{
		jboxTip("请搜索书目");
		return;
	}
}

function doSubmit(bookImpFlow){
	jboxConfirm("确认提交吗！",function () {
		$("#flagFlow").val(bookImpFlow);
		var url = "<s:url value='/exam/manage/imp/submit'/>?bookImpFlow="+bookImpFlow;
		jboxPost(url,null, function() {
			//window.parent.frames['mainIframe'].window.location.reload(true);
			//jboxClose();
			search();
		});
	});
}

function view(bookImpFlow){
	var url = "<s:url value='/exam/manage/imp/view'/>?bookImpFlow="+bookImpFlow;
	jboxOpen(url,"题目查看", 900, 600);
}

function edit(bookImpFlow){
	$("#flagFlow").val(bookImpFlow);
	var url = "<s:url value='/exam/manage/imp/impedit'/>?bookImpFlow="+bookImpFlow;
	jboxOpen(url,"题目重传", 900, 600);
}

function viewReloadRec(bookFlow){
	var url = "<s:url value='/exam/manage/imp/viewReloadRec'/>?bookFlow="+bookFlow;
	jboxOpen(url,"重传记录", 900, 600);
}
	
function toPage(page) {
	if(page!=undefined){
		$("#currentPage").val(page);			
	}
	search();
}

function changeColor(obj){
	$(obj).parent("tr").css("background-color" , "pink").siblings().css("background-color" , "");
}

</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" action="<s:url value="/exam/manage/imp/list" />"	method="post">
					书号：<input name="examBook.bookNum" value="${bookImpExt.examBook.bookNum}"/>
					&nbsp;&nbsp;
					<input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage}"/>
					<input type="button" class="search" onclick="search();" value="查&#12288;询">
					<input type="button" class="search" onclick="add();" value="导入新题目">
					<input id="flagFlow" type="hidden" name="flagFlow" value="${param.flagFlow}"/>
				</form>
			</div>			
			<table id="impTable" class="xllist">
				<thead>
				<tr>
				    <th width="50px;">书号</th>
					<th width="40%">导入书本</th>
					<th width="20%">导入科目</th>
					<th width="60px">导入人</th>
					<th width="120px">导入时间</th>
					
					<th width="60px">校验人</th>
					<th width="120px">校验时间</th>
					
					<th width="60px">审核人</th>
					<th width="120px">审核时间</th>
					
					<th width="100px">状态</th>
					<th width="150px">操作</th>
				</tr>
				</thead>						
				<tbody>
				<c:forEach items="${examImpList}" var="imp">
					<tr <c:if test='${imp.bookImpFlow eq param.flagFlow}'>style="background-color:pink"</c:if>>
					    <td>${imp.examBook.bookNum}</td>
						<td>${imp.bookName}</td>
						<td>${imp.subjectMemo}</td>
						<td>${imp.impUserName }</td>
						<td>${pdfn:transDateTime(imp.impTime)}</td>
						
						<td>${imp.checkUserName}</td>
						<td>${pdfn:transDateTime(imp.checkTime)}</td>
						
						<td>${imp.auditUserName }</td>
						<td>${pdfn:transDateTime(imp.auditTime)}</td>
						
						<td>${imp.statusDesc}</td>
						<td onclick="changeColor(this);">
						    <c:if test='${imp.statusId eq bookImpStatusEnumSave.id || imp.statusId eq bookImpStatusEnumNotChecked.id || imp.statusId eq bookImpStatusEnumNotAudited.id}'>
							    [<a href="javascript:edit('${imp.bookImpFlow}');">重传</a>] 
							</c:if>
							<c:if test='${imp.statusId eq bookImpStatusEnumSave.id}'>[<a href="javascript:doSubmit('${imp.bookImpFlow}');">提交</a>]</c:if>
						    [<a href="javascript:view('${imp.bookImpFlow}');">查看</a>] [<a href="javascript:viewReloadRec('${imp.bookFlow}');">重传记录</a>]
						</td>
					</tr>
				</c:forEach>
				</tbody>
				<c:if test="${examImpList == null || examImpList.size()==0 }"> 
					<tr> 
						<td align="center" colspan="11">无记录</td>
					</tr>
				</c:if>
			</table>
			<c:set var="pageView" value="${pdfn:getPageView(examImpList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>
	</div>
</div>
</body>
</html>