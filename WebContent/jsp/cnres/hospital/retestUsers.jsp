<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	function toPage(page) {
		if(page!=undefined){
			$("#currentPage").val(page);			
		}
		searchRetestUser();
	}
	
	function getInfo(recruitFlow){
		jboxOpen("<s:url value='/cnres/singup/hospital/doctorInfo'/>?recruitFlow="+recruitFlow,"人员信息",1000,550);
	}
	
	function searchRetestUser(){
		retestUsers("${speId}","${assignPlan}",$("#currentPage").val(),$("#userName").val(),$("#graduatedId").val());
	}
	
	function noticeRetestMain(doctorFlow){
		jboxOpen("<s:url value='/cnres/singup/hospital/noticeRetestMain'/>?operType=single&speId=${speId}&doctorFlow="+doctorFlow,"复试通知",1000,500);
	}
	
	function doBack(){
		jboxLoad("content","<s:url value='/cnres/singup/hospital/main'/>?liId=fstz",true);
	}
</script>
<div class="main_bd" id="div_table_0" > 
   <div class="main_hd">
       <h2 style="line-height: 40px;padding-top: 10px;">
                        当前专业：${speName}&#12288;计划招录人数：${assignPlan}&#12288;通知复试人数：<span id="retestNum" style="color: red;">${retestNum}</span>
		  &#12288;&#12288;<a onclick="doBack();" style="color: #459ae9;">返回</a>
		</h2><br/>
		<h2 style="line-height: 40px;padding-top: 10px;padding-bottom: 10px;padding-right:40px;float: right;">
			姓名：<input type="text" id="userName"  value="${param.userName}" onblur="searchRetestUser();" class="input" style="width: 107px;"/>&#12288;
			毕业院校：
			<select class="select" id="graduatedId" onchange="searchRetestUser();" style=" width:200px;">
			    <option value="">请选择</option>
				    <c:forEach var="dict" items="${dictTypeEnumGraduateSchoolList}">
						<option value="${dict.dictId}" <c:if test='${dict.dictId == param.graduatedId}'>selected="selected"</c:if>>${dict.dictName}</option>
					</c:forEach>
				    <option value="00" <c:if test="${'00' == param.graduatedId}">selected="selected"</c:if>>其它</option>
			</select>
		</h2>
   </div>
   <div class="div_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <th style="text-align: left;padding-left: 20px;">排名</th>
              <th style="text-align: left;padding-left: 20px;">姓名</th>
              <th style="text-align: left;padding-left: 20px;">毕业院校</th>
              <th style="text-align: left;padding-left: 20px;">毕业专业</th>
              <th style="text-align: left;padding-left: 20px;">类型</th>
              <th>笔试成绩</th>
              <th width="120px;">人员信息</th>
              <th width="120px;">操作</th>
            </tr>
            <c:forEach items="${doctorRecruitExts }" var="doctorExt" varStatus="status">
            <tr>
              <td style="text-align: left;padding-left: 20px;">${(currPage-1)*10+status.index+1}</td>
              <td style="text-align: left;padding-left: 20px;">${doctorExt.doctor.doctorName}</td>
              <td style="text-align: left;padding-left: 20px;">${doctorExt.doctor.graduatedName}</td>
              <td style="text-align: left;padding-left: 20px;">
             	    <c:forEach var="dict" items="${dictTypeEnumGraduateMajorList}">
              	        <c:if test='${doctorExt.doctor.specialized==dict.dictId}'>${dict.dictName}</c:if>
              	    </c:forEach>
              </td>
              <td style="text-align: left;padding-left: 20px;">${doctorExt.doctor.doctorTypeName}</td>
              <td>${doctorExt.examResult}</td>
              <td width="120px;"><a class="btn" onclick="getInfo('${doctorExt.recruitFlow}');">详情</a></td>
              <td width="120px;" id="operTd_${doctorExt.doctorFlow}">
	              <c:if test="${GlobalConstant.FLAG_Y != doctorExt.retestFlag }">
	              	<a id="notice_${doctorExt.doctorFlow}" class="btn" onclick="noticeRetestMain('${doctorExt.doctorFlow}');">通知复试</a>
	              </c:if>
	              <c:if test="${GlobalConstant.FLAG_Y eq doctorExt.retestFlag }">
	              	已通知复试
	              </c:if>
              </td>
            </tr>
            </c:forEach>
          </table>
    </div>
    <div class="page" style="padding-right: 40px;">
       	 <input id="currentPage" type="hidden" name="currentPage" value="${currentPage}"/>
         <c:set var="pageView" value="${pdfn:getPageView(doctorRecruitExts)}" scope="request"></c:set>
	     <pd:pagination-cnres toPage="toPage"/>	 
    </div>
</div>