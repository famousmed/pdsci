<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
<script type="text/javascript">
	function nextOpt(step){
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		var form = $('#projForm');
		var action = form.attr('action');
		action+="?nextPageName="+step;
		form.attr("action" , action);
		form.submit();
	}
	
	function calculate1() {
		var total = 0;
		$("#fund1 td:not(:eq(0))").each(function(){
			var val = $(this).children("input").val();
			if (val == null || val == undefined || val == '' || isNaN(val)){
				val = 0;
			}
			total += parseFloat(val);
		});
		$("input[name='yjzjf']").val(parseFloat(total.toFixed(3)));
	}
	
	function calculate2() {
		var total = 0;
		$("#fund2 td:not(:eq(0),:last)").each(function(){
			var val = $(this).children("input").val();
			if (val == null || val == undefined || val == '' || isNaN(val)){
				val = 0;
			}
			total += parseFloat(val);
		});
		$("input[name='aidTotal']").val(parseFloat(total.toFixed(3)));
	}
	
	function budgetCalculate(index , obj){
		var sumVal = 0;
		var cell = $(obj).parent()[0].cellIndex+1;
		$("#fund3 tr:not(:last,:eq(0)) td:nth-child("+cell+")").each(function(){
			var val = $(this).children("input").val();
			if (val == null || val == undefined || val == '' || isNaN(val)){
				val = 0;
			}
			sumVal += parseFloat(val);
		});
		$("input[name=fundBudgetTotal]").val(parseFloat(sumVal.toFixed(3)));	
	}
</script>
</c:if>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step2" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>

		<font style="font-size: 14px; font-weight:bold;color: #333; ">二、项目经费</font>
		<table class="bs_tb" style="width: 100%; margin-top: 10px;" >
			<tr>
				<td>预计总经费（万元）</td>
				<td>自筹（万元）</td>
				<td>区财政资助（万元）</td>
				<td>单位配套（万元）</td>
			</tr>
			<tr id="fund1">
				<td><input type="text" name="yjzjf" value="${resultMap.yjzjf}" class="validate[custom[number]] inputText" style="border-bottom-style: none;" readonly="readonly"/></td>
				<td><input type="text" name="zc" value="${resultMap.zc}" onchange="calculate1();" class="validate[custom[number]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="qczzz" value="${resultMap.qczzz}" onchange="calculate1();" class="validate[custom[number]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="dwpt" value="${resultMap.dwpt}" onchange="calculate1();" class="validate[custom[number]] inputText" style="width: 80%"/></td>
			</tr>
		</table>
		
		<table class="bs_tb" style="width: 100%; margin-top: 10px;" >
			<tr>
				<td rowspan="2">资助计划</td>
				<td>日期</td>
				<td style="text-align: left; padding-left: 3%;"><input type="text" name="aidDate" value="${resultMap.aidDate}" onClick="WdatePicker({dateFmt:'yyyy-MM'})" class="inputText ctime" readonly="readonly" style="width: 85%"/></td>
				<td style="text-align: left; padding-left: 3%;"><input type="text" name="aidDate2" value="${resultMap.aidDate2}" onClick="WdatePicker({dateFmt:'yyyy-MM'})" class="inputText ctime" readonly="readonly" style="width: 85%"/></td>
				<td>合计</td>
			</tr>
			<tr id ="fund2">
				<td>金额（万元）</td>
				<td><input type="text" name="aidFund" value="${resultMap.aidFund}" onchange="calculate2();" class="validate[custom[number]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="aidFund2" value="${resultMap.aidFund2}" onchange="calculate2();" class="validate[custom[number]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="aidTotal" value="${resultMap.aidTotal}" class="validate[custom[number]] inputText" style="border-bottom-style: none;" readonly="readonly"/></td>
			</tr>
		</table>
		
		<table id="fund3" class="bs_tb" style="width: 100%; margin-top: 10px;" >
			<tr>
				<td>技术研发费内容</td>
				<td>经费预算（万元）</td>
			</tr>
			<tr>
				<td>1.查新和专家咨询费</td>
				<td><input type="text" name="fundBudget1" value="${resultMap.fundBudget1}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>2.检测试剂材料费</td>
				<td><input type="text" name="fundBudget2" value="${resultMap.fundBudget2}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>3.设备购置费</td>
				<td><input type="text" name="fundBudget3" value="${resultMap.fundBudget3}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>4.信息咨询、指导费</td>
				<td><input type="text" name="fundBudget4" value="${resultMap.fundBudget4}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>5.技术图书资料费及会议、培训费</td>
				<td><input type="text" name="fundBudget5" value="${resultMap.fundBudget5}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>6.未列入国家计划的中间实验费</td>
				<td><input type="text" name="fundBudget6" value="${resultMap.fundBudget6}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>7.与研发直接相关的其他费用</td>
				<td><input type="text" name="fundBudget7" value="${resultMap.fundBudget7}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>8. 委托其他单位和个人科研试制费用及管理费</td>
				<td><input type="text" name="fundBudget8" value="${resultMap.fundBudget8}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>合&#12288; 计</td>
				<td><input type="text" name="fundBudgetTotal" value="${resultMap.fundBudgetTotal}" class="validate[custom[number]] inputText" style="border-bottom-style: none;" readonly="readonly"/></td>
			</tr>
		</table>
	</form>
	
   	<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="prev" type="button" onclick="nextOpt('step1')" class="search" value="上一步"/>
		    <input id="nxt" type="button" onclick="nextOpt('step3')" class="search" value="下一步"/>
       	</div>
    </c:if>

		