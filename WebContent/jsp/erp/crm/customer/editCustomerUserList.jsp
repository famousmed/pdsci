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
$(document).ready(function(){
	if($("#customerUserTb tr").length<=0){
		add();
	}
});

function add(){
	$("#noRecord").hide();
	$('#customerUserTb').append($("#clone tr:eq(0)").clone());
}

function del(){
	var checkboxs = $("#customerUserTb input[name='userFlow']:checked");
	if(checkboxs.length == 0){
		jboxTip("请勾选要删除的！");
		return false;
	}
	jboxConfirm("确认删除？", function() {
		checkboxs.each(function(){
			$(this).parent().parent().remove();
		});
	});
}


function save(){
	if($("#customerUserTb tr").length<=0){
		jboxTip("请添加联系人！");
		return false;
	}
	var trs = $("#customerUserTb").children();
	var datas = [];
	$.each(trs, function(i,n){
		var userFlow = $(n).find("input[name='userFlow']").val();
		var deptName = $(n).find("input[name='deptName']").val();
		var postName = $(n).find("input[name='postName']").val();
		var userName = $(n).find("input[name='userName']").val();
		var sexId = $(n).find("select[name='sexId']").val();
		var idNo = $(n).find("input[name='idNo']").val();
		var birthday = $(n).find("input[name='birthday']").val();
		var userQq = $(n).find("input[name='userQq']").val();
		var userTelphone = $(n).find("input[name='userTelphone']").val();
		var userCelphone = $(n).find("input[name='userCelphone']").val();
		var userEmail = $(n).find("input[name='userEmail']").val();
		var isMain = $(n).find("select[name='isMain']").val();
		var remark = $(n).find("input[name='remark']").val();
		var data={
			"userFlow":userFlow,
			"deptName":deptName, 
			"postName":postName, 
			"userName":userName, 
			"sexId":sexId, 
			"birthday":birthday, 
			"userQq":userQq, 
			"idNo":idNo,
			"userTelphone":userTelphone, 
			"userCelphone":userCelphone, 
			"userEmail":userEmail, 
			"isMain":isMain, 
			"remark":remark
		};
		if(deptName=="" && postName=="" && userName=="" && userQq=="" && userTelphone=="" && userCelphone=="" && userEmail=="" && isMain=="" && remark==""){
			$(n).remove();
		}else{
			datas.push(data);
		};
	});
	
	if (datas.length <= 0) {
		jboxTip("请添加联系人！");
		return false;
	}
	
	if(false == $("#customerUserForm").validationEngine("validate")){
		return false;
	}
	var requestData = {"customerUserList":datas};
	$("#saveButton").attr("disabled",true);
	var url = "<s:url value='/erp/crm/saveCustomerUserList'/>?customerFlow=${customerFlow}";
	jboxPostJson(
			url,
			JSON.stringify(requestData),
			function(resp){
				if(resp == "${GlobalConstant.SAVE_SUCCESSED}"){
					window.parent.frames['jbox-message-iframe'].window.searchUserList();
					jboxClose();
				}
			}, null, true);
}

function writeBirthday(obj){	
	var idNo = obj.value;
	var birthDayObj = $(obj).parent().next().children();
	if(idNo.length==15){
		birthDayObj.val("19"+idNo.substr(6,2)+"-"+idNo.substr(8,2)+"-"+idNo.substr(10,2)); 	
	}else if(idNo.length==18){
		birthDayObj.val(idNo.substr(6,4)+"-"+idNo.substr(10,2)+"-"+idNo.substr(12,2));
	}
}

