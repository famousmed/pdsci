<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>

<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="true"/>
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

<style>
.infoAudit{padding:20px;background:#fff;}
.infoAudit h1{ line-height:40px;  text-align:center; font-size:16px; color:#333;}
.infoAudit h2{line-height:40px; border-bottom:2px solid #44b549;padding-left:10px; color:#44b549; text-indend:10px;font-size:14px;}
.orgTable{ margin:10px 0;border-collapse: collapse;}
.orgCaption,.orgTh,.orgTd{height:40px;}
.orgCaption{line-height:40px;text-align:left;font-weight:bold; padding-left:10px; border-bottom:1px solid #ddd;color:#f60;}
.orgTh{text-align:right;font-weight:500;padding-right:5px; color:#333;}
.orgTd{text-align:left; padding-left:5px; color:#999;}
.orgTable a{ color:#00f;}
.btn{padding-left:22px; padding-right:22px;}
.blue-btn{ background:#44b549; border: 1px solid #3ea543; color:#fff;}
.blue-btn:hover{ background:#3ea543;}
.red-btn{background:#f90; border: 1px solid #f49200; color:#fff;}
.red-btn:hover{ background:#f60;}
.h-btn{background:#eee;border: 1px solid #ddd; }
.h-btn:hover{ background:#ddd;}
textarea{ width:100%; height:150px;padding:0; resize:none; outline:none;text-indent:28px; line-height:24px; font-family:'微软雅黑'; }
</style>

<script type="text/javascript">
// 	$(function(){
// 		$("#detail").slideInit({
// 			width:800,
// 			speed:500,
// 			outClose:true
// 		});
// 	});
	
// 	function loadDetail(){
// 		var url = "<s:url value='/res/rec/showRegistryForm'/>"+
// 		"?recFlow=${evaluation.recFlow}"+
// 		"&schDeptFlow=${param.schDeptFlow}"+
// 		"&rotationFlow=${param.rotationFlow}"+
// 		"&recTypeId=${evaluation.recTypeId}"+
// 		"&roleFlag=${param.roleFlag}";
// 		if ("${param.roleFlag}"=="${GlobalConstant.RES_ROLE_SCOPE_DOCTOR}" || "${param.isRead}"=="true") {
// 			url += "&openType=messager";
// 			var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='1100px' height='500px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
// 			top.jboxMessager(iframe,'出科考核表',1100,500);
// 		} else {
// 			url += "&isLoad=true";
// 			jboxStartLoading();
// 			jboxGet(url,null,function(resp){
// 				$("#detail").html(resp);
// 				$("#detail").rightSlideOpen();
// 				end();
// 			},function(){end();},false);
// 		}
// 	}
	
// 	function end(){
// 		jboxEndLoading();
// 	}
	//====================滑动=========================

	function saveForm(){
			if($("#summaryForm").validationEngine("validate")){
				var isConfirm = true;
				<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR && !empty rec}">
					isConfirm = false;
				</c:if>
				saveFormToConfirm(function(){
					jboxPost("<s:url value='/res/rec/saveRegistryForm'/>",$('#summaryForm').serialize(),function(){
						window.parent.frames['mainIframe'].window.$(".recTypeTag.active").click();
						jboxClose();
					},null,true);
				},isConfirm);
			}
	}
	
	function saveFormToConfirm(save,isConfirm){
		if(isConfirm){
			var title = "确认保存?保存后将不能修改！";
			<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
				title = "确认填写出科小结？填写后科室审核通过即可出科!";
			</c:if>
			jboxConfirm(title,function(){
				save();
			});
		}else{
			save();
		}
	}
	
	function submit(){
		jboxConfirm("确认提交?",function(){
			jboxPost("<s:url value='/res/rec/opreResRec'/>",
					{
					"recFlow":"${rec.recFlow}",
					"statusId":"${recStatusEnumSubmit.id}",
					"recTypeId":"${rec.recTypeId}"
					},
					function(resp){
						window.parent.frames['mainIframe'].window.$(".recTypeTag.active").click();
					},null,true);
		});
	}
	
	function evaluation(){
		var url = "<s:url value='/res/rec/showRegistryForm'/>"+
				"?recFlow=${evaluation.recFlow}"+
				"&schDeptFlow=${param.schDeptFlow}"+
				"&rotationFlow=${param.rotationFlow}"+
				"&recTypeId=${evaluation.recTypeId}"+
				"&roleFlag=${param.roleFlag}";
		window.open(url,"_blank");
	}
	
	function audit(auditResult){
		if($("#summaryForm").validationEngine("validate")){
			jboxConfirm("确认提交?提交后将无法修改!",function(){
				var url = "<s:url value='/res/teacher/audit'/>?auditResult="+auditResult;
				jboxPost(url,$('#summaryForm').serialize(),function(resp){
					if(resp=="${GlobalConstant.OPRE_SUCCESSED}"){
// 					if(window.parent.frames["jbox-message-iframe"] == undefined){
// 						window.parent.frames["mainIframe"].window.$(".selectTag a").click();
// 					}else{
// 						window.parent.frames["jbox-message-iframe"].window.recReLoad();
// 					}
						<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
							window.parent.frames["mainIframe"].window.$(".selectTag a").click();
						</c:if>
						<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}">
							//back();
							top.document.mainIframe.location.reload(true);
						</c:if>
						jboxClose();
					}
				},null,true);
			},null);
		};
	}
	
	function goBack(){
		var parent = "${param.isView?'showView':'audit'}";
		location.href = "<s:url value='/res/teacher/"+parent+"/${param.roleFlag}'/>?currentPage=${param.currentPage}";
	}
</script>
</head>
<body>	
		<div class="infoAudit" style="overflow: auto;height: 100%;">
			<div style="text-align: left;padding-left: 10px;margin-bottom: 10px;">
				<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}">
					医师姓名：${rec.operUserName}
				</c:if>
			</div>
			
	 		<form id="summaryForm" method="post">
		 		<input type="hidden" name="formFileName" value="${formFileName}"/>
				<input type="hidden" name="schDeptFlow" value="${param.schDeptFlow}"/>
				<input type="hidden" name="recFlow" value="${empty rec.recFlow?param.recFlow:rec.recFlow}"/>
				<input type="hidden" name="roleFlag" value="${param.roleFlag}">
				<input type="hidden" name="recTypeId" value="${param.recTypeId }">
				<input type="hidden" name="processFlow" value="${param.processFlow}">
				
				<table class="basic" style="width: 100%;">
					<tr>
						<th style="text-align: left;padding-left: 10px;" colspan="4">
							一、出科小结
<%-- 							<c:if test="${!empty evaluation}"> --%>
<!-- 								<input type="button" value="出科考核表" class="search" style="float: right;margin-bottom: 5px;" onclick="loadDetail();"/> -->
<%-- 							</c:if> --%>
						</th>
					</tr>
					<tr>
						<td colspan="4" style="height: ${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR?"380":"220"}px;vertical-align: top;">
							<c:if test="${!(!empty rec.auditStatusId || !empty rec.headAuditStatusId) && param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
								<textarea
								 placeholder="（从医德医风、床位管理、病历书写、临床操作、参加教学等方面书写，不少于600字）"
								 name="personalSummary" class="validate[required]" style="border: none;">${formDataMap['personalSummary']}</textarea>
							</c:if>
							<c:if test="${empty formDataMap['personalSummary'] && !(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}">
								暂无出科小结!
							</c:if>
							<c:if test="${(!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR) && !empty formDataMap['personalSummary']) || ((param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR) && (!empty rec.auditStatusId || !empty rec.headAuditStatusId))}">
								&#12288;${formDataMap['personalSummary']}
								<input type="hidden" name="personalSummary" value="${formDataMap['personalSummary']}"/>
							</c:if>
						</td>
					</tr>
					<c:if test="${(!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR) && !empty formDataMap['personalSummary']) || ((param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR) && (!empty rec.auditStatusId || !empty rec.headAuditStatusId)) || 'open' eq param.type}">
					<tr>
						<td colspan="2">
							实习表现评价
						</td>
						<td colspan="2">
							<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER && empty formDataMap['internshipEvaluation']}">
							<label>
								<input type="radio" value="优" name="internshipEvaluation" <c:if test="${formDataMap['internshipEvaluation'] eq '优'}">checked</c:if>/>
								优
							</label>
							&#12288;
							<label>
								<input type="radio" value="良" name="internshipEvaluation" <c:if test="${formDataMap['internshipEvaluation'] eq '良'}">checked</c:if>/>
								良
							</label>
							&#12288;
							<label>
								<input type="radio" value="中" name="internshipEvaluation" <c:if test="${formDataMap['internshipEvaluation'] eq '中'}">checked</c:if>/>
								中
							</label>
							&#12288;
							<label>
								<input type="radio" value="合格" name="internshipEvaluation" <c:if test="${formDataMap['internshipEvaluation'] eq '合格'}">checked</c:if>/>
								合格
							</label>
							&#12288;
							<label>
								<input type="radio" value="不合格" name="internshipEvaluation" <c:if test="${formDataMap['internshipEvaluation'] eq '不合格'}">checked</c:if>/>
								不合格
							</label>
							</c:if>
							<c:if test="${!empty formDataMap['internshipEvaluation']}">
								&#12288;${formDataMap['internshipEvaluation']}
								<input type="hidden" name="internshipEvaluation" value="${formDataMap['internshipEvaluation']}"/>
							</c:if>
						</td>
					</tr>
					<tr>
						<th style="text-align: left;padding-left: 10px;" colspan="4">
							二、出科考核
							<script type="text/javascript">
								function countScore(){
									var a = $("[name='theoryTest']").val();
									a = !isNaN(a) && a?parseInt(a):0;
									var b = $("[name='skillTest']").val();
									b = !isNaN(b) && b?parseInt(b):0;
									$("[name='total']").val(a+b);
								}
							</script>
						</th>
					</tr>
					<tr>
						<td colspan="2" style="width: 60%;">理论考试（20分）（根据实际分数折算）</td>
						<td colspan="2">
							<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER && empty formDataMap['theoryTest']}">
								<input type="text" name="theoryTest" value="${formDataMap['theoryTest']}"/>
							</c:if>
							<c:if test="${!empty formDataMap['theoryTest']}">
								&#12288;${formDataMap['theoryTest']}
								<input type="hidden" name="theoryTest" value="${formDataMap['theoryTest']}"/>
							</c:if>
							分
						</td>
					</tr>
					<tr>
						<td colspan="2">技能考核（80分）（根据实际分数折算）</td>
						<td colspan="2">
							（病史采集、体格检查、辅助检查、临床操作、诊断、鉴别诊断、治疗原则等方面评估）<br>
							<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER && empty formDataMap['skillTest']}">
								<input type="text" name="skillTest" value="${formDataMap['skillTest']}"/>
							</c:if>
							<c:if test="${!empty formDataMap['skillTest']}">
								&#12288;${formDataMap['skillTest']}
								<input type="hidden" name="skillTest" value="${formDataMap['skillTest']}"/>
							</c:if>
							分
						</td>
					</tr>
					<tr>
						<td colspan="2">满分100</td>
						<td colspan="2">
							<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER && empty formDataMap['total']}">
								<input type="text" name="total" value="${formDataMap['total']}"/>
							</c:if>
							<c:if test="${!empty formDataMap['total']}">
								&#12288;${formDataMap['total']}
								<input type="hidden" name="total" value="${formDataMap['total']}"/>
							</c:if>
							分
						</td>
					</tr>
					<c:if test="${!empty rec.headAuditStatusId || param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}">
						<tr>
							<th style="text-align: left;padding-left: 10px;" colspan="4">
								三、同意出科
							</th>
						</tr>
						<tr>
							<td colspan="4">
								<label style="font-weight: normal;color: black;">
									<input type="checkbox" name="isAgaree" 
									value="${GlobalConstant.FLAG_Y}" 
									<c:if test="${(empty formDataMap['isAgaree'] && param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD) || (formDataMap['isAgaree'] eq GlobalConstant.FLAG_Y)}">
										checked
									</c:if>
									<c:if test="${!empty formDataMap['isAgaree'] || !(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD)}">
										disabled
									</c:if>
									/>
									同意
									<c:if test="${!empty formDataMap['isAgaree']}">
										<input type="hidden" name="isAgaree" value="${formDataMap['isAgaree']}"/> 
									</c:if>
								</label>
								<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}">
						         <font color="red">(如同意出科请选中)</font>
						         </c:if>
						         <c:if test="${empty rec}">
							         <input type="hidden" name="isAgaree" value="${formDataMap['isAgaree']}"/>
						         </c:if>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<div align="right" style="margin-top: 10px;width: 90%;margin-right: auto;margin-left: auto;">
						         	主任：
						         	<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD)}">
						         		${formDataMap['head']}
						         		<input type="hidden" name="head" value="${formDataMap['head']}"/>
						         	</c:if>
						         	<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}">
						         		${empty formDataMap['head']?sessionScope.currUser.userName:formDataMap['head']}
							         	<input type="hidden" name="head" value="${empty formDataMap['head']?sessionScope.currUser.userName:formDataMap['head']}"/>
						         	</c:if>
						         	&#12288;日期：
						         	<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD)}">
						         		${formDataMap['date']}
						         		<input type="hidden" name="date" value="${formDataMap['date']}"/>
						         	</c:if>
						         	<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}">
						         		<c:if test="${empty formDataMap['date']}">
						         		<input type="text" name="date" value="${empty formDataMap['date']?pdfn:getCurrDate():formDataMap['date']}" readonly="readonly" 
						         		onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" style="width: 100px;"
						         		/>
						         		</c:if>
						         		<c:if test="${!empty formDataMap['date']}">
						         			${formDataMap['date']}
						         		</c:if>
						         	</c:if>
						         </div>
							</td>
						</tr>
					</c:if>
					</c:if>
				</table>
	         </form>
	         	<div style="text-align: center;margin-top: 5px;width: 90%;margin-left: auto;margin-right: auto;margin-bottom: 20px;">
	         		<c:if test="${!(!empty rec.auditStatusId || !empty rec.headAuditStatusId) && param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
	         			<input type="button" value="保&#12288;存" class="search" onclick="saveForm();"/>
	         		</c:if>
			         <c:if test="${!empty param.roleFlag && !(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}">
			         	<c:if test="${!empty formDataMap['personalSummary'] && ((empty formDataMap['internshipEvaluation'] && param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER) || (empty formDataMap['isAgaree'] && param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD))}">
				         	<input type="button" value="提&#12288;交" class="search" onclick="audit('${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD?recStatusEnumHeadAuditY.id:recStatusEnumTeacherAuditY.id}');"/>
			         	</c:if>
			         	<c:if test="${!param.isManager}">
			         		<input type="button" value="关&#12288;闭" class="search" onclick="jboxClose();"/>
			         	</c:if>
			         </c:if>
			         <c:if test="${param.isManager}">
			         	<input type="button" value="关&#12288;闭" class="search" onclick="jboxClose();"/>
			         </c:if>
		         </div>
	 		</div>
		         <div id="detail"></div>
</body>
</html>