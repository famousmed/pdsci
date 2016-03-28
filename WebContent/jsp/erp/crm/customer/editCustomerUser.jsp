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
	<jsp:param name="jquery_cxselect" value="true"/>
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
function writeBirthday(obj){	
	var idNo = obj.value;
	var birthDayObj = $("input[name='birthday']");
	if(idNo.length==15){
		birthDayObj.val("19"+idNo.substr(6,2)+"-"+idNo.substr(8,2)+"-"+idNo.substr(10,2)); 	
	}else if(idNo.length==18){
		birthDayObj.val(idNo.substr(6,4)+"-"+idNo.substr(10,2)+"-"+idNo.substr(12,2));
	}
}

function save(){
	if(false == $("#customerUserForm").validationEngine("validate")){
		return false;
	}
	$("#saveButton").attr("disabled",true);
	jboxPost("<s:url value='/erp/crm/customerUserNameConfirm'/>",$("#customerUserForm").serialize(),function(resp){
		if(resp == '${GlobalConstant.OPRE_SUCCESSED}'){
			var url = "<s:url value='/erp/crm/saveCustomerUser'/>";
			jboxPost(url, $("#customerUserForm").serialize(),
					function(resp){
						if(resp == "${GlobalConstant.SAVE_SUCCESSED}"){
							window.parent.frames['jbox-message-iframe'].window.searchUserList();
							jboxClose();
						}
					},null,true);
		} else if(resp == "${GlobalConstant.OPRE_FAIL}"){
			jboxInfo("当前客户已存在该联系人，不能重复添加!");
			$("#saveButton").attr("disabled",false);
		}
	},null,false);
}
</script>
</head>
<body>
<div class="mainright">
<div class="content">
	<div class="title1 clearfix">
		<form id="customerUserForm">
				<input type="hidden" name="customerFlow" value="${param.customerFlow}"/>
				<input type="hidden" name="userFlow" value="${customerUser.userFlow}"/>
				<table cellpadding="0" cellspacing="0" class="basic" style="width: 100%;">
					<colgroup>
						<col width="17%"/>
						<col width="35%"/>
						<col width="15%"/>
						<col width="33%"/>
					</colgroup>
					<tr>
						<th colspan="4" style="text-align: left;padding-left: 10px;">联系人详细信息</th>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;"><span style="color: red">*</span>&nbsp;姓&#12288;&#12288;名：</td>
						<td><input type="text" name="userName" value="${customerUser.userName}" class="validate[required,maxSize[10]] inputText" style="width:90%; text-align: left;"/></td>
						<td style="text-align: right;padding-right: 10px;">性&#12288;&#12288;别：</td>
						<td>
							<select name="sexId" class="inputText" style="width:90%;">
								<c:forEach var="userSex" items="${userSexEnumList}">
									<c:if test="${userSex.id != userSexEnumUnknown.id}">
										<option value="${userSex.id}"  <c:if test="${customerUser.sexId eq userSex.id}">selected="selected"</c:if>>${userSex.name}</option>
									</c:if>
								</c:forEach>
								<option value="" <c:if test="${not empty customerUser.userFlow and empty customerUser.sexId}">selected="selected"</c:if>></option>
							</select>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">科&#12288;&#12288;室：</td>
						<td><input type="text" name="deptName" value="${customerUser.deptName}" class="validate[maxSize[50]] inputText" style="width:90%; text-align: left;"/></td>
						<td style="text-align: right;padding-right: 10px;">职&#12288;&#12288;务：</td>
						<td><input name="postName" value="${customerUser.postName}" type="text" class="validate[maxSize[25]] inputText" style="width:90%; text-align: left;"/></td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">身份证号：</td>
						<td><input name="idNo" value="${customerUser.idNo}" type="text" class="validate[custom[chinaId]] inputText" style="width:90%; text-align: left;" onblur="writeBirthday(this);"/></td>
						<td style="text-align: right;padding-right: 10px;">出生日期：</td>
						<td>
							<input name="birthday" value="${customerUser.birthday}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:90%; text-align: left;" class="validate[custom[dateFormat]] inputText" type="text"/>
							
						</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">固&#12288;&#12288;话：</td>
						<td><input name="userTelphone" value="${customerUser.userTelphone}" type="text" class="validate[custom[phone2]] inputText" style="width:90%; text-align: left;"/></td>
						<td style="text-align: right;padding-right: 10px;">手&#12288;&#12288;机：</td>		
						<td><input name="userCelphone" value="${customerUser.userCelphone}" type="text" class="validate[custom[mobile]] inputText" style="width:90%; text-align: left;"/></td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">邮&#12288;&#12288;箱：</td>
						<td><input name="userEmail" value="${customerUser.userEmail}" type="text" class="validate[custom[email],maxSize[50]] inputText" style="width:90%; text-align: left;"/></td>
						<td style="text-align: right;padding-right: 10px;">QQ：</td>
						<td><input name="userQq" value="${customerUser.userQq}" type="text" class="validate[custom[qq]] inputText" style="width:90%; text-align: left;"/></td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">部门负责人：</td>		
						<td>
							<select name="isMain" class="inputText" style="width:90%;">
								<option value=""></option>
								<option value="${GlobalConstant.FLAG_Y}" <c:if test="${customerUser.isMain eq GlobalConstant.FLAG_Y}">selected="selected"</c:if>>是</option>
								<option value="${GlobalConstant.FLAG_N}" <c:if test="${customerUser.isMain eq GlobalConstant.FLAG_N}">selected="selected"</c:if>>否</option>
							</select>
						</td>
						<td style="text-align: right;padding-right: 10px;">备&#12288;&#12288;注：</td>		
						<td><input name="remark" value="${customerUser.remark}" type="text" class="validate[maxSize[100]] inputText" style="width:90%; text-align: left;"/></td>
					</tr>
				</table>
			</form>
			<p style="text-align: center; margin-top: 10px;">
				<input class="search" type="button" value="保&#12288;存" id="saveButton" onclick="save();" />
				<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
			<p>
			</div>
		</div>
	</div>
</body>
</html>