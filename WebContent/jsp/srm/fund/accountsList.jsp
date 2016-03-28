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
function editItem(fundFlow , projFlow){
	var w = $('#mainright').width();
	var h = $('#mainright').height();
	var url =rootPath()+'/srm/fund/details?fundFlow='+fundFlow+"&projFlow="+projFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='400px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'经费到账编辑',w , 400);

}
</script>
</head>
<body onload="font()">

 <div class="mainright" id="mainright">
    <div class="content">
      <div class="title1 clearfix">
		  <form id="searchForm" action="<s:url value="/srm/fund/accountsList/${sessionScope.projListScope}"/>" method="post">
			<p>
		 		项目名称：
		 		<input type="text" name="projName" value="${param.projName}" class="xltext"/>
		 	&#12288;项目类型：
				<select name="projTypeId"  class="xlselect">
                <option value="">请选择</option>
	                <c:forEach items="${dictTypeEnumProjTypeList }" var="dict">
	                	<option value="${dict.dictId }" <c:if test="${dict.dictId==param.projTypeId}">selected="selected"</c:if> >${dict.dictName }</option>
	                </c:forEach>
                </select><%-- <br><br>
                                                科&#12288;&#12288;室：
				<select name="projSourceId" class="xlselect">
                <option value="">请选择</option>
	                <c:forEach items="${dictTypeEnumProjSourceList }" var="dict">
	                	<option value="${dict.dictId }" <c:if test="${dict.dictId==param.projSourceId}">selected="selected"</c:if> >${dict.dictName }</option>
	                </c:forEach>
                </select>
                &#12288; --%>
                <c:if test="${sessionScope.projListScope=='local'}" >
                &#12288;负责人：
		 		<input type="text" name="applyUserName" value="${param.applyUserName}" class="xltext"/>
		 		</c:if>
				<input id="currentPage" type="hidden" name="currentPage" value=""/>
				<input type="button" class="search" onclick="search();" value="查询">
			</p>
		  </form>
	  </div>

  <table class="xllist">
  	<thead>
         <tr>
            <th>项目名称</th>
            <th width="150px;">项目类型</th>
            <th width="100px;">负责人</th>
            <th width="100px;">项目开始时间</th>
            <th width="100px;">项目结束时间</th>
            <!-- <th width="8%">下拨金额</th> -->
            <!-- <th width="8%">配套金额</th> -->
            <th width="60px;">预算总额(万元)</th>
            <th width="80px;">下拨到账金额(万元)</th>
            <th width="80px;">配套到账金额(万元)</th>
            <th width="80px">到账总金额(万元)</th>
            <th width="60px">到账余额(万元)</th>
            <c:if test="${sessionScope.projListScope=='local'}" ><th width="80px;">操作</th></c:if>
         </tr>
     </thead>
      <c:forEach items="${funds}" var="fundExt">
      <tr>
	      <td>${fundExt.project.projName}</td>
	       <td>${fundExt.project.projTypeName}</td>
	      <td>${fundExt.project.applyUserName}</td>
	      <td>${fundExt.project.projStartTime}</td>
	      <td>${fundExt.project.projEndTime}</td>
	      <!-- <td>${fundExt.fund.goveFund}</td> -->
	      <!-- <td>${fundExt.fund.orgFund}</td> -->
	      <td>${fundExt.fund.budgetAmount}</td>
	      <td>${fundExt.fund.realityGoveAmount}</td>
	      <td>${fundExt.fund.realityOrgAmount}</td>
	      <td>${fundExt.fund.realityAmount}</td>
	      <td>${fundExt.fund.realityBalance}</td>
	      <c:if test="${sessionScope.projListScope=='local'}" ><td><a href="javascript:void(0)" onclick="editItem('${fundExt.fund.fundFlow}' , '${fundExt.fund.projFlow}')">编辑</a><%-- <c:if test="${sessionScope.projListScope!='local'}" ><a href="javascript:void(0)" onclick="">[查看]</a></c:if> --%></td></c:if>
      </tr>
      </c:forEach>
  </table>
<%--  	<c:set var="pageView" value="${pdfn:getPageView(funds)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>
     </div> --%>
  </div> 	
</div>
</body>
</html>