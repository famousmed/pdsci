<script type="text/javascript">
</script>
    <div class="search_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
        	<colgroup>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        	</colgroup>
            <tr>
                <th>姓名</th>
                <th>证件号</th>
                <th>性别</th>
                <th>联系方式</th>
                <th>培训类别</th>
                <th>培训专业</th>
                <th>届别</th>
                <th>培养年限</th>
                <th>详情</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${recruitList}" var="doctorRecruit">
	             <tr>
	                <td>${doctorRecruit.sysUser.userName}</td>
	                <td>${doctorRecruit.sysUser.idNo}</td>
	                <td>${doctorRecruit.sysUser.sexName}</td>
	                <td>${doctorRecruit.sysUser.userPhone}</td>
	                <td>${doctorRecruit.catSpeName}</td>
	                <td>${doctorRecruit.speName}</td>
	                <td>${doctorRecruit.sessionNumber}</td>
	                <td>${doctorRecruit.trainYear}</td>
	                <td><a class="btn" onclick="getInfo('${doctorRecruit.doctorFlow}');">详情</a></td>
	                <td><a class="btn" onclick="editDoctorTrend('${doctorRecruit.doctorFlow}','${doctorRecruit.recruitFlow}');">更新</a></td>
	            </tr>
            </c:forEach>
             <c:if test="${empty recruitList}">
				<tr>
					<td colspan="10" >无记录！</td>
				</tr>
      	  	</c:if>
        </table>
        
    </div>
    <div class="page" style="padding-right: 40px;">
		<c:set var="pageView" value="${pdfn:getPageView(recruitList)}" scope="request"></c:set>
		<pd:pagination-hbres toPage="toPage"/>	 
	</div>
</div>
      
