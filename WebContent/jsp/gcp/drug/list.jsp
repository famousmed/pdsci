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
    function add(){
		var url = "<s:url value ='/gcp/drug/editDrugInfo'/>";
		jboxOpen(url,"新增药物信息",700,625);
	}
    function edit(drugFlow){
		var url = "<s:url value ='/gcp/drug/editDrugInfo'/>?drugFlow="+drugFlow;
		jboxOpen(url,"编辑药物信息",700,650);
	}
    function del(drugFlow){
		jboxConfirm("确认删除该药物信息？",function(){
			var url = "<s:url value='/gcp/drug/delDrugInfo'/>?drugFlow="+drugFlow;
			jboxPost(url,null,function(resp){
				if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
					search();
				}
			},null,true);
		},null);
	}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content" style="padding-top: 10px;">
		    <form id="searchForm" action="<s:url value='/gcp/drug/list'/>" method="post">
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
		         <input type="button" onclick="add();" value="新&#12288;增" class="search">
		    </form>
		    <table width="100%" class="xllist" style="margin-top: 10px;">
		     <thead>
		       <tr>
		        <th width="4%">序号</th>
		        <th width="20%">药物名称</th>
		        <th width="8%">药物类型</th>
		        <th width="8%">药物规格</th>
		        <th width="8%">最小包装量</th>
		        <th width="14%">储藏条件</th>
		        <th width="14%">生产厂家</th>
		        <th width="17%">项目名称</th>
		        <th width="10%">操作</th>
		       </tr>
		     </thead>
		     <tbody>
		     <c:if test="${empty gcpDrugList}">
		         <tr>
		           <td colspan="9">无记录！</td>
		         </tr>
		     </c:if>
		    <c:forEach items="${gcpDrugList }" var="drug" varStatus="num">
			   <tr>
			     <td>${num.count }</td>
			     <td>${drug.drugName }</td>
			     <td>${drug.drugTypeName }</td>
			     <td>${drug.spec }</td>
			     <td>${drug.minPackUnitName }</td>
			     <td>${drug.storageCondition }</td>
			     <td>${drug.manufacturer }</td>
			     <td title="${drug.projName }">${pdfn:cutString(drug.projName,10,true,3 )}</td>
			     <td>
			        <a style="color: blue;" href="javascript:void(0)" onclick="edit('${drug.drugFlow}');">编辑</a>&nbsp;&nbsp;|&nbsp;
				    <a style="color: blue;" href="javascript:void(0)" onclick="del('${drug.drugFlow}');">删除</a> 
			     </td>
			   </tr>
		   </c:forEach>
		       
		     </tbody>
		   </table>	
		</div> 
		</div>
		
	
	  
</body>
</html>