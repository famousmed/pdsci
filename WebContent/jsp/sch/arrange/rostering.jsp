<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<c:if test="${not empty processArrange }">
<meta http-equiv="refresh" content="60">
</c:if>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
</jsp:include>
<script type="text/javascript">
	function arrange(){
		var beginDate = $("#beginDate").val();
		if(!beginDate){
			return jboxTip("请选择本次排班轮转开始时间！");
		}
		if(${unSelDepCount}>0){
			jboxTip("请完成选科动作后再排班!");
			return;
		}
		jboxConfirm("确认进行智能排班操作?",function(){
			jboxGet("<s:url value='/sch/rostering'/>?beginDate="+beginDate,null,function(){
				window.location.reload();
			},null,true);
		},null,true);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<c:if test="${not empty processArrange }">
				<div>
				<fieldset>
					<legend>自动排班</legend>
					<table>
						<tr><td>
						本次排班总人数：<font color="red">${processArrange.doctorNum}</font>人。
						&#12288; <font id="countProcessForCurr" color="red" size="8px">共约需要${processArrange.doctorNum*2}分钟，请耐心等待...</font> 
						<br> 排班开始时间： ${pdfn:transDateTime(processArrange.operTime)}
						&#12288; &#12288; 排班人：${processArrange.operUserName}
						&#12288;&#12288; 
						</td></tr>
					</table>
				</fieldset>
				</div>
			</c:if>
			<c:if test="${empty processArrange }">
			<div>
			<fieldset>
				<legend>自动排班</legend>
				<table>
					<tr><td>
					本次排班总人数：<font color="red">${unSchDoctorCount}</font> &#12288;其中已选科人数：<font color="red">${selDeptCount}</font> &#12288;
					未选科人数：<font color="red">${unSelDepCount}</font> &#12288;您必须先确定所有选科才可以进行排班操作,点击<a style="color: blue" href="<s:url value='/sch/doc/seldept'/>">这里</a>进行选科操作!
					<p>
					<br>
					<font color="red">本次排班轮转开始时间：</font>
					<input type="text" id="beginDate" name="beginDate" value="" style="height: 24px;margin-top: -5px;width: 80px;" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
					<input type="button" value="排&#12288;班" class="search" onclick="arrange();">
					</td></tr>
				</table>
			</fieldset>
			</div>
			</c:if>
			<div id="dept" style="width:100%; margin-top: 10px;margin-bottom: 10px;" >
				<fieldset>
					<legend>排班记录</legend>
					<table  width="100%" class="xllist" >
						<tr>
							<th>操作时间</th>
							<th>操作人员</th>
							<th>排班人数</th>
							<th>轮转开始时间</th>
							<th>排班指数</th>
							<th>状态</th>
							<!-- <th>操作</th> -->
						</tr>
						<c:forEach items="${arrangeList }" var="arrange">
							<tr>
								<td>${pdfn:transDateTime(arrange.operTime)}</td>
								<td>${arrange.operUserName}</td>
								<td>${arrange.doctorNum}</td>
								<td>${arrange.beginDate }</td>
								<td>${arrange.beginIndex }->${arrange.endIndex }</td>
								<td>${arrange.arrangeStatusName }</td>
								<%-- <td>
									<a href="javascript:schConfirm('${arrange.arrangeFlow }');">
								<c:if test="${ arrange.arrangeStatusId == schArrangeStatusEnumFinish.id }">
									[确认]
								</c:if>
								<c:if test="${ arrange.arrangeStatusId == schArrangeStatusEnumConfirm.id }">
									[查看]
								</c:if>
									</a>
								</td> --%>
							</tr>
						</c:forEach>
						<c:if test="${empty arrangeList}">
							<tr><td align="center" colspan="6">无记录</td></tr>
						</c:if>
					</table>
				</fieldset>
		</div>
	</div>
</div>
</div>
</body>
</html>