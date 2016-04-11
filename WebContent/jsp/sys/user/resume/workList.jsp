<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<script type="text/javascript">
function addWork(){
	jboxOpen("<s:url value='/pub/resume/editWork?userFlow=${userFlow}'/>", "添加工作经历信息", 500, 350);
}
function editWork(recordId){
	jboxOpen("<s:url value='/pub/resume/editWork?userFlow=${userFlow}&recordId='/>"+recordId, "编辑工作经历信息", 500, 350);
}
function delWork(recordId){
	jboxConfirm("确认删除?",function () {
		var url = "<s:url value='/pub/resume/delWork?userFlow=${userFlow}&recordId='/>" + recordId;
		jboxPost(url,null,function(resp){
			if(resp == '${GlobalConstant.DELETE_SUCCESSED}'){
				window.parent.frames['mainIframe'].window.loadWork();
				doClose();
			}
		},null,true);
	});
}

</script>	
	
<div>
	<table class="xllist" style="width: 100%">
		<tr>
			<th colspan="6" style="text-align: left;padding-left: 20px;" onclick="slideToggle('work');">
				工作经历
				<%-- <a style="float: right;padding-right: 10px;" href="javascript:edit('${ sessionScope.currUser.userFlow}')">[新增]</a> --%>
				<c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
					<a style="float: right; padding-right: 10px;" href="javascript:addWork()">[新增]</a>
				</c:if>
			</th>
		</tr> 
		<tr>
			<th style="width: 100px;">开始年月</th>
			<th style="width: 100px;">结束年月</th>
			<th style="width: 303px;">单位名称</th>
			<th style="width: 100px;">部门</th>
			<th style="width: 100px;">职务</th>
			<c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
				<th style="width: 100px;">操作</th>
			</c:if>
		</tr>
		<tbody id="workTb" class="work">
		<c:if test="${!empty workFormList}">
		<c:forEach var="work" items="${workFormList}">
			<tr>
				<td style="width: 100px;">${work.startDate}</td>
				<td style="width: 100px">${work.endDate}</td>
				<td style="width: 303px">${work.orgName}</td>
				<td style="width: 100px">${work.department}</td>
				<td style="width: 100px">${work.title}</td>
				<c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
					<td style="width: 100px">
					[<a href="javascript:void(0)" onclick="editWork('${work.recordId}')">编辑</a>]
					[<a href="javascript:void(0)" onclick="delWork('${work.recordId}')">删除</a>]
					</td>
				</c:if>
			</tr>
		</c:forEach>
		</c:if>
		</tbody>
		<c:if test="${empty workFormList}">
			<tr>
		    	<td colspan="7">无记录</td>
			</tr>
		</c:if>
	</table>
</div>
	
