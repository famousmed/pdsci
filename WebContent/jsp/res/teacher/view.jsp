<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/res/teacher/Style.css'/>"></link>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
</jsp:include>

<script type="text/javascript">
	function scroll(){
		setTimeout(function(){
			$(".list li:first").animate({marginTop : "-25px"},500,function(){
				$(".list").append($(this).css({marginTop : "0px"}));
				scroll();
			});
		},3000);
	}
	$(function(){
		if($(".list li").length>1){
			scroll();
		}
		
		//选择科室
// 		$("#selDeptImg,.tips_select").on("mouseenter mouseleave",function(){
// 			$(".tips_select").toggle();
// 		});
		
	});
	
	function changeDept(deptFlow){
		location.href = "<s:url value='/res/teacher/showView/${roleFlag}'/>?schDeptFlow="+deptFlow;
	}
	
	function goAudit(doctorName){
		$("#doctorName").val(doctorName);
		$("#doctorForm").submit();
		$("#dateAreaValue").val();
	}
	function edit(flow){
		var url="<s:url value='/res/teacher/showDocAndUser'/>?flow="+flow;
		jboxOpen(url, "信息", 1000, 500);
	}
	function afterAudit(rotationFlow,userFlow,processFlow){
		location.href="<s:url value='/res/rec/showRegistryForm'/>?roleFlag=${roleFlag}&recTypeId=${resRecTypeEnumAfterSummary.id}&rotationFlow="+rotationFlow+"&schDeptFlow=${schDeptFlow}&userFlow="+userFlow+"&processFlow="+processFlow+"&isView=true";
	}
	
// 	function evaluation(recFlow,schDeptFlow, rotationFlow, userFlow, schResultFlow){
// 		var url = "<s:url value='/res/rec/showRegistryForm'/>"+
// 				"?schDeptFlow="+schDeptFlow+
// 				"&rotationFlow="+rotationFlow+
// 				"&recTypeId=${resRecTypeEnumAfterEvaluation.id}&userFlow="+userFlow+
// 				"&roleFlag=${roleFlag}&openType=open"+
// 				"&resultFlow="+schResultFlow+
// 				"&recFlow="+recFlow;
// 		jboxOpen(url, "思想政治和工作态度", 1000, 500);
// 	}
	
	//选择日期区间
	function selDateArea(area,num){
		$(".selected").removeClass("selected");
		$(area).addClass("selected");
		$("#dateAreaValue").text(num);
	}
	
	//操作入科
	function openChoose(resultFlow,schDeptFlow){
		var url="<s:url value='/res/doc/showChoose' />?resultFlow="+resultFlow+"&schDeptFlow="+schDeptFlow+"&roleFlag=${roleFlag}&headUserFlow=${sessionScope.currUser.userFlow}";
		jboxOpen(url,"选择科主任和带教老师",400,200);
	}
	
	function teachPlan(){
		window.location.href="<s:url value='/res/teacher/teachPlanList'/>";
	}
	
	function defaultImg(img){
		img.src="<s:url value='/jsp/edu/css/images/up-pic.jpg'/>";
	}
</script>
</head>
<body>
<form id="doctorForm" action="<s:url value='/res/teacher/auditListContent'/>" method="post">
	<input id="doctorName" type="hidden" name="doctorName" />
	<input type="hidden" name="roleFlag" value="${roleFlag}" />
</form>
<div class="mainright">
<!--     <div class="tips"> -->
<!-- 		    <h1 class="tips_title">科室信息</h1> -->
<!-- 			<div class="tips_body"> -->
<%-- 				<div class="office" ><span id="selDeptImg"><strong>当前科室选择<img src="<s:url value='/css/skin/${skinPath}/images/down_red.png'/>"  border="0"  style="margin-top:0px;margin-left: 5px; vertical-align:middle;"></strong><br/>${schDeptName}</span></div> --%>
<!-- 				<div class="tips_select" style="display:none;"> -->
<%-- 				<c:forEach items="${schDeptList}" var="dept"> --%>
<%-- 					<p onclick="changeDept('${dept.schDeptFlow}');">${dept.schDeptName}</p> --%>
<%-- 				</c:forEach> --%>
<!-- 			</div> -->
				
