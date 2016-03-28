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
	<jsp:param name="jquery_ui_sortable" value="true"/>
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
<style>
	.attrTd:HOVER {
	background-color: pink;
}
</style>

<script type="text/javascript">
	function search(){
		if($("[name='viewAllIndex']:checked").length>0){
			$("[name='moduleCode']").val("");
		}
		$("#observationForm").submit();
	}
	
	function selAttr(attr,isCode,elementName,attrName,attrCode){
		if($(attr).find("img").length>0){
			$(attr).find("img").remove();
		}else{
			var selFlag = $('<img />');
			$(selFlag).attr("src","<s:url value='/css/skin/${skinPath}/images/gou.gif'/>");
			$(attr).append(selFlag);
		}
		var data = "isCode="+isCode+"&elementName="+elementName+"&attrName="+attrName+"&attrCode="+attrCode;
		jboxPost("<s:url value='/edc/design/saveInspectInfo'/>",data,null,null,false);
	}
	
	$(function (){
		if(${param.viewAllIndex eq GlobalConstant.FLAG_Y}){
			$(".dataBody").each(function(){
				if($(this).find(".attrTd").length<=0){
					$(this).hide();
				}else{
					$(this).find(".elementTr").each(function(){
						if($(this).find(".attrTd").length<=0){
							$(this).hide();
						}
					});
				}
			});
			
			if($(".dataBody").not(":hidden").length<=0){
				$("#dataFoot").show();
			}
		}
	});
</script>

<body>
<div class="mainright">
	<div class="content">
	<div style="margin-top: 5px">
		<form id="observationForm" action="<s:url value='/edc/design/observationCfg'/>">
		模块：<select style="width: 300px" name="moduleCode" onchange="search();">
				<option></option>
				<c:forEach items="${moduleList}" var="module">
				<option value="${module.moduleCode }" <c:if test="${param.moduleCode eq module.moduleCode }">selected</c:if>>${module.moduleName }</option>	
				</c:forEach>
			</select>
			&#12288;
			<label>
			<input type="checkbox" name="viewAllIndex" ${GlobalConstant.FLAG_Y eq param.viewAllIndex?'checked="true"':''} value="${GlobalConstant.FLAG_Y}" onclick="search();"/>
			显示全部观测指标
			</label>
			&#12288;&#12288;
			<span style="color: blue;float: right;margin-right: 10px">Tip：<font>点击选择,再次点击可取消选择！</font></span>
		</form>
			<hr/>
	</div>
	<div class="title1 clearfix">
		<c:set value="4" var="colCount"/>
		<table class="xllist">
			<tr>
				<th width="20%">元素名称</th>
				<th width="80%">属性</th>
			</tr>
			<c:forEach items="${(empty singleModuleList)?moduleList:singleModuleList}" var="module">
				<tbody class="dataBody">
					<c:if test="${!empty elementMap[module.moduleCode]}">
						<tr>
							<th colspan="2" style="text-align: left;padding-left: 10px">${module.moduleName}</th>
						</tr>
					</c:if>
					
					<c:forEach items="${elementMap[module.moduleCode]}" var="element">
						<tr class="elementTr">
							<td>${element.elementName}</td>
							<td>
							<table style="width: 100%;">
							<tr>
								<c:set value="0" var="attrCount" />
								<c:forEach items="${attrMap[element.elementCode]}" var="attr" varStatus="status">
									<c:if test="${!status.first && attrCount%colCount==0}"></tr><tr></c:if>
									<c:if test="${((GlobalConstant.FLAG_Y eq param.viewAllIndex) && (!empty observationCfgFormMap[attr.attrCode])) || !(GlobalConstant.FLAG_Y eq param.viewAllIndex)}">
										<td style="text-align: left ;border: none;padding-left: 10px;vertical-align: top;cursor: pointer;width:${100/colCount}%;" class="attrTd" onclick="selAttr(this,'${((empty codeMap[attr.attrCode]) || (attr.attrVarName eq GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME))?'':GlobalConstant.FLAG_Y}','${element.elementName}','${attr.attrName}','${attr.attrCode}');">
											${attr.attrName}&nbsp;
											<c:if test="${!empty observationCfgFormMap[attr.attrCode]}">
												<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
											</c:if>
										</td>
										<c:set value="${attrCount+1}" var="attrCount"/>
									</c:if>
								</c:forEach>
								<c:if test="${attrCount<colCount && attrCount!=0}">
									<c:forEach begin="1" end="${colCount-attrCount}">
										<td style="width:${100/colCount}%;text-align: left ;border: none;padding-left: 10px"></td>
									</c:forEach>
								</c:if>
							</tr>
							</table>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</c:forEach>
			<tr id="dataFoot" style="${empty elementMap?'':'display: none;'}"><td colspan="2">无记录</td></tr>
		</table>
	</div>
	</div>
	</div>
</body>
</html>