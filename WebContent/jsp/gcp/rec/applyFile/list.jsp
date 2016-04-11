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
			    <span>文件信息</span>
			    <c:if test="${proj.projStatusId == gcpProjStatusEnumEdit.id||proj.projStatusId == gcpProjStatusEnumNoPassed.id}"><i class="i-trend-main-back" ><a href="javascript:void(0)" onclick="editApplyFile('${param.projFlow}')" title="点击修改"></a></i></c:if>
		    </th>
        </tr>
        <tr>
	     <th>序号</th>
	     <th>文件名称</th>
	     <th>版本号</th>
	     <th>版本日期</th>
	     <c:if test="${param.auditFlag == 'Y' }">
	    	 <th>审核意见</th>
	     </c:if>
	   </tr>
	   <c:forEach items="${fileList}" var="file" varStatus="status">
		<tr <c:if test="${status.count%2==0}"> class="odd" </c:if>>
			<td>${status.count}</td>
			<td>
				<a href="${ctxPath}/pub/file/down?fileFlow=${file.fileFlow}">${file.fileName}</a>
			</td>
			<td>${file.version}</td>
			<td>${file.versionDate}</td>
		 <c:if test="${param.auditFlag == 'Y' }">
				<td><label><input type="checkbox"  onclick="aliveRemark(this,'${file.fileFlow }');">不合格&#12288;</label> <input name="${file.fileFlow }_remark" id="${file.fileFlow }_remark" disabled="disabled" type="text" style="width: 200px;"/></td>
		</c:if>
		</tr>
	   </c:forEach>
	</table>
</div>
