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
			<input type="hidden" name="pageName" value="step2"/>
			<input type="hidden" name="itemGroupName" value="developUser"/>
			<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
            <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
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
                         	<input type="text" name="developUserName" value="${resultMap.developUserName }" class="xltext">
                         </td>
                         <th width="20%">性别:</th>
                         <td width="30%">
                         	<input type="radio" name="developUserSex" value="0" <c:if test='${resultMap.developUserSex=="0"}'> checked="checked"</c:if>/>男
                         	<input type="radio" name="developUserSex" value="1" <c:if test='${resultMap.developUserSex=="1"}'> checked="checked"</c:if>/>女
                         </td>
                      </tr>
                      <tr>
                         <th width="20%">生日：</th>
                         <td width="30%">
                         	<input type="text" name="developUserBirthday" value="${resultMap.developUserBirthday }" class="xltext ctime" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                         </td>
                         <th width="20%">职称:</th>
                         <td width="30%">
                         	<input type="text" name="developUserTitle" value="${resultMap.developUserTitle }" class="xltext">
                         </td>
                      </tr>
                      <tr>
                         <th width="20%">所在单位：</th>
                         <td width="30%">
                         	<input type="text" name="developUserOrgBelong" value="${resultMap.developUserOrgBelong }" class="xltext">
                         </td>
                         <th width="20%">为本项目工作时间:</th>
                         <td width="30%">
                         	<input type="text" name="developUserTime" value="${resultMap.developUserTime }" class="xltext ctime" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                         </td>
                      </tr>
                      <tr>
                         <th width="20%">在项目中担任的职务：</th>
                         <td width="30%">
                         	<input type="text" name="developUserDuty" value="${resultMap.developUserDuty }" class="xltext">
                         </td>
                         <th width="20%"></th>
                         <td width="30%">
                         </td>
                      </tr>
                 </tbody>
           </table>
           <div class="button">
		   	<input class="search" id="sv" type="button" onclick="save();" value="保存"/>
      	   </div>
           </form>
         </div>
        
     </div> 	
   </div>
</div>
</body>
</html>