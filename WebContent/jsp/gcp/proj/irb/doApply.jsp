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
		jboxConfirm("确认申请伦理审查吗?",function(){
			if ("${irbTypeEnumInit.id}"==$("#irbTypeId").val()) {
				jboxGet("<s:url value='/irb/researcher/saveInitIrbConfirm'/>?projFlow=${param.projFlow}",null,function(resp){
					if(resp == '${GlobalConstant.OPRE_SUCCESSED}'){
						doSave();
					} else {
						jboxTip("该项目已存在${irbTypeEnumInit.name}，不能重复添加!");
					}
				},null,false);
			} else {
				doSave();
			}
		});
	} 
	
	function doSave() {
		jboxGet("<s:url value='/irb/researcher/addIrb'/>?projFlow=${param.projFlow}&irbTypeId="+$("#irbTypeId").val(),null,function(){
			window.parent.frames['mainIframe'].window.location.href="<s:url value='/irb/researcher/process'/>?roleScope=${param.roleScope}&projFlow=${param.projFlow}&irbTypeId="+$("#irbTypeId").val();
			jboxClose();
		},null,true);
	}
	
</script>
</head>

<body>
   <form id="pjTypeForm">
           <table class="basic" align="center" width="100%">
                      <tr>
                         <th style="text-align: center;">
                         	伦理审查申请：<select id="irbTypeId">
                         	<c:forEach items="${irbTypeEnumList }" var="iEnum">
                         		<option value="${iEnum.id }">${iEnum.name }</option>
                         	</c:forEach>
                         	</select>
                         </th>
                      </tr>
           </table>
    </form>
         <div class="button">
  		 	<input class="search" type="button" onclick="save();" value="保&#12288;存"/>
    	   </div>
</body>
</html>