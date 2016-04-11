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
<script type="text/javascript">
$(document).ready(function(){
	if('${param.visitFlag}'=="Y"){
		loadReturnVisitForm('${param.contactFlow}');
	}else if('${param.trackFlag}'=="Y"){
		loadTrackForm('${param.contactFlow}');
	}else{
		loadContactOrder('${param.contactFlow}');
	}
	
});
function selectTag(url, id) {
    // 操作标签
    var tag = document.getElementById("tags").getElementsByTagName("li");
    var taglength = tag.length;
    for (i = 0; i < taglength; i++) {
        tag[i].className = "ui-bluetag";
    }
    document.getElementById(id).parentNode.className = "selectTag";
    // 操作内容
    var divBox=$(".conDiv");
    	$.each(divBox,function(i,n){
    		$(n).hide();
    	});
    	$("#"+id+"Div").show();
    if($("#"+id+"Div").is(":empty")){
    	jboxLoad(id+"Div",url,true);
    }
    
}

function loadContactOrder(contactFlow){
	var url = "<s:url value='/erp/sales/contactInfo'/>?contactFlow="+contactFlow+"&historyFlag=${param.historyFlag}&closeFlag=${param.closeFlag}";
	selectTag(url,'lxd');
}

function loadWorkOrderList(contactFlow){
	var url = "<s:url value='/erp/implement/assignList'/>?contactFlow="+contactFlow+"&closeFlag=close&type=load";
	selectTag(url,'pgd');
}
function loadReturnVisitForm(contactFlow){
	var url = "<s:url value='/erp/sales/editVisitInfo'/>?contactFlow="+contactFlow;
	selectTag(url,'hfd');
}

function loadTrackForm(contactFlow){
	var url = "<s:url value='/erp/sales/editTrackInfo'/>?contactFlow="+contactFlow;
	selectTag(url,'gzd');
}

function loadHistoryContactOrderList(contactFlow){
	var url = "<s:url value='/erp/sales/historyContact'/>?contactFlow="+contactFlow;
	selectTag(url,'lslxd');
}

function saveVisit(){
	var url= "<s:url value='/erp/sales/saveVisitInfo'/>";
	jboxPost(url , $("#visitForm").serialize(), function(resp){
		if(resp!="${GlobalConstant.SAVE_FAIL}"){
			jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
			setTimeout(function(){
				window.parent.frames['mainIframe'].window.search();
				jboxCloseMessager();
				jboxClose();
			},1000);
		}
	}, null , false);
	
}

function saveTrack(){
	var url= "<s:url value='/erp/sales/saveTrackInfo'/>";
	jboxPost(url , $("#visitForm").serialize(), function(resp){
		if(resp!="${GlobalConstant.SAVE_FAIL}"){
			jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
			setTimeout(function(){
				$("#visitForm")[0].reset();
				loadTrackFormList('${param.contactFlow}');
				/* window.parent.frames['mainIframe'].window.search('<s:url value="/erp/sales/trackContactList?type=track"/>');
				jboxCloseMessager(); */
			},1000);
		}
	}, null , false);
	
}
function info(contactFlow) {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url="<s:url value='/erp/sales/contactOrderInfo'/>?contactFlow="+contactFlow;
	jboxOpen(url,'查看工作联系单',w,h);
}

function checkedView(contactFlow){
	$.each($(".contactTr"),function(i,n){
		$(n).css("background-color","");
	});
	$("#contactTr_"+contactFlow).css("background-color","pink");
	$("#checkContactFlow").val(contactFlow);
}
</script>
</head>
<body>
<div class="mainright">
<div class="content">
		<ul id="tags" style="padding-top: 10px;">
		   <c:if test="${param.visitFlag eq 'Y'}">
		    <li><a onclick="loadReturnVisitForm('${param.contactFlow}');" href="javascript:void(0)" id="hfd">回访信息</a></li>
		   </c:if>
		   <c:if test="${param.trackFlag eq 'Y'}">
		    <li><a onclick="loadTrackForm('${param.contactFlow}');" href="javascript:void(0)" id="gzd">跟踪信息</a></li>
		   </c:if>	
			<li><a onclick="loadContactOrder('${param.contactFlow}');" href="javascript:void(0)" id="lxd">工作联系单</a></li>
			<li><a onclick="loadWorkOrderList('${param.contactFlow}');" href="javascript:void(0)" id="pgd">派工单</a></li>
	        <c:if test="${param.historyFlag eq 'Y' }">
	         <li><a onclick="loadHistoryContactOrderList('${param.contactFlow}');" href="javascript:void(0)" id="lslxd">客户历史联系单</a></li>
	        </c:if>
	    </ul>
	    <form id="visitForm" method="post" style="position: relative;">
	     <input type="hidden" name="contactFlow" value="${param.contactFlow }"/>
	    <table class="i-trend-table" cellpadding="0" cellspacing="0" style="border:none;">
		    <tbody>
		        <tr>
		          <td>
		          <c:if test="${param.visitFlag eq 'Y'}">
		            <div class="conDiv" id="hfdDiv" style="border:none;"></div>
		          </c:if>
		          <c:if test="${param.trackFlag eq 'Y'}">
		            <div class="conDiv" id="gzdDiv" style="border:none;"></div>
		          </c:if>
					<div class="conDiv" id="lxdDiv" style="border:none; "></div>
					<div class="conDiv" id="pgdDiv" style="border:none; "></div>
					<div class="conDiv" id="lslxdDiv" style="border:none; "></div>
		          </td>
		        </tr>
		    </tbody>
	    </table>
	    </form>
					
</div>
</div>
</body>
</html>