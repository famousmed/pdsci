<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script type="text/javascript">

	function searchProj() {
		jboxStartLoading();
		$("#searchForm").submit();
	}
	
	function toPage(page) {
		if(page!=undefined){
			$("#currentPage").val(page);			
		}
		searchProj();
	}
	function edit(){
	   jboxOpen("<s:url value='/jsp/srm/conedu/credit/edit.jsp'/>","新增学分",850,400);
	}
	function audit(){
		jboxConfirm("确认审核通过？", function() {
			jboxTip("审核失败！");			
		});
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/srm/aid/proj/list"/>"
				method="post">
				<p>
					姓名：
					<input type="text" class="xltext " name="projYear"/>&#12288;
					单位名称： <input type="text" name="projNo" value="${param.projNo}" class="xltext" />&#12288;
					身份证号码：
					<input type="text" name="projName" value="${param.projName}" class="xltext"  />
					<input id="currentPage" type="hidden" name="currentPage" value=""/>
					<input type="button" class="search" onclick="searchProj();" value="查&#12288;询">
				</p>
			</form>
		</div>
		<table class="xllist">
			<thead>
				<tr>
					<th >单位</th>
					<th style="width: 100px;">姓名</th>
					<th style="width: 80px;">性别</th>
					<th style="width: 200px;">身份证号码</th>
					<th  style="width: 100px;">职称</th>
					<th  style="width: 200px;">最后晋升时间</th>
					<th style="width: 80px;">学科</th>
					<th style="width: 80px;">学分</th>
				</tr>
			</thead>
			<tbody>
					<tr>
						<td>南京医科大学附属医院</td>
						<td>李永康</td>
						<td>男</td>
						<td>342622196008075560</td>
						<td>院长</td>
						<td>2013-10-12</td>
						<td>普通外科</td>
						<td>
						  <a href="#" onclick="javascript:audit();">[审核]</a>
						</td>
					</tr>
					<tr>
						<td>江苏省人民医院</td>
						<td>贾云飞</td>
						<td>男</td>
						<td>342622195908075561</td>
						<td>教授</td>
						<td>2014-09-20</td>
						<td>妇科</td>
						<td>
						  <a href="#" onclick="javascript:audit();">[审核]</a>
						</td>
					</tr>
					<tr>
						<td>江苏省军区总医院</td>
						<td>吴昊</td>
						<td>男</td>
						<td>342622195908074568</td>
						<td>副教授</td>
						<td>2013-12-15</td>
						<td>儿科</td>
						<td>
						  <a href="#" onclick="javascript:audit();">[审核]</a>
						</td>
					</tr>
					<tr>
						<td>南京医科大学附属医院</td>
						<td>沈振</td>
						<td>男</td>
						<td>342622195908074654</td>
						<td>教授</td>
						<td>2012-05-14</td>
						<td>骨科</td>
						<td>
						  <a href="#" onclick="javascript:audit();">[审核]</a>
						</td>
					</tr>
					<tr>
						<td>江苏省军区总医院</td>
						<td>韩兰叶</td>
						<td>女</td>
						<td>342622195908075352</td>
						<td>副教授</td>
						<td>2013-08-16</td>
						<td>普通外科</td>
						<td>
						  <a href="#" onclick="javascript:audit();">[审核]</a>
						</td>
					</tr>
					<tr>
						<td>江苏人民医院</td>
						<td>石峰</td>
						<td>男</td>
						<td>342622195908075463</td>
						<td>教授</td>
						<td>2014-02-17</td>
						<td>神经内科</td>
						<td>
						  <a href="#" onclick="javascript:audit();">[审核]</a>
						</td>
					</tr>
					<tr>
						<td>江苏中医院</td>
						<td>刘燕</td>
						<td>女</td>
						<td>342622195908075954</td>
						<td>教授</td>
						<td>2015-01-12</td>
						<td>普通外科</td>
						<td>
						  <a href="#" onclick="javascript:audit();">[审核]</a>
						</td>
					</tr>
					<tr>
						<td>江苏省人民医院</td>
						<td>王明成</td>
						<td>男</td>
						<td>342622195908075340</td>
						<td>副教授</td>
						<td>2014-12-20</td>
						<td>内科</td>
						<td>
						  <a href="#" onclick="javascript:audit();">[审核]</a>
						</td>
					</tr>
			</tbody>
		</table>
		<c:set var="pageView" value="${pdfn:getPageView(aidProjList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>	
	</div>
</div>
</body>
</html>