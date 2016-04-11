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
function checkedView(workFlow){
	$.each($(".workTr"),function(i,n){
		$(n).css("background-color","");
	});
	$("#workTr_"+workFlow).css("background-color","pink");
	$("#checkWorkFlow").val(workFlow);
}
function search() {
	jboxStartLoading();
	$("#searchForm").submit();
}

function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	jboxStartLoading();
	form.submit();
}

function viewWorkOrder(workFlow,contactFlow) {
	var url = "<s:url value='/erp/implement/editWorkOrder'/>?workFlow=" + workFlow+"&contactFlow="+contactFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='100%' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,"查看派工单", 840, 650, null, false);
}

function finishWorkOrder(workFlow,contactFlow) {
	var url = "<s:url value='/erp/implement/editWorkOrder'/>?type=engineerEdit&workFlow=" + workFlow+"&contactFlow="+contactFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='100%' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,"完成派工单", 840, 650, null, false);
}

function customerInfo(customerFlow) {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/crm/customerInfo'/>?customerFlow=" + customerFlow + "&type=open";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'客户详细信息',w,h,null,false);
}

function searchDeptUser(obj){
	 $("#assignUserFlow").empty();
	 $("#assignUserFlow").removeAttr("disabled");
	 var deptFlow=$(obj).val();
	 if(deptFlow==""){
		 var option='<option value="">请选择接收部门</option>';
		 $("#assignUserFlow").append(option);
	 }else{
		 jboxPost("<s:url value='/erp/implement/searchOwnUser'/>?deptFlow="+deptFlow,null,function(data){
			 if(data!=null){
			 $("#assignUserFlow").append('<option></option>');
			 for ( var i = 0; i < data.length; i++) {
					$("#assignUserFlow").append('<option value="'+data[i].userFlow+'">'+data[i].userName+'</option>');
				 }
			 setAssignUserSelected();
		  }
		 },null,false);
	 }	 
}
function setAssignUserSelected(){
	var options=$("#assignUserFlow").find("option");
	$.each(options,function(i,n){
		if($(n).val()=='${param.assignUserFlow}'){
			$(n).attr("selected","selected");
		}
	});
}
$(document).ready(function(){
	if('${GlobalConstant.USER_LIST_GLOBAL}'=='${sessionScope[GlobalConstant.USER_LIST_SCOPE]}'){
		searchDeptUser($("#assignDeptFlow"));
	}
	if($("#checkWorkFlow").val()!=""){
		checkedView($("#checkWorkFlow").val());
	}
});
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" action="<s:url value="/erp/implement/myWorkOrders/${sessionScope[GlobalConstant.USER_LIST_SCOPE] }"/>" method="post">
				<input type="hidden" id="currentPage" name="currentPage" value=""/>
				<input type="hidden" id="checkWorkFlow" name="checkWorkFlow" value="${param.checkWorkFlow }"/>
				<c:if test="${GlobalConstant.USER_LIST_GLOBAL != sessionScope[GlobalConstant.USER_LIST_SCOPE]}">
				<div style="padding-bottom: 10px;">
				            客户名称：<input type="text" name="customerName" placeholder="客户名称/别名" value="${param.customerName}" class="xltext" style="width:158px;"/>
					最终使用方：<input type="text" name="consumerName" placeholder="最终使用方名称/别名" value="${param.consumerName}" class="xltext" style="width:148px;"/>
					派工单编号：<input type="text" name="workNo" placeholder="派工单编号" value="${param.workNo }" class="xltext"/>
					<c:if test="${GlobalConstant.USER_LIST_LOCAL == sessionScope[GlobalConstant.USER_LIST_SCOPE] }">
					接收人：<select name="assignUserFlow" id="assignUserFlow" class="xlselect" style="width:120px;">
					        <option value="">请选择</option>
					        <c:forEach items="${userList }" var="user">
					           <option value="${user.userFlow }">${user.userName }</option>
					        </c:forEach>
					     </select>
				    </c:if>
				</div>
				<div style="padding-bottom: 10px;">
				产品/项目名称：<input type="text" name="productTypeName" placeholder="产品/项目名称" value="${param.productTypeName}" class="xltext" style="width: 128px;"/>
					&#12288;需求事项：<select name="demandMatterId" class="xlselect" style="width: 155px;">
				            	<option value="">请选择</option>
				             	<c:forEach var="demandMatter" items="${demandMatterEnumList}">
						            <option value="${demandMatter.id}" <c:if test="${param.demandMatterId eq demandMatter.id}">selected="selected"</c:if>>${demandMatter.name}</option>
						        </c:forEach>
							</select>
					&#12288;状&#12288;&#12288;态：<select name="workStatusId" class="xlselect" style="width: 170px;">
		            	<option value="">请选择</option>
		            	<option value="${workOrderStatusEnumImplementing.id}" <c:if test="${param.workStatusId eq workOrderStatusEnumImplementing.id}">selected="selected"</c:if>>${workOrderStatusEnumImplementing.name}</option>
		            	<option value="${workOrderStatusEnumImplemented.id}" <c:if test="${param.workStatusId eq workOrderStatusEnumImplemented.id}">selected="selected"</c:if>>${workOrderStatusEnumImplemented.name}</option>
		            	<option value="${workOrderStatusEnumCompletePassed.id}" <c:if test="${param.workStatusId eq workOrderStatusEnumCompletePassed.id}">selected="selected"</c:if>>${workOrderStatusEnumCompletePassed.name}</option>
		            	<option value="${workOrderStatusEnumCompleteUnPassed.id}" <c:if test="${param.workStatusId eq workOrderStatusEnumCompleteUnPassed.id}">selected="selected"</c:if>>${workOrderStatusEnumCompleteUnPassed.name}</option>
		            	<option value="${workOrderStatusEnumClosed.id}" <c:if test="${param.workStatusId eq workOrderStatusEnumClosed.id}">selected="selected"</c:if>>${workOrderStatusEnumClosed.name}</option>
					</select>
				</div>
				<div>
				    派工时间：<input type="text" class="xltext ctime" name="applyDateStart" value="${param.applyDateStart}" style="width: 100px;margin:0px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>&nbsp;~&nbsp;
					<input type="text" class="xltext ctime" name="applyDateEnd" value="${param.applyDateEnd}" style="width: 100px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
					<input type="button" class="search" onclick="search();" value="查&#12288;询" >
				</div>
				</c:if>
				
				<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq sessionScope[GlobalConstant.USER_LIST_SCOPE]}">
				<div style="padding-bottom: 10px;">
					客户名称：<input type="text" name="customerName" placeholder="客户名称/别名" value="${param.customerName}" class="xltext"/>
					&#12288;&nbsp;派工单编号：<input type="text" name="workNo" placeholder="派工单编号" value="${param.workNo }" class="xltext"/>
					状&#12288;&#12288;态：<select name="workStatusId" class="xlselect" style="width: 170px;">
		            	<option value="">请选择</option>
		            	<option value="${workOrderStatusEnumImplementing.id}" <c:if test="${param.workStatusId eq workOrderStatusEnumImplementing.id}">selected="selected"</c:if>>${workOrderStatusEnumImplementing.name}</option>
		            	<option value="${workOrderStatusEnumImplemented.id}" <c:if test="${param.workStatusId eq workOrderStatusEnumImplemented.id}">selected="selected"</c:if>>${workOrderStatusEnumImplemented.name}</option>
		            	<option value="${workOrderStatusEnumCompletePassed.id}" <c:if test="${param.workStatusId eq workOrderStatusEnumCompletePassed.id}">selected="selected"</c:if>>${workOrderStatusEnumCompletePassed.name}</option>
		            	<option value="${workOrderStatusEnumCompleteUnPassed.id}" <c:if test="${param.workStatusId eq workOrderStatusEnumCompleteUnPassed.id}">selected="selected"</c:if>>${workOrderStatusEnumCompleteUnPassed.name}</option>
		            	<option value="${workOrderStatusEnumClosed.id}" <c:if test="${param.workStatusId eq workOrderStatusEnumClosed.id}">selected="selected"</c:if>>${workOrderStatusEnumClosed.name}</option>
					</select>
					  
				   </div>
				   <div style="padding-bottom: 10px;">
					需求事项：<select name="demandMatterId" class="xlselect">
				            	<option value="">请选择</option>
				             	<c:forEach var="demandMatter" items="${demandMatterEnumList}">
						            <option value="${demandMatter.id}" <c:if test="${param.demandMatterId eq demandMatter.id}">selected="selected"</c:if>>${demandMatter.name}</option>
						        </c:forEach>
							</select>
					产品/项目名称：<input type="text" name="productTypeName" placeholder="产品/项目名称" value="${param.productTypeName}" class="xltext"/>
					派工时间：<input type="text" class="xltext ctime" name="applyDateStart" value="${param.applyDateStart}" style="width: 100px;margin:0px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>&nbsp;~&nbsp;
					<input type="text" class="xltext ctime" name="applyDateEnd" value="${param.applyDateEnd}" style="width: 100px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
				</div>
				<div>
				   接收部门： <select name="assignDeptFlow" id="assignDeptFlow" class="xlselect" onchange="searchDeptUser(this);" style="width: 165px;" >
						       <option value="">请选择</option>
						       <c:forEach items="${deptList }" var="dept">
						         <option value="${dept.deptFlow }"<c:if test="${dept.deptFlow eq param.assignDeptFlow }">selected="selected"</c:if>>${dept.deptName }</option>
						       </c:forEach>
						   </select>
                 &#12288;&nbsp;接&#12288;收&#12288;人：<select name="assignUserFlow" id="assignUserFlow" class="xlselect" style="width:168px;">
						     <option value="">请选择接收部门</option>
						   </select>
				<input type="button" class="search" onclick="search();" value="查&#12288;询"/>
				</div>
				</c:if>
				</form>
			</div>			
			<table class="xllist">
				<colgroup>
					<col width="3%"/>
					<col width="9%"/>
					<col width="9%"/>
					<col width="9%"/>
					<col width="9%"/>
					<col width="9%"/>
					<col width="9%"/>
					<col width="9%"/>
					<col width="7%"/>
					<col width="9%"/>
					<col width="9%"/>
					<col width="9%"/>
				</colgroup>
				<thead>
				<tr>
					<th>序号</th>
					<th>派工单编号</th>
					<th>客户名称</th>
					<th>最终使用方</th>
					<th>产品/项目名称</th>
					<th>申请时间</th>
					<th>需求事项</th>
					<th>派工时间</th>
					<th>接收人</th>
					<th>完成时间</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
				</thead>						
				<tbody>
				<c:forEach items="${workOrderExtList}" var="workOrderExt" varStatus="status">
				<tr class="workTr" id="workTr_${workOrderExt.workFlow }">
					<td>${status.count}</td>
					<td>${workOrderExt.workNo}</td>
					<td><a href="javascript:customerInfo('${workOrderExt.customerFlow}');">${workOrderExt.customerName}</a></td>
					<td><a href="javascript:customerInfo('${workOrderExt.consumerFlow}');">${workOrderExt.consumerName}</a>
					</td>
					<td>${workOrderExt.contactOrder.productTypeName}
					    <c:if test="${(not empty workOrderExt.contactOrder.productTypeName) and (not empty workOrderExt.contactOrder.orderProductName) }">、</c:if>
				        ${workOrderExt.contactOrder.orderProductName }
					</td>
					<td>${workOrderExt.contactOrder.applyDate}</td>
					<td>${workOrderExt.contactOrder.demandMatterName}</td>
					<td>${workOrderExt.assignDate}</td>
					<td>${workOrderExt.assignUserName}</td>
					<td>${completeDateMap[workOrderExt.workFlow]}</td>
					<td>${workOrderExt.workStatusName}</td>
					<td>
						[<a href="javascript:viewWorkOrder('${workOrderExt.workFlow}','${workOrderExt.contactFlow }');" onclick="checkedView('${workOrderExt.workFlow }');">详情</a>] 
						<c:if test="${(workOrderExt.workStatusId == workOrderStatusEnumImplementing.id or workOrderExt.workStatusId == workOrderStatusEnumCompleteUnPassed.id) and GlobalConstant.USER_LIST_LOCAL != sessionScope[GlobalConstant.USER_LIST_SCOPE]}">
							| [<a href="javascript:finishWorkOrder('${workOrderExt.workFlow}','${workOrderExt.contactFlow }');" onclick="checkedView('${workOrderExt.workFlow }');">完成</a>]
						</c:if>
					</td>
				</tr>
				</c:forEach>
				</tbody>
				<c:if test="${empty workOrderExtList}">
					<tr>
						<td colspan="11">无记录</td>
					</tr>
				</c:if>
			</table>
			<p>
			   	<c:set var="pageView" value="${pdfn:getPageView2(workOrderExtList, 10)}" scope="request"/> 
				<pd:pagination toPage="toPage"/>
			</p>
	</div>
</div>
</body>
</html>