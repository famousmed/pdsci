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
	function saveProj() {
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		
		var url = "<s:url value='/edc/proj/saveInfo'/>";
		var data = $('#projForm').serialize();
		jboxPost(url, data, function() {
			window.parent.frames['mainIframe'].location.reload(true);
			jboxClose();
		});
	}
	function modProjParamConfirm(type){
		if (type=='isRandom') {
			jboxConfirm("是否随机选择后不能修改，确认选择?",function(){
				modProjParam();
				var isRandom = $("input:checked[name='isRandom']").val();
				var isRandomName;
				if (isRandom == '${GlobalConstant.FLAG_Y}') {
					isRandomName = "是";
					$("#randomLock").attr("disabled",false);
					$("input[name='isVisit']").attr("disabled",false);
				} else {
					isRandomName = "否";
				}
				$("#isRandomTd").html(isRandomName);
				
			},function(){
				$("input[name='isRandom']").attr("checked", false);
			});
		} else if (type=='inputTypeId') {
			jboxConfirm("录入方式选择后不能修改，确认选择?",function(){
				modProjParam();
				var inputTypeId = $("input:checked[name='inputTypeId']").val();
				var inputTypeIdName;
				if (inputTypeId == '${projInputTypeEnumSingle.id }') {
					inputTypeIdName = "${projInputTypeEnumSingle.name }";
				} else {
					inputTypeIdName = "${projInputTypeEnumDouble.name }";
				}
				$("#inputTypeIdTd").html(inputTypeIdName);
			},function(){
				$("input[name='inputTypeId']").attr("checked", false);
			});
		} else if (type=='isVisit') {
			jboxConfirm("是否随访选择后不能修改，确认选择?",function(){
				modProjParam();
				var isVisit = $("input:checked[name='isVisit']").val();
				var isVisitName;
				if (isVisit == '${GlobalConstant.FLAG_Y}') {
					isVisitName = "是";
				} else {
					isVisitName = "否";
				}
				$("#isVisitTd").html(isVisitName);
			},function(){
				$("input[name='isVisit']").attr("checked", false);
			});
		}
	}
	
	function modProjParam() {
		var datas = {
				isRandom:$("input:checked[name='isRandom']").val(),
				isVisit:$("input:checked[name='isVisit']").val(),
				randomLock:$("input:checked[name='randomLock']").val(),
				designLock:$("input:checked[name='designLock']").val(),
				inputLock:$("input:checked[name='inputLock']").val(),
				inspectLock:$("input:checked[name='inspectLock']").val(),
				projLock:$("input:checked[name='projLock']").val(),
				inputTypeId:$("input:checked[name='inputTypeId']").val()
		}
		jboxGet("<s:url value='/edc/proj/modProjParam'/>",datas,null,null,false);
	}
