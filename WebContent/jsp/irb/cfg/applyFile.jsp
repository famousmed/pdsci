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
 $().ready(function(){
	changePjType();
}); 
	function showEdit(id){
		var irbType = $("#irbType").val();
		var pjType = $("#pjType").val();
		var url = "<s:url value='/irb/cfg/applyFileEdit' />?irbType="+irbType+"&pjType="+pjType+"&id="+id;
		var title = "新增";
		if(id){
			title = "修改";
		}
		jboxOpen(url,title+"送审文件模板",500,300,true);
	}
	function changePjType(){
		var irbType = $("#irbType").val();
		if(irbType!='${irbTypeEnumInit.id}'){
			$("#pjTypeTitle").hide();
			$("#pjType").hide();
		}else{
			$("#pjTypeTitle").show();
			$("#pjType").show();
		}
	}
	function search(){
		$("#searchForm").submit();
	}
	function del(id){
		jboxConfirm("确认删除记录吗？",function(){
			var irbType = $("#irbType").val();
			var pjType = $("#pjType").val();
			var url="<s:url value='/irb/cfg/operaApplyFile'/>?id="+id+"&opera=del&irbType="+irbType+"&pjType="+pjType;
			jboxPost(url,null,function(resp){
				if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
					search();
				}
			},null,true);
		},null);
		
		
	}
</script>
</head>
<body>
	<div class="mainright" id="mainright">
	<div class="content">
	<form id="searchForm" action="<s:url value="/irb/cfg/applyFile" />" method="post" >
		 <div class="title1 clearfix">
		 		送审文件类型：
		 		<select id="irbType"  name="irbType"  class="xlselect" onchange="changePjType();search();">
	                <c:forEach items="${irbTypeEnumList}" var="dict">
	                	<option value="${dict.id }" <c:if test="${dict.id==param.irbType}">selected="selected"</c:if> >${dict.name }</option>
	                </c:forEach>
                </select>
                <span id="pjTypeTitle">&nbsp;子类型：</span>
                <select id="pjType" name="pjType"  class="xlselect" onchange="search();">
	                <c:forEach items="${projCategroyEnumList}" var="dict">
	                	<c:if test="${dict.id != projCategroyEnumRc.id && dict.id != projCategroyEnumXk.id}"> 
	                		<option value="${dict.id }" <c:if test="${dict.id==param.pjType || (empty param.pjType && dict.id==projCategroyEnumYw.id) }">selected="selected"</c:if> >${dict.name }</option>
	               		</c:if>
	                </c:forEach>
                </select>
					<input type="button" class="search" onclick="showEdit('');" value="新&#12288;增">
		</div>
		<table class="xllist" > 
			<thead>
			<tr>
				<th width="10%">序号</th>
				<th width="40%">文件名</th>
				<th width="10%">版本号</th>
				<th width="10%">版本日期</th>
				<th width="15%">受理通知->送审材料<br>中是否显示</th>
				<th width="15%" >操作</th>
			</tr>
			</thead>
			<c:forEach items="${list}" var="af" varStatus="status">
			<tr>
				<td>${status.count}</td>
				<td>${af.name}</td>
				<td><c:if test="${af.version==GlobalConstant.FLAG_Y}">有</c:if><c:if test="${af.version==GlobalConstant.FLAG_N}">无</c:if></td>
				<td><c:if test="${af.versionDate==GlobalConstant.FLAG_Y}">有</c:if><c:if test="${af.versionDate==GlobalConstant.FLAG_N}">无</c:if></td>
				<td><c:if test="${af.showNotice==GlobalConstant.FLAG_Y}">是</c:if><c:if test="${af.showNotice==GlobalConstant.FLAG_N}">否</c:if></td>
				<td><a href="javascript:void(0)" onclick="showEdit('${af.id}')">[修改]</a>&#12288;<a href="javascript:void(0)" onclick="del('${af.id}')">[删除]</a></td>
			</tr>
		   </c:forEach>
		</table>
		</form>
	</div> 
</div>
</body>
</html>