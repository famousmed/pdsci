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
<c:set value="schUnitEnum${sysCfgMap['res_rotation_unit']}" var="unitKey"/>
<script type="text/javascript">
	function doBack(){
		var target ;
		<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag)}">
			target = "<s:url value='/sch/template/localList'/>?roleFlag=${param.roleFlag}";
		</c:if>
		<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag}">
			target = "<s:url value='/res/platform/rotation'/>?roleFlag=${param.roleFlag}";
		</c:if>
		<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq param.currRoleFlag}">
			target = "<s:url value='/sch/template/localList'/>?roleFlag=${param.roleFlag}&orgFlow=${param.orgFlow}&currRoleFlag=${param.currRoleFlag}";
		</c:if>
		location.href = target;
	}
	
	function addRotationDept(){
		jboxOpen("<s:url value='/sch/template/deptcfg_edit'/>?rotationFlow=${param.rotationFlow}&isAdd=${GlobalConstant.FLAG_Y}&roleFlag=${param.roleFlag}","科室管理",$('.mainright').width(),600);
	}
	
	function editRotationDept(recordFlow,groupFlow){
		jboxOpen("<s:url value='/sch/template/deptcfg_edit'/>?rotationFlow=${param.rotationFlow}&roleFlag=${param.roleFlag}&groupFlow="+groupFlow,"科室管理",$('.mainright').width(),600);
	}
	
	function delRotationDept(recordFlow,groupFlow,rotationFlow){
		jboxConfirm("确认删除?",function () {
			var url = "<s:url value='/sch/template/delRotationDept'/>?recordFlow="+recordFlow+"&groupFlow="+groupFlow+"&rotationFlow="+rotationFlow;
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
		jboxGet("<s:url value='/sch/template/rotationRequire'/>?roleFlag=${param.roleFlag}&rotationFlow=${param.rotationFlow}&recordFlow="+recordFLow,null,function(resp){
			$("#reqCfg").html(resp).rightSlideOpen();
			jboxEndLoading();
		},function(){jboxEndLoading();},false);
	}
	//加载页面
	function reqReload(url){
		jboxLoad("reqCfg",url,false);
	}
	
	//刷新页面
	function refresh(rotationFlow){
		window.location.href="<s:url value='/sch/template/rule'/>?roleFlag=${param.roleFlag}&rotationFlow="+rotationFlow;
	}
	
	//移动科室
	function moveDept(type,bodyId,ele){
		var bodyTr = $(ele).closest(".body");
		var trIndex = $("."+bodyId+" .body").index(bodyTr);
		$("."+bodyId+" .body:first td:last").hide();
		if("up" == type){
			if(0==trIndex){
				$("."+bodyId+" .body:first td:last").show();
				return jboxTip("不可上移！");
			}
			var replaceEle = $("."+bodyId+" .body:eq("+(trIndex-1)+")");
			replaceEle.before(bodyTr);
			$("."+bodyId+" .body:first td:last").show();
		}else if("down" == type){
			if($("."+bodyId+" .body").length-1 == trIndex){
				$("."+bodyId+" .body:first td:last").show();
				return jboxTip("不可下移！");
			}
			var replaceEle = $("."+bodyId+" .body:eq("+(trIndex+1)+")");
			replaceEle.after(bodyTr);
			$("."+bodyId+" .body:first td:last").show();
		}
		var recordFlows = "";
		$(".record").each(function(){
			recordFlows+=("&recordFlows="+this.value);
		});
		jboxPost("<s:url value='/sch/template/sortRotationDept'/>",recordFlows,null,null,false);
	}
	
	//轮转方案说明
	function openDetail(rotationName,rotationFlow){
		var url = "<s:url value='/sch/template/editRotation'/>?roleFlag=${param.roleFlag}&viewFlag=${GlobalConstant.FLAG_Y}&rotationFlow="+rotationFlow;
		jboxOpen(url, rotationName, 800, 500);
	}
	
	//科室关联配置
	function relCfg(deptBody){
		$("#selDeptList").attr("bodyId",deptBody);
		$(".relOption").hide();
		$("."+deptBody+" .relOption").toggle().html($("#selDeptList"));
		var standardDeptId = $("."+deptBody).attr("standardId") || "";
		jboxPost("<s:url value='/sch/template/relSchDept'/>?orgFlow=${param.orgFlow}&standardDeptId="+standardDeptId,null,function(resp){
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
		data.orgFlow = "${param.orgFlow}" || "";
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
				groupFlow:bodyData.groupFlow || "",
				orgFlow:"${param.orgFlow}" || "",
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
			newTr.find("td:last").hide();
			newTr.find(".record,.schDeptFlow,.firstYear,.secondYear,.thirdYear,.schMonth").val("");
			$(addTr).closest("tbody").append(newTr);
		}else{
			jboxTip("轮转科室不可多于关联轮转科室数！");
		}
	}
	
	//移除调整
	function removeCfg(bodyId,trId){
		if($("."+bodyId+" .body").length>1){
			var removeTr = $(trId).closest(".body");
			var record = removeTr.find(".record").val();
			if(record){
				$("."+bodyId).data("removeList").push(record);
			}
			removeTr.next().find("td:last").show();
			removeTr.remove();
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
			var first = parseFloat($(":text.firstYear",this).val() || 0);
			var second = parseFloat($(":text.secondYear",this).val() || 0);
			var third = parseFloat($(":text.thirdYear",this).val() || 0);
			currFirst+=first;
			currSecond+=second;
			currThird+=third;
			
			var rotationDept = {};
			rotationDept.recordFlow = $(".record",this).val() || "";
			rotationDept.schMonth = $(".schMonth",this).val() || "";
			rotationDept.standardDeptId = standardDeptId;
			rotationDept.schDeptFlow = $(".schDeptFlow",this).val() || "";
			rotationDept.rotationFlow = "${rotation.rotationFlow}";
			rotationDept.firstYear = first;
			rotationDept.secondYear = second;
			rotationDept.thirdYear = third;
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
		
		var addNum = 0;
		var deptNum = data.deptNum || 0;
		var maxDeptNum = data.maxDeptNum || 0;
		if(groupFlow){
			var groupTab = $("."+bodyId).closest(".xllist");
			groupTab.find(".mainBody").each(function(){
				addNum+=($(this).find(".body").length-1);
			});
			if(maxDeptNum){
				maxDeptNum+=addNum;
			}else{
				deptNum+=addNum;
			}
		}
		jboxConfirm("确认保存修改?",function(){
			jboxPostJson("<s:url value='/sch/template/saveCfg'/>?orgFlow=${param.orgFlow}&groupFlow="+groupFlow+"&deptNum="+deptNum+"&maxDeptNum="+maxDeptNum,JSON.stringify(rotationDeptList),function(resp){
				if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
					location.reload(true);
				}
			},null,false);
		},null);
	}
	
	<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq param.currRoleFlag}">
	function reloadRule(orgFlow){
		window.location.href="<s:url value='/sch/template/rule'/>?rotationFlow=${rotation.rotationFlow}&roleFlag=${param.roleFlag}&currRoleFlag=${param.currRoleFlag}&orgFlow="+orgFlow;
	}
	</c:if>
	
	$(function(){
		<c:if test="${useCount>0}">
			$(".countEditFlag").toggle();
		</c:if>
	});
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<table style="width:100%;margin: 10px 0;" class="basic" >
			<tr>
				<td style="text-align: left;padding-left:10px;">
					<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq param.currRoleFlag}">
					选择机构：
					<select onchange="reloadRule(this.value);">
						<c:forEach items="${applicationScope.sysOrgList}" var="org">
							<option value="${org.orgFlow}" <c:if test="${param.orgFlow eq org.orgFlow}">selected</c:if>>${org.orgName}</option>
						</c:forEach>
					</select>
					&#12288;&#12288;
					</c:if>
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
						<input type="button" value="新&#12288;增" class="search countEditFlag" onclick="addRotationDept();"/>
						<font class="countEditFlag" style="display: none;color: blue;margin-right: 10px;float: right;">Tip：已有<font color="red">${useCount}</font>名医师在使用本方案,不可修改！</font>
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
			<a onclick="editRotationDept('${rotationDept.rotationFlow}','')" style="color: blue;cursor: pointer;" class="countEditFlag">编辑</a>
			</font>
			</c:if>
			</caption>
			<tr>
				<th width="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag?'25':'25'}%">
					标准科室
				</th>
				<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag)}">
					<th width="20%">轮转科室</th>
				</c:if>
				<th width="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag?'20':'15'}%">轮转时间(${applicationScope[unitKey].name})</th>
				<th width="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag?'15':'10'}%">总时间(${applicationScope[unitKey].name}数)</th>
				<th width="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag?'20':'15'}%">备注</th>
				<th width="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag?'20':'15'}%">操作</th>
			</tr>
			<c:set var="sf" value="0"/>
			<c:set var="ss" value="0"/>
			<c:set var="st" value="0"/>
			<c:set var="lf" value="0"/>
			<c:set var="ls" value="0"/>
			<c:set var="ltc" value="0"/>
			<c:forEach items="${mustStandardRotationDeptList}" var="mustDept">
			<tbody standardId="${mustDept.standardDeptId}" maxsel="${deptRelMap[mustDept.standardDeptId].size()}" class="must${mustDept.standardDeptId} mainBody">
				<tr class="head">
					<td rowspan="100">
						<table style="width: 100%;" class="none">
							<tr>
								<td width="100px;" style="text-align: center;">${mustDept.standardDeptName}</td>
								<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag)}">
									<td width="5px;" >|</td>
									<td style="text-align: left">
										轮转时间：
										<c:out value="${mustDept.firstYear}" default="0"/>
										<c:set var="sf" value="${sf+mustDept.firstYear}"/>
										<script>
										$(function(){
											$(".must${mustDept.standardDeptId}").data("data",{
												firstYear:<c:out value="${mustDept.firstYear}" default="0"/>,
												secondYear:<c:out value="${mustDept.secondYear}" default="0"/>,
												thirdYear:<c:out value="${mustDept.thirdYear}" default="0"/>,
											});
										});
										</script>
										<c:if test="${rotation.rotationYear >= 2}">
											+
											<c:out value="${mustDept.secondYear}" default="0"/>
											<c:set var="ss" value="${ss+mustDept.secondYear}"/>
										</c:if>
										<c:if test="${rotation.rotationYear == 3}">
											+
											<c:out value="${mustDept.thirdYear}" default="0"/>
											<c:set var="st" value="${st+mustDept.thirdYear}"/>
										</c:if>
										<div style="color: #3d91d5;" onclick="relCfg('must${mustDept.standardDeptId}');">
										关联科室：
										<font class="relRoom ${mustDept.standardDeptId}" title="配置关联科室" style="cursor: pointer;">
										<c:forEach items="${deptRelMap[mustDept.standardDeptId]}" var="relMap" varStatus="status">
											<c:if test="${!status.first}">
												,
											</c:if>
											${relMap.value.schDeptName}
										</c:forEach>
										<c:if test="${empty deptRelMap[mustDept.standardDeptId]}">未关联</c:if>
										</font>
										</div>
										<div relNum="${deptRelMap[mustDept.standardDeptId].size()}" class="relOption" style="display: none;height: 0px;overflow: visible;width: 0px;"></div>
									</td>
								</c:if>
							</tr>
						</table>
					</td>
				</tr>
				
				<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag}">
					<tr>
						<td>
							<c:out value="${mustDept.firstYear}" default="0"/>
							<c:set var="sf" value="${sf+mustDept.firstYear}"/>
							<c:if test="${rotation.rotationYear >= 2}">
								+
								<c:out value="${mustDept.secondYear}" default="0"/>
								<c:set var="ss" value="${ss+mustDept.secondYear}"/>
							</c:if>
							<c:if test="${rotation.rotationYear == 3}">
								+
								<c:out value="${mustDept.thirdYear}" default="0"/>
								<c:set var="st" value="${st+mustDept.thirdYear}"/>
							</c:if>
						</td>
						<td>
							${mustDept.schMonth}
						</td>
						<td class="note">${mustDept.deptNote}</td>
						<td>
							<a onclick="delRotationDept('${mustDept.recordFlow}','','${mustDept.rotationFlow}')" style="color: blue;cursor: pointer;" class="countEditFlag">删除</a>
							<font class="countEditFlag">&nbsp;|&nbsp;</font>
							<a onclick="rotationRequire('${mustDept.recordFlow}');" style="color: blue;cursor: pointer;">轮转要求</a>
							&nbsp;|&nbsp;
							<a onclick="rotationStandard('${mustDept.recordFlow}');" style="color: blue;cursor: pointer;">轮转规范</a>
						</td>
					</tr>
				</c:if>
				
				<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag)}">
				<c:forEach items="${localRotationDeptListMap[mustDept.standardDeptId]}" var="rotationDept" varStatus="statusFlag">
					<tr class="body" style="min-height: 30px;">
						<input class="record" type="hidden" value="${rotationDept.recordFlow}"/>
						<td>
							<span style="float: left;margin-left: 10px;">
								<img title="上移" src="<s:url value='/css/skin/${skinPath}/images/up.png'/>" onclick="moveDept('up','must${mustDept.standardDeptId}',this);" style="cursor: pointer;"/>
								<img title="下移" src="<s:url value='/css/skin/${skinPath}/images/down.png'/>" onclick="moveDept('down','must${mustDept.standardDeptId}',this);" style="cursor: pointer;"/>
							</span>
							<font class="data">${rotationDept.schDeptName}</font>
							<div class="data"  style="display: none;">
								<img title="移除" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="removeCfg('must${mustDept.standardDeptId}',this);" style="display: none;cursor: pointer;margin-right: 10px;" class="data"/>
								<select class="schDeptFlow" style="width: 100px;" onchange="checkResel('must${mustDept.standardDeptId}',this);">
								<option>
								<c:forEach items="${deptRelMap[mustDept.standardDeptId]}" var="relMap">
									<option value="${relMap.value.schDeptFlow}" 
									<c:if test="${rotationDept.schDeptFlow eq relMap.value.schDeptFlow}">selected</c:if>
									>${relMap.value.schDeptName}</option>
								</c:forEach>
								</select>
							</div>
						</td>
						<td>
							<font class="firstYear data">
								<c:out value="${rotationDept.firstYear}" default="0"/>
								<c:set var="lf" value="${lf+rotationDept.firstYear}"/>
							</font>
							<input type="text" value="${rotationDept.firstYear}" class="firstYear data"  style="display: none;width: 20px;"/>
							
							<c:if test="${rotation.rotationYear >= 2}">
								+
							<font class="secondYear data">
								<c:out value="${rotationDept.secondYear}" default="0"/>
								<c:set var="ls" value="${ls+rotationDept.secondYear}"/>
							</font>
							<input type="text" value="${rotationDept.secondYear}" class="secondYear data"  style="display: none;width: 20px;"/>
							</c:if>
							
							<c:if test="${rotation.rotationYear == 3}">
								+
							<font class="thirdYear data">
								<c:out value="${rotationDept.thirdYear}" default="0"/>
								<c:set var="ltc" value="${ltc+rotationDept.thirdYear}"/>
							</font>
							<input type="text" value="${rotationDept.thirdYear}" class="thirdYear data"  style="display: none;width: 20px;"/>
							</c:if>
						</td>
						<td>
							${rotationDept.schMonth}
