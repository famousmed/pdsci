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
<script type="text/javascript" src="<s:url value='/js/j.suggest.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
$(document).ready(function(){
	if($("#linkManTb tr").length<=0){
		addLinkMan();
	}
});

function addLinkMan(){
	$('#linkManTb').append($("#clone tr:eq(0)").clone());
}

function delLinkMan(){
	var mIds = $("#linkManTb input[name='id']:checked");
	if(mIds.length == 0){
		jboxTip("请选择一条记录！");
		return false;
	}
	jboxConfirm("确认删除？", function() {
		var recordFlows = [];
		mIds.each(function(){
			var recordFlow = $(this).val();
			if(recordFlow != ''){
				recordFlows.push(recordFlow);
			}
			$(this).parent().parent().remove();
		});
		if (recordFlows.length>0) {
			var url = "<s:url value='/erp/crm/delContractUsers'/>";
			jboxPostJson(url,JSON.stringify(recordFlows),function(res){
				window.parent.frames['jbox-message-iframe'].window.search();
			},null,true);
		} else {
			jboxTip("${GlobalConstant.DELETE_SUCCESSED}");
		}
	});
}

function save(){
	     var contract = $("#contractForm").serializeJson();
		 var linkManTr=$("#linkManTb").children();
		 var linkManDatas=[];
		 $.each(linkManTr , function(i , n){
			   var customerFlow=$(n).find("input[name='customerFlow']").val();
			   var contractFlow=$(n).find("input[name='contractFlow']").val();
			   var recordFlow=$(n).find("input[name='recordFlow']").val();
			   var userFlow=$(n).find("input[name='userFlow']").val();
			   var userName=$(n).find("input[name='userName']").val();
			  /*  var userCategoryId=$(n).find("select[name='userCategoryId']").val(); */
			   var postName=$(n).find("input[name='postName']").val();
			   var sexId=$(n).find("select[name='sexId']").val();
			   var deptName=$(n).find("input[name='deptName']").val();	
			   var userQq=$(n).find("input[name='userQq']").val();
			   var userTelphone=$(n).find("input[name='userTelphone']").val();
			   var userCelphone=$(n).find("input[name='userCelphone']").val();
			   var userEmail=$(n).find("input[name='userEmail']").val();
			   /* var isMain=$(n).find("select[name='isMain']").val(); */
			   var remark=$(n).find("input[name='remark']").val();
			   if(userName=="" && postName==""
				      && deptName=="" && userTelphone=="" && remark==""
				      && userCelphone=="" && userEmail=="" && isMain==""){
					   $(n).remove();
				}else{
					var linkManData={
							"customerFlow":customerFlow,
						    "userFlow":userFlow,
						    "deptName":	deptName,
						    "userName":userName,
						    "postName":postName,
						    "sexId":sexId,
						    "userTelphone":userTelphone,
						    "userCelphone":userCelphone,
						    "userEmail":userEmail,
						    "userQq":userQq,
						    "remark":remark
				   };
				   linkManDatas.push(linkManData);
				}
			   
			});
		
		 if($("#linkManForm").validationEngine("validate")){
			 $("#saveButton").attr("disabled",true);
			 var allData={
					 'contract':contract,
					 'userList':linkManDatas
				};
			 $('#jsondata').val(JSON.stringify(allData));
			
			 var url = "<s:url value='/erp/crm/saveContractUsers'/>";
				jboxSubmit($('#linkManForm'),url,function(resp){
					jboxTip('${GlobalConstant.SAVE_SUCCESSED}');
					setTimeout(function(){
						window.parent.frames['jbox-message-iframe'].window.search();
						jboxClose();
					},1000);
				},
				function(resp){
				},false);
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
	        <form id="contractForm">
	           <input type="hidden" name="contractFlow" value="${param.contractFlow }"/>
	        </form>
			<form id="linkManForm">
			    <input id="jsondata" type="hidden" name="jsondata"/>
				<table cellpadding="0" cellspacing="0" class="xllist" style="width: 100%;">
					<colgroup>
						<col width="4%"/>
						<col width="10%"/>
						<col width="5%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="13%"/>
						<col width="13%"/>
						<col width="13%"/>
					    <col width="10%"/>
						<col width="12%"/>
					</colgroup>
					<tr>
						<th colspan="11" style="text-align: left;padding-left: 10px">联系人信息
							<img title="删除" src="<s:url value="/css/skin/${skinPath}/images/del1.png" />" style="float: right;margin-right: 20px;cursor: pointer;" onclick="delLinkMan();"/>
							<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="float: right;margin-right: 10px;cursor: pointer;" onclick="addLinkMan();"/>
						</th>
					</tr>
					<tr>
						<th></th>
						<th><span class="red">*</span>姓名</th>
						<th>性别</th>
						<th>科室</th>
						<th>职务</th>
						<!-- <th>人员类别</th> -->
						<th>固话</th>
						<th>手机</th>		
						<th>邮箱</th>
						<th>QQ</th>
						<!-- <th>主要联系人</th>	 -->
						<th>备注</th>	
					</tr>
					<tbody id="linkManTb">
					<c:forEach items="${userList }" var="user">
					 <c:if test="${user.recordStatus eq GlobalConstant.RECORD_STATUS_Y }">
					   <tr>
		<td>
		 <input type="checkbox" name="id" value="${user.recordFlow }" /> 
		<%-- <input type="hidden" name="contractFlow" value="${user.contractFlow }"/> --%>
		<input type="hidden" name="userFlow" value="${user.userFlow }"/>
		<input type="hidden" name="recordFlow" value="${user.recordFlow }"/>
		<input type="hidden" name="customerFlow" value="${customerUserMap[user.userFlow].customerFlow }"/>
		</td>
		<td><input type="text" class="inputText validate[required,maxSize[10]]" name="userName" oldName=""
		onchange="checkCustomerUserName(this,'${user.userFlow}','${customerUserMap[user.userFlow].userName}');" oldName="" style="width:90%;" value="${customerUserMap[user.userFlow].userName }"/></td>
		
		<td><select class="inputText" name="sexId" style="width:90%;">
		           <option></option>
				<c:forEach var="userSex" items="${userSexEnumList}">
				  <c:if test="${userSex.id != userSexEnumUnknown.id}">
					<option value="${userSex.id}" <c:if test="${userSex.id eq customerUserMap[user.userFlow].sexId }">selected="selected"</c:if>>${userSex.name}</option>
				  </c:if>
				</c:forEach>
			</select>
		</td>
		<td><input type="text" class="inputText validate[maxSize[50]]" name="deptName" style="width:90%;" value="${customerUserMap[user.userFlow].deptName }"/></td>
		<td><input type="text" class="inputText validate[maxSize[25]]" name="postName" style="width:90%;" value="${customerUserMap[user.userFlow].postName }"/></td>
		<td><input type="text" class="inputText validate[custom[phone2],maxSize[20]]" name="userTelphone" style="width:90%;" value="${customerUserMap[user.userFlow].userTelphone }"/></td>
		<td><input type="text" class="inputText validate[custom[mobile],maxSize[20]]" name="userCelphone" style="width:90%;" value="${customerUserMap[user.userFlow].userCelphone }"/></td>
		<td><input type="text" class="inputText validate[custom[email],maxSize[50]]" name="userEmail" style="width:90%;" value="${customerUserMap[user.userFlow].userEmail }"/></td>
	    <td><input type="text" class="inputText validate[custom[qq],maxSize[50]]" name="userQq" style="width:90%;" value="${customerUserMap[user.userFlow].userQq }"/></td>
		<td><input type="text" class="inputText validate[maxSize[100]]" name="remark" style="width:90%;" value="${customerUserMap[user.userFlow].remark }"/></td>
	</tr>
	</c:if>
	</c:forEach>
					</tbody>
				</table>
				</form>
				<div class="button" style="width: 100%">
					<input id="saveButton" class="search" type="button" value="保&#12288;存" onclick="save();" />
					<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
				</div>
			
			</div>
		</div>
	</div>
   <table style="display: none;" id="clone">
	<tr>
		<td>
		<input type="checkbox" name="id" value=""/>
		<input type="hidden" name="contractFlow" value="${param.contractFlow }"/>
		<input type="hidden" name="recordFlow"/>
		<input type="hidden" name="userFlow"/>
		<input type="hidden" name="customerFlow" value="${customerFlow }"/>
		</td>
		<td><input type="text" class="inputText validate[required,maxSize[10]]" name="userName" oldName=""
		onchange="checkCustomerUserName(this,'','');" oldName="" style="width:90%;"/></td>
		
		<td><select class="inputText" name="sexId" style="width:90%;">
				<c:forEach var="userSex" items="${userSexEnumList}">
				  <c:if test="${userSex.id != userSexEnumUnknown.id}">
					<option value="${userSex.id}" >${userSex.name}</option>
				  </c:if>
				</c:forEach>
				<option value=""></option>
			</select>
		</td>
		<td><input type="text" class="inputText validate[maxSize[50]]" name="deptName" style="width:90%;"/></td>
		
		<td><input type="text" class="inputText validate[maxSize[25]]" name="postName" style="width:90%;"/></td>
		<td><input type="text" class="inputText validate[custom[phone2],maxSize[20]]" name="userTelphone" style="width:90%;"/></td>
		<td><input type="text" class="inputText validate[custom[mobile],maxSize[20]]" name="userCelphone" style="width:90%;"/></td>
		<td><input type="text" class="inputText validate[custom[email],maxSize[50]]" name="userEmail" style="width:90%;"/></td>
	    <td><input type="text" class="inputText validate[custom[qq],maxSize[50]]" name="userQq" style="width:90%;"/></td>
		<td><input type="text" class="inputText validate[maxSize[100]" name="remark" style="width:90%;"/></td>
	</tr>
</table>
</body>
</html>