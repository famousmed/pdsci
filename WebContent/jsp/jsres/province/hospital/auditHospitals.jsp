<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	function toPage(page) {
		if(!page){
			page = 1;
		}
		$("#currentPage").val(page);
		searchBase();
		jboxEndLoading();
	} 
	function getInfo(baseFlow){
		var url =  "<s:url value='/jsres/base/hospitalMain'/>?auditFlag=${GlobalConstant.FLAG_Y}&baseFlow="+baseFlow;
		jboxOpen(url ,"基地审核",1100,550);
	}
	function searchBase(baseFlow){
		var url =  "<s:url value='/jsres/base/findBaseInfo?auditFlag=${GlobalConstant.FLAG_Y}'/>";
		jboxPostLoad(url , $("#searchForm").serialize(), false);
	}
</script>

<div class="main_bd" id="div_table_0" >
	<div class="div_search">
<%-- 	<c:if test="${param.source != 'city' }"> --%>
<!-- 		地&#12288;&#12288;区： -->
<!--       	<select class="select" style="width: 106px;"> -->
<!-- 		    <option value="">全部</option> -->
<!-- 		    <option value="">南京市</option> -->
<!-- 		    <option value="">无锡市</option> -->
<!-- 	    </select>&#12288;&#12288; -->
<%-- 	    </c:if> --%>
		<form id="searchForm">
		 <input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage}"/>
		基地名称：<input type="text" class="input" style="width: 150px;"name="orgName" value="${param.orgName}"/>&#12288;&#12288;
<!-- 		审核类型： -->
<!-- 		<select class="select" style="width: 106px;" name="baseStatusName"> -->
<!-- 			<option value="">全部</option> -->
<%-- 		    <option value="登记审核" <c:if test="${param. baseStatusName eq '登记审核'}">selected="selected"</c:if>>登记审核</option> --%>
<%-- 		    <option value="变更审核" <c:if test="${param. baseStatusName eq '变更审核'}">selected="selected"</c:if>>变更审核</option> --%>
<!-- 	    </select>&#12288;&#12288; -->
	    <input class="btn_green"  onclick="searchBase(); "type="button" value="查询"/>
	    </form>
    </div>
    <div class="search_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
        	<colgroup>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        	</colgroup>
            <tr>
                <th>培训基地</th>
                <th>审核类型</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${resBaseExtList }" var="res">
             <tr>
                <td>${res.sysOrg.orgName}</td>
                <td>${res.baseStatusName}</td>
                <td><a class="btn" onclick="getInfo(${res.orgFlow});">审核</a></td>
            </tr>
            </c:forEach>
            <c:if test="${ empty resBaseExtList }">
            	<tr><td colspan="5">无记录</td></tr>
            </c:if>
        </table>
    </div>	
     <div class="page" style="padding-right: 40px;">
           	<c:set var="pageView" value="${pdfn:getPageView2(resBaseExtList, 10)}" scope="request"/>
	  		 <pd:pagination-hbres toPage="toPage"/>	 
        </div>
</div>
      
