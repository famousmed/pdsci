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

<script>
$(document).ready(function(){
// 	 var myChart = echarts.init(document.getElementById('trainChart')); 
//      var labelTop = {
//      	    normal : {
//      	        label : {
//      	            show : true,
//      	            position : 'center',
//      	            formatter : '{b}',
//      	            textStyle: {
//      	                baseline : 'bottom'
//      	            }
//      	        },
//      	        labelLine : {
//      	            show : false
//      	        }
//      	    }
//      	};
//      	var labelFromatter = {
//      	    normal : {
//      	        label : {
//      	            formatter : function (a,b,c){return 100-c + '%'},
//      	            textStyle: {
//      	                baseline : 'center'
//      	            }
//      	        }
//      	    },
//      	}
//      	var labelBottom = {
//      	    normal : {
//      	        color: '#ccc',
//      	        label : {
//      	            show : true,
//      	            position : 'center'
//      	        },
//      	        labelLine : {
//      	            show : false
//      	        }
//      	    },
//      	    emphasis: {
//      	        color: 'rgba(0,0,0,0)'
//      	    }
//      	};
//      	var radius = [25, 28];
//      	option = {
//      		    tooltip : {
//      		        trigger: 'item',
//      		        formatter: "{b}"
//      		    },
//      		    toolbox: {
//      		        show : true,
//      		        feature : {
//      		            restore : {show: true},
//      		            saveAsImage : {show: true}
//      		        }
//      		    },
     		   
//      		    series : [
//      		        {
     		          
//      		            type:'pie',
//      		            radius : '65%',
//      		            itemStyle : {
//      		                normal : {
//      		                    label : {
//      		                        show : true
//      		                    },
//      		                    labelLine : {
//      		                        show : true
//      		                    }
//      		                }
//      		            },
//      		            data:[
//      		                  <c:forEach items="${registryTypeEnumList}" var="registryType">
// 	                   			<c:set value="res_registry_type_${registryType.id}" var="viewCfgKey"/>
// 	                   			<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
// 	                   				<c:set value="${result.resultFlow}${registryType.id}finish" var="finishKey"/>
// 	     		                	{value:${recFinishMap[finishKey]+0}, name:'${registryType.name}：${recFinishMap[finishKey]+0}'},
// 	     		                </c:if>
//      		                  </c:forEach>
//      		            ]
//      		        }
//      		    ]
//      		};
     		              

//      // 为echarts对象加载数据 
//      myChart.setOption(option); 
});
	$(document).ready(function(){
		//toggleItem('processView');
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
	   jboxOpen("<s:url value='/res/rec/sopView'/>?&resultFlow=${param.resultFlow}", "轮转信息规范",700,500);
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
		  //toggleItem('processView');
	  }
	  loadProcessStudyInfo(); 
 });
 function loadProcessStudyInfo(){
		var url="<s:url value='/resedu/student/loadStudyInfo'/>?roleFlag=${GlobalConstant.RES_ROLE_SCOPE_DOCTOR}&resultFlow=${param.resultFlow}"+
		"&rotationFlow=${param.rotationFlow}&schDeptFlow="+indexObj.schDeptFlow;
		jboxLoad("processStudyInfoDiv",url,true);
	}
 function add(){
			var url="<s:url value='/res/doc/speAbilityAssess'/>";
			jboxOpen(url,"专业能力评估表",700,800);
 }
