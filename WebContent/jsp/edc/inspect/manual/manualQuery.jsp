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
$(document).ready(function(){
	$("input[name='recordFlow']:checked",window.parent.frames['mainIframe'].document).each(function(){
		var visitName= ($(this).attr("queryTitle")).split("_")[0];
		var moduleName= ($(this).attr("queryTitle")).split("_")[1];
		var elementName= ($(this).attr("queryTitle")).split("_")[2];
		var elementSeq= ($(this).attr("queryTitle")).split("_")[3];
		var attrName= ($(this).attr("queryTitle")).split("_")[4];
		var value= ($(this).attr("queryTitle")).split("_")[5];
		var tr = "<tr><td>"+visitName +"</td><td>"+moduleName+"</td><td>"+elementName+"</td><td>"+elementSeq+"</td><td>"+attrName+"</td><td>"+value+"</td></tr>"; 
		$("#queryDetail").append(tr);
	});
});

function sendQuery(){
	if(false==$("#queryDetailForm").validationEngine("validate")){
		return ;
	}
	
	var data = $("#manualForm",window.parent.frames['mainIframe'].document).serialize()+"&queryTypeId="+$("#queryTypeId").val()+"&queryContent="+$("#queryContent").val();
	jboxConfirm("确认发送疑问?",function(){
		jboxPost("<s:url value='/edc/inspect/manualQuery'/>",data,function(){
			$("input[name='recordFlow']:checked",window.parent.frames['mainIframe'].document).each(function(){
				$(this).attr("checked",false);
				$(this).parent().css("display","none");
				$(this).parent().parent().removeClass("selected");
				$(this).parent().parent().prev().removeClass("selected");
			});
			jboxCloseMessager();
		},null,true);
	});
}
</script>
</head>

<body>
	<script type="text/javascript">
		
	</script>
	<div class="mainright">
		<div class="content">
				<div class="title1 clearfix">
		<table class="xllist">
			<tr>
				<th width="100px">访视名称</th>
				<th width="100px">模块名称</th>
				<th width="100px">元素名称</th>
				<th width="50px">录入序号</th>
				<th width="100px">属性名称</th>
				<th width="100px">录入值</th>
			</tr>
			<tbody id="queryDetail">
			
			</tbody>
		</table>
		
		<div style="margin-top: 25px;"   > 
			<form id="queryDetailForm">
			<table style="width:100%;"  >
			<tr>
				<td>
					疑问类型：<select id="queryTypeId" style="width: 200px">
						<c:forEach items="${dictTypeEnumQueryTypeList}" var="type">
							<option value="${type.dictId }">${type.dictName }</option>
						</c:forEach>
					</select>
					疑问内容：<input class="validate[required] text" type="text" id="queryContent" style="width: 60%"/><input type="button" onclick="sendQuery();" class="search" value="确认发送"/>
				</td>
			</tr>
			</table>
			</form>
		</div>
		</div>
		</div>
		</div>
</body>
</html>