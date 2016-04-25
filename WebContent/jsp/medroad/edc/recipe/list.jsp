<link rel="stylesheet" type="text/css" href="<s:url value='/css/slideRight.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/slideRight.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<style type="text/css">
.top-tab,.content {
	margin: 0 20px;
}

.top-innder {
	position: relative;
	height: 50px;
}

.top-sx {
	position: absolute;
	display: block;
	top: 50%;
	margin-top: -16px;
	left: 35px;
}

.sch {
	width: 245px;
	height: 216px;
	float: left;
	margin-right: 10px;
	border: 1px #ccc solid;
	margin-top: 15px;
	cursor: pointer;
}

.sch_top {
	padding: 10px;
	border-bottom: 1px #ccc solid;
	height: 46px;
}

.sch_top h3 {
	margin-bottom: 5px;
	color: #3d91d5;
	font-size: 15px;
	font-weight: normal;
}

.sch_top p,.reorder p {
	color: #5A5A5A;
}

.sch_img_1 {
	width: 48px;
	float: right;
	margin-top: -20px;
	margin-left: -54px;
}

.sch_img {
	width: 48px;
	float: right;
	margin-top: -10px;
	margin-right: -16px;
}

.sch_title,.sch_info {
	float: left;
	margin-left: 10px;
	width: 157;
	color: #A3A3A3;
}

.sch_body {
	clear: both;
	padding: 10px 10px;
	height: 60px;
}

.sch_jd {
	width: 55px;
	float: left;
	height: 60px;
	line-height: 46px;
	text-align: center;
	vertical-align: middle;
}

.sch_date {
	clear: both;
	text-align: center;
	width: 245px;
	height: 40px;
	padding-top: 15px;
}

.sch_date_item {
	width: 90px;
	height: 30px;
	text-align: center;
	vertical-align: middle;
	display: inline-block;
	line-height: 30px;
	border: 1px #ccc solid;
	color: #A8A8A8;
	margin-right: 10px;
}

.sch_info p {
	margin-bottom: 5px;
}

.btn-group,.btn-group-vertical {
	position: relative;
	display: inline-block;
	vertical-align: middle;
}

.select {
	padding: 4px 0;
	vertical-align: middle;
	border: 1px solid #e7e7eb;
	border-radius: 3px;
	-moz-border-radius: 3px;
	-webkit-border-radius: 3px;
	font-size: 14px;
	color: #363636;
	font-family: "Microsoft YaHei";
}

.btn-sm {
	padding: 0;
	line-height: 50px;
}

.icon-th-large {
	background:
		url("<s:url value='/css/skin/${skinPath}/images/th_larger_g1.png'/>");
	background-repeat: no-repeat;
	background-position: 0px center;
	padding: 12px 22px;
}

.icon-reorder {
	background:
		url("<s:url value='/css/skin/${skinPath}/images/reorder_w1.png'/>");
	background-repeat: no-repeat;
	background-position: 0px center;
	padding: 12px 22px;
}

.icon-large {
	background:
		url("<s:url value='/css/skin/${skinPath}/images/th_larger_w1.png'/>");
	background-repeat: no-repeat;
	background-position: 0px center;
	padding: 12px 22px;
}

.icon-th-reorder {
	background:
		url("<s:url value='/css/skin/${skinPath}/images/reorder_g1.png'/>");
	background-repeat: no-repeat;
	background-position: 0px center;
	padding: 12px 22px;
}

.icon-head {
	background:
		url("<s:url value='/css/skin/${skinPath}/images/audit_tec.png'/>");
	background-repeat: no-repeat;
	background-position: 0px center;
	padding: 12px 22px;
}

.reorder {
	border: 1px solid #ddd;
	width: 100%;
	margin-top:20px;
	cursor: pointer;
}

.reorder h3 {
	color: #3d91d5;
	font-size: 18px;
	font-weight: normal;
}

#userInfo {
	position: absolute;
	background-color: #fff;
	padding: 10px;
	border: 1px solid #dcdcdc;
	width: 290px;
	right: -128px;
}

