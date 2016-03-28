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
	<jsp:param name="jquery_ui_sortable" value="true"/>
</jsp:include>

<style type="text/css">
	caption{line-height:40px;text-align:left;font-weight:bold; padding-left:10px; border-bottom:1px solid #ddd;color:#f60;margin-bottom: 10px;}
	.processFlag{width: 50px;float: left;height: 100%;}
	.processDept{width: 120px;padding-left: 10px;}
	.processDept .dept{font-size: 15px;color:#3d91d5;margin: 5px 0px;}
	.processDept .schScore{color:#5A5A5A;margin: 10px 0px 5px 0px;;}
	.headNmae{width: 170px;color: #A3A3A3;margin-top: 5px;line-height: 25px;}
</style>
<c:set value="schUnitEnum${sysCfgMap['res_rotation_unit']}" var="unitKey"/>
<script type="text/javascript">
	//选科数据
	var selDeptFlows = {};
	
	//页面初始化
	$(function(){
		//步骤信息操作
// 		blink($("#titleTd"),2,200,{
// 			backgroundColor:"pink",
// 			boxShadow:"0 0 10px red"
// 		},{
// 			backgroundColor:"white",
// 			boxShadow:"none"
// 		});
// 		$("#titleTd").on("click",function(){
// 			$("#rostingStep").toggle(80);
// 			$("#titleTd").toggleClass("up1").toggleClass("down1");
// 		});
		
		//检测日期顺序是否合法
		globalCheck();

		//阻止事件冒泡
		$("[onclick]").click(function(e){
			e.stopPropagation();
		});
		
		//排班拖动排序
		<c:if test="${empty doctor.schStatusId}">
			<c:if test="${rotation.isCrisscrossFlag eq GlobalConstant.FLAG_Y}">
				var oldData = "";
			    $("#sortResult").sortable({
			    	helper: function(e, ui) {
				   	    ui.children().each(function() {
					        $(this).width($(this).width());
				     	});
					    return ui;
					},  
			    	create: function(e,ui){
			    		var oldSortedIds = $("#sortResult").sortable("toArray");
			    		$.each(oldSortedIds,function(i,sortedId){
			    			oldData = oldData+"&recordFlow="+sortedId;
			    		});
			    	},
			    	start:function(e,ui){
			    	    ui.helper.css({"backgroundColor":"rgba(225, 238, 245,0.95)"});
			    	    return ui;
			    	}, 
			    	stop: function(event,ui) {
			    		ui.item.css({"backgroundColor":"#fff"});
			    		var sortedIds = $( "#sortResult" ).sortable("toArray");
			    		var postdata = "";
			    		$.each(sortedIds,function(i,sortedId){
			    			postdata = postdata+"&resultFlow="+sortedId;
			    		});
			    		if(oldData==postdata){
			    			return;
			    		}
			    		autoCount(postdata+"&resultNum=${resultList.size()}",true);
			    		globalCheck();
			    		oldData = postdata;
			    	}
			    });
		    </c:if>
		    
		    <c:if test="${!(rotation.isCrisscrossFlag eq GlobalConstant.FLAG_Y)}">
				$("#containerFree").append($(".sort"));
				var oldDataFree = "";
			    $("#containerFree").sortable({
			    	helper: function(e, ui) {
				   	    ui.children().each(function() {
					        $(this).width($(this).width());
				     	});
					    return ui;
					},  
			    	create: function(e,ui){
			    		var oldSortedIds = $("#containerFree").sortable("toArray");
			    		$.each(oldSortedIds,function(i,sortedId){
			    			oldDataFree = oldDataFree+"&recordFlow="+sortedId;
			    		});
			    	},
			    	start:function(e,ui){
			    	    ui.helper.css({"backgroundColor":"rgba(225, 238, 245,0.95)"});
			    	    return ui;
			    	}, 
			    	stop: function(event,ui) {
			    		ui.item.css({"backgroundColor":"#fff"});
			    		var sortedIds = $( "#containerFree" ).sortable("toArray");
			    		var postdata = "";
			    		$.each(sortedIds,function(i,sortedId){
			    			postdata = postdata+"&resultFlow="+sortedId;
			    		});
			    		if(oldDataFree==postdata){
			    			return;
			    		}
			    		autoCount(postdata+"&resultNum=${resultList.size()}",true);
			    		oldDataFree = postdata;
			    	}
			    });
		    	
				<c:forEach items="${schStageEnumList}" var="stage">
					$("#container${stage.id}").append($(".sort${stage.id}"));
					
					var oldData${stage.id} = "";
				    $("#container${stage.id}").sortable({
				    	helper: function(e, ui) {
					   	    ui.children().each(function() {
						        $(this).width($(this).width());
					     	});
						    return ui;
						},  
				    	create: function(e,ui){
				    		var oldSortedIds = $("#container${stage.id}").sortable("toArray");
				    		$.each(oldSortedIds,function(i,sortedId){
				    			oldData${stage.id} = oldData${stage.id}+"&recordFlow="+sortedId;
				    		});
				    	},
				    	start:function(e,ui){
				    	    ui.helper.css({"backgroundColor":"rgba(225, 238, 245,0.95)"});
				    	    return ui;
				    	}, 
				    	stop: function(event,ui) {
				    		ui.item.css({"backgroundColor":"#fff"});
				    		var sortedIds = $( "#container${stage.id}" ).sortable("toArray");
				    		var postdata = "";
				    		$.each(sortedIds,function(i,sortedId){
				    			postdata = postdata+"&resultFlow="+sortedId;
				    		});
				    		if(oldData${stage.id}==postdata){
				    			return;
				    		}
				    		autoCount(postdata+"&resultNum=${resultList.size()}",true);
				    		oldData${stage.id} = postdata;
				    	}
				    });
				</c:forEach>
			</c:if>
	    </c:if>
	    
	    //第3步骤判断
	    <c:if test="${!empty resultList}">
	    if(!checkRostingFinish()){
	    	$(".tips_body p:eq(2)").css("color","red");
	    }else{
	    	<c:if test="${empty doctor.schStatusId}">
	    	$(".tips_body p:eq(3)").css("color","red");
	    	</c:if>
	    }
	    </c:if>
	    
	    //将不可移动的放进新容器中
	    $("#cannotMove").append($(".noMoveItem"));
	});
	
	//闪烁
	function blink(obj,count,speed,start,end){
		if(count){
			setTimeout(function(){
				obj.css(start);
				setTimeout(function(){
					obj.css(end);
					blink(obj,--count,speed,start,end);
				},speed);
			},speed);
		};
	}
	
	//轮转方案说明
	function openDetail(rotationName, rotationFlow){
		var url = "<s:url value='/sch/template/editRotation'/>?roleFlag=${param.roleFlag}&viewFlag=${GlobalConstant.FLAG_Y}&rotationFlow="+rotationFlow;
		jboxOpen(url, rotationName, 800, 500);
	}
	
	//选中科室
	function selDept(dept,recordFlow,groupFlow,selMax,selTypeId,maxDeptNum){
		selMax = parseInt(selMax);
		if(selTypeId=="${schSelTypeEnumFree.id}"){
			maxDeptNum = parseInt(maxDeptNum);
		}
		selDeptFlows[groupFlow] = selDeptFlows[groupFlow] || [];
		
		var index = selDeptFlows[groupFlow].indexOf(recordFlow);
		if(index!=-1){
			selDeptFlows[groupFlow].splice(index,1);
			$(dept).removeClass("selChoose");
		}else{
			var selCount = selDeptFlows[groupFlow].length;
			var isSelMaxFlag = selCount==selMax;
			if(selTypeId=="${schSelTypeEnumFree.id}"){
				isSelMaxFlag = selCount==maxDeptNum;
			}
			if(isSelMaxFlag){
				return jboxTip("该组合不能选择更多科室！");
			}
			
			selDeptFlows[groupFlow].push(recordFlow);
			$(dept).addClass("selChoose");
		};
	}
	
	function selDeptSumCheck(){
		//判断轮转时间和
		var haveEmpty = true;
		$(".group").each(function(){
			var monthCount = 0;
			var noEmpty = true;
			var schMonth = parseFloat($(this).attr("schMonth")) || 0;
			var title = $("legend font",this).text();
			$(".selChoose .selDiyMonth",this).each(function(){
				var sm = parseFloat(this.value) || 0;
				if(sm){
					monthCount+=(sm);
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
	
	//确认选科
	function confirmDept(){
		if(!selDeptSumCheck()){return false;};
		var isOk = false;
		$(".group").each(function(){
			var deptNum = parseInt($(this).attr("deptNum"));
			var checkNum = $(this).find(".selChoose").length;
			if("${schSelTypeEnumFree.id}" == $(this).attr("selTypeId")){
				var maxDeptNum = parseInt($(this).attr("maxDeptNum"));
				if(!(isOk = (deptNum<=checkNum && maxDeptNum>=checkNum)))
					return isOk;
			}else{
				if(!(isOk = (deptNum==checkNum))) 
					return isOk;
			}
		});
		if(isOk){
			jboxConfirm("确认完成选科并且开始排班填报？",function(){
				var recordFlowList = [];
				var schMonthList = [];
				for(var key in selDeptFlows){
					var deptFlows = selDeptFlows[key];
					recordFlowList.push(deptFlows);
					for(var index in deptFlows){
						schMonthList.push($("#schMonth"+deptFlows[index]).val());
					}
				}
				jboxPost("<s:url value='/res/doc/saveSelDept'/>",
					{recordFlows:recordFlowList.toString(),schMonths:schMonthList.toString()},
					function(resp){
						if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
							top.jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
							location.href = "<s:url value='/res/doc/doctorMain'/>";
// 							location.reload(true);
						}
					},
				null,false);
			},null);
		}else{
			jboxTip("请完成所有选科！");
		}
	}
	
	//产生排班数据
	function rostingHandConfirm(){
		<c:if test="${empty doctorDeptMap}">
			jboxTip("请先完成选科！");
			return;
		</c:if>
		jboxConfirm("确认开始排班填报？",function(){
			jboxGet("<s:url value='/res/doc/createRosting'/>",null,function(resp){
				if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
					top.jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					location.reload(true);
				}
			},null,false);
		},null);
	}
	
	//自动计算日期
	function autoCount(postdata,sort,clear){
// 		if(!postdata){
			postdata = "";
			$(".result").each(function(){
				if(this.id){
					postdata+=("&resultFlow="+(this.id));
				}
			});
// 		}
		if(!sort){
			if(!$("#startDate").val())return jboxTip("请选择日期！");
			postdata+=("&startDate="+$("#startDate").val());
		}
		if(clear){
			postdata+="&clear=true";
		}
		var url = "<s:url value='/res/doc/sortAndCalculate'/>";
		jboxPost(url, postdata+"&resultNum=${resultList.size()}", function(){
			top.jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
			if(!sort || clear){
				location.href = "<s:url value='/res/doc/selDeptAndRosteringHand'/>?startDate="+$("#startDate").val();
			}
		},null,false);
	}
	
	//清空排班
	function clearRosting(){
		jboxConfirm("确认清空所有排班?",function(){
			autoCount(null,true,true);
		},null);
	}
	
	//自定义时间
	function diyDate(dateInput,data){
		var start = $("."+data.resultFlow+".start").val();
		var end = $("."+data.resultFlow+".end").val();
		if(start && end && (start>=end)){
			jboxTip("结束时间必须大于开始时间！");
			dateInput.value=$(dateInput).attr("old");
			return;
		}
		
		globalCheck();
		
		var url = "<s:url value='/res/doc/saveDiyDate'/>";
		jboxPost(url,data, function(resp){
			if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
				$(dateInput).attr("old",dateInput.value);
				if(!checkRostingFinish()){
			    	$(".tips_body p:eq(1)").css("color","red");
			    	$(".tips_body p:eq(2)").css("color","");
			    }else{
			    	<c:if test="${empty doctor.schStatusId}">
			    	$(".tips_body p:eq(1)").css("color","");
			    	$(".tips_body p:eq(2)").css("color","red");
			    	</c:if>
			    }
			}
		},null,false);
	}
	
	//计算不合法日期
	function countDisableDate(id){
		var currResult = $("#"+id);
		var index = $(".result").index(currResult);
		var startDate = currResult.find(".start").val();
		var endDate = currResult.find(".end").val();
		if(startDate && endDate){
			$(".result:lt("+index+")").each(function(){
				var start = $(this).find(".start").val();
				var end = $(this).find(".end").val();
				if(start && end){
					if(start>=startDate || end>=endDate || start>=endDate || end>=startDate){
						currResult.css({"backgroundColor":"rgba(255, 246, 235)"});
						return false;
					}
				}
			});
		}
	}
	
	//全局检测不合法日期
	function globalCheck(){
		$(".result").css({"backgroundColor":"#fff"}).each(function(){
			countDisableDate(this.id);
		});
	}
	
	//判断是否排班全部完成
	function checkRostingFinish(){
		var isFinish = true;
		$(".start,.end").each(function(){
			if(!this.value){
				return isFinish=false;
			}
		});
		return isFinish;
	}
	
	//确认排班
	function confirmRosting(){
		if(!checkRostingFinish())return jboxTip("请先完成排班！");
		
		<c:if test="${!empty rotationGroupList}">
			//选科排班的总时间判断
// 			var groups = [
// 			      <c:forEach items="${rotationGroupList}" var="group">
// 			      		{"groupFlow":"${group.groupFlow}","schMonth":${group.schMonth}},
// 			      </c:forEach>
// 			                  ];
// 			if(!checkSelDeptMonth(groups)){
// 				return jboxTip("请先完成选科时间调整！");
// 			}
		</c:if>
		
		jboxConfirm("确认提交排班？确认后将不能修改！",function(){
			jboxPost("<s:url value='/res/doc/confirmRosting'/>",{
				doctorFlow:"${doctor.doctorFlow}",
				schStatusId:"${schStatusEnumSubmit.id}",
				schStatusName:"${schStatusEnumSubmit.name}"
			},function(resp){
				if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
					top.jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					location.reload(true);
				}
			},null,false);
		},null);
	}
	
	//自由选科页面
	function editResult(){
		var content = $("#selSchDeptHome").html();
		jboxOpenContent(content,"选择要轮转的科室",800,500);
	}
	
	//保存自由选科计划
	function saveSelResult(selResultTd){
		var addResult = [];
		var delResult = [];
		selResultTd.find(":checkbox:checked:not([isResult])").each(function(){
			addResult.push(this.value);
		});
		selResultTd.find(":checkbox[isResult]:not(:checked)").each(function(){
			delResult.push($(this).attr("isResult"));
		});
		
		var data = "";
		if(addResult.length>0){
			data += "&";
			data+=serializeList("addSchDeptFlows",addResult);
		}
		if(delResult.length>0){
			data+=("&"+serializeList("delResultFlows",delResult));
		}
		jboxPost("<s:url value='/sch/template/saveFreeRostering'/>?doctorFlow=${doctor.doctorFlow}"+data,null,function(resp){
			if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
				top.jboxContentClose();
				location.reload();
			}
		},null,false);
	}
	
	//序列化数组
	function serializeList(name,list){
		var result = "";
		for(var index in list){
			if(result){
				result+=("&"+name+"="+list[index]);
			}else{
				result+=(name+"="+list[index]);
			}
		}
		return result;
	}
	
	//保存轮转时间
	function saveSchMonth(resultFlow,schMonth,groupFlow,groupMonth,groupName){
		if(isNaN(schMonth) || schMonth==""){
			return jboxTip("请输入数字！");
		}
		
// 		if(groupFlow){
// 			var countMonth = 0;
// 			$("."+groupFlow).each(function(){
// 				countMonth+=(parseFloat(this.value));
// 			});
// 			if(countMonth>groupMonth){
// 				jboxInfo(groupName+"组合的总轮转时间必须等于"+groupMonth+"${applicationScope[unitKey].name}");
// 			}
// 		}
		
		var data = {};
		data.resultFlow = resultFlow;
		schMonth = parseFloat(schMonth);
		
		if(schMonth>99 || schMonth<0.5){
			return jboxTip("请输入合法数字(0.5~99)！");
		}
		
		data.schMonth = schMonth;
		var url = "<s:url value='/res/doc/saveDiyDate'/>";
		jboxPost(url,data,function(resp){
			if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
// 				$("#"+resultFlow).attr("schMonth",schMonth);
// 				jboxTip("");
			}
		},null,false);
	}
	
	//检查选科总时间
	function checkSelDeptMonth(groups){
		var isOk = true;
		for(var index in groups){
			var groupFlow = groups[index].groupFlow;
			var groupMonth = groups[index].schMonth;
			var countMonth = 0;
			$("."+groupFlow).each(function(){
				countMonth+=(parseFloat(this.value));
			});
			if(countMonth!=groupMonth){
				return isOk = false;
			}
		}
		return isOk;
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
		if(!checkTime(schMonth)){
			return jboxTip("请输入数字且大于0.5！");
		}
	}
</script>
</head>

<body>
	<div class="mainright">
	    <div class="tips">
		    <h1 class="tips_title">排班操作：</h1>
			<div class="tips_body" style="padding: 10px 10px 0;">
				<c:if test="${!relFlag}">
				<c:if test="${!empty doctor.rotationFlow}">
					<p style="
					<c:if test="${empty doctorDeptMap && empty resultList}">
					color:red;
					</c:if>
					<c:if test="${!(GlobalConstant.FLAG_Y eq sysCfgMap['res_doc_seldept'])}">
					display:none;
					</c:if>
					">
					<font style="font-weight: bolder;">· </font>
					选择轮转科室并
					<c:if test="${empty resultList}">
					<a style="color:blue;cursor: pointer;" onclick="confirmDept();">确认完成</a>
					</c:if>
					<c:if test="${!(empty resultList)}">
					确认完成
					</c:if>。
					</p>
				</c:if>
				<c:if test="${GlobalConstant.FLAG_Y eq sysCfgMap['res_doc_rostering']}">
					<p style="<c:if test="false">color:red;</c:if>"><font style="font-weight: bolder;">· </font>请自主
						<c:if test="${!(empty doctor.schStatusId && GlobalConstant.FLAG_Y eq doctor.selDeptFlag)}">
							选择
						</c:if>
						<c:if test="${empty doctor.schStatusId && GlobalConstant.FLAG_Y eq doctor.selDeptFlag}">
							<a style="color:blue;cursor: pointer;" onclick="editResult();">选择</a>
						</c:if>
					轮转科室。</p>
					<p><font style="font-weight: bolder;">· </font>为轮转科室排序并制定轮转计划。</p>
					<p><font style="font-weight: bolder;">· </font><c:if test="${empty doctor.schStatusId && !empty resultList}"><a onclick="confirmRosting();">提交</a></c:if><c:if test="${!(empty doctor.schStatusId && !empty resultList)}">提交</c:if>排班计划。</p>
					<p style="<c:if test="${doctor.schStatusId eq schStatusEnumSubmit.id}">color:red;</c:if>"><font style="font-weight: bolder;">· </font>管理员审核中,审核通过后可继续轮转。</p>
					<p>Tip：黄色排班为日期错误的排班！</p>
				</c:if>
				</c:if>
			</div>
			<div class="tips_bottom_bg"></div>
		</div>
		<div class="content" style="padding-right:300px;">
			<div style="width: 100%;height: 40px;">
				<table class="basic" style="width: 100%;margin-top: 10px;margin-bottom: 10px;background-color: white;position: relative;">
					<tr>
						<td id="titleTd" style="cursor: pointer;">
							医师姓名：<font style="font-weight: bold;">${doctor.doctorName}</font>
							&#12288;&#12288;&#12288;&#12288;
							轮转方案：<font title="点击查看方案说明" style="font-weight: bold;color:#3d91d5;"  onclick="openDetail('${doctor.rotationName}','${doctor.rotationFlow}');">${doctor.rotationName}</font>
							&#12288;&#12288;&#12288;&#12288;
							轮转年限：<font style="font-weight: bold;"><c:out value="${rotation.rotationYear}" default="无"/></font>
						</td>
					</tr>
				</table>
			</div>
			
			<c:if test="${relFlag}">
				<table class="basic" style="width: 100%;margin-top: 10px;">
					<tr>
						<td style="padding: 0px;text-align: center;">请等待管理员完成<font color="blue">${rotation.rotationName}</font>方案调整！</td>
					</tr>
				</table>
			</c:if>
			
			<c:if test="${!relFlag}">
			<c:if test="${empty resultList && !empty doctor.rotationFlow}">
			<div id="selDept">
				<script type="text/javascript">
					$(function(){
						<c:forEach items="${schStageEnumList}" var="stage">
							$("#${stage.id}").append($(".sort${stage.id}"));
						</c:forEach>
					});
				</script>
				<table width="100%">
					<caption>
						轮转科室选择
					</caption>
				</table>
				<div class="groupHome">
					<c:set value="0" var="groupCount"/>
					<c:forEach items="${rotationGroupList}" var="group">
						<c:set value="${groupCount+group.deptNum}" var="groupCount"/>
						<fieldset class="sort${group.schStageId} group ${group.groupFlow}" deptNum="${group.deptNum}" selTypeId="${group.selTypeId}" maxDeptNum="${group.maxDeptNum}" schMonth="${group.schMonth}">
							<legend class="groupName">
							<c:if test="${rotation.isStage eq GlobalConstant.FLAG_Y}">
								${group.schStageName}：
							</c:if>
							<font>${group.groupName}</font>
<!-- 								&#12288; -->
<%-- 								(选科数：${group.deptNum}<c:if test="${schSelTypeEnumFree.id eq group.selTypeId}">~${group.maxDeptNum}</c:if>&#12288;轮转时间：${group.schMonth}) --%>
<!-- 								&#12288; -->
<%-- 								<a style="color: blue;cursor: pointer;" onclick="resetTime('${group.groupFlow}');">还原时间</a> --%>
							</legend>
							<c:forEach items="${rotationDeptMap[group.groupFlow]}" var="dept">
								<c:set value="${group.groupFlow}${dept.schDeptFlow}" var="doctorDeptKey"/>
								<div <c:if test="${empty doctorDeptMap}">title="选科/取消"</c:if> class="rotationChoose ${!empty doctorDeptMap[doctorDeptKey]?'selChoose':''}" 
<%-- 									<c:if test="${empty doctorDeptMap}"> --%>
										onclick="selDept(this,'${dept.recordFlow}','${group.groupFlow}','${group.deptNum}','${group.selTypeId}','${group.maxDeptNum}');"
<%-- 									</c:if> --%>
									schMonth="${dept.schMonth+0}"
								>
									<div class="chooseStandard">
									    标准科室：${dept.standardDeptName}
									</div>
									<div class="chooseName">${dept.schDeptName}</div>
									<div class="chooseMonth" onclick="window.event.stopPropagation();$('.selDiyMonth',this).focus();">
										<input id="schMonth${dept.recordFlow}" type="text" value="${dept.schMonth}" class="inputText selDiyMonth" schMonth="${dept.schMonth}" style="width: 20px;" onchange="saveDiySelTime(this.value);"/>
										${applicationScope[unitKey].name}
									</div>
								</div>
							</c:forEach>
							
							<div style="width: 97.5%;float: left;border: 1px solid #ccc;margin-top: 10px;height: 30px;">
								<p style="padding-left: 10px;margin-top: 5px;">
									<span style="font-weight: bold;">选科条件：</span>
									轮转时间：${group.schMonth}${applicationScope[unitKey].name}
									&#12288;
									选科数：${group.deptNum}<c:if test="${schSelTypeEnumFree.id eq group.selTypeId}">~${group.maxDeptNum}</c:if>
								</p>
							</div>
							<div style="width: 97.5%;float: left;border: 1px solid #ccc;margin-top: 10px;height: 30px;">
								<p style="padding-left: 10px;margin-top: 5px;">
									<span style="font-weight: bold;">备注：</span>
									${group.groupNote}
									<a style="color: blue;cursor: pointer;float: right;margin-right: 10px;" onclick="resetTime('${group.groupFlow}');">还原时间</a>
								</p>
							</div>
						</fieldset>
					</c:forEach>
					
					<c:if test="${empty rotationGroupList}">
						<table class="basic" style="width:100%;margin-top: 10px;margin-bottom: 10px;">
							<tr>
								<td style="text-align: center;">没有组合科室可选！</td>
							</tr>
						</table>
					</c:if>
					
					<input type="hidden" id="deptNumSum" value="${groupCount}"/>
					
<!-- 					<div class="confirm"> -->
<!-- 						<input type="button" value="完成选科" onclick="confirmDept();" class="search"> -->
<!-- 						<input type="button" value="排班填报" onclick="rostingHandConfirm();" class="search"> -->
<!-- 					</div> -->
					<c:forEach items="${schStageEnumList}" var="stage">
						<div id="${stage.id}">
						</div>
					</c:forEach>
				</div>
			</div>
			</c:if>
			
			<c:if test="${!empty resultList || empty doctor.rotationFlow}">
			<div id="rostingHand" style="margin-bottom: 20px;">
				<table width="100%">
					<caption>
						轮转计划
						<c:if test="${empty doctor.schStatusId}">
							<font style="float: right;margin-right: 10px;">
								请选择开始日期：
								<input class="date editDate" id="startDate" type="text" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="${param.startDate}" style="height: 27px;">
								&#12288;
								<input type="button" value="自动排班" class="search" onclick="autoCount();"/>
								<input type="button" value="清空排班" class="search" onclick="clearRosting();"/>
							</font>
						</c:if>
					</caption>
				</table>
				<div class="resultHome" id="cannotMove">
					
				</div>
				<div class="resultHome" id="sortResult">
					<c:forEach items="${resultList}" var="result">
						<c:if test="${!(processMap[result.resultFlow].schFlag eq GlobalConstant.FLAG_Y)}">
						<div id="${result.resultFlow}" class="result ${!empty result.isRequired?(GlobalConstant.FLAG_Y eq result.isRequired?'bl':'xk'):''} sort${stageGroupMap[result.groupFlow].schStageId}" style="<c:if test="${empty doctor.schStatusId}">cursor: move;</c:if>">
							<div class="resultDept">
								${result.schDeptName}
								<c:if test="${rotation.isStage eq GlobalConstant.FLAG_Y}">
									<p style="color: #aaa;font-size: 10px;">${stageGroupMap[result.groupFlow].schStageName}</p>
								</c:if>
							</div>
							<div class="resultMonth" style="margin-top: 10px;">
								轮转时间：
<%-- 								<c:if test="${!((empty result.standardDeptId || !(GlobalConstant.FLAG_Y eq result.isRequired)) && !(GlobalConstant.FLAG_Y eq doctor.schFlag) && empty doctor.schStatusId)}"> --%>
<%-- 									${result.schMonth} --%>
<%-- 								</c:if> --%>
<%-- 								<c:if test="${(empty result.standardDeptId || !(GlobalConstant.FLAG_Y eq result.isRequired)) && !(GlobalConstant.FLAG_Y eq doctor.schFlag) && empty doctor.schStatusId}"> --%>
<%-- 									<input class="${result.groupFlow}" type="text" value="${result.schMonth}" style="width: 20px;" onchange="saveSchMonth('${result.resultFlow}',this.value,'${result.groupFlow}',${groupMap[result.groupFlow].schMonth+0},'${groupMap[result.groupFlow].groupName}');"/> --%>
<%-- 								</c:if> --%>
								<c:if test="${!(empty result.standardDeptId && !(GlobalConstant.FLAG_Y eq doctor.schFlag) && empty doctor.schStatusId)}">
									${result.schMonth}
								</c:if>
								<c:if test="${empty result.standardDeptId && !(GlobalConstant.FLAG_Y eq doctor.schFlag) && empty doctor.schStatusId}">
									<input class="${result.groupFlow}" type="text" value="${result.schMonth}" style="width: 20px;" onchange="saveSchMonth('${result.resultFlow}',this.value,'${result.groupFlow}',${groupMap[result.groupFlow].schMonth+0},'${groupMap[result.groupFlow].groupName}');"/>
								</c:if>
								${applicationScope[unitKey].name}
								<c:if test="${GlobalConstant.FLAG_N eq result.isRequired && !empty result.rotationFlow}">
									<div class="groupInfo" style="margin-top: 5px;color: #aaa;">
										(${groupMap[result.groupFlow].groupName}：${groupMap[result.groupFlow].schMonth}${applicationScope[unitKey].name})
									</div>
								</c:if>
							</div>
							<div class="planDate">
								<input old="${result.schStartDate}" class="${result.resultFlow} start date <c:if test="${empty doctor.schStatusId}">editDate</c:if>" type="text" value="${result.schStartDate}" readonly="readonly" 
									<c:if test="${empty doctor.schStatusId}">
										onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" onchange="diyDate(this,{resultFlow:'${result.resultFlow}',schStartDate:this.value});"
									</c:if>
								>
								~
								<input old="${result.schEndDate}" class="${result.resultFlow} end date <c:if test="${empty doctor.schStatusId}">editDate</c:if>" type="text" value="${result.schEndDate}" readonly="readonly" 
									<c:if test="${empty doctor.schStatusId}">
										onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" onchange="diyDate(this,{resultFlow:'${result.resultFlow}',schEndDate:this.value});"
									</c:if>
								>
							</div>
						</div>
						</c:if>
						<c:if test="${processMap[result.resultFlow].schFlag eq GlobalConstant.FLAG_Y}">
							<div class="noMoveItem result ${GlobalConstant.FLAG_Y eq result.isRequired?'bl':'xk'}">
								<div class="resultDept">
									${result.schDeptName}
								</div>
								<div class="resultMonth">
									轮转时间：
									${result.schMonth}
									${applicationScope[unitKey].name}
								</div>
								<div class="planDate">
									${result.schStartDate}
									~
									${result.schEndDate}
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>
				
				<c:forEach items="${schStageEnumList}" var="stage">
					<div class="resultHome" id="container${stage.id}"></div>
				</c:forEach>
				
				<div class="resultHome" id="containerFree"></div>
				
			</div>
			</c:if>
			
			</c:if>
			
			<c:if test="${!empty resultList && false}">
			<script type="text/javascript" src="<s:url value='/js/echarts/echarts-all.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
			<script>
				function search(){
					$("#searchForm").submit();
				}
				function toDetail(resultFlow,rotationFlow,schDeptFlow){
					window.location.href="<s:url value='/res/doc/rotationDetail'/>?roleFlag=${GlobalConstant.RES_ROLE_SCOPE_DOCTOR}&resultFlow="+resultFlow+"&rotationFlow="+rotationFlow+"&schDeptFlow="+schDeptFlow;
				}
				function openChoose(resultFlow,preResultFlow,rotationFlow,schDeptFlow){
					var url="<s:url value='/res/doc/showChoose' />?resultFlow="+resultFlow+"&preResultFlow="+preResultFlow+"&rotationFlow="+rotationFlow+"&schDeptFlow="+schDeptFlow;
					var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='200' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
					jboxMessager(iframe, "选择科主任和带教老师", 400,200,null,true);
				}
				function showWarning(){
					jboxTip("请按轮转计划，顺序完成出科！");
				}
				
				function showCanvas(){
					 <c:forEach items="${resultList}" var="result">
						 <c:set value="${result.resultFlow}finish" var="finishKey"/>
						 <c:set value="${result.resultFlow}req" var="reqKey"/>
				     var myChart = echarts.init(document.getElementById('chart_${result.resultFlow}')); 
				     var labelTop = {
				     	    normal : {
				     	        label : {
				     	            show : true,
				     	            position : 'center',
				     	            formatter : '{b}',
				     	            textStyle: {
				     	                baseline : 'bottom'
				     	            }
				     	        },
				     	        labelLine : {
				     	            show : false
				     	        }
				     	    }
				     	};
				     	var labelFromatter = {
				     	    normal : {
				     	        label : {
				     	            formatter : function (a,b,c){return "${finishPerMap[result.resultFlow]+0}%"},
				     	            textStyle: {
				     	                baseline : 'center'
				     	            }
				     	        }
				     	    },
				     	}
				     	var labelBottom = {
				     	    normal : {
				     	        color: '#ccc',
				     	        label : {
				     	            show : true,
				     	            position : 'center'
				     	        },
				     	        labelLine : {
				     	            show : false
				     	        }
				     	    },
				     	    emphasis: {
				     	        color: 'rgba(0,0,0,0)'
				     	    }
				     	};
				     	var radius = [25, 28];
				     	option = {
				     	    series : [
				     	        {
				     	            type : 'pie',
				     	            radius : radius,
				     	            x: '0%', // for funnel
				     	            itemStyle : labelFromatter,
				     	            data : [
										{name:'other', value:${100-(finishPerMap[result.resultFlow]+0)},itemStyle : labelBottom},
										{name:'', value:${finishPerMap[result.resultFlow]+0}, itemStyle : labelTop},
				     	            ]
				     	        }
				     	    ]
				     	};

				     // 为echarts对象加载数据 
				     myChart.setOption(option); 
				  </c:forEach>
				}
				
				function scroll(){
					setTimeout(function(){
						$(".list li:first").animate({marginTop : "-25px"},500,function(){
							$(".list").append($(this).css({marginTop : "0px"}));
							scroll();
						});
					},3000);
				}
				$(function(){
					if($(".list li").length>1){
						scroll();
					}
				});
				
				$(function(){
					showCanvas();
					if($(".list li").length>1){
						scroll();
					}
				});
			</script>
			
			<div id="rostingHand">
				<table width="100%">
					<caption>
						轮转计划
					</caption>
				</table>
				<table class="basic" style="width: 100%;">
					<tr>
						<td width="150px"> 最新通知：</td>
						<td>
						 <div class="scroll">  
							<ul class="list">
								 <c:forEach items="${infos}" var="info">
								 	<li><a href="<s:url value='/res/platform/noticeView'/>?infoFlow=${info.infoFlow}" target="_blank">${info.infoTitle}</a> <img src="<s:url value='/jsp/hbres/images/new.png'/>"/></li>  
								 </c:forEach>
								 <c:if test="${empty infos}">
								 	<li>暂无通知!</li>
								 </c:if>
			               </ul> 
		               	</div> 
		               </td>
	               		<td width="150px">
						<span style="float: right;padding-right: 10px;"> 
							<a href="<s:url value='/res/doc/noticeList'/>?fromSch=true&isView=false&roleFlag=${GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">>>查看更多</a>
						</span>
					</td>
					</tr>
				</table>
				<div class="resultHome">
				<c:forEach items="${resultList}" var="result" varStatus="status">
					<c:choose>
						<c:when test="${empty processMap}">
							<c:choose>
								<c:when test="${status.first }">
									<c:set var="clickString" value="openChoose('${result.resultFlow }','','${result.rotationFlow}','${result.schDeptFlow}');"/>
								</c:when>
								<c:otherwise>
									<c:set var="clickString" value="showWarning();"/>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${!empty processMap[result.resultFlow] }"><c:set var="clickString" value="toDetail('${result.resultFlow }','${result.rotationFlow}','${result.schDeptFlow}');"/></c:when>
								<c:otherwise>
								    <c:choose>
										<c:when test="${processMap[resultList[status.index-1].resultFlow].schFlag eq GlobalConstant.FLAG_Y }">
											<c:set var="clickString" value="openChoose('${result.resultFlow }','${resultList[status.index-1].resultFlow}','${result.rotationFlow}');"/>
										</c:when>
										<c:otherwise>
											<c:set var="clickString" value="showWarning();"/>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					<c:set var="process" value="${processMap[result.resultFlow] }"/>
					<c:set var="startDate"  value="${result.schStartDate }"/>
					<c:set var="endDate"  value="${result.schEndDate }"/>
					<c:if test="${!empty process.startDate }">
						<c:set var="startDate"  value="${process.startDate }"/>
					</c:if>
					<c:if test="${!empty process.endDate }">
						<c:set var="endDate"  value="${process.endDate }"/>
					</c:if>
					
					<div class="result" style="cursor: pointer;" onclick="${clickString}">
						<div class="processFlag">
							<c:if test="${processMap[result.resultFlow].schFlag eq GlobalConstant.FLAG_Y}">
								<img src="<s:url value='/css/skin/${skinPath}/images/yck_1.png'/>">
							</c:if>
							<c:if test="${processMap[result.resultFlow].isCurrentFlag eq GlobalConstant.FLAG_Y}">
								<img alt="" src="<s:url value='/css/skin/${skinPath}/images/Rotary_1.png'/>">
							</c:if>
						</div>
						<div class="processDept">
							<p class="dept">${result.schDeptName}</p>
							<p class="schScore">出科成绩:<c:out value="${process.schScore}" default="暂无"/></p>
						</div>
						<div class="headNmae">
							<p>带教老师：<c:out value="${process.teacherUserName }" default="未选择"/></p>
							<p>科主任：<c:out value="${process.headUserName }" default="未选择"/></p>
						</div>
						<div id="chart_${result.resultFlow}" class="resultChart" style="width: 100px;height: 100%;"></div>
						<div class="planDate">
							<input class="start date" type="text" value="${result.schStartDate}" readonly="readonly">
							~
							<input class="end date" type="text" value="${result.schEndDate}" readonly="readonly">
						</div>
					</div>
					</c:forEach>
				</div>
			</div>
			</c:if>
		</div>
	</div>
	<div id="selSchDeptHome" style="display: none;">
		<table class="basic" style="width:100%;">
			<tr>
				<th style="text-align: left;padding-left: 10px;">
					选择要轮转的科室
<%-- 					<input id="doctorFlow" type="hidden" value="${doctor.doctorFlow}"/> --%>
				</th>
			</tr>
			<tr>
				<td id="selResultTd">
					<c:forEach items="${schDeptList}" var="schDept">
						<div style="float: left;width:23%;padding-left:10px;text-align: left;"><label><input type="checkbox" value="${schDept.schDeptFlow}" <c:if test="${!empty resultMap[schDept.schDeptFlow]}"> checked isResult="${resultMap[schDept.schDeptFlow].resultFlow}"</c:if> <c:if test="${!empty processMap[resultMap[schDept.schDeptFlow].resultFlow]}">disabled="disabled"</c:if>/>${schDept.schDeptName}</label></div>
					</c:forEach>
				</td>
			</tr>
		</table>
		<div align="center" style="margin: 10px 0px;">
			<input type="button" value="保&#12288;存" class="search" onclick="window.document.mainIframe.saveSelResult($('#selResultTd'));"/>
			<input type="button" value="关&#12288;闭" class="search" onclick="top.jboxContentClose();"/>
		</div>
	</div>
</body>
</html>