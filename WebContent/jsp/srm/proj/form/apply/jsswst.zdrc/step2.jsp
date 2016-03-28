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
		<input type="hidden" id="pageName" name="pageName" value="step2" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>

		<font style="font-size: 14px; font-weight:bold;color: #333; ">二、课题情况</font>
		<table class="basic" style="width: 100%; margin-top: 10px;" >
			<tr>
				<th colspan="6" style="text-align: left;padding-left: 20px;">课题</th>
			</tr>           
			<tr>                      
				<td style="text-align: right;">课题名称：</td>
				<td colspan="6"><input type="text" name="problemName" value="${resultMap.problemName}" class="inputText" style="width: 90%"/></td>
			</tr>
			<tr>                      
				<td style="text-align: right;">研究类别：</td>
				<td>
					<select name="researchCategory" class="inputText" style="width: 80%">
						<option value="">请选择</option>
						<option value="基础研究" <c:if test="${resultMap.researchCategory eq '基础研究'}">selected="selected"</c:if>>基础研究</option>
						<option value="应用研究" <c:if test="${resultMap.researchCategory eq '应用研究'}">selected="selected"</c:if>>应用研究</option>
						<option value="开发研究" <c:if test="${resultMap.researchCategory eq '开发研究'}">selected="selected"</c:if>>开发研究</option>
					</select>
				</td>
				<td style="text-align: right;">起止时间：</td>
				<td colspan="3">
					<input class="inputText ctime" type="text" name="startDate" value="${resultMap.startDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 30%;margin-right: 0px;"/>
					 ~ <input class="inputText ctime" type="text" name="endDate" value="${resultMap.endDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 30%;margin-right: 0px;"/>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">其他资助：</td>
				<td>
					<input type="radio" name="otherSubsidize" id="otherSubsidize_ljrc" value="领军人才" class="inputText" <c:if test="${resultMap.otherSubsidize eq '领军人才'}">checked="checked"</c:if>/><label for="otherSubsidize_ljrc">&nbsp;领军人才</label>&nbsp;
					<input type="radio" name="otherSubsidize" id="otherSubsidize_zdrc" value="重点人才" class="inputText" <c:if test="${resultMap.otherSubsidize eq '重点人才'}">checked="checked"</c:if>/><label for="otherSubsidize_zdrc">&nbsp;重点人才</label>
				</td>
				<td style="text-align: right;">单位：</td>
				<td><input type="text" name="company" value="${resultMap.company}" class="inputText" style="width: 80%"/></td>
				<td style="text-align: right;">金额（万元）：</td>
				<td><input type="text" name="money" value="${resultMap.money}" class="validate[custom[number]] inputText" style="width: 80%"/></td>
			</tr>
		</table>
		<br/>
		<table class="bs_tb" style="width: 100%">
			<tr>
				<th class="theader" style="text-align:center;"></th>
				<th class="theader" style="text-align:center;">姓名</th>
				<th class="theader" style="text-align:center;">性别</th>
				<th class="theader" style=" width: 50px;text-align:center;">年龄</th>
				<th class="theader" style="text-align:center;">专业</th>
				<th class="theader" style="text-align:center;">职称</th>
				<th class="theader" style="text-align:center;">单位</th>
			</tr>
			<tr>
				<td>第2负责人</td>
				<td><input type="text" name="name2" value="${resultMap.name2}" class="inputText" style="width: 80%;"/></td>
				<td>
	                <select name="sex2" class="inputText" style="width: 80%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="sex" items="${userSexEnumList}">
	                   		<c:if test="${sex.id != userSexEnumUnknown.id}">
	                   			<option value="${sex.id}" <c:if test="${resultMap.sex2 eq sex.id}">selected="selected"</c:if>>${sex.name}</option>
	                   		</c:if>	 
	                   </c:forEach>
	                </select>
           		</td>
				<td><input type="text" name="age2" value="${resultMap.age2}" class="validate[custom[integer]] inputText" style="width: 80%;"/></td>
				<td><input type="text" name="major2" value="${resultMap.major2}" class="inputText" style="width: 80%;"/></td>
				<td>
	                 <select name="jobTitle2" class="inputText" style="width: 80%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserTitleList}">
	                   <option value="${dict.dictId }" <c:if test="${resultMap.jobTitle2 eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
	                   </c:forEach>
	                </select>
             	</td>
				<td><input type="text" name="company2" value="${resultMap.company2}" class="inputText" style="width: 80%;"/></td>
			</tr>
			<tr>
				<td>第3负责人</td>
				<td><input type="text" name="name3" value="${resultMap.name3}" class="inputText" style="width: 80%;"/></td>
				<td>
	                <select name="sex3" class="inputText" style="width: 80%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="sex" items="${userSexEnumList}">
	                   		<c:if test="${sex.id != userSexEnumUnknown.id}">
	                   			<option value="${sex.id}" <c:if test="${resultMap.sex3 eq sex.id}">selected="selected"</c:if>>${sex.name}</option>
	                   		</c:if>	 
	                   </c:forEach>
	                </select>
           		</td>
				<td><input type="text" name="age3" value="${resultMap.age3}" class="validate[custom[integer]] inputText" style="width: 80%;"/></td>
				<td><input type="text" name="major3" value="${resultMap.major3}" class="inputText" style="width: 80%;"/></td>
				
				<td>
	                 <select name="jobTitle3" class="inputText" style="width: 80%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserTitleList}">
	                   <option value="${dict.dictId }" <c:if test="${resultMap.jobTitle3 eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
	                   </c:forEach>
	                </select>
             	</td>
				<td><input type="text" name="company3" value="${resultMap.company3}" class="inputText" style="width: 80%;"/></td>
			</tr>
			
		</table>
		
		
		</form>
    <div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
	   <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step1')">上一步</a>
	   <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step3')">下一步</a>
    </div>
		</div>
		</div>
		</div>
		</div>
		</body>
		</html>
		