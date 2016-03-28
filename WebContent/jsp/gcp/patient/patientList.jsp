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
	<jsp:param name="jquery_fixedtable" value="false"/>
</jsp:include>

<script type="text/javascript">
	$(document).ready(function(){
		<c:if test="${empty param.type}">
			$("#in").attr("checked",true);
			selPatient("${patientStageEnumIn.id}");
		</c:if>
		<c:if test="${empty sessionScope.gcpCurrProj}">
			selectProj();
		</c:if>
		countData();
		<c:if test="${not empty param.type}">
			selPatient("${param.type}");
		</c:if>
	});
	
	function selectProj(){
		jboxOpen("<s:url value='/gcp/researcher/userProjList'/>", "选择项目", 800, 600,false);
	}
	
	function selPatient(type){
		$(".selPatientBox[value!='"+type+"']").attr("checked",false);
		if($(".selPatientBox:checked").length>0){
			$("#data tr").hide();
			if(type == "${patientStageEnumIn.id}"){
				$("._${patientStageEnumFinish.id}").show();
				$("._${patientStageEnumOff.id}").show();
			}
			$("._"+type).show();
		}else{
			$("#data tr").show();
		}
		countData();
	}
	
	function countData(){
		if($("#data tr").not(":hidden").length>0){
			$("#dataFoot").hide();
		}else{
			$("#dataFoot").show();
		}
	}
	
	function refresh(type){
		location.href = "<s:url value='/gcp/researcher/patientList'/>?type="+type;
	}
	
	function addPatient(){
		if(${!empty visitList}){
			jboxOpen("<s:url value='/gcp/researcher/addPatient'/>","受试者筛选",700,450);
		}else{
			jboxTip("请先为该项目维护访视!");
		}
	}
	
	function editPatient(patientFlow){
		jboxOpen("<s:url value='/gcp/researcher/editPatient'/>?patientFlow="+patientFlow+"&type="+$(".selPatientBox:checked").val(),"编辑受试者",700,250);
	}
	
	function record(patientFlow){
		jboxOpen("<s:url value='/gcp/researcher/drugRecord'/>?patientFlow="+patientFlow,"发药记录",950,400);
	}
	function editRecipe(patientFlow){
		<c:if test="${empty drugList}">
			jboxTip("该项目尚无试验用药!");
			return;
		</c:if>
		jboxOpen("<s:url value='/gcp/researcher/editRecipe'/>?patientFlow="+patientFlow+"&type="+$(".selPatientBox:checked").val(),"添加处方",700,450);
	} 
	function editAe(patientFlow, orgFlow, patientCode, patientNamePy){
		var url = "<s:url value='/gcp/researcher/aeList'/>?type=GCP&patientFlow=" + patientFlow + "&orgFlow=" + orgFlow +"&patientCode=" +patientCode + "&patientNamePy="+patientNamePy;
		window.location.href = url;
	}
	function choosePatient(){
		var url = "<s:url value='/gcp/researcher/choosePatient'/>";
		jboxOpen(url,"选择受试者",800,500);
	}
	
	function finishPatient(patientFlow) {
		jboxConfirm("确认该受试者已完成所有访视并结束临床试验观察吗？",  function() {
			jboxPost( "<s:url value='/gcp/researcher/changePatientStage?patientFlow='/>"+patientFlow+"&patientStageId=${patientStageEnumFinish.id}",null,function(resp){
				if(resp == '${GlobalConstant.SAVE_SUCCESSED}'){
					window.location.reload();
				}
			},null,true);
		});
	}
	
	function patientStageNote(patientFlow) {
		jboxOpen("<s:url value='/gcp/researcher/patientStageNote?patientFlow='/>"+patientFlow, "脱落原因", 500, 300);
	}
	
	function visit(patientFlow){
		var url = "<s:url value='/gcp/researcher/visit'/>?beforePage=patientList&patientFlow=" + patientFlow;
		window.location.href = url;
	}
	
	function visitWindow(patientFlow){
		jboxOpen("<s:url value='/gcp/researcher/windowInfo'/>?patientFlow=" + patientFlow,"访视窗信息",800,600);
	}
