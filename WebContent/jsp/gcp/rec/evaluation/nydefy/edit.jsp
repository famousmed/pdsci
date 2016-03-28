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
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_fixedtable" value="true"/>
</jsp:include>
</head>
<style>
.edit3{text-align: left;border:none;}
</style>
<body>
	<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div class="title1 clearfix">
				<form id="projForm" style="position: relative;"> 
				<input type="hidden" id="projFlow" name="projFlow" value="${projInfoForm.proj.projFlow }">
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<tr>
						<th colspan="6" style="text-align: left;">&#12288;专业科室主要研究者评估</th>
					</tr>
					<tr>
						<td width="35%">目标研究人群的招募：</td>
						<td colspan="5">
							<input type="radio" name="radio1" id="radio1_1"/><label for="radio1_1">预期能按进度完成</label>&#12288;
							<input type="radio" name="radio1" id="radio1_2"/><label for="radio1_2">有难度</label>&#12288;
							<input type="radio" name="radio1" id="radio1_3"/><label for="radio1_3">很困难</label>
						</td>
					</tr>
					<tr>
						<td>是否具备研究所需的理化检查的条件：</td>
						<td colspan="5">
							<input type="radio" name="radio2" id="radio2_1"/><label for="radio2_1">是</label>&#12288;
							<input type="radio" name="radio2" id="radio2_2"/><label for="radio2_2">否</label>
						</td>
					</tr>
					<tr>
						<td >是否具备预期严重不良事件抢救的条件：</td>
						<td colspan="5">
							<input type="radio" name="radio3" id="radio3_1"/><label for="radio3_1">是</label>&#12288;
							<input type="radio" name="radio3" id="radio3_2"/><label for="radio3_2">否</label>
						</td>
					</tr>
					<tr>
						<td >主要研究者是否有充分的时间参加研究：</td>
						<td colspan="5">
							<input type="radio" name="radio4" id="radio4_1"/><label for="radio4_1">是</label>&#12288;
							<input type="radio" name="radio4" id="radio4_2"/><label for="radio4_2">否</label>
						</td>
					</tr>
					<tr>
						<td >评估意见：</td>
						<td colspan="5">
							<input type="radio" name="radio5" id="radio5_1"/><label for="radio5_1">同意立项</label>&#12288;
							<input type="radio" name="radio5" id="radio5_2"/><label for="radio5_2">不同意立项</label>
						</td>
					</tr>
					<tr>
						<td >主要研究者（签字）：</td>
						<td colspan="5">
							<input type="text" name="" class="xltext" value="叶进 韩新民"/>
						</td>
					</tr>
					<tr>
						<th colspan="6" style="text-align: left;">&#12288;项目管理员评估</th>
					</tr>
					<tr>
						<td width="35%">研究项目是否专业对口：</td>
						<td colspan="5">
							<input type="radio" name="radio1" id="radio1_1"/><label for="radio1_1">是</label>&#12288;
							<input type="radio" name="radio1" id="radio1_2"/><label for="radio1_2">否</label>
						</td>
					</tr>
					<tr>
						<td>承担科室在研临床试验项目数：</td>
						<td colspan="5">
							<input type="text" name="" class="xltext" value="0"/>项
						</td>
					</tr>
					<tr>
						<td >与试验药物目标疾病相同的在研项目：</td>
						<td colspan="5">
							<input type="radio" name="radio3" id="radio3_1"/><label for="radio3_1">有</label>&#12288;
							<input type="radio" name="radio3" id="radio3_2"/><label for="radio3_2">无</label>
						</td>
					</tr>
					<tr>
						<td >是否同时承担不同申办者的相同品种药物：</td>
						<td colspan="5">
							<input type="radio" name="radio4" id="radio4_1"/><label for="radio4_1">是</label>&#12288;
							<input type="radio" name="radio4" id="radio4_2"/><label for="radio4_2">否</label>
						</td>
					</tr>
					<tr>
						<td >评估意见：</td>
						<td colspan="5">
							<input type="radio" name="radio5" id="radio5_1"/><label for="radio5_1">同意立项</label>&#12288;
							<input type="radio" name="radio5" id="radio5_2"/><label for="radio5_2">不同意立项</label>
						</td>
					</tr>
					<tr>
						<td >项目管理员（签字）：</td>
						<td colspan="5">
							<input type="text" name="" class="xltext" value="刘芳"/>
						</td>
					</tr>
					<tr>
						<th colspan="6" style="text-align: left;">&#12288;机构办公室审核</th>
					</tr>
					<tr>
						<td >审核意见：</td>
						<td colspan="5">
							<input type="radio" name="radio5" id="radio5_1"/><label for="radio5_1">同意立项</label>&#12288;
							<input type="radio" name="radio5" id="radio5_2"/><label for="radio5_2">不同意立项</label>
						</td>
					</tr>
					<tr>
						<td>机构办公室主任（签字）：</td>
						<td colspan="5">
							<input type="text" name="" class="xltext" value="刘芳"/>
						</td>
					</tr>
					<tr>
						<td >日期：</td>
						<td colspan="5">
							<input type="text" name="" class="xltext" value="2014-09-11"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div style="width: 100%;" align="center" >
			<input class="search" type="button" value="保&#12288;存" onclick="jboxClose()"  />
		</div>
</div></div></div>
</body>
</html>