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
var mainContractFlowArray=new Array();
var saveFlag=false;
function addFile(obj){
	var td=$(obj).parent();
	td.text("");
	td.append($("#file").clone());
	
}
function save(){
	reMoneyMask();
	 if($("#contractForm").validationEngine("validate")){
			/* if(checkDate($("#signDate"),$("#contractDueDate"),"签订日期大于合同到期日,请重新填写")==false){
				return false;
			}
			if(checkDate($("#contractDueDate"),$("#maintainDueDate"),"合同到期日期大于维护到期日,请重新填写")==false){
				return false;
			}
			if(checkDate($("#signDate"),$("#maintainDueDate"),"签订日期大于维护到期日,请重新填写")==false){
				return false;
			}	 */
		 var contractCategoryId=$("#contractCategoryId").val();
		 if ("${contractCategoryEnumSecond.id}"!=contractCategoryId) {
				$("#refTb").html("");
			}
		 var contract = $("#contractForm").serializeJson();
		 var mainContracts=$("#mainContactSpan").find("input[name='mainContract']:checked");
		 var refDatas=[];
		 $.each(mainContracts,function(i,n){
			 var contractFlow=$(n).val();
			 var refData={
				     "contractFlow":contractFlow	 
			 };
			 refDatas.push(refData);
		 });
		 $("#saveButton").attr("disabled",true);
		 var allData={
					'contract':contract,
					'refList':refDatas
			};
		 $('#jsondata').val(JSON.stringify(allData));
		 var url = "<s:url value='/erp/crm/saveContractInfo'/>?refType=Y";
			jboxSubmit($('#contractForm'),url,function(resp){
				if(resp=='${GlobalConstant.SAVE_FAIL}'){
					jboxTip('${GlobalConstant.SAVE_FAIL}');
				}else if(resp=='${GlobalConstant.FILE_BEYOND_LIMIT}'){
					jboxTip('${GlobalConstant.FILE_BEYOND_LIMIT}');
				}else{
					jboxTip('${GlobalConstant.SAVE_SUCCESSED}');
					setTimeout(function(){
						window.parent.frames['jbox-message-iframe'].window.search();
						jboxClose();
					},1000);
				}
			},
			function(resp){
			},false);
	 }else{
		 moneyMask();
		 return false;
	 }
}
$(function(){
	/*查询客户*/
	loadCustomerList();
});
 
function loadCustomerList() {
	var customers = new Array();
	var url = "<s:url value='/erp/crm/searchCustomerJson'/>";
	jboxPost(url,null,function(data){
		if(data!=null){
			for (var i = 0; i < data.length; i++) {
				var aliasName=data[i].aliasName;
				if(data[i].aliasName==null){
					aliasName="";
				}
				customers[i]=new Array(data[i].customerFlow,data[i].customerName,aliasName);
			}
		}
	},null,false);
	$("#searchParam_Customer").suggest(customers,{
		attachObject:'#suggest_Customer',
		dataContainer:'#result_Customer',
		triggerFunc:function(customerFlow){
			showMainContactInfo(customerFlow);
		},
	    enterFunc:function(customerFlow){
	    	showMainContactInfo(customerFlow);
	    }
	});
	$("#searchParam_Customer_other").suggest(customers,{
		attachObject:'#suggest_Customer_other',
		dataContainer:'#result_Customer_other',
		triggerFunc:function(customerFlow){
			showMainContactInfo(customerFlow);
		},
	    enterFunc:function(customerFlow){
	    	showMainContactInfo(customerFlow);
	    }
	});
}
function doClose(){
	jboxClose();
}
function changeContractCategoryTd(obj){
	 var secondTitle=$("#secondTitle");
	 var secondContent=$("#secondContent");
	 var thirdTitle=$("#thirdTitle");
	 var thirdContent=$("#thirdContent");
	 secondTitle.text("");
	 secondContent.text("");
	 thirdTitle.text("");
	 thirdContent.text("");
	 var contractCategoryId=$(obj).val();
	 if(contractCategoryId!=""){
		 if(contractCategoryId!='${contractCategoryEnumSecond.id}'){
			 secondTitle.html('<span class="red">*</span>合同类型：');
			 secondContent.append($("#clone_Sales").html());
		 }else{
			 secondTitle.html('<span class="red">*</span>合同类型：');
			 secondContent.append($("#clone_"+contractCategoryId).html());
		 }
		 if(contractCategoryId=='${contractCategoryEnumSell.id}'){
		     thirdTitle.html('<span class="red">*</span>经&nbsp;销&nbsp;&nbsp;商：');
		     thirdContent.append($("#clone_"+contractCategoryId).html());
		 }
			 
			 if ("${contractCategoryEnumSecond.id}"==$(obj).val()) {
					$("#mainContactTr").show();
					if($("#result_Customer").val()!=""){
						showMainContactInfo($("#result_Customer").val());
					}
				} else {
					$("#mainContactTr").hide();
				}
	 }
	 
}

