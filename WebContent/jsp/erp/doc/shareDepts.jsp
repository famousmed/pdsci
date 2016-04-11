<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<script type="text/javascript">
	$(document).ready(function(){
		$(".parentA").click(function(event){
	        event.stopPropagation();
	    });
		
		if("${param.type}"=="add"){
			addCheckedRecords();
			addCheckedRecords2();
		}
	});
</script>

<div class="mainright">
<div class="content">
<div class="title1 clearfix">

<form id="deptsForm" action="<s:url value="/erp/doc/searchShareDepts" />" method="post">
	&#12288;部门名称：<input type="text" id="deptName" name="deptName" value="${param.deptName}"  class="xltext"/>	
	     <input type="button" class="search" onclick="searchShareDepts();" value="查&#12288;询">
</form>
<table class="xllist" > 
	<colgroup>
		<col width="5%"/>
		<col width="95%"/>
	</colgroup>
	<tr>
		<th><%-- <input type="checkBox" onclick="selectAll('${shareTypeEnumDept.id}', this);"> --%></th>
		<th>部门</th>
	</tr>
	<tbody>
		<c:forEach items="${deptList}" var="dept">
		<c:set var="deptFlow_my" value="${dept.deptFlow}_my"/>
		<c:set var="deptFlow_other" value="${dept.deptFlow}_other"/>
		<tr <c:if test="${!(not empty docShareMap[dept.deptFlow] and param.docCategory=='shared')}">
				style="height:20px;cursor: pointer;" onclick="selShare('${shareTypeEnumDept.id}','${dept.deptFlow}','${dept.deptName}','tr');"
			</c:if> >	
			<td>
				<input type="checkbox" id="${dept.deptFlow}" name="recordFlow" class="parentA" shareRecordName="${dept.deptName}"
				<c:if test="${not empty docShareMap[deptFlow_my] or not empty docShareMap[deptFlow_other]}">checked="checked"</c:if>
				<c:if test="${not empty docShareMap[deptFlow_other] and param.docCategory=='shared'}">disabled="disabled"</c:if>
				onclick="selShare('${shareTypeEnumDept.id}','${dept.deptFlow}','${dept.deptName}','');"
				  style="cursor: pointer;"/>
			</td>	
			<td>${dept.deptName}</td>
		</tr>
		</c:forEach>
	</tbody>
	<c:if test="${empty deptList}"> 
		<tr> 
			<td colspan="2">无记录</td>
		</tr>
	</c:if>
</table>

</div>
</div>
</div>
