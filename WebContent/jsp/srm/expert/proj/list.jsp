<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
</jsp:include>
<script type="text/javascript">
	function score(expertProjFlow){
		window.location.href="<s:url value='/srm/expert/proj/score'/>?expertProjFlow="+expertProjFlow;
	}
</script>

<body>
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
        	<form id="searchForm" method="post" action="<s:url value='/srm/expert/proj/list'/>"> 
            	<p>项目名称：<input type="text" name="pjName" value="${param.pjName}" class="xltext" style="width:522px"/></p>
            	<p>评分状态：
                	<input type="radio" name="scoreType" value="${GlobalConstant.FLAG_N }"  id="radio0"  <c:if test="${param.scoreType==GlobalConstant.FLAG_N }">checked</c:if> /><label for="radio0">未评分</label>&#12288;
                    <input type="radio"  name="scoreType" value="${GlobalConstant.FLAG_Y }" id="radio1" <c:if test="${param.scoreType==GlobalConstant.FLAG_Y }">checked</c:if> /><label for="radio1">已评分</label>&#12288;
                    <input type="radio" name="scoreType" value="" id="radioAll"  <c:if test="${empty param.scoreType }">checked</c:if> /><label for="radioAll">全部</label>&#12288;
                    <input class="search" type="submit" value="查 询" />
            </form>
        </div>
        <table class="xllist">
	        <thead>
	            <tr>
                	<th width="5%">序号</th>
                	<th width="10%">评审类型</th>
                    <th width="30%">项目名称</th>
                    <th width="20%">承担单位</th>
                    <th width="8%">评分结果</th>
                    <th width="8%">项目信息</th>
                    <th width="8%">评分</th>
                </tr>
	        </thead>
            <tbody>
                <c:forEach items="${expertProjList}"  var="expertProj" varStatus="status">
	                <tr>
	                    <td><span >${status.count}</span></td>
	                    <td>${expertProj.srmExpertGroupProjExt.srmGradeScheme.evaluationName}</td>
	                    <td >${expertProj.pubProj.projName }</td>
	                    <td >${expertProj.pubProj.applyOrgName}</td>
	                    <td class="xlming">
	                    	<c:if test="${!empty expertProj.scoreTotal}">
	                    	评审得分：${expertProj.scoreTotal }<br/>
	                    	评审结果：${expertProj.scoreResultName}
	                    	</c:if>
	                    </td>
	                    <td ><a href="<s:url value='/srm/proj/mine/auditProjView?projFlow=${expertProj.projFlow}'/>&expertFlag=Y" target="_blank">【查看项目】</a></td>
	                    <td ><a href="javascript:score('${expertProj.expertProjFlow}');" >评分</a></td>
	                </tr>
                </c:forEach>
            </tbody>
        </table>   
     </div> 	
   </div>
   
</body>

</html>
