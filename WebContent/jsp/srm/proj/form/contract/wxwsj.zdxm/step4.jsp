<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
<script type="text/javascript">
		function nextOpt(step){
			if(false==$("#projForm").validationEngine("validate")){
				return false;
			}
			var expend11Cell2 = $("#expend11Cell2").val();
			var swsjbkAmount = $("input[name='swsjbkAmount']").val();
			if(swsjbkAmount != expend11Cell2){
				jboxInfo("市卫生局拨款合计的来源与支出必须相等！");
				return false;
			}
			var form = $('#projForm');
			var action = form.attr('action');
			action+="?nextPageName="+step;
			form.attr("action" , action);
			form.submit();
		}

	function budgetCalculate(trIndex, index , obj){
		var verticalSum = 0;//纵向
		var horizontalSum = 0;//横向
		var $verticalInput;
		var $horizontalInput;
		var cell = $(obj).parent()[0].cellIndex+1;
		$("#budget1 tr:not(:eq(0)) td:nth-child("+cell+")").each(function(){
			 var val = $(this).children("input").val();
			 if(val == null || val == undefined || val == '' || isNaN(val)){
					val = 0;
			 }
			 verticalSum += parseFloat(val) ;
	  	});
		
		$("#budget1 tr:eq("+trIndex+") td:not(:eq(0),:eq(1),:last)").each(function(){
			 var val = $(this).children("input").val();
			 if(val == null || val == undefined || val == '' || isNaN(val)){
					val = 0;
			 }
			 horizontalSum += parseFloat(val) ;
	  	});
		
		if(index==1){
			$verticalInput = $("input[name=amountFirst]");	
		}else if(index==2){
			$verticalInput = $("input[name=amountSecond]");
		}else if(index==3){
			$verticalInput = $("input[name=amountThird]");
		}else if(index==4){
			$verticalInput = $("input[name=amountFourth]");
		}
		$verticalInput.val(parseFloat(verticalSum.toFixed(3)));
		
		if(trIndex==1){
			$horizontalInput = $("input[name=swsjbkAmount]");	
		}else if(trIndex==2){
			$horizontalInput = $("input[name=sjzgbmptAmount]");
		}else if(trIndex==3){
			$horizontalInput = $("input[name=zddwzcAmount]");
		}else if(trIndex==4){
			$horizontalInput = $("input[name=qtlyAmount]");
		}
		$horizontalInput.val(parseFloat(horizontalSum.toFixed(3)));
		
		//合计
		var amountAmountSum = 0;
		$("#budget1 tr:eq(0) td:not(:eq(0),:eq(1),:last)").each(function(){
			 var val = $(this).children("input").val();
			 if(val == null || val == undefined || val == '' || isNaN(val)){
					val = 0;
			 }
			 amountAmountSum += parseFloat(val);
	  	});
		$("input[name=amountAmount]").val(parseFloat(amountAmountSum.toFixed(3)));
	}
	
	
	function budgetCalculate2(cell , obj){
		var verticalSum = 0;
		var $verticalInput;
		$("#budget2 tr td:nth-child("+cell+")").each(function(){
			 var val = $(this).children("input").val();
			 if(val == null || val == undefined || val == '' || isNaN(val)){
					val = 0;
			 }
			 verticalSum += parseFloat(val);
	  	});
		if(cell==2){
			$verticalInput = $("input[name=expend11Cell1]");	
		}else if(cell==3){
			$verticalInput = $("input[name=expend11Cell2]");
		}
		$verticalInput.val(parseFloat(verticalSum.toFixed(3)));
	}
	
	$(function(){
		var $swsjbkFirst = $("input[name='swsjbkFirst']");
		var $swsjbkSecond = $("input[name='swsjbkSecond']");
		var $swsjbkThird = $("input[name='swsjbkThird']");
		var $swsjbkFourth = $("input[name='swsjbkFourth']");
		budgetCalculate(1,1, $swsjbkFirst[0]);
		budgetCalculate(1,2, $swsjbkSecond[0]);
		budgetCalculate(1,3, $swsjbkThird[0]);
		budgetCalculate(1,4, $swsjbkFourth[0]);
	});
