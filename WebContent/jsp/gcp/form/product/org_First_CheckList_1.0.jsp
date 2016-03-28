<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<script type="text/javascript">
	$(function() {
		$(".textTd").css({
			"text-align" : "left",
			"padding-left" : "5px"
		});
		$(".textTdCenter").css({
			"text-align" : "center",
		});
		$(":checkbox").bind("click", function() {
			singleSel(this);
		});
		$("#qcStartDate").text(qcStartDate);
		$("#qcEndDate").text(qcEndDate);
		disableTag();
	});
</script>
<input type="hidden" name="recTypeId"
	value="${gcpRecTypeEnumOrg_First_CheckList.id}" />
<input type="hidden" name="formFileName" value="${formFileName}" />
<table class="basic" width="100%" style="margin-bottom: 10px">
	<tr>
		<th colspan="16" style="text-align: left">&#12288;项目信息</th>
	</tr>
	<tr>
		<td width="12%" colspan="2" style="text-align: right">项目名称：</td>
		<td colspan="10">${projInfoForm.proj.projName}</td>
		<td width="12%" colspan="2" style="text-align: right">期类别：</td>
		<td colspan="2">${projInfoForm.proj.projSubTypeName}</td>
	</tr>
	<tr>
		<td width="12%" colspan="2" style="text-align: right">项目来源/CRO：</td>
		<td colspan="14">${projInfoForm.proj.projDeclarer}${!empty
			projInfoForm.CROName?"/":""}${projInfoForm.CROName}</td>
	</tr>
	<tr>
		<td width="12%" colspan="2" style="text-align: right">项目编号：</td>
		<td width="13%" colspan="2">${projInfoForm.proj.projNo}</td>
		<td width="12%" colspan="2" style="text-align: right">项目类别：</td>
		<td width="13%" colspan="2">${projInfoForm.proj.projTypeName}</td>
		<td width="12%" colspan="2" style="text-align: right">CFDA批件号：</td>
		<td width="13%" colspan="2">${projInfoForm.proj.cfdaNo}</td>
		<td width="12%" colspan="2" style="text-align: right">研究者：</td>
		<td width="13%" colspan="2">${projInfoForm.proj.applyUserName}</td>
	</tr>
	<tr>
		<td width="12%" colspan="2" style="text-align: right">启动会日期：</td>
		<td width="13%" colspan="2">${meetingForm.date}</td>
		<td width="12%" colspan="2" style="text-align: right">第一例入组日期：</td>
		<td width="13%" colspan="2">${pdfn:transDate(firstInDate)}</td>
		<td width="12%" colspan="2" style="text-align: right">检查开始日期：</td>
		<td width="13%" colspan="2" id="qcStartDate"></td>
		<td width="12%" colspan="2" style="text-align: right">检查结束日期：</td>
		<td width="13%" colspan="2" id="qcEndDate"></td>
	</tr>
	<tr>
		<td width="8%" style="text-align: right">计划数：</td>
		<td width="4.5%" style="text-align: center">${planSum}</td>
		<td width="8%" style="text-align: right">知情数：</td>
		<td width="4.5%" style="text-align: center">${icfCount}</td>
		<td width="8%" style="text-align: right">筛查数：</td>
		<td width="4.5%" style="text-align: center">${filterCount}</td>
		<td width="8%" style="text-align: right">入组数：</td>
		<td width="4.5%" style="text-align: center">${in}</td>
		<td width="8%" style="text-align: right">进行中：</td>
		<td width="4.5%" style="text-align: center">${inStage}</td>
		<td width="8%" style="text-align: right">完成数：</td>
		<td width="4.5%" style="text-align: center">${finish}</td>
		<td width="8%" style="text-align: right">脱落数：</td>
		<td width="4.5%" style="text-align: center">${off}</td>
		<td width="8%" style="text-align: right">有无SAE：</td>
		<td width="4.5%" style="text-align: center">${isSae?"有":"无"}</td>
	</tr>
</table>

