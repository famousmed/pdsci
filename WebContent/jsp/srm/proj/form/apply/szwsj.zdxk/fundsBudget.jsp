<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	 var researchProjSumVal = 0;
	 var cell = $(obj).parent()[0].cellIndex+1;
	 
	 //研究项目费用
	 $("#fund2 tr:not(:last,:eq(0),:eq(1),:eq(2),:eq(3),:eq(10)) td:nth-child("+cell+")").each(function(){
		 var val = $(this).children("input").val();
		 //alert(val);
		 if (val == null || val == undefined || val == '' || isNaN(val)){
				val = 0;
			}
		 researchProjSumVal = parseFloat(researchProjSumVal) + parseFloat(val);
	  });
	 
	 //合计
	 $("#fund2 tr:not(:last,:eq(3)) td:nth-child("+cell+")").each(function(){
		 var val = $(this).children("input").val();
		 if (val == null || val == undefined || val == '' || isNaN(val)){
				val = 0;
			}
		 sumVal = parseFloat(sumVal) + parseFloat(val);
	  });
	 
	 if(index==1){
			researchProjInput = $("input[name=researchProjFirstYear]");	
			sumInput = $("input[name=amountFirstYear]");	
		}else if(index==2){
			researchProjInput = $("input[name=researchProjSecondYear]");
			sumInput = $("input[name=amountSecondYear]");
		}else if(index==3){
			researchProjInput = $("input[name=researchProjThirdYear]");
			sumInput = $("input[name=amountThirdYear]");
		}else if(index==4){
			researchProjInput = $("input[name=researchProjFourthYear]");
			sumInput = $("input[name=amountFourthYear]");
		}else if(index==5){
			researchProjInput = $("input[name=researchProjFifthYear]");
			sumInput = $("input[name=amountFifthYear]");
		}
	 researchProjInput.val(parseFloat(researchProjSumVal.toFixed(3)));	
	 sumInput.val(parseFloat(sumVal.toFixed(3)));	
}

