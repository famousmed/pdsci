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
</head>
<body>
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
		     <h2>&#12288;&#12288;评审委员打分</h2>
        </div>
        <form id="expertForm" method="post">
			<table class="xllist">
				<thead>
	       			<tr> 
                    	<th  width="10%">专家</th>
                        <th  width="10%">总分</th>
                        <th  width="10%">审核结果</th>
                        <th>审核意见</th>
                   </tr>
       			</thead>
       			<tbody>
	      			<c:set var="projName" scope="page"></c:set>
                        <c:forEach items="${expertProjList}" var="expertProj"> 
	                         <tr>
	                             <td>${expertProj.userExt.userName}</td>
	                         	 <td>${expertProj.scoreTotal}</td>
	                         	 <td>${expertProj.scoreResultName}</td>
	                         	 <td>
	                         	 <c:choose>
	                         	 	<c:when test="${ expertProj.agreeFlag==GlobalConstant.FLAG_N }">
	                         	 		未参加评审
	                         	 	</c:when>
	                         	 	<c:otherwise>
	                         	 		 ${expertProj.expertOpinion}
	                         	 	</c:otherwise>
	                         	 </c:choose>
	                         	</td>
	                        </tr>
                        </c:forEach>
   				</tbody>
			</table>
   			<div style="text-align: center;margin-top: 20px">
   			</div>
		</form>
     </div> 	
   </div>
</body>
</html>
