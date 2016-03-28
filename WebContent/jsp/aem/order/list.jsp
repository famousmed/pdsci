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
function add() {
	jboxOpen("<s:url value='/sys/user/edit'/>","新增实验信息", 900, 300);
}
function edit(userFlow) {
	jboxOpen("<s:url value='/sys/user/edit?userFlow='/>"+ userFlow,"编辑实验信息", 900, 300);
}
function go(){
	location.href = "http://"+$("#web").val();
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				 <form id="searchForm" action="<s:url value="/sys/user/list/${sessionScope.userListScope}" />" method="post" > 
				     	动物名称：<input type="text" name="userName" value="${param.userName}"  class="xltext"/>  
				     	<input type="text" id="web" >			
				     	<input type="button" class="search" onclick="go();" value="查&#12288;询">
				</form>
			</div>
	<table class="xllist" > 
		<tr>
			<th width="20px"></th>
			<th width="50px">动物</th>
			<th width="50px">数量</th>
			<th width="30px">单位</th>
			<th width="30px">总金额</th>
			<th width="60px">订购时间</th>
			<th width="60px">供应商</th>
			<th width="30px">是否入库</th>
			<th width="60px">入库人</th>
			<th width="60px">入库时间</th>
			<th width="60px">操作</th>
		</tr>
		<tr>			
			<td></td>
			<td>小白鼠</td>
			<td>300</td>
			<td>只</td>
			<td>1000.00</td>
			<td>2014-05-25</td>
			<td>****单位</td>
			<td>否</td>
			<td></td>
			<td></td>
			<td>入库</td>
		</tr>			
			<td></td>
			<td>小白鼠</td>
			<td>300</td>
			<td>只</td>
			<td>1000.00</td>
			<td>2014-05-25</td>
			<td>****单位</td>
			<td>否</td>
			<td></td>
			<td></td>
			<td>入库</td>
		</tr>
		<tr>			
			<td></td>
			<td>小白鼠</td>
			<td>300</td>
			<td>只</td>
			<td>1000.00</td>
			<td>2014-05-25</td>
			<td>****单位</td>
			<td>是</td>
			<td>张三</td>
			<td>2014-05-27</td>
			<td></td>
		</tr>
	</table>
	</div>
</div>
</body>
</html>