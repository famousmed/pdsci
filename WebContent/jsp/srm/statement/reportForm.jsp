<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<jsp:param name="jquery_validation" value="false"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
function searchProj() {
	jboxStartLoading();
	$("#searchForm").submit();
}
</script>
</head>
<body>
<div id="main">
    <div class="mainright">
	    <div class="content">
	        <div class="title1 clearfix">
	            <form id="searchForm" action="<s:url value="/srm/statement/list" />" method="post">
                    <p>
                                                                        年&#12288;&#12288;份：
              	        <input type="text" class="xltext ctime" name="projYear" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})" value="${param.projYear }"/>
          		                        项目类型：
          		  	    <select class="xlselect" name="projTypeId">
          		  		    <option value="">请选择</option>
                       	    <c:forEach var="dictEnuProjType" items="${dictTypeEnumProjTypeList}">
                       		    <option value="${dictEnuProjType.dictId}" <c:if test='${param.projTypeId==dictEnuProjType.dictId}'>selected="selected"</c:if>>${dictEnuProjType.dictName}</option>
                       	    </c:forEach>
          		  	    </select>
                                                                        主管部门：
                        <select id="chargeOrg" name="chargeOrgFlow" class="xlselect">
            	            <option value="">请选择</option>
            		        <c:forEach var="chargeOrg" items="${chargeOrgList}">
            		            <option value="${chargeOrg.orgFlow}" <c:if test="${param.chargeOrgFlow==chargeOrg.orgFlow}">selected</c:if>>${chargeOrg.orgName}</option>
            		        </c:forEach>
            	        </select>
                        <input type="button" class="search" onclick="searchProj();" value="查&#12288;询"> 
                    </p>   
                </form>
            </div>
	        
	        <table width="100%" class="xllist">
	            <thead>
	                <tr>
	                    <th >机构名称</th>
	                    <th width="14%">申报项目数量</th>
	                    <th width="14%">申报审核通过项目数量</th>
	                    <th width="14%">立项数量</th>
	                    <th width="14%">未立项数量</th>
	                    <th width="14%">立项比例(%)</th>
	                </tr>
	            </thead>
	            <tbody>
	                <c:set var="sumApplyCount" value="0"/>
	                <c:set var="sumEvalCount" value="0"/>
	                <c:set var="sumApproveCount" value="0"/>
	                <c:set var="sumNotApproveCount" value="0"/>
	                <c:forEach var="report" items="${reportForms}">
                        <tr>
                            <td>${report.orgName}</td>
                            <td>${report.applyCount}</td>
                            <c:set var="sumApplyCount" value="${sumApplyCount+report.applyCount}"/>
                            <td>${report.evalCount}</td>
                            <c:set var="sumEvalCount" value="${sumEvalCount+report.evalCount}"/>
                            <td>${report.approveCount}</td>
                            <c:set var="sumApproveCount" value="${sumApproveCount+report.approveCount}"/>
                            <td>${report.notApproveCount}</td>
                            <c:set var="sumNotApproveCount" value="${sumNotApproveCount+report.notApproveCount}"/>
                            <td>${pdfn:getPercent(report.approveCount , report.evalCount)}</td>
                        </tr>	           
	                </c:forEach>
	                <tr>
	                    <td style="color: red;">总计</td>
                        <td style="color: red;">${sumApplyCount}</td>
                        <td style="color: red;">${sumEvalCount}</td>
                        <td style="color: red;">${sumApproveCount}</td>
                        <td style="color: red;">${sumNotApproveCount}</td>
                        <td></td>
	                </tr>
	            </tbody>
	        </table> 
	    </div>
	</div>
</div>
</body>
</html>