<table class="xllist" width="100%">
	<tr>
		<th colspan="4" style="text-align: left">&#12288;●&nbsp;第一例入组</th>
	</tr>
	<tr>
		<th>内容</th>
		<th>问题</th>
		<th>检查结果</th>
		<th>备注</th>
	</tr>
	<tbody>
		<tr class="data">
			<td class="textTd">研究者文件夹</td>
			<td class="textTd">
				<p>●&nbsp;未专业组保存</p>
				<p>●&nbsp;文件不全，无法按照方案及设计执行</p>
				<p>●&nbsp;不是伦理批准的最新版</p>
			</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1" ${formDataMap['result1'] eq "1"?"checked='true'":""}
					value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1"
					${formDataMap['result1'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1"
					${formDataMap['result1'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1">${formDataMap['remark1']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">伦理批件</td>
			<td class="textTd">
				<p>●&nbsp;批件内容不全</p>
				<p>●&nbsp;批件内容有误</p>
				<p>●&nbsp;批件批准内容与实际文件不符</p>
			</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2" ${formDataMap['result2'] eq "1"?"checked='true'":""}
					value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2"
					${formDataMap['result2'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2"
					${formDataMap['result2'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2">${formDataMap['remark2']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">启动会资料</td>
			<td class="textTd">
				<p>●&nbsp;启动会相关部件均参加试验</p>
				<p>●&nbsp;签到表、PPT、会议记录/培训记录齐全</p>
				<p>●&nbsp;启动会在协议签署后</p>
			</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result3" ${formDataMap['result3'] eq "1"?"checked='true'":""}
					value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result3"
					${formDataMap['result3'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result3"
					${formDataMap['result3'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark3">${formDataMap['remark3']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">分工授权表</td>
			<td class="textTd">
				<p>●&nbsp;所有授权者均收集了研究者简历</p>
				<p>●&nbsp;所有授权者均经过试验启动培训</p>
				<p>●&nbsp;新增研究者有授权及培训</p>
			</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result4" ${formDataMap['result4'] eq "1"?"checked='true'":""}
					value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result4"
					${formDataMap['result4'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result4"
					${formDataMap['result4'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark4">${formDataMap['remark4']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">知情同意及签署</td>
			<td class="textTd">
				<p>●&nbsp;未签署知情同意</p>
				<p>●&nbsp;未交予受试者知情同意书</p>
				<p>●&nbsp;签字无法辨认</p>
				<p>●&nbsp;日期不全</p>
				<p>●&nbsp;法定监护人代签，但未标识清楚与受试者关系</p>
				<p>●&nbsp;受试者本人不签字，但受试者姓名和签名都有人签字</p>
				<p>●&nbsp;受试者应本人签字，但只有监护人签名</p>
			</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result5" ${formDataMap['result5'] eq "1"?"checked='true'":""}
					value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result5"
					${formDataMap['result5'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result5"
					${formDataMap['result5'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark5">${formDataMap['remark5']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">入排标准符合方案</td>
			<td class="textTd">
				<p>●&nbsp;不符合入选标准</p>
				<p>●&nbsp;符合排除标准</p>
				<p>●&nbsp;不符合方案要求</p>
				<p>●&nbsp;非本试验要求的适应症用药</p>
			</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result6" ${formDataMap['result6'] eq "1"?"checked='true'":""}
					value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result6"
					${formDataMap['result6'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result6"
					${formDataMap['result6'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark6">${formDataMap['remark6']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">实验室检查</td>
			<td class="textTd">
				<p>●&nbsp;未完成试验要求的全部检查</p>
				<p>●&nbsp;实验室检查超出入选标准</p>
				<p>●&nbsp;实验室检查结果在入选后</p>
				<p>●&nbsp;实验室检查时间超出了试验规定，不被接受</p>
			</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result7" ${formDataMap['result7'] eq "1"?"checked='true'":""}
					value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result7"
					${formDataMap['result7'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result7"
					${formDataMap['result7'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark7">${formDataMap['remark7']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">原始医疗文件</td>
			<td class="textTd">
				<p>●&nbsp;住院病例或门诊病例中有知情同意的记录</p>
				<p>●&nbsp;病例中参加试验及药物编号、随机号等记录</p>
				<p>●&nbsp;有记录用药的反应等</p>
				<p>●&nbsp;检查单、报告单完整</p>
			</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result8" ${formDataMap['result8'] eq "1"?"checked='true'":""}
					value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result8"
					${formDataMap['result8'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result8"
					${formDataMap['result8'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark8">${formDataMap['remark8']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">受试者签认代码表</td>
			<td class="textTd">
				<p>●&nbsp;未填写</p>
				<p>●&nbsp;为收集受试者基本信息</p>
				<p>●&nbsp;缺联系方式</p>
				<p>●&nbsp;缺受试者信息</p>
				<p>●&nbsp;无受试者本人签字</p>
			</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result9" ${formDataMap['result9'] eq "1"?"checked='true'":""}
					value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result9"
					${formDataMap['result9'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result9"
					${formDataMap['result9'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark9">${formDataMap['remark9']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">受试者筛选入选表</td>
			<td class="textTd">
				<p>●&nbsp;未及时填写</p>
				<p>●&nbsp;筛选编号和入组编号、随机号混乱、理解不清</p>
				<p>●&nbsp;知情日期、筛选日期、入组日期填写错误</p>
				<p>●&nbsp;不是按照筛选日期、筛选编号排列</p>
				<p>●&nbsp;按照入组编号排列</p>
				<p>●&nbsp;多为研究者共同填写，次序混乱</p>
			</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result10"
					${formDataMap['result10'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result10"
					${formDataMap['result10'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result10"
					${formDataMap['result10'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark10">${formDataMap['remark10']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">完成编码目录</td>
			<td class="textTd">
				<p>●&nbsp;未填写</p>
				<p>●&nbsp;未记录是否完成试验</p>
				<p>●&nbsp;未记录完成试验日期</p>
				<p>●&nbsp;未记录退出试验日期</p>
				<p>●&nbsp;未记录退出试验的原因</p>
			</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result11"
					${formDataMap['result11'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result11"
					${formDataMap['result11'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result11"
					${formDataMap['result11'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark11">${formDataMap['remark11']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">相关药品管理表格</td>
			<td class="textTd">
				<p>●&nbsp;温湿度记录表</p>
				<p>●&nbsp;接收登记</p>
				<p>●&nbsp;库存记录表</p>
				<p>●&nbsp;受试者使用发放回收记录表</p>
				<p>●&nbsp;试验用药品回收记录等</p>
				<p>●&nbsp;静脉用药的配药记录和转运记录是否齐全</p>
			</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result12"
					${formDataMap['result12'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result12"
					${formDataMap['result12'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result12"
					${formDataMap['result12'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark12">${formDataMap['remark12']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">试验用药品管理</td>
			<td class="textTd">
				<p>●&nbsp;药品装运、递送、接收、分配记录</p>
				<p>●&nbsp;药品管理数据记录准确性</p>
				<p>●&nbsp;药品交接、分发记录及时性</p>
				<p>●&nbsp;试验药品仅用于受试者</p>
				<p>●&nbsp;处方单/医嘱单完整</p>
			</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result13"
					${formDataMap['result13'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result13"
					${formDataMap['result13'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result13"
					${formDataMap['result13'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark13">${formDataMap['remark13']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">受试者访视费发放表</td>
			<td class="textTd">
				<p>●&nbsp;未发放，表格未填写</p>
				<p>●&nbsp;表格填写不全</p>
				<p>●&nbsp;发放人未记录</p>
				<p>●&nbsp;发放额度、频率与知情、协议不一致</p>
			</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result14"
					${formDataMap['result14'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result14"
					${formDataMap['result14'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result14"
					${formDataMap['result14'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark14">${formDataMap['remark14']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">免费检查单</td>
			<td class="textTd">
				<p>●&nbsp;有免费检查，但未发放免费检查通知</p>
				<p>●&nbsp;未领取申请单</p>
				<p>●&nbsp;申请单使用中信息填写有问题</p>
			</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result15"
					${formDataMap['result15'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result15"
					${formDataMap['result15'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result15"
					${formDataMap['result15'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark15">${formDataMap['remark15']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">AE与SAE</td>
			<td class="textTd">
				<p>●&nbsp;
				<label><input type="checkbox" name="isSae" ${formDataMap['isSae'] eq "2"?"checked='true'":""} value="2" />无发生</label>，
				<label><input type="checkbox" name="isSae" ${formDataMap['isSae'] eq "1"?"checked='true'":""} value="1" />有发生</label></p>
				<p>●&nbsp;是否及时上报</p>
				<p>●&nbsp;对AE的记录、跟踪随访是否详细及时</p>
			</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result16"
					${formDataMap['result16'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result16"
					${formDataMap['result16'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result16"
					${formDataMap['result16'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark16">${formDataMap['remark16']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">CRF填写</td>
			<td class="textTd">
				<p>●&nbsp;及时填写，与试验进度相符</p>
				<p>●&nbsp;完整填写，符合填写要求</p>
				<p>●&nbsp;准确填写，与原始资料一致</p>
				<p>●&nbsp;规范填写，修改符合要求，字迹清晰可辨</p>
				<p>●&nbsp;可溯源，数据真实</p>
			</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result17"
					${formDataMap['result17'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result17"
					${formDataMap['result17'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result17"
					${formDataMap['result17'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark17">${formDataMap['remark17']}</textarea>
			</td>
		<tr>
	</tbody>
	<tr>
		<th colspan="4"><font style="float: left">&#12288;其他</font></th>
	</tr>
	<tr>
		<td colspan="4"><textarea class="xltxtarea" name="other">${formDataMap['other']}</textarea>
		</td>
	</tr>
	<tr>
		<th colspan="4"><font style="float: left">&#12288;发现的问题</font></th>
	</tr>
	<tr>
		<td colspan="4"><textarea class="xltxtarea validate[required]"
				name="problem" placeholder="请填写发现的问题 (若没有，请填无)">${formDataMap['problem']}</textarea>
		</td>
	</tr>
</table>

