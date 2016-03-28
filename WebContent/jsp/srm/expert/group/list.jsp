<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
</head>
<body>
<script type="text/javascript">

function editGroup(groupFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/expert/group/edit?groupFlow='/>"+groupFlow, "编辑专家组信息", 800,600);
}

function delExpert(groupFlow){
	var url = '<s:url value="/srm/expert/group/delete"/>?groupFlow='+groupFlow;
	jboxConfirm("确认删除？" , function(){
		jboxStartLoading();
		jboxGet(url , null , function(){
			searchExpert();
		} , null , true);
	});

}
function searchExpertGroup(){
	jboxStartLoading();
	$("#searchExpertGroupForm").submit();
}

function setExpert(groupFlow){
	var w = $('#mainright').width();
	var url ='<s:url value="/srm/expert/groupUser/list?groupFlow="/>'+groupFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='330px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'评分项设置',w,400);

}
function toPage(page) {
	var form=$('#searchExpertGroupForm');
	if(page!=undefined){
		$("#currentPage").val(page);			
	}
	jboxStartLoading();
    form.submit();
}

</script>
   <div class="mainright" id="mainright">
      <div class="content">
        <div class="title1 clearfix">
			 <form id="searchExpertGroupForm" action="<s:url value="/srm/expert/group/list" />" method="post" > 
			 		专家组名称：<input type="text" name="groupName" value="${param.groupName}" class="xltext"/>
			 		<input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage}"/>
			 		<input type="button" class="search" onclick="searchExpertGroup();"  value="查询">
			     	<input type="button" class="search" onclick="editGroup();" value="新增">
			</form>
			<p></p>
		</div>
		
	<table class="xllist" > 
		<tr>
			<th width="10%">专家组名称</th>
			<!--  <th width="10%">类别</th>-->
			<th width="60%">专家组描述</th> 
			<th width="20%" >操作</th>
		</tr>
		<c:forEach items="${expertGroupList}" var="expertGroup">
		<tr style="height:20px ">
			<td>${expertGroup.groupName }</td>
			<!--<td>${expertGroup.groupTypeName }</td>--> 
			<td>${expertGroup.groupNote }</td>
			<td>[<a href="javascript:editGroup('${expertGroup.groupFlow}');" >编辑</a>] |
				[<a href="javascript:delExpert('${expertGroup.groupFlow}');" >删除</a>] |
				[<a	href="javascript:setExpert('${expertGroup.groupFlow}');">专家维护</a>]
				<!-- <s:url value="/srm/expert/groupUser/list?groupFlow="/>${expertGroup.groupFlow} -->
			</td>
		</tr>
	   </c:forEach>
	</table>
	<c:set var="pageView" value="${pdfn:getPageView(expertGroupList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>
</div>
</div>
</body>
</html>