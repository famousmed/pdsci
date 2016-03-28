<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="true"/>
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

function add(){
	jboxOpen("<s:url value='/sys/dept/edit?orgFlow=${param.orgFlow}'/>","编辑部门信息", 500, 300);
}

function edit(deptFlow){
	jboxOpen("<s:url value='/sys/dept/edit?deptFlow='/>"+deptFlow,"编辑部门信息", 500, 300);
}
function del(deptFlow,recordStatus){
	var msg = "";
	if (recordStatus == '${GlobalConstant.RECORD_STATUS_N}') {
		msg = "停用";
	} else if (recordStatus == '${GlobalConstant.RECORD_STATUS_Y}') {
		msg = "启用";
	}
	jboxConfirm("确认" + msg + "该记录吗？",function () {
		var url = "<s:url value='/sys/dept/delete?deptFlow='/>" + deptFlow+ "&recordStatus=" + recordStatus;
		jboxGet(url,null,function(){
			search();					
		});			
	});
}
function search(){
	jboxStartLoading();
	$("#searchForm").submit();
}
var fixHelper = function(e, ui) {
    ui.children().each(function() {
   	//在拖动时，拖动行的cell（单元格）宽度会发生改变。在这里做了处理就没问题了  
        $(this).width($(this).width());
    });
    return ui;
};
$(function() {
	var oldPostData = "";
   $( "#roleSortable" ).sortable({
   	helper: fixHelper,  
   	create: function(e, ui){
   		var oldSortedIds = $( "#roleSortable" ).sortable( "toArray" );
   		$.each(oldSortedIds,function(i,sortedId){
   			oldPostData = oldPostData+"&deptFlow="+sortedId;
   		});
   	},
   	start:function(e, ui){
   	     //拖动时的行，要用ui.helper
   	    ui.helper.css({"background":"#eee"});
   	    return ui; 
   	}, 
   	stop: function( event, ui ) {
   		ui.item.css({"background":"#fff"});
   		var sortedIds = $( "#roleSortable" ).sortable( "toArray" );
   		var postdata = "";
   		$.each(sortedIds,function(i,sortedId){
   			postdata = postdata+"&deptFlow="+sortedId;
   		});
   		if(oldPostData==postdata){
   			return;
   		}
   		var url = "<s:url value='/sys/dept/saveOrder'/>";
   		jboxPost(url, postdata, function() {
   			},null,false);
   		oldPostData = postdata;
   	}
   });
   $( "#sortable" ).disableSelection();
});
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		 <div class="title1 clearfix">
		 <form id="searchForm" action="<s:url value="/sys/dept/list/${sessionScope.deptListScope}" />" method="post" > 
		 		<c:if test="${sessionScope.deptListScope==GlobalConstant.DEPT_LIST_GLOBAL }">
		 		机构名称：
		 		<select  class="xlselect" name="orgFlow"  onchange="search();">	
					<option value="">请选择</option>
				<c:forEach var="org" items="${applicationScope.sysOrgList}">
					<option value="${org.orgFlow}" <c:if test="${param.orgFlow==org.orgFlow}">selected="selected"</c:if>>${org.orgName}</option>
				</c:forEach>
				</select>
				</c:if>
				<c:if test="${sessionScope.deptListScope==GlobalConstant.DEPT_LIST_LOCAL }">
					<input type="hidden" name="orgFlow" value="${sessionScope.currUser.orgFlow }"/>
				</c:if>
		 		部门代码:<input type="text" name="deptCode" value="${param.deptCode}"  class="xltext"/>
		 		部门名称:<input type="text" name="deptName" value="${param.deptName}"  class="xltext"/>
				<input type="button" class="search" onclick="search();" value="查&#12288;询">
		     	<input type="button" class="search" onclick="add();" value="新&#12288;增">
		</form>
		</div>		
		<table class="xllist" > 
			<thead>
			<tr>
				<th width="80px">部门代码</th>
				<th width="120px">部门名称</th>
				<th width="100px" >操作</th>
			</tr>
			</thead>
			<tbody id="roleSortable">
			<c:forEach items="${deptList}" var="dept">
			<tr id="${dept.deptFlow}">
				<td>${dept.deptCode }</td>
				<td>${dept.deptName }</td>
				<td>
					<c:if test="${dept.recordStatus == GlobalConstant.RECORD_STATUS_Y }">
						[<a href="javascript:edit('${dept.deptFlow}');" >编辑</a>] | [<a href="javascript:del('${dept.deptFlow}','${GlobalConstant.RECORD_STATUS_N}');" >停用</a>]
					</c:if>
					<c:if test="${dept.recordStatus == GlobalConstant.RECORD_STATUS_N }">
						[<a href="javascript:del('${dept.deptFlow}','${GlobalConstant.RECORD_STATUS_Y}');" >启用</a>]
					</c:if>
				</td>
			</tr>
		   </c:forEach>
		   </tbody>
		</table>
	</div> 
</div>
</body>
</html>