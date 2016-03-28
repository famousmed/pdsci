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
function nextOpt(step){
	var form = $('#projForm');
	var action = form.attr('action');
	action+="?nextPageName="+step;
	form.attr("action" , action);
	form.submit();
}

function add(){
	var url = "?pageName=step4&itemGroupName=wcr&projRecFlow=${param.projRecFlow}&projFlow=${param.projFlow}";
	jboxOpen("<s:url value='/srm/proj/mine/showPageGroupStep'/>"+url, "添加信息", 500,350);
}


function edit(flow){
	var url = "?pageName=step4&itemGroupName=wcr&projRecFlow=${param.projRecFlow}&projFlow=${param.projFlow}&flow="+flow;
	jboxOpen("<s:url value='/srm/proj/mine/showPageGroupStep'/>"+url, "添加信息", 500,350);
}

function del(flow){
	var datas = {
			"pageName":"step4",
			"itemGroupName":"wcr",
			"projRecFlow":'${param.projRecFlow}',
			"projFlow":'${param.projFlow}',
			"flow":flow,
	};
	var url = "<s:url value='/srm/proj/mine/delPageGroupStep'/>";
	jboxPost(url , datas , function(){
		window.parent.frames['mainIframe'].location.reload(true);
		jboxClose();
	} , null , true);
}
</script>
</head>
<body>
第四步 流水号：${param.projFlow}
<a href="javascript:void(0)" onclick="add();">新增</a><br/>
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm">
	<input type="hidden" name="pageName" value="step4"/>
	<input type="hidden" name="projRecFlow" value="${param.projRecFlow}"/>
	<input type="hidden" name="projFlow" value="${param.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
	英文名：<input type="text" name="usName" value="${resultMap.usName}"/>
</form>
<table>
	<thead>
		<tr>
			<td>序号</td>
			<td>姓名</td>
			<td>性别</td>
			<td>生日</td>
			<td>操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="test" items="${resultMap.wcr}" varStatus="sta">
			<tr>
				<td>${sta.count}</td>
				<td>${test.objMap.userName}</td>
				<td>${test.objMap.sex}</td>
				<td>${test.objMap.birthday}</td>
				<td>[<a href="javascript:void(0);" onclick="edit('${test.flow}')">编辑</a>][<a href="javascript:void(0);" onclick="del('${test.flow}')">删除</a>]</td>
			</tr>
		</c:forEach>
	</tbody>
</table>




<a href="javascript:void(0)" target="_self" onclick="nextOpt('step3')" id="next">上一步</a>
<a href="javascript:void(0)" target="_self" onclick="nextOpt('file')">下一步</a>
</body>
</html>