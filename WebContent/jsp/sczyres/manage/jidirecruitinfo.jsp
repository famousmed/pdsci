<script>
    function getOrgRecruit(){
    	var data = {"orgFlow":$("#orgFlow").val() , "speId":$("#speId").val()};
    	jboxPostLoad("content" , "<s:url value='/sczyres/manage/showRecruit'/>" , data , true);
    }
</script>
<div class="main_hd">
    <h2 class="underline">
        <span>基地录取情况表</span>
    </h2>
	<div class="div_search">
        <form id="searchForm">
        <b>基地:</b>
            <select id="orgFlow" name="orgFlow" class="select" onchange="getOrgRecruit();">
    	        <option value=''>请选择</option>
	            <c:forEach items="${hospitals}" var="hospital">
	                <option value='${hospital.orgFlow}' <c:if test='${param.orgFlow eq hospital.orgFlow}'>selected="selected"</c:if>>${hospital.orgName}</option>
	            </c:forEach>
   		</select>
   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   		<b>专业名称:</b>
   		<select id="speId" name="speId" class="select" onchange="getOrgRecruit();">
	        <option value=''>请选择</option>
	        <c:forEach items="${spes}" var="spe">
	            <option value='${spe.dictId}' <c:if test='${param.speId eq spe.dictId}'>selected="selected"</c:if>>${spe.dictName}</option>
	        </c:forEach>
	    </select>
        </form>
   	</div> 
</div>
<div class="search_table">
    <c:if test='${!empty param.orgFlow and empty param.speId}'>
    <table border="0" cellspacing="0" cellpadding="0" class="grid">
        <tr>
            <th style="width: 300px;">专业名称</th>
            <th>已录取数</th>
    	</tr>
    	<c:forEach items="${spes}" var="spe">
            <tr>
      			<td>${spe.dictName}</td>
      		    <td>${countResultMap[spe.dictId]}</td>
   	       </tr>
        </c:forEach>
    </table>
    </c:if>
    
    <c:if test='${empty param.orgFlow and !empty param.speId}'>
    <table border="0" cellspacing="0" cellpadding="0" class="grid">
        <tr>
            <th style="width: 300px;">基地名称</th>
            <th>已录取数</th>
    	</tr>
    	<c:forEach items="${hospitals}" var="org">
            <tr>
      			<td>${org.orgName}</td>
      		    <td>${countResultMap[org.orgFlow]}</td>
   	       </tr>
        </c:forEach>
    </table>
    </c:if>
    
    <c:if test='${!empty param.orgFlow and !empty param.speId}'>
    <table border="0" cellspacing="0" cellpadding="0" class="grid">
        <tr>
            <th style="width: 300px;">专业名称</th>
            <th>已录取数</th>
    	</tr>
            <tr>
                <td>
                    <c:forEach items="${spes}" var="spe">
                        <c:if test='${param.speId eq spe.dictId}'>${spe.dictName}</c:if>
                    </c:forEach>
                </td>
      			<td>${recruitCount}</td>
   	        </tr>
    </table>
    </c:if>
</div> 
    	

















