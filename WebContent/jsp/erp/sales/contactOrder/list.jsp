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
</jsp:include>
<script type="text/javascript">
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
function delImplement(contactFlow){
	var url = "<s:url value='/erp/sales/deleteContactOrder'/>?contactFlow="+contactFlow;
	jboxConfirm("确认删除？", function(){
	jboxPost(url,null,function(data){
		search();
	},null,true);
	});
}

function submitImplement(contactFlow){
	var url = "<s:url value='/erp/sales/submitContactOrder'/>?contactFlow="+contactFlow;
	jboxConfirm("确认提交？", function(){
	jboxPost(url,null,function(data){
		if(data!='${GlobalConstant.SAVE_FAIL}'){
			jboxTip('${GlobalConstant.OPRE_SUCCESSED}');
			setTimeout(function(){
				search();
				jboxClose();
			},1000);
		}else{
			jboxTip('${GlobalConstant.OPRE_FAIL}');
		}
	},null,false);
	});
}

function add() {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/sales/editContactOrder'/>";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'新增工作联系单',w,h,null,false);
}

function edit(contactFlow) {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/sales/editContactOrder'/>?contactFlow="+contactFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'编辑工作联系单',w,h,null,false);
}

function info(contactFlow) {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url="<s:url value='/erp/sales/contactOrderInfo'/>?contactFlow="+contactFlow+"&historyFlag=Y";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'查看工作联系单',w,h,null,false);
}

function workInfo() {
	jboxOpen("<s:url value='/erp/sales/auditWorkContact'/>?type=info","工作联系单信息", 1000, 670);
}

function auditOpinion(contactFlow){
	jboxOpen("<s:url value='/erp/sales/contactOrderAuditOpinion'/>?contactFlow="+contactFlow,"审核意见", 700, 400);
}

function trackOpinion(contactFlow){
	jboxOpen("<s:url value='/erp/sales/contactOrderTrackOpinion'/>?contactFlow="+contactFlow,"实施进度", 700, 400);
}

function customerInfo(customerFlow) {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/crm/customerInfo'/>?customerFlow="+customerFlow+"&type=open";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'客户详细信息',w,h,null,false);
}

function setStatusName(id){
	$("#"+id+"Name").val($("#"+id+"Id").find("option:selected").text());
	if($("#"+id+"Id").val()==""){
		$("#"+id+"Name").val("");
	}
}
function checkedView(contactFlow){
	$.each($(".contactTr"),function(i,n){
		$(n).css("background-color","");
	});
	$("#contactTr_"+contactFlow).css("background-color","pink");
	$("#checkContactFlow").val(contactFlow);
}
$(document).ready(function(){
	if('${GlobalConstant.USER_LIST_GLOBAL}'=='${sessionScope[GlobalConstant.USER_LIST_SCOPE]}'){
	    searchDeptUser($("#applyDeptFlow"));
	}
	if($("#checkContactFlow").val()!=""){
		checkedView($("#checkContactFlow").val());
	}
});

function auditWorkContact(contactFlow) {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url="<s:url value='/erp/sales/auditWorkContact'/>?contactFlow="+contactFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'工作联系单申请审核',w,h,null,false);
}
function searchDeptUser(obj){
	 $("#applyUserFlow").empty();
	 $("#applyUserFlow").removeAttr("disabled");
	 var deptFlow=$(obj).val();
	 if(deptFlow==""){
		 var option='<option value="">请选择申请部门</option>';
		 $("#applyUserFlow").append(option);
	 }else{
		 jboxPost("<s:url value='/erp/sales/searchOwnUser'/>?deptFlow="+deptFlow,null,function(data){
			 if(data!=null){
			 $("#applyUserFlow").append('<option></option>');
			 for ( var i = 0; i < data.length; i++) {
					$("#applyUserFlow").append('<option value="'+data[i].userFlow+'">'+data[i].userName+'</option>');
				 }
			 setApplyUserSelected();
		  }
		 },null,false);
	 }	 
}
function setApplyUserSelected(){
	var options=$("#applyUserFlow").find("option");
	$.each(options,function(i,n){
		if($(n).val()=='${param.applyUserFlow}'){
			$(n).attr("selected","selected");
		}
	});
}

