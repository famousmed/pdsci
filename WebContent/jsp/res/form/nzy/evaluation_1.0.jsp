<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<c:if test="${!param.isLoad}">
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
</c:if>

<script type="text/javascript">
		
	
	$(function(){
		if($('[name="departmentName"]').val()=="" || $('[name="departmentName"]').val()==null ){
			var deptname='${sresult.schDeptName}';
			$('[name="departmentName"]').val(deptname);
		}
		if($('[name="april"]').val()=="" || $('[name="april"]').val()==null ){
			var deptname='${sresult.schMonth}';
			$('[name="april"]').val(deptname);
			
		}
		<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
			
			$(".ctrlInput").attr("readonly",true);
			$("[type='checkbox']").attr("disabled",true);
			$(".jin").hide();
			$('[name="date"]').removeAttr("onclick");
			$('[name="date"]').attr("readonly",true);
		</c:if>
		<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
	
			if($(".theacher").val()!="" && $(".theacher").val()!=null){
				
				$(".ctrlInput").attr("readonly",true);
				$("[type='checkbox']").attr("disabled",true);
				$(".jin").hide();
				$('[name="date"]').removeAttr("onclick");
				$('[name="date"]').attr("readonly",true);
			}
			if($(".theacher").val()=="" || $(".theacher").val()==null){
			
// 				$("textarea").attr("readonly",true);
// 				$("[type='checkbox']").attr("disabled",true);
				$('[name="date"]').removeAttr("onclick");
				$('[name="date"]').attr("readonly",true);
				$('[name="guideTeacher"]').attr("readonly",false);
				var TeacherName=$('[name="guideTeacher"]').val();
				if(TeacherName==""){
					TeacherName='${sessionScope.currUser.userName}';
					$('[name="guideTeacher"]').val(TeacherName);
			};
			}
		</c:if>
		
		<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}">
			if($(".branchDirector").val()!="" && $(".branchDirector").val()!=null){
			
				$(".ctrlInput").attr("readonly",true);
				$("[type='checkbox']").attr("disabled",true);
				$(".jin").hide();
				$('[name="date"]').removeAttr("onclick");
				$('[name="date"]').attr("readonly",true);
			}
			if($(".branchDirector").val()=="" || $(".branchDirector").val()==null){
				
				$('.branchDirector').attr("readonly",false);
				var TeacherName=$('[name="branchDirector"]').val();
				if(TeacherName==""){
					TeacherName='${sessionScope.currUser.userName}';
					$('[name="branchDirector"]').val(TeacherName);
				};
			}
		</c:if>
		hideInput();
		
		$(".scoreCount").keyup(function(){
			var sum = 0;
			$(".scoreCount").each(function(){
				var val = this.value;
				if(val && !isNaN(val)){
					sum+=parseFloat(val);
				}
				$("#totalScore").val(sum);
			});
		});
	});
	function single(box){
		var curr=box.checked;
		if(curr){
			var name=box.name;
			
			$(":checkbox[name='"+name+"']").attr("checked",false);
		}
		box.checked = curr;
	}
	
	function save(){
		if(!$("#evaluationForm").validationEngine("validate")){
			return false;
		}
		
		jboxConfirm("确认提交？提交后将无法修改！",function(){
			
			saveForm();
		},null);
	}
	
	function saveForm(){
		var url = "<s:url value='/res/rec/saveRegistryForm'/>";
		jboxPost(url, $('#evaluationForm').serialize(),function(resp){
			if("${GlobalConstant.SAVE_SUCCESSED}"==resp){
				window.parent.document.mainIframe.location.reload();
				back();
			}
			
		}, null, true);
	}
	function back(){
		if ("${param.openType}"=="open") {
			jboxClose();
		} if ("${param.openType}"=="messager"){
			top.jboxCloseMessager();
		} else {
			$("#detail").rightSlideClose();
		}
	}
	
	function calculate(){
		 var sum = 0;
		 $(".calculate").each(function(){
			 var val = $(this).val();
			 if (val == null || val == undefined || val == '' || isNaN(val)){
					val = 0;
				}
			 sum += parseFloat(val);
		 });
		 $("#total").val(sum);
	}
	
	function hideInput(){
		$(":text[readonly='readonly'],textarea[readonly='readonly']").each(function(){
			var val = this.value;
			$(this).after('<label>'+val+'<input type="hidden" name="'+this.name+'" value="'+val+'"/></label>').remove();
		});
		$(":disabled").each(function(){
			var val = this.value;
			var $parent = $(this).closest("label");
			if(this.checked){
				$parent.after('<label>'+val+'<input type="hidden" name="'+this.name+'" value="'+val+'"/></label>');
			}
			$parent.remove();
		});
		$("[disabled='disabled']:selected").each(function(){
			var val = this.value;
			var $parent = $(this).closest("select");
			$parent.after('<label>'+val+'<input type="hidden" name="'+$parent.attr("name")+'" value="'+val+'"/></label>').remove();
		});
	}
