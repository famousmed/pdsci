<script type="text/javascript">
</script>
<div class="main_hd">
    <form id="recruitResultForm">
		<h2 class="underline">住培注册学员统计表&#12288;&#12288;
			基地：
			<c:choose>
			<c:when test="${GlobalConstant.USER_LIST_LOCAL eq param.source }">
			 	${sessionScope.currUser.orgName}
			</c:when>
			<c:otherwise>
				<select class="select" name="orgFlow" onchange="registerStatistics();" >
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
                <th>专业代码</th>
                <th>专业基地名称</th>
                <th>招收人数</th>
            </tr>
            <c:forEach var="dict" items="${dictTypeEnumDoctorTrainingSpeList}">
            <tr>
                <td>${dict.dictId}</td>
                <td>${dict.dictName}</td>
                <td>${doctorRecruitFormMap[dict.dictId]==null?'0':doctorRecruitFormMap[dict.dictId]}</td>
            </tr>
        	</c:forEach>
        </table>
    </div>
</div>
      
