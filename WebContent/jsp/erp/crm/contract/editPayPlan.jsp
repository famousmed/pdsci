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
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="true"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_mask" value="true"/>
</jsp:include>
<script type="text/javascript" src="<s:url value='/js/j.suggest.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
$(document).ready(function(){
	if($("#payPlanTb tr").length<=0){
		addPayPlan();
	}
	moneyMask();
});
function moneyMask(){
	var moneyBox=$(".money");
	$.each(moneyBox,function(i,n){
		$(n).mask('000,000,000,000,000', {reverse: true});
	});
}

function reMoneyMask(){
	var moneyBox=$(".money");
	$.each(moneyBox,function(i,n){
		$(n).mask('000000000000000', {reverse: true});
	});
}

function moneyObjMask(obj){
	$(obj).mask('000,000,000,000,000', {reverse: true});
}

function reMoneyObjMask(obj){
	$(obj).mask('000000000000000', {reverse: true});
}

function save(){
		if($("#planForm").validationEngine("validate")){
			reMoneyMask();
		}else{
			moneyMask();
			return false;
		}
	    
		var payPlanTr=$("#payPlanTb").children();
		var payPlanDatas=[];
		 $.each(payPlanTr , function(i , n){
			    var planFlow=$(n).find("input[name='planFlow']").val();
				var contractFlow=$(n).find("input[name='contractFlow']").val();
				var planDate=$(n).find("input[name='planDate']").val();
				var payFund=$(n).find("input[name='payFund']").val();
				if(planDate=="" && payFund==""){
					$(n).remove();
				}else{
					var payPlanData={
							"planFlow":planFlow,
							"contractFlow":contractFlow,
							"planDate":planDate,
							"payFund":payFund
					};
					payPlanDatas.push(payPlanData);
				}
				
			});
			 $("#saveButton").attr("disabled",true);
			 var allData={
					 'payPlanList':payPlanDatas 
				};
			 $('#jsondata').val(JSON.stringify(allData));
			 var url = "<s:url value='/erp/crm/saveContractInfo'/>";
				jboxSubmit($('#planForm'),url,function(resp){
					jboxTip('${GlobalConstant.SAVE_SUCCESSED}');
					setTimeout(function(){
						window.parent.frames['jbox-message-iframe'].window.search();
						jboxClose();
					},1000);
				},
				function(resp){
				},false);
		 
		
}

function addPayPlan(){
	$('#payPlanTb').append($("#payPlanClone tr:eq(0)").clone());
	moneyMask();
}

function delPayPlan(){
	var mIds = $("#payPlanTb input[name='id']:checked");
	if(mIds.length == 0){
		jboxTip("请勾选要删除的！");
		return false;
	}
	jboxConfirm("确认删除？", function() {
		var ids = "";
		mIds.each(function(){
			var id = $(this).val();
			if(id != ''){
				ids = ids + "id="+ id + "&";
			}else{
				$(this).parent().parent().remove();
			}
		});
	});
}

function timeMask(obj){
	reMoneyObjMask($(obj));
	setTimeout(function(){
		moneyObjMask($(obj));
	},100);
}

</script>
</head>
<body>
<div class="mainright">
<div class="content">
	<div class="title1 clearfix">
			<form id="planForm" >
			    <input id="jsondata" type="hidden" name="jsondata"/>
				<table cellpadding="0" cellspacing="0" class="xllist" style="width: 100%;">
					<colgroup>
						<col width="5%"/>
						<col width="45%"/>
						<col width="50%"/>
						<!-- <col width="15%"/> -->
					</colgroup>
					<tr>
						<th colspan="3" style="text-align: left;padding-left: 10px">款项执行计划
							<img title="删除" src="<s:url value="/css/skin/${skinPath}/images/del1.png" />" style="float: right;margin-right: 20px;cursor: pointer;" onclick="delPayPlan();"/>
							<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="float: right;margin-right: 10px;cursor: pointer;" onclick="addPayPlan();"/>
						</th>
					</tr>
					<tr>
						<th></th>
						<th>计划日期</th>
						<th>计划金额</th>
						<!-- <th>状态</th> -->
					</tr>
					<tbody id="payPlanTb">
					  <c:forEach items="${payPlanList }" var="plan">
					   <tr>
		                 <td>
		                  <input type="checkbox" name="id" value="" style="display: none;"/>
		                  <input type="hidden" name="planFlow" value="${plan.planFlow }"/>
		                  <input type="hidden" name="contractFlow" value="${plan.contractFlow }"/>
		                 </td>
		                 <td>
		                    <c:choose>
		                    <c:when test="${empty plan.planStatusId or plan.planStatusId eq payPlanStatusEnumNotStart.id}">
		                    <input type="text" value="${plan.planDate }" class="inputText ctime" name="planDate" style="width: 130px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		                    </c:when>
		                    <c:otherwise>
		                      <label>${plan.planDate }</label>
		                      <input type="hidden" value="${plan.planDate }" class="inputText ctime" name="planDate" style="width: 130px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		                    </c:otherwise>
		                    </c:choose>
		                 </td>
		                 <td>
		                    <c:choose>
		                    <c:when test="${empty plan.planStatusId or plan.planStatusId eq payPlanStatusEnumNotStart.id}">
		                    <input type="text" value="${plan.payFund }" class="inputText validate[custom[number],maxSize[9]] money" name="payFund" style="width: 150px;" onblur="timeMask(this);"/>元
		                    </c:when>
		                    <c:otherwise>
		                      <label class="money">${plan.payFund }</label>
		                      <input type="hidden" value="${plan.payFund }" class="inputText validate[custom[number],maxSize[9]] money" name="payFund" style="width: 150px;" onblur="timeMask(this);"/>元
		                    </c:otherwise>
		                    </c:choose>
		                    
		                 </td>
		                <!--  <td></td> -->
	                   </tr>
	                  </c:forEach>
					</tbody>
				</table>
				<div class="button" style="width: 100%">
					<input id="saveButton" class="search" type="button" value="保&#12288;存" onclick="save();" />
					<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
				</div>
			</form>
			</div>
		</div>
	</div>


<table style="display: none;" id="payPlanClone">
	<tr>
		<td>
		<input type="checkbox" name="id" value=""/>
		<input type="hidden" name="planFlow"/>
		<input type="hidden" name="contractFlow" value="${param.contractFlow }"/>
		</td>
		<td><input type="text" class="inputText ctime validate[required]" name="planDate" style="width: 130px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		</td>
		<td><input type="text" class="money inputText validate[required,custom[number],maxSize[9]]" name="payFund" style="width: 150px;" onblur="timeMask(this);"/>元
		</td>
		<!-- <td></td> -->
	</tr>
</table>
</body>
</html>