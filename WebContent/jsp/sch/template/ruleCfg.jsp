<%-- rule.jsp  关联科室功能同步修正轮转科室时使用的辅助页面 --%>
<c:forEach items="${rotationDeptList}" var="rotationDept" varStatus="statusFlag"> 
	<c:set var="isOne" value="${rotationDeptList.size()==1}" />
	<tr class="body">
		<input class="record" type="hidden" value="${rotationDept.recordFlow}"/>
		<td>
		<span style="float: left;margin-left: 10px;">
			<img class="sortbtn" title="上移" src="<s:url value='/css/skin/${skinPath}/images/up.png'/>" onclick="moveDept('up','${rotationDept.groupFlow}${rotationDept.standardDeptId}',this);" style="cursor: pointer;<c:if test="${isOne}">display: none;</c:if>"/>
			<img class="sortbtn" title="下移" src="<s:url value='/css/skin/${skinPath}/images/down.png'/>" onclick="moveDept('down','${rotationDept.groupFlow}${rotationDept.standardDeptId}',this);" style="cursor: pointer;<c:if test="${isOne}">display: none;</c:if>"/>
		</span>
		<font class="data">${rotationDept.schDeptName}</font>
		<div class="data"  style="display: none;">
			<img title="移除" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="removeCfg('<c:out value="${rotationDept.groupFlow}" default="must"/>${rotationDept.standardDeptId}',this);"  style="display: none;cursor: pointer;margin-right: 10px;" class="data"/>
			<select class="schDeptFlow" style="width: 100px;" onchange="checkResel('<c:out value="${rotationDept.groupFlow}" default="must"/>${rotationDept.standardDeptId}',this);">
			<option>
			<c:forEach items="${deptRelList}" var="deptRel">
				<option value="${deptRel.schDeptFlow}" 
				<c:if test="${rotationDept.schDeptFlow eq deptRel.schDeptFlow}">selected</c:if>
				>${deptRel.schDeptName}</option>
			</c:forEach>
			</select>
		</div>
		</td>
		<td>
		<font class="schMonth data">
			${rotationDept.schMonth}
		</font>
		<input type="text" value="${rotationDept.schMonth}" class="schMonth data"  style="display: none;width: 15px;"/>
		</td>
		<td>
			${standardRotationDept.deptNote}
		</td>
<%-- 		<c:if test="${empty rotationDept.groupFlow}"> --%>
<!-- 			<td> -->
<%-- 				<font>${rotationDept.schMonth}</font> --%>
<%-- 				<input type="text" value="${rotationDept.schMonth}" class="data schMonth"  style="display: none;width: 15px;"> --%>
<!-- 			</td> -->
<%-- 		</c:if> --%>
<%-- 		<c:if test="${empty rotationDept.groupFlow}"> --%>
<%-- 			<td>${standardRotationDept.deptNote}</td> --%>
<%-- 		</c:if> --%>
		<td rowspan="100" <c:if test="${!statusFlag.first}">style="display: none;"</c:if>>
			<div class="data">
				<a style="cursor: pointer;color: blue;" onclick="ruleCfg('<c:out value="${rotationDept.groupFlow}" default="must"/>${rotationDept.standardDeptId}');">调整</a>
				&nbsp;|&nbsp;
				<a href="javascript:rotationStandard('${standardRotationDept.recordFlow}');" style="color: blue;cursor: pointer;">轮转规范</a>
			</div>
			<div class="data" style="display: none;">
				<a style="cursor: pointer;color: blue;" onclick="addSchDept(this);">添加</a>
<!-- 				&nbsp;|&nbsp; -->
<%-- 				<a style="cursor: pointer;color: blue;" onclick="removeCfg('<c:out value="${rotationDept.groupFlow}" default="must"/>${rotationDept.standardDeptId}',this);">移除</a> --%>
				&nbsp;|&nbsp;
				<a style="cursor: pointer;color: blue;" onclick="saveCfg('<c:out value="${rotationDept.groupFlow}" default="must"/>${rotationDept.standardDeptId}','${rotationDept.standardDeptId}','${rotationDept.groupFlow}');">确认</a>
				&nbsp;|&nbsp;
				<a style="cursor: pointer;color: blue;" onclick="cancelCfg('<c:out value="${rotationDept.groupFlow}" default="must"/>${rotationDept.standardDeptId}');">取消</a>
			</div>
		</td>
	</tr>
</c:forEach>