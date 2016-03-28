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
	lastContactOrder("${param.contactFlow}");
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
    jboxLoad("conDiv",url,true);
}

function lastContactOrder(contactFlow){
	var url = "<s:url value='/erp/sales/contactInfo'/>?contactFlow="+contactFlow+"&type=noclose";
	selectTag(url,'lxd');
}

function lastWorkOrderList(contactFlow){
	var url = "<s:url value='/erp/implement/assignList'/>?contactFlow=" + contactFlow + "&type=load";
	selectTag(url,'pgd');
}

function closeContactOrder(contactFlow){
	var url;
	jboxConfirm("确认关闭联系单？", function(){
				 url="<s:url value='/erp/sales/checkContractMaintainDueDate'/>?contactFlow="+contactFlow;
				 jboxPost(url , null, function(resp){
					if(resp){
						  if(!resp.maintainDueDate){
						     jboxConfirm("是否回写合同维护到期日？", function(){	
						        url="<s:url value='/erp/sales/computeMaintainDueDate'/>?contactFlow="+contactFlow+"&contractFlow="+resp.contractFlow;
						        jboxOpen(url,"计算合同维护到期日",400,180);
						    },function(){ closeContact(contactFlow);});
						     
						 }else{
							 closeContact(contactFlow);
						 }
				   }else{
					 closeContact(contactFlow);
				 }
			 },null,false);
	},null);
}

function closeContact(contactFlow){
	var url = "<s:url value='/erp/sales/closeContactOrder'/>?contactFlow="+contactFlow;
		jboxPost(url , null, function(resp){
			if(resp != "${GlobalConstant.SAVE_FAIL}"){
				jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
				setTimeout(function(){
					window.parent.frames['mainIframe'].window.search();
					jboxCloseMessager();
				},1000);
			}
		}, null , false);
}

function doClose(){
	if ("${param.closeFlag == GlobalConstant.FLAG_Y}"=="true") {
		jboxCloseMessager();
	} else {
		jboxClose();
	}
}

function recall(contactFlow){
	jboxConfirm("确认将联系单撤回至<font color='red'>实施中</font>？", function(){
		url="<s:url value='/erp/sales/recall'/>?contactFlow="+contactFlow;
		 jboxPost(url , null, function(resp){
			 if(resp != "${GlobalConstant.SAVE_FAIL}"){
					jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					setTimeout(function(){
						window.parent.frames['mainIframe'].window.search();
						jboxCloseMessager();
					},1000);
				}
		 },null,false);
	},null);
}

</script>
</head>
<body>
<div class="mainright">
<div class="content">

		<ul id="tags" style="padding-top: 10px;">
			<li><a onclick="lastContactOrder('${param.contactFlow}');" href="javascript:void(0)" id="lxd">工作联系单</a></li>
			<li><a onclick="lastWorkOrderList('${param.contactFlow}');" href="javascript:void(0)" id="pgd">派工单</a></li>
	    </ul>
	    
	    <table class="i-trend-table" cellpadding="0" cellspacing="0" style="border:none;">
		    <tbody>
		        <tr>
		          <td>
		            <div id="conDiv" style="border:none;">
					</div>
		          </td>
		        </tr>
		    </tbody>
	    </table>
	    
		<div class="button">
			<c:if test="${param.closeFlag == GlobalConstant.FLAG_Y and sessionScope[GlobalConstant.USER_LIST_SCOPE] == GlobalConstant.USER_LIST_LOCAL}">
	       		<input type="button" value="关&#12288;单" onclick="closeContactOrder('${param.contactFlow}');" class="search"/>
       		    <input type="button" value="撤&#12288;回" onclick="recall('${param.contactFlow}');" class="search"/>
       		</c:if>
       		
			<input type="button" class="search" value="关&#12288;闭" onclick="doClose();" >
		</div>			
</div>
</div>
</body>
</html>