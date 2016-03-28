<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<style type="text/css">
table.basic th,table.basic td{text-align: center;padding: 0;}
</style>
<script type="text/javascript">
// 	$(function(){
// 		$(".isRostering :checkbox").attr("disabled",true);
// 	});
	
	//轮转方案说明
	function openDetail(rotationName,rotationFlow){
		var url = "<s:url value='/sch/template/editRotation'/>?roleFlag=${param.roleFlag}&viewFlag=${GlobalConstant.FLAG_Y}&rotationFlow="+rotationFlow;
		jboxOpen(url, rotationName, 800, 500);
	}
	
	//科室选择或取消
	function deptSelOrCancel(currDept,doctorFlow,rotationDeptFlow,groupFlow){
		var $rotationDept = $(currDept).closest(".rotationChoose").toggleClass("selChoose",currDept.checked);
		if(currDept.checked){
			var $groupHome = $("."+doctorFlow+groupFlow);
			var isFree = "${schSelTypeEnumFree.id}"==$groupHome.attr("selTypeId");
			var deptNum = parseInt($groupHome.attr("deptNum"));
			if(isFree){
				deptNum = parseInt($groupHome.attr("maxDeptNum"));
			}
			if($groupHome.find(":checked").length > deptNum){
				currDept.checked = false;
				$(currDept).closest(".rotationChoose").toggleClass("selChoose",currDept.checked);
				return jboxTip("该组合不能选择更多科室！");
			}
		}
		
		
		var data = {};
		data.doctorFlow = doctorFlow;
		data.doctorDeptFlow = currDept.id;
		data.rotationDeptFlow = rotationDeptFlow;
		data.recordStatus = currDept.checked?"${GlobalConstant.RECORD_STATUS_Y}":"${GlobalConstant.RECORD_STATUS_N}";
		data.schMonth = $(".selDiyMonth",$rotationDept).val() || "";
		jboxPost("<s:url value='/sch/template/operSelDept'/>",data,function(resp){
			if(resp){
				currDept.id = resp;
				
				var isOk = false;
				$("#"+doctorFlow+" .groupHome").each(function(){
					var deptNum = parseInt($(this).attr("deptNum"));
					var checkNum = $(":checked",this).length;
					if("${schSelTypeEnumFree.id}" == $(this).attr("selTypeId")){
						var maxDeptNum = parseInt($(this).attr("maxDeptNum"));
						if(!(isOk = (deptNum<=checkNum && maxDeptNum>=checkNum)))
							return isOk;
					}else{
						if(!(isOk = (deptNum==checkNum))) 
							return isOk;
					}
				});
				$("#selDeptStatus"+doctorFlow).text(isOk?"已完成":"未完成");
				
				var currFlag = isOk?"${GlobalConstant.FLAG_Y}":"${GlobalConstant.FLAG_N}";
				var recordFlag = $("#"+doctorFlow).attr("selDeptFlag");
				if(currFlag!=recordFlag){
					jboxPost("<s:url value='/res/doc/confirmRosting'/>",{doctorFlow:doctorFlow,selDeptFlag:currFlag},function(resp){
						if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
							$("#"+doctorFlow).attr("selDeptFlag",currFlag);
// 							if("${GlobalConstant.FLAG_Y}"==currFlag){
// 								$("#startRostingHand").show();
// 								$("#"+doctorFlow+"WaitSel").hide();
// 							}else{
// 								$("#startRostingHand").hide();
// 								$("#"+doctorFlow+"WaitSel").show();
// 							}
							$("#startRostingHand").attr("disabled",!("${GlobalConstant.FLAG_Y}"==currFlag));
							$("#"+doctorFlow+"WaitSel").toggle(!("${GlobalConstant.FLAG_Y}"==currFlag));
							$("#startRostingHand").toggleClass("close",!("${GlobalConstant.FLAG_Y}"==currFlag));
							$("#startRostingHand").toggleClass("search","${GlobalConstant.FLAG_Y}"==currFlag);
						}
					},null,false);
				}
			}
		},null,false);
	}

	function selDeptSumCheck(){
		//判断轮转时间和
		var haveEmpty = true;
		$(".groupHome").each(function(){
			var monthCount = 0;
			var noEmpty = true;
			var schMonth = parseFloat($(this).attr("schMonth")) || 0;
			var title = $(".groupName",this).text();
			$(".selChoose .selDiyMonth",this).each(function(){
				var sm = parseFloat(this.value) || 0;
				if(sm){
					monthCount+=sm;
				}else{
					return noEmpty = false;
				}
			});
			
			if(!noEmpty){
				jboxInfo("请为<font color='blue'>"+title+"</font>组合内选择的科室完整填写轮转时间！");
				return haveEmpty = false;
			}
			if(schMonth!=monthCount){
				jboxInfo("<font color='blue'>"+title+"</font>要求轮转时间为：<font color='red'>"+schMonth+"</font>,已选总时间为：<font color='red'>"+monthCount+"</font>");
				return haveEmpty = false;
			}
		});
		return haveEmpty;
	}
	
	//开始排班,创建排班数据
	function startResult(doctorFlow){
		if(!selDeptSumCheck()){return false;};
		
		jboxConfirm("开始后该医师的选科将不能修改！确认开始？",function(){
			jboxPost("<s:url value='/sch/doc/createResults'/>?doctorFlow="+doctorFlow,null,function(resp){
				if(resp == "${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
					jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					selDoc($(".selDoc")[0],doctorFlow);
				}
			},null,false);
		},null);
	}
	
	//选中一个科室
	function selItem(rotationDept){
		var checkStatus = rotationDept.checked;
		rotationDept.checked = !checkStatus;
		$(rotationDept).change();
	}
	
	//还原时间
	function resetTime(groupHome){
		$("."+groupHome+" .selDiyMonth").each(function(){
			this.value = $(this).attr("schMonth");
		});
	}
	
	//时间控制不小于0.5
	function checkTime(time){
		return $.trim(time) && !isNaN(time) && parseFloat(time)>=0.5;
	}
	
	//保存时间
	function saveDiySelTime(schMonth){
		if(!checkTime(schMonth.value)){
			return jboxTip("请输入数字且大于0.5！");
		}
		var checkBox = $(":checkbox",$(schMonth).closest(".rotationChoose"))[0];
		if(checkBox.checked){
			$(checkBox).change();
		}
	}
	
	$(function(){
	<c:forEach items="${schStageEnumList}" var="stage">
		$("#${stage.id}").append($(".ord${stage.id}"));
	</c:forEach>
	});
