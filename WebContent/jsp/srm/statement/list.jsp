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
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">

</script>
</head>
<body>
<div id="main">
   <div class="mainright">
	<div class="content">
	    <table width="100%" class="xllist">
	       <thead>
	         <tr>
	          <th >机构名称</th>
	          <th width="14%">项目类别</th>
	          <th width="14%">项目总数</th>
	          <th width="14%">未提交项目数量</th>
	          <th width="14%">已提交项目数量</th>
	          <th width="14%">审核中的项目数量</th>
	          <th width="14%">审核通过的项目数量</th>
	         </tr>
	       </thead>
	       <tbody>
	         <c:forEach items="${orgList}" var="org">
	         <tr>
	           <td>
	               ${org.orgName }
	               <input type="hidden" name="orgFlow" value="${statement.orgFlow }"/>  
	           </td>
	           <td colspan="6">
	             <table width="100%" class="tjsj" style="border-left-style: none;border-bottom-style:none; border-right-style: none;border-top-style: none;">
	               <tbody>
	               <c:forEach items="${statementList }" var="statement">
	                  <c:if test="${statement.orgFlow eq org.orgFlow }">
	                  <tr>
	                    <td style="border-top-style:none;" width="16.6%">${statement.projTypeName }</td>
	                    <td style="border-top-style:none;" width="16.6%">
	                        ${statement.allProjCount }
	                       
	                        </td>
	                    <td style="border-top-style:none;" width="16.6%">
	                        ${statement.noSubmitProjCount }
	                       
	                    </td>
	                    <td style="border-top-style:none;" width="16.6%">
	                        ${statement.submitProjCount }
	                       
	                        </td>
	                    <td style="border-top-style:none;" width="16.6%">
	                        ${statement.approvingProjCount }
	                        
	                        </td>
	                    <td style="border-top-style:none;" width="16.6%">
	                        ${statement.approveProjCount }
	                        
	                        </td>
	                  </tr>
	                  </c:if>  
	               </c:forEach>
	                </tbody>
	                  <c:forEach items="${sumList }" var="sum">
	                    <c:if test="${sum.orgFlow eq org.orgFlow and sum.projTypeId eq 'hj'}">
	                   <tr>
	                    <th style="border-bottom-style:none;">合&#12288;计</th>
	                    <th id="allProjCountSum" style="border-bottom-style:none;"><font color="red">${sum.allProjCount }</font></th>
	                    <th id="noSubmitProjCountSum" style="border-bottom-style:none;"><font color="red">${sum.noSubmitProjCount }</font></th>
	                    <th id="submitProjCountSum" style="border-bottom-style:none;"><font color="red">${sum.submitProjCount }</font></th>
	                    <th id="approvingProjCountSum" style="border-bottom-style:none;"><font color="red">${sum.approvingProjCount }</font></th>
	                    <th id="approveProjCountSum" style="border-bottom-style:none;"><font color="red">${sum.approveProjCount }</font></th>
	                  </tr>
	                  </c:if>
	                  </c:forEach>
	             </table>
	         </td>
	         </tr>
	         </c:forEach>
	          </tbody>
	    </table> 
	</div>
	</div>
</div>
</body>
<script type="text/javascript">

</script>
</html>