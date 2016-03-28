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
	function assign() {
		if(false==$("#assignForm").validationEngine("validate")){
			return ;
		}
		jboxPost("<s:url value='/edc/random/assignConfirm'/>",$('#assignForm').serialize(),function(resp){
			var confirmMessage = "确认申请?";
			if(resp != '${GlobalConstant.OPERATE_SUCCESSED}'){
				confirmMessage = "<font color='blue'>" + $("#patientName").val() + "</font>已存在入组申请记录,编号为：" + resp +"， 确认新受试者入组申请?";
			}
			jboxConfirm(confirmMessage,function(){
				var factorObjs = $("input[name='factors']");
				var layerFactors = "";
				factorObjs.each(function(){
					var value = this.value;
					layerFactors = layerFactors + $("input[name='factor_"+value+"']:checked").val();
				});
				var inputs = $("input[name='ieFlows']");
				var values = [];
				inputs.each(function(){
					var value = this.value;
					var obj = {"ieValue":$("input[name='ieValue_"+value+"']:checked").val(),"varName":$("#varName_"+value).val()};
					values.push(obj);
				});
				var sexId = $("input[name='sexId']:checked").val();
				var requestData= {"patientFlow":$("#patientFlow").val(),"patientName":$("#patientName").val(),"sexId":sexId,
						"patientBirthday":$("#patientBirthday").val(),"layerFactors":layerFactors,"ieValueList":values};
				jboxPostJson("<s:url value='/edc/random/assign'/>?assignLabel=${edcRandomAssignLabelEnumFirst.id}",JSON.stringify(requestData),function(resp){
					
					if(resp.indexOf("${GlobalConstant.RANDOM_SUCCESSED}")>-1){
						window.parent.frames['mainIframe'].location.reload(true);
						jboxInfo(resp);
						doClose();
					} else {
						jboxInfo(resp);
					}
				},null,false);
			});
		},null,false);
	}
	
	function doClose(){
		jboxClose();
	}
	
	function includeExclude () {
		if(false==$("#assignForm").validationEngine("validate")){
			return ;
		}
		$("#patientInfo").hide();
		$("#ieButton").hide();
		$("#includeExclude").show();
		$("#patientButton").show();
		$("#assignButton").show();
	}
	
	function patientInfo () {
		$("#ieButton").show();
		$("#patientInfo").show();
		$("#includeExclude").hide();
		$("#patientButton").hide();
		$("#assignButton").hide();
	}
	
	$(document).ready(function(){
		if ("${GlobalConstant.FLAG_Y}" != "${ieFlag}") {
			$("#ieButton").hide();
			$("#assignButton").show();
		}
	});
</script>
<style type="text/css">
.none {
	border-collapse: collapse;
	table-layout: fixed;
}

.none td {
	border: 0 none;
	border-collapse: collapse;
	padding-bottom: 3px;
	padding-top: 3px;
}
</style>
</head>
<body>

