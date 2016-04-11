<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="now" class="java.util.Date" /> 
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
function nextOpt(step){
	if(false==$("#projForm").validationEngine("validate")){
		return false;
	}
var form = $('#projForm');
form.append('<input type="hidden" name="nextPageName" value="'+step+'"/>');
$('#nxt').attr({"disabled":"disabled"});
$('#prev').attr({"disabled":"disabled"});
jboxStartLoading();
form.submit();
}

function defaultIfEmpty(obj){
	if(isNaN(obj)){
		return 0;
	}else{
		return obj;
	}
}


function calculate() {
	
	var amountFund = 0.0;
	var constructOrgFund = parseFloat( $("input[name='constructOrgFund']").val()) ;
	var assumeOrgFund = parseFloat(  $("input[name='assumeOrgFund']").val());
	var assumeOrgChargeOrgFund =  parseFloat( $("input[name='assumeOrgChargeOrgFund']").val());
	var otherFund =  parseFloat( $("input[name='otherFund']").val());
	
	amountFund =  defaultIfEmpty(constructOrgFund) + defaultIfEmpty(assumeOrgFund) + defaultIfEmpty(assumeOrgChargeOrgFund) + defaultIfEmpty(otherFund);

	$("input[name='amountFund']").val(parseFloat(amountFund.toFixed(3)));
}


function budgetCalculate(index , obj){
	 var sumVal = 0;
	 var cell = $(obj).parent()[0].cellIndex+1;
	 $("#fund2 tr:not(:last) td:nth-child("+cell+")").each(function(){
		 var val = $(this).children("input").val();
		 if (val == null || val == undefined || val == '' || isNaN(val)){
				val = 0;
			}
		 sumVal = parseFloat(sumVal)+parseFloat(val);
	  });
	if(index==1){
		sumInput = $("input[name=amountFirstYear]");	
	}else if(index==2){
		sumInput = $("input[name=amountSecondYear]");
	}else if(index==3){
		sumInput = $("input[name=amountThirdYear]");
	}
	sumInput.val(parseFloat(sumVal.toFixed(3)));
}
</script>
</c:if>

<style type="text/css">
	#fund td{text-align: center;}
