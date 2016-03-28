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
</head>
<body>
	<script type="text/javascript">
		function saveProj() {
			if(false==$("#projForm").validationEngine("validate")){
				return false;
			}
			jboxGet("<s:url value='/edc/proj/saveProjConfirm'/>?projFlow=${proj.projFlow}&projNo="+$("#projNo").val(),null,function(resp){
				if(resp == '${GlobalConstant.OPRE_SUCCESSED}'){
					jboxPost("<s:url value='/edc/proj/save'/>", $('#projForm').serialize(), function() {
						window.parent.frames['mainIframe'].location.reload(true);
						doClose();
					});
				} else{
					jboxTip("项目编号重复，请修改!");
				}
			},null,false);
		}
		function doClose() {
			jboxClose();			
		}
	</script>
<form id="projForm" style="padding-left: 30px;height: 100px;" >
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">
				<table width="800" cellpadding="0" cellspacing="0" class="basic">
					<tr>
						<th width="20%">项目名称：</th>
						<td width="30%">
							<input class="validate[required,maxSize[250]] xltext" name="projName" type="text" value="${proj.projName }"/>
						</td>
						<th width="20%">项目简称：</th>
						<td width="30%">
							<input class="xltext validate[maxSize[100]]" name="projShortName" type="text" value="${proj.projShortName }" />
						</td>
					</tr>
					<tr>
					
					<tr>
						<th width="20%">项目编号：</th>
						<td width="30%">
							<input class="xltext"  id="projNo" name="projNo" type="text" value="${proj.projNo }"/>
						</td>
						<th width="20%">CFDA编号：</th>
						<td width="30%">
							<input class="xltext" name="cfdaNo" type="text" value="${proj.cfdaNo }"/>
						</td>
					</tr>
					
					
					<tr>
						<th>期类别：</th>
						<td>
							<select name="projSubTypeId" class="xlselect">
								<option value="">请选择</option>
								<c:forEach var="projSubType" items="${gcpProjSubTypeEnumList}">
									<option value="${projSubType.id}" <c:if test="${proj.projSubTypeId==projSubType.id}">selected="selected"</c:if>>${projSubType.name}</option>
								</c:forEach>
							</select>
						</td>
						<th></th>
						<td></td>
					</tr>
						
			
				</table>
				<div class="button" style="width: 800px;">
					<input type="hidden" name="projFlow" value="${proj.projFlow}" /> 
					<input class="search" type="button" value="保&#12288;存" onclick="saveProj();" />
					<input class="search" type="button" value="关&#12288;闭" onclick="doClose();" />
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>