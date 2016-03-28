<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	
	function getInfo(recruitFlow){
		jboxOpen("<s:url value='/hbres/singup/hospital/doctorInfo'/>?recruitFlow="+recruitFlow,"人员信息",1000,550);
	}
	
	function searchDoctor(){
		recruitUsers("${param.speId}", $("#graduatedId").val() , $("#key").val() , $('#batchOper').val());
	}
	
	//复试通知
	function noticeRetestMain(recruitFlow){
		jboxOpen("<s:url value='/hbres/singup/hospital/noticeRetestMain'/>?operType=single&recruitFlow="+recruitFlow,"复试通知",1000,500);
	}
	
	function noticeRetestMainForBatch(){
		if ($("input[name='recruitFlow_check']:checked").length<1) {
			jboxTip("请至少选择一条记录！");
			return;
		}
		jboxOpen("<s:url value='/hbres/singup/hospital/noticeRetestMain'/>?operType=batch","复试通知",1000,500);
	}
	
	//成绩录入
	function gradeEdit(recruitFlow){
		jboxOpen("<s:url value='/hbres/singup/hospital/gradeedit'/>?recruitFlow="+recruitFlow , "成绩录入" , 400 , 200);
	}
	
	//是否录取操作
	function admitOper(recruitFlow , admitFlag){
		if(admitFlag=='${GlobalConstant.FLAG_Y}'){
			jboxOpen("<s:url value='/hbres/singup/hospital/noticeRecruitMain'/>?operType=single&recruitFlow="+recruitFlow,"录取通知",1000,500);
		}else if(admitFlag=='${GlobalConstant.FLAG_N}'){
			jboxConfirm("确认不录取？", function(){
				jboxPost("<s:url value='/hbres/singup/hospital/notrecruit'/>" , {"recruitFlow":recruitFlow} , function(resp){
					if(resp == "${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
						jboxTip("${GlobalConstant.OPERATE_SUCCESSED}");
						searchDoctor();
						jboxClose();
					}
				} , null , false);
			});
		}
	}
	
	function noticeRecruitMainForBatch(){
		if ($("input[name='recruitFlow_check']:checked").length<1) {
			jboxTip("请至少选择一条记录！");
			return;
		}
		jboxOpen("<s:url value='/hbres/singup/hospital/noticeRecruitMain'/>?operType=batch","录取通知",1000,500);
	}
	
	//调剂操作
	function swapOper(recruitFlow , speId){
		jboxOpen("<s:url value='/hbres/singup/hospital/noticeSwapMain'/>?recruitFlow="+recruitFlow+"&speId="+speId,"调剂专业",1000,500);
	}
	
	function checkAll(obj) {
		if (obj.checked) {
			$(":checkbox[name='recruitFlow_check']").attr("checked",true);
		}else {
			$(":checkbox[name='recruitFlow_check']").attr("checked",false);
		}
	}
	
	function speciftedOper(recruitFlow){
		jboxOpen("<s:url value='/hbres/singup/hospital/getSpecifiedOper'/>?recruitFlow="+recruitFlow , '操作' , 400 , 300 , true);
	}
	
