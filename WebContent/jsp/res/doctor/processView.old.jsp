<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<style type="text/css">
.col-tb {
display: table;
width: 100%;
}
.ps-r {
position: relative;
}
.col-tb>[class^="col-"], .col-tb>[class*=" col-"] {
display: table-cell;
vertical-align: top;
padding-right: 10px;
float: none;
}
.panel {
margin-bottom: 20px;
background-color: #fff;
border: 1px solid #ddd;
-webkit-box-shadow: 0 1px 1px rgba(0,0,0,.05);
box-shadow: 0 1px 1px rgba(0,0,0,.05);
}
.panel-head {
padding: 0 10px;
min-height: 38px;
background: #f9f9f9;
border-bottom: 1px solid #ddd;
}
.panel-head > h3 {
display: inline-block;
line-height: 37px;
font-size: 13px;
margin: 0;
color: inherit;
}
.panel>.list-group {
margin-bottom: 0;
}
.list-group {
padding-left: 0;
margin-bottom: 20px;
}

.panel-head+.list-group .list-group-item:first-child {
border-top-width: 0;
}
.panel>.list-group .list-group-item {
border-width: 1px 0;
border-radius: 0;
}
.list-group-item:first-child {
border-top-left-radius: 4px;
border-top-right-radius: 4px;
}
a.list-group-item {
color: #555;
}
.list-group-item {
position: relative;
display: block;
padding: 10px 15px;
margin-bottom: -1px;
border: 1px solid #ddd;
}
element.style {
width: 238px;
}
.panel-head+.list-group .list-group-item:first-child {
border-top-width: 0;
}
.panel>.list-group .list-group-item {
border-width: 1px 0;
border-radius: 0;
}
.list-group-item:first-child {
border-top-left-radius: 4px;
border-top-right-radius: 4px;
}
a.list-group-item {
color: #555;
}
.list-group-item {
position: relative;
display: block;
padding: 10px 15px;
margin-bottom: -1px;
border: 1px solid #ddd;
}
.ellipsis {
white-space: nowrap;
text-overflow: ellipsis;
overflow: hidden;
-o-text-overflow: ellipsis;
}
table.dataTable.no-footer {
border-color: #bebebe;
}
table.dataTable.no-footer {
border-bottom: 1px solid #111;
}
table.dataTable {
width: 100%;
margin: 0 auto;
clear: both;
border-collapse: separate;
border-spacing: 0;
}
table {
background-color: transparent;
}
table.dataTable thead th, table.dataTable thead td, table.dataTable.no-footer {
border-color: #bebebe;
}
table.dataTable thead th {
padding: 12px 10px;
}
table.dataTable thead th, table.dataTable thead td {
padding: 10px 18px;
border-bottom: 1px solid #111;
}
table.dataTable thead th, table.dataTable tfoot th {
font-weight: bold;
}
th {
text-align: left;
}
a {
cursor: pointer;
background: transparent;
color: #428bca;
text-decoration: none;
}
</style>
<c:set value="${result.resultFlow}${resRecTypeEnumCaseRegistry.id}finish" var="caseRegistryKey"/>
<c:set value="${result.resultFlow}${resRecTypeEnumDiseaseRegistry.id}finish" var="diseaseRegistryKey"/>
<c:set value="${result.resultFlow}${resRecTypeEnumOperationRegistry.id}finish" var="operationRegistryKey"/>
<c:set value="${result.resultFlow}${resRecTypeEnumSkillRegistry.id}finish" var="skillRegistryKey"/>
<c:set value="${result.resultFlow}${resRecTypeEnumCampaignRegistry.id}finish" var="campaignRegistryKey"/>

<c:set value="${result.resultFlow}${resRecTypeEnumCaseRegistry.id}req" var="caseRegistryKeyReq"/>
<c:set value="${result.resultFlow}${resRecTypeEnumDiseaseRegistry.id}req" var="diseaseRegistryKeyReq"/>
<c:set value="${result.resultFlow}${resRecTypeEnumOperationRegistry.id}req" var="operationRegistryKeyReq"/>
<c:set value="${result.resultFlow}${resRecTypeEnumSkillRegistry.id}req" var="skillRegistryKeyReq"/>

