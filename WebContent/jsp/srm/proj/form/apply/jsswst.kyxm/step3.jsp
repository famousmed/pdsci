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
</script>
</c:if>
  
	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm" style="position:relative;">
		<input type="hidden" id="pageName" name="pageName" value="step3" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
	    <font style="font-size: 14px; font-weight:bold; ">三、课题组总体情况</font>
		<table width="100%" class="basic" style="margin: 20px 0px;">
			<tr>
				<td style="text-align: right;">人员总数：</td>
				<td colspan="3">
					<input type="text" name="userCount" class="validate[custom[integer]] inputText" value="${resultMap.userCount}" style="width: 50px;"/>人
					&#12288;【高级：<input type="text" name="grade1" class="validate[custom[integer]] inputText" value="${resultMap.grade1}" style="width: 50px;"/>人
					&#12288;&#12288;中级：<input type="text" name="grade2" class="validate[custom[integer]] inputText" value="${resultMap.grade2}" style="width: 50px;"/>人
					&#12288;&#12288;初级：<input type="text" name="grade3" class="validate[custom[integer]] inputText" value="${resultMap.grade3}" style="width: 50px;"/>人
					&#12288;&#12288;其他：<input type="text" name="grade4" class="validate[custom[integer]] inputText" value="${resultMap.grade4}" style="width: 50px;"/>人】
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">其中研究生：</td>
				<td colspan="3">
					<input type="text" name="postgraduate" class="validate[custom[integer]] inputText" value="${resultMap.postgraduate}" style="width: 50px;"/>人
					&#12288;【博士后：<input type="text" name="postgraduateDegree1" class="validate[custom[integer]] inputText" value="${resultMap.postgraduateDegree1}" style="width: 50px;"/>人
					&#12288;&#12288;博士生：<input type="text" name="postgraduateDegree2" class="validate[custom[integer]] inputText" value="${resultMap.postgraduateDegree2}" style="width: 50px;"/>人
					&#12288;&#12288;硕士生：<input type="text" name="postgraduateDegree3" class="validate[custom[integer]] inputText" value="${resultMap.postgraduateDegree3}" style="width: 50px;"/>人】
				</td>
			</tr>
		</table>
		
		<fieldset>
			<legend>第二、三负责人</legend>
			<table width="100%" class="basic" style="margin: 20px 0px;">
				<tr>
					<td style="text-align: right;">姓名：</td>
					<td><input type="text" name="userName2" class="inputText" value="${resultMap.userName2}" style="width: 90%;"/></td>
					<td style="text-align: right;">性别：</td>
					<td>
	                   <c:forEach var="dict" items="${userSexEnumList}">
	                   		<c:if test="${dict.id != userSexEnumUnknown.id}">
	                   			<input type="radio" name="gender2" value="${dict.name}" <c:if test="${resultMap.gender2 eq dict.name}">checked="checked"</c:if> id="gender2_${dict.id}"/><label for="gender2_${dict.id}">&nbsp;${dict.name}</label>&#12288;
	                   		</c:if>	 
	                   </c:forEach>
					</td>
					<td style="text-align: right;">出生年月：</td>
					<td><input type="text" name="birthday2" onclick="WdatePicker({dateFmt:'yyyy-MM'})"  class="inputText ctime" value="${resultMap.birthday2}" style="width: 120px;margin-right: 0px;" readonly="readonly"/></td>
					<td style="text-align: right;">职务：</td>
					<td>
						<select name="post2" class="inputText" style="width: 90%;">
							<option value="">请选择</option>
							<c:forEach var="dict" items="${dictTypeEnumUserPostList}">
							<option value="${dict.dictName}" <c:if test="${resultMap.post2 eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">职称：</td>
					<td width="15%">
						<select name="title2" class="inputText" style="width: 90%;">
							<option value="">请选择</option>
							<c:forEach var="dict" items="${dictTypeEnumUserTitleList }">
							<option value="${dict.dictName}" <c:if test="${resultMap.title2 eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
							</c:forEach>
						</select>
					</td>
					<td style="text-align: right;">工作单位：</td>
					<td colspan="3"><input type="text" name="orgName2" class="inputText" value="${resultMap.orgName2}" style="width: 90%;"/></td>
					<td style="text-align: right;">从事专业：</td>
					<td><input type="text" name="major2" class="inputText" value="${resultMap.major2}" style="width: 90%;"/></td>
				</tr>
			</table>
			
			<table width="100%" class="basic" style="margin: 20px 0px;">
				<tr>
					<td style="text-align: right;">姓名：</td>
					<td><input type="text" name="userName3" class="inputText" value="${resultMap.userName3}" style="width: 90%;"/></td>
					<td style="text-align: right;">性别：</td>
					<td>
	                   <c:forEach var="dict" items="${userSexEnumList}">
	                   		<c:if test="${dict.id != userSexEnumUnknown.id}">
	                   			<input type="radio" name="gender3" value="${dict.name}" <c:if test="${resultMap.gender3 eq dict.name}">checked="checked"</c:if> id="gender3_${dict.id}"/><label for="gender3_${dict.id}">&nbsp;${dict.name}</label>&#12288;
	                   		</c:if>	 
	                   </c:forEach>
					</td>
					<td style="text-align: right;">出生年月：</td>
					<td><input type="text" name="birthday3" onclick="WdatePicker({dateFmt:'yyyy-MM'})"  class="inputText ctime" value="${resultMap.birthday3}" style="width: 120px;margin-right: 0px;" readonly="readonly"/></td>
					<td style="text-align: right;">职务：</td>
					<td>
						<select name="post3" class="inputText" style="width: 90%;">
							<option value="">请选择</option>
							<c:forEach var="dict" items="${dictTypeEnumUserPostList}">
							<option value="${dict.dictName}" <c:if test="${resultMap.post3 eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">职称：</td>
					<td width="15%">
						<select name="title3" class="inputText" style="width: 90%;">
							<option value="">请选择</option>
							<c:forEach var="dict" items="${dictTypeEnumUserTitleList }">
							<option value="${dict.dictName}" <c:if test="${resultMap.title3 eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
							</c:forEach>
						</select>
					</td>
					<td style="text-align: right;">工作单位：</td>
					<td colspan="3"><input type="text" name="orgName3" class="inputText" value="${resultMap.orgName3}" style="width: 90%;"/></td>
					<td style="text-align: right;">从事专业：</td>
					<td><input type="text" name="major3" class="inputText" value="${resultMap.major3}" style="width: 90%;"/></td>
				</tr>
			</table>
		</fieldset>
	</form>
	
    <div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
        <input type="button" onclick="nextOpt('step2')" class="search" value="上一步"/>
	    <input type="button" onclick="nextOpt('step4')" class="search" value="下一步"/>
    </div>

		