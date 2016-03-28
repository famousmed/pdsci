<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
</jsp:include>
<style type="text/css">
/* table.basic th,table.basic td{text-align: center;padding: 0;} */
/* .groupHome{float: left;height: 16px;line-height: 15px;padding-bottom: -5px;border-bottom: 1px solid rgba(255,255,255,0);margin: 5px 5px 5px;} */
/* .groupHome:HOVER{border-bottom: 1px solid black;} */
.wDept{color:#3d91d5;}
.sDept{color:red;}
</style>
<c:set value="schUnitEnum${sysCfgMap['res_rotation_unit']}" var="unitKey"/>
<script type="text/javascript">
	$(function(){
		$(".isRostering :checkbox").attr("disabled",true);
		<c:forEach items="${doctorList}" var="doctor">
			<c:if test="${rotationMap[doctor.rotationFlow].isStage eq GlobalConstant.FLAG_Y}">
				<c:forEach items="${schStageEnumList}" var="stage">
					$("#${doctor.doctorFlow}${stage.id}").append($(".${doctor.doctorFlow}${stage.id}"));
				</c:forEach>
			</c:if>
		</c:forEach>
		
		defaultSel();
	});
	
	function search(){
		$("#doctorSearchForm").submit();
	}
	
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
					
					//判断轮转时间和
		 			var monthCount = 0;
		 			var noEmpty = true;
		 			var schMonth = parseFloat($(this).attr("schMonth"));
		 			$(".selChoose .selDiyMonth",this).each(function(){
		 				var sm = parseFloat(this.value) || 0;
						if(sm){
							monthCount+=sm;
						}else{
							return noEmpty = false;
						}
		 			});
		 			if(!(isOk = (!noEmpty || schMonth==monthCount))){
		 				return isOk;
		 			}
					
				});
				if(isOk){
					$("#"+doctorFlow+"RedTitle").removeAttr("color");
				}else{
					$("#"+doctorFlow+"RedTitle").attr("color","red");
				}
				
				$("#selDeptStatus"+doctorFlow).text(isOk?"已完成":"未完成");
				
				var currFlag = isOk?"${GlobalConstant.FLAG_Y}":"${GlobalConstant.FLAG_N}";
				var recordFlag = $("#"+doctorFlow).attr("selDeptFlag");
				if(currFlag!=recordFlag){
					jboxPost("<s:url value='/res/doc/confirmRosting'/>",{doctorFlow:doctorFlow,selDeptFlag:currFlag},function(resp){
						if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
							$("#"+doctorFlow).attr("selDeptFlag",currFlag);
						}
					},null,false);
				}
			}
		},null,false);
	}
	
	function enterSelInfo(doctorFlow){
		var content = "";
		if($("#"+doctorFlow+"Info").is(":hidden")){
			$("#"+doctorFlow+" .groupHome").each(function(){
				//判断轮转时间和
	 			var monthCount = 0;
	 			var noEmpty = true;
				var groupName = $(".groupName",this).text();
				var schMonth = parseFloat($(this).attr("schMonth"));
	 			$(".selChoose .selDiyMonth",this).each(function(){
	 				var sm = parseFloat(this.value) || 0;
	 				if(sm){
	 					monthCount+=sm;
	 				}else{
	 					return noEmpty = false;
	 				}
	 			});
	 			if(noEmpty && schMonth!=monthCount){
	 				content+=("<div>&#12288;<font color='blue'>"+groupName+"</font>组合要求<font color='red'>"+schMonth+"</font>${applicationScope[unitKey].name}，当前选择总时间为<font color='red'>"+monthCount+"</font>${applicationScope[unitKey].name}！</div>");
	 			}
			});
		}
		
		$("#"+doctorFlow+"Info").html(content).toggle(($("#"+doctorFlow+"Info").is(":hidden") && !!content));
	}
	
	function leaveSelInfo(doctorFlow){
		$("#"+doctorFlow+"Info").hide();
	}
	
	function moveInfo(doctorFlow){
		var x = window.event.pageX;
		var y = window.event.pageY;
		$("#"+doctorFlow+"InfoHome").css({
			"top":y+"px",
			"left":x+"px"
		});
	}
	
	//选中一个科室
	function selItem(rotationDept){
		var checkStatus = rotationDept.checked;
		rotationDept.checked = !checkStatus;
		$(rotationDept).change();
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
	
	//时间控制不小于0.5
	function checkTime(time){
		return $.trim(time) && !isNaN(time) && parseFloat(time)>=0.5;
	}
	
	//收缩展开
	function operContent(id){
		var contentId = "#oper"+id+"Content";
		var btn = ".btn"+id;
		$(btn+","+contentId).toggle();
	}
	
	//默认选中第一个人员类型
	function defaultSel(){
		if("${empty doctor.doctorCategoryId}"=="true"){
			var doccatory = $("[name='doctorCategoryId'] option");
			if(doccatory.length>1){
				var secondOption = $(doccatory.get(1));
				secondOption.attr("selected",true);
				$("[name='doctorCategoryId']").change();
			}
			
		}
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<form action="<s:url value='/sch/doc/seldept'/>" id="doctorSearchForm" method="post">
			<table class="basic" style="width:100%;margin-top: 10px;">
			<tr><td>
				人员类型：
				<select name="doctorCategoryId" style="width: 100px;" onchange="search();">
					<option/>
					<c:forEach items="${recDocCategoryEnumList}" var="category">
						<c:set var="res_doctor_category_key" value="res_doctor_category_${category.id }"/>
						<c:if test="${sysCfgMap[res_doctor_category_key]==GlobalConstant.FLAG_Y}">
						<option value="${category.id}" ${doctor.doctorCategoryId eq category.id?'selected':''}>${category.name}</option>
						</c:if>
					</c:forEach>
				</select>
				&#12288;
				届数：
				<select name="sessionNumber" style="width: 100px" onchange="search();">
					<option></option>
					<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
						<option value="${dict.dictName}" ${dict.dictName eq doctor.sessionNumber?'selected':''}>${dict.dictName}</option>
					</c:forEach>
				</select>
				&#12288;
				培训专业：
				<select name="trainingSpeId" style="width: 100px" onchange="search();">
					<option></option>
					<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
						<option value="${dict.dictId}" ${doctor.trainingSpeId eq dict.dictId?'selected':''}>${dict.dictName}</option>
					</c:forEach>
				</select>
				&#12288;
				医师姓名：
				<input name="doctorName" type="text" value="${doctor.doctorName}" style="width: 100px;" onchange="search();"/>
				&#12288;
				<label>
					<input type="checkbox" value="${GlobalConstant.FLAG_Y}" name="selDeptFlag" <c:if test="${doctor.selDeptFlag eq GlobalConstant.FLAG_Y}">checked</c:if> onchange="search();"/>
					只看未完成
				</label>
				</td></tr>
			</table>
<!-- 			<div style="margin-top: 5px">Tip:&#12288;<font color="red">红色</font>为未完成选科医师</div> -->
		</form>
		<div>
			<c:forEach items="${doctorList}" var="doctor">
				<table class="basic" style="width:100%;margin-top: 10px;">
					<tr>
						<th style="text-align: left;padding-left: 10px;">
							<span style="display: inline-block;width: 10%;">姓名：${doctor.doctorName}</span>
							<span style="display: inline-block;width: 10%;">届数：${doctor.sessionNumber}</span>
							<span style="display: inline-block;width: 15%;">选科状态：<font id="selDeptStatus${doctor.doctorFlow}">${doctor.selDeptFlag eq GlobalConstant.FLAG_Y ? '已完成':'未完成'}</font></span>
							<span style="display: inline-block;width: 40%;">轮转方案：<a onclick="openDetail('${doctor.rotationName}','${doctor.rotationFlow}');" style="cursor: pointer;color: blue;">${doctor.rotationName}</a></span>
							<span style="display: inline-block;width: 20%;text-align: right;">
								<a class="btn${doctor.doctorFlow}" style="cursor: pointer;color: blue;" onclick="operContent('${doctor.doctorFlow}');">收起</a>
								<a class="btn${doctor.doctorFlow}" style="cursor: pointer;color: blue;display: none;" onclick="operContent('${doctor.doctorFlow}');">展开</a>
							</span>
						</th>
					</tr>
					<tr id="oper${doctor.doctorFlow}Content">
						<td>
							<table style="width: 95%;">
								<tr>
									<td style="border: none;width: 80px;vertical-align: top;padding: 0;cursor:pointer;" onmouseover="enterSelInfo('${doctor.doctorFlow}');" onmouseout="enterSelInfo('${doctor.doctorFlow}');" onmousemove="moveInfo('${doctor.doctorFlow}');">
										<font id="${doctor.doctorFlow}RedTitle" <c:if test="${!(doctor.selDeptFlag eq GlobalConstant.FLAG_Y)}">color="red"</c:if>>选科情况：</font>
										<div style="height: 0px;overflow: visible;width: 0px;position: absolute;" id="${doctor.doctorFlow}InfoHome">
											<div style="border: 1px #ccc solid;display: none;background: white;position: relative;width: 250px;" id="${doctor.doctorFlow}Info"></div>
										</div>
									</td>
									<td id="${doctor.doctorFlow}" selDeptFlag="${doctor.selDeptFlag}" style="border: none;text-align: left;padding: 0;">
										<c:forEach items="${schStageEnumList}" var="stage">
											<div id="${doctor.doctorFlow}${stage.id}">
											</div>
										</c:forEach>
										
										<c:forEach items="${groupListMap[doctor.rotationFlow]}" var="group">
											<fieldset class="${doctor.doctorFlow}${group.schStageId} groupHome ${doctor.doctorFlow}${group.groupFlow} <c:if test="${!empty resultMap[doctor.doctorFlow]}"> isRostering</c:if>" deptNum="${group.deptNum}" selTypeId="${group.selTypeId}" maxDeptNum="${group.maxDeptNum}" schMonth="${group.schMonth+0}">
												<legend>
													<c:if test="${rotationMap[doctor.rotationFlow].isStage eq GlobalConstant.FLAG_Y}">
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
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</c:forEach>
			<c:if test="${empty doctorList}">
				<table class="basic" style="width:100%;margin-top: 10px;">
				<tr><td style="text-align: center;">无记录</td></tr>
				</table>
			</c:if>
		</div>
	</div>
</div>
</body>
</html>