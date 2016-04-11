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
   function chooseUser(){
	   var mainIframe = window.parent.frames["mainIframe"];
	   var width = mainIframe.document.body.scrollWidth;
	   var height = mainIframe.document.body.scrollHeight;
	   var url ='<s:url value="/srm/aid/talents/chooseUser"/>?talentsFlow=${aidExt.talentsFlow}&role=${param.role}';
	   var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='"+width+"px' height='"+height+"px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	   jboxMessager(iframe,'选择用户',width,height);
	   
   }
   function submit(){
	   jboxStartLoading();
	   $("#editForm").submit();
   }
   function save(){
	   var form = $("#editForm");
	   if(form.validationEngine("validate")){
		   var url='<s:url value="/srm/aid/talents/save"/>';
		   var requestData = form.serialize();
		   if($("#orgFlow").val()){
			   requestData += "&orgName="+$("#orgFlow > option:selected").text();
		   }
		   /* if($("#deptFlow").val()){
			   requestData += "&deptName="+$("#deptFlow > option:selected").text();
		   } */
		   if($("#titleId").val()){
			   requestData += "&titleName="+$("#titleId > option:selected").text();
		   }
		   if($("#postId").val()){
			   requestData += "&postName="+$("#postId > option:selected").text();
		   }
		   if($("input[name='sexId']:checked").val()){
			   requestData += "&sexName="+$("input[name='sexId']:checked").next("label").text();
		   }
		   jboxStartLoading();
		   jboxPost(url,requestData,function(resp){
			   if(resp=="${GlobalConstant.SAVE_SUCCESSED}"){
				   window.parent.frames["mainIframe"].window.search();
				   jboxClose();
			   }
		   },null,true);
	   }
   }
   function selectOrg(){
	   var url='<s:url value="/srm/aid/talents/queryDeptListJson"/>?orgFlow='+$("#orgFlow").val();
	   jboxPost(url,null,function(resp){
		   //alert(resp);
		   if(resp){
			  var html = '<option value="">--请选择--</option>';
			  $.each(resp,function(index,obj){
				  html += '<option value="'+obj.deptFlow+'">'+obj.deptName+'</option>';
			  });
			  $("#deptFlow").html(html);
		   }
	   },null,false);
   }
</script>
</head>
<body>

