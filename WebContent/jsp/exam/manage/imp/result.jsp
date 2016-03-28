<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<jsp:param name="jquery_datePicker" value="false"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ztree" value="false"/>
</jsp:include>
<script type="text/javascript">
<c:if test='${action eq "result"}'>
function doSubmit(bookImpFlow){
	jboxConfirm("确认提交吗！",function () {
		var url = "<s:url value='/exam/manage/imp/submit'/>?bookImpFlow="+bookImpFlow;
		var data = $('#sysOrgForm').serialize();
		jboxPost(url, data, function() {
			//window.parent.frames['mainIframe'].window.location.reload(true);
			window.parent.frames['mainIframe'].window.search();
			jboxClose();
		});
	});
}
</c:if>
<c:if test='${action eq "check"}'>
function check(bookImpFlow , statusId , obj){
	jboxConfirm("确认"+$(obj).attr("value")+"吗！",function () {
		var url = "<s:url value='/exam/manage/imp/operate'/>";
		var data = {
				"bookImpFlow":bookImpFlow,
				"statusId":statusId
		};
		jboxPost(url, data, function() {
			//window.parent.frames['mainIframe'].window.location.reload(true);
			window.parent.frames['mainIframe'].window.search();
			jboxClose();
		} , null , true);
	});
}
</c:if>
<c:if test='${action eq "audit"}'>
function audit(bookImpFlow , statusId){
    jboxConfirm("确认吗！",function () {
	    var url = "<s:url value='/exam/manage/imp/operate'/>";
	    var data = {
			"bookImpFlow":bookImpFlow,
			"statusId":statusId,
			"subjectFlow":$("#subjectFlow").val(),
			"subjectMemo":$("#subjectMemo").val()
	    };
	    jboxPost(url, data, function() {
		    //window.parent.frames['mainIframe'].window.location.reload(true);
		    window.parent.frames['mainIframe'].window.search();
		    jboxClose();
	    } , null , true);
	});
}

function beforeClick(treeId, treeNode) {
	var check = (treeNode && !treeNode.isParent);
	if (!check) 
		jboxTip("只能选择末节点导入");
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
</c:if>
function viewQuestionFile(detailFlow , typeId){
	$('#'+typeId+"_content").parent("tr").show();
	if($('#'+typeId+"_content").html().length==0){
		var url = "<s:url value='/exam/manage/imp/showquestioncontent'/>?detailFlow="+detailFlow+"&questionTypeId="+typeId;
		jboxGet(url , null , function(data){
			$('#'+typeId+"_content").html(data);
		} , null , false);
	}
	
}
function hideQuestionContent(typeId){
	$('#'+typeId+"_content").parent("tr").hide();
}


$(document).ready(function(){
	
});
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
			    <c:if test='${action eq "audit"}'>
                        <a id="menuBtn" href="#" onclick="loadSubTree();">选择科目</a>
						<input id="subjectMemo" value="${bookImp.subjectMemo}" type="text" class="xltext"  style="width:200px;background: #cccccc;" onfocus=""/>
					    <input id="subjectFlow" name="subjectFlow" type="hidden" value="${bookImp.subjectFlow}">
				</c:if>
			</div>			
			<table class="basic" style="width: 100%;height: 100%;">
				<tr>
					<th style="text-align: left;" colspan="3">&#12288;&#12288;导入结果
					</th>
				</tr>
				<tr>
					<th style="text-align: left;">&#12288;题型</th>
					<th style="text-align: left;">&#12288;数量
				</tr>
			   	<c:forEach items="${questionTypeEnumList}" var="questionTypeEnum" varStatus="status">
			   		<c:if test="${ not empty examBookImpDetailMap[questionTypeEnum.id] }">
					<tr style="cursor: pointer;" onclick=""> 
						<td>
							${questionTypeEnum.name}
						</td>
						<td>
						    ${examBookImpDetailMap[questionTypeEnum.id].questionNum}
						    &nbsp;&nbsp;&nbsp;&nbsp;
						    <a onclick="viewQuestionFile('${examBookImpDetailMap[questionTypeEnum.id].impDetailFlow}' , '${questionTypeEnum.id}');">[查看]</a>
						    <a onclick="hideQuestionContent('${questionTypeEnum.id}');">[收起]</a>
						</td>
					</tr>	
					<tr style="display: none;">
					    <td colspan="2" id="${questionTypeEnum.id}_content" style="padding-left: 0px;"></td>
					</tr>
					</c:if>		
				</c:forEach>		
			</table>
			<c:if test='${action eq "audit"}'>
			    <div id="menuContent" class="menuContent" style="position: absolute; top: 134px;display: block;">
				    <ul id="bookTree" class="ztree" style="margin-top:0; width:360px;"></ul>
			    </div>
			</c:if>
			<div class="button" style="width: 800px;">
			    <c:if test='${action eq "result"}'>
			        <input class="search" type="button" value="提&#12288;交" onclick="doSubmit('${param.bookImpFlow}');" />
			    </c:if>
				<c:if test='${action eq "check"}'>
				    <input class="search" type="button" value="校验通过" onclick="check('${param.bookImpFlow}' , '${bookImpStatusEnumChecked.id}' , this);" />
				    <input class="search" type="button" value="校验不通过" onclick="check('${param.bookImpFlow}' , '${bookImpStatusEnumNotChecked.id}' , this);" />
				</c:if>
				<c:if test='${action eq "audit"}'>
				    <input class="search" type="button" value="审核通过" onclick="audit('${param.bookImpFlow}' , '${bookImpStatusEnumAudited.id}' , this);" />
				    <input class="search" type="button" value="审核不通过" onclick="audit('${param.bookImpFlow}' , '${bookImpStatusEnumNotAudited.id}' , this);" />
				</c:if>
			</div>
	</div>
</div>
</body>
</html>