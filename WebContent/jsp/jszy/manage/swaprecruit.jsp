<jsp:include page="/jsp/jszy/htmlhead-jszy.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	
	function getInfo(doctorFlow){
		jboxOpen("<s:url value='/jszy/doctor/getsingupinfofordialog'/>?userFlow="+doctorFlow,"人员信息",1000,550);
	}
	
	function openSwapPage(doctorFlow , recruitFlow){
		jboxOpen("<s:url value='/jszy/manage/openSwapPage'/>?doctorFlow="+doctorFlow+"&recruitFlow="+recruitFlow,"调剂",1000,550);
	}
	function searchSwapDoctor(){
		var data = $("#searchForm").serialize();
		jboxPostLoad("content","<s:url value='/jszy/manage/swap'/>",data ,true);
	}
	
</script>
<div class="main_bd" id="div_table_0" > 
   <div class="main_hd">
       <h2 class="underline">学员调剂</h2>
	   <div class="div_search" style="text-align:right;">
	       <form id="searchForm">
			<input type="text" id="key" style="width: 200px;" name="key" value="${param.key}" class="input" placeholder="姓名/手机号/邮件/身份证" 
			onchange="searchSwapDoctor();"/>
		    </form>
		</div>
   </div>

   <div class="search_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <th style=" text-align:left; padding-left:5px;">姓名</th>
              <th>身份证号</th>
              <th>填报志愿</th>
              <th>调剂志愿</th>
              <th>人员信息</th>
              <th>操作</th>
            </tr>
            <c:forEach items="${doctorRecruitExts}" var="noRecruit">
                <tr>
                    <td>${noRecruit.sysUser.userName}</td>
                    <td>${noRecruit.sysUser.idNo}</td>
                    <td>${noRecruit.orgName}<br/>${noRecruit.catSpeName}-${noRecruit.speName}</td>
                    <td>
                        <c:set var="swapRecruit" value='${swapRecruitMap[noRecruit.doctorFlow]}'></c:set>
                        <c:if test='${empty swapRecruit}'>
                            <span>暂无调剂</span>
                        </c:if>
                        <c:if test='${!empty swapRecruit}'>
                            <span>${swapRecruit.orgName}<br/>${swapRecruit.catSpeName}-${swapRecruit.speName}</span>
                        </c:if>
                    </td>
                    <td><a class="btn" onclick="getInfo('${noRecruit.doctorFlow}');">详情</a></td>
                    <td>
                        <c:if test='${empty swapRecruit}'>
                            <a class="btn" onclick="openSwapPage('${noRecruit.doctorFlow}' , '${noRecruit.recruitFlow}');">调剂</a>
                        </c:if>
                        <c:if test='${!empty swapRecruit}'>
                            <span>
                                <c:if test="${ empty swapRecruit.confirmFlag}">未确认</c:if>
                                <c:if test="${ 'Y' eq swapRecruit.confirmFlag}">已确认</c:if>
                                <c:if test="${ 'N' eq swapRecruit.confirmFlag}">已拒绝</c:if>
                            </span>
                        </c:if>
                        </td>
                </tr>
            </c:forEach>
          </table>
    </div>
</div>
