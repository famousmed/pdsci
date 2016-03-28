<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<script>
function evaluation(){
	var url = "<s:url value='/res/rec/showRegistryForm'/>"+
			"?recFlow=${evaluation.recFlow}"+
			"&schDeptFlow="+indexObj.schDeptFlow+
			"&rotationFlow="+indexObj.rotationFlow+
			"&recTypeId=${resRecTypeEnumAfterEvaluation.id}"+
			"&roleFlag=${param.roleFlag}&openType=open&resultFlow=${process.schResultFlow}";
	var h = $('.main_fix').height();		
	jboxOpen(url, "出科考核表",800,h);
}

// function workingAttitude(){
// 	var url = "<s:url value='/res/rec/showRegistryForm'/>"+
// 			"?recFlow=${workingAttitude.recFlow}"+
// 			"&schDeptFlow="+indexObj.schDeptFlow+
// 			"&rotationFlow="+indexObj.rotationFlow+
// 			"&recTypeId=${afterRecTypeEnumWorkingAttitude.id}"+
// 			"&roleFlag=${param.roleFlag}&openType=open";
// 	var h = $('.main_fix').height();		
// 	jboxOpen(url, "${afterRecTypeEnumWorkingAttitude.name}",800,h);
// }

function afterSummary(userFlow,schDeptFlow,recTypeId){
	jboxOpen("<s:url value='/res/rec/showRegistryForm'/>?roleFlag=${param.roleFlag}&userFlow="+userFlow+"&schDeptFlow="+schDeptFlow+"&recTypeId="+recTypeId,"出科小结",800,500);
}

//评分
function grade(recTypeName,recTypeId,recFlow){
	var w = $('.main_fix').width();
	jboxOpen("<s:url value='/res/rec/grade'/>?roleFlag=${param.roleFlag}&resultFlow=${process.schResultFlow}&schDeptFlow=${process.schDeptFlow}&rotationFlow=${result.rotationFlow}&recTypeId="+recTypeId+"&recFlow="+recFlow,
			   recTypeName,w,500);
}

function annualTrainForm(){
	var h = $('.main_fix').height();
	jboxOpen("<s:url value='/jsp/res/edu/student/annualTrainForm.jsp'/>", "年度培训记录表",700,h);
}

$(document).ready(function() {
	//toggleItem('outDeptView');
	$("[onclick]").click(function(e){
		e.stopPropagation();
	});
});

//操作出科
function operAfter(){
	jboxPost("<s:url value='/res/rec/docOperAfter'/>?userFlow=${process.userFlow}&schDeptFlow=${process.schDeptFlow}&processFlow=${process.processFlow}",null,function(resp){
		if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
			jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
			$(".box.selected").click();
		}else{
			jboxTip("请先完成岗前培训表和对带教老师评价！");
		}
	},null,false);
}
</script>
<style>
a {
cursor: pointer;
background: transparent;
color: #428bca;
text-decoration: none;
}
</style>
</head>
<body>
	<div class="toolkit bg-f6 toolkit-lg toolkit-bar" style="border-top: 0;cursor: pointer;" onclick="toggleItem('outDeptView');scrollHome('outDeptView');">
		<ul class="j_e-nav-tab toolkit-list fl">
			<li class="j_mainline_link toolkit-item toolkit-item-tab j_mainline_link_task router">
				<span class="tool_title">出科</span>
			</li>
		</ul>
<!-- 		<ul class="toolkit-list fr"> -->
<!-- 			<li class="toolkit-item dropdown-create create-stage fr task-tab-li"> -->
<%-- 				<c:if test="${GlobalConstant.FLAG_Y eq sysCfgMap['res_doc_oper_after']}"> --%>
<%-- 					<c:if test="${!(GlobalConstant.FLAG_Y eq process.schFlag)}"> --%>
<!-- 						<input type="button" value="出&#12288;科" class="search" style="margin-top: 10px;" onclick="operAfter();"> -->
<%-- 					</c:if> --%>
<%-- 				</c:if> --%>
<!-- 			</li> -->
<!-- 		</ul> -->
	</div>
	<div class="col-tb ps-r scrollwrapper" style="width: 99%;" id="outDeptView_div"> 
		<div class="col-cell j_center" style="width:100%;">
			<ul class=" e-list task-list" style="margin-top: 5px;width: 100%;">
				<li  style="position: relative;">
					<span class="mark"><i></i></span>
					<span class="j_title  ellipsis" style="padding-left: 10px;">
						<a href="javascript:grade('${resRecTypeEnumTeacherGrade.name}','${resRecTypeEnumTeacherGrade.id}','${teacherGrade.recFlow}');">评价带教老师：${process.teacherUserName}</a>
						&#12288;评分：
						<a href="javascript:grade('${resRecTypeEnumTeacherGrade.name}','${resRecTypeEnumTeacherGrade.id}','${teacherGrade.recFlow}');">${empty teacherGrade?'未评':(teacherGradeMap['totalScore']+0)}分</a>
					</span>
				</li>
				<li  style="position: relative;">
					<span class="mark"><i></i></span>
					<span class="j_title  ellipsis" style="padding-left: 10px;">
						<a href="javascript:grade('${resRecTypeEnumDeptGrade.name}','${resRecTypeEnumDeptGrade.id}','${deptGrade.recFlow}');">评价科室：${process.schDeptName}</a>
						&#12288;评分：
						<a href="javascript:grade('${resRecTypeEnumDeptGrade.name}','${resRecTypeEnumDeptGrade.id}','${deptGrade.recFlow}');">${empty deptGrade?'未评':(deptGradeMap['totalScore']+0)}分</a>
					</span>
				</li>