function checkCustomerUserName(obj,userFlow,username){
	var userName = $(obj).val();
	if(userName != ""){
		//判断当前页面是否已有重复姓名
		var num = 0;
		$("[name='userName']").each(function(){
			if(userName == $(this).val()){
				num++;
			}
		}); 
		if (num>1) {
			$(obj).focus();
			if (userFlow != "") {
				$(obj).val(username);
			} else {
				$(obj).val("");
			}
			jboxInfo("当前客户已存在该联系人，不能重复添加!");
			return false;
		}
		//判断是否已存在该联系人
		var oldName = $(obj).attr("oldName");
		if(userName == oldName){
			$(obj).focus();
			if (userFlow != "") {
				$(obj).val(username);
			} else {
				$(obj).val("");
			}
			jboxInfo("当前客户已存在该联系人，不能重复添加!");
			return false;
		}
		var data = {
				userFlow:userFlow,
				userName:userName
			};
		var url = "<s:url value='/erp/crm/customerUserNameConfirm'/>?customerFlow=${customerFlow}";
		jboxPost(url, data,
				function(resp){
					if(resp == "${GlobalConstant.OPRE_FAIL}"){
						$(obj).focus();
						if (userFlow != "") {
							$(obj).val(username);
						} else {
							$(obj).val("");
						}
						$(obj).attr("oldName",userName);
						jboxInfo("当前客户已存在该联系人，不能重复添加!");
						return false;
					}
				},null,false);
	}
}
</script>
</head>
<body>
<div class="mainright">
<div class="content">
	<div class="title1 clearfix">
			<form id="customerUserForm">
				<table cellpadding="0" cellspacing="0" class="xllist nofix" style="width: 100%;">
					<colgroup>
						<col width="3%"/>
						<col width="6%"/>
						<col width="4%"/>
						<col width="7%"/>
						<col width="8%"/>
						<col width="12%"/>
						<col width="7%"/>
						<col width="10%"/>
						<col width="9%"/>
						<col width="10%"/>
						<col width="9%"/>
						<col width="5%"/>
						<col width="7%"/>
						<col width="5%"/>
					</colgroup>
					<tr>
						<th colspan="19" style="text-align: left;padding-left: 10px">联系人信息
							<img title="删除" src="<s:url value="/css/skin/${skinPath}/images/del1.png" />" style="float: right;margin-right: 20px;cursor: pointer;" onclick="del();"/>
							<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="float: right;margin-right: 10px;cursor: pointer;" onclick="add();"/>
						</th>
					</tr>
					<tr>
						<th></th>
						<th><span style="color: red">*</span>&nbsp;姓名</th>
						<th>性别</th>
						<th>科室</th>
						<th>职务</th>
						<th>身份证号</th>
						<th>出生日期</th>
						<th>固话</th>
						<th>手机</th>		
						<th>邮箱</th>
						<th>QQ</th>
						<th>部门负责人</th>
						<th>备注</th>		
					</tr>
					<c:if test="${empty customerUserList}">
						<tr id="noRecord">
							<td colspan="11">无记录</td>
						</tr>
					</c:if>
					<tbody id="customerUserTb">
						<c:forEach items="${customerUserList}"  var="user">
						<tr>
							<td width="3%;"></td>
							<td width="6%;">
								<input type="hidden" name="userFlow" value="${user.userFlow}"/>
								<input type="text" name="userName" value="${user.userName}" oldName="" class="validate[required,maxSize[10]] inputText"
								 onchange="checkCustomerUserName(this,'${user.userFlow}','${user.userName}');" style="width:97%;"/>
							</td>
							<td width="4%;">
								<select name="sexId" class="inputText" style="width:97%;">
									<option value=""></option>
									<c:forEach var="userSex" items="${userSexEnumList}">
										<c:if test="${userSex.id != userSexEnumUnknown.id}">
											<option value="${userSex.id}"  <c:if test="${user.sexId eq userSex.id}">selected="selected"</c:if>>${userSex.name}</option>
										</c:if>
									</c:forEach>
								</select>
							</td>
							<td width="7%;"><input type="text" name="deptName" value="${user.deptName}" class="validate[maxSize[50]] inputText" style="width:97%;"/></td>
							<td width="8%;"><input name="postName" value="${user.postName}" type="text" class="validate[maxSize[25]] inputText" style="width:97%;"/></td>
							<td width="12%;"><input name="idNo" value="${user.idNo}" type="text" class="validate[custom[chinaId]] inputText" style="width:97%;" onblur="writeBirthday(this);"/></td>
							<td width="7%;">
								<input name="birthday" value="${user.birthday}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:97%;" class="validate[custom[dateFormat]] inputText" type="text"/>
							</td>
							<td width="10%;"><input name="userTelphone" value="${user.userTelphone}" type="text" class="validate[custom[phone2]] inputText" style="width:97%;"/></td>
							<td width="9%;"><input name="userCelphone" value="${user.userCelphone}" type="text" class="validate[custom[mobile]] inputText" style="width:97%;"/></td>
							<td width="10%;"><input name="userEmail" value="${user.userEmail}" type="text" class="validate[custom[email],maxSize[50]] inputText" style="width:97%;"/></td>
							<td width="9%;"><input name="userQq" value="${user.userQq}" type="text" class="validate[custom[qq]] inputText" style="width:97%;"/></td>
							<td width="7%;">
								<select name="isMain" class="inputText" style="width:97%;">
									<option value=""></option>
									<option value="${GlobalConstant.FLAG_Y}" <c:if test="${user.isMain eq GlobalConstant.FLAG_Y}">selected="selected"</c:if>>是</option>
									<option value="${GlobalConstant.FLAG_N}" <c:if test="${user.isMain eq GlobalConstant.FLAG_N}">selected="selected"</c:if>>否</option>
								</select>
							</td>
							<td width="5%;"><input name="remark" value="${user.remark}" type="text" class="validate[maxSize[100]] inputText" style="width:97%;"/></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				<div class="button" style="width: 100%;">
					<input class="search" type="button" value="保&#12288;存" id="saveButton" onclick="save();" />
					<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
				</div>
			</form>
			</div>
		</div>
	</div>