</script>
</head>
<body>
	<div class="toolkit bg-f6 toolkit-lg toolkit-bar" style="border-top: 0;cursor: pointer;" onclick="toggleItem('processView');scrollHome('processView');">
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
				<a class="btn btn-sm btn-success parentA" style="margin-top: 10px;text-decoration: none;display: none;border-radius:5px;" id="dataViewB" onclick="view('view');">
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
				<c:forEach items="${registryTypeEnumList}" var="registryType">
				
					<c:set value="res_registry_type_${registryType.id}" var="viewCfgKey"/>
					
					<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
					
						<c:set value="${result.resultFlow}${registryType.id}finish" var="registryTypeFinish"/>
						<c:set value="${result.resultFlow}${registryType.id}req" var="registryTypeReq"/>
						<c:set value="${result.resultFlow}${registryType.id}isFinish" var="registryTypeIsFinish"/>
						<c:set value="${result.resultFlow}${registryType.id}itemPre" var="registryTypePre"/>
						
						<li  style="position: relative;width: 100%" class="lidata">
							<span class="mark"><i></i></span>
							<span class="j_title  ellipsis" style="padding-left: 10px;width: 25%;text-align: left;">
								<span style="display: inline-block;width: 130px;">
									完成${registryType.name}：&#12288;
								</span>
								<a href="javascript:goList('${registryType.id}');">${recFinishMap[registryTypeFinish]+0}</a>&#12288;例
							</span>
							<c:if test="${GlobalConstant.FLAG_Y eq registryType.haveReq && !empty result.rotationFlow}">
								<span style="margin-left: 40px;">
									完成比例：${recFinishMap[registryTypePre]+0}%
								</span>
							</c:if>
							<div style="float: right;padding-right: 10px;">
								<span class="showSpan" style="color: green">
									<c:if test="${GlobalConstant.FLAG_Y eq registryType.haveReq}">
										<c:if test="${recFinishMap[registryTypeReq]+0 == 0}">
											无要求
										</c:if>
										<c:if test="${recFinishMap[registryTypeReq]+0 > 0}">
											<c:if test="${recFinishMap[registryTypeFinish]+0 >= recFinishMap[registryTypeReq]+0}">
												已完成
												|
											</c:if>
											要求数：
											<font style="display: inline-block;width: 20px;">
												${reqNumMap[registryType.id]+0}
											</font>
										</c:if>
									</c:if>
								</span>
								
								<span class="editSpan" style="display:none;">
									<a href="javascript:loadForm('','','${registryType.id}');">登记</a>
									
									<c:if test="${GlobalConstant.FLAG_Y eq registryType.haveAppeal}">
										|
										<c:set value="${result.resultFlow}${registryType.id}itemCount" var="registryTypeItemCount"/>
										<c:set value="${recFinishMap[registryTypeItemCount] == 0 || recFinishMap[registryTypeItemCount] <= appealCount[registryType.id]}" var="appealFull"/>
										<c:set value="editAppeal('','','${registryType.id}')" var="editAppeal"/>
										<c:set value="${appealFull?'appealTip()':editAppeal}" var="jsFunc"/>
										<a href="javascript:${jsFunc};">申述</a>
									</c:if>
								</span>
							</div>
						</li>
					</c:if>
				</c:forEach>
<!-- 				<li  style="position: relative;"> -->
<!-- 					<span class="mark"><i></i></span> -->
<!-- 					<span class="j_title  ellipsis" style="padding-left: 10px;"><a onclick="add();">年度专业能力评估表</a></span> -->
<!-- 				</li> -->
				<!--  登记手册待轮转结束后统一打印
				<li  style="position: relative;">
					<span class="mark"><i></i></span>
					<c:set var="url" value="${sysCfgMap['res_manual_url'] }"/>
					<span class="j_title  ellipsis" style="padding-left: 10px;"><a href="<s:url value='${url}'/>?schDeptFlow=${process.schDeptFlow}&resultFlow=${param.resultFlow}" target="_blank">登记手册</a></span>
				</li>
				 -->
			</ul>
		</div>
		
<!-- 		<div id="js_side" > -->
<!-- 			<div class="panel" style="border: 1px solid #ddd; width: 360px;height: 300px;float: right;margin-right: 10px;margin-top: 10px;"> -->
<!-- 				<div class="panel-head"><h3>培训登记情况</h3></div> -->
<!-- 				<div id="trainChart" style="height: 250px;"></div> -->
<!-- 			</div> -->
<!-- 		</div> -->
	</div>
	<c:if test="${sysCfgMap['res_study_course_flag']== GlobalConstant.FLAG_Y}">
<!-- 	<div id="processStudyInfoDiv" class="col-tb ps-r scrollwrapper" style="width: 100%;border-top: 1px solid #ddd;"></div> -->
	</c:if>
	</div>
	
	<div id="dataView" class="ebox1" style="height:auto;border:0;margin-bottom: 20px;display: none;">
		<div class="toolkit bg-f6 toolkit-lg toolkit-bar" style="border-top: 0;">
			<ul class="j_e-nav-tab toolkit-list fl">
				<c:forEach items="${registryTypeEnumList}" var="registryType" varStatus="status">
				
					<c:set value="res_registry_type_${registryType.id}" var="viewCfgKey"/>
					
					<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
						<li id="${registryType.id}" class="j_mainline_link toolkit-item toolkit-item-tab j_mainline_link_task router recTypeTag <c:if test="${status.first}">active</c:if>"
						onclick="selActive(this,'${registryType.id}');loadRegistryView();">
							<a>${registryType.name}</a>
						</li>
					</c:if>
				</c:forEach>
				</ul>
			</div>
		<div id="processDiv" style="min-height: 300px;"></div>
	</div>
</div>
</body>
</html>
