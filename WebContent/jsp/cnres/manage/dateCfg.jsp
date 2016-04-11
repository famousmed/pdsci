<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
    <jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script>
$(document).ready(function(){
	$('#regBeginDate , #regEndDate').datepicker();
	$('#printBeginDate , #printEndDate').datepicker();
	$('#wishBeginDate , #wishEndDate').datepicker();
	$('#admitBeginDate , #admitEndDate').datepicker();
	$('#swapBeginDate , #swapEndDate').datepicker();
	//$('#examDate').datepicker();
});	

function submitDateCfg(type){
	var beginDateId = type+"BeginDate";
	var endDateId = type+"EndDate";
	if(!$("#"+beginDateId).validationEngine("validate") && !$("#"+endDateId).validationEngine("validate")){
		var beginDate = $("#"+beginDateId).val();
		var endDate = $("#"+endDateId).val();
		if(beginDate>endDate){
			jboxTip("结束日期不可小于开始日期");
			$("#"+beginDateId).focus();
			return ;
		}
		var url = "<s:url value='/cnres/singup/manage/savedatecfg'/>";
		var reqdata = {};
		reqdata[beginDateId] = beginDate;
		reqdata[endDateId] = endDate;
		jboxConfirm("确认提交？" , function(){
			jboxPost(url , reqdata , function(){
				cfg();
			} , null , true);
		});
	}
	
}
function editDateCfg(type){
	var beginDateId = type+"BeginDate";
	var endDateId = type+"EndDate";
	$("#existSpan_"+type).hide();
	$("#editSpan_"+type).show();
	$("#"+beginDateId).val($("#"+beginDateId+"Span").html());
	$("#"+endDateId).val($("#"+endDateId+"Span").html());
}

function submitExamDate(){
	if(!$("#examDate").validationEngine("validate") && !$("#examTime").validationEngine("validate")){
		var url = "<s:url value='/cnres/singup/manage/savedatecfg'/>";
		var reqdata = {"examDate":$("#examDate").val() , "examTime":$("#examTime").val()};
		jboxConfirm("确认提交？" , function(){
			jboxPost(url , reqdata , function(){
				cfg();
			} , null , true);
		});
	}
}

function editExamDate(){
	$("#existSpan_exam").hide();
	$("#editSpan_exam").show();
	$("#examDate").val($("#examDateSpan").html());
	$("#examTime").val($("#examTimeSpan").html());
}

