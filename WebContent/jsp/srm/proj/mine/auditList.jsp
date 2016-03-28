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
function doClose() {
	jboxClose();
}
</script>
<style type="text/css">
	#wrap{word-break:break-all; width:150px;}
</style>
</head>

<body>
<div id="main">   
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix"></div>
        	<table class="xllist" style="width: 100%;">
        	  <thead>
	       	  	<tr>
	                 <th width="4%">序号</th>
	                 <th width="8%">阶段</th>
	                 <th width="12%">操作单位</th>
	                 <th width="7%">操作人</th>
	                 <th width="11%">审核时间</th>
	                 <th width="13%">审核结果</th>
	                 <th width="40%">审核意见</th>
	             </tr>
              </thead>
              <tbody>
              	<c:forEach var="projProcess" items="${projProcessList}" varStatus="status">
					<tr>
						<td>${status.count}</td>
						<td>${projProcess.projStageName}</td>
						<td>${projProcess.operOrgName}</td>
						<td>${projProcess.operUserName}</td>
						<td>${pdfn:transDate(projProcess.createTime)}</td>
						<td>${projProcess.processRemark}</td>
						<td id="wrap">${projProcess.auditContent}</td>
					</tr>
				</c:forEach>
              </tbody>
         </table> 
         <div class="button">
			<input type="button" class="search" value="关&#12288闭" onclick="doClose();">
		 </div>  
     </div> 	
   </div>
</div>
</body>
</html>