</script>
<div class="main_bd" id="div_table_0" > 
   <div class="main_hd">
       <h2 class="underline">
          <span>当前专业：${currSpe.speName}</span>
       </h2>
	   <div class="div_search" style="text-align:right;">	     
			<label>毕业院校：</label>
			<select id="graduatedId" onchange="searchDoctor();" class="select" style="width:200px;">
			    <option value="">请选择</option>
				    <c:forEach var="dict" items="${dictTypeEnumGraduateSchoolList}">
						<option value="${dict.dictId}" <c:if test='${dict.dictId == param.graduatedId}'>selected="selected"</c:if>>${dict.dictName}</option>
					</c:forEach>
				    <option value="00" <c:if test="${'00' == param.graduatedId}">selected="selected"</c:if>>其它</option>
			</select>&#12288;
			<input type="text" id="key" name="key" value="${param.key}" class="input" placeholder="姓名/手机号/邮件/身份证" onchange="searchDoctor();"/>
			<a onclick="main();" class="btn_green">返回</a>
		</div>
		<div class="search_table cz" style="text-align:left; padding: 5px 10px; margin: 0 40px;">
          <label>批量操作：</label>
               <select style="width:100px; margin-top: -4px;" class="select" id="batchOper" name="batchOper" onchange="searchDoctor();">
                <option value=''>请选择</option>
                <option value='1' <c:if test='${param.batchOper eq "1"}'>selected="selected"</c:if>>复试通知</option>
                <option value='2' <c:if test='${param.batchOper eq "2"}'>selected="selected"</c:if>>录取通知</option>
               </select>
               <span id="batchOperDiv"  style="margin-left:10px; display:inline-block;">
		         <c:if test="${param.batchOper eq '1'}">
		           <a id="batchRetest" class="btn_green" href="javascript:void(0);" onclick="noticeRetestMainForBatch();">批量复试通知</a>
		         </c:if>
		         <c:if test="${param.batchOper eq '2'}">
		           <a id="batchtRecruit" class="btn_green" href="javascript:void(0);" onclick="noticeRecruitMainForBatch();">批量录取通知</a>
		         </c:if>
		       </span>
		       <span style="margin-left:10px;">总成绩=(笔试分*100/150)*0.4 + 面试分*0.2 + 操作技能分*0.4</span>
        </div>
   </div>
   <div class="search_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
            <c:if test='${not empty param.batchOper}'>
              <th>
                  <input type="checkbox" onclick="checkAll(this);">
              </th>
            </c:if>
              <th style="text-align: left;padding-left: 5px;">排名</th>
              <th style="text-align: left;padding-left: 5px;">姓名</th>
              <!-- 
              <th style="text-align: left;padding-left: 5px;">毕业院校</th>
              <th style="text-align: left;padding-left: 5px;">毕业专业</th>
              <th style="text-align: left;padding-left: 5px;">类型</th>
               -->
              <th style="text-align: left;padding-left: 5px;">笔试成绩</th>
              <th style="text-align: left;padding-left: 5px;">面试/操作<br/>成绩</th>
              <th style="text-align: left;padding-left: 5px;">总成绩</th>
              <th style="text-align: left;padding-left: 5px;">服从调剂</th>
              <th width="80px;">人员信息</th>
              <th width="120px;">操作</th>
            </tr>
            <c:forEach items="${doctorRecruitExts }" var="doctorExt" varStatus="status">
            <tr>
            <c:if test='${not empty param.batchOper}'>
              <td>
                  <input type="checkbox" name="recruitFlow_check"  value="${doctorExt.recruitFlow}">
              </td>
            </c:if>
              <td style="text-align: left;padding-left: 5px;">${status.index+1}</td>
              <td style="text-align: left;padding-left: 5px;" <c:if test="${sysCfgMap['res_specified_hospital_oper'] eq 'Y'}">onclick='speciftedOper("${doctorExt.recruitFlow}");'</c:if>>${doctorExt.doctor.doctorName}</td>
              <!-- 
              <td style="text-align: left;padding-left: 5px;">${doctorExt.doctor.graduatedName}</td>
              <td style="text-align: left;padding-left: 5px;">
             	    <c:forEach var="dict" items="${dictTypeEnumGraduateMajorList}">
              	        <c:if test='${doctorExt.doctor.specialized==dict.dictId}'>${dict.dictName}</c:if>
              	    </c:forEach>
              </td>
              <td style="text-align: left;padding-left: 5px;">${doctorExt.doctor.doctorTypeName}</td>
               -->
              <td style="text-align: left;padding-left: 5px;">${doctorExt.examResult}</td>
              <td style="text-align: left;padding-left: 5px;"><a href='javascript:void(0);' onclick="gradeEdit('${doctorExt.recruitFlow}');" title="修改">${doctorExt.auditionResult}/${doctorExt.operResult}</a></td>
              <td style="text-align: left;padding-left: 5px;">${doctorExt.totleResult}</td>
              <td style="text-align: left;padding-left: 5px;">${GlobalConstant.FLAG_Y eq doctorExt.swapFlag?'是':'否' }</td>
              <td width="80px;"><a class="btn" onclick="getInfo('${doctorExt.recruitFlow}');">详情</a></td>
              <td width="120px;" id="operTd_${doctorExt.doctorFlow}">
                  <c:choose>
                      <c:when test='${not empty doctorExt.swapSpeId}'>
                          <span title="被调剂至${doctorExt.swapSpeName}">被调剂...</span>
                      </c:when>
                      <c:when test="${'N' eq doctorExt.recruitFlag}">
                          <span>不录取</span>
                      </c:when>
                      <c:when test="${doctorExt.retestFlag eq 'N'}">
                          <a href="javascript:void(0);" onclick="noticeRetestMain('${doctorExt.recruitFlow}')">复试通知</a>    
                      </c:when>
                      <c:when test="${(doctorExt.retestFlag eq 'Y') and ((empty doctorExt.auditionResult) or (empty doctorExt.operResult))}">
                          <a href='javascript:void(0);' onclick="gradeEdit('${doctorExt.recruitFlow}');">录入成绩</a>
                      </c:when>
                      <c:when test="${(doctorExt.retestFlag eq 'Y') and ((not empty doctorExt.auditionResult) and (not empty doctorExt.operResult)) and (doctorExt.admitFlag eq 'N')}">
                          <a href="javascript:void(0);" onclick="admitOper('${doctorExt.recruitFlow}' , '${GlobalConstant.FLAG_Y}');">录取</a>
                          <a href="javascript:void(0);" onclick="admitOper('${doctorExt.recruitFlow}' , '${GlobalConstant.FLAG_N}');">不录取</a>
                          <c:if test='${doctorExt.swapFlag eq "Y"}'>
                              <a href="javascript:void(0);" onclick="swapOper('${doctorExt.recruitFlow}' , '${doctorExt.speId}');">调剂</a>
                          </c:if>
                      </c:when>
                      <c:when test="${doctorExt.recruitFlag eq 'Y' and empty doctorExt.confirmFlag}">
                          <span>等待学员确认</span>
                      </c:when>
                      <c:when test="${doctorExt.recruitFlag eq 'Y' and doctorExt.confirmFlag eq 'Y'}">
                          <span>学员已确认</span>
                      </c:when>
                      <c:when test="${doctorExt.recruitFlag eq 'Y' and doctorExt.confirmFlag eq 'F'}">
                          <span>未确认(过期)</span>
                      </c:when>
                      <c:when test="${doctorExt.recruitFlag eq 'Y' and doctorExt.confirmFlag eq 'N'}">
                          <span>学员放弃录取</span>
                      </c:when>
                  </c:choose>
              </td>
            </tr>
            </c:forEach>
          </table>
    </div>
</div>
