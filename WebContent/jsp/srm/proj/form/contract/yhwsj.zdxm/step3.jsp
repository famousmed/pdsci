<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
	#tb3 td input{text-align: left; }
</style>
<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
<script type="text/javascript">
	function nextOpt(step){
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		var form = $('#projForm');
		var action = form.attr('action');
		action+="?nextPageName="+step;
		form.attr("action" , action);
		form.submit();
	}
</script>
</c:if>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step3" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>

		<font style="font-size: 14px; font-weight:bold;color: #333; ">三、承担单位</font>
		<table id="tb3" class="bs_tb" style="width: 100%; margin-top: 10px;" >
			<tr>
				<td rowspan="7">承担单位</td>
				<td>单位名称</td>
				<td colspan="3" style="text-align: left; padding-left: 3.3%;"><input type="text" name="orgName" value="${empty resultMap.orgName?proj.applyOrgName:resultMap.orgName}" class="inputText" style="width: 80%;"/></td>
			</tr>
			<tr>
				<td>法人代码</td>
				<td colspan="3" style="text-align: left; padding-left: 3.3%;"><input type="text" name="legalPersonCode" value="${resultMap.legalPersonCode}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>详细地址</td>
				<td colspan="3" style="text-align: left; padding-left: 3.3%;"><input type="text" name="detailAddress" value="${resultMap.detailAddress}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>单位E-mail</td>
				<td><input type="text" name="orgEmail" value="${resultMap.orgEmail}" class="validate[custom[email]] inputText" style="width: 80%"/></td>
				<td>邮政编码</td>
				<td><input type="text" name="orgZipCode" value="${resultMap.orgZipCode}" class="validate[custom[chinaZip]] inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>单位负责人</td>
				<td><input type="text" name="headOfOrg" value="${resultMap.headOfOrg}" class="inputText" style="width: 80%"/></td>
				<td>联系电话<br/>手机</td>
				<td><input type="text" name="headOfOrgContactNumber" value="${resultMap.headOfOrgContactNumber}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>单位联系人</td>
				<td><input type="text" name="orgContacts" value="${resultMap.orgContacts}" class="inputText" style="width: 80%"/></td>
				<td>联系电话<br/>手机</td>
				<td><input type="text" name="orgContactsContactNumber" value="${resultMap.orgContactsContactNumber}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>开户银行</td>
				<td><input type="text" name="depositBank" value="${resultMap.depositBank}" class="inputText" style="width: 80%"/></td>
				<td>银行帐号</td>
				<td><input type="text" name="bankAccount" value="${resultMap.bankAccount}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td rowspan="3">协作单位</td>
				<td colspan="4">单位名称</td>
			</tr>
			<tr>
				<td>1</td>
				<td colspan="3" style="text-align: left; padding-left: 3.3%;"><input type="text" name="cooperateOrg1" value="${resultMap.cooperateOrg1}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>2</td>
				<td colspan="3" style="text-align: left; padding-left: 3.3%;"><input type="text" name="cooperateOrg2" value="${resultMap.cooperateOrg2}" class="inputText" style="width: 80%"/></td>
			</tr>
		</table>
		
	</form>
	
   	<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="prev" type="button" onclick="nextOpt('step2')" class="search" value="上一步"/>
		    <input id="nxt" type="button" onclick="nextOpt('step4')" class="search" value="下一步"/>
       	</div>
    </c:if>

		