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
    
    function add(){
		var url = "<s:url value ='/gcp/drug/editDrugInfo'/>";
		jboxOpen(url,"新增药物信息",700,650);
	}
    
    function editDrugIn(drugFlow){
    	jboxOpen("<s:url value='/gcp/drug/editDrugIn'/>?drugFlow="+drugFlow,"药物入库", 750,310);
    }
    
    function editDrugOut(drugFlow){
    	jboxOpen("<s:url value='/gcp/drug/editDrugOut'/>?drugFlow="+drugFlow,"药物出库", 720,500);
    }
    
    function drugInRecord(drugFlow){
    	jboxOpen("<s:url value='/gcp/drug/drugInRecord'/>?drugFlow="+drugFlow,"入库记录", 1000,400);
    }
    
    function drugOutRecord(drugFlow){
    	jboxOpen("<s:url value='/gcp/drug/drugOutRecord'/>?drugFlow="+drugFlow,"出库记录", 1000,400);
    }
</script>
</head>
<body>
	<div class="mainright">
		<div class="content" style="padding-top: 10px;">
		    <form id="searchForm" action="<s:url value='/gcp/drug/stockList'/>" method="post">
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
		        <th width="20%">药物名称</th>
		        <th width="8%">药物类型</th>
		        <th width="8%">药物规格</th>
		        <th width="18%">项目名称</th>
		        <th width="20%">库存编码</th>
		        <th width="22%">操作</th>
		       </tr>
		     </thead>
		     <tbody>
		    <c:forEach items="${gcpDrugList }" var="drug" varStatus="num">
			   <tr>
			     <td>${num.count }</td>
			     <td>${drug.drugName }</td>
			     <td>${drug.drugTypeName }</td>
			     <td>${drug.spec }</td>
			     <td title="${drug.projName }">${pdfn:cutString(drug.projName,12,true,3 )}</td>
			     <td style="text-align: left;padding-left: 10px;">
			     	<c:forEach items="${drugRecMap[drug.drugFlow]}" var="rec" varStatus="statu">
				        ${rec.drugPack}<c:if test="${!statu.last}">，</c:if>
				    </c:forEach>
				    </td>
			     <td>
			        <a style="color: blue;" href="javascript:void(0)" onclick="editDrugIn('${drug.drugFlow}');">入库</a>&nbsp;&nbsp;|&nbsp;
				    <a style="color: blue;" href="javascript:void(0)" onclick="editDrugOut('${drug.drugFlow}');">出库</a>&nbsp;&nbsp;|&nbsp;
				    <a style="color: blue;" href="javascript:void(0)" onclick="drugInRecord('${drug.drugFlow}');">入库记录</a>&nbsp;&nbsp;|&nbsp;
				    <a style="color: blue;" href="javascript:void(0)" onclick="drugOutRecord('${drug.drugFlow}');">出库记录</a>
			     </td>
			   </tr>
		   </c:forEach>
		     </tbody>
		     <c:if test="${empty gcpDrugList}">
		         <tr>
		           <td colspan="7">无记录！</td>
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