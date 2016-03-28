<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<script type="text/javascript">
	$(function(){
		disableTag();
	});
</script>
<input type="hidden" name="recTypeId" value="${gcpRecTypeEnumIcfInspect.id}"/>
<input type="hidden" name="formFileName" value="${formFileName}"/>
<table class="basic" width="100%">
	<tr>
		<th style="text-align: left;padding-left: 10px" colspan="4">知情同意书</th>
	</tr>
	<tr>
		<td style="text-align: right;width: 25%">本中心筛选：</td>
		<td>${filterCount+0}例</td>
		<td style="text-align: right;width: 25%">入组：</td>
		<td>${in+0}例</td>
	</tr>
	<tr>
		<td style="text-align: right;">脱落：</td>
		<td>${off+0}例</td>
		<td style="text-align: right;">实际完成：</td>
		<td>${finish+0}例</td>
	</tr>
	<tr>
		<td style="text-align: right;">第一例入组日期：</td>
		<td>${pdfn:transDate(firstInDate)}</td>
		<td style="text-align: right;">最后一例入组日期：</td>
		<td>${pdfn:transDate(lastInDate)}</td>
	</tr>
	<tr>
		<td style="text-align: right;">应保存知情同意书：</td>
		<td><input type="text" name="icfFileNum" value="${formDataMap['icfFileNum']}" class="xltext" style="margin-right: 5px;width: 50px"/>份</td>
		<td style="text-align: right;">实际保存知情同意书：</td>
		<td><input type="text" name="realIcfFileNum" value="${formDataMap['realIcfFileNum']}" class="xltext" style="margin-right: 5px;width: 50px"/>份</td>
	</tr>
	<tr>
		<th colspan="4">
			<font style="float: left">&#12288;发现的问题</font>
		</th>
	</tr>
	<tr>
		<td colspan="4">
			<textarea class="xltxtarea validate[required]" name="problem" placeholder="请填写发现的问题 (若没有，请填无)">${formDataMap['problem']}</textarea>
		</td>
	</tr>
</table>
