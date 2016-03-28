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
</jsp:include>
<script type="text/javascript">
function search() {
	jboxStartLoading();
	$("#searchForm").submit();
}

function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	form.submit();
}

function contractInfo(contractFlow) {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/crm/contractInfo'/>?contractFlow=" + contractFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'合同详细信息',w,h,null,false);
}

function payPlanList() {
	
}
function changeContractTypeOption(obj){
	var type=$(obj).val();
	$("#contractTypeId").removeAttr("disabled");
	$("#contractTypeId").empty();
	if(type=='${contractCategoryEnumPurchase.id}'){
		$("#contractTypeId").attr("disabled","disabled");
		var option='<option>此类别无合同类型</option>';
		$("#contractTypeId").append(option);
	}else if(type==""){
		$("#contractTypeId").attr("disabled","disabled");
		var option='<option>请先选择合同类别</option>';
		$("#contractTypeId").append(option);
	}else{
		var options=$("#copy_"+type).find("option");
		$.each(options,function(i,n){
			$("#contractTypeId").append($(n).clone());
		});
	}
}
$(document).ready(function(){
	changeContractTypeOption($("#contractCategoryId"));
	searchDeptUser($("#signDeptFlow"));
});

function setSignUserSelected(){
	var options=$("#signUserFlow").find("option");
	$.each(options,function(i,n){
		if($(n).val()=='${param.signUserFlow}'){
			$(n).attr("selected","selected");
		}
	});
}
function searchDeptUser(obj){
	 $("#signUserFlow").empty();
	 $("#signUserFlow").removeAttr("disabled");
	 var deptFlow=$(obj).val();
	 if(deptFlow==""){
		 var option='<option>请先选择签订部门</option>';
		 $("#signUserFlow").append(option);
		 $("#signUserFlow").attr("disabled","disabled");
	 }else{
		 jboxPost("<s:url value='/erp/crm/searchDeptUserJson'/>?deptFlow="+deptFlow,null,function(data){
			 if(data!=null){
			 $("#signUserFlow").append('<option></option>');
			 for ( var i = 0; i < data.length; i++) {
					$("#signUserFlow").append('<option value="'+data[i].userFlow+'">'+data[i].userName+'</option>');
				 }
			 setSignUserSelected();
		  }
		 },null,false);
	 }	 
}

