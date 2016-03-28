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
	<jsp:param name="jquery_fixedtable" value="true"/>
</jsp:include>

<script type="text/javascript">
	$(document).ready(function(){
		<c:if test="${(sessionScope.currWsId eq GlobalConstant.GCP_WS_ID) && (empty sessionScope.gcpCurrProj)}">
			selectProj();
		</c:if>
	});
	
	function selectProj(){
		jboxOpen("<s:url value='/gcp/researcher/userProjList'/>", "选择项目", 800, 600,false);
	}
	
	function refresh(){
		if($("#searchForm").validationEngine("validate")){
			location.href = "<s:url value='/gcp/researcher/followRemind'/>?remindDays="+$("[name='remindDays']").val();
		}
	}
	
	function patientNotice(patientFlow,projFlow,visitFlow){
		jboxConfirm("确认通知?",function(){
			jboxPost("<s:url value='/gcp/researcher/saveWindowNotice'/>?patientFlow="+patientFlow+"&projFlow="+projFlow+"&visitFlow="+visitFlow,null, function(data) {
				if('${GlobalConstant.OPRE_SUCCESSED}'==data){
					refresh(); 
				}
			});
		});
	}
	
	function visit(patientFlow){
		var url = "<s:url value='/gcp/researcher/visit'/>?beforePage=followRemind&patientFlow=" + patientFlow;
		window.location.href = url;
	}
</script>
</head>
<body>
<c:set value="${empty param.remindDays?sysCfgMap['default_remind_days']:param.remindDays}" var="remindDays"></c:set>
<c:if test="${'edc' eq sessionScope.currWsId }">
	<c:set value="${empty param.remindDays?sysCfgMap['ecrf_default_remind_days']:param.remindDays}" var="remindDays"></c:set>
</c:if>	
<div class="mainright">
	<div class="content">	
		<div class="title1 clearfix">
			<form id="searchForm">
				当前项目：
				<c:if test="${sessionScope.currWsId eq GlobalConstant.GCP_WS_ID}">
					<a title="点击切换项目" href="javascript:selectProj();" style="color:blue">${empty proj.projShortName?pdfn:cutString(proj.projName,10,true,3):proj.projShortName}</a>
				</c:if>
				<c:if test="${!(sessionScope.currWsId eq GlobalConstant.GCP_WS_ID)}">
					<font color="blue">${empty proj.projShortName?pdfn:cutString(proj.projName,10,true,3):proj.projShortName}</font>
				</c:if>
				 &#12288;&#12288;
				提前<input type="text" name="remindDays" value="${remindDays}" class="inputText validate[required,custom[number]]" style="width: 25px"/>天提醒&#12288;
				<input type="button" class="search" value="查&#12288;询" onclick="refresh();">
				<span style="float: right;margin-right: 10px">Tip：<font color="blue">蓝色</font>表示即将到期的访视，<font color="green">绿色</font>表示在访视期中，<font color="red">红色</font>表示已经过期的访视</span>
			</form>
			<div class="title1" style="margin-top: 5px;">
			<table class="xllist">
				<thead>
				<tr>
					<th width="8%">受试者编号</th>
					<th width="10%">受试者姓名缩写</th>
					<th width="5%">性别</th>
					<th width="7%">药物编号</th>
					<th width="10%">入组日期</th>
					<th width="8%">入组医生</th>
					<th width="10%">上次随访日期</th>
					<th width="10%">下次访视窗</th>
					<th width="15%">状态</th>
					<th width="10%">手机号</th>
					<th width="7%">${(sessionScope.currWsId eq GlobalConstant.GCP_WS_ID)?'操作':'是否通知'}</th>
				</tr>
				</thead>
				<tbody id="dataBody">
					<c:forEach items="${patientList}" var="patient">
						<c:set value="${patientVisitMap[patient.patientFlow]['remindDays']}" var="patientRemindDays"/>
						<c:set value="${patientVisitMap[patient.patientFlow]['outDays']}" var="patientOutDays"/>
						<tr 
						<c:choose>
							<c:when test="${(!empty patientRemindDays) && (patientRemindDays<=remindDays) && (patientRemindDays>0)}">
								style="background-color: skyblue;"
							</c:when>
							<c:when test="${(!empty patientOutDays) && (patientOutDays>0)}">
								style="background-color: pink;"
							</c:when>
							<c:when test="${(!empty patientRemindDays) && (patientRemindDays<=0) && (patientOutDays<=0)}">
								style="background-color: lightgreen;"
							</c:when>
						</c:choose>
							>
							<td width="8%">${patient.patientCode}</td>
							<td width="10%">${patient.patientNamePy}</td>
							<td width="5%">${patient.sexName}</td>
							<td width="7%">
								<c:forEach items="${patientDrugPackMap[patient.patientFlow]}" var="drugPack" varStatus="first">
									${first.first?'':','}${drugPack}
								</c:forEach>
							</td>
							<td width="10%">${pdfn:transDate(patient.inDate)}</td>
							<td width="8%">${patient.inDoctorName}</td>
							<td width="10%">${patientVisitMap[patient.patientFlow]['beforeVisit'].visitDate}</td>
							<td width="10%" style="Line-height:20px;">
							<c:if test="${!empty patientVisitMap[patient.patientFlow]['nextWindow'] && !empty patientVisitMap[patient.patientFlow]['nextWindow'].windowVisitLeft && !empty patientVisitMap[patient.patientFlow]['nextWindow'].windowVisitRight}">
								${patientVisitMap[patient.patientFlow]['nextWindow'].windowVisitLeft}<div  style="Line-height:8px;">~</div>${patientVisitMap[patient.patientFlow]['nextWindow'].windowVisitRight}
							</c:if>
							</td>
							<td width="15%">
								<c:if test="${(!empty patientRemindDays) && (patientRemindDays>0)}">
									距下次访视&nbsp;${patientRemindDays}&nbsp;天
								</c:if>
								<c:if test="${(!empty patientOutDays) && (patientOutDays>0)}">
									已超窗&nbsp;${patientOutDays}&nbsp;天
								</c:if>
								<c:if test="${(!empty patientRemindDays) && (patientRemindDays<=0) && (patientOutDays<=0)}">
									访视ing...
								</c:if>
							</td>
							<td width="10%">${patient.patientPhone}</td>
							<td width="7%">
								<c:if test="${!empty patientVisitMap[patient.patientFlow]['nextWindow'] && patientVisitMap[patient.patientFlow]['nextWindow'].isNotice eq GlobalConstant.FLAG_Y}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>">
								</c:if>
								<c:if test="${!empty patientVisitMap[patient.patientFlow]['nextWindow'] && !(patientVisitMap[patient.patientFlow]['nextWindow'].isNotice eq GlobalConstant.FLAG_Y) && (!empty patientRemindDays) && (patientRemindDays<=remindDays) && (patientRemindDays>0)}">
									[<a href="javascript:patientNotice('${patient.patientFlow}','${patient.projFlow}','${patientVisitMap[patient.patientFlow]['nextWindow'].visitFlow}');">通知</a>]
								</c:if>
								<c:if test="${(!empty patientRemindDays) && (patientRemindDays<=0) && (patientOutDays<=0) && (sessionScope.currWsId eq GlobalConstant.GCP_WS_ID)}">
									[<a href="javascript:visit('${patient.patientFlow}');">访视</a>]
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
				<c:if test="${empty patientList }">
					<tr><td align="center" colspan="11">无记录</td></tr>
				</c:if>
			</table></div>
		</div></div></div>
</body>
</html>