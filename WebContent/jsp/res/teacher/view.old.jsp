<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/res/teacher/Style.css'/>"></link>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
</jsp:include>
	<style type="text/css">
        body
        {
            text-align: left;
        }
        a
        {
            color: #2485b2;
        }
        a:link
        {
            color: #2485b2;
        }
        a:visited 
        {
        	color: #2485b2;
        }
        .ablue
        {
            color: #2485b2;
            font-size: 12px;
            font-weight: normal;
            margin-left: 10px;
        }
        .ui-widget-header {
	        border: 1px solid #D8D7D8;
	        background: #62B32B url(images/ui-bg_highlight-soft_75_cccccc_1x100.png) 50% 50% repeat-x;
	        color: #ffffff;
	        font-weight: bold;
        }
        .ui-widget-content {
	        border: 1px solid #D8D7D8;
	        background: #ffffff url(images/ui-bg_flat_75_ffffff_40x100.png) 50% 50% repeat-x;
	        color: #222222;
        }
  
</style>
<script type="text/javascript">
	
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div id="contain" style="min-width:1000px;">
        
        <div  id="tagContent" class="divContent" style="padding-bottom: 20px;">
            <div id="title">
                <span id="SpanLunZhuangKeShi"><B>审核情况</B></span></div>
            <div id="contable" style="padding: 10px 0 0 10px;">
                <table border="0" class="table2" style="width: 100%;">
	                <tbody>
	                <c:if test="${roleFlag ==GlobalConstant.RES_ROLE_SCOPE_TEACHER}"> 
	                      <tr>
	                        <td  style="width:70px;text-align: right;">大 病 历：</td>
	                        <td>有（<span id="lbSecName"><c:choose><c:when test="${countMap[resRecTypeEnumCaseRegistry.id] > 0 }"><a href="<s:url value='/res/teacher/auditList'/>?roleFlag=${roleFlag}&recTypeId=${resRecTypeEnumCaseRegistry.id}">${countMap[resRecTypeEnumCaseRegistry.id] }</a></c:when><c:otherwise>0</c:otherwise></c:choose></span>）条数据未审核<c:if test="${countMap[resRecTypeEnumCaseRegistry.id] > 0 }">&#12288;&#12288;[<a href="<s:url value='/res/teacher/auditList'/>?roleFlag=${roleFlag}&recTypeId=${resRecTypeEnumCaseRegistry.id}">审核</a>]</c:if></td>
	                        <td  style="width:70px;text-align: right;">病&#12288;种：</td>
	                        <td>有（<span id="lbSecName"><c:choose><c:when test="${countMap[resRecTypeEnumDiseaseRegistry.id] > 0 }"><a href="<s:url value='/res/teacher/auditList'/>?roleFlag=${roleFlag}&recTypeId=${resRecTypeEnumDiseaseRegistry.id}">${countMap[resRecTypeEnumDiseaseRegistry.id] }</a></c:when><c:otherwise>0</c:otherwise></c:choose></span>）条数据未审核<c:if test="${countMap[resRecTypeEnumDiseaseRegistry.id] > 0 }">&#12288;&#12288;[<a href="<s:url value='/res/teacher/auditList'/>?roleFlag=${roleFlag}&recTypeId=${resRecTypeEnumDiseaseRegistry.id}">审核</a>]</c:if></td>
	                    </tr>
	                    <tr>
	                        <td  style="width:70px;text-align: right;">操作技能：</td>
	                        <td>有（<span id="lbSecName"><c:choose><c:when test="${countMap[resRecTypeEnumSkillRegistry.id] > 0 }"><a href="<s:url value='/res/teacher/auditList'/>?roleFlag=${roleFlag}&recTypeId=${resRecTypeEnumSkillRegistry.id}">${countMap[resRecTypeEnumSkillRegistry.id] }</a></c:when><c:otherwise>0</c:otherwise></c:choose></span>）条数据未审核<c:if test="${countMap[resRecTypeEnumSkillRegistry.id] > 0 }">&#12288;&#12288;[<a href="<s:url value='/res/teacher/auditList'/>?roleFlag=${roleFlag}&recTypeId=${resRecTypeEnumSkillRegistry.id}">审核</a>]</c:if></td>
	                        <td  style="width:70px;text-align: right;">手&#12288;术：</td>
	                        <td>有（<span id="lbSecName"><c:choose><c:when test="${countMap[resRecTypeEnumOperationRegistry.id] > 0 }"><a href="<s:url value='/res/teacher/auditList'/>?roleFlag=${roleFlag}&recTypeId=${resRecTypeEnumOperationRegistry.id}">${countMap[resRecTypeEnumOperationRegistry.id] }</a></c:when><c:otherwise>0</c:otherwise></c:choose></span>）条数据未审核<c:if test="${countMap[resRecTypeEnumOperationRegistry.id] > 0 }">&#12288;&#12288;[<a href="<s:url value='/res/teacher/auditList'/>?roleFlag=${roleFlag}&recTypeId=${resRecTypeEnumOperationRegistry.id}">审核</a>]</c:if></td>
	                    </tr>
	                    <tr>
	                        <td  style="width:70px;text-align: right;">参加活动：</td>
	                        <td>有（<span id="lbSecName"><c:choose><c:when test="${countMap[resRecTypeEnumCampaignRegistry.id] > 0 }"><a href="<s:url value='/res/teacher/auditList'/>?roleFlag=${roleFlag}&recTypeId=${resRecTypeEnumCampaignRegistry.id}">${countMap[resRecTypeEnumCampaignRegistry.id] }</a></c:when><c:otherwise>0</c:otherwise></c:choose></span>）条数据未审核<c:if test="${countMap[resRecTypeEnumCampaignRegistry.id] > 0 }">&#12288;&#12288;[<a href="<s:url value='/res/teacher/auditList'/>?roleFlag=${roleFlag}&recTypeId=${resRecTypeEnumCampaignRegistry.id}">审核</a>]</c:if></td>
	                        <td  style="width:70px;text-align: right;">培训数据：</td>
	                        <td>有（<span id="lbSecName"><c:choose><c:when test="${countMap[resRecTypeEnumTrainData.id] > 0 }"><a href="<s:url value='/res/teacher/auditList'/>?roleFlag=${roleFlag}&recTypeId=${resRecTypeEnumTrainData.id}">${countMap[resRecTypeEnumTrainData.id] }</a></c:when><c:otherwise>0</c:otherwise></c:choose></span>）条数据未审核<c:if test="${countMap[resRecTypeEnumTrainData.id] > 0 }">&#12288;&#12288;[<a href="<s:url value='/res/teacher/auditList'/>?roleFlag=${roleFlag}&recTypeId=${resRecTypeEnumTrainData.id}">审核</a>]</c:if></td>
	                    </tr>
	                   
	                    </c:if>
	                    <tr>
	                        <td  style="width:70px;text-align: right;">出科小结：</td>
	                        <td>有（<span id="lbSecName"><c:choose><c:when test="${countMap[resRecTypeEnumAfterSummary.id] > 0 }"><a href="<s:url value='/res/teacher/auditList'/>?roleFlag=${roleFlag}&recTypeId=${resRecTypeEnumAfterSummary.id}">${countMap[resRecTypeEnumAfterSummary.id] }</a></c:when><c:otherwise>0</c:otherwise></c:choose></span>）条数据未审核<c:if test="${countMap[resRecTypeEnumAfterSummary.id] > 0 }">&#12288;&#12288;[<a href="<s:url value='/res/teacher/auditList'/>?roleFlag=${roleFlag}&recTypeId=${resRecTypeEnumAfterSummary.id}">审核</a>]</c:if></td>
	                        <td  style="width:100px;text-align: right;">出科考核表：</td>
	                        <td>有（<span id="lbSecName"><c:choose><c:when test="${countMap[resRecTypeEnumAfterEvaluation.id] > 0 }"><a href="<s:url value='/res/teacher/auditList'/>?roleFlag=${roleFlag}&recTypeId=${resRecTypeEnumAfterEvaluation.id}">${countMap[resRecTypeEnumAfterEvaluation.id] }</a></c:when><c:otherwise>0</c:otherwise></c:choose></span>）条数据未审核<c:if test="${countMap[resRecTypeEnumAfterEvaluation.id] > 0 }">&#12288;&#12288;[<a href="<s:url value='/res/teacher/auditList'/>?roleFlag=${roleFlag}&recTypeId=${resRecTypeEnumAfterEvaluation.id}">审核</a>]</c:if></td>
	                    </tr>
	                </tbody>
                </table>
            </div>
            <div id="title">即将出科人员名单</div>
            <div id="contable" >
                <table class="table2" >
	                <tbody>
	                	<tr>
		                	<c:forEach items="${recExtList}" var="recExt" varStatus="status">
		                    	<td style="width:70px; text-align: right;"><a href="<s:url value='/res/teacher/audit/${roleFlag}'/>?doctorFlow=${recExt.operUserFlow}">${recExt.operUserName}</a></td>
		                    	<td>(${recExt.process.startDate} ~ ${recExt.process.endDate})</td>
		                		<c:if test="${status.count % 3 == 0}">
		                			</tr><tr>
		                		</c:if>
		                	</c:forEach>
	                	</tr>
	                </tbody>
                </table>
            </div>
            <div style="padding:15px 0 0 18px;">注：<span style="color:#2485b2;">蓝名</span>表示该研究生有待审核数据，点击审核。</div>
        </div>
    </div>
	</div>
</div>
</div>
</body>
</html>