<!-- 				 <div class="scroll_body"> -->
<!-- 				<dl class="count"> -->
<%-- 				<dt>当前轮转人数<span>${doctorList.size()+0}</span></dt> --%>
<%-- 					<c:forEach items="${categoryNum}" var="docCategory"> --%>
<%-- 						<dd>${docCategory.key}<span>${docCategory.value+0}</span></dd> --%>
<%-- 					</c:forEach> --%>
<!-- 				<dt><span></span></dt> -->
<%-- 				<dd style="text-indent:0;">预出科人数<span>${afterMap.size()+0}</span></dd> --%>
<%-- 				<dd style="text-indent:0;">预计下月入科人数<span>${willInDoctorList.size()+0}</span></dd> --%>
<!-- 				</dl> -->
<!-- 			  </div> -->
			  
<!-- 			  <h2 class="has"> -->
<!-- 				<span>已出科人数</span> -->
<!-- 				<dl> -->
<!-- 				  <dt class="dateArea"><a class="selected" onclick="selDateArea(this,10);">月</a><a onclick="selDateArea(this,20);">季</a><a onclick="selDateArea(this,30);">年</a></dt> -->
<!-- 				  <dd id="dateAreaValue">10</dd> -->
<!-- 				</dl> -->
<!-- 				</h2> -->
			  
				
<!-- 			</div> -->
<!-- 			<div class="tips_bottom_bg"></div> -->
<!--     </div> -->
	<div class="content" >
		<div>
			<table class="basic" style="margin-top: 10px; width:700px;float: left;">
				<tr>
				<td width="80px"> 最新通知：</td>
				<td width="500px">
				 <div class="scroll">  
					<ul class="list">
						 <c:forEach items="${infos}" var="info">
						 	<li><a href="<s:url value='/res/platform/noticeView'/>?infoFlow=${info.infoFlow}" target="_blank">${info.infoTitle}</a> <img src="<s:url value='/jsp/hbres/images/new.png'/>"/></li>  
						 </c:forEach>
						 <c:if test="${empty infos}">
						 	<li>暂无通知!</li>
						 </c:if>
	               </ul> 
	               </div> 
	               </td>
	               <td width="100px">
					<span style="text-align:center;"> <a href="<s:url value='/res/doc/noticeList'/>?fromSch=true&isView=true&roleFlag=${roleFlag}">>>查看更多</a></span>
					</td>
				</tr>
			</table> 
<!-- 			<div style="float: right;"> -->
<%-- 				<div class="office" style=""><span id="selDeptImg"><strong>当前科室选择<img src="<s:url value='/css/skin/${skinPath}/images/down_red.png'/>"  border="0"  style="margin-top:0px;margin-left: 5px; vertical-align:middle;"></strong><br/>${schDeptName}</span></div> --%>
<!-- 				<div class="tips_select" style="display:none;top: 40px;"> -->
<%-- 					<c:forEach items="${schDeptList}" var="dept"> --%>
<%-- 						<p onclick="changeDept('${dept.schDeptFlow}');">${dept.schDeptName}</p> --%>
<%-- 					</c:forEach> --%>
<!-- 				</div> -->
<!-- 			</div> -->
		</div>
		
