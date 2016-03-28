<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style type="text/css">
td.td_sp{padding-left: 30px;}
</style>
<script type="text/javascript">
function editStamp(projFlow){
	jboxOpen("<s:url value='/gcp/rec/editSumStamp?projFlow='/>" + projFlow ,"编辑总结盖章",900,500);
}
</script>
<table cellpadding="0" class="i-trend-main-table" cellspacing="0" border="0" style="width: 100%">
	<colgroup>
		<col width="70%" />
		<col width="30%" />
	</colgroup>
  <tr>
	<th colspan="2" class="ith">
	<span>盖章信息</span>
	<c:if test="${param.roleScope eq GlobalConstant.ROLE_SCOPE_GO }">
	<i class="i-trend-main-back" ><a href="javascript:void(0)" onclick="editStamp('${param.projFlow}')" title="点击修改"></a></i>
	</c:if>
	</th>
  </tr>
  <tr>
  	<td class="td_sp" colspan="2">项目名称：${proj.projName }</td>
  </tr>
  <tr class="odd">
  	<td class="td_sp">项目来源：${proj.projDeclarer }</td>
    <td >期类别：${proj.projSubTypeName }</td>
  </tr>
  <tr>
  	<td class="td_sp">承担科室：${proj.applyDeptName }</td>
    <td >主要研究者：${proj.applyUserName }</td>
  </tr>
  <tr class="odd">
    <td class="td_sp" colspan="2">主要研究者确认：${ssForm.resConfirm }</td>
  </tr>
  <tr>
  	<td class="td_sp">主要研究者（签字）：${ssForm.resSign }</td>
  </tr>
  <tr class="odd">
    <td class="td_sp" colspan="2">机构办公室确认：${ssForm.orgConfirm }</td>
  </tr>
  <tr>
    <td class="td_sp" colspan="2">项目管理员（签字）：${ssForm.adminSign }</td>
  </tr>
   <tr class="odd">
  	<td class="td_sp">办公室主任（签字）：${ssForm.dirSign }</td>
    <td >日&#12288;期：${ssForm.date }</td>
  </tr>
</table>