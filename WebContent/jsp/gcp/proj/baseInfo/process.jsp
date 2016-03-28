<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style type="text/css">
.ui-recent-footer {
	padding: 12px 9px;
	height: 16px;
	line-height: 16px;
	text-align: right;
}
</style>
<script type="text/javascript">
<!--
function editApplyFile(projFlow){
	jboxOpen("<s:url value='/gcp/rec/editApplyFile'/>?projFlow="+projFlow,"上传项目文件",900,400);
}
function aliveRemark(obj,fileFlow){
	if(obj.checked){
		$("#"+fileFlow+"_remark").attr("disabled",false);
	}else {
		$("#"+fileFlow+"_remark").attr("disabled",true);
	}
}
//-->
</script>
<div class="i-trend-main-div">
	<table class="i-trend-main-table i-trend-main-div-table"  border="0" cellpadding="0" cellspacing="0" width="100%">
		<col width="10%" />
        <col width="25%" />
        <col width="15%" />
        <col width="20%" />
        <tr>
		    <th colspan="5" class="ith">
			    <span>项目进度</span>
			    <c:if test="${proj.projStatusId == gcpProjStatusEnumEdit.id||proj.projStatusId == gcpProjStatusEnumNoPassed.id}"><i class="i-trend-main-back" ><a href="javascript:void(0)" onclick="editApplyFile('${param.projFlow}')" title="点击修改"></a></i></c:if>
		    </th>
        </tr>
        <tr>
	   				<th width="50px;">内容</th>
					<th width="100px;">进度</th>
					<th>操作时间</th>		
					<th width="100px;">操作人</th>	
	   </tr>
		 <c:forEach items="${processList}" var="process" varStatus="statu">
			<tr>
				<td>${process.recTypeName}</td>
				<td>${process.processRemark }</td>
				<td>${pdfn:transDateTime(process.operTime)}</td>
				<td>${process.operUserName }</td>
			</tr>
		</c:forEach>
		<c:if test="${empty processList }">
		<tr>
			<td colspan="9">无记录！</td>
		</tr>
		</c:if>
	</table>
</div>
