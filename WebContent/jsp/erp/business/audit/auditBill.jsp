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
 	$(function(){
	 	billInfo();
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
	    jboxLoad("contentDiv",url,true);
	}
	
	function billInfo(){
		selectTag('<s:url value="/erp/sales/billInfo"/>?type=audit','fpdxx');
	}
	
	function payPlanInfo(){
		selectTag('<s:url value="/erp/business/payPlanInfo"/>','hthkxx');
	}
	function contractInfo(contractFlow) {
		var mainIframe = window.parent.frames["mainIframe"];
		var width = mainIframe.document.body.scrollWidth;
		if (width >1100) {
			width = 1000;
		}
		var url = "<s:url value='/erp/crm/contractInfo'/>?contractFlow="+contractFlow+"&status=main&type=open";
		jboxOpen(url, "合同详细信息", width, 600);
	}
	function customerInfo(customerFlow,customerName){
		var w = $('.mainright').width();
		var h = $('.mainright').height();
		var url = "<s:url value='/erp/crm/customerInfo'/>?customerFlow=" + customerFlow+"&type=open&no=third";
		jboxOpen(url,customerName, w, h); 
	}
</script>

<style type="text/css">
	#table1 th {background: #fff; width: 110px;border:none;}
	#table1,#table1 td{border:none;}
</style>
</head>
<body>
<div class="mainright">
  <div class="content" style="margin-top: 10px;">
  	<ul id="tags">
		<li class="selectTag"><a onclick="billInfo();" href="javascript:void(0)" id="fpdxx">发票单信息</a></li>
		<li><a onclick="payPlanInfo();" href="javascript:void(0)" id="hthkxx">合同回款信息</a></li>
    </ul>
    <table class="i-trend-table" cellpadding="0" cellspacing="0" >
    <tbody>
        <tr>
          <td>
            <div id="contentDiv" style="overflow:auto;border:none;">
			</div>
          </td>
        </tr>
    </tbody>
    </table>
    
  	<form id="auditForm"  method="post" style="margin-top: 10px;position: relative;">
  	<fieldset>
		<legend>审核意见</legend>
			<table style="width: 100%;">
				<tr>
				<td><textarea  name="auditContent" rows="5" style="width:100%;" placeholder="请填写审核意见"></textarea></td>
				</tr>
			</table>
	</fieldset>
       <p class="button">
       		<input type="button" value="审核通过" onclick="" class="search"/>
       		<input type="button" value="审核不通过" onclick="" class="search"/>
       		<input type="button" value="关&#12288;闭" onclick="jboxCloseMessager();" class="search"/>
	    </p>
   	</form>
  </div>
</div>
</body>
</html>