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
	<jsp:param name="jquery_ui_sortable" value="true"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<style type="text/css">
	table.basic th,table.basic td{padding: 0;text-align: center;}
	caption{line-height:40px;text-align:left;font-weight:bold; padding-left:10px; border-bottom:1px solid #ddd;color:#f60;margin-bottom: 10px;}
	table.none td{padding-right:5px;border: 0px;border-bottom-width: 0;border-left-width: 0;border-right-width: 0x;border-top-width: 0;}
</style>
<script type="text/javascript">
	function doBack(){
		var target = "<s:url value='/sch/template/list'/>";
		location.href = target+"?roleFlag=${param.roleFlag}";
	}
	
	function addRotationDept(){
		jboxOpen("<s:url value='/sch/template/deptcfg_edit'/>?rotationFlow=${param.rotationFlow}&isAdd=${GlobalConstant.FLAG_Y}&roleFlag=${param.roleFlag}","科室管理",$('.mainright').width(),600);
	}
	
	function editRotationDept(recordFlow,groupFlow){
		jboxOpen("<s:url value='/sch/template/deptcfg_edit'/>?rotationFlow=${param.rotationFlow}&roleFlag=${param.roleFlag}&groupFlow="+groupFlow,"科室管理",$('.mainright').width(),600);
	}
	
	function delRotationDept(recordFlow,groupFlow){
		jboxConfirm("确认删除?",function () {
			var url = "<s:url value='/sch/template/delRotationDept'/>?rotationFlow=${param.rotationFlow}&recordFlow="+recordFlow+"&groupFlow="+groupFlow;
			jboxPost(url,null,function(resp){
				if(resp == '${GlobalConstant.DELETE_SUCCESSED}'){
					refresh('${param.rotationFlow}');
				}
			},null,true);
		});
	}
	
	//查看编辑要求标准
	function rotationStandard(recordFLow){
		jboxOpen("<s:url value='/sch/template/rotationStandard'/>?roleFlag=${param.roleFlag}&recordFlow="+recordFLow,"轮转规范",1000,500);
	}
	
	//编辑要求
// 	function rotationRequire(recordFLow){
// 		location.href = "<s:url value='/sch/template/rotationRequire'/>?roleFlag=${param.roleFlag}&speId=${param.speId}&sessionNumber=${param.sessionNumber}&rotationFlow=${param.rotationFlow}&recordFlow="+recordFLow;
// 	}
	$(function(){
		//侧滑初始化
		$("#reqCfg").slideInit({
			width:800,
			speed:500,
			outClose:true,
			haveZZ:true
		});
	});
	//加载后滑出
	function rotationRequire(recordFLow){
		jboxGet("<s:url value='/sch/template/rotationRequire'/>?roleFlag=${param.roleFlag}&speId=${param.speId}&sessionNumber=${param.sessionNumber}&rotationFlow=${param.rotationFlow}&recordFlow="+recordFLow,null,function(resp){
			$("#reqCfg").html(resp).rightSlideOpen();
			jboxEndLoading();
		},function(){jboxEndLoading();},false);
	}
	//加载页面
	function reqReload(url){
		jboxLoad("reqCfg",url,false);
	}
	
	function refresh(rotationFlow){
		window.location.href="<s:url value='/sch/template/rule'/>?roleFlag=${param.roleFlag}&speId=${param.speId}&sessionNumber=${param.sessionNumber}&rotationFlow="+rotationFlow;
	}
	
	//轮转方案说明
	function openDetail(rotationName, rotationFlow){
		var url = "<s:url value='/sch/template/editRotation'/>?roleFlag=${param.roleFlag}&viewFlag=${GlobalConstant.FLAG_Y}&rotationFlow="+rotationFlow;
		jboxOpen(url, rotationName, 800, 500);
	}
	
	//科室关联配置
	function relCfg(deptBody){
		$("#selDeptList").attr("bodyId",deptBody);
		$(".relOption").hide();
		$("."+deptBody+" .relOption").toggle().html($("#selDeptList"));
		jboxPost("<s:url value='/sch/template/relSchDept'/>?standardDeptId="+$("."+deptBody).attr("standardId"),null,function(resp){
			if(resp){
				$("#selDeptList :checkbox").attr({
					checked:false,
					recordFlow:""
				});
				for(var index in resp){
					$("#"+resp[index].schDeptFlow).attr({
						recordFlow:resp[index].recordFlow,
						checked:true
					});
				}
			}
		},null,false);
	}
	
	//选择或取消关联
	function relSchDept(schDeptFlow){
		if($("#selDeptList :checked").length<1){
			jboxTip("必须保留一条关系！");
			$("#"+schDeptFlow)[0].checked = true;
			return ;
		}
		var bodyId = $("#selDeptList").attr("bodyId");
		var standardDeptId = $("."+bodyId).attr("standardId");
		var schDept = $("#"+schDeptFlow)[0];
		var recordFlow = $(schDept).attr("recordFlow") || "";
		var recordStatus = schDept.checked?"${GlobalConstant.RECORD_STATUS_Y}":"${GlobalConstant.RECORD_STATUS_N}";
		var data = {};
		data.recordFlow = recordFlow;
		if(schDept.checked){
			data.schDeptFlow = schDeptFlow;
			data.standardDeptId = standardDeptId;
		}
		if($("."+bodyId+" .schDeptFlow option[value='"+schDeptFlow+"']").length){
			$("."+bodyId+" .schDeptFlow option[value='"+schDeptFlow+"']").remove();
		}else{
			$("."+bodyId+" .schDeptFlow").append('<option value="'+schDeptFlow+'">'+$("#"+schDeptFlow).attr("schDeptName")+'</option>');
		}
		data.recordStatus = recordStatus;
		jboxStartLoading();
		jboxPost("<s:url value='/sch/cfg/saveDeptRel'/>",data,function(resp){
			if(resp){
				$(schDept).attr("recordFlow",resp);
				var text = "";
				$("#selDeptList :checked").each(function(){
					text+=(","+$(this).attr("schDeptName"));
				});
				text = text.substr(1) || "未关联";
				$(".relRoom."+standardDeptId).text(text);
				
				$("."+bodyId).attr("maxsel",$("#selDeptList :checked").length);
			}
			var bodyData = $("."+bodyId).data("data");
			jboxPost("<s:url value='/sch/template/reUpdateRotationDept'/>",{
				rotationFlow:"${rotation.rotationFlow}",
				standardDeptId:standardDeptId,
				groupFlow:bodyData.groupFlow || ""
			},function(resp){
				$("."+bodyId+" .body").replaceWith($(resp));
				jboxEndLoading();
			},null,false);
		},null,false);
	}
	
	//轮转科室微调
	function ruleCfg(bodyId){
		$("."+bodyId).data("oldBody",$("."+bodyId+" .body").clone(true));
		$("."+bodyId).data("removeList",[]);
		
		$("."+bodyId+" .data").toggle();
	}
	
	//取消调整
	function cancelCfg(bodyId){
		//jboxConfirm("确认取消设置？",function(){
			$("."+bodyId+" .body").replaceWith($("."+bodyId).data("oldBody"));
		//},null);
	}
	
	//添加调整
	function addSchDept(addTr){
		var body = $(addTr).closest("tbody");
		if(body.find(".body").length < body.attr("maxsel")){
			var newTr = $(addTr).closest(".body").clone(true);
			newTr.find(".record,.schDeptFlow,.firstYear,.secondYear,.thirdYear,.schMonth").val("");
			$(addTr).closest(".body").after(newTr);
		}else{
			jboxTip("轮转科室不可多于关联轮转科室数！");
		}
	}
	
	//移除调整
	function removeCfg(bodyId,trId){
		if($("."+bodyId+" .body").length>1){
			var record = $(trId).closest(".body").find(".record").val();
			$("."+bodyId).data("removeList").push(record);
			$(trId).closest(".body").remove();
		}else{
			jboxTip("必须保留一个轮转科室！");
		}
	}
	
	//检测重复选取
	function checkResel(bodyId,select){
		if($("."+bodyId+" [value='"+select.value+"']:selected").length>1){
			select.value="";
			jboxTip("不可添加重复轮转科室！");
		}
	}
	
	//保存微调
	function saveCfg(bodyId,standardDeptId,groupFlow){
		var rotationDeptList = [];
		var currFirst = 0;
		var currSecond = 0;
		var currThird = 0;
		
		$("."+bodyId+" .body").each(function(){
// 			if(!$(this).find(".schDeptFlow").val()){
// 				return jboxTip("轮转科室不能为空！");
// 			}
			var first = parseFloat($(this).find(":text.firstYear").val() || 0);
			var second = parseFloat($(this).find(":text.secondYear").val() || 0);
			var third = parseFloat($(this).find(":text.thirdYear").val() || 0);
			currFirst+=first;
			currSecond+=second;
			currThird+=third;
			
			var rotationDept = {};
			rotationDept.recordFlow = $(this).find(".record").val() || "";
			rotationDept.schMonth = $(this).find(".schMonth").val() || "";
			rotationDept.standardDeptId = standardDeptId;
			rotationDept.schDeptFlow = $(this).find(".schDeptFlow").val() || "";
			rotationDept.rotationFlow = "${rotation.rotationFlow}";
			rotationDept.firstYear = first;
			<c:if test="${rotation.rotationYear>1}">
			rotationDept.secondYear = second;
			</c:if>
			<c:if test="${rotation.rotationYear>2}">
			rotationDept.thirdYear = third;
			</c:if>
			rotationDept.isRequired = groupFlow?"${GlobalConstant.FLAG_N}":"${GlobalConstant.FLAG_Y}";
			rotationDept.groupFlow = groupFlow || "";
			
			rotationDeptList.push(rotationDept);
		});
		
		var removeList = $("."+bodyId).data("removeList");
		for(var index in removeList){
			
			var rotationDept = {};
			rotationDept.recordFlow = removeList[index];
			rotationDept.recordStatus = "${GlobalConstant.RECORD_STATUS_N}";
			
			rotationDeptList.push(rotationDept);
		}
		
		var data = $("."+bodyId).data("data");
		if(currFirst!=data.firstYear || currSecond!=data.secondYear || currThird!=data.thirdYear){
			jboxTip("轮转时间必须等于标准方案轮转时间！");
			return ;
		}
		
		var deptNum = 0;
		if(groupFlow){
			var groupTab = $("."+bodyId).closest(".xllist");
			groupTab.find(".mainBody").each(function(){
				deptNum+=($(this).find(".body").length-1);
			});
			deptNum+=data.deptNum;
		}
		jboxConfirm("确认保存修改?",function(){
			jboxPostJson("<s:url value='/sch/template/saveCfg'/>?groupFlow="+groupFlow+"&deptNum="+deptNum,JSON.stringify(rotationDeptList),function(resp){
				if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
					location.reload(true);
				}
			},null,false);
		},null);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<table style="width:100%;margin: 10px 0;" class="basic" >
			<tr>
				<td style="text-align: left;padding-left:10px;">
					<font style="font-weight: bolder;">培训方案名称：</font><font title="点击查看方案说明" style="font-weight: bold;color:#3d91d5;cursor: pointer;"  onclick="openDetail('${rotation.rotationName}','${rotation.rotationFlow}');">${rotation.rotationName}</font>
					&#12288;&#12288;
					<font style="font-weight: bolder;">人员类型：</font>${rotation.doctorCategoryName}
					&#12288;&#12288;
					<font style="font-weight: bolder;">培训专业：</font>${rotation.speName}
					&#12288;&#12288;
					<font style="font-weight: bolder;">年限：</font>${rotation.rotationYear}
					&#12288;&#12288;
					<input type="button" value="返&#12288;回" class="search" onclick="doBack();"/>
					<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag}">
						<input type="button" value="新&#12288;增" class="search" onclick="addRotationDept();"/>
					</c:if>
				</td>
			</tr>
		</table>
		<div>
		<table class="xllist" style="margin-bottom: 10px;">
			<caption>
			必轮科室
			<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag}">
			<font style="float: right;margin-right: 10px;font-weight: normal;">
			<a onclick="editRotationDept('${rotationDept.rotationFlow}','')" style="color: blue;cursor: pointer;">编辑</a>
			</font>
			</c:if>
			</caption>
			<tr>
				<th width="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag?'25':'25'}%">
					标准科室
				</th>
				<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag)}">
					<th width="15%">轮转科室</th>
				</c:if>
				<th width="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag?'20':'15'}%">轮转时间</th>
				<th width="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag?'15':'10'}%">时间(月数)</th>
				<th width="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag?'20':'15'}%">备注</th>
				<th width="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag?'20':'20'}%">操作</th>
			</tr>
			<c:forEach items="${mustDeptMap}" var="mustDepts">
			<tbody standardId="${mustDepts.key}" maxsel="${deptRelMap[mustDepts.key].size()}" class="must${mustDepts.key} mainBody">
				<tr class="head">
					<td rowspan="${mustDepts.value.size()+10}">
						<table style="width: 100%;" class="none">
							<tr>
								<td width="100px;" style="text-align: center;">${standardNameMap[mustDepts.key]}</td>
								<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag)}">
									<td width="5px;" >|</td>
									<td style="text-align: left">
										轮转时间：
										<c:set value="${mustDepts.key}" var="key"/>
										${standardRotationDeptMap[key].firstYear}
										<script>
										$(function(){
											$(".must${mustDepts.key}").data("data",{
												firstYear:<c:out value="${standardRotationDeptMap[key].firstYear}" default="0"/>,
												secondYear:<c:out value="${standardRotationDeptMap[key].secondYear}" default="0"/>,
												thirdYear:<c:out value="${standardRotationDeptMap[key].thirdYear}" default="0"/>,
											});
										});
										</script>
										<c:if test="${!empty standardRotationDeptMap[key].secondYear}">
											+
											${standardRotationDeptMap[key].secondYear}
										</c:if>
										<c:if test="${!empty standardRotationDeptMap[key].thirdYear}">
											+
											${standardRotationDeptMap[key].thirdYear}
										</c:if>月
										<div style="color: #3d91d5;" onclick="relCfg('must${mustDepts.key}');">
										关联科室：
										<font class="relRoom ${mustDepts.key}" title="配置关联科室" style="cursor: pointer;">
										<c:forEach items="${deptRelMap[mustDepts.key]}" var="relMap" varStatus="status">
											<c:if test="${!status.first}">
												,
											</c:if>
											${relMap.value.schDeptName}
										</c:forEach>
										<c:if test="${empty deptRelMap[mustDepts.key]}">未关联</c:if>
										</font>
										</div>
										<div relNum="${deptRelMap[mustDepts.key].size()}" class="relOption" style="display: none;height: 0px;overflow: visible;width: 0px;"></div>
									</td>
								</c:if>
							</tr>
						</table>
					</td>
				</tr>
				<c:forEach items="${mustDepts.value}" var="rotationDept">
					<tr class="body">
						<input class="record" type="hidden" value="${rotationDept.recordFlow}"/>
						<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag)}">
						<td>
							<font class="data">${rotationDept.schDeptName}</font>
							<div class="data"  style="display: none;">
								<select class="schDeptFlow" style="width: 100px;" onchange="checkResel('must${mustDepts.key}',this);">
								<option>
								<c:forEach items="${deptRelMap[mustDepts.key]}" var="relMap">
									<option value="${relMap.value.schDeptFlow}" 
									<c:if test="${rotationDept.schDeptFlow eq relMap.value.schDeptFlow}">selected</c:if>
									>${relMap.value.schDeptName}</option>
								</c:forEach>
								</select>
							</div>
						</td>
						</c:if>
						<td>
							<font class="firstYear data">
								${rotationDept.firstYear}个月
							</font>
							<input type="text" value="${rotationDept.firstYear}" class="firstYear data"  style="display: none;width: 20px;"/>
							
							<c:if test="${!empty rotationDept.secondYear}">
							+
							<font class="secondYear data">
								${rotationDept.secondYear}个月
							</font>
							<input type="text" value="${rotationDept.secondYear}" class="secondYear data"  style="display: none;width: 20px;"/>
							</c:if>
							
							<c:if test="${!empty rotationDept.thirdYear}">
							+
							<font class="thirdYear data">
								${rotationDept.thirdYear}个月
							</font>
							<input type="text" value="${rotationDept.thirdYear}" class="thirdYear data"  style="display: none;width: 20px;"/>
							</c:if>
						</td>
						<td>
							${rotationDept.schMonth}
