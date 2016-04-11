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

function save(){
	var url = "<s:url value='/srm/proj/mine/savePageGroupStep'/>";
	jboxPost(url , $('#itemGroup1').serialize() , function(){
		window.parent.frames['mainIframe'].location.reload(true);
		jboxClose();
	} , null , true);
}
</script>
</head>
<body>
<div id="main">
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
        <form action="<s:url value='/srm/proj/mine/savePageGroupStep'/>" id="itemGroup1" method="post">
			<input type="hidden" name="pageName" value="step3"/>
			<input type="hidden" name="itemGroupName" value="planRule"/>
			<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
            <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
			<input type="hidden" name="itemGroupFlow" value="${param.itemGroupFlow}"/>
			<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
           <table class="basic">
                 <thead>
                    <tr>
                        <th colspan="4" class="bs_name">计划指标</th>
                    </tr>
                 </thead>
                 <tbody>
                      <tr>
                         <th width="10%">阶段：</th>
                         <td>
                         	<input type="text" name="steps" value="${resultMap.steps}" class="xltext">
                         </td>
                      </tr>
                      <tr>
                         <th width="30%">财务计划及考核指标:</th>
                         <td>
                         	<textarea rows="10" cols="70" name="moneyPlanAndTestRule">${resultMap.moneyPlanAndTestRule }</textarea>
                         </td>
                      </tr>
                      
                 </tbody>
           </table>
           <div class="button">
		   	<input class="search" type="button" onclick="save();" value="保存"/>
      	   </div>
           </form>
         </div>
        
     </div> 	
   </div>
</div>
</body>
</html>