</style>
</head>
		
        	    	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
						<input type="hidden" id="pageName" name="pageName" value="fundsBudget"/>
						<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
						<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>

  					<table width="100%" cellspacing="0" cellpadding="0" class="basic" style="margin-top: 10px;">
  						<tr>
						  	<th colspan="2" style="text-align: left;padding-left: 15px;font-size: 14px;">六、经费预算</th>
						</tr>
						<tr>
							<td width="25%" style="text-align: center;">甲方资助金额：</td>
							<td>
  								<input name="constructOrgFund" value="${resultMap.constructOrgFund}"  onchange="calculate()" type="text" class="inputText validate[custom[number]]" style="margin-right: 0px; width:26%; margin-left: 22px;"/>（万元）
  							    <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
  							</td>
						</tr>
						<tr>
							<td style="text-align: center;">乙方匹配经费：</td>
  							<td>
  								<input name="assumeOrgFund" value="${resultMap.assumeOrgFund}" onchange="calculate()" type="text" class="inputText validate[custom[number]]" style="margin-right: 0px; width:26%; margin-left: 22px;"/>（万元）
  							</td>
						</tr>
						<tr>
							<td style="text-align: center;">丙方匹配经费：</td>
  							<td>
  								<input name="assumeOrgChargeOrgFund" value="${resultMap.assumeOrgChargeOrgFund}" onchange="calculate()" type="text" class="inputText validate[custom[number]]" style="margin-right: 0px; width:26%; margin-left: 22px;"/>（万元）
  							</td>
						</tr>
						<tr>
							<td style="text-align: center;">其他来源经费：</td>
  							<td>
  								<input name="otherFund" value="${resultMap.otherFund}" onchange="calculate()" type="text" class="inputText validate[custom[number]]" style="margin-right: 0px; width:26%; margin-left: 22px;"/>（万元）
  							</td>
						</tr>
						<tr>
							<td style="text-align: center;">合      计：</td>
  							<td>
  								<input name="amountFund" value="${resultMap.amountFund}" type="text" class="inputText validate[custom[number]]" style="margin-right: 0px; width:26%; margin-left: 22px;"/>（万元）
  							</td>
						</tr>
					</table>

					<table width="100%" cellspacing="0" cellpadding="0" class="basic" style="border-top: none;">
						<tr>
							<th width="25%" style="text-align: center;background: #fff;">申请资助的预算支出科目</th>
							<td style="text-align: center;">
						    	<fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy" var="bb"/>
				                <input name="year1" class='inputText'  type="text" <c:if test='${empty resultMap.year1 and param.view != GlobalConstant.FLAG_Y}'>value="${bb+1}"</c:if><c:if test='${!empty resultMap.year1}'>value="${resultMap.year1}"</c:if>  readonly="readonly"/>
				            </td>
				            <td style="text-align: center;">
				            	<input name="year2" class='inputText' type="text" <c:if test='${empty resultMap.year2 and param.view != GlobalConstant.FLAG_Y}'>value="${bb+2}"</c:if><c:if test='${!empty resultMap.year2}'>value="${resultMap.year2}"</c:if>  readonly="readonly"/>
				            </td> 
				            <td style="text-align: center;">
				            	<input name="year3" class='inputText' type="text" <c:if test='${empty resultMap.year3 and param.view != GlobalConstant.FLAG_Y}'>value="${bb+3}"</c:if><c:if test='${!empty resultMap.year3}'>value="${resultMap.year3}"</c:if>  readonly="readonly"/>
				            </td>
						</tr>
						<tbody id="fund2">
						<tr>
			   				<td style="text-align: center">1.国内外进修费用：</td>
							<td><input type="text" name="inlandFirstYear" value="${resultMap.inlandFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
							<td><input type="text" name="inlandSecondYear" value="${resultMap.inlandSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
							<td><input type="text" name="inlandThirdYear" value="${resultMap.inlandThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
							</tr>
						<tr>
						    <td style="text-align: center">2.学术交流费用：</td>
							<td><input type="text" name="communicationFirstYear" value="${resultMap.communicationFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
							<td><input type="text" name="communicationSecondYear" value="${resultMap.communicationSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
							<td><input type="text" name="communicationThirdYear" value="${resultMap.communicationThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
						</tr>
						<tr>
						    <td style="text-align: center">3.仪器设备费：</td>
							<td><input type="text" name="equipmentFirstYear" value="${resultMap.equipmentFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
							<td><input type="text" name="equipmentSecondYear" value="${resultMap.equipmentSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
							<td><input type="text" name="equipmentThirdYear" value="${resultMap.equipmentThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
						</tr>
						<tr>
						    <td style="text-align: center">4.实验材料费：</td>
							<td><input type="text" name="materialFirstYear" value="${resultMap.materialFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
							<td><input type="text" name="materialSecondYear" value="${resultMap.materialSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
							<td><input type="text" name="materialThirdYear" value="${resultMap.materialThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
						</tr>
						<tr>
						    <td style="text-align: center">5.实验动物费：</td>
							<td><input type="text" name="animalFirstYear" value="${resultMap.animalFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
							<td><input type="text" name="animalSecondYear" value="${resultMap.animalSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
							<td><input type="text" name="animalThirdYear" value="${resultMap.animalThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					    </tr>
					    
						<tr>
						    <td style="text-align: center">6.人员培养费用：</td>
							<td><input type="text" name="trainFirstYear" value="${resultMap.trainFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
							<td><input type="text" name="trainSecondYear" value="${resultMap.trainSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
							<td><input type="text" name="trainThirdYear" value="${resultMap.trainThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					    </tr>
						<tr>
						    <td style="text-align: center">7.购买图书、资料费：</td>
							<td><input type="text" name="bookTrFirstYear" value="${resultMap.bookTrFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
							<td><input type="text" name="bookTrSecondYear" value="${resultMap.bookTrSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
							<td><input type="text" name="bookTrThirdYear" value="${resultMap.bookTrThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					    </tr>
						<tr>
						    <td style="text-align: center">8.研究项目费用：</td>
							<td><input type="text" name="researchFirstYear" value="${resultMap.researchFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
							<td><input type="text" name="researchSecondYear" value="${resultMap.researchSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
							<td><input type="text" name="researchThirdYear" value="${resultMap.researchThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					    </tr>
						<tr>
						    <td style="text-align: center">9.其他费用：</td>
							<td><input type="text" name="otherFirstYear" value="${resultMap.otherFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
							<td><input type="text" name="otherSecondYear" value="${resultMap.otherSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
							<td><input type="text" name="otherThirdYear" value="${resultMap.otherThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					    </tr>
						<tr>
						    <td style="text-align: center">合     计：</td>
							<td><input type="text" name="amountFirstYear" value="${resultMap.amountFirstYear}" class="inputText validate[custom[number]]" style="width:80%;" /></td>
							<td><input type="text" name="amountSecondYear" value="${resultMap.amountSecondYear}" class="inputText validate[custom[number]]" style="width:80%;"/></td>
							<td><input type="text" name="amountThirdYear" value="${resultMap.amountThirdYear}" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					    </tr>
					    </tbody>
					</table>
      						
           			</form>
               		<div class="button" style="width:100%;
               		<c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
               			<input id="prev" type="button" onclick="nextOpt('subjectUserList')" class="search" value="上一步"/>
                	    <input id="nxt" type="button" onclick="nextOpt('finish')" class="search" value="完&#12288;成"/>
					</div>