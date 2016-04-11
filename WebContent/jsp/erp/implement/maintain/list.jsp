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
	<jsp:param name="jquery_cxselect" value="true"/>
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
function search() {
	jboxStartLoading();
	$("#searchForm").submit();
}

function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	form.submit();
}

function maintianImplement() {
	window.location.href="<s:url value='/erp/implement/maintianImplement'/>";
}

</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" action="<s:url value="/erp/implement/maintainList" />"	method="post">
				<div style="margin-bottom: 10px">
					客户名称：<input type="text" name="" value="" class="xltext"/>
					区域：<c:if test="${empty param.orgProvId}">
						<span id="provCityAreaId"><select id="orgProvId" name="orgProvId" class="province xlselect" data-value="" data-first-title="选择省"></select>
							<select id="orgCityId" name="orgCityId" class="city xlselect" data-value="" data-first-title="选择市"></select>
							<select id="orgAreaId" name="orgAreaId" class="area xlselect" data-value="" data-first-title="选择地区"></select>
						</span>
					</c:if>
					<c:if test="${not empty param.orgProvId}">
						<span id="provCityAreaId"><select id="orgProvId" name="orgProvId" class="province xlselect" data-value="${param.orgProvId}" data-first-title="选择省"></select>
							<select id="orgCityId" name="orgCityId" class="city xlselect" data-value="${param.orgCityId}" data-first-title="选择市"></select>
							<select id="orgAreaId" name="orgAreaId" class="area xlselect" data-value="${param.orgAreaId}" data-first-title="选择地区"></select>
						</span>
					</c:if>
					<script type="text/javascript">
						// 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件 
						$.cxSelect.defaults.url = "<s:url value='/js/provCityAreaJson.min.json'/>"; 
						$.cxSelect.defaults.nodata = "none"; 

						$("#provCityAreaId").cxSelect({ 
						    selects : ["province", "city", "area"],
						    //selects : ["province"], 
						    nodata : "none",
							firstValue : ""
						}); 
					</script>
				</div>
				<div>
					性&#12288;&#12288;质：<select class="xlselect">
				            	<option value="">请选择</option>
				             	<c:forEach var="clientType" items="${clientTypeEnumList}">
						            <option value="${clientType.id}" >${clientType.name}</option>
						        </c:forEach>
							</select>
					等级：<select class="xlselect">
				            	<option value="">请选择</option>
				             	<c:forEach var="hospitalGrade" items="${dictTypeEnumHospitalGradeList}">
						            <option value="${hospitalGrade.dictId}" >${hospitalGrade.dictName}</option>
						        </c:forEach>
							</select>
					<input type="checkBox" id="base" value="${baseTypeEnumBase.id}"><label for="base">${baseTypeEnumBase.name}</label>&#12288;
					类别：<select class="xlselect" style="width: 100px;">
				            	<option value="">请选择</option>
				             	<c:forEach var="clientCategory" items="${clientCategoryEnumList}">
						            <option value="${clientCategory.id}" >${clientCategory.name}</option>
						        </c:forEach>
							</select>
					联系人：<input type="text" name="" style="width: 100px;" value="" class="xltext"/>
					<input id="currentPage" type="hidden" name="currentPage" value=""/> 
					<input type="button" class="search" onclick="search();" value="查&#12288;询" >
				</div>
				</form>
			</div>			
			<table id="orgTable" class="xllist">
				<colgroup>
					<col width="4%"/>
					<col width="20%"/>
					<col width="15%"/>
					<col width="15%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
				</colgroup>
				<thead>
				<tr>
					<th>序号</th>
					<th>产品名称</th>
					<th>关联合同号</th>
					<th>开始日期</th>
					<th>免费维护</th>
					<th>续费维护</th>
					<th>脱保维护</th>
					<th>操作</th>
				</tr>
				</thead>						
				<tbody>
				<tr>
					<th colspan="8" style="text-align: left;padding-left: 10px;">客户名称：苏州卫生局</th>
				</tr>
				<tr>
					<td>1</td>
					<td><a href="javascript:maintianImplement();">住院医师系统</a></td>
					<td>SZDYYY-005</td>
					<td>2014-05-10</td>
					<td>25</td>
					<td>3</td>
					<td>1</td>
					<td>[<a href="javascript:maintianImplement();">执行情况</a>]</td>
				</tr>
				<tr>
					<td>2</td>
					<td><a href="javascript:maintianImplement();">考试系统</a></td>
					<td>SZWSJ-001，SZWSJ-002</td>
					<td>2014-06-02</td>
					<td>18</td>
					<td>1</td>
					<td>2</td>
					<td>[<a href="javascript:maintianImplement();">执行情况</a>]</td>
				</tr>
				<tr>
					<td>3</td>
					<td><a href="javascript:maintianImplement();">数据采集系统</a></td>
					<td>NJYKDX-006</td>
					<td>2014-09-10</td>
					<td>30</td>
					<td>5</td>
					<td>2</td>
					<td>[<a href="javascript:maintianImplement();">执行情况</a>]</td>
				</tr>
				<tr>
					<th colspan="8" style="text-align: left;padding-left: 10px;">客户名称：南京医科大学</th>
				</tr>
				<tr>
					<td>1</td>
					<td><a href="javascript:maintianImplement();">考试系统</a></td>
					<td>SZWSJ-001，SZWSJ-002</td>
					<td>2014-02-16</td>
					<td>21</td>
					<td>1</td>
					<td>2</td>
					<td>[<a href="javascript:maintianImplement();">执行情况</a>]</td>
				</tr>
				<tr>
					<td>2</td>
					<td><a href="javascript:maintianImplement();">数据采集系统</a></td>
					<td>NJYKDX-006</td>
					<td>2014-08-25</td>
					<td>8</td>
					<td>0</td>
					<td>0</td>
					<td>[<a href="javascript:maintianImplement();">执行情况</a>]</td>
				</tr>
				</tbody>
			</table>
			<c:set var="pageView" value="${pdfn:getPageView(clientList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>			
	</div>
</div>
</body>
</html>