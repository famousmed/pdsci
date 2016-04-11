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
	function isInt(num){
		return !isNaN(num) && num!="";
	}
	function check(num){
	var item = $(".score");
	var sum = 0;
	item.each(function(){
		var value = this.value;
		if(isInt(value)){
			value = parseInt(value);
		}else{
			value = 0;
		}
		sum+=value;
	});
	<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
		$("#total label").text(sum);
		$("#total input").val(sum);
	</c:if>
	}
	$(function(){
		$("#detail").slideInit({
			width:800,
			speed:500,
			outClose:true
		});
		$(".Input").attr("disabled",true);
		$(".Input.${param.roleFlag}").attr("disabled",false);
		$(".ctrlInput").attr("readonly",true);
		$(".ctrlInput.${param.roleFlag}").attr("readonly",false);
		<c:if test="${!empty rec.auditStatusId}">
			$(".toggleView,.toggleView2").toggle();
		 </c:if>
		 <c:if test="${!empty rec.headAuditStatusId}">
			$(".toggleView3").toggle();
		 </c:if>
	});
	
	function loadDetail(){
		var url = "<s:url value='/res/rec/showRegistryForm'/>"+
		"?recFlow=${evaluation.recFlow}"+
		"&schDeptFlow=${param.schDeptFlow}"+
		"&rotationFlow=${param.rotationFlow}"+
		"&recTypeId=${evaluation.recTypeId}"+
		"&roleFlag=${param.roleFlag}";
		if ("${param.roleFlag}"=="${GlobalConstant.RES_ROLE_SCOPE_DOCTOR}" || "${param.isRead}"=="true") {
			url += "&openType=messager";
			var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='1100px' height='500px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
			top.jboxMessager(iframe,'出科考核表',1100,500);
		} else {
			url += "&isLoad=true";
			jboxStartLoading();
			jboxGet(url,null,function(resp){
				$("#detail").html(resp);
				$("#detail").rightSlideOpen();
				end();
			},function(){end();},false);
		}
	}
	
	function end(){
		jboxEndLoading();
	}
	//====================滑动=========================

	function saveForm(){
			if($("#summaryForm").validationEngine("validate")){
					jboxPost("<s:url value='/res/rec/saveRegistryForm'/>",$('#summaryForm').serialize(),function(){
//						window.parent.frames['mainIframe'].window.$(".recTypeTag.active").click();
// 						jboxClose();
					},null,true);
			}
	}
	function save(){
		if(!$("#summaryForm").validationEngine("validate")){
			return;
		}
		jboxConfirm("确认保存，保存之后不可修改",function(){
		if($("#summaryForm").validationEngine("validate")){
				jboxPost("<s:url value='/res/rec/saveRegistryForm'/>",$('#summaryForm').serialize(),function(){
						window.parent.document.mainIframe.location.reload();
						jboxClose();
				},null,true);
		}
		});
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
	
// 	function audit(auditResult){
// 		if($("#summaryForm").validationEngine("validate")){
// 			jboxConfirm("确认提交?一旦提交将无法修改!",function(){
// 				var url = "<s:url value='/res/teacher/audit'/>?auditResult="+auditResult;
// 				jboxPost(url,$('#summaryForm').serialize(),function(resp){
// 					if(resp=="${GlobalConstant.OPRE_SUCCESSED}"){
// // 					if(window.parent.frames["jbox-message-iframe"] == undefined){
// // 						window.parent.frames["mainIframe"].window.$(".selectTag a").click();
// // 					}else{
// // 						window.parent.frames["jbox-message-iframe"].window.recReLoad();
// // 					}
// 						<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
// 							window.parent.frames["mainIframe"].window.$(".selectTag a").click();
// 						</c:if>
// 						<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}">
// 							//back();
// 							location.reload(true);
// 						</c:if>
// 						jboxClose();
// 					}
// 				},null,true);
// 			},null);
// 		};
// 	}
	
	function goBack(){
		var parent = "${param.isView?'showView':'audit'}";
		location.href = "<s:url value='/res/teacher/"+parent+"/${param.roleFlag}'/>?currentPage=${param.currentPage}";
	}
</script>
</head>
<body>	
		<div class="infoAudit" style="overflow: auto;height: 100%;">
			<div style="width: 90%;margin-right: auto;margin-left: auto;">
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
				<input type="hidden" name="processFlow" value="${param.processFlow }">
				<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}">
					 <input type="hidden" name="headAuditStatusId" value="${recStatusEnumHeadAuditY.id}"/>
				 </c:if>
				<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
					 <input type="hidden" name="auditStatusId" value="${recStatusEnumTeacherAuditY.id}"/>
				 </c:if>
				<table class="basic" style="width: 100%;">
					<tr>
						<th style="text-align: left;padding-left: 10px;" colspan="4">
							一、个人小结
