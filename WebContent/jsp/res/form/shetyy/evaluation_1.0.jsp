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
	var ENTER = 13;
	var UP = 38;
	var DOWN = 40;
	$(document).ready(function(){
		readOnly($(".ctrlInput"),true);
		if("${param.roleFlag}"=="${GlobalConstant.RES_ROLE_SCOPE_MANAGER}"){
			if("true"=="${empty formDataMap['kzr']}"){
				$("#message").text("（科主任未填写，教研室暂时不能填写！）");
			}else{
				if("true"=="${empty formDataMap['jys']}"){
					readOnly($(".${param.roleFlag} .ctrlInput"), false);
					$("#saveBtn").show();
				}
			}
		}else if("${param.roleFlag}"=="${GlobalConstant.RES_ROLE_SCOPE_HEAD}"){
			if("true"=="${empty formDataMap['kzr']}"){
				readOnly($(".${param.roleFlag} .ctrlInput"), false);
				$("#saveBtn").show();
			}
		}else if("${param.roleFlag}"=="${GlobalConstant.RES_ROLE_SCOPE_TEACHER}"){
			if("true"=="${empty formDataMap['jxgs']}"){
				readOnly($(".${param.roleFlag} .ctrlInput"), false);
				$("#saveBtn").show();
			}
		} 
		$(".calculate").keyup(function(){
			var index = $(".calculate").index(this);
			var keyCode = window.event.keyCode;
			if(keyCode==ENTER || keyCode==DOWN){
				$(".calculate:eq("+(++index)+")").focus();
			}
		 });
		$("[readonly]").css("border","none");
	});
	
	function readOnly($inputs,lock){
		$inputs.each(function(){
			var type = this.type;
			var className = this.className;
			if("checkbox,radio".indexOf(type)>=0){
				this.disabled = lock;
			}
			if(className.indexOf("time")<0){
				$(this).attr("readonly",lock);
				//$(this).addClass("borderNone");
			}else if(className.indexOf("time")>=0){
				if(lock){
					this.onclick = null;
					//$(this).addClass("borderNone");
				}else{
					this.onclick = function(){WdatePicker({dateFmt:'yyyy-MM-dd'});};
				}
			}
		});
		/* $(":disabled:checked").each(function(){
			$("#evaluationForm").append($(this).clone().attr({"type":"hidden","disabled":false}));
		}); */
	}
	
	function save(){
		if(!$("#evaluationForm").validationEngine("validate")){
			return false;
		}
		jboxConfirm("确认保存？保存之后不可修改！",function(){
			saveForm();
		},null);
	}
	
	function saveForm(){
		var url = "<s:url value='/res/rec/saveRegistryForm'/>";
		var reason = [];
		$(".reason:checked").each(function(){
			reason.push(this.value);
		});
		$("[name='reason']").val(reason.toString());
		jboxPost(url, $('#evaluationForm').serialize(),function(resp){
			if("${GlobalConstant.SAVE_SUCCESSED}"==resp){
				if("${param.reloadFlag}" != "${GlobalConstant.FLAG_N}"){
					window.parent.frames['mainIframe'].location.reload(true);
				}
				back();
			}
		}, null, true);
	}
	
	function back(){
		if("${param.openType}"=="open"){
			jboxClose();
		}else if("${param.openType}"=="messager"){
			top.jboxCloseMessager();
		}else{
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
		 $("#total").val(parseFloat(sum.toFixed(3)));
	}
</script>
<style type="text/css">
	#tab0 tr td{padding-bottom: 10px;}
	#tab2 tr td{padding-bottom: 10px;}
	#tab3 tr td{padding-bottom: 10px;}
	.borderNone{border-bottom-style: none;}
</style>

</head>
<body>	
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix"></div> 
			<form id="evaluationForm">
				<input type="hidden" name="formFileName" value="${formFileName}"/>
				<input type="hidden" name="schDeptFlow" value="${param.schDeptFlow}"/>
				<input type="hidden" name="recFlow" value="${rec.recFlow}"/>
				<input type="hidden" name="roleFlag" value="${param.roleFlag}"/>
				<input type="hidden" name="operUserFlow" value="${param.userFlow}"/>
				<input type="hidden" name="processFlow" value="${currRegProcess.processFlow}"/>
				<c:if test="${GlobalConstant.RES_ROLE_SCOPE_MANAGER eq param.roleFlag}">
					<input type="hidden" name="managerAuditStatusId" value="${recStatusEnumManagerAuditY.id}"/>
				</c:if>
				<c:if test="${GlobalConstant.RES_ROLE_SCOPE_HEAD eq param.roleFlag}">
					<input type="hidden" name="headAuditStatusId" value="${recStatusEnumHeadAuditY.id}"/>
				</c:if>
				<c:if test="${GlobalConstant.RES_ROLE_SCOPE_TEACHER eq param.roleFlag}">
					<input type="hidden" name="auditStatusId" value="${recStatusEnumTeacherAuditY.id}"/>
				</c:if>
				<table id="tab0" style="width: 100%;">
					<tr>
						<td style="text-align: center;">上海儿童医学中心住院医师医师规范化培训</td>
					</tr>
					<tr>
						<td style="text-align: center;">出科考核评分表（儿科基地）</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<c:set var="turnTime" value="${result.schStartDate}~${result.schEndDate}"/>
							姓名：<label>${empty formDataMap['userName']?doctor.doctorName:formDataMap['userName']}</label>&#12288;&#12288;
							轮转专业：<label>${empty formDataMap['turnMajor']?doctor.trainingSpeName:formDataMap['turnMajor']}</label>&#12288;&#12288;
							轮转时间：<label>${empty formDataMap['turnTime']?turnTime:formDataMap['turnTime']}</label>
							<input type="hidden" name="userName" value="${empty formDataMap['userName']?doctor.doctorName:formDataMap['userName']}"/>
							<input type="hidden" name="turnMajor" value="${empty formDataMap['turnMajor']?doctor.trainingSpeName:formDataMap['turnMajor']}"/>
							<input type="hidden" name="turnTime" value="${empty formDataMap['turnTime']?turnTime:formDataMap['turnTime']}"/>
						</td>
					</tr>
				</table>
				
				<table id="tab1" class="${GlobalConstant.RES_ROLE_SCOPE_TEACHER} bs_tb ${GlobalConstant.RES_ROLE_SCOPE_HEAD}" style="width: 100%;margin-top: 10px;">
					<tr>
						<td width="26%">考核项目</td>
						<td width="54%">内容</td>
						<td width="10%">分值</td>
						<td width="10%">得分</td>
					</tr>
					<tbody id="tbody1">
					<tr>
						<td>入院大病历</td>
						<td>于出科考前提交给教学干事入院大病历（含诊断依据、鉴别诊断）2份（轮转时间少于2月者，写1份）</td>
						<td>10</td>
						<td><input type="text" name="rydbl" value="${formDataMap['rydbl']}" onchange="calculate();" class="validate[custom[number,max[10],min[0]]] inputText calculate ctrlInput" style="width: 90%;"/></td>
					</tr>
					<tr>
						<td>医师职业道德考核</td>
						<td>工作纪律、服务态度</td>
						<td>10</td>
						<td><input type="text" name="yszyddkh" value="${formDataMap['yszyddkh']}" onchange="calculate();" class="validate[custom[number,max[10],min[0]]] inputText calculate ctrlInput" style="width: 90%;"/></td>
					</tr>
					<tr>
						<td>出勤情况</td>
						<td>
							<script type="text/javascript">
								function cancleRadio(radio){
									var selStatus = radio.checked;
									$("[name='ywxlqk']").attr("checked",false);
									radio.checked = selStatus;
								}
							</script>
							轮转期间累计请假时间：<input type="text" name="lzqjljqjsj" value="${formDataMap['lzqjljqjsj']}" class="ctrlInput validate[custom[number]] inputText" style="width: 50px;"/>天<br/>
							有无下列情况：
							<label><input onchange="cancleRadio(this);" type="checkbox" name="ywxlqk" value="迟到" class="ctrlInput" <c:if test="${formDataMap['ywxlqk'] eq '迟到'}">checked</c:if>/>&nbsp;迟到</label>&nbsp;
							<label><input onchange="cancleRadio(this);" type="checkbox" name="ywxlqk" value="早退" class="ctrlInput" <c:if test="${formDataMap['ywxlqk'] eq '早退'}">checked</c:if>/>&nbsp;早退</label>&nbsp;
							<label><input onchange="cancleRadio(this);" type="checkbox" name="ywxlqk" value="旷工" class="ctrlInput" <c:if test="${formDataMap['ywxlqk'] eq '旷工'}">checked</c:if>/>&nbsp;旷工</label>&nbsp;
							<label><input onchange="cancleRadio(this);" type="checkbox" name="ywxlqk" value="其它" class="ctrlInput" <c:if test="${formDataMap['ywxlqk'] eq '其它'}">checked</c:if>/>&nbsp;其它</label>:<input type="text" name="ywxlqk_qt" value="${formDataMap['ywxlqk_qt']}" class="inputText ctrlInput" style="width: 60px;margin-bottom: 5px;"/>
						</td>
						<td>10</td>
						<td><input type="text" name="cqzk" value="${formDataMap['cqzk']}" onchange="calculate();" class="validate[custom[number,max[10],min[0]]] inputText calculate ctrlInput" style="width: 90%;"/></td>
					</tr>
					<tr>
						<td>《住院医师规范化培训登记手册》</td>
						<td>完成轮转计划，完整填写《住院医师规范化培训登记手册》</td>
						<td>10</td>
						<td><input type="text" name="zyysgfhdjsc" value="${formDataMap['zyysgfhdjsc']}" onchange="calculate();" class="validate[custom[number,max[10],min[0]]] inputText calculate ctrlInput" style="width: 90%;"/></td>
					</tr>
					<tr>
						<td rowspan="4">临床综合能力考核</td>
						<td>理论考试</td>
						<td>20</td>
						<td><input type="text" name="llks" value="${formDataMap['llks']}" onchange="calculate();" class="validate[custom[number,max[20],min[0]]] inputText calculate ctrlInput" style="width: 90%;"/></td>
					</tr>
					<tr>
						<td>病例分析考核</td>
						<td>20</td>
						<td><input type="text" name="blfxkh" value="${formDataMap['blfxkh']}" onchange="calculate();" class="validate[custom[number,max[20],min[0]]] inputText calculate ctrlInput" style="width: 90%;"/></td>
					</tr>
					<tr>
						<td>体格检查</td>
						<td>10</td>
						<td><input type="text" name="tgjc" value="${formDataMap['tgjc']}" onchange="calculate();" class="validate[custom[number,max[10],min[0]]] inputText calculate ctrlInput" style="width: 90%;"/></td>
					</tr>
					<tr>
						<td>临床操作</td>
						<td>10</td>
						<td><input type="text" name="lccz" value="${formDataMap['lccz']}" onchange="calculate();" class="validate[custom[number,max[10],min[0]]] inputText calculate ctrlInput" style="width: 90%;"/></td>
					</tr>
					</tbody>
					<tr>
						<td colspan="2">合计</td>
						<td>100</td>
						<td><input type="text" id="total" name="totalScore" value="${formDataMap['totalScore']}" class="validate[custom[number]] inputText ctrlInput" style="width: 90%;border-bottom-style: none;" readonly="readonly"/></td>
					</tr>
				</table>
				
				<table id="tab2" style="width: 100%;margin-top: 20px;">
					<tr>
						<td width="25%" style="text-align: right;">
							<c:if test="${param.roleFlag == GlobalConstant.RES_ROLE_SCOPE_TEACHER}"><span style="color: red">*</span></c:if>教学干事：
						</td>
						<c:if test="${param.roleFlag == GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
							<td width="25%" class="${GlobalConstant.RES_ROLE_SCOPE_TEACHER}"><input type="text" id="jxgs" name="jxgs" value="${empty formDataMap['jxgs']?sessionScope.currUser.userName:formDataMap['jxgs']}" class="validate[required] inputText ctrlInput" style="width: 120px;"/></td>
						</c:if>
						<c:if test="${param.roleFlag != GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
							<td width="25%">${formDataMap['jxgs']}<input type="hidden" name="jxgs" value="${formDataMap['jxgs']}"/></td>
						</c:if>
						
						<td width="25%" style="text-align: right;">
							<c:if test="${param.roleFlag == GlobalConstant.RES_ROLE_SCOPE_HEAD}"><span style="color: red">*</span></c:if>科主任：
						</td>
						<c:if test="${param.roleFlag == GlobalConstant.RES_ROLE_SCOPE_HEAD}">
							<td width="25%" class="${GlobalConstant.RES_ROLE_SCOPE_HEAD}"><input type="text" id="kzr" name="kzr" value="${empty formDataMap['kzr']?sessionScope.currUser.userName:formDataMap['kzr']}" class="validate[required] inputText ctrlInput" style="width: 120px;"/></td>
						</c:if>
						<c:if test="${param.roleFlag != GlobalConstant.RES_ROLE_SCOPE_HEAD}">
							<td width="25%" >${formDataMap['kzr']}<input type="hidden" name="kzr" value="${formDataMap['kzr']}"/></td>
						</c:if>
					</tr>
					
					<tr>
						<td style="text-align: right;">
							<c:if test="${param.roleFlag == GlobalConstant.RES_ROLE_SCOPE_TEACHER}"><span style="color: red">*</span></c:if>日期：
						</td>
						<c:if test="${param.roleFlag == GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
							<td class="${GlobalConstant.RES_ROLE_SCOPE_TEACHER}"><input type="text" id="jxgsrq" name="jxgsrq" value="${empty formDataMap['jxgsrq']?pdfn:getCurrDate():formDataMap['jxgsrq']}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="validate[required] inputText ctrlInput time" style="width: 120px;" readonly="readonly"/></td>
						</c:if>
						<c:if test="${param.roleFlag != GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
							<td width="30%">${formDataMap['jxgsrq']}<input type="hidden" name="jxgsrq" value="${formDataMap['jxgsrq']}"/></td>
						</c:if>
						
						<td style="text-align: right;">
							<c:if test="${param.roleFlag == GlobalConstant.RES_ROLE_SCOPE_HEAD}"><span style="color: red">*</span></c:if>日期：
						</td>
						<c:if test="${param.roleFlag == GlobalConstant.RES_ROLE_SCOPE_HEAD}">
							<td class="${GlobalConstant.RES_ROLE_SCOPE_HEAD}">
								<input type="text" id="kzrrq" name="kzrrq" value="${empty formDataMap['kzrrq']?pdfn:getCurrDate():formDataMap['kzrrq']}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="validate[required] inputText ctrlInput time" style="width: 120px;" readonly="readonly"/>
							</td>
						</c:if>
						<c:if test="${param.roleFlag != GlobalConstant.RES_ROLE_SCOPE_HEAD}">
							<td>${formDataMap['kzrrq']}<input type="hidden" name="kzrrq" value="${formDataMap['kzrrq']}"/></td>
						</c:if>
						
						
					</tr>
				</table>
				<div class="${GlobalConstant.RES_ROLE_SCOPE_MANAGER}">
					<div style="margin-top: 10px;text-align: center;"> 以下由教研室填写<span id="message" style="color: red"></span></div><hr/>
					<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_MANAGER}">
						<input type="hidden" name="ckkhrd" value="${formDataMap['ckkhrd']}"/>
					</c:if>
					<script type="text/javascript">
						function oneSel(box){
							var status = box.checked;
							if(status){
								$(":checkbox[name='"+box.name+"']").attr("checked",false);
								box.checked = status;
							}
						}
					</script>
					<table id="tab3" style="width: 100%;" class="${GlobalConstant.RES_ROLE_SCOPE_MANAGER}">
						<tr>
							<td colspan="2">出科考核认定：</td>
						</tr>
						<tr>
							<td colspan="2" style="padding-left: 10%;">
								<input type="checkbox" name="ckkhrd" class="validate[required] ctrlInput" value="${GlobalConstant.FLAG_Y}" onchange="oneSel(this);" id="ckkhrd_Y" <c:if test="${formDataMap['ckkhrd'] eq GlobalConstant.FLAG_Y}">checked="checked"</c:if>/><label for="ckkhrd_Y">&nbsp;合格</label>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="padding-left: 10%;">
								<input type="hidden" name="reason" value="${formDataMap['reason']}"/>
								<input type="checkbox" name="ckkhrd" class="validate[required] ctrlInput" value="${GlobalConstant.FLAG_N}" onchange="oneSel(this);" id="ckkhrd_N" <c:if test="${formDataMap['ckkhrd'] eq GlobalConstant.FLAG_N}">checked="checked"</c:if>/><label for="ckkhrd_N">&nbsp;不合格</label>
								，原因：
								<input type="checkbox" class="ctrlInput reason" value="A"
									<c:if test="${(fn:indexOf(formDataMap['reason'],'A')>-1)}">checked</c:if>
								/>
								经核实，有严重违纪事件；<br/>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="padding-left: 22%;">
								<input type="checkbox" name="reason" class="ctrlInput reason" value="B"
									<c:if test="${(fn:indexOf(formDataMap['reason'],'B')>-1)}">checked</c:if>
								/>
								累计请假时间超过本学科轮转时间的1/3；
							</td>
						</tr>
						<tr>
							<td colspan="2" style="padding-left: 22%;">
								<input type="checkbox" class="ctrlInput reason" value="C"
									<c:if test="${(fn:indexOf(formDataMap['reason'],'C')>-1)}">checked</c:if>
								/>
								临床综合能力考核低于36分；
							</td>
						</tr>
						<tr>
							<td style="padding-left: 22%;">
								<input type="checkbox" class="ctrlInput reason" value="D"
									<c:if test="${(fn:indexOf(formDataMap['reason'],'D')>-1)}">checked</c:if>
								/>
								其它：
								<c:if test="${param.roleFlag != GlobalConstant.RES_ROLE_SCOPE_MANAGER}">
									${formDataMap['ckkhrd_qt']}<input type="hidden" name="ckkhrd_qt" value="${formDataMap['ckkhrd_qt']}"/>
								</c:if>
								<c:if test="${param.roleFlag == GlobalConstant.RES_ROLE_SCOPE_MANAGER}">
									<input type="text" name="ckkhrd_qt" value="${formDataMap['ckkhrd_qt']}" class="inputText ctrlInput" style="width: 120px;"/>
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: right;">
								教研室：
								<c:if test="${param.roleFlag != GlobalConstant.RES_ROLE_SCOPE_MANAGER}">
									${formDataMap['jys']}<input type="hidden" name="jys" value="${formDataMap['jys']}"/>
								</c:if>
								<c:if test="${param.roleFlag == GlobalConstant.RES_ROLE_SCOPE_MANAGER}">
									<input type="text" name="jys" value="${empty formDataMap['jys']?sessionScope.currUser.deptName:formDataMap['jys']}" class="validate[required] inputText ctrlInput" style="width: 120px;"/>
								</c:if>
								日期：
								<c:if test="${param.roleFlag != GlobalConstant.RES_ROLE_SCOPE_MANAGER}">
									${formDataMap['jysrq']}<input type="hidden" name="jysrq" value="${formDataMap['jysrq']}"/>
								</c:if>
								<c:if test="${param.roleFlag == GlobalConstant.RES_ROLE_SCOPE_MANAGER}">
									<input type="text" name="jysrq" value="${empty formDataMap['jysrq']?pdfn:getCurrDate():formDataMap['jysrq']}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctrlInput time" style="width: 120px;" readonly="readonly"/>
								</c:if>
							</td>
						</tr>
					</table>
				</div>
			</form>
        <div style="text-align: center;margin-top: 5px;">
        	<input type="button" value="打印考核表" class="search"/>
        	<input type="button" id="saveBtn" value="提&#12288;交" class="search saveBtn" onclick="save();" style="display: none;"/>
        	<input type="button" value="关&#12288;闭" class="search" onclick="back();"/>
        </div>
   </div>	
  </div>
</body>
</html>