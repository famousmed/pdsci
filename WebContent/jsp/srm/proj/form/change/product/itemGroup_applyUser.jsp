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
        <form action="<s:url value='/srm/proj/mine/savePageGroupStep'/>" id="itemGroup1" method="post" style="position: relative;">
			<input type="hidden" name="pageName" value="step2"/>
			<input type="hidden" name="itemGroupName" value="applyUser"/>
			<input type="hidden" name="recFlow" value="${projRec.recFlow}"/>
			<input type="hidden" name="projFlow" value="${proj.projFlow}"/>
			<input type="hidden" name="itemGroupFlow" value="${param.itemGroupFlow}"/>
			<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
           <table class="basic">
                 <thead>
                    <tr>
                        <th colspan="4" class="bs_name">主要负责人信息</th>
                    </tr>
                 </thead>
                 <tbody>
                      <tr>
                         <th width="20%">姓名：</th>
                         <td width="30%">
                         	<input type="text" name="applyUserName" value="${resultMap.applyUserName }" class="xltext">
                         </td>
                         <th width="20%">性别:</th>
                         <td width="30%">
                         	<input type="radio" name="applyUserSex" value="0" <c:if test='${resultMap.applyUserSex=="0"}'> checked="checked"</c:if>/>男
                         	<input type="radio" name="applyUserSex" value="1" <c:if test='${resultMap.applyUserSex=="1"}'> checked="checked"</c:if>/>女
                         </td>
                      </tr>
                      <tr>
                         <th width="20%">生日：</th>
                         <td width="30%">
                         	<input type="text" name="applyUserBirthday" value="${resultMap.applyUserBirthday }" class="xltext ctime" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                         </td>
                         <th width="20%">职称:</th>
                         <td width="30%">
                         	<input type="text" name="applyUserTitle" value="${resultMap.applyUserTitle }" class="xltext">
                         </td>
                      </tr>
                      <tr>
                         <th width="20%">所在单位：</th>
                         <td width="30%">
                         	<input type="text" name="applyUserOrgBelong" value="${resultMap.applyUserOrgBelong }" class="xltext">
                         </td>
                         <th width="20%">为本项目工作时间:</th>
                         <td width="30%">
                         	<input type="text" name="applyUserTime" value="${resultMap.applyUserTime }" class="xltext ctime" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                         </td>
                      </tr>
                      <tr>
                         <th width="20%">在项目中担任的职务：</th>
                         <td width="30%">
                         	<input type="text" name="applyUserDuty" value="${resultMap.applyUserDuty }">
                         </td>
                         <th width="20%"></th>
                         <td width="30%">
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


<!--  
<body>
	<form action="<s:url value='/srm/proj/mine/savePageGroupStep'/>" id="itemGroup1" method="post">
		<input type="hidden" name="pageName" value="step2"/>
		<input type="hidden" name="itemGroupName" value="applyUser"/>
		<input type="hidden" name="projRecFlow" value="${param.projRecFlow}"/>
		<input type="hidden" name="projFlow" value="${param.projFlow}"/>
		<input type="hidden" name="itemGroupFlow" value="${param.itemGroupFlow}"/>
		<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>

		姓名:<input type="text" name="applyUserName" value="${resultMap.applyUserName }"><br/> 
		性别:<input type="text" name="applyUserSex" value="${resultMap.applyUserSex }"><br/>
		生日:<input type="text" name="applyUserBirthday" value="${resultMap.applyUserBirthday }"><br/> 
		职称:<input type="text" name="applyUserTitle" value="${resultMap.applyUserTitle }"><br/> 
		所在单位:<input type="text" name="applyUserOrgBelong" value="${resultMap.applyUserOrgBelong }"><br/>
		为本项目工作时间：<input type="text" name="applyUserTime" value="${resultMap.applyUserTime }"><br/> 
		在项目中担任的职务:<input type="text" name="applyUserDuty" value="${resultMap.applyUserDuty }"><br/>    
		<input type="button" onclick="save();" value="保存"/>
	</form>	
</body>
-->
</html>