<table style="display: none;" id="clone">
	<tr>
		<td width="3%;"><input type="checkbox" name="userFlow" value=""/></td>
		<td width="6%;"><input type="text" name="userName" oldName="" class="validate[required,maxSize[10]] inputText" onchange="checkCustomerUserName(this,'','');" style="width:97%;"/></td>
		<td width="4%;">
			<select name="sexId" class="inputText" style="width:97%;">
				<c:forEach var="userSex" items="${userSexEnumList}">
					<c:if test="${userSex.id != userSexEnumUnknown.id}">
						<option value="${userSex.id}" >${userSex.name}</option>
					</c:if>
				</c:forEach>
				<option value=""></option>
			</select>
		</td>
		<td width="7%;"><input type="text" name="deptName" class="validate[maxSize[50]] inputText" style="width:97%;"/></td>
		<td width="8%;"><input name="postName" type="text" class="validate[maxSize[25]] inputText" style="width:97%;"/></td>
		<td width="12%;"><input name="idNo" type="text" class="validate[custom[chinaId]] inputText" style="width:97%;" onblur="writeBirthday(this);"/></td>
		<td width="7%;">
			<input name="birthday" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:97%;" class="validate[custom[dateFormat]] inputText" type="text"/>
		</td>
		<td width="10%;"><input name="userTelphone" type="text" class="validate[custom[phone2]] inputText" style="width:97%;"/></td>
		<td width="9%;"><input name="userCelphone" type="text" class="validate[custom[mobile]] inputText" style="width:97%;"/></td>
		<td width="10%;"><input name="userEmail" type="text" class="validate[custom[email],maxSize[50]] inputText" style="width:97%;"/></td>
		<td width="9%;"><input name="userQq" type="text" class="validate[custom[qq]] inputText" style="width:97%;"/></td>
		<td width="7%;">
			<select name="isMain" class="inputText" style="width:97%;">
				<option value=""></option>
				<option value="${GlobalConstant.FLAG_Y}">是</option>
				<option value="${GlobalConstant.FLAG_N}">否</option>
			</select>
		</td>
		<td width="5%;"><input name="remark" type="text" class="validate[maxSize[100]] inputText" style="width:97%;"/></td>
	</tr>
</table>
</body>
</html>