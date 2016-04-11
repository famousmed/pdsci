<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<script type="text/javascript">
function addAcademic(){
	jboxOpen("<s:url value='/pub/resume/editAcademic?userFlow=${userFlow}'/>", "添加学会任职信息", 500, 350);
}
function editAcademic(recordId){
	jboxOpen("<s:url value='/pub/resume/editAcademic?userFlow=${userFlow}&recordId='/>"+recordId, "编辑学会任职信息", 500, 350);
}
function delAcademic(recordId){
	jboxConfirm("确认删除?",function () {
		var url = "<s:url value='/pub/resume/delAcademic?userFlow=${userFlow}&recordId='/>" + recordId;
		jboxPost(url,null,function(resp){
			if(resp == '${GlobalConstant.DELETE_SUCCESSED}'){
				window.parent.frames['mainIframe'].window.loadAcademic();
				doClose();
			}
		},null,true);
	});
}

</script>	
	
<div>
	<table class="xllist" style="width: 100%">
		<tr>
			<th colspan="4" style="text-align: left;padding-left: 20px;" onclick="slideToggle('academic');">
				学会任职
				<%-- <a style="float: right;padding-right: 10px;" href="javascript:edit('${ sessionScope.currUser.userFlow}')">[新增]</a> --%>
				<c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
					<a style="float: right; padding-right: 10px;" href="javascript:addAcademic()">[新增]</a>
				</c:if>
			</th>
		</tr>
		<tr>
			<th style="width: 100px;">开始年月</th>
			<th style="width: 400px;">学会名称</th>
			<th style="width: 200px;">职务</th>
			<c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
				<th style="width: 100px;">操作</th>
			</c:if>
		</tr>
		<tbody id="academicTb" class="academic">
		<c:if test="${! empty academicFormList}">
		<c:forEach var="academic" items="${academicFormList}">
			<tr>
				<td style="width: 100px;">${academic.startDate}</td>
				<td style="width: 400px">${academic.academicName}</td>
				<td style="width: 200px">${academic.title}</td>
				<c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
					<td style="width: 100px">
					[<a href="javascript:void(0)" onclick="editAcademic('${academic.recordId}')">编辑</a>]
					[<a href="javascript:void(0)" onclick="delAcademic('${academic.recordId}')">删除</a>]
					</td>
				</c:if>
			</tr>
		</c:forEach>
		</c:if>
		</tbody>
		<c:if test="${empty academicFormList}">
			<tr>
		    	<td colspan="4">无记录</td>
			</tr>
		</c:if>
	</table>
</div>
