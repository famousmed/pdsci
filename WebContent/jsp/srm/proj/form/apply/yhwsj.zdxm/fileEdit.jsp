<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script type="text/javascript">
	function save(){
		$("#saveBtn").attr("disabled",true);
		$('#fileForm').submit();
	}
	
	var callBack = function(result){
		if(result=="1"){
			jboxTip("保存成功");
			doClose();
		}else{
			jboxTip("保存失败");
		}
		
	};
	
	function refreshOpener(){
		window.parent.frames['mainIframe'].location.reload(true);
	}
	
	function doClose() {
		refreshOpener();
		jboxClose();
	}
	
	$(document).ready(function(){
		<c:if test="${not empty param.fileRemark}">
			modifyFileName("${param.fileRemark}");
		</c:if>
	});
	
	function modifyFileName(remark){
		var $fileName = $("input[name='fileEdit_fileName']");
		if(remark==1){
			$fileName.val("立项查新报告");
		}else if(remark==2){
			$fileName.val("项目可行性报告");
		}else if(remark==3){
			$fileName.val("承诺书");
		}
		$("input[name='fileEdit_fileRemark']").val(remark);
		$fileName.attr("readonly","readonly");
	}
</script>
<style type="text/css">
.basic tbody th{background: #fff;font-weight: normal;}
</style>
</head>

<body>
<div id="main">
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
        <form id="fileForm" action="<s:url value="/srm/proj/mine/savePageGroupStep"/>" method="post" enctype="multipart/form-data" target="screct_frame">
			<input type="hidden" name="pageName" value="${param.pageName}"/>
			<input type="hidden" name="itemGroupName" value="${param.itemGroupName}"/>
			<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
            <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
            
			<input type="hidden" name="itemGroupFlow" value="${param.itemGroupFlow}"/>
			<input type="hidden" name="fileEdit_fileRemark"  value="${file.fileEdit_fileRemark}" />
            <table class="basic">
                 <tr>
                     <th colspan="4" style="text-align: left;font-weight:bold;color#333;   padding-left: 15px;font-size: 14px;background: #ECF2FA;height: 35px;line-height: 35px;vertical-align: middle;">附件</th>
                 </tr>
                 <tbody>
                      <tr>
                         <th width="20%">附件名称：</th>
                         <td width="30%">
                         	<input class="validate[required] inputText" name="fileEdit_fileName" type="text" value="${file.fileEdit_fileName}" style="width: 90%"/>
                         </td>
                     </tr>
                     <tr>
                         <th>附件：</th>
                         <td>
                         	<input type="file" name="fileEdit_file" class="validate[required] inputText" style="width: 90%" />
                         </td>
                      </tr>
                 </tbody>
           </table>
           <div class="button">
           	<input class="search" id="saveBtn" type="button" onclick="save();" value="保&#12288;存"/>
      	   </div>
           </form>
         </div>
     </div> 	
   </div>
</div>
<iframe name="screct_frame" style="display: none"></iframe>
</body>
</html>