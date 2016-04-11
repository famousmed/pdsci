<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<script>
function viewByBookQuestionTypeId(questionTypeId){
	var treeObj = $.fn.zTree.getZTreeObj("bookTree");
	var nodes = treeObj.getSelectedNodes();
	if (nodes.length>0) {
		var id = nodes[0].id;
		var url ="<s:url value='/exam/manage/question/viewByBookQuestionTypeId'/>?bookFlow="+id+"&questionTypeId="+questionTypeId;
		jboxOpen(url ,"题目", 1000 , 700);
	}
}
function viewByBookSubject(subjectFlow){
	var treeObj = $.fn.zTree.getZTreeObj("bookTree");
	var nodes = treeObj.getSelectedNodes();
	if (nodes.length>0) {
		var id = nodes[0].id;
		var url ="<s:url value='/exam/manage/question/viewByBookSubject'/>?bookFlow="+id+"&subjectFlow="+subjectFlow;
		var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='400px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
		jboxCloseMessager();
		var mainIframe = window.parent.frames["mainIframe"];
	    var width = mainIframe.document.body.scrollWidth-5;
	    var height = mainIframe.document.body.scrollHeight/2;
	    jboxStartLoading();
		jboxMessager(iframe,'题目查看',width,height);		
		jboxEndLoading();
	}
}
function viewByBookBook(bookFlow2){
	var treeObj = $.fn.zTree.getZTreeObj("bookTree");
	var nodes = treeObj.getSelectedNodes();
	if (nodes.length>0) {
		var id = nodes[0].id;
		var url ="<s:url value='/exam/manage/question/viewByBookBook'/>?bookFlow="+id+"&bookFlow2="+bookFlow2;
		var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='400px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
		jboxCloseMessager();
		var mainIframe = window.parent.frames["mainIframe"];
	    var width = mainIframe.document.body.scrollWidth-5;
	    var height = mainIframe.document.body.scrollHeight/2;
	    jboxStartLoading();
		jboxMessager(iframe,'题目查看',width,height);		
		jboxEndLoading();
	}
}
function delSubject(bookFlow , subjectFlow){
	jboxConfirm("确认删除吗？" , function(){
		var url ="<s:url value='/exam/manage/book/delBookAndSubjectRelation'/>?bookFlow="+bookFlow+"&subjectFlow="+subjectFlow;
		jboxGet(url , null , function(){
			refreshStat();
			refreshParent();
		} , null , true);
	});
	
}
function reBind(bookFlow , subjectFlow){
	jboxOpen("<s:url value='/exam/manage/book/rebindsubject'/>?bookFlow="+bookFlow+"&subjectFlow="+subjectFlow ,"重新绑定科目", 900, 500);
}

function addBindSubject(bookFlow){
	jboxOpen("<s:url value='/exam/manage/book/rebindsubject'/>?bookFlow="+bookFlow ,"新增绑定科目", 900, 500);
}

</script>
<div id="rightDiv2" style="float:none;">
	${book.memo } 包含子书目共对应${countForTree }条题目
</div>
<table class="basic" style="width: 100%;height: 100%;">
	<tr>
		<th style="text-align: left;" colspan="2">&#12288;&#12288;题型分布</th>
	</tr>
   		<c:forEach items="${questionTypeCountMapList}" var="questionTypeCountMap" varStatus="status">
		<tr style="cursor: pointer;" onclick="viewByBookQuestionTypeId('${questionTypeCountMap.questionTypeId}');"> 
			<td>
				${pdfn:getQuestTypeName( questionTypeCountMap.questionTypeId) }
			</td>
			<td>
				[${questionTypeCountMap.totalNum }]
			</td>
		</tr>			
		</c:forEach>		
	<c:if test="${questionTypeCountMapList == null || questionTypeCountMapList.size()==0 }">
		<tr>
			<td align="center" style="text-align: center;" colspan="2">无记录</td>
		</tr>
	</c:if>
</table>
<br>
<table class="basic" style="width: 100%;height: 100%;">
	<tr>
		<th style="text-align: left;" colspan="2">&#12288;&#12288;科目分布&nbsp;&nbsp;<a href="javascript:void(0);" onclick="addBindSubject('${book.bookFlow}');">[新增绑定]</a></th>
		<th style="text-align: left;">&#12288;&#12288;操作</th>
	</tr>
	<!-- 
   		<c:forEach items="${subjectCountMapList}" var="subjectCountMap" varStatus="status">
		<tr> 
			<td>
				${examSubjectMap[subjectCountMap.subjectFlow].memo}
			</td>
			<td style="cursor: pointer;" onclick="viewByBookSubject('${subjectCountMap.subjectFlow}');">
				${subjectCountMap.totalNum}
			</td>
			<td>
				<a href="javascript:void(0);" onclick="delSubject('${book.bookFlow}' , '${subjectCountMap.subjectFlow}');">[删除]</a>
				&nbsp;&nbsp;&nbsp;
			</td>
		</tr>			
		</c:forEach> -->
		<c:forEach items='${examSubjectList}' var='subject'>
		    <tr>
		        <td>${subject.memo}</td>
		        <td></td>
		        <td>
		            <a href="javascript:void(0);" onclick="delSubject('${book.bookFlow}' , '${subject.subjectFlow}');">[从<b>${subject.bankTypeName}</b>删除]</a>
		        </td>
		    </tr>
		</c:forEach>		
	<c:if test="${examSubjectList == null || examSubjectList.size()==0 }">
		<tr>
			<td align="center" style="text-align: center;" colspan="3">无记录</td>
		</tr>
	</c:if>
</table>
<br>
<table class="basic" style="width: 100%;height: 100%;">
	<tr>
		<th style="text-align: left;" colspan="2">&#12288;&#12288;书目分布</th>
	</tr>
   		<c:forEach items="${bookCountMapList}" var="bookCountMap" varStatus="status">
		<tr style="cursor: pointer;" onclick="viewByBookBook('${bookCountMap.bookFlow}');"> 
			<td>
				${examBookMap[bookCountMap.bookFlow].memo}
			</td>
			<td width="40px;">
				${bookCountMap.totalNum}
			</td>
		</tr>			
		</c:forEach>		
	<c:if test="${bookCountMapList == null || bookCountMapList.size()==0 }">
		<tr>
			<td align="center" style="text-align: center;" colspan="2">无记录</td>
		</tr>
	</c:if>
</table>