</script>
</head>
	<body>
		<div class="mainright">
	<div class="content">	
		<div class="title1 clearfix">
			<div>
				当前项目：<a title="点击切换项目" href="javascript:selectProj();" style="color:blue">${empty proj.projShortName?pdfn:cutString(proj.projName,10,true,3):proj.projShortName}</a> &#12288;&#12288;
				<input type="checkbox" class="selPatientBox" onclick="selPatient(this.value);" ${param.type eq patientStageEnumExclude.id?"checked='true'":""} value="${patientStageEnumExclude.id}" id="exclude"/><label for="exclude">${patientStageEnumExclude.name}</label>&#12288;
				<input type="checkbox" class="selPatientBox" onclick="selPatient(this.value);" ${param.type eq patientStageEnumIn.id?"checked='true'":""} value="${patientStageEnumIn.id}" id="in"/><label for="in">${patientStageEnumIn.name}</label>&#12288;
				<input type="checkbox" class="selPatientBox" onclick="selPatient(this.value);" ${param.type eq patientStageEnumFinish.id?"checked='true'":""} value="${patientStageEnumFinish.id}" id="finish"/><label for="finish">${patientStageEnumFinish.name}</label>&#12288;
				<input type="checkbox" class="selPatientBox" onclick="selPatient(this.value);" ${param.type eq patientStageEnumOff.id?"checked='true'":""} value="${patientStageEnumOff.id}" id="off"/><label for="off">${patientStageEnumOff.name}</label>&#12288;
				<input type="button" style="float: right;" value="新增AE" class="search" onclick="choosePatient();"/>
				<input type="button" style="float: right;" value="受试者筛选" class="search" onclick="addPatient();"/>
			</div>
			<div class="title1" style="margin-top: 10px;">
			<table class="xllist">
				<thead>
				<tr id="top">
					<th width="7%">受试者编号</th>
					<th width="10%">受试者姓名缩写</th>
					<th width="10%">知情同意日期</th>
					<th width="8%">药物编码</th>
					<th width="10%">入组日期</th>
					<th width="8%">入组医生</th>
					<th width="8%">状态</th>
					<th width="8%">发药记录</th>
					<th width="26%">操作</th>
				</tr>
				</thead>
				<tbody id="data">
					<c:forEach items="${patientList}" var="patient">
						<tr class="_${patient.patientStageId}">
							<td>${patient.patientCode}</td>
							<td>${patient.patientNamePy}</td>
							<td>${patient.icfDate}</td>
							<td>
								<c:forEach items="${patientDrugPackMap[patient.patientFlow]}" var="drugPack" varStatus="first">
									${first.first?'':','}${drugPack}
								</c:forEach>
							</td>
							<td>${pdfn:transDate(patient.inDate)}</td>
							<td>${patient.inDoctorName}</td>
							<td>${patient.patientStageName}</td>
							<td>
								<c:if test="${!(patientStageEnumExclude.id eq patient.patientStageId)}">
									[<a href="javascript:record('${patient.patientFlow}');">发药记录</a>]
								</c:if>
								${patientStageEnumExclude.id eq patient.patientStageId?'-':''}
							</td>
							<td style="text-align: left; padding-left: 20px;">
								<c:if test="${patientStageEnumIn.id eq patient.patientStageId}">
									<a style="color: blue;" href="javascript:editPatient('${patient.patientFlow}');">编辑</a>
									&nbsp;|&nbsp;
									<a style="color: blue;" href="javascript:visit('${patient.patientFlow}');">访视</a>
									&nbsp;|&nbsp;
									<a style="color: blue;" href="javascript:finishPatient('${patient.patientFlow}');">完成</a>
									&nbsp;|&nbsp;
									<a style="color: blue;" href="javascript:patientStageNote('${patient.patientFlow}');">脱落</a>
									&nbsp;|&nbsp;
									<a style="color: blue;" href="javascript:visitWindow('${patient.patientFlow}');">访视窗</a>
								</c:if>
								<c:if test="${not empty patientAeMap[patient.patientFlow]}">
									<c:if test="${patientStageEnumIn.id eq patient.patientStageId}">
										&nbsp;|&nbsp;
									</c:if>
									<a style="color: blue;" href="javascript:editAe('${patient.patientFlow}','${patient.orgFlow}','${patient.patientCode}','${patient.patientNamePy}');">AE</a>
								</c:if>
								<c:if test="${patientStageEnumOff.id eq patient.patientStageId }">
									<c:if test="${not empty patientAeMap[patient.patientFlow]}">
										&nbsp;|&nbsp;
									</c:if>
									<a href="javascript:void(0)" onclick="patientStageNote('${patient.patientFlow}')" style="color: blue;">脱落原因</a>
								</c:if>
								
							</td>
						</tr>
					</c:forEach>
				</tbody>
				<tr id="dataFoot"><td align="center" colspan="10">无记录</td></tr>
			</table></div>
		</div></div></div>
</body>
</html>