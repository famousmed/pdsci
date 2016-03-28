<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
	function save(){
		if(false==$("#pjTypeForm").validationEngine("validate")){
			return ;
		}
		window.parent.frames['mainIframe'].location.href="<s:url value='/irb/researcher/applyMain'/>?projCategroyId="+$("input[name=pjType]:checked").val()+"&roleScope=${param.roleScope}";
		jboxClose();
	}
	
</script>
</head>

<body>
           	<form id="pjTypeForm">
           <table class="basic" align="center" width="100%">
                      <tr>
                         <th style="text-align: center;">
                         	
                         	<select name="stage" style="width: 150px;">
	                         	<c:forEach items="${irbStageEnumList}" var="stage" end="${pdfn:getIrbStageOrdinal(param.stageId)}" >
	                         		<option value="${stage.id}">${stage.name}</option>
	                         	</c:forEach>
                         	</select>
                         </th>
                      </tr>
           </table>
                      </form>
           <div class="button">
		   	<input class="search" type="button" onclick="save();" value="保存"/>
      	   </div>
</body>
</html>