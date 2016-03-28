<script type="text/javascript">
	function toPage(currentPage) {
		if(!currentPage){
			currentPage = 1;
		}
		registerList(currentPage);
	} 
</script>
<style>
</style>
<div class="main_hd">
    <form id="recruitResultForm">
		<h2 class="underline">住培学员注册登记表&#12288;&#12288;
			基地：
			<c:choose>
			<c:when test="${GlobalConstant.USER_LIST_LOCAL eq param.source }">
				 ${sessionScope.currUser.orgName}
			</c:when>
			<c:otherwise>
				<select class="select" name="orgFlow" onchange="registerList();">
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
        <table border="0" cellpadding="0" cellspacing="0" class="grid" style="width: 100%">
            <tr>
                <th>序号</th>
                <th>专业基地<br/>代码</th>
                <th>姓名</th>
                <th>性别</th>
                <th>年龄</th>
                <th>毕业院校</th>
                <th>学历</th>
                <th>专业</th>
                <th>人员类型</th>
                <th>是/否有医<br/>师资格证</th>
                <!-- <th>责任指<br/>导医师</th> -->
            </tr>
            <c:forEach items="${doctorExtList}" var="doctorExt" varStatus="status">
            <tr>
                <td>${status.count}</td>
                <td>${doctorExt.doctorRecruit.speId}</td>
                <td><span title="身份证号：${doctorExt.sysUser.idNo}">${doctorExt.sysUser.userName}</span></td>
                <td>${doctorExt.sysUser.sexName}</td>
                <td>${pdfn:calculateAge(doctorExt.sysUser.userBirthday)}</td>
                <td><span title="毕业时间：${doctorExt.graduationTime}">${doctorExt.graduatedName}</span></td>
                <td>${doctorExt.deptName}</td>
                <td>${doctorExt.specialized}</td>
                <td>
                	<c:if test="${doctorExt.doctorTypeId == recDocTypeEnumAgency.id}"><span title="委培单位：${doctorExt.workOrgName}">委培人</span></c:if>
                	<c:if test="${doctorExt.doctorTypeId == recDocTypeEnumIndustry.id}">${recDocTypeEnumIndustry.name}</c:if>
                </td>
                <td><span title="医师资格证号：${doctorExt.qualifiedNo}">${doctorExt.qualifiedNo==null?'无':'有'}</span></td>
            </tr>
            </c:forEach>
            <c:if test="${empty doctorExtList}">
            <tr>
                <td colspan="10">无记录</td>
            </tr>
            </c:if>
        </table>
        <div class="page" style="padding-right: 40px;">
        <input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage}"/>
        <c:set var="pageView" value="${pdfn:getPageView(doctorExtList)}" scope="request"></c:set>
	  	<pd:pagination-cnres toPage="toPage"/>	 
    </div>
    </div>
    
</div>
      