</script>
<style type="text/css">
</style>
</head>
<body>	
   <div class="mainright">
      <div class="content" style="margin-left: -15px;">
        <div class="title1 clearfix" ></div> 
			<form id="evaluationForm">
			<label></label>
				<input type="hidden" name="formFileName" value="${formFileName}"/>
				<input type="hidden" name="schDeptFlow" value="${param.schDeptFlow}"/>
				<input type="hidden" name="recFlow" value="${rec.recFlow}"/>
				<input type="hidden" name="roleFlag" value="${param.roleFlag}"/>
				<input type="hidden" name="operUserFlow" value="${param.userFlow}"/>
				<input type="hidden" name="processFlow" value="${currRegProcess.processFlow}"/>
				<input id="totalScore" type="hidden" name="totalScore" value="${formDataMap['totalScore']}"/>
				<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
					<input type="hidden" name="auditStatusId" value="${recStatusEnumTeacherAuditY.id}"/>
				</c:if>
				<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}">
					<input type="hidden" name="headAuditStatusId" value="${recStatusEnumHeadAuditY.id}"/> 
				</c:if>
				<table class="basic" width="100%" >
					<tr style="display: none; border: red; height: ">
						<td colspan="5"></td>
					</tr>
					<tr>
						<th colspan="5" style="text-align:center;">
							江苏省中医类别住院医师规范化培训科室考核评分表
						</th>
					</tr>
					<tr>
						<td style="border-right:0px;text-align:left;" colspan="5">
							<span style="float: left;">轮转科室名称:<input  class="inputText  ctrlInput" name="departmentName" type="text" value="${formDataMap['departmentName']}" style="width: 120px;" readonly="readonly"/></span>
							<span style="float: right;margin-right: 10px;">共<input  class="inputText  ctrlInput"  name="april" type="text" value="${formDataMap['april']}" style="width: 40px;" readonly="readonly"/>个月</span>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center;">考核内容</td>
						<td style="text-align: center; width:10%">赋分标准</td>
						<td style="text-align: center;">评分标准</td>
						<td style="text-align: center; width:10%" >得分</td>
					</tr>
					<tr>
						<td rowspan="4" width="35px;" style="text-align: center;width: 6%;">
							政<br>
							治<br>
							思<br>
							想
						</td>
						<td>工作责任心,无差错</td>
						<td>20分</td>
						<td>差错一次扣10分,重大医疗纠纷扣20分</td>
						<td style="text-align: center;">
								<input  class="inputText ctrlInput validate[custom[number]] scoreCount" style="width:90%; "  name="responsibility" type="text" value="${formDataMap['responsibility']}" style="width: 150px;"/><br>
						</td>
					</tr>
					<tr>
						<td>服务态度,沟通能力</td>
						<td>10分</td>
						<td>有效投诉一次扣5分</td>
						<td style="text-align: center;">
								<input style="width: 90%; " class="inputText ctrlInput validate[custom[number]] scoreCount"  name="attitude" type="text" value="${formDataMap['attitude']}" style="width: 150px;"/><br>
						</td>
					</tr>
					<tr>
						<td>医德医风,廉洁行医</td>
						<td>10分</td>
						<td>违规一次扣5分</td>
						<td style="text-align: center;">
								<input style="width: 90%; " class="inputText ctrlInput validate[custom[number]] scoreCount" name="doctor" type="text" value="${formDataMap['doctor']}" style="width: 150px;"/><br>
						</td>
					</tr>
					<tr>	
							<td>团结协作,遵守制度</td>
							<td>10分</td>
							<td>违规一次扣2分</td>
							<td style="text-align: center;">
								<input style="width:90%; " class="inputText ctrlInput validate[custom[number]] scoreCount" name="unite" type="text" value="${formDataMap['unite']}" style="width: 150px;"/><br>
							</td>
					</tr>
					<tr>
						<td rowspan="5" style="text-align: center;">
							临<br>
							床<br>
							实<br>
							践
						</td>
						<td>轮转时间和科目</td>
						<td>20分</td>
						<td>轮转时间每少1天扣一分</td>
						<td style="text-align: center;">
								<input style="width: 90%; " class="inputText ctrlInput validate[custom[number]] scoreCount" name="subject" type="text" value="${formDataMap['subject']}" style="width: 150px;"/><br>
						</td>
					</tr>
					<tr>
						<td>掌握病症数量</td>
						<td>30分</td>
						<td>抽查登记册记录及病历,每少1病症扣2分</td>
						<td style="text-align: center;">
								<input style="width: 90%; " class="inputText ctrlInput validate[custom[number]] scoreCount" name="disease" type="text" value="${formDataMap['disease']}" style="width: 150px;"/><br>
						</td>
					</tr>
					<tr>
						<td>掌握病种数量</td>
						<td>30分</td>
						<td>抽查登记册记录及病历,每少1病种扣2分,参与诊疗轮转科室病例数不少于10例,每少1例扣1分(医技科室参照此标准打分)</td>
						<td style="text-align: center;">
								<input style="width:90%; " class="inputText ctrlInput validate[custom[number]] scoreCount" name="diseases" type="text" value="${formDataMap['diseases']}" style="width: 150px;"/><br>
						</td>
					</tr>
					<tr>
						<td>医疗文书书写质量</td>
						<td>30分</td>
						<td>甲级病历率≥90%,每下降5%扣1分,丙级病例不得分;门诊处方,化验单,放射申请单抽查每发现1份不合格的扣0.1分</td>
						<td style="text-align: center;">
							<input style="width: 90%; " class="inputText ctrlInput validate[custom[number]] scoreCount" name="quality" type="text" value="${formDataMap['quality']}" style="width: 150px;"/><br>
						</td>
					</tr>
					<tr>
						<td>掌握轮转科室要求的基本技能</td>
						<td>30分</td>
						<td>科室考核小组根据平时表现打分</td>
						<td style="text-align: center;">
								<input style="width: 90%; " class="inputText ctrlInput validate[custom[number]] scoreCount" name="skill" type="text" value="${formDataMap['skill']}" style="width: 150px;"/><br>
						</td>
					</tr>
					<tr>
						<td rowspan="3" style="text-align: center;">
							医<br>
							学<br>
							理<br>
							论
						</td>
						<td>出科理论考核</td>
						<td>25分</td>
						<td>按100分卷折计</td>
						<td style="text-align: center;">
								<input style="width: 90%; " class="inputText ctrlInput validate[custom[number]] scoreCount" name="theoryAssessment" type="text" value="${formDataMap['theoryAssessment']}" style="width: 150px;"/><br>
						</td>
					</tr>
					<tr>
						<td>读书笔记(《培训细则》规定书目)</td>
						<td>15分</td>
						<td>科室考核小组根据实际情况打分</td>
						<td style="text-align: center;">
								<input style="width: 90%; " class="inputText ctrlInput validate[custom[number]] scoreCount" name="readingNotes" type="text" value="${formDataMap['readingNotes']}" style="width: 150px;"/><br>
						</td>
					</tr>
					<tr>
						<td>参加医院规定的培训和学术活动</td>
						<td>10分</td>
						<td>到会率≥75%,每下降5%扣2分</td>
						<td style="text-align: center;">
								<input style="width:90%; " class="inputText ctrlInput validate[custom[number]] scoreCount" name="activity" type="text" value="${formDataMap['activity']}" style="width: 150px;"/><br>
						</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							考<br>
							勤
						</td>
						<td colspan="3">培训期间除享受国家法定的节假日(不含产假)外,事假每天扣除总学分1分。</td>
						<td style="text-align: center;">
								<input style="width:90%; " class="inputText ctrlInput validate[custom[number]] scoreCount" name="attendance" type="text" value="${formDataMap['attendance']}" style="width: 150px;"/><br>
						</td>
					</tr>
					
					<tr>
						<td style="border-right:0px;">	
						</td>
						<td colspan="4" >
								<span style="padding-right: 100px;" class="ability ctrlInput">
									教学能力:
									<label>
										&nbsp;<input onchange="single(this);" type="checkbox" name="ability" value="优" <c:if test="${formDataMap['ability']=='优'}">checked</c:if>/>
										&nbsp;优
									</label>
									<label>
										&nbsp;<input onchange="single(this);" type="checkbox" name="ability" value="良" <c:if test="${formDataMap['ability']=='良'}">checked</c:if>/>
										&nbsp;良
									</label>
									<label>
										&nbsp;<input onchange="single(this);" type="checkbox" name="ability" value="中" <c:if test="${formDataMap['ability']=='中'}">checked</c:if>/>
										&nbsp;中
									</label>
									<label>
										&nbsp;<input onchange="single(this);" type="checkbox" name="ability" value="差" <c:if test="${formDataMap['ability']=='差'}">checked</c:if>/>
										&nbsp;差
									</label>