</script>
        <div class="main_hd">
          <h2>招录设置</h2>
        </div>
        <div class="main_bd">
          <div class="bd_tips">
            <div class="desc">
            <h4>当前报名${regDateCfgMsg.msg}</h4>
            <p>国家住院医师规范化培训招录报名截至时间：
                <c:if test='${recruitCfg.regBeginDate==null && recruitCfg.regEndDate==null}'>
                    <input type="text" readonly="readonly" class="validate[required]" id="regBeginDate" style="width: 100px;"/> ~ <input type="text" readonly="readonly" class="validate[required]" id="regEndDate" style="width: 100px;"/>
                    &#12288;&#12288;<a onclick="submitDateCfg('reg');">确认</a>
                </c:if>
                <c:if test='${recruitCfg.regBeginDate!=null && recruitCfg.regEndDate!=null}'>
                    <span id="existSpan_reg"><span id="regBeginDateSpan">${recruitCfg.regBeginDate}</span> ~ <span id="regEndDateSpan">${recruitCfg.regEndDate}</span>&#12288;&#12288;<a onclick="editDateCfg('reg');">修改</a></span>
                    <span id="editSpan_reg" style="display: none;">
                        <input type="text" readonly="readonly" class="validate[required]" id="regBeginDate" style="width: 100px;"/> ~ <input type="text" readonly="readonly" class="validate[required]" id="regEndDate" style="width: 100px;"/>
                        &#12288;&#12288;<a onclick="submitDateCfg('reg');">确认</a>
                    </span>
                </c:if> 
            </p>
            </div>
          </div>
          
          <div class="bd_tips">
            <div class="desc">
            <h4>当前${printDateCfgMsg.msg}准考证打印</h4>
            <p>打印准考证日期范围：	
                <c:if test='${recruitCfg.printBeginDate==null && recruitCfg.printEndDate==null}'>
                    <input type="text" readonly="readonly" class="validate[required]" id="printBeginDate" style="width: 100px;"/> ~ <input type="text" readonly="readonly" class="validate[required]" id="printEndDate" style="width: 100px;"/>
                    &#12288;&#12288;<a onclick="submitDateCfg('print');">确认</a>
                </c:if>
                <c:if test='${recruitCfg.printBeginDate!=null && recruitCfg.printEndDate!=null}'>
                    <span id="existSpan_print"><span id="printBeginDateSpan">${recruitCfg.printBeginDate}</span> ~ <span id="printEndDateSpan">${recruitCfg.printEndDate}</span>&#12288;&#12288;<a onclick="editDateCfg('print');">修改</a></span>
                    <span id="editSpan_print" style="display: none;">
                        <input type="text" readonly="readonly" class="validate[required]" id="printBeginDate" style="width: 100px;"/> ~ <input type="text" readonly="readonly" class="validate[required]" id="printEndDate" style="width: 100px;"/>
                        &#12288;&#12288;<a onclick="submitDateCfg('print');">确认</a>
                    </span>
                </c:if> 
            </p>
            </div>
          </div>
          
          <div class="bd_tips">
            <div class="desc">
            <h4>当前志愿填报时间${wishDateCfgMsg.msg}</h4>
            <p>志愿填报日期范围：	
                <c:if test='${recruitCfg.wishBeginDate==null && recruitCfg.wishEndDate==null}'>
                    <input type="text" readonly="readonly" class="validate[required]" id="wishBeginDate" style="width: 100px;"/> ~ <input type="text" readonly="readonly" class="validate[required]" id="wishEndDate" style="width: 100px;"/>
                    &#12288;&#12288;<a onclick="submitDateCfg('wish');">确认</a>
                </c:if>
                <c:if test='${recruitCfg.wishBeginDate!=null && recruitCfg.wishEndDate!=null}'>
                    <span id="existSpan_wish"><span id="wishBeginDateSpan">${recruitCfg.wishBeginDate}</span> ~ <span id="wishEndDateSpan">${recruitCfg.wishEndDate}</span>&#12288;&#12288;<a onclick="editDateCfg('wish');">修改</a></span>
                    <span id="editSpan_wish" style="display: none;">
                        <input type="text" readonly="readonly" class="validate[required]" id="wishBeginDate" style="width: 100px;"/> ~ <input type="text" readonly="readonly" class="validate[required]" id="wishEndDate" style="width: 100px;"/>
                        &#12288;&#12288;<a onclick="submitDateCfg('wish');">确认</a>
                    </span>
                </c:if> 
            </p>
            </div>
          </div>
          
          <div class="bd_tips">
            <div class="desc">
            <h4>当前确认录取结果${admitDateCfgMsg.msg}</h4>
            <p>确认录取结果日期范围：	
                <c:if test='${recruitCfg.admitBeginDate==null && recruitCfg.admitEndDate==null}'>
                    <input type="text" readonly="readonly" class="validate[required]" id="admitBeginDate" style="width: 100px;"/> ~ <input type="text" readonly="readonly" class="validate[required]" id="admitEndDate" style="width: 100px;"/>
                    &#12288;&#12288;<a onclick="submitDateCfg('admit');">确认</a>
                </c:if>
                <c:if test='${recruitCfg.admitBeginDate!=null && recruitCfg.admitEndDate!=null}'>
                    <span id="existSpan_admit"><span id="admitBeginDateSpan">${recruitCfg.admitBeginDate}</span> ~ <span id="admitEndDateSpan">${recruitCfg.admitEndDate}</span>&#12288;&#12288;<a onclick="editDateCfg('admit');">修改</a></span>
                    <span id="editSpan_admit" style="display: none;">
                        <input type="text" readonly="readonly" class="validate[required]" id="admitBeginDate" style="width: 100px;"/> ~ <input type="text" readonly="readonly" class="validate[required]" id="admitEndDate" style="width: 100px;"/>
                        &#12288;&#12288;<a onclick="submitDateCfg('admit');">确认</a>
                    </span>
                </c:if> 
            </p>
            </div>
          </div>
          
          <div class="bd_tips">
            <div class="desc">
            <h4>当前学员调剂日期${swapDateCfgMsg.msg}</h4>
            <p>学员调剂日期范围：	
                <c:if test='${recruitCfg.swapBeginDate==null && recruitCfg.swapEndDate==null}'>
                    <input type="text" readonly="readonly" class="validate[required]" id="swapBeginDate" style="width: 100px;"/> ~ <input type="text" readonly="readonly" class="validate[required]" id="swapEndDate" style="width: 100px;"/>
                    &#12288;&#12288;<a onclick="submitDateCfg('swap');">确认</a>
                </c:if>
                <c:if test='${recruitCfg.swapBeginDate!=null && recruitCfg.swapEndDate!=null}'>
                    <span id="existSpan_swap"><span id="swapBeginDateSpan">${recruitCfg.swapBeginDate}</span> ~ <span id="swapEndDateSpan">${recruitCfg.swapEndDate}</span>&#12288;&#12288;<a onclick="editDateCfg('swap');">修改</a></span>
                    <span id="editSpan_swap" style="display: none;">
                        <input type="text" readonly="readonly" class="validate[required]" id="swapBeginDate" style="width: 100px;"/> ~ <input type="text" readonly="readonly" class="validate[required]" id="swapEndDate" style="width: 100px;"/>
                        &#12288;&#12288;<a onclick="submitDateCfg('swap');">确认</a>
                    </span>
                </c:if> 
            </p>
            </div>
          </div>
        </div>
   