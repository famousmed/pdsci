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
   function save(){
	   var form = $("#editForm");
	   if(form.validationEngine("validate")){
	   jboxConfirm("确认保存评价表，保存后将无法修改？",function(){
		   var url='<s:url value="/srm/aid/talents/save"/>';
		   var requestData = form.serialize();
		   jboxStartLoading();
		   jboxPost(url,requestData,function(resp){
			   if(resp=="${GlobalConstant.SAVE_SUCCESSED}"){
				   window.parent.frames["mainIframe"].window.search();
				   jboxClose();
			   }
		   },null,true);
	   },null);
	 }
   }
</script>
</head>
<body>

<div class="mainright">
  <div class="content">
    <div class="title1 clearfix">
    <form id="editForm"  method="post" action="<s:url value='/srm/aid/talents/edit'/>" >
    <table class="basic" style="width: 100%">
     <!--  <tr class="bs_name" style="height: 26px">
   		 <td style="text-align:center;" colspan="6">人才培养绩效评价表</td>
      </tr> -->
      <tr>
         <th width="16%">姓名：</th>
         <td>
        	 ${aidExt.userName }
         </td>
         <th width="16%">单位：</th>
         <td >
        	${aidExt.orgName }
         </td>
         <th width="16%">部门：</th>
         <td >
        	${aidExt.deptName }  
         </td>
       </tr>
      <tr>
      	 <th width="16%">职称：</th>
         <td>
        	 ${aidExt.titleName }
         </td>
         <th width="16%">职务：</th>
         <td >
        	 ${aidExt.postName }
         </td>
         <th width="16%">性别：</th>
         <td >
         	${aidExt.sexName }
         </td>
       </tr>
      <tr>
      	<th width="16%">出生日期：</th>
         <td>
         	${aidExt.userBirthday }
         </td>
         <th width="16%">研修所赴国家<br>（地区）：</th>
         <td >
        	  ${aidExt.studyCountry}
         </td>
         <th width="16%">研修项目名称：</th>
         <td>
        	${aidExt.studyName}
         </td>
       </tr>
      <tr>
      	 <th width="16%">申请资助金额：</th>
         <td>
        	 ${aidExt.applyFee}
         </td>
         <th width="16%">研修开始时间：</th>
         <td>
        	  ${aidExt.startDate}
         </td>
          <th width="16%">研修结束时间：</th>
         <td>
        	 ${aidExt.endDate}
         </td>
       </tr>
      <tr>
         <th width="16%">开展的新业务、<br>新技术：</th>
         <td colspan="5">
         	<c:choose>
            	<c:when test="${aidExt.assessStatusId==aidAssessStatusEnumAssessing.id }"><textarea name="newBusiness" rows="5" style="width:98%;margin: 8px 0px;" placeholder="请填写开展的新业务、新技术">${aidExt.newBusiness}</textarea></c:when>
            	<c:otherwise>${aidExt.newBusiness}</c:otherwise>
         	</c:choose>
         </td>
       </tr>
      <tr>
         <th width="16%">论文发表：</th>
         <td colspan="5">
         	<c:choose>
            	<c:when test="${aidExt.assessStatusId==aidAssessStatusEnumAssessing.id }"> <textarea name="thesis" rows="5" style="width:98%;margin: 8px 0px;" placeholder="请填写论文发表">${aidExt.thesis}</textarea></c:when>
            	<c:otherwise>${aidExt.thesis}</c:otherwise>
         	</c:choose>
         </td>
       </tr>
      <tr>
         <th width="16%">科研项目、<br>科研成果：</th>
         <td colspan="5">
         	<c:choose>
            	<c:when test="${aidExt.assessStatusId==aidAssessStatusEnumAssessing.id }"><textarea name="project" rows="5" style="width:98%;margin: 8px 0px;" placeholder="请填写科研项目、科研成果">${aidExt.project}</textarea></c:when>
            	<c:otherwise>${aidExt.project}</c:otherwise>
         	</c:choose>
         </td>
       </tr>
      <tr>
         <th width="16%">其&#12288;&#12288;它：</th>
         <td colspan="5">
         	<c:choose>
            	<c:when test="${aidExt.assessStatusId==aidAssessStatusEnumAssessing.id }"> <textarea name="other" rows="5" style="width:98%;margin: 8px 0px;"placeholder="请填写其它">${aidExt.other}</textarea></c:when>
            	<c:otherwise>${aidExt.other}</c:otherwise>
         	</c:choose>
         </td>
       </tr>
         <tr>
         <th width="16%"><span class="red">*</span>填报时间：</th>
         <td colspan="5">
        	 <input type="text" name="assessDate" value="${aidExt.assessDate}" class="validate[required] xltext ctime" style="width:159px;" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
         </td>
       </tr>
     <%--   <tr>
         <th width="16%">所在单位负责人签字：</th>
         <td colspan="5">
        	 <input  class="validate[required]  xltext" type="text" name="pjPrincipal" value="${aidExt.pjPrincipal}"/>
         </td>
       </tr> --%>
    </table>
       <p class="button" >
       	   <input type="hidden" name="talentsFlow" value="${aidExt.talentsFlow}"/>
       	   <input type="hidden" name="assessStatusId" value="${aidAssessStatusEnumAssessed.id}"/>
	       <c:if test="${aidExt.assessStatusId==aidAssessStatusEnumAssessing.id }">
	       <input type="button" value="保&#12288;存" onclick="save();" class="search"/>
	       </c:if>
	       <input type="button" value="关&#12288;闭" onclick="jboxClose();" class="search"/>
	    </p>
	    </form>
      </div>
  </div> 	
</div>

</body>
</html>