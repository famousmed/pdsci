<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<script type="text/javascript">
	$(function(){
		disableTag();
	});
</script>
<input type="hidden" name="recTypeId" value="${gcpRecTypeEnumRawDataInspect.id}"/>
<input type="hidden" name="formFileName" value="${formFileName}"/>
<table class="basic" width="100%">
	<tr>
		<th style="text-align: left;padding-left: 10px">重点关注的问题：</th>
	</tr>
	<tr>
		<td style="text-align: left;">&#12288;1、入选与排除标准;</td>
	</tr>
	<tr>
		<td style="text-align: left;">&#12288;2、合并用药的填写;</td>
	</tr>
	<tr>
		<td style="text-align: left;">&#12288;3、CRF与原始病例核对及溯源;</td>
	</tr>
	<tr>
		<td style="text-align: left;">&#12288;4、SAE随访;</td>
	</tr>
	<tr>
		<td style="text-align: left;">&#12288;5、SAE文件;</td>
	</tr>
	<tr>
		<td style="text-align: left;">&#12288;6、检查记录;</td>
	</tr>
	<tr>
		<th>
			<font style="float: left">&#12288;发现的问题</font>
		</th>
	</tr>
	<tr>
		<td>
			<textarea class="xltxtarea validate[required]" name="problem" placeholder="请填写发现的问题 (若没有，请填无)">${formDataMap['problem']}</textarea>
		</td>
	</tr>
</table>