<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>

<style type="text/css">
	table.basic th,table.basic td{text-align: center;padding: 0;}
	table.basic a{color: blue;cursor: pointer;}
	
	.auditContent{width: 100%;margin-top: 10px;}
	.titleHome{width: 100%;}
	.resultHome{width: 100%;overflow: auto;height: 300px;}
	.deptList{float: left;width: 10%;margin-right: 10px;}
	.resultView{float: right;width: 89%;max-width:89%;}
	.resultItem:HOVER{background-color: #ccc;cursor: pointer;}
	.selMonth{background-color:pink;}
	.titleDiv{margin-bottom: 10px;font-size: 15px;}
	.titleDiv font{font-weight: bold;}
	#detailContent{}
	.selDoc{background-color: rgba(255, 192, 203, 0.5);}
</style>

<script type="text/javascript">
	function search(){
		$("#doctorSearchForm").submit();
	}

	String.prototype.htmlFormart = function(){
		var html = this;
		for(var index in arguments){
			var reg = new RegExp('\\{'+index+'\\}','g');
			html = html.replace(reg,arguments[index]);
		}
		return html;
	};
	
	function selMonth(schDeptName,schDeptFlow,month,item){
		$(".selMonth").removeClass("selMonth");
		$(item).addClass("selMonth");
		$(".doctorDetail").show();
		$("#currDept").text(schDeptName);
		$("#currMonth").text(month);
		$("#detailContent .doctorList").empty();
		var postData = "schDeptFlow="+schDeptFlow+"&month="+month+"&"+$("#doctorSearchForm").serialize();
		jboxPost("<s:url value='/sch/template/doctorDetailList'/>",postData,
			function(resp){
				var resultList = resp.resultList;
				var doctorMap = resp.doctorMap;
				if(resultList){
					for(var index in resultList){
						var docInfo = $("#doctorDetailList tbody").html();
						var doctor = doctorMap[resultList[index].doctorFlow];
						var display = (doctor.schStatusId == "${schStatusEnumAuditY.id}")?"none":"block";
						docInfo = docInfo.htmlFormart(resultList[index].doctorName,resultList[index].schStartDate,resultList[index].schEndDate,resultList[index].doctorFlow,schDeptFlow,month,display,doctor.schStatusId,resultList[index].resultFlow);
						$("#detailContent .doctorList").append(docInfo);
					}
					$("[onclick]").click(function(e){e.stopPropagation();});
				}else{
					$("#detailContent .doctorList").append('<tr><td colspan="3">无记录！</td></tr>');
				}
		},null,false);
	}
	
	function resultBack(doctorFlow,schDeptFlow,month){
		jboxConfirm("确认退回该学员的计划？",function(){
			jboxPost("<s:url value='/res/doc/confirmRosting'/>",{
				doctorFlow:doctorFlow,
				schStatusId:"",
				schStatusName:""
			},function(resp){
				if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
					top.jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					location.href="<s:url value='/sch/arrange/auditResult'/>?schDeptFlow="+schDeptFlow+"&month="+month+"&"+$("#doctorSearchForm").serialize();
				}
			},null,false);
		},null);
	}
	
	function auditComplate(){
		<c:if test="${empty monthList}">
			jboxTip("没有可审核对象！");
			return;
		</c:if>
		jboxConfirm("确认审核通过所有学员轮转计划（不含已退回学员）？",function(){
			jboxPost("<s:url value='/sch/template/auditComplate'/>",null,function(resp){
				if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
					top.jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					location.reload(true);
				}
			},null,false);
		},null);
	}
	
	$(function(){
		if("${param.schDeptFlow}"+"${param.month}"){
			$(".${param.schDeptFlow}${param.month}").click();
		}
		
		$("#doctorResultList").slideInit({
			width:500,
			speed:300,
			outClose:false,
			//outClose:function(){$(".selDoc").removeClass("selDoc");},
			haveZZ:false,
		});
	});
	
	function getResultList(doctorFlow,docTr,schStatusId,schDeptFlow,month,resultFlow){
		$(".selDoc").removeClass("selDoc");
		$(docTr).addClass("selDoc");
		jboxPost("<s:url value='/sch/template/doctorResultList'/>",{doctorFlow:doctorFlow},function(resp){
			var resultList = resp.resultList;
			if(resultList){
				$("#doctorResultContent").empty();
				for(var index in resultList){
					var docInfo = $("#resultListTemplate").html();
					docInfo = docInfo.htmlFormart(resultList[index].schDeptName,resultList[index].schStartDate,resultList[index].schEndDate);
					var styleStr = "";
					if(resultFlow == resultList[index].resultFlow){
						styleStr = 'style="color:red;"';
					}
					$("#doctorResultContent").append('<tr '+styleStr+'>'+docInfo+'</tr>');
				}
				if(schStatusId == "${schStatusEnumAuditY.id}"){
					$("#pass,#back").hide();
				}else{
					$("#pass,#back").off("click").show();;
					$("#pass").click(function(){
						doctorPassOrBack({
							doctorFlow:doctorFlow,
							schStatusId:"${schStatusEnumAuditY.id}",
							schStatusName:"${schStatusEnumAuditY.name}",
							schFlag:"${GlobalConstant.FLAG_Y}"
						},"通过",schDeptFlow,month);
					});
					$("#back").click(function(){
						doctorPassOrBack({
							doctorFlow:doctorFlow,
							schStatusId:"",
							schStatusName:""
						},"退回",schDeptFlow,month);
					});
				}
				$("#doctorResultList").rightSlideOpen();
			}else{
				$("#doctorResultContent").append('<tr><td colspan="2">无记录！</td></tr>');
			}
		},null,false);
	}
	
	function doctorPassOrBack(data,title,schDeptFlow,month){
		jboxConfirm("确认"+title+"该学员的计划？",function(){
			jboxPost("<s:url value='/res/doc/confirmRosting'/>",data,function(resp){
				if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
					top.jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					location.href="<s:url value='/sch/arrange/auditResult'/>?schDeptFlow="+schDeptFlow+"&month="+month+"&"+$("#doctorSearchForm").serialize();
				}
			},null,false);
		},null);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<form action="<s:url value='/sch/arrange/auditResult'/>" id="doctorSearchForm" method="post">
		<table class="basic" style="width: 100%;margin-top: 10px;">
			<tr>
				<td style="text-align: left;padding-left: 10px;">
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
					<input type="button" value="批量审核" class="search" style="float: right;margin-top: 5px;" onclick="auditComplate();"/>
				</td>
			</tr>
		</table>
		</form>
		<div class="auditContent">
			<div class="titleHome">
				<div class="deptList">
					<table class="basic" style="width: 100%;">
						<tr>
							<th>轮转科室</th>
						</tr>
					</table>
				</div>
				<div class="resultView">
					<table class="basic" style="width: 100%;">
						<tr>
							<c:forEach items="${monthList}" var="month">
								<th width="100px">${month}</th>
							</c:forEach>
							<c:if test="${empty monthList}">
								<th width="100%">无记录</th>
							</c:if>
						</tr>
					</table>
				</div>
			</div>
			
			<div class="resultHome">
				<div class="deptList">
					<table class="basic" style="width: 100%;border-top: none;">
						<c:forEach items="${schDeptList}" var="schDept">
							<tr>
								<td>${schDept.schDeptName}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="resultView">
					<table class="basic" style="width: 100%;border-top: none;">
						<c:forEach items="${schDeptList}" var="schDept">
							<tr>
								<c:forEach items="${monthList}" var="month">
									<c:set value="${schDept.schDeptFlow}${month}" var="key"/>
									<td style="<c:if test="${resultSubmitCountMap[key]>0}">color:red;</c:if>" width="100px" class="resultItem  ${key}" onclick="selMonth('${schDept.schDeptName}','${schDept.schDeptFlow}','${month}',this);">${resultCountMap[key]+0}</td>
								</c:forEach>
							</tr>
							<c:if test="${empty monthList}">
								<td width="100%" style="height:36px;"></td>
							</c:if>
						</c:forEach>
					</table>
				</div>
			</div>
			<div class="doctorDetail" style="display: none;min-height: 200px;margin-bottom: 20px;">
				<div class="titleDiv">
					科室：<font id="currDept"></font>&#12288;轮转时间：<font id="currMonth"></font>
				</div>
				<table id="detailContent" class="basic" style="width: 80%;">
					<tr>
						<th width="20%">姓名</th>
						<th width="60%">轮转计划</th>
						<th width="20%">操作</th>
					</tr>
					<tbody class="doctorList">
						
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<div style="display: none;">
	<table id="doctorDetailList">
		<tbody>
			<tr style="cursor: pointer;" onclick="getResultList('{3}',this,'{7}','{4}','{5}','{8}');">
				<td>{0}</td>
				<td>{1} ~ {2}</td>
				<td><a style="display: {6};" onclick="resultBack('{3}','{4}','{5}');">退回</a></td>
			</tr>
		</tbody>
		<tr id="resultListTemplate">
			<td>{0}</td>
			<td>{1} ~ {2}</td>
		</tr>
	</table>
</div>
<div id="doctorResultList">
	<div style="height: 100%;width: 100%;background-color: white;padding-top: 10px;" align="center">
		<table class="basic" style="width: 90%;" >
			<tr>
				<th width="40%">科室名称</th>
				<th width="60%">轮转时间</th>
			</tr>
			<tbody id="doctorResultContent">
				
			</tbody>
		</table>
		<div id="changeOper" align="center" style="margin-top: 10px;">
			<input id="pass" value="通过" type="button" class="search"/>
			<input id="back" value="退回" type="button" class="search"/>
			<input value="关闭" type="button" class="search" onclick="$('#doctorResultList').rightSlideClose();"/>
		</div>
	</div>
</div>
</body>
</html>