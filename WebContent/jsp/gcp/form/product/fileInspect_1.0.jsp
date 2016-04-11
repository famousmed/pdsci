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
	value="${gcpRecTypeEnumFileInspect.id}" />
<input type="hidden" name="formFileName" value="${formFileName}" />
<table class="xllist" width="100%">
	<tr>
		<th width="5%">序号</th>
		<th width="35%">文件名</th>
		<th width="15%">文件形式</th>
		<th width="15%">检查结果</th>
		<th width="30%">备注</th>
	</tr>
	<tbody id="fileInspectList">
		<tr>
			<th class="textTd">1</th>
			<th class="textTd" colspan="4">临床准备阶段</th>
		</tr>
		<tr class="data">
			<td class="textTd">1.1</td>
			<td class="textTd">研究者手册</td>
			<td class="textTdCenter"><select name="fileType1.1"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType1.1'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType1.1'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType1.1'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType1.1'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.1"
					${formDataMap['result1.1'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.1"
					${formDataMap['result1.1'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.1"
					${formDataMap['result1.1'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.1">${formDataMap['remark1.1']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.2</td>
			<td class="textTd">实验方案及其修正案</td>
			<td class="textTdCenter"><select name="fileType1.2"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType1.2'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType1.2'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType1.2'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType1.2'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.2"
					${formDataMap['result1.2'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.2"
					${formDataMap['result1.2'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.2"
					${formDataMap['result1.2'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.2">${formDataMap['remark1.2']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.3</td>
			<td class="textTd">病例报告(样表)</td>
			<td class="textTdCenter"><select name="fileType1.3"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType1.3'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType1.3'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType1.3'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType1.3'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.3"
					${formDataMap['result1.3'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.3"
					${formDataMap['result1.3'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.3"
					${formDataMap['result1.3'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.3">${formDataMap['remark1.3']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.4</td>
			<td class="textTd">知情同意书</td>
			<td class="textTdCenter"><select name="fileType1.4"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType1.4'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType1.4'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType1.4'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType1.4'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.4"
					${formDataMap['result1.4'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.4"
					${formDataMap['result1.4'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.4"
					${formDataMap['result1.4'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.4">${formDataMap['remark1.4']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.5</td>
			<td class="textTd">受试者招募广告及其他提供给受试者的书面文件</td>
			<td class="textTdCenter"><select name="fileType1.5"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType1.5'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType1.5'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType1.5'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType1.5'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.5"
					${formDataMap['result1.5'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.5"
					${formDataMap['result1.5'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.5"
					${formDataMap['result1.5'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.5">${formDataMap['remark1.5']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.6</td>
			<td class="textTd">财务规定</td>
			<td class="textTdCenter"><select name="fileType1.6"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType1.6'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType1.6'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType1.6'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType1.6'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.6"
					${formDataMap['result1.6'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.6"
					${formDataMap['result1.6'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.6"
					${formDataMap['result1.6'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.6">${formDataMap['remark1.6']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.7</td>
			<td class="textTd">保险和赔偿措施或相关文件</td>
			<td class="textTdCenter"><select name="fileType1.7"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType1.7'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType1.7'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType1.7'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType1.7'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.7"
					${formDataMap['result1.7'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.7"
					${formDataMap['result1.7'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.7"
					${formDataMap['result1.7'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.7">${formDataMap['remark1.7']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.8</td>
			<td class="textTd">多方协议(已签名)(研究者、申办者、合同研究组织)</td>
			<td class="textTdCenter"><select name="fileType1.8"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType1.8'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType1.8'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType1.8'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType1.8'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.8"
					${formDataMap['result1.8'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.8"
					${formDataMap['result1.8'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.8"
					${formDataMap['result1.8'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.8">${formDataMap['remark1.8']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.9</td>
			<td class="textTd">伦理委员会批件</td>
			<td class="textTdCenter"><select name="fileType1.9"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType1.9'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType1.9'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType1.9'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType1.9'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.9"
					${formDataMap['result1.9'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.9"
					${formDataMap['result1.9'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.9"
					${formDataMap['result1.9'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.9">${formDataMap['remark1.9']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.10</td>
			<td class="textTd">伦理委员会成员表</td>
			<td class="textTdCenter"><select name="fileType1.10"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType1.10'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType1.10'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType1.10'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType1.10'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.10"
					${formDataMap['result1.10'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.10"
					${formDataMap['result1.10'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.10"
					${formDataMap['result1.10'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.10">${formDataMap['remark1.10']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.11</td>
			<td class="textTd">国家食品药品监督管理局批件</td>
			<td class="textTdCenter"><select name="fileType1.11"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType1.11'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType1.11'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType1.11'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType1.11'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.11"
					${formDataMap['result1.11'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.11"
					${formDataMap['result1.11'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.11"
					${formDataMap['result1.11'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.11">${formDataMap['remark1.11']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.12</td>
			<td class="textTd">研究者履历及相关文件</td>
			<td class="textTdCenter"><select name="fileType1.12"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType1.12'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType1.12'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType1.12'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType1.12'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.12"
					${formDataMap['result1.12'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.12"
					${formDataMap['result1.12'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.12"
					${formDataMap['result1.12'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.12">${formDataMap['remark1.12']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.13</td>
			<td class="textTd">临床试验有关的实验室检测正常值范围</td>
			<td class="textTdCenter"><select name="fileType1.13"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType1.13'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType1.13'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType1.13'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType1.13'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.13"
					${formDataMap['result1.13'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.13"
					${formDataMap['result1.13'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.13"
					${formDataMap['result1.13'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.13">${formDataMap['remark1.13']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.14</td>
			<td class="textTd">医学或实验室操作的质控证明</td>
			<td class="textTdCenter"><select name="fileType1.14"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType1.14'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType1.14'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType1.14'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType1.14'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.14"
					${formDataMap['result1.14'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.14"
					${formDataMap['result1.14'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.14"
					${formDataMap['result1.14'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.14">${formDataMap['remark1.14']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.15</td>
			<td class="textTd">试验用药品与试验相关物资的运货单</td>
			<td class="textTdCenter"><select name="fileType1.15"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType1.15'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType1.15'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType1.15'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType1.15'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.15"
					${formDataMap['result1.15'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.15"
					${formDataMap['result1.15'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.15"
					${formDataMap['result1.15'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.15">${formDataMap['remark1.15']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.16</td>
			<td class="textTd">试验药物的药检证明</td>
			<td class="textTdCenter"><select name="fileType1.16"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType1.16'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType1.16'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType1.16'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType1.16'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.16"
					${formDataMap['result1.16'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.16"
					${formDataMap['result1.16'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.16"
					${formDataMap['result1.16'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.16">${formDataMap['remark1.16']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.17</td>
			<td class="textTd">设盲试验的破盲规程</td>
			<td class="textTdCenter"><select name="fileType1.17"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType1.17'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType1.17'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType1.17'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType1.17'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.17"
					${formDataMap['result1.17'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.17"
					${formDataMap['result1.17'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.17"
					${formDataMap['result1.17'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.17">${formDataMap['remark1.17']}</textarea>
			</td>
		<tr>
		<tr>
			<th class="textTd">2</th>
			<th class="textTd" colspan="4">临床试验进行阶段</th>
		</tr>
		<tr class="data">
			<td class="textTd">2.1</td>
			<td class="textTd">研究者手册更新件</td>
			<td class="textTdCenter"><select name="fileType2.1"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.1'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.1'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.1'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.1'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.1"
					${formDataMap['result2.1'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.1"
					${formDataMap['result2.1'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.1"
					${formDataMap['result2.1'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.1">${formDataMap['remark2.1']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.2</td>
			<td class="textTd">其他文件的更新</td>
			<td class="textTdCenter"><select name="fileType2.2"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.2'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.2'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.2'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.2'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.2"
					${formDataMap['result2.2'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.2"
					${formDataMap['result2.2'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.2"
					${formDataMap['result2.2'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.2">${formDataMap['remark2.2']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.3</td>
			<td class="textTd">试验相关文件修订的伦理委员会批件</td>
			<td class="textTdCenter"><select name="fileType2.3"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.3'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.3'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.3'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.3'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.3"
					${formDataMap['result2.3'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.3"
					${formDataMap['result2.3'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.3"
					${formDataMap['result2.3'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.3">${formDataMap['remark2.3']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.4</td>
			<td class="textTd">新研究者的履历</td>
			<td class="textTdCenter"><select name="fileType2.4"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.4'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.4'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.4'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.4'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.4"
					${formDataMap['result2.4'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.4"
					${formDataMap['result2.4'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.4"
					${formDataMap['result2.4'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.4">${formDataMap['remark2.4']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.5</td>
			<td class="textTd">医学、实验室检查的正常值范围更新</td>
			<td class="textTdCenter"><select name="fileType2.5"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.5'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.5'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.5'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.5'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.5"
					${formDataMap['result2.5'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.5"
					${formDataMap['result2.5'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.5"
					${formDataMap['result2.5'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.5">${formDataMap['remark2.5']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.6</td>
			<td class="textTd">医学或实验室操作的质控证明的更新</td>
			<td class="textTdCenter"><select name="fileType2.6"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.6'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.6'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.6'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.6'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.6"
					${formDataMap['result2.6'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.6"
					${formDataMap['result2.6'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.6"
					${formDataMap['result2.6'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.6">${formDataMap['remark2.6']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.7</td>
			<td class="textTd">试验用药品与试验相关物资的运货单或交接记录</td>
			<td class="textTdCenter"><select name="fileType2.7"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.7'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.7'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.7'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.7'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.7"
					${formDataMap['result2.7'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.7"
					${formDataMap['result2.7'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.7"
					${formDataMap['result2.7'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.7">${formDataMap['remark2.7']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.8</td>
			<td class="textTd">新批号试验药物的药检证明</td>
			<td class="textTdCenter"><select name="fileType2.8"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.8'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.8'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.8'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.8'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.8"
					${formDataMap['result2.8'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.8"
					${formDataMap['result2.8'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.8"
					${formDataMap['result2.8'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.8">${formDataMap['remark2.8']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.9</td>
			<td class="textTd">相关通信记录</td>
			<td class="textTdCenter"><select name="fileType2.9"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.9'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.9'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.9'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.9'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.9"
					${formDataMap['result2.9'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.9"
					${formDataMap['result2.9'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.9"
					${formDataMap['result2.9'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.9">${formDataMap['remark2.9']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.10</td>
			<td class="textTd">已签名的知情同意书</td>
			<td class="textTdCenter"><select name="fileType2.10"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.10'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.10'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.10'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.10'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.10"
					${formDataMap['result2.10'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.10"
					${formDataMap['result2.10'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.10"
					${formDataMap['result2.10'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.10">${formDataMap['remark2.10']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.11</td>
			<td class="textTd">原始医疗文件</td>
			<td class="textTdCenter"><select name="fileType2.11"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.11'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.11'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.11'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.11'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.11"
					${formDataMap['result2.11'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.11"
					${formDataMap['result2.11'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.11"
					${formDataMap['result2.11'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.11">${formDataMap['remark2.11']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.12</td>
			<td class="textTd">病例报告表(已填写,签名,注明日期)</td>
			<td class="textTdCenter"><select name="fileType2.12"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.12'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.12'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.12'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.12'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.12"
					${formDataMap['result2.12'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.12"
					${formDataMap['result2.12'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.12"
					${formDataMap['result2.12'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.12">${formDataMap['remark2.12']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.13</td>
			<td class="textTd">病例报告表修改记录</td>
			<td class="textTdCenter"><select name="fileType2.13"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.13'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.13'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.13'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.13'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.13"
					${formDataMap['result2.13'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.13"
					${formDataMap['result2.13'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.13"
					${formDataMap['result2.13'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.13">${formDataMap['remark2.13']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.14</td>
			<td class="textTd">研究者至申办者的严重不良事件报告</td>
			<td class="textTdCenter"><select name="fileType2.14"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.14'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.14'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.14'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.14'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.14"
					${formDataMap['result2.14'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.14"
					${formDataMap['result2.14'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.14"
					${formDataMap['result2.14'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.14">${formDataMap['remark2.14']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.15</td>
			<td class="textTd">研究中止/中断报告或终止报告(如果存在)</td>
			<td class="textTdCenter"><select name="fileType2.15"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.15'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.15'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.15'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.15'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.15"
					${formDataMap['result2.15'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.15"
					${formDataMap['result2.15'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.15"
					${formDataMap['result2.15'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.15">${formDataMap['remark2.15']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.16</td>
			<td class="textTd">申办者和/或研究者致药品监督管理局、伦理委员会的严重不良事件及其他安全信息报告</td>
			<td class="textTdCenter"><select name="fileType2.16"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.16'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.16'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.16'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.16'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.16"
					${formDataMap['result2.16'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.16"
					${formDataMap['result2.16'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.16"
					${formDataMap['result2.16'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.16">${formDataMap['remark2.16']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.17</td>
			<td class="textTd">申办者致研究者的安全信息通告</td>
			<td class="textTdCenter"><select name="fileType2.17"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.17'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.17'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.17'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.17'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.17"
					${formDataMap['result2.17'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.17"
					${formDataMap['result2.17'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.17"
					${formDataMap['result2.17'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.17">${formDataMap['remark2.17']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.18</td>
			<td class="textTd">中期或年度报告</td>
			<td class="textTdCenter"><select name="fileType2.18"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.18'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.18'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.18'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.18'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.18"
					${formDataMap['result2.18'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.18"
					${formDataMap['result2.18'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.18"
					${formDataMap['result2.18'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.18">${formDataMap['remark2.18']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.19</td>
			<td class="textTd">受试者鉴认代码表</td>
			<td class="textTdCenter"><select name="fileType2.19"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.19'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.19'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.19'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.19'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.19"
					${formDataMap['result2.19'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.19"
					${formDataMap['result2.19'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.19"
					${formDataMap['result2.19'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.19">${formDataMap['remark2.19']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.20</td>
			<td class="textTd">受试者筛选表与入选表</td>
			<td class="textTdCenter"><select name="fileType2.20"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.20'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.20'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.20'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.20'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.20"
					${formDataMap['result2.20'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.20"
					${formDataMap['result2.20'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.20"
					${formDataMap['result2.20'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.20">${formDataMap['remark2.20']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.21</td>
			<td class="textTd">试用药品登记表</td>
			<td class="textTdCenter"><select name="fileType2.21"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.21'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.21'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.21'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.21'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.21"
					${formDataMap['result2.21'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.21"
					${formDataMap['result2.21'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.21"
					${formDataMap['result2.21'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.21">${formDataMap['remark2.21']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.22</td>
			<td class="textTd">研究者签名样张</td>
			<td class="textTdCenter"><select name="fileType2.22"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.22'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.22'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.22'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.22'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.22"
					${formDataMap['result2.22'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.22"
					${formDataMap['result2.22'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.22"
					${formDataMap['result2.22'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.22">${formDataMap['remark2.22']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.23</td>
			<td class="textTd">生物样本(体液或组织样本)留存记录</td>
			<td class="textTdCenter"><select name="fileType2.23"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType2.23'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType2.23'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType2.23'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType2.23'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.23"
					${formDataMap['result2.23'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.23"
					${formDataMap['result2.23'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.23"
					${formDataMap['result2.23'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.23">${formDataMap['remark2.23']}</textarea>
			</td>
		<tr>
		<tr>
			<th class="textTd">3</th>
			<th class="textTd" colspan="4">临床试验完成后</th>
		</tr>
		<tr class="data">
			<td class="textTd">3.1</td>
			<td class="textTd">剩余试验药物退回或销毁证明</td>
			<td class="textTdCenter"><select name="fileType3.1"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType3.1'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType3.1'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType3.1'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType3.1'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result3.1"
					${formDataMap['result3.1'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result3.1"
					${formDataMap['result3.1'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result3.1"
					${formDataMap['result3.1'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark3.1">${formDataMap['remark3.1']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">3.2</td>
			<td class="textTd">完成试验受试者编码目录</td>
			<td class="textTdCenter"><select name="fileType3.2"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType3.2'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType3.2'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType3.2'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType3.2'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result3.2"
					${formDataMap['result3.2'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result3.2"
					${formDataMap['result3.2'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result3.2"
					${formDataMap['result3.2'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark3.2">${formDataMap['remark3.2']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">3.3</td>
			<td class="textTd">统计报告</td>
			<td class="textTdCenter"><select name="fileType3.3"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType3.3'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType3.3'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType3.3'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType3.3'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result3.3"
					${formDataMap['result3.3'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result3.3"
					${formDataMap['result3.3'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result3.3"
					${formDataMap['result3.3'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark3.3">${formDataMap['remark3.3']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">3.4</td>
			<td class="textTd">总结报告</td>
			<td class="textTdCenter"><select name="fileType3.4"
				style="width: 100px; margin-right: 0px">
					<option />
					<option value="1"
						${formDataMap['fileType3.4'] eq "1"?"selected='selected'":""}>原件</option>
					<option value="2"
						${formDataMap['fileType3.4'] eq "2"?"selected='selected'":""}>扫描版</option>
					<option value="3"
						${formDataMap['fileType3.4'] eq "3"?"selected='selected'":""}>电子档</option>
					<option value="4"
						${formDataMap['fileType3.4'] eq "4"?"selected='selected'":""}>复印件</option>
			</select></td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result3.4"
					${formDataMap['result3.4'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result3.4"
					${formDataMap['result3.4'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result3.4"
					${formDataMap['result3.4'] eq "3"?"checked='true'":""} value="3" />&nbsp;不确定
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark3.4">${formDataMap['remark3.4']}</textarea>
			</td>
		<tr>
	</tbody>
	<tr>
		<th colspan="5"><font style="float: left">&#12288;发现的问题</font></th>
	</tr>
	<tr>
		<td colspan="5"><textarea class="xltxtarea validate[required]"
				name="problem" placeholder="请填写发现的问题 (若没有，请填无)">${formDataMap['problem']}</textarea>
		</td>
	</tr>
</table>
