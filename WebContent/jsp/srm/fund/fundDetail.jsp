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
	<jsp:param name="jquery_validation" value="false"/>
	<jsp:param name="jquery_datePicker" value="false"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="false"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<style type="text/css">
	.xllist td,.xllist th{text-align: left;padding-left: 15px;}
	.xllist td span{font-weight: bold;color:#333;font-size: 13px;}
	table{margin-bottom: 10px;}
</style>
</head>
<body>
    <div id="main">
        <div class="mainright">
            <div class="content">
            <div class="title1 clearfix">
                    <div>
			   	        <table class="xllist nofix">
			   		        <tr><th colspan="4" style="font-size: 14px;">项目信息</th></tr>
					        <tr>
			        	        <td><span>项目名称：</span>${fundExt.project.projName}</td>
			                    <td><span>年&#12288;份：</span>${fundExt.project.projYear}</td>
			                    <td colspan="2"><span>项目类型：</span>${fundExt.project.projTypeName}</td>
			                </tr>
					        <tr>
			        	        <td><span>承担单位：</span>${fundExt.project.applyOrgName}</td>
			                    <td><span>负责人：</span>${fundExt.project.applyUserName}</td>
			                    <td colspan="2"><span>起止日期：</span>${fundExt.project.projStartTime}~${fundExt.project.projEndTime}</td>
			                </tr>
			                <tr>
			                    <td><span>项目编号：</span>${fundExt.project.projNo}</td>
			                    <td><span>经费方案：</span>${fundExt.fundScheme.schemeName}</td>
			                    <td colspan="2"></td>
			                </tr>
				        </table>
	   		        </div>
	   		    </div>
            
                <p style="padding-top: 15px; padding-bottom:10px; font-weight: bold;">支出费用：</p>
                <table class="xllist">
  	                <thead>
                        <tr>
                            <th>报销项目</th>
                            <th>预算金额(万元)</th>
                            <th>报销金额(万元)</th>
                            <th>报销时间</th>
                            <th>报销内容</th>
                        </tr>
                    </thead>
     	            <c:forEach items="${fundExt.alaimList}" var="alaimExt">
                        <tr>
                            <td>${alaimExt.item.itemName}</td>
                            <td><c:forEach items="${fundExt.budgetList}" var="budget"><c:if test="${budget.itemFlow==alaimExt.fundDetail.itemFlow }">${budget.money}</c:if></c:forEach></td>
                            <td>${alaimExt.fundDetail.money}</td>
                            <td>${pdfn:transDateTime(alaimExt.fundDetail.provideDateTime)}</td>
                            <td>${alaimExt.fundDetail.content}</td>
                        </tr>
                    </c:forEach>
                </table>
                <p align="center" style="width:100%;padding-top: 10px;">
  	                <input class="search" type="button" value="关&#12288;闭"  onclick="jboxClose();" />
                </p>
 	<%-- <c:set var="pageView" value="${pdfn:getPageView(reseachrepList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/> --%>
            </div>
        </div> 	
    </div>
</body>
</html>