<%-- 							<font class="data">${rotationDept.schMonth}</font> --%>
<%-- 							<input type="text" value="${rotationDept.schMonth}" class="data schMonth"  style="display: none;width: 20px;"> --%>
						</td>
						<td class="note">${mustDept.deptNote}</td>
						
						<td rowspan="100" <c:if test="${!statusFlag.first}">style="display: none;"</c:if>>
							<div class="data">
								<a style="cursor: pointer;color: blue;" class="ruleCfgBtn" onclick="ruleCfg('must${mustDept.standardDeptId}');">调整</a>
								&nbsp;|&nbsp;
								<a onclick="rotationStandard('${mustDept.recordFlow}');" style="color: blue;cursor: pointer;">轮转规范</a>
							</div>
							<div class="data"  style="display: none;">
								<a style="cursor: pointer;color: blue;" onclick="addSchDept(this);">添加</a>
<!-- 								&nbsp;|&nbsp; -->
<%-- 								<a style="cursor: pointer;color: blue;" onclick="removeCfg('must${mustDept.standardDeptId}',this);">移除</a> --%>
								&nbsp;|&nbsp;
								<a style="cursor: pointer;color: blue;" onclick="saveCfg('must${mustDept.standardDeptId}','${mustDept.standardDeptId}','');">确认</a>
								&nbsp;|&nbsp;
								<a style="cursor: pointer;color: blue;" onclick="cancelCfg('must${mustDept.standardDeptId}');">取消</a>
							</div>
						</td>
						
					</tr>
				</c:forEach>
				</c:if>
			</tbody>
			</c:forEach>
			<c:if test="${!empty mustStandardRotationDeptList}">
				<tr>
					<th>合计</th>
					<td colspan="6" style="text-align: left;padding-left: 10px;">
						轮转时间(标准)：
						${sf}
						<c:if test="${rotation.rotationYear >= 2}">
							+
							${ss}
						</c:if>
						<c:if test="${rotation.rotationYear >= 3}">
							+
							${st}
						</c:if>
						&#12288;
						合：${sf+ss+st}
						&#12288;&#12288;&#12288;
						<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag)}">
							轮转时间：
							${lf}
							<c:if test="${rotation.rotationYear >= 2}">
								+
								${ls}
							</c:if>
							<c:if test="${rotation.rotationYear >= 3}">
								+
								${ltc}
							</c:if>
							&#12288;
							合：${lf+ls+ltc}
						</c:if>
					</td>
				</tr>
			</c:if>
			<c:if test="${empty mustStandardRotationDeptList}">
				<tr><td colspan="7">暂无必轮科室</td></tr>
			</c:if>
		</table>
				
				
		<c:forEach items="${standardRotationGroupList}" var="rotationGroup">
			<c:set var="sf" value="0"/>
			<c:set var="ss" value="0"/>
			<c:set var="st" value="0"/>
			<c:set var="lf" value="0"/>
			<c:set var="ls" value="0"/>
			<c:set var="ltc" value="0"/>
			<table class="xllist">
				<caption>
					${rotationGroup.groupName}
					<font style="float: right;margin-right: 10px;font-weight: normal;color: black;">
						总时间(${applicationScope[unitKey].name}数)：${rotationGroup.schMonth}${applicationScope[unitKey].name}
						&#12288;
						<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag}">
						<font class="countEditFlag">
						<a href="javascript:editRotationDept('','${rotationGroup.groupFlow}')" style="color: blue;cursor: pointer;">编辑</a>
						&nbsp;|&nbsp;
						<a href="javascript:delRotationDept('','${rotationGroup.groupFlow}','${rotationGroup.rotationFlow}')" style="color: blue;cursor: pointer;">删除</a>
						</font>
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
						<th width="20%">轮转科室</th>
					</c:if>
					<th width="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag?'55':'40'}%">轮转时间(${applicationScope[unitKey].name})</th>
					<th width="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag?'20':'15'}%">操作</th>
				</tr>
				<c:forEach items="${standardGroupDeptMap[rotationGroup.groupFlow]}" var="rotationDept">
				<tbody standardId="${rotationDept.standardDeptId}" maxsel="${deptRelMap[rotationDept.standardDeptId].size()}" class="${localGroupMap[rotationGroup.groupFlow].groupFlow}${rotationDept.standardDeptId} mainBody">
					<tr class="head">
						<td rowspan="100">
							<table style="width: 100%;" class="none">
							<tr>
							<td width="100px;" style="text-align: center;">
							${rotationDept.standardDeptName}
							</td>
							<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag)}">
								<td width="5px;" >|</td>
								<td style="text-align: left">
									轮转时间：
