<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
function nextOpt(step){
	if(false==$("#projForm").validationEngine("validate")){
		return false;
	}
	if(!budgetCalculate()){
		return false;
	}
	var form = $('#projForm');
	form.append('<input type="hidden" name="nextPageName" value="'+step+'"/>');
	$('#nxt').attr({"disabled":"disabled"});
	$('#prev').attr({"disabled":"disabled"});
	jboxStartLoading();
	form.submit();
}
function budgetCalculate(flag){
	$("#newFundTotalSpan").hide();
	$("#scienceFundTotalSpan").hide();
	 var newFundTotalVal=parseFloat($("#newFundTotal").val());
	  if (newFundTotalVal == null || newFundTotalVal == undefined || newFundTotalVal == '' || isNaN(newFundTotalVal)){
		  newFundTotalVal = 0;
		}
	  var scienceFundTotalVal=parseFloat($("#scienceFundTotal").val());
	  if (scienceFundTotalVal == null || scienceFundTotalVal == undefined || scienceFundTotalVal == '' || isNaN(scienceFundTotalVal)){
		  scienceFundTotalVal = 0;
		}
	for(var cell=2;cell<=4;){
		 var sumVal=0;
		 $("#budgetTb tr:not(:last) td:nth-child("+cell+")").each(function(){
			 var val = $(this).children("input").val();
			 if (val == null || val == undefined || val == '' || isNaN(val)){
					val = 0;
				}
			 if(parseFloat(val) < 0){
					return ;
				}
			 sumVal = parseFloat(sumVal)+parseFloat(val);
		  });
		  sumVal = sumVal.toFixed(3);
		 
		 if(cell==2 && parseFloat(sumVal)!=newFundTotalVal){
			 jboxTip("新增经费明细项之和与新增总经费不相等，请修改！");
			 $("#tipTb").show();
			 $("#newFundTotalSpan").show();
			 return false;
		 }
        if(cell==4 && parseFloat(sumVal)!=scienceFundTotalVal){
       	 jboxTip("卫生局投入经费明细项之和与卫生局投入总经费不相等，请修改！");
       	 $("#tipTb").show();
       	 $("#scienceFundTotalSpan").show();
       	 return false;
		 }
		 cell=cell+2;
	 }
	return true;
}
function calculate(index , obj){
	//横向求和
	var sumAcross = 0;
	var tds = $(obj).parent().parent().find("td:not(:eq(1),:first)");
	
	$.each(tds , function(i , o){
		var val = $(o).children("input").val();
		if (val == null || val == undefined || val == '' || isNaN(val)){
			val = 0;
		}
		if(parseFloat(val)<0){
			return ;
		}
		sumAcross = parseFloat(sumAcross)+parseFloat(val);
	});
	var sumInput = $(obj).parent().parent().find("td:eq(1)").children("input");
	sumInput.val(parseFloat(sumAcross.toFixed(3)));

	
	//纵向求和
	
	var sumStand = 0;
	 var cell = $(obj).parent()[0].cellIndex+1;
	 $("#fundTb tr:not(:first) td:nth-child("+cell+")").each(function(){
		 var val = $(this).children("input").val();
		 if (val == null || val == undefined || val == '' || isNaN(val)){
				val = 0;
			}
		 if(parseFloat(val) < 0){
				return ;
			}
		 sumStand = parseFloat(sumStand)+parseFloat(val);
	  });
	if(index==1){
		sumInput = $("input[name=sumFund1]");	
	}else if(index==2){
		sumInput = $("input[name=sumFund2]");
	}else if(index==3){
		sumInput = $("input[name=sumFund3]");
	}else if(index==4){
		sumInput = $("input[name=sumFund4]");
	}else if(index==5){
		sumInput = $("input[name=sumFund5]");
	}
	sumInput.val(parseFloat(sumStand.toFixed(3)));
	
	var t1 = $("#injectFundTotal").val();
	if(t1 == null || t1 == undefined || t1 == '' || isNaN(t1)){
		t1=0;
	}
	var injectFundTotalVal=parseFloat(t1);
	var t2 = $("#addFundTotal").val();
	if(t2 == null || t2 == undefined || t2 == '' || isNaN(t2)){
		t2=0;
	}
	var addFundTotalVal=parseFloat(t2);
	var sumFundTotalVal=injectFundTotalVal+addFundTotalVal;
	$("#sumFundTotal").val(parseFloat(sumFundTotalVal.toFixed(3)));
	
	//给新增经费总数赋值
	$("#newFundTotal").val($("#addFundTotal").val());

	//给其中卫生局经费赋值
	$("#scienceFundTotal").val($("#addFund2").val());
    
}
function removeTip(obj){
	 var cell = $(obj).parent()[0].cellIndex+1;
	 if(cell==2){
		 $("#newFundTotalSpan").hide();
	 }else if(cell==4){
		 $("#scienceFundTotalSpan").hide();
	 }
}

