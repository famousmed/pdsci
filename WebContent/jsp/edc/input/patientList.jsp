<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="jquery_fixedtable" value="true"/>
	<jsp:param name="jquery_fixedtable" value="true"/>
</jsp:include>
<style>
.divPic{background-image: url('<s:url value='/css/skin/${skinPath}/images/gou.gif' />');background-repeat: no-repeat;background-position: center;}
.viewTd img {border: 0;position: relative;vertical-align: middle;}
</style>

<script type="text/javascript" defer="defer">
	function doInput(patientFlow,visitFlow,currOperFlow,obOperFlow){
		<c:if test="${projParam.inputLock == GlobalConstant.FLAG_Y || projParam.projLock == GlobalConstant.FLAG_Y }">
			jboxTip("当前项目已锁定录入!");
			return;
		</c:if>
		<c:if test="${edcProjOrg.inputLock == GlobalConstant.FLAG_Y}">
			jboxTip("当前机构已锁定录入!");
			return;
		</c:if>
		<c:if test="${edcProjOrg.normalValueLock  !=  GlobalConstant.FLAG_Y && patientTypeEnumReal.id == patientType}">
			jboxTip("当前机构未提交正常者范围,无法录入!");
			return;
		</c:if>
		
		
		if(currOperFlow!=""){
			if(currOperFlow != "${sessionScope.currUser.userFlow}"){ 
				jboxTip("您不是当前录入员，不能进行录入!");
				return;
			}
		}else if(currOperFlow=="" && obOperFlow!="" ){
			if(obOperFlow == "${sessionScope.currUser.userFlow}"){
				jboxTip("您已录入过数据，不能进行录入!");
				return;
			}
		}
		
		if ("${patientTypeEnumReal.id}" == "${patientType}") {
			jboxGet("<s:url value='/edc/input/editPatientConfirm'/>?patientFlow="+patientFlow,null,function(resp){
				if(resp == '${GlobalConstant.OPERATE_SUCCESSED}'){
					jboxOpen("<s:url value='/edc/input/editPubPatient'/>?patientScope=${patientScope}&patientType=${patientType}&patientFlow="
							+ patientFlow+"&visitFlow="+visitFlow, "病人基本信息", 500, 325);
				}else {
					window.location.href="<s:url value='/edc/input/inputMain?patientScope=${patientScope}&patientType=${patientType}&inputType=${param.inputType}&groupFlow=${groupFlow}&patientFlow='/>"+patientFlow+"&visitFlow="+visitFlow;
				}
			},null,false);
		} else {
			window.location.href="<s:url value='/edc/input/inputMain?patientScope=${patientScope}&patientType=${patientType}&inputType=${param.inputType}&groupFlow=${groupFlow}&patientFlow='/>"+patientFlow+"&visitFlow="+visitFlow;
		}
	}
	
	function showInput(patientFlow,visitFlow,inputOper1Flow,inputOper2Flow){
		if("${sessionScope.currUser.userFlow}" != inputOper1Flow && "${sessionScope.currUser.userFlow}" != inputOper2Flow){ 
			jboxTip("您不是该受试者该次访视的录入员，不能查看!");
			return;
		}
		window.location.href="<s:url value='/edc/input/inputMain?patientScope=${patientScope}&patientType=${patientType}&inputType=${param.inputType}&groupFlow=${groupFlow}&patientFlow='/>"+patientFlow+"&visitFlow="+visitFlow;
	}
	
	$(document).ready(function(){
		init();
	});
	
	function init(){
		$(".viewTd").hover(function() {
			$(this).find("span").stop().animate({left: "210", opacity:1}, "slow").css("display","block");
		},function(){
			$(this).find("span").stop().animate({left: "0", opacity: 0}, "slow");
		});
	}
	<c:if test="${fn:length(patientList)>0}">
	$(document).ready(function() {
        var Id = "tableDiv";
        var maintbheight = $('.mainright').height()-100;
        var maintbwidth = $('.mainright').width()-50;
        
        $("#" + Id + " .FixedTables").fixedTable({
            width: maintbwidth,
            height: maintbheight,
            fixedColumns: 2,
            classHeader: "fixedHead",
            classFooter: "fixedFoot",
            classColumn: "fixedColumn",
            fixedColumnWidth: 150,
            outerId: Id
            //Contentbackcolor: "#187BAF",
           	//Contenthovercolor: "#fbf8e9",
            //fixedColumnbackcolor:"#187BAF",
            //fixedColumnhovercolor:"#fbf8e9"
        });
    });
	</c:if>
