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
			<form id="uploadForm" action="<s:url value='/exam/manage/imp/questionreupload'/>" method="post" enctype="multipart/form-data">
			<table class="basic" style="width: 100%;height: 100%;">
				<tr>
					<th style="text-align: left;" colspan="3">
						书号：<input id="bookNum" name="bookNum" type="text" class="xltext" style="width:50px;" onblur="loadTree();" value="${param.bookNum}">
						<a id="menuBtn" href="#" onclick="loadTree();return false;">选择书目</a>
						<input id="bookName" name="bookName" type="text" class="xltext"  style="width:200px;" onfocus="loadTree();" value="${param.bookName}">
						<input id="bookFlow" name="bookFlow" type="hidden" value="${param.bookFlow}">
					</th>
				</tr>
				<tr>
					<th style="text-align: left;">&#12288;题型</th>
					<th style="text-align: left;">&#12288;文件
				</tr>
				<tr>
				    <td>选择题型：
				        <select name="questionTypeId" class="validate[required]">
				            <option value="">请选择</option>
				            <c:forEach items="${questionTypeEnumList}" var="questionTypeEnum" varStatus="status">
				                <option value="${questionTypeEnum.id}" <c:if test='${param.questionTypeId eq questionTypeEnum.id}'>selected="selected"</c:if>>${questionTypeEnum.name}</option>
				            </c:forEach>
				        </select>
				    </td>
				    <td><input name="questionFile" type="file" class="validate[required]"></td>
				</tr>
			</table>
			</form>
			<div id="menuContent" class="menuContent" style="position: absolute; top: 134px;display: block;">
				<ul id="bookTree" class="ztree" style="margin-top:0; width:360px;"></ul>
			</div>
			<div style="text-align: center;" class="button" style="width: 800px;">
				<input class="search" type="button" value="上&#12288;传" onclick="doUplaod();" />
			</div>
			
			<c:if test='${not empty registInfo or verifyInfo.passFlag==false}'>
			<div>
			    <h2>错误信息</h2>
			    <c:if test="${not empty registInfo }">
                    <p>${registInfo}</p>
                </c:if>
                <c:if test="${verifyInfo.passFlag==false}">
                                                操作失败<br/>
                                                失败题型：
                <c:forEach items="${questionTypeEnumList}" var="questionTypeEnum">
                    <c:if test="${questionTypeEnum.id eq verifyInfo.questionTypeId}">
                        ${questionTypeEnum.name}
                    </c:if>
                </c:forEach>
                <br/>
                                                第${verifyInfo.getQuestionNo()}题出错<br/>
                                                出错行数：${verifyInfo.getLineNum()}<br/>
                                                错误信息：${verifyInfo.msg}<br/>
                                               请检查题目文件信息后重新上传&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <br/>
                </c:if>
			</div>
			</c:if>
	</div>
</div>

</body>
</html>