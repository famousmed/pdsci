<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style type="text/css">
td.td_sp{padding-left: 30px;}
</style>
<script type="text/javascript">
function editWork(projFlow){
	if ("${gcpProjStageEnumApply.id}"=="${proj.projStageId}") {
		jboxTip("该项目尚未启动，请先编辑启动会！");
		return;
	}
	jboxOpen("<s:url value='/gcp/rec/editFinishWork?projFlow='/>" + projFlow+"&roleScope=${param.roleScope}" ,"编辑研究结束工作",800,380);
}
</script>
<table cellpadding="0" class="i-trend-main-table" cellspacing="0" border="0" style="width: 100%">
	<colgroup>
		<col width="50%" />
		<col width="50%" />
	</colgroup>
  <tr>
	<th colspan="2" class="ith">
	<span>研究结束工作</span>
	<c:if test="${param.roleScope eq GlobalConstant.ROLE_SCOPE_GO }">
	<i class="i-trend-main-back" ><a href="javascript:void(0)" onclick="editWork('${param.projFlow}')" title="点击修改"></a></i>
	</c:if>
	</th>
  </tr>
  <tr>
  	<td class="td_sp">数据库锁定日期：${fwForm.dbLockDate }</td>
  	<td>剩余药物退还清库日期：${fwForm.cleanDate }</td>
  </tr>
  <tr class="odd">
  	<td class="td_sp">项目信息锁定日期：${fwForm.projLockDate }</td>
    <td >审评意见答复日期：${fwForm.replyDate }</td>
  </tr>
  <tr>
  	<td class="td_sp">药审中心答辩日期：${fwForm.answerDate }</td>
    <td >药品注册号：${fwForm.regNumber }</td>
  </tr>
  <tr class="odd">
    <td class="td_sp" >药品批准文号：${fwForm.appNumber }</td>
    <td>获得证书复印件日期：${fwForm.copiesDate }</td>
  </tr>
  <tr class="odd">
    <td class="td_sp" colspan="2">项目状态：${proj.projStageName}</td>
  </tr>
</table>