$(document).ready(function(){
	var obj=$("#signDeptFlow");
	searchDeptUser(obj);
	moneyMask();
	<c:forEach items="${customerList}" var="customer">
	  mainContractFlowArray.push("${customer.customerFlow}");
	</c:forEach>
    	 $("#assistContractSpan").show();
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
function showMainContactInfo(customerFlow) {
	saveFlag=false;
	var contractFlow=$("#contractFlow").val();
	var mainContacts = "";
	jboxPost("<s:url value='/erp/crm/searchMainContact'/>?customerFlow="+customerFlow+"&contractFlow="+contractFlow,null,function(data){
		if(data!=null){
			for(var i=0;i<mainContractFlowArray.length;i++){
				if(mainContractFlowArray[i]==data['customer'].customerFlow){
					saveFlag=true;
				}
			}
			if(saveFlag==false){
				mainContractFlowArray.push(data['customer'].customerFlow);
			    mainContacts += data['customer'].customerName+"的主合同：<br/>";
			for ( var i = 0; i < data['contractList'].length; i++) {
				var ahref = 'javascript:contractInfo("'+data['contractList'][i].contractFlow+'");';
				mainContacts += "<input class='mainContract validate[required]' type='checkbox'  name='mainContract' value='"+data['contractList'][i].contractFlow+"'>"+
				"&#12288;<a href='"+ahref+"'>";
				if(data['contractList'][i].contractNo!=null && data['contractList'][i].contractNo!=""){
					mainContacts += data['contractList'][i].contractNo+"：";
				}
				mainContacts += data['contractList'][i].contractName+"</a>&#12288;<br/>";
			}
			$("#mainContactSpan").append(mainContacts);
		}
		}
		$("#assistContractSpan").show();
		if(customerFlow=='${contractExt.customerFlow}'){
			changeCheck();
		}
	},null,false);
	
}
function changeCheck(){
	var mainContacts=$("#mainContactSpan").find("input[name='mainContract']");
	var beforeRefTr=$("#beforeRefTb").children();
   $.each(mainContacts,function(a,b){
	   $.each(beforeRefTr,function(i,n){
	    	if($(b).val()==$(n).find("input[name='beforeContractFlow']").val()){
	    		$(b).attr("checked","checked");
	    	} 
	    }); 
   });
	
}

function searchDeptUser(obj){
	 var deptFlow=$(obj).val();
	 jboxPost("<s:url value='/erp/crm/searchDeptUserJson'/>?deptFlow="+deptFlow,null,function(data){
	 if(data!=null){
		 $("#signUserFlow").empty();
		 $("#signUserFlow").append('<option></option>');
		 $("#chargeUserFlow").empty();
		 $("#chargeUserFlow").append('<option></option>');
		 var dataSignUserFlow=$("#dataSignUserFlow").val();
		 var dataChargeUserFlow=$("#dataChargeUserFlow").val();
		 for ( var i = 0; i < data.length; i++) {
			   if(dataSignUserFlow==data[i].userFlow){
				   $("#signUserFlow").append('<option value="'+data[i].userFlow+'" selected>'+data[i].userName+'</option>');
			   }else{
				   $("#signUserFlow").append('<option value="'+data[i].userFlow+'">'+data[i].userName+'</option>');
			   }
			   if(dataChargeUserFlow==data[i].userFlow){
				   $("#chargeUserFlow").append('<option value="'+data[i].userFlow+'" selected>'+data[i].userName+'</option>');
			   }else{
				   $("#chargeUserFlow").append('<option value="'+data[i].userFlow+'">'+data[i].userName+'</option>');   
			   }
				
			 }
		 var signDeptName=$(obj).find("option:selected").text();
		 $("#signDeptName").val(signDeptName);
	  } 
	 },null,false);
}

function setUserName(id){
	 $("#"+id+"Name").val($("#"+id+"Flow").find("option:selected").text());
}

function resetCustomerName(name){
	 var customerFlow=$("#"+name+"_CustomerFlow").val();
	 var customerName=$("#"+name+"_CustomerName");
	 if(customerFlow==""){
		 customerName.val("");
	 }
}
function resetCustomerFlow(name){
	 var customerFlow=$("#"+name+"_CustomerFlow");
	 customerFlow.val("");
}
function checkDate(date1,date2,info){
	if($(date1).val()!="" && $(date2).val()!=""){
		 var date1Box=$(date1).val().split("-");
		 var date2Box=$(date2).val().split("-");
		 var date1Value="";
		 var date2Value="";
		 for(var i=0;i<date1Box.length;i++){
			 date1Value=date1Value+date1Box[i];
		 }
		 for(var i=0;i<date2Box.length;i++){
			 date2Value=date2Value+date2Box[i];
		 }
		 var date1Int=parseInt(date1Value);
		 var date2Int=parseInt(date2Value);
			 if(date1Int>date2Int){
				 jboxTip(info);
				 $(date1).val("");
				 $(date2).val("");
				 return false;
			 }else{
				 return true;
			 } 
	}
	
}
function checkContractNoOnlyOne(obj){
	$("#contractNoFlag").val('');
  	 var contractNo=$(obj).val();
  	 var contractFlow=$("#contractFlow").val();
  	 if(contractNo!="" && contractFlow!=""){
  		jboxPost("<s:url value='/erp/crm/checkContractNoOnlyOne'/>?contractNo="+contractNo+"&contractFlow="+contractFlow,null,function(resp){
  			if(resp=='${GlobalConstant.ONE_LINE}'){
  				jboxTip("该合同号已存在，请重新输入");
  				$(obj).val("");
  				$("#contractNoFlag").val('${GlobalConstant.FLAG_N}');
  			}
  		 },null,false);  
  	 }
}
function timeMask(obj){
	reMoneyObjMask($(obj));
	setTimeout(function(){
		moneyObjMask($(obj));
	},100);
}
function changeSellAndBuy(td1,td2){
	var contractCategoryId=$("#contractCategoryId").val();
	if(contractCategoryId=='${contractCategoryEnumSales.id}'
	|| contractCategoryId=='${contractCategoryEnumSecond.id}'
	|| contractCategoryId=='${contractCategoryEnumTrialAgreement.id}'){
		$("#"+td1).html('<span class=\"red\">*</span>买&#12288;&#12288;方：');
		$("#"+td2).html('<span class=\"red\">*</span>卖&#12288;&#12288;方：');
	}
	if(contractCategoryId=='${contractCategoryEnumPurchase.id}'){
		$("#"+td1).html('<span class=\"red\">*</span>卖&#12288;&#12288;方：');
		$("#"+td2).html('<span class=\"red\">*</span>买&#12288;&#12288;方：');
	}
	if(contractCategoryId=='${contractCategoryEnumSell.id}'){
		$("#"+td2).html('<span class=\"red\">*</span>卖&#12288;&#12288;方：');
		$("#"+td1).html('<span class=\"red\">*</span>使&nbsp;用&nbsp;&nbsp;方：');
	}
	
}
function adjustResults() {
	$("#suggest_Customer_other").css("left",$("#searchParam_Customer_other").offset().left);
	$("#suggest_Customer_other").css("top",$("#searchParam_Customer_other").offset().top+$("#searchParam_Customer_other").outerHeight());
}


function init(){
	$("#searchParam_Customer_other").hover(function() {
		adjustResults();
	},null);
}
</script>
</head>
<body>
<div class="mainright">
<div class="content">
	<div class="title1 clearfix">
	        <input type="hidden" id="contractNoFlag"/>
			<form id="contractForm" method="post" style="position: relative;" enctype="multipart/form-data">
				<input id="jsondata" type="hidden" name="jsondata"/>
				<input name="contractFlow" id="contractFlow" type="hidden" value="${contractExt.contractFlow }"/>
				<input type="hidden" id="dataSignUserFlow" value="${contractExt.signUserFlow }">
				<input type="hidden" id="dataChargeUserFlow" value="${contractExt.chargeUserFlow }">
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<colgroup>
						<col width="13%"/>
						<col width="20%"/>
						<col width="13%"/>
						<col width="20%"/>
						<col width="13%"/>
						<col width="20%"/>
					</colgroup>
					<tr>
						<th colspan="6" style="text-align: left;padding-left: 10px">合同信息
						<c:if test="${not empty contractExt.contractNo }">&#12288;[${contractExt.contractNo }]</c:if>
						</th>
					</tr>
					<tr>
					    <td style="text-align: right;padding-right: 10px;"><span class="red">*</span>合同类别：</td>
						<td style="text-align: left;">
							 <select class="inputText validate[required]" id="contractCategoryId" name="contractCategoryId" style="width: 90%;" onchange="changeContractCategoryTd(this);changeSellAndBuy('firstTd','secondTd');">
				            	<option value="">请选择</option>
				             	<c:forEach var="contractCategory" items="${contractCategoryEnumList}">
				             	   <c:if test="${empty refFlag or contractCategory.id != contractCategoryEnumSecond.id}">
				             	        <option value="${contractCategory.id}" <c:if test="${contractCategory.id eq contractExt.contractCategoryId }">selected="selected"</c:if>>${contractCategory.name}</option>
				             	   </c:if>
				             	</c:forEach> 
							</select> 
						</td>
						<td id="secondTitle" style="text-align: right;padding-right: 10px;"><span class="red">*</span>合同类型：</td>
						<td id="secondContent">
						 <c:if test="${contractExt.contractCategoryId eq contractCategoryEnumSecond.id }">
						     <select class="inputText validate[required]"  name="contractTypeId" style="width: 90%;">
                               <option value="">请选择</option>
	                           <c:forEach items="${contractTypeEnumList }" var="contractType">
	                               <c:if test="${contractType.categoryId eq 'Second' }">
	                               <option value="${contractType.id }" <c:if test="${contractType.id eq contractExt.contractTypeId }">selected="selected"</c:if>>${contractType.name }</option>
	                               </c:if>
	                            </c:forEach>
                             </select>
						  </c:if>
						  <c:if test="${contractExt.contractCategoryId != contractCategoryEnumSecond.id }">
						     <select class="inputText validate[required]"  name="contractTypeId" style="width: 90%;">
                               <option value="">请选择</option>
	                           <c:forEach items="${contractTypeEnumList }" var="contractType">
	                               <c:if test="${contractType.categoryId eq 'Sales' }">
	                               <option value="${contractType.id }" <c:if test="${contractType.id eq contractExt.contractTypeId }">selected="selected"</c:if>>${contractType.name }</option>
	                               </c:if>
	                            </c:forEach>
                             </select>
						  </c:if>
						</td>
					    <c:choose>
					     <c:when test="${contractExt.contractCategoryId eq contractCategoryEnumSell.id }">
						<td id="thirdTitle" style="text-align: right;padding-right: 10px;"><c:choose><c:when test="${contractExt.contractCategoryId == contractCategoryEnumSell.id }"><span class="red">*</span>经&nbsp;销&nbsp;&nbsp;商：</c:when><c:otherwise><span class="red">*</span>合同类型：</c:otherwise></c:choose></td>
						<td id="thirdContent">
						     <select name="consumerFlow" class="inputText validate[required]" style="width:90%;">
                                   <option value="">请选择</option>
                                   <c:forEach items="${consumerList }" var="consumer">
                                   <option value="${consumer.customerFlow }"<c:if test="${contractExt.consumerFlow eq consumer.customerFlow }">selected="selected"</c:if>>${consumer.customerName }</option>
                                   </c:forEach>
                               </select>
						</td>
						</c:when>
						<c:otherwise>
						<td id="thirdTitle" style="text-align: right;padding-right: 10px;"></td>
						<td id="thirdContent"></td>
						 </c:otherwise>
						</c:choose>
					   
					</tr>
					<tr>
					    <td style="text-align: right;padding-right: 10px;" id="firstTd"><span class="red">*</span><c:choose>
					      <c:when test="${(contractExt.contractCategoryId eq contractCategoryEnumSales.id) or (contractExt.contractCategoryId eq contractCategoryEnumSecond.id) or (contractExt.contractCategoryId eq contractCategoryEnumTrialAgreement.id)}">买&#12288;&#12288;方：
					      </c:when>
					      <c:otherwise><c:choose><c:when test="${contractExt.contractCategoryId eq contractCategoryEnumSell.id }">使&nbsp;用&nbsp;&nbsp;方：</c:when><c:otherwise>卖&#12288;&#12288;方：
					      </c:otherwise>
					      </c:choose>
					      </c:otherwise>
					     </c:choose>        
					    </td>
						<td>
							<input id="searchParam_Customer"  placeholder="输入客户名称/别名" class="inputText validate[required]"  style="width: 90%;text-align: left;" value="${contractExt.customer.customerName }" onblur="resetCustomerName('main');" onchange="resetCustomerFlow('main');"/>
				        	<div id="suggest_Customer" class="ac_results" style="margin:0;position: fixed; z-index: 100;width: 370px;"></div>
				        	<input type="hidden" id="result_Customer" name="customerFlow" value="${contractExt.customerFlow }"/>
				        	
			        	</td>
			        	<td style="text-align: right;padding-right: 10px;">使用部门：</td>
			        	<td style="text-align: left;">
			        	    <input type="text" name="customerDept" class="inputText validate[maxSize[50]]" style="width:90%;text-align: left;" value="${contractExt.customerDept }"/>
			        	</td>
			            <td style="text-align: right;padding-right: 10px;"><span class="red" style="padding-left: 7px;">*</span>合同名称：</td>
						<td><input class="inputText validate[required,maxSize[100]]" name="contractName" style="width:90%;text-align: left;" type="text" value="${contractExt.contractName }"/>
						</td>
								
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;" id="secondTd"><span class="red">*</span><c:choose>
					         <c:when test="${(contractExt.contractCategoryId eq contractCategoryEnumSales.id) or (contractExt.contractCategoryId eq contractCategoryEnumSecond.id) or (contractExt.contractCategoryId eq contractCategoryEnumTrialAgreement.id) or (contractExt.contractCategoryId eq contractCategoryEnumSell.id)}">卖&#12288;&#12288;方：
					         </c:when>
					        <c:otherwise>买&#12288;&#12288;方：
					        </c:otherwise>
					     </c:choose>
						</td>
						<td>
						    <select name="contractOwnId" class="inputText validate[required]" style="width: 90%;">
						       <c:forEach items="${companyNameEnumList }" var="companyName">
						        <option value="${companyName.id }" <c:if test="${contractExt.contractOwnId eq companyName.id }">selected="selected"</c:if>>${companyName.name }</option>
						       </c:forEach>
						    </select>
						</td>
						<td style="text-align: right;padding-right: 10px;"><span class="red">*</span>负责部门：</td>
						<td>
						  <select name="signDeptFlow" id="signDeptFlow" class="inputText validate[required]" onchange="searchDeptUser(this);" style="width: 90%;">
						       <option value="">请选择</option>
						       <c:forEach items="${deptList }" var="dept">
						         <option value="${dept.deptFlow }" <c:if test="${contractExt.signDeptFlow eq dept.deptFlow }">selected="selected"</c:if>>${dept.deptName }</option>
						       </c:forEach>
						   </select>
						   <input type="hidden" name="signDeptName" id="signDeptName" value="${contractExt.signDeptName }"/>
						</td>
						<td style="text-align: right;padding-right: 10px;"><span class="red">*</span>合同负责人：</td>
						<td>
						  <select name="chargeUserFlow" id="chargeUserFlow" class="inputText validate[required]" style="width: 90%;" onchange="setUserName('chargeUser');">
						   </select>
						   <input type="hidden" name="chargeUserName" id="chargeUserName" value="${contractExt.chargeUserName }"/>
						</td>
					</tr>
					
					<tr>
					    <td style="text-align: right;padding-right: 10px;"><!-- <span class="red">*</span> -->签&nbsp;订&nbsp;人：</td>
						<td>
						  <select name="signUserFlow" id="signUserFlow" class="inputText" style="width: 90%;" onchange="setUserName('signUser');">
						   </select>
						   <input type="hidden" name="signUserName" id="signUserName" value="${contractExt.signUserName }"/>
						</td>
						<td style="text-align: right;padding-right: 10px;"><span class="red">*</span>签订日期：</td>
						<td>
						<c:set var="signDateFmt" value="${empty contractExt.signDate?'yyyy':(pdfn:cutString(contractExt.signDate,2,false,0)) }"></c:set>
						<input type="text" class="inputText ctime validate[required]" name="signDate" id="signDate" value="${contractExt.signDate }" style="width: 90%;text-align: left;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
						</td>
						<td style="text-align: right;padding-right: 10px;">合同到期日：</td>
						<td><input class="inputText ctime" name="contractDueDate" id="contractDueDate" value="${contractExt.contractDueDate }" style="width: 90%;text-align: left;" type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
						</td>
					</tr>
					<tr>
					<tr>
					    <td style="text-align: right;padding-right: 10px;">维护到期日：</td>
						<td><input class="inputText ctime" name="maintainDueDate" id="maintainDueDate" value="${contractExt.maintainDueDate }" style="width: 90%;text-align: left;" type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
						</td>
					    <td style="text-align: right;padding-right: 10px;"><span class="red">*</span>合同金额：</td>
						<td><input class="inputText validate[required,custom[number],maxSize[9]] money" type="text" id="contractFund" name="contractFund" value="${contractExt.contractFund }" style="width: 80%;text-align: left;" onblur="timeMask(this);"/>元</td>
						<td style="text-align: right;padding-right: 10px;"><span class="red" style="padding-left: 12px;">*</span>合同状态：</td>
						<td>
						   <select name="contractStatusId" class="inputText validate[required]" style="width:90%;">
						       <option value="">请选择</option>
						       <c:forEach items="${contractStatusEnumList }" var="status">
						          <option value="${status.id }"<c:if test="${contractExt.contractStatusId eq status.id }">selected</c:if>>${status.name }</option>
						       </c:forEach>
						   </select>
						</td>	
					</tr>
					<tr>
					   <td style="text-align: right;padding-right: 10px;">电子原件：</td>
						<td colspan="5">
						 <c:choose>
						  <c:when test="${empty file.fileName}">
						    <input type="file" name="file" class="validate[custom[fileType]]"/><br/>
						    <span style="color: red">支持格式jpg，bmp，png，jpeg，doc，docx，pdf，zip，rar，文件小于100MB</span>
						  </c:when>
						  <c:otherwise>
						  <span>${file.fileName }</span>&#12288;<a href="javascript:void(0)" onclick="addFile(this);">[重新上传]</a>
						  </c:otherwise>
						 </c:choose>
						</td>
					</tr>
					<tr id="mainContactTr" <c:if test="${contractExt.contractCategoryId != contractCategoryEnumSecond.id }">style="display:none;"</c:if>>
					    <td style="text-align: right;padding-right: 10px;line-height: 25px;">关联主合同:</td>
					    <td colspan="5" id="mainContactTd" style="line-height: 25px;">
					     <span id="assistContractSpan" style="display:none;">
						      <font class="red">添加其他客户主合同：</font>
						      <input id="searchParam_Customer_other"  placeholder="输入客户名称/别名" class="inputText"  style="width: 200px;text-align: left;" onkeydown="adjustResults();" onfocus="adjustResults();"/>
				        	  <div id="suggest_Customer_other" class="ac_results" style="margin:0;position:fixed;width: 370px;"></div>
				        	  <input type="hidden" id="result_Customer_other" />  
				           </span><br/> 
					     <span id="mainContactSpan">
					        <c:forEach items="${customerList }" var="customer">
					          ${customer.customerName }的主合同：<br/>
					          <c:forEach items="${contractMap[customer.customerFlow] }" var="mainContract">
					             <input type="checkbox" class="validate[required]" name="mainContract" value="${mainContract.contractFlow }"  
					               <c:forEach items="${refExtList }" var="ref">
					                 <c:if test="${mainContract.contractFlow eq ref.contract.contractFlow }">checked="checked"</c:if> 
					               </c:forEach>>&#12288;
					               <c:if test="${not empty mainContract.contractNo }">
					                 ${mainContract.contractNo }：
					               </c:if>${mainContract.contractName }
					           <br/>
					          </c:forEach>
					       </c:forEach>
					     </span>
					    </td>
					</tr>
					
			      </table>
			      
				<div class="button" style="width: 100%;">
					<input id="saveButton" class="search" type="button" value="保&#12288;存" onclick="save();" />
					<input class="search" type="button" value="关&#12288;闭" onclick="doClose();" />
				</div>
			</form>
			  <table style="display: none;">
					<tbody id="beforeRefTb">
					<tr><td>以前的:</td></tr>
					   <c:forEach items="${refExtList }" var="ref">
					      <tr>
					        <td><input type="text" name="beforeContractFlow" value="${ref.contractFlow }"/></td>
					      </tr>
					   </c:forEach>
					</tbody>
			      </table>
			</div>
		</div>
	</div>

<div style="display: none;">
<span id="file">
 <input type="file" name="file"  class="validate[custom[fileType]]"/><br/>
 <span style="color: red">支持格式jpg，bmp，png，jpeg，doc，docx，pdf，zip，rar，文件小于100MB</span>
</span>
<span id="clone_${contractCategoryEnumSales.id }">
    <select class="inputText validate[required]"  name="contractTypeId" style="width: 90%;" onchange="changeContractTypeTd(this);">
       <option value="">请选择</option>
	   <c:forEach items="${contractTypeEnumList }" var="contractType">
	      <c:if test="${contractType.categoryId eq 'Sales' }">
	      <option value="${contractType.id }">${contractType.name }</option>
	      </c:if>
	   </c:forEach>
    </select>
</span>
<span id="clone_${contractCategoryEnumSecond.id }">
    <select class="inputText validate[required]"  name="contractTypeId" style="width: 90%;" onchange="changeContractTypeTd(this);">
       <option value="">请选择</option>
	   <c:forEach items="${contractTypeEnumList }" var="contractType">
	      <c:if test="${contractType.categoryId eq 'Second' }">
	      <option value="${contractType.id }">${contractType.name }</option>
	      </c:if>
	   </c:forEach>
    </select>
</span>
<span id="clone_${contractCategoryEnumSell.id }">
    <select name="consumerFlow" class="inputText validate[required]" style="width:90%;">
        <option value="">请选择</option>
        <c:forEach items="${consumerList }" var="consumer">
          <option value="${consumer.customerFlow }">${consumer.customerName }</option>
        </c:forEach>
    </select>
</span>
</div>
</body>
</html>