<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="true"/>
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
function edit(dictFlow){
	jboxOpen("<s:url value='/sys/dict/edit?dictFlow='/>"+dictFlow,"编辑字典信息", 500,350);
}

function add(){
	jboxOpen("<s:url value='/sys/dict/edit?dictTypeId=${param.dictTypeId}'/>","编辑字典信息", 500,350);
}
function search(){
	jboxStartLoading();
	$("#searchForm").submit();	
}

function delDict(dictFlow,recordStatus , parentDictFlow , level){
	var msg = "";
	if(recordStatus=='${GlobalConstant.RECORD_STATUS_N}'){
		msg = "停用";
	}else if(recordStatus=='${GlobalConstant.RECORD_STATUS_Y}'){
		msg = "启用";
	}
	msg = "确认" + msg + "该记录吗？";
	var url = '<s:url value="/sys/dict/delete"/>?dictFlow='+dictFlow+"&recordStatus="+recordStatus;
	jboxGet(url, null , function() {
		if(parentDictFlow==''){
			window.parent.frames['mainIframe'].window.search();
			jboxClose();
		}else{
			viewChildNode(parentDictFlow , level);
		}
		
		
	});
}

var fixHelper = function(e, ui) {
    ui.children().each(function() {
   	//在拖动时，拖动行的cell（单元格）宽度会发生改变。在这里做了处理就没问题了  
        $(this).width($(this).width());
    });
    return ui;
};
$(function() {
	var oldPostData = "";
   $( "#sorttable" ).sortable({
   	helper: fixHelper,  
   	create: function(e, ui){
   		var oldSortedIds = $( "#sorttable" ).sortable( "toArray" );
   		$.each(oldSortedIds,function(i,sortedId){
   			oldPostData = oldPostData+"&dictFlow="+sortedId;
   		});
   	},
   	start:function(e, ui){
   	     //拖动时的行，要用ui.helper
   	    ui.helper.css({"background":"#eee"});
   	    return ui; 
   	}, 
   	stop: function( event, ui ) {
   		ui.item.css({"background":"#fff"});
   		var sortedIds = $( "#sorttable" ).sortable( "toArray" );
   		var postdata = "";
   		$.each(sortedIds,function(i,sortedId){
   			postdata = postdata+"&dictFlow="+sortedId;
   		});
   		if(oldPostData==postdata){
   			return;
   		}
   		var url = "<s:url value='/sys/dict/saveorder'/>";
   		jboxPost(url, postdata, function(data) {
   			},null,true);
   		oldPostData = postdata;
   	}
   });
   $( "#sorttable" ).disableSelection();
});

function viewChildNode(dictFlow , level){
	if(level==1){
		$("#subdict2").html("");
		$("#subdict3").html("");
	}
	level=parseInt(level)+1;
	var url = "<s:url value='/sys/dict/getChildDict'/>?dictFlow="+dictFlow+"&level="+level;
	jboxGet(url , null , function(data){
		$("#subdict"+level).html(data);
	} , null , false);
}

function subDictAdd(parentDictFlow , level){
	jboxOpen("<s:url value='/sys/dict/subdictedit?parentDictFlow='/>"+parentDictFlow+"&level="+level,"编辑字典信息", 500,350);
}

function subDictEdit(dictFlow , parentDictFlow , level){
	jboxOpen("<s:url value='/sys/dict/subdictedit?parentDictFlow='/>"+parentDictFlow+"&dictFlow="+dictFlow+"&level="+level,"编辑字典信息", 500,350);
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		 <div class="title1 clearfix">
		 <form id="searchForm" action="<s:url value="/sys/dict/list" />" method="post" >
		 	字典类型：
		 	<select class="xlselect" name="dictTypeId" style="80px;" onchange="search();">
				<option value="">请选择</option>
				<c:forEach var="dictTypeEnum" items="${dictTypeEnumList}">
					<c:if test="${dictTypeEnum.wsid==GlobalConstant.SYS_WS_ID or  dictTypeEnum.wsid==sessionScope.currWsId
					or fn:indexOf(dictTypeEnum.wsid,sessionScope.currWsId)>-1}">
					<option value="${dictTypeEnum.id}" <c:if test="${param.dictTypeId==dictTypeEnum.id}">selected="selected"</c:if>>${dictTypeEnum.name}</option>
					</c:if>
				</c:forEach>
			</select>
			   字典代码：
			 <input class="xltext" name="dictId" type="text" value="${param.dictId}"/>
			   字典名称：
			 <input class="xltext" name="dictName" type="text" value="${param.dictName}"/>
		     <input type="button" class="search" onclick="search();" value="查&#12288;询">
			 <input type="button" class="search" onclick="add();" value="新&#12288;增">
		</form>
		</div>
		
		<div id="subdict1" 
		<c:if test='${level==3}'>style="width: 32%;float: left;"</c:if>
		<c:if test='${level==2}'>style="width: 47%;float: left;"</c:if>
		>
		<a onclick="add();">1级新增</a>
		<table class="xllist"> 
			<tr>
				<th width="10%">字典代码</th>
				<th width="30%">字典名称</th>
				<th width="30%">描述</th>
				<th width="20%" >操作</th>
			</tr>
			<tbody id="sorttable">
			<c:forEach items="${dictList}" var="dict">
				<tr id="${dict.dictFlow}">
					<td>${dict.dictId}</td>
					<td>
					    <c:if test="${dict.recordStatus == GlobalConstant.RECORD_STATUS_Y }">
					        <a href="javascript:void(0);" onclick="viewChildNode('${dict.dictFlow}' , 1);">${dict.dictName}</a>
					    </c:if>
					    <c:if test="${dict.recordStatus == GlobalConstant.RECORD_STATUS_N }">
					        <a href="javascript:void(0);" title="请启用后才可以编辑子字典">${dict.dictName}</a>
					    </c:if>
					</td>
					<td>${dict.dictDesc}</td>
					<td>
						<c:if test="${dict.recordStatus == GlobalConstant.RECORD_STATUS_Y }">
						[<a href="javascript:edit('${dict.dictFlow}');" >编辑</a>] | [<a href="javascript:delDict('${dict.dictFlow}','${GlobalConstant.RECORD_STATUS_N}' , '' , 1);" >停用</a>]
						</c:if>				
						<c:if test="${dict.recordStatus == GlobalConstant.RECORD_STATUS_N }">
						[<a href="javascript:delDict('${dict.dictFlow}','${GlobalConstant.RECORD_STATUS_Y}' , '' , 1);" >启用</a>]
						</c:if>
					</td>
				</tr>
			</c:forEach>
			</tbody>
			<c:if test="${dictList == null || dictList.size()==0 }"> 
				<tr> 
					<td align="center" colspan="4">无记录</td>
				</tr>
			</c:if>
		</table>
		</div>
		<div id="subdict2" 
		<c:if test='${level==3}'>style="width: 32%;float: left;margin-right: 10px;margin-left: 10px;"</c:if>
		<c:if test='${level==2}'>style="width: 47%;float: left;margin-left: 10px;"</c:if>
		>
		
		</div>
		<c:if test='${level==3}'>
		<div id="subdict3" style="width: 32%;float: left;">
		</div>
		</c:if>
	</div> 
</div>
</body>
</html>