<!-- 		<table id="links" class="basic" style="margin-top: 10px; "> -->
<%-- 			<tr><td  width="80px">快捷操作：</td><td style="text-align: center;cursor: pointer;width: 100px;" title="教学安排" onclick="teachPlan();"><img src="<s:url value='/css/skin/${skinPath}/images/icon_2.png'/>"/></td> --%>
<!-- 			<td style="text-align: center;cursor: pointer;width: 100px;">请假审批</td></tr> -->
<!-- 		</table> -->
		<div style="padding-top: 45px;">
		<table class="xllist" style="margin-top: 10px; width:100%;">
			<tr>
				<th colspan="99" style="text-align:left;padding-left: 10px; font-size:14px;font-weight:normal;font-weight: bold;">
					当前轮转学员信息
					<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
					<font style="float: right;margin-right: 10px;color: black;"><img src="<s:url value='/css/skin/${skinPath}/images/unchecked.png'/>" style="margin-top:-2px;"/> 待审核</font>
					</c:if>
				</th>
			</tr>
			<tr>
			<th style="width: 10%;">姓名</th>
			<th style="width: 5%;">性别</th>
			<th style="width: 10%;">手机</th>
			<th style="width: 10%;">入院时间</th>
			<th style="width: 10%;">人员类型</th>
			<th style="width: 10%;">轮转科室</th>
			<th style="width: 16%;">计划轮转时间</th>
			<th style="width: 10%;">入科时间</th>
<!-- 			<th>培训进度</th> -->
			<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
				<th>培训数据审核</th>
			</c:if>
			<th style="width: 10%;">状态</th>
<!-- 			<th>出科审核</th> -->
<!-- 			<th width="100px">带教老师</th> -->
<!-- 			<th width="100px">科主任</th> -->
			</tr>
<%-- 			<c:forEach items="${doctorList}" var="doctor"> --%>
			<c:forEach items="${processList}" var="process">
				<c:set var="doctor" value="${doctorMap[process.userFlow]}"/>
				<tr>
					<td onclick="edit('${doctor.doctorFlow}');" title="<img src='${sysCfgMap['upload_base_url']}/${userMap[doctor.doctorFlow].userHeadImg}' onerror='defaultImg(this);' style='width: 110px;height: 130px;'/>" style="cursor:pointer;"><a>${doctor.doctorName}</a></td>
					<td>${userMap[doctor.doctorFlow].sexName}</td>
					<td>${userMap[doctor.doctorFlow].userPhone}</td>
					<td>${doctor.inHosDate}</td>
					<td>${doctor.doctorCategoryName}</td>
					<td>${process.schDeptName}</td>
					<td>${process.schStartDate} ~ ${process.schEndDate}</td>
					<td>${process.startDate}</td>
<!-- 					<td> -->
<%-- 						${finishPreMap[doctor.doctorFlow]+0}% --%>
<%-- 						<c:if test="${(waitAuditMap[doctor.doctorFlow]+waitAuditAppealMap[doctor.doctorFlow])+0>0 && roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}"> --%>
<%-- 							<img title="去审核" src="<s:url value='/css/skin/${skinPath}/images/unchecked.png'/>" style="margin-top:-5px;cursor: pointer;" onclick="goAudit('${doctor.doctorName}');"/> --%>
<%-- 						</c:if> --%>
<!-- 					</td> -->
					<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
						<td>
							<c:if test="${(waitAuditMap[doctor.doctorFlow]+waitAuditAppealMap[doctor.doctorFlow])+0>0}">
								<img title="去审核" src="<s:url value='/css/skin/${skinPath}/images/unchecked.png'/>" style="margin-top:-5px;cursor: pointer;" onclick="goAudit('${doctor.doctorName}');"/>
							</c:if>
							<a style="cursor: pointer;color: blue;" onclick="goAudit('${doctor.doctorName}');">
								审核
							</a>
						</td>
					</c:if>
					<td>
						<c:set var="key" value="${doctor.doctorFlow}${process.schDeptFlow}"/>
						<c:if test="${process.schFlag eq GlobalConstant.FLAG_Y}">
							已出科
						</c:if>
						<c:if test="${!(process.schFlag eq GlobalConstant.FLAG_Y)}">
							<c:if test="${!empty afterMap[key] || !empty recMap[key]}">
								待出科
							</c:if>
							<c:if test="${!(!empty afterMap[key] || !empty recMap[key])}">
								轮转中
							</c:if>
						</c:if>
					</td>
