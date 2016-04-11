<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
var title="操作技能登记信息";
</script>
<style>
	.searchTable th{text-align: right;font-weight: normal;padding-left: 10px;}
	.searchTable td{text-align: left;}
	.searchTable tr{height: 35px;}
</style>
<div class="i-trend-main-div" style="padding: 15px 10px;">
	<form id="recSearchForm" style="margin-bottom: 10px;">
		<table class="searchTable">
			<tr>
				<th>届数：</th>
				<td>
					<select name="sessionNumber" style="width: 80px;">
						<option></option>
						<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
							<option value="${dict.dictName}" ${param.sessionNumber eq dict.dictName?'selected':''}>${dict.dictName}</option>
						</c:forEach>
					</select>
				</td>
				<th>专业：</th>
				<td>
					<input type="text" name="specialized" value="${param.specialized}" style="width: 100px;"/>
				</td>
				<th>操作技能：</th>
				<td>
					<input type="text" name="itemName" value="${param.itemName}" style="width: 100px;"/>
				</td>
				<th>轮转时间：</th>
				<td>
					<input type="text" name="startDate" value="${param.startDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" readonly="readonly" style="width: 80px;">
				 	~
				 	<input type="text" name="endDate" value="${param.endDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" readonly="readonly" style="width: 80px;">
				</td>
				<th>
					<input type="button" class="search" value="查&#12288;询" onclick="loadContent('${param.recTypeId}');"/>
				</th>
			</tr>
			<tr>
				<th>
					工号：
				</th>
				<td>
					<input type="text" name="doctorCode" value="${param.doctorCode}" style="width: 80px;"/>
				</td>
				<th>医师姓名：</th>
				<td>
					<input type="text" name="userName" value="${param.userName}" style="width: 80px;"/>
				</td>
			</tr>
		</table>
	</form>
	
	<table class="xllist" width="100%">
		<tr>
			<th width="25%">医院</th>
			<th>专业</th>
			<th>届数</th>
			<th>姓名</th>
			<th>轮转科室</th>
			<th>病种</th>
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
					<td>${deptReq.itemName}</td>
					<td>${deptReq.reqNum+0}</td>
					<c:set value="${processExt.userFlow}${processExt.schDeptFlow}${deptReq.itemName}finish" var="finishKey"/>
					<td>${countMap[finishKey]+0}</td>
					<c:set value="${processExt.userFlow}${processExt.schDeptFlow}${deptReq.itemName}audit" var="auditKey"/>
					<td>${countMap[auditKey]+0}</td>
					<td>
						[
						<a style="color: blue;cursor: pointer;" onclick="detail('${processExt.userFlow}','${processExt.schDeptFlow}','${processExt.doctorExt.rotationFlow}','${deptReq.reqFlow}');">详细</a>
						]
					</td>
				</tr>
			</c:forEach>
		</c:forEach>
	</table>
</div>