<c:set value="${result.resultFlow}${resRecTypeEnumDiseaseRegistry.id}itemCount" var="diseaseRegistryKeyItemCount"/>
<c:set value="${result.resultFlow}${resRecTypeEnumOperationRegistry.id}itemCount" var="operationRegistryKeyItemCount"/>
<c:set value="${result.resultFlow}${resRecTypeEnumSkillRegistry.id}itemCount" var="skillRegistryKeyItemCount"/>

<c:set value="${result.resultFlow}${resRecTypeEnumDiseaseRegistry.id}isFinish" var="diseaseRegistryKeyIsFinish"/>
<c:set value="${result.resultFlow}${resRecTypeEnumOperationRegistry.id}isFinish" var="operationRegistryKeyIsFinish"/>
<c:set value="${result.resultFlow}${resRecTypeEnumSkillRegistry.id}isFinish" var="skillRegistryKeyIsFinish"/>
<script>
$(document).ready(function(){
	 var myChart = echarts.init(document.getElementById('trainChart')); 
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
     	var radius = [25, 28];
     	option = {
     		    tooltip : {
     		        trigger: 'item',
     		        formatter: "{b}"
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
     		                  <c:forEach items="${registryTypeEnumList}" var="registryType">
	                   			<c:set value="res_registry_type_${registryType.id}" var="viewCfgKey"/>
	                   			<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
	                   				<c:set value="${result.resultFlow}${registryType.id}finish" var="finishKey"/>
	     		                	{value:${recFinishMap[finishKey]+0}, name:'${registryType.name}：${recFinishMap[finishKey]+0}'},
	     		                </c:if>
     		                  </c:forEach>
     		            ]
     		        }
     		    ]
     		};
     		              

     // 为echarts对象加载数据 
     myChart.setOption(option); 
});
	$(document).ready(function(){
		init();
	});

	function init(){
		$(".lidata").on("mouseenter mouseleave",function(){
			$(this).find(".showSpan,.editSpan").toggle();
		});
	}
	
	//修改轮转时间
   function modifySchDate(){
	   jboxOpen("<s:url value='/res/doc/showModifySchDate'/>?processFlow=${process.processFlow}", "修改轮转时间",400,200);
   }
	
 //轮转规范
   function sop(){
	   jboxOpen("<s:url value='/res/rec/sopView'/>?schDeptFlow="+indexObj.schDeptFlow+"&rotationFlow="+indexObj.rotationFlow, "轮转信息规范",700,500);
   }
 
 function goList(recTypeId){
	 $("#"+recTypeId).click();
	 view("data");
 }
 
 function appealTip(){
	 jboxTip("该类型没有可申述对象!");
 }
 
 $(document).ready(function() {
	   $(".parentA").click(function(event){
	        event.stopPropagation();
	    });
	  if ("up"=="${param.showType}") {
		  toggleItem('processView');
	  }
 });
