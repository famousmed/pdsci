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
	function refreshOpener(){
		window.parent.frames['mainIframe'].window.showApplyFile();
	}
	function doClose() {
		refreshOpener();
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
        <form id="fileForm" action="<s:url value="/irb/researcher/saveApplyFile"/>" method="post" enctype="multipart/form-data" >
           <table class="basic" style="margin: 0 auto;" width="100%">
                 <tbody>
                      <tr>
                         <th width="100px">附&#12288;件：</th>
                         <td colspan="3">
	                         <c:choose>
	                         	<c:when test="${empty form.fileFlow  }">
	                         		<input type="file" name="file" class="validate[required] " />
	                         	</c:when>
	                         	<c:otherwise>
	                         		<a href="${ctxPath}/pub/file/down?fileFlow=${form.fileFlow}">${form.fileName}</a><a href="javascript:void(0)" onclick="changeFile(this)" style="float: right;margin-right: 20px;">[重新上传]</a>
	                         	</c:otherwise>
	                         </c:choose>
                         </td>
                      </tr>
                      <c:if test="${findApplyFile.version==GlobalConstant.FLAG_Y}">
                      	 <tr>
	                         <th >版本号：</th>
	                         <td colspan="3">
	                         	<input class="validate[required] xltext" name="version" type="text" value="${form.version }" />
	                         </td>
                      	 </tr>
                      </c:if>
                      <c:if test="${findApplyFile.versionDate==GlobalConstant.FLAG_Y}">
                      	 <tr>
	                         <th>版本日期：</th>
	                         <td colspan="3">
	                         	<input class="validate[required] xltext" name="versionDate" type="text" value="${form.versionDate }"  />
	                         </td>
                      	 </tr>
                      </c:if>
                       <tr>
                         <th>附件备注：</th>
                         <td colspan="3">
                         	<input class="xltext" name="fileRemark" type="text"  value="${form.fileRemark }" />
                         </td>
                      </tr>
                 </tbody>
           </table>
           <div class="button">
            <input type="hidden" name="fileTempId" value="${findApplyFile.id}">
            <input type="hidden" name="fileName" value="${findApplyFile.name}">
            <input type="hidden" name="fileFlow" value="${form.fileFlow}">
            <input type="hidden" name="showNotice" value="${findApplyFile.showNotice}">
		   	<input class="search" type="button" onclick="save();" value="保&#12288;存"/>
      	   </div>
           </form>
         </div>
        
     </div> 	
   </div>
</div>
<c:if test="${!empty msg }"><script type="text/javascript">callback('${msg}');</script></c:if>
</body> 
</html>