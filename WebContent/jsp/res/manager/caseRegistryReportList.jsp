<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
var title="大病例登记信息";
</script>
<div class="i-trend-main-div" style="padding: 15px 10px;">
	<form id="recSearchForm" style="margin-bottom: 10px;">
		&#12288;
		届数：
		<select name="sessionNumber" style="width: 80px;">
			<option></option>
			<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
				<option value="${dict.dictName}" ${param.sessionNumber eq dict.dictName?'selected':''}>${dict.dictName}</option>
			</c:forEach>
		</select>
		&#12288;
	 	专业：
	 	<input type="text" name="specialized" value="${param.specialized}" style="width: 100px;"/>
	 	<!--  &#12288;
	 	医院科室：
	 	<select name="deptFlow" style="width: 100px;">
	 		<option></option>
	 		<c:forEach items="${deptList}" var="dept">
	 			<option value="${dept.deptFlow}" ${param.deptFlow eq dept.deptFlow?'selected':''}>${dept.deptName}</option>
	 		</c:forEach>
	 	</select>-->
	 	&#12288;
		医师姓名：
	 	<input type="text" name="userName" value="${param.userName}" style="width: 80px;"/>
	 	&#12288;
		工号：
	 	<input type="text" name="doctorCode" value="${param.doctorCode}" style="width: 80px;"/>
	 	&#12288;
	 	轮转时间：
	 	<input type="text" name="startDate" value="${param.startDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" readonly="readonly" style="width: 80px;">
	 	~
	 	<input type="text" name="endDate" value="${param.endDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" readonly="readonly" style="width: 80px;">
	 	&#12288;
	 	<input type="button" class="search" value="查&#12288;询" onclick="loadContent('${param.recTypeId}');"/>
	</form>
	
	<table class="xllist" width="100%">
		<tr>
			<th width="25%">医院</th>
			<th>专业</th>
			<th>届数</th>
			<th>姓名</th>
			<th>轮转科室</th>
			<th>要求数</th>
			<th>完成数</th>
			<th>审核数</th>
			<th>操作</th>
		</tr>
		<c:forEach items="${processExtList}" var="processExt">
			<c:set value="${processExt.doctorExt.rotationFlow}${processExt.schDeptFlow}" var="reqKey"/>
			<c:forEach items="${deptReqMap[reqKey]}" var="deptReq">
				<tr>
					<td>${processExt.doctorExt.orgName}</td>
					<td>${processExt.doctorExt.specialized}</td>
					<td>${processExt.doctorExt.sessionNumber}</td>
					<td>${processExt.doctorExt.sysUser.userName}</td>
					<td>${processExt.schDeptName}</td>
					<td>${deptReq.reqNum+0}</td>
					<c:set value="${processExt.userFlow}${processExt.schDeptFlow}${deptReq.itemId}finish" var="finishKey"/>
					<td>${countMap[finishKey]+0}</td>
					<c:set value="${processExt.userFlow}${processExt.schDeptFlow}${deptReq.itemId}audit" var="auditKey"/>
					<td>${countMap[auditKey]+0}</td>
					<td>
						[
						<a style="color: blue;cursor: pointer;" onclick="detail('${processExt.userFlow}','${processExt.schDeptFlow}');">详细</a>
						]
					</td>
				</tr>
			</c:forEach>
		</c:forEach>
	</table>
</div>