<div class="mainright">
  <div class="content">
    <div class="title1 clearfix">
    <form id="editForm"  method="post" action="<s:url value='/srm/aid/talents/edit'/>" >
    <table class="basic" style="width: 100%">
      <!-- <tr style="height: 26px">
   		 <th style="text-align:center;" colspan="6">人才培养专项资金申请表</th>
      </tr> -->
      <tr>
         <th width="16%"><span class="red">*</span>姓名：</th>
         <td>
        	 <input class="validate[required]  xltext" style="width:127px; <c:if test='${param.role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL }'>display:none;</c:if>" type="text" <c:if test="${param.role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL }"> readonly="readonly" </c:if> name="userName" value="<c:choose><c:when test="${param.role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL}">${sessionScope.currUser.userName}</c:when><c:when test="${!empty chooseUser.userName }">${chooseUser.userName}</c:when><c:otherwise>${aidExt.userName}</c:otherwise></c:choose>"/><input type="hidden" name="userFlow" value="<c:choose><c:when test="${param.role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL}">${sessionScope.currUser.userFlow}</c:when><c:when test="${!empty chooseUser.userFlow }">${chooseUser.userFlow}</c:when><c:otherwise>${aidExt.userFlow}</c:otherwise></c:choose>"/><c:if test="${param.role!=GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL }"><img alt="查找用户" src="<s:url value='/css/skin/${skinPath}/images/search.gif'/>" onclick="chooseUser()" style="cursor: pointer;"></c:if>
        	 <c:if test='${param.role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL }'>${sessionScope.currUser.userName}</c:if>
         </td>
         <th width="16%"><span class="red">*</span>单位：</th>
         <td >
        	 <select id="orgFlow" name="orgFlow" class="validate[required] xlselect" <c:if test='${param.role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL }'>style="display:none;"</c:if> >
        	 	<c:choose>
	        	 	<c:when test="${param.role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL ||param.role==GlobalConstant.PROJ_STATUS_SCOPE_LOCAL}">
	        	 		<option value="${sessionScope.currUser.orgFlow }">${sessionScope.currUser.orgName }</option>
	        	 	</c:when>
	        	 	<c:otherwise>
	        	 		<option value="">--请选择--</option>
		           		<c:forEach items="${applicationScope.sysOrgList}" var="org">
		           			<option value="${org.orgFlow}" <c:choose><c:when test="${!empty chooseUser.orgFlow&&org.orgFlow == chooseUser.orgFlow }">selected="selected"</c:when><c:when test="${empty chooseUser.orgFlow&&org.orgFlow == aidExt.orgFlow }">selected="selected"</c:when></c:choose> >${org.orgName}</option>
		           		</c:forEach>
	        	 	</c:otherwise>
        	 	</c:choose>
           	 </select>
           	 <c:if test='${param.role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL }'>${sessionScope.currUser.orgName}</c:if> 
         </td>
         <th width="16%"><span class="red">*</span>部门：</th>
         <td >
         	<input class="validate[required , maxSize[25]]  xltext" name="deptName" value="${aidExt.deptName}" />
        	 <%--  <select id="deptFlow"  name="deptFlow" class="xlselect">
        	  <c:choose>
	        	 	<c:when test="${param.role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL }">
	        	 		<option value="${sessionScope.currUser.deptFlow }">${sessionScope.currUser.deptName }</option>
	        	 	</c:when>
	        	 	<c:otherwise>
	        	 		<option value="">--请选择--</option>
		           		<c:forEach items="${deptList}" var="dept">
		           			<option value="${dept.deptFlow}" <c:choose><c:when test="${!empty chooseUser.deptFlow&&dept.deptFlow == chooseUser.deptFlow }">selected="selected"</c:when><c:when test="${empty chooseUser.deptFlow&&dept.deptFlow == aidExt.deptFlow }">selected="selected"</c:when></c:choose> >${dept.deptName}</option>
		           		</c:forEach>
	        	 	</c:otherwise>
        	 	</c:choose>
        	 
		      </select>  --%>
		      
         </td>
       </tr>
      <tr>
      	<th width="16%">职称：</th>
         <td>
        	  <select id="titleId" name="titleId" class="xlselect" <c:if test='${param.role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL }'>style="display:none;"</c:if>  >
        	   <c:choose>
	        	 	<c:when test="${param.role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL }">
	        	 		<option value="${sessionScope.currUser.titleId }">${sessionScope.currUser.titleName }</option>
	        	 	</c:when>
	        	 	<c:otherwise>
	        	 		<option value="">--请选择--</option>
		        	  	<c:forEach var="dict" items="${dictTypeEnumUserTitleList }">
		                   <option value="${dict.dictId }" <c:choose><c:when test="${!empty chooseUser.titleId&&dict.dictId == chooseUser.titleId }">selected="selected"</c:when><c:when test="${empty chooseUser.titleId&&dict.dictId == aidExt.titleId }">selected="selected"</c:when></c:choose> >${dict.dictName }</option> 
		                 </c:forEach>
	        	 	</c:otherwise>
        	 	</c:choose>
        	  </select>
        	  <c:if test='${param.role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL }'>${sessionScope.currUser.titleName}</c:if>  
         </td>
         <th width="16%">职务：</th>
         <td >
        	  <select id="postId" name="postId" class="xlselect" <c:if test='${param.role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL }'>style="display:none;"</c:if> >
        	  	 <c:choose>
	        	 	<c:when test="${param.role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL }">
	        	 		<option value="${sessionScope.currUser.postId }">${sessionScope.currUser.postName }</option>
	        	 	</c:when>
	        	 	<c:otherwise>
	        	 		<option value="">--请选择--</option>
		        	  	<c:forEach var="dict" items="${dictTypeEnumUserPostList }">
		                   <option value="${dict.dictId }" <c:choose><c:when test="${!empty chooseUser.postId&&dict.dictId == chooseUser.postId }">selected="selected"</c:when><c:when test="${empty chooseUser.postId&&dict.dictId == aidExt.postId }">selected="selected"</c:when></c:choose> >${dict.dictName }</option> 
		                 </c:forEach>
	        	 	</c:otherwise>
        	 	</c:choose>
        	  </select> 
        	  <c:if test='${param.role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL }'>${sessionScope.currUser.postName}</c:if>  
         </td>
         <th width="16%"><span class="red">*</span>性别：</th>
         <td >
         	 <c:choose>
	        	 	<c:when test="${param.role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL }">
	        	 		<input type="radio"  readonly="readonly" style="display: none;" checked="checked"  name="sexId" id="sex_y" value="${sessionScope.currUser.sexId}" ><label for="sex_y">${sessionScope.currUser.sexName}</label>&nbsp;
	        	 	</c:when>
	        	 	<c:otherwise>
	        	 		<input type="radio"  name="sexId" id="sex_y" value="${userSexEnumMan.id}" <c:choose><c:when test="${!empty chooseUser.sexId&&userSexEnumMan.id == chooseUser.sexId }">checked="checked"</c:when><c:when test="${empty chooseUser.sexId&&userSexEnumMan.id == aidExt.sexId }">checked="checked"</c:when></c:choose>><label for="sex_y">${userSexEnumMan.name}</label>&nbsp;
        	 			<input type="radio"  name="sexId" id="sex_n" value="${userSexEnumWoman.id}" <c:choose><c:when test="${!empty chooseUser.sexId&&userSexEnumWoman.id == chooseUser.sexId }">checked="checked"</c:when><c:when test="${empty chooseUser.sexId&&userSexEnumWoman.id == aidExt.sexId }">checked="checked"</c:when></c:choose> ><label for="sex_n">${userSexEnumWoman.name}</label>&nbsp;
	        	 	</c:otherwise>
        	 	</c:choose>
         </td>
       </tr>
      <tr>
      	 <th width="16%"><span class="red">*</span>出生日期：</th>
         <td>
        	  <input type="text"  name="userBirthday" <c:if test="${param.role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL }"> style="display:none;" </c:if> value="<c:choose><c:when test="${param.role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL}">${sessionScope.currUser.userBirthday}</c:when><c:when test="${!empty chooseUser.userBirthday }">${chooseUser.userBirthday}</c:when><c:otherwise>${aidExt.userBirthday}</c:otherwise></c:choose>" class="validate[required] xltext ctime" style="width:159px;" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
        	  <c:if test='${param.role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL }'>${sessionScope.currUser.userBirthday}</c:if> 
         </td>
         <th width="16%"><span class="red">*</span>研修所赴国家<br>（地区）：</th>
         <td >
        	  <input class="validate[required]  xltext" type="text" name="studyCountry" value="${aidExt.studyCountry}"/> 
         </td>
         <th width="16%"><span class="red">*</span>研修项目名称：</th>
         <td>
        	 <input class="validate[required]  xltext" type="text" name="studyName" value="${aidExt.studyName}"/>
         </td>
       </tr>
      <tr>
         <th width="16%"><span class="red">*</span>研修开始时间：</th>
         <td>
        	  <input type="text" name="startDate" value="${aidExt.startDate}" class="validate[required] xltext ctime" style="width:159px;" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
         </td>
          <th width="16%"><span class="red">*</span>研修结束时间：</th>
         <td>
        	  <input type="text" name="endDate" value="${aidExt.endDate}" class="validate[required] xltext ctime" style="width:159px;" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
         </td>
         <!-- <td colspan="2"></td> -->
         <th width="16%"><span class="red">*</span>申请资助金额：</th>
         <td>
        	 <input class="validate[required]  xltext" type="text" name="applyFee" value="${aidExt.applyFee}"/>
         </td>
       </tr>
      <tr>
         <th width="16%">预计费用&nbsp; <br>及主要构成：</th>
         <td colspan="5">
        	  <textarea name="mainCompose" rows="5" style="width:98%;margin: 8px 0px;" placeholder="请填写预计费用及主要构成">${aidExt.mainCompose}</textarea>
         </td>
       </tr>
      <tr>
         <th width="16%">具体研修内容：</th>
         <td colspan="5">
        	  <textarea name="content" rows="5" style="width:98%;margin: 8px 0px;" placeholder="请填写具体研修内容">${aidExt.content}</textarea>
         </td>
       </tr>
      <%-- <tr>
         <th width="16%">市卫生局意见：</th>
         <td colspan="5">
        	  <textarea name="wsjOpinion" rows="5" style="width:100%">${aidExt.wsjOpinion}</textarea>
         </td>
       </tr>
      <tr>
         <th width="16%">市财政局意见：</th>
         <td colspan="5">
        	  <textarea name="czjOpinion" rows="5" style="width:100%">${aidExt.czjOpinion}</textarea>
         </td>
       </tr>
       <tr>
         <th width="16%">所在单位负责人签字：</th>
         <td colspan="5">
        	 <input  class="validate[required]  xltext" type="text" name="sqPrincipal" value="${aidExt.sqPrincipal}"/>
         </td>
       </tr> --%>
       <tr>
         <th width="16%"><span class="red">*</span>填报时间：</th>
         <td colspan="5">
        	 <input type="text" name="applyDate" value="${aidExt.applyDate}" class="validate[required] xltext ctime" style="width:159px;" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
         </td>
       </tr>
    </table>
       <p class="button" >
       	   <input type="hidden" name="talentsFlow" value="${aidExt.talentsFlow}"/>
       	   <input type="hidden" name="role" value="${param.role}"/>
	       <input type="button" value="保&#12288;存" onclick="save();" class="search"/>
	       <input type="button" value="关&#12288;闭" onclick="jboxClose();" class="search"/>
	    </p>
	    </form>
      </div>
  </div> 	
</div>

</body>
</html>