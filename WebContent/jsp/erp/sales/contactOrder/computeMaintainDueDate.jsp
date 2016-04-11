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
	<jsp:param name="jquery_ui_combobox" value="true"/>
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
<script type="text/javascript" src="<s:url value='/js/j.suggest.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
	$(function(){
		$("#month").live("keyup",function(){
			if(false == $("#editForm").validationEngine("validate")){
	    		 return false;
   		 	}
			var month = $(this).val();
			calculate(month);
		});
	});
	 
     function calculate(month){
    	 month = parseInt(month);
    	 var completeTime = $("#completeTime").text();
    	 var y = parseInt(completeTime.substring(0,4));
    	 var m = parseInt(completeTime.substring(5,7));
    	 var d = completeTime.substring(8,10);
    	 var count = month + m;
    	 if(count > 12){
    		 y = y + parseInt(count/12);
    		 m = count%12;
    	 }else{
    		 m = count;
    	 }
    	 if(m == 0){
   			 m = 1;
   		 }
    	 if(m < 10){
   			 m = "0" + m;
   		 }
    	 $("#maintainDueDate").text(y + "-" + m + "-" + d);
     }
     
     function save(){
    	 var url = "<s:url value='/erp/sales/modifyMaintainDueDate'/>";
    	 var data = {
    		 contractFlow:"${param.contractFlow}",
    		 maintainDueDate:$("#maintainDueDate").text(),
    		 contactFlow:"${param.contactFlow}"
    	 }
    	 jboxPost(url , data, function(resp){
 			if(resp != "${GlobalConstant.OPRE_FAIL}"){
 				setTimeout(function(){
 					window.parent.frames['mainIframe'].window.search();
 					jboxCloseMessager();
 				},1000);
 			}
 		}, null , true);
     }
</script>
</head>
<body>
<form id="editForm">
  <table width="100%" cellpadding="0" cellspacing="0" class="basic">
      <colgroup>
		<col width="30%"/>
		<col width="70%"/>
	  </colgroup>
	  <tr>
	     <td style="text-align: right;">完成时间：</td>
	     <td id="completeTime">${contactOrder.completeTime}</td>
	  </tr>
	  <tr>
	     <td style="text-align: right;">延长时间：</td>
	     <td>
	        <input type="text" id="month" name="month" class="inputText validate[required,custom[integer]]" style="width:80%;">&#12288;月
	     </td>
	  </tr>
	  <tr>
	     <td style="text-align: right;">维护到期日：</td>
	     <td id="maintainDueDate"></td>
	  </tr>
  </table>
</form>
   <div class="button">
       <input type="button" class="search" value="确认并关单" onclick="save();"/>
       <input type="button" class="search" value="关&#12288;闭" onclick="jboxClose();"/>
   </div>
</body>
</html>