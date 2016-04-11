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
	<jsp:param name="jquery_scrollTo" value="true"/>
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
    function search(){
    	$("#searchForm").submit();
    	
    }
    
    function toPage(page){
		var form = $("#searchForm");
		$("#currentPage").val(page);
		form.submit();
	}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content" style="padding-top: 10px;">
		    <form id="searchForm" action="<s:url value='/gcp/drug/storeList'/>" method="post">
		      	项目名称：
		        <input type="text" name="projName" value="${param.projName }" class="xltext"/>
		      	药物名称：
		        <input type="text" name="drugName" value="${param.drugName }" class="xltext"/>
		      	药物类型：
		        <select name="drugTypeId" class="xlselect">
		           <option value="">请选择</option>
		           <c:forEach items="${gcpDrugTypeEnumList }" var="drug">
		             <option value="${drug.id }" <c:if test="${drug.id eq param.drugTypeId }">selected="selected"</c:if>>${drug.name }</option>
		           </c:forEach>
		        </select>
		         <input type="button" onclick="search();" value="查&#12288;询" class="search">
		         <input type="hidden" id="currentPage" name="currentPage">
		    </form>
		    <table width="100%" class="xllist" style="margin-top: 10px;">
		     <thead>
		       <tr>
		        <th width="4%">序号</th>
		        <th width="16%">药物名称</th>
		        <th width="8%">药物类型</th>
		        <th width="8%">药物规格</th>
		        <th width="8%">最小包装量</th>
		        <th width="16%">项目名称</th>
		        <th width="20%">已发药编码</th>
		        <th width="20%">库存编码</th>
		       </tr>
		     </thead>
		     <tbody>
		    <c:forEach items="${gcpDrugList }" var="drug" varStatus="num">
			   <tr>
			     <td>${num.count }</td>
			     <td>${drug.drugName }</td>
			     <td>${drug.drugTypeName }</td>
			     <td>${drug.spec }</td>
			     <td>${drug.minPackUnitName }</td>
			     <td title="${drug.projName }">${pdfn:cutString(drug.projName,12,true,3 )}</td>
			     <td style="text-align: left;padding-left: 10px;">
			     	<c:forEach items="${drugRecSendMap[drug.drugFlow]}" var="rec" varStatus="statu">
				        ${rec.drugPack}<c:if test="${!statu.last}">，</c:if>
				    </c:forEach>
				 </td>
			     <td style="text-align: left;padding-left: 10px;">
			     	<c:forEach items="${drugRecUnSendMap[drug.drugFlow]}" var="rec" varStatus="statu">
				        ${rec.drugPack}<c:if test="${!statu.last}">，</c:if>
				    </c:forEach>
				 </td>
			   </tr>
		   </c:forEach>
		     </tbody>
		     <c:if test="${empty gcpDrugList}">
		         <tr>
		           <td colspan="8">无记录！</td>
		         </tr>
		     </c:if>
		   </table>	
		   <p>
			<c:set var="pageView" value="${pdfn:getPageView2(gcpDrugList, 10)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>
			</p>
		</div> 
		</div>
</body>
</html>