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
		 var cell = $("#fundTb").find("tr").eq(0).children().length;
		 var result = $("#result").children();
		 for(var i=5;i<=cell;i++){
			 var sumStand = 0;
			 $("#fundTb tr td:nth-child("+i+")").each(function(){
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
	<div class="content">
		<div class="title1 clearfix">
		    <form id="searchForm" action="<s:url value='/gcp/fin/projFundList'/>" method="post">
		      	项目名称：<input type="text" name="projName" value="${param.projName }" class="xltext"/>
		      	专业组：
		        <select name="applyDeptFlow" class="xlselect" onchange="search();">
		           <option value="">请选择</option>
		           <c:forEach items="${deptList }" var="dept">
		             <option value="${dept.deptFlow }" <c:if test="${dept.deptFlow eq param.applyDeptFlow}">selected="selected"</c:if>>${dept.deptName }</option>
		           </c:forEach>
		        </select>
		      	项目类别：
				<select name="projCategoryId" onchange="search()" class="xlselect">
					<option value="">全部</option>
					<option value="${projCategroyEnumYw.id }" <c:if test="${param.projCategoryId==projCategroyEnumYw.id}">selected="selected"</c:if> >${projCategroyEnumYw.name}</option>
					<option value="${projCategroyEnumKy.id }" <c:if test="${param.projCategoryId==projCategroyEnumKy.id}">selected="selected"</c:if> >${projCategroyEnumKy.name}</option>
					<option value="${projCategroyEnumQx.id }" <c:if test="${param.projCategoryId==projCategroyEnumQx.id}">selected="selected"</c:if> >${projCategroyEnumQx.name}</option>
				</select>
		         <input type="button" onclick="search();" value="查&#12288;询" class="search">
		    </form>
		    </div>
		    <table class="xllist">
			<thead>
				<tr>
					<th width="5%">序号</th>
					<th width="25%">项目名称</th>
					<th width="10%">CFDA批件号</th>
					<th width="10%">合同编号</th>
					<th width="7%">累计到账</th>
					<th width="7%">累计支出</th>
					<th width="7%">结余金额</th>
					<th width="8%">专业组劳务费</th>
					<th width="7%">医院管理费</th>
					<th width="7%">机构质控费</th>
					<th width="7%">机构运行费</th>
				</tr>
			</thead>
			<tbody id="fundTb">
			<c:if test="${empty projList}">
			<tr>
				<td colspan="11">无记录！</td>
			</tr>
			</c:if>
			<c:forEach items="${projList}" var="proj" varStatus="num">
			<tr>
				<td width="5%">${num.count}</td>
				<td width="25%">${proj.projName}</td>
				<td width="10%">${proj.cfdaNo}</td>
				<td width="10%">${projContractNoMap[proj.projFlow]}</td>
				<td width="7%">
			        ${countMap[proj.projFlow]['fundInTotal'] }
			        <c:if test="${empty countMap[proj.projFlow]['fundInTotal']}">0</c:if>
				</td>
				<td width="7%">
				   ${countMap[proj.projFlow]['fundOutTotal'] }
				<c:if test="${empty countMap[proj.projFlow]['fundOutTotal']}">0</c:if>
				</td>
				<td width="7%">
				  ${countMap[proj.projFlow]['fundRemainTotal'] }
				  <c:if test="${empty countMap[proj.projFlow]['fundRemainTotal']}">0</c:if>
				</td>
				<td width="8%">
				   ${countMap[proj.projFlow]['detp'] }
				   <c:if test="${empty countMap[proj.projFlow]['detp']}">0</c:if>
				</td>
				<td width="7%">
				   ${countMap[proj.projFlow]['hospital'] }
				   <c:if test="${empty countMap[proj.projFlow]['hospital']}">0</c:if>
				</td>
				<td width="7%">
				   ${countMap[proj.projFlow]['qc'] }
				   <c:if test="${empty countMap[proj.projFlow]['qc']}">0</c:if>
				</td>
				<td width="7%">
				   ${countMap[proj.projFlow]['gcp'] }
				   <c:if test="${empty countMap[proj.projFlow]['gcp']}">0</c:if>
				</td>
			</tr>
			</c:forEach>	       
			<c:if test="${not empty projList}">
			   <tr id="result">
			      <td><font color="red">汇总</font></td>
			      <td>————</td>
			      <td>————</td>
			      <td>————</td>
			      <td></td>
			      <td></td>
			      <td></td>
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