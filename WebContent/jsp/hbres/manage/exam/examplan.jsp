<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
	<jsp:param name="font" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/hbres/css/exam.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript">
$(function(){
	$('#examDate').datepicker();
});

function saveExam(){
	if(false==$("#examForm").validationEngine("validate")){
		return ;
	}
	jboxConfirm("确认提交？", function(){
		var url = "<s:url value='/hbres/singup/exam/save'/>";
		var loadPage = "add";
		if($('#examFlow').val()){
			loadPage = "edit";
		}
		var reqdata =$('#examForm').serialize();
		jboxPost(url , reqdata , function(resp){
			if(resp=="1"){
				if(loadPage=="add"){
					examSitePlan();		
				}else if(loadPage=="edit"){
					jboxTip("操作成功");
					examPlan();
				}
			}else{
				jboxTip(resp);
			}
		} , null , false);
	});
	
}

function editExam(examFlow){
	var url = "<s:url value='/hbres/singup/exam/findexam'/>?examFlow="+examFlow;
	jboxGet(url , null , function(resp){
		if(resp.examFlow){
			$("#examFlow").val(resp.examFlow);
			$("#examName").val(resp.examName);
			$("#examDate").val(resp.examDate);
			$("#examTime").val(resp.examTime);
			$("#examTypeId").find('option[value="'+resp.examTypeId+'"]').attr("selected" , "selected");
			$("#cel").show();
			$('#addExamDiv').show();
		}
	},null , false);
	
}

function finishExam(examFlow){
	jboxConfirm("确认考试安排结束？结束后不可再对该场考试操作！",function(){
		jboxPost("<s:url value='/hbres/singup/exam/finishexam'/>",{"examFlow":examFlow},function(resp){
			if(resp=="1"){
				jboxTip("操作成功");
				examPlan();
			}else{
				jboxTip("操作失败");
			}
		},null , false);
	});
	
}

function intoExam(examFlow){
	jboxLoad("content","<s:url value='/hbres/singup/exam/intoexam'/>?examFlow="+examFlow,true);
}
</script>
      <div class="main_hd">
        <h2>考试管理</h2>
        
         <div class="title_tab" id="toptab">
          <ul>
            <li class="tab_select"><a>考试安排</a></li>
          </ul>
        </div>
      </div>
      
      <div class="main_bd" id="div_table_0" >
          
          <div id="addExamDiv" class="div_table" <c:if test='${arrangeExams.size()>0}'> style="display: none" </c:if>>
              <h4>添加考试</h4>
              <form id="examForm">
              <input type="hidden" name="examFlow" id="examFlow"/>
              <p>
                  <label>标题：</label><input id="examName" name="examName" class="validate[required,maxSize[100]] input" type="text" style="width:711px;"/>
              </p>
              <p>
                  <label>日期：</label><input class="validate[required] input" type="text" style="width:200px;" id="examDate" name="examDate" readonly="readonly"/>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  <label>考试时间：</label><input class="validate[required,maxSize[12]] input" type="text" style="width:145px;" id="examTime" name="examTime"/>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  <label>类型：</label>
                  <select id="examTypeId" name="examTypeId" class="validate[required]" style="border:1px solid #d6d7d9; height:30px; line-height:30px; width:175px; outline:none;font-family: microsoft yahei;">
                      <option value=''>请选择</option>
                      <c:forEach items='${examTypeEnumList}' var='examType'>
                          <option value='${examType.id}'>${examType.name}</option>
                      </c:forEach>
                      
                  </select>
                  <input class="btn_green" style=" margin-left:16px;" onclick="saveExam();" type="button" value="保存"/>
                  <input id="cel" class="btn_green" style=" margin-left:5px;display: none" onclick="examPlan();" type="button" value="取消"/>
              </p>
              </form>
          </div>
         
          <div class="div_table">
             <h4>待分配</h4>
           <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <colgroup>
              <col width="20%"/>
              <col width="40%"/>
              <col width="20%"/>
              <col width="10%"/>
              <col width="10%"/>
            </colgroup>
	           <thead>
	           <tr>
	              <th>日期</th>
	              <th>标题</th>
	              <th>时间</th>
	              <th>类型</th>
	              <th>操作</th>
	           <tr>
	           </thead>
	           <tbody>
	           <c:forEach items="${arrangeExams}" var="arrange">
	               <tr>
	                   <td>${arrange.examDate}</td>
	                   <td><a href="javascript:void(0);" onclick="intoExam('${arrange.examFlow}');">${arrange.examName}</a></td>
	                   <td>${arrange.examTime}</td>
	                   <td>${arrange.examTypeName}</td>
	                   <td>
	                       <a href='javascript:void(0);' onclick="editExam('${arrange.examFlow}');">[编辑]</a>
	                       <a href='javascript:void(0);' onclick="finishExam('${arrange.examFlow}');">[结束]</a>
	                   </td>
	               </tr>
	           </c:forEach>
	           <c:if test='${arrangeExams.size()==0}'>
	               <tr>
	                   <td align="center" colspan="5">无记录</td>
	               </tr>
	           </c:if>
	           </tbody>
           </table>
          </div>
          <div class="div_table">
             <h4>已分配</h4>
	          <table border="0" cellpadding="0" cellspacing="0" class="grid">
	          <colgroup>
              <col width="20%"/>
              <col width="40%"/>
              <col width="20%"/>
              <col width="20%"/>
            </colgroup>
	           <thead>
	           <tr>
	              <th>日期</th>
	              <th>标题</th>
	              <th>时间</th>
	              <th>类型</th>
	           <tr>
	           </thead>
	           <tbody>
	           <c:forEach items="${finishedExams}" var="exam">
	               <tr>
	                   <td>${exam.examDate}</td>
	                   <td><a href="javascript:void(0);" onclick="intoExam('${exam.examFlow}');">${exam.examName}</a></td>
	                   <td>${exam.examTime}</td>
	                   <td>${exam.examTypeName}</td>
	               </tr>
	           </c:forEach>
	           <c:if test='${finishedExams.size()==0}'>
	               <tr>
	                   <td align="center" colspan="4">无记录</td>
	               </tr>
	           </c:if>
	           </tbody>
           </table>
          </div>
      </div>
