<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<script type="text/javascript">
	function addPatent(){
		jboxOpen("<s:url value='/pub/resume/editPatent?userFlow=${userFlow}'/>", "添加专利信息", 500, 350);
	}
	function editPatent(patentFlow){
		jboxOpen("<s:url value='/pub/resume/editPatent?userFlow=${userFlow}&patentFlow='/>"+patentFlow, "编辑专利信息", 500, 350);
	}
	
	function delPatent(patentFlow){
		jboxConfirm("确认删除?",function () {
			var url = "<s:url value='/pub/resume/delPatent?patentFlow='/>" + patentFlow;
			jboxPost(url,null,function(resp){
				if(resp == '${GlobalConstant.DELETE_SUCCESSED}'){
					window.parent.frames['mainIframe'].window.loadPatent();
					doClose();
				}
			},null,true);
		});
	}
</script>

<div>
	<table class="xllist" style="width: 100%">
		<tr>
			<th colspan="6" style="text-align: left;padding-left: 20px;" onclick="slideToggle('patent');">
				专利
				<c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
					<a style="float: right; padding-right: 10px;" href="javascript:addPatent()">[新增]</a>
				</c:if>
			</th>
		</tr>
		<tr>
           <th width="20%">专利名称</th>
	       <th width="20%">专利类型</th>
	       <th width="10%">专利状态</th>
	       <th width="25%">申请号</th>
	       <th width="10%">申请日期</th>
	       <c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
				<th style="width: 100px;">操作</th>
			</c:if>
		</tr>
		<c:if test="${! empty patentList}">
		<tbody class="patent">
		<c:forEach items="${patentList}" var="patent">
		    <tr>
		     	<td>${patent.patentName}</td>
		     	<td>${patent.typeName}</td>
		     	<td>${patent.statusName}</td>
		     	<td>${patent.applyCode}</td>
		     	<td>${patent.applyDate}</td>
		     	<c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
					<td style="width: 100px">
						[<a href="javascript:void(0)" onclick="editPatent('${patent.patentFlow}')">编辑</a>]
						[<a href="javascript:void(0)" onclick="delPatent('${patent.patentFlow}')">删除</a>]
					</td>
				</c:if>
		    </tr>
		</c:forEach>
		</tbody>
		</c:if>
		<c:if test="${empty patentList}">
			<tr>
	             <td colspan="6">无记录</td>
			</tr>
		</c:if>
	</table>
</div>
	

		
