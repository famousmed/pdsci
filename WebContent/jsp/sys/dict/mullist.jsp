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

function delDict(dictFlow,recordStatus , parentDictFlow){
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
			viewChildNode(parentDictFlow);
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

function viewChildNode(dictFlow){
	$(".curr").removeClass("curr");
	$("#"+dictFlow).addClass("curr");
	$("#"+dictFlow).removeAttr("style");
	$('#currDictFlow').val(dictFlow);
	$('#currDictNameSpan').html($("#"+dictFlow).children().eq(1).text());
	var url = "<s:url value='/sys/dict/getChildDict'/>?dictFlow="+dictFlow;
	jboxGet(url , null , function(data){
		$("#subdictdiv").html(data);
	} , null , false);
}

function subDictAdd(parentDictFlow){
	var parentDictFlow = $('#currDictFlow').val();
	if (parentDictFlow == "") {
		jboxTip("请选择一个一级字典!");
		return;
	}
	var w = 600;
	var h = 400;
	<c:if test='${level==3}'>
	w = 600;
	h = 600;
	</c:if>
	jboxOpen("<s:url value='/sys/dict/subdictedit?parentDictFlow='/>"+parentDictFlow,"编辑字典信息", w,h);
}

function subDictEdit(dictFlow , parentDictFlow){
	var w = 600;
	var h = 400;
	<c:if test='${level==3}'>
	w = 600;
	h = 600;
	</c:if>
	jboxOpen("<s:url value='/sys/dict/subdictedit?parentDictFlow='/>"+parentDictFlow+"&dictFlow="+dictFlow,"编辑字典信息", w,h);
}
</script>
<style>
.curr{background-color:highlight;}
</style>
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
		
		<div class="side" style="height:98%;width: 47%">
		    <table width="100%" cellspacing="0" cellpadding="0" class="bs_tb" >
		        <tr>
				    <th class="bs_name" colspan="4">1级字典<a href="javascript:add();">
				        <img src="<s:url value="/css/skin/${skinPath}/images/add.png" />" title="新增一级字典"></a>
				    </th>
                </tr>
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
					        <a href="javascript:void(0);" onclick="viewChildNode('${dict.dictFlow}');">${dict.dictName}</a>
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
		    <input type="hidden" id="currDictFlow" name="currDictFlow" value=""/>
		</div>
		
		<div class="side1" style="height: 98%;">
		    <div class="bs_title">
		    <span id="currDictNameSpan"></span>
            &#12288;2级字典 
			   <a href="javascript:void(0);" onclick="subDictAdd();">
			       <img src="<s:url value="/css/skin/${skinPath}/images/add.png" />" title="二级字典新增" style="float: right;padding-top: 10px;padding-right: 10px">
			   </a>
		    </div>
			<div id="subdictdiv">
			</div>
	    </div>
	</div> 
</div>
</body>
</html>