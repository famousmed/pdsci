<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script>
function getgradestep(examFlow , speId , obj){
	var gradeStep = $(obj).val();
	var f_x = parseFloat(gradeStep);
	if (isNaN(f_x) || f_x<0){
	   jboxTip("数值错误");
	   return false;
	}
	jboxPostLoad("grade_step_"+speId , "<s:url value='/cnres/grade/getgradestep'/>" , {"examFlow":examFlow , "speId":speId , "gradeStep":gradeStep});
}
</script>
        <c:forEach var="dict" items="${dictTypeEnumGraduateMajorList}">
            <div style="width: 45%;float: left;margin-left: 20px;">
                <p>${dict.dictName}
                    <span style="float: right;">分数间隔：
		                <c:choose>
		                    <c:when test='${gradeStepsMap[dict.dictId].gradeBorderline.publishFlag eq "Y"}'>
		                        ${gradeStepsMap[dict.dictId].gradeBorderline.gradeStep}
		                    </c:when>
		                    <c:otherwise>
		                        <input type="text" id="inp_step_${dict.dictId}" style="width: 50px;text-align: center;" onblur="getgradestep('${currExam.examFlow}' , '${dict.dictId}' , this);" value="<c:if test='${gradeStepsMap[dict.dictId].gradeBorderline == null}'>5</c:if>${gradeStepsMap[dict.dictId].gradeBorderline.gradeStep}"/>
		                    </c:otherwise>
		                </c:choose>
	                </span>
	            </p>
                <div id="grade_step_${dict.dictId}">
                    <table border="0" cellpadding="0" cellspacing="0" class="grid">
			            <tr>
			                <th>分数段</th>
			                <th>人数</th>
			            </tr>
			            <tbody>
			                <c:forEach items="${gradeStepsMap[dict.dictId].gradeSteps}" var="gradeStep">
			                <tr>
			                    <td>${gradeStep.startGrade} ~ ${gradeStep.endGrade}</td>
			                    <td>${gradeStep.count}</td>
			                </tr>
			                </c:forEach>
			            </tbody>
			        </table>
                </div>
            </div>
       </c:forEach>
