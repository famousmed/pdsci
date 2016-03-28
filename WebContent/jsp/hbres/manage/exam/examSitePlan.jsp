<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
	<jsp:param name="font" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/hbres/css/exam.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript">
function addExamSite(){
	var url = "<s:url value='/hbres/singup/exam/addExamSite'/>";
	jboxOpen(url, "选择考点",500, 500);
}

function addColleges(recordFlow){
	var url = "<s:url value='/hbres/singup/exam/addColleges'/>?recordFlow=" + recordFlow;
	jboxOpen(url, "选择考点涵盖的毕业院校",500, 500);
}

</script>

<div class="main_hd">
  <h2>考试管理
  <span class="tips">当前考试：${sessionScope.currExam.examName}</span>
  </h2>
  <jsp:include page="./nvtab.jsp">
      <jsp:param value="1" name="tabIndex"/>
  </jsp:include>
</div>

<div class="main_bd" id="div_table_0">
    <c:if test='${sessionScope.currExam.examStatusId eq examStatusEnumArrange.id}'>
   	<input class="btn_green" type="button" value="选择考点" onclick="addExamSite();" style="float: right;margin: 5px 50px 5px auto;"/>
   	</c:if>
    <div class="div_table">
    	<form id="examSiteForm">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
        	<colgroup>
				<col width="8%"/>
				<col width="25%"/>
				<col width="25%"/>
				<col width="10%"/>
				<col width="20%"/>
				<col width="12%"/>
			</colgroup>
            <tr>
                <th>考点代码</th>
                <th>考点名称</th>
                <th>考点地址</th>
                <th>涵盖年份</th>
                <th style="text-align: left;">涵盖毕业院校</th>
                <c:if test='${sessionScope.currExam.examStatusId eq examStatusEnumArrange.id}'>
                <th></th>
                </c:if>
            </tr>
            <c:forEach items="${examSiteList}" var="examSite">
            <tr>
                <td>
                	${examSite.siteCode}
                	<input type="hidden" name="siteCode" value="${examSite.siteCode}"/>
                </td>
                <td>${examSite.siteName}</td>
                <td>${examSite.siteAddress}</td>
                <td>${examSite.coverYear}</td>
                <td id="td_${examSite.recordFlow}" style="text-align: left;">
             		<c:forEach var="college" items="${examSiteCollegesMap[examSite.siteCode]}" varStatus="status">
		    			<c:forEach var="dict" items="${dictTypeEnumGraduateSchoolList}">
							<c:if test="${college eq dict.dictId}">
								<input type='hidden' name='college' value="${dict.dictId}">
		    					${dict.dictName}<br/>
							</c:if>
					    </c:forEach>
						<c:if test="${college == '00'}">
							<input type='hidden' name='college' value="00">
							其它<br/>
						</c:if>
				    </c:forEach>
                </td>
                <c:if test='${sessionScope.currExam.examStatusId eq examStatusEnumArrange.id}'>
                <td>
                	<a class="btn" href="javascript:addColleges('${examSite.recordFlow}');">添加院校</a>
                </td>
                </c:if>
            </tr>
            </c:forEach>
            <c:if test="${empty examSiteList}">
            	<tr>
	                <td colspan="7">无记录</td>
	            </tr>
            </c:if>
        </table>
        </form>
    </div>
</div>
      
