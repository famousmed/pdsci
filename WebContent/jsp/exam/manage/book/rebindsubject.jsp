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
	<jsp:param name="jquery_fixedtableheader" value="false"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ztree" value="true"/>
</jsp:include>
<script type="text/javascript">
function bindSubject(){
	jboxConfirm("确认提交？",function () {
		var url = "<s:url value='/exam/manage/book/bindsubject'/>";
		var data = $('#bindSubjectForm').serialize();
		jboxPost(url, data, function() {
			window.parent.frames['mainIframe'].window.refreshStat();
			jboxClose();
		});
	});
}

function beforeClick(treeId, treeNode) {
	var check = (treeNode && !treeNode.isParent);
	if (!check) 
		jboxTip("只能选择末节点");
	return check;
}

function showMenu(typeId) {
	var bookObj = $("#"+typeId);
	var bookOffset = bookObj.offset();
	$("#menuContent").css({left:bookOffset.left + "px", top:bookOffset.top + bookObj.outerHeight() + "px"}).slideDown("fast");
	$("body").bind("mousedown", onBodyDown);
}

function hideMenu() {
	$("#menuContent").fadeOut("fast");
	$("body").unbind("mousedown", onBodyDown);
}

function onBodyDown(event) {
	if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
		hideMenu();
	}
}

var subsetting = {
		data: {
			simpleData: {
				enable: true,
				pIdKey:"pid",
				rootPId:"-1"
			}
		},
	    async: {    
            enable: true,    
               url:"<s:url value='/exam/manage/imp/subTree/${examBankTypeEnumBank0.id}'/>",    
               autoParam:["id"]  
        },
        view: {
    		dblClickExpand: false,
    		selectedMulti: false
    	},
    	callback: {
    		beforeClick: beforeClick,
    		onClick: onClickForSub
    	}
	};
	
function onClickForSub(e, treeId, treeNode) {
	v = treeNode.name;
	id = treeNode.id;
	if (v.length > 0 ) v = v.substring(0, v.lastIndexOf("["));
	var bookObj = $("#subjectMemo");
	bookObj.attr("value", v);
	var hiddenObj = $("#subjectFlow");
	hiddenObj.attr("value", id);
}	
function loadSubTree(){
	var url = "<s:url value='/exam/manage/imp/subTree/${examBankTypeEnumBank0.id}'/>";
	jboxGet(url , null , function(data){
		$.fn.zTree.init($("#bookTree"), subsetting , data);
		showMenu("subjectMemo"); 
	} , null , false);
}

$(document).ready(function(){
	hideMenu();
});
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
			</div>			
			<form id="bindSubjectForm" action="<s:url value='/exam/manage/book/bindsubject'/>" method="post">
			<table class="basic" style="width: 100%;height: 100%;">
				<tr>
					<th style="text-align: left;" colspan="3">
						<p>书号：<span>${topBook.bookNum}</span></p>
						<p>书目：<span>${book.memo}</span></p>
						<input id="bookFlow" name="bookFlow" type="hidden" value="${book.bookFlow}">
						<br/>
						<p>
						<a id="menuBtn" href="#" onclick="loadSubTree();">选择科目</a>
						<input id="subjectMemo" type="text" class="xltext"  style="width:200px;" onfocus="loadSubTree();"/>
					    <input id="subjectFlow" name="subjectFlow" type="hidden" value="">
					    <input id="oldSubjectFlow" name="oldSubjectFlow" type="hidden" value="${param.subjectFlow}">
					    </p>
					</th>
				</tr>
			</table>
			</form>
			<div id="menuContent" class="menuContent" style="position: absolute; top: 134px;display: block;">
				<ul id="bookTree" class="ztree" style="margin-top:0; width:360px;"></ul>
			</div>
			<div class="button" style="width: 800px;">
				<input class="search" type="button" value="提&#12288;交" onclick="bindSubject();" />
			</div>
	</div>
</div>
</body>
</html>