</script>
</head>
<body>
	<div class="toolkit bg-f6 toolkit-lg toolkit-bar" style="border-top: 0;cursor: pointer;" onclick="toggleItem('processView');">
		<ul class="j_e-nav-tab toolkit-list fl">
			<li class="j_mainline_link toolkit-item toolkit-item-tab j_mainline_link_task router">
				<span class="tool_title">在培</span>
			</li>
		</ul>
		<ul class="toolkit-list fr ">
			<li
				class="toolkit-item dropdown-create create-stage fr task-tab-li">
				<a class="btn btn-sm btn-success parentA" style="margin-top: 10px;text-decoration: none;" id="dataViewA" onclick="view('data');">
					<i class="icon-plus-thin glyphicon"></i>培训数据
				</a>
				<a class="btn btn-sm btn-success parentA" style="margin-top: 10px;text-decoration: none;display: none;" id="dataViewB" onclick="view('view');">
					<i class="icon-plus-thin glyphicon"></i>培训视图
				</a>
			</li>
		</ul>
	</div>
	<div id="processView_div">
	<div id="proceView">
	<div class="col-tb ps-r scrollwrapper" style="width: 99%;"> 
		<div class="col-cell j_center" style="width:100%; min-width: 380px;">
			<ul class=" e-list task-list" style="margin-top: 5px;">
				<c:set value="res_registry_type_${registryTypeEnumCaseRegistry.id}" var="viewCfgKey"/>
				<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
				<li  style="position: relative;width: 100%" class="lidata">
					<span class="mark"><i></i></span>
					<span class="j_title  ellipsis" style="padding-left: 10px;">完成${registryTypeEnumCaseRegistry.name}：&#12288;<a href="javascript:goList('${resRecTypeEnumCaseRegistry.id}');">${recFinishMap[caseRegistryKey]+0}</a>&#12288;例</span>
					<div style="float: right;padding-right: 10px;">
						<span class="showSpan" style="color: green">
							<c:if test="${recFinishMap[caseRegistryKey]+0 >= recFinishMap[caseRegistryKeyReq]+0}">
								已完成
								|
							</c:if>
							要求数：
							<font style="display: inline-block;width: 20px;">
								${reqNumMap[resRecTypeEnumCaseRegistry.id]+0}
							</font>
						</span>
						<span class="editSpan" style="display:none;">
							<a href="javascript:loadForm('','','${resRecTypeEnumCaseRegistry.id}');">登记</a>
						</span>
					</div>
				</li>
				</c:if>
				
				<c:set value="res_registry_type_${registryTypeEnumOperationRegistry.id}" var="viewCfgKey"/>
				<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
				<li style="position: relative;" class="lidata">
					<span class="mark"><i></i></span>
					<span class="j_title  ellipsis" style="padding-left: 10px;">完成${registryTypeEnumOperationRegistry.name}：&#12288;&#12288;<a href="javascript:goList('${resRecTypeEnumOperationRegistry.id}');">${recFinishMap[operationRegistryKey]+0}</a>&#12288;例</span>
					<div style="float: right;padding-right: 10px;">
						<span class="showSpan" style="color: green">
							<c:if test="${recFinishMap[operationRegistryKeyIsFinish]}">
								已完成
								|
							</c:if>
							要求数：
							<font style="display: inline-block;width: 20px;">
								${reqNumMap[resRecTypeEnumOperationRegistry.id]+0}
							</font>
						</span>
						<span class="editSpan" style="display:none;">
							<a href="javascript:loadForm('','','${resRecTypeEnumOperationRegistry.id}');">登记</a> |
							<c:set value="${recFinishMap[operationRegistryKeyItemCount] <= appealCount[resRecTypeEnumOperationRegistry.id]}" var="appealFull"/>
							<c:set value="editAppeal('','','${resRecTypeEnumOperationRegistry.id}')" var="editAppeal"/>
							<c:set value="${appealFull?'appealTip()':editAppeal}" var="jsFunc"/>
							<a href="javascript:${jsFunc};">申述</a>
						</span>
					</div>
				</li>
				</c:if>
				
				<c:set value="res_registry_type_${registryTypeEnumDiseaseRegistry.id}" var="viewCfgKey"/>
				<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
				<li  style="position: relative;" class="lidata">
					<span class="mark"><i></i></span>
					<span class="j_title  ellipsis" style="padding-left: 10px;">完成${registryTypeEnumDiseaseRegistry.name}：&#12288;&#12288;<a href="javascript:goList('${resRecTypeEnumDiseaseRegistry.id}');">${recFinishMap[diseaseRegistryKey]+0}</a>&#12288;例</span>
					<div style="float: right;padding-right: 10px;">
						<span class="showSpan" style="color: green">
							<c:if test="${recFinishMap[diseaseRegistryKeyIsFinish]}">
								已完成
								|
							</c:if>
							要求数：
							<font style="display: inline-block;width: 20px;">
								${reqNumMap[resRecTypeEnumDiseaseRegistry.id]+0}
							</font>
						</span>
						<span class="editSpan" style="display:none;">
							<a href="javascript:loadForm('','','${resRecTypeEnumDiseaseRegistry.id}');">登记</a> |
							<c:set value="${recFinishMap[diseaseRegistryKeyItemCount] <= appealCount[resRecTypeEnumDiseaseRegistry.id]}" var="appealFull"/>
							<c:set value="editAppeal('','','${resRecTypeEnumDiseaseRegistry.id}')" var="editAppeal"/>
							<c:set value="${appealFull?'appealTip()':editAppeal}" var="jsFunc"/>
							<a href="javascript:${jsFunc};">申述</a>
						</span>
					</div>
				</li>
				</c:if>
				
				<c:set value="res_registry_type_${registryTypeEnumSkillRegistry.id}" var="viewCfgKey"/>
				<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
				<li  style="position: relative;" class="lidata">
					<span class="mark"><i></i></span>
					<span class="j_title  ellipsis" style="padding-left: 10px;">完成${registryTypeEnumSkillRegistry.name}：<a href="javascript:goList('${resRecTypeEnumSkillRegistry.id}');">${recFinishMap[skillRegistryKey]+0}</a>&#12288;种</span>
					<div style="float: right;padding-right: 10px;">
						<span class="showSpan" style="color: green">
							<c:if test="${recFinishMap[skillRegistryKeyIsFinish]}">
								已完成
								|
							</c:if>
							要求数：
							<font style="display: inline-block;width: 20px;">
								${reqNumMap[resRecTypeEnumSkillRegistry.id]+0}
							</font>
						</span>
						<span class="editSpan" style="display:none;">
							<a href="javascript:loadForm('','','${resRecTypeEnumSkillRegistry.id}');">登记</a> |
							<c:set value="${recFinishMap[skillRegistryKeyItemCount] <= appealCount[resRecTypeEnumSkillRegistry.id]}" var="appealFull"/>
							<c:set value="editAppeal('','','${resRecTypeEnumSkillRegistry.id}')" var="editAppeal"/>
							<c:set value="${appealFull?'appealTip()':editAppeal}" var="jsFunc"/>
							<a href="javascript:${jsFunc};">申述</a>
						</span>
					</div>
				</li>
				</c:if>
				<c:set value="res_registry_type_${registryTypeEnumCampaignRegistry.id}" var="viewCfgKey"/>
				<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
				<li  style="position: relative;" class="lidata">
					<span class="mark"><i></i></span>
					<span class="j_title  ellipsis" style="padding-left: 10px;">${registryTypeEnumCampaignRegistry.name}：&#12288;&#12288;<a href="javascript:goList('${resRecTypeEnumCampaignRegistry.id}');">${recFinishMap[campaignRegistryKey]+0}</a>&#12288;次</span>
					<div style="float: right;padding-right: 10px;">
						<span class="editSpan" style="display:none;">
							<a href="javascript:loadForm('','','${resRecTypeEnumCampaignRegistry.id}');">登记</a>
						</span>
					</div>
				</li>
				</c:if>
				<li  style="position: relative;">
					<span class="mark"><i></i></span>
					<span class="j_title  ellipsis" style="padding-left: 10px;"><a href="<s:url value='/res/doc/registryNoteBook'/>?schDeptFlow=${process.schDeptFlow}&resultFlow=${param.resultFlow}" target="_blank">登记手册</a></span>
				</li>
			</ul>
		</div>
		
		<div id="js_side" >
			<div class="panel" style="border: 1px solid #ddd; width: 360px;height: 300px;float: right;margin-right: 10px;margin-top: 10px;">
				<div class="panel-head"><h3>培训登记情况</h3></div>
				<div id="trainChart" style="height: 250px;"></div>
			</div>
		</div>
	</div>
	<c:if test="${sysCfgMap['res_study_course_flag']== GlobalConstant.FLAG_Y}">
	<div class="col-tb ps-r scrollwrapper" style="width: 100%;border-top: 1px solid #ddd;"> 
		<div class="panel-head"><h3 style="font-weight: normal;">学习中心</h3></div>
		<table width="99%">
			<tr>
				<td  style="width: 150px;">
					<a href="<s:url value ='/jsp/res/edu/student/main.jsp?resultFlow=${param.resultFlow}&rotationFlow=${param.rotationFlow}&schDeptFlow=${param.schDeptFlow}'/>">
	                   <img class="fl" src="<s:url value='/jsp/edu/css/images/film.png'/>" height="100" /> 
			        </a>
		         </td>
				<td style="border-right: 1px solid #ddd;line-height: 30px;width: 300px;">
					<p>必修课程：4&#12288;&#12288;已学完：3</p>
					<p>选修课程：2&#12288;&#12288;已学完：1</p>
					<p>获得学分：15&#12288;&#12288;未获得学分：6</p>
				</td>
				<td style="line-height: 30px;padding-left: 10px;">
					<p>最新学习：临床药理学&#12288;<a href="<s:url value='/jsp/res/edu/student/courseMain.jsp?source=${param.source}'/>" target="_blank">继续学习</a></p>
					<p>最近学习：预防医学&#12288;中医学&#12288;医学免疫学&#12288;基础医学...</p>
				</td>
			</tr>
		</table>
	</div>
	</c:if>
	</div>
	
	<div id="dataView" class="ebox1" style="height:auto;border:0;margin-bottom: 20px;display: none;">
		<div class="toolkit bg-f6 toolkit-lg toolkit-bar" style="border-top: 0;">
			<ul class="j_e-nav-tab toolkit-list fl">
				<c:set value="res_registry_type_${registryTypeEnumCaseRegistry.id}" var="viewCfgKey"/>
				<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
				<li id="${resRecTypeEnumCaseRegistry.id}" class="j_mainline_link toolkit-item toolkit-item-tab j_mainline_link_task router recTypeTag active"
					onclick="selActive(this,'${resRecTypeEnumCaseRegistry.id}');loadRegistryView();">
					<a>${registryTypeEnumCaseRegistry.name}</a>
				</li>
				</c:if>
				
				<c:set value="res_registry_type_${registryTypeEnumDiseaseRegistry.id}" var="viewCfgKey"/>
				<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
				<li id="${resRecTypeEnumDiseaseRegistry.id}" class="j_mainline_link toolkit-item toolkit-item-tab j_mainline_link_task router recTypeTag"
					onclick="selActive(this,'${resRecTypeEnumDiseaseRegistry.id}');loadRegistryView();">
					<a>${registryTypeEnumDiseaseRegistry.name}</a>
				</li>
				</c:if>
				
				<c:set value="res_registry_type_${registryTypeEnumSkillRegistry.id}" var="viewCfgKey"/>
				<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
				<li id="${resRecTypeEnumSkillRegistry.id}" class="j_mainline_link toolkit-item toolkit-item-tab j_mainline_link_task router recTypeTag"
					onclick="selActive(this,'${resRecTypeEnumSkillRegistry.id}');loadRegistryView();">
					<a>${registryTypeEnumSkillRegistry.name}</a>
				</li>
				</c:if>
				
				<c:set value="res_registry_type_${registryTypeEnumOperationRegistry.id}" var="viewCfgKey"/>
				<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
				<li id="${resRecTypeEnumOperationRegistry.id}" class="j_mainline_link toolkit-item toolkit-item-tab j_mainline_link_task router recTypeTag"
					onclick="selActive(this,'${resRecTypeEnumOperationRegistry.id}');loadRegistryView();">
					<a>${registryTypeEnumOperationRegistry.name}</a>
				</li>
				</c:if>
				
				<c:set value="res_registry_type_${registryTypeEnumCampaignRegistry.id}" var="viewCfgKey"/>
				<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
				<li id="${registryTypeEnumCampaignRegistry.id}" class="j_mainline_link toolkit-item toolkit-item-tab j_mainline_link_task router recTypeTag"
					onclick="selActive(this,'${registryTypeEnumCampaignRegistry.id}');loadRegistryView();">
					<a>${registryTypeEnumCampaignRegistry.name}</a>
				</li>
				</c:if>
				</ul>
			</div>
		<div id="processDiv" style="min-height: 300px;"></div>
	</div>
</div>
</body>
</html>
