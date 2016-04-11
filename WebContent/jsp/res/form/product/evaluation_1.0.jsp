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
		$(".oneSel").click(function(){
			$(".oneSel[name='"+this.name+"']").attr("checked",false);
			this.checked = true;
			$(this).closest("tr").find(".score").text(this.checked?$(this).val():"");
			countSocre();
		});
		<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR || (param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER && rec.auditStatusId eq recStatusEnumTeacherAuditY.id) || (param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD && rec.headAuditStatusId eq recStatusEnumHeadAuditY.id)}">
			$(".dept").toggle();
		</c:if>
	});
	
	function save(){
		if($("#evaluationForm").validationEngine("validate")){
			jboxConfirm("确认提交?提交后将无法修改!",function(){
				jboxPost("<s:url value='/res/rec/saveRegistryForm'/>",$('#evaluationForm').serialize(),function(){
					back();
					//jboxClose();
				},null,true);
			});
		}
	}
	
	function countSocre(){
		var count = 0;
		$(".oneSel:checked").each(function(){
			if(!isNaN(this.value)){
				count+=parseFloat(this.value);
			}
		});
		
		var theory = $("[name='theory']").val();
		if(!isNaN(theory) && $.trim(theory)!=""){
			count+=parseFloat(theory);
		}
		
		var real = $("[name='real']").val();
		if(!isNaN(real) && $.trim(real)!=""){
			count+=parseFloat(real);
		}
		
		$("[name='totalScore']").val(count.toFixed(1));
		$("#totalScore").text(count.toFixed(1));
	}
	
	function back(){
		if ("${param.openType}"=="open") {
			jboxClose();
		} if ("${param.openType}"=="messager") {
			top.jboxCloseMessager();
		} else {
			$("#detail").rightSlideClose();
		}
	}