.icon_up {
	background-image:
		url("<s:url value='/css/skin/${skinPath}/images/up2.png'/>");
	background-repeat: no-repeat;
	background-position: top center;
	padding: 5px;
	position: absolute;
	top: -6px;
	left: 150px;
}

.xllist caption {
	padding-bottom: 10px;
	font-weight: bold;
	font-size: 15px;
	color: #3d91d5;
}

.pxxx {
	position: absolute;
	right: 130px;
}
</style>
<script>

	$(document).ready(function(){
		jboxEndLoading();
	});
	function recipeInputData(visitFlow){
		$(".tab_select").addClass("tab");
		$(".tab_select").removeClass("tab_select");
		$(" .title_tab  li:last").removeClass("tab");
		$(".title_tab li:last").addClass("tab_select");
		 datainput(visitFlow,'');
	}
	$(function(){
		$("#detail").slideInit({
			width:800,
			speed:500,
			outClose:true
		});
	});
	function loadDetail(visitFlow){
		jboxStartLoading();
		jboxGet("<s:url value='/medroad/recipeContent'/>?visitFlow="+visitFlow,null,function(resp){
			$("#detail").html(resp).rightSlideOpen();
			jboxEndLoading();
		},function(){jboxEndLoading();},false);
	}
</script>

	<div class="content" style="margin-top: 15px;height:100%" id="horz">
								<c:set var="leftDate" value=""/>
								<c:set var="rightDate" value=""/>
						<c:forEach items="${visitList }" var="visit">
							<c:if test="${visit.isVisit == GlobalConstant.FLAG_Y }">
								<table class="reorder">
									<tr onclick="loadDetail('${visit.visitFlow}');">
										<td style="width: 47px;height: 50px;">
										<c:if test="${!empty patientVisitMap[visit.visitFlow] }">
											<div class="sch_img_1">
												<img alt="" style="height: 30px;margin-top: 15px;margin-left: 10px;" title="已访视" src="<s:url value='/css/skin/${skinPath}/images/doctor.png'/>">
											</div>
										</c:if>
										<c:if test="${empty patientVisitMap[visit.visitFlow] }">
											<div class="sch_img_1">
												<img alt=""  style="height: 35px;margin-top: 15px;margin-left: 10px;" title="未访视" src="<s:url value='/css/skin/${skinPath}/images/calendar.png'/>">
											</div>
										</c:if>
										</td>
										<td
											style="text-align: left;width:200px;  padding-left: 25px;" >
											<h3>${visit.visitName }</h3>
										</td>
										<td width="300px;" style="text-align: left;">	
											<c:if test="${!empty patientVisitMap[visit.visitFlow].visitDate }">
												访视日期：<span class="${visit.visitFlow}_visitDate">${patientVisitMap[visit.visitFlow].visitDate }</span>
											<c:if test="${!empty windowMap[visit.visitFlow] }">
												<c:set var="leftDate" value="${windowMap[visit.visitFlow].windowVisitLeft }"/>
												<c:set var="rightDate" value="${windowMap[visit.visitFlow].windowVisitRight }"/>
											</c:if>
										</c:if>
										<c:if test="${empty patientVisitMap[visit.visitFlow].visitDate && visit.isVisit == GlobalConstant.FLAG_Y && !empty leftDate}">
											<div class="sch_date_item" style="width: 350px;">
												访视窗：${leftDate}&#12288;~&#12288;${rightDate}(距今${pdfn:signDaysBetweenTowDate(leftDate,pdfn:getCurrDate()) }天)
												<c:set var="leftDate" value=""/>
												<c:set var="rightDate" value=""/>
											</div>
											</c:if>
										</td>
										<td style="text-align: right;width: 100px;">
										 	<div class="sch_date_item" onclick="recipeInputData('${visit.visitFlow}');">病例录入</div>
										</td>
									</tr>
							</table>	
							</c:if>
						</c:forEach>
						</div>
						<div class="slideRightDiv" id="detail" style='background: url("/pdsci/css/skin/Blue/images/detail_shadow.jpg") repeat-y left; top: 0px; width: 800px; height: 100%; right: 0px; padding-left: 11px; display: block; position: fixed; z-index: 1000;'>
							
</div>
					