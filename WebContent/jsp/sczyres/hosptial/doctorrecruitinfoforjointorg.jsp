<jsp:include page="/jsp/sczyres/htmlhead-sczyres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	
	function getInfo(doctorFlow){
		jboxOpen("<s:url value='/sczyres/doctor/getsingupinfofordialog'/>?userFlow="+doctorFlow,"人员信息",1000,550);
	}
	
	function searchDoctorForStatus(obj){
		var status = $(obj).attr('id');
		$("#status").val(status);
		searchDoctor();
	}
	
	function searchDoctor(){
		var data = $("#searchForm").serialize();
		jboxPostLoad("content","<s:url value='/sczyres/hosptial/recruitDoctorForJointOrg'/>",data ,true);
	}
	
	//成绩录入
	function gradeEdit(recruitFlow){
		jboxOpen("<s:url value='/sczyres/hosptial/gradeedit'/>?recruitFlow="+recruitFlow , "成绩录入" , 400 , 200);
	}
	
	//是否录取操作
	function admitOper(recruitFlow , admitFlag){
		if("Y"==admitFlag){
			jboxOpen("<s:url value='/sczyres/hosptial/openAdmitPage?recruitFlow='/>"+recruitFlow , "录取通知",1000,500);
		}
		if("N"==admitFlag){
			jboxConfirm("确认 不录取?" , function(){
				jboxPost('<s:url value="/sczyres/hosptial/notrecruit"/>' , {"recruitFlow":recruitFlow} , function(resp){
					if(resp=="1"){
						jboxTip("操作成功");
					}
					searchDoctor();
				} , null , false);
			});
		}
		
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
              <th>笔试成绩</th>
              <th>面试/技能<br/>成绩</th>
              <th>专业</th>
              <th>人员信息</th>
              <th>操作</th>
            </tr>
            <c:forEach items="${doctorRecruitExts }" var="doctorExt" varStatus="status">
            <tr>
              <td  style=" text-align:left; padding-left:5px;">${doctorExt.doctor.doctorName}</td>
              <td >${doctorExt.examResult}</td>
              <td ><a href='javascript:void(0);' onclick="gradeEdit('${doctorExt.recruitFlow}');" title="修改">${doctorExt.auditionResult}/${doctorExt.operResult}</a></td>
              <td >${doctorExt.speName}</td>
              <td ><a class="btn" onclick="getInfo('${doctorExt.doctorFlow}');">详情</a></td>
              <td id="operTd_${doctorExt.doctorFlow}">
                  <c:choose>
                      <c:when test="${doctorExt.recruitFlag eq 'Y'}">
                          <span>已录取</span>
                          <c:if test='${doctorExt.recruitTypeId eq recruitTypeEnumSwap.id}'>(调剂)</c:if>
                          <c:if test='${empty doctorExt.confirmFlag}'>(<font color='blue'>学员未确认</font>)</c:if>
                         <c:if test='${doctorExt.confirmFlag eq "Y"}'>(<font color='green'>学员已确认</font>)</c:if>
                         <c:if test='${doctorExt.confirmFlag eq "N"}'>(<font color='red'>学员已放弃</font>)</c:if>
                      </c:when>
                      <c:when test="${doctorExt.recruitFlag eq 'N'}">
                          <span>未录取</span>
                      </c:when>
                      <c:when test="${doctorExt.admitFlag eq 'Y' and empty doctorExt.recruitFlag}">
                          <a onclick="gradeEdit('${doctorExt.recruitFlow}');">录入成绩</a>
                          <a onclick='admitOper("${doctorExt.recruitFlow}" , "Y")'>录取</a>
                          <a onclick='admitOper("${doctorExt.recruitFlow}" , "N")'>不录取</a>
                      </c:when>
                  </c:choose>
              </td>
            </tr>
            </c:forEach>
          </table>
    </div>

</div>

