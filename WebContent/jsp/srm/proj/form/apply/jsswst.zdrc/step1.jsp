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
</head>
<body>
<div id="main">
	<div class="mainright">
		<div class="content">
       <div style="margin-top: 10px;">
	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step1" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		<font style="font-size: 14px; font-weight:bold;color: #333;">一、个人情况</font>
		<table class="basic" style="width: 100%; margin-top: 10px;" >
			<tr>
				<th colspan="6" style="text-align: left;padding-left: 20px;">个人情况</th>
			</tr>
			<tr>                             
				<td style="text-align: right;">类别：</td>
				<td>
					<input type="radio" name="category" id="category_ljrc" value="${resultMap.category}" class="inputText" <c:if test="${resultMap.category eq '领军人才'}">checked="checked"</c:if>/><label for="category_ljrc">&nbsp;领军人才</label>&nbsp;
					<input type="radio" name="category" id="category_zdrc" value="${resultMap.category}" class="inputText" <c:if test="${resultMap.category eq '重点人才'}">checked="checked"</c:if>/><label for="category_zdrc">&nbsp;重点人才</label>
				</td>
				<td style="text-align: right;">姓名：</td>
				<td><input type="text" name="name" value="${resultMap.name}" class="inputText" style="width: 80%"/></td>
				<td style="text-align: right;">性别：</td>
				<td>
	                <select name="sexId" class="inputText" style="width: 80%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="sex" items="${userSexEnumList}">
	                   		<c:if test="${sex.id != userSexEnumUnknown.id}">
	                   			<option value="${sex.id}" <c:if test="${resultMap.sexId eq sex.id}">selected="selected"</c:if>>${sex.name}</option>
	                   		</c:if>	 
	                   </c:forEach>
	                </select>
           		</td>
			</tr>
			<tr>                      
				<td style="text-align: right;">民族：</td>
				<td><input type="text" name="nation" value="${resultMap.nation}" class="inputText" style="width: 80%"/></td>
				<td style="text-align: right;">出生年月：</td>
				<td><input class="inputText ctime" type="text" name="birthday" value="${resultMap.birthday}" onClick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly" style="width: 80%"/></td>
				<td style="text-align: right;">最终学位：</td>
				<td>
				   <select name="finalDegreeId" class="inputText" style="width: 80%;">
				      <option value="">请选择</option>
				      <c:forEach var="dict" items="${dictTypeEnumUserDegreeList}">
				      <option value="${dict.dictId}" <c:if test="${resultMap.finalDegreeId eq dict.dictId}">selected="selected"</c:if>>${dict.dictName}</option> 
				      </c:forEach>
				   </select> 
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">授予时间：</td>
				<td><input class="inputText ctime" type="text" name="awardTime" value="${resultMap.awardTime}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 80%"/></td>
				<td style="text-align: right;">授予单位：</td>
				<td><input type="text" name="awardOrg" value="${resultMap.awardOrg}" class="inputText" style="width: 80%"/></td>
				<td style="text-align: right;">从事专业：</td>
				<td><input type="text" name="engageMajor" value="${resultMap.engageMajor}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>        
				<td style="text-align: right;">行政职务：  </td>
				<td><input type="text" name="administrativePost" value="${resultMap.administrativePost}" class="inputText" style="width: 80%"/></td>
				<td style="text-align: right;">研究生导师：</td>
				<td colspan="3">
					<input type="radio" name="tutor" id="tutor_none" value="${resultMap.category}" class="inputText" /><label for="tutor_none">&nbsp;否</label>&nbsp;
					<input type="radio" name="tutor" id="tutor_bd" value="${resultMap.category}" class="inputText" <c:if test="${resultMap.category eq '博导'}">checked="checked"</c:if>/><label for="tutor_bd">&nbsp;博导</label>&nbsp;
					<input type="radio" name="tutor" id="tutor_sd" value="${resultMap.category}" class="inputText" <c:if test="${resultMap.category eq '硕导'}">checked="checked"</c:if>/><label for="tutor_sd">&nbsp;硕导</label>
				</td>
			</tr>              
			<tr>
				<td style="text-align: right;">专业技术职称：</td>
				<td>
	                 <select name="technologyTitle" class="inputText" style="width: 80%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserTitleList}">
	                   <option value="${dict.dictId }" <c:if test="${resultMap.technologyTitle eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
	                   </c:forEach>
	                </select>
             	</td>
				<td style="text-align: right;">人才培养对象：</td>
				<td><input type="text" name="cultivateObject" value="${resultMap.cultivateObject}" class="inputText" style="width: 80%"/></td>
				<td style="text-align: right;">学术荣誉称号：</td>
				<td><input type="text" name="honorTitle" value="${resultMap.honorTitle}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">学会任职：</td>
				<td colspan="5"><input type="text" name="instituteOfficeHolding" value="${resultMap.instituteOfficeHolding}" class="inputText" style="width: 90%"/></td>
			</tr>
			<tr>     
				<td style="text-align: right;">所在单位：</td>
				<td><input type="text" name="companyPlace" value="${resultMap.companyPlace}" class="inputText" style="width: 80%"/></td>
				<td style="text-align: right;">隶属关系：</td>
				<td><input type="text" name="subordination" value="${resultMap.subordination}" class="inputText" style="width: 80%"/></td>
				<td style="text-align: right;">主管部门：</td>
				<td><input type="text" name="competentDepartment" value="${resultMap.competentDepartment}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">传真：</td>
				<td><input type="text" name="fax" value="${resultMap.fax}" class="inputText" style="width: 80%"/></td>
				<td style="text-align: right;">通讯地址：</td>
				<td><input type="text" name="postalAddress" value="${resultMap.postalAddress}" class="inputText" style="width: 80%"/></td>
				<td style="text-align: right;">邮编：</td>
				<td><input type="text" name="postcode" value="${resultMap.postcode}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>              
				<td style="text-align: right;">联系人：</td>
				<td><input type="text" name="linkman" value="${resultMap.linkman}" class="inputText" style="width: 80%"/></td>
				<td style="text-align: right;">电话：</td>
				<td><input type="text" name="telephone" value="${resultMap.telephone}" class="inputText" style="width: 80%"/></td>
				<td style="text-align: right;">邮箱：</td>
				<td><input type="text" name="mailbox" value="${resultMap.mailbox}" class="inputText" style="width: 80%"/></td>
			</tr>
		</table>
		
		
		
		
		
		
		
		</form>
    <div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
	   <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step2')">下一步</a>
    </div>
		</div>
		</div>
		</div>
		</div>
		</body>
		</html>
		