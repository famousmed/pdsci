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
 .bs_tb tbody th{background: #fff;}
 .bs_tb tbody td{text-align: left;}
 .bs_tb tbody td input{text-align: left;margin-left: 10px;}
</style>
</head>
<body>
<div id="main">
	<div class="mainright">
		<div class="content">
       <div style="margin-top: 10px;">
	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step3" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		   
		<font style="font-size: 14px; font-weight:bold;color: #333; ">三、中心主任</font>
		<table class="basic" style="width: 100%">
			<tr>
				<th colspan="8" style="text-align: left;padding-left: 20px;">中心主任、副主任信息</th>
			</tr>
			<tr>
				<td style="text-align: center;">姓名</td>
				<td style="text-align: center;">性别</td>
				<td style="text-align: center;">出生年月</td>
				<td style="text-align: center;">职务</td>
				<td style="text-align: center;">技术职称</td>
				<td style="text-align: center;">业务专业</td>
				<td style="text-align: center;">主要任务</td>
				<td style="text-align: center;">工作单位</td>
			</tr>
			<tr>
				<td><input type="text" name="directorName" value="${resultMap.directorName}" class="inputText" style="width: 80%"/></td>
				<td>
	                <select name="directorSexId" class="inputText" style="width: 90%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="sex" items="${userSexEnumList}">
	                   		<c:if test="${sex.id != userSexEnumUnknown.id}">
	                   			<option value="${sex.id}" <c:if test="${resultMap.directorSexId eq sex.id}">selected="selected"</c:if>>${sex.name}</option>
	                   		</c:if>	 
	                   </c:forEach>
	                </select>
           		</td>
           		<td>
					<input type="text" name="directorBirthday" value="${resultMap.directorBirthday}" onClick="WdatePicker({dateFmt:'yyyy-MM'})"  class="inputText" readonly="readonly" style="width: 80%"/>
				</td>
				<td><input type="text" name="directorPost" value="${resultMap.directorPost}" class="inputText" style="width: 80%"/></td>
				<td>
	                 <select name="directorTechnicalTitle" class="inputText">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserTitleList}">
	                   <option value="${dict.dictId }" <c:if test="${resultMap.directorTechnicalTitle eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
	                   </c:forEach>
	                </select>
             	</td>
				<td><input type="text" name="directorMajor" value="${resultMap.directorMajor}" class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="directorMainTask" value="${resultMap.directorMainTask}" class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="directorWorkOrg" value="${resultMap.directorWorkOrg}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td><input type="text" name="deputyDirectorName" value="${resultMap.deputyDirectorName}" class="inputText" style="width: 80%"/></td>
				<td>
	                <select name="deputyDirectorSexId" class="inputText" style="width: 90%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="sex" items="${userSexEnumList}">
	                   		<c:if test="${sex.id != userSexEnumUnknown.id}">
	                   			<option value="${sex.id}" <c:if test="${resultMap.deputyDirectorSexId eq sex.id}">selected="selected"</c:if>>${sex.name}</option>
	                   		</c:if>	 
	                   </c:forEach>
	                </select>
           		</td>
           		<td>
					<input type="text" name="deputyDirectorBirthday" value="${resultMap.deputyDirectorBirthday}" onClick="WdatePicker({dateFmt:'yyyy-MM'})"  class="inputText" readonly="readonly" style="width: 80%"/>
				</td>
				<td><input type="text" name="deputyDirectorPost" value="${resultMap.deputyDirectorPost}" class="inputText" style="width: 80%"/></td>
				<td>
	                 <select name="deputyDirectorTechnicalTitle" class="inputText" >
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserTitleList}">
	                   <option value="${dict.dictId }" <c:if test="${resultMap.deputyDirectorTechnicalTitle eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
	                   </c:forEach>
	                </select>
             	</td>
				<td><input type="text" name="deputyDirectorMajor" value="${resultMap.deputyDirectorMajor}" class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="deputyDirectorMainTask" value="${resultMap.deputyDirectorMainTask}" class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="deputyDirectorWorkOrg" value="${resultMap.deputyDirectorWorkOrg}" class="inputText" style="width: 80%"/></td>
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
		