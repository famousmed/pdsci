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
	jboxOpen("<s:url value='/sys/role/edit'/>","添加角色信息", 900, 500);
}
function edit(roleFlow){
	jboxOpen("<s:url value='/sys/role/edit'/>?roleFlow="+roleFlow,"编辑角色信息", 900, 500);
}
function del(roleFlow,recordStatus){
	var msg = "";
	if(recordStatus=='${GlobalConstant.RECORD_STATUS_N}'){
		msg = "停用";
	}else if(recordStatus=='${GlobalConstant.RECORD_STATUS_Y}'){
		msg = "启用";
	}
	jboxConfirm("确认" + msg + "该记录吗？",function () {
		var url = "<s:url value='/sys/role/delete?roleFlow='/>" + roleFlow+ "&recordStatus=" + recordStatus;
		jboxGet(url,null,function(){
			search();					
		});			
	});
}

function search(){
	jboxStartLoading();
	$("#searchForm").submit();	
}
function getpop(roleFlow,wsId){
	jboxOpen("<s:url value='/sys/role/getpop'/>?roleFlow="+roleFlow+"&wsId="+wsId,"权限信息", 900, 600);
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
    			oldPostData = oldPostData+"&roleFlow="+sortedId;
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
    			postdata = postdata+"&roleFlow="+sortedId;
    		});
    		if(oldPostData==postdata){
    			return;
    		}
    		var url = "<s:url value='/sys/role/saveOrder'/>";
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
			<form id="searchForm" action="<s:url value="/sys/role/list"/>" method="post">
			角色名称：
			<input class="xltext" name="roleName" type="text" value="${param.roleName}"/>
			<input class="search" type="button" value="查 &#12288;询" onclick="search()"/>
			<input class="search" type="button" value="新&#12288;增" onclick="add()"/>
			</form>
		</div>
		<div class="czdingdan" id="list0_c_1" style="display: block;">
			<table class="xllist">
				<thead>
					<tr>
						<th width="10%">角色名称</th>
						<th width="10%">角色级别</th>
<%-- 						<c:if test="${sessionScope.currWsId==GlobalConstant.SRM_WS_ID}">	
						<th width="10%">允许注册</th>
						<th width="10%">注册页面</th>
						</c:if>
 --%>						<th width="10%">父角色</th>
						<th width="10%">操作</th>
					</tr>
				</thead>
				<tbody id="roleSortable">
					<c:forEach items="${sysRoleList}" var="sysRole">
						<tr id="${sysRole.roleFlow}">
							<td>${sysRole.roleName}</td>
							<td>${sysRole.roleLevelName}</td>
							<%-- <c:if test="${sessionScope.currWsId==GlobalConstant.SRM_WS_ID}">	
							<td>${sysRole.allowRegFlag}</td>
							<td>${sysRole.regPageName}</td>
							</c:if> --%>
							<td>${sysRole.parentRoleName}</td>
							<td>	
								<c:if test="${sysRole.recordStatus == GlobalConstant.RECORD_STATUS_Y }">
								[<a href="javascript:edit('${sysRole.roleFlow}');" >编辑</a>] | 
								[<a href="javascript:del('${sysRole.roleFlow}','${GlobalConstant.RECORD_STATUS_N}');" >停用</a>] | 
								[<a href="javascript:getpop('${sysRole.roleFlow}','${sysRole.wsId}');" >权限</a>] 
								</c:if>
								<c:if test="${sysRole.recordStatus == GlobalConstant.RECORD_STATUS_N }">
								[<a href="javascript:del('${sysRole.roleFlow}','${GlobalConstant.RECORD_STATUS_Y}');" >启用</a>] 
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
				<c:if test="${sysRoleList == null || sysRoleList.size()==0 }"> 
					<tr> 
						<td align="center" colspan="4">无记录</td>
					</tr>
				</c:if>
			</table>
		</div>
	</div> 
</div>
</body>
</html>