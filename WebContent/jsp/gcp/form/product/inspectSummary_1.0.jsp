<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<script type="text/javascript">
	$(function(){
		if(statusLevel.indexOf(qcStatus)>=afbView[role+qcType+"advise"]){
			$(".adviseTr").show();
		}
		if(statusLevel.indexOf(qcStatus)>=afbView[role+qcType+"feedback"]){
			$(".feedbackTr").show();
		}
		
		var qcRecordRec = true;
		var advise = ${not empty formDataMap['advise']};
		var feedback = ${not empty formDataMap['feedback']};
		buttonStatus = {
				"${GlobalConstant.ROLE_SCOPE_GO}${gcpQcTypeEnumOrg.id}${gcpQcStatusEnumSave.id}":advise,
                "${GlobalConstant.ROLE_SCOPE_RESEARCHER}${gcpQcTypeEnumOrg.id}${gcpQcStatusEnumSubmit.id}":feedback,
                "${GlobalConstant.ROLE_SCOPE_GO}${gcpQcTypeEnumDept.id}${gcpQcStatusEnumSubmit.id}":advise,
                "${GlobalConstant.ROLE_SCOPE_RESEARCHER}${gcpQcTypeEnumDept.id}${gcpQcStatusEnumSave.id}":qcRecordRec,
                "${GlobalConstant.ROLE_SCOPE_RESEARCHER}${gcpQcTypeEnumDept.id}${gcpQcStatusEnumOrgCheck.id}":feedback,
                };
		if(buttonShow()){
			if(buttonStatus[role+qcType+qcStatus]){
				$("#recSubmit").show();
			}
		}
		
		disableTag();
		
		var tags = detailTags[qcType][qcCategory];
		for(var i in tags){
			$("#"+tags[i].id+"Tr").show();
		}
	});
</script>
<input type="hidden" name="recTypeId" value="${gcpRecTypeEnumInspectSummary.id}"/>
<input type="hidden" name="formFileName" value="${formFileName}"/>

<table class="basic" width="100%" style="margin-bottom: 10px">
	<tr>
		<th colspan="8" style="text-align: left">&#12288;项目信息</th>
	</tr>
	<tr>
		<td width="12%" style="text-align: right">项目名称：</td>
		<td colspan="5">${projInfoForm.proj.projName}</td>
		<td width="12%" style="text-align: right">期类别：</td>
		<td>${projInfoForm.proj.projSubTypeName}</td>
	</tr>
	<tr>
		<td width="12%" style="text-align: right">项目来源/CRO：</td>
		<td colspan="7">${projInfoForm.proj.projDeclarer}${!empty projInfoForm.CROName?"/":""}${projInfoForm.CROName}</td>
	</tr>
	<tr>
		<td width="12%" style="text-align: right">项目编号：</td>
		<td width="13%">${projInfoForm.proj.projNo}</td>
		<td width="12%" style="text-align: right">项目类别：</td>
		<td width="13%">${projInfoForm.proj.projTypeName}</td>
		<td width="12%" style="text-align: right">CFDA批件号：</td>
		<td width="13%">${projInfoForm.proj.cfdaNo}</td>
		<td width="12%" style="text-align: right">研究者：</td>
		<td width="13%">${projInfoForm.proj.applyUserName}</td>
	</tr>
</table>

<table class="basic" width="100%">
	<tbody>
		<tr>
			<th><font style="float: left">&#12288;发现的问题</font></th>
		</tr>
		<c:forEach items="${gcpRecTypeEnumList}" var="recType">
			<c:if test="${recType.isForm eq 'Y' && !(recType.id eq gcpRecTypeEnumInspectSummary.id)}">
				<tr id="${recType.id}Tr" style="display: none;">
					<td><font style="font-weight: bolder;">${recType.name}问题：</font>
					<pre style="font-family: Microsoft Yahei;line-height:25px;margin-top: 0px">${proplemMap[recType.id]}</pre></td>
				</tr>
			</c:if>
		</c:forEach>
	</tbody>
	
	<tr class="adviseTr"  style="display: none">
		<th>
			<font style="float: left">&#12288;整改建议</font>
		</th>
	</tr>
	<tr class="adviseTr" style="display: none">
		<td>
			<textarea class="advise xltxtarea validate[required]" name="advise" placeholder="请填写整改建议（若没有，请填无）">${formDataMap['advise']}</textarea>
			<div style="float: right;margin-bottom: 10px">
				建议人：<input type="text" name="adviseUser" class="advise inputText validate[required]" value="${empty formDataMap['adviseUser']?sessionScope.currUser.userName:formDataMap['adviseUser']}" style="width: 80px"/>
				建议日期：<input style="margin-right: 15px;width: 100px" type="text" name="adviseDate" readonly="readonly" class="advise time inputText validate[required]" value="${empty formDataMap['adviseDate']?pdfn:getCurrDate():formDataMap['adviseDate']}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
			</div>
		</td>
	</tr>
	<tr class="feedbackTr" style="display: none">
		<th>
			<font style="float: left">&#12288;反馈</font>
		</th>
	</tr>
	<tr class="feedbackTr" style="display: none">
		<td>
			<textarea class="feedback xltxtarea validate[required]" name="feedback" placeholder="请填写反馈信息（若没有，请填无）">${formDataMap['feedback']}</textarea>
			<div style="float: right;margin-bottom: 10px">
				反馈人：<input type="text" name="feedbackUser" class="feedback inputText validate[required]" value="${empty formDataMap['feedbackUser']?sessionScope.currUser.userName:formDataMap['feedbackUser']}" style="width: 80px"/>
				反馈日期：<input style="margin-right: 15px;width: 100px" type="text" name="feedbackDate" readonly="readonly" class="feedback time inputText validate[required]" value="${empty formDataMap['feedbackDate']?pdfn:getCurrDate():formDataMap['feedbackDate']}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
			</div>
		</td>
	</tr>
</table>

