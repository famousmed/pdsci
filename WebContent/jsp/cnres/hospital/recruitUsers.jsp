<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	function getInfo(doctorFlow){
		jboxOpen("<s:url value='/cnres/singup/hospital/doctorInfo'/>?doctorFlow="+doctorFlow,"人员信息",1000,550);
	}
	
	function searchRecruitUser(){
		recruitUsers("${speId}","${assignPlan}",$("#key").val());
	}
	
	function noticeRecruitMain(doctorFlow){
		if (doctorFlow != "") {
			$("#allChecked").attr("checked",false);
			$("input[name='doctorFlow']").attr("checked",false);
			$("#doctor_"+doctorFlow).attr("checked",true);
		}
		if ($("input[name='doctorFlow']:checked").length<1) {
			jboxTip("请至少选择一条记录！");
			return;
		}
		jboxOpen("<s:url value='/cnres/singup/hospital/noticeRecruitMain'/>?speId=${speId}","录取通知",1000,500);
	}
	
	function checkAll(obj) {
		if (obj.checked) {
			$("input[name='doctorFlow'][disabled!='disabled']").attr("checked",true);
		} else {
			$("input[name='doctorFlow']").attr("checked",false);
		}
	}
	
	function doBack(){
		jboxLoad("content","<s:url value='/cnres/singup/hospital/main'/>?liId=ylqtz",true);
	}
</script>
   <div class="main_hd">
   	<div>
		<h2 style="padding-left: 40px;">
       	    当前专业：${speName}&#12288;计划招录人数：${assignPlan}&#12288;
                        复试通知人数：${retestNum}&#12288;
                        预录取人数：<span id="recruitNum" style="color: red;">${recruitNum}</span>
          &#12288;&#12288;<a onclick="doBack();" style="color: #459ae9;">返回</a>
          <input type="hidden" id="assignPlan" value="${assignPlan}">  
		</h2><br/>
			<span class="fl" style="padding-left: 40px;">
				<a class="btn" onclick="noticeRecruitMain('');">批量通知录取</a>
			</span>
			<span class="fr">
	        <input type="text" id="key" name="key" value="${key}" class="input" style="width:200px;" placeholder="姓名/手机号/邮件/身份证" onblur="searchRecruitUser();"/>
	</span>
   </div>
   <div class="div_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <th style="text-align: left;padding-left: 10px;"><input type="checkbox" id="allChecked" onclick="checkAll(this)" title="全选"></th>
              <th style="text-align: left;padding-left: 10px;">排名</th>
              <th style="text-align: left;padding-left: 20px;">姓名</th>
              <th style="text-align: left;padding-left: 20px;">类型</th>
              <th>笔试成绩</th>
              <th>技能操作成绩</th>
              <th>面试成绩</th>
              <th>总成绩</th>
              <th width="120px;">人员信息</th>
              <th width="120px;">操作</th>
            </tr>
            <c:forEach items="${doctorRecruitExts }" var="doctorExt" varStatus="status">
            <tr>
              <td style="text-align: left;padding-left: 10px;">
              	<input type="checkbox" id="doctor_${doctorExt.doctorFlow}" name="doctorFlow" value="${doctorExt.doctorFlow}" 
              	${GlobalConstant.FLAG_Y eq doctorExt.recruitFlag?'disabled':'' }>
              </td>
              <td style="text-align: left;padding-left: 10px;">${status.index+1}</td>
              <td style="text-align: left;padding-left: 20px;">${doctorExt.doctor.doctorName}</td>
              <td style="text-align: left;padding-left: 20px;">${doctorExt.doctor.doctorTypeName}</td>
              <td>${doctorExt.examResult}</td>
              <td>${doctorExt.operResult}</td>
              <td>${doctorExt.auditionResult}</td>
              <td>${doctorExt.totleResult}</td>
              <td width="120px;"><a class="btn" onclick="getInfo('${doctorExt.doctorFlow}');">详情</a></td>
              <td width="120px;" id="operTd_${doctorExt.doctorFlow}">
	              <c:if test="${GlobalConstant.FLAG_Y != doctorExt.recruitFlag }">
	              	<a id="notice_${doctorExt.doctorFlow}" class="btn" onclick="noticeRecruitMain('${doctorExt.doctorFlow}');">通知录取</a>
	              </c:if>
	              <c:if test="${GlobalConstant.FLAG_Y eq doctorExt.recruitFlag }">
	              	已通知录取
	              </c:if>
              </td>
            </tr>
            </c:forEach>
          </table>
    </div>
   </div>
