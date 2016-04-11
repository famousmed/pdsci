<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
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
	
	function budgetCalculate(index , obj){
		var total = 0;
		var cellIndex = $(obj).parent()[0].cellIndex+1;
		//支出预算合计
		$("#fund1 input[class='validate[custom[number]] inputText']").each(function(){
			var val = $(this).val();
			if (val == null || val == undefined || val == '' || isNaN(val)){
				val = 0;
			}
			total  +=  parseFloat(val);
		});
		$("#expenseBudgetTotal").val(parseFloat(total.toFixed(2)));
	}
	
	function budgetCalculate2(trIndex, index , obj){
		var verticalSum = 0;//纵向
		var horizontalSum = 0;//横向
		var $verticalInput;
		var $horizontalInput;
		var cellIndex = $(obj).parent()[0].cellIndex+1;
		$("#fund2 tr td:nth-child("+cellIndex+")").each(function(){
			 var val = $(this).children("input").val();
			 if(val == null || val == undefined || val == '' || isNaN(val)){
					val = 0;
			 }
			 verticalSum += parseFloat(val) ;
	  	});
		
		$("#fund2 tr:eq("+trIndex+") td:not(:eq(0),:last)").each(function(){
			 var val = $(this).children("input").val();
			 if(val == null || val == undefined || val == '' || isNaN(val)){
					val = 0;
			 }
			 horizontalSum += parseFloat(val) ;
	  	});
		
		if(index==0){
			$verticalInput = $("input[name=expenditureOrg4]");
		}else if(index==1){
			$verticalInput = $("input[name=expenditureCounty4]");	
		}else if(index==2){
			$verticalInput = $("input[name=expenditureOtherSource4]");
		}
		$verticalInput.val(parseFloat(verticalSum.toFixed(2)));
		
		if(trIndex==0){
			$horizontalInput = $("input[name=expenditureTotal1]");	
		}else if(trIndex==1){
			$horizontalInput = $("input[name=expenditureTotal2]");
		}else if(trIndex==2){
			$horizontalInput = $("input[name=expenditureTotal3]");
		}
		$horizontalInput.val(parseFloat(horizontalSum.toFixed(2)));
		
 		//合计
		var amountAmountSum = 0;
		$("#amount td:not(:eq(0),:last)").each(function(){
			 var val = $(this).children("input").val();
			 if(val == null || val == undefined || val == '' || isNaN(val)){
					val = 0;
			 }
			 amountAmountSum += parseFloat(val);
	  	});
		$("#expenditureTotal4").val(parseFloat(amountAmountSum.toFixed(2)));
	}
</script>
</c:if>
<style>
	.borderNone{border-bottom-style: none;}
