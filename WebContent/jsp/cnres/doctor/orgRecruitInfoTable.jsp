<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>

 <div class="infoAudit" style="height:415px; padding:0 20px;">
<table class="grid">
    <thead>
        <tr>
            <th style="text-align:left;padding-left: 5px;">基地名称</th>
            <th style="text-align:left;">专业名称</th>
            <th style="text-align:left;">计划招录人数</th>
            <th style="text-align:left;">已录取人数</th>
            <th style="text-align:left;">剩余人数</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${orgRecruitInfos}" var="orgRecruitInfo">
            <tr>
                <td>${orgRecruitInfo.orgName}</td>
                <td>${orgRecruitInfo.speName}</td>
                <td>${orgRecruitInfo.planCount}</td>
                <td>${orgRecruitInfo.confirmCount}</td>
                <td>${orgRecruitInfo.surplusCount}</td>
            </tr>
        </c:forEach>
        <c:if test="${orgRecruitInfos.isEmpty()}">无招录记录</c:if>
    </tbody>
</table>
</div>
