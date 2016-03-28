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
	$(function(){
		$(".moduleDiv").hover(function(){
			$(this).css("background-color","pink");
		},function(){
			$(this).css("background-color","");
		});
	});
	
	function exportModules(){
		if($("[name='moduleCodes']:checked").length>0){
			$("#exportModules").submit();
		}else{
			jboxTip("请选择一个模块!");
		}
	}
	
	function addModuleNameInput(code,name,status){
		if(status.checked){
			$(status).after($("<input/>").attr({
				"type":"hidden",
				"id":code,
				"name":"moduleNames",
				"value":name,
			}));
		}else{
			$("#"+code).remove();
		}
	}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<form style="width: 100%;margin-top: 10px;" id="exportModules" action="<s:url value='/edc/export/exportData'/>" method="post">
				<div style="width: 59.5%;float: left;">
					<table class="xllist" style="width: 100%;">
						<tr>
							<th style="text-align: left;padding-left:10px;">导出模块</th>
						</tr>
						<tr>
							<td style="text-align: left;">
								<div style="width:100%;">
									<div style="float: left;width: 30%;">
										<c:forEach items="${moduleList}" var="module" varStatus="status">
											<c:if test="${!status.first && (status.index%15==0)}">
												</div><div style="float: left;padding-left:10px;width: 30%;">
											</c:if>
											<label>
												<div class="moduleDiv" style="padding-left:10px;">
													<input type="checkbox" name="moduleCodes" value="${module.moduleCode}"  onclick="addModuleNameInput('${module.moduleCode}','${module.moduleName}',this);"/>
													${module.moduleName}
												</div>
											</label>
										</c:forEach>
									</div>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<div style="width: 39.5%;float:right;">
					<table class="xllist" style="width: 100%;">
						<tr>
							<th style="text-align: left;padding-left:10px;">导出文件格式</th>
						</tr>
						<tr>
							<td style="text-align: left;padding-left:10px;">
								<label>
									<input type="radio" name="format" checked="checked" value="excel"/>
									EXCEL
								</label>
								&#12288;
								<label>
									<input type="radio" name="format" value="sas"/>
									SAS
								</label>
							</td>
						</tr>
						<tr>
							<th style="text-align: left;padding-left:10px;">是否压缩</th>
						</tr>
						<tr>
							<td style="text-align: left;padding-left:10px;">
								<label>
									<input type="radio" name="isRar" value="${GlobalConstant.FLAG_Y}"/>
									是
								</label>
								&#12288;
								<label>
									<input type="radio" name="isRar" checked="checked" value="${GlobalConstant.FLAG_N}"/>
									否
								</label>
							</td>
						</tr>
						<tr>
							<th style="text-align: left;padding-left:10px;">访视展示样式</th>
						</tr>
						<tr>
							<td style="text-align: left;padding-left:10px;">
								<label title="
									<table class='xllist' style='background-color:white;'>
										<tr>
											<th>访视名称</th>
											<th>属性名...</th>
										</tr>
										<tr>
											<td>V1</td>
											<td>4.5...</td>
										</tr>
										<tr>
											<td>V2</td>
											<td>5.5...</td>
										</tr>
									</table>
								">
									<input type="radio" name="visitStyle" checked="checked" value="vertical"/>
									纵向展示
								</label>
								&#12288;
								<label title="
									<table class='xllist' style='background-color:white;'>
										<tr>
											<th>V1_属性名</th>
											<th>V2_属性名...</th>
										</tr>
										<tr>
											<td>4.5</td>
											<td>5.5...</td>
										</tr>
										<tr>
											<td>4.5</td>
											<td>5.5...</td>
										</tr>
									</table>
								">
									<input type="radio" name="visitStyle" value="cross"/>
									横向展示
								</label>
							</td>
						</tr>
						<tr>
							<th style="text-align: left;padding-left:10px;">文件名标识</th>
						</tr>
						<tr>
							<td style="text-align: left;padding-left:10px;">
								<label>
									<input type="radio" name="nameFlag" checked="checked" value="${proj.projNo}"/>
									项目编号
								</label>
								&#12288;
								<label>
									<input type="radio" name="nameFlag" value="${proj.cfdaNo}"/>
									CFDA编号
								</label>
							</td>
						</tr>
						<tr>
							<td style="text-align: left;padding-left:10px;">
								<input type="button" value="导&#12288;出" class="search" onclick="exportModules();"/>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</div>
			
</body>
</html>