</script>
</head>
<body>
<form id="projForm" style="height: 100%" >
<div class="mainright">
<div class="content">
	<div class="title1 clearfix"> 
	<table width="800" cellpadding="0" cellspacing="0" class="basic">
		<thead>
                  <tr>
                      <th colspan="4" class="bs_name">基本信息	
                     </th>
                  </tr>
        </thead>
		
		<tr>
			<th width="20%">项目名称：</th>
			<td width="30%" colspan="3">
				<input style="width: 560px;" class="validate[required] xltext" name="projName" type="text" value="${proj.projName }"/>
			</td>
		</tr>
		
		<tr>
			<th width="20%">项目简称：</th>
			<td width="30%">
				<input class="xltext" name="projShortName" type="text" value="${proj.projShortName }" />
			</td>
			<th width="20%">期类别：</th>
			<td width="30%">
				<select name="projSubTypeId" class="xlselect">
					<option value="">请选择</option>
					<c:forEach var="projSubType" items="${gcpProjSubTypeEnumList}">
									<option value="${projSubType.id}" <c:if test="${proj.projSubTypeId==projSubType.id}">selected="selected"</c:if>>${projSubType.name}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		
		<tr>
			<th width="20%">项目编号：</th>
			<td width="30%">
				<input class="xltext"  name="projNo" type="text" value="${proj.projNo }"/>
			</td>
			<th width="20%">CFDA编号：</th>
			<td width="30%">
				<input class="xltext" name="cfdaNo" type="text" value="${proj.cfdaNo }"/>
			</td>
		</tr>
		
	</table>
	<br/>
	<table width="800" cellpadding="0" cellspacing="0" class="basic">
		<thead>
                  <tr>
                      <th colspan="4" class="bs_name">参数信息
                      </th>
                  </tr>
               </thead>
		
		<tr>
			<th width="20%">是否随机：</th>
			<td width="30%" id="isRandomTd">
				<c:choose>
					<c:when test="${ projParam.isRandom  == null }">
						<input class="validate[required] " onchange="modProjParamConfirm('isRandom');"  name="isRandom" type="radio" value="${GlobalConstant.FLAG_Y }" id="isRandom_Y"/><label for="isRandom_Y">是&#12288;</label>
						<input class="validate[required] " onchange="modProjParamConfirm('isRandom');"  name="isRandom" type="radio" value="${GlobalConstant.FLAG_N }" id="isRandom_N"/><label for="isRandom_N">否&#12288;</label>
					</c:when>
					<c:otherwise>
						${projParam.isRandom eq GlobalConstant.FLAG_Y ?"是":"否" }
					</c:otherwise>
				</c:choose>
			</td>
			<th width="20%">随机锁定：</th>
			<td width="30%">
				<input  name="randomLock" <c:if test="${empty projParam.isRandom || projParam.isRandom eq GlobalConstant.FLAG_N }">disabled="disabled"</c:if>
				 <c:if test="${projParam.randomLock eq GlobalConstant.FLAG_Y }">checked</c:if> onchange="modProjParam();" id="randomLock" type="checkbox" value="${GlobalConstant.FLAG_Y }" id="randomLock"/><label for="randomLock">锁定&#12288;</label>
			</td>
		</tr>
		<tr>
			<th width="20%">是否随访：</th>
			<td width="30%" id="isVisitTd">
				<c:choose>
					<c:when test="${ projParam.isVisit  == null }">
						<input class="validate[required] " onchange="modProjParamConfirm('isVisit');"  name="isVisit" type="radio" value="${GlobalConstant.FLAG_Y }" id="isVisit_Y"
						<c:if test="${empty projParam.isRandom || projParam.isRandom eq GlobalConstant.FLAG_N }">disabled="disabled"</c:if>/><label for="isVisit_Y">是&#12288;</label>
						<input class="validate[required] " onchange="modProjParamConfirm('isVisit');"  name="isVisit" type="radio" value="${GlobalConstant.FLAG_N }" id="isVisit_N"
						<c:if test="${empty projParam.isRandom || projParam.isRandom eq GlobalConstant.FLAG_N }">disabled="disabled"</c:if>/><label for="isVisit_N">否&#12288;</label>
					</c:when>
					<c:otherwise>
						${projParam.isVisit eq GlobalConstant.FLAG_Y ?"是":"否" }
					</c:otherwise>
				</c:choose>	
			</td>
			<th width="20%">设计锁定：</th>
			<td width="30%">
				<input  name="designLock" <c:if test="${projParam.designLock eq GlobalConstant.FLAG_Y }">checked</c:if> onchange="modProjParam();" id="designLock" type="checkbox" value="${GlobalConstant.FLAG_Y }" id="designLock"/><label for="designLock">锁定&#12288;</label>
			</td>
		</tr>
		
		<tr>
			<th width="20%">录入方式：</th>
			<td width="30%" id="inputTypeIdTd">
			<c:choose>
					<c:when test="${ projParam.inputTypeId  == null }">
				<input  name="inputTypeId" onchange="modProjParamConfirm('inputTypeId');"  type="radio" value="${projInputTypeEnumSingle.id }" id="inputType_single"/><label for="inputType_single">${projInputTypeEnumSingle.name }&#12288;</label>
				<input  name="inputTypeId" onchange="modProjParamConfirm('inputTypeId');" type="radio" value="${projInputTypeEnumDouble.id }" id="inputType_double"/><label for="inputType_double">${projInputTypeEnumDouble.name }&#12288;</label>
				</c:when>
				<c:otherwise>
				${projParam.inputTypeName }
				</c:otherwise>
				</c:choose>
			</td>
			<th width="20%">录入锁定：</th>
			<td width="30%">
				<input  name="inputLock" <c:if test="${projParam.inputLock eq GlobalConstant.FLAG_Y }">checked</c:if> onchange="modProjParam();" id="inputLock"  type="checkbox" value="${GlobalConstant.FLAG_Y }" id="inputLock"/><label for="inputLock">锁定&#12288;</label>
			</td>
		</tr>
		<tr>
			<th width="20%"></th>
			<td width="30%">
			</td>
			<th width="20%">核查锁定：</th>
			<td width="30%">
				<input  name="inspectLock" <c:if test="${projParam.inspectLock eq GlobalConstant.FLAG_Y }">checked</c:if> onchange="modProjParam();" id="inspectLock" type="checkbox" value="${GlobalConstant.FLAG_Y }" id="inspectLock"/><label for="inspectLock">锁定&#12288;</label>
			</td>
		</tr>
		<tr>
			<th width="20%"></th>
			<td width="30%">
			</td>
			<th width="20%">数据库锁定：</th>
			<td width="30%">
				<input  name="projLock"  onchange="modProjParam();" <c:if test="${projParam.projLock eq GlobalConstant.FLAG_Y }">checked</c:if> id="projLock" type="checkbox" value="${GlobalConstant.FLAG_Y  }" id="projLock"/><label for="projLock">锁定&#12288;</label>
			</td>
		</tr>
	</table>
	</div>
	<div class="button" style="width: 800px;">
		<input type="hidden" name="projFlow" value="${proj.projFlow}" /> 
		<input class="search" type="button" value="保&#12288;存" onclick="saveProj();" />
	</div>
</div>
</div>
</form>
</body>
</html>