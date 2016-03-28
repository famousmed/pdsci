<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	function doBack(){
		jboxLoad("content","<s:url value='/cnres/singup/hospital/main'/>?liId=lqjg",true);
	}
	function searchRecruitUser(){
		confirmUserList("${param.speId}","${param.assignPlan}","${param.recruitCount}","${param.confirmCount}",$("#key").val());
	}
</script>
   <div class="main_hd">
   	<div>
		<h2 style="padding-left: 40px;">
			当前专业：${speName}&#12288;
			计划招录人数：${empty param.assignPlan?'0':param.assignPlan}&#12288;
			预录取人数：${empty param.recruitCount?'0':param.recruitCount}&#12288;
			确认录取人数：<span style="color: red;">${empty param.confirmCount?'0':param.confirmCount}</span>
			&#12288;&#12288;<a onclick="doBack();" style="color: #459ae9;">返回</a>
			<input type="hidden" id="assignPlan" value="${assignPlan}">  
		</h2>
		<br/>
		<span style="float: right;">
        	<input type="text" id="key" name="key" value="${param.key}" style="width:200px;" class="input" placeholder="姓名/手机号/邮件/身份证" onblur="searchRecruitUser();"/>
		</span>
   </div>
   <div class="div_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <th><input type="checkbox" id="allChecked" onclick="checkAll(this)" title="全选"></th>
              <th>排名</th>
              <th>姓名</th>
              <th>身份证号</th>
              <th>类型</th>
              <th>总成绩</th>
              <th>人员信息</th>
              <th>是否调剂</th>
              <th>是否确认录取</th>
            </tr>
            <c:forEach items="${doctorRecruitExts }" var="doctorExt" varStatus="status">
            <tr>
              <td>
              	<input type="checkbox" id="doctor_${doctorExt.doctorFlow}" name="doctorFlow" value="${doctorExt.doctorFlow}" 
              	${GlobalConstant.FLAG_Y eq doctorExt.recruitFlag?'disabled':'' }>
              </td>
              <td>${status.index+1}</td>
              <td>${doctorExt.doctor.doctorName}</td>
              <td>${doctorExt.sysUser.idNo}</td>
              <td>${doctorExt.doctor.doctorTypeName}</td>
              <td>${doctorExt.totleResult}</td>
              <td><a class="btn" onclick="getInfo('${doctorExt.doctorFlow}');">详情</a></td>
              <td>
				  <c:if test="${(GlobalConstant.FLAG_Y == doctorExt.swapFlag) and (doctorExt.swapSpeId==param.speId)}">是</c:if>
              </td>
              <td>
	              <c:if test="${GlobalConstant.FLAG_Y == doctorExt.confirmFlag}">
	              	 <a class="btn">已确认</a>
	              </c:if>
              </td>
            </tr>
            </c:forEach>
          </table>
    </div>
   </div>
