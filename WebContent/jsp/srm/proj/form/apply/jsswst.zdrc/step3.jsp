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
	<jsp:param name="jquery_ui_combobox" value="true"/>
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
	function nextOpt(step){
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		var form = $('#projForm');
		var action = form.attr('action');
		action+="?nextPageName="+step;
		form.attr("action" , action);
		form.submit();
	}

</script>
<style type="text/css">
 .bs_tb tbody td input{text-align: left;margin-left: 10px;}
</style>
</head>
<body>
<div id="main">
	<div class="mainright">
		<div class="content">
       <div style="margin-top: 10px;">
	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step3" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		<font style="font-size: 14px; font-weight:bold;color: #333; ">三、导师情况</font>   
	 	<table class="basic" style="width: 100%; margin-top: 10px;">
			<tr>
				<th colspan="8" style="text-align: left;padding-left: 20px;">导师</th>
			</tr>           
			<tr>
				<td style="text-align: right;" width="80px;">姓名：</td>
				<td><input type="text" name="instructorName" value="${resultMap.instructorName}" class="inputText" style="width: 80%;"/></td>
				<td style="text-align: right;" width="80px;">性别：</td>
				<td>
	                <select name="instructorSex" class="inputText" style="width: 85%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${userSexEnumList}">
	                   		<c:if test="${dict.id != userSexEnumUnknown.id}">
	                   			<option value="${dict.id}" <c:if test="${resultMap.instructorSex eq dict.id}">selected="selected"</c:if>>${dict.name}</option>
                 					</c:if> 
	                   </c:forEach>
	                </select>
             	</td>
				<td style="text-align: right;" width="100px;">民族：</td>
				<td><input type="text" name="instructorNation" value="${resultMap.instructorNation}" class="inputText" style="width: 80%;"/></td>
				<td style="text-align: right;" width="100px;">出生年月：</td>
				<td><input class="inputText" type="text" name="instructorBirthday" value="${resultMap.instructorBirthday}" onClick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly" style="width: 80%;"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">所在单位：</td>
				<td colspan="3"><input type="text" name="instructorCompanyPlace" value="${resultMap.instructorCompanyPlace}" class="inputText" style="width: 80%"/></td>
				<td style="text-align: right;">邮编：</td>
				<td><input type="text" name="instructorPostcode" value="${resultMap.instructorPostcode}" class="inputText" style="width: 80%;"/></td>
				<td style="text-align: right;">目前从事专业：</td>
				<td><input type="text" name="instructorNowMajor" value="${resultMap.instructorNowMajor}" class="inputText" style="width: 80%;"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">研究方向： </td>
				<td><input type="text" name="instructorResearchDirection" value="${resultMap.instructorResearchDirection}" class="inputText" style="width: 80%"/></td>
				<td style="text-align: right;">研究生导师：</td>
				<td>
					<input type="radio" name="instructorSupervisor" id="instructorSupervisor_bd" value="博导" class="inputText" <c:if test="${resultMap.instructorSupervisor eq '博导'}">checked="checked"</c:if>/><label for="instructorSupervisor_bd">&nbsp;博导</label>&nbsp;
					<input type="radio" name="instructorSupervisor" id="instructorSupervisor_sd" value="硕导" class="inputText" <c:if test="${resultMap.instructorSupervisor eq '硕导'}">checked="checked"</c:if>/><label for="instructorSupervisor_sd">&nbsp;硕导</label>
				</td>
				<td style="text-align: right;">专业技术职称： </td>
				<td>
	                 <select name="instructorJobTitle" class="inputText" style="width: 80%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserTitleList}">
	                   <option value="${dict.dictId }" <c:if test="${resultMap.instructorJobTitle eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
	                   </c:forEach>
	                </select>
             	</td>
				<td style="text-align: right;">学会任职：</td>
				<td><input type="text" name="instructorInstituteOfficeHolding" value="${resultMap.instructorInstituteOfficeHolding}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">学术头衔：</td>
				<td><input type="text" name="instructorAcademicTitle" value="${resultMap.instructorAcademicTitle}" class="inputText" style="width: 80%"/></td>
				<td style="text-align: right;">电话：</td>
				<td><input type="text" name="instructorTelephone" value="${resultMap.instructorTelephone}" class="inputText" style="width: 80%"/></td>
				<td style="text-align: right;">传真： </td>
				<td><input type="text" name="instructorFax" value="${resultMap.instructorFax}" class="inputText" style="width: 80%"/></td>
				<td style="text-align: right;">邮箱：</td>
				<td><input type="text" name="instructorMailbox" value="${resultMap.instructorMailbox}" class="inputText" style="width: 80%"/></td>
			</tr>
		</table>
		
		</form>
    <div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
	   <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step2')">上一步</a>
	   <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step4')">下一步</a>
    </div>
		</div>
		</div>
		</div>
		</div>
		</body>
		</html>
		