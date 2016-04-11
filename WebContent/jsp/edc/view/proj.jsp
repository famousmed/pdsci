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
<script type="text/javascript" src="<s:url value='/js/echarts/echarts-all.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<link rel="stylesheet" href="<s:url value='/jsp/edc/view/org_proj.css'/>?v=${applicationScope.sysCfgMap['sys_version']}" type="text/css">
<style>
	.e-list li .mark > i {
		background: url('<s:url value='/css/skin/${skinPath}/images/label.png' />') no-repeat;
		display: inline-block;
		width: 5px;
		height: 25px;
		vertical-align: middle;
		margin-top: 12px;
	}
</style>
<script type="text/javascript">
   $(document).ready(function(){
		showCanvas();
		//showCanvas2();
	});
   function showCanvas (){
	     var myChart = echarts.init(document.getElementById('chart')); 
	     var labelTop = {
	     	    normal : {
	     	        label : {
	     	            show : false,
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
	     	            formatter : function (a,b,c){return 100-c + '%'},
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
	     	
	     	var inValue = 0;
	     	var otherValue = 100;
	     	var inCount = 0;
	     	var patientCount = 0;
	     	if ("${scope == GlobalConstant.USER_LIST_LOCAL}"=="true") {
	     		inCount = "${implemenMap['inCount']+'0'}";
	     		patientCount = "${projOrg.patientCount+'0'}";
	     	} else {
	     		inCount = $("#totalInCount").val();
	     		patientCount = $("#totalPatientCount").val();
	     	}
	     	if (patientCount != 0) {
	     		inValue = (inCount/patientCount*100).toFixed();
		     	otherValue = 100-inValue;
	     	}
	     	var radius = [65, 75];
	     	option = {
	     		    legend: {
	     		        x : 'center',
	     		        y : 'bottom',
	     		        data:[
							'入组：'+inCount+'  \t\t承担： '+patientCount
	     		        ]
	     		    },
	     			 toolbox: {
	      		        show : true,
	      		        feature : {
	      		            restore : {show: true},
	      		            saveAsImage : {show: true}
	      		        }
	      		    },
	     	    series : [
	     	        {
	     	            type : 'pie',
	     	            radius : radius,
	     	            x: '0%', // for funnel
	     	            itemStyle : labelFromatter, 
	     	            data : [
							{name:'other', value:otherValue, itemStyle : labelBottom},
							{name:'入组：'+inCount+'  \t\t承担： '+patientCount, value:inValue, itemStyle : labelTop}
	     	            ]
	     	        }
	     	    ]
	     	};

	     // 为echarts对象加载数据 
	     myChart.setOption(option); 
	}
   function showCanvas2 (){
	   var myChart = echarts.init(document.getElementById('chart')); 
	     	var inCount = 0;
	     	var finishCount = 0;
	     	var offCount = 0;
	     	if ("${scope == GlobalConstant.USER_LIST_LOCAL}"=="true") {
	     		inCount = "${implemenMap['inNum']+'0'}";
		     	finishCount = "${implemenMap['finishCount']+'0'}";
		     	offCount = "${implemenMap['offCount']+'0'}";
	     	} else {
	     		inCount = $("#totalInSum").val();
	     		finishCount = $("#totalFinishSum").val();
	     		offCount = $("#totalOffSum").val();
	     	}
	     	option = {
	     		    tooltip : {
	     		        trigger: 'item',
	     		        formatter: "{b} : {c}"
	     		    },
	     		   title : {
	     		        text: '入组详情',
	     		        x:'center',
	     		        y:'bottom'
	     		    },
	     		    toolbox: {
	     		        show : true,
	     		        feature : {
	     		            restore : {show: true},
	     		            saveAsImage : {show: true}
	     		        }
	     		    },
	     		   
	     		    series : [
	     		        {
	     		          
	     		            type:'pie',
	     		            radius : '65%',
	     		            itemStyle : {
	     		                normal : {
	     		                    label : {
	     		                        show : true
	     		                    },
	     		                    labelLine : {
	     		                        show : true
	     		                    }
	     		                }
	     		            },
	     		            data:[
	     		                {value:inCount, name:'访视中'},
	     		                {value:finishCount, name:'完成'},
	     		                {value:offCount, name:'脱落'}
	     		            ]
	     		        }
	     		    ]
	     		};
	     		              

	     // 为echarts对象加载数据 
	     myChart.setOption(option); 
	}
   
   $(function(){
		$(".parentA").click(function(event){
	        event.stopPropagation();
	    });
		if ("${projParam.projLock}"=="${GlobalConstant.FLAG_Y}") {
			$("#projLockSpan").show();
    	} else {
    		$("#projUnLockSpan").show();
    	}
	});
   
   function infoToggle(id){
		$("#"+id).toggle();
	}
   
   function editProjInfo() {
	   jboxOpen("<s:url value='/edc/proj/edit?projFlow=${proj.projFlow}'/>" , "编辑基本信息", 900, 300);
   }
   
   function editProjParam() {
	   jboxOpen("<s:url value='/edc/proj/editProjParam?projFlow=${proj.projFlow}'/>" , "编辑研究方案", 700, 250); 
   }
   
   function modProjParam() {
		var datas = {
				randomLock:$("input:checked[name='randomLock']").val(),
				designLock:$("input:checked[name='designLock']").val(),
				inputLock:$("input:checked[name='inputLock']").val(),
				inspectLock:$("input:checked[name='inspectLock']").val(),
		}
		jboxGet("<s:url value='/edc/proj/modProjParam'/>",datas,null,null,false);
	}
   
    function projLock(projLock){
    	var datas = {
    			randomLock:$("input:checked[name='randomLock']").val(),
				designLock:$("input:checked[name='designLock']").val(),
				inputLock:$("input:checked[name='inputLock']").val(),
				inspectLock:$("input:checked[name='inspectLock']").val(),
				projLock:projLock
		}
		jboxGet("<s:url value='/edc/proj/modProjParam'/>",datas,function(res){
			if (projLock == "${GlobalConstant.FLAG_Y}") {
				$("#projUnLockSpan").hide();
	    		$("#projLockSpan").show();
	    	} else {
	    		$("#projLockSpan").hide();
	    		$("#projUnLockSpan").show();
	    	}
		},null,false);
    }
    
    function editProjFile() {
 	   jboxOpen("<s:url value='/edc/proj/editProjFile?projFlow=${proj.projFlow}'/>" , "编辑附件", 700, 250); 
    }
    
    function modPubFile(obj,fileFlow) {
    	var isShared = "";
    	if ($(obj).attr("checked")=="checked") {
    		isShared = "${GlobalConstant.FLAG_Y}";
    	}
		jboxGet("<s:url value='/edc/proj/modPubFile'/>?projFlow=${proj.projFlow}&fileFlow="+fileFlow+"&isShared="+isShared,null,null,null,false);
	}
    
    function queryInfo(percent,data1Name,data1,data2Name,data2){
	     var myChart = echarts.init(document.getElementById('chart')); 
	     var otherPercent = 100-percent;
	     var labelTop = {
	     	    normal : {
	     	        label : {
	     	            show : false,
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
	     	            formatter : function (a,b,c){return 100-c + '%'},
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
	     	
	     	var radius = [65, 75];
	     	option = {
	     		    legend: {
	     		        x : 'center',
	     		        y : 'bottom',
	     		        data:[
							data1Name+data1+'  \t\t'+data2Name+data2
	     		        ]
	     		    },
	     			 toolbox: {
	      		        show : true,
	      		        feature : {
	      		            restore : {show: true},
	      		            saveAsImage : {show: true}
	      		        }
	      		    },
	     	    series : [
	     	        {
	     	            type : 'pie',
	     	            radius : radius,
	     	            x: '0%', // for funnel
	     	            itemStyle : labelFromatter, 
	     	            data : [
							{name:'other', value:otherPercent, itemStyle : labelBottom},
							{name:data1Name+data1+'  \t\t'+data2Name+data2, value:percent, itemStyle : labelTop}
	     	            ]
	     	        }
	     	    ]
	     	};

	     // 为echarts对象加载数据 
	     myChart.setOption(option); 
	}
    
    function queryView(){
    	var percent=0;
	    var solvedCount = 0;
	    var sendedCount = 0;
	    if ("${scope == GlobalConstant.USER_LIST_LOCAL}"=="true") {
	    	solvedCount = Number($("#orgSdvSolved").val())+Number($("#orgManualSolved").val());
	    	sendedCount = Number($("#orgSdvSended").val())+Number($("#orgManualSended").val());
	    } else {
	    	solvedCount = Number($("#sdvSolved").val())+Number($("#manualSolved").val());
	    	sendedCount = Number($("#sdvSended").val())+Number($("#manualSended").val());
	    }
	    if (sendedCount != 0) {
	    	percent = (solvedCount/sendedCount*100).toFixed();
	    }
	    queryInfo(percent,"全部疑问：   已发送： ",sendedCount,"已解决：",solvedCount);
 	}
    
    function sdvInfo() {
		var sdvPercent=0;
	    var sdvSolvedCount = 0;
	    var sdvSendedCount = 0;
	    if ("${scope == GlobalConstant.USER_LIST_LOCAL}"=="true") {
	    	sdvSolvedCount = $("#orgSdvSolved").val();
	    	sdvSendedCount = $("#orgSdvSended").val();
	    } else {
	    	sdvSolvedCount = $("#sdvSolved").val();
	    	sdvSendedCount = $("#sdvSended").val();
	    }
	    if (sdvSendedCount != 0) {
	    	sdvPercent = (sdvSolvedCount/sdvSendedCount*100).toFixed();
	    }
	    queryInfo(sdvPercent,"SDV疑问： 已发送：  ",sdvSendedCount,"已解决： ",sdvSolvedCount);
	 }
    
    function manualInfo() {
		var manualPercent=0;
	    var manualSolvedCount = 0;
	    var manualSendedCount = 0;
	    if ("${scope == GlobalConstant.USER_LIST_LOCAL}"=="true") {
	    	manualSolvedCount = $("#orgManualSolved").val();
	    	manualSendedCount = $("#orgManualSended").val();
	    } else {
	    	manualSolvedCount = $("#manualSolved").val();
	    	manualSendedCount = $("#manualSended").val();
	    }
	    if (manualSendedCount != 0) {
	    	manualPercent = (manualSolvedCount/manualSendedCount*100).toFixed();
	    }
	    queryInfo(manualPercent,"手工疑问： 已发送：  ",manualSendedCount,"已解决： ",manualSolvedCount);
	 }
    function queryType(){
  	   var myChart = echarts.init(document.getElementById('chart')); 
  	     	var sdvCount = 0;
  	     	var manualCount = 0;
  	     	if ("${scope == GlobalConstant.USER_LIST_LOCAL}"=="true") {
  	     		sdvCount = $("#orgSdv").val();
  	     		manualCount = $("#orgManual").val();
  	     	} else {
  	     		sdvCount = "${queryMap[edcQuerySendWayEnumSdv.id]+'0'}";
  	     		manualCount = "${queryMap[edcQuerySendWayEnumManual.id]+'0'}";
  	     	}
  	     	option = {
  	     		    tooltip : {
  	     		        trigger: 'item',
  	     		        formatter: "{b} : {c}"
  	     		    },
  	     		   title : {
  	     		        text: '疑问类型',
  	     		        x:'center',
  	     		        y:'bottom'
  	     		    },
  	     		    toolbox: {
  	     		        show : true,
  	     		        feature : {
  	     		            restore : {show: true},
  	     		            saveAsImage : {show: true}
  	     		        }
  	     		    },
  	     		   
  	     		    series : [
  	     		        {
  	     		          
  	     		            type:'pie',
  	     		            radius : '65%',
  	     		            itemStyle : {
  	     		                normal : {
  	     		                    label : {
  	     		                        show : true
  	     		                    },
  	     		                    labelLine : {
  	     		                        show : true
  	     		                    }
  	     		                }
  	     		            },
  	     		            data:[
  	     		                {value:sdvCount, name:'SDV疑问'},
  	     		                {value:manualCount, name:'手工疑问'}
  	     		            ]
  	     		        }
  	     		    ]
  	     		};
  	     		              

  	     // 为echarts对象加载数据 
  	     myChart.setOption(option); 
  	}
    function sdvStatusInfo(){
 	   var myChart = echarts.init(document.getElementById('chart')); 
 	     	var notSdv = 0;
 	     	var sdving = 0;
 	     	var sdved = 0;
 	     	if ("${scope == GlobalConstant.USER_LIST_LOCAL}"=="true") {
 	     		notSdv = $("#orgNotSdv").val();
 	     		sdving = $("#orgSdving").val();
 	     		sdved = $("#orgSdved").val();
 	     	} else {
 	     		notSdv = $("#notSdv").val();
 	     		sdving = $("#sdving").val();
 	     		sdved = $("#sdved").val();
 	     	}
 	     	option = {
 	     		    tooltip : {
 	     		        trigger: 'item',
 	     		        formatter: "{b} : {c}"
 	     		    },
 	     		   title : {
 	     		        text: 'SDV核查概况',
 	     		        x:'center',
 	     		        y:'bottom'
 	     		    },
 	     		    toolbox: {
 	     		        show : true,
 	     		        feature : {
 	     		            restore : {show: true},
 	     		            saveAsImage : {show: true}
 	     		        }
 	     		    },
 	     		   
 	     		    series : [
 	     		        {
 	     		          
 	     		            type:'pie',
 	     		            radius : '65%',
 	     		            itemStyle : {
 	     		                normal : {
 	     		                    label : {
 	     		                        show : true
 	     		                    },
 	     		                    labelLine : {
 	     		                        show : true
 	     		                    }
 	     		                }
 	     		            },
 	     		            data:[
 	     		                {value:notSdv, name:'${edcSdvStatusEnumNotSdv.name}'},
 	     		                {value:sdving, name:'${edcSdvStatusEnumSdving.name}'},
 	     		                {value:sdved, name:'${edcSdvStatusEnumSdved.name}'}
 	     		            ]
 	     		        }
 	     		    ]
 	     		};
 	     		              

 	     // 为echarts对象加载数据 
 	     myChart.setOption(option); 
 	}
    
    function inputInfo(){
  	   var myChart = echarts.init(document.getElementById('chart')); 
  	     	var save = 0;
  	     	var submit = 0;
  	     	var checked = 0;
  	     	if ("${scope == GlobalConstant.USER_LIST_LOCAL}"=="true") {
  	     		save = $("#orgSave").val();
  	     		submit = $("#orgSubmit").val();
  	     		checked = $("#orgChecked").val();
  	     	} else {
  	     		save = $("#save").val();
  	     		submit = $("#submit").val();
  	     		checked = $("#checked").val();
  	     	}
  	     	option = {
  	     		    tooltip : {
  	     		        trigger: 'item',
  	     		        formatter: "{b} : {c}"
  	     		    },
  	     		   title : {
  	     		        text: '录入情况',
  	     		        x:'center',
  	     		        y:'bottom'
  	     		    },
  	     		    toolbox: {
  	     		        show : true,
  	     		        feature : {
  	     		            restore : {show: true},
  	     		            saveAsImage : {show: true}
  	     		        }
  	     		    },
  	     		   
  	     		    series : [
  	     		        {
  	     		          
  	     		            type:'pie',
  	     		            radius : '65%',
  	     		            itemStyle : {
  	     		                normal : {
  	     		                    label : {
  	     		                        show : true
  	     		                    },
  	     		                    labelLine : {
  	     		                        show : true
  	     		                    }
  	     		                }
  	     		            },
  	     		            data:[
  	     		                {value:save, name:'未录入'},
  	     		                {value:submit, name:'录入中'},
  	     		                {value:checked, name:'录入完成'}
  	     		            ]
  	     		        }
  	     		    ]
  	     		};
  	     		              

  	     // 为echarts对象加载数据 
  	     myChart.setOption(option); 
  	}
    
    function switchCanvas(type){
    	var canvasCount = 3;
		var cuurIndex = $(".canvas0").index($(".canSelected"));
		var nextIndex = cuurIndex+1;
		if ("up"==type) {
			nextIndex = cuurIndex-1;
		}
		if(nextIndex == canvasCount){
			nextIndex = 0 ;
		}
		$(".canSelected").hide();
		$(".canSelected").removeClass("canSelected");
		for(var i=0;i<canvasCount;i++) {
			var canvasSpan = $(".canvas"+i).get(nextIndex);
			$(canvasSpan).addClass("canSelected");
			$(canvasSpan).fadeToggle("slow");
			if (i==0) {
				$(canvasSpan).find("a").css("color","#ff5200");
				$(canvasSpan).find("a").trigger("click");
			} else {
				$(canvasSpan).find("a").css("color","");
			}
		}
	}
    
    $(document).ready(function(){
    	for(var i=0;i<3;i++) {
    		$(".canvas"+i).find("a").click(function(event){
    			$(".canSelected").find("a").css("color","");
    			$(this).css("color","#ff5200");
    	    });
    	}
	});
</script>
</head>
<body>
<c:set var="isOrg" value="${scope == GlobalConstant.USER_LIST_LOCAL}"/>
<div class="mainright">
	<div class="content">
		<div class="col-tb ps-r" > 
		<div class="col-cell j_center" style="width:100%; min-width: 440px;">
			<div class="group-view e-list-group" style="margin-top:10px; ">
				<div class="e-list-head" style="cursor: pointer;" onclick="infoToggle('jbxx');"><strong style="color: blue">基本信息></strong>
				<c:if test="${!isOrg }">
					<img alt="" src="<s:url value='/css/skin/${skinPath}/images/modify.png'/>" class="parentA" onclick="editProjInfo();" style="float: right;padding-right: 10px;padding-top: 10px;">
				</c:if>
				</div>
				<ul class="e-list center-list task-list ui-sortable" id="jbxx">
					<li>
						<span class="mark" style="padding-left: 15px;"><i></i></span>
						<span>项目名称：${proj.projName }</span>
					</li>
					<li>
						<span class="mark" style="padding-left: 15px;"><i></i></span>
						<span class="e-info" style="width: 44%;">项目简称：${pdfn:cutString(proj.projShortName,15,true,3 )}</span>
						<span class="e-info">项目编号：${proj.projNo }</span>
					</li>
					<li>
						<span class="mark" style="padding-left: 15px;"><i></i></span>
						<span class="e-info" style="width: 44%;">期类别&#12288;：${proj.projSubTypeName}</span>
						<span class="e-info">CFDA编号：${proj.cfdaNo }</span>
					</li>
				</ul>
			</div>	 
			<div class="group-view e-list-group" style="margin-top:10px; ">
				<div class="e-list-head" style="cursor: pointer;" onclick="infoToggle('yjfa');">
					<strong id="titleChart" style="color: blue">研究方案></strong>
					<c:if test="${!isOrg && (projParam.isRandom  == null or (projParam.isRandom  != null && projParam.isVisit  == null) or projParam.inputTypeId  == null)}">
						<img alt="" src="<s:url value='/css/skin/${skinPath}/images/modify.png'/>" class="parentA" onclick="editProjParam();" style="float: right;padding-right: 10px;padding-top: 10px;">
					</c:if>
				</div>
				<ul class="e-list center-list task-list ui-sortable" id="yjfa">
				<c:if test="${isOrg}">
					<li>
						<span class="mark" style="padding-left: 15px;"><i></i></span>
						<span>机构名称：${projOrg.orgName }</span>
					</li>
					<li>
						<span class="mark" style="padding-left: 15px;"><i></i></span>
						<span class="e-info" style="width: 44%;">中心号&#12288;：${projOrg.centerNo }</span>
						<span>承担例数：${projOrg.patientCount+'0' }</span>
					</li>
				</c:if>
					<li>
						<span class="mark" style="padding-left: 15px;"><i></i></span>
						<span class="e-info" style="width: 44%;">随机类型：${GlobalConstant.FLAG_Y eq projParam.isRandom?projParam.randomTypeName:(GlobalConstant.FLAG_N eq projParam.isRandom?'非随机':'') }</span>
						<span>盲法类型：${projParam.blindTypeName }</span>
					</li>
					<li>
						<span class="mark" style="padding-left: 15px;"><i></i></span>
						<span class="e-info" style="width: 44%;">随访申请：${GlobalConstant.FLAG_Y eq projParam.isVisit?'是':(GlobalConstant.FLAG_N eq projParam.isVisit?'否':'') }</span>
						<span>访视次数：${visitNum }</span>
					</li>
					<li>
						<span class="mark" style="padding-left: 15px;"><i></i></span>
						<span>录入方式：${projParam.inputTypeName }</span>
					</li>
				</ul>
			</div>
			<c:if test="${!isOrg}">
				<div class="group-view e-list-group" style="margin-top:10px; ">
				<div class="e-list-head" style="cursor: pointer;" onclick="infoToggle('cyjg');">
					<strong id="titleChart" style="color: blue">参与机构></strong>
				</div>
				<ul class="e-list center-list task-list ui-sortable" id="cyjg">
					<c:set var="totalPatientCount" value="0"/>
					<c:set var="totalInCount" value="0" />
					<c:set var="totalInSum" value="0" />
					<c:set var="totalFinishSum" value="0" />
					<c:set var="totalOffSum" value="0" />
					<c:set var="minDate" value="" />
					<c:forEach items="${pdfn:filterProjOrg(projOrgList)}" var="projOrg" varStatus="status">
						<c:set var="count" value="${projOrg.orgFlow}_Count"/>
						<c:set var="totalPatientCount" value="${totalPatientCount + projOrg.patientCount}" />
						<c:set var="totalInCount" value="${totalInCount + inDateMap[count]}" />
						<c:set var="totalInSum" value="${totalInSum + inCountMap[projOrg.orgFlow].size()}" />
						<c:set var="totalFinishSum" value="${totalFinishSum + finishCountMap[projOrg.orgFlow].size()}" />
						<c:set var="totalOffSum" value="${totalOffSum + offCountMap[projOrg.orgFlow].size()}" />
						<c:set var="min" value="${projOrg.orgFlow}_Min"/>
						<c:set var="minInDate" value="${empty inDateMap[min]?'':pdfn:transDateTime(inDateMap[min])}"/>
						<c:set var="minDate" value="${empty minDate?minInDate:((empty minInDate?minDate:(minInDate.compareTo(minDate)<0?minInDate:minDate)))}"/>
						<li>
							<span class="e-info" style="padding-left: 15px;width: 5px;"><i></i></span>
							<span class="e-info" style="width: 28%;">${status.index+1}.&nbsp;${projOrg.orgName }</span>
							<span class="e-info" style="width: 20%;">${projOrg.orgTypeName }</span>
							<span class="e-info" style="width: 22%;">承担例数：<span class="e-info" style="width: 35px;">${projOrg.patientCount }</span></span>
							<span>入组例数：<span class="e-info" style="width: 35px;">${inDateMap[count]+0 }</span>(${pdfn:getPercent(inDateMap[count],projOrg.patientCount) })</span>
						</li>
					</c:forEach>
					<input type="hidden" id="totalPatientCount" value="${totalPatientCount }">
					<input type="hidden" id="totalInCount" value="${totalInCount }">
					<input type="hidden" id="totalInSum" value="${totalInSum }">
					<input type="hidden" id="totalFinishSum" value="${totalFinishSum }">
					<input type="hidden" id="totalOffSum" value="${totalOffSum }">
				</ul>
			</div>
			</c:if>
		
			<div class="group-view e-list-group" style="margin-top:10px; ">
				<div class="e-list-head" style="cursor: pointer;" onclick="infoToggle('ssjz');">
					<strong id="titleChart" style="color: blue" id="ssjz">实施进展></strong>
				</div>
				<ul class="e-list center-list task-list ui-sortable" id="ssjz">
					<li>
						<span class="mark" style="padding-left: 15px;"><i></i></span>
						<span class="e-info" style="width: 22%;">承担病例数：${isOrg?projOrg.patientCount+'0':totalPatientCount}</span>
						<span class="e-info" style="width: 22%;">入组例数：${isOrg?implemenMap['inCount']+'0':totalInCount }</span>
						<span class="e-info" style="width: 22%;">完成例数：${isOrg?implemenMap['finishCount']+'0':totalFinishSum }</span>
						<span>脱落例数：${isOrg?implemenMap['offCount']+'0':totalOffSum }</span>
					</li>
					<li>
						<span class="mark" style="padding-left: 15px;"><i></i></span>
						<span>第一例入组日期：${pdfn:transDateTime(isOrg?implemenMap['minInDate']:minDate) }</span>
					</li>
					<li>
						<span class="mark" style="padding-left: 15px;"><i></i></span>
						<span class="e-info" style="width: 44%;">最新例入组日期：${pdfn:transDateTime(newPatient.inDate) }</span>
						<span class="e-info" style="width: 22%;">药物编号：${newDrugPack }</span>
						<span>申请人：${newPatient.inDoctorName }</span>
					</li>
				</ul>
			</div>	
			<div class="group-view e-list-group" style="margin-top:10px; ">
				<div class="e-list-head" style="cursor: pointer;" onclick="infoToggle('fj');">
					<strong id="titleChart" style="color: blue">附件></strong>
					<c:if test="${!isOrg }">
						<img alt="" src="<s:url value='/css/skin/${skinPath}/images/modify.png'/>" class="parentA" onclick="editProjFile();" style="float: right;padding-right: 10px;padding-top: 10px;">
					</c:if>
				</div>
				<ul class="e-list center-list task-list ui-sortable" id="fj">
					<c:forEach items="${fileList}" var="file">
					<c:if test="${!isOrg or file.isShared eq GlobalConstant.FLAG_Y}">
						<li style="position: relative;" class="task editable">
							<span class="mark" style="padding-left: 15px;"><i></i></span>
							<span>
							<a title="下载" style="color: blue;" href="<s:url value='/pub/file/down'/>?fileFlow=${file.fileFlow}">${file.fileName}</a>
							</span>
							<c:if test="${!isOrg }">
								<span><input type="checkbox" onchange="modPubFile(this,'${file.fileFlow }');" <c:if test="${file.isShared eq GlobalConstant.FLAG_Y }"> checked </c:if> style="float: right;margin-right: 18px;margin-top: 10px;" title="机构浏览"/></span>
							</c:if>
						</li>
					</c:if>
					</c:forEach>
				</ul>
			</div>					
		</div>
		
		<div id="js_side" >
			<div class="panel" style="border: 1px solid #ddd; width: 300px;height: 300px;float: right;margin-right: 10px;margin-top: 10px;">
				<div class="panel-head" style="text-align: center;">
					<h3 style="float: left;">
						<span class="canvas0 canSelected">
						  	<a href="javascript:void(0);" style="color: #ff5200;" onclick="showCanvas();">研究进度</a>
						</span>
						<span class="canvas0" style="display: none;">
					  		<a href="javascript:void(0);" onclick="inputInfo();">录入情况</a>
					    </span>
					    <span class="canvas0" style="display: none;">
						  	<a href="javascript:void(0);" onclick="queryView();">疑问概况</a>
						</span>
					</h3>
					<span style="float: right;width: 15px;padding-top: 5px;">
	 					 <img alt="" src="<s:url value='/css/skin/${skinPath}/images/up.png'/>" onclick="switchCanvas('up');" style="cursor: pointer;">
	 					 <img alt="" src="<s:url value='/css/skin/${skinPath}/images/down.png'/>" onclick="switchCanvas('down');" style="cursor: pointer;">
					 </span>
					<h3 style="text-align: center;">
						<span class="canvas1 canSelected" style="display: none;">
						 </span>
						 <span class="canvas1" style="display: none;">
						 </span>
						<span class="canvas1" style="display: none;">
						  	<!-- <a href="javascript:void(0);" onclick="sdvInfo();">SDV疑问</a> -->
						 </span>
					</h3>
				    <h3 style="float: right;padding-right: 10px;">
					  <span class="canvas2 canSelected" style="float: right;padding-right: 10px;">
					  	<a href="javascript:void(0);" onclick="showCanvas2();">入组详情</a>
					  </span>
					  <span class="canvas2" style="display: none;">
					  	<a href="javascript:void(0);" onclick="sdvStatusInfo();">审核概况</a>
					  </span>
					  <!-- <span class="canvas2" style="display: none;">
					  	<a href="javascript:void(0);" onclick="manualInfo();">手工疑问</a>
					  </span> -->
					  <span class="canvas2" style="display: none;">
					  	<a href="javascript:void(0);" onclick="queryType();">疑问类型</a>
					  </span>
					  <!-- 疑问管理 -->
					    <c:set var="orgSdv" value="${projOrg.orgFlow}${edcQuerySendWayEnumSdv.id}"/>
					    <c:set var="orgManual" value="${projOrg.orgFlow}${edcQuerySendWayEnumManual.id}"/>
					  	<c:set var="orgSdvSolved" value="${projOrg.orgFlow}${edcQuerySendWayEnumSdv.id}${edcQuerySolveStatusEnumSolved.id}"/>
						<c:set var="orgSdvSended" value="${projOrg.orgFlow}${edcQuerySendWayEnumSdv.id}${edcQueryStatusEnumSended.id}"/>
						<c:set var="orgManualSolved" value="${projOrg.orgFlow}${edcQuerySendWayEnumManual.id}${edcQuerySolveStatusEnumSolved.id}"/>
						<c:set var="orgManualSended" value="${projOrg.orgFlow}${edcQuerySendWayEnumManual.id}${edcQueryStatusEnumSended.id}"/>
					  	<c:set var="sdvSolved" value="${edcQuerySendWayEnumSdv.id}${edcQuerySolveStatusEnumSolved.id}"/>
						<c:set var="sdvSended" value="${edcQuerySendWayEnumSdv.id}${edcQueryStatusEnumSended.id}"/>
						<c:set var="manualSolved" value="${edcQuerySendWayEnumManual.id}${edcQuerySolveStatusEnumSolved.id}"/>
						<c:set var="manualSended" value="${edcQuerySendWayEnumManual.id}${edcQueryStatusEnumSended.id}"/>
				 		<input type="hidden" id="orgSdv" value="${queryMap[orgSdv]+'0'}">
				 		<input type="hidden" id="orgManual" value="${queryMap[orgManual]+'0'}">
				 		<input type="hidden" id="orgSdvSolved" value="${queryMap[orgSdvSolved]+'0'}">
				 		<input type="hidden" id="orgSdvSended" value="${queryMap[orgSdvSended]+'0'}">
				 		<input type="hidden" id="orgManualSolved" value="${queryMap[orgManualSolved]+'0'}">
				 		<input type="hidden" id="orgManualSended" value="${queryMap[orgManualSended]+'0'}">
				 		<input type="hidden" id="sdvSolved" value="${queryMap[sdvSolved]+'0'}">
				 		<input type="hidden" id="sdvSended" value="${queryMap[sdvSended]+'0'}">
				 		<input type="hidden" id="manualSolved" value="${queryMap[manualSolved]+'0'}">
				 		<input type="hidden" id="manualSended" value="${queryMap[manualSended]+'0'}">
				 	   <!-- sdv核查概况 -->
				 	    <c:set var="orgNotSdv" value="${projOrg.orgFlow}${edcSdvStatusEnumNotSdv.id}"/>
					    <c:set var="orgSdving" value="${projOrg.orgFlow}${edcSdvStatusEnumSdving.id}"/>
					  	<c:set var="orgSdved" value="${projOrg.orgFlow}${edcSdvStatusEnumSdved.id}"/>
					  	<c:set var="notSdv" value="${edcSdvStatusEnumNotSdv.id}"/>
					    <c:set var="sdving" value="${edcSdvStatusEnumSdving.id}"/>
					  	<c:set var="sdved" value="${edcSdvStatusEnumSdved.id}"/>
					  	<input type="hidden" id="orgNotSdv" value="${sdvStatusMap[orgNotSdv]+'0'}">
				 		<input type="hidden" id="orgSdving" value="${sdvStatusMap[orgSdving]+'0'}">
				 		<input type="hidden" id="orgSdved" value="${sdvStatusMap[orgSdved]+'0'}">
				 		<input type="hidden" id="notSdv" value="${sdvStatusMap[notSdv]+'0'}">
				 		<input type="hidden" id="sdving" value="${sdvStatusMap[sdving]+'0'}">
				 		<input type="hidden" id="sdved" value="${sdvStatusMap[sdved]+'0'}">
				 		<!-- 录入情况 -->
				 		<c:set var="orgSave" value="${projOrg.orgFlow}${edcInputStatusEnumSave.id}"/>
					    <c:set var="orgSubmit" value="${projOrg.orgFlow}${edcInputStatusEnumSubmit.id}"/>
					  	<c:set var="orgChecked" value="${projOrg.orgFlow}${edcInputStatusEnumChecked.id}"/>
					  	<c:set var="save" value="${edcInputStatusEnumSave.id}"/>
					    <c:set var="submit" value="${edcInputStatusEnumSubmit.id}"/>
					  	<c:set var="checked" value="${edcInputStatusEnumChecked.id}"/>
					  	<input type="hidden" id="orgSave" value="${inputMap[orgSave]+'0'}">
				 		<input type="hidden" id="orgSubmit" value="${inputMap[orgSubmit]+'0'}">
				 		<input type="hidden" id="orgChecked" value="${inputMap[orgChecked]+'0'}">
				 		<input type="hidden" id="save" value="${inputMap[save]+'0'}">
				 		<input type="hidden" id="submit" value="${inputMap[submit]+'0'}">
				 		<input type="hidden" id="checked" value="${inputMap[checked]+'0'}">
				  </h3>
				</div>
				<div id="chart" style="height: 250px;"></div>
			</div>
			<c:if test="${isOrg }">
			<div class="panel" style="border: 1px solid #ddd; width: 300px;float: right;margin-right: 10px;margin-top: 5px;">
				<div class="panel-head"><h3>权限分配</h3></div>
				<div  class="list-group">
					<c:forEach var="role" items="${sysRoleList }">
						<c:if test="${!empty projUserMap[role.roleFlow] }">
							<span class="list-group-item  ellipsis router" >${role.roleName }：
							<c:forEach var="user" items="${projUserMap[role.roleFlow] }" varStatus="status">
							<span title="分配时间：${pdfn:transDate(user.authTime) } 分配人：${user.authUserFlow}">${user.createUserFlow }${status.last?"":"、" }</span>
							</c:forEach>
							</span>
						</c:if>
					</c:forEach>
				</div>
			</div>
			</c:if>
			<c:if test="${!isOrg }">
			<div class="panel" style="border: 1px solid #ddd; width: 300px;float: right;margin-right: 10px;margin-top: 5px;">
				<div class="panel-head"><h3>项目状态</h3>
					<span id="projUnLockSpan" style="display: none;">
					<img  title="数据库锁定" onclick="projLock('${GlobalConstant.FLAG_Y}');" src="<s:url value='/css/skin/${skinPath}/images/unlock.png'/>" style="float: right;padding-top: 10px;cursor: pointer;" />
					</span>
					<span id="projLockSpan" style="display: none;">
					<img  title="数据库解锁" onclick="projLock('${GlobalConstant.FLAG_N}');" src="<s:url value='/css/skin/${skinPath}/images/lock.png'/>" style="float: right;padding-top: 10px;cursor: pointer;" />
					</span>
				</div>
				<div  class="list-group">
					<span class="list-group-item  ellipsis router"  >设计锁定：<input  name="designLock" <c:if test="${projParam.designLock eq GlobalConstant.FLAG_Y }">checked</c:if> onchange="modProjParam();" type="checkbox" value="${GlobalConstant.FLAG_Y }"/></span>
					<span class="list-group-item  ellipsis router" >随机锁定：<input  name="randomLock" <c:if test="${empty projParam.isRandom || projParam.isRandom eq GlobalConstant.FLAG_N }">disabled="disabled"</c:if>
				 		<c:if test="${projParam.randomLock eq GlobalConstant.FLAG_Y }">checked</c:if> onchange="modProjParam();" type="checkbox" value="${GlobalConstant.FLAG_Y }"/></span>
					<span class="list-group-item  ellipsis router"  >录入锁定：<input  name="inputLock" <c:if test="${projParam.inputLock eq GlobalConstant.FLAG_Y }">checked</c:if> onchange="modProjParam();" type="checkbox" value="${GlobalConstant.FLAG_Y }"/></span>
					<span class="list-group-item  ellipsis router"  >核查锁定：<input  name="inspectLock" <c:if test="${projParam.inspectLock eq GlobalConstant.FLAG_Y }">checked</c:if> onchange="modProjParam();" type="checkbox" value="${GlobalConstant.FLAG_Y }"/></span>
				</div>
			</div>
			</c:if>
			<%-- <c:if test="${isOrg }">
			<div class="panel" style="border: 1px solid #ddd; width: 300px;float: right;margin-right: 10px;margin-top: 5px;">
				<div class="panel-head"><h3>联系方式</h3></div>
				<div  class="list-group">
					<span class="list-group-item  ellipsis router"  >组长单位：${leaderOrg.orgName }</span>
					<span class="list-group-item  ellipsis router" >联系人：李四</span>
					<span class="list-group-item  ellipsis router"  >联系电话：1234567890</span>
					<span class="list-group-item  ellipsis router"  >邮箱：1234@5678.com</span>
				</div>
			</div>
			</c:if> --%>
		</div>
	</div>
	</div>
</div>
</body>
</html>