<%-- 							<c:if test="${!empty evaluation}"> --%>
<!-- 								<input type="button" value="出科考核表" class="search" style="float: right;margin-bottom: 5px;" onclick="loadDetail();"/> -->
<%-- 							</c:if> --%>
						</th>
					</tr>
					<tr>
						<td colspan="4">
								<c:if test="${ param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
									<div><textarea name="personalSummary" class="toggleView validate[required]" style="border: none;">${formDataMap['personalSummary']}</textarea></div>
									<div style="display: none; height: 100px;"  class="toggleView">${formDataMap['personalSummary']}</div>
								</c:if>
								<c:if test="${ !empty formDataMap['personalSummary'] && param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_DOCTOR }">
									<div style="width: 100px;height:100px;">${formDataMap['personalSummary']}</div>
									<input type="hidden" name="personalSummary" value="${formDataMap['personalSummary']}"/>
								</c:if>
							<c:if test="${empty rec && !(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}">
								暂无出科小结!
							</c:if>
						
						</td>
					</tr>
					</table>
					<c:if test="${!empty rec || 'open' eq param.type}">
					<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_DOCTOR || param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR && !empty rec.auditStatusId}">
					 
					<table class="basic" style="width: 100%;margin-top: 10px;">
					
					<tr>
						<td colspan="2">
							实习表现评价
						</td>
						<td colspan="2" style="width: 150px;">
							<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
								<label>
									<input type="radio" value="优" name="internshipEvaluation" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput" <c:if test="${formDataMap['internshipEvaluation'] eq '优'}">checked</c:if>/>
									<span class="toggleView2">优</span>
								</label>
								<c:if test="${'优' eq formDataMap['internshipEvaluation']}">
									<label style="display: none;" class="toggleView2">优</label>
								</c:if>
							</c:if>
							<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_TEACHER && '优' eq formDataMap['internshipEvaluation']}">
								${formDataMap['internshipEvaluation']}
								<input type="hidden" name="internshipEvaluation" value="${formDataMap['internshipEvaluation']}"/>
							</c:if>
							<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
							&#12288;
							<label>
								<input type="radio" value="良" name="internshipEvaluation" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput" <c:if test="${formDataMap['internshipEvaluation'] eq '良'}">checked</c:if>/>
								<span class="toggleView2">良</span>
							</label>
							<c:if test="${'良' eq formDataMap['internshipEvaluation']}">
								<label style="display: none;" class="toggleView2">良</label>
							</c:if>
							</c:if>
							<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_TEACHER && '良' eq formDataMap['internshipEvaluation']}">
								${formDataMap['internshipEvaluation']}
								<input type="hidden" name="internshipEvaluation" value="${formDataMap['internshipEvaluation']}"/>
							</c:if>
							
							<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
							&#12288;
							<label>
								<input type="radio" value="中" name="internshipEvaluation" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput" <c:if test="${formDataMap['internshipEvaluation'] eq '中'}">checked</c:if>/>
								<span class="toggleView2">中</span>
							</label>
							<c:if test="${'中' eq formDataMap['internshipEvaluation']}">
								<label style="display: none;" class="toggleView2">中</label>
							</c:if>
							</c:if>
							<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_TEACHER && '中' eq formDataMap['internshipEvaluation']}">
								${formDataMap['internshipEvaluation']}
								<input type="hidden" name="internshipEvaluation" value="${formDataMap['internshipEvaluation']}"/>
							</c:if>
							<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
							&#12288;
							<label>
								<input type="radio" value="合格" name="internshipEvaluation" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput" <c:if test="${formDataMap['internshipEvaluation'] eq '合格'}">checked</c:if>/>
								<span class="toggleView2">合格</span>
							</label>
								<c:if test="${'合格' eq formDataMap['internshipEvaluation']}">
								<label style="display: none;" class="toggleView2">合格</label>
							</c:if>
							</c:if>
							<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_TEACHER && '合格' eq formDataMap['internshipEvaluation']}">
								${formDataMap['internshipEvaluation']}
								<input type="hidden" name="internshipEvaluation" value="${formDataMap['internshipEvaluation']}"/>
							</c:if>
							<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
							&#12288;
							<label>
								<input type="radio" value="不合格" name="internshipEvaluation"  class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput" <c:if test="${formDataMap['internshipEvaluation'] eq '不合格'}">checked</c:if>/>
								<span class="toggleView2">不合格</span>
							</label>
								<c:if test="${'不合格' eq formDataMap['internshipEvaluation']}">
								<label style="display: none;" class="toggleView2">不合格</label>
							</c:if>
							</c:if>
							<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_TEACHER && '不合格' eq formDataMap['internshipEvaluation']}">
								${formDataMap['internshipEvaluation']}
								<input type="hidden" name="internshipEvaluation" value="${formDataMap['internshipEvaluation']}"/>
							</c:if>