</style>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step5" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		<font style="font-size: 14px; font-weight:bold;color: #333;">八、学科建设经费来源与支出预算</font>
		<table class="basic" style="width: 100%; margin-top: 10px;" >
			<tr>
				<th class="theader" colspan="4" style="text-align: left;padding-left: 20px;">1、经费支出预算<span style="float: right;">单位：万元（保留两位小数）</span></th>
			</tr>
	        <tr>		
		     	<td colspan="2" style="text-align: center;">支 出 科 目</td>
		     	<td style="text-align: center;">金    额（万元）</td>
		     	<td style="text-align: center;">计算根据及简要理由</td>
		    </tr>
		    <tbody id="fund1">
	        <tr>		
		     	<td rowspan="3"  style="text-align: center;">设备材料费用</td>
		     	<td>1、设备费</td>
		     	<td><input type="text" name="expenseBudget1" value="${resultMap.expenseBudget1}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenseBudgetReason1" value="${resultMap.expenseBudgetReason1}" class="inputText" style="width: 90%"/></td>
		    </tr>
	        <tr>		
		     	<td>2、材料费</td>
		     	<td><input type="text" name="expenseBudget2" value="${resultMap.expenseBudget2}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenseBudgetReason2" value="${resultMap.expenseBudgetReason2}" class="inputText" style="width: 90%"/></td>
		    </tr>
	        <tr>		
		     	<td>3、测试化验加工费</td>
		     	<td><input type="text" name="expenseBudget3" value="${resultMap.expenseBudget3}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenseBudgetReason3" value="${resultMap.expenseBudgetReason3}" class="inputText" style="width: 90%"/></td>
		    </tr>
		    <tr>		
		     	<td rowspan="6"  style="text-align: center;">人才培养与交流费用</td>
		     	<td>4、差旅费</td>
		     	<td><input type="text" name="expenseBudget4" value="${resultMap.expenseBudget4}" onchange="budgetCalculate(1,this)" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenseBudgetReason4" value="${resultMap.expenseBudgetReason4}" class="inputText" style="width: 90%"/></td>
		    </tr>
		    <tr>		
		     	<td>5、会议费</td>
		     	<td><input type="text" name="expenseBudget5" value="${resultMap.expenseBudget5}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenseBudgetReason5" value="${resultMap.expenseBudgetReason5}" class="inputText" style="width: 90%"/></td>
		    </tr>
		    <tr>		
		     	<td>6、合作、协作研究与交流费</td>
		     	<td><input type="text" name="expenseBudget6" value="${resultMap.expenseBudget6}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenseBudgetReason6" value="${resultMap.expenseBudgetReason6}" class="inputText" style="width: 90%"/></td>
		    </tr>
		    <tr>		
		     	<td>7、出版/文献/信息传播/知识产权事务费</td>
		     	<td><input type="text" name="expenseBudget7" value="${resultMap.expenseBudget7}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenseBudgetReason7" value="${resultMap.expenseBudgetReason7}" class="inputText" style="width: 90%"/></td>
		    </tr>
		    <tr>		
		     	<td>8、人员劳务费</td>
		     	<td><input type="text" name="expenseBudget8" value="${resultMap.expenseBudget8}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenseBudgetReason8" value="${resultMap.expenseBudgetReason8}" class="inputText" style="width: 90%"/></td>
		    </tr>
		    <tr>		
		     	<td>9、专家咨询费</td>
		     	<td><input type="text" name="expenseBudget9" value="${resultMap.expenseBudget9}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenseBudgetReason9" value="${resultMap.expenseBudgetReason9}" class="inputText" style="width: 90%"/></td>
		    </tr>
		    <tr>		
		     	<td rowspan="6" style="text-align: center;">建设支撑费</td>
		     	<td>10、燃料动力费</td>
		     	<td><input type="text" name="expenseBudget10" value="${resultMap.expenseBudget10}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenseBudgetReason10" value="${resultMap.expenseBudgetReason10}" class="inputText" style="width: 90%"/></td>
		    </tr>
		    <tr>		
		     	<td>11、维修费</td>
		     	<td><input type="text" name="expenseBudget11" value="${resultMap.expenseBudget11}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenseBudgetReason11" value="${resultMap.expenseBudgetReason11}" class="inputText" style="width: 90%"/></td>
		    </tr>
		    <tr>		
		     	<td>12 、办公及印刷费</td>
		     	<td><input type="text" name="expenseBudget12" value="${resultMap.expenseBudget12}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenseBudgetReason12" value="${resultMap.expenseBudgetReason12}" class="inputText" style="width: 90%"/></td>
		    </tr>
		    <tr>		
		     	<td>13、水电气燃料费</td>
		     	<td><input type="text" name="expenseBudget13" value="${resultMap.expenseBudget13}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenseBudgetReason13" value="${resultMap.expenseBudgetReason13}" class="inputText" style="width: 90%"/></td>
		    </tr>
		    <tr>		
		     	<td>14、物业管理费</td>
		     	<td><input type="text" name="expenseBudget14" value="${resultMap.expenseBudget14}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenseBudgetReason14" value="${resultMap.expenseBudgetReason14}" class="inputText" style="width: 90%"/></td>
		    </tr>
		    <tr>		
		     	<td>15、图书资料费</td>
		     	<td><input type="text" name="expenseBudget15" value="${resultMap.expenseBudget15}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenseBudgetReason15" value="${resultMap.expenseBudgetReason15}" class="inputText" style="width: 90%"/></td>
		    </tr>
		    <tr>		
		     	<td colspan="2" style="padding-left: 198px;">16、其他</td>
		     	<td><input type="text" name="expenseBudget16" value="${resultMap.expenseBudget16}" onchange="budgetCalculate(1,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenseBudgetReason16" value="${resultMap.expenseBudgetReason16}" class="inputText" style="width: 90%"/></td>
		    </tr>
		    </tbody>
		    <tr>		
		     	<td colspan="2" style="padding-left: 198px;">合计</td>
		     	<td><input type="text" id="expenseBudgetTotal" name="expenseBudgetTotal" value="${resultMap.expenseBudgetTotal}" class="borderNone validate[custom[number]] inputText" style="width: 90%" readonly="readonly"/></td>
		     	<td><input type="text" name="expenseBudgetReasonTotal" value="${resultMap.expenseBudgetReasonTotal}" class="inputText" style="width: 90%"/></td>
		    </tr>
		</table>

		
		<table class="basic" style="width: 100%; margin-top: 15px;" >
			<tr>
				<th class="theader" colspan="5" style="text-align: left;padding-left: 20px;">2、配套经费<span style="float: right;">单位：万元（保留两位小数）</span></th>
			</tr>
	        <tr>		
		     	<td style="text-align: center;">年度	</td>
		     	<td style="text-align: center;">所在单位（万元）</td>
		     	<td style="text-align: center;">区县配套（万元）</td>
		     	<td style="text-align: center;">其他渠道来源（万元）</td>
		     	<td style="text-align: center;">合计</td>
		    </tr>
		    <tbody id="fund2">
		    <tr>
		    	<td style="text-align: center;">第一年</td>
		     	<td><input type="text" name="expenditureOrg1" value="${resultMap.expenditureOrg1}" onchange="budgetCalculate2(0,0,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenditureCounty1" value="${resultMap.expenditureCounty1}" onchange="budgetCalculate2(0,1,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenditureOtherSource1" value="${resultMap.expenditureOtherSource1}" onchange="budgetCalculate2(0,2,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenditureTotal1" value="${resultMap.expenditureTotal1}" class="borderNone validate[custom[number]] inputText" style="width: 90%" readonly="readonly"/></td>
		    </tr>
		    <tr>
		    	<td style="text-align: center;">第二年</td>
		     	<td><input type="text" name="expenditureOrg2" value="${resultMap.expenditureOrg2}" onchange="budgetCalculate2(1,0,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenditureCounty2" value="${resultMap.expenditureCounty2}" onchange="budgetCalculate2(1,1,this)"  class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenditureOtherSource2" value="${resultMap.expenditureOtherSource2}" onchange="budgetCalculate2(1,2,this)"  class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenditureTotal2" value="${resultMap.expenditureTotal2}" class="borderNone validate[custom[number]] inputText" style="width: 90%" readonly="readonly"/></td>
		    </tr>
		    <tr>
		    	<td style="text-align: center;">第三年</td>
		     	<td><input type="text" name="expenditureOrg3" value="${resultMap.expenditureOrg3}" onchange="budgetCalculate2(2,0,this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenditureCounty3" value="${resultMap.expenditureCounty3}" onchange="budgetCalculate2(2,1,this)"  class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenditureOtherSource3" value="${resultMap.expenditureOtherSource3}" onchange="budgetCalculate2(2,2,this)"  class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="expenditureTotal3" value="${resultMap.expenditureTotal3}" class="borderNone validate[custom[number]] inputText" style="width: 90%" readonly="readonly"/></td>
		    </tr>
		    </tbody>
		    <tr id="amount">
		    	<td style="text-align: center;">三年合计</td>
		     	<td><input type="text" name="expenditureOrg4" value="${resultMap.expenditureOrg4}" class="borderNone validate[custom[number]] inputText" style="width: 90%" readonly="readonly"/></td>
		     	<td><input type="text" name="expenditureCounty4" value="${resultMap.expenditureCounty4}" class="borderNone validate[custom[number]] inputText" style="width: 90%" readonly="readonly"/></td>
		     	<td><input type="text" name="expenditureOtherSource4" value="${resultMap.expenditureOtherSource4}" class="borderNone validate[custom[number]] inputText" style="width: 90%" readonly="readonly"/></td>
		     	<td><input type="text" id="expenditureTotal4" name="expenditureTotal4" value="${resultMap.expenditureTotal4}" class="borderNone validate[custom[number]] inputText" style="width: 90%" readonly="readonly"/></td>
		    </tr>
	    </table>
	</form>
	
    <c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="prev" type="button" onclick="nextOpt('step4')" class="search" value="上一步"/>
     	    <input id="nxt" type="button" onclick="nextOpt('step6')" class="search" value="下一步"/>
       	</div>
    </c:if>
   
  

		