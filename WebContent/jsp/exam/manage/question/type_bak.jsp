<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="true"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="false"/>
	<jsp:param name="jquery_datePicker" value="false"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="false"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ztree" value="true"/>
</jsp:include>
<script type="text/javascript">
	function delQuestionSubject(questionFlow,subjectFlow){
		jboxConfirm("确认解除该关系吗？，请慎重操作！",function () {
			var url = "<s:url value='/exam/manage/subject/delQuestionSubject'/>?subjectFlow="+subjectFlow+"&questionFlow="+questionFlow;
			jboxGet(url,null,function(){
				//treeObj.reAsyncChildNodes(nodes[0].getParentNode(), "refresh");
				//treeObj.expandNode(nodes[0], true, true, true);
				window.parent.frames['mainIframe'].window.refreshParent();
				window.location.reload(true);
			});		
		});
	}
	function delQuestion(questionFlow){
		jboxConfirm("确认解除该题目吗？，请慎重操作！",function () {
			var url = "<s:url value='/exam/manage/question/del'/>?questionFlow="+questionFlow;
			jboxGet(url,null,function(){
				//treeObj.reAsyncChildNodes(nodes[0].getParentNode(), "refresh");
				//treeObj.expandNode(nodes[0], true, true, true);
				window.parent.frames['mainIframe'].window.refreshParent();
				window.location.reload(true);
			});		
		});
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		 <div class="title1 clearfix">
		 	<div style="width: 800px;float: left;height: 100%;">
		 		<table class="basic" style="width: 100%;height: 100%;">
			    	<tbody id="">
					<c:forEach items="${examQuestionList}" var="question" varStatus="status">
						<tr>
							<th style="text-align: left;" colspan="2">&#12288;序号：${status.index+1 }</th>
						</tr>
						<tr style="cursor: pointer;" width="100%">
							<td width="100px">题目类型</td>
							<td>
								${pdfn:getQuestTypeName( question.questionTypeId) }
							</td>
						</tr>
						<tr style="cursor: pointer;" width="100%" title="${question.questionContent }">
							<td width="100px">题目内容</td>
							<td>
								[<a href="javaScript:delQuestion('${question.questionFlow}')"><font color="red">删除题目</font></a>]
								${pdfn:cutString(question.questionContent,35,true,6)}
							</td>
						</tr>
						<tr style="cursor: pointer;" width="100%" title="${question.questionAnswer}">
							<td>题目答案</td>
							<td>
								${pdfn:cutString(question.questionAnswer,35,true,6)}
							</td>
						</tr>
						<tr style="cursor: pointer;" width="100%" title="${question.rightAnswer}">
							<td>正确答案</td>
							<td>
								${pdfn:cutString(question.rightAnswer,35,true,6)}
							</td>
						</tr>
						<tr style="cursor: pointer;" width="100%">
							<td>相关书目</td>
							<td>								
								<c:forEach items="${examBookMap[question.questionFlow]}" var="book" varStatus="status">
									${book.memo }<br>
								</c:forEach>
							</td>
						</tr>
						<tr style="cursor: pointer;" width="100%">
							<td>相关科目</td>
							<td>							
								<c:set var="subjectList" value="${examSubjectMap[question.questionFlow] }"></c:set>
								<c:forEach items="${examSubjectMap[question.questionFlow]}" var="subject" varStatus="status2">
									${subject.memo }&#12288;
									[<a href="javaScript:delQuestionSubject('${question.questionFlow}','${subject.subjectFlow}')"><font color="red">删除<b>${subject.bankTypeName }</b>关联关系</font></a>]
									<br>
								</c:forEach>
							</td>
						</tr>
					</c:forEach>
					</tbody>
					<c:if test="${examQuestionList == null || examQuestionList.size()==0 }">
						<tr>
							<td align="center" style="text-align: center;" colspan="2">无记录</td>
						</tr>
					</c:if>
				</table>
		 	</div>
	</div> 
</div>
</body>
</html>