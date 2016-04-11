<jsp:include page="/jsp/sczyres/htmlhead-sczyres.jsp">
    <jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script>
$(document).ready(function(){
	$('#regBeginDate , #regEndDate').datepicker();
	$('#swapBeginDate , #swapEndDate').datepicker();
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
		var url = "<s:url value='/sczyres/manage/savedatecfg'/>";
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

</script>
        <div class="main_hd">
          <h2>招录设置</h2>
        </div>
        <div class="main_bd">
          <div class="bd_tips">
            <div class="desc">
            <h4>当前报名${regDateCfgMsg.msg}</h4>
            <p>报名截至时间：
                <c:if test='${recruitCfg.regBeginDate==null && recruitCfg.regEndDate==null}'>
                    <input type="text" readonly="readonly" class="validate[required] input" id="regBeginDate" style="width: 100px;"/> ~ <input type="text" readonly="readonly" class="validate[required] input" id="regEndDate" style="width: 100px;"/>
                    &#12288;&#12288;<a onclick="submitDateCfg('reg');">确认</a>
                </c:if>
                <c:if test='${recruitCfg.regBeginDate!=null && recruitCfg.regEndDate!=null}'>
                    <span id="existSpan_reg"><span id="regBeginDateSpan">${recruitCfg.regBeginDate}</span> ~ <span id="regEndDateSpan">${recruitCfg.regEndDate}</span>&#12288;&#12288;<a onclick="editDateCfg('reg');">修改</a></span>
                    <span id="editSpan_reg" style="display: none;">
                        <input type="text" readonly="readonly" class="validate[required] input" id="regBeginDate" style="width: 100px;"/> ~ <input type="text" readonly="readonly" class="validate[required] input" id="regEndDate" style="width: 100px;"/>
                        &#12288;&#12288;<a onclick="submitDateCfg('reg');">确认</a>
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
                    <input type="text" readonly="readonly" class="validate[required] input" id="swapBeginDate" style="width: 100px;"/> ~ <input type="text" readonly="readonly" class="validate[required] input" id="swapEndDate" style="width: 100px;"/>
                    &#12288;&#12288;<a onclick="submitDateCfg('swap');">确认</a>
                </c:if>
                <c:if test='${recruitCfg.swapBeginDate!=null && recruitCfg.swapEndDate!=null}'>
                    <span id="existSpan_swap"><span id="swapBeginDateSpan">${recruitCfg.swapBeginDate}</span> ~ <span id="swapEndDateSpan">${recruitCfg.swapEndDate}</span>&#12288;&#12288;<a onclick="editDateCfg('swap');">修改</a></span>
                    <span id="editSpan_swap" style="display: none;">
                        <input type="text" readonly="readonly" class="validate[required] input" id="swapBeginDate" style="width: 100px;"/> ~ <input type="text" readonly="readonly" class="validate[required] input" id="swapEndDate" style="width: 100px;"/>
                        &#12288;&#12288;<a onclick="submitDateCfg('swap');">确认</a>
                    </span>
                </c:if> 
            </p>
            </div>
          </div>
        </div>
   