</script>
</head>
<body>	
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
		 <div align="left">
		 	姓名：${rec.operUserName}
		 	&#12288;
		 	科室：${rec.schDeptName}
		 	&#12288;
		 	轮转时间：${0}个月
		 	&#12288;
		 	 分管床位数：${0}
		 </div>
		</div> 
		<div>
			<form id="evaluationForm">
			<input type="hidden" name="formFileName" value="${formFileName}"/>
			<input type="hidden" name="schDeptFlow" value="${param.schDeptFlow}"/>
			<input type="hidden" name="recFlow" value="${rec.recFlow}"/>
			<input type="hidden" name="roleFlag" value="${param.roleFlag}"/>
			<input type="hidden" name="processFlow" value="${currRegProcess.processFlow}"/>
			<table class="xllist">
				<tr style="display: none;"><td colspan="8"></td></tr>
				<tr>
					<th colspan="8">
						临床医学研究生培训出科考核评分表
					</th>
				</tr>
				<tr>
					<td width="60px"></td>
					<td width="100px"></td>
					<td>项目</td>
					<td class="dept" colspan="3"  width="150px">评分标准</td>
					<td width="30px">得分</td>
					<td colspan="4">备注</td>
				</tr>
				<tr>
					<td rowspan="20">
						一<br>、<br>日<br>常<br>临<br>床<br>能<br>力<br>考<br>核<br>(50%)
					</td>
					<td rowspan="4">医德医风</td>
					<td style="text-align: left;padding-left: 10px;">廉洁行医</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="ljxy" value="0" ${formDataMap['ljxy'] eq '0'?'checked':''} class="oneSel">&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="ljxy" value="1" ${formDataMap['ljxy'] eq '1'?'checked':''} class="oneSel" >&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="ljxy" value="2" ${formDataMap['ljxy'] eq '2'?'checked':''} class="oneSel" >&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['ljxy']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4">无投诉</td>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 10px;">工作态度及责任心</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="gztdjzrx" value="0" ${formDataMap['gztdjzrx'] eq '0'?'checked':''}>&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="gztdjzrx" value="1" ${formDataMap['gztdjzrx'] eq '1'?'checked':''}>&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="gztdjzrx" value="2" ${formDataMap['gztdjzrx'] eq '2'?'checked':''}>&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['gztdjzrx']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4">无投诉</td>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 10px;">
						医疗差错，事故
						<br>
						备注
						<label><input type="radio" value="${GlobalConstant.FLAG_N}" ${formDataMap['fault'] eq GlobalConstant.FLAG_N?'checked':''} name="fault" disabled>&nbsp;无</label>
						<label><input type="radio" value="${GlobalConstant.FLAG_Y}" ${formDataMap['fault'] eq GlobalConstant.FLAG_Y?'checked':''} name="fault" disabled>&nbsp;有</label>
					</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="ylccsg" value="0" ${formDataMap['ylccsg'] eq '0'?'checked':''}>&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="ylccsg" value="1" ${formDataMap['ylccsg'] eq '1'?'checked':''}>&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="ylccsg" value="2" ${formDataMap['ylccsg'] eq '2'?'checked':''}>&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['ylccsg']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4">大于等于1次为不合格</td>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 10px;">医患沟通能力</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="yhgtnl" value="0" ${formDataMap['yhgtnl'] eq '0'?'checked':''}>&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="yhgtnl" value="1" ${formDataMap['yhgtnl'] eq '1'?'checked':''}>&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="yhgtnl" value="2" ${formDataMap['yhgtnl'] eq '2'?'checked':''}>&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['yhgtnl']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4">无投诉</td>
				</tr>
				<tr>
					<td>实践时间</td>
					<td style="text-align: left;padding-left: 10px;">病假 0天 事假 0天</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="bjsj" value="0" ${formDataMap['bjsj'] eq '0'?'checked':''}>&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="bjsj" value="1" ${formDataMap['bjsj'] eq '1'?'checked':''}>&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="bjsj" value="2" ${formDataMap['bjsj'] eq '2'?'checked':''}>&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['bjsj']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4">
						在轮转科室病事假平均小于等于 2天/月
					</td>
				</tr>
				<tr>
					<td rowspan="5">临床实践指标完成情况</td>
					<td style="text-align: left;padding-left: 10px;">病史质量无丙级病历</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="bszlwbjbl" value="0" ${formDataMap['bszlwbjbl'] eq '0'?'checked':''}>&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="bszlwbjbl" value="1" ${formDataMap['bszlwbjbl'] eq '1'?'checked':''}>&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="bszlwbjbl" value="2" ${formDataMap['bszlwbjbl'] eq '2'?'checked':''}>&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['bszlwbjbl']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4">
						完成数量100%；有丙级病历则不能通过
					</td>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 10px;">带教质量</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="djzl" value="0" ${formDataMap['djzl'] eq '0'?'checked':''}>&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="djzl" value="1" ${formDataMap['djzl'] eq '1'?'checked':''}>&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="djzl" value="2" ${formDataMap['djzl'] eq '2'?'checked':''}>&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['djzl']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4">
						带教实习生，无下级医生投诉
					</td>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 10px;">
						<c:set value="${resRecTypeEnumDiseaseRegistry.id}req" var="dKey"/>
						管理病种数应完成
						<font color="red">${recFinishMap[dKey]+0}</font>
						例 已完成 
						<font color="red">${recFinishMap[resRecTypeEnumDiseaseRegistry.id]+0}</font>
						例 完成比例 
						<font color="red">${pdfn:transPercent(recFinishMap[resRecTypeEnumDiseaseRegistry.id],recFinishMap[dKey],2)}</font>
					</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="glbzsywcbl" value="0" ${formDataMap['glbzsywcbl'] eq '0'?'checked':''}>&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="glbzsywcbl" value="1" ${formDataMap['glbzsywcbl'] eq '1'?'checked':''}>&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="glbzsywcbl" value="2" ${formDataMap['glbzsywcbl'] eq '2'?'checked':''}>&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['glbzsywcbl']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4">
						管理病种数应完成大于等于80%，否则不能通过
					</td>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 10px;">
						<c:set value="${resRecTypeEnumCaseRegistry.id}req" var="cKey"/>
						管理病例数应完成
						<font color="red">${recFinishMap[cKey]+0}</font>
						例 已完成
						<font color="red">${recFinishMap[resRecTypeEnumCaseRegistry.id]+0}</font>
						 例 完成比例
						<font color="red">${pdfn:transPercent(recFinishMap[resRecTypeEnumCaseRegistry.id],recFinishMap[cKey],2)}</font>
					</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="glblsywcbl" value="0" ${formDataMap['glblsywcbl'] eq '0'?'checked':''}>&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="glblsywcbl" value="1" ${formDataMap['glblsywcbl'] eq '1'?'checked':''}>&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="glblsywcbl" value="2" ${formDataMap['glblsywcbl'] eq '2'?'checked':''}>&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['glblsywcbl']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4">
						管理病例数应完成大于等于80%，否则不能通过
					</td>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 10px;">
						<c:set value="${resRecTypeEnumOperationRegistry.id}req" var="oKey"/>
						<c:set value="${resRecTypeEnumSkillRegistry.id}req" var="sKey"/>
						操作/手术 应完成
						<font color="red">${recFinishMap[oKey]+0}</font>
						例 已完成 
						<font color="red">${recFinishMap[resRecTypeEnumOperationRegistry.id]+0}</font>
						例 完成比例 
						<font color="red">${pdfn:transPercent(recFinishMap[resRecTypeEnumOperationRegistry.id],recFinishMap[oKey],2)}</font>
						/
						应完成
						<font color="red">${recFinishMap[sKey]+0}</font>
						例 已完成 
						<font color="red">${recFinishMap[resRecTypeEnumSkillRegistry.id]+0}</font>
						例 完成比例 
						<font color="red">${pdfn:transPercent(recFinishMap[resRecTypeEnumSkillRegistry.id],recFinishMap[sKey],2)}</font>
					</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="czhssywcbl" value="0" ${formDataMap['czhssywcbl'] eq '0'?'checked':''}>&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="czhssywcbl" value="1" ${formDataMap['czhssywcbl'] eq '1'?'checked':''}>&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="czhssywcbl" value="2" ${formDataMap['czhssywcbl'] eq '2'?'checked':''}>&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['czhssywcbl']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4">
						操作（手术）规范并能完成大于等于80%，否则不能通过
					</td>
				</tr>
				<tr>
					<td rowspan="3">“三基”掌握情况</td>
					<td style="text-align: left;padding-left: 10px;">基本理论</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="jbll" value="0" ${formDataMap['jbll'] eq '0'?'checked':''}>&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="jbll" value="1" ${formDataMap['jbll'] eq '1'?'checked':''}>&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="jbll" value="2" ${formDataMap['jbll'] eq '2'?'checked':''}>&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['jbll']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4"></td>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 10px;">基本技能</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="jbjn" value="0" ${formDataMap['jbjn'] eq '0'?'checked':''}>&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="jbjn" value="1" ${formDataMap['jbjn'] eq '1'?'checked':''}>&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="jbjn" value="2" ${formDataMap['jbjn'] eq '2'?'checked':''}>&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['jbjn']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4"></td>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 10px;">基本操作</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="jbcz" value="0" ${formDataMap['jbcz'] eq '0'?'checked':''}>&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="jbcz" value="1" ${formDataMap['jbcz'] eq '1'?'checked':''}>&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="jbcz" value="2" ${formDataMap['jbcz'] eq '2'?'checked':''}>&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['jbcz']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4"></td>
				</tr>
				<tr>
					<td rowspan="6">临床综合能力</td>
					<td style="text-align: left;padding-left: 10px;">体格检查</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="tgjc" value="0" ${formDataMap['tgjc'] eq '0'?'checked':''}>&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="tgjc" value="1" ${formDataMap['tgjc'] eq '1'?'checked':''}>&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="tgjc" value="2" ${formDataMap['tgjc'] eq '2'?'checked':''}>&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['tgjc']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4">
						体检手法规范，按顺序进行，重要体征无遗漏（有一项不符合，则扣1分）
					</td>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 10px;">专业理论</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="zyll" value="0" ${formDataMap['zyll'] eq '0'?'checked':''}>&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="zyll" value="1" ${formDataMap['zyll'] eq '1'?'checked':''}>&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="zyll" value="2" ${formDataMap['zyll'] eq '2'?'checked':''}>&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['zyll']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4">
						临床基础理论、专业知识、科学发展动向的了解与掌握 注明：平时
					</td>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 10px;">处理常见病人的能力</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="clcjbrdnl" value="0" ${formDataMap['clcjbrdnl'] eq '0'?'checked':''}>&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="clcjbrdnl" value="1" ${formDataMap['clcjbrdnl'] eq '1'?'checked':''}>&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="clcjbrdnl" value="2" ${formDataMap['clcjbrdnl'] eq '2'?'checked':''}>&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['clcjbrdnl']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4">
						临床资料的分析，反应能力，表达能力（有一项不符合，则扣1分）
					</td>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 10px;">处理危重疑难病人的能力</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="clwzynbrdnl" value="0" ${formDataMap['clwzynbrdnl'] eq '0'?'checked':''}>&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="clwzynbrdnl" value="1" ${formDataMap['clwzynbrdnl'] eq '1'?'checked':''}>&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="clwzynbrdnl" value="2" ${formDataMap['clwzynbrdnl'] eq '2'?'checked':''}>&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['clwzynbrdnl']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4">
						综合能力，反应能力，表达能力（有一项不符合，则扣1分）
					</td>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 10px;">实验检查</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="syjc" value="0" ${formDataMap['syjc'] eq '0'?'checked':''}>&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="syjc" value="1" ${formDataMap['syjc'] eq '1'?'checked':''}>&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="syjc" value="2" ${formDataMap['syjc'] eq '2'?'checked':''}>&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['syjc']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4">
						实验室及辅助检查的选择合理，结果分析，判断正确（有一项不符合，则扣1分）
					</td>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 10px;">临床思维和表达能力</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="lcswhbdbl" value="0" ${formDataMap['lcswhbdbl'] eq '0'?'checked':''}>&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="lcswhbdbl" value="1" ${formDataMap['lcswhbdbl'] eq '1'?'checked':''}>&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="lcswhbdbl" value="2" ${formDataMap['lcswhbdbl'] eq '2'?'checked':''}>&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['lcswhbdbl']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4">
						临床资料的分析与综合能力，反应能力及表达能力（有一项不符合， 则扣1分）
					</td>
				</tr>
				<tr>
					<td>业务学习</td>
					<td style="text-align: left;padding-left: 10px;">学术会议、学术讲座、病例讨论等共计：8 次</td>
					<td class="dept">
						<label title="0分"><input type="checkbox" class="oneSel" name="xshyxsjzbltl" value="0" ${formDataMap['xshyxsjzbltl'] eq '0'?'checked':''}>&nbsp;0</label>
					</td>
					<td class="dept">
						<label title="1分"><input type="checkbox" class="oneSel" name="xshyxsjzbltl" value="1" ${formDataMap['xshyxsjzbltl'] eq '1'?'checked':''}>&nbsp;1</label>
					</td>
					<td class="dept">
						<label title="2分"><input type="checkbox" class="oneSel" name="xshyxsjzbltl" value="2" ${formDataMap['xshyxsjzbltl'] eq '2'?'checked':''}>&nbsp;2</label>
					</td>
					<td><label class="score">${formDataMap['xshyxsjzbltl']}</label></td>
					<td style="text-align: left;padding-left: 10px;" colspan="4">
						依据研究生培训手册情况记录（大于等与4次/月，为合格），不合格则不能通过
					</td>
				</tr>
				<tr>
					<td rowspan="2">二<br>、<br>出<br>科<br>考<br>核<br>(50%)</td>
					<td colspan="2">理论考试（10分）<br><font class="dept" style="display:none;">（根据实际分数折算）</font></td>
					<td class="dept" colspan="3">根据实际分数折算</td>
					<td>
						<input type="text" style="width: 30px;" name="theory" value="${formDataMap['theory']}" class="dept validate[custom[number],max[10]]" onkeyup="countSocre();"/>
						<label class="dept" style="display: none;">${formDataMap['theory']}</label>
					</td>
					<td colspan="4"></td>
				</tr>
				<tr>
					<td colspan="2">技能考核（40分）<br><font class="dept" style="display:none;">（根据实际分数折算）</font></td>
					<td class="dept" colspan="3">根据实际分数折算</td>
					<td>
						<input type="text" style="width: 30px;" name="real" value="${formDataMap['real']}" class="dept validate[custom[number],max[40]]" onkeyup="countSocre();"/>
						<label class="dept" style="display: none;">${formDataMap['real']}</label>
					</td>
					<td style="text-align: left;padding-left: 10px;" colspan="2">
						病史采集、体格检查、辅助检查、临床操作、诊断、鉴别诊断、治疗原则等方面评估
					</td>
				</tr>
				<tr>
					<td>综合成绩</td>
					<td colspan="${(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR) || (param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER && rec.auditStatusId eq recStatusEnumTeacherAuditY.id) || (param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD && rec.headAuditStatusId eq recStatusEnumHeadAuditY.id)?2:5}">满分100</td>
					<td>
						<label id="totalScore">${formDataMap['totalScore']}</label>
					</td>
					<td></td>
				</tr>
			</table>
			<div align="left" style="margin-top: 10px;">
				<div class="dept">
					<p>注：（1）请在您认为合适的分数项打“√”</p>
					<p style="padding-left: 25px;">（2）带教质量：根据实习生和研究生反映住院医师带教情况给予评分。</p>
					<p style="padding-left: 25px;">（3）业务学习是指科室组织的各种形式的业务学习。</p>
				</div>
				<p style="padding-left: 25px;">
					科主任（签名）： 
					<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}">
						<label>${empty formDataMap['headName']?sessionScope.currUser.userName:formDataMap['headName']}</label>
					</c:if>
					<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD)}">
						<label>${formDataMap['headName']}</label>
					</c:if>
					<input type="hidden" name="headName" value="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD?sessionScope.currUser.userName:formDataMap['headName']}">
					<br>时间：
					<input class="dept inputText" type="text" name="nameTime" value="${empty formDataMap['nameTime']?pdfn:getCurrDate():formDataMap['nameTime']}" readonly="readonly" 
					<c:if test="${empty formDataMap['nameTime']}">
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"
					</c:if>
					>
					<b class="dept" style="display: none;">${formDataMap['nameTime']}</b>
				</p>
			</div>
			<input type="hidden" name="totalScore" value="${formDataMap['totalScore']}"/>
			<input type="hidden" name="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD?'headAuditStatusId':'auditStatusId'}" value="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD?recStatusEnumHeadAuditY.id:recStatusEnumTeacherAuditY.id}"/>
			</form>
		</div>
        <div style="text-align: center;margin-top: 5px;">
        	<input type="button" value="打印考核表" class="search docBtn" onclick="$('.docBtn').hide();window.print();$('.docBtn').show();"/>
        	<input type="button" value="提&#12288;交" class="search dept" onclick="save();"/>
        	<input type="button" value="关&#12288;闭" class="search docBtn" onclick="back();"/>
        </div>
   </div>	
  </div>
</body>
</html>