</script>
</c:if>

<style>
	.borderNone{border-bottom-style: none;}
</style>

<c:if test="${proj.projTypeId =='wxwsj.zdxm' or proj.projTypeId =='wxwsj.msxm'}">
	<c:set var="addTd" value="true"/>
</c:if>
<c:forEach items="${projFundPlanList}" var="fundPlan" varStatus="status">
	<c:if test="${fundPlan.planTypeId eq projFundPlanTypeEnumSumAmount.id}">
		<c:set var="swsjbkAmount" value="${fundPlan.amount}"/>
	</c:if>
	<c:if test="${fundPlan.planTypeId eq projFundPlanTypeEnumYearAmount.id && not empty fundPlan.year}">
		<c:if test="${fundPlan.year ==0}">
			<c:set var="swsjbkFirst" value="${fundPlan.amount}"/>
		</c:if>
		<c:if test="${fundPlan.year ==1}">
			<c:set var="swsjbkSecond" value="${fundPlan.amount}"/>
		</c:if>
		<c:if test="${fundPlan.year ==2}">
			<c:set var="swsjbkThird" value="${fundPlan.amount}"/>
		</c:if>
		<c:if test="${fundPlan.year ==3}">
			<c:set var="swsjbkFourth" value="${fundPlan.amount}"/>
		</c:if>
	</c:if>
