<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
		$('#fileForm').submit();
	}
	
    function callback(result){
		jboxTip(result);
		if(result=='${GlobalConstant.SAVE_SUCCESSED}'){
			 doClose();
		} 
	};
	function doClose() {
		window.parent.frames['mainIframe'].window.reload();
		jboxClose();
	}
	function changeFile(obj){
		var tdObj = $(obj).parent();
		tdObj.html('<input type="file" name="file" class="validate[required] " />');
	}
</script>
</head>

<body>
<div id="main">
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
        <form id="fileForm" action="<s:url value="/irb/secretary/addApplyFile"/>" method="post" enctype="multipart/form-data" >
           <table class="basic" style="margin: 0 auto;" width="100%">
                 <tbody>
                 	  <tr>
                         <th>文件名称：</th>
                         <td colspan="3">
                         	<input class="validate[required] xltext" name="name" type="text" style="width: 200px;"  />
                         </td>
                      </tr>
                      <tr>
                         <th width="100px">附&#12288;件：</th>
                         <td colspan="3">
                       		<input type="file" name="file" />
                         </td>
                      </tr>
                 </tbody>
           </table>
           <div class="button">
            <input type="hidden" name="irbFlow" value="${param.irbFlow}">
		   	<input class="search" type="button" onclick="save();" value="保&#12288;存"/>
		   	<input type="button" class="search" onclick="jboxClose();" value="关&#12288;闭">
      	   </div>
           </form>
         </div>
        
     </div> 	
   </div>
</div>
<c:if test="${!empty msg }"><script type="text/javascript">callback('${msg}');</script></c:if>
</body> 
</html>