<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<table class="basic" style="width: 100%;height: 100%;">
    <thead>
        <tr style="background-color: #e3e3e3;">
            <th colspan="2" style="text-align: center;"> <h2>${pdfn:getQuestTypeName(param.questionTypeId)}</h2></th>
        </tr>
    </thead>
    <tbody id="">
	    <c:forEach items="${examQuestionList}" var="question" varStatus="status">
	        <tr style="background-color:#fffdf5;">
	            <td>
	                <p style="float: left;">${status.index+1}.</p>
	                <ul style="margin-left: 20px;">
	                    <c:set var='content' value='${fn:replace(question.questionContent , "manager/" , "/manager/")}'/>
	                    <c:set var="questionAnswers" value="${pdfn:parseQuestionAnswer(content)}"></c:set>
	                    <c:forEach items="${questionAnswers}" var="answer" varStatus="seltatus">
				            <li>${answer}</li>
				        </c:forEach>
	                </ul>
	                
	            </td>
	        </tr>
	        <!-- 子题 -->
	        <c:forEach items="${question.questionDetails}" var="subQuestion" varStatus="subStatus">
	            <tr>
	            <td>
	                <p>(${subStatus.index+1}).<span>${fn:replace(subQuestion.questionContent , "manager/" , "/manager/")}</span></p>
	                <c:forEach items="${pdfn:getSelection(questionAnswers.size())}" var="selection">
	                    <input type="checkbox" value="${selection}"/>${selection}<br/>
	                </c:forEach>
				    &nbsp;&nbsp;<span style="color: green;">正确答案：${fn:replace(subQuestion.rightAnswer , "manager/" , "/manager/")}</span>
	            </td>
	            </tr>
	        </c:forEach>
	        
		</c:forEach>
	</tbody>
	<c:if test="${examQuestionList == null || examQuestionList.size()==0 }">
	    <tr>
	        <td align="center" style="text-align: center;" colspan="2">无记录</td>
	    </tr>
	</c:if>
</table>