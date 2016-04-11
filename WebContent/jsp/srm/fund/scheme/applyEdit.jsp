<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
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
 function changeSelect(obj){
    var schemeFlow=obj.value;
    url="<s:url value='/srm/fund/scheme/changeScheme'/>?schemeFlow="+schemeFlow;
    jboxStartLoading();
	jboxGet(url,null,function(resp){
		$("#tbody").empty();
		$.each(resp , function(i , n){
			$("#tbody").append("<tr>"+"<td>"+n.itemName+"<input name='itemFlow' value='"+n.itemFlow+"' type='hidden'/></td>"+"<td ondblclick=tlick(this)>"+"</td>"+"<td>"+n.maxLimit+"</td>"+"<td>"+n.remark+"</td>"+"</tr>");
		});
				
	},null,false);		
 }
 
 function countBudgetFund(){
	 var moneys = $('#tbody').find("[name='money']");
	 var sum = 0;
	 var re = /^[0-9]+.?[0-9]*$/;//正数正则
	 $.each(moneys , function(i , n){
		 var tdMoney = $(n).val()?$(n).val():0;
		 if(re.test(tdMoney)){
			 sum+=parseFloat(tdMoney);
			 $("#budgetAmount").val(sum);
		 }
		 
	 });
 }
 
 function submit(projFlow){
	 if(!$('#schemeFlow').val()){
		 jboxTip("暂无经费方案,无法提交，请联系管理员!");
		 return false;
	 }
	 if($("#schemeDtlList").validationEngine("validate")){
	 jboxConfirm("确认提交项目预算，提交后无法更改?" , function(){
		 var schemeFlow=$("#schemeFlow").val();
		 var fundFlow=$("#fundFlow").val();
		 var budgetAmount=$("#budgetAmount").val();
		 //var goveFund=$("#goveFund").val();
		 //var orgFund=$("#orgFund").val();
		 var trs = $('#tbody').find('tr');
	     var datas = [];
	     $.each(trs , function(i , n){
	    	 var money = $(n).find("input[name='money']").val();
	    	  if(money){}else{
	    		  money=$(n).find('td').eq(1).text();
	    	  }
	         var content = $(n).find('td').eq(3).text();
	  	     var itemFlow = $(n).find("input[name='itemFlow']").val();
	  	     var fundDetailFlow = $(n).find("input[name='fundDetailFlow']").val();
	  	     var data={
	 			  "money": money,
	 			  "content": content,
	 			  "itemFlow": itemFlow,
	 			 "fundDetailFlow":fundDetailFlow
	 	  };
	  	   
	  	 datas.push(data);
	     });
	     var requestData = JSON.stringify(datas);
	 	var url="<s:url value='/srm/fund/scheme/saveFundInfoDetail'/>?schemeFlow="+schemeFlow+"&projFlow="+projFlow+"&fundFlow="+fundFlow+"&budgetAmount="+budgetAmount;//+"&goveFund="+goveFund+"&orgFund="+orgFund;
	 	jboxStartLoading();
	 	jboxPostJson(url,requestData,function(){
		 		$("#budgetList",window.parent.frames['mainIframe'].document).submit(); 
		 		jboxCloseMessager(); 
	 		} , null , true);
	 });
	 }
 }
</script>
</head>
<body>
    <div class="mainright">
        <div class="content">
            <p style="font-weight: bold;font-size: 14px;"> 项目名称：${proj.projName} &nbsp;&nbsp;&nbsp;&nbsp;项目编号：${proj.projNo }&nbsp;&nbsp;&nbsp;&nbsp;项目类型：${proj.projTypeName}</p>     
            <br/>
            <form id="schemeDtlList" method="post">
                <input type="hidden" id="fundFlow" name="fundFlow" value="${fundInfo.fundFlow }"/>
                <div style="margin-bottom:10px;text-align: left;">
	            <p>
	                                                 预算方案：<input type="text" id="schemeName" name="schemeName" value="${scheme.schemeName}" readonly="readonly"/>
	                       <input type="hidden" id="schemeFlow" name="schemeFlow" value="${scheme.schemeFlow}"/>
              &nbsp;预算总经费(万元)：<input type="text" id="budgetAmount" value="${fundInfo.budgetAmount }" readonly="readonly" class="validate[required,custom[number],min[0]] text-input xltext" <c:if test="${look == 'look'}">disabled="disabled"</c:if> />
            <!--  &nbsp;下拨金额：<input type="text" id="goveFund" value="${fundInfo.goveFund }" class="validate[required,custom[number],min[0]] text-input xltext" <c:if test="${look == 'look'}">disabled="disabled"</c:if> />
              &nbsp;配套金额：<input type="text" id="orgFund" value="${fundInfo.orgFund }" class="validate[required,custom[number],min[0]] text-input xltext" <c:if test="${look == 'look'}">disabled="disabled"</c:if> />
               -->
	          </p>
              </div>      
			  <table class="xllist">
			      <tr style="height: 20px">
			      <th style="width:100px;">预算项名称</th>
			      <th style="width:100px;">预算金额(万元)</th>
			      <th style="width:130px;">最高比例(单位：%)</th>
			      <th>预算内容</th>
			    </tr>
			    <tbody id="tbody">
			    <c:if test="${empty fundDtlList}">
			    <c:forEach var="n" items="${sfsdList}">
			        <tr>
			            <td>${n.itemName}
			                <input name='itemFlow' value='${n.itemFlow}' type='hidden'/>
			            </td>
			            <td><input type="text" onblur="countBudgetFund();" name="money" class="validate[required,custom[number],min[0]]" style="width: 90%;text-align: center;"/></td>
			            <td>${n.maxLimit}</td>
			            <td>${n.remark}</td>
			        </tr>
			    </c:forEach>
			    </c:if>
			    
			    <c:if test="${not empty fundDtlList}">
			    <c:forEach var="fundDtl" items="${fundDtlList}">
			    <tr>
			       <td>
			       	<c:forEach var="schemeDtl" items="${schemeDtlList}">
			       	   <c:if test="${fundDtl.itemFlow eq schemeDtl.itemFlow}">${schemeDtl.itemName}</c:if>
			       	</c:forEach>
			       </td> 
			       <td><c:if test="${look == 'look'}"><span name="money">${fundDtl.money}</span></c:if><c:if test="${look != 'look'}"><input type="text" value="${fundDtl.money}" onblur="countBudgetFund();" name="money" class="validate[required,custom[number],min[0]]" style="width: 90%;text-align: center;"/></c:if></td>     
			       <td>
			       	<c:forEach var="schemeDtl" items="${schemeDtlList}">
			          <input type="hidden" name="itemFlow" value="${fundDtl.itemFlow }"/>
			          <c:if test="${fundDtl.itemFlow eq schemeDtl.itemFlow}">${schemeDtl.maxLimit }</c:if>
			          <input type="hidden" name="fundDetailFlow" value="${fundDtl.fundDetailFlow }">
			      	</c:forEach>
			       </td>
			       <td>${fundDtl.content}</td>
			    </tr>
			    </c:forEach>
			    </c:if>
			    </tbody>
			  </table>
          </form>
  
          <div style="margin-top: 20px;text-align: center;">
              <c:if test="${look != 'look'}">   
                  <input type="button" class="search" onclick="submit('${projFlow}');" value="提交"/>
              </c:if>
          </div>    
       </div>
   </div>
</body>