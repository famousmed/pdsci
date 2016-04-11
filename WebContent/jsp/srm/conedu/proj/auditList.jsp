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
	  jboxOpen("<s:url value='/jsp/srm/conedu/proj/edit.jsp'/>","继续教育项目录入",850,400);
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
					年&#12288;&#12288;份：
					<input type="text" style="width: 120px;" class="xltext ctime" name="projYear" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})" value="${param.projYear }"/>
					项目级别： <input type="text" name="projNo" value="${param.projNo}" class="xltext" />&#12288;
					所属学科： <input type="text" name="projNo" value="${param.projNo}" class="xltext" />
					&#12288;
					申报结果： <select class="xlselect" style="width: 100px;"><option></option><option>通过</option><option>不通过</option></select>
				</p>
				<p>
					项目名称：
					<input type="text" name="projName" value="${param.projName}" class="xltext" style="width: 380px" />
					项目负责人：
					<input type="text" name="projName" value="${param.projName}" class="xltext"  />
					<input id="currentPage" type="hidden" name="currentPage" value=""/>
					<input type="button" class="search" onclick="searchProj();" value="查&#12288;询">
					<input type="button" class="search" onclick="edit();" value="添&#12288;加">  
				</p>
			</form>
		</div>
		<table class="xllist">
			<thead>
				<tr>
					<th width="5%" >年份</th>
					<th width="10%" >项目级别</th>
					<th >项目名称</th>
					<th width="15%" >主办单位</th>
					<th width="10%" >项目负责人</th>
					<th width="15%" >起止时间</th>
					<th width="10%" >申请学分</th>
					<th width="10%" >申报结果</th>
					<th width="10%" >操作</th>
				</tr>
			</thead>
			<tbody>
					<tr>
						<td>2015</td>
						<td>国家级</td>
						<td>南京医疗卫生科研项目</td>
						<td>南京医科大学附属医院</td>
						<td>李永康</td>
						<td>2015-08 至 2015-10</td>
						<td>20</td>
						<td>通过</td>
						<td>
						  <a href="#" onclick="javascript:audit();">[审核]</a>
						</td>
					</tr>
					<tr>
						<td>2015</td>
						<td>省级</td>
						<td>南京市卫生科技计划项目</td>
						<td>南京人民医院</td>
						<td>杨金鑫</td>
						<td>2015-09 至 2015-12</td>
						<td>30</td>
						<td>通过</td>
						<td>
						  <a href="#" onclick="javascript:audit();">[审核]</a>
						</td>
					</tr>
					<tr>
						<td>2014</td>
						<td>省级</td>
						<td>南京市医疗卫生科研项目</td>
						<td>南京中医院</td>
						<td>贾云飞</td>
						<td>2014-02 至 2015-07</td>
						<td>15</td>
						<td>通过</td>
						<td>
						  <a href="#" onclick="javascript:audit();">[审核]</a>
						</td>
					</tr>
					<tr>
						<td>2014</td>
						<td>省级</td>
						<td>江苏省中医药科技计划项目</td>
						<td>南京人民医院</td>
						<td>吴昊</td>
						<td>2014-09 至 2015-01</td>
						<td>15</td>
						<td>通过</td>
						<td>
						  <a href="#" onclick="javascript:audit();">[审核]</a>
						</td>
					</tr>
					<tr>
						<td>2013</td>
						<td>省级</td>
						<td>江苏省医药卫生科技计划项目</td>
						<td>江苏省中医院</td>
						<td>王明臣</td>
						<td>2013-02 至 2014-07</td>
						<td>30</td>
						<td>通过</td>
						<td>
						  <a href="#" onclick="javascript:audit();">[审核]</a>
						</td>
					</tr>
					<tr>
						<td>2013</td>
						<td>国家级</td>
						<td>江苏省医学会临床科研基金项目</td>
						<td>江苏省人民医院</td>
						<td>沈振</td>
						<td>2013-09 至 2014-01</td>
						<td>20</td>
						<td>通过</td>
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