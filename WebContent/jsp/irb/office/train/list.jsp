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
var width=(window.screen.width)*0.7;
var height=(window.screen.height)*0.7;
	function add(){
		jboxOpen("<s:url value='/irb/office/editTrain?trainCategoryId='/>${trainCategoryId}" ,"新增培训", width,height); 
	}
	function edit(trainFlow){
		jboxOpen("<s:url value='/irb/office/editTrain?trainCategoryId='/>${trainCategoryId}&trainFlow="+trainFlow,"编辑培训", width,height); 
	}
	function search(){
		$("#searchForm").submit();
	}
	function certificate(trainFlow){
		jboxOpen("<s:url value='/irb/office/certificate'/>?trainFlow="+trainFlow+"&trainCategoryId=${trainCategoryId}","培训证书", width,height);
	}
	function delTrain(trainFlow){
		var url = "<s:url value='/irb/office/delTrain?trainFlow='/>" + trainFlow;
		jboxConfirm("确认删除？" , function(){
			jboxGet(url , null , function(){
				window.parent.frames['mainIframe'].location.reload(true);
			}, null , true);
		});
	}
	
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/irb/office/train" />" method="Post">
				<div style="margin-bottom: 10px">
					培训日期：
					<input type="text" name="trainDate" value="${param.trainDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="ctime" readonly="readonly" style="margin-right: 0px;"/>~<input type="text" name="endTrainDate"  value="${param.endTrainDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="ctime" readonly="readonly"/> 
					&#12288;培训类别：
					<select name="trainTypeId" class="xlselect">
						<option value="">请选择</option>
						<c:forEach items="${irbTrainTypeEnumList}" var="dict">
							<option value="${dict.id}" <c:if test="${param.trainTypeId eq dict.id}">selected="selected"</c:if>>${dict.name}</option>
						</c:forEach>
					</select>
					<input type="button" value="查&#12288;询" class="search" onclick="search();"/>
					<input type="button" value="新&#12288;增" class="search" onclick="add();"/>
					
					<input type="hidden" name="trainCategoryId" value="${trainCategoryId}"/>
				</div>
			<table class="xllist">
				<thead>
					<tr>
						<th width="15%">主办单位</th>
						<th width="15%">培训名称</th>
						<th width="10%">培训类别</th>
						<th width="10%">培训日期</th>
						<th width="20%">培训地点</th>
						<th width="10%">培训天数</th>
						<th width="10%">培训证书</th>
						<th width="10%">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${trainList}" var="train">
						<tr>
							<td>${train.trainOrg}</td>
							<td>${train.trainName}</td>
							<td>${train.trainTypeName}</td>
							<td>${train.trainDate}</td>
							<td>${train.trainAddress}</td>
							<td>${train.trainDays}</td>
							<td><a href="javascript:certificate('${train.trainFlow}');">[证书]</a></td>
							<td>
								<a href="javascript:edit('${train.trainFlow}');">[编辑]</a>
								<a href="javascript:delTrain('${train.trainFlow}')">[删除]</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</form>
		</div>
	</div>
</div>
</body>
</html>