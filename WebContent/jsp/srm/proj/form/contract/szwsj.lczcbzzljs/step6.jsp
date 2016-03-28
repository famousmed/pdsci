<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<jsp:useBean id="now" class="java.util.Date" /> 

<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<script type="text/javascript">
function nextOpt(step){
	 if(false==$("#projForm").validationEngine("validate")){
		return false;
	}
	var form = $("#projForm");
	form.append('<input type="hidden" name="nextPageName" value="'+step+'"/>');
	$('#nxt').attr({"disabled":"disabled"});
	$('#prev').attr({"disabled":"disabled"});
	jboxStartLoading();
	form.submit();
}
function countFund(obj){
	var sumVal = 0;
	var trs = $(obj).parent().parent().parent().find("tr:not(:last)");
	$.each(trs , function(i , o){
			var val = $(o).find("td").children("input").val();
			if (val == null || val == undefined || val == '' || isNaN(val)){
				val = 0;
			}
			if(parseFloat(val)<0){
				return ;
			}
			sumVal = parseFloat(sumVal)+parseFloat(val);
	         
	});
	var sumInput = $(obj).parent().parent().parent().find("tr:last").find("td").children("input");
	sumInput.val(parseFloat(parseFloat(sumVal.toFixed(3))));
}

function countFundBudget(index , obj){
	 var sumVal = 0;
	 var cell = $(obj).parent()[0].cellIndex+1;
	 $("#budgetTb tr:not(:last) td:nth-child("+cell+")").each(function(){
		 var val = $(this).children("input").val();
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
	  });
	if(index==1){
		sumInput = $("#sumyear1");	
	}else if(index==2){
		sumInput = $("#sumyear2");
	}else if(index==3){
		sumInput = $("#sumyear3");
	}
	sumInput.val(parseFloat(parseFloat(sumVal.toFixed(3))));
	
}
</script>
</c:if>

	        	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post"
				id="projForm" style="position: relative;">
					<input type="hidden" id="pageName" name="pageName" value="step6"/>
					<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
	                <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
					<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
					<table width="100%" cellspacing="0" cellpadding="0" class="basic">
			        	    <c:choose>
			        	      <c:when test="${param.view == GlobalConstant.FLAG_Y}">
			        	         <tr>
									<th colspan="4" style="text-align: left;padding-left: 15px;font-size: 14px;font-weight: bold;">六、经费预算</th>
								</tr>
								<tbody>
			        			<tr>
						    		<td width="20%" style="text-align: right;">甲方资助金额：</td>
						    		<td colspan="3" width="80%">
				                       &#12288;&#12288;${resultMap.jiaFund}&#12288;&#12288;万元
				                    </td>
						    	</tr>
						    	<tr>
						    		<td width="20%" style="text-align: right;">乙方匹配金额：</td>
						    		<td colspan="3" width="80%">
				                       	&#12288;&#12288;${resultMap.yiFund}&#12288;&#12288;万元
				                    </td>
						    	</tr>
						    	<tr>
						    		<td width="20%" style="text-align: right;">丙方资助金额：</td>
						    		<td colspan="3" width="80%">
				                       	&#12288;&#12288;${resultMap.bingFund}&#12288;&#12288;万元
				                    </td>
						    	</tr>
						    	<tr>
						    		<td width="20%" style="text-align: right;">其他经费来源：</td>
						    		<td colspan="3" width="80%">
				                       	&#12288;&#12288;${resultMap.otherFund}&#12288;&#12288;万元
				                    </td>
						    	</tr>
						    	<tr>
						    		<td width="20%" style="text-align: right;">合&#12288;计：</td>
						    		<td colspan="3" width="80%">
				                       	&#12288;&#12288;${resultMap.sumFund}&#12288;&#12288;万元
				                    </td>
						    	</tr>
						    	</tbody>
						    	<tr>
						    		<td style="text-align: right;">申请资助的预算支出科目：</td>
						    		<td style="text-align: center;">
						    			<fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy" var="bb"/>
				                       	${resultMap.year1}
				                   </td>
				                    <td style="text-align: center;">
				                        ${resultMap.year2}
				                    </td> 
				                    <td style="text-align: center;">
				                        ${resultMap.year3}
				                    </td>
						    	</tr>
						    	<tbody id="budgetTb">
						    	<tr>
						    		<td style="text-align: right;">国内外进修费用：</td>
						    		<td style="text-align: center;">
				                       ${resultMap.cost1year1}
				                    </td>
				                    <td style="text-align: center;">
				                       ${resultMap.cost1year2}
				                    </td>
				                    <td style="text-align: center;">
				                       ${resultMap.cost1year3}
				                    </td>
						    	</tr>
						    	<tr>
						    		<td style="text-align: right;">学术交流费用：</td>
						    		<td style="text-align: center;">
				                       	${resultMap.cost2year1}
				                    </td>
				                    <td style="text-align: center;">
				                       	${resultMap.cost2year2}
				                    </td>
				                    <td style="text-align: center;">
				                       	${resultMap.cost2year3}
				                    </td>
						    	</tr>
						    	<tr>
						    		<td style="text-align: right;">仪器设备费：</td>
						    		<td style="text-align: center;">
				                       	${resultMap.cost3year1}
				                    </td>
				                    <td style="text-align: center;">
				                       	${resultMap.cost3year2}
				                    </td>
				                    <td style="text-align: center;">
				                        ${resultMap.cost3year3}
				                    </td>
						    	</tr>
						    	<tr>
						    		<td style="text-align: right;">实验材料费：</td>
						    		<td style="text-align: center;">
				                       ${resultMap.cost4year1}
				                    </td>
				                    <td style="text-align: center;">
				                       ${resultMap.cost4year2}
				                    </td>
				                    <td style="text-align: center;">
				                       ${resultMap.cost4year3}
				                    </td>
						    	</tr>
						    	<tr>
						    		<td style="text-align: right;">购买图书、资料费：</td>
						    		<td style="text-align: center;">
				                       ${resultMap.cost5year1}
				                    </td>
				                    <td style="text-align: center;">
				                       ${resultMap.cost5year2}
				                    </td>
				                    <td style="text-align: center;">
				                      ${resultMap.cost5year3}
				                    </td>
						    	</tr>
						    	<tr>
						    		<td style="text-align: right;">项目研究费用：</td>
						    		<td style="text-align: center;">
				                       	${resultMap.cost6year1}
				                    </td>
				                    <td style="text-align: center;">
				                       	${resultMap.cost6year2}
				                    </td>
				                    <td style="text-align: center;">
				                       ${resultMap.cost6year3}
				                    </td>
						    	</tr>
						    	<tr>
						    		<td style="text-align: right;">其他费用：</td>
						    		<td style="text-align: center;">
				                       	${resultMap.cost7year1}
				                    </td>
				                    <td style="text-align: center;">
				                       ${resultMap.cost7year2}
				                    </td>
				                    <td style="text-align: center;">
				                       ${resultMap.cost7year3}
				                    </td>
						    	</tr>
						    	<tr>
						    		<td style="text-align: right;">合&#12288;计：</td>
						    		<td style="text-align: center;">
				                       ${resultMap.sumyear1}
				                    </td>
				                    <td style="text-align: center;">
				                       ${resultMap.sumyear2}
				                    </td>
				                    <td style="text-align: center;">
				                       ${resultMap.sumyear3}
				                    </td>
						    	</tr>
			        		</tbody>
			        	      </c:when>
			        	      <c:otherwise>
			        			<tr>
									<th colspan="4" style="text-align: left;padding-left: 15px;font-size: 14px;font-weight: bold;">六、经费预算</th>
								</tr>
								<tbody>
			        			<tr>
						    		<td width="20%" style="text-align: right;">甲方资助金额：</td>
						    		<td colspan="3" width="80%">
				                       	<input name="jiaFund" type="text" value="${resultMap.jiaFund}"  class="inputText"  style="width: 250px; " onchange="countFund(this);" placeholder="甲方：苏州市卫生局"/>&#12288;万元
				                    </td>
						    	</tr>
						    	<tr>
						    		<td width="20%" style="text-align: right;">乙方匹配金额：</td>
						    		<td colspan="3" width="80%">
				                       	<input name="yiFund" type="text" value="${resultMap.yiFund}"  class="inputText"  style="width: 250px; " onchange="countFund(this);" placeholder="乙方：项目承担单位"/>&#12288;万元
				                    </td>
						    	</tr>
						    	<tr>
						    		<td width="20%" style="text-align: right;">丙方资助金额：</td>
						    		<td colspan="3" width="80%">
				                       	<input name="bingFund" type="text" value="${resultMap.bingFund}"  class="inputText"  style="width:250px; " onchange="countFund(this);" placeholder="丙方：市(县)、区卫生局"/>&#12288;万元
				                    </td>
						    	</tr>
						    	<tr>
						    		<td width="20%" style="text-align: right;">其他经费来源：</td>
						    		<td colspan="3" width="80%">
				                       	<input name="otherFund" type="text" value="${resultMap.otherFund}"  class="inputText"  style="width: 250px; " onchange="countFund(this);"/>&#12288;万元
				                    </td>
						    	</tr>
						    	<tr>
						    		<td width="20%" style="text-align: right;">合&#12288;计：</td>
						    		<td colspan="3" width="80%">
				                       	<input name="sumFund" type="text" value="${resultMap.sumFund}"  class="inputText"  style="width: 250px; " readonly="readonly"/>&#12288;万元
				                    </td>
						    	</tr>
						    	</tbody>
						    	<tr>
						    		<td style="text-align: right;">申请资助的预算支出科目：</td>
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
						    	<tbody id="budgetTb">
						    	<tr>
						    		<td style="text-align: right;">国内外进修费用：</td>
						    		<td style="text-align: center;">
				                       	<input name="cost1year1" type="text" class='inputText' value='${resultMap.cost1year1}' onchange="countFundBudget(1,this);"/>
				                    </td>
				                    <td style="text-align: center;">
				                       	<input name="cost1year2" type="text" class='inputText' value='${resultMap.cost1year2}' onchange="countFundBudget(2,this);"/>
				                    </td>
				                    <td style="text-align: center;">
				                       	<input name="cost1year3" type="text" class='inputText' value='${resultMap.cost1year3}' onchange="countFundBudget(3,this);"/>
				                    </td>
						    	</tr>
						    	<tr>
						    		<td style="text-align: right;">学术交流费用：</td>
						    		<td style="text-align: center;">
				                       	<input name="cost2year1" type="text" class='inputText' value='${resultMap.cost2year1}' onchange="countFundBudget(1,this);"/>
				                    </td>
				                    <td style="text-align: center;">
				                       	<input name="cost2year2" type="text" class='inputText' value='${resultMap.cost2year2}' onchange="countFundBudget(2,this);"/>
				                    </td>
				                    <td style="text-align: center;">
				                       	<input name="cost2year3" type="text" class='inputText' value='${resultMap.cost2year3}' onchange="countFundBudget(3,this);"/>
				                    </td>
						    	</tr>
						    	<tr>
						    		<td style="text-align: right;">仪器设备费：</td>
						    		<td style="text-align: center;">
				                       	<input name="cost3year1" type="text" class='inputText' value='${resultMap.cost3year1}' onchange="countFundBudget(1,this);"/>
				                    </td>
				                    <td style="text-align: center;">
				                       	<input name="cost3year2" type="text" class='inputText' value='${resultMap.cost3year2}' onchange="countFundBudget(2,this);"/>
				                    </td>
				                    <td style="text-align: center;">
				                       	<input name="cost3year3" type="text" class='inputText' value='${resultMap.cost3year3}' onchange="countFundBudget(3,this);"/>
				                    </td>
						    	</tr>
						    	<tr>
						    		<td style="text-align: right;">实验材料费：</td>
						    		<td style="text-align: center;">
				                       	<input name="cost4year1" type="text" class='inputText' value='${resultMap.cost4year1}' onchange="countFundBudget(1,this);"/>
				                    </td>
				                    <td style="text-align: center;">
				                       	<input name="cost4year2" type="text" class='inputText' value='${resultMap.cost4year2}' onchange="countFundBudget(2,this);"/>
				                    </td>
				                    <td style="text-align: center;">
				                       	<input name="cost4year3" type="text" class='inputText' value='${resultMap.cost4year3}' onchange="countFundBudget(3,this);"/>
				                    </td>
						    	</tr>
						    	<tr>
						    		<td style="text-align: right;">购买图书、资料费：</td>
						    		<td style="text-align: center;">
				                       	<input name="cost5year1" type="text" class='inputText' value='${resultMap.cost5year1}' onchange="countFundBudget(1,this);"/>
				                    </td>
				                    <td style="text-align: center;">
				                       	<input name="cost5year2" type="text" class='inputText' value='${resultMap.cost5year2}' onchange="countFundBudget(2,this);"/>
				                    </td>
				                    <td style="text-align: center;">
				                       	<input name="cost5year3" type="text" class='inputText' value='${resultMap.cost5year3}' onchange="countFundBudget(3,this);"/>
				                    </td>
						    	</tr>
						    	<tr>
						    		<td style="text-align: right;">项目研究费用：</td>
						    		<td style="text-align: center;">
				                       	<input name="cost6year1" type="text" class='inputText' value='${resultMap.cost6year1}' onchange="countFundBudget(1,this);"/>
				                    </td>
				                    <td style="text-align: center;">
				                       	<input name="cost6year2" type="text" class='inputText' value='${resultMap.cost6year2}' onchange="countFundBudget(2,this);"/>
				                    </td>
				                    <td style="text-align: center;">
				                       	<input name="cost6year3" type="text" class='inputText' value='${resultMap.cost6year3}' onchange="countFundBudget(3,this);"/>
				                    </td>
						    	</tr>
						    	<tr>
						    		<td style="text-align: right;">其他费用：</td>
						    		<td style="text-align: center;">
				                       	<input name="cost7year1" type="text" class='inputText' value='${resultMap.cost7year1}' onchange="countFundBudget(1,this);"/>
				                    </td>
				                    <td style="text-align: center;">
				                       	<input name="cost7year2" type="text" class='inputText' value='${resultMap.cost7year2}' onchange="countFundBudget(2,this);"/>
				                    </td>
				                    <td style="text-align: center;">
				                       	<input name="cost7year3" type="text" class='inputText' value='${resultMap.cost7year3}' onchange="countFundBudget(3,this);"/>
				                    </td>
						    	</tr>
						    	<tr>
						    		<td style="text-align: right;">合&#12288;计：</td>
						    		<td style="text-align: center;">
				                       	<input name="sumyear1" id="sumyear1" type="text" class='inputText' value='${resultMap.sumyear1}' readonly="readonly"/>
				                    </td>
				                    <td style="text-align: center;">
				                       	<input name="sumyear2" id="sumyear2" type="text" class='inputText' value='${resultMap.sumyear2}' readonly="readonly"/>
				                    </td>
				                    <td style="text-align: center;">
				                       	<input name="sumyear3" id="sumyear3" type="text" class='inputText' value='${resultMap.sumyear3}' readonly="readonly"/>
				                    </td>
						    	</tr>
			        		</tbody>
			        		 </c:otherwise>
			        		</c:choose>
			        	</table>
			        	<c:if test="${param.view != GlobalConstant.FLAG_Y}">
			        	<div align="center" style="margin-top: 10px">
			        	 <input id="prev" type="button" onclick="nextOpt('step5')" class="search" value="上一步"/>
        	             <input id="nxt" type="button" onclick="nextOpt('finish')" class="search" value="完成"/>
			        	</div>
			        	</c:if>
				</form>