<%-- 							</c:if> --%>
<%-- 							<c:if test="${!empty formDataMap['internshipEvaluation']}"> --%>
<%-- 								&#12288;${formDataMap['internshipEvaluation']} --%>
<%-- 								<input type="hidden" name="internshipEvaluation" value="${formDataMap['internshipEvaluation']}"/> --%>
<%-- 							</c:if> --%>
						</td>
					</tr>
				
					<tr>
						<th style="text-align: left;padding-left: 10px;" colspan="4">
							二、出科考核
						</th>
					</tr>
					<tr>
						<td colspan="2">理论考试（20分）（根据实际分数折算）</td>
						<td colspan="2"> 
								<input type="text" onchange="check(this.value)" name="theoryTest" style="width: 60px;"  value="${formDataMap['theoryTest']}" class="score validate[custom[integer,max[20],min[0]]] toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput"/>
								<label style="display: none;" class="toggleView2">${formDataMap['theoryTest']}</label>
						</td>
					</tr>
					<tr>
						<td colspan="2">技能考核（80分）（根据实际分数折算）</td>
						<td colspan="2">
							<input type="text" onchange="check(this.value)" name="skillTest" style="width: 60px;" value="${formDataMap['skillTest']}" class="score validate[custom[integer,max[80],min[0]]] toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput"/>
							<label style="display: none;" class="toggleView2">${formDataMap['skillTest']}</label>
						</td>
					</tr>
					<tr>
						<td colspan="2">满分100</td>
						<td colspan="2" id="total">
							<input type="text" name="total" style="width: 60px;" value="${formDataMap['total']}" class=" toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput"/>
							<label style="display: none;" class="toggleView2">${formDataMap['total']}</label>
						</td>
					</tr>
					</table>
					</c:if>
					<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_DOCTOR || (param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR && !empty rec.headAuditStatusId)}">
					<table class="basic" style="width: 100%; margin-top: 10px;">
					<tr>
						<th style="text-align: left;padding-left: 10px;" colspan="4">
							三、同意出科
						</th>
					</tr>
					<tr>
						<td colspan="4">