<%-- 							<font class="data">${rotationDept.schMonth}</font> --%>
<%-- 							<input type="text" value="${rotationDept.schMonth}" class="data schMonth"  style="display: none;width: 20px;"> --%>
						</td>
						<td class="note">${rotationDept.deptNote}</td>
						<td>
							<div class="data">
								<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag)}">
									<a style="cursor: pointer;color: blue;" class="ruleCfgBtn" onclick="ruleCfg('must${mustDepts.key}');">调整</a>
									&nbsp;|&nbsp;
								</c:if>
								<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag}">
								<a onclick="delRotationDept('${rotationDept.recordFlow}','')" style="color: blue;cursor: pointer;">删除</a>
								&nbsp;|&nbsp;
								<a onclick="rotationRequire('${rotationDept.recordFlow}');" style="color: blue;cursor: pointer;">轮转要求</a>
								&nbsp;|&nbsp;
								</c:if>
								<a onclick="rotationStandard('${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag?rotationDept.recordFlow:standardRotationDeptMap[key].recordFlow}');" style="color: blue;cursor: pointer;">轮转规范</a>
							</div>
							<div class="data"  style="display: none;">
								<a style="cursor: pointer;color: blue;" onclick="addSchDept(this);">添加</a>
								&nbsp;|&nbsp;
								<a style="cursor: pointer;color: blue;" onclick="removeCfg('must${mustDepts.key}',this);">移除</a>
								&nbsp;|&nbsp;
								<a style="cursor: pointer;color: blue;" onclick="saveCfg('must${mustDepts.key}','${mustDepts.key}','');">确认</a>
								&nbsp;|&nbsp;
								<a style="cursor: pointer;color: blue;" onclick="cancelCfg('must${mustDepts.key}');">取消</a>
							</div>
						</td>
					</tr>
				</c:forEach>
			</tbody>
			</c:forEach>
			<c:if test="${empty rotationDeptList}">
				<tr><td colspan="7">暂无必轮科室</td></tr>
			</c:if>
		</table>
				
				
		<c:forEach items="${rotationGroupList}" var="rotationGroup">
			<table class="xllist">
				<caption>
					${rotationGroup.groupName}
					<font style="float: right;margin-right: 10px;font-weight: normal;color: black;">
						时间(月数)：${rotationGroup.schMonth}个月
						&#12288;
						<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag}">
						<a href="javascript:editRotationDept('','${rotationGroup.groupFlow}')" style="color: blue;cursor: pointer;">编辑</a>
						&nbsp;|&nbsp;
						<a href="javascript:delRotationDept('','${rotationGroup.groupFlow}')" style="color: blue;cursor: pointer;">删除</a>
						</c:if>
					</font>
				</caption>
				<tr>
					<th width="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag?'25':'25'}%">
					标准科室
