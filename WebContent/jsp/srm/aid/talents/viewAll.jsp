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

</head>
<body>

<div class="mainright">
  <div class="content">
    <div class="title1 clearfix">
    <form id="editForm"  method="post" action="<s:url value='/srm/aid/talents/edit'/>" >
    <table class="basic" style="width: 100%">
      <tr>
   		 <th colspan="6" style="text-align: left;padding-left: 15px;">专项资金申请表</th>
      </tr>
      <tr>
         <td width="15%" style="text-align:right;">姓名：</td>
         <td width="12%">
        	 ${aidExt.userName }
         </td>
         <td style="text-align:right;" width="15%">单位：</td>
         <td  width="19%" >
        	${aidExt.orgName }
         </td>
         <td style="text-align:right;" width="15%">部门：</td>
         <td >
        	${aidExt.deptName }  
         </td>
       </tr>
      <tr>
      <td style="text-align:right;" width="15%">职称：</td>
         <td>
        	 ${aidExt.titleName }
         </td>
         <td style="text-align:right;" width="15%">职务：</td>
         <td >
        	 ${aidExt.postName }
         </td>
         <td style="text-align:right;" width="15%">性别：</td>
         <td >
         	${aidExt.sexName }
         </td>
         
       </tr>
      <tr>
       <td style="text-align:right;" width="15%">出生日期：</td>
         <td>
         	${aidExt.userBirthday }
         </td>
         <td style="text-align:right;" width="15%">研修所赴国家<br>（地区）：</td>
         <td >
        	  ${aidExt.studyCountry}
         </td>
         <td style="text-align:right;" width="15%">研修项目名称：</td>
         <td>
        	${aidExt.studyName}
         </td>
         
       </tr>
      <tr>
         <td style="text-align:right;" width="15%">研修开始时间：</td>
         <td>
        	  ${aidExt.startDate}
         </td>
          <td style="text-align:right;" width="15%">研修结束时间：</td>
         <td>
        	 ${aidExt.endDate}
         </td>
         <!-- <td colspan="2"></td> -->
          <td style="text-align:right;" width="15%">申请资助金额：</td>
         <td>
        	 ${aidExt.applyFee}
         </td>
       </tr>
        <tr>
         <td style="text-align:right;" width="15%">预计费用&nbsp; <br>及主要构成：</td>
         <td colspan="5">
        	  ${aidExt.mainCompose}
         </td>
       </tr>
      <tr>
         <td style="text-align:right;" width="15%">具体研修内容：</td>
         <td colspan="5">
        	  ${aidExt.content}
         </td>
       </tr>
      <tr>
         <td style="text-align:right;" width="15%">市卫生局意见：</td>
         <td colspan="5">
        	  ${aidExt.wsjOpinion}
         </td>
       </tr>
    <%--   <tr>
         <td style="text-align:right;" width="15%">市财政局意见：</td>
         <td colspan="5">
        	  ${aidExt.czjOpinion}
         </td>
       </tr> --%>
       <tr>
         <td style="text-align:right;" width="15%">单位负责人签字：</td>
         <td colspan="5">
        	 ${aidExt.sqPrincipal}
         </td>
       </tr>
       <c:if test="${aidExt.assessStatusId==aidAssessStatusEnumAssessed.id }">
      <tr>
   		  <th colspan="6" style="text-align: left;padding-left: 15px;">绩效评价表</th>
      </tr>
      <tr>
         <td style="text-align:right;" width="15%">开展的新业务、<br>新技术：</td>
         <td colspan="5">
        	  ${aidExt.newBusiness}
         </td>
       </tr>
      <tr>
         <td style="text-align:right;" width="15%">论文发表：</td>
         <td colspan="5">
        	 ${aidExt.thesis}
         </td>
       </tr>
      <tr>
         <td style="text-align:right;" width="15%">科研项目、<br>科研成果：</td>
         <td colspan="5">
        	  ${aidExt.project}
         </td>
       </tr>
      <tr>
         <td style="text-align:right;" width="15%">其&#12288;&#12288;它：</td>
         <td colspan="5">
        	 ${aidExt.other}
         </td>
       </tr>
      <%--  <tr>
         <td style="text-align:right;" width="15%">所在单位负责人签字：</td>
         <td colspan="5">
        	 ${aidExt.pjPrincipal}
         </td>
       </tr> --%>
       </c:if>
    </table>
       <p class="button" >
	       <input type="button" value="关&#12288;闭" onclick="jboxClose();" class="search"/>
	    </p>
	    </form>
      </div>
  </div> 	
</div>

</body>
</html>