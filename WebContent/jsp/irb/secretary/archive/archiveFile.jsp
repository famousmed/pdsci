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
function saveApplyFile(){
	var checkboxs = $("input[name='ids']:checked");
	if(checkboxs.length==0){
		jboxTip("请勾选要存档的文件！");
		return false;
	}
	var datas = [];
	var inputDate = true;
	var fileName = "";
	checkboxs.each(function(){
		var id = $(this).val();
		var date = $("#date_"+id).val();
		if(!date){
			fileName = $(this).parent().nextAll(".fileName").find("a").html();
			inputDate = false;
			return false;
		}
		var data = {"id":id,"date":date};
		datas.push(data);
	});
	if(!inputDate){
		jboxInfo("请填写"+fileName+"的存档日期！");
		return false;
	}
	var url = "<s:url value='/irb/secretary/saveApplyFile'/>?irbFlow=${param.irbFlow}";
	jboxPostJson(url , JSON.stringify(datas) , function(resp){
		if(resp=="${GlobalConstant.SAVE_SUCCESSED}"){
			window.location.reload();
		}
	} , null , true);
}

function finishApply(){
	jboxConfirm("确定完成本次审查，操作后将无法修改？",function(){
		var url = "<s:url value='/irb/secretary/finishApply'/>?irbFlow=${param.irbFlow}"; 
		jboxGet(url,null,function(resp){
			if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
				window.location.href = "<s:url value='/irb/secretary/list?irbStageId=${irbStageEnumArchive.id}'/>";
			}
		},null,true);
	},null);
}
function checkInput(obj){
	var input = $(obj).parent().prevAll("td:last").children("input");
	input.attr("checked","checked");
}

