<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript">
	function addBook(){
		jboxOpen("<s:url value='/pub/resume/editBook?userFlow=${userFlow}'/>", "添加著作信息", 500, 350);
	}
	function editBook(bookFlow){
		jboxOpen("<s:url value='/pub/resume/editBook?userFlow=${userFlow}&bookFlow='/>"+bookFlow, "编辑著作信息", 500, 350);
	}
	
	function delBook(bookFlow){
		jboxConfirm("确认删除?",function () {
			var url = "<s:url value='/pub/resume/delBook?bookFlow='/>" + bookFlow;
			jboxPost(url,null,function(resp){
				if(resp == '${GlobalConstant.DELETE_SUCCESSED}'){
					window.parent.frames['mainIframe'].window.loadBook();
					doClose();
				}
			},null,true);
		});
	}
</script>
	
<div>
	<table class="xllist" style="width: 100%">
		<tr>
			<th colspan="6" style="text-align: left;padding-left: 20px;" onclick="slideToggle('book');">
				著作
				<c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
					<a style="float: right; padding-right: 10px;" href="javascript:addBook()">[新增]</a>
				</c:if>
			</th>
		</tr>
		<tr>
            <th width="20%">著作名称</th>
			<th width="10%">出版日期</th>
			<th width="25%">出版单位</th>
			<th width="20%">著作类别</th>
			<th width="10%">出版地</th>
			<c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
				<th style="width: 100px;">操作</th>
			</c:if>
		</tr>
		<c:if test="${! empty bookList}">
		<tbody class="book">
		<c:forEach items="${bookList}" var="book">
			<tr>
				<td>${book.bookName}</td>
				<td>${book.publishDate}</td>
				<td>${book.publishOrg}</td>
				<td>${book.typeName}</td>
				<td>${book.pubPlaceName}</td>
				<c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
					<td style="width: 100px">
						[<a href="javascript:void(0)" onclick="editBook('${book.bookFlow}')">编辑</a>]
						[<a href="javascript:void(0)" onclick="delBook('${book.bookFlow}')">删除</a>]
					</td>
				</c:if>
			</tr>
		</c:forEach>
		</tbody>
		</c:if>
		<c:if test="${empty bookList}">
				<tr>
		             <td colspan="6">无记录</td>
				</tr>
		</c:if>
	</table>
</div>
	

		
