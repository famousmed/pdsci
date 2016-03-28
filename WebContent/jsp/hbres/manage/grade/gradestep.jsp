<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
                <th>分数段</th>
                <th>人数</th>
            </tr>
            <tbody>
                <c:forEach items="${gradeSteps}" var="gradeStep">
                <tr>
                    <td>${gradeStep.startGrade} ~ ${gradeStep.endGrade}</td>
                    <td>${gradeStep.count}</td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