<div class="mainright">
<div class="content">
	<div class="title1 clearfix" align="center">
		<form id="assignForm" style="position: relative;">
		<input type="hidden" id="patientFlow" name="patientFlow" value="${patient.patientFlow }"/>
				<table width="95%" cellpadding="0" cellspacing="0" class="basic"  id="patientInfo" style="display:">	
					<tr>
						<th align="right" width="50%">受试者姓名：</th>
						<td align="left" width="50%">
							<input type="text" id="patientName" class="validate[required]" name="patientName" value="" />
						</td>  
					</tr>	
					<tr>
						<th align="right" width="50%">受试者性别：</th>
						<td align="left" width="50%">
							<input id="${userSexEnumMan.id }" class="validate[required]" type="radio" name="sexId"  value="${userSexEnumMan.id }"/>
			                <label for="${userSexEnumMan.id }">${userSexEnumMan.name}</label>&#12288;
			                <input id="${userSexEnumWoman.id }" class="validate[required]" type="radio"  name="sexId" value="${userSexEnumWoman.id }" />
			                <label for="${userSexEnumWoman.id }">${userSexEnumWoman.name }</label>
						</td>
					</tr>			
					<tr>
						<th align="right" width="50%">受试者出生日期：</th>
						<td align="left" width="50%">
							<input type="text" id="patientBirthday" name="patientBirthday" class="validate[required] " value="" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
						</td>  
					</tr>
					<c:if test="${!empty factors }">
					<tr>
						<td colspan="2" width="100%">
							<fieldset>
								<legend>预后因素</legend>
								<table width="100%" class="none">
									<c:forEach items="${factors }" var="factor">
									<input type="hidden" name="factors" value="${factor.index }">
										<c:forEach items="${factor.itemMap }" var="item">
										<tr>
											<td><input type="radio" class="validate[required] " name="factor_${factor.index }" value="${item.key }" id="${factor.index }_${item.key}"/><label for="${factor.index }_${item.key}">&#12288;${item.value }</label></td>
										</tr>
										</c:forEach>
										<tr><td><hr/>
										</td></tr></c:forEach>
								</table>
							</fieldset>
					    </td> 
					</tr>
					</c:if>
				</table>
			
				<table width="95%" cellpadding="0" cellspacing="0" class="basic" id="includeExclude" style="display: none">	
					<tr>
						<th colspan="2" style="text-align: left;">&#12288;纳入标准
						</th>
					</tr>
					<c:forEach items="${inList}" var="in">
						<tr>
							<td width="200px">${in.ieName }</td>
							<td width="50px" style="text-align: center;padding-left: 0;">
								<input type="hidden" name="ieFlows" value="${in.ieFlow }">
								<input type="hidden" id="varName_${in.ieFlow }" value="${in.ieVarName }">
								<c:if test="${appItemInputTypeEnumNumber.id == in.inputTypeId}">
									<input type="text" name="ieValue_${in.ieFlow }" value="" class="validate[min[${in.minValue }], max[${in.maxValue }]"/>
								</c:if>
								<c:if test="${appItemInputTypeEnumBool.id == in.inputTypeId}">
									<input id="${in.ieFlow }_true" class="validate[required]" type="radio" name="ieValue_${in.ieFlow }" value="true" checked/>
					                <label for="${in.ieFlow }_true">是</label>
					                <input id="${in.ieFlow }_false" class="validate[required]" type="radio" name="ieValue_${in.ieFlow }" value="false" />
					                <label for="${in.ieFlow }_false">否</label>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				<c:if test="${empty inList }"> 
					<tr> 
						<td style="text-align: center;" colspan="2">无记录</td>
					</tr>
				</c:if>
				<tr>
					<th colspan="2" style="text-align: left;">&#12288;排除标准
					</th>
				</tr>
				<c:forEach items="${exList}" var="ex">
				<tr>
					<td width="200px">${ex.ieName }</td>
					<td width="50px" style="text-align: center;padding-left: 0;">
						<input type="hidden" name="ieFlows" value="${ex.ieFlow }">
						<input type="hidden" id="varName_${ex.ieFlow }" value="${ex.ieVarName }">
						<c:if test="${appItemInputTypeEnumNumber.id == ex.inputTypeId}">
							<input type="text" name="ieValue_${in.ieFlow }" value=""  class="validate[min[${ex.minValue }], max[${ex.maxValue }]"/>
						</c:if>
						<c:if test="${appItemInputTypeEnumBool.id == ex.inputTypeId}">
							<input id="${ex.ieFlow }_true" class="validate[required]" type="radio" name="ieValue_${ex.ieFlow }" value="true"/>
					        <label for="${ex.ieFlow }_true">是</label>
					        <input id="${ex.ieFlow }_false" class="validate[required]" type="radio" name="ieValue_${ex.ieFlow }" value="false" checked/>
					        <label for="${ex.ieFlow }_false">否</label>
						</c:if>
					</td>
				</tr>
				</c:forEach>
				<c:if test="${empty exList }"> 
					<tr> 
						<td style="text-align: center;" colspan="2">无记录</td>
					</tr>
				</c:if>
			</table>
		</form>
		<div class="button" style="width: 400px;">
			<input type="button" class="search" value="下一步" onclick="includeExclude();" id="ieButton" style="display: "/>
			<input type="button" class="search" value="上一步" onclick="patientInfo();" id="patientButton" style="display: none"/>
			<input type="button" class="search" value="申&#12288;请" onclick="assign();" id="assignButton" style="display: none"/>
			<input type="button" class="search" onclick="doClose();" value="关&#12288;闭">
		</div>
	</div>
	</div>
</div>
</body>
</html>