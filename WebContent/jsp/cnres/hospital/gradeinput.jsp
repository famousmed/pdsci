<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="font" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
	function toPage(page) {
		if(page!=undefined){
			$("#currentPage").val(page);			
		}
		var currentPage = $("#currentPage").val();
		if(!currentPage){
			currentPage = 1;
		}
		gradeInput(currentPage);
	} 
	
	function getInfo(doctorFlow){
		jboxOpen("<s:url value='/cnres/singup/hospital/doctorInfo'/>?doctorFlow="+doctorFlow,"人员信息",1000,550);
	}
	
	function inputGrade(doctorFlow,resultType,obj){
		if($(obj).validationEngine("validate")){
			return;
		}
		var url = "<s:url value='/cnres/singup/hospital/inputGrade'/>";
		var data = {"doctorFlow":doctorFlow ,"result":$(obj).val(),"resultType":resultType};
		jboxPost(url , data , function(resp){
			if(resp=="${GlobalConstant.OPERATE_SUCCESSED}"){
				var currentPage = $("#currentPage").val();
				gradeInput(currentPage);
			}
		} , null , false);
	}
</script>
<div class="main_bd"> 
   <form id="gradeInputForm">
   	<div>
      	<input type="text" id="key" name="key" value="${key}" class="input" placeholder="姓名/手机号/邮件/身份证" onblur="gradeInput();"/>
    </div>
	</form>
   <div class="div_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <th style="text-align: left;padding-left: 20px;">姓名</th>
              <th style="text-align: left;padding-left: 20px;">身份证号</th>
              <th style="text-align: left;padding-left: 20px;">类型</th>
              <th width="120px;">人员信息</th>
              <th>笔试成绩</th>
              <th>技能操作成绩</th>
              <th>面试成绩</th>
              <th width="100px;">总成绩</th>
            </tr>
            <c:forEach items="${doctorRecruitExts }" var="doctorExt" varStatus="status">
            <tr>
              <td style="text-align: left;padding-left: 20px;">${doctorExt.doctor.doctorName}</td>
              <td style="text-align: left;padding-left: 20px;">${doctorExt.sysUser.idNo}</td>
              <td style="text-align: left;padding-left: 20px;">${doctorExt.doctor.doctorTypeName}</td>
              <td width="120px;"><a class="btn" onclick="getInfo('${doctorExt.doctorFlow}');">详情</a></td>
              <td>${doctorExt.examResult}</td>             
              <td>
              	<input class="validate[custom[number]] input" style="width:313px;" value="${doctorExt.operResult }" onchange="inputGrade('${doctorExt.doctorFlow}','operResult',this)" style="width: 50px;text-align: center;"/>
              </td>
              <td>
              	<input class="validate[custom[number]] input" style="width:313px;" value="${doctorExt.auditionResult }" onchange="inputGrade('${doctorExt.doctorFlow}','auditionResult',this)" style="width: 50px;text-align: center;"/>
              </td>
              <td width="100px;">${doctorExt.totleResult}</td>
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