<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<%@ taglib prefix="any" uri="http://www.anychart.com" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
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
<script type="text/javascript" src="<s:url value='/js/echarts/echarts-all.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</head>
<script type="text/javascript">
	function search(){
		$("#observationForm").submit();
	}
	
	function viewAll(){
		if($("#allData").is(":hidden")){
			$("#viewTag").text("收起列表 ∧");
			$("#allData").show();
		}else{
			$("#viewTag").text("展开列表 ∨");
			$("#allData").hide();
		}
	}
	
	$(function(){
		$("#allData").hide();
	});
	
	$(document).ready(function(){
		if ("true" == "${isCode}") {
			showCanvas();
		} else if ("false" == "${isCode}"){
			showCanvas2();
		}
	});

	function showCanvas(){
		var piechart = echarts.init(document.getElementById('pieChart'));
		piechart.showLoading({"text":"图表正在加载数据..."});
		var pieLabel = [];
		var pieValue = [];
		<c:forEach items="${codeList}" var="code" varStatus="status">
			pieLabel["${status.index}"]="${code.codeName}";
			pieValue["${status.index}"]={"value":"${attrCountMap[code.codeValue]}","name":"${code.codeName}"};
	    </c:forEach>
	    piechart.hideLoading();
    	
    	var pieoption = {
    		    title : {
    		        text: '观测指标：${observationCfgForm.elementName}_${observationCfgForm.attrName}',
    		    },
    		    tooltip : {
    		        trigger: 'item',
    		        formatter: "{a} <br/>{b} : {c} ({d}%)"
    		    },
    		    legend: {
    		        orient : 'horizontal',
    		        x : 'center',
    		        data:pieLabel
    		    },
    		    calculable : true,
    		    series : [
    		        {
    		            name:'${observationCfgForm.elementName}_${observationCfgForm.attrName}',
    		            type:'pie',
    		            radius : '55%',
    		            center: ['50%', '60%'],
    		            itemStyle:{
    		            	normal:{
    		            		label:{
    		            			show:true,
    		            			formatter:'{b} : {c} ({d}%)'
    		            		},
    		            		labelLine:{show:true}
    		            	}
    		            },
    		            data:pieValue
    		        }
    		    ]
    		};
    	piechart.setOption(pieoption);
	}
	
	function showCanvas2(){
	    var myChart = echarts.init(document.getElementById('lineChart')); 
	    var lineLabel = [];
	 	var lineValue = [];
	 	<c:forEach items="${visitDataMaxMinList }" var="maxminData">
		  	lineLabel.push("${maxminData.attrValue }");
		  	lineValue.push("${attrCountMap[maxminData.attrValue]}");
		</c:forEach>
		if (lineLabel.length==0) {
			lineLabel.push("");
		  	lineValue.push("");
		}
	 	option = {
	 		    title : {
	 		        text: '观测指标：${observationCfgForm.elementName}_${observationCfgForm.attrName}',
	 		    },
	 		    tooltip : {
	 		        trigger: 'axis'
	 		    },
	 		    legend: {
	 		        data:['${observationCfgForm.elementName}_${observationCfgForm.attrName}']
	 		    },
	 		    calculable : true,
	 		    xAxis : [
	 		        {
	 		            type : 'category',
	 		            boundaryGap: true,
	 		            data : lineLabel
	 		        }
	 		    ],
	 		    yAxis : [
	 		        {
	 		            type : 'value',
	 		            axisLabel : {
	 		                formatter: '{value}'
	 		            }
	 		        }
	 		    ],
	 		    series : [
	 		        {
	 		            name:'${observationCfgForm.elementName}_${observationCfgForm.attrName}',
	 		            type:'line',
	 		            data:lineValue,
	 		            itemStyle: {
		                    normal: {
		                        label : {
		                            show: true, position: 'top'
		                        }
		                    }
	               		}
	 		        }
	 		    ]
	 		};
	     // 为echarts对象加载数据 
	     myChart.setOption(option); 
	}
