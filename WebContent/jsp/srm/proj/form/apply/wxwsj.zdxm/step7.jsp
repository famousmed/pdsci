<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
<script type="text/javascript">
	$(document).ready(function(){
		init();
	});

	function init(){
		var trLength =  $("#expendBudgetTb tr").length;
		if(trLength < 10){
			for(var i=0; i<10; i++){
				add('expendBudget');
				$("#expendBudgetTb tr:eq("+i+") td:eq(0)").children().attr("disabled","disabled");
				var $input = $("#expendBudgetTb tr:eq("+i+") td:eq(2)").children();
				$input.css("border-bottom-style", "none");
				$input.attr("readonly", "readonly");
				if(i==0){
					$input.val("材料费");
				}else if(i==1){
					$input.val("测试化验加工费");
				}else if(i==2){
					$input.val("试剂耗材费");
				}else if(i==3){
					$input.val("燃料动力费");
				}else if(i==4){
					$input.val("差旅费");
				}else if(i==5){
					$input.val("会议费");
				}else if(i==6){
					$input.val("出版/文献/信息传播/知识产权事务费");
				}else if(i==7){
					$input.val("劳务费");
				}else if(i==8){
					$input.val("专家咨询费");
				}else if(i==9){
					$input.val("其他支出");
				}
			 }
		}
	}
	
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
	
	function add(tb){
	 	$("#"+tb+"Tb").append($("#"+tb+"Template tr:eq(0)").clone());
	 	
	 	var length = $("#"+tb+"Tb").children().length;
	 	//序号
		$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length);
	}
	
	function delTr(tb){
		//alert("input[name="+tb+"Ids]:checked");
		var checkboxs = $("input[name='"+tb+"Ids']:checked");
		if(checkboxs.length==0){
			jboxTip("请勾选要删除的！");
			return false;
		}
		jboxConfirm("确认删除?",function () {
			var trs = $('#'+tb+'Tb').find(':checkbox:checked');
			$.each(trs , function(i , n){
				$(n).parent('td').parent("tr").remove();
			});
			//删除后序号
			var serial = 0;
			$("."+tb+"Serial").each(function(){
				serial += 1;
				$(this).text(serial);
			});
		});
	}
	
	function budgetCalculate(index , obj){
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		 var amountVal = 0;
		 var expensesAmountVal = 0;
		 //var cell = $(obj).parent()[0].cellIndex+1;
		 //金额
		 var num = 0;
		 var unitPrice = 0;
		 var $amount;
		 if(index==1){
			 num = $(obj).val();
			 unitPrice = $(obj).parent().next().children().val();
			 $amount = $(obj).parent().next().next().children();
		 }
		 if(index==2){
			 num = $(obj).parent().prev().children().val();
			 unitPrice = $(obj).val();
			 $amount = $(obj).parent().next().children();
		 }
		 if(num == null || num == undefined || num == '' || isNaN(num)){
			 num = 0;
		 }
		 if(unitPrice == null || unitPrice == undefined || unitPrice == '' || isNaN(unitPrice)){
			 unitPrice = 0;
		 }
		 amountVal = num * unitPrice;
		 $amount.val(parseFloat(amountVal.toFixed(3)));//三位有效小数
		 
		 //费用总计
		 $("#expendBudgetTb tr td:nth-child(6)").each(function(){
			 var val = $(this).children("input").val();
			 if(val == null || val == undefined || val == '' || isNaN(val)){
			 	val = 0;
			 }
			 expensesAmountVal += parseFloat(val);
		 });
		 $("#expensesAmount").val(parseFloat(expensesAmountVal.toFixed(3)));
	}
</script>
</c:if>
<style>
	.disabled{border-bottom-style: none;}
