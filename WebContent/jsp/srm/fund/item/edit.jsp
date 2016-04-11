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
<script type="text/javascript">
function saveFund() {
	if(false==$("#srmFundItem").validationEngine("validate")){
		return ;
	}
	var url = '<s:url value="/srm/fund/item/saveFund"/>';
	jboxStartLoading();
	jboxPost(url , $('#srmFundItem').serialize() , function(){
		$("#searchFundItem",window.parent.frames['mainIframe'].document).submit();
		doClose();
	} , null , true);
}
function doClose() {
	jboxClose();
}
</script>
   <div style="margin-top: 25px;"   >
	<form id="srmFundItem" action="<s:url value="/srm/fund/item/save"/>"style="padding-left: 33px;height: 100px;" >
   		<table class="mation" style="width: 400px"  >
        	<tr>
				<td style="text-align: right" width="100px">经费项目名：</td>
				<td style="text-align: left;padding-left: 5px" width="200px">
					<input class="validate[required] name" class="text" name="itemName" style="width: 135px" type="text" value="${srmFundItem.itemName }" />
				</td>
			</tr>
       </table>
	   <div align="center">
	   	   <input  type="hidden" name="itemFlow" value="${srmFundItem.itemFlow }"/>
		   <input type="button" value="保存" class="dingdan-d" style="width: 70px"  onclick="saveFund();" />
		   <input type="button" class="dingdan-d" onclick="doClose();" value="关闭">
	   </div>
   </form>
  </div>
</body>
</html>