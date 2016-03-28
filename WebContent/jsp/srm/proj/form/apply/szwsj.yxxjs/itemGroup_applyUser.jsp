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
	if(false==$("#itemGroup1").validationEngine("validate")){
		return ;
	}
	
	var url = "<s:url value='/srm/proj/mine/savePageGroupStep'/>";
	$('#sv').attr({"disabled":"disabled"});
	jboxStartLoading();
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
			<input type="hidden" name="pageName" value="step4"/>
			<input type="hidden" name="itemGroupName" value="applyUser"/>
			<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
            <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
			<input type="hidden" name="itemGroupFlow" value="${param.itemGroupFlow}"/>
			<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
			<input type="hidden" name="applyUser_type" value="${param.applyUser_type}"/>
           <table  width="100%" class="tableStyle">
                    <tr >
                        <th colspan="6" style="text-align: left;padding-left: 20px;">主要完成人信息</th>
                    </tr>
                 <tbody>
                      <tr>
                         <td>姓名</td>
                         <td >
                         	&#12288;<input type="text" name="applyUser_name" value="${resultMap.applyUser_name }" class="validate[required] inputText" style="width: 80%">
                            <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                         </td>
                         <td>性别</td>
                         <td>&#12288;
                         	<select name="applyUser_sex" class="validate[required] inputText" style="width: 80%">
                               <c:forEach items="${userSexEnumList }" var="sex" >
                                <c:if test="${sex.id != 'Unknown' }"><option value="${sex.name }" <c:if test="${resultMap.applyUser_sex eq sex.name}">selected="selected"</c:if>>${sex.name }</option></c:if>
                               </c:forEach>
                           </select>
                           <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                         </td>
                         <td>民族</td>
                         <td>&#12288;
                            <input type="text" name="applyUser_nation" value="${resultMap.applyUser_nation }" class="validate[required] inputText" style="width: 80%"/>
                            <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                         </td>
                      </tr>
                     <tr>
                       <td>出生地</td>
                       <td colspan="3">&#12288;
                         <input type="text" name="applyUser_home" value="${resultMap.applyUser_home }" class="validate[required] inputText" style="width: 90%;text-align: left"/>
                         <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                       </td>
                       <td>出生</td>
                       <td>&#12288;
                         <input class="validate[required] inputText" style="width:80%;" type="text" name="applyUser_birthday" value="${resultMap.applyUser_birthday}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  readonly="readonly"/>
                         <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                       </td>
                     </tr>
                     <tr>
                        <td>政治面貌</td>
                        <td >&#12288;
                           <input type="text" name="applyUser_politicalStatus" value="${resultMap.applyUser_politicalStatus }" class="validate[required] inputText" style="width: 80%"/>
                          <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                        </td>
                        <td>留学国家</td>
                        <td colspan="3">&#12288;
                           <input type="text" name="applyUser_studyAbroadArea" value="${resultMap.applyUser_studyAbroadArea }" class="inputText" style="width: 90%"/>
                        </td>
                     </tr>
                     <tr>
                       <td>工作单位</td>
                       <td >&#12288;
                          <input type="text" name="applyUser_orgBelong" value="${resultMap.applyUser_orgBelong }" class="validate[required] inputText" style="width: 80%"/>
                          <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                       </td>
                        <td>联系电话</td>
                       <td colspan="3">&#12288;
                          <input type="text" name="applyUser_phone" value="${resultMap.applyUser_phone }" class="validate[required] inputText" style="width: 90%"/>
                          <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                       </td>
                     </tr>
                     <tr>
                       <td>通讯地址</td>
                       <td colspan="5">&#12288;
                           <input type="text" name="applyUser_address" value="${resultMap.applyUser_address }" class="validate[required] inputText" style="width: 93%;text-align: left"/>
                           <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                       </td>
                     </tr>
                     <tr>
                       <td>毕业学校</td>
                       <td>&#12288;
                          <input type="text" name="applyUser_graduateSchool" value="${resultMap.applyUser_graduateSchool }" class="validate[required] inputText" style="width: 80%"/>
                          <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                       </td>
                       <td>学历</td>
                       <td>&#12288;
                         <input type="text" name="applyUser_education" value="${resultMap.applyUser_education }" class="validate[required] inputText" style="width: 80%"/>
                         <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                       </td>
                       <td>学位</td>
                       <td>&#12288;
                         <input type="text" name="applyUser_degree" value="${resultMap.applyUser_degree }" class="validate[required] inputText" style="width: 80%"/>
                         <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                       </td>
                     </tr>
                     <tr>
                       <td>职称</td>
                       <td>&#12288;
                         <input type="text" name="applyUser_title" value="${resultMap.applyUser_title }" class="validate[required] inputText" style="width: 80%"/>
                        <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                       </td>
                       <td>专业</td>
                       <td >&#12288;
                         <input type="text" name="applyUser_major" value="${resultMap.applyUser_major }" class="validate[required] inputText" style="width: 80%"/>
                         <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                       </td>
                        <td >毕业单位</td>
                       <td colspan="3">&#12288;
                         <input type="text" name="applyUser_graduateOrg" value="${resultMap.applyUser_graduateOrg }" class="inputText" style="width: 80%"/>
                       </td>
                     </tr>
                     <tr>
                       <td>外语语种</td>
                       <td>&#12288;
                          <input type="text" name="applyUser_foreignLanguageType" value="${resultMap.applyUser_foreignLanguageType }" class="inputText" style="width: 85%"/>
                       </td>
                       <td>熟练程度</td>
                       <td colspan="5">
                          &#12288;<input type="radio" name="applyUser_skillful" id="applyUser_skillful_jt" value="jt" <c:if test="${resultMap.applyUser_skillful eq 'jt'}">checked="checked"</c:if>/><label for="applyUser_skillful_jt">精通</label>
                          &#12288;<input type="radio" name="applyUser_skillful" id="applyUser_skillful_sl" value="sl" <c:if test="${resultMap.applyUser_skillful eq 'sl'}">checked="checked"</c:if>/><label for="applyUser_skillful_sl">熟练</label>
                          &#12288;<input type="radio" name="applyUser_skillful" id="applyUser_skillful_lh" value="lh" <c:if test="${resultMap.applyUser_skillful eq 'lh'}">checked="checked"</c:if>/><label for="applyUser_skillful_lh">良好</label>
                          &#12288;<input type="radio" name="applyUser_skillful" id="applyUser_skillful_yb" value="yb" <c:if test="${resultMap.applyUser_skillful eq 'yb'}">checked="checked"</c:if>/><label for="applyUser_skillful_yb">一般</label>
                       </td>
                     </tr>
                     <tr>
                      <td>曾获奖励及荣誉称号</td>
                       <td colspan="5">
                          <textarea  placeholder="此处填写曾获奖励及荣誉称号情况" style="height:120px;" class="xltxtarea" name="applyUser_rewardHistory" >${resultMap.applyUser_rewardHistory}</textarea>
                       </td>
                     </tr>
                     <tr>
                       <td>参加本项目的起止时间</td>
                       <td colspan="5">
                           <input class="validate[required] inputText" style="width:20%;" type="text" name="applyUser_joinStartTime" value="${resultMap.applyUser_joinStartTime}" onClick="WdatePicker({dateFmt:'yyyy-MM'})"  readonly="readonly"/>&#12288;<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>&#12288;至&#12288;
                           
                          <input class="validate[required] inputText" style="width:20%;" type="text" name="applyUser_joinEndTime" value="${resultMap.applyUser_joinEndTime}" onClick="WdatePicker({dateFmt:'yyyy-MM'})"  readonly="readonly"/>
                          <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                       </td>
                     </tr>
                     <tr>
                       <td>所做贡献</td>
                       <td colspan="5">
                         <textarea style="height:120px;" placeholder="此处填写所做贡献情况" class="xltxtarea" name="applyUser_devote" >${resultMap.applyUser_devote}</textarea>
                       </td>
                     </tr>
                 </tbody>
           </table>
           <div class="button">
		   	<input class="search" id="sv" type="button" onclick="save();" value="保&#12288;存"/>
      	   </div>
           </form>
         </div>
        
     </div> 	
   </div>
</div>
</body>



</html>