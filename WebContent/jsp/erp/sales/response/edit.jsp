<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="true"/>
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
<script type="text/javascript" src="<s:url value='/js/j.suggest.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">

</script>
</head>
<body>
<div class="mainright">
<div class="content">
	   <table class="basic" width="100%">
	      <colgroup>
			<col width="25%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="25%"/>
		 </colgroup>
	       <tr>
	         <th colspan="4" style="text-align: left;padding-left: 10px">
	                                     来电记录
	         </th>
	       </tr>
	       <tbody>
	           <tr>
	             <td style="text-align: right;">客户名称：</td>
	             <td style="text-align: left;"><input type="text" name="customerName" class="inputText" style="text-align: left;" <c:if test="${param.type=='edit' }">value="江苏省中医院"</c:if>/></td>
	             <td style="text-align: right;">记录人：</td>
	             <td style="text-align: left;">
	               ${sessionScope.currUser.userName }
	               <input type="hidden" name="recordUserName" class="inputText" value="${sessionScope.currUser.userName }"/>
	               <input type="hidden" name="recordUserFlow" class="inputText" value="${sessionScope.currUser.userFlow }"/>
	             </td>
	           </tr>
	           <tr>
	             <td style="text-align: right;">来电部门：</td>
	             <td style="text-align: left;"><input type="text"  class="inputText" style="text-align: left;" <c:if test="${param.type=='edit' }">value="科教科"</c:if>/></td>
	             <td style="text-align: right;">来电人：</td>
	             <td style="text-align: left;"><input type="text"  class="inputText" style="text-align: left;" <c:if test="${param.type=='edit' }">value="张三"</c:if>/></td>
	           </tr>
	           <tr>
	             <td style="text-align: right;">联系方式：</td>
	             <td style="text-align: left;"><input type="text"  class="inputText" style="text-align: left;" <c:if test="${param.type=='edit' }">value="13545269874"</c:if>/></td>
	             <td style="text-align: right;">来电时间：</td>
	             <td style="text-align: left;">
	             <input onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"  style="text-align:left;" readonly="readonly" class="validate[required] inputText" type="text" <c:if test="${param.type=='edit' }">value="2015-04-28 12:24"</c:if>/>
	             </td>
	           </tr>
	           <tr>
	              <td style="text-align: right;">记录内容：</td>
	              <td colspan="3">
	                  <textarea name="recordContent" rows="5" style="width: 90%;text-align: left;">
	                  <c:if test="${param.type=='edit' }">aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</c:if>
	                  </textarea>
	              </td>
	           </tr>
	       </tbody>
	       <c:if test="${GlobalConstant.USER_LIST_LOCAL == sessionScope[GlobalConstant.USER_LIST_SCOPE]}">
	           <tr>
	             <th colspan="4" style="text-align: left;padding-left: 10px">
	                                          来电响应
	             </th>
	          </tr>
	          <tr>
	             <td style="text-align: right;">响应部门：</td>
	             <td style="text-align: left;">${sessionScope.currUser.deptName }<input type="hidden"  class="inputText" style="text-align: left;"/></td>
	             <td style="text-align: right;">响应人：</td>
	             <td style="text-align: left;">
	               ${sessionScope.currUser.userName }
	               <input type="hidden" name="recordUserName" class="inputText" value="${sessionScope.currUser.userName }"/>
	               <input type="hidden" name="recordUserFlow" class="inputText" value="${sessionScope.currUser.userFlow }"/>
	             </td>
	           </tr>
	           <tr>
	             <td style="text-align: right;">响应时间：</td>
	             <td style="text-align: left;">
	             <input onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"  style="text-align:left;" readonly="readonly" class="validate[required] inputText" type="text" />
	             </td>
	              <td></td>
	              <td></td>
	           </tr>
	           <tr>
	              <td style="text-align: right;">响应内容：</td>
	              <td colspan="3">
	                  <textarea name="recordContent" rows="5" style="width: 90%;text-align: left;">
	                  </textarea>
	              </td>
	           </tr>
	       </c:if>
	   </table>
	  <div class="button">
					<c:if test="${param.type != 'show'}">
					<input class="search" type="button" value="保&#12288;存" onclick="jboxCloseMessager();" />
					</c:if>
					<input class="search" type="button" value="关&#12288;闭" onclick="jboxCloseMessager();" />
		   </div>
</div>
</div>		
</body>
</html>