<%-- 									<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}"> --%>
<%-- 										<input type="hidden"  name="ability" value="${formDataMap['ability']}"/> --%>
<%-- 									</c:if> --%>
								</span>
								<span class="situation ctrlInput">
									参加各种科研情况:
									<label>
										&nbsp;<input onchange="single(this);" type="checkbox" name="situation" value="有" <c:if test="${formDataMap['situation']=='有'}">checked</c:if>/>
										&nbsp;有
									</label>
									<label>
										&nbsp;<input onchange="single(this);" type="checkbox" name="situation" value="无" <c:if test="${formDataMap['situation']=='无'}">checked</c:if>/>
										&nbsp;无
									</label>
<%-- 									<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}"> --%>
<%-- 										<input type="hidden"  name="situation" value="${formDataMap['situation']}"/> --%>
<%-- 									</c:if> --%>
								</span>
						</td>
					</tr>
					<tr>
						<td style="border-right:0px;text-align:left;" colspan="5" >	
							<span >所在科室意见:</span>
						</td>
						
					</tr>
					<tr>
						<td colspan="5" style="height: 200px;vertical-align: top;">
							<textarea style="width:99%; border:1px solid #bdbebe;	height:150px;	margin:5px 5px 5px 0px" class="ctrlInput" name="opinion">${formDataMap['opinion']}</textarea>
						</td>
           		    </tr>
           		  	<tr >
           		  		<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
							<td style="border-right:0px;text-align:left;" colspan="3" >	
								<span >指导老师签名：<input class=" inputText ctrlInput validate[required] theacher"  name="guideTeacher" type="text" value="${formDataMap['guideTeacher']}" readonly="readonly"  style="width: 120px;"/></span>
							</td>
						</c:if>
						<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER)}">
							<td style="border-right:0px;text-align:left;" colspan="3" >	
								<span >指导老师签名：<input class=" inputText ctrlInput  theacher"  name="guideTeacher" type="text" value="${formDataMap['guideTeacher']}" readonly="readonly" style="width: 120px;"/></span>
							</td>
						</c:if>
						<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}">
							<td colspan="2" style="text-align:right;">	
								<span style="padding-right: 40px;">科主任签名：<input style="width: 120px;" class=" inputText ctrlInput validate[required] branchDirector" readonly="readonly" name="branchDirector" type="text" value="${formDataMap['branchDirector']}" style="width: 150px;"/></span>
							</td>
						</c:if>
						<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD)}">
							<td colspan="2" style="text-align:right;">	
								<span style="padding-right: 40px;">科主任签名：<input style="width: 120px;" class=" inputText ctrlInput branchDirector" readonly="readonly" name="branchDirector" type="text" value="${formDataMap['branchDirector']}" style="width: 150px;"/></span>
							</td>
						</c:if>
						
					</tr>
					<tr>
						<td style="text-align:right;" colspan="5" >	
							<span style="padding-right: 40px;">时间：<input type="text" name="date" value="${empty formDataMap['date']?pdfn:getCurrDate():formDataMap['date']}" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctrlInput time" style="width: 120px;" /></span>
							
						</td>
						
					</tr>
				</table>
				
			</form>
        <div style="text-align: center;margin-top: 5px;">
        	<!-- <input type="button" value="打印考核表" class="search ctrlInput"/> -->
        	<input type="button" value="提&#12288;交" class="search saveBtn  jin" onclick="save();"/>
        	<input type="button" value="关&#12288;闭" class="search ctrlInput" onclick="back();"/>
        </div>
   </div>	
  </div>
</body>
</html>