</script>
<style>
.wechatApp-contact {
border: 1px solid #b8b8b8;
border-radius: 10px;
height: 130px;
margin: 18px 10px 0 10px;
background: #f8f8f8;
position: relative;
padding: 15px 124px 0 10px;
-webkit-box-shadow: 1px 0 2px rgba(255,255,255,.6) inset;
box-shadow: 1px 0 2px rgba(255,255,255,.6) inset;
}
.wechat-noresult {
margin-top: 25px;
font-size: 18px;
color: #b7b7b7;
}
</style>
</head>
	<body>
		<div id="tableDiv">
		<c:if test="${!empty visitList && !empty patientList}">
		<table id="patientFixedTable" class="xllist FixedTables">
			<thead>
			<tr>
				<th style="width:50px;" title="序号">序号</th>
				<th style="width:100px;" title="受试者编码">受试者编码</th>
				<c:forEach items="${visitList }" var="visit">
					<th title="${visit.visitName }">${pdfn:cutString(visit.visitName,14,true,1)}</th>
				</c:forEach>				
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${patientList}" var="patient">
				<tr style="height: 20px">
					<td style="width:50px;">${patient.patientSeq}</td>
					<td style="width:100px;">${patient.patientCode}</td>
					<c:forEach items="${visitList }" var="visit">
						<c:set var="edcPatientVisit" value="${patientVisitMap[patient.patientFlow][visit.visitFlow].edcPatientVisit }"/>
						<td class="viewTd" style="text-align: left;">
							<div style="width:220px;">
								<c:if test="${projInputTypeEnumDouble.id eq projParam.inputTypeId && projInputTypeEnumSingle.id != param.inputType}"> <!-- 双份录入 -->
										<c:if test="${edcPatientVisit.inputOperStatusId eq edcInputStatusEnumChecked.id}">
											&#12288;<img src="<s:url value='${pdfn:getInputStatusPic(projParam.inputTypeId,edcPatientVisit)}'/>" />&#12288;
											<a href="javascript:showInput('${patient.patientFlow }','${visit.visitFlow }','${edcPatientVisit.inputOper1Flow }','${edcPatientVisit.inputOper2Flow }')">
											查看
											</a>
										</c:if>
										<c:if  test="${edcPatientVisit.inputOperStatusId != edcInputStatusEnumChecked.id}">
											<c:if test="${!empty edcPatientVisit.inputOper1StatusId}"> 
											&#12288;
											<a href="javascript:doInput('${patient.patientFlow }','${visit.visitFlow }','${edcPatientVisit.inputOper1Flow }','${edcPatientVisit.inputOper2Flow }')">
											${edcPatientVisit.inputOper1Name}
											</a>
											<img src="<s:url value='${pdfn:getSinglePic(edcPatientVisit.inputOper1StatusId)}'/>" />&#12288;录二：
											<a style="color: ${!empty edcPatientVisit.inputOper2Name?'':'blue'};" href="javascript:doInput('${patient.patientFlow }','${visit.visitFlow }','${edcPatientVisit.inputOper2Flow }','${edcPatientVisit.inputOper1Flow }')">
											${ !empty edcPatientVisit.inputOper2Name ?edcPatientVisit.inputOper2Name:"点击录入" }
											</a>
											<c:if test="${!empty pdfn:getSinglePic(edcPatientVisit.inputOper2StatusId)}">
											 <img src="<s:url value='${pdfn:getSinglePic(edcPatientVisit.inputOper2StatusId)}'/>" />
											</c:if>
											</c:if>
										</c:if>
										<c:choose>
											<c:when test="${empty edcPatientVisit.inputOper1StatusId && empty edcPatientVisit.inputOper1StatusId }">
												<span style="display: none;">&#12288;
													<a style="color: blue;" href="javascript:doInput('${patient.patientFlow }','${visit.visitFlow }','${edcPatientVisit.inputOper1Flow }','${edcPatientVisit.inputOper2Flow }')">${ !empty edcPatientVisit.inputOper1Name ?edcPatientVisit.inputOper1Name:"点击录入" }</a><br/>
												</span>
											</c:when>
											<c:otherwise>
											</c:otherwise>
										</c:choose>
								</c:if>
								<c:if test="${projInputTypeEnumSingle.id eq projParam.inputTypeId || projInputTypeEnumSingle.id eq param.inputType}"> <!-- 单份录入 -->
								<c:set var="projInputTypeId" value="${empty param.inputType?projParam.inputTypeId:param.inputType }"></c:set>
								&#12288;&#12288;&#12288;&#12288;<img src="<s:url value='${pdfn:getInputStatusPic(projInputTypeId,edcPatientVisit)}'/>" />
									<span style="display: none;float: right">
											录入员：<a style="color: blue;" href="javascript:doInput('${patient.patientFlow }','${visit.visitFlow }','${edcPatientVisit.inputOperFlow }','')">${ !empty edcPatientVisit.inputOperName ?edcPatientVisit.inputOperName:"点击录入" }</a>&#12288;
									</span>
								</c:if>
							</div>
						</td>
					</c:forEach>
				</tr>
			</c:forEach>
			</tbody>
			<c:if test="${empty patientList}"> 
				<tr> 
					<c:set var="visitNum" value="${visitList == null?0:visitList.size() }"></c:set>
					<td align="center" colspan="${visitNum+2}">无记录</td>
				</tr>
			</c:if>
		</table>
		</c:if>
		<c:choose>
			<c:when test="${empty visitList }">
				<div class="wechatApp-contact">
					<h3 class="wechatAPP-mod-hd">提示:</h3>
					<div class="wechat-noresult">该项目暂未维护访视，请联系项目管理员!</div>
				</div>
			</c:when>
			<c:when test="${empty patientList }">
				<div class="wechatApp-contact">
					<h3 class="wechatAPP-mod-hd">提示:</h3>
					<div class="wechat-noresult">${param.orgFlow==''?'请先选择机构!':'该机构暂无入组受试者!' }</div>
				</div>
			</c:when>
		</c:choose>
	</div>
</body>
</html>