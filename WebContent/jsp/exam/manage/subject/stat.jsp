<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<script>
function viewBySubjectQuestionTypeId(questionTypeId){
	var treeObj = $.fn.zTree.getZTreeObj("subjectTree");
	var nodes = treeObj.getSelectedNodes();
	if (nodes.length>0) {
		var id = nodes[0].id;
		var url ="<s:url value='/exam/manage/question/viewBySubjectQuestionTypeId'/>?subjectFlow="+id+"&questionTypeId="+questionTypeId;
		jboxOpen(url ,"题目", 1000 , 700);
	}
}
function viewBySubjectSubject(subjectFlow2){
	var treeObj = $.fn.zTree.getZTreeObj("subjectTree");
	var nodes = treeObj.getSelectedNodes();
	if (nodes.length>0) {
		var id = nodes[0].id;
		var url ="<s:url value='/exam/manage/question/viewBySubjectSubject'/>?subjectFlow="+id+"&subjectFlow2="+subjectFlow2;
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
function viewBySubjectBook(bookFlow){
	var treeObj = $.fn.zTree.getZTreeObj("subjectTree");
	var nodes = treeObj.getSelectedNodes();
	if (nodes.length>0) {
		var id = nodes[0].id;
		var url ="<s:url value='/exam/manage/question/viewBySubjectBook'/>?subjectFlow="+id+"&bookFlow="+bookFlow;
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
// 和从书中删科目方法一样
function delSubject(bookFlow , subjectFlow){
	jboxConfirm("确认删除吗？" , function(){
		var url ="<s:url value='/exam/manage/book/delBookAndSubjectRelation'/>?bookFlow="+bookFlow+"&subjectFlow="+subjectFlow;
		jboxGet(url , null , function(){
			refreshStat();
			refreshParent();
		} , null , true);
	});
	
}
</script>
<div id="rightDiv2" style="float:none;">
	${subject.memo } 包含子科目共对应${countForTree }条题目
</div>
<table class="basic" style="width: 100%;height: 100%;">
	<tr>
		<th style="text-align: left;" colspan="2">&#12288;&#12288;题型分布</th>
	</tr>
   		<c:forEach items="${questionTypeCountMapList}" var="questionTypeCountMap" varStatus="status">
		<tr style="cursor: pointer;" onclick="viewBySubjectQuestionTypeId('${questionTypeCountMap.questionTypeId}');"> 
			<td width="70%">
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
		<th style="text-align: left;" colspan="3">&#12288;&#12288;书目分布</th>
	</tr>
   		<c:forEach items="${bookCountMapList}" var="bookCountMap" varStatus="status">
		<tr style="cursor: pointer;"> 
			<td width="70%" onclick="viewBySubjectBook('${bookCountMap.bookFlow}')">
				[${examBookMap[bookCountMap.bookFlow].bookNum}]${examBookMap[bookCountMap.bookFlow].memo}
			</td>
			<td>
				${bookCountMap.totalNum}
			</td>
			<td>
	            <a href="javascript:void(0);" onclick="delSubject('${bookCountMap.bookFlow}' , '${subject.subjectFlow}');">[从<b>${sessionScope.examBankTypeName}</b>删除]</a>
	        </td>
		</tr>			
		</c:forEach>		
	<c:if test="${bookCountMapList == null || bookCountMapList.size()==0 }">
		<tr>
			<td align="center" style="text-align: center;" colspan="2">无记录</td>
		</tr>
	</c:if>
</table>
<br>
<table class="basic" style="width: 100%;height: 100%;">
	<tr>
		<th style="text-align: left;" colspan="2">&#12288;&#12288;科目分布</th>
	</tr>
   		<c:forEach items="${subjectCountMapList}" var="subjectCountMap" varStatus="status">
		<tr style="cursor: pointer;" onclick="viewBySubjectSubject('${subjectCountMap.subjectFlow}');"> 
			<td width="70%">
				${examSubjectMap[subjectCountMap.subjectFlow].memo}
			</td>
			<td>
				${subjectCountMap.totalNum}
			</td>
		</tr>			
		</c:forEach>		
	<c:if test="${subjectCountMapList == null || subjectCountMapList.size()==0 }">
		<tr>
			<td align="center" style="text-align: center;" colspan="2">无记录</td>
		</tr>
	</c:if>
</table>