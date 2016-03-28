<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<script type="text/javascript">

function addEdu(){
	var url="<s:url value='/pub/resume/editEdu?userFlow=${userFlow}'/>";
	if ("resDoc"=="${param.source}") {
		url += "&source=${param.source}";
		var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='350' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
		jboxMessager(iframe, "添加教育经历信息", 500, 350,null,true);
	} else {
		jboxOpen(url, "添加教育经历信息", 500, 350);
	}
}
function editEdu(recordId){
	var url="<s:url value='/pub/resume/editEdu?userFlow=${userFlow}&recordId='/>"+recordId;
	if ("resDoc"=="${param.source}") {
		url += "&source=${param.source}";
		var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='350' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
		jboxMessager(iframe, "编辑教育经历信息", 500, 350,null,true);
	} else {
		jboxOpen(url, "编辑教育经历信息", 500, 350);
	}
}

function delEdu(recordId){
	jboxConfirm("确认删除?",function () {
		var url = "<s:url value='/pub/resume/delEdu?userFlow=${userFlow}&recordId='/>" + recordId;
		jboxPost(url,null,function(resp){
			if(resp == '${GlobalConstant.DELETE_SUCCESSED}'){
				if ("resDoc"=="${param.source}") {
					loadEdu();
				} else {
					window.parent.frames['mainIframe'].window.loadEdu();
					doClose();
				}
			}
		},null,true);
	});
}


</script>	
	
<div>
	<table class="xllist" style="width: 100%">
		<tr>
			<th colspan="7" style="text-align: left;padding-left: 20px;" onclick="slideToggle('edu');">
				教育经历
				<%-- <a style="float: right;padding-right: 10px;" href="javascript:edit('${ sessionScope.currUser.userFlow}')">[新增]</a> --%>
				<c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
					<a style="float: right; padding-right: 10px;" href="javascript:addEdu()">[新增]</a>
				</c:if>
			</th>
		</tr>
		<tr>
			<th style="width: 100px;">开始年月</th>
			<th style="width: 100px;">结束年月</th>
			<th style="width: 200px;">学校名称</th>
			<th style="width: 100px;">专业</th>
			<th style="width: 100px;">学历</th>
			<th style="width: 100px;">学位</th>
			<c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
				<th style="width: 100px;">操作</th>
			</c:if>
		</tr>
		<tbody id="eduTb" class="edu">
		<c:if test="${! empty eduFormList}">
		<c:forEach var="edu" items="${eduFormList}">
			<tr>
				<td style="width: 100px;">${edu.startDate}</td>
				<td style="width: 100px">${edu.endDate}</td>
				<td style="width: 200px">${edu.college}</td>
				<td style="width: 100px">${edu.major}</td>
				<td style="width: 100px">${edu.education}</td>
				<td style="width: 100px">${edu.degree}</td>
				<c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
					<td style="width: 100px">
						[<a href="javascript:void(0)" onclick="editEdu('${edu.recordId}')">编辑</a>]
						[<a href="javascript:void(0)" onclick="delEdu('${edu.recordId}')">删除</a>]
					</td>
				</c:if>
			</tr>
		</c:forEach>
		</c:if>
		</tbody>
		<c:if test="${empty eduFormList}">
			<tr>
		    	<td colspan="7">无记录</td>
			</tr>
		</c:if>
	</table>
</div>
	

		
