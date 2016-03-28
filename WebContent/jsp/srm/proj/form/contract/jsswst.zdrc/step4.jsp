<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="true"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
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
	
	function defaultIfEmpty(obj){
		if(isNaN(obj)){
			return 0;
		}else{
			return obj;
		}
	}

	function calculate() {
		var amountFund = 0.0;
		var applySubsidizeFund = parseFloat( $("input[name='applySubsidizeFund']").val()) ;
		var orgMatchFund = parseFloat(  $("input[name='orgMatchFund']").val());
		var binMatchFund =  parseFloat( $("input[name='binMatchFund']").val());
		var otherFund =  parseFloat( $("input[name='otherFund']").val());
		amountFund =  defaultIfEmpty(applySubsidizeFund) + defaultIfEmpty(orgMatchFund) + defaultIfEmpty(binMatchFund) + defaultIfEmpty(otherFund);

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
			 if(parseFloat(val) < 0){
					return ;
				}
			 sumVal = parseFloat(sumVal) + parseFloat(val);
		  });
		if(index==1){
			sumInput = $("input[name=amountFirstYear]");	
		}else if(index==2){
			sumInput = $("input[name=amountSecondYear]");
		}else if(index==3){
			sumInput = $("input[name=amountThirdYear]");
		}else if(index==4){
			sumInput = $("input[name=amountFourthYear]");
		}else if(index==5){
			sumInput = $("input[name=amountFifthYear]");
		}
		sumInput.val(parseFloat(sumVal.toFixed(3)));	
	}