<!-- 				<li  style="position: relative;"> -->
<!-- 					<span class="mark"><i></i></span> -->
<!-- 					<span class="j_title  ellipsis" style="padding-left: 10px;"> -->
<!-- 					<a href="#">出科考试</a> -->
<!-- 					（成绩： -->
<%-- 					<c:if test="${empty process.schScore}">暂无</c:if> --%>
<%-- 					<c:if test="${!empty process.schScore}"> --%>
<%-- 						<a href="javascript:evaluation();">${process.schScore}</a> --%>
<%-- 					</c:if>） --%>
<!-- 					</span> -->
<!-- 				</li> -->
				<c:if test="${GlobalConstant.FLAG_Y eq sysCfgMap['res_doc_reg_score']}">
					<li  style="position: relative;">
						<span class="mark"><i></i></span>
						<span class="j_title  ellipsis" style="padding-left: 10px;">
							<script type="text/javascript">
								function saveScore(data){
									data.recFlow = "${after.recFlow}";
									data.formFileName = "${resRecTypeEnumAfterSummary.id}";
									data.schDeptFlow = "${process.schDeptFlow}";
									data.roleFlag = "${param.roleFlag}";
									data.recTypeId = "${resRecTypeEnumAfterSummary.id}";
									data.processFlow = "${process.processFlow}";
									data.theoryTest = data.theoryTest || "${afterDataMap['theoryTest']}";
									data.skillTest = data.skillTest || "${afterDataMap['skillTest']}";
									data.personalSummary = "${afterDataMap['personalSummary']}";
									data.internshipEvaluation = "${afterDataMap['internshipEvaluation']}";
									data.total = "${afterDataMap['total']}";
									data.isAgaree = "${afterDataMap['isAgaree']}";
									data.head = "${afterDataMap['head']}";
									data.date = "${afterDataMap['date']}";
	// 								if($("#summaryForm").validationEngine("validate")){
	// 									jboxConfirm("确认提交?一旦提交将无法修改!",function(){
											jboxPost("<s:url value='/res/rec/saveRegistryForm'/>",data,function(){
												//$(".recTypeTag.active").click();
												location.reload();
											},null,true);
	// 									});
	// 								}
								}
							</script>
							理论成绩(
								<c:if test="${empty afterDataMap['theoryTest']}">
									<a class="theoryTest" onclick="$('.theoryTest').toggle();">参加出科考试</a><input class="inputText theoryTest" type="text" value="" style="display: none;width: 60px;" onchange="saveScore({theoryTest:this.value});"/>
								</c:if>
								${afterDataMap['theoryTest']}
							)
							&#12288;
							技能成绩(
								<c:if test="${empty afterDataMap['skillTest']}">
									<a class="skillTest" onclick="$('.skillTest').toggle();">输入成绩</a><input class="inputText skillTest" type="text" value="" style="display: none;width: 60px;" onchange="saveScore({skillTest:this.value});"/>
								</c:if>
								${afterDataMap['skillTest']}
							)
						</span>
					</li>
				</c:if>
<%-- 				<c:set var="workKey" value="res_${afterRecTypeEnumWorkingAttitude.id}_form_flag"/> --%>
<%-- 				<c:if test="${GlobalConstant.FLAG_Y eq sysCfgMap[workKey]}"> --%>
<!-- 					<li  style="position: relative;"> -->
<!-- 						<span class="mark"><i></i></span> -->
<%-- 						<span class="j_title  ellipsis" style="padding-left: 10px;"><a onclick="workingAttitude();">${afterRecTypeEnumWorkingAttitude.name}(${empty workingAttitude.recFlow?"未填写":"已填写"})</a></span> --%>
<!-- 					</li> -->
<%-- 				</c:if> --%>

				<c:if test="${!empty evaluation}">
					<c:set var="afterKey" value="res_${afterRecTypeEnumAfterEvaluation.id}_form_flag"/>
					<c:if test="${GlobalConstant.FLAG_Y eq sysCfgMap[afterKey]}">
						<li  style="position: relative;">
							<span class="mark"><i></i></span>
							<span class="j_title  ellipsis" style="padding-left: 10px;"><a onclick="evaluation();">${afterRecTypeEnumAfterEvaluation.name}</a></span>
						</li>
					</c:if>
				</c:if>
				
				<!-- 
				<li  style="position: relative;">
					<span class="mark"><i></i></span>
					<span class="j_title  ellipsis" style="padding-left: 10px;"><a href="javascript:void();" onclick="annualTrainForm();">年度考核表</a></span>
				</li>
				 -->
				 <c:set var="summaryKey" value="res_${afterRecTypeEnumAfterSummary.id}_form_flag"/>
				 <c:if test="${GlobalConstant.FLAG_Y eq sysCfgMap[summaryKey]}">
					<li  style="position: relative;">
						<span class="mark"><i></i></span>
						<span class="j_title  ellipsis" style="padding-left: 10px;"><a onclick="afterSummary('${process.userFlow }','${process.schDeptFlow }','${resRecTypeEnumAfterSummary.id}');">出科小结</a></span>
					</li>
				</c:if>
			</ul>
		</div>
	</div>
</body>
</html>
	