<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="tagContent selectTag">
	<table class="xllist"><tr>
			<th >序号</th>
			<th >文件名称</th>
			<th >版本号</th>
			<th >版本日期</th>
			<th >备注</th>
		</tr>
		<c:forEach items="${applyFileFormList}" var="applyFile" varStatus="status">
			<tr style="cursor: pointer;">
				<td style="width: 10%">${status.count}</td>
				<td style="width: 40%">
					<a <c:choose><c:when test="${!empty applyFile.fileFlow }">href="${ctxPath}/pub/file/down?fileFlow=${applyFile.fileFlow}"</c:when><c:otherwise>href="javascript:jboxOpen('${applyFile.url}','${applyFile.fileName}',900,600)"</c:otherwise></c:choose> >${applyFile.fileName}</a>
				</td>
				<td style="width: 10%">${applyFile.version}</td>
				<td style="width: 15%">${applyFile.versionDate}</td>
				<td style="width: 25%">${applyFile.fileRemark}</td>
			</tr>
		</c:forEach>
	</table>
</div>
