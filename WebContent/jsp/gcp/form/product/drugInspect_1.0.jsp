<%@page import="com.pinde.sci.enums.gcp.GcpRecTypeEnum"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
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
	value="${gcpRecTypeEnumDrugInspect.id}" />
<input type="hidden" name="formFileName" value="${formFileName}" />
<table class="xllist" width="100%">
	<tr>
		<th width="5%">序号</th>
		<th width="50%">文件名</th>
		<th width="15%">检查结果</th>
		<th width="30%">备注</th>
	</tr>
	<tbody id="fileInspectList">
		<tr>
			<th class="textTd">1</th>
			<th class="textTd" colspan="4">药物接收</th>
		</tr>
		<tr class="data">
			<td class="textTd">1.1</td>
			<td class="textTd">试验用药物的质量检验报告</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.1"
					${formDataMap['result1.1'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.1"
					${formDataMap['result1.1'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.1"
					${formDataMap['result1.1'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.1">${formDataMap['remark1.1']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.2</td>
			<td class="textTd">试验用药物：名称、数量、剂型、规格、生产日期、批号、有效期、生产厂家、运输过程中的条件是否与方案相符</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.2"
					${formDataMap['result1.2'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.2"
					${formDataMap['result1.2'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.2"
					${formDataMap['result1.2'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.2">${formDataMap['remark1.2']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.3</td>
			<td class="textTd">药物编号：药物药包号与送货单上的号码是否一致;接收双盲药物时如有应急信封，应急信封上的编号与该药物的药物编码号是否一致，信封是否密封，是否有破损</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.3"
					${formDataMap['result1.3'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.3"
					${formDataMap['result1.3'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.3"
					${formDataMap['result1.3'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.3">${formDataMap['remark1.3']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.4</td>
			<td class="textTd">药物的外包装是否完好，包装的标识是否清楚</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.4"
					${formDataMap['result1.4'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.4"
					${formDataMap['result1.4'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.4"
					${formDataMap['result1.4'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.4">${formDataMap['remark1.4']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">1.5</td>
			<td class="textTd">低温保存药物的接收：温度计的编号与送货单上登记的编号是否一致;开箱温度是否记录</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result1.5"
					${formDataMap['result1.5'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result1.5"
					${formDataMap['result1.5'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result1.5"
					${formDataMap['result1.5'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark1.5">${formDataMap['remark1.5']}</textarea>
			</td>
		<tr>
		<tr>
			<th class="textTd">2</th>
			<th class="textTd" colspan="4">试验用药物保管</th>
		</tr>
		<tr class="data">
			<td class="textTd">2.1</td>
			<td class="textTd">试验用药物的储藏和保存应具备的必要的环境和设备是否健全</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.1"
					${formDataMap['result2.1'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.1"
					${formDataMap['result2.1'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.1"
					${formDataMap['result2.1'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.1">${formDataMap['remark2.1']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.2</td>
			<td class="textTd">试验用药物专柜是否加锁存放</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.2"
					${formDataMap['result2.2'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.2"
					${formDataMap['result2.2'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.2"
					${formDataMap['result2.2'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.2">${formDataMap['remark2.2']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.3</td>
			<td class="textTd">试验用药物存放期间每日是否有温湿度记录</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.3"
					${formDataMap['result2.3'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.3"
					${formDataMap['result2.3'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.3"
					${formDataMap['result2.3'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.3">${formDataMap['remark2.3']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.4</td>
			<td class="textTd">药物管理员是否对试验药物进行清点、核对、记录</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.4"
					${formDataMap['result2.4'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.4"
					${formDataMap['result2.4'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.4"
					${formDataMap['result2.4'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.4">${formDataMap['remark2.4']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.5</td>
			<td class="textTd">试验用药物是否破损、变质、失效、将药物集中存放于“不合格药物区”</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.5"
					${formDataMap['result2.5'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.5"
					${formDataMap['result2.5'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.5"
					${formDataMap['result2.5'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.5">${formDataMap['remark2.5']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">2.6</td>
			<td class="textTd">药物管理员是否负责保管药柜的钥匙</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result2.6"
					${formDataMap['result2.6'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result2.6"
					${formDataMap['result2.6'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result2.6"
					${formDataMap['result2.6'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark2.6">${formDataMap['remark2.6']}</textarea>
			</td>
		<tr>
		<tr>
			<th class="textTd">3</th>
			<th class="textTd" colspan="4">试验用药物分发使用</th>
		</tr>
		<tr class="data">
			<td class="textTd">3.1</td>
			<td class="textTd">试验用药物的分发、核对处方的内容：项目的名称、受试者的姓名与编号、药物的规格、数量</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result3.1"
					${formDataMap['result3.1'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result3.1"
					${formDataMap['result3.1'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result3.1"
					${formDataMap['result3.1'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark3.1">${formDataMap['remark3.1']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">3.2</td>
			<td class="textTd">需要回收的口服试验用药物是否外包装注明：项目的名称、受试者姓名的缩写、受试者编号、发药日期</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result3.2"
					${formDataMap['result3.2'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result3.2"
					${formDataMap['result3.2'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result3.2"
					${formDataMap['result3.2'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark3.2">${formDataMap['remark3.2']}</textarea>
			</td>
		<tr>
		<tr class="data">
			<td class="textTd">3.3</td>
			<td class="textTd">需要回收的注射剂是否外包装注明：“请留瓶”字样、项目的名称、受试者姓名缩写、受试者编号、发药日期</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result3.3"
					${formDataMap['result3.3'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result3.3"
					${formDataMap['result3.3'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result3.3"
					${formDataMap['result3.3'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark3.3">${formDataMap['remark3.3']}</textarea>
			</td>
		<tr>
		<tr>
			<th class="textTd">4</th>
			<th class="textTd" colspan="4">试验用药物及包装的回收</th>
		</tr>
		<tr class="data">
			<td class="textTd">4.1</td>
			<td class="textTd">试验用药物是否回收</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result4.1"
					${formDataMap['result4.1'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result4.1"
					${formDataMap['result4.1'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result4.1"
					${formDataMap['result4.1'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark4.1">${formDataMap['remark4.1']}</textarea>
			</td>
		<tr>
		<tr>
			<th class="textTd">5</th>
			<th class="textTd" colspan="4">实验用药物的销毁</th>
		</tr>
		<tr class="data">
			<td class="textTd">5.1</td>
			<td class="textTd">是否有试验用药物的销毁记录</td>
			<td class="textTdCenter"><label> <input type="checkbox"
					name="result5.1"
					${formDataMap['result5.1'] eq "1"?"checked='true'":""} value="1" />&nbsp;是
			</label> &nbsp; <label> <input type="checkbox" name="result5.1"
					${formDataMap['result5.1'] eq "2"?"checked='true'":""} value="2" />&nbsp;否
			</label> &nbsp; <label> <input type="checkbox" name="result5.1"
					${formDataMap['result5.1'] eq "3"?"checked='true'":""} value="3" />&nbsp;NA
			</label></td>
			<td class="textTdCenter"><textarea class="xltxtarea"
					style="height: 25px; resize: none; width: 80%" name="remark5.1">${formDataMap['remark5.1']}</textarea>
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