<jsp:include page="/jsp/sczyres/htmlhead-sczyres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	function getInfo(userFlow){
		jboxOpen("<s:url value='/sczyres/doctor/getsingupinfofordialog'/>?userFlow="+userFlow,"用户信息",1000,550);
	}
</script>
<div class="main_bd" id="div_table_0" > 
   <div class="main_hd">
       <h2>协同基地</h2>
       <div class="title_tab" id="toptab">
          <ul>
            <li class="${param.status=='Y' || empty param.status?'tab_select':tab}" id="Y" onclick="searchDoctorForStatus(this);"><a>已录取</a></li>
            <li class="${param.status=='N'?'tab_select':tab}" id="N" onclick="searchDoctorForStatus(this);"><a>未录取</a></li>
            <li class="${param.status=='F'?'tab_select':tab}" id="F" onclick="searchDoctorForStatus(this);"><a>报名名单</a></li>
          </ul>
       </div>
	   
	   <div class="div_search" style="text-align:right;">
	       <form id="searchForm">
			<input type="text" id="key" style="width: 200px;" name="key" value="${param.key}" class="input" placeholder="姓名/手机号/邮件/身份证" 
			onchange="searchDoctor();"
			/>
			<input type="hidden" name="status" id="status" value='${param.status}'/>
		    </form>
		</div>
   </div>
   <div class="search_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <th style=" text-align:left; padding-left:5px;">姓名</th>
              <th>身份证号</th>
              <th>毕业专业</th>
              <th>类型</th>
              <th>人员信息</th>
              <th>状态</th>
            </tr>
            <c:forEach items="${userList}" var="doctor">
            <tr>
              <td  style=" text-align:left; padding-left:5px;">${doctor.doctorName}</td>
              <td>${doctor.sysUser.idNo}</td>
              <td>${doctor.specialized}</td>
              <td>${doctor.doctorTypeName}</td>
              <td><a class="btn" onclick="getInfo('${doctor.doctorFlow}');">详情</a></td>
              <td>
                  <c:if test='${regStatusEnumPassing.id eq doctor.doctorStatusId}'>待审核</c:if>
                  <c:if test='${regStatusEnumPassed.id eq doctor.doctorStatusId}'>审核通过</c:if>
                  <c:if test='${regStatusEnumUnPassed.id eq doctor.doctorStatusId}'>审核不通过</c:if>
              </td>
            </tr>
            </c:forEach>
          </table>
    </div>

</div>
