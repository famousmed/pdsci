<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

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
function doAudit(fundDetailFlow) {
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/payment/audit?fundDetailFlow='/>"+fundDetailFlow, "审核", 750, 600);
}

function search(){
	jboxStartLoading();
	$('#searchForm').submit();
}

</script>
</head>
<body>
<div class="mainright" id="mainright">
   <div class="content">
       <div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/srm/payment/auditList"/>" method="post">
			<p>
                                                项目名称：	
			    <input class="xltext" style="width: 120px" name="proj.projName" type="text" value="${fundDetailExt.proj.projName}"/>
			    &#12288;项目类型：
			    <select name="proj.projTypeId"  class="xlselect">
                    <option value="">请选择</option>
	                <c:forEach items="${dictTypeEnumProjTypeList }" var="dict">
	                	<option value="${dict.dictId }" <c:if test="${dict.dictId==fundDetailExt.proj.projTypeId}">selected="selected"</c:if> >${dict.dictName }</option>
	                </c:forEach>
                </select>
			</p>
			<p>
			&#12288;负责人：	
			<input class="xltext" style="width: 120px" name="proj.applyUserName" type="text" value="${fundDetailExt.proj.applyUserName}"/>
			<!-- 
			&#12288;&#12288;科室：	
			<input class="xltext" style="width: 120px" name="" type="text" value=""/> -->
			&#12288;报销时间：	
			<input onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 160px;" class="ctime" name="provideDateTime" type="text"  />
			&#12288;审核状态：
			<select name="operStatusId"  class="xlselect" style="width:100px;">
               <option value="">全部</option>
               <option value="${achStatusEnumSubmit.id}" <c:if test="${achStatusEnumSubmit.id==param.operStatusId}">selected="selected"</c:if> >${achStatusEnumSubmit.name }</option>
               <option value="${achStatusEnumFirstAudit.id}" <c:if test="${achStatusEnumFirstAudit.id==param.operStatusId}">selected="selected"</c:if> >${achStatusEnumFirstAudit.name }</option>
               </select>
			&#12288;
			<input class="search" type="button" value="查询" onclick="search()"/>
			</p>
			</form>
        </div>
        
		<table class="xllist">
		<tr>
			<th width="300px;">项目名称</th>
			<th width="100px;">项目类型</th>
			<th width="80px;">负责人</th>
			<th width="90px;">报销项目</th>
			<th width="60px;">预算金额(万元)</th>
			<th width="60px;">报销金额(万元)</th>
			<th width="60px;">到账总额(万元)</th>
			<th width="60px;">到账余额(万元)</th>
			<th>报销内容</th>
			<th width="100px;">报销时间</th>
			<th width="80px;">审核状态</th>
			<th width="60px;">操作</th>
		</tr>
		
		<c:forEach items="${fundDetailList}" var="detail">
		<tr>
			<td>${detail.proj.projName}</td>
			<td>${detail.proj.projTypeName}</td>
			<td>${detail.proj.applyUserName}</td>
			<td>${detail.schemeDetail.itemName }</td>
			<td>${budgetMap[detail.fundDetailFlow].money}</td>
			<td class="money">${detail.money}</td>
			<td>${detail.projFundInfo.realityAmount}</td>
			<td>${detail.projFundInfo.realityBalance}</td>
			<td>${detail.content}</td>
			<td>${pdfn:transDateTime(detail.provideDateTime)}</td>
			<td>${detail.operStatusName}</td>
			<td>
				<c:if test="${detail.operStatusId==achStatusEnumSubmit.id}"><a href="javascript:void(0)" onclick="doAudit('${detail.fundDetailFlow}');">审核</a></c:if>
			</td>
		</tr>
		
		</c:forEach>
		</table>
		<p align="right" style="margin-top: 20px;">
		<b style="color: red;padding-right: 50px;">已报销总计：<span id="total">${total}</span>万元</b>
		</p>
   </div> 	
 </div>
</body>
</html>