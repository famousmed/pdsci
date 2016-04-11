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
	            <td>${status.index+1}.<span>${fn:replace(question.questionContent , "manager/" , "/manager/")}</span></td>
	        </tr>
	        <!-- 子题 -->
	        
	        <c:forEach items="${question.questionDetails}" var="subQuestion" varStatus="subStatus">
	            <tr>
	            <td>
	                <p>(${subStatus.index+1}).<span>${fn:replace(subQuestion.questionContent , "manager/" , "/manager/")}</span></p>
	                <c:forEach items="${pdfn:parseQuestionAnswer(subQuestion.questionAnswer)}" var="answer">
				        <input type="radio" name="${subQuestion.detailFlow}"/>${fn:replace(answer , "manager/" , "/manager/")}<br/>
				    </c:forEach>
				    <span style="color: green;">正确答案：${subQuestion.rightAnswer}</span>
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