</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" action="<s:url value="/erp/sales/contactOrderList/${sessionScope[GlobalConstant.USER_LIST_SCOPE] }" />" method="post">
				<input type="hidden" id="currentPage" name="currentPage" value=""/>
				<input type="hidden" id="checkContactFlow" name="checkContactFlow" value="${param.checkContactFlow }"/>
				<c:if test="${GlobalConstant.USER_LIST_GLOBAL != sessionScope[GlobalConstant.USER_LIST_SCOPE]}">
				<div style="padding-bottom: 10px;">
					客户名称：<input type="text" name="customerName" placeholder="客户名称/别名" value="${param.customerName }" class="xltext"/>
					审核状态：<select class="xlselect" style="width: 140px;" id="contactStatusId" name="contactStatusId" onchange="setStatusName('contactStatus')">
				            	<option value="">请选择</option>
				             	<c:forEach var="contactStatus" items="${contactOrderStatusEnumList}">
						            <option value="${contactStatus.id}" <c:if test="${param.contactStatusName eq contactStatus.name }">selected</c:if>>${contactStatus.name}</option>
						        </c:forEach>
							</select>
							<input type="hidden" name="contactStatusName" id="contactStatusName" value="${param.contactStatusName }"/>
					 联系单编号：<input type="text" name="contactNo" placeholder="联系单编号" value="${param.contactNo }" class="xltext"/>
				   <c:if test="${GlobalConstant.USER_LIST_LOCAL == sessionScope[GlobalConstant.USER_LIST_SCOPE] or GlobalConstant.BUSINESS_DEPT_FLAG == sessionScope[GlobalConstant.USER_LIST_SCOPE]}">      
				           申&nbsp;请&nbsp;&nbsp;人：<select name="applyUserFlow" id="applyUserFlow" class="xlselect" style="width:125px;">
						     <option value="">请选择</option>
						     <c:forEach items="${userList }" var="user">
						        <option value="${user.userFlow }">${user.userName }</option>
						     </c:forEach>
						   </select>
				   </c:if>
				</div>
				<div>
				    产品/项目名称：<input type="text" name="productTypeName" placeholder="产品/项目名称" value="${param.productTypeName }" class="xltext" style="width: 128px;"/>
					需求事项：<select class="xlselect" name="demandMatterId" style="width: 140px;">
				            	<option value="">请选择</option>
				             	<c:forEach var="demandMatter" items="${demandMatterEnumList}">
						            <option value="${demandMatter.id}" <c:if test="${param.demandMatterId eq demandMatter.id }">selected</c:if>>${demandMatter.name}</option>
						        </c:forEach>
							</select>
					&nbsp;&nbsp;&nbsp;申请时间：<input type="text" class="xltext ctime" name="applyDateStart" value="${param.applyDateStart }" style="width: 100px;margin:0px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>&nbsp;~&nbsp;
					<input type="text" class="xltext ctime" name="applyDateEnd" value="${param.applyDateEnd }" style="width: 100px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
					<input type="button" class="search" onclick="search();" value="查&#12288;询" >
					<input type="button" class="search" onclick="add();" value="新&#12288;增" >
				</div>
				</c:if>
				<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq sessionScope[GlobalConstant.USER_LIST_SCOPE]}">
				<div style="padding-bottom: 10px;">
				客户名称：&nbsp;<input type="text" name="customerName" placeholder="客户名称/别名" value="${param.customerName }" class="xltext"/>
					审核状态：<select class="xlselect" style="width: 125px;" id="contactStatusId" name="contactStatusId" onchange="setStatusName('contactStatus')">
				            	<option value="">请选择</option>
				             	<c:forEach var="contactStatus" items="${contactOrderStatusEnumList}">
						            <option value="${contactStatus.id}" <c:if test="${param.contactStatusName eq contactStatus.name }">selected</c:if>>${contactStatus.name}</option>
						        </c:forEach>
							</select>
							<input type="hidden" name="contactStatusName" id="contactStatusName" value="${param.contactStatusName }"/>
				         联系单编号：<input type="text" name="contactNo" placeholder="联系单编号" value="${param.contactNo }" class="xltext"/>
				</div>
				<div style="padding-bottom: 10px;">
					  申请部门： <select name="applyDeptFlow" id="applyDeptFlow" class="xlselect" onchange="searchDeptUser(this);" style="width: 168px;" >
						       <option value="">请选择</option>
						       <c:forEach items="${deptList }" var="dept">
						         <option value="${dept.deptFlow }"<c:if test="${dept.deptFlow eq param.applyDeptFlow }">selected="selected"</c:if>>${dept.deptName }</option>
						       </c:forEach>
						   </select>
              		   申&nbsp;请&nbsp;&nbsp;人：<select name="applyUserFlow" id="applyUserFlow" class="xlselect" style="width:125px;">
						     <option value="">请选择申请部门</option>
						   </select>
					&nbsp;&nbsp;&nbsp;申请时间：&nbsp;<input type="text" class="xltext ctime" name="applyDateStart" value="${param.applyDateStart }" style="width: 100px;margin:0px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>&nbsp;~&nbsp;
					<input type="text" class="xltext ctime" name="applyDateEnd" value="${param.applyDateEnd }" style="width: 100px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
				</div>
				<div>
				   需求事项：&nbsp;<select class="xlselect" name="demandMatterId">
				            	<option value="">请选择</option>
				             	<c:forEach var="demandMatter" items="${demandMatterEnumList}">
						            <option value="${demandMatter.id}" <c:if test="${param.demandMatterId eq demandMatter.id }">selected</c:if>>${demandMatter.name}</option>
						        </c:forEach>
							</select>
					产品/项目名称：<input type="text" name="productTypeName" placeholder="产品/项目名称" value="${param.productTypeName }" class="xltext"/>
				  <input type="button" class="search" onclick="search();" value="查&#12288;询" >
				</div>
				</c:if>
				</form>
			</div>			
			<table class="xllist">
				<colgroup>
					<col width="3%"/>
					<col width="9%"/>
					<col width="15%"/>
					<col width="13%"/>
					<col width="8%"/>
					<col width="8%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="25%"/>
				</colgroup>
				<thead>
				<tr>
					<th>序号</th>
					<th>联系单编号</th>
					<th>客户名称</th>
					<th>产品/项目名称</th>
					<th>需求事项</th>
					<th>申请人</th>
					<th>申请时间</th>
					<th>审核状态</th>
					<th>操作</th>
				</tr>
				</thead>						
				<tbody>
				   <c:if test="${empty contactOrderList  }">
				      <tr><td colspan="9">无记录</td></tr>
				   </c:if>
				   <c:forEach items="${contactOrderList }" var="contactOrder" varStatus="num">
				      <tr class="contactTr" id="contactTr_${contactOrder.contactFlow }">
				        <td>${num.count }</td>
				        <td>${contactOrder.contactNo }</td>
				        <td><a href="javascript:customerInfo('${contactOrder.customerFlow }');" >${contactOrder.customerName }</a></td>
				        <td>
				        ${contactOrder.productTypeName }
				        <c:if test="${(not empty contactOrder.productTypeName) and (not empty contactOrder.orderProductName) }">、</c:if>
				        ${contactOrder.orderProductName }
				        </td>
				        <td>${contactOrder.demandMatterName }</td>
				        <td>${contactOrder.applyUserName }</td>
				        <td>${contactOrder.applyDate }</td>
				        <td>${contactOrder.contactStatusName }</td>
				        <td>
				          <c:if test="${contactOrder.contactStatusId eq contactOrderStatusEnumSave.id }">
				           <c:if test="${GlobalConstant.USER_LIST_GLOBAL != sessionScope[GlobalConstant.USER_LIST_SCOPE]}">
				             [<a href="javascript:edit('${contactOrder.contactFlow }');" onclick="checkedView('${contactOrder.contactFlow }');">编辑</a>] | 
				             [<a href="javascript:delImplement('${contactOrder.contactFlow }');" onclick="checkedView('${contactOrder.contactFlow }');">删除</a>] |
				             <c:if test="${(scope != GlobalConstant.MANAGER_FLAG) and (scope != GlobalConstant.BUSINESS_FLAG) and (scope != GlobalConstant.BUSINESS_DEPT_FLAG)}">
				             [<a href="javascript:submitImplement('${contactOrder.contactFlow }');" onclick="checkedView('${contactOrder.contactFlow }');">提交</a>]
				             </c:if>
				             <c:if test="${(scope eq GlobalConstant.MANAGER_FLAG) or (scope eq GlobalConstant.BUSINESS_FLAG) or (scope eq GlobalConstant.BUSINESS_DEPT_FLAG)}">
				             [<a href="javascript:auditWorkContact('${contactOrder.contactFlow }');" onclick="checkedView('${contactOrder.contactFlow }');">提交</a>]
				             </c:if>
				           </c:if>
				          </c:if>
				          
				          <c:if test="${contactOrder.contactStatusName != contactOrderStatusEnumSave.name}">
				             [<a href="javascript:info('${contactOrder.contactFlow }');" onclick="checkedView('${contactOrder.contactFlow }');">详情</a>]
				             [<a href="javascript:auditOpinion('${contactOrder.contactFlow }');" onclick="checkedView('${contactOrder.contactFlow }');">审核意见</a>]
				             [<a href="javascript:trackOpinion('${contactOrder.contactFlow }');" onclick="checkedView('${contactOrder.contactFlow }');">实施进度</a>]
				          </c:if>
				        </td>
				      </tr>
				   </c:forEach>
				</tbody>
			</table>
			<p>
			   	<c:set var="pageView" value="${pdfn:getPageView(contactOrderList)}" scope="request"></c:set>
				<pd:pagination toPage="toPage"/>
			</p>
	</div>
</div>
</body>
</html>