<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/hbres/css/exam.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript">
function getInfo(userFlow){
	jboxOpen("<s:url value='/hbres/singup/manage/userInfo'/>?userFlow="+userFlow+"&isActive=","用户信息",1000,550);
}
function toPage(page) {
	if(page){
		$("#currentPage").val(page);			
	}
	search();
} 
function search(){
	var searchdata = {
	    "siteFlow":$("#siteCode").val(),
	    "ticketNum":$("#ticketNum").val(),
	    "key":$("#key").val(),
		"currentPage":$("#currentPage").val()
	};
	
	jboxPostLoad("content" ,"<s:url value='/hbres/singup/exam/users'/>" ,searchdata , true);
}
</script>
      <div class="main_hd">
        <h2>考试管理
        <span class="tips">当前考试：${sessionScope.currExam.examName}</span>
        </h2>
        <jsp:include page="./nvtab.jsp">
            <jsp:param value="4" name="tabIndex"/>
        </jsp:include>
      </div>
      
      <div class="main_bd" id="div_table_0" >
      <div class="div_search">
         <label >考点：</label>
         <select name="siteCode" id="siteCode" style="width:200px;" class="select" onchange="search();">
             <option value=''>请选择</option>
             <c:forEach items="${sites}" var='site'>
                 <option value="${site.recordFlow}" <c:if test='${param.siteFlow eq site.recordFlow}'>selected="selected"</c:if>>${site.siteName}</option>
             </c:forEach>
         </select>
         &nbsp;&nbsp;
         <label>准考证号：</label><input id="ticketNum" type="text" class="select" value="${param.ticketNum}" onblur="search();"/>
         &nbsp;&nbsp;
         <input type="text" id="key" name="key" value="${param.key}" placeholder="姓名/手机号/邮件/身份证" onblur="search();" class="select" style="width: 250px;"/>
         </div>
         <div class="search_table">
          <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <th style="text-align: left;padding-left: 40px;">姓名</th>
              <th style="text-align: left;padding-left: 20px;">准考证号</th>
              <th style="text-align: left;padding-left: 20px;">考场号</th>
              <th style="text-align: left;padding-left: 20px;">身份证号</th>
              <th style="text-align: left;padding-left: 20px;">毕业院校</th>
              <th>毕业专业</th>
              <th>报名信息</th>
            </tr>
            <c:forEach items="${examDoctorExts}" var="examDoctorExt">
            <tr>
              <td style="text-align: left;padding-left: 40px;">${examDoctorExt.doctor.doctorName}</td>
              <td style="text-align: left;padding-left: 20px;">${examDoctorExt.ticketNum}</td>
              <td style="text-align: left;padding-left: 20px;">${examDoctorExt.roomCode}</td>
              <td style="text-align: left;padding-left: 20px;">${examDoctorExt.user.idNo}</td>
              <td style="text-align: left;padding-left: 20px;">${examDoctorExt.doctor.graduatedName}</td>
              <td>
                  <c:forEach var="dict" items="${dictTypeEnumGraduateMajorList}">
              	      <c:if test='${examDoctorExt.doctor.specialized==dict.dictId}'>${dict.dictName}</c:if>
              	  </c:forEach>
              </td>
             
              <td><a class="btn" href="javascript:void(0);" onclick="getInfo('${examDoctorExt.doctorFlow}');">详细</a></td>
            </tr>
            </c:forEach>
          </table>
        </div>
         <div class="page" style="padding-right: 40px;">
       	 <input id="currentPage" type="hidden" name="currentPage" />
           <c:set var="pageView" value="${pdfn:getPageView(examDoctorExts)}" scope="request"></c:set>
	  		 <pd:pagination-hbres toPage="toPage"/>	 
        </div>
      </div>
