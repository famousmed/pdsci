<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
	$(document).ready(function(){
		$(".selTypeId:checked").change();
		$(".data").hide();
		var selDepts = $(".box:checked");
		selDepts.each(function(){
			dataView(this.value);
		});
		groupInfoView();
		$(".treeMain,.sTreeMain").each(function(){
			if($("[class^='tree'] :checked",this).length){
				$("[class^='op']:first",this).click();
			}
		});
// 		$(".sTreeMain").each(function(){
// 			if($("[class^='tree'] :checked",this).length){
// 				$("[class^='op']:first",this).click();
// 			}
// 		});
	});
	
	function selDeptRequired(){
		$("#deptNum,#maxDeptNum").attr("class","validate[required,custom[number,max["+$(".box:checked").length+"],min[1]]]");
	}
	
	function groupInfoView(){
		var isRequired = $("[name='isRequired']:checked").val()=='${GlobalConstant.FLAG_Y}';
		$(".groupInfo").toggle(!isRequired);
		$(".schReq").toggle(isRequired);
		if(isRequired){
			$("[id^='schMonth']").addClass("validate[required,custom[number],max[99],min[0.5]]");
			$("[id^='schMonth']").removeClass("validate[custom[number],max[99],min[0.5]]");
		}else{
			$("[id^='schMonth']").addClass("validate[custom[number],max[99],min[0.5]]");
			$("[id^='schMonth']").removeClass("validate[required,custom[number],max[99],min[0.5]]");
		}
	}
	
	function dataView(deptFlow){
		selDeptRequired();
		var reg = /\./g;
		deptFlow = deptFlow.replace(reg,"\\.");
		$(".data."+deptFlow).toggle();
	}
	
	function parse(year){
		var integer = parseInt(year);
		return isNaN(integer)?0:integer;
	}
	
	function saveRotationDept(){
		var isRequired = $("[name='isRequired']:checked").val();
		
		if($(".box:checked").length==0){
			jboxTip("必须选择一个科室!");
			return;
		}
		
		if(isRequired=="${GlobalConstant.FLAG_Y}"){
// 			$("#schMonth").val("");
			$("#deptNum").val("");
			$("#maxDeptNum").val("");
			$(".selTypeId:checked").attr("checked",false);
			var schMonthG = 0;
			$(".data [id^=schMonth]").each(function(){
				var val = this.value;
				if($.trim(val)!="" && !isNaN(val)){
					schMonthG+=(parseFloat(val));
				}
			});
			$("#schMonth").val(schMonthG);
		}else{
			if($(".selTypeId:checked").val()=="${schSelTypeEnumFree.id}"){
				if($("#deptNum").val()>$("#maxDeptNum").val()){
					return jboxTip("选科数有误,前者应小于或等于后者！");
				}
			}
		}
		
		if(!$("#schRotationDept").validationEngine("validate")){
			return ;
		} 
		var url = "<s:url value='/sch/template/saveRotationDept'/>?roleFlag=${param.roleFlag}&rotationFlow=${param.rotationFlow}";
		var selDepts = $(".box:checked");
		var rotationDepts = [];
		var ordinalIndex = 0;
		
		selDepts.each(function(){
			value = this.value;
			var reg = /\./g;
			var regValue = value.replace(reg,"\\.");
			var obj = {
					"recordFlow":$("#recordFlow"+regValue).val(),
					"schDeptFlow":value,
					"schDeptName":$("#schDeptName"+regValue).val(),
					'rotationFlow':'${param.rotationFlow}',
					"schMonth":$("#schMonth"+regValue).val(),
					"isRequired":isRequired,
					"deptNote":$("#deptNote"+regValue).val(),
					"ordinal":ordinalIndex++
					};
			rotationDepts.push(obj);
		});
		var requestData= {
				"rotationDeptList":rotationDepts,
				"rotationGroup":{
					"groupFlow":$("#groupFlow").val(),
					"rotationFlow":"${param.rotationFlow}",
					"groupName":$("#groupName").val(),
					"groupNote":$("#groupNote").val(),
					"schMonth":$("#schMonth").val() || "",
					"deptNum":$("#deptNum").val() || "",
					"maxDeptNum":$("#maxDeptNum").val() || "",
					"selTypeId":$(".selTypeId:checked").val() || "",
					"selTypeName":$.trim($(".selTypeId:checked").closest("label").text()),
					"isRequired":isRequired,
					"ordinal":$("#ordinal").val(),
					<c:if test="${rotation.isStage eq GlobalConstant.FLAG_Y}">
					"schStageId":$("[name='schStageId']:checked").val()
					</c:if>
				}
			};
		jboxPostJson(url,JSON.stringify(requestData),function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				window.parent.frames["mainIframe"].window.refresh('${param.rotationFlow}');
				jboxClose();
			}
		},null,true);
	}
	
	//切换树
	function treeFunc(id){
		var reg = /\./g;
		id = id.replace(reg,"\\.");
		$(".tree"+id).toggle();
		$(".op"+id).toggle();
	}
	
	//检查小数位
	function valueCheck(put){
		if(put.value%0.5>0){
			put.value = "";
			return jboxTip("小数位必须为0.5！");
		}
	}