<!-- 								| -->
									<c:out value="${rotationDept.firstYear}" default="0"/>
									<c:set var="sf" value="${sf+rotationDept.firstYear}"/>
									<script>
									$(function(){
										$(".${localGroupMap[rotationGroup.groupFlow].groupFlow}${rotationDept.standardDeptId}").data("data",{
											firstYear:<c:out value="${rotationDept.firstYear}" default="0"/>,
											secondYear:<c:out value="${rotationDept.secondYear}" default="0"/>,
											thirdYear:<c:out value="${rotationDept.thirdYear}" default="0"/>,
											deptNum:<c:out value="${rotationGroup.deptNum}" default="0"/>,
											maxDeptNum:<c:out value="${rotationGroup.maxDeptNum}" default="0"/>,
											groupFlow:"${localGroupMap[rotationGroup.groupFlow].groupFlow}"
										});
									});
									</script>
									<c:if test="${rotation.rotationYear >= 2}">
										+
										<c:out value="${rotationDept.secondYear}" default="0"/>
										<c:set var="ss" value="${ss+rotationDept.secondYear}"/>
									</c:if>
									<c:if test="${rotation.rotationYear == 3}">
										+
										<c:out value="${rotationDept.thirdYear}" default="0"/>
										<c:set var="st" value="${st+rotationDept.thirdYear}"/>
									</c:if>
									<div style="color: #3d91d5;font-size: 8px;" onclick="relCfg('${localGroupMap[rotationGroup.groupFlow].groupFlow}${rotationDept.standardDeptId}');">
									关联科室：
									<font class="relRoom ${rotationDept.standardDeptId}" title="配置关联科室" style="cursor: pointer;">
									<c:forEach items="${deptRelMap[rotationDept.standardDeptId]}" var="relMap" varStatus="status">
										<c:if test="${!status.first}">
											,
										</c:if>
										${relMap.value.schDeptName}
									</c:forEach>
									<c:if test="${empty deptRelMap[rotationDept.standardDeptId]}">未关联</c:if>
									</font>
									</div>
									<div relNum="${deptRelMap[rotationDept.standardDeptId].size()}" class="relOption" style="display: none;height: 0px;overflow: visible;width: 0px;"></div>
								</td>
							</c:if>
								</tr>
							</table>
							</td>
						</tr>
						
						<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag}">
							<tr>
								<td>
									<c:out value="${rotationDept.firstYear}" default="0"/>
									<c:set var="sf" value="${sf+rotationDept.firstYear}"/>
									<c:if test="${rotation.rotationYear >= 2}">
										+
										<c:out value="${rotationDept.secondYear}" default="0"/>
										<c:set var="ss" value="${ss+rotationDept.secondYear}"/>
									</c:if>
									<c:if test="${rotation.rotationYear == 3}">
										+
										<c:out value="${rotationDept.thirdYear}" default="0"/>
										<c:set var="st" value="${st+rotationDept.thirdYear}"/>
									</c:if>
								</td>
								<td>
									<font class="countEditFlag">
									<a onclick="delRotationDept('${rotationDept.recordFlow}','','${rotationDept.rotationFlow}')" style="color: blue;cursor: pointer;">删除</a>
									&nbsp;|&nbsp;
									</font>
									<a onclick="rotationRequire('${rotationDept.recordFlow}');" style="color: blue;cursor: pointer;">轮转要求</a>
									&nbsp;|&nbsp;
									<a onclick="rotationStandard('${rotationDept.recordFlow}');" style="color: blue;cursor: pointer;">轮转规范</a>
								</td>
							</tr>
						</c:if>
						
					<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag)}">
					<c:set var="localKey" value="${localGroupMap[rotationGroup.groupFlow].groupFlow}${rotationDept.standardDeptId}"/>
					<c:forEach items="${localRotationDeptListMap[localKey]}" var="groupDept" varStatus="statusFlag">
						<tr class="body" style="min-height: 30px;">
							<input class="record" type="hidden" value="${groupDept.recordFlow}"/>
							<td>
								<span style="float: left;margin-left: 10px;">
									<img title="上移" src="<s:url value='/css/skin/${skinPath}/images/up.png'/>" onclick="moveDept('up','${localGroupMap[rotationGroup.groupFlow].groupFlow}${rotationDept.standardDeptId}',this);" style="cursor: pointer;"/>
									<img title="下移" src="<s:url value='/css/skin/${skinPath}/images/down.png'/>" onclick="moveDept('down','${localGroupMap[rotationGroup.groupFlow].groupFlow}${rotationDept.standardDeptId}',this);" style="cursor: pointer;"/>
								</span>
								<font class="data">${groupDept.schDeptName}</font>
								<div class="data"  style="display: none;">
									<img title="移除" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="removeCfg('${localGroupMap[rotationGroup.groupFlow].groupFlow}${rotationDept.standardDeptId}',this);"  style="display: none;cursor: pointer;margin-right: 10px;" class="data"/>
									<select class="schDeptFlow" style="width: 100px;" onchange="checkResel('${localGroupMap[rotationGroup.groupFlow].groupFlow}${rotationDept.standardDeptId}',this);">
									<option>
									<c:forEach items="${deptRelMap[rotationDept.standardDeptId]}" var="relMap">
										<option value="${relMap.value.schDeptFlow}" 
										<c:if test="${groupDept.schDeptFlow eq relMap.value.schDeptFlow}">selected</c:if>
										>${relMap.value.schDeptName}</option>
									</c:forEach>
									</select>
								</div>
							</td>
							<td>
							<font class="firstYear data">
								<c:out value="${groupDept.firstYear}" default="0"/>
								<c:set var="lf" value="${lf+groupDept.firstYear}"/>
							</font>
							<input type="text" value="${groupDept.firstYear}" class="firstYear data"  style="display: none;width: 20px;"/>
							
							<c:if test="${rotation.rotationYear >= 2}">
								+
							<font class="secondYear data">
								<c:out value="${groupDept.secondYear}" default="0"/>
								<c:set var="ls" value="${ls+groupDept.secondYear}"/>
							</font>
							<input type="text" value="${groupDept.secondYear}" class="secondYear data"  style="display: none;width: 20px;"/>
							</c:if>
							
							<c:if test="${rotation.rotationYear == 3}">
								+
							<font class="thirdYear data">
								<c:out value="${groupDept.thirdYear}" default="0"/>
								<c:set var="ltc" value="${ltc+groupDept.thirdYear}"/>
							</font>
							<input type="text" value="${groupDept.thirdYear}" class="thirdYear data"  style="display: none;width: 20px;"/>
							</c:if>
							</td>
							<td rowspan="100" <c:if test="${!statusFlag.first}">style="display: none;"</c:if>>
								<div class="data">
									<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag)}">
										<a style="cursor: pointer;color: blue;" onclick="ruleCfg('${localGroupMap[rotationGroup.groupFlow].groupFlow}${rotationDept.standardDeptId}');">调整</a>
										&nbsp;|&nbsp;
									</c:if>
									<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag}">
									<a onclick="rotationRequire('${groupDept.recordFlow}');" style="color: blue;cursor: pointer;">轮转要求</a>
									&nbsp;|&nbsp;
									</c:if>
									<a onclick="rotationStandard('${rotationDept.recordFlow}');" style="color: blue;cursor: pointer;">轮转规范</a>
								</div>
								<div class="data" style="display: none;">
									<a style="cursor: pointer;color: blue;" onclick="addSchDept(this);">添加</a>
