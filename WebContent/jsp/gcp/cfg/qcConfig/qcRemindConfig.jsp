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
 	var value = {
			<c:forEach items="${qcConfigMap}" var="values">
				'${values.key}':{
					<c:forEach items="${values.value}" var="v">
						'${v}':'${v}',
					</c:forEach>
				},
			</c:forEach>
	};
 	
 	$(function(){
 		for(var categoryKey in value){
 			for(var typeKey in value[categoryKey]){
 				$("#"+categoryKey+typeKey).append("<img src=\"<s:url value='/css/skin/${skinPath}/images/gou.gif'/>\">");
 			}
 		}
 	});
 	
	function pushValue(qcType,qcCategory){
		if(qcCategory in value){
			if(qcType in value[qcCategory]){
				delete value[qcCategory][qcType];
				$("#"+qcCategory+qcType).find("img").remove();
			}else{
				value[qcCategory][qcType] = qcType;
				$("#"+qcCategory+qcType).append("<img src=\"<s:url value='/css/skin/${skinPath}/images/gou.gif'/>\">");
			}
		}else{
			value[qcCategory] = {};
			value[qcCategory][qcType] = qcType;
			$("#"+qcCategory+qcType).append("<img src=\"<s:url value='/css/skin/${skinPath}/images/gou.gif'/>\">");
		}
	}
	
	function saveConfig(){
		var url = "<s:url value='/gcp/cfg/saveQcRemindConfig'/>";
		var data = "";
		for(var categoryKey in value){
 			for(var typeKey in value[categoryKey]){
 				if(data != null && data != ""){
 					data+=("&"+categoryKey+"="+typeKey);
 				}else{
 					data+=(categoryKey+"="+typeKey);
 				}
 			}
 		}
		jboxPost(url,data);
	}
	
	function back(){
		location.href = "<s:url value='/gcp/proj/main'/>";
	}
</script>
</head>
<body>
	<div class="mainright" id="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div style="margin-bottom: 10px">Tip：再次点击可取消选择!</div>
			<table class="xllist" > 
				<tr>
					<th rowspan="2">质控节点</th>
					<th colspan="2">质控类型</th>
				</tr>
				<tr>
					<th>${gcpQcTypeEnumDept.name}</th>
					<th>${gcpQcTypeEnumOrg.name}</th>
				</tr>
				<c:forEach items="${gcpQcCategoryEnumList}" var="qcCategory">
					<tr>
						<td>${qcCategory.name}</td>
						<td id="${qcCategory.id}${gcpQcTypeEnumDept.id}" onclick="pushValue('${gcpQcTypeEnumDept.id}','${qcCategory.id}');">
						</td>
						<td id="${qcCategory.id}${gcpQcTypeEnumOrg.id}" onclick="pushValue('${gcpQcTypeEnumOrg.id}','${qcCategory.id}');">
						</td>
					</tr>
				</c:forEach>
			</table>
			<div align="center" style="margin-top: 10px">
				<input type="button" class="search" value="保&#12288;存" onclick="saveConfig();" />
				<c:if test="${!empty param.beforePage}">
					<input type="button" class="search" value="返&#12288;回" onclick="back();" />
				</c:if>
			</div>
		</div>
	</div> 
</div>
</body>
</html>