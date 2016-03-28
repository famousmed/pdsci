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
		var constructOrgFund = parseFloat( $("input[name='constructOrgFund']").val()) ;
		var assumeOrgFund = parseFloat(  $("input[name='assumeOrgFund']").val());
		var otherFund =  parseFloat( $("input[name='otherFund']").val());
		amountFund =  defaultIfEmpty(constructOrgFund) + defaultIfEmpty(assumeOrgFund) + defaultIfEmpty(otherFund);
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
			 sumVal = parseFloat(sumVal)+parseFloat(val);
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
 .bs_tb tbody td input{text-align: left;margin-left: 10px;}
</style>
</head>
<body>
<div id="main">
	<div class="mainright">
		<div class="content">
       <div style="margin-top: 10px;">
	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step6" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
	 	<table id="fund1"  style="width: 100%;margin-top: 10px;" cellspacing="0" cellpadding="0" class="basic">
			<tr>
			  	<th colspan="4" style="text-align: left;padding-left: 15px;">六、经费预算</th>
			</tr>
			<tr>
				<td width="200px;" style="text-align:center;">申请资助金额：</td>
				<td>
					<input name="constructOrgFund" value="${resultMap.constructOrgFund}" onchange="calculate()" type="text" class="inputText validate[custom[number]]" style="margin-right: 0px; width:26%; margin-left: 22px;"/>（万元）
				</td>
				<td style="text-align:center;">单位匹配金额：</td>
				<td>
					<input name="assumeOrgFund" value="${resultMap.assumeOrgFund}" onchange="calculate()" type="text" class="inputText validate[custom[number]]" style="margin-right: 0px; width:26%; margin-left: 22px;"/>（万元）
				</td>
			</tr>
			<tr>
				<td style="text-align:center;">其他经费来源：</td>
				<td>
					<input name="otherFund" value="${resultMap.otherFund}" onchange="calculate()" type="text" class="inputText validate[custom[number]]" style="margin-right: 0px; width:26%; margin-left: 22px;"/>（万元）
				</td>
				<td style="text-align:center;">合&#12288;&#12288;计：</td>
				<td>
					<input name="amountFund" value="${resultMap.amountFund}" type="text" class="inputText validate[custom[number]] amount" style="margin-right: 0px; width:26%; margin-left: 22px;"/>（万元）
				</td>
			</tr>
		</table>

		<table id="fund2" style="width: 100%;border-top: none;" cellspacing="0" cellpadding="0" class="bs_tb">
			<tr>
				<th style="width:200px;">经费预算支出科目</th>
				<th>第一年</th>
				<th>第二年</th>
				<th>第三年</th>
				<th>第四年</th>
				<th>第五年</th>
			</tr>
			<tr>
   				<td>国内外进修费用</td>
				<td><input type="text" name="inlandFirstYear" value="${resultMap.inlandFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="inlandSecondYear" value="${resultMap.inlandSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="inlandThirdYear" value="${resultMap.inlandThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="inlandFourthYear" value="${resultMap.inlandFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="inlandFifthYear" value="${resultMap.inlandFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				</tr>
			<tr>
			    <td>学术交流费用</td>
				<td><input type="text" name="communicationFirstYear" value="${resultMap.communicationFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="communicationSecondYear" value="${resultMap.communicationSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="communicationThirdYear" value="${resultMap.communicationThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="communicationFourthYear" value="${resultMap.communicationFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="communicationFifthYear" value="${resultMap.communicationFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
			</tr>
			<tr>
			    <td>导师指导研究工作费用</td>
				<td><input type="text" name="tutorDirectFirstYear" value="${resultMap.tutorDirectFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="tutorDirectSecondYear" value="${resultMap.tutorDirectSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="tutorDirectThirdYear" value="${resultMap.tutorDirectThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="tutorDirectFourthYear" value="${resultMap.tutorDirectFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="tutorDirectFifthYear" value="${resultMap.tutorDirectFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
			</tr>
			
			<tr>
			    <td>仪器设备费</td>
				<td><input type="text" name="instrumentFirstYear" value="${resultMap.instrumentFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
				<td><input type="text" name="instrumentSecondYear" value="${resultMap.instrumentSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="instrumentThirdYear" value="${resultMap.instrumentThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
				<td><input type="text" name="instrumentFourthYear" value="${resultMap.instrumentFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="instrumentFifthYear" value="${resultMap.instrumentFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
		    </tr>
		    
			<tr>
			    <td>实验材料费</td>
				<td><input type="text" name="experimentMaterialFirstYear" value="${resultMap.experimentMaterialFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
				<td><input type="text" name="experimentMaterialSecondYear" value="${resultMap.experimentMaterialSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="experimentMaterialThirdYear" value="${resultMap.experimentMaterialThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
				<td><input type="text" name="experimentMaterialFourthYear" value="${resultMap.experimentMaterialFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="experimentMaterialFifthYear" value="${resultMap.experimentMaterialFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
		    </tr>
			<tr>
			    <td>实验动物费</td>
				<td><input type="text" name="experimentAnimalTrFirstYear" value="${resultMap.experimentAnimalTrFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
				<td><input type="text" name="experimentAnimalTrSecondYear" value="${resultMap.experimentAnimalTrSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="experimentAnimalTrThirdYear" value="${resultMap.experimentAnimalTrThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
				<td><input type="text" name="experimentAnimalTrFourthYear" value="${resultMap.experimentAnimalTrFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="experimentAnimalTrFifthYear" value="${resultMap.experimentAnimalTrFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
		    </tr>
			<tr>
			    <td>业务费</td>
				<td><input type="text" name="businessFirstYear" value="${resultMap.businessFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
				<td><input type="text" name="businessSecondYear" value="${resultMap.businessSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="businessThirdYear" value="${resultMap.businessThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
				<td><input type="text" name="businessFourthYear" value="${resultMap.businessFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="businessFifthYear" value="${resultMap.businessFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
		    </tr>
			<tr>
			    <td>图书资料费</td>
				<td><input type="text" name="bookFirstYear" value="${resultMap.bookFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
				<td><input type="text" name="bookSecondYear" value="${resultMap.bookSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="bookThirdYear" value="${resultMap.bookThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
				<td><input type="text" name="bookFourthYear" value="${resultMap.bookFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="bookFifthYear" value="${resultMap.bookFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
		    </tr>
			<tr>
			    <td>其他费用</td>
				<td><input type="text" name="otherFirstYear" value="${resultMap.otherFirstYear}" onchange="budgetCalculate(1,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
				<td><input type="text" name="otherSecondYear" value="${resultMap.otherSecondYear}" onchange="budgetCalculate(2,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="otherThirdYear" value="${resultMap.otherThirdYear}" onchange="budgetCalculate(3,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
				<td><input type="text" name="otherFourthYear" value="${resultMap.otherFourthYear}" onchange="budgetCalculate(4,this)" class="inputText validate[custom[number]]" style="width:90%;"/></td>
				<td><input type="text" name="otherFifthYear" value="${resultMap.otherFifthYear}" onchange="budgetCalculate(5,this)" class="inputText validate[custom[number]]" style="width:90%;" /></td>
		    </tr>
			<tr>
			    <td>合&#12288;&#12288;&#12288;计</td>
				<td><input type="text" name="amountFirstYear" value="${resultMap.amountFirstYear}" class="inputText validate[custom[number]] amount" style="width:90%;" /></td>
				<td><input type="text" name="amountSecondYear" value="${resultMap.amountSecondYear}" class="inputText validate[custom[number]] amount" style="width:90%;"/></td>
				<td><input type="text" name="amountThirdYear" value="${resultMap.amountThirdYear}" class="inputText validate[custom[number]] amount" style="width:90%;" /></td>
				<td><input type="text" name="amountFourthYear" value="${resultMap.amountFourthYear}" class="inputText validate[custom[number]] amount" style="width:90%;"/></td>
				<td><input type="text" name="amountFifthYear" value="${resultMap.amountFifthYear}" class="inputText validate[custom[number]] amount" style="width:90%;" /></td>
		    </tr>
		</table>
		
		</form>
    <div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
	   <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step5')">上一步</a>
	   <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('finish')">完成</a>
    </div>
		</div>
		</div>
		</div>
		</div>
		</body>
		</html>
		