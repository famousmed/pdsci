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
  
	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm" style="position:relative;">
		<input type="hidden" id="pageName" name="pageName" value="step1" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
	    <font style="font-size: 14px; font-weight:bold; ">一、基本信息</font>
		<table width="100%" class="basic" style="margin: 20px 0px;">
			<tr>
				<td style="text-align: right;">项目名称：</td>
				<td colspan="3"><input type="text" name="projName" class="inputText" value="${empty resultMap.projName?proj.projName:resultMap.projName}" style="width: 90%;"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">计划类别：</td>
				<td>
					<select name="planCategory" class="inputText" style="width: 90%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumJsPlanCategoryList}">
						<option value="${dict.dictName}" <c:if test="${resultMap.planCategory eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
						</c:forEach>
					</select> 
				</td>
				<td style="text-align: right;">申请类型：</td>
				<td>
					<select name="applyType" class="inputText" style="width: 90%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumJsApplyTypeList}">
						<option value="${dict.dictName}" <c:if test="${resultMap.applyType eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">起止时间：</td>
				<td  colspan="3">
					<input type="text" name="projStratTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="inputText ctime" value="${empty resultMap.projStratTime?proj.projStartTime:resultMap.projStratTime}" style="width: 150px;margin-right: 0px;" readonly="readonly"/>
					~&nbsp;<input type="text" name="projEndTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="inputText ctime" value="${empty resultMap.projEndTime?proj.projEndTime:resultMap.projEndTime}" style="width: 150px;" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">审核部门：</td>
				<td><input type="text" name="chargeOrgName" class="inputText" value="${empty resultMap.chargeOrgName?proj.chargeOrgName:resultMap.chargeOrgName}" style="width: 90%;"/></td>
				<td style="text-align: right;">申报学科：</td>
				<td><input type="text" name="subjectName" class="inputText" value="${empty resultMap.subjectName?projInfoMap.subjectName:resultMap.subjectName}" style="width: 90%;"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">项目联系人：</td>
				<td><input type="text" name="applyUserName" class="inputText" value="${empty resultMap.applyUserName?sessionScope.currUser.userName:resultMap.applyUserName}" style="width: 90%;"/></td>
				<td style="text-align: right;">电话：</td>
				<td><input type="text" name="userPhone" class="inputText" value="${empty resultMap.userPhone?sessionScope.currUser.userPhone:resultMap.userPhone}" onchange="checkTeltphone(this)" style="width: 90%;"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">Email：</td>
				<td colspan="3"><input type="text" name="userEmail" class="validate[custom[email]] inputText" value="${empty resultMap.userEmail?sessionScope.currUser.userEmail:resultMap.userEmail}" style="width: 90%;"/></td>
			</tr>
		</table>
		
		<hr/>
		
		<table width="100%" class="basic" style="margin: 20px 0px;">	
			<tr>
				<td style="text-align: right;">单位名称：</td>
				<td colspan="7"><input type="text" name="applyOrgName" class="inputText" value="${empty resultMap.applyOrgName?proj.applyOrgName:resultMap.applyOrgName}" style="width: 90%;"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">单位性质：</td>
				<td colspan="3">
					<select name="orgCharacter0" class="inputText" style="width: 90%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumJsOrgCharacterList}">
						<option value="${dict.dictName}" <c:if test="${resultMap.orgCharacter0 eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
						</c:forEach>
					</select>
				</td>
				<td style="text-align: right;">隶属关系：</td>
				<td colspan="3">
					<select name="subordinateRelation" class="inputText" style="width: 90%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumJsSubordinateRelationList}">
						<option value="${dict.dictName}" <c:if test="${resultMap.subordinateRelation eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">依托类型：</td>
				<td colspan="3">
					<select name="relyType" class="inputText" style="width: 90%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumJsRelyTypeList}">
						<option value="${dict.dictName}" <c:if test="${resultMap.relyType eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
						</c:forEach>
					</select>
				</td>
				<td style="text-align: right;">所在地区：</td>
				<td colspan="3"><input type="text" name="district" class="inputText" value="${resultMap.district}" style="width: 90%;"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">单位地址：</td>
				<td colspan="7"><input type="text" name="orgAddress" class="inputText" value="${resultMap.orgAddress}" style="width: 90%;"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">单位法人：</td>
				<td width="15%"><input type="text" name="legalPerson" class="inputText" value="${resultMap.legalPerson}" style="width: 90%;"/></td>
				<td style="text-align: right;">职务：</td>
				<td width="15%">
					<select name="legalPersonPost" class="inputText" style="width: 90%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumUserPostList }">
						<option value="${dict.dictName}" <c:if test="${resultMap.legalPersonPost eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
						</c:forEach>
					</select> 
				</td>
				<td style="text-align: right;">职称：</td>
				<td width="15%">
					<select name="legalPersonTitle" class="inputText" style="width: 90%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumUserTitleList }">
						<option value="${dict.dictName}" <c:if test="${resultMap.legalPersonTitle eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
						</c:forEach>
					</select>
				</td>
				<td style="text-align: right;">电话：</td>
				<td width="15%"><input type="text" name="legalPersonTelephone" class="inputText" onchange="checkTeltphone(this)" value="${resultMap.legalPersonTelephone}" style="width: 90%;"/></td>
			</tr>
		</table>
		
		<hr/>
		
		<table width="100%" class="basic" style="margin-top: 20px;">	
			<tr>
				<td style="text-align: right;">合作单位1：</td>
				<td><input type="text" name="cooperationOrg1" class="inputText" value="${resultMap.cooperationOrg1}" style="width: 90%;"/></td>
				<td style="text-align: right;">单位性质：</td>
				<td>
					<select name="orgCharacter1" class="inputText" style="width: 90%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumJsOrgCharacterList}">
						<option value="${dict.dictName}" <c:if test="${resultMap.orgCharacter1 eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">合作单位2：</td>
				<td><input type="text" name="cooperationOrg2" class="inputText" value="${resultMap.cooperationOrg2}" style="width: 90%;"/></td>
				<td style="text-align: right;">单位性质：</td>
				<td>
					<select name="orgCharacter2" class="inputText" style="width: 90%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumJsOrgCharacterList}">
						<option value="${dict.dictName}" <c:if test="${resultMap.orgCharacter2 eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">合作单位3：</td>
				<td><input type="text" name="cooperationOrg3" class="inputText" value="${resultMap.cooperationOrg3}" style="width: 90%;"/></td>
				<td style="text-align: right;">单位性质：</td>
				<td>
					<select name="orgCharacter3" class="inputText" style="width: 90%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumJsOrgCharacterList}">
						<option value="${dict.dictName}" <c:if test="${resultMap.orgCharacter3 eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
	</form>
    
    <div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
	    <input type="button" onclick="nextOpt('step2')" class="search" value="下一步"/>
    </div>

		