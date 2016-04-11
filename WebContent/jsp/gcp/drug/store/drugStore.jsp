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
	<jsp:param name="jquery_scrollTo" value="true"/>
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
		<div class="content" style="padding-top: 10px;">
		    <table width="100%" class="basic" style="margin-top: 10px;">
		    <colgroup>
		    	<col width="18%" />
				<col width="32%" />
				<col width="18%" />
				<col width="32%" />
		    </colgroup>
		     <tr>
				<th colspan="4" style="text-align: left;padding-left: 10px;">药物库存信息</th>
			 </tr>
			 <tr>
				<td style="text-align: right">药物名称：</td>
				<td>${drug.drugName }</td>
				<td style="text-align: right">药物类别：</td>
				<td>${drug.drugTypeName }</td>
			 </tr>
			 <tr>
				<td style="text-align: right">规&#12288;&#12288;格：</td>
				<td>${drug.spec }</td>
				<td style="text-align: right">最小包装单位：</td>
				<td>${drug.minPackUnitName }</td>
			 </tr>
			 <tr>
				<td style="text-align: right">已发药编码：</td>
				<td colspan="3">
					<c:forEach items="${drugRecSendList}" var="rec" varStatus="statu">
				        ${rec.drugPack}<c:if test="${!statu.last}">，</c:if>
				    </c:forEach>
				</td>
			 </tr>
			 <tr>
				<td style="text-align: right">库存编码：</td>
				<td colspan="3">
					<c:forEach items="${drugRecUnSendList}" var="rec" varStatus="statu">
				        ${rec.drugPack}<c:if test="${!statu.last}">，</c:if>
				    </c:forEach>
				</td>
			 </tr>
		     </tbody>
		   </table>	
		</div> 
		</div>
</body>
</html>