<!-- 									&nbsp;|&nbsp; -->
<%-- 									<a style="cursor: pointer;color: blue;" onclick="removeCfg('${localGroupMap[rotationGroup.groupFlow].groupFlow}${rotationDept.standardDeptId}',this);">移除</a> --%>
									&nbsp;|&nbsp;
									<a style="cursor: pointer;color: blue;" onclick="saveCfg('${localGroupMap[rotationGroup.groupFlow].groupFlow}${rotationDept.standardDeptId}','${rotationDept.standardDeptId}','${localGroupMap[rotationGroup.groupFlow].groupFlow}');">确认</a>
									&nbsp;|&nbsp;
									<a style="cursor: pointer;color: blue;" onclick="cancelCfg('${localGroupMap[rotationGroup.groupFlow].groupFlow}${rotationDept.standardDeptId}');">取消</a>
								</div>              
							</td>                   
						</tr>                       
					</c:forEach> 
					</c:if>                   
				</tbody>                            
				</c:forEach>                        
				<tr>                                
					<th>备注</th>                   
					<td colspan="4" style="padding-left: 10px;text-align: left;">
						${rotationGroup.groupNote}
					</td>
				</tr>   
				<tr>
					<th>合计</th>
					<td colspan="4" style="text-align: left;padding-left: 10px;">
						轮转时间(标准)：
						${sf}
						<c:if test="${rotation.rotationYear >= 2}">
							+
							${ss}
						</c:if>
						<c:if test="${rotation.rotationYear >= 3}">
							+
							${st}
						</c:if>
						&#12288;
						合：${sf+ss+st}
						&#12288;&#12288;&#12288;
						<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag)}">
							轮转时间：
							${lf}
							<c:if test="${rotation.rotationYear >= 2}">
								+
								${ls}
							</c:if>
							<c:if test="${rotation.rotationYear >= 3}">
								+
								${ltc}
							</c:if>
							&#12288;
							合：${lf+ls+ltc}
						</c:if>
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