</style>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step7" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		<font style="font-size: 14px; font-weight:bold;color: #333; ">七、经费预算表（金额单位：万元）</font>
		<table class="basic" style="width: 100%; margin-top: 10px;">
			<tr>
				<th rowspan="2">其中</th>
				<td>
					1．无锡市卫生局资助：<input type="text" name="wxwsjSubsidize" value="${resultMap.wxwsjSubsidize}" class="inputText validate[custom[number]]" style="width: 40%"/>
				</td>
				<td>
					3．上级主管部门资助：<input type="text" name="chargeSubsidize" value="${resultMap.chargeSubsidize}" class="inputText validate[custom[number]]" style="width: 40%"/>
				</td>
			</tr> 
			<tr>
				<td>
					2．依托单位资助：<input type="text" name="orgSubsidize" value="${resultMap.orgSubsidize}" class="inputText validate[custom[number]]" style="width: 40%"/>
				</td>
				<td>
					4．其它渠道资助：<input type="text" name="otherSubsidize" value="${resultMap.otherSubsidize}" class="inputText validate[custom[number]]" style="width: 40%"/>
				</td>
			</tr> 
		</table>
		
		<table class="bs_tb" style="width: 100%;margin-top: 10px; border-bottom-style: none;">
			<tr>
				<th colspan="10" class="theader">课题支出预算
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('expendBudget')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('expendBudget');"></img></span>
					</c:if>
				</th>
			</tr>
			<tr>
				<td width="3%"></td>
				<td width="4%">序号</td>
				<td width="24%">支出科目</td>
				<td width="8%">数量</td>
				<td width="10%">单价</td>
				<td width="15%">金额</td>
				<td width="12%">其中：市卫生局资助额</td>
				<td width="14%">备注/计算依据</td>
			</tr>
			<tbody id="expendBudgetTb">
			<c:if test="${not empty resultMap.expendBudget}">
				<c:forEach var="mr" items="${resultMap.expendBudget}" varStatus="status">
				<tr>
		             <td width="4%" style="text-align: center;"><input name="expendBudgetIds" type="checkbox" <c:if test="${status.count < 11}">disabled="disabled"</c:if>/></td>
		             <td width="5%" style="text-align: center;" class="expendBudgetSerial">${status.count}</td>
		             <td><input type="text" name="expendBudget_subject" value="${mr.objMap.expendBudget_subject}" class="inputText <c:if test='${status.count < 11}'>disabled</c:if>" style="width: 80%;" <c:if test="${status.count < 11}">readonly="readonly"</c:if>/></td>
		             <td><input type="text" name="expendBudget_num" value="${mr.objMap.expendBudget_num}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[integer,maxSize[6]]]" style="width: 80%"/></td>
		             <td><input type="text" name="expendBudget_unitPrice" value="${mr.objMap.expendBudget_unitPrice}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number,max[100000]]]" style="width: 80%"/></td>
		             <td><input type="text" name="expendBudget_amount" value="${mr.objMap.expendBudget_amount}" class="disabled inputText" style="width: 80%" readonly="readonly"/></td>
		             <td><input type="text" name="expendBudget_subsidize" value="${mr.objMap.expendBudget_subsidize}" class="inputText validate[custom[number]]" style="width: 80%"/></td>
		             <td><input type="text" name="expendBudget_remark" value="${mr.objMap.expendBudget_remark}" class="inputText" style="width: 80%"/></td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
			<tr>
				<td colspan="8" style="text-align:left;">
					&#12288;<span style="color: red;">费用总计：</span><input type="text" id="expensesAmount" name="expensesAmount" value="${resultMap.expensesAmount}" class="disabled inputText" style="width: 100px; color: red;" readonly="readonly"/>
				</td>
			</tr>
		</table>
	</form>
	
	<!-------------------------------------------------------------------------------------------------------->
		
	<div style="display: none">
		<!-- 课题支出预算模板 -->
		<table class="basic" id="expendBudgetTemplate" style="width: 100%">
        <tr>
             <td width="3%" style="text-align: center;"><input name="expendBudgetIds" type="checkbox"/></td>
             <td width="4%" style="text-align: center;" class="expendBudgetSerial"></td>
             <td><input type="text" name="expendBudget_subject" class="inputText" style="width: 80%"/></td>
             <td><input type="text" name="expendBudget_num" onchange="budgetCalculate(1,this)" class="inputText validate[custom[integer,maxSize[6]]]" style="width: 80%"/></td>
             <td><input type="text" name="expendBudget_unitPrice" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number,max[100000]]]" style="width: 80%"/></td>
             <td><input type="text" name="expendBudget_amount" class="disabled inputText" style="width: 80%" readonly="readonly"/></td>
             <td><input type="text" name="expendBudget_subsidize" class="inputText validate[custom[number]]" style="width: 80%"/></td>
             <td><input type="text" name="expendBudget_remark" class="inputText" style="width: 80%"/></td>
		</tr>
		</table>
	</div>	
		
   	<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="prev" type="button" onclick="nextOpt('step6')" class="search" value="上一步"/>
		    <input id="nxt" type="button" onclick="nextOpt('step8')" class="search" value="下一步"/>
       	</div>
    </c:if>
		