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
	function doClose(){
		jboxClose();
	}
	
	/* function saveModuleSingle(obj){
		var actionFlag = "";
		if(obj.checked==true){
			actionFlag = "${GlobalConstant.FLAG_Y}	";
		}else {
			actionFlag = "${GlobalConstant.FLAG_N}	";
		}
		jboxGet("<s:url value='/edc/design/saveModuleSingle'/>?moduleCode="+$(obj).val()+"&actionFlag="+actionFlag,null,function(){
			window.parent.frames["jbox-iframe"].location.reload();
			window.parent.frames['mainIframe'].location.reload();
		});	
	} */
</script>
</head>

<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
<form id="chooseForm">
	<table class="mation" style="width: 500px">
		<tr style="height: 28px">
			<th style="text-align: center;" width="30px">序号</th>
			<th style="text-align: center;" width="150px">名称</th>
			<th style="text-align: center;" width="70px">缩写</th>
		</tr>

		<c:forEach var="dict" items="${dictTypeEnumModuleTypeList}">
			<c:if test="${!empty edcModuleMap[dict.dictId] }"> 
				<tr>
					<td colspan="3" style="text-align: left;">
					 <p style=" color:#c00; line-height:15px; background:url('<s:url value='/css/skin/${skinPath}/images/tb.png'/>') no-repeat 20px -11px; padding:18px 0 6px 40px;float: left">&#12288;&#12288;${dict.dictName }(${dict.dictId }:${fn:length(edcModuleMap[dict.dictId]) }) </p>
					</td>
				</tr>
				<c:forEach var="module" items="${edcModuleMap[dict.dictId]}" >
					<tr>
						<td style="text-align: center;">${module.ordinal}</td>	  
						<td style="text-align: center;">${module.moduleName}</td>
						<td style="text-align: center;">${module.moduleShortName}</td>
					</tr>
				</c:forEach>
			</c:if>
		</c:forEach>

	</table>
</form>
</div>
</div>
</div>
</body>
</html>