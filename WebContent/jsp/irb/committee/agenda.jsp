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
function vote(){
	jboxOpen("<s:url value='/irb/committee/vote'/>","委员投票",800,400);
}
function declare(){
	jboxConfirm("确定声明利益冲突，退出本次投票?",function(){
		
	});
}
function viewIrbFile(){
	jboxOpen("<s:url value='/irb/committee/viewIrbFile'/>","送审文件",1000,600);
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" 
				method="post">
				<table>
				<tr>
					<td width="95%">
						<p>
							<b>会议日期：</b>2013-06-06   15:00 ～ 17:00  &#12288;&#12288;<b>地点：</b> 科教大楼502 &#12288;&#12288;<b>主持人：</b>沈海琦 
						</p>
						<p><b>参会委员：</b>沈海琦、马振华、陈亚新、刘晓东、夏京胜、孙辉、陈小兰、张林
						&#12288;&#12288;<b>独立顾问：</b>孙辉&#12288;&#12288;<b>秘书：</b>朱怀刚
						&#12288;<b>伦理委员会：</b>医疗技术临床应用伦理委员会 
						</p>
					</td>
					<td width="5%" align="right">
						       <img src="<s:url value='/css/skin/${skinPath}/images/meeting.png'/>" onclick="jboxInfo('下载会议记录');" style="width: 80px;height: 80px;cursor: pointer;" title="会议记录"/>
					</td>
				</tr>
				</table>
			</form>
		</div> 
		<table class="xllist">
			<thead>
				<tr>
					<th  colspan="7" align="left">&#12288;会议报告项目</th>
				</tr>
				<tr>
					<th width="20%" >项目名称</th>
					<th width="10%" >专业组</th>
					<th width="10%" >主要研究者</th>
					<th width="10%" >伦理审查类别</th>
					<th width="10%"  >受理号</th>
					<th width="10%">委员投票</th>
					<th width="10%" >利益冲突</th>
				</tr>
			</thead>
			<tbody>
					<tr>
						<td ><a href="javascript:viewIrbFile();" style="color: blue">喉返神经损伤、再支配机制的实验研究</a></td>
						<td >骨科</td>
						<td >方琪</td>
						<td >复审申请</td>
						<td >2014SL-01</td>
						<td >[<a href="javascript:vote()">委员投票</a>]</td>
						<td >[<a href="javascript:declare();">利益冲突声明</a>]</td>
					</tr>
			</tbody>
		</table>
		<div style="height: 10px"></div> 
		<table class="xllist">
			<thead>
				<tr>
					<th colspan="7" align="left">&#12288;会议审查项目</th>
				</tr>
				<tr>
					<th width="20%" >项目名称</th>
					<th width="10%" >专业组</th>
					<th width="10%" >主要研究者</th>
					<th width="10%" >伦理审查类别</th>
					<th width="10%"  >受理号</th>
					<th width="10%">委员投票</th>
					<th width="10%" >利益冲突</th>
				</tr>
			</thead>
			<tbody>
					<tr>
						<td ><a href="javascript:viewIrbFile();" style="color: blue">喉返神经损伤、再支配机制的实验研究</a></td>
						<td >骨科</td>
						<td >方琪</td>
						<td >复审申请</td>
						<td >2014SL-01</td>
						<td >[<a href="javascript:vote()">委员投票</a>]</td>
						<td >[<a href="javascript:declare();">利益冲突声明</a>]</td>
					</tr>
			</tbody>
		</table>
	</div>
</div>
</body>
</html>