</script>
<style type="text/css">
 .bs_tb tbody th{background: #fff;}
 .bs_tb tbody td{text-align: left;}
 .bs_tb tbody td input{text-align: left;margin-left: 10px;}
</style>
</head>
<body>
<div id="main">
	<div class="mainright">
		<div class="content">
       <div style="margin-top: 10px;">
	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step4" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		   
		
		
		<table id="fund1"  style="width: 100%;margin-top: 10px;" cellspacing="0" cellpadding="0" class="basic" style="position: relative;">
				<tr>
				  	<th colspan="4" style="text-align: left;padding-left: 15px;font-size: 14px;">合同经费</th>
				</tr>
				<tr>
					<td width="200px;" style="text-align:center;">申请资助经费</td>
					<td>
						<input name="applySubsidizeFund" value="${resultMap.applySubsidizeFund}" onchange="calculate()" type="text" class="inputText validate[custom[number]]" style="margin-right: 0px; width:26%; margin-left: 22px;"/>（万元）
					</td>
					<td style="text-align:center;">单位匹配金额</td>
					<td>
						<input name="orgMatchFund" value="${resultMap.orgMatchFund}" onchange="calculate()" type="text" class="inputText validate[custom[number]]" style="margin-right: 0px; width:26%; margin-left: 22px;"/>（万元）
					</td>
				</tr>
				<tr>
					<td style="text-align:center;">丙方匹配金额</td>
					<td>
						<input name="binMatchFund" value="${resultMap.binMatchFund}" onchange="calculate()" type="text" class="inputText validate[custom[number]]" style="margin-right: 0px; width:26%; margin-left: 22px;"/>（万元）
					</td>
					<td style="text-align:center;">其他经费来源</td>
					<td>
						<input name="otherFund" value="${resultMap.otherFund}" onchange="calculate()" type="text" class="inputText validate[custom[number]]" style="margin-right: 0px; width:26%; margin-left: 22px;"/>（万元）
					</td>
				</tr>
				<tr>
					<td style="text-align:center;">合&#12288;&#12288;计</td>
					<td colspan="3">
						<input name="amountFund" value="${resultMap.amountFund}" type="text" class="inputText validate[custom[number]] amount" style="margin-right: 0px; width:26%; margin-left: 22px;"/>（万元）
					</td>
				</tr>
			</table>

			<table id="fund2" style="width: 100%;border-top: none;" cellspacing="0" cellpadding="0" class="basic">
				<tr>
					<th style="text-align:center;width:200px;">申请资助的预算支出项目</th>
					<th style="text-align: center;">第1年</th>
					<th style="text-align: center;">第2年</th>
					<th style="text-align: center;">第3年</th>
					<th style="text-align: center;">第4年</th>
					<th style="text-align: center;">第5年</th>
				</tr>
				<tr>
	   				<td style="text-align: center;">国内外进修费用</td>
					<td><input type="text" name="inlandFirstYear" value="${resultMap.inlandFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="inlandSecondYear" value="${resultMap.inlandSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="inlandThirdYear" value="${resultMap.inlandThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="inlandFourthYear" value="${resultMap.inlandFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="inlandFifthYear" value="${resultMap.inlandFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					</tr>
				<tr>
				    <td style="text-align: center;">学术交流费用</td>
					<td><input type="text" name="communicationFirstYear" value="${resultMap.communicationFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="communicationSecondYear" value="${resultMap.communicationSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="communicationThirdYear" value="${resultMap.communicationThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="communicationFourthYear" value="${resultMap.communicationFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="communicationFifthYear" value="${resultMap.communicationFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
				</tr>
				
				<tr>
				    <td style="text-align: center;">仪器设备费</td>
					<td><input type="text" name="instrumentFirstYear" value="${resultMap.instrumentFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					<td><input type="text" name="instrumentSecondYear" value="${resultMap.instrumentSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="instrumentThirdYear" value="${resultMap.instrumentThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					<td><input type="text" name="instrumentFourthYear" value="${resultMap.instrumentFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="instrumentFifthYear" value="${resultMap.instrumentFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
			    </tr>
			    
				<tr>
				    <td style="text-align: center;">实验材料费</td>
					<td><input type="text" name="experimentMaterialFirstYear" value="${resultMap.experimentMaterialFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					<td><input type="text" name="experimentMaterialSecondYear" value="${resultMap.experimentMaterialSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="experimentMaterialThirdYear" value="${resultMap.experimentMaterialThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					<td><input type="text" name="experimentMaterialFourthYear" value="${resultMap.experimentMaterialFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="experimentMaterialFifthYear" value="${resultMap.experimentMaterialFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
			    </tr>
				<tr>
				    <td style="text-align: center;">实验动物费</td>
					<td><input type="text" name="experimentAnimalTrFirstYear" value="${resultMap.experimentAnimalTrFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					<td><input type="text" name="experimentAnimalTrSecondYear" value="${resultMap.experimentAnimalTrSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="experimentAnimalTrThirdYear" value="${resultMap.experimentAnimalTrThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					<td><input type="text" name="experimentAnimalTrFourthYear" value="${resultMap.experimentAnimalTrFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="experimentAnimalTrFifthYear" value="${resultMap.experimentAnimalTrFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
			    </tr>
				<tr>
				    <td style="text-align: center;">人员培养费</td>
					<td><input type="text" name="personFosterFirstYear" value="${resultMap.personFosterFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					<td><input type="text" name="personFosterSecondYear" value="${resultMap.personFosterSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="personFosterThirdYear" value="${resultMap.personFosterThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					<td><input type="text" name="personFosterFourthYear" value="${resultMap.personFosterFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="personFosterFifthYear" value="${resultMap.personFosterFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
			    </tr>
				<tr>
				    <td style="text-align: center;">图书资料费</td>
					<td><input type="text" name="bookFirstYear" value="${resultMap.bookFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					<td><input type="text" name="bookSecondYear" value="${resultMap.bookSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="bookThirdYear" value="${resultMap.bookThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					<td><input type="text" name="bookFourthYear" value="${resultMap.bookFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="bookFifthYear" value="${resultMap.bookFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
			    </tr>
				<tr>
				    <td style="text-align: center;">研究项目费</td>
					<td><input type="text" name="researchProjFirstYear" value="${resultMap.researchProjFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					<td><input type="text" name="researchProjSecondYear" value="${resultMap.researchProjSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="researchProjThirdYear" value="${resultMap.researchProjThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					<td><input type="text" name="researchProjFourthYear" value="${resultMap.researchProjFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="researchProjFifthYear" value="${resultMap.researchProjFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
			    </tr>
				<tr>
				    <td style="text-align: center;">其他费用</td>
					<td><input type="text" name="otherFirstYear" value="${resultMap.otherFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					<td><input type="text" name="otherSecondYear" value="${resultMap.otherSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="otherThirdYear" value="${resultMap.otherThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
					<td><input type="text" name="otherFourthYear" value="${resultMap.otherFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
					<td><input type="text" name="otherFifthYear" value="${resultMap.otherFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:80%;" /></td>
			    </tr>
				<tr>
				    <td style="text-align: center;">合&#12288;&#12288;&#12288;计</td>
					<td><input type="text" name="amountFirstYear" value="${resultMap.amountFirstYear}" class="inputText validate[custom[number]] amount" style="width:80%;" /></td>
					<td><input type="text" name="amountSecondYear" value="${resultMap.amountSecondYear}" class="inputText validate[custom[number]] amount" style="width:80%;"/></td>
					<td><input type="text" name="amountThirdYear" value="${resultMap.amountThirdYear}" class="inputText validate[custom[number]] amount" style="width:80%;" /></td>
					<td><input type="text" name="amountFourthYear" value="${resultMap.amountFourthYear}" class="inputText validate[custom[number]] amount" style="width:80%;"/></td>
					<td><input type="text" name="amountFifthYear" value="${resultMap.amountFifthYear}" class="inputText validate[custom[number]] amount" style="width:80%;" /></td>
			    </tr>
			</table>
		
		</form>
    <div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
	   <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step3')">上一步</a>
	   <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('finish')">完&#12288;成</a>
    </div>
		</div>
		</div>
		</div>
		</div>
		</body>
		</html>
		