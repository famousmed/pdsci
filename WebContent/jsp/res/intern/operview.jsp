<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_form" value="false" />
	<jsp:param name="jquery_ui_tooltip" value="true" />
	<jsp:param name="jquery_ui_combobox" value="false" />
	<jsp:param name="jquery_ui_sortable" value="false" />
	<jsp:param name="jquery_cxselect" value="true" />
	<jsp:param name="jquery_scrollTo" value="false" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="false" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
</jsp:include>

</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<table class="basic" width="100%">
					<tr>
						<th colspan="6" style="text-align: left;">&#12288;临床技术操作项目完成情况统计表</th>
					</tr>
					<tr style="font-weight: bold;">
						<td colspan="2" style="text-align: center;">操作项目</td>
						<td width="150px;" style="text-align: center;">大纲规定次数</td>
						<td width="100px;" style="text-align: center;">完成次数</td>
						<td width="100px;" style="text-align: center;">达成率</td>
					</tr>

					<tr>
						<td rowspan="6" width="100px;" style="text-align: center;">内科</td>
						<td>静脉穿刺、补液</td>
						<td style="text-align: center;">20</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="10"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
							<td style="text-align: center; width: 150px;">50%</td>
					</tr>
					<tr>
						<td>心电图操作</td>
						<td style="text-align: center;">30</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="15"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">50%</td>
					</tr>
					<tr>
						<td>腹腔穿刺</td>
						<td style="text-align: center;">3</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="1"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">33.3%</td>
					</tr>
					<tr>
						<td>胸腔穿刺</td>
						<td style="text-align: center;">2</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="2"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">100%</td>
					</tr>
					<tr>
						<td>骨髓穿刺</td>
						<td style="text-align: center;">1</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="0"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">&#12288;&#12288;0%
						<img src="<s:url value='/css/skin/${skinPath}/images/ts.png'/>" title="实习期间未遇到该操作手术"/>
						</td>
					</tr>
					<tr>
						<td>腰椎穿刺</td>
						<td style="text-align: center; ">5</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="5"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">100%</td>
					</tr>
					<tr>
						<td rowspan="6" width="100px;" style="text-align: center;">外科</td>
						<td>外科手术基本操作(如切开、止血、打结、缝合等)</td>
						<td style="text-align: center;">12</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="6"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">50%</td>
					</tr>
					<tr>
						<td>手术室无菌技术(如洗手、戴手套、穿手术衣、消毒、铺单等手术过程无菌原则)</td>
						<td style="text-align: center;">10</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="8"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">80%</td>
					</tr>
					<tr>
						<td>换药及清创术</td>
						<td style="text-align: center;">5</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="5"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">100%</td>
					</tr>
					<tr>
						<td>导尿术</td>
						<td style="text-align: center;">4</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText"  value="4"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">100%</td>
					</tr>
					<tr>
						<td>肠胃减压</td>
						<td style="text-align: center;">5</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="5"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">100%</td>
					</tr>
					<tr>
						<td>石膏固定、骨牵引</td>
						<td style="text-align: center;">6</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="6"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">100%</td>
					</tr>
					
					<tr>
					<td rowspan="7" width="100px;" style="text-align: center;">妇产科</td>
						<td>产程观察及肛查</td>
						<td style="text-align: center;">8</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="8"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">100%</td>
					</tr>
					<tr>
						<td>产程图</td>
						<td style="text-align: center;">9</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="9"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">100%</td>
					</tr>
					<tr>
						<td>产前检查四步法</td>
						<td style="text-align: center;">8</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="8"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">100%</td>
					</tr>
					<tr>
						<td>胎心听诊</td>
						<td style="text-align: center;">8</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="8"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">100%</td>
					</tr>
					<tr>
						<td>骨盆测量</td>
						<td style="text-align: center;">8</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="8"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">100%</td>
					</tr>
					<tr>
						<td>妊娠图</td>
						<td style="text-align: center; ">6</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="6"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">100%</td>
					</tr>
					<tr>
						<td>妇科检查(双合诊)</td>
						<td style="text-align: center;">10</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="10"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">100%</td>
					</tr>
					<tr>
					<td rowspan="6" width="100px;" style="text-align: center;">儿科</td>
						<td>静脉穿刺、补液/td>
						<td style="text-align: center;">12</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="12"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">100%</td>
					</tr>
					<tr>
						<td>心电图操作</td>
						<td style="text-align: center;">15</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="15"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">100%</td>
					</tr>
					<tr>
						<td>腹腔穿刺</td>
						<td style="text-align: center;">10</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="2"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">20%</td>
					</tr>
					<tr>
						<td>胸腔穿刺</td>
						<td style="text-align: center;">10</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="10"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">100%</td>
					</tr>
					<tr>
						<td>骨髓穿刺</td>
						<td style="text-align: center;">10</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="10"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">100%</td>
					</tr>
					<tr>
						<td>腰椎穿刺</td>
						<td style="text-align: center; ">15</td>
						<td style="text-align: center; width: 150px;"><input
							type="text" class="inputText" value="15"
							style="text-align: center; width: 60%; border-width: 0px; border-bottom-width: 1px;" /></td>
						<td style="text-align: center; width: 150px;">100%</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>