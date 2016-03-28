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
                         
                         
                         <input type="radio" class="validate[required] " id="${projCategroyEnumYw.id }" value="${projCategroyEnumYw.id }" name="pjType"><label for="${projCategroyEnumYw.id }">${projCategroyEnumYw.name }&#12288;&#12288;</label>
                         <input type="radio"  name="pjType" id="${projCategroyEnumKy.id }" class="validate[required] " value="${projCategroyEnumKy.id }"><label for="${projCategroyEnumKy.id }">${projCategroyEnumKy.name }&#12288;&#12288;</label>
                         <input type="radio"  name="pjType" id="${projCategroyEnumQx.id }" class="validate[required] " value="${projCategroyEnumQx.id }"><label for="${projCategroyEnumQx.id }">${projCategroyEnumQx.name }&#12288;&#12288;</label>
                         </th>
                      </tr>
           </table>
                      </form>
           <div class="button">
		   	<input class="search" type="button" onclick="save();" value="保存"/>
      	   </div>
</body>
</html>