<!-- 					<td> -->
<%-- 						<c:set var="afterKey" value="res_${afterRecTypeEnumAfterEvaluation.id}_form_flag"/> --%>
<%-- 						<c:if test="${GlobalConstant.FLAG_Y eq sysCfgMap[afterKey]}"> --%>
<%-- 							<c:set var="color" value="blue"/> --%>
<%-- 	  						<c:if test="${GlobalConstant.RES_ROLE_SCOPE_TEACHER eq roleFlag && !empty recMap[doctor.doctorFlow].auditStatusId}"> --%>
<%-- 	  							<c:set var="color" value="black"/> --%>
<%-- 	  						</c:if> --%>
<%-- 	  						<c:if test="${GlobalConstant.RES_ROLE_SCOPE_HEAD eq roleFlag && !empty recMap[doctor.doctorFlow].headAuditStatusId}"> --%>
<%-- 	  							<c:set var="color" value="black"/> --%>
<%-- 	  						</c:if> --%>
<%-- 	  						<c:if test="${GlobalConstant.RES_ROLE_SCOPE_MANAGER eq param.roleFlag && !empty recMap[doctor.doctorFlow].headAuditStatusId}"> --%>
<%-- 	  							<c:set var="color" value="black"/> --%>
<%-- 	  						</c:if> --%>
<%-- 	  						${param.roleFlag}[<a style="color: ${color};" href="javascript:void(0)" onclick="evaluation('${recMap[doctor.doctorFlow].recFlow}','${processMap[doctor.doctorFlow].schDeptFlow}','${doctor.rotationFlow}','${processMap[doctor.doctorFlow].userFlow}','${processMap[doctor.doctorFlow].schResultFlow}');">出科考核表</a>] --%>
<%-- 	  					</c:if> --%>
	  					