if ("${param.type}" != 'show') {
var fixHelper = function(e, ui) {
    ui.children().each(function() {
   	//在拖动时，拖动行的cell（单元格）宽度会发生改变。在这里做了处理就没问题了  
        $(this).width($(this).width());
    });
    return ui;
};
$(function() {
	/*判断是否选中全选*/
	var isChecked = true;
	$("input[name='ids']").each(function(){
		if(!this.checked ){
			isChecked = false;
			return false;
		}
	 });
	document.getElementById("checkAllId").checked = isChecked;
	
	var oldPostData = "";
   $( "#fileSortable" ).sortable({
   	helper: fixHelper,  
   	create: function(e, ui){
   		var oldSortedIds = $( "#fileSortable" ).sortable( "toArray" );
   		$.each(oldSortedIds,function(i,sortedId){
   			oldPostData = oldPostData+"&roleFlow="+sortedId;
   		});
   	},
   	start:function(e, ui){
   	     //拖动时的行，要用ui.helper
   	    ui.helper.css({"background":"#eee"});
   	    return ui; 
   	}, 
   	stop: function( event, ui ) {
   		ui.item.css({"background":"#fff"});
   		var sortedIds = $( "#fileSortable" ).sortable( "toArray" );
   		var postdata = "";
   		$.each(sortedIds,function(i,sortedId){
   			postdata = postdata+"&ids="+sortedId;
   		});
   		if(oldPostData==postdata){
   			return;
   		}
   		var datas = "irbFlow=${irbForm.irb.irbFlow}"+postdata;
   		var url = "<s:url value='/irb/secretary/sortApplyFile'/>";
   		jboxPost(url, datas, function() {
   			},null,false);
   		oldPostData = postdata;
   	}
   });
   $( "#sortable" ).disableSelection();
});
}
function addApplyFile(){
	jboxOpen("<s:url value='/irb/secretary/showAddApplyFile'/>?irbFlow=${irbForm.irb.irbFlow}", "新增存档文件", 600,300);
}
function reload(){
	window.location.reload();
}
function delApplyFile(){
	var datas = [];
	datas = $("input[name='ids']:checked").serialize();
	if(datas.length==0){
		jboxTip("请勾选要存档的文件！");
		return false;
	}
	jboxConfirm("确认删除勾选的文件？",function(){
		datas += "&irbFlow=${irbForm.irb.irbFlow}";
		var url = "<s:url value='/irb/secretary/delApplyFile' />";
		jboxPost(url, datas, function(resp) {
			if(resp=="${GlobalConstant.DELETE_SUCCESSED}"){
				reload();
			}
			},null,true);
	},null);
}
function checkAll(){
	var isChecked = document.getElementById("checkAllId").checked;
	 $("input[name='ids']").each(function(){
		 this.checked = isChecked;
	 });
	
}
function refresh(){
	window.location.reload();
}
function print(){
	var url ="<s:url value='/irb/printOther'/>?watermarkFlag=${GlobalConstant.FLAG_Y}&irbFlow=${irbForm.irb.irbFlow}&recTypeId=${irbRecTypeEnumArchive.id}";
	window.location.href= url;
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
		<div style="width: 60%;float: left;margin-top: 10px;">
		<form id="applyFileForm">
				<table class="xllist" style="width: 100%;">
				<tr>
					<th width="40px;"><input type="checkbox" id="checkAllId" value="${file.id}" title="全选" onclick="checkAll()"/></th>
					<th width="60px;">序号</th>
					<th>文件名称</th>
					<th width="120px;">存档日期</th>
				</tr>
				<tbody id="fileSortable">
					<c:forEach items="${archiveFlielist}" var="file" varStatus="status">
						<tr id="${file.id}">
							<td width="40px;">
								<input type="checkbox" name="ids" value="${file.id}" <c:if test="${!empty file.date}">checked="checked"</c:if>/>
							</td>
							<td width="60px;">${status.count}</td>
							<td class="fileName" >
								<c:set var="fileUrl" value="${file.url }&type=${param.type }"></c:set>
							<c:choose>
								<c:when test="${empty file.fileFlow && empty file.url}">${file.name}</c:when>
								<c:otherwise>
									<a <c:choose>
									<c:when test="${!empty file.fileFlow }">href="${ctxPath}/pub/file/down?fileFlow=${file.fileFlow}"</c:when>
									<c:otherwise>href="javascript:jboxOpen('${fileUrl}','${file.name}',1000,600)"</c:otherwise>
									</c:choose> >${file.name}</a>
								</c:otherwise>
							</c:choose>
							</td>
							<td width="120px;">
								<input name="date" type="text" id="date_${file.id}" style="width: 80%;" value="${file.date}"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'});checkInput(this);"  readonly="readonly"/>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
		<p style="text-align: center;">
			<c:if test="${param.type != 'show'}"><font color="blue" style="float: left">Tip：拖动行可以调整排序</font></c:if>
			<c:if test="${!empty archiveFlielist}"><input type="button" class="search" onclick="saveApplyFile();" value="存&#12288;档"></c:if>
			<input type="button" class="search" onclick="addApplyFile();" value="新&#12288;增">
			<input type="button" class="search" onclick="delApplyFile();" value="删&#12288;除">
			<input type="button" class="search" onclick="refresh();" value="刷&#12288;新">
			<input class="search" type="button" showFlag="${GlobalConstant.FLAG_Y }" value="打&#12288;印" onclick="print();" />
		</p>
		</div>
		<div style="width: 38%;float: right;margin-top: 10px;">
			<table class="xllist">
				<tr><th colspan="2">本次伦理审查信息</th></tr> 
				<tr><td width="120px">项目名称</td><td style="text-align: left;padding-left: 5px;">${irbForm.irb.projShortName}</td></tr>
				<tr><td>期类别</td><td style="text-align: left;padding-left: 5px;">${irbForm.irb.projSubTypeName}</td></tr>
				<tr><td>项目来源</td><td style="text-align: left;padding-left: 5px;">${irbForm.irb.projShortDeclarer}</td></tr>
				<tr><td>伦理审查类型</td><td style="text-align: left;padding-left: 5px;">${irbForm.irb.irbTypeName}</td></tr>
				<tr><td>承担科室</td><td style="text-align: left;padding-left: 5px;">${irbForm.proj.applyDeptName}</td></tr>
				<tr><td>主要研究者</td><td style="text-align: left;padding-left: 5px;">${irbForm.proj.applyUserName}</td></tr>
				<tr><td>受理号</td><td style="text-align: left;padding-left: 5px;">${irbForm.irb.irbNo}</td></tr>
				<tr><td>受理日期</td><td style="text-align: left;padding-left: 5px;">${irbForm.irb.irbAcceptedDate}</td></tr>
				<tr><td>审查方式</td><td style="text-align: left;padding-left: 5px;">${irbForm.irb.reviewWayName}</td></tr>
				<tr><td>主审委员</td><td style="text-align: left;padding-left: 5px;">
				<c:forEach items="${committeeList}" var="irbUser" varStatus="statu">
				                           ${irbUser.userName}<c:if test="${fn:length(committeeList)>1&&!statu.last}">、</c:if>
				                           </c:forEach>
				</td></tr>
				<tr><td>审查日期</td><td style="text-align: left;padding-left: 5px;">${irbForm.irb.irbReviewDate}</td></tr>
				<tr><td>审查决定</td><td style="text-align: left;padding-left: 5px;">${irbForm.irb.irbDecisionName}</td></tr>
				<tr><td>跟踪审查日期</td><td style="text-align: left;padding-left: 5px;">${irbForm.irb.trackDate} </td></tr>
			</table>
			<div style="text-align: center;margin-top: 10px;"><input type="button" class="search" onclick="finishApply();" value="完成本次审查"></div>
		</div>
		
		</div>
	</div>
</div>
</body>
</html>