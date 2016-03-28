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
	function save(){
		var form = $("#editForm");
		var requestData = form.serialize();
		var url = "<s:url value='/gcp/rec/saveProvFiling'/>";
	 	jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				window.parent.frames['mainIframe'].window.loadFiling();
				jboxClose();
			}
		},null,true);
	}
</script>
<style type="text/css">
	table.xllist tr th, table.xllist tr td{text-align: center;padding: 0;margin: 0;}
</style>
</head>
<body>
	<div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
		<form id="editForm">
   		<table class="basic" width="100%" style="margin: 0 auto;">
   			<tr>
   				<th class="td_blue" width="100px">备案时间：</th>
                <td>
                	<input type="text" name="date" class="xltext ctime" readonly="readonly" <c:choose><c:when test="${empty pfForm.date }">value="${pdfn:getCurrDate()}"</c:when><c:otherwise>value="${pfForm.date }"</c:otherwise></c:choose>  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                </td>
   			</tr>
			<tr>
	             <th class="td_blue" width="180px">备案意见：</th>
	             <td >
	             	<textarea name="opinion" rows="4" style="width:97%;margin:8px 0px; " placeholder="请填写备案意见">${pfForm.opinion }</textarea>
	             </td>
            </tr>
			</table>
			<p align="center" style="width:100%">
			    <input name="projFlow" type="hidden" value="${param.projFlow }" />
				<input class="search" type="button" value="保&#12288;存"  onclick="save();" />
			</p>
		</form>
         </div>
        
     </div> 	
   </div>
</body>
</html>