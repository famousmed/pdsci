<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<style type="text/css">
table.basic th,table.basic td{text-align: center;padding: 0;}
</style>
<script type="text/javascript">
	//清空组员选科与排班
	function clearSelAndRostering(){
		<c:if test="${!empty isUseMap}">
			jboxConfirm("确认清空所有学员的选科和排班数据？",function(){
				var doctorFlows = "";
				$("[hasSelOrResult]").each(function(){
					doctorFlows+=("&doctorFlows="+$(this).attr("hasSelOrResult"));
				});
				jboxPost("<s:url value='/sch/arrange/clearSelAndRostering'/>",doctorFlows,function(resp){
					if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
						$(".selDoc").click();
						jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					}else{
						jboxTip("${GlobalConstant.OPRE_FAIL}");
					}
				},null,false);
			},null);
		</c:if>
		<c:if test="${empty isUseMap}">
			jboxTip("该组不需要清空！");
		</c:if>
	}
	
	//检测选科,保存选择科室
	function selDept(groupFlow,rotationDept){
		var group = $("#"+groupFlow);
		var isFree = "${schSelTypeEnumFree.id}" == group.attr("selTypeId");
		var deptNum = parseInt(group.attr("deptNum"));
		var maxDeptNum = parseInt(group.attr("maxDeptNum"));
		if(rotationDept.checked){
			var selNum = $(".waitSel:checked",group).length;
			if(isFree?(selNum>maxDeptNum):(selNum>deptNum)){
				rotationDept.checked = false;
				return jboxTip("该组合不能选择更多科室！");
			}
			
		}
		
		var selNum = $(".waitSel:checked",group).length;
		if(isFree?(selNum>=deptNum && selNum<=maxDeptNum):(deptNum==selNum)){
			group.addClass("isFinish");
		}else{
			group.removeClass("isFinish");
		}
	}
	
	//完成选科加载排班
	function finishSelAndLoadRostering(){
		if(!($(".isFinish").length == $(".groupHome").length)){
			return jboxTip("请先完成选科！");
		}
		var data = "";
		$(".waitSel:checked").each(function(){
			data+=("&selDepts="+this.value);
		});
		jboxPost("<s:url value='/sch/template/simulateResult'/>",data+"&rotationFlow=${rotation.rotationFlow}",function(resp){
			$("#rosteringHome").html(resp);
			$("#selArea").hide();
			$("#rosteringOper").show();
		},null,false);
	}
	
	//自动排班
	function autoRostering(){
		var startDate = $("#startDate").val();
		if(!startDate){
			return jboxTip("请选择开始日期！");
		}
		var data="";
		$(".simulateResult").each(function(){
			var deptData = $(this).data("rotationDeptData");
			data+=("&steps="+deptData.schMonth);
		});
		jboxPost("<s:url value='/res/doc/getAutoCountResult'/>",data+"&startDate="+startDate,function(result){
			if(result){
				for(var index in result){
					$(".start:eq("+index+")").val(result[index].start);
					$(".end:eq("+index+")").val(result[index].end);
				}
			}else{
				jboxTip("${GlobalConstant.OPRE_FAIL}");
			}
		},null,false);
	}
	
	//清空排班
	function clearCount(){
		$(".start,.end").val("");
	}
</script>
</head>
<c:set value="schUnitEnum${sysCfgMap['res_rotation_unit']}" var="unitKey"/>
<body>
	<input type="hidden" id="groupId" value="${param.groupId}"/>
	<table class="basic" style="margin-left: 10px;width: 100%;">
		<tr>
			<td style="text-align: left;padding-left: 10px;">
				<div style="height: 30px;">
					<div style="height: 100%;vertical-align: top;float: left;margin-right: 10px;width: 100%;">
						方案名称：
						<font style="font-weight: bold;">${rotation.rotationName}</font>
						<span id="rosteringOper" style="display: none;">
							<input type="button" value="清空排班" class="search" style="float: right;margin-right: 10px;margin-top: 4px;" onclick="clearCount();">
							<input type="button" value="自动排班" class="search" style="float: right;margin-right: 10px;margin-top: 4px;" onclick="autoRostering();">
							<input type="text" style="float: right;margin-right: 10px;margin-top: 7px;cursor: pointer;width: 100px;" id="startDate" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});">
							<font style="float: right;margin-right: 10px;">开始时间：</font>
						</span>
					</div>
				</div>
				<div>
					<div style="height: 100%;vertical-align: top;float: left;margin-right: 10px;">
						组&#12288;员：
					</div>
					<div style="float: left;width: 92%;">
						<c:forEach items="${doctorList}" var="doctor" varStatus="docsStatus">
							<div style="float: left;">
								<font <c:if test="${isUseMap[doctor.doctorFlow]}">color="red" hasSelOrResult="${doctor.doctorFlow}"</c:if>>${doctor.doctorName}</font>
								<c:if test="${!docsStatus.last}">
									，&nbsp;
								</c:if>
							</div>
						</c:forEach>
					</div>
				</div>
			</td>
		</tr>
	</table>
	
	<c:if test="${empty isUseMap}">
		<div id="selArea">
			<table class="basic" style="width: 100%;margin-top: 10px;margin-left: 10px;">
				<tr>
					<td style="text-align: left;padding-left: 10px;">
						<table>
							<tr>
								<td style="border: none;width: 80px;vertical-align: top;padding: 0;">选科情况：</td>
								<td style="border: none;text-align: left;padding: 0;">
									<c:forEach items="${groupList}" var="group">
										<div id="${group.groupFlow}" class="groupHome" deptNum="${group.deptNum+0}" selTypeId="${group.selTypeId}" maxDeptNum="${group.maxDeptNum+0}">
											[
											<font title="轮转时间：${group.schMonth}" style="font-weight: bold;cursor: pointer;">${group.groupName}</font>
											(<font title="选科数" style="cursor: pointer;">${group.deptNum}<c:if test="${schSelTypeEnumFree.id eq group.selTypeId}">~${group.maxDeptNum}</c:if></font>)：
											<c:forEach items="${rotationDeptListMap[group.groupFlow]}" var="rotationDept" varStatus="status">
												<font title="标准科室：${rotationDept.standardDeptName}<br>轮转时间：${rotationDept.schMonth}${applicationScope[unitKey].name}" style="margin-right: 5px;">
													<label style="cursor: pointer;">
													<input style="cursor: pointer;" type="checkbox" onchange="selDept('${group.groupFlow}',this);" class="waitSel" value="${rotationDept.recordFlow}">
														${rotationDept.schDeptName}
													</label>
												</font>
											</c:forEach>
											]
										</div>
									</c:forEach>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<div style="text-align: center;margin-top: 10px;margin-bottom: 20px;">
				<input type="button" value="完成选科" class="search" onclick="finishSelAndLoadRostering();"/>
			</div>
		</div>
		
		<div id="rosteringHome"></div>
	</c:if>
</body>
</html>