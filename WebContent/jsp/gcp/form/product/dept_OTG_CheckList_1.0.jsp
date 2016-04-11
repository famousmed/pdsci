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
		disableTag();
	});
</script>
<input type="hidden" name="recTypeId"
	value="${gcpRecTypeEnumDept_OTG_CheckList.id}" />
<input type="hidden" name="formFileName" value="${formFileName}" />

<table class="xllist" width="100%">
	<tr>
		<th>序号</th>
		<th>内容</th>
		<th>检查结果</th>
		<th>备注</th>
	</tr>
	<tbody>
		<tr class="data">
			<td class="textTd">1</td>
			<td class="textTd">伦理会批准与备案</td>
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
			<td class="textTd">2</td>
			<td class="textTd">研究者资质、培训与授权</td>
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
			<td class="textTd">3</td>
			<td class="textTd">受试者权益保护（知情、受试费）</td>
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
			<td class="textTd">4</td>
			<td class="textTd">方案依从性</td>
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
			<td class="textTd">5</td>
			<td class="textTd">受试者姓名、住址、电话真实性核对</td>
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
			<td class="textTd">6</td>
			<td class="textTd">实验方案依从性（入排、随访）</td>
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
			<td class="textTd">7</td>
			<td class="textTd">原始记录（病史、医嘱单、处方单等）</td>
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
			<td class="textTd">8</td>
			<td class="textTd">病例报告表（及时、准确、完整、可溯源）</td>
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
			<td class="textTd">9</td>
			<td class="textTd">试验用药品管理</td>
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
			<td class="textTd">10</td>
			<td class="textTd">样品采集与管理</td>
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
			<td class="textTd">11</td>
			<td class="textTd">合并用药与伴随治疗</td>
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
			<td class="textTd">12</td>
			<td class="textTd">方案偏离与违背</td>
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
			<td class="textTd">13</td>
			<td class="textTd">AE与SAE处理、记录与报告</td>
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
			<td class="textTd">14</td>
			<td class="textTd">随即分组与设盲、破盲</td>
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
			<td class="textTd">15</td>
			<td class="textTd">申办者方式及记录正常</td>
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
			<td class="textTd">16</td>
			<td class="textTd">内部质量控制</td>
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
	</tbody>
	<tr>
		<th colspan="4"><font style="float: left">&#12288;发现的问题</font></th>
	</tr>
	<tr>
		<td colspan="4"><textarea class="xltxtarea validate[required]"
				name="problem" placeholder="请填写发现的问题 (若没有，请填无)">${formDataMap['problem']}</textarea>
		</td>
	</tr>
</table>

