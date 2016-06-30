
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
	margin-top: -29px;
	margin-left: -16px;
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
	height: 82px;
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
	function showProjInfo(projFlow){
		$("."+projFlow).toggle();
	}
	function intoProj(projFlow,roleFlow){
		jboxStartLoading();
		window.location.href = "<s:url value='/medroad/index'/>?projFlow="+projFlow+"&roleFlow="+roleFlow;
		//jboxLoad("container","<s:url value='/medroad/index'/>?projFlow="+projFlow+"&roleFlow="+roleFlow);
	}
	function joinProj(projFlow){
		if(${empty sessionScope.currUser.orgFlow}){
			jboxTip("您的资料未完善,请联系管理员!");
			return false;
		}
		jboxConfirm("确认以研究者的身份参与该项目?",function(){
			jboxGet("<s:url value='/medroad/joinProj'/>?projFlow="+projFlow,null,function(resp){
				if(resp == '${GlobalConstant.SAVE_SUCCESSED}'){
					intoProj(projFlow,'${GlobalConstant.REACHER_ROLE_FLOW}');
				} 
			},null);
		});
	}

	$(document).ready(function(){
		jboxEndLoading();
	});
</script>

	<div class="content" style="margin-top: 15px;height:100%" id="horz">
						<c:forEach items="${ProjInfoFormList }" var="projForm">
								<table class="reorder">
									<tr>
										<td style="width: 47px;">
										<c:if test="${!empty roleMap[projForm.proj.projFlow] }">
											<div class="sch_img_1">
												<img alt="" src="<s:url value='/css/skin/${skinPath}/images/yck_1.png'/>">
											</div>
										</c:if>
										<c:if test="${empty roleMap[projForm.proj.projFlow] }">
											<div class="sch_img_1">
												<img alt="" src="<s:url value='/css/skin/${skinPath}/images/wrk_1.png'/>">
											</div>
										</c:if>
										</td>
										<td
											style="text-align: left;  padding-left: 45px;" onclick="showProjInfo('${projForm.proj.projFlow}');">
											<h3>${projForm.proj.projName }</h3>
											<p style="margin-top: 10px;">项目类型：${projForm.proj.projSubTypeName } &#12288;&#12288;
											计划病例数：${projForm.caseCount}&#12288;&#12288;适应症：${projForm.indication}&#12288;<br/>申办单位：${projForm.proj.projShortDeclarer}</p>
										</td>
										<td width="100px;">${sysRoleMap[roleMap[projForm.proj.projFlow]].roleName }</td>
										<td style="text-align: right;width: 100px;">
											<c:choose>
											<c:when test="${empty roleMap[projForm.proj.projFlow] }">
											 	<div class="sch_date_item" onclick="joinProj('${projForm.proj.projFlow}');">参加研究</div>
											 </c:when> 
											 <c:otherwise>
												<div class="sch_date_item btn_green" style="color:#ffffff" onclick="intoProj('${projForm.proj.projFlow}','${roleMap[projForm.proj.projFlow] }');">进入>></div>
											</c:otherwise>
											</c:choose>
										</td>
									</tr>
							</table>	
							<table class="${projForm.proj.projFlow }" style="margin-bottom: 20px;border: 1px solid #ddd;border-top: 0px;width: 100%;display: none;">
								<tr><td  style="padding-left: 20px;padding-top:20px;font-size: 16px;">项目介绍：</td></tr>
								<tr><td  style="padding-left: 20px;font-size: 14px;width: 100%"><pre style="font-family: Microsoft Yahei;line-height:25px;white-space: pre-wrap ">
								${projForm.info}</pre>
								</td></tr>
							</table>
						</c:forEach>
						</div>
					