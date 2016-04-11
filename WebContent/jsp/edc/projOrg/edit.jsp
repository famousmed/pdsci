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
	<jsp:param name="jquery_ui_combobox" value="true"/>
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
	function saveOrg() {
		if(false==$("#projOrgForm").validationEngine("validate")){
			return ;
		}
		jboxGet("<s:url value='/edc/projOrg/saveOrgConfirm'/>?recordFlow=${projOrg.recordFlow}&orgFlow="+$("#orgFlow option:selected").val()+"&centerNo="+$("#centerNo").val(),null,function(resp){
			if(resp == '${GlobalConstant.OPRE_SUCCESSED}'){
				$("#orgName").val($("#orgFlow option:selected").text());
				jboxPost("<s:url value='/edc/projOrg/save'/>", $('#projOrgForm').serialize(), function() {	
					window.parent.frames['mainIframe'].location.reload(true);
					doClose();
				});
			} else if(resp == "orgError"){
				jboxTip("当前机构已参加本项目，不能重复添加!");
			} else {
				jboxTip("该中心号本项目已存在，请修改!");
			}
		},null,false);
	}
	function doClose() 
	{
		jboxClose();
	}
	$(document).ready(function(){
		$("#orgFlow").scombobox({
			forbidInvalid : true,
			invalidAsValue : true,
			expandOnFocus : false
		});
		$(".scombobox-display").addClass("validate[required]");
	});
</script>
</head>
<body>

<form id="projOrgForm" style="padding-left: 10px;height: 100px;" >
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0"  align="center">				
				<table width="400" cellpadding="0" cellspacing="0" class="basic">					
					<tr>
						<th>中心号：</th>
						<td>
							<input name="recordFlow" type="hidden" value="${projOrg.recordFlow }" />
							<input class="validate[required,custom[integer]] xltext" id="centerNo" name="centerNo" type="text" value="${projOrg.centerNo }" />
						</td>  
					</tr>
					<tr>
						<th>机构名称：</th>
						<td>
							<select class="validate[required]" id="orgFlow" name="orgFlow" style="180px;">
								<option value="">请选择</option>
								<c:forEach var="sysOrg" items="${applicationScope.sysOrgList}">
								<option value="${sysOrg.orgFlow}" <c:if test="${sysOrg.orgFlow==projOrg.orgFlow }">selected</c:if>>${sysOrg.orgName}</option>
								</c:forEach>
							</select>
				        </td>                                    
				    </tr>
					<tr>   
					
						<th>机构角色：</th>
						<td>
							<select class="validate[required] xlselect" name="orgTypeId">
								<option value="">请选择</option>
								<c:forEach var="projOrgType" items="${projOrgTypeEnumList}">
								<option value="${projOrgType.id}" <c:if test="${projOrg.orgTypeId==projOrgType.id || (empty projOrg.recordFlow && projOrgTypeEnumParti.id eq projOrgType.id)}"> selected </c:if>>${projOrgType.name}</option>
								</c:forEach>
							</select>
						</td> 
		            </tr>
					<tr>
						<th>承担病例数：</th>
						<td >
							<input class="validate[custom[number]] xltext" name="patientCount" type="text" value="${projOrg.patientCount }" />
					    </td> 
					</tr>
				</table>
				<div class="button" style="width: 400px;">
					<input type="button" class="search" value="保&#12288存" onclick="saveOrg();" />
					<input type="button" class="search" value="关&#12288闭" onclick="doClose();">
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>