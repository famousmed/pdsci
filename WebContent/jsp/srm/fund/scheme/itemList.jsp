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
function change(obj){
	 if(obj.id=='maxLimit'){
	 var maxLimitValue=$(obj).text();
	 var inputMaxLimit=$("<input>");
	 inputMaxLimit.attr("name","maxLimit");
	 inputMaxLimit.attr("value",maxLimitValue);
	 $(obj).empty();
	 $(obj).append(inputMaxLimit);
	 }
	 if(obj.id=='remark'){
     var remarkValue=$(obj).text();
	 var inputRemark=$("<input>");
	 inputRemark.attr("name","remark");
	 inputRemark.attr("value",remarkValue);
	 $(obj).empty();
	 $(obj).append(inputRemark);
	 }
}
function clicks(obj){
	var tr=$(obj).parent("td").parent('tr');
	var tdMaxLimit = tr.find('td').eq(2);
	var tdRemark = tr.find('td').eq(3);
 if(obj.checked==true){
   var inputMaxLimit=$("<input>");
   inputMaxLimit.attr("name","maxLimit");
   var inputRemark=$("<input>");
   inputRemark.attr("name","remark");
   tdMaxLimit.append(inputMaxLimit);
   tdRemark.append(inputRemark);
}
  else{
	  tdMaxLimit.empty();
	  tdRemark.empty();
	}
}

function save(schemeFlow){
	var trs = $('#schemeDtl').find('tr');
	var datas = [];
	$.each(trs , function(i , n){
    var checkbox=$(n).find('td').eq(0).find("input[type='checkbox']");
    if($(n).find('td').eq(0).find("input[type='checkbox']").prop("checked")){
       var tdMaxLimitValue = checkbox.parent('td').parent('tr').find('td').eq(2).text();
       var tdRemarkValue = checkbox.parent('td').parent('tr').find('td').eq(3).text();
	   var maxLimit = checkbox.parent('td').parent('tr').find("input[name='maxLimit']").val();
	   var remark = checkbox.parent('td').parent('tr').find("input[name='remark']").val();
	   var itemFlow = checkbox.parent('td').parent('tr').find("input[name='itemFlow']").val();
	   var itemId= checkbox.val();
	   if(maxLimit){}else{
         maxLimit=tdMaxLimitValue;
	   }
	   if(remark){}else{
	         remark=tdRemarkValue;
	   }
	  var data={
			  "maxLimit": maxLimit,
			  "remark": remark,
			  "itemFlow": itemFlow,
			  "itemId": itemId,
			  "schemeFlow":schemeFlow,
	  };
	  datas.push(data);
	} 
	});
	var requestData = JSON.stringify(datas);
	var url="<s:url value='/srm/fund/scheme/updateDetail'/>";
	jboxStartLoading();
	jboxPostJson(url,requestData,function(){
			window.location.reload();
			jboxClose();		
	},null,true); 
}
</script>
</head>
<body>
    <div class="mainright">
        <div class="content">
            <form id="budgetList" action="<s:url value="/srm/fund/scheme/list2"/>" method="post">      
                <table class="xllist" >
                    <tr style="height: 20px">
                        <th>序号</th>
                        <th>预算项</th>
                        <th>最高比例(单位：%)</th>
                        <th>备注</th>
                    </tr>
                    <tbody id="schemeDtl">
                        <c:forEach var="dict" items="${dictTypeEnumBudgetItemList}">
                            <c:set var="selectedSchemeDtl" value="false"/>
                            <c:set var="sdtl" value=""/>
                            <c:forEach var="schemeDtl" items="${schemeDtlList }">
                                <c:if test="${schemeDtl.itemId eq dict.dictId}">
                                    <c:set var="selectedSchemeDtl" value="true"/> 
                                    <c:set var="sdtl" value="${schemeDtl}"/>        
                                </c:if>
                            </c:forEach>
                            <tr>
                                <td>
                                    <input type="checkbox" name="check" value="${dict.dictId}" <c:if test='${selectedSchemeDtl}'>checked="checked"</c:if> onclick="clicks(this);"/>
                                </td>
                                <td>
                                    ${dict.dictName}
                                    <input type="hidden" name="itemFlow" value="<c:if test="${not empty sdtl}">${sdtl.itemFlow}</c:if>">
                                </td>
                                <td id="maxLimit" ondblclick="change(this);">
                                    <c:if test="${not empty sdtl}">
                                        ${sdtl.maxLimit}
                                    </c:if>
                                </td>
                                <td id="remark" ondblclick="change(this);">
                                    <c:if test="${not empty sdtl}">
                                        ${sdtl.remark}
                                    </c:if>
                                    
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
           </form>
           <div style="margin-top:10px; text-align: center;">
               <input type="button" id="next" class="search" onclick="save('${schemeFlow}');" value="保&nbsp;&nbsp;存"/>
           </div>
       </div>
   </div>
</body>