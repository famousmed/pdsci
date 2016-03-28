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
	var url = "<s:url value='/srm/proj/mine/savePageGroupStep'/>";
	jboxPost(url , $('#itemGroup1').serialize() , function(){
		window.parent.frames['mainIframe'].location.reload(true);
		jboxClose();
	} , null , true);
	
}

</script>
</head>
<body>
<div id="main">
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
	<form action="<s:url value='/srm/proj/mine/savePageGroupStep'/>" id="itemGroup1" method="post">
		<input type="hidden" name="pageName" value="step5"/>
		<input type="hidden" name="itemGroupName" value="cost"/>
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" name="itemGroupFlow" value="${param.itemGroupFlow}"/>
		<table class="basic" width="680">
                 <thead>
                    <tr>
                        <th colspan="4" class="bs_name">添加项目经费支出情况</th>
                    </tr>
                 </thead>
                 <tbody>
                    <tr>
                        <td>栏目：</td>
                        <td><input class="xltext" type="text" name="costReason" value="${resultMap.costReason }"/></td>
                        <td>金额:</td>
                        <td><input class="sltext" type="text" name="costCount" value="${resultMap.costCount }"/></td>
                    </tr>
                 </tbody>
	    </table>
	</form>	
	         <div class="button" style="width: 650px;">
	           <input type="button" id="sv" onclick="save();" value="保存" class="search"/>
	         </div>
	</div>
	</div>
	</div>
	</div>
</body>
</html>