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
function doUplaod(){
	jboxConfirm("确认上传吗！",function () {
		jboxStartLoading();
		$("#uploadForm").submit();
	});
}

var setting = {
	view: {
		dblClickExpand: false,
		selectedMulti: false
	},
	data: {
		simpleData: {
			enable: true
		}
	},
	callback: {
		beforeClick: beforeClick,
		onClick: onClick
	},
    async: {    
        enable: true,    
        url:"<s:url value='/exam/manage/imp/tree'/>",    
        autoParam:["id"]  
    }
};

//function zTreeBeforeAsync(treeId , treeNode){
//	var treeObj = $.fn.zTree.getZTreeObj(treeId);
//	treeObj.setting.async.url="http://www.baidu.com";
//	return true;
//}

function loadTree(){
	var bookNum = $("#bookNum").val();
	if(bookNum==''){
		jboxTip("请输入书号进行查询");
		return ;
	}
	var url = "<s:url value='/exam/manage/imp/tree'/>?bookNum="+bookNum;
	jboxGet(url , null , function(data){
		$.fn.zTree.init($("#bookTree"), setting , data);
		showMenu("bookName"); 
	} , null , false);
}

function beforeClick(treeId, treeNode) {
	var check = (treeNode && !treeNode.isParent);
	if (!check) 
		jboxTip("只能选择末节点导入");
	return check;
}

function onClick(e, treeId, treeNode) {
	v = treeNode.name;
	id = treeNode.id;
	if (v.length > 0 ) v = v.substring(0, v.lastIndexOf("["));
	var bookObj = $("#bookName");
	bookObj.attr("value", v);
	var hiddenObj = $("#bookFlow");
	hiddenObj.attr("value", id);
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

function rechoosefile(questionTypeId , index){
	$('#'+questionTypeId+"_desc").hide();
	$('#'+questionTypeId+"_file").show();
	//$('#'+questionTypeId).append('<span id="'+questionTypeId+'_file"><input name="questionType" type="file" width="50px;"><input type="hidden" name="'+index+'" value="'+questionTypeId+'"><a onclick="cancelfile('+questionTypeId+' , '+index+');">取消</a></span>');
}

function cancelfile(questionTypeId , index){
	$('#'+questionTypeId+"_desc").show();
	$('#'+questionTypeId+"_file").remove();
	$('#'+questionTypeId).append('<span id="'+questionTypeId+'_file"><input name="questionType" type="file" width="50px;"><input type="hidden" name="'+index+'" value="'+questionTypeId+'"><a onclick="cancelfile('+questionTypeId+' , '+index+');">取消</a></span>');
	$('#'+questionTypeId+"_file").hide();
}

function empty(impDetailFlow){
	jboxConfirm("确认清空该题型导入的文件？" , function(){
		jboxPost("<s:url value='/exam/manage/imp/emptyimpdetail'/>" , {"impDetailFlow":impDetailFlow} , function(resp){
			window.location.reload(true);
		} , null , true);
	});
	
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
			<iframe name="hidden_frame" id="hidden_frame" style="display:none"></iframe>
			<form id="uploadForm" action="<s:url value='/exam/manage/imp/reupload'/>" method="post" enctype="multipart/form-data">
			<table class="basic" style="width: 100%;height: 100%;">
				<tr>
					<th style="text-align: left;" colspan="3">
						书号：<input id="bookNum" name="bookNum" value="${bookImp.examBook.bookNum}" type="text" class="xltext" style="width:50px;" onblur="loadTree();">
						<a id="menuBtn" href="#" onclick="loadTree();return false;">选择</a>
						<input id="bookName" name="bookName" type="text" class="xltext" value="${bookImp.examBook.bookName}"  style="width:360px;" onfocus="loadTree();">
						<input id="bookFlow" name="bookFlow" type="hidden" value="${bookImp.examBook.bookFlow}">
						<input name="bookImpFlow" value="${bookImp.bookImpFlow}" type="hidden">
						
						<a id="menuBtn" href="#" onclick="loadSubTree();">选择科目</a>
						<input id="subjectMemo" type="text" class="xltext" value="${bookImp.subjectMemo}"  style="width:200px;" onfocus="loadSubTree();"/>
					    <input id="subjectFlow" name="subjectFlow" type="hidden" value="${bookImp.subjectFlow}">
					</th>
				</tr>
				<tr>
					<th style="text-align: left;">&#12288;题型</th>
					<!-- <th style="text-align: left;">&#12288;科目</th> -->
					<th style="text-align: left;">&#12288;文件
				</tr>
			   		<c:forEach items="${questionTypeEnumList}" var="questionTypeEnum" varStatus="status">
					<tr style="cursor: pointer;" onclick=""> 
						<td>
							${questionTypeEnum.name }
						</td>
						<td>
						    <c:if test='${not empty bookImpDetailMap[questionTypeEnum.id]}'>
						    <div id="${questionTypeEnum.id}">
						        <span id="${questionTypeEnum.id}_desc">已存在文件
						            &nbsp;&nbsp;&nbsp;&nbsp;<a onclick="rechoosefile('${questionTypeEnum.id}' , '${status.index}');">重新选择</a>
						            &nbsp;&nbsp;&nbsp;&nbsp;<a onclick="empty('${bookImpDetailMap[questionTypeEnum.id].impDetailFlow}');">清空</a>
						        </span>
						        <span id="${questionTypeEnum.id}_file" style="display: none;">
						            <input name="questionType" type="file" width="50px;">
						            <input name="${status.index}" value="${questionTypeEnum.id}" type="hidden">
						            <a onclick="cancelfile('${questionTypeEnum.id}' , '${status.index}');">取消</a>
						        </span>
						    </div>         
						    </c:if>
						    <c:if test='${empty bookImpDetailMap[questionTypeEnum.id]}'>
							    <input name="questionType" type="file">
							    <input name="${status.index}" value="${questionTypeEnum.id}" type="hidden">
							</c:if>
							
						</td>
					</tr>			
					</c:forEach>		
			</table>
			</form>
			<div id="menuContent" class="menuContent" style="position: absolute;left: 59px; top: 134px;display: block;">
				<ul id="bookTree" class="ztree" style="margin-top:0; width:360px;"></ul>
			</div>
			<div class="button" style="width: 800px;">
				<input class="search" type="button" value="重新上传" onclick="doUplaod();" />
			</div>
	</div>
</div>
</body>
</html>