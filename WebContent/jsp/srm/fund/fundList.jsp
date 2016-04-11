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
function font(){
	$("td").css("font-size","12px");
}
var height=(window.screen.height)*0.7;
var width=(window.screen.width)*0.7;
function search() {
	jboxStartLoading();
	$("#searchForm").submit();
}
function toPage(page) {
	if(page!=undefined){
		$("#currentPage").val(page);			
	}
	search();
}
function showDetail(fundFlow){
	jboxStartLoading();
	jboxOpen(rootPath()+"/srm/fund/getDetail?fundFlow="+fundFlow, "经费支出信息", width, height);
}
</script>
</head>
<body onload="font()">
    <div class="mainright">
        <div class="content">
            <div class="title1 clearfix">
		        <form id="searchForm" action="<s:url value="/srm/fund/list/${sessionScope.projListScope}"/>" method="post">
			        <p>
		 		                        项目名称：<input type="text" name="projName" value="${param.projName}" class="xltext"/>
				 		<%-- &#12288;项目来源：
						<select name="projSourceId" class="xlselect">
		                <option value="">请选择</option>
			                <c:forEach items="${dictTypeEnumProjSourceList }" var="dict">
			                	<option value="${dict.dictId }" <c:if test="${dict.dictId==param.projSourceId}">selected="selected"</c:if> >${dict.dictName }</option>
			                </c:forEach>
		                </select> --%>
		                <c:if test="${sessionScope.projListScope=='local'}" >
		                &#12288;负责人：
				 		<input type="text" name="applyUserName" value="${param.applyUserName}" class="xltext"/>
				 		</c:if>
				 		<%--  科&#12288;&#12288;室：
						<select name="projSourceId" class="xlselect">
		                <option value="">请选择</option>
			                <c:forEach items="${dictTypeEnumProjSourceList }" var="dict">
			                	<option value="${dict.dictId }" <c:if test="${dict.dictId==param.projSourceId}">selected="selected"</c:if> >${dict.dictName }</option>
			                </c:forEach>
		                </select> --%>
		                <%--   &#12288;报销时间：
				 		<input class="xltext ctime" type="text" name="submitDate" value="${param.submitDate}"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  readonly="readonly"/> --%>
				 		<%--  &#12288;&#12288;审核状态：
						<select name="projSourceId" class="xlselect">
		                <option value="">请选择</option>
			                <c:forEach items="${dictTypeEnumProjSourceList }" var="dict">
			                	<option value="${dict.dictId }" <c:if test="${dict.dictId==param.projSourceId}">selected="selected"</c:if> >${dict.dictName }</option>
			                </c:forEach>
		                </select> --%>
				        <input id="currentPage" type="hidden" name="currentPage" value=""/>
				        <input type="button" class="search" onclick="search();" value="查&nbsp;&nbsp;询">
			        </p>
		        </form>
	        </div>
            <table class="xllist">
  	            <thead>
                    <tr>
                        <th>项目名称</th>
                        <th style="width:150px;">项目编号</th>
                        <th style="width:150px;">项目类型</th>
                        <c:if test="${sessionScope.projListScope=='local'}" ><th style="width:80px;">负责人</th></c:if>
                        <th style="width:80px;">预算总经费(万元)</th>
                        <th style="width:80px;">下拨到账金额(万元)</th>
                        <th style="width:80px;">配套到账金额(万元)</th>
                        <th style="width:80px;">到账(万元)</th>
                        <th style="width:80px;">支出(万元)</th>
                        <th style="width:80px;">剩余(万元)</th>
                        <th style="width:80px;">操作</th>
                    </tr>
                </thead>
                <c:forEach items="${funds}" var="fundExt">
	                <tr>
		                <td>${fundExt.project.projName}</td>
		                <td>${fundExt.project.projNo}</td>
		                <td>${fundExt.project.projTypeName}</td>
		                <c:if test="${sessionScope.projListScope=='local'}" ><td>${fundExt.project.applyUserName}</td></c:if>
		                <td>${fundExt.fund.budgetAmount}</td>
		                <td>${fundExt.fund.realityGoveAmount}</td>
		                <td>${fundExt.fund.realityOrgAmount}</td>
		                <td>${fundExt.fund.realityAmount}</td>
		                <td>${fundExt.fund.yetPaymentAmount}</td>
		                <td>${fundExt.fund.realityBalance}</td>
		                <td><a href="javascript:void(0)" onclick="showDetail('${fundExt.fund.fundFlow}')" >查看</a></td>
	                </tr>
                </c:forEach>
                <tr>
                    <td colspan="<c:if test="${sessionScope.projListScope=='local'}" >4</c:if><c:if test="${sessionScope.projListScope!='local'}" >3</c:if>" style="color: red;">合计</td>
                    <td style="color: red;">${fundSum.amountFundSum }</td>
                    <td style="color: red;">${fundSum.goveFundSum }</td>
                    <td style="color: red;">${fundSum.orgFundSum }</td>
                    <td style="color: red;">${fundSum.realityAmountSum }</td>
                    <td style="color: red;">${fundSum.yetPaymentAmountSum }</td>
                    <td style="color: red;">${fundSum.realityBalanceSum }</td>
                    <td></td>
                    
                </tr>
            </table>
 	<%-- <c:set var="pageView" value="${pdfn:getPageView(reseachrepList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/> --%>
        </div>
    </div> 	
</body>
</html>