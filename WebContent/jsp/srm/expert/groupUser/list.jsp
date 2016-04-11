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
function search(){
	$("#searchForm").submit();
}

function doEmailFlag(recordFlow){
	var emailNotifyFlag = $('#emailNotifyFlag_'+recordFlow+':checked').val();
	if(!emailNotifyFlag){
		emailNotifyFlag = "N";
	}
	var emailFlag={
			"recordFlow":recordFlow,
			"emailNotifyFlag":emailNotifyFlag
	};
	var url = '<s:url value="/srm/expert/groupUser/emailFlag"/>';
	jboxPost(url , emailFlag , function(){} , null , true);
     
}

function doPhoneFlag(recordFlow){
	var phoneNotifyFlag=$('#phoneNotifyFlag_'+recordFlow+':checked').val();
	if(!phoneNotifyFlag){
		phoneNotifyFlag="N";
	}
	var phoneFlag={
			"recordFlow":recordFlow,
			"phoneNotifyFlag":phoneNotifyFlag
	};
	var url = '<s:url value="/srm/expert/groupUser/phoneFlag"/>';
	jboxPost(url , phoneFlag , function(){} , null , true);
}

function addExpert(){
	jboxOpen("<s:url value='/srm/expert/groupUser/addExpert?groupFlow=${param.groupFlow}'/>", "向专家组添加专家信息", 800,400);
}
function delExpertGroupUser(recordFlow){
	
	var url = '<s:url value="/srm/expert/groupUser/delete"/>?recordFlow='+recordFlow;
	jboxConfirm("确认删除？" , function(){
		jboxGet(url , null , function(){
			window.location.reload(true);
		} , null , true);
	});

}
</script>
<div class="mainright">
    <div class="content">
        <div class="title1 clearfix">
			 <form id="searchForm" action="<s:url value="/srm/expert/groupUser/list" />" method="post" > 
			 		专家组名：${group.groupName}
					<input type="hidden" name="groupFlow" value="${group.groupFlow }">
			 		<c:if test="${not empty param.groupFlow}">
			 		<input type="button" class="search" onclick="addExpert();" value="添加专家" >
			 		</c:if>
			</form>
		</div>

	<table class="xllist" > 
		<tr>
			<th width="80px">姓名</th>
			<th width="120px">性别/职称</th>
			<th width="80px">学位</th>
			<th width="80px">机构名称</th>
			<th width="80px">技术领域</th>
			<th width="80px">操作</th>
		</tr>
		<c:forEach items="${expertInfoList}" var="expertInfo">
		<tr style="height:20px ">
			<td>${expertInfo.user.userName}</td>
			<td>${expertInfo.user.sexName}/${expertInfo.user.titleName}</td>
			<td>${expertInfo.user.degreeName}</td>
			<td>${expertInfo.user.orgName}</td>
			<td>${expertInfo.expert.techAreaName}</td>
			<td>
				[<a href="javascript:delExpertGroupUser('${expertInfo.expertGroupUser.recordFlow}');" >删除</a>] 
			</td>
		</tr>
	   </c:forEach>
	</table>

</div>
</div>
</body>
</html>