</script>
</c:if>
<style type="text/css">
	#fund td{
	 text-align: center;
}
</style>

        	    	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
						<input type="hidden" id="pageName" name="pageName" value="fundsBudget"/>
						<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
						<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>

  					<table id="fund1"  style="width: 100%;margin-top: 10px;" cellspacing="0" cellpadding="0" class="basic">
  						<tr>
						  	<th colspan="2" style="text-align: left;padding-left: 15px;font-size: 14px;">十四、经费预算</th>
						</tr>
						<tr>
							<td width="200px;" style="text-align:center;">申请资助经费</td>
							<td>
  								<input name="constructOrgFund" value="${resultMap.constructOrgFund}" onchange="calculate()" type="text" class="inputText validate[custom[number]]" style="margin-right: 0px; width:26%; margin-left: 22px;"/>（万元）
  							</td>
						</tr>
						<tr>
							<td style="text-align:center;">单位建设经费</td>
  							<td>
  								<input name="assumeOrgFund" value="${resultMap.assumeOrgFund}" onchange="calculate()" type="text" class="inputText validate[custom[number]]" style="margin-right: 0px; width:26%; margin-left: 22px;"/>（万元）
  							</td>
						</tr>
						<tr>
							<td style="text-align:center;">主管部门建设经费</td>
  							<td>
  								<input name="assumeOrgChargeOrgFund" value="${resultMap.assumeOrgChargeOrgFund}" onchange="calculate()" type="text" class="inputText validate[custom[number]]" style="margin-right: 0px; width:26%; margin-left: 22px;"/>（万元）
  							</td>
						</tr>
						<tr>
							<td style="text-align:center;">其他经费来源</td>
  							<td>
  								<input name="otherFund" value="${resultMap.otherFund}" onchange="calculate()" type="text" class="inputText validate[custom[number]]" style="margin-right: 0px; width:26%; margin-left: 22px;"/>（万元）
  							</td>
						</tr>
						<tr>
							<td style="text-align:center;">合&#12288;&#12288;计</td>
  							<td>
  								<input name="amountFund" value="${resultMap.amountFund}" type="text" class="inputText validate[custom[number]] amount" style="margin-right: 0px; width:26%; margin-left: 22px;"/>（万元）
  							</td>
						</tr>
					</table>

					<table style="width: 100%;border-top: none;" cellspacing="0" cellpadding="0" class="basic">
						<tr>
							<th style="text-align:center;width:200px;">经费预算支出科目</th>
							<th style="text-align: center;">第一年</th>
							<th style="text-align: center;">第二年</th>
							<th style="text-align: center;">第三年</th>
							<th style="text-align: center;">第四年</th>
							<th style="text-align: center;">第五年</th>
						</tr>
						<tbody id="fund2" >
						<tr>
			   				<td  style="text-align: left;padding-left: 30px;">一、国内外进修费用</td>
							<td><input type="text" name="inlandFirstYear" value="${resultMap.inlandFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="inlandSecondYear" value="${resultMap.inlandSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="inlandThirdYear" value="${resultMap.inlandThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="inlandFourthYear" value="${resultMap.inlandFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="inlandFifthYear" value="${resultMap.inlandFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							</tr>
						<tr>
						    <td  style="text-align: left;padding-left: 30px;">二、学术交流费用</td>
							<td><input type="text" name="communicationFirstYear" value="${resultMap.communicationFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="communicationSecondYear" value="${resultMap.communicationSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="communicationThirdYear" value="${resultMap.communicationThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="communicationFourthYear" value="${resultMap.communicationFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="communicationFifthYear" value="${resultMap.communicationFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
						</tr>
						<tr>
						    <td  style="text-align: left;padding-left: 30px;">三、导师指导研究工作费用</td>
							<td><input type="text" name="tutorDirectFirstYear" value="${resultMap.tutorDirectFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="tutorDirectSecondYear" value="${resultMap.tutorDirectSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="tutorDirectThirdYear" value="${resultMap.tutorDirectThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="tutorDirectFourthYear" value="${resultMap.tutorDirectFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="tutorDirectFifthYear" value="${resultMap.tutorDirectFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
						</tr>
						<tr>
						    <td  style="text-align: left;padding-left: 30px;">四、研究项目费用</td>
							<td><input type="text" name="researchProjFirstYear" value="${resultMap.researchProjFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;" readonly="readonly"/></td>
							<td><input type="text" name="researchProjSecondYear" value="${resultMap.researchProjSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;" readonly="readonly"/></td>
							<td><input type="text" name="researchProjThirdYear" value="${resultMap.researchProjThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;" readonly="readonly"/></td>
							<td><input type="text" name="researchProjFourthYear" value="${resultMap.researchProjFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;" readonly="readonly"/></td>
							<td><input type="text" name="researchProjFifthYear" value="${resultMap.researchProjFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;" readonly="readonly"/></td>
						</tr>
						<tr>
						    <td  style="text-align: left; padding-left: 60px;">1、仪器设备费</td>
							<td><input type="text" name="instrumentFirstYear" value="${resultMap.instrumentFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
							<td><input type="text" name="instrumentSecondYear" value="${resultMap.instrumentSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="instrumentThirdYear" value="${resultMap.instrumentThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
							<td><input type="text" name="instrumentFourthYear" value="${resultMap.instrumentFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="instrumentFifthYear" value="${resultMap.instrumentFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
					    </tr>
					    
						<tr>
						    <td style="text-align: left; padding-left: 60px;">2、实验材料费</td>
							<td><input type="text" name="experimentMaterialFirstYear" value="${resultMap.experimentMaterialFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
							<td><input type="text" name="experimentMaterialSecondYear" value="${resultMap.experimentMaterialSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="experimentMaterialThirdYear" value="${resultMap.experimentMaterialThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
							<td><input type="text" name="experimentMaterialFourthYear" value="${resultMap.experimentMaterialFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="experimentMaterialFifthYear" value="${resultMap.experimentMaterialFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
					    </tr>
						<tr>
						    <td style="text-align: left; padding-left: 60px;">3、实验动物费</td>
							<td><input type="text" name="experimentAnimalTrFirstYear" value="${resultMap.experimentAnimalTrFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
							<td><input type="text" name="experimentAnimalTrSecondYear" value="${resultMap.experimentAnimalTrSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="experimentAnimalTrThirdYear" value="${resultMap.experimentAnimalTrThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
							<td><input type="text" name="experimentAnimalTrFourthYear" value="${resultMap.experimentAnimalTrFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="experimentAnimalTrFifthYear" value="${resultMap.experimentAnimalTrFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
					    </tr>
						<tr>
						    <td style="text-align: left; padding-left: 60px;">4、业务费</td>
							<td><input type="text" name="businessFirstYear" value="${resultMap.businessFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
							<td><input type="text" name="businessSecondYear" value="${resultMap.businessSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="businessThirdYear" value="${resultMap.businessThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
							<td><input type="text" name="businessFourthYear" value="${resultMap.businessFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="businessFifthYear" value="${resultMap.businessFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
					    </tr>
						<tr>
						    <td style="text-align: left; padding-left: 60px;">5、购买图书、资料费</td>
							<td><input type="text" name="bookFirstYear" value="${resultMap.bookFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
							<td><input type="text" name="bookSecondYear" value="${resultMap.bookSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="bookThirdYear" value="${resultMap.bookThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
							<td><input type="text" name="bookFourthYear" value="${resultMap.bookFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="bookFifthYear" value="${resultMap.bookFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
					    </tr>
						<tr>
						    <td style="text-align: left; padding-left: 60px;">6、其他研究费用</td>
							<td><input type="text" name="otherResearchFirstYear" value="${resultMap.otherResearchFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
							<td><input type="text" name="otherResearchSecondYear" value="${resultMap.otherResearchSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="otherResearchThirdYear" value="${resultMap.otherResearchThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
							<td><input type="text" name="otherResearchFourthYear" value="${resultMap.otherResearchFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="otherResearchFifthYear" value="${resultMap.otherResearchFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
					    </tr>
						<tr>
						    <td style="text-align: left;padding-left: 30px;">五、其他费用</td>
							<td><input type="text" name="otherFirstYear" value="${resultMap.otherFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
							<td><input type="text" name="otherSecondYear" value="${resultMap.otherSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="otherThirdYear" value="${resultMap.otherThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
							<td><input type="text" name="otherFourthYear" value="${resultMap.otherFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
							<td><input type="text" name="otherFifthYear" value="${resultMap.otherFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
					    </tr>
						<tr>
						    <td style="text-align:left;padding-left: 60px;">合&#12288;&#12288;&#12288;计</td>
							<td><input type="text" name="amountFirstYear" value="${resultMap.amountFirstYear}" class="inputText validate[custom[number]] amount" style="width:90%;" /></td>
							<td><input type="text" name="amountSecondYear" value="${resultMap.amountSecondYear}" class="inputText validate[custom[number]] amount" style="width:90%;"/></td>
							<td><input type="text" name="amountThirdYear" value="${resultMap.amountThirdYear}" class="inputText validate[custom[number]] amount" style="width:90%;" /></td>
							<td><input type="text" name="amountFourthYear" value="${resultMap.amountFourthYear}" class="inputText validate[custom[number]] amount" style="width:90%;"/></td>
							<td><input type="text" name="amountFifthYear" value="${resultMap.amountFifthYear}" class="inputText validate[custom[number]] amount" style="width:90%;" /></td>
					    </tr>
					    </tbody>
					</table>
      						
           			</form>
               		<div class="button" style="width:100%;
               		<c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none;</c:if>">
               			<input id="prev" type="button" onclick="nextOpt('cooperationOrg')" class="search" value="上一步"/>
                	    <input id="nxt" type="button" onclick="nextOpt('step15')" class="search" value="下一步"/>
					</div>