function billList(contractFlow) {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/sales/billList'/>?contractFlow" + contractFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'客户详细信息',w,h,null,false);
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" action="<s:url value="/erp/sales/contractList" />"	method="post">
				<input type="hidden" id="currentPage2" name="currentPage2" value="${param.currentPage }"/>
				<div style="margin-bottom: 10px;">
					客户名称：<input type="text" name="customerName" value="${param.customerName }" class="xltext"/>
					合同名称：<input type="text" name="contractName" value="${param.contractName }" class="xltext"/>
				   &nbsp;&nbsp;&nbsp;签订日期：<input type="text" name="signDateStart" value="${param.signDateStart }" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:120px;margin: 0"/>&nbsp;~&nbsp;
				           <input type="text" name="signDateEnd" value="${param.signDateEnd }" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:120px;"/>
				</div>
				<div style="margin-bottom: 10px;">
			                         合同类别：<select class="xlselect" id="contractCategoryId" name="contractCategoryId" onchange="changeContractTypeOption(this);" style="width:168px;">
				            	<option value="">请选择</option>
				             	<c:forEach var="contractCategory" items="${contractCategoryEnumList}">
						            <option value="${contractCategory.id}"<c:if test="${param.contractCategoryId eq contractCategory.id }">selected="selected"</c:if>>${contractCategory.name}</option>
						        </c:forEach>
							</select>
				           合同类型：<select class="xlselect" id="contractTypeId" name="contractTypeId" style="width:168px;">
				            <option value="">请先选择合同类别</option>
				           </select>  
					  合同到期日：<input type="text" name="contractDueDateStart" value="${param.contractDueDateStart }" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:120px;margin: 0"/>&nbsp;~&nbsp;
					       <input type="text" name="contractDueDateEnd" value="${param.contractDueDateEnd }" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:120px;"/>
					
				</div>
				<div>
				          签订部门：<select name="signDeptFlow" id="signDeptFlow" class="xlselect" onchange="searchDeptUser(this);" style="width: 168px;">
						       <option value="">请选择</option>
						       <c:forEach items="${deptList }" var="dept">
						         <option value="${dept.deptFlow }"<c:if test="${dept.deptFlow eq param.signDeptFlow }">selected="selected"</c:if>>${dept.deptName }</option>
						       </c:forEach>
						   </select>
              	签&nbsp;订&nbsp;&nbsp;人：<select name="signUserFlow" id="signUserFlow" class="xlselect" style="width:168px;">
						     <option value="">请先选择签订部门</option>
						   </select>
				   维护到期日：<input type="text" name="maintainDueDateStart" value="${param.maintainDueDateStart }" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:120px;margin: 0"/>&nbsp;~&nbsp;
					        <input type="text" name="maintainDueDateEnd" value="${param.maintainDueDateEnd }" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:120px;"/>
				      
				           <input type="button" class="search" onclick="search();" value="查&#12288;询">
				           <input id="currentPage" type="hidden" name="currentPage" value=""/> 
				</div>
				</form>
			</div>			
			<table id="orgTable" class="xllist">
				<colgroup>
					<col width="12%"/>
					<col width="15%"/>
					<col width="9%"/>
					<col width="9%"/>
					<col width="9%"/>
					<col width="9%"/>
					<col width="9%"/>
					<col width="9%"/>
					<col width="9%"/>
					<col width="9%"/>
				</colgroup>
				<thead>
				<tr>
					<th>客户名称</th>
					<th>合同名称</th>
					<th>合同类别</th>
					<th>合同类型</th>
					<th>签订部门</th>
					<th>签订人</th>
					<th>签订日期</th>
					<th>合同到期日</th>
					<th>维护到期日</th>
					<th>操作</th>
				</tr>
				</thead>						
				<tbody>
				<c:if test="${empty contractListExt }">
				 <tr>
				   <td colspan="11">无记录</td>
				 </tr>
				</c:if>
				<c:forEach items="${contractListExt }" var="contractExt">
				<tr>
					<td>${contractExt.customer.customerName }</td>
					<td><a href="javascript:contractInfo('${contractExt.contractFlow }')">${contractExt.contractName }</a></td>
					<td>${contractExt.contractCategoryName }</td>
					<td>${contractExt.contractTypeName }</td>
					<td>${contractExt.signDeptName }</td>
					<td>${contractExt.signUserName }</td>
					<td>${contractExt.signDate }</td>
					<td>${contractExt.contractDueDate }</td>
					<td>${contractExt.maintainDueDate }</td>
					<td>
						[<a href="javascript:contractInfo('${contractExt.contractFlow}');">查看</a>] |
						[<a href="javascript:billList('${contractExt.contractFlow}');">开票</a>]
					</td>
				</tr>
			    </c:forEach>
				</tbody>
			</table>
			<div style="display: none;">
			  <select id="copy_Sales" name="contractTypeId">
			   <option value=""></option>
			      <c:forEach items="${contractTypeEnumList }" var="contractType">
	                <c:if test="${contractType.categoryId eq 'Sales' }">
	                 <option value="${contractType.id }"<c:if test="${contractType.id eq param.contractTypeId }">selected="selected"</c:if>>${contractType.name }</option>
	                </c:if>
	              </c:forEach>
			  </select>
			  <select id="copy_Second" name="contractTypeId">
			       <option value=""></option>
			       <c:forEach items="${contractTypeEnumList }" var="contractType">
	                 <c:if test="${contractType.categoryId eq 'Second' }">
	                  <option value="${contractType.id }" <c:if test="${contractType.id eq param.contractTypeId }">selected="selected"</c:if>>${contractType.name }</option>
	                 </c:if>
	               </c:forEach>
			  </select>
			</div>
			<c:set var="pageView" value="${pdfn:getPageView(contractListExt)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>			
	</div>
</div>
</body>
</html>