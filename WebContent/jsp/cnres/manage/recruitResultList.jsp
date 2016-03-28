<script type="text/javascript">
	function toPage(currentPage) {
		if(!currentPage){
			currentPage = 1;
		}
		recruitResultList(currentPage);
	} 
</script>
<style>
</style>
<div class="main_hd">
    <form id="recruitResultForm">
		<h2 class="underline">录取考试成绩排序表&#12288;&#12288;
			基地：
			<c:choose>
			<c:when test="${GlobalConstant.USER_LIST_LOCAL eq param.source }">
			 	${sessionScope.currUser.orgName}
			</c:when>
			<c:otherwise>
				<select class="select" name="orgFlow" onchange="recruitResultList();">
				    <option value="">请选择</option>
					    <c:forEach var="org" items="${orgList}">
							<option value="${org.orgFlow}" <c:if test='${org.orgFlow == param.orgFlow}'>selected="selected"</c:if>>${org.orgName}</option>
						</c:forEach>
				</select>
			</c:otherwise>
			</c:choose>
		</h2> 
	</form>
</div>
<div class="main_bd" id="div_table_0" >
    <div class="div_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
                <th style="text-align: left;padding-left: 40px;">名次</th>
                <th style="text-align: left;padding-left: 40px;">姓名</th>
                <th style="text-align: left;padding-left: 40px;">身份证号</th>
                <th style="text-align: left;padding-left: 40px;">笔试</th>
                <th style="text-align: left;padding-left: 40px;">技能考试</th>
                <th style="text-align: left;padding-left: 40px;">面试</th>
                <th style="text-align: left;padding-left: 40px;">总成绩</th>
            </tr>
            <c:forEach items="${doctorRecruitExtList}" var="doctorRecruitExt" varStatus="status">
            <tr>
                <td>
                	<c:set var="rank" value="${(param.currentPage-1)*10}"/>
                	${rank + status.count}
                </td>
                <td>${doctorRecruitExt.sysUser.userName}</td>
                <td>${doctorRecruitExt.sysUser.idNo}</td>
                <td>${doctorRecruitExt.examResult==null?'——':doctorRecruitExt.examResult}</td>
                <td>${doctorRecruitExt.operResult==null?'——':doctorRecruitExt.operResult}</td>
                <td>${doctorRecruitExt.auditionResult==null?'——':doctorRecruitExt.auditionResult}</td>
                <td>${doctorRecruitExt.totleResult==null?'——':doctorRecruitExt.totleResult}</td>
            </tr>
            </c:forEach>
            <c:if test="${empty doctorRecruitExtList}">
            <tr>
                <td colspan="7">无记录</td>
            </tr>
            </c:if>
        </table>
    </div>
   <div class="page" style="padding-right: 40px;">
        <input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage}"/>
        <c:set var="pageView" value="${pdfn:getPageView(doctorRecruitExtList)}" scope="request"></c:set>
	  	<pd:pagination-cnres toPage="toPage"/>	 
    </div>
</div>
      