</script>
<body> 
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form action="<s:url value='/edc/report/observationList'/>" id="observationForm">
					&#12288;&#12288;观测指标：
					<select id="orgFlow" name="attrCode" class="xlname" style="width: 300px" onchange="search();">
						<option value=""></option>
						<c:forEach items="${observationCfgFormList}" var="form">
							<option value="${form.attrCode}" ${param.attrCode eq form.attrCode?'selected="selected"':''}>${form.elementName}_${form.attrName}</option>
						</c:forEach>
					</select>
				</form>
			</div>
			
			<table class="basic" width="100%" style="margin-bottom: 10px">
				<tr>
					<th width="20%" style="text-align: center;padding-left: 0px;padding-right: 0px">观测指标</th>
					<th style="text-align: center;padding-left: 0px;padding-right: 0px">
						<div>${isCode?'观测值':'最小/最大值(各五个)'}</div>
						<c:if test="${!empty observationCfgForm}">
							<a href="javascript:viewAll();" style="float: right;margin-right: 10px;font-weight: normal;margin-top: -17px;" id="viewTag">展开列表&nbsp;∨</a>
						</c:if>
					</th>
				</tr>
				<tr>
					<td style="text-align: center;padding-left: 0px;padding-right: 0px"><c:if test="${!empty param.attrCode }">${observationCfgForm.elementName}_${observationCfgForm.attrName}</c:if></td>
					<td style="text-align: center;padding-left: 0px;padding-right: 0px">
						<c:if test="${isCode}">
							<table style="margin-left: auto;margin-right: auto;">
								<c:forEach items="${codeList}" var="code">
									<tr>
										<td style="text-align: right;padding: 0;border: 0;line-height: 20px;height: 20px">代码：</td>
										<td style="text-align: left;padding: 0;border: 0;line-height: 20px;height: 20px">${code.codeValue}&#12288;</td>
										<td style="text-align: right;padding: 0;border: 0;line-height: 20px;height: 20px">描述：</td>
										<td style="text-align: left;padding: 0;border: 0;line-height: 20px;height: 20px">${code.codeName}&#12288;</td>
										<td style="text-align: right;padding: 0;border: 0;line-height: 20px;height: 20px">频数：</td>
										<td style="text-align: left;padding: 0;border: 0;line-height: 20px;height: 20px">${attrCountMap[code.codeValue]+0}&#12288;</td>
									</tr>
								</c:forEach>
							</table>
						</c:if>
						<c:if test="${!isCode && !empty visitDataMaxMinList}">
							<c:set value="${visitDataMaxMinList.size()+0}" var="size" />
							<c:forEach begin="0" end="${size>5?4:(size-1)}" varStatus="index">
								${visitDataMaxMinList[index.index].attrValue}&#12288;
							</c:forEach>
							|&#12288;
							<c:forEach begin="${size>5?(size-5):0}" end="${size-1}" varStatus="index">
								${visitDataMaxMinList[index.index].attrValue}&#12288;
							</c:forEach>
						</c:if>
					</td>
				</tr>
			</table>
			
			<table class="xllist" id="allData" style="margin-bottom: 10px;width: 100%">
				<tr>
					<th width="12%">中心号</th>
					<th width="17%">机构名称</th>
					<th width="15%">受试者编号</th>
					<th width="18%">访视名称</th>
					<th width="13%">录入序号</th>
					<th width="25%">${observationCfgForm.elementName}_${observationCfgForm.attrName}</th>
				</tr>
				<c:forEach items="${pubProjOrgList}" var="org">
					<c:forEach items="${patientMap[org.orgFlow]}" var="patient">
						<c:forEach items="${patientVisitDataMap[patient.patientFlow]}" var="data">
							<tr>
								<td width="12%">${org.centerNo}</td>
								<td width="17%">${org.orgName}</td>
								<td width="15%">${patient.patientCode}</td>
								<td width="18%">${visitMap[data.visitFlow].visitName}</td>
								<td width="13%">${data.elementSerialSeq}</td>
								<td width="25%">${isCode?codeMap[data.attrValue]:data.attrValue}</td>
							</tr>
						</c:forEach>
					</c:forEach>
				</c:forEach>
				<c:if test="${empty patientVisitDataMap}">
					<tr><td colspan="6">无记录</td></tr>
				</c:if>
			</table>
			
			<div id="lineChart" style="${empty observationCfgForm || isCode?'display: none;':''}height: 500px;width:80%;margin: auto 50px;">
     		</div>
     		
     		<div id="pieChart" style="${empty observationCfgForm || !isCode?'display: none;':''}height: 350px;width:80%;margin: auto 50px;">
     		</div>
		
	</div>
</div>
</body>
</html>