<%-- 	  					<c:set var="summaryKey" value="res_${afterRecTypeEnumAfterSummary.id}_form_flag"/> --%>
<%-- 						<c:if test="${GlobalConstant.FLAG_Y eq sysCfgMap[summaryKey]}"> --%>
<!-- 							[<a -->
<!-- 							style="cursor: pointer;color: blue;"  -->
<%-- 							onclick="afterAudit('${doctor.rotationFlow}','${doctor.doctorFlow}','${processMap[doctor.doctorFlow].processFlow}');" --%>
<!--  							> -->
<!-- 								出科小结 -->
<!-- 							</a>] -->
<%-- 						</c:if> --%>
<!-- 					</td> -->
<!-- 					<td> -->
<%-- 						<c:if test="${afterMap[doctor.doctorFlow].auditStatusId eq recStatusEnumTeacherAuditY.id}"> --%>
<%-- 							<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}"> --%>
<!-- 							<a  -->
<!-- 							style="cursor: pointer;color: blue;"  -->
<%-- 							onclick="afterAudit('${doctor.rotationFlow}','${doctor.doctorFlow}','${processMap[doctor.doctorFlow].processFlow}');" --%>
<!-- 							> -->
<%-- 							</c:if> --%>
<!-- 							审核通过 -->
<%-- 							<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}"> --%>
<!-- 							</a> -->
<%-- 							</c:if> --%>
<%-- 						</c:if> --%>
<%-- 						<c:if test="${afterMap[doctor.doctorFlow].auditStatusId eq recStatusEnumTeacherAuditN.id}"> --%>
<%-- 							<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}"> --%>
<!-- 							<a  -->
<!-- 							style="cursor: pointer;color: blue;"  -->
<%-- 							onclick="afterAudit('${doctor.rotationFlow}','${doctor.doctorFlow}','${processMap[doctor.doctorFlow].processFlow}');" --%>
<!-- 							> -->
<%-- 							</c:if> --%>
<!-- 							审核不通过 -->
<%-- 							<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}"> --%>
<!-- 							</a> -->
<%-- 							</c:if> --%>
<%-- 						</c:if> --%>
<%-- 						<c:if test="${empty afterMap[doctor.doctorFlow].auditStatusId && !empty afterMap[doctor.doctorFlow]}"> --%>
<%-- 							<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}"> --%>
<!-- 							<a  -->
<!-- 							style="cursor: pointer;color: blue;"  -->
<%-- 							onclick="afterAudit('${doctor.rotationFlow}','${doctor.doctorFlow}','${processMap[doctor.doctorFlow].processFlow}');" --%>
<!-- 							> -->
<%-- 							</c:if> --%>
<!-- 							未审核 -->
<%-- 							<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}"> --%>
<!-- 							</a> -->
<%-- 							</c:if> --%>
<%-- 						</c:if> --%>
<!-- 					</td> -->
<!-- 					<td> -->
<%-- 						<c:if test="${afterMap[doctor.doctorFlow].headAuditStatusId eq recStatusEnumHeadAuditY.id}"> --%>
<%-- 							<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}"> --%>
<!-- 							<a  -->
<!-- 							style="cursor: pointer;color: blue;"  -->
<%-- 							onclick="afterAudit('${doctor.rotationFlow}','${doctor.doctorFlow}','${processMap[doctor.doctorFlow].processFlow}');" --%>
<!-- 							> -->
<%-- 							</c:if> --%>
<!-- 							审核通过 -->
<%-- 							<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}"> --%>
<!-- 							</a> -->
<%-- 							</c:if> --%>
<%-- 						</c:if> --%>
<%-- 						<c:if test="${afterMap[doctor.doctorFlow].headAuditStatusId eq recStatusEnumHeadAuditN.id}"> --%>
<%-- 							<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}"> --%>
<!-- 							<a  -->
<!-- 							style="cursor: pointer;color: blue;"  -->
<%-- 							onclick="afterAudit('${doctor.rotationFlow}','${doctor.doctorFlow}','${processMap[doctor.doctorFlow].processFlow}');" --%>
<!-- 							> -->
<%-- 							</c:if> --%>
<!-- 							审核不通过 -->
<%-- 							<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}"> --%>
<!-- 							</a> -->
<%-- 							</c:if> --%>
<%-- 						</c:if> --%>
<%-- 						<c:if test="${empty afterMap[doctor.doctorFlow].headAuditStatusId && !empty afterMap[doctor.doctorFlow]}"> --%>
<%-- 							<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}"> --%>
<!-- 							<a  -->
<!-- 							style="cursor: pointer;color: blue;"  -->
<%-- 							onclick="afterAudit('${doctor.rotationFlow}','${doctor.doctorFlow}','${processMap[doctor.doctorFlow].processFlow}');" --%>
<!-- 							> -->
<%-- 							</c:if> --%>
<!-- 							未审核 -->
<%-- 							<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}"> --%>
<!-- 							</a> -->
<%-- 							</c:if> --%>
<%-- 						</c:if> --%>
<!-- 					</td> -->
				</tr>
			</c:forEach>
			
			<c:if test="${empty doctorList}">
				<tr><td colspan="99">没有医师在当前科室轮转！</td></tr>
			</c:if>
		</table>
		</div>
		
		<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}">
<!-- 		<table class="basic" style="margin-top: 10px; width:100%;"> -->
<!-- 			<tr><th style="text-align:left;padding-left: 10px; font-size:14px; color:#fea527;font-weight:normal;"> 带教老师审核情况</th></tr> -->
<!-- 			<tr><td style="padding-left:0;"> -->
<!-- 			 <div style="margin:0 1%;"> -->
<%-- 			 <c:forEach items="${teacherFlows}" var="teacherFlow"> --%>
<!-- 				  <div class="card_tec"> -->
<!-- 				    <span class="card_inner"> -->
<%-- 				    <h1><c:out value="${auditMap[teacherFlow].teacherName}" default="${notAuditMap[teacherFlow].teacherName}"/><span class="card_score">评分：6分</span></h1> --%>
<%-- 				    <h2>已审核：${auditMap[teacherFlow].auditCount}&nbsp;&nbsp;&nbsp;未审核：${notAuditMap[teacherFlow].auditCount}</h2> --%>
<!-- 				    </span> -->
<!-- 				  </div> -->
<%-- 			 </c:forEach> --%>
<%-- 			 <c:if test="${empty teacherFlows}"> --%>
<!-- 			 	暂无带教老师审核信息! -->
<%-- 			 </c:if> --%>
<!-- 			  </div> -->
<!-- 			</td></tr> -->
<!-- 		</table> -->
		
