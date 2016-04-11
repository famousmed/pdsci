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
</jsp:include>
<script type="text/javascript">
function add(){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/fund/item/edit'/>", "经费项目信息", 500, 260);
}
function doDel(){
	jboxStartLoading();
	jboxConfirm("确认删除?",function(){});
}
function submitConfirm(){
	jboxStartLoading();
	jboxConfirm("确认审核?",function(){});
}
function scale(){
	jboxStartLoading();
	jboxOpen("${ctxPath }/jsp/srm/fund/item/scale.jsp", "经费正负比例", 500, 400);
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchFundItem" action="<s:url value="/srm/fund/item/list"/>" method="post">
			项目名称：	
			<input style="width: 200px" class="xlname" name="itemName" type="text" value="${param.itemName}"/>
			项目编号：	
			<input style="width: 120px" class="xlname" name="itemName" type="text" value="${param.itemName}"/>
			报销日期：	
			<input style="width: 100px" class="xlname" name="itemName" type="text" value="${param.itemName}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
			~<input style="width: 100px" class="xlname" name="itemName" type="text" value="${param.itemName}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
			<input type="checkbox" id="0"/><label for="0">未审核&#12288;</label><input type="checkbox" id="1" /><label for="1">已审核&#12288;</label><input type="checkbox" id="2"/><label for="2">已核销</label>
			<input class="search" type="button" value="查询" onclick="search()"/>
			<input class="search" type="button" value="新增" onclick="add()"/>
			</form>
		</div>
		<table class="xllist">
				<tr>
					<th width="18%">项目名称</th>
					<th width="10%">费用类型</th>
					<th width="8%">费用金额</th>
					<th width="8%">费用正负比</th>
					<th width="8%">报销时间</th>
					<th width="10%">报销状态</th>
					<th width="8%">审核时间</th>
					<th width="10%">操作</th>
				</tr>
					<tr>
						<td>喉返神经损伤、再支配机制的实验研究</td>
						<td>差旅费</td>
						<td>3550</td>
						<td><a href="javascript:scale();" style="color: blue">200%</a></td>
						<td>2014-04-21</td>
						<td>已审核未核销</td>
						<td>2014-05-09</td>
						<td><a href="javascript:submitConfirm();">审核</a></td>
					</tr>
					<tr>
						<td>喉返神经损伤、再支配机制的实验研究</td>
						<td>差旅费</td>
						<td>550</td>
						<td><a href="javascript:scale();" style="color: blue">100%</a></td>
						<td>2014-04-21</td>
						<td>已审核未核销</td>
						<td>2013-05-09</td>
						<td><a href="javascript:submitConfirm();">审核</a></td>
					</tr>
					<tr>
						<td>喉返神经损伤、再支配机制的实验研究</td>
						<td>材料费</td>
						<td>1550</td>
						<td><a href="javascript:scale();" style="color: blue">120%</a></td>
						<td>2013-07-21</td>
						<td>已审核未核销</td>
						<td>2014-07-31</td>
						<td><a href="javascript:submitConfirm();">审核</a></td>
					</tr>
					<tr>
						<td>喉返神经损伤、再支配机制的实验研究</td>
						<td>会议费</td>
						<td>5000</td>
						<td><a href="javascript:scale();" style="color: blue">90%</a></td>
						<td>2013-09-14</td>
						<td>审核中</td>
						<td></td>
						<td><a href="javascript:submitConfirm();">审核</a></td>
					</tr>
					<tr>
						<td>硫化氢对腹膜透析腹膜纤维化的干预作用及机制研究</td>
						<td>差旅费</td>
						<td>550</td>
						<td><a href="javascript:scale();" style="color: blue">100%</a></td>
						<td>2014-04-21</td>
						<td>已审核未核销</td>
						<td>2013-05-09</td>
						<td><a href="javascript:submitConfirm();">审核</a></td>
					</tr>
					<tr>
						<td>硫化氢对腹膜透析腹膜纤维化的干预作用及机制研究</td>
						<td>材料费</td>
						<td>1550</td>
						<td><a href="javascript:scale();" style="color: blue">120%</a></td>
						<td>2013-07-21</td>
						<td>已审核未核销</td>
						<td>2014-07-31</td>
						<td><a href="javascript:submitConfirm();">审核</a></td>
					</tr>
					<tr>
						<td>硫化氢对腹膜透析腹膜纤维化的干预作用及机制研究</td>
						<td>会议费</td>
						<td>5000</td>
						<td><a href="javascript:scale();" style="color: blue">90%</a></td>
						<td>2013-09-14</td>
						<td>审核中</td>
						<td></td>
						<td><a href="javascript:submitConfirm();">审核</a></td>
					</tr>
					<tr>
						<td>舌下含服“尘螨合剂”的疗效及安全性评价</td>
						<td>差旅费</td>
						<td>550</td>
						<td><a href="javascript:scale();" style="color: blue">100%</a></td>
						<td>2014-04-21</td>
						<td>已审核未核销</td>
						<td>2013-05-09</td>
						<td><a href="javascript:submitConfirm();">审核</a></td>
					</tr>
					<tr>
						<td>舌下含服“尘螨合剂”的疗效及安全性评价</td>
						<td>材料费</td>
						<td>1550</td>
						<td><a href="javascript:scale();" style="color: blue">120%</a></td>
						<td>2013-07-21</td>
						<td>已审核未核销</td>
						<td>2014-07-31</td>
						<td><a href="javascript:submitConfirm();">审核</a></td>
					</tr>
					<tr>
						<td>舌下含服“尘螨合剂”的疗效及安全性评价</td>
						<td>会议费</td>
						<td>5000</td>
						<td><a href="javascript:scale();" style="color: blue">90%</a></td>
						<td>2013-09-14</td>
						<td>审核中</td>
						<td></td>
						<td><a href="javascript:submitConfirm();">审核</a></td>
					</tr>
					<tr>
						<td>雷珠单抗病理性近视的脉络膜新生血管导致视力损害</td>
						<td>会议费</td>
						<td>5000</td>
						<td><a href="javascript:scale();" style="color: blue">90%</a></td>
						<td>2013-09-14</td>
						<td>审核中</td>
						<td></td>
						<td><a href="javascript:submitConfirm();">审核</a></td>
					</tr>
					<tr>
						<td>雷珠单抗病理性近视的脉络膜新生血管导致视力损害</td>
						<td>差旅费</td>
						<td>550</td>
						<td><a href="javascript:scale();" style="color: blue">100%</a></td>
						<td>2014-04-21</td>
						<td>已审核未核销</td>
						<td>2013-05-09</td>
						<td><a href="javascript:submitConfirm();">审核</a></td>
					</tr>
					<tr>
						<td>雷珠单抗病理性近视的脉络膜新生血管导致视力损害</td>
						<td>材料费</td>
						<td>1550</td>
						<td><a href="javascript:scale();" style="color: blue">120%</a></td>
						<td>2013-07-21</td>
						<td>已审核未核销</td>
						<td>2014-07-31</td>
						<td><a href="javascript:submitConfirm();">审核</a></td>
					</tr>
					<tr>
						<td>雷珠单抗病理性近视的脉络膜新生血管导致视力损害</td>
						<td>会议费</td>
						<td>5000</td>
						<td><a href="javascript:scale();" style="color: blue">90%</a></td>
						<td>2013-09-14</td>
						<td>审核中</td>
						<td></td>
						<td><a href="javascript:submitConfirm();">审核</a></td>
					</tr>
		</table>
	</div>
</div>
</body>
</html>