</script>
</c:if>
<style type="text/css">
.readInputText{border:0; border-bottom:0px solid #ccc;text-align: center;}
</style>
 	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post"
		id="projForm" style="position: relative;">
		<input type="hidden" id="pageName" name="pageName" value="step7"/>
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
		
		<font style="font-size: 14px; font-weight:bold;color: #333; ">八、经费概算及来源</font> 
		<c:choose>
		    <c:when test="${param.view == GlobalConstant.FLAG_Y}">
		        	<table width="100%" cellpadding="0" cellspacing="0" class="bs_tb" style="margin-top: 10px;">
		       		<thead>
				    	<tr>
							<th colspan="7" style="text-align: left;padding-left: 15px;font-size: 14px;font-weight: bold;" class="theader">1、经费筹集情况（经费单位：万元）</th>
						</tr>
				    	<tr>
				    		<td  style="text-align: center;" rowspan="2"></td>
				    		<td  style="text-align: center;"  rowspan="2">合计</td>
				    		<td  style="text-align: center;"  rowspan="2">自有资金</td>
				    		<td  style="text-align: center;"  colspan="2">政府部门</td>
				    		<td  style="text-align: center;"  rowspan="2">其他</td>
				    		
				    	</tr>
				    	<tr>
				    		<td  style="text-align: center;" >苏州市</td>
				    		<td  style="text-align: center;" >县、区</td>
				    		<!-- <td  style="text-align: center;" >其他部门</td> -->
				    	</tr>
			    	</thead>
				    <tbody id="fundTb">
				    	<tr>
				    		<td style="text-align: center;" width="10%">项目总投入</td>
				    		<td style="text-align: center;">${resultMap.sumFundTotal}</td>
				    		<td style="text-align: center;">${resultMap.sumFund1}</td>
				    		<td style="text-align: center;">${resultMap.sumFund2}</td>
				    		<td style="text-align: center;">${resultMap.sumFund3}</td>
				    		<%-- <td style="text-align: center;">${resultMap.sumFund4}</td> --%>
				    		<td style="text-align: center;">${resultMap.sumFund5}</td>
				    	    
				    	</tr>
				    	<tr>
				    		<td style="text-align: center;">已投入经费</td>
				    		<td style="text-align: center;">${resultMap.injectFundTotal}</td>
				    		<td style="text-align: center;">${resultMap.injectFund1}</td>
				    		<td style="text-align: center;">${resultMap.injectFund2}</td>
				    		<td style="text-align: center;">${resultMap.injectFund3}</td>
				    		<%-- <td style="text-align: center;">${resultMap.injectFund4}</td> --%>
				    		<td style="text-align: center;">${resultMap.injectFund5}</td>
				    	    
				    	</tr>
				    	<tr>
				    		<td style="text-align: center;">新增经费</td>
				    		<td style="text-align: center;">${resultMap.addFundTotal}</td>
				    		<td style="text-align: center;">${resultMap.addFund1}</td>
				    		<td style="text-align: center;">${resultMap.addFund2}</td>
				    		<td style="text-align: center;">${resultMap.addFund3}</td>
				    		<%-- <td style="text-align: center;">${resultMap.addFund4}</td> --%>
				    		<td style="text-align: center;">${resultMap.addFund5}</td>
				    	    
				    	</tr>
				    </tbody>
		       	</table>
		       	
		       	<table width="100%" cellpadding="0" cellspacing="0" class="bs_tb" style="margin-top: 10px;">
				    	<tr>
							<th colspan="7" style="text-align: left;padding-left: 15px;font-size: 14px;font-weight: bold;" class="theader">2、新增经费预算（单位：万元）</th>
						</tr>
				    	<tr>
				    		<td style="text-align: center;" colspan="3">新增总经费</td>
				    		<td style="text-align: center;" colspan="2">其中苏州市经费</td>
				    	</tr>
				    	<tr>
				    		<td width="10%" style="text-align: center;">科目</td>
				    		<td width="15%" style="text-align: center;">经费额</td>
				    		<td style="text-align: center;">用途说明</td>
				    		<td width="15%" style="text-align: center;">经费额</td>
				    		<td style="text-align: center;">用途说明</td>
				    	</tr>
				    <tbody id="budgetTb" >
						<tr>
							<td style="text-align: center;">设备购置费</td>
							<td style="text-align: center;">${resultMap.newFund1}</td>
							<td style="text-align: center;">${resultMap.newFund1Explain}</td>
							<td style="text-align: center;">${resultMap.scienceFund1}</td>
							<td style="text-align: center;">${resultMap.scienceFund1Explain}</td>
						</tr>
						<tr>
							<td style="text-align: center;">能源材料费</td>
							<td style="text-align: center;">${resultMap.newFund2}</td>
							<td style="text-align: center;">${resultMap.newFund2Explain}</td>
							<td style="text-align: center;">${resultMap.scienceFund2}</td>
							<td style="text-align: center;">${resultMap.scienceFund2Explain}</td>
						</tr>
						<tr>
							<td style="text-align: center;">试验外协费</td>
							<td style="text-align: center;">${resultMap.newFund3}</td>
							<td style="text-align: center;">${resultMap.newFund3Explain}</td>
							<td style="text-align: center;">${resultMap.scienceFund3}</td>
							<td style="text-align: center;">${resultMap.scienceFund3Explain}</td>
						</tr>
						<tr>
							<td style="text-align: center;">资料、印刷费</td>
							<td style="text-align: center;">${resultMap.newFund4}</td>
							<td style="text-align: center;">${resultMap.newFund4Explain}</td>
							<td style="text-align: center;">${resultMap.scienceFund4}</td>
							<td style="text-align: center;">${resultMap.scienceFund4Explain}</td>
						</tr>
						<tr>
							<td style="text-align: center;">租赁费</td>
							<td style="text-align: center;">${resultMap.newFund5}</td>
							<td style="text-align: center;">${resultMap.newFund5Explain}</td>
							<td style="text-align: center;">${resultMap.scienceFund5}</td>
							<td style="text-align: center;">${resultMap.scienceFund5Explain}</td>
						</tr>
						<tr>
							<td style="text-align: center;">差旅费</td>
							<td style="text-align: center;">${resultMap.newFund6}</td>
							<td style="text-align: center;">${resultMap.newFund6Explain}</td>
							<td style="text-align: center;">${resultMap.scienceFund6}</td>
							<td style="text-align: center;">${resultMap.scienceFund6Explain}</td>
						</tr>
						<tr>
							<td style="text-align: center;">鉴定、验收费</td>
							<td style="text-align: center;">${resultMap.newFund7}</td>
							<td style="text-align: center;">${resultMap.newFund7Explain}</td>
							<td style="text-align: center;">${resultMap.scienceFund7}</td>
							<td style="text-align: center;">${resultMap.scienceFund7Explain}</td>
						</tr>
						<tr>
							<td style="text-align: center;">管理费</td>
							<td style="text-align: center;">${resultMap.newFund8}</td>
							<td style="text-align: center;">${resultMap.newFund8Explain}</td>
							<td style="text-align: center;">${resultMap.scienceFund8}</td>
							<td style="text-align: center;">${resultMap.scienceFund8Explain}</td>
						</tr>
						<tr>
							<td style="text-align: center;">其他费用</td>
							<td style="text-align: center;">${resultMap.newFund9}</td>
							<td style="text-align: center;">${resultMap.newFund9Explain}</td>
							<td style="text-align: center;">${resultMap.scienceFund9}</td>
							<td style="text-align: center;">${resultMap.scienceFund9Explain}</td>
						</tr>
						<tr>
							<td style="text-align: center;">合计</td>
							<td style="text-align: center;">${resultMap.newFundTotal}</td>
							<td style="text-align: center;">${resultMap.newFundTotalExplain}</td>
							<td style="text-align: center;">${resultMap.scienceFundTotal}</td>
							<td style="text-align: center;">${resultMap.scienceFundTotalExplain}</td>
						</tr>
			    	</tbody>
			    </table>
		    </c:when>
		    
		    <c:otherwise>
		        	<table width="100%" cellpadding="0" cellspacing="0" class="basic" style="margin-top: 10px;">
		       		<thead>
				    	<tr>
							<th colspan="7" style="text-align: left;padding-left: 15px;font-size: 14px;font-weight: bold;">1、经费筹集情况（经费单位：万元）</th>
						</tr>
				    	<tr>
				    		<td  style="text-align: center;" rowspan="2"></td>
				    		<td  style="text-align: center;"  rowspan="2">合计</td>
				    		<td  style="text-align: center;"  rowspan="2">自有资金</td>
				    		<td  style="text-align: center;"  colspan="2">政府部门</td>
				    		<td  style="text-align: center;"  rowspan="2">其他</td>
				    		
				    	</tr>
				    	<tr>
				    		<td  style="text-align: center;" >苏州市</td>
				    		<td  style="text-align: center;" >县、区</td>
				    		<!-- <td  style="text-align: center;" >其他部门</td> -->
				    	</tr>
			    	</thead>
				    <tbody id="fundTb">
				    	<tr>
				    		<td style="text-align: center;" width="10%">项目总投入</td>
				    		<td style="text-align: center;"><input type="text" id="sumFundTotal" name="sumFundTotal" value="${resultMap.sumFundTotal}" readonly="readonly" class="readInputText validate[custom[number]]" style="width:80%;"/></td>
				    		<td style="text-align: center;"><input type="text" name="sumFund1" value="${resultMap.sumFund1}" onchange="calculate(this)" readonly="readonly" class="readInputText validate[custom[number]]" style="width:80%;"/></td>
				    		<td style="text-align: center;"><input type="text" id="sumFund2" name="sumFund2" value="${resultMap.sumFund2}" onchange="calculate(this)" readonly="readonly" class="readInputText validate[custom[number]]" style="width:80%;"/></td>
				    		<td style="text-align: center;"><input type="text" name="sumFund3" value="${resultMap.sumFund3}" onchange="calculate(this)" readonly="readonly" class="readInputText validate[custom[number]]" style="width:80%;"/></td>
				    		<%-- <td style="text-align: center;"><input type="text" name="sumFund4" value="${resultMap.sumFund4}" onchange="calculate(this)" readonly="readonly" class="readInputText validate[custom[number]]" style="width:80%;"/></td> --%>
				    		<td style="text-align: center;"><input type="text" name="sumFund5" value="${resultMap.sumFund5}" onchange="calculate(this)" readonly="readonly" class="readInputText validate[custom[number]]" style="width:80%;"/></td>
				    	    
				    	</tr>
				    	<tr>
				    		<td style="text-align: center;">已投入经费</td>
				    		<td style="text-align: center;"><input type="text" id="injectFundTotal" name="injectFundTotal" value="${resultMap.injectFundTotal}" readonly="readonly" class="readInputText validate[custom[number]]" style="width:80%;"/></td>
				    		<td style="text-align: center;"><input type="text" name="injectFund1" value="${resultMap.injectFund1}" onchange="calculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
				    		<td style="text-align: center;"><input type="text" name="injectFund2" value="${resultMap.injectFund2}" onchange="calculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
				    		<td style="text-align: center;"><input type="text" name="injectFund3" value="${resultMap.injectFund3}" onchange="calculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
				    		<%-- <td style="text-align: center;"><input type="text" name="injectFund4" value="${resultMap.injectFund4}" onchange="calculate(4,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td> --%>
				    		<td style="text-align: center;"><input type="text" name="injectFund5" value="${resultMap.injectFund5}" onchange="calculate(5,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
				    	    
				    	</tr>
				    	<tr>
				    		<td style="text-align: center;">新增经费</td>
				    		<td style="text-align: center;"><input type="text" id="addFundTotal" name="addFundTotal" value="${resultMap.addFundTotal}" readonly="readonly" class="readInputText validate[custom[number]]" style="width:80%;"/></td>
				    		<td style="text-align: center;"><input type="text" name="addFund1" value="${resultMap.addFund1}" onchange="calculate(1,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
				    		<td style="text-align: center;"><input type="text" id="addFund2" name="addFund2" value="${resultMap.addFund2}" onchange="calculate(2,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
				    		<td style="text-align: center;"><input type="text" name="addFund3" value="${resultMap.addFund3}" onchange="calculate(3,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
				    		<%-- <td style="text-align: center;"><input type="text" name="addFund4" value="${resultMap.addFund4}" onchange="calculate(4,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td> --%>
				    		<td style="text-align: center;"><input type="text" name="addFund5" value="${resultMap.addFund5}" onchange="calculate(5,this)" class="inputText validate[custom[number]]" style="width:80%;"/></td>
				    	    
				    	</tr>
				    </tbody>
		       	</table>
		       	
		       	<table width="100%" cellpadding="0" cellspacing="0" class="basic" style="margin-top: 10px;">
		       		<thead>
				    	<tr>
							<th colspan="7" style="text-align: left;padding-left: 15px;font-size: 14px;font-weight: bold;">2、新增经费预算（单位：万元）</th>
						</tr>
				    	<tr>
				    		<td style="text-align: center;" colspan="3">新增总经费</td>
				    		<td style="text-align: center;" colspan="2">其中苏州市经费</td>
				    	</tr>
				    	<tr>
				    		<td width="10%" style="text-align: center;">科目</td>
				    		<td width="15%" style="text-align: center;">经费额</td>
				    		<td style="text-align: center;">用途说明</td>
				    		<td width="15%" style="text-align: center;">经费额</td>
				    		<td style="text-align: center;">用途说明</td>
				    	</tr>
			    	</thead>
				    <tbody id="budgetTb" >
						<tr>
							<td style="text-align: center;">设备购置费</td>
							<td style="text-align: center;"><input type="text" name="newFund1" value="${resultMap.newFund1}"  class="inputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);"/></td>
							<td style="text-align: center;"><input type="text" name="newFund1Explain" value="${resultMap.newFund1Explain}" class="inputText" style="width:80%;"/></td>
							<td style="text-align: center;"><input type="text" name="scienceFund1" value="${resultMap.scienceFund1}"  class="inputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);"/></td>
							<td style="text-align: center;"><input type="text" name="scienceFund1Explain" value="${resultMap.scienceFund1Explain}" class="inputText" style="width:80%;"/></td>
						</tr>
						<tr>
							<td style="text-align: center;">能源材料费</td>
							<td style="text-align: center;"><input type="text" name="newFund2" value="${resultMap.newFund2}"  class="inputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);"/></td>
							<td style="text-align: center;"><input type="text" name="newFund2Explain" value="${resultMap.newFund2Explain}" class="inputText" style="width:80%;"/></td>
							<td style="text-align: center;"><input type="text" name="scienceFund2" value="${resultMap.scienceFund2}"  class="inputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);"/></td>
							<td style="text-align: center;"><input type="text" name="scienceFund2Explain" value="${resultMap.scienceFund2Explain}" class="inputText" style="width:80%;"/></td>
						</tr>
						<tr>
							<td style="text-align: center;">试验外协费</td>
							<td style="text-align: center;"><input type="text" name="newFund3" value="${resultMap.newFund3}"  class="inputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);"/></td>
							<td style="text-align: center;"><input type="text" name="newFund3Explain" value="${resultMap.newFund3Explain}" class="inputText" style="width:80%;"/></td>
							<td style="text-align: center;"><input type="text" name="scienceFund3" value="${resultMap.scienceFund3}"  class="inputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);"/></td>
							<td style="text-align: center;"><input type="text" name="scienceFund3Explain" value="${resultMap.scienceFund3Explain}" class="inputText" style="width:80%;"/></td>
						</tr>
						<tr>
							<td style="text-align: center;">资料、印刷费</td>
							<td style="text-align: center;"><input type="text" name="newFund4" value="${resultMap.newFund4}"  class="inputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);"/></td>
							<td style="text-align: center;"><input type="text" name="newFund4Explain" value="${resultMap.newFund4Explain}" class="inputText" style="width:80%;"/></td>
							<td style="text-align: center;"><input type="text" name="scienceFund4" value="${resultMap.scienceFund4}"  class="inputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);"/></td>
							<td style="text-align: center;"><input type="text" name="scienceFund4Explain" value="${resultMap.scienceFund4Explain}" class="inputText" style="width:80%;"/></td>
						</tr>
						<tr>
							<td style="text-align: center;">租赁费</td>
							<td style="text-align: center;"><input type="text" name="newFund5" value="${resultMap.newFund5}"  class="inputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);"/></td>
							<td style="text-align: center;"><input type="text" name="newFund5Explain" value="${resultMap.newFund5Explain}" class="inputText" style="width:80%;"/></td>
							<td style="text-align: center;"><input type="text" name="scienceFund5" value="${resultMap.scienceFund5}"  class="inputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);"/></td>
							<td style="text-align: center;"><input type="text" name="scienceFund5Explain" value="${resultMap.scienceFund5Explain}" class="inputText" style="width:80%;"/></td>
						</tr>
						<tr>
							<td style="text-align: center;">差旅费</td>
							<td style="text-align: center;"><input type="text" name="newFund6" value="${resultMap.newFund6}"  class="inputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);"/></td>
							<td style="text-align: center;"><input type="text" name="newFund6Explain" value="${resultMap.newFund6Explain}" class="inputText" style="width:80%;"/></td>
							<td style="text-align: center;"><input type="text" name="scienceFund6" value="${resultMap.scienceFund6}"  class="inputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);"/></td>
							<td style="text-align: center;"><input type="text" name="scienceFund6Explain" value="${resultMap.scienceFund6Explain}" class="inputText" style="width:80%;"/></td>
						</tr>
						<tr>
							<td style="text-align: center;">鉴定、验收费</td>
							<td style="text-align: center;"><input type="text" name="newFund7" value="${resultMap.newFund7}"  class="inputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);"/></td>
							<td style="text-align: center;"><input type="text" name="newFund7Explain" value="${resultMap.newFund7Explain}" class="inputText" style="width:80%;"/></td>
							<td style="text-align: center;"><input type="text" name="scienceFund7" value="${resultMap.scienceFund7}"  class="inputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);"/></td>
							<td style="text-align: center;"><input type="text" name="scienceFund7Explain" value="${resultMap.scienceFund7Explain}" class="inputText" style="width:80%;"/></td>
						</tr>
						<tr>
							<td style="text-align: center;">管理费</td>
							<td style="text-align: center;"><input type="text" name="newFund8" value="${resultMap.newFund8}"  class="inputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);"/></td>
							<td style="text-align: center;"><input type="text" name="newFund8Explain" value="${resultMap.newFund8Explain}" class="inputText" style="width:80%;"/></td>
							<td style="text-align: center;"><input type="text" name="scienceFund8" value="${resultMap.scienceFund8}"  class="inputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);"/></td>
							<td style="text-align: center;"><input type="text" name="scienceFund8Explain" value="${resultMap.scienceFund8Explain}" class="inputText" style="width:80%;"/></td>
						</tr>
						<tr>
							<td style="text-align: center;">其他费用</td>
							<td style="text-align: center;"><input type="text" name="newFund9" value="${resultMap.newFund9}"  class="inputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);"/></td>
							<td style="text-align: center;"><input type="text" name="newFund9Explain" value="${resultMap.newFund9Explain}" class="inputText" style="width:80%;"/></td>
							<td style="text-align: center;"><input type="text" name="scienceFund9" value="${resultMap.scienceFund9}"  class="inputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);"/></td>
							<td style="text-align: center;"><input type="text" name="scienceFund9Explain" value="${resultMap.scienceFund9Explain}" class="inputText" style="width:80%;"/></td>
						</tr>
						<tr>
							<td style="text-align: center;">合计</td>
							<td style="text-align: center;"><input type="text" id="newFundTotal" name="newFundTotal" value="${resultMap.newFundTotal}"  class="readInputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);" readonly="readonly"/></td>
							<td style="text-align: center;"><input type="text" name="newFundTotalExplain" value="${resultMap.newFundTotalExplain}" class="inputText" style="width:80%;"/></td>
							<td style="text-align: center;"><input type="text" id="scienceFundTotal" name="scienceFundTotal" value="${resultMap.scienceFundTotal}"  class="readInputText validate[custom[number]]" style="width:80%;" onfocus="removeTip(this);" readonly="readonly"/></td>
							<td style="text-align: center;"><input type="text" name="scienceFundTotalExplain" value="${resultMap.scienceFundTotalExplain}" class="inputText" style="width:80%;"/></td>
						</tr>
						
			    	</tbody>
			    </table>
			     <table id="tipTb" width="100%" style="border-style: none;" >
						 <tr >
						    <td width="10%" height="20px;"></td>
						    <td width="15%" height="20px;"><span id="newFundTotalSpan" style="display: none;" class="red">明细项之和与合计不相等</span></td>
						    <td width="30%" height="20px;"></td>
						    <td width="15%" height="20px;"><span id="scienceFundTotalSpan" style="display: none;" class="red">明细项之和与合计不相等</span></td>
						    <td width="30%" height="20px;"></td>
						</tr>
				</table>
		    </c:otherwise>
		</c:choose>
       
       	
       	
       	<c:if test="${param.view != GlobalConstant.FLAG_Y}">
       	<div align="center" style="margin-top: 10px">
       	    <input id="prev" type="button" onclick="nextOpt('step6')" class="search" value="上一步"/>
       	    <input id="nxt" type="button" onclick="nextOpt('step8')" class="search" value="下一步"/>
       	</div>
       	</c:if>	          
	</form>
</body>

</html>