<%-- 					<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag)}"> --%>
<!-- 					 |  -->
<!-- 					 轮转时间 -->
<%-- 					</c:if> --%>
					</th>
					<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag)}">
						<th width="15%">轮转科室</th>
					</c:if>
					<th width="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag?'55':'40'}%">轮转时间</th>
					<th width="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag?'20':'20'}%">操作</th>
				</tr>
				<c:forEach items="${rotationDeptListMap[rotationGroup.groupFlow]}" var="groupDeptMap">
				<tbody standardId="${groupDeptMap.key}" maxsel="${deptRelMap[groupDeptMap.key].size()}" class="${rotationGroup.groupFlow}${groupDeptMap.key} mainBody">
					<tr class="head">
						<td rowspan="${groupDeptMap.value.size()+10}">
							<table style="width: 100%;" class="none">
							<tr>
							<td width="100px;" style="text-align: center;">
							${standardNameMap[groupDeptMap.key]}
							</td>
							<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag)}">
								<td width="5px;" >|</td>
								<td style="text-align: left">
									轮转时间：
<!-- 								| -->
									<c:set value="${rotationGroup.standardGroupFlow}${groupDeptMap.key}" var="key"/>
									${standardRotationDeptMap[key].firstYear}
									<script>
									$(function(){
										$(".${rotationGroup.groupFlow}${groupDeptMap.key}").data("data",{
											firstYear:<c:out value="${standardRotationDeptMap[key].firstYear}" default="0"/>,
											secondYear:<c:out value="${standardRotationDeptMap[key].secondYear}" default="0"/>,
											thirdYear:<c:out value="${standardRotationDeptMap[key].thirdYear}" default="0"/>,
											deptNum:${standardRotationGroupMap[rotationGroup.standardGroupFlow].deptNum},
											groupFlow:"${rotationGroup.groupFlow}"
										});
									});
									</script>
									<c:if test="${!empty standardRotationDeptMap[key].secondYear}">
										+
										${standardRotationDeptMap[key].secondYear}
									</c:if>
									<c:if test="${!empty standardRotationDeptMap[key].thirdYear}">
										+
										${standardRotationDeptMap[key].thirdYear}
									</c:if>
									<div style="color: #3d91d5;font-size: 8px;" onclick="relCfg('${rotationGroup.groupFlow}${groupDeptMap.key}');">
									关联科室：
									<font class="relRoom ${groupDeptMap.key}" title="配置关联科室" style="cursor: pointer;">
									<c:forEach items="${deptRelMap[groupDeptMap.key]}" var="relMap" varStatus="status">
										<c:if test="${!status.first}">
											,
										</c:if>
										${relMap.value.schDeptName}
									</c:forEach>
									<c:if test="${empty deptRelMap[groupDeptMap.key]}">未关联</c:if>
									</font>
									</div>
									<div relNum="${deptRelMap[groupDeptMap.key].size()}" class="relOption" style="display: none;height: 0px;overflow: visible;width: 0px;"></div>
								</td>
							</c:if>
								</tr>
							</table>
							</td>
						</tr>
					<c:forEach items="${groupDeptMap.value}" var="groupDept">
						<tr class="body">
							<input class="record" type="hidden" value="${groupDept.recordFlow}"/>
							<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag)}">
								<td>
								<font class="data">${groupDept.schDeptName}</font>
								<div class="data"  style="display: none;">
									<select class="schDeptFlow" style="width: 100px;" onchange="checkResel('${rotationGroup.groupFlow}${groupDeptMap.key}',this);">
									<option>
									<c:forEach items="${deptRelMap[groupDeptMap.key]}" var="relMap">
										<option value="${relMap.value.schDeptFlow}" 
										<c:if test="${groupDept.schDeptFlow eq relMap.value.schDeptFlow}">selected</c:if>
										>${relMap.value.schDeptName}</option>
									</c:forEach>
									</select>
								</div>
								</td>
							</c:if>
							<td>
							<font class="firstYear data">
								${groupDept.firstYear}个月
							</font>
							<input type="text" value="${groupDept.firstYear}" class="firstYear data"  style="display: none;width: 20px;"/>
							
							<c:if test="${!empty groupDept.secondYear}">
							<font class="secondYear data">
								+ ${groupDept.secondYear}个月
							</font>
							<input type="text" value="${groupDept.secondYear}" class="secondYear data"  style="display: none;width: 20px;"/>
							</c:if>
							
							<c:if test="${!empty groupDept.thirdYear}">
							<font class="thirdYear data">
								+ ${groupDept.thirdYear}个月
							</font>
							<input type="text" value="${groupDept.thirdYear}" class="thirdYear data"  style="display: none;width: 20px;"/>
							</c:if>
							</td>
							<td>
								<div class="data">
									<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag)}">
										<a style="cursor: pointer;color: blue;" onclick="ruleCfg('${rotationGroup.groupFlow}${groupDeptMap.key}');">调整</a>
										&nbsp;|&nbsp;
									</c:if>
									<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag}">
									<a href="javascript:rotationRequire('${groupDept.recordFlow}');" style="color: blue;cursor: pointer;">轮转要求</a>
									&nbsp;|&nbsp;
									</c:if>
									<a href="javascript:rotationStandard('${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag?groupDept.recordFlow:standardRotationDeptMap[key].recordFlow}');" style="color: blue;cursor: pointer;">轮转规范</a>
								</div>
								<div class="data" style="display: none;">
									<a style="cursor: pointer;color: blue;" onclick="addSchDept(this);">添加</a>
									&nbsp;|&nbsp;
									<a style="cursor: pointer;color: blue;" onclick="removeCfg('${rotationGroup.groupFlow}${groupDeptMap.key}',this);">移除</a>
									&nbsp;|&nbsp;
									<a style="cursor: pointer;color: blue;" onclick="saveCfg('${rotationGroup.groupFlow}${groupDeptMap.key}','${groupDeptMap.key}','${rotationGroup.groupFlow}');">确认</a>
									&nbsp;|&nbsp;
									<a style="cursor: pointer;color: blue;" onclick="cancelCfg('${rotationGroup.groupFlow}${groupDeptMap.key}');">取消</a>
								</div>              
							</td>                   
						</tr>                       
					</c:forEach>                    
				</tbody>                            
				</c:forEach>                        
				<tr>                                
					<th>备注</th>                   
					<td colspan="4" style="padding-left: 10px;text-align: left;">
						${rotationGroup.groupNote}
					</td>
				</tr>                            
			</table>                             
		</c:forEach>                             
		</div>                                   
	</div>
</div>
<div id="openContentHome" style="display: none;">
	<div id="selDeptList" bodyId="" class="choose-wrapper">
		<p style="text-align: left;padding-left: 10px;width: 100%;line-height: 30px;">
		<c:forEach items="${deptList}" var="dept" varStatus="status">
			<font title="${dept.externalOrgName}" style="display: inline-block;text-align: left;min-width: 110px;"> <label><input id="${dept.schDeptFlow}" type="checkbox" onclick="relSchDept('${dept.schDeptFlow}');" schDeptName="${dept.schDeptName}"/> ${dept.schDeptName}<c:if test="${GlobalConstant.FLAG_Y eq dept.isExternal}"><font color="red">*</font></c:if></label></font>
			<c:if test="${status.count%3==0}">
				</p><p style="text-align: left;padding-left: 10px;width: 100%;">
			</c:if>
		</c:forEach>
		</p>
		<div style="margin:10px auto;"><a class="search" style="padding: 3px 12px;"  onclick="$('#selDeptList').parent().toggle();">关&nbsp;闭</a>&#12288;Tip：<font color="red"> * </font>表示外院科室！</div>
	</div>
</div>
<div id="reqCfg"></div>
</body>
</html>