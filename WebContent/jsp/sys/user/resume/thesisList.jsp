<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
	
<script type="text/javascript">
	function addThesis(){
		jboxOpen("<s:url value='/pub/resume/editThesis?userFlow=${userFlow}'/>", "添加论文信息", 500, 350);
	}
	function editThesis(thesisFlow){
		jboxOpen("<s:url value='/pub/resume/editThesis?userFlow=${userFlow}&thesisFlow='/>"+thesisFlow, "编辑论文信息", 500, 350);
	}

	function delThesis(thesisFlow){
		jboxConfirm("确认删除?",function () {
			var url = "<s:url value='/pub/resume/delThesis?thesisFlow='/>" + thesisFlow;
			jboxPost(url,null,function(resp){
				if(resp == '${GlobalConstant.DELETE_SUCCESSED}'){
					window.parent.frames['mainIframe'].window.loadThesis();
					doClose();
				}
			},null,true);
		});
	}
</script>
<div>
	<table class="xllist" style="width: 100%">
		<tr>
			<th colspan="6" style="text-align: left;padding-left: 20px;" onclick="slideToggle('thesis');">
				论文
				<c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
					<a style="float: right; padding-right: 10px;" href="javascript:addThesis()">[新增]</a>
				</c:if>
			</th>
		</tr>
		<tr>
            <th width="20%">论文题目</th>
            <th width="20%">发表期刊</th>
            <th width="10%">发表/出版日期</th>
            <th width="10%">论文类型</th>
            <th width="25%">项目来源</th>
            <c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
				<th style="width: 100px;">操作</th>
			</c:if>
		</tr>
		<c:if test="${! empty thesisList}">
		<tbody class="thesis">
			<c:forEach items="${thesisList}" var="thesis">
	             <tr>
		             <td width="20%">${thesis.thesisName}</td>
		             <td width="20%">${thesis.publishJour}</td>
		             <td width="10%">${thesis.publishDate}</td>
		             <td width="10%">${thesis.typeName}</td>
		             <td width="20%">${thesis.projSourceName}</td>
		             <c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
						 <td style="width: 100px">
							 [<a href="javascript:void(0)" onclick="editThesis('${thesis.thesisFlow}')">编辑</a>]
							 [<a href="javascript:void(0)" onclick="delThesis('${thesis.thesisFlow}')">删除</a>]
						 </td>
					</c:if>
				</tr>
	        </c:forEach>
		</tbody>
		</c:if>
		<c:if test="${empty thesisList}">
			<tr>
	             <td colspan="6">无记录</td>
			</tr>
		</c:if>
		</tbody>
	</table>
</div>
	

		
