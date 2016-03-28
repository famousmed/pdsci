<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<select class="<c:if test="${sessionScope.currWsId=='srm' and applicationScope.sysCfgMap['srm_for_use']=='local'}">validate[required] </c:if>xlselect" id="deptFlow" name="deptFlow" onchange="mulChange();">
	<option value="">请选择</option>
	<c:forEach items="${sysDeptList}" var="dept">
	<option value="${dept.deptFlow}" <c:if test="${dept.deptFlow==param.deptFlow}">selected</c:if> tabindex="">${dept.deptName}</option>
	</c:forEach>
</select>