</script>
</head>
<body>
	<div class="main_fix" style="overflow: hidden;margin-top: -45px">
		<div class="" id="main">
		<form id="schRotationDept" style="position: relative;">
			<input type="hidden" id="groupFlow" value="${rotationGroup.groupFlow}"/>
			<div style="width: 30%;float: left;overflow: auto;height: 500px;" class="side">
				<table class="basic" style="width: 100%">
					<tr>
						<th style="text-align: left;">&#12288;轮转科室</th>
					</tr>
					<tr>
						<td valign="top">
							<div style="overflow: auto;">
								<c:forEach items="${dictTypeEnumStandardDeptList}" var="dict">
									<c:set var="dictKey" value="dictTypeEnumStandardDept.${dict.dictId}List"/>
									
									<ul class="treeMain">
										<li>
											<c:set var="showOp" value="${applicationScope[dictKey].size()>0}" />
											<img class="op${dict.dictId}" onclick="treeFunc('${dict.dictId}');" src="<s:url value='/css/skin/${skinPath}/images/zTreeStandard_03.png'/>" style="cursor: pointer;<c:if test="${!showOp}">visibility: hidden;</c:if>"/>
											<img class="op${dict.dictId}" onclick="treeFunc('${dict.dictId}');" src="<s:url value='/css/skin/${skinPath}/images/zTreeStandard_05.png'/>" style="cursor: pointer;display: none;<c:if test="${!showOp}">visibility: hidden;</c:if>"/>
											
											<label>
												<input onclick="dataView(this.value);" type="checkbox" class="box ${dict.dictId}" value="${dict.dictId}" ${!empty rotationDeptMap[dict.dictId]?'checked':''} />
												${dict.dictName}
											</label>
											<input type="hidden" id="schDeptName${dict.dictId}" value="${dict.dictName}"/>
										</li>
										
										<li>
										<ul class="sTreeMain">
											<c:forEach items="${applicationScope[dictKey]}" var="sDict">
												<c:set var="sDictId" value="${dict.dictId}.${sDict.dictId}"/>
												<c:set var="sDictName" value="${dict.dictName}.${sDict.dictName}"/>
												
												<c:set var="dictKey" value="dictTypeEnumStandardDept.${sDictId}List"/>
												
												<li class="tree${dict.dictId}" style="display: none;margin-left: 30px;">
													<c:set var="showOp" value="${applicationScope[dictKey].size()>0}" />
													<img class="op${sDictId}" onclick="treeFunc('${sDictId}');" src="<s:url value='/css/skin/${skinPath}/images/zTreeStandard_03.png'/>" style="cursor: pointer;<c:if test="${!showOp}">visibility: hidden;</c:if>"/>
													<img class="op${sDictId}" onclick="treeFunc('${sDictId}');" src="<s:url value='/css/skin/${skinPath}/images/zTreeStandard_05.png'/>" style="cursor: pointer;display: none;<c:if test="${!showOp}">visibility: hidden;</c:if>"/>
													
													<label>
														<input onclick="dataView(this.value);" type="checkbox" class="box ${sDictId}" value="${sDictId}" ${!empty rotationDeptMap[sDictId]?'checked':''} />
														${sDict.dictName}
													</label>
													<input type="hidden" id="schDeptName${sDictId}" value="${sDictName}"/>
												</li>
												
												<c:forEach items="${applicationScope[dictKey]}" var="tDict">
													<c:set var="tDictId" value="${dict.dictId}.${sDict.dictId}.${tDict.dictId}"/>
													<c:set var="tDictName" value="${dict.dictName}.${sDict.dictName}.${tDict.dictName}"/>
													
													<li class="tree${sDictId}" style="display: none;margin-left: 60px;">
														<label>
															<input onclick="dataView(this.value);" type="checkbox" class="box ${tDictId}" value="${tDictId}" ${!empty rotationDeptMap[tDictId]?'checked':''} />
															${tDict.dictName}
														</label>
														<input type="hidden" id="schDeptName${tDictId}" value="${tDictName}"/>
													</li>
												</c:forEach>
											</c:forEach>
										</ul>
										</li>
									</ul>
								</c:forEach>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div id="dept" style="width:65%;margin-bottom: 10px;float: left;overflow: auto;height: 500px;" class="side">
				<table width="100%" class="basic" style="font-size: 14px">
						<tr>
							<th style="text-align: left;width: 100px;" colspan="3">&#12288;轮转科室配置</th>
						</tr>
						<c:if test="${rotation.isStage eq GlobalConstant.FLAG_Y}">
						<tr>
							<td style="text-align: right;width: 20%"><font color="red" >*</font>轮转阶段：</td>
							<td colspan="2">
								<c:forEach items="${schStageEnumList}" var="stage">
									<label>
										<input type="radio" name="schStageId" value="${stage.id}" <c:if test="${rotationGroup.schStageId eq stage.id}">checked</c:if> class="validate[required]"/>
										${stage.name}
									</label>
									&#12288;
								</c:forEach>
							</td>
						</tr>
						</c:if>
						<tr>
							<td style="text-align: right;width: 20%">是否必轮：</td>
							<td colspan="2">
								<input type="radio" value="${GlobalConstant.FLAG_Y}" name="isRequired" id="yes" onclick="groupInfoView();" <c:if test="${(rotationGroup.isRequired eq GlobalConstant.FLAG_Y) || empty rotationGroup}">checked</c:if>><label for="yes">是</label>
								&#12288;
								<input type="radio" value="${GlobalConstant.FLAG_N}" name="isRequired" id="no" onclick="groupInfoView();" <c:if test="${rotationGroup.isRequired eq GlobalConstant.FLAG_N}">checked</c:if>><label for="no">否</label>
							</td>
						</tr>
						
						<tr>
							<th style="text-align: center;padding: 0;">科室名称</th>
							<th style="text-align: center; width: 150px;padding: 0;">轮转时间</th>
							<th style="text-align: center;padding: 0;">备注</th>
						</tr>
							
						<c:forEach items="${dictTypeEnumStandardDeptList}" var="dict">
							<input type="hidden" id="recordFlow${dict.dictId}" value="${rotationDeptMap[dict.dictId].recordFlow}"/>
							<tr class="data ${dict.dictId}">
								<td style="text-align: center;width: 150px;">${dict.dictName}</td>
								<td style="text-align: center">
									<input type="text" value="${rotationDeptMap[dict.dictId].schMonth}" id="schMonth${dict.dictId}" style="width: 25px;text-align: center;" onchange="valueCheck(this);"/>
									<font color="red" class="schReq">*</font>
								</td>
								<td>
									<input type="text" value="${rotationDeptMap[dict.dictId].deptNote}" style="width: 90%" id="deptNote${dict.dictId}"/>
								</td>
							</tr>
							
							<c:set var="dictKey" value="dictTypeEnumStandardDept.${dict.dictId}List"/>
							<c:forEach items="${applicationScope[dictKey]}" var="sDict">
								<c:set var="sDictId" value="${dict.dictId}.${sDict.dictId}"/>
								<c:set var="sDictName" value="${dict.dictName}.${sDict.dictName}"/>
								
								<input type="hidden" id="recordFlow${sDictId}" value="${rotationDeptMap[sDictId].recordFlow}"/>
								<tr class="data ${sDictId}">
									<td style="text-align: center;width: 150px;">${sDict.dictName}</td>
									<td style="text-align: center">
										<input type="text" value="${rotationDeptMap[sDictId].schMonth}" id="schMonth${sDictId}" style="width: 25px;text-align: center;" onchange="valueCheck(this);"/>
										<font color="red" class="schReq">*</font>
									</td>
									<td>
										<input type="text" value="${rotationDeptMap[sDictId].deptNote}" style="width: 90%" id="deptNote${sDictId}"/>
									</td>
								</tr>
								
								<c:set var="dictKey" value="dictTypeEnumStandardDept.${sDictId}List"/>
								<c:forEach items="${applicationScope[dictKey]}" var="tDict">
									<c:set var="tDictId" value="${dict.dictId}.${sDict.dictId}.${tDict.dictId}"/>
									<c:set var="tDictName" value="${dict.dictName}.${sDict.dictName}.${tDict.dictName}"/>
									
									<input type="hidden" id="recordFlow${tDictId}" value="${rotationDeptMap[tDictId].recordFlow}"/>
									<tr class="data ${tDictId}">
										<td style="text-align: center;width: 150px;">${tDict.dictName}</td>
										<td style="text-align: center">
											<input type="text" value="${rotationDeptMap[tDictId].schMonth}" id="schMonth${tDictId}" style="width: 25px;text-align: center;" onchange="valueCheck(this);"/>
											<font color="red" class="schReq">*</font>
										</td>
										<td>
											<input type="text" value="${rotationDeptMap[tDictId].deptNote}" style="width: 90%" id="deptNote${tDictId}"/>
										</td>
									</tr>
								</c:forEach>
							</c:forEach>
						</c:forEach>
						
						<tr>
							<th colspan="3" style="text-align: left;">&#12288;组合信息</th>
						</tr>
						<tr>
							<td style="text-align: right;"><font color="red" >*</font>组合名称：</td>
							<td colspan="2">
								<input id="groupName" type="text" value="${rotationGroup.groupName}" style="width: 93%" class="validate[required]"/>
							</td>
						</tr>
						<tr class="groupInfo">
							<td style="text-align: right;"><font color="red" >*</font>轮转时间：</td>
							<td colspan="2">
								<input id="schMonth" type="text" class="validate[required,custom[number]]" value="${rotationGroup.schMonth}" style="width: 30px"/>
							</td>
						</tr>
						<tr class="groupInfo">
							<td style="text-align: right;"><font color="red" >*</font>科室选择类型：</td>
							<td colspan="2">
								<c:forEach items="${schSelTypeEnumList}" var="selType">
									<label>
										<input class="selTypeId validate[required]" name="selTypeId" value="${selType.id}" type="radio" <c:if test="${rotationGroup.selTypeId eq selType.id}">checked</c:if> onchange="$('[free]').toggle(this.value=='${schSelTypeEnumFree.id}');">
										${selType.name}
									</label>
								</c:forEach>
							</td>
						</tr>
						<tr class="groupInfo">
							<td style="text-align: right;"><font color="red" >*</font>科室选择数：</td>
							<td colspan="2">
								<input id="deptNum" type="text" value="${rotationGroup.deptNum}" style="width: 30px;" />
								<font free style="display: none;">~</font>
								<input free id="maxDeptNum" type="text" value="${rotationGroup.maxDeptNum}" style="width: 30px;display: none;" />
							</td>
						</tr>
						<tr>
							<td style="text-align: right;"><font color="red" >*</font>排序码：</td>
							<td colspan="2"><input id="ordinal" class="validate[required,custom[integer]]" type="text" value="${rotationGroup.ordinal}" style="width: 30px;"/></td>
						</tr>
						<tr>
							<td style="text-align: right;">组合备注：</td>
							<td colspan="2"><input id="groupNote" type="text" value="${rotationGroup.groupNote}" style="width: 93%"/></td>
						</tr>
					</table>
					<div style="padding-top: 5px;text-align: center;">
						<input type="button" value="保&#12288;存" class="search" onclick="saveRotationDept();"/>
						<input type="button" value="关&#12288;闭" class="search" onclick="jboxClose();"/>
					</div>
		</div>
		</form>
	</div>
</div>
</body>
</html>