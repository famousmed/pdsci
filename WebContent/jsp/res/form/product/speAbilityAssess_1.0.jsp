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
	<jsp:param name="jquery_cxselect" value="true"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="false"/>
	<jsp:param name="jquery_placeholder" value="false"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<style type="text/css">
	table.formBasic th,table.formBasic td{padding: 0px;text-align: center;}
</style>
	<script type="text/javascript">
	function save(){
		if($("#speAbilityAssess").validationEngine("validate")){
			jboxConfirm("确认保存？保存之后不可修改！",function(){
			jboxPost("<s:url value='/res/rec/saveRegistryForm'/>",$("#speAbilityAssess").serialize(),function(resp){
				if(resp=="${GlobalConstant.SAVE_SUCCESSED}"){
  						top.document.mainIframe.$("#tags .selectTag a").click();
 						jboxClose();
				}				
			},null,true);
			});
		}
		 if(!$("#speAbilityAssess").validationEngine("validate")){
				return;
			}
		 
	}
	function saveForm(){
		if($("#speAbilityAssess").validationEngine("validate")){
			jboxPost("<s:url value='/res/rec/saveRegistryForm'/>",$("#speAbilityAssess").serialize(),function(resp){
				if(resp=="${GlobalConstant.SAVE_SUCCESSED}"){
  						top.document.mainIframe.$("#tags .selectTag a").click();
 						jboxClose();
				}				
			},null,true);
		}
		 if(!$("#speAbilityAssess").validationEngine("validate")){
				return;
			}
		 
	}
	function isInt(num){
		return !isNaN(num) && num!="";
	}
	
	function check(num,flag){
		var item = $("."+flag);
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
		
		var itemCount = item.length;
		
		var avg = sum/itemCount;
		<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
			$("#zhSelfAccess label").text(avg);
			$("#zhSelfAccess input").val(avg);
		</c:if>
		<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_MANAGER}">
			$("#zhDirectorAccess label").text(avg);
			$("#zhDirectorAccess input").val(avg);
		</c:if>
	}
		$(function(){
		$(".ctrlInput").attr("readonly",true);
		$(".ctrlInput.${param.roleFlag}").attr("readonly",false);
		<c:if test="${!empty rec.auditStatusId}">
			$(".toggleView,.toggleView2").toggle();
		 </c:if>
// 		 <c:if test="${!empty formDataMap['managerAutograph']}">
// 			$(".toggleView2").toggle();
// 		 </c:if>
	});
	
	</script>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<div style="margin-bottom: 10px;">
					  <h3 align="center">上海交通大学医学院附属上海儿童医学中心</h3>
					  <h3 align="center">(医生/技术人员)专业能力评估表【非手术科室】</h3>
				</div>
				<form id="speAbilityAssess" method="post">
				 <input type="hidden" name="formFileName" value="${formFileName}"/>
				 <input type="hidden" name="recFlow" value="${rec.recFlow}"/>
				 <input type="hidden" name="processFlow" value="${currRegProcess.processFlow}"/>
				 <c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_MANAGER}">
					 <input type="hidden" name="managerAuditStatusId" value="${recStatusEnumManagerAuditY.id}"/>
				 </c:if>
				
				<table class="basic" style="width: 100%;">
					<tr>
					<td style="text-align: center; width: 155px;">
						姓&#12288;&#12288;&#12288;&#12288;&nbsp;名</td>
					<td style="text-align: center; width: 200px;">
						<input type="text" style="width: 126px; " class="toggleView inputText validate[required] ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="name" value="<c:out value="${formDataMap['name']}" default="${sessionScope.currUser.userName}"/>"/>
						<label style="display: none;" class="toggleView">${formDataMap['name']}</label>
					</td>
					<td style="text-align: center;width: 155px;">职&#12288;称&#12288;(职&nbsp;务)</td>
					<td style="text-align: center;width: 200px;">
						<c:set var="postAndTitle" value="${sessionScope.currUser.postName}（${sessionScope.currUser.titleName}）"/>
						<input type="text" class="toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="titlePost" value="${empty formDataMap['titlePost']?postAndTitle:formDataMap['titlePost']}"/>
						<label style="display: none;" class="toggleView">${formDataMap['titlePost']}</label>
					</td>
					</tr>
					<tr>
						<td style="text-align: center;">出&#12288;&#12288;&#12288;&#12288;勤 </td>
						<td style="text-align: center;">
							<input type="text" class="toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="attendance" value="${formDataMap['attendance']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['attendance']}</label>
						</td>
						<td style="text-align: center;">考&#12288;核&#12288;时&#12288;间</td>
						<td style="text-align: center;">
							<input type="text" class="toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="assessmentTime" value="${formDataMap['assessmentTime']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['assessmentTime']}</label>
						</td>
					</tr>
					<tr>
						<td style="text-align: center;">病房工作时间 </td>
						<td style="text-align: center;">
							<input type="text" class="toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="wardTime" value="${formDataMap['wardTime']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['wardTime']}</label>
						</td>
						<td style="text-align: center;">门急诊工作时间</td>
						<td style="text-align: center;">
							<input type="text" class="toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="doorTime" value="${formDataMap['doorTime']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['doorTime']}</label>
						</td>
					</tr>	
				</table>
				<table class="basic formBasic" style="margin-top: 10px; width: 100%;">
					<tr>
						<td rowspan="2" colspan="2" style="width: 50%;">评价内容</td>
						<td colspan="2" style="width: 50%;">评价等级(0-5分)</td>
					</tr>
					<tr>
						<td style="width: 25%;">自我评价</td>
						<td style="width: 25%;">主管评价</td>
					</tr>
					<tr>
						<td rowspan="4"><span style="float: left;">&#12288;1.&#12288;工作量</span></td>
						<td><span style="float: left;">&#12288;普通门/急诊量</span></td>
						<td style="width: 170px;">
							<input  type="text" style="width: 60px;" onchange="check(this.value,'doctorScore');" class="doctorScore toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="ptSelfAccess" value="${formDataMap['ptSelfAccess']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['ptSelfAccess']}</label>
						</td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'managerScore');" class="managerScore toggleView2 inputText ${GlobalConstant.RES_ROLE_SCOPE_MANAGER} ctrlInput" name="ptDirectorAccess" value="${formDataMap['ptDirectorAccess']}"/>
							<label style="display: none;" class="toggleView2">${formDataMap['ptDirectorAccess']}</label>
						</td>
					</tr>
					<tr>
						<td style="width: 170px;"><span style="float: left;">&#12288;专科/专家门诊量</span></td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'doctorScore');" class="doctorScore toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="zkSelfAccess" value="${formDataMap['zkSelfAccess']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['zkSelfAccess']}</label>
						</td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'managerScore');" class="managerScore toggleView2 inputText ${GlobalConstant.RES_ROLE_SCOPE_MANAGER} ctrlInput" name="zkDirectorAccess" value="${formDataMap['zkDirectorAccess']}"/>
							<label style="display: none;" class="toggleView2">${formDataMap['zkDirectorAccess']}</label>	
						</td>
					</tr>
					<tr>
						<td><span style="float: left;">&#12288;手术/有效操作数量</span></td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'doctorScore');" class="doctorScore toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="ssSelfAccess" value="${formDataMap['ssSelfAccess']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['ssSelfAccess']}</label>
						</td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'managerScore');" class="managerScore toggleView2 inputText ${GlobalConstant.RES_ROLE_SCOPE_MANAGER} ctrlInput" name="ssDirectorAccess" value="${formDataMap['ssDirectorAccess']}"/>
							<label style="display: none;" class="toggleView2">${formDataMap['ssDirectorAccess']}</label>
						</td>
					</tr>
					<tr>
						<td><span style="float: left;">&#12288;出院病人数</span></td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'doctorScore');" class="doctorScore toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="cySelfAccess" value="${formDataMap['cySelfAccess']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['cySelfAccess']}</label>
						</td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'managerScore');" class="managerScore toggleView2 inputText ${GlobalConstant.RES_ROLE_SCOPE_MANAGER} ctrlInput" name="cyDirectorAccess" value="${formDataMap['cyDirectorAccess']}"/>
							<label style="display: none;" class="toggleView2">${formDataMap['cyDirectorAccess']}</label>
						</td>
					</tr>
					<tr>
						<td colspan="2"><span style="float: left;">&#12288;2.&#12288;危重/疑难病例诊疗数量</span></td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'doctorScore');" class="doctorScore toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="wzSelfAccess" value="${formDataMap['wzSelfAccess']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['wzSelfAccess']}</label>
						</td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'managerScore');" class="managerScore toggleView2 inputText ${GlobalConstant.RES_ROLE_SCOPE_MANAGER} ctrlInput" name="wzDirectorAccess" value="${formDataMap['wzDirectorAccess']}"/>
							<label style="display: none;" class="toggleView2">${formDataMap['wzDirectorAccess']}</label>
						</td>
					</tr>
					<tr>
						<td colspan="2"><span style="float: left;">&#12288;3.&#12288;住院病史书写规范</span></td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'doctorScore');" class="doctorScore toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="zySelfAccess" value="${formDataMap['zySelfAccess']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['zySelfAccess']}</label>
						</td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'managerScore');" class="managerScore toggleView2 inputText ${GlobalConstant.RES_ROLE_SCOPE_MANAGER} ctrlInput" name="zyDirectorAccess" value="${formDataMap['zyDirectorAccess']}"/>
							<label style="display: none;" class="toggleView2">${formDataMap['zyDirectorAccess']}</label>
						</td>
					</tr>
					<tr>
						<td colspan="2"><span style="float: left;">&#12288;4.&#12288;三级查房质量</span></td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'doctorScore');" class="doctorScore toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="sjSelfAccess" value="${formDataMap['sjSelfAccess']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['sjSelfAccess']}</label>
						</td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'managerScore');" class="managerScore toggleView2 inputText ${GlobalConstant.RES_ROLE_SCOPE_MANAGER} ctrlInput" name="sjDirectorAccess" value="${formDataMap['sjDirectorAccess']}"/>
							<label style="display: none;"  class="toggleView2">${formDataMap['sjDirectorAccess']}</label>
						</td>
					</tr>
					<tr>
						<td colspan="2"><span style="float: left;">&#12288;5.&#12288;合理使用抗菌药物(病房,门诊)</span></td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'doctorScore');" class="doctorScore toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="hlSelfAccess" value="${formDataMap['hlSelfAccess']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['hlSelfAccess']}</label>
						</td>
						<td>
							<input type="text"  style="width: 60px;" onchange="check(this.value,'managerScore');" class="managerScore toggleView2 inputText ${GlobalConstant.RES_ROLE_SCOPE_MANAGER} ctrlInput" name="hlDirectorAccess" value="${formDataMap['hlDirectorAccess']}"/>
							<label style="display: none;" class="toggleView2">${formDataMap['hlDirectorAccess']}</label>
						</td>
					</tr>
					<tr>
						<td colspan="2"><span style="float: left;">&#12288;6.&#12288;院内感染控制情况</span></td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'doctorScore');" class="doctorScore toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput"  name="ynSelfAccess" value="${formDataMap['ynSelfAccess']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['ynSelfAccess']}</label>
						</td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'managerScore');" class="managerScore toggleView2 inputText ${GlobalConstant.RES_ROLE_SCOPE_MANAGER} ctrlInput"  name="ynDirectorAccess" value="${formDataMap['ynDirectorAccess']}"/>
							<label style="display: none;"  class="toggleView2">${formDataMap['ynDirectorAccess']}</label>
						</td>
					</tr>
					<tr>
						<td colspan="2"><span style="float: left;">&#12288;7.&#12288;门诊病史质量</span></td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'doctorScore');" class="doctorScore toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="mzSelfAccess" value="${formDataMap['mzSelfAccess']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['mzSelfAccess']}</label>
						</td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'managerScore');" class="managerScore toggleView2 inputText ${GlobalConstant.RES_ROLE_SCOPE_MANAGER} ctrlInput" name="mzDirectorAccess" value="${formDataMap['mzDirectorAccess']}"/>
							<label style="display: none;"  class="toggleView2">${formDataMap['mzDirectorAccess']}</label>
						</td>
					</tr>
					<tr>
						<td colspan="2"><span style="float: left;">&#12288;8.&#12288;合理处方</span></td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'doctorScore');" class="doctorScore toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="cfSelfAccess" value="${formDataMap['cfSelfAccess']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['cfSelfAccess']}</label>
						</td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'managerScore');" class="managerScore toggleView2 inputText ${GlobalConstant.RES_ROLE_SCOPE_MANAGER}ctrlInput" name="cfDirectorAccess" value="${formDataMap['cfDirectorAccess']}"/>
							<label style="display: none;"  class="toggleView2">${formDataMap['cfDirectorAccess']}</label>
						</td>
					</tr>
					<tr>
						<td colspan="2"><span style="float: left;">&#12288;9.&#12288;门诊专科/专家预约率</span></td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'doctorScore');" class="doctorScore toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="zjSelfAccess" value="${formDataMap['zjSelfAccess']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['zjSelfAccess']}</label>
						</td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'managerScore');" class="managerScore toggleView2 inputText ${GlobalConstant.RES_ROLE_SCOPE_MANAGER} ctrlInput" name="zjDirectorAccess" value="${formDataMap['zjDirectorAccess']}"/>
							<label style="display: none;" class="toggleView2">${formDataMap['zjDirectorAccess']}</label>
						</td>
					</tr>
					<tr>
						<td colspan="2"><span style="float: left;">&#12288;10.&#12288;科室业务学习/医疗质量讲评/(主持/参与)情况</span></td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'doctorScore');" class="doctorScore toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="ksSelfAccess" value="${formDataMap['ksSelfAccess']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['ksSelfAccess']}</label>
						</td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'managerScore');" class="managerScore toggleView2 inputText ${GlobalConstant.RES_ROLE_SCOPE_MANAGER} ctrlInput" name="ksDirectorAccess" value="${formDataMap['ksDirectorAccess']}"/>
							<label style="display: none;" class="toggleView2">${formDataMap['ksDirectorAccess']}</label>
						</td>
					</tr>
					<tr>
						<td colspan="2"><span style="float: left;">&#12288;11.&#12288;医院业务学习/医疗质量讲评参与情况</span></td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'doctorScore');" class="doctorScore toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="yySelfAccess" value="${formDataMap['yySelfAccess']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['yySelfAccess']}</label>
						</td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'managerScore');" class="managerScore toggleView2 inputText ${GlobalConstant.RES_ROLE_SCOPE_MANAGER} ctrlInput" name="yyDirectorAccess" value="${formDataMap['yyDirectorAccess']}"/>
							<label style="display: none;" class="toggleView2">${formDataMap['yyDirectorAccess']}</label>
						</td>
					</tr>
					<tr>
						<td colspan="2"><span style="float: left;">&#12288;12.&#12288;患者满意度(褒奖情况)</span></td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'doctorScore');" class="doctorScore toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="hzSelfAccess" value="${formDataMap['hzSelfAccess']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['hzSelfAccess']}</label>
						</td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'managerScore');" class="managerScore toggleView2 inputText ${GlobalConstant.RES_ROLE_SCOPE_MANAGER} ctrlInput" name="hzDirectorAccess" value="${formDataMap['hzDirectorAccess']}"/>
							<label style="display: none;" class="toggleView2">${formDataMap['hzDirectorAccess']}</label>
						</td>
					</tr>
					<tr>
						<td colspan="2"><span style="float: left;">&#12288;13.&#12288;医疗投诉/差错/事故</span></td>
						<td>
							<input type="text" style="width: 60px;" style="width: 60px;" onchange="check(this.value,'doctorScore');" class="doctorScore toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="ylSelfAccess" value="${formDataMap['ylSelfAccess']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['ylSelfAccess']}</label>
						</td>
						<td>
							<input type="text" style="width: 60px;" onchange="check(this.value,'managerScore');" class="managerScore toggleView2 inputText ${GlobalConstant.RES_ROLE_SCOPE_MANAGER} ctrlInput" name="ylDirectorAccess" value="${formDataMap['ylDirectorAccess']}"/>
							<label style="display: none;" class="toggleView2">${formDataMap['ylDirectorAccess']}</label>
						</td>
					</tr>
					<tr>
						<td colspan="2"><span style="float: left;">&#12288;综合评分(按项目平均分计，满分5分)</span></td>
						<td id="zhSelfAccess">
							<input type="text" style="width: 60px;" class="toggleView inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="zhSelfAccess" value="${formDataMap['zhSelfAccess']}"/>
							<label style="display: none;" class="toggleView">${formDataMap['zhSelfAccess']}</label>
						</td>
						<td id="zhDirectorAccess">
							<input type="text" style="width: 60px;" class="toggleView2 inputText ${GlobalConstant.RES_ROLE_SCOPE_MANAGER} ctrlInput"  name="zhDirectorAccess" value="${formDataMap['zhDirectorAccess']}"/>
							<label style="display: none;" class="toggleView2">${formDataMap['zhDirectorAccess']}</label>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: left;">
							<span>&#12288;本人签名：
							<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
								<input class="toggleView inputText validate[required] ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" type="text" name="selfAutograph"  value="<c:out value="${formDataMap['selfAutograph']}" default="${sessionScope.currUser.userName}"/>"  style="width: 100px;"/>
								<label style="display: none;" class="toggleView">${formDataMap['selfAutograph']}</label>
							</c:if>
							<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_DOCTOR }">
								<label c style="width: 100px;display: inline-block;">${formDataMap['selfAutograph']}</label>
								<input type="hidden" name="selfAutograph" value="${formDataMap['selfAutograph']}"/>
							</c:if>
							</span><br>
							<span style="margin-bottom: 5px;">&#12288;日&#12288;&nbsp;&nbsp;&nbsp;期 :&nbsp;&nbsp;
								<c:if test="${ param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
									<input type="text" class="toggleView inputText validate[required] " readonly="readonly" name="selfAutographDate" value="<c:out value="${formDataMap['selfAutographDate']}" default="${pdfn:getCurrDate()}"/>" style="width: 100px;"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
									<label style="display: none;" class="toggleView">${formDataMap['selfAutographDate']}</label>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_DOCTOR }">
									<label  style="width: 100px;display: inline-block;">${formDataMap['selfAutographDate']}</label>
									<input type="hidden" name="selfAutograph" value="${formDataMap['selfAutographDate']}"/>
								</c:if>
							</span>
						</td>
						
						<td colspan="2" style="text-align: left;">
							<span style="">&#12288;主管签名：
							<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_MANAGER}">
								<input type="text" class="toggleView2 inputText validate[required]" name="managerAutograph"  value="${empty formDataMap['managerAutograph']?sessionScope.currUser.userName:formDataMap['managerAutograph']}" style="width: 100px;"/>
								<label style="display: none;" class="toggleView2">${formDataMap['managerAutograph']}</label>
							</c:if>
							<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_MANAGER }">
								<label style="width: 100px;display: inline-block;">${formDataMap['managerAutograph']}</label>
								<input type="hidden" name="managerAutograph" value="${formDataMap['managerAutograph']}"/>
							</c:if>
							</span><br>
							<span style="margin-bottom: 5px;">&#12288;日&#12288;&nbsp;&nbsp;&nbsp;期 :&nbsp;&nbsp;
								<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_MANAGER}">
									<input class="toggleView2 inputText validate[required]" type="text" name="managerAutographDate"  value="${empty formDataMap['managerAutographDate']?pdfn:getCurrDate():formDataMap['managerAutographDate']}" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" style="width: 100px;"/>
									<label style="display: none;" class="toggleView2">${formDataMap['managerAutographDate']}</label>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_MANAGER }">
									<label style="width: 100px;display: inline-block;">${formDataMap['managerAutographDate']}</label>
									<input type="hidden" name="managerAutographDate" value="${formDataMap['managerAutographDate']}"/>
								</c:if>
							</span>
						</td>
					</tr>
				</table>
				<div align="right" style="margin-top: 10px;" >
					<c:if test="${ param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
						<input type="text" class="inputText validate[required] " name="year" value="<c:out value="${formDataMap['year']}" default="${pdfn:getCurrYear()}"/>" style="width: 70px;" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy'});"/>
					</c:if>
				<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_DOCTOR }">
						<label class="inputText" style="width: 50px;display: inline-block;">${formDataMap['year']}</label>
						<input type="hidden" name="year" value="${formDataMap['year']}"/>
				</c:if>
				年度
				<c:if test="${ param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
				<select name="schDeptFlow" style="width: 100px;"  class="toggleView validate[required]" onchange="$('#department').val($(':selected',this).text());">
					<option value="">请选择</option>
					<c:forEach items="${deptList}" var="dept">
						<option value="${dept.schDeptFlow}" <c:if test="${empty formDataMap['schDeptFlow']?(dept.schDeptFlow==process.schDeptFlow):(dept.schDeptFlow==formDataMap['schDeptFlow'])}">selected</c:if>>${dept.schDeptName}</option>
					</c:forEach>
				</select>
				<label style="display: none;" class="toggleView">${formDataMap['department']}</label>
				<input id="department" type="hidden" name="department" value="${empty formDataMap['department']?process.schDeptName:formDataMap['department']}"/>
				</c:if>
				<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_DOCTOR }">
					<label class="inputText" style="width: 100px;display: inline-block;">${formDataMap['department']}</label>
					<input type="hidden" name="department" value="${formDataMap['department']}"/>
				</c:if>
				科室
				</div>
				<div align="right" style="margin-top: 10px;">医务部
						<c:if test="${ param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
							<input type="text" class="inputText ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput" name="medicalDepartment" value="${formDataMap['medicalDepartment']}" style="width: 190px;" />
						</c:if>
						<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_DOCTOR }">
							<label class="inputText" style="width: 170px;display: inline-block;">${formDataMap['medicalDepartment']}</label>
							<input type="hidden" name="medicalDepartment" value="${formDataMap['medicalDepartment']}"/>
						</c:if>
				</div>
				</form>
				
				<div align="center" style="margin-top: 10px;">
					<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR }">
<%--  					<c:if test="${empty formDataMap['selfAutograph'] && param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">  --%>
						<input type="button" class="search" onclick="saveForm();" value="保&#12288;存">
					</c:if> 
					<c:if test="${empty formDataMap['managerAutograph'] && param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_MANAGER}"> 
						<input type="button" class="search" onclick="save();" value="保&#12288;存">
					</c:if>
					<input type="button" class="search" onclick="jboxClose();" value="关&#12288;闭"></div>
				</div>
				
			</div>
		</div>
</body>
</html>