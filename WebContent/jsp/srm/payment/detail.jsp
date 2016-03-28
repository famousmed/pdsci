<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
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

function doClose() {
	jboxClose();
}

function modify(fundDetailFLow , itemFlow , money , content){
	$('#fundDetailFlow').val(fundDetailFLow);
	$('#money').val(money);
	$('input[name="content"]').val(content);
	$('#itemFlow').val(itemFlow);
}

function deleteDetail(fundDetailFlow){
	jboxConfirm("确认删除该条报销?" , function(){
		var requestData={"fundDetailFlow":fundDetailFlow};
		var url = "<s:url value='/srm/payment/deleteDetail' />";
		jboxStartLoading();
		jboxPost(url,requestData,function(resp){
			if(resp=="${GlobalConstant.DELETE_SUCCESSED}"){
				window.parent.frames['mainIframe'].window.search();
				window.location.reload();
			}
		},null,true);
	});
}

function reimburse(){
	var tip = "";
	 if(!$("#paymentForm").validationEngine("validate")){
		 return false;
	 }
	var itemFlow = $('#itemFlow').val();
	var currentAmount = parseFloat($('#money').val());
	var itemFLowTds = $('#appendTbody .'+itemFlow);
	$.each(itemFLowTds , function(i , n){
		currentAmount = parseFloat(currentAmount)+parseFloat($(n).html());
	});
	var budgetAmount = parseFloat($('#budget_'+itemFlow).val());
	if(currentAmount>budgetAmount){
		tip = "<span style='color:red;'>对于该报销项目中,报销总额已超过预算</span>，";
	}	
	jboxConfirm(tip+"确认报销?" , function(){
		jboxStartLoading();
		$('#paymentForm').submit();	
	});
	
}

function findAuditDetail(fundDetailFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/payment/showPaymentAudit?fundDetailFlow='/>"+fundDetailFlow,"操作信息", 800,600);
}

</script>

</head>
<body>
    <div class="mainright">
        <div class="content">
             <p style="font-weight: bold;font-size: 14px;"> 项目名称：${proj.projName} &nbsp;&nbsp;&nbsp;&nbsp;项目编号：${proj.projNo }&nbsp;&nbsp;&nbsp;&nbsp;项目类型：${proj.projTypeName}</p>     
             <br/>
            <form id="paymentForm" action="<s:url value='/srm/payment/reimburse'/>" method="post">
                <input type="hidden" id="fundFlow" name="fundFlow" value="${fundFlow}"/>
                <input type="hidden" id="fundDetailFlow" name="fundDetailFlow" value=""/>
                <table class="xllist">
                <tr>
			        <th width="10%">报销项目</th>
			        <th width="10%">报销金额(万元)</th>
			        <th>报销内容</th>
			        <th width="5%">操作</th>
		        </tr>
		        <tr>
			        <td style="text-align: center;">
				        <select class="validate[required]" name="itemFlow" id="itemFlow">
					        <option value="">请选择</option>
					        <c:forEach items="${schemeDetailList}" var="schemeItem">
						        <option value="${schemeItem.itemFlow}">${schemeItem.itemName}</option>
					        </c:forEach>
				        </select>
			        </td>
			        <td style="text-align: center;">
				        <input id="money" name="money" type="text" style="width: 90%;text-align: center;" class="validate[required,custom[number],min[0]]"/>
			        </td>
			        <td style="text-align: center;">
				        <input  name="content" type="text" style="width: 96%" class="validate[required]"/>
			        </td>
			        <td>
				        <a href="javascript:void(0);" onclick="reimburse();">报销</a>
			        </td>
		        </tr>
	        </table>
        </form>
        <br/>
	    <table style="width: 100%;" class="bs_tb">
		    <tr>
			    <th width="100px;">报销项目</th>
			    <th width="100px;">预算金额(万元)</th>
			    <th width="100px;">超出预算比例(%)</th>
			    <th width="100px;">报销金额(万元)</th>
			    
			    <th>报销内容(万元)</th>
			    <th width="100px;">进度</th>
			    <th width="150px;">操作</th>
		    </tr>
		    <tbody id="appendTbody">
		        <c:forEach items="${fundDetailMap}" var="detailEntry">
		                <c:forEach items="${detailEntry.value}" var="detail" varStatus="status">
		                <tr>
		                    <c:if test="${status.count==1}">
		                        <td rowspan="${detailEntry.value.size()}">
		                            <c:forEach items="${schemeDetailList}" var="schemeItem">
						                <c:if test='${schemeItem.itemFlow eq detailEntry.key}'>${schemeItem.itemName}</c:if>
					                </c:forEach>
		                        </td>
		                        <td rowspan="${detailEntry.value.size()}">${budgetFundDtlMap[detailEntry.key].money}</td>
		                        <td rowspan="${detailEntry.value.size()}">
		                            ${pdfn:getPercentByDouble(yetPaymentMap[detailEntry.key], budgetFundDtlMap[detailEntry.key].money)}
		                        </td>
		                    </c:if>
		                    <td class="${detail.itemFlow}">${detail.money}</td>
		                    <td>
		                        ${detail.content}
		                    </td>
		                    <td>
		                        ${detail.operStatusName}
		                        
		                    </td>
		                    <td>
		                        <c:if test="${detail.operStatusId==achStatusEnumRollBack.id}">
			                        <a href="javascript:void(0)" onclick="modify('${detail.fundDetailFlow}' , '${detail.itemFlow}' , '${detail.money}' , '${detail.content}')" id="modifyLink">[修改]</a>
			                        &nbsp;
			                        <a href="javascript:void(0)" onclick="deleteDetail('${detail.fundDetailFlow}')">[删除]</a>
			                    </c:if>
			                    &nbsp;
			                        <a href="javascript:void(0)" onclick="findAuditDetail('${detail.fundDetailFlow}')">[查看]</a>
		                    </td>
		                </tr>
		                </c:forEach>
		        </c:forEach>
		    </tbody>
	    </table>
    </div>
</div>	
<c:forEach var="budgetItem" items="${budgetFundDtlMap}">
 <input type="hidden" id="budget_${budgetItem.key}" value="${budgetItem.value.money}"/>
</c:forEach>	
</body>
</html>