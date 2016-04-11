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
	function selectSingle(obj) {
		var value = $(obj).val();
		var name = $(obj).attr("name");
		$("input[name="+name+"][value!="+value+"]:checked").attr("checked",false);
	}
	
	function changeIsVisit() {
		var isRandom = $("input:checked[name='isRandom']").val();
		if (isRandom == '${GlobalConstant.FLAG_Y}') {
			$("input[name='isVisit']").attr("disabled",false);
		} else {
			$("input[name='isVisit']").attr("disabled",true);
		}
	}

	function modProjParam() {
		jboxConfirm("项目参数保存后不能修改，确认保存?",function(){
			var datas = {
					randomLock:"${projParam.randomLock}",
					designLock:"${projParam.designLock}",
					inputLock:"${projParam.inputLock}",
					inspectLock:"${projParam.inspectLock}",
					projLock:"${projParam.projLock}",
					isRandom:$("input:checked[name='isRandom']").val(),
					isVisit:$("input:checked[name='isVisit']").val(),
					inputTypeId:$("input:checked[name='inputTypeId']").val()
			}
			jboxGet("<s:url value='/edc/proj/modProjParam'/>",datas,function(){
				window.parent.frames['mainIframe'].location.reload(true);
				doClose();
			},null,true);
		},null);
	}
</script>
</head>
<body>
<form id="projForm" style="height: 100%" >
<div class="mainright">
<div class="content">
	<div class="title1 clearfix"> 
	<table width="100%" cellpadding="0" cellspacing="0" class="basic">
		<tr>
			<th width="20%">是否随机：</th>
			<td width="30%" id="isRandomTd" colspan="3">
				<c:choose>
					<c:when test="${ projParam.isRandom  == null }">
						<input onchange="selectSingle(this);changeIsVisit();" name="isRandom" type="checkbox" value="${GlobalConstant.FLAG_Y }" id="isRandom_Y"/><label for="isRandom_Y">是&#12288;</label>
						<input onchange="selectSingle(this);changeIsVisit();" name="isRandom" type="checkbox" value="${GlobalConstant.FLAG_N }" id="isRandom_N"/><label for="isRandom_N">否&#12288;</label>
					</c:when>
					<c:otherwise>
						${projParam.isRandom eq GlobalConstant.FLAG_Y ?"是":"否" }
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<th width="20%">是否随访：</th>
			<td width="30%" id="isVisitTd">
				<c:choose>
					<c:when test="${ projParam.isVisit  == null }">
						<input onchange="selectSingle(this);" name="isVisit" type="checkbox" value="${GlobalConstant.FLAG_Y }" id="isVisit_Y"
						<c:if test="${empty projParam.isRandom || projParam.isRandom eq GlobalConstant.FLAG_N }">disabled="disabled"</c:if>/><label for="isVisit_Y">是&#12288;</label>
						<input onchange="selectSingle(this);" name="isVisit" type="checkbox" value="${GlobalConstant.FLAG_N }" id="isVisit_N"
						<c:if test="${empty projParam.isRandom || projParam.isRandom eq GlobalConstant.FLAG_N }">disabled="disabled"</c:if>/><label for="isVisit_N">否&#12288;</label>
					</c:when>
					<c:otherwise>
						${projParam.isVisit eq GlobalConstant.FLAG_Y ?"是":"否" }
					</c:otherwise>
				</c:choose>	
			</td>
			<th width="20%">录入方式：</th>
			<td width="30%" id="inputTypeIdTd">
				<c:choose>
					<c:when test="${ projParam.inputTypeId  == null }">
						<input  name="inputTypeId" type="checkbox" onchange="selectSingle(this);" value="${projInputTypeEnumSingle.id }" id="inputType_single"/><label for="inputType_single">${projInputTypeEnumSingle.name }&#12288;</label>
						<input  name="inputTypeId" type="checkbox" onchange="selectSingle(this);" value="${projInputTypeEnumDouble.id }" id="inputType_double"/><label for="inputType_double">${projInputTypeEnumDouble.name }&#12288;</label>
					</c:when>
					<c:otherwise>
					${projParam.inputTypeName }
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</table>
	</div>
	<div class="button">
		<input type="hidden" name="projFlow" value="${proj.projFlow}" /> 
		<input class="search" type="button" value="保&#12288;存" onclick="modProjParam();" />
		<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
	</div>
</div>
</div>
</form>
</body>
</html>