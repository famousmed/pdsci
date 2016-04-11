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
			var url = "<s:url value='/srm/aid/talents/check'/>";
			var requestData = $("#editForm").serialize();
			jboxStartLoading();
			jboxPost(url,requestData,function(resp){
				if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
					window.parent.frames["mainIframe"].window.search();
					jboxClose();
				}
			},null,true);
		}
	}
</script>
<style type="text/css">
	#table1 th {background: #fff; width: 110px;border:none;}
	#table1,#table1 td{border:none;}
	.check{padding:10px 40px;}
	.check div{padding: 7px 0px;}
	.check span{display: inline-block;   font-weight: bold;}
	.check span#span_sp{margin-bottom: 5px;}
</style>
</head>
<body>
<div class="mainright">
  <div class="content">
    <div class="title1 clearfix">
    <form id="editForm"  method="post" action="<s:url value='/srm/aid/talents/edit'/>" >
    <table class="basic" style="width: 100%" id="table1">
      <!-- <tr class="bs_name" style="height: 26px">
   		 <td style="text-align:center;" colspan="6">人才培养专项资金申请表</td>
      </tr> -->
       <tr>
         <th>姓名：</th>
         <td>
        	 ${aidExt.userName }
         </td>
         <th>单位：</th>
         <td width="20%" >
        	${aidExt.orgName }
         </td>
         <th>部门：</th>
         <td >
        	${aidExt.deptName }  
         </td>
       </tr>
      <tr>
      <th>职称：</th>
         <td>
        	 ${aidExt.titleName }
         </td>
         <th>职务：</th>
         <td >
        	 ${aidExt.postName }
         </td>
         <th>性别：</th>
         <td >
         	${aidExt.sexName }
         </td>
         
       </tr>
      <tr>
       <th>出生日期：</th>
         <td>
         	${aidExt.userBirthday }
         </td>
         <th>研修所赴国家<br>（地区）：</th>
         <td >
        	  ${aidExt.studyCountry}
         </td>
         <th>研修项目名称：</th>
         <td width="25%">
        	${aidExt.studyName}
         </td>
         
       </tr>
      <tr>
         <th>研修开始时间：</th>
         <td>
        	  ${aidExt.startDate}
         </td>
          <th>研修结束时间：</th>
         <td>
        	 ${aidExt.endDate}
         </td>
         <!-- <td colspan="2"></td> -->
          <th>申请资助金额：</th>
         <td>
        	 ${aidExt.applyFee}
         </td>
       </tr>
        <tr>
         <th>预计费用&nbsp; <br>及主要构成：</th>
         <td colspan="5">
        	  ${aidExt.mainCompose}
         </td>
       </tr>
      <tr>
         <th>具体研修内容：</th>
         <td colspan="5">
        	  ${aidExt.content}
         </td>
       </tr>
     <%--  <tr>
         <th width="16%">市卫生局意见：</th>
         <td colspan="5">
        	  ${aidExt.wsjOpinion}
         </td>
       </tr>
      <tr>
         <th width="16%">市财政局意见：</th>
         <td colspan="5">
        	  ${aidExt.czjOpinion}
         </td>
       </tr> --%>
       <c:if test="${param.role==GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL }">
        <tr>
         <th>单位负责人签字：</th>
         <td colspan="5">
         	${aidExt.sqPrincipal}
         </td>
       </tr>
       </c:if>
    </table>
    <hr>
    <div class="check" >
     <c:if test="${param.role==GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL }">
       <div><span>审核结果：</span><input type="radio" name="statusId" value="${aidTalentsStatusEnumGlobalPassed.id}" checked="checked" id="statusId_y"><label for="statusId_y">审核通过</label>&nbsp;
        	 <input type="radio" name="statusId" value="${aidTalentsStatusEnumGlobalNoPassed.id}"  id="statusId_n"><label for="statusId_n">审核不通过</label></div>
       <div><span id="span_sp">审核意见：</span><br><textarea name="wsjOpinion" rows="4" style="width:100%;" placeholder="请填写审核意见"></textarea></div> 	 
       </c:if>
       <c:if test="${param.role==GlobalConstant.PROJ_STATUS_SCOPE_LOCAL }">
       <div><span>审核结果：</span><input type="radio" name="statusId" value="${aidTalentsStatusEnumLocalPassed.id}" checked="checked" id="statusId_y"><label for="statusId_y">审核通过提交卫生局</label>&nbsp;
        	 <input type="radio" name="statusId" value="${aidTalentsStatusEnumLocalNoPassed.id}"  id="statusId_n"><label for="statusId_n">审核不通过</label></div>
       <div><span>所在单位负责人签字：</span><input type="text" name="sqPrincipal" class="validate[required]  xltext" value="${sessionScope.currUser.userName}" /></div> 	 
       </c:if>
    </div>
       <p class="button">
       		<input type="hidden" name="talentsFlow" value="${aidExt.talentsFlow}"/> 
       		<input type="button" value="确&#12288;认" onclick="save();" class="search"/>
	       <input type="button" value="关&#12288;闭" onclick="jboxClose();" class="search"/>
	    </p>
	    </form>
	    </div>
   </div>
</div> 	


</body>
</html>