<!-- 							<label style="font-weight: normal;color: black;"> -->
								<label><input type="checkbox" name="isAgaree" value="${GlobalConstant.FLAG_Y}" 
								<c:if test="${formDataMap['isAgaree'] eq GlobalConstant.FLAG_Y}">checked</c:if> class="toggleView3 ${GlobalConstant.RES_ROLE_SCOPE_HEAD} Input"/>
								<span class="toggleView3">同意</span></label>
								<c:if test="${GlobalConstant.FLAG_Y eq formDataMap['isAgaree']}">
									<label style="display: none; margin-left: 30px;" class="toggleView3">同意</label>
								</c:if>
							<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}">
					         <font color="red"><span class="toggleView3">(如同意出科请选中)</span></font>
					         </c:if>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<div align="right" style="margin-top: 10px;width: 90%;margin-right: auto;margin-left: auto;">
					         	主任：
					         	<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
									<input type="text" class="toggleView3 validate[required] inputText" name="head" style="width: 100px;" value="${empty formDataMap['head']?sessionScope.currUser.userName:formDataMap['head']}"/>
									<label style="display: none;" class="toggleView3">${formDataMap['head']}</label>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD }">
									<label>${formDataMap['head']}</label>
									<input type="hidden" name="head" value="${formDataMap['head']}"/>
								</c:if>		
					         	&#12288;日期：
					         	<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
									<input type="text" class="toggleView3 inputText validate[required] ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="date" value="${empty formDataMap['date']?pdfn:getCurrDate():formDataMap['date']}" style="width: 100px;" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
									<label style="display: none;" class="toggleView3">${formDataMap['date']}</label>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_HEAD }">
									<label>${formDataMap['date']}</label>
									<input type="hidden" name="date" value="${formDataMap['date']}"/>
								</c:if>
					         </div>
						</td>
					</tr>
				</table>
				</c:if>
				</c:if>
	         </form>
	         	<div style="text-align: center;margin-top: 5px;width: 90%;margin-left: auto;margin-right: auto;margin-bottom: 20px;">
	         		<c:if test="${empty rec.auditStatusId && param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
	         			<input type="button" value="保&#12288;存" class="search" onclick="saveForm();"/>
	         		</c:if>
<%-- 			         <c:if test="${!empty param.roleFlag && !(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}"> --%>
<%-- 			         	<c:if test="${!empty formDataMap['personalSummary'] && ((empty formDataMap['internshipEvaluation'] && param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER) || (empty formDataMap['isAgaree'] && param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD))}"> --%>
				         <c:if test="${empty rec.headAuditStatusId && param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD}">
				      		<input type="button" value="保&#12288;存" class="search" onclick="save();"/> 	
<%-- 						<input type="button" value="提&#12288;交" class="search" onclick="audit('${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD?recStatusEnumHeadAuditY.id:recStatusEnumTeacherAuditY.id}');"/> --%>
						</c:if>
						 <c:if test="${empty rec.auditStatusId && param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
<%-- 				         	<input type="button" value="提&#12288;交" class="search" onclick="audit('${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD?recStatusEnumHeadAuditY.id:recStatusEnumTeacherAuditY.id}');"/> --%>
							<input type="button" value="保&#12288;存" class="search" onclick="save();"/>
						</c:if>
<%-- 			         	</c:if> --%>
			         		<input type="button" value="关&#12288;闭" class="search" onclick="jboxClose();"/>
<%-- 			         </c:if> --%>
			         <c:if test="${param.isManager}">
			         	<input type="button" value="关&#12288;闭" class="search" onclick="jboxClose();"/>
			         </c:if>
		         </div>
	 		</div>
		         <div id="detail"></div>
</body>
</html>