</script>
</head>
<c:set value="schUnitEnum${sysCfgMap['res_rotation_unit']}" var="unitKey"/>
<body>
	<table class="basic" style="margin-left: 10px;width: 98%;">
		<tr>
			<td style="text-align: left;padding-left: 10px;">
			医师姓名：${doctor.doctorName}
			&#12288;
			轮转方案：<a style="color: blue;cursor: pointer;" onclick="openDetail('${rotation.rotationName}','${rotation.rotationFlow}');">${rotation.rotationName}</a>
			&#12288;
			轮转年限：<c:out value="${rotation.rotationYear}" default="无"/>
			&#12288;
			Tip：完成选科后方可开始排班！
			<c:if test="${empty resultList}">
				<input id="startRostingHand" type="button" value="开始排班" class="<c:if test="${!(GlobalConstant.FLAG_Y eq doctor.selDeptFlag)}">close</c:if><c:if test="${GlobalConstant.FLAG_Y eq doctor.selDeptFlag}">search</c:if>" style="float: right;margin-right: 10px;margin-top: 4px;" onclick="startResult('${doctor.doctorFlow}');" <c:if test="${!(GlobalConstant.FLAG_Y eq doctor.selDeptFlag)}">disabled="disabled"</c:if>>
			</c:if>
			</td>
		</tr>
	</table>
	<table class="basic" style="width: 98%;margin-top: 10px;margin-left: 10px;">
		<tr>
			<td>
				<div id="${doctor.doctorFlow}" selDeptFlag="${doctor.selDeptFlag}" style="text-align: left;">
					<c:forEach items="${schStageEnumList}" var="stage">
						<div id="${stage.id}">
						</div>
					</c:forEach>
				
					<c:forEach items="${groupListMap[doctor.rotationFlow]}" var="group">
						<fieldset class="ord${group.schStageId} groupHome ${doctor.doctorFlow}${group.groupFlow} <c:if test="${!empty resultMap[doctor.doctorFlow]}"> isRostering</c:if>" deptNum="${group.deptNum}" selTypeId="${group.selTypeId}" maxDeptNum="${group.maxDeptNum}" schMonth="${group.schMonth+0}">
							<legend>
								<c:if test="${rotation.isStage eq GlobalConstant.FLAG_Y}">
									${group.schStageName}：
								</c:if>
								<span class="groupName">${group.groupName}</span>
							</legend>
							<c:forEach items="${rotationDeptListMap[group.groupFlow]}" var="rotationDept" varStatus="status">
								<c:set value="${doctor.doctorFlow}${group.groupFlow}${rotationDept.standardDeptId}${rotationDept.schDeptFlow}" var="key"/>
								
								<div class="wDept rotationChoose <c:if test="${!empty doctorDeptMap[key]}">selChoose</c:if>" style="margin-right: 5px;" onclick="selItem($(':checkbox',this)[0]);">
									<div class="chooseStandard">
									    标准科室：${rotationDept.standardDeptName}
									</div>
									<div class="chooseName">
										${rotationDept.schDeptName}
									</div>
									<div class="chooseMonth" onclick="window.event.stopPropagation();$('.selDiyMonth',this).focus();">
										<input type="text" value="${empty doctorDeptMap[key]?rotationDept.schMonth:doctorDeptMap[key].schMonth}" class="inputText selDiyMonth" schMonth="${rotationDept.schMonth}" style="width: 20px;" onchange="saveDiySelTime(this);"/>
										${applicationScope[unitKey].name}
									</div>
									<input style="display: none;" id="${doctorDeptMap[key].recordFlow}" type="checkbox" <c:if test="${!empty doctorDeptMap[key]}">checked</c:if> onchange="deptSelOrCancel(this,'${doctor.doctorFlow}','${rotationDept.recordFlow}','${group.groupFlow}');" schMonth="${rotationDept.schMonth+0}">
								</div>
								
							</c:forEach>
							<div style="width: 97%;float: left;border: 1px solid #ccc;margin-top: 10px;">
								<p style="padding-left: 10px;">
									<span style="font-weight: bold;">选科条件：</span>
									轮转时间：${group.schMonth}${applicationScope[unitKey].name}
									&#12288;
									选科数：${group.deptNum}<c:if test="${schSelTypeEnumFree.id eq group.selTypeId}">~${group.maxDeptNum}</c:if>
								</p>
							</div>
							<div style="width: 97%;float: left;border: 1px solid #ccc;margin-top: 10px;">
								<p style="padding-left: 10px;">
									<span style="font-weight: bold;">备注：</span>
									${group.groupNote}
									
									<a style="color: blue;cursor: pointer;float: right;margin-right: 10px;" onclick="resetTime('${doctor.doctorFlow}${group.groupFlow}');">还原时间</a>
								</p>
							</div>
						</fieldset>
					</c:forEach>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>