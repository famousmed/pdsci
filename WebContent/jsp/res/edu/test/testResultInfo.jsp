<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="compatible" value="false"/>
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
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
	<jsp:param name="jquery_ztree" value="false"/>
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<script type="text/javascript">
function toPage(page){
	$("#currentPage").val(page);
	search();
}
function search(){
	var form = $("#searchForm");
	form.submit();
}
</script>
</head>
<body>
    <div class="mainright">
	 <div class="content">
	     <div class="title1 clearfix">
	         <form id="searchForm" action="<s:url value='/resedu/manage/course/testResultInfo'/>" method="post">
	            <input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage }"/>
	            <input type="hidden" name="paperFlow" value="${param.paperFlow }"/>
	            <div style="margin-bottom: 10px;margin-right: 10px;">
	                                              考生姓名：<input type="text" name="userName" class="xltext" style="width:120px;" value="${param.userName }"/>
	                                              是否及格：<select name="passFlag" style="width:100px;">
	                          <option value="">请选择</option>
	                          <option value="Y" <c:if test="${param.passFlag eq 'Y'}">selected</c:if>>是</option>  
	                          <option value="N" <c:if test="${param.passFlag eq 'N'}">selected</c:if>>否</option>                    
	                      </select>
	               <input type="button" class="search" onclick="search();" value="查&#12288;询">
	            </div>
	         </form>
	          <table class="xllist" style="width: 100%;margin-top: 10px;">
	           <colgroup>
   		         <col width="25%"/>
   		         <col width="25%"/>
   		         <col width="25%"/>
   		         <col width="25%"/>
   		       </colgroup>
	             <thead>
	                <tr>
	                  <th>考生姓名</th>
	                  <th>考试成绩</th>
	                  <th>是否及格</th>
	                  <th>考试时间</th>
	                </tr>
	             </thead>
	             <tbody>
	             <c:forEach items="${results }" var="result">
	               <tr>
	                <td>${result.userName }</td>
	                <td>${result.totleScore }</td>
	                <td>
	                  <c:if test="${result.passFlag eq 'Y' }">是</c:if>
	                  <c:if test="${result.passFlag eq 'N' }">否</c:if>
	                </td>
	                <td>${pdfn:transDateTimeForPattern(result.testTime,"yyyyMMddHHmmss","yyyy-MM-dd HH:mm:ss") }</td>
	               </tr> 
	               </c:forEach>
	               <c:if test="${empty results }">
	                 <tr>
	                    <td colspan="4">无记录</td>
	                 </tr>
	               </c:if>
	             </tbody>
	          </table>
	          <c:set var="pageView" value="${pdfn:getPageView(results)}" scope="request"></c:set>
	     <pd:pagination toPage="toPage"/>
	            <p align="center" style="width:100%">
				  <input class="search" type="button" value="关&#12288;闭"  onclick="jboxClose();" />
			    </p>
	     </div>
	   </div>
	</div>
</body>
</html>