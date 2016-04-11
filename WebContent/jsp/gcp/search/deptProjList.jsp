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
    
 	$(document).ready(function(){
		 var cell = $("#deptProjTb").find("tr").eq(0).children().length;
		 var result = $("#result").children();
		 for(var i=2;i<=cell;i++){
			 var sumStand = 0;
			 $("#deptProjTb tr td:nth-child("+i+")").each(function(){
				 var val = $(this).text();
				 if (val == null || val == undefined || val == '' || isNaN(val)){
						val = 0;
					}
				 if(parseFloat(val) < 0){
						return ;
					}
				 sumStand = parseFloat(sumStand)+parseFloat(val);
			 });
			 $(result.eq(i-1)).text(parseFloat(sumStand.toFixed(2)));
		}
	}); 
		
</script>
</head>
<body>
<div class="mainright">
	<div class="content" style="padding-top: 10px;">
		
		    <table class="xllist" style="width:100%; margin-top: 10px;">
			<thead>
				<tr>
					<th width="24%">专业组</th>
					<th width="19%">${projCategroyEnumYw.name }</th>
					<th width="19%">${projCategroyEnumKy.name }</th>
					<th width="19%">${projCategroyEnumQx.name }</th>
					<th width="19%"><font color="red">汇总</font></th>
				</tr>
			</thead>
			<tbody id="deptProjTb">
			<c:if test="${empty deptList}">
			<tr>
				<td colspan="5">无记录！</td>
			</tr>
			</c:if>
			<c:forEach items="${deptList}" var="dept" varStatus="num">
			<tr>
				<td width="24%">${dept.deptName}</td>
				<td width="19%">
				     ${deptProjMap[dept.deptFlow][projCategroyEnumYw.id]}
				</td>
				<td width="19%">
				     ${deptProjMap[dept.deptFlow][projCategroyEnumKy.id]}
				</td>
				<td width="19%">
				     ${deptProjMap[dept.deptFlow][projCategroyEnumQx.id]}
				</td>
				<td width="19%" id="deptResult">
					${deptProjMap[dept.deptFlow][projCategroyEnumYw.id]+
					deptProjMap[dept.deptFlow][projCategroyEnumKy.id]+
					deptProjMap[dept.deptFlow][projCategroyEnumQx.id]}
				</td>
			</tr>
			</c:forEach>	       
			<c:if test="${not empty deptList}">
			   <tr id="result">
			      <td><font color="red">汇总</font></td>
			      <td></td>
			      <td></td>
			      <td></td>
			      <td></td>
			    </tr>
			</c:if>
			</tbody>
			</table>
	</div> 
</div>
</body>
</html>