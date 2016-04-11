<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
function countFundSource(obj){
	var sumVal = 0;
	var tds = $(obj).parent().parent().find("td:not(:last,:first)");
	$.each(tds , function(i , o){
		if(i){
			var val = $(o).children("input").val();
			if(val.length>5){
				return ;
			};
			if (val == null || val == undefined || val == '' || isNaN(val)){
				val = 0;
			}
			if(parseFloat(val)<0){
				return ;
			}
			sumVal = parseFloat(sumVal)+parseFloat(val);
		}
		
	});
	var sumInput = $(obj).parent().parent().find("td").eq(1).children("input");
	sumInput.val(parseFloat(sumVal.toFixed(3)));
	
}
function countFundBudget(index , obj){
	 var sumVal = 0;
	 var cell = $(obj).parent()[0].cellIndex+1;
	 var rows = $("#budgetTb tr:not(:last) td:nth-child("+cell+")");
	 $.each(rows , function(i , o){
		 if(i){
			 var val = $(o).children("input").val();
			 if(val.length>5){
					return ;
			 };
			 if (val == null || val == undefined || val == '' || isNaN(val)){
					val = 0;
			 }
			 if(parseFloat(val)<0){
					return ;
			 }
			 sumVal = parseFloat(sumVal)+parseFloat(val); 
		 }
		 
	  });
	if(index==1){
		sumInput = $("#fundPaymentBudgetBudgetCountSum");	
	}else if(index==2){
		sumInput = $("#fundPaymentBudgetOneOfFundSum");
	}
	sumInput.val(parseFloat(sumVal.toFixed(3)));
	
}
</script>
</c:if>
        	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
				<input type="hidden" id="pageName" name="pageName" value="step6"/>
				<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
				<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
				<div class="title_sp">六、经费预算</div>
				  <c:choose>
  			              <c:when test="${param.view == GlobalConstant.FLAG_Y}">
  			                 <table width="100%" cellpadding="0" cellspacing="0" class="basic" style="position: relative;">
		        		<tbody>
		        		<tr>
					    	<th colspan="6" style="text-align: left;padding-left: 15px;font-weight: bold;font-size: 13px;">项目经费来源预算(单位：万元)</th>
					    </tr>			        		
		        			<tr>
					    		<td style="text-align:right; width:20%;">项目总投入：</td>
					    		<td colspan="2">
			                       	${resultMap.fundSourceBudgetProjSumFund}
			                    </td>
			                    <td style="text-align:right">前期已投入：</td>
					    		<td colspan="2">
			                       ${resultMap.fundSourceBudgetEarlyFund}
			                    </td>
					    	</tr>
					    	
					    	<tr>
					    		<td></td>
					    		<td width="10%" style='text-align: center;'>合计</td>
					    		<td width="10%" style='text-align: center;'>第一年</td>
					    		<td width="10%" style='text-align: center;'>第二年</td>
					    		<td width="10%" style='text-align: center;'>第三年</td>
					    		<td width="40%" style='text-align: center;'>备注</td>
					    	</tr>
					    	
					    	<tr>
					    		<td style="text-align:right">新增投入：</td>
					    		<td style='text-align: center;'>${resultMap.fundSourceBudgetSumFund1}</td>
					    		<td style='text-align: center;'>${resultMap.fundSourceBudgetFund1year1}</td>
					    		<td style='text-align: center;'>${resultMap.fundSourceBudgetFund1year2}</td>
					    		<td style='text-align: center;'>${resultMap.fundSourceBudgetFund1year3}</td>
					    		<td style='text-align: center;'>${resultMap.fundSourceBudgetFund1remark}</td>
					    	    
					    	</tr>
					    	
					    	<tr>
					    		<td style="text-align:right"><c:if test='${proj.chargeOrgFlow eq sysCfgMap["global_org_flow"] }'>市财政拨款：</c:if><c:if test='${proj.chargeOrgFlow != sysCfgMap["global_org_flow"] }'>县、区财政拨款：</c:if></td>
					    		<td style='text-align: center;'>${resultMap.fundSourceBudgetSumFund2}</td>
					    		<td style='text-align: center;'>${resultMap.fundSourceBudgetFund2year1}</td>
					    		<td style='text-align: center;'>${resultMap.fundSourceBudgetFund2year2}</td>
					    		<td style='text-align: center;'>${resultMap.fundSourceBudgetFund2year3}</td>
					    		<td style='text-align: center;'>${resultMap.fundSourceBudgetFund2remark}</td>
					    	    
					    	</tr>
					    	
					    	<tr>
					    		<td style="text-align:right">承担单位配套：</td>
					    		<td style='text-align: center;'>${resultMap.fundSourceBudgetSumFund3}</td>
					    		<td style='text-align: center;'>${resultMap.fundSourceBudgetFund3year1}</td>
					    		<td style='text-align: center;'>${resultMap.fundSourceBudgetFund3year2}</td>
					    		<td style='text-align: center;'>${resultMap.fundSourceBudgetFund3year3}</td>
					    		<td style='text-align: center;'>${resultMap.fundSourceBudgetFund3remark}</td>
					    	    
					    	</tr>
					    	<tr>
					    		<fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy" var="bb"/>
					    		<td colspan="6"><c:if test='${proj.chargeOrgFlow eq sysCfgMap["global_org_flow"] }'>甲方</c:if><c:if test='${proj.chargeOrgFlow != sysCfgMap["global_org_flow"] }'>丙方</c:if>核拨乙方科技经费  ： ${resultMap.fundSourceBudgetJiaGiveYiFund}  万元，不足部分由乙方自筹解决。经费采取一次性拨款，计划于${resultMap.fundSourceBudgetYear}年，拨款    ${resultMap.fundSourceBudgetYearFund}  万元。 </td>
					    	</tr>
		        		</tbody>
		        	</table>
		        	<br/>
		        	<table width="100%" cellpadding="0" cellspacing="0" class="basic" id="budgetTb" style="position: relative;">
		        		<tr>
					    	<th colspan="4" style="text-align: left;padding-left: 15px;font-weight: bold;font-size: 13px;">项目经费支出预算经费(单位：万元)</th>
					    </tr>
		        		<tbody >
		        			<tr>
					    		<td width="20%"></td>
					    		<td width="20%" style='text-align: center;'>预算数</td>
					    		<td width="20%"style='text-align: center;'>其中：<c:if test='${proj.chargeOrgFlow eq sysCfgMap["global_org_flow"] }'>市财政拨款</c:if><c:if test='${proj.chargeOrgFlow != sysCfgMap["global_org_flow"] }'>县、区财政拨款</c:if></td>
					    		<td style='text-align: center;'>备注</td>
					    	</tr>
					    	<tbody>
					    		<tr>
					    			<td style="text-align:right">人员费：</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetBudgetCount1}</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetOneOfFund1}</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetRemark1}</td>
					    		</tr>
					    		<tr>
					    			<td style="text-align:right">设备费：</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetBudgetCount2}</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetOneOfFund2}</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetRemark2}</td>
					    		</tr>
					    		<tr>
					    			<td style="text-align:right">能源材料费：</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetBudgetCount3}</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetOneOfFund3}</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetRemark3}</td>
					    		</tr>
					    		<tr>
					    			<td style="text-align:right">试验外协费：</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetBudgetCount4}</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetOneOfFund4}</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetRemark4}</td>
					    		</tr>
					    		<tr>
					    			<td style="text-align:right">差旅费：</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetBudgetCount5}</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetOneOfFund5}</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetRemark5}</td>
					    		</tr>
					    		<tr>
					    			<td style="text-align:right">会议费：</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetBudgetCount6}</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetOneOfFund6}</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetRemark6}</td>
					    		</tr>
					    		<tr>
					    			<td style="text-align:right">管理费：</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetBudgetCount7}</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetOneOfFund7}</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetRemark7}</td>
					    		</tr>
					    		<tr>
					    			<td style="text-align:right">其他相关费：</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetBudgetCount8}</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetOneOfFund8}</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetRemark8}</td>
					    		</tr>
					    		<tr>
					    			<td style="text-align:right">合&#12288;计（自动计算）：</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetBudgetCountSum}</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetOneOfFundSum}</td>
					    			<td style='text-align: center;'>${resultMap.fundPaymentBudgetRemarkSum}</td>
					    		</tr>
					    	</tbody>
		        		</tbody>
		        	</table>
  			              </c:when>
  			              <c:otherwise>
		        	<table width="100%" cellpadding="0" cellspacing="0" class="basic" style="position: relative;">
		        		<tbody>
		        		<tr>
					    	<th colspan="6" style="text-align: left;padding-left: 15px;font-weight: bold;font-size: 13px;">项目经费来源预算(单位：万元)</th>
					    </tr>			        		
		        			<tr>
					    		<td style="text-align:right; width:20%;">项目总投入：</td>
					    		<td colspan="2">
			                       	<input name="fundSourceBudgetProjSumFund" type="text" value="${resultMap.fundSourceBudgetProjSumFund}"  class="inputText"  style="width: 84%; "/>
			                    </td>
			                    <td style="text-align:right">前期已投入：</td>
					    		<td colspan="2">
			                       	<input name="fundSourceBudgetEarlyFund" type="text" value="${resultMap.fundSourceBudgetEarlyFund}"  class="inputText"  style="width: 84%; "/>
			                    </td>
					    	</tr>
					    	
					    	<tr>
					    		<td></td>
					    		<td style='text-align: center;'>合计</td>
					    		<td style='text-align: center;'>第一年</td>
					    		<td style='text-align: center;'>第二年</td>
					    		<td style='text-align: center;'>第三年</td>
					    		<td style='text-align: center;'>备注</td>
					    	</tr>
					    	
					    	<tr>
					    		<td style="text-align:right">新增投入：</td>
					    		<td><input name='fundSourceBudgetSumFund1' type='text' value='${resultMap.fundSourceBudgetSumFund1}' class="inputText"  style="width: 84%; " readonly="readonly"/></td>
					    		<td><input name='fundSourceBudgetFund1year1' type='text' value='${resultMap.fundSourceBudgetFund1year1}' class="validate[custom[number] ,custom[positiveNum] , maxSize[5]] inputText" onblur="countFundSource(this)"  style="width: 84%; "/></td>
					    		<td><input name='fundSourceBudgetFund1year2' type='text' value='${resultMap.fundSourceBudgetFund1year2}' class="validate[custom[number],custom[positiveNum] , maxSize[5]] inputText" onblur="countFundSource(this)"  style="width: 84%; "/></td>
					    		<td><input name='fundSourceBudgetFund1year3' type='text' value='${resultMap.fundSourceBudgetFund1year3}' class="validate[custom[number]] inputText" onblur="countFundSource(this)"  style="width: 84%; "/></td>
					    		<td><input name='fundSourceBudgetFund1remark' type='text' value='${resultMap.fundSourceBudgetFund1remark}' class="inputText"  style="width: 84%; "/></td>
					    	    
					    	</tr>
					    	
					    	<tr>
					    		<td style="text-align:right"><c:if test='${proj.chargeOrgFlow eq sysCfgMap["global_org_flow"] }'>市财政拨款：</c:if><c:if test='${proj.chargeOrgFlow != sysCfgMap["global_org_flow"] }'>县、区财政拨款：</c:if></td>
					    		<td><input name='fundSourceBudgetSumFund2' type='text' value='${resultMap.fundSourceBudgetSumFund2}' class="inputText"  style="width: 84%; " readonly="readonly"/></td>
					    		<td><input name='fundSourceBudgetFund2year1' type='text' value='${resultMap.fundSourceBudgetFund2year1}' class="validate[custom[number],custom[positiveNum] , maxSize[5]] inputText" onblur="countFundSource(this)"  style="width: 84%; "/></td>
					    		<td><input name='fundSourceBudgetFund2year2' type='text' value='${resultMap.fundSourceBudgetFund2year2}' class="validate[custom[number],custom[positiveNum] , maxSize[5]] inputText" onblur="countFundSource(this)"  style="width: 84%; "/></td>
					    		<td><input name='fundSourceBudgetFund2year3' type='text' value='${resultMap.fundSourceBudgetFund2year3}' class="validate[custom[number]] inputText" onblur="countFundSource(this)"  style="width: 84%; "/></td>
					    		<td><input name='fundSourceBudgetFund2remark' type='text' value='${resultMap.fundSourceBudgetFund2remark}' class="inputText"  style="width: 84%; "/></td>
					    	    
					    	</tr>
					    	
					    	<tr>
					    		<td style="text-align:right">承担单位配套：</td>
					    		<td><input name='fundSourceBudgetSumFund3' type='text' value='${resultMap.fundSourceBudgetSumFund3}' class="inputText"  style="width: 84%; " readonly="readonly"/></td>
					    		<td><input name='fundSourceBudgetFund3year1' type='text' value='${resultMap.fundSourceBudgetFund3year1}' class="validate[custom[number],custom[positiveNum] , maxSize[5]] inputText" onblur="countFundSource(this)" style="width: 84%; "/></td>
					    		<td><input name='fundSourceBudgetFund3year2' type='text' value='${resultMap.fundSourceBudgetFund3year2}' class="validate[custom[number],custom[positiveNum] , maxSize[5]] inputText" onblur="countFundSource(this)" style="width: 84%; "/></td>
					    		<td><input name='fundSourceBudgetFund3year3' type='text' value='${resultMap.fundSourceBudgetFund3year3}' class="validate[custom[number]] inputText" onblur="countFundSource(this)" style="width: 84%; "/></td>
					    		<td><input name='fundSourceBudgetFund3remark' type='text' value='${resultMap.fundSourceBudgetFund3remark}' class="inputText"  style="width: 84%; "/></td>
					    	    
					    	</tr>
					    	<tr>
					    		<fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy" var="bb"/>
					    		<td colspan="6"><c:if test='${proj.chargeOrgFlow eq sysCfgMap["global_org_flow"] }'>甲方</c:if><c:if test='${proj.chargeOrgFlow != sysCfgMap["global_org_flow"] }'>丙方</c:if>核拨乙方科技经费  ：   <input type='text' class='inputText' name='fundSourceBudgetJiaGiveYiFund' value='${resultMap.fundSourceBudgetJiaGiveYiFund}'/>    万元，不足部分由乙方自筹解决。经费采取一次性拨款，计划于<c:if test='${empty resultMap.fundSourceBudgetYear}'><input type='text' class='inputText' value='${bb+1}' name="fundSourceBudgetYear" readonly="readonly"></c:if><c:if test='${not empty resultMap.fundSourceBudgetYear}'><input type='text' class='inputText' name="fundSourceBudgetYear" value='${resultMap.fundSourceBudgetYear}' readonly="readonly"></c:if>年，拨款    <input type='text' class='inputText' name='fundSourceBudgetYearFund' value='${resultMap.fundSourceBudgetYearFund}'/>   万元。 </td>
					    	</tr>
		        		</tbody>
		        	</table>
		        	<br/>
		        	<table width="100%" cellpadding="0" cellspacing="0" class="basic" id="budgetTb" style="position: relative;">
		        		<tr>
					    	<th colspan="4" style="text-align: left;background:#ECF2FA;padding-left: 15px;font-weight: bold;font-size: 13px;">项目经费支出预算经费(单位：万元)</th>
					    </tr>
		        		<tbody >
		        			<tr>
					    		<td></td>
					    		<td style='text-align: center;'>预算数</td>
					    		<td style='text-align: center;'>其中：<c:if test='${proj.chargeOrgFlow eq sysCfgMap["global_org_flow"] }'>市财政拨款</c:if><c:if test='${proj.chargeOrgFlow != sysCfgMap["global_org_flow"] }'>县、区财政拨款</c:if></td>
					    		<td style='text-align: center;'>备注</td>
					    	</tr>
					    	<tbody>
					    		<tr>
					    			<td style="text-align:right">人员费：</td>
					    			<td><input type='text' name='fundPaymentBudgetBudgetCount1' value='${resultMap.fundPaymentBudgetBudgetCount1}' class="validate[custom[number],custom[positiveNum] , maxSize[5]] inputText" onblur="countFundBudget(1,this)" style="width: 84%; "/></td>
					    			<td><input type='text' name='fundPaymentBudgetOneOfFund1' value='${resultMap.fundPaymentBudgetOneOfFund1}' class="validate[custom[number],custom[positiveNum] , maxSize[5]] inputText" onblur="countFundBudget(2,this)" style="width: 84%; "/></td>
					    			<td><input type='text' name='fundPaymentBudgetRemark1' value='${resultMap.fundPaymentBudgetRemark1}' class="inputText"  style="width: 84%; "/></td>
					    		</tr>
					    		<tr>
					    			<td style="text-align:right">设备费：</td>
					    			<td><input type='text' name='fundPaymentBudgetBudgetCount2' value='${resultMap.fundPaymentBudgetBudgetCount2}' class="validate[custom[number],custom[positiveNum] , maxSize[5]] inputText" onblur="countFundBudget(1,this)"  style="width: 84%; "/></td>
					    			<td><input type='text' name='fundPaymentBudgetOneOfFund2' value='${resultMap.fundPaymentBudgetOneOfFund2}' class="validate[custom[number],custom[positiveNum] , maxSize[5]] inputText" onblur="countFundBudget(2,this)" style="width: 84%; "/></td>
					    			<td><input type='text' name='fundPaymentBudgetRemark2' value='${resultMap.fundPaymentBudgetRemark2}' class="inputText"  style="width: 84%; "/></td>
					    		</tr>
					    		<tr>
					    			<td style="text-align:right">能源材料费：</td>
					    			<td><input type='text' name='fundPaymentBudgetBudgetCount3' value='${resultMap.fundPaymentBudgetBudgetCount3}' class="validate[custom[number],custom[positiveNum] ,maxSize[5]] inputText" onblur="countFundBudget(1,this)"  style="width: 84%; "/></td>
					    			<td><input type='text' name='fundPaymentBudgetOneOfFund3' value='${resultMap.fundPaymentBudgetOneOfFund3}' class="validate[custom[number],custom[positiveNum] , maxSize[5]] inputText" onblur="countFundBudget(2,this)"  style="width: 84%; "/></td>
					    			<td><input type='text' name='fundPaymentBudgetRemark3' value='${resultMap.fundPaymentBudgetRemark3}' class="inputText"  style="width: 84%; "/></td>
					    		</tr>
					    		<tr>
					    			<td style="text-align:right">试验外协费：</td>
					    			<td><input type='text' name='fundPaymentBudgetBudgetCount4' value='${resultMap.fundPaymentBudgetBudgetCount4}' class="validate[custom[number],custom[positiveNum] , maxSize[5]] inputText" onblur="countFundBudget(1,this)" style="width: 84%; "/></td>
					    			<td><input type='text' name='fundPaymentBudgetOneOfFund4' value='${resultMap.fundPaymentBudgetOneOfFund4}' class="validate[custom[number],custom[positiveNum] ,maxSize[5]] inputText" onblur="countFundBudget(2,this)" style="width: 84%; "/></td>
					    			<td><input type='text' name='fundPaymentBudgetRemark4' value='${resultMap.fundPaymentBudgetRemark4}' class="inputText"  style="width: 84%; "/></td>
					    		</tr>
					    		<tr>
					    			<td style="text-align:right">差旅费：</td>
					    			<td><input type='text' name='fundPaymentBudgetBudgetCount5' value='${resultMap.fundPaymentBudgetBudgetCount5}' class="validate[custom[number],custom[positiveNum] , maxSize[5]] inputText" onblur="countFundBudget(1,this)" style="width: 84%; "/></td>
					    			<td><input type='text' name='fundPaymentBudgetOneOfFund5' value='${resultMap.fundPaymentBudgetOneOfFund5}' class="validate[custom[number],custom[positiveNum] , maxSize[5]] inputText" onblur="countFundBudget(2,this)" style="width: 84%; "/></td>
					    			<td><input type='text' name='fundPaymentBudgetRemark5' value='${resultMap.fundPaymentBudgetRemark5}' class="inputText"  style="width: 84%; "/></td>
					    		</tr>
					    		<tr>
					    			<td style="text-align:right">会议费：</td>
					    			<td><input type='text' name='fundPaymentBudgetBudgetCount6' value='${resultMap.fundPaymentBudgetBudgetCount6}' class="validate[custom[number],custom[positiveNum] , maxSize[5]] inputText" onblur="countFundBudget(1,this)" style="width: 84%; "/></td>
					    			<td><input type='text' name='fundPaymentBudgetOneOfFund6' value='${resultMap.fundPaymentBudgetOneOfFund6}' class="validate[custom[number],custom[positiveNum] , maxSize[5]] inputText" onblur="countFundBudget(2,this)" style="width: 84%; "/></td>
					    			<td><input type='text' name='fundPaymentBudgetRemark6' value='${resultMap.fundPaymentBudgetRemark6}' class="inputText"  style="width: 84%; "/></td>
					    		</tr>
					    		<tr>
					    			<td style="text-align:right">管理费：</td>
					    			<td><input type='text' name='fundPaymentBudgetBudgetCount7' value='${resultMap.fundPaymentBudgetBudgetCount7}' class="validate[custom[number],custom[positiveNum] , maxSize[5]] inputText" onblur="countFundBudget(1,this)" style="width: 84%; "/></td>
					    			<td><input type='text' name='fundPaymentBudgetOneOfFund7' value='${resultMap.fundPaymentBudgetOneOfFund7}' class="validate[custom[number],custom[positiveNum] , maxSize[5]] inputText" onblur="countFundBudget(2,this)"  style="width: 84%; "/></td>
					    			<td><input type='text' name='fundPaymentBudgetRemark7' value='${resultMap.fundPaymentBudgetRemark7}' class="inputText"  style="width: 84%; "/></td>
					    		</tr>
					    		<tr>
					    			<td style="text-align:right">其他相关费：</td>
					    			<td><input type='text' name='fundPaymentBudgetBudgetCount8' value='${resultMap.fundPaymentBudgetBudgetCount8}' class="validate[custom[number],custom[positiveNum] , maxSize[5]] inputText" onblur="countFundBudget(1,this)" style="width: 84%; "/></td>
					    			<td><input type='text' name='fundPaymentBudgetOneOfFund8' value='${resultMap.fundPaymentBudgetOneOfFund8}' class="validate[custom[number],custom[positiveNum] , maxSize[5]] inputText" onblur="countFundBudget(2,this)" style="width: 84%; "/></td>
					    			<td><input type='text' name='fundPaymentBudgetRemark8' value='${resultMap.fundPaymentBudgetRemark8}' class="inputText"  style="width: 84%; "/></td>
					    		</tr>
					    		<tr>
					    			<td style="text-align:right">合&#12288;计（自动计算）：</td>
					    			<td><input type='text' id="fundPaymentBudgetBudgetCountSum" name='fundPaymentBudgetBudgetCountSum' value='${resultMap.fundPaymentBudgetBudgetCountSum}' class="validate[custom[number]] inputText"  style="width: 84%; " readonly="readonly"/></td>
					    			<td><input type='text' id="fundPaymentBudgetOneOfFundSum" name='fundPaymentBudgetOneOfFundSum' value='${resultMap.fundPaymentBudgetOneOfFundSum}' class="validate[custom[number]] inputText"  style="width: 84%; " readonly="readonly"/></td>
					    			<td><input type='text' name='fundPaymentBudgetRemarkSum' value='${resultMap.fundPaymentBudgetRemarkSum}' class="inputText"  style="width: 84%; "/></td>
					    		</tr>
					    	</tbody>
		        		</tbody>
		        	</table>
		        	 </c:otherwise>
		        	</c:choose>
		        	<c:if test="${param.view != GlobalConstant.FLAG_Y}">
			        	<div align="center" style="margin-top: 10px">
			        		 <input id="prev" type="button" onclick="nextOpt('step5')" class="search" value="上一步"/>
       	                     <input id="nxt" type="button" onclick="nextOpt('finish')" class="search" value="完成"/>
			        	</div>
		        	</c:if>
				
				</form>