<%-- 		<c:if test="${!empty willInResult}"> --%>
			<table class="xllist" style="margin-top: 10px; width:100%;">
				<tr>
					<th colspan="99" style="text-align:left;padding-left: 10px; font-size:14px;font-weight:normal;font-weight: bold;">
						待入科学员信息
						<font style="float: right;margin-left: 10px;font-weight: normal;">Tip：<font color="red">红色</font>表示已超过入科时间却未入科的学员！</font>
					</th>
				</tr>
				<tr>
					<th style="width: 10%;">姓名</th>
					<th style="width: 5%;">性别</th>
					<th style="width: 10%;">手机</th>
					<th style="width: 10%;">入院时间</th>
					<th style="width: 10%;">人员类型</th>
					<th style="width: 10%;">轮转科室</th>
					<th style="width: 16%;">计划轮转时间</th>
					<th style="width: 10%;">备注</th>
					<th style="width: 10%;">操作</th>
				</tr>
				<c:forEach items="${willInResult}" var="result">
					<c:set var="willInUser" value="${willInUserMap[result.doctorFlow]}"/>
					<c:set var="willInDoctor" value="${willInDoctorMap[result.doctorFlow]}"/>
					<c:set var="currDate" value="${pdfn:getCurrDate()}"/>
					<c:set var="overDay" value="${pdfn:signDaysBetweenTowDate(currDate,result.schStartDate)}"/>
					<tr>
						<td onclick="edit('${willInDoctor.doctorFlow}');" title="<img src='${sysCfgMap['upload_base_url']}/${willInUser.userHeadImg}' onerror='defaultImg(this);' style='width: 110px;height: 130px;'/>" style="cursor:pointer;"><a style="<c:if test="${overDay>0}">color:red;</c:if>">${willInDoctor.doctorName}</a></td>
						<td>${willInUser.sexName}</td>
						<td>${willInUser.userPhone}</td>
						<td>${willInDoctor.inHosDate}</td>
						<td>${willInDoctor.doctorCategoryName}</td>
						<td>${result.schDeptName}</td>
						<td>${result.schStartDate} ~ ${result.schEndDate}</td>
						<td>
							<c:if test="${overDay>0}">
								已超过入科日期${overDay}天
							</c:if>
						</td>
						<td>
							<a onclick="openChoose('${result.resultFlow}','${result.schDeptFlow}');" style="color: blue;cursor: pointer;">
								入科
							</a>
						</td>
					</tr>
				</c:forEach>
				 <c:if test="${empty willInResult}">
					<tr><td colspan="99" style="padding-left:10;"> 暂无待入科学员信息!</td></tr>
				 </c:if>
			</table>
<%-- 		</c:if> --%>
		</c:if>
		<script type="text/javascript">
		//拖动demo
// 			function moveE(d){
// 				var e = window.event;
// 				$(d).css({
// 					position:"absolute",
// 					top:$(d).offset().top+"px",
// 					left:$(d).offset().left+"px",
// 					zIndex:10000
// 				}).mouseup(function(){
// 					$(document).off("mousemove");
// 				});
// 				var topM = $(d).offset().top-e.pageY;
// 				var leftM = $(d).offset().left-e.pageX;
// 				$(document).mousemove(function(ev){
// 					$(d).css({
// 						top:ev.pageY+topM+"px",
// 						left:ev.pageX+leftM+"px"
// 					});
// 				});
// 			}
		</script>
<!-- 		<div style="width: 100px;height: 100px;background: red;" onmousedown="moveE(this);"></div> -->
	</div>
</div>
</body>
</html>