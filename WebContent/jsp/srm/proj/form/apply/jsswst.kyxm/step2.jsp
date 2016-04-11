<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
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
	
	function checkTeltphone(obj){
		var r, reg; 
		var s = obj.value;
		reg =/^[1][34578]\w*$/; //正则表达式模式。
		r = reg.test(s); 
		if(r){
			$(obj).addClass("validate[custom[mobile]]");
			$(obj).removeClass("validate[custom[phone2]]");
		}else{
			$(obj).addClass("validate[custom[phone2]]");
			$(obj).removeClass("validate[custom[mobile]]");
		}       
	}
	
	
</script>
</c:if>
<script type="text/javascript">
$(document).ready(function(){
	selectStudyAbroad($("#studyAbroad")[0]);
});

function selectStudyAbroad(obj){
	if(obj.checked){
		$("#studyAbroadTb input").removeAttr("disabled");
		$("#studyAbroadTb select").removeAttr("disabled");
	}else{
		$("#studyAbroadTb input").attr('disabled', "disabled");
		$("#studyAbroadTb select").attr('disabled', "disabled");
	}
}
</script>
  
	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm" style="position:relative;">
		<input type="hidden" id="pageName" name="pageName" value="step2" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
	    <font style="font-size: 14px; font-weight:bold; ">二、项目负责人概况</font>
		<table width="100%" class="basic" style="margin: 20px 0px;">
			<tr>
				<td width="10%" style="text-align: right;">姓名：</td>
				<td width="15%"><input type="text" name="userName" class="inputText" value="${empty resultMap.userName?sessionScope.currUser.userName:resultMap.userName}" style="width: 90%;"/></td>
				<td width="10%" style="text-align: right;">性别：</td>
				<td width="15%">
	                <c:forEach var="dict" items="${userSexEnumList}">
                   		<c:if test="${dict.id != userSexEnumUnknown.id}">
                   			<input type="radio" name="sexName" value="${dict.name}" <c:if test="${resultMap.sexName eq dict.name or sessionScope.currUser.sexName eq dict.name}">checked="checked"</c:if> id="sexName_${dict.id}"/><label for="sexName_${dict.id}">&nbsp;${dict.name}</label>&#12288;
                   		</c:if>	 
                    </c:forEach>
				</td>
				<td width="10%" style="text-align: right;">出生年月：</td>
				<td colspan="3"><input type="text" name="userBirthday" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="inputText ctime" value="${empty resultMap.userBirthday?sessionScope.currUser.userBirthday:resultMap.userBirthday}" style="width: 150px;margin-right: 0px;" readonly="readonly"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">学历：</td>
				<td>
					<select name="educationName" class="inputText" style="width: 90%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserEducationList}">
	                   <option value="${dict.dictName}" <c:if test="${resultMap.educationName eq dict.dictName or sessionScope.currUser.educationName eq dict.dictName}">selected="selected"</c:if>>${dict.dictName}</option> 
	                   </c:forEach>
	                </select>
				</td>
				<td style="text-align: right;">学位：</td>
				<td>
					<select name="degreeName" class="inputText" style="width: 90%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserDegreeList}">
	                   <option value="${dict.dictName}" <c:if test="${resultMap.degreeName eq dict.dictName or sessionScope.currUser.degreeName eq dict.dictName}">selected="selected"</c:if>>${dict.dictName}</option> 
	                   </c:forEach>
	                </select> 
				</td>
				<td style="text-align: right;">职务：</td>
				<td>
					<select name="postName" class="inputText" style="width: 90%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumUserPostList}">
						<option value="${dict.dictName}" <c:if test="${resultMap.postName eq dict.dictName or sessionScope.currUser.postName eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
						</c:forEach>
					</select>
				</td>
				<td style="text-align: right;">职称：</td>
				<td>
					<select name="titleName" class="inputText" style="width: 90%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumUserTitleList}">
						<option value="${dict.dictName}" <c:if test="${resultMap.titleName eq dict.dictName or sessionScope.currUser.titleName eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">从事专业：</td>
				<td colspan="3"><input type="text" name="major" class="inputText" value="${resultMap.major}" style="width: 90%;"/></td>
				<td style="text-align: right;">个人联系电话：</td>
				<td colspan="3"><input type="text" name="userPhone1" class="inputText" value="${empty resultMap.userPhone1?sessionScope.currUser.userPhone:resultMap.userPhone1}" onchange="checkTeltphone(this)" style="width: 90%;"/></td>
			</tr>
		</table>
		
		<fieldset>
			<legend><input type="checkbox" name="studyAbroad" id="studyAbroad" onchange="selectStudyAbroad(this)" value="${GlobalConstant.FLAG_Y}" <c:if test="${resultMap.studyAbroad eq GlobalConstant.FLAG_Y}">checked="checked"</c:if>/>&nbsp;<label for="studyAbroad">留学</label></legend>
			<table id="studyAbroadTb" width="100%" class="basic" style="margin: 20px 0px;">
				<tr>
					<td style="text-align: right;">留学时间：</td>
					<td>
						<select name="studyAbroadTime1" class="inputText" style="width: 90%;">
							<option value="">请选择</option>
							<c:forEach var="dict" items="${dictTypeEnumJsStudyAbroadTimeList}">
							<option value="${dict.dictName}" <c:if test="${resultMap.studyAbroadTime1 eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
							</c:forEach>
						</select>
					</td>
					<td style="text-align: right;">留学国家：</td>
					<td><input type="text" name="studyAbroadCountry1" class="inputText" value="${resultMap.studyAbroadCountry1}" style="width: 90%;"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">留学时间：</td>
					<td>
						<select name="studyAbroadTime2" class="inputText" style="width: 90%;">
							<option value="">请选择</option>
							<c:forEach var="dict" items="${dictTypeEnumJsStudyAbroadTimeList}">
							<option value="${dict.dictName}" <c:if test="${resultMap.studyAbroadTime2 eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
							</c:forEach>
						</select>
					</td>
					<td style="text-align: right;">留学国家：</td>
					<td><input type="text" name="studyAbroadCountry2" class="inputText" value="${resultMap.studyAbroadCountry2}" style="width: 90%;"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">留学时间：</td>
					<td>
						<select name="studyAbroadTime3" class="inputText" style="width: 90%;">
							<option value="">请选择</option>
							<c:forEach var="dict" items="${dictTypeEnumJsStudyAbroadTimeList}">
							<option value="${dict.dictName}" <c:if test="${resultMap.studyAbroadTime3 eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
							</c:forEach>
						</select>
					</td>
					<td style="text-align: right;">留学国家：</td>
					<td><input type="text" name="studyAbroadCountry3" class="inputText" value="${resultMap.studyAbroadCountry3}" style="width: 90%;"/></td>
				</tr>
			</table>
		</fieldset>
		
		<fieldset>
			<legend>近3年承担的在研课题</legend>
			<table width="100%" class="basic" style="margin: 20px 0px;">
				<tr>
					<td width="10%" style="text-align: right;">国家级：</td>
					<td><input type="text" name="researchLesson1" class="validate[custom[integer]] inputText" value="${resultMap.researchLesson1}" style="width: 50px;"/>项</td>
					<td width="10%" style="text-align: right;">省部级：</td>
					<td><input type="text" name="researchLesson2" class="validate[custom[integer]] inputText" value="${resultMap.researchLesson2}" style="width: 50px;"/>项</td>
					<td width="10%" style="text-align: right;">市级：</td>
					<td><input type="text" name="researchLesson3" class="validate[custom[integer]] inputText" value="${resultMap.researchLesson3}" style="width: 50px;"/>项</td>
				</tr>
			</table>
		</fieldset>
	</form>
    <div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
        <input type="button" onclick="nextOpt('step1')" class="search" value="上一步"/>
	    <input type="button" onclick="nextOpt('step3')" class="search" value="下一步"/>
    </div>

		