</c:forEach>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step4" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		<input type="hidden" name="budgetYear1" value="${proj.projYear}"/>
		<input type="hidden" name="budgetYear2" value="${proj.projYear+1}"/>
		<input type="hidden" name="budgetYear3" value="${proj.projYear+2}"/>
		<input type="hidden" name="budgetYear4" value="${proj.projYear+3}"/>
		
		<font style="font-size: 14px; font-weight:bold;color: #333; ">五、项目经费预算</font>
		<table class="bs_tb" style="width: 100%;margin-top: 10px; border-bottom-style: none;">
			<tr>
				<th colspan="10" class="theader">（一）项目经费来源预算<span style="float: right;">经费单位：万元&#12288;</span></th>
			</tr>
			<tr>					
				<td width="20%"></td>
				<td width="15%">合&#12288;计</td>
				<td>${proj.projYear}年</td>
				<td>${proj.projYear+1}年</td>
				<td>${proj.projYear+2}年</td>
				<c:if test="${addTd}">
					<td>${proj.projYear+3}年</td>
				</c:if>
				<td width="20%">备&#12288;注</td>
			</tr>
			<tbody id="budget1">
			<tr>					
				<td>合&#12288;计</td>
				<td><input type="text" name="amountAmount" value="${resultMap.amountAmount}" class="borderNone inputText validate[custom[number]]" style="width: 80%" readonly="readonly"/></td>
				<td><input type="text" name="amountFirst" value="${resultMap.amountFirst}" class="borderNone inputText validate[custom[number]]" style="width: 80%" readonly="readonly"/></td>
				<td><input type="text" name="amountSecond" value="${resultMap.amountSecond}" class="borderNone inputText validate[custom[number]]" style="width: 80%" readonly="readonly"/></td>
				<td><input type="text" name="amountThird" value="${resultMap.amountThird}" class="borderNone inputText validate[custom[number]]" style="width: 80%" readonly="readonly"/></td>
				<c:if test="${addTd}">
					<td><input type="text" name="amountFourth" value="${resultMap.amountFourth}" class="borderNone inputText validate[custom[number]]" style="width: 80%" readonly="readonly"/></td>
				</c:if>
				<td><input type="text" name="amountRemark" value="${resultMap.amountRemark}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>市卫生局拨款</td>
				<c:choose>
					<c:when test="${param.view!=GlobalConstant.FLAG_Y}">
						<td><input type="text" name="swsjbkAmount" value="${sysCfgMap['srm_contract_use_fundPlan'] eq 'Y'?swsjbkAmount:resultMap.swsjbkAmount}" class="borderNone inputText validate[custom[number]]" style="width: 80%" readonly="readonly"/></td>
						<td><input type="text" name="swsjbkFirst" value="${sysCfgMap['srm_contract_use_fundPlan'] eq 'Y'?swsjbkFirst:resultMap.swsjbkFirst}" onchange="budgetCalculate(1,1,this)" class="inputText validate[custom[number]]" <c:if test='${sysCfgMap["srm_contract_use_fundPlan"] eq "Y"}'>readonly="readonly"  style="width: 80%;border-bottom-style: none;" </c:if> <c:if test='${sysCfgMap["srm_contract_use_fundPlan"] != "Y"}'>style="width: 80%"</c:if>/></td>
						<td><input type="text" name="swsjbkSecond" value="${sysCfgMap['srm_contract_use_fundPlan'] eq 'Y'?swsjbkSecond:resultMap.swsjbkSecond}" onchange="budgetCalculate(1,2,this)" class="inputText validate[custom[number]]" <c:if test='${sysCfgMap["srm_contract_use_fundPlan"] eq "Y"}'>readonly="readonly"  style="width: 80%;border-bottom-style: none;" </c:if> <c:if test='${sysCfgMap["srm_contract_use_fundPlan"] != "Y"}'>style="width: 80%"</c:if>/></td>
						<td><input type="text" name="swsjbkThird" value="${sysCfgMap['srm_contract_use_fundPlan'] eq 'Y'?swsjbkThird:resultMap.swsjbkThird}" onchange="budgetCalculate(1,3,this)" class="inputText validate[custom[number]]" <c:if test='${sysCfgMap["srm_contract_use_fundPlan"] eq "Y"}'>readonly="readonly"  style="width: 80%;border-bottom-style: none;" </c:if> <c:if test='${sysCfgMap["srm_contract_use_fundPlan"] != "Y"}'>style="width: 80%"</c:if>/></td>
						<c:if test="${addTd}">
							<td><input type="text" name="swsjbkFourth" value="${sysCfgMap['srm_contract_use_fundPlan'] eq 'Y'?swsjbkFourth:resultMap.swsjbkFourth}" onchange="budgetCalculate(1,4,this)" class="inputText validate[custom[number]]" <c:if test='${sysCfgMap["srm_contract_use_fundPlan"] eq "Y"}'>readonly="readonly"  style="width: 80%;border-bottom-style: none;" </c:if> <c:if test='${sysCfgMap["srm_contract_use_fundPlan"] != "Y"}'>style="width: 80%"</c:if>/></td>
						</c:if>
					</c:when>
					<c:otherwise>
						<td><input type="text" name="swsjbkAmount" value="${resultMap.swsjbkAmount}" class="borderNone inputText validate[custom[number]]" style="width: 80%" readonly="readonly"/></td>
						<td><input type="text" name="swsjbkFirst" value="${resultMap.swsjbkFirst}" onchange="budgetCalculate(1,1,this)" class="borderNone inputText validate[custom[number]]" style="width: 80%" readonly="readonly"/></td>
						<td><input type="text" name="swsjbkSecond" value="${resultMap.swsjbkSecond}" onchange="budgetCalculate(1,2,this)" class="borderNone inputText validate[custom[number]]" style="width: 80%" readonly="readonly"/></td>
						<td><input type="text" name="swsjbkThird" value="${resultMap.swsjbkThird}" onchange="budgetCalculate(1,3,this)" class="borderNone inputText validate[custom[number]]" style="width: 80%" readonly="readonly"/></td>
						<c:if test="${addTd}">
							<td><input type="text" name="swsjbkFourth" value="${resultMap.swsjbkFourth}" onchange="budgetCalculate(1,4,this)" class="borderNone inputText validate[custom[number]]" style="width: 80%" readonly="readonly"/></td>
						</c:if>
					</c:otherwise>
				</c:choose>
				<td><input type="text" name="swsjbkRemark" value="${resultMap.swsjbkRemark}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>					
				<td>上级主管部门配套</td>
				<td><input type="text" name="sjzgbmptAmount" value="${resultMap.sjzgbmptAmount}" class="borderNone inputText validate[custom[number]]" style="width: 80%" readonly="readonly"/></td>
				<td><input type="text" name="sjzgbmptFirst" value="${resultMap.sjzgbmptFirst}" onchange="budgetCalculate(2,1,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="sjzgbmptSecond" value="${resultMap.sjzgbmptSecond}" onchange="budgetCalculate(2,2,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="sjzgbmptThird" value="${resultMap.sjzgbmptThird}" onchange="budgetCalculate(2,3,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<c:if test="${addTd}">
					<td><input type="text" name="sjzgbmptFourth" value="${resultMap.sjzgbmptFourth}" onchange="budgetCalculate(2,4,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				</c:if>
				<td><input type="text" name="sjzgbmptRemark" value="${resultMap.sjzgbmptRemark}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>					
				<td>承担单位自筹</td>
				<td><input type="text" name="zddwzcAmount" value="${resultMap.zddwzcAmount}" class="borderNone inputText validate[custom[number]]" style="width: 80%" readonly="readonly"/></td>
				<td><input type="text" name="zddwzcFirst" value="${resultMap.zddwzcFirst}" onchange="budgetCalculate(3,1,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="zddwzcSecond" value="${resultMap.zddwzcSecond}" onchange="budgetCalculate(3,2,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="zddwzcThird" value="${resultMap.zddwzcThird}" onchange="budgetCalculate(3,3,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<c:if test="${addTd}">
					<td><input type="text" name="zddwzcFourth" value="${resultMap.zddwzcFourth}" onchange="budgetCalculate(3,4,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				</c:if>
				<td><input type="text" name="zddwzcRemark" value="${resultMap.zddwzcRemark}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>					
				<td>其他来源</td>
				<td><input type="text" name="qtlyAmount" value="${resultMap.qtlyAmount}" class="borderNone inputText validate[custom[number]]" style="width: 80%" readonly="readonly"/></td>
				<td><input type="text" name="qtlyFirst" value="${resultMap.qtlyFirst}" onchange="budgetCalculate(4,1,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="qtlySecond" value="${resultMap.qtlySecond}" onchange="budgetCalculate(4,2,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="qtlyThird" value="${resultMap.qtlyThird}" onchange="budgetCalculate(4,3,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<c:if test="${addTd}">
					<td><input type="text" name="qtlyFourth" value="${resultMap.qtlyFourth}" onchange="budgetCalculate(4,4,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				</c:if>
				<td><input type="text" name="qtlyRemark" value="${resultMap.qtlyRemark}" class="inputText" style="width: 80%"/></td>
			</tr>
			</tbody>
		</table>
		
		<table class="bs_tb" style="width: 100%;margin-top: 10px;">
			<tr>
				<th colspan="10" class="theader">（二）项目经费支出预算<span style="float: right;">经费单位：万元&#12288;</span></th>
			</tr>
			<tr>
				<td width="25"></td>
				<td width="25%">预算数</td>
				<td width="25%">其中：市卫生局拨款</td>
				<td width="25%">备&#12288;注</td>
			</tr>
			<tbody id="budget2">
			<tr>
				<td>材料费</td>
				<td><input type="text" name="expend1Cell1" value="${resultMap.expend1Cell1}" onchange="budgetCalculate2(2,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend1Cell2" value="${resultMap.expend1Cell2}" onchange="budgetCalculate2(3,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend1Cell3" value="${resultMap.expend1Cell3}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>测试化验加工费</td>
				<td><input type="text" name="expend2Cell1" value="${resultMap.expend2Cell1}" onchange="budgetCalculate2(2,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend2Cell2" value="${resultMap.expend2Cell2}" onchange="budgetCalculate2(3,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend2Cell3" value="${resultMap.expend2Cell3}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>试剂耗材费</td>
				<td><input type="text" name="expend3Cell1" value="${resultMap.expend3Cell1}" onchange="budgetCalculate2(2,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend3Cell2" value="${resultMap.expend3Cell2}" onchange="budgetCalculate2(3,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend3Cell3" value="${resultMap.expend3Cell3}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>燃料动力费</td>
				<td><input type="text" name="expend4Cell1" value="${resultMap.expend4Cell1}" onchange="budgetCalculate2(2,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend4Cell2" value="${resultMap.expend4Cell2}" onchange="budgetCalculate2(3,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend4Cell3" value="${resultMap.expend4Cell3}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>差旅费</td>
				<td><input type="text" name="expend5Cell1" value="${resultMap.expend5Cell1}" onchange="budgetCalculate2(2,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend5Cell2" value="${resultMap.expend5Cell2}" onchange="budgetCalculate2(3,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend5Cell3" value="${resultMap.expend5Cell3}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>会议费</td>
				<td><input type="text" name="expend6Cell1" value="${resultMap.expend6Cell1}" onchange="budgetCalculate2(2,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend6Cell2" value="${resultMap.expend6Cell2}" onchange="budgetCalculate2(3,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend6Cell3" value="${resultMap.expend6Cell3}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>出版/文献/信息传播/知识产权事务费</td>
				<td><input type="text" name="expend7Cell1" value="${resultMap.expend7Cell1}" onchange="budgetCalculate2(2,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend7Cell2" value="${resultMap.expend7Cell2}" onchange="budgetCalculate2(3,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend7Cell3" value="${resultMap.expend7Cell3}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>劳务费</td>
				<td><input type="text" name="expend8Cell1" value="${resultMap.expend8Cell1}" onchange="budgetCalculate2(2,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend8Cell2" value="${resultMap.expend8Cell2}" onchange="budgetCalculate2(3,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend8Cell3" value="${resultMap.expend8Cell3}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>专家咨询费</td>
				<td><input type="text" name="expend9Cell1" value="${resultMap.expend9Cell1}" onchange="budgetCalculate2(2,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend9Cell2" value="${resultMap.expend9Cell2}" onchange="budgetCalculate2(3,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend9Cell3" value="${resultMap.expend9Cell3}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>其他支出</td>
				<td><input type="text" name="expend10Cell1" value="${resultMap.expend10Cell1}" onchange="budgetCalculate2(2,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend10Cell2" value="${resultMap.expend10Cell2}" onchange="budgetCalculate2(3,this)" class="inputText validate[custom[number]]" style="width: 80%"/></td>
				<td><input type="text" name="expend10Cell3" value="${resultMap.expend10Cell3}" class="inputText" style="width: 80%"/></td>
			</tr>
			</tbody>
			<tr>
				<td><span style="color: red">合&#12288;计</span></td>
				<td><input type="text" name="expend11Cell1" value="${resultMap.expend11Cell1}" class="borderNone inputText validate[custom[number]]" style="width: 80%" readonly="readonly"/></td>
				<td><input type="text" name="expend11Cell2" id="expend11Cell2" value="${resultMap.expend11Cell2}" class="borderNone inputText validate[custom[number]]" style="width: 80%" readonly="readonly"/></td>
				<td><input type="text" name="expend11Cell3" value="${resultMap.expend11Cell3}" class="inputText" style="width: 80%"/></td>
			</tr>
		</table>
	</form>
		
   	<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="prev" type="button" onclick="nextOpt('step3')" class="search" value="上一步"/>
		    <input id="nxt" type="button" onclick="nextOpt('finish')" class="